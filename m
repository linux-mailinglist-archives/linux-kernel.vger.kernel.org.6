Return-Path: <linux-kernel+bounces-313518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CE1BF96A693
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 20:32:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59722B20CCB
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 18:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D9B51922D8;
	Tue,  3 Sep 2024 18:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VpAcO3E0"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D1518E027;
	Tue,  3 Sep 2024 18:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725388303; cv=none; b=bt7VssdDnFW0nrTjBvq5s4P8mZq1mSainSuYvOsYKrMdpDfG6Vxr4V83TETcOGTfmsfw5CtlFyH0TqFhyLLZPdXd4gtu9gluAK+eeORGc5HogC/G58Yke6CBcF+6MX2aMdXRzFDSgoURxzpLcXyT5JhAGj2EmVTuWFCPlNOnNh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725388303; c=relaxed/simple;
	bh=lLtBvj4b4a9FZjEQXtG8TT4P04Lxq60KH2gciLcoEKw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JNOVJtP01XBTQKqp9f16RBO57nvpB48Nzl5Py5EqkqMBUDymlefj8X1J3wgPVIW812F1rZAQFcXf5E77ddWGH0XK45dYLKKdv6q/B8Z++qLeTbeBuGru/nGoP3JowO70OWhp7XISsbGEQpUMc1p8xF9BRH6INm+OB46WTs+o6gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VpAcO3E0; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725388302; x=1756924302;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lLtBvj4b4a9FZjEQXtG8TT4P04Lxq60KH2gciLcoEKw=;
  b=VpAcO3E0dJNsNam4bq2h+6CG9DYzeXY3K2JK+PTai32QIMgEj5egW7qv
   J5xlkQ66vhnL0PYVLJPrUYMod1/UeTwiMhlb0VcSXBMECoK8xyxroNmUJ
   hASlnlRheaxLxwY5c6jVmmjJVlDx9w55Y1JLQ4XQ3qyi2VfbP1+pWEl9u
   jGx7LQeBYxNbud5OOO9VVxBAewRzeJ33bmnvujpX/Z7Q2G+wmZ/QWyvUm
   bGfVCaGwtuzBhWGzahcUVYxtXRP9dPdVjoxFlgXkr0bRupsuxxSKX2CuX
   dWqsN8hNNFiPWS0kcPZcmkVgF8QFjENo8zR0Hneg33czdg2ftReu6Ai6X
   A==;
X-CSE-ConnectionGUID: Yl7EuGAURHSKzAOrWG3WMw==
X-CSE-MsgGUID: FvkMtC7sRXipXnpBtsFUPw==
X-IronPort-AV: E=McAfee;i="6700,10204,11184"; a="24147196"
X-IronPort-AV: E=Sophos;i="6.10,199,1719903600"; 
   d="scan'208";a="24147196"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2024 11:31:41 -0700
X-CSE-ConnectionGUID: WVx0QEHbQRynxXfjEMTsWQ==
X-CSE-MsgGUID: nUIglSs7TRqIA/x//dRGZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,199,1719903600"; 
   d="scan'208";a="95809013"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa001.fm.intel.com with ESMTP; 03 Sep 2024 11:31:39 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 12D613C1; Tue, 03 Sep 2024 21:31:37 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] usb: common: Switch to device_property_match_property_string()
Date: Tue,  3 Sep 2024 21:31:36 +0300
Message-ID: <20240903183136.3641770-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace open coded device_property_match_property_string().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/usb/common/common.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/common/common.c b/drivers/usb/common/common.c
index 84ec00b7966c..b7bea1015d7c 100644
--- a/drivers/usb/common/common.c
+++ b/drivers/usb/common/common.c
@@ -107,19 +107,18 @@ EXPORT_SYMBOL_GPL(usb_speed_string);
  */
 enum usb_device_speed usb_get_maximum_speed(struct device *dev)
 {
-	const char *maximum_speed;
+	const char *p = "maximum-speed";
 	int ret;
 
-	ret = device_property_read_string(dev, "maximum-speed", &maximum_speed);
-	if (ret < 0)
-		return USB_SPEED_UNKNOWN;
-
-	ret = match_string(ssp_rate, ARRAY_SIZE(ssp_rate), maximum_speed);
+	ret = device_property_match_property_string(dev, p, ssp_rate, ARRAY_SIZE(ssp_rate));
 	if (ret > 0)
 		return USB_SPEED_SUPER_PLUS;
 
-	ret = match_string(speed_names, ARRAY_SIZE(speed_names), maximum_speed);
-	return (ret < 0) ? USB_SPEED_UNKNOWN : ret;
+	ret = device_property_match_property_string(dev, p, speed_names, ARRAY_SIZE(speed_names));
+	if (ret > 0)
+		return ret;
+
+	return USB_SPEED_UNKNOWN;
 }
 EXPORT_SYMBOL_GPL(usb_get_maximum_speed);
 
-- 
2.43.0.rc1.1336.g36b5255a03ac


