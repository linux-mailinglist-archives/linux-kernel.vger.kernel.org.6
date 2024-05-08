Return-Path: <linux-kernel+bounces-173449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E937C8C0091
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 17:04:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2E021C233BA
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 15:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BCCE126F04;
	Wed,  8 May 2024 15:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PcUx9Cyn"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4781E54657;
	Wed,  8 May 2024 15:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715180653; cv=none; b=a4PzjQ5kHaqket+IeW3K5cTlpAu7K5UBNwEFjiDwCGJKXZb/NFKw5ZQfhdjvpcjfxafPK/EU1RgmMgw4Naq67u6/cBgI91e7bQZlTBHOgbrfibvGzjbhbN87XySc3AFMoqLfnIlf5nT72nTdfkodHWVIWZTPKhNk4GM+YwPf5mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715180653; c=relaxed/simple;
	bh=uJSpbk3ya3vagd4krDgPsMn2Z9oeD4q5b/Qz/h4I1zw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t+gbVs0Kg0/2Ge/lZhAhfmVkTLWmh4KPEDp/rWaOgCTCqyCrPQzKqGfS7T3i5Fvw/96seHRtJb1/azhHx09dspeW46kSibAh3ypFegOa1EHMlp5x2MDlBhx4t1sXoMgyjYtvlV7u2mw7BpnDvCzZPN+Y6Arh7phkVpl4F4Dd3v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PcUx9Cyn; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715180652; x=1746716652;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=uJSpbk3ya3vagd4krDgPsMn2Z9oeD4q5b/Qz/h4I1zw=;
  b=PcUx9CynuGdK5mG/TH6c5p7nvu0KBrSPyVHDoeu/Xb4YSgGo7yu6B/iz
   hnnACocax3nAH6dIBOBdikAdMA83fJ4Ng+L2B97e1wUASqVfpxfnLPkyw
   k0BeC5851UzztQXX27HC2+zEKvHmE4gUpTKNQadv6QeHETrQs8Wj8/QoH
   KJDhSZPiaLxxoHNJP1HplWCaXI0RfNbLS8y5wB93gOg60ssv9KINa25uh
   lK97B5j+oXlDT+de86aMdUdVM2DEDyRMjmjB+F8oFFD0LqMHXZ5JprkwJ
   S3V7ow1CoMspHQD2ftasxICDI3pWTC9SBIzhafcxrX+RjKxa4qVkyBO1r
   Q==;
X-CSE-ConnectionGUID: Cjb5ZJ5SQdSJj+hnAJvFag==
X-CSE-MsgGUID: ouVA2lmnTImzs64ahgMx3Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11067"; a="22453879"
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="22453879"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 08:04:12 -0700
X-CSE-ConnectionGUID: 3+V4Gd93S1OZO2hv34MwmA==
X-CSE-MsgGUID: gVHMF76RQ0KLKTXQeFsXxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="33441079"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa003.fm.intel.com with ESMTP; 08 May 2024 08:04:10 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id E7862109; Wed, 08 May 2024 18:04:08 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v1 1/1] usb: fotg210: Use *-y instead of *-objs in Makefile
Date: Wed,  8 May 2024 18:04:06 +0300
Message-ID: <20240508150406.1378672-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

*-objs suffix is reserved rather for (user-space) host programs while
usually *-y suffix is used for kernel drivers (although *-objs works
for that purpose for now).

Let's correct the old usages of *-objs in Makefiles.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/usb/fotg210/Makefile | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/fotg210/Makefile b/drivers/usb/fotg210/Makefile
index 5aecff21f24b..8f5b0fb9b988 100644
--- a/drivers/usb/fotg210/Makefile
+++ b/drivers/usb/fotg210/Makefile
@@ -1,10 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 
-# This setup links the different object files into one single
-# module so we don't have to EXPORT() a lot of internal symbols
-# or create unnecessary submodules.
-fotg210-objs-y				+= fotg210-core.o
-fotg210-objs-$(CONFIG_USB_FOTG210_HCD)	+= fotg210-hcd.o
-fotg210-objs-$(CONFIG_USB_FOTG210_UDC)	+= fotg210-udc.o
-fotg210-objs				:= $(fotg210-objs-y)
 obj-$(CONFIG_USB_FOTG210)		+= fotg210.o
+fotg210-y				:= fotg210-core.o
+fotg210-$(CONFIG_USB_FOTG210_HCD)	+= fotg210-hcd.o
+fotg210-$(CONFIG_USB_FOTG210_UDC)	+= fotg210-udc.o
-- 
2.43.0.rc1.1336.g36b5255a03ac


