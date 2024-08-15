Return-Path: <linux-kernel+bounces-287922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30F38952E43
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 14:30:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC1D71F2681A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 12:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F12691993AC;
	Thu, 15 Aug 2024 12:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SCVrPGie"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210C017C9AA
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 12:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723724981; cv=none; b=Dt53HBn1+0OEyEx2Nz6xJCymUWXPoYwM9x8aDnCk0ZOBHx4eEVEkwFPFxDhr/feHKeYfl1HmManhNpDePhizKU1UEAWui3KZxajiCSYqJfVBO/9Jn+X8BrPH8HGliexVQNGQw+G/wX6gFvRlN2lmCmGl+DQOildJNMZF5iGRiKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723724981; c=relaxed/simple;
	bh=NkiVEOpddfuXRWwjjKQ2g+L7HBTHV9/YbUBL5zvT4gY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TbnpPKTxhVDi2z+C8Tlcjtm5VUBmf1p2MDgFtF9evbFM++oTbN7qCMYodewiyicCk7TgWPAooP4JYSaSGaSdPphm3VHrEQv/kG4X8OSZcz1zcrc0zwqap8zAxf84YAQPGCEyPckp8KCpH3rSScwfrTnsCbzocsNVJbaTLGhFneI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SCVrPGie; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723724979; x=1755260979;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=NkiVEOpddfuXRWwjjKQ2g+L7HBTHV9/YbUBL5zvT4gY=;
  b=SCVrPGiehOt47mNCu08SCaUJjxbLIl9ejhWxukC2FnAG6Vbeps/y9U4/
   yuiTPu5uMiP7tv3kGZLWLausonNa/JvtnmMEx3WfEx/55B6Rkt6Yf+NXe
   MQJKk/pFBnsJKBUdQLe5UAtV1SZmEzQq+Dz9tbgETYG1QyfqdFjYSeevi
   X/qECn/bXmtHF+5Ght1Cxbjw1c7g/z7AsiP1GDtedq+r43aPsHcLaTxwV
   R+qWDwpgl0BhPex0LkgL1UrRGJPFw0hlBJudxhQGymI/EgVadKpFFJR1J
   O5o2FARzxhqOJEDL6mt7JvOMVP0NSVMs0dqEeTZ/I0UnjlrKslrtbqtoj
   Q==;
X-CSE-ConnectionGUID: 88QemGsKTC27qF280A85kg==
X-CSE-MsgGUID: AtY+/1j9SWuPpT2OacyJHg==
X-IronPort-AV: E=McAfee;i="6700,10204,11165"; a="22112216"
X-IronPort-AV: E=Sophos;i="6.10,148,1719903600"; 
   d="scan'208";a="22112216"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2024 05:29:38 -0700
X-CSE-ConnectionGUID: TgQCFRqoR6OiTtvSfU3vqA==
X-CSE-MsgGUID: LwHbPxXRRGqaPNjFzfd2ng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,148,1719903600"; 
   d="scan'208";a="59489428"
Received: from unknown (HELO khuang2-desk.gar.corp.intel.com) ([10.124.223.78])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2024 05:29:35 -0700
From: Kai Huang <kai.huang@intel.com>
To: dave.hansen@intel.com,
	kirill.shutemov@linux.intel.com,
	bp@alien8.de,
	tglx@linutronix.de,
	peterz@infradead.org,
	mingo@redhat.com
Cc: x86@kernel.org,
	hpa@zytor.com,
	luto@kernel.org,
	linux-kernel@vger.kernel.org,
	thomas.lendacky@amd.com,
	pbonzini@redhat.com,
	seanjc@google.com
Subject: [PATCH v5 0/5] TDX host: kexec() support
Date: Fri, 16 Aug 2024 00:29:16 +1200
Message-ID: <cover.1723723470.git.kai.huang@intel.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently kexec() support and TDX host are muturally exclusive in the
Kconfig.  This series adds the TDX host kexec support so that they can
work together and can be enabled at the same time in the Kconfig.

Hi maintainers,

This series aims to go through the tip tree, but I also CC'ed Sean/Paolo
due to when KVM TDX comes to play a KVM patch [*] is needed to complete
the kexec support for TDX.  Also copy Dan for TDX connect.

