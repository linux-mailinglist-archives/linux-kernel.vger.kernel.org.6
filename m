Return-Path: <linux-kernel+bounces-349405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38D2698F574
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 19:43:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B46EAB21454
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 17:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29BE01A76D0;
	Thu,  3 Oct 2024 17:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mrftDL/Y"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F4C15534D;
	Thu,  3 Oct 2024 17:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727977423; cv=none; b=dVyvdRQp7WvQND2a9W3pL6a2sg/UgzsbvJ5O/HfDfVALVNZkdvUUwfG5ixwVe8/clL29LBZwH621LnDdNa86A3MxPKdf2pPke8/Ld3YktSLZCgi9SDVrEz1hbmzRAd9PuvxgTE1vUAEgDVat01xfXONxpC/nf9owG6Y47bietpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727977423; c=relaxed/simple;
	bh=NOKjV+szRuwwsziQwPUPk1Ep5pmMQ0asxQEC3Im0PSs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kqWO0ccepWZ/iC5bLOxuSggjr+dQoKKmvz3br9FFx+NGwaYCfL7NB/yODxWB6pdjcUs4PfLiObjyO4Ml+wIr1KTglqdNJ+4UdUkarWS9bonZ2nXq400QPXCJZdNVZNko+PHTPm69y/QG54a+nqrKJZPPJJWmAmJoZlenZo+oJCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mrftDL/Y; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727977422; x=1759513422;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=NOKjV+szRuwwsziQwPUPk1Ep5pmMQ0asxQEC3Im0PSs=;
  b=mrftDL/Yu6IAXKGln9iwj0nTNwA4vvMXWQaYxAEc878qIvoJOXXXW8oY
   oWLVQEc1suCMc+Pi6PWFu5HnefKqAw5sLTl+RCtipnl+7LqAeB27RVp4S
   SapohHeBEODuZfcicLUhGkqyH2NBLRFepTIb8g7bAQXtyjboLqX0RDsSb
   COnesuwyp+GofDCyFthQnk5BcHfoLY65AAxBQrvga1ESGAHYnFDLX3O19
   wED9DV8ve9kpolEG712xnAr2KkW7NOXCWdozo86rxyr6z+j8pkOE1D5Sa
   yp3OWYIKBg/rs9asQnGHPAwxIclT/HgQMHk5XefLYE/Tt9uhdfPQs9kd2
   w==;
X-CSE-ConnectionGUID: PKRplT8AQX2IdBZEYxKPXA==
X-CSE-MsgGUID: GFrI3e32Spyv7hY/i7NQUg==
X-IronPort-AV: E=McAfee;i="6700,10204,11214"; a="27074226"
X-IronPort-AV: E=Sophos;i="6.11,175,1725346800"; 
   d="scan'208";a="27074226"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2024 10:43:41 -0700
X-CSE-ConnectionGUID: XNoRbspFRiip1YZtx7h7WA==
X-CSE-MsgGUID: u12whoksRKWk+Oe2PeDGQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,175,1725346800"; 
   d="scan'208";a="74116150"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa007.fm.intel.com with ESMTP; 03 Oct 2024 10:43:38 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 7DE4B1E5; Thu, 03 Oct 2024 20:43:37 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-usb@vger.kernel.org
Cc: Andy Shevchenko <andy@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v1 0/4] mfd: intel_soc_pmic_bxtwc: Fix IRQ domain usage
Date: Thu,  3 Oct 2024 20:32:00 +0300
Message-ID: <20241003174252.1190628-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It appears that the driver has been developed without proper thinking
of what the difference between HW IRQ and Linux IRQ (also known as vIRQ).
This misunderstanding led to the 0 being used as vIRQ which is no-no and
platform APIs unveal this after the commit a85a6c86c25b ("driver core:
platform: Clarify that IRQ 0 is invalid"). With this the Intel Broxton
Whiskey Cove PMIC driver has to be fixed all over the places.

In this series two immediate fixes as reported recently and we have
drivers for (patches 1 & 2) followed by the patch that prepares the
same fix for the devices that have no in-tree drivers yet. At the end
it is a fix for IRQ domain debugging (when enabled), but it requires
quite recent patches in IRQ domain and regmap IRQ subsystems, which is
reflected in the Depends-on tag (I can't use Fixes, as this doesn't
fix anything related to that).

The series touches a couple of subsystems as the respective drivers
has to be fixed simultaneously. The idea is to proceed the series via
MFD tree to where the main driver belongs.

I also hope that Zhang will be able to test it soon and provide his
Tested-by. I have tested this on Intel Joule SoM (Apollo Lake SoC).

Andy Shevchenko (4):
  mfd: intel_soc_pmic_bxtwc: Use IRQ domain for USB Type-C device
  mfd: intel_soc_pmic_bxtwc: Use IRQ domain for TMU device
  mfd: intel_soc_pmic_bxtwc: Use IRQ domain for PMIC devices
  mfd: intel_soc_pmic_bxtwc: Fix IRQ domain names duplication

 drivers/mfd/intel_soc_pmic_bxtwc.c     | 144 ++++++++++++++++---------
 drivers/platform/x86/intel/bxtwc_tmu.c |  22 ++--
 drivers/usb/typec/tcpm/wcove.c         |   4 -
 3 files changed, 97 insertions(+), 73 deletions(-)

-- 
2.43.0.rc1.1336.g36b5255a03ac


