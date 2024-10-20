Return-Path: <linux-kernel+bounces-373208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C378B9A53CB
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 13:34:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76C361F22762
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 11:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FA5A18A926;
	Sun, 20 Oct 2024 11:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="CPFBpgR5"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC07E2BB13
	for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 11:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729424048; cv=none; b=B25GH1U9HyvBgrkUsJW5HHJM/uaiPFSobNdVntRIie13hDsjGjn840IwabujJ4HVejRr+Cdt49RaF82wVx2PRG3ASU5lpYPV4kq5Dvn//Kyn++WroYo2dySrs6Gi2YmsVfX/s9CQIBOj/QJPpyk1m3ROX7Ds5Jq7j8rywQheduY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729424048; c=relaxed/simple;
	bh=lBS+w7FByHVxwZLQDR5de1nXq8xbc7XPN9t5BiR70F4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=pTjecqSvcXxfonhR/ouYJnp+MACW2v/53qJ8EwoaOC0dK9yTP+H11f0gvxmd0f075YyfKypd2VABFAJMWR7Ompl6y59HjtWW7FTx8bnl6Z72BwMCyBsBQS66pteVxAggI/oVigUPu0GwIWsTwPApXoQZ0K/nRy88goCF3LJkPWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=CPFBpgR5; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id A27B240E0198;
	Sun, 20 Oct 2024 11:34:04 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 1zGaBIggSz8a; Sun, 20 Oct 2024 11:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1729424040; bh=o/knoaXsWyU210xehQkP/dUhOg2TsC2vcYt1xT+v3BI=;
	h=Date:From:To:Cc:Subject:From;
	b=CPFBpgR5fL//0pu6AS1tOgQbshjuXlOgvyaHPswJUmR3TEXKExFGZ+21dttBALjsD
	 icp5tAuwSTwUP3Dnl2iwwH1P/Oykbs0J11OkVBbBSV+SS+Lnfb3uqxj38EBHsml3Fn
	 r54yKV3bwDz4a3Lx4C+dBSTB+m7yDVt1ijKxNkmPNKTtCwhV1hASelF9qxLBwbFQXJ
	 F8T6eGYzTrBpj1islbfKnLpHYdSSSfEuwXKIB4MTTVFS0/dlFpDD6DbXSD5DxZmuuY
	 FvpZ0FvOQHLque5Pa06wwzw0kl1K/JWZRN844dCNkSKiQpirzwCMjoBNt+ffTMBPUC
	 qLU90sxwCdjHYZyNNnWCYFZwW/2zqlxVM/t4LKawwDx6wdfSI9Wbvv9xkx5/ERZpXB
	 SxJMBy6Fy2BsZllxpnnbXtOGHckjXY6cW1wXVARVS+2neWiCBpg9Q+CY6UL13BJtsP
	 DoszvuQrZ2iYgJw9dw+9sMvaFAw9FF0vOY5LEh9pW82be/9zaD1m0yIoih1aA/2zRz
	 yk39rwZjvKdSxWEEqtljXgN46OiMeGHk2g3zfSO2qwanBPvmbUldQLR14IIjSR3phq
	 L3yTKXBy8EjDF7f/oRHDSFrfGIwGMqhFo8c5ZAyHCAp23qcNFox/S3XL1sudKSmRcW
	 BDBeNrH8bKITz2TiB6IH3oyw=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 40FFC40E0169;
	Sun, 20 Oct 2024 11:33:57 +0000 (UTC)
Date: Sun, 20 Oct 2024 13:33:51 +0200
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/urgent for v6.12-rc4
Message-ID: <20241020113351.GAZxTqnz0SOdrMUAA8@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

please pull the x86/urgent lineup for v6.12-rc4.

Thx.

---

The following changes since commit 8cf0b93919e13d1e8d4466eb4080a4c4d9d66d7b:

  Linux 6.12-rc2 (2024-10-06 15:32:27 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/x86_urgent_for_v6.12_rc4

for you to fetch changes up to ffd95846c6ec6cf1f93da411ea10d504036cab42:

  x86/apic: Always explicitly disarm TSC-deadline timer (2024-10-15 05:45:18 -0700)

----------------------------------------------------------------
- Explicitly disable the TSC deadline timer when going idle to address
  some CPU errata in that area

- Do not apply the Zenbleed fix on anything else except AMD Zen2 on the
  late microcode loading path

- Clear CPU buffers later in the NMI exit path on 32-bit to avoid
  register clearing while they still contain sensitive data, for the
  RDFS mitigation

- Do not clobber EFLAGS.ZF with VERW on the opportunistic SYSRET exit
  path on 32-bit

- Fix parsing issues of memory bandwidth specification in sysfs for
  resctrl's memory bandwidth allocation feature

- Other small cleanups and improvements

----------------------------------------------------------------
John Allen (1):
      x86/CPU/AMD: Only apply Zenbleed fix for Zen2 during late microcode load

Martin Kletzander (1):
      x86/resctrl: Avoid overflow in MB settings in bw_validate()

Nathan Chancellor (1):
      x86/resctrl: Annotate get_mem_config() functions as __init

Pawan Gupta (3):
      x86/entry_32: Do not clobber user EFLAGS.ZF
      x86/entry_32: Clear CPU buffers after register restore in NMI return
      x86/bugs: Use code segment selector for VERW operand

Richard Gong (1):
      x86/amd_nb: Add new PCI ID for AMD family 1Ah model 20h

Zhang Rui (1):
      x86/apic: Always explicitly disarm TSC-deadline timer

 arch/x86/entry/entry_32.S                 |  6 ++++--
 arch/x86/include/asm/nospec-branch.h      | 11 ++++++++++-
 arch/x86/kernel/amd_nb.c                  |  2 ++
 arch/x86/kernel/apic/apic.c               | 14 +++++++++++++-
 arch/x86/kernel/cpu/amd.c                 |  3 ++-
 arch/x86/kernel/cpu/resctrl/core.c        |  4 ++--
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 23 ++++++++++++++---------
 7 files changed, 47 insertions(+), 16 deletions(-)


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

