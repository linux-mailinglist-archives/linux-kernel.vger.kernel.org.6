Return-Path: <linux-kernel+bounces-173155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 467298BFC45
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 13:39:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01D41285590
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 11:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BB2D82D66;
	Wed,  8 May 2024 11:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kci4b9x0"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064178120A;
	Wed,  8 May 2024 11:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715168297; cv=none; b=SXXZ+aemNTkzNugrLC+8PtqAD7CJMZO9zvyMsd0/J43nePWid/PYZHb8oLeTgeDfEscNnYof26yixprVtP1CRKrP0m7RHSGv9/tDOVeX/TM0edXyBL3C/RKZ2XTr0oWKGOw+ITsSCiBrfoOStQ4j5j1xm3ruY7YWaJ19w65/Oi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715168297; c=relaxed/simple;
	bh=iweWDyYezogrtHMPwakIJOi3mF2YKlhm4kZbXzx5dEM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L0y2Sdez1th6PjCW59a24zJyWBTXNW/03j8GM5fuTESwiajibD9gnqEdUbLNcfYvT3Vr/Y8sRbpUOMriAY/Aik0iFUkGDxLRzhuAnkqS8nlvus/b1UnL3TxLPtLpIpB0vju19mt5Ocx2Exeq5CC3m0EXFgcHvwYpcGxUv4WMnJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Kci4b9x0; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715168296; x=1746704296;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=iweWDyYezogrtHMPwakIJOi3mF2YKlhm4kZbXzx5dEM=;
  b=Kci4b9x0IEIUk5fGHt4RZWBF26Kqg+mi6dSj7YOKBhsEYy+dFC3pi8Wx
   BjmqR9K6ib+KQueNvI2Vml3iuPnZQi46WAUs3JyvNtHLesrY4tRin2tYM
   OHTM1S4HpxBLzTS6tddgKkxvTALuP0LNddRCl+6SrjocjOLM8pjVZMHAU
   hn5fxG/+ofgWIPV0nLOmXyaEGgqLHMWFz3ho9qGIW6ed6P1asBlCn2dvq
   8YvdHEFVTprsr7HC+HayfNDoMOuLht2ajtf6TMauPbfxiXtQwcO8SQUXo
   NMLWKId6xWKfMJVhNbdGOQNYTSXtZn9znBQAyT6mZNNTk+psjCGZt+8Li
   w==;
X-CSE-ConnectionGUID: OVRgsgomQaSJFGf6BDGb3A==
X-CSE-MsgGUID: CNNuUfs9RjaprAyMJZHBQw==
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="11233689"
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="11233689"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 04:38:15 -0700
X-CSE-ConnectionGUID: zisdnwuuRFOLYoml0UjQIw==
X-CSE-MsgGUID: nwWIU/lPSi2pMCs/8TgTyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="33695727"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa004.jf.intel.com with ESMTP; 08 May 2024 04:38:13 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 2286911F; Wed, 08 May 2024 14:38:12 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-usb@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>
Subject: [PATCH v1 1/1] usb: phy: tegra: Replace of_gpio.h by proper one
Date: Wed,  8 May 2024 14:38:09 +0300
Message-ID: <20240508113809.926155-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

of_gpio.h is deprecated and subject to remove.
The driver doesn't use it directly, replace it
with what is really being used.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/usb/tegra_usb_phy.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/usb/tegra_usb_phy.h b/include/linux/usb/tegra_usb_phy.h
index 46e73584b6e6..e6c14f2b1f9b 100644
--- a/include/linux/usb/tegra_usb_phy.h
+++ b/include/linux/usb/tegra_usb_phy.h
@@ -7,11 +7,12 @@
 #define __TEGRA_USB_PHY_H
 
 #include <linux/clk.h>
-#include <linux/gpio.h>
 #include <linux/regmap.h>
 #include <linux/reset.h>
 #include <linux/usb/otg.h>
 
+struct gpio_desc;
+
 /*
  * utmi_pll_config_in_car_module: true if the UTMI PLL configuration registers
  *     should be set up by clk-tegra, false if by the PHY code
-- 
2.43.0.rc1.1336.g36b5255a03ac