Thanks for your time!

=== More information ===

If the kernel has ever enabled TDX, part of system memory remains TDX
private memory when kexec happens.  E.g., the PAMT (Physical Address
Metadata Table) pages used by the TDX module to track each TDX memory
page's state are never freed once the TDX module is initialized.  TDX
guests also have guest private memory and secure-EPT pages.

Similar to AMD SME, to support kexec the kernel needs to flush dirty
cachelines for TDX private memory before booting to the second kernel.
Also, the kernel needs to reset TDX private memory to normal (using
MOVDIR64B) before booting to the second kernel when the platform has
"partial write machine check" erratum, otherwise the second kernel may
see unexpected machine check.

The majority code change in this series handles "resetting TDX private
memory" (flushing cache part is relatively straightforward).  Due to
currently the kernel doesn't have a unified way to tell whether a given
page is TDX private or not, this series chooses to only reset PAMT in
the core-kernel kexec code, but requires the in-kernel TDX users (e.g.,
KVM to reset the TDX private pages that they manage (see [*]).

Other options are also mentioned in the changelog of patch:

  x86/kexec: Reset TDX private memory on platforms with TDX erratum

..which also contains more information about the above TDX erratum.

This series also covers crash kexec, but no special handling is needed
for crash kexec:

1) kdump kernel uses reserved memory from the first kernel, but the
   reserved memory will never be used as TDX memory.
2) /proc/vmcore in the kdump kernel will only be used for read, but read
   itself won't poison TDX private memory thus won't cause unexpected
   machine check (only "partial write" will).


v4 -> v5:
 - Rebase to tip/master.
 - Remove the TDX-specific callback due to no need to reset TDX private
   memory for crash kexec.
 - Add a new patch to make module status immutable in reboot notifier
   (split from v1) in order to use module status to tell the presence of
   TDX private memory.
 - Minor changelog updates, trivial comments improvements.
 - Add Tom's Reviewed-by tag.

 v4: https://lore.kernel.org/all/cover.1713439632.git.kai.huang@intel.com/

v3 -> v4:
 - Updated changelog and comments of patch 1/2 per comments from
   Kirill and Tom (see specific patch for details).

 v3: https://lore.kernel.org/linux-kernel/cover.1712493366.git.kai.huang@intel.com/

v2 -> v3:
 - Change to only do WBINVD for bare-metal, as Kirill/Tom pointed out
   WBINVD in TDX guests and SEV-ES/SEV-SNP guests triggers #VE.

 v2: https://lore.kernel.org/linux-kernel/cover.1710811610.git.kai.huang@intel.com/

v1 -> v2:
 - Do unconditional WBINVD during kexec() -- Boris
 - Change to cover crash kexec() -- Rick
 - Add a new patch (last one) to add a mechanism to reset all TDX private
   pages due to having to cover crash kexec().
 - Other code improvements  -- Dave
 - Rebase to latest tip/master.

 v1: https://lore.kernel.org/linux-kernel/cover.1706698706.git.kai.huang@intel.com/

[*]: https://github.com/intel/tdx/commit/513e24d7913457ba87b6f25644d02fbed0848f21


Kai Huang (5):
  x86/kexec: do unconditional WBINVD for bare-metal in stop_this_cpu()
  x86/kexec: do unconditional WBINVD for bare-metal in relocate_kernel()
  x86/virt/tdx: Make module initializatiton state immutable in reboot
    notifier
  x86/kexec: Reset TDX private memory on platforms with TDX erratum
  x86/virt/tdx: Remove the !KEXEC_CORE dependency

 arch/x86/Kconfig                     |  1 -
 arch/x86/include/asm/kexec.h         |  2 +-
 arch/x86/include/asm/tdx.h           |  2 +
 arch/x86/kernel/machine_kexec_64.c   | 29 +++++++++--
 arch/x86/kernel/process.c            | 19 ++++---
 arch/x86/kernel/relocate_kernel_64.S | 19 +++++--
 arch/x86/virt/vmx/tdx/tdx.c          | 78 ++++++++++++++++++++++++++++
 7 files changed, 129 insertions(+), 21 deletions(-)


base-commit: b8c7cbc324dc17b9e42379b42603613580bec2d8
-- 
2.45.2


