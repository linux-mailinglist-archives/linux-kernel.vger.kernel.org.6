Return-Path: <linux-kernel+bounces-564565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B327A65770
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 17:09:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33DAB188DFDB
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 16:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 289F418A6DB;
	Mon, 17 Mar 2025 16:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bob/JDTn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73CEB17A314
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 16:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742227476; cv=none; b=JyRrqyCIXgzdh2Vu12Az9fsYHNM7yvTlGqcUS16rze29d2rR0j1V8Ip3lhtn7kln1XZCsl9r1HQwSfx3tHbg2XeGt2mVrxhYwxhix8MJ+nBrOOAummS8ZA3JqvtI8vI1vZIz1gtS++VWfSQZ3M1ZGpdCpdXX2yET2bVfwNMuPC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742227476; c=relaxed/simple;
	bh=nwC90Z/7coWbV8KyYl0EY1kHWOzFR41vr9/VYmzvxhc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=pmd0R8tj3Gx6m6nPJ++QDDVbBYyT8u8Mf4fD6+i6bzeYZghLpkZ2+DXXb0ovv9kz6BmNlCAgvZSdsQGKZEkxxFyHppzRqQtv1Iz5TkJesC7f3s8Q9SVBFrcMRLrix5LgnpSbBDfwhC31GUZl6wWy1uYSewjcKpaMDnaiPAIp67c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bob/JDTn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D197AC4CEE3;
	Mon, 17 Mar 2025 16:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742227475;
	bh=nwC90Z/7coWbV8KyYl0EY1kHWOzFR41vr9/VYmzvxhc=;
	h=Date:From:To:Cc:Subject:From;
	b=bob/JDTnlhCjlL3j3LBmj//pcQHHjGkT5QicMb+W9k0xCBH759xMqboqna8Ctza76
	 ssD2P1qtGtqtYPN3WXn2nQmwp+Hta8PkGnQ01+BmIqI11nr6Z3QO//bMjt2V8P2WUI
	 R0wjfMbrp+XIZq+g9fOvco7jB/rggqBIkPw3xO+LMD3CpESo1FIkJtcgKjqhvZ/UFi
	 Uo79rSs1IplHfrjupwdyt4+UUDMZ1jNC+RTWnd+w0TTtC5eZtJlygag3Jb9BgGMyqP
	 gJRgFz08xvnVqobyDmhAnCp1BVckac7j168YvqBb5kA8+aU8RAPaXWZ+DnotcX7UmC
	 nPI9L3J32awCA==
Date: Mon, 17 Mar 2025 09:04:32 -0700
From: Kees Cook <kees@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Arulpandiyan Vadivel <arulpandiyan.vadivel@siemens.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Gow <davidgow@google.com>, Ingo Molnar <mingo@kernel.org>,
	Justin Stitt <justinstitt@google.com>, Kees Cook <kees@kernel.org>,
	kernel test robot <lkp@intel.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Mel Gorman <mgorman@techsingularity.net>,
	Michael Kelley <mhklinux@outlook.com>,
	=?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	Miguel Ojeda <ojeda@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>, Paul Moore <paul@paul-moore.com>,
	R Sundar <prosunofficial@gmail.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>
Subject: [GIT PULL] hardening updates for v6.15-rc1
Message-ID: <202503170859.6188E2CEBE@keescook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi Linus,

Please pull these hardening updates for v6.15-rc1. As usual, it's
scattered changes all over. Patches touching things outside of our
traditional areas in the tree have been Acked by maintainers or were
trivial changes.

Thanks!

-Kees

