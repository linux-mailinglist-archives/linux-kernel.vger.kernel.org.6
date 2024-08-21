Return-Path: <linux-kernel+bounces-295460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 504EF959B35
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 14:05:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED1541F224C1
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 12:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CADB49659;
	Wed, 21 Aug 2024 12:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NoZnvUYc"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D09E1D1304;
	Wed, 21 Aug 2024 12:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724241905; cv=none; b=ifeJAH6nnwZElImX1JQxWhk+qG01UI9/J+GBZHHv4IhVQ64vV5s2aLIOOrdLmV2+tZNGWvHgvvGVw6wFXMW5bGyKM3J/P8SFmNsGSV9l/VMy+0plBbbThQRDffniqjxUhPhOPqe3PCJe8vv/S5SBGJaNsN6L1xLSC4jEiiTh6kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724241905; c=relaxed/simple;
	bh=kkemyqSbgq4Wi5mtf87z+iEyf1zAZrBisQqAGMkoY78=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dTKC/Z0e5x2wySV95MfG4Q1C4axZZk6zq6vCYkokgAHsn4dZsf+MldXA6S6GsR7Jj1S1lhRsDX2VQ1Pi/e38MA6vYCcto6kRkNgCK5ELYXdTrVPeucloaaQxA6AEy+GVcJ91sefddln0ibpRm7iX9lgLRVcw3IvHHIBVVfgqAOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NoZnvUYc; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724241904; x=1755777904;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=kkemyqSbgq4Wi5mtf87z+iEyf1zAZrBisQqAGMkoY78=;
  b=NoZnvUYcAe8J0LQCulhzHhI2qKvMMNkmK0sHjkn2WV3IEmOpi6OK3x9b
   B53KTo341KRFQcvQdoQ4hVD0ajplsHKv5+euxQX70vl8fM8xxUBmYmFhw
   wsSKqyuQ38aQE0S2lxCGsVjEYMdocK4W3Nchyq4dYlFoDUEFtgSCY9kz6
   HHKotJemB/trQF82cCZ6WXe/F2/Ie+x0xbVH4p9Js9k6nTrfS4HIN/EWD
   QL4i37Gsp36q7mIg3jOrFP6mns61jOcZ1mrOAc9xhZvxzAvG/gpIvX2c6
   acy7VeXf7eBD1a6CMUFUHqwuHmpB69ajRWK5Svei73DVyf36wJILKdpfI
   w==;
X-CSE-ConnectionGUID: C/fxzO7JTuqs0F5/Pe5ejg==
X-CSE-MsgGUID: o4Za1bJ+SK6sqMo+bBP+yw==
X-IronPort-AV: E=McAfee;i="6700,10204,11170"; a="33258078"
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="33258078"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 05:05:01 -0700
X-CSE-ConnectionGUID: Ao/3LgvuRCKRzJLjhoe0ww==
X-CSE-MsgGUID: AVwgTqHxQtq5CZjcsYDwQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="61211166"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa010.fm.intel.com with ESMTP; 21 Aug 2024 05:05:00 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id CC40C43E; Wed, 21 Aug 2024 15:04:58 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Alex Hung <alexhung@gmail.com>
Subject: [PATCH v1 1/1] platform/x86: intel-hid: Use string_choices API instead of ternary operator
Date: Wed, 21 Aug 2024 15:04:57 +0300
Message-ID: <20240821120458.3702655-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use modern string_choices API instead of manually determining the
output using ternary operator.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/platform/x86/intel/hid.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/intel/hid.c b/drivers/platform/x86/intel/hid.c
index 10cd65497cc1..445e7a59beb4 100644
--- a/drivers/platform/x86/intel/hid.c
+++ b/drivers/platform/x86/intel/hid.c
@@ -13,6 +13,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/string_choices.h>
 #include <linux/suspend.h>
 #include "../dual_accel_detect.h"
 
@@ -331,10 +332,8 @@ static int intel_hid_set_enable(struct device *device, bool enable)
 	acpi_handle handle = ACPI_HANDLE(device);
 
 	/* Enable|disable features - power button is always enabled */
-	if (!intel_hid_execute_method(handle, INTEL_HID_DSM_HDSM_FN,
-				      enable)) {
-		dev_warn(device, "failed to %sable hotkeys\n",
-			 enable ? "en" : "dis");
+	if (!intel_hid_execute_method(handle, INTEL_HID_DSM_HDSM_FN, enable)) {
+		dev_warn(device, "failed to %s hotkeys\n", str_enable_disable(enable));
 		return -EIO;
 	}
 
-- 
2.43.0.rc1.1336.g36b5255a03ac


