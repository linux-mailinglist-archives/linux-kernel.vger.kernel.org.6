Return-Path: <linux-kernel+bounces-275766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57945948990
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 08:43:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 895A21C23203
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 06:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F7111BCA00;
	Tue,  6 Aug 2024 06:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mwKgxqCe"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18FEA1BBBE7;
	Tue,  6 Aug 2024 06:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722926586; cv=none; b=croRikPD9zBqr8ILyGjh8rznDTQRp3rPeepEIM4pvl6qMg7Njwr7BKSym9eXT4npKo4wOmW6lKV2UEfh6mAdvtYOx/Jd9Nke95unQt+NyMReWQ9lngnx0wOtDIairfQ31xDswk/nJK0e4JD7JmizSDsl6BsenDCVsSqTdnyg7S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722926586; c=relaxed/simple;
	bh=myjOdjGrg6zzY5ExoZ2SBAYWT96x1eYv1EGHSfIMijk=;
	h=From:To:Cc:Date:Subject:Message-ID:MIME-Version:Content-Type; b=HOh9AzYJwCMEfUjOxUf0kr+DFxGd7V7vYS85pYweGGcKElZ/tMiVcM8zP03cHuOlatTnaWyG2hwbd2PBsE2ZUazySbH6ELHVGeqhKWn+vMdj80VqDs5yS7G+G2SjSl2Je1ybmtNW+UsX9pUNnFNoRdEt5S3Q8B42mctt1NonOo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mwKgxqCe; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722926585; x=1754462585;
  h=from:to:cc:date:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=myjOdjGrg6zzY5ExoZ2SBAYWT96x1eYv1EGHSfIMijk=;
  b=mwKgxqCekAPi4FQmzyM6/jHerdtDxRnHVKo1pOdR7IjSKBo6B6BkXGHK
   OMD9jaivjPi+pAqrGNn3gA1jUyndPNJUp4kmt2lfcIM6AghltJq7dHVC4
   9omHBNWcVThUNDQI5UcXLj202XAz4+/vMbvgq2rz4dQL/ifjiS/rACB2/
   SVVtYknKimPwr1z8lyLbyBh+7Myap9FXawd1Os7xF4+qoM1xr0TnJ8JzH
   F+I1Unh6MTxeFNcSoz/DOHKo/AV33f6FQ2eI+F4VWE1eOT4tbUzkozlT2
   3HQ2RKtHmPBoYhN0zOMfJYLpo2+10fcODwHsCb/YZPiLOKuZTmoSQe67e
   A==;
X-CSE-ConnectionGUID: TD2+g9vVRfS01xlwFnoW+w==
X-CSE-MsgGUID: WOMnENQyS3CHiuRZAf1gcA==
X-IronPort-AV: E=McAfee;i="6700,10204,11155"; a="32076896"
X-IronPort-AV: E=Sophos;i="6.09,267,1716274800"; 
   d="scan'208";a="32076896"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2024 23:43:05 -0700
X-CSE-ConnectionGUID: u7tNPjweQ9WuBAt0LoNSdA==
X-CSE-MsgGUID: IjtcAWT6S/a1OQdLcOjSIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,267,1716274800"; 
   d="scan'208";a="79666022"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.72])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2024 23:43:02 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, PDx86 <platform-driver-x86@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>, Andy Shevchenko <andy@kernel.org>
Date: Tue, 06 Aug 2024 09:40:38 +0300
Subject: [GIT PULL] platform-drivers-x86 for v6.11-2
Message-ID: <pdx86-pr-20240806094038-269710364@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Linus,

Here is a platform-drivers-x86 fixes PR for v6.11.

Fixes:
- intel-vbtn: ACPI notifier racing with itself.
- intel/ifs: Init local variable to cover a timeout corner case.
- WMI docs spelling

New HW Support:
- amd/{pmc,pmf}: AMD 1Ah model 60h series.
- amd/pmf: SPS quirk support for ASUS ROG Ally X

Regards, i.


The following changes since commit 8400291e289ee6b2bf9779ff1c83a291501f017b:

  Linux 6.11-rc1 (2024-07-28 14:19:55 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.11-2

for you to fetch changes up to 3114f77e9453daa292ec0906f313a715c69b5943:

  platform/x86/intel/ifs: Initialize union ifs_status to zero (2024-07-31 12:37:34 +0300)

----------------------------------------------------------------
platform-drivers-x86 for v6.11-2

Fixes:
- intel-vbtn: ACPI notifier racing with itself.
- intel/ifs: Init local variable to cover a timeout corner case.
- WMI docs spelling

New HW Support:
- amd/{pmc,pmf}: AMD 1Ah model 60h series.
- amd/pmf: SPS quirk support for ASUS ROG Ally X

The following is an automated shortlog grouped by driver:

amd/pmc:
 -  Send OS_HINT command for new AMD platform

amd/pmf:
 -  Add new ACPI ID AMDI0107

amd: pmf:
 -  Add quirk for ROG Ally X

intel/ifs:
 -  Initialize union ifs_status to zero

intel-vbtn:
 -  Protect ACPI notify handler against recursion

msi-wmi-platform:
 -  Fix spelling mistakes

----------------------------------------------------------------
Hans de Goede (1):
      platform/x86: intel-vbtn: Protect ACPI notify handler against recursion

Kuppuswamy Sathyanarayanan (1):
      platform/x86/intel/ifs: Initialize union ifs_status to zero

Luis Felipe Hernandez (1):
      platform/x86: msi-wmi-platform: Fix spelling mistakes

Luke D. Jones (1):
      platform/x86/amd: pmf: Add quirk for ROG Ally X

Shyam Sundar S K (2):
      platform/x86/amd/pmc: Send OS_HINT command for new AMD platform
      platform/x86/amd/pmf: Add new ACPI ID AMDI0107

 Documentation/wmi/devices/msi-wmi-platform.rst | 6 +++---
 drivers/platform/x86/amd/pmc/pmc.c             | 2 ++
 drivers/platform/x86/amd/pmc/pmc.h             | 1 +
 drivers/platform/x86/amd/pmf/core.c            | 3 +++
 drivers/platform/x86/amd/pmf/pmf-quirks.c      | 9 ++++++++-
 drivers/platform/x86/intel/ifs/runtest.c       | 2 +-
 drivers/platform/x86/intel/vbtn.c              | 9 +++++++++
 7 files changed, 27 insertions(+), 5 deletions(-)