The following changes since commit a64dcfb451e254085a7daee5fe51bf22959d52d3:

  Linux 6.14-rc2 (2025-02-09 12:45:03 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/hardening-v6.15-rc1

for you to fetch changes up to b688f369ae0d5d25865f5441fa62e54c7d5d0de6:

  compiler_types: Introduce __nonstring_array (2025-03-12 13:21:09 -0700)

----------------------------------------------------------------
hardening updates for v6.15-rc1

- loadpin: remove unsupported MODULE_COMPRESS_NONE (Arulpandiyan Vadivel)

- samples/check-exec: Fix script name (Mickaël Salaün)

- yama: remove needless locking in yama_task_prctl() (Oleg Nesterov)

- lib/string_choices: Sort by function name (R Sundar)

- hardening: Allow default HARDENED_USERCOPY to be set at compile time
  (Mel Gorman)

- uaccess: Split out compile-time checks into ucopysize.h

- kbuild: clang: Support building UM with SUBARCH=i386

- x86: Enable i386 FORTIFY_SOURCE on Clang 16+

- ubsan/overflow: Rework integer overflow sanitizer option

- Add missing __nonstring annotations for callers of memtostr*()/strtomem*()

- Add __must_be_noncstr() and have memtostr*()/strtomem*() check for it

- Introduce __nonstring_array for silencing future GCC 15 warnings

----------------------------------------------------------------
Arulpandiyan Vadivel (1):
      loadpin: remove MODULE_COMPRESS_NONE as it is no longer supported

Kees Cook (18):
      uaccess: Introduce ucopysize.h
      scsi: mptfusion: Mark device strings as nonstring
      scsi: mpi3mr: Mark device strings as nonstring
      scsi: mpt3sas: Mark device strings as nonstring
      scsi: qla2xxx: Mark device strings as nonstring
      string: kunit: Mark nonstring test strings as __nonstring
      x86/tdx: Mark message.bytes as nonstring
      uapi: stddef.h: Introduce __kernel_nonstring
      nilfs2: Mark on-disk strings as nonstring
      compiler.h: Introduce __must_be_noncstr()
      string.h: Validate memtostr*()/strtomem*() arguments more carefully
      kbuild: clang: Support building UM with SUBARCH=i386
      ubsan/overflow: Rework integer overflow sanitizer option to turn on everything
      ubsan/overflow: Enable pattern exclusions
      ubsan/overflow: Enable ignorelist parsing and add type filter
      x86/build: Remove -ffreestanding on i386 with GCC
      hardening: Enable i386 FORTIFY_SOURCE on Clang 16+
      compiler_types: Introduce __nonstring_array

Mel Gorman (4):
      mm: security: Move hardened usercopy under 'Kernel hardening options'
      mm: security: Allow default HARDENED_USERCOPY to be set at compile time
      mm: security: Check early if HARDENED_USERCOPY is enabled
      fortify: Move FORTIFY_SOURCE under 'Kernel hardening options'

Mickaël Salaün (1):
      samples/check-exec: Fix script name

Oleg Nesterov (1):
      yama: don't abuse rcu_read_lock/get_task_struct in yama_task_prctl()

R Sundar (1):
      lib/string_choices: Rearrange functions in sorted order

 Documentation/admin-guide/kernel-parameters.txt    |  4 +-
 MAINTAINERS                                        |  1 +
 arch/x86/Makefile                                  |  4 +-
 arch/x86/coco/tdx/tdx.c                            |  4 +-
 drivers/message/fusion/mptsas.c                    |  8 +--
 drivers/scsi/mpi3mr/mpi3mr_transport.c             |  8 +--
 drivers/scsi/mpt3sas/mpi/mpi2_cnfg.h               |  2 +-
 drivers/scsi/mpt3sas/mpt3sas_transport.c           |  8 +--
 drivers/scsi/qla2xxx/qla_mr.h                      |  4 +-
 include/linux/compiler.h                           | 18 ++++++-
 include/linux/compiler_types.h                     | 23 ++++++--
 include/linux/string.h                             | 16 ++++--
 include/linux/string_choices.h                     | 24 ++++-----
 include/linux/thread_info.h                        | 48 -----------------
 include/linux/uaccess.h                            |  2 +-
 include/linux/ucopysize.h                          | 63 ++++++++++++++++++++++
 include/linux/uio.h                                |  2 +-
 include/uapi/linux/nilfs2_ondisk.h                 |  3 +-
 include/uapi/linux/stddef.h                        |  6 +++
 init/Kconfig                                       |  3 ++
 kernel/configs/hardening.config                    |  2 +-
 lib/Kconfig.ubsan                                  | 25 ++++-----
 lib/string_kunit.c                                 |  4 +-
 lib/test_ubsan.c                                   | 18 +++++--
 lib/ubsan.c                                        | 28 +++++++++-
 lib/ubsan.h                                        |  8 +++
 mm/usercopy.c                                      | 18 ++++---
 .../{run-script-ask.inc => run-script-ask.sh}      |  0
 scripts/Makefile.clang                             |  2 +
 scripts/Makefile.lib                               |  4 +-
 scripts/Makefile.ubsan                             | 10 +++-
 scripts/integer-wrap-ignore.scl                    |  3 ++
 security/Kconfig                                   | 21 --------
 security/Kconfig.hardening                         | 33 ++++++++++++
 security/loadpin/Kconfig                           |  2 +-
 security/yama/yama_lsm.c                           |  9 +---
 36 files changed, 285 insertions(+), 153 deletions(-)
 create mode 100644 include/linux/ucopysize.h
 rename samples/check-exec/{run-script-ask.inc => run-script-ask.sh} (100%)
 create mode 100644 scripts/integer-wrap-ignore.scl

-- 
Kees Cook

