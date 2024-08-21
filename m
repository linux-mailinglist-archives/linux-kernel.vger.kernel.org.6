Return-Path: <linux-kernel+bounces-296048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FAF795A4E1
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 20:46:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0ED81F238F1
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 18:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E6F81B3B0E;
	Wed, 21 Aug 2024 18:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KTorQswO"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9DADEAC0;
	Wed, 21 Aug 2024 18:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724265958; cv=none; b=Guwc2WuLSAHs7tqiWR3YKxx4/HwZAdVC9pOEygSZdjcyWHLFPP8ensHxf/zE0D/frXTbeei6B4peVUMYEz/azfixpn+sD7DUF/wALQ7od+d394w/I+7HsBQTitJ5wH7DoVgrcM2ZvUPs1+7PYaqLg9TQxfUCT04HzOVQbLTcB/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724265958; c=relaxed/simple;
	bh=cxfQ2TYC2Pf6uL7YdGRSYCNPIqLLJJDtptw+GPbJzh4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JOQkRYgsYBuxwb0Azt2q2bVDvggSoMuk1rJZb/sMUU5PvAOwOM30AKoclsKrJS8nDmWszC63nw/InK5Vy6A/0wK7rlEXOrHhJ6Z91Gk1p+fiMVUOSl40xiEu6JCoT72OPE4vD364UwtQcS8BH9r6RMP+omMt/2Xfc8zdzYQe/sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KTorQswO; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724265956; x=1755801956;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=cxfQ2TYC2Pf6uL7YdGRSYCNPIqLLJJDtptw+GPbJzh4=;
  b=KTorQswOFLqkxyfzjh/I/R+DKUQXS0NdS57y3LK39uQk6oL9W8F9tmTL
   aUajGqqlAb4yRGKFBzCJ0SUyH8v9CWiTQOLklLDT3nwcYfL0YcH8cV5GJ
   PqrrLKcRC2t21usPynoUeOg5itQdSp0T//g0nqw5rFypVPPsKXoz/HYDR
   9s5BxguT9Pj5xtmOSRIA3jTA5Qij+7Pz1vBXKT+sxzz9Ywse1XFzFIuLh
   t/iI+TWNtX06yRHpTRjCcTbRQW4rFl9VG6R/oLl4m3Ng5FT+rYwT3Ouvu
   zwbf++gdCpCHcIGCgyqJwDPLv8bbrDpH+j91BgOqW3GEwzM9mEUr0TiXn
   w==;
X-CSE-ConnectionGUID: BCQTxFUCQca01oCLJKTfQQ==
X-CSE-MsgGUID: v75+344TRTik71i18E4VEg==
X-IronPort-AV: E=McAfee;i="6700,10204,11171"; a="33215854"
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="33215854"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 11:45:55 -0700
X-CSE-ConnectionGUID: akN04QTuQHG/dG/XKj4ihw==
X-CSE-MsgGUID: r3tdL/DlQuyLfSp7tQpiMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="60898531"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa007.fm.intel.com with ESMTP; 21 Aug 2024 11:45:53 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 5AD97268; Wed, 21 Aug 2024 21:45:52 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Hans de Goede <hdegoede@redhat.com>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Daniel Scally <djrscally@gmail.com>
Subject: [PATCH v1 1/1] platform/x86: int3472: discrete: Remap "reset" to "enable" for OV7251
Date: Wed, 21 Aug 2024 21:40:07 +0300
Message-ID: <20240821184546.627456-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver of OV7251 expects "enable" pin instead of "reset".
Remap "reset" to "enable" and update polarity.

In particular, the Microsoft Surface Book can't load the camera sensor
driver without this change:

 ov7251 i2c-INT347E:00: supply vdddo not found, using dummy regulator
 ov7251 i2c-INT347E:00: supply vddd not found, using dummy regulator
 ov7251 i2c-INT347E:00: supply vdda not found, using dummy regulator
 ov7251 i2c-INT347E:00: cannot get enable gpio
 ov7251 i2c-INT347E:00: probe with driver ov7251 failed with error -2

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---

Hmm... I have spent some time to achieve this, and then I realised that
linux-surface GitHub project already has something similar [1].

The advantage of [1] is that it applies the quirk to all OV7251 sensors
on the platform (don't know how useful it IRL).

However, it seems the [1] has two issues:
1) it missed terminator entry in the ACPI ID table;
2) it forces polarity to be active high, while I think the XOR approach
is better as it's possible (but quite unlikely I believe) that reset pin
might be inverted on the PCB level.

All in all, I'm fine with any of these patches to be applied with the
above mentioned improvements / caveats.

Link: https://github.com/linux-surface/kernel/commit/d0f2c2d5a449c2bf69432f90d164183143d8af8d [1]

 drivers/platform/x86/intel/int3472/discrete.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/platform/x86/intel/int3472/discrete.c b/drivers/platform/x86/intel/int3472/discrete.c
index b5f6f71bb1dd..0559295dfb27 100644
--- a/drivers/platform/x86/intel/int3472/discrete.c
+++ b/drivers/platform/x86/intel/int3472/discrete.c
@@ -86,6 +86,16 @@ static int skl_int3472_map_gpio_to_sensor(struct int3472_discrete_device *int347
 		return -EINVAL;
 	}
 
+	/*
+	 * The driver of OV7251 expects "enable" pin instead of "reset".
+	 * Remap "reset" to "enable" and update polarity.
+	 */
+	if (!strcmp(int3472->sensor_name, "i2c-INT347E:00") &&
+	    !strcmp(func, "reset")) {
+		func = "enable";
+		polarity ^= GPIO_ACTIVE_LOW;
+	}
+
 	ret = skl_int3472_fill_gpiod_lookup(&int3472->gpios.table[int3472->n_sensor_gpios],
 					    agpio, func, polarity);
 	if (ret)
-- 
2.43.0.rc1.1336.g36b5255a03ac


