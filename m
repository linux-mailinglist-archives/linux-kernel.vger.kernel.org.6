Return-Path: <linux-kernel+bounces-316671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D41E96D296
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 10:57:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C4712875F0
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 08:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1500195385;
	Thu,  5 Sep 2024 08:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cwcOW5P0"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A851527B4;
	Thu,  5 Sep 2024 08:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725526652; cv=none; b=AZkxPNHqSb/kA0rOOVyKupfGc3t/XlNON7XebxT7UOO7hOJEq+kRdYP93vkEuOXWw0b4Q8XIEbH/DInfOU6SYyeVRf029D5RRYP/K+i+HZLi8XG4a92RepM9kedLg9e+qys0NQh0tsvd+VRK2VLLkm47CDNBM4e4zEFSpvxbEAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725526652; c=relaxed/simple;
	bh=UEHdkm2rOloAObBhegt9Nfe9rdWRP46+0hCeL6V+ezM=;
	h=From:To:Cc:Date:Subject:Message-ID:MIME-Version:Content-Type; b=KH0HaniHb4kq0If0Zi7QMRrCORXsVHLneUdLqhdpgXqRFzzDuVZZxHa/sRkDUgFQ3Ru0urRDqmQjjtaAebbMIETSLMxlCriNB/sb1itJ1guzTkvW+StjM+cwiwBJXSxlFnlaQwOsIqlzs40znajs2+ltNDe7ArubUVE2Tdk75mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cwcOW5P0; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725526651; x=1757062651;
  h=from:to:cc:date:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=UEHdkm2rOloAObBhegt9Nfe9rdWRP46+0hCeL6V+ezM=;
  b=cwcOW5P0WTL5X5VKO6YkFh8ZDZszaI9Yh5odB614RaYhjc77jOk7H2iE
   RhkSBZYSwox2Gfzo1R0bdm0dFcnkxhVtbwdoDuQOqBiNcNkbBY1h7elP3
   Sa5CH1xJo9cEA0nwROJ729zr17clXKLC7Qu9pT55kwbqbV4ntyU30PTBq
   XBvFe/IsnqbYDZIoIXWcI9i638Uegv8dwnW3fFJAn1jjbv3+MKhPPzYz1
   btHvwITZaI1GE67DRzLfSWrkOwf85I54CYIAeAIxfGwA+rt3AaiDmxP4O
   1waR5uS3BdU47b+gv2eZmRHiSQJw1ftV8f4ixb+JzMYz/P/QainPV4ODj
   Q==;
X-CSE-ConnectionGUID: vaUXg8k9TByvtz/JwG9Zng==
X-CSE-MsgGUID: FlcfythPSmqCBVEw3rcpAg==
X-IronPort-AV: E=McAfee;i="6700,10204,11185"; a="24390652"
X-IronPort-AV: E=Sophos;i="6.10,204,1719903600"; 
   d="scan'208";a="24390652"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 01:57:30 -0700
X-CSE-ConnectionGUID: 4wITaAjwTPKO24GS/VyQuA==
X-CSE-MsgGUID: 2VE7RL41T+iDkJAo5TMeDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,204,1719903600"; 
   d="scan'208";a="65799204"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.31])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 01:57:28 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, PDx86 <platform-driver-x86@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>, Andy Shevchenko <andy@kernel.org>
Date: Thu, 05 Sep 2024 11:56:03 +0300
Subject: [GIT PULL] platform-drivers-x86 for v6.11-6
Message-ID: <pdx86-pr-20240905115603-931030098@linux.intel.com>
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

Changes:
- amd/pmf: ASUS GA403 quirk matching tweak
- dell-smbios: Fix to the init function rollback path

Regards, i.


The following changes since commit a3379eca24a7da5118a7d090da6f8eb8611acac8:

  platform/x86: x86-android-tablets: Make Lenovo Yoga Tab 3 X90F DMI match less strict (2024-08-26 14:34:33 +0300)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.11-6

for you to fetch changes up to d34af755a533271f39cc7d86e49c0e74fde63a37:

  platform/x86/amd: pmf: Make ASUS GA403 quirk generic (2024-09-03 17:31:08 +0300)

----------------------------------------------------------------
platform-drivers-x86 for v6.11-6

Changes:
- amd/pmf: ASUS GA403 quirk matching tweak
- dell-smbios: Fix to the init function rollback path

The following is an automated shortlog grouped by driver:

amd: pmf:
 -  Make ASUS GA403 quirk generic

dell-smbios:
 -  Fix error path in dell_smbios_init()

----------------------------------------------------------------
Aleksandr Mishin (1):
      platform/x86: dell-smbios: Fix error path in dell_smbios_init()

Luke D. Jones (1):
      platform/x86/amd: pmf: Make ASUS GA403 quirk generic

 drivers/platform/x86/amd/pmf/pmf-quirks.c    | 2 +-
 drivers/platform/x86/dell/dell-smbios-base.c | 5 ++++-
 2 files changed, 5 insertions(+), 2 deletions(-)

