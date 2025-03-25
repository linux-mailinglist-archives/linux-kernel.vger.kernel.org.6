Return-Path: <linux-kernel+bounces-575735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 224F4A70697
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 17:19:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B40753A9EC6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 16:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09A0625BAA8;
	Tue, 25 Mar 2025 16:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="HD1XM9m/"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8542C25A631
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 16:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742919435; cv=none; b=l9V/KQIuv+zr9HVJbUlkg/M6Q71NFGfBCeLefqgd89J/QMRm0zH5+FeHOAzclWs+XN5GO+4MUsVsD6XLobGzG5AcCiZRnyf9LeWmlHIjcTGDHwAmu7UnJFcH+C4wWDeWe9VmP2VtVKmbKF+76JAfmrvEOP2iKjesvmglRzzHeI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742919435; c=relaxed/simple;
	bh=M736tMda+Xo3V451dLSmP5tUE0yt+PReWmVjVSa8LF4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=SBXzCrFA1o1Yk1AUfLgjz7Y+cEaUtF3WTXh4/HeDL55v7kNtME/DC1waWYyEnlmjpuRLxqsQYDIZmsVGL6WXXYr6f+8IQuPGOfT8uZnlPJx2ND/km1op4E2dcdo7AO/r6kWmkFe+qd2Js44gzSalhjgC8it2OzbtAaW/3NtjvxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=HD1XM9m/; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 4635940E0214;
	Tue, 25 Mar 2025 16:17:10 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ifvA_0Gysur2; Tue, 25 Mar 2025 16:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1742919423; bh=Z3ONUzf5mfUfq03VJB8Ha1NlpPj1E3lbbqhevOTT0AY=;
	h=Date:From:To:Cc:Subject:From;
	b=HD1XM9m/x5bS9lRd25s2Spp/8Nw5dO4c3bVmSFTWOEuXnVP031y97DbwcevFANQxt
	 D/M98JqUGv13qBBVYceKqhDxepBCsJ5mFbuEIO7trq8d7BEvu+Smq8LtoLmyb7Gwlb
	 V2JulOloR+i1EB08788Lb4uGD/epiS4bTtPlgIoCWNu+FNcnsSpgn5haZRiGaNv/ND
	 Mu7CyRXPr/CrY/uC+QBBE8agVuBSeL9g1UPsjL6OfzFuOPF+m47S7kVO1bZvca2vtX
	 hJZBk72G8kb/Tg8kCtzpln8XDD++7xmyrxk1WtBnPQOo4QmyMIafPrIeDZwl9W5Ecs
	 ZF2dMDEnAQ6aRLIS6wDAOlOWs+jKHDLH5BKKXbox6wOV3lfdBdMRgQWWJr40NcJHcD
	 VLw5G4GsFqElg8M78HKCIdhS+w9iZfUQe4p/x9tp+oxWuvEypXMduetlEOrgRNKYqt
	 pjGMwtDy4kaWS1g9WmxqTcngOYjk3VVTSuCp3suKDU7SFgjrzksDWFRCEMGpUDaPyM
	 dlsuKRNbfx1ZOjrr9AAptYF6I4Utf+aWDuhhcMq2g+3qU1q8WuD7riqMIwiQUPXssv
	 hZ3ixyIXwHhJNfz00QDpUdYbS45qfsQbEr3IctLgySwWThfhCVF/7l5hxjxs5FPQFQ
	 L7WrY1RUBmlX533bUgwxzzng=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 271DD40E015D;
	Tue, 25 Mar 2025 16:17:00 +0000 (UTC)
Date: Tue, 25 Mar 2025 17:16:53 +0100
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/bugs for v6.15
Message-ID: <20250325161653.GAZ-LW9WpsQrJgWx16@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

please pull the x86 spec mitigations updates for v6.15.

Thx.

---

The following changes since commit d082ecbc71e9e0bf49883ee4afd435a77a5101b6:

  Linux 6.14-rc4 (2025-02-23 12:32:57 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/x86_bugs_for_v6.15

for you to fetch changes up to 98fdaeb296f51ef08e727a7cc72e5b5c864c4f4d:

  x86/bugs: Make spectre user default depend on MITIGATION_SPECTRE_V2 (2025-03-03 12:48:41 +0100)

----------------------------------------------------------------
- Some preparatory work to convert the mitigations machinery to mitigating
  attack vectors instead of single vulnerabilities

- Untangle and remove a now unneeded X86_FEATURE_USE_IBPB flag

- Add support for a Zen5-specific SRSO mitigation

- Cleanups and minor improvements

----------------------------------------------------------------
Borislav Petkov (1):
      x86/bugs: KVM: Add support for SRSO_MSR_FIX

Breno Leitao (2):
      x86/bugs: Use the cpu_smt_possible() helper instead of open-coded code
      x86/bugs: Make spectre user default depend on MITIGATION_SPECTRE_V2

David Kaplan (3):
      x86/bugs: Add X86_BUG_SPECTRE_V2_USER
      x86/bugs: Relocate mds/taa/mmio/rfds defines
      x86/bugs: Add AUTO mitigations for mds/taa/mmio/rfds

Yosry Ahmed (6):
      x86/bugs: Move the X86_FEATURE_USE_IBPB check into callers
      x86/mm: Remove X86_FEATURE_USE_IBPB checks in cond_mitigation()
      x86/bugs: Remove the X86_FEATURE_USE_IBPB check in ib_prctl_set()
      x86/bugs: Use a static branch to guard IBPB on vCPU switch
      KVM: nVMX: Always use IBPB to properly virtualize IBRS
      x86/bugs: Remove X86_FEATURE_USE_IBPB

 Documentation/admin-guide/hw-vuln/srso.rst      |  13 +++
 Documentation/admin-guide/kernel-parameters.txt |   2 +
 arch/x86/include/asm/cpufeatures.h              |   6 +-
 arch/x86/include/asm/msr-index.h                |   1 +
 arch/x86/include/asm/nospec-branch.h            |   4 +-
 arch/x86/include/asm/processor.h                |   1 +
 arch/x86/kernel/cpu/bugs.c                      | 121 +++++++++++++++---------
 arch/x86/kernel/cpu/common.c                    |   4 +-
 arch/x86/kvm/svm/svm.c                          |   9 +-
 arch/x86/kvm/vmx/vmx.c                          |   3 +-
 arch/x86/lib/msr.c                              |   2 +
 arch/x86/mm/tlb.c                               |   3 +-
 tools/arch/x86/include/asm/cpufeatures.h        |   1 -
 13 files changed, 118 insertions(+), 52 deletions(-)


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

