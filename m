Return-Path: <linux-kernel+bounces-258190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4020D9384D5
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 15:43:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 011AB28179A
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 13:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13FD01649CC;
	Sun, 21 Jul 2024 13:43:47 +0000 (UTC)
Received: from mailscanner04.zoner.fi (mailscanner04.zoner.fi [5.44.246.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115BA8C0B
	for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2024 13:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.44.246.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721569426; cv=none; b=D735h1Vhju8wvCxJOFk0I99omO0vapAF4Y1MMj/Z7bqYPj+W9fNgqTUzltTILUNJkao+NDOC6dQkRVXS4V+q017CN83XOHrHuWxro2RdEiJxk4aGf76A5dcetnaMkS2Z22d+0Ky1UXJ1iljToiBOHm7wCXCkthgwQhfayrv0kNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721569426; c=relaxed/simple;
	bh=EjW0cP3or2WHRsHl4Ar4xEiRKOeiPNy9nOH77fKmln4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Plylh0Kf95qbO/22D6HikriRGcV6av+jnA4gy8WB6VUi5IWyRpaKd5I+Fp5oFWhenbDsQcZeREvno7/ktVXdIPfmIs8c4jy+uW12H1DtmFmD2xk1AdZEeFlnheegvcD0ERxeJbb99wBo1vAMTuBI3K+m5HnQfqEumn/9Kl4FpZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tukaani.org; spf=pass smtp.mailfrom=tukaani.org; arc=none smtp.client-ip=5.44.246.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tukaani.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tukaani.org
Received: from www25.zoner.fi (www25.zoner.fi [84.34.147.45])
	by mailscanner04.zoner.fi (Postfix) with ESMTPS id B4A24212C6;
	Sun, 21 Jul 2024 16:37:03 +0300 (EEST)
Received: from mail.zoner.fi ([84.34.147.244])
	by www25.zoner.fi with esmtp (Exim 4.97.1)
	(envelope-from <lasse.collin@tukaani.org>)
	id 1sVWkG-00000001SjJ-1G0T;
	Sun, 21 Jul 2024 16:37:03 +0300
From: Lasse Collin <lasse.collin@tukaani.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Lasse Collin <lasse.collin@tukaani.org>,
	Sam James <sam@gentoo.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 00/16] xz: Updates to license, filters, and compression options
Date: Sun, 21 Jul 2024 16:36:15 +0300
Message-ID: <20240721133633.47721-1-lasse.collin@tukaani.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

XZ Embedded, the upstream project, switched from public domain to the
BSD Zero Clause License (0BSD). Now matching SPDX license identifiers
can be added.

Documentation was revised. Fix syntax errors in kernel-doc comments in
<linux/xz.h>. The xz_dec API docs from <linux/xz.h> are now included in
Documentation/staging/xz.rst.

The new ARM64 and RISC-V filters can be used for kernel decompression
if CONFIG_EFI_ZBOOT=y. The filters can be used by Squashfs too.
(Userspace Squashfs-tools already had the ARM64 filter support committed
but it was reverted due to backdoor fears. I try to get ARM64 and RISC-V
filter support added to Squashfs-tools somewhat soon.)

Account for the default threading change made in the xz command line
tool version 5.6.0. Tweak kernel compression options for archs that
support XZ compressed kernel.

v2:
  - Omit Jia Tan from MAINTAINERS and commit messages.
  - Don't change home page URLs as the home pages were moved back
    to their old locations.
  - Add xz_dec (<linux/xz.h>) kernel-doc fixes and improvements.
  - arm64: Add the make target Image.xz for CONFIG_EFI_ZBOOT=n.
  - riscv: Add the make target Image.xz and set HAVE_KERNEL_XZ
    in Kconfig like it is done with other compressors for
    CONFIG_EFI_ZBOOT=n.

Lasse Collin (16):
  MAINTAINERS: Add XZ Embedded maintainer
  LICENSES: Add 0BSD license text
  xz: Switch from public domain to BSD Zero Clause License (0BSD)
  xz: Fix comments and coding style
  xz: Fix kernel-doc formatting errors in xz.h
  xz: Improve the MicroLZMA kernel-doc in xz.h
  xz: Documentation/staging/xz.rst: Revise thoroughly
  docs: Add XZ_EXTERN to c_id_attributes
  xz: Cleanup CRC32 edits from 2018
  xz: Optimize for-loop conditions in the BCJ decoders
  xz: Add ARM64 BCJ filter
  xz: Add RISC-V BCJ filter
  xz: Use 128 MiB dictionary and force single-threaded mode
  xz: Adjust arch-specific options for better kernel compression
  arm64: boot: add Image.xz support
  riscv: boot: add Image.xz support

 Documentation/conf.py           |   3 +
 Documentation/staging/xz.rst    | 160 ++++++++++++----------------
 LICENSES/deprecated/0BSD        |  23 ++++
 MAINTAINERS                     |  13 +++
 arch/arm64/boot/Makefile        |   5 +-
 arch/riscv/Kconfig              |   1 +
 arch/riscv/Makefile             |   6 +-
 arch/riscv/boot/Makefile        |   3 +
 include/linux/decompress/unxz.h |   5 +-
 include/linux/xz.h              |  48 ++++-----
 init/Kconfig                    |   5 +-
 lib/decompress_unxz.c           |  39 ++++---
 lib/xz/Kconfig                  |  13 ++-
 lib/xz/xz_crc32.c               |   7 +-
 lib/xz/xz_dec_bcj.c             | 182 ++++++++++++++++++++++++++++++--
 lib/xz/xz_dec_lzma2.c           |   5 +-
 lib/xz/xz_dec_stream.c          |   5 +-
 lib/xz/xz_dec_syms.c            |  14 +--
 lib/xz/xz_dec_test.c            |  12 +--
 lib/xz/xz_lzma2.h               |   5 +-
 lib/xz/xz_private.h             |  20 ++--
 lib/xz/xz_stream.h              |   5 +-
 scripts/Makefile.lib            |  13 ++-
 scripts/xz_wrap.sh              | 158 +++++++++++++++++++++++++--
 24 files changed, 542 insertions(+), 208 deletions(-)
 create mode 100644 LICENSES/deprecated/0BSD

-- 
2.45.2


