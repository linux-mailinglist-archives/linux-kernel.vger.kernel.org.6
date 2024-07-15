Return-Path: <linux-kernel+bounces-252720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A304593174A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 17:01:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DD88B2269D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 15:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAECD18EFCE;
	Mon, 15 Jul 2024 15:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="OQGasQv2"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF79186E5A
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 15:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721055676; cv=none; b=h/zRRuQ2bYG5KXj7j5T6c3QCiOY5uXC0wYqevdqljsYSAJTqXTKEOpIW9DrXZ/o+J/4+b1nZ0QTMkzmKl/zuhbaIqkXwYKHM+ZeGx8RBtPK0ADgjuBR/jmoSkrnGX5thX3K4BVAmrVZXNKc4yTAmhiUETt1LY4dS7Fv3aw0vYG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721055676; c=relaxed/simple;
	bh=PAJw2z/rBfFVTIAYPdyTmcMPTASE55qK5YWq0VRv6Z0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=biQGqmdzaiG/jG9ZL5JVtkE3vJFGPkL+hygt5/pmLAMCSibomb6BhbncT3cePSkvgh7heiJ54CvWvuaulSgs77AECW9/mVp7+SOxl6pcyOOHW783zSNf08jLe1Nx/dTDLIwzaAnqIGsuMayBLyoeOwU3G9DVIPjP3Jp+agIEBik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=fail (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=OQGasQv2 reason="signature verification failed"; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 7FBCE40E021B;
	Mon, 15 Jul 2024 15:01:09 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
	reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id qiuTeiOhTSNK; Mon, 15 Jul 2024 15:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1721055664; bh=NzCEpxhvXrtGwt9mvTVYL1yK9Edo2I3lN8omoaYbn6c=;
	h=Date:From:To:Cc:Subject:From;
	b=OQGasQv2+a+gv2V2jv5BjnxhyU0cl6VinVM4g8Djlq+51esgzYlgl4u3TT7dgZ7uV
	 ECIhNl1ITbpUVMvUj1vUFlPcXoZFY/LHTA8Uaf6mAixGg890SgaHrVBluaunTqABJN
	 TFghDo3TU5BXNo0XnD1zHECR8oVeilHuh2ADvreyGq13c1z7mtGs1kRF82anoL+7Qz
	 NUzKDS5zCcbjzwA8XUkZJwVciPaPv/uMzgoBPOD+GGbXPuR4xcilGNOI6qZNqDVaLa
	 XoQ2nI8kOxCymfql3JjE/9A7GwxHTnUm0V18HLlB72LjuRbWJcLV8n1IhDWwIsBkkH
	 Yumdn6+JB6N1DN5wbW5IdY+L3e1fdorFvr3SSrVvuPBwMZes3ohDVN60UZTsXhhAYS
	 McLofKHD1gHMoTVLjo59Hl3zM3hMYHmm2KM4UIZ3ZE/skbeT9/DtsgpEXl2SxQbJhn
	 96jdUwAl9SnasbzxuZjfCz1HD6bG8escfHtIxktx5pJDxiw7lbJuS16hFJ7vadUCC9
	 9aZnzYpuWgrt1qasi9x/vMISAQnuqR7WQWuNrDEA9TxY2mQdnIK4CcvGHHbtzfA/Fl
	 VJyMHiedShf7QnhAqqL87TaAn/4q9haFqGbf/9W3LC9Yr0qplaOByoi8DKmZd309+x
	 8plACWOEIpRrMzAx4uUTBWes=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 47C1440E0192;
	Mon, 15 Jul 2024 15:01:01 +0000 (UTC)
Date: Mon, 15 Jul 2024 17:00:55 +0200
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/misc for v6.11-rc1
Message-ID: <20240715150055.GAZpU5p9TOAJSyW3gQ@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

please pull the x86/misc lineup for v6.11-rc1.

Thx.

---

The following changes since commit 83a7eefedc9b56fe7bfeff13b6c7356688ffa6=
70:

  Linux 6.10-rc3 (2024-06-09 14:19:43 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/x86_misc_for=
_v6.11_rc1

for you to fetch changes up to bf6ab33d8487f5e2a0998ce75286eae65bb0a6d6:

  x86/kmsan: Fix hook for unaligned accesses (2024-06-25 11:37:21 +0200)

----------------------------------------------------------------
 - Make error checking of AMD SMN accesses more robust in the callers as
   they're the only ones who can interpret the results properly

 - The usual cleanups and fixes, left and right

----------------------------------------------------------------
Brian Johannesmeyer (1):
      x86/kmsan: Fix hook for unaligned accesses

Christian Heusel (1):
      tools/x86/kcpuid: Add missing dir via Makefile

Ilpo J=C3=A4rvinen (4):
      x86/of: Return consistent error type from x86_of_pci_irq_enable()
      x86/pci/intel_mid_pci: Fix PCIBIOS_* return code handling
      x86/pci/xen: Fix PCIBIOS_* return code handling
      x86/platform/iosf_mbi: Convert PCIBIOS_* return codes to errnos

Marcin Juszkiewicz (1):
      x86, arm: Add missing license tag to syscall tables files

Yazen Ghannam (8):
      EDAC/amd64: Remove unused register accesses
      EDAC/amd64: Check return value of amd_smn_read()
      hwmon: (k10temp) Check return value of amd_smn_read()
      x86/amd_nb: Enhance SMN access error checking
      hwmon: (k10temp) Define a helper function to read CCD temperature
      hwmon: (k10temp) Reduce k10temp_get_ccd_support() parameters
      hwmon: (k10temp) Remove unused HAVE_TDIE() macro
      hwmon: (k10temp) Rename _data variable

 arch/arm/tools/syscall.tbl             |  1 +
 arch/x86/entry/syscalls/syscall_32.tbl |  1 +
 arch/x86/entry/syscalls/syscall_64.tbl |  1 +
 arch/x86/include/asm/amd_nb.h          |  4 +-
 arch/x86/kernel/amd_nb.c               | 44 +++++++++++++++++++---
 arch/x86/kernel/devicetree.c           |  2 +-
 arch/x86/lib/iomem.c                   |  5 ++-
 arch/x86/pci/intel_mid_pci.c           |  4 +-
 arch/x86/pci/xen.c                     |  4 +-
 arch/x86/platform/intel/iosf_mbi.c     |  4 +-
 drivers/edac/amd64_edac.c              | 69 +++++++++++++++++++---------=
------
 drivers/edac/amd64_edac.h              |  4 --
 drivers/hwmon/k10temp.c                | 62 +++++++++++++++++++---------=
--
 tools/arch/x86/kcpuid/Makefile         |  4 +-
 14 files changed, 136 insertions(+), 73 deletions(-)


--=20
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

