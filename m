Return-Path: <linux-kernel+bounces-261485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66C5893B7E7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 22:16:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11BC11F24F43
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 20:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0927C16CD12;
	Wed, 24 Jul 2024 20:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mOqSK6KP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486AA54670;
	Wed, 24 Jul 2024 20:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721852167; cv=none; b=crmTsk2JpVfPxkNA06j/7VmmnubAEv0/+dXqaZ1iDRlYPI1wA8j0r9j2TzSfD5xOawc2eBYj6P2CaAm5s6mjPNZp7ClZ10CuV1JJl10iakaEPkQ0eOElAG6f6KTER+e/T+EN9jChUyWgkM2LbpcF/gtfeQNXftky28k6roG7gG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721852167; c=relaxed/simple;
	bh=RfzeQLRGwp1Dy3ahdSkCQ55LBG/hJgWJitLsjJT8nsI=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=FjSuc7vDmAruq3VeRLmBRVmKGhY7uV61MfLL0O6o5wPOg5cgGVSEQ8kivUK8fj9F51DBxGgfMikSPSz47OwFwLGLjf2IKorKwcf5LZWF4ootYenjQp68pxknOlH/h40IVDsRE7DKpaHgyCV8vQKWj79zqih+SfvrGQRPwp4A3Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mOqSK6KP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58C6AC32786;
	Wed, 24 Jul 2024 20:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721852166;
	bh=RfzeQLRGwp1Dy3ahdSkCQ55LBG/hJgWJitLsjJT8nsI=;
	h=Date:From:To:Subject:From;
	b=mOqSK6KPsywqSHcNHSzkWHghUqbNzTBWaWn3bvG2zJpNZqvrdipGBcr0srfbsf/MJ
	 AaZKltg9eUpGTJ3fujN14r9V6O6Ajm1ofNkOaSs83BG/qLU2IEyMGSwVucxOEt/xTH
	 fxiZLu2uEp8aLy/S4fiU6S3/6F3tEvEwbJ6Tu4LGc2e2Q9nh3sKefnJ4ksAHbUuxSg
	 jxAi3XXZ1HJ3ShkzsVINMIxnzprGJp8HXjW43b00teIxewD1B352mal3Bn/MwS6FpU
	 nJMUb275rawvaXC64PqoL3b8Iqjh3kBnPggOw6yZvRmYhvsZRDjwaU+fmQ0W/VVVBr
	 DX+1JgnD3Hx7Q==
Date: Wed, 24 Jul 2024 22:16:02 +0200
From: Helge Deller <deller@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	John David Anglin <dave.anglin@bell.net>
Subject: [GIT PULL] parisc architecture fixes for v6.11-rc1
Message-ID: <ZqFhAi7HqWJxwhFD@p100>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Please pull some updates for the parisc architecture for 6.11-rc1.

The gettimeofday() and clock_gettime() syscalls are now available as
vDSO functions, and Dave added a patch which allows to use NVMe
cards in the PCI slots as fast and easy alternative to SCSI discs.

Thanks!
Helge

----------------------------------------------------------------
The following changes since commit 6ba59ff4227927d3a8530fc2973b80e94b54d58f:

  Linux 6.10-rc4 (2024-06-16 13:40:16 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/parisc-for-6.11-rc1

for you to fetch changes up to cbade823342cd013f1fbd46f6e3b74825fecbc16:

  parisc: Add support for CONFIG_SYSCTL_ARCH_UNALIGN_NO_WARN (2024-07-24 02:04:05 +0200)

----------------------------------------------------------------
parisc architecture fixes and updates for kernel v6.11-rc1:

- Add gettimeofday() and clock_gettime() vDSO functions
- Enable PCI_MSI_ARCH_FALLBACKS to allow PCI to PCIe bridge adaptor
  with PCIe NVME card to function in parisc machines
- Allow users to reduce kernel unaligned runtime warnings
- minor code cleanups

----------------------------------------------------------------
Helge Deller (4):
      parisc: Clean up unistd.h file
      parisc: Add 32-bit gettimeofday() and clock_gettime() vDSO functions
      parisc: Add 64-bit gettimeofday() and clock_gettime() vDSO functions
      parisc: Add support for CONFIG_SYSCTL_ARCH_UNALIGN_NO_WARN

John David Anglin (1):
      parisc: Fix warning at drivers/pci/msi/msi.h:121

Thorsten Blum (1):
      parisc: Use max() to calculate parisc_tlb_flush_threshold

 Documentation/admin-guide/sysctl/kernel.rst |  2 +-
 arch/parisc/Kconfig                         |  2 ++
 arch/parisc/include/asm/unistd.h            | 54 ++++++++---------------------
 arch/parisc/include/asm/vdso.h              |  2 +-
 arch/parisc/kernel/cache.c                  |  6 +---
 arch/parisc/kernel/unaligned.c              |  2 ++
 arch/parisc/kernel/vdso32/Makefile          | 24 +++++++++++--
 arch/parisc/kernel/vdso32/vdso32.lds.S      |  3 ++
 arch/parisc/kernel/vdso32/vdso32_generic.c  | 32 +++++++++++++++++
 arch/parisc/kernel/vdso64/Makefile          | 25 ++++++++++---
 arch/parisc/kernel/vdso64/vdso64.lds.S      |  2 ++
 arch/parisc/kernel/vdso64/vdso64_generic.c  | 24 +++++++++++++
 12 files changed, 125 insertions(+), 53 deletions(-)
 create mode 100644 arch/parisc/kernel/vdso32/vdso32_generic.c
 create mode 100644 arch/parisc/kernel/vdso64/vdso64_generic.c

