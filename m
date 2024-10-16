Return-Path: <linux-kernel+bounces-367873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 461109A07D4
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 12:52:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7277E1C280EF
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 10:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F1842076DC;
	Wed, 16 Oct 2024 10:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fPJ706jw"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350AD2071FE
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 10:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729075941; cv=none; b=VZaFu7r/rV35y62J2AQ/Rq9CeufrEcmd7lo9GrgEu1/ZdGvZLUdbrdDxqdplNxV6865HspPbOugnSno07PpVsA5ApHJePska2RW0Ar6+bR+r1f/Z/IKbyp6hyo4GATbacJcNMfYqACiHAtqXKdvuP0SCxxNr5Lev5op/xTG0fck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729075941; c=relaxed/simple;
	bh=jJ5Dx5nScUtZW8vUTxHnxSqXEChMTGzv9BI+vmS133Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i/sOf2EiVkEmk25ubd1gkNAzq8G9aoVBNgNJZ1X9dQKFel/awB1W6P4e4eLlokzkTGTk6D8hWQce2A6ufgvUfUHCYJvyoyUYZtak55XblsoUpdg6J5QZWeQ0kH+Wx5g7x/JwXfKWaXHUPFbsRXV3Llv4id4gQRmRG+qQqFPP6h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fPJ706jw; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729075940; x=1760611940;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jJ5Dx5nScUtZW8vUTxHnxSqXEChMTGzv9BI+vmS133Y=;
  b=fPJ706jw+DVlVlRoi3S5QEZgu2cGagZZgblUbQ6fRNh5MKmQS2g9dRt7
   nmWnaJa9SYN9Afvcx9J8D4ENhHcp8sNdoFPMjbv1GqMFjF6Sy0ys8j9hZ
   YGo1f6qwnMfx0r5JKKDrlj1F2ZEep4wMz6Ut0Y86WNhL98dRiQc6R/YJo
   aTU7HFoctAl77HhSph6Tu/e9SHpD2w+/Mccq9SwvsSOsehJBYCxL5terY
   l+hayZsTVMAunbdLbmxMep2GVjnpGwaZeJ4Gxfcmo1QlIoS9FbIGY3J9U
   wPlL2bS6bD0rgIISJcoMYfkyPsPBKOzRIfyEj5podx5sQCioH6W+SmXuq
   Q==;
X-CSE-ConnectionGUID: /rdFdTTeS1W/w4Hy3bdFfw==
X-CSE-MsgGUID: jui2hkZIQcuCWrgcoCTblQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11226"; a="31382474"
X-IronPort-AV: E=Sophos;i="6.11,207,1725346800"; 
   d="scan'208";a="31382474"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 03:52:05 -0700
X-CSE-ConnectionGUID: WfMSlj0mSba/ZfPYKI/r2A==
X-CSE-MsgGUID: PIxhc3UzSJiHLtuok1CRTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,207,1725346800"; 
   d="scan'208";a="82740099"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa005.fm.intel.com with ESMTP; 16 Oct 2024 03:52:04 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 02DE250F; Wed, 16 Oct 2024 13:52:02 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andy@kernel.org>,
	Lee Jones <lee@kernel.org>
Subject: [PATCH v1 2/4] mfd: intel_soc_pmic_bxtwc: Don't use "proxy" headers
Date: Wed, 16 Oct 2024 13:49:52 +0300
Message-ID: <20241016105201.757024-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20241016105201.757024-1-andriy.shevchenko@linux.intel.com>
References: <20241016105201.757024-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update header inclusions to follow IWYU (Include What You Use)
principle.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mfd/intel_soc_pmic_bxtwc.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/intel_soc_pmic_bxtwc.c b/drivers/mfd/intel_soc_pmic_bxtwc.c
index c130734f308e..1469e89b88ce 100644
--- a/drivers/mfd/intel_soc_pmic_bxtwc.c
+++ b/drivers/mfd/intel_soc_pmic_bxtwc.c
@@ -6,16 +6,27 @@
  */
 
 #include <linux/acpi.h>
+#include <linux/array_size.h>
 #include <linux/bits.h>
 #include <linux/delay.h>
+#include <linux/device.h>
 #include <linux/err.h>
+#include <linux/errno.h>
+#include <linux/gfp_types.h>
 #include <linux/interrupt.h>
-#include <linux/kernel.h>
+#include <linux/ioport.h>
+#include <linux/kstrtox.h>
 #include <linux/mfd/core.h>
 #include <linux/mfd/intel_soc_pmic.h>
 #include <linux/mfd/intel_soc_pmic_bxtwc.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/platform_data/x86/intel_scu_ipc.h>
+#include <linux/platform_device.h>
+#include <linux/pm.h>
+#include <linux/regmap.h>
+#include <linux/sysfs.h>
+#include <linux/types.h>
 
 /* PMIC device registers */
 #define REG_ADDR_MASK		GENMASK(15, 8)
-- 
2.43.0.rc1.1336.g36b5255a03ac


