Return-Path: <linux-kernel+bounces-352084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 421DA9919F4
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 21:31:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70CF71C216FB
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 19:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 570C1171E7C;
	Sat,  5 Oct 2024 19:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SbZnZTL4"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC92166F11;
	Sat,  5 Oct 2024 19:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728156641; cv=none; b=l2bSfLhWPve/uRo9eRQr5cZ8KHWD5iU5MGepEl6m3TXTK1M4UZ0UlxdI2FOy6BU7XWehsZW6bCuyMdLDzxr+MqqBKVYZyjyY9bCjnmGv+lLxfiKBYg1TdzRxBG4E9mk50ioKVN50CSOiPnqDA7PQ2+i6uWB52E2CUg+LWpIBA9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728156641; c=relaxed/simple;
	bh=DAZkK2w6uiaoPIH0NFXtrjeE8rlq8Uh2RD5oK2bm1jY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fGQMg3Ev3JQXVTbJSvMVuZPfbEbbeOv0/yUw7ZYmj4nxFtzLH/vHU1bk4o8HE8MyErW8Oke2byie1sgTkYZNykFfU+KAFbUms1x1/EV/NGgOw5Qyv3TVUbWkp3KeVIGFxVrIK39JbkWhXXpaXEwVb0a7eXbW2Upk/DThbJrsQSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SbZnZTL4; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728156640; x=1759692640;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=DAZkK2w6uiaoPIH0NFXtrjeE8rlq8Uh2RD5oK2bm1jY=;
  b=SbZnZTL4jDcIGAMQkxBgHgWF4hphX+kj6L9yBGDtAKp1K02UnW22jyBG
   4Cp4BU5DkeKZYE2FNs38Amnx8OXNz7G1MYhbdIQvWQF/cFkHZ52DGT80j
   swUfqCMaNGqbj+mSdH4/PTKqfnDO3xS2bOPISm5u3Tn6+1uKgNLRDdUGL
   cOzFML/q6Paiv+ZHA3Yg3MQev89bGYjXFIpbByWgxF6I8WOr8yU4wW8Wk
   1ZP88WYUDvyVsMGKwajE2KTi+8+py374jPFsEFqYS+QA2MczPmjcw3aoM
   kYistd724bNZjWOb6ptguCGgEb4dZVCByuzFBX8rpKvv3dJgdy1OKUlGj
   g==;
X-CSE-ConnectionGUID: 8DsdHRAwRna2cSZzXZiVVg==
X-CSE-MsgGUID: Pk7vqWHPQzS0dsPVyV/TJQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11216"; a="44879472"
X-IronPort-AV: E=Sophos;i="6.11,181,1725346800"; 
   d="scan'208";a="44879472"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2024 12:30:36 -0700
X-CSE-ConnectionGUID: yXVhGMvfT0S0VdwxUXSYTQ==
X-CSE-MsgGUID: qnOSeE/ZQ4yPUxGj/vYNuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,181,1725346800"; 
   d="scan'208";a="74861628"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa010.jf.intel.com with ESMTP; 05 Oct 2024 12:30:33 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id D0B86178; Sat, 05 Oct 2024 22:30:31 +0300 (EEST)
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
Subject: [PATCH v2 0/4] mfd: intel_soc_pmic_bxtwc: Fix IRQ domain usage
Date: Sat,  5 Oct 2024 22:27:03 +0300
Message-ID: <20241005193029.1929139-1-andriy.shevchenko@linux.intel.com>
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
platform APIs unveil this after the commit a85a6c86c25b ("driver core:
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

I have tested this on Intel Joule SoM (Apollo Lake SoC).

In v2:
- added tags (Hans, Zhang)
- fixed typo in the commit messages

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


