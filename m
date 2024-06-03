Return-Path: <linux-kernel+bounces-198685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B8BD8D7C19
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 09:03:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC52AB20F2D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 07:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C621739FEC;
	Mon,  3 Jun 2024 07:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DAXeJK7B"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7878428DD1;
	Mon,  3 Jun 2024 07:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717398174; cv=none; b=HH9KYukVRu1b/dnwGdrV0N49HbEjKZSezesiZh+mewTHdEb0l7rjbZI8ThNbNQCXnEh8RoGRS/oiBbqNUQjaXGM/YIN3X23TatSjMi8VTXR8DHtE1VzkaLW0utPHYQUTsps+rOj0oikeWhNhvqhNcOLQHlKKCWWYq8oJCA+2I/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717398174; c=relaxed/simple;
	bh=7G+KHzZPfIXYAoHo6LS/I+i8QeZAT2Qnm+pClda5V+o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=uXnuX4LaS2zCTuBSIbVIuuRXmPJZBZPvaM3s6G57AlKy6qAnsZ18nvfkoordLJ654K/PJ5QmDvpz7mEoyXWspLsadlwsTjFxQVr0v5fZVsxB617/BjHZSZQOIuAjJMvrJcuVIjtSf4pObnwJB2lnCgHk98xoQsvF40yOP9VNqxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DAXeJK7B; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717398173; x=1748934173;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7G+KHzZPfIXYAoHo6LS/I+i8QeZAT2Qnm+pClda5V+o=;
  b=DAXeJK7BnCzbJ8nJsgPymzy24dkfv0sdMIWqzUdEmb7Vrp1ZutknznWc
   YyYMBQvAxOXEpfrE8c3vDQDG1RZWpw1rsEen/p6PPZEyewmDRrAYtuE6A
   fHYeVJxozPccdYctNtFRb4RjoY2ndkXRoy9u6iZOmqTKvRdVT9XABU+Am
   OmaCabVQqfuDJTYfOy6WXdVxmaRjG5CEuQ0FuzBVXbcOCGVmohOQ1gy0q
   CL4xpXwHKv+CCWlaxUdLg6BufgJ10Q+pQmxcwgscn5N689WhbobAHYLHS
   oGrYHyTiSW0+cDrBgUUhHwMZwbQ3ntO866pBWxDgHewY7lE30TTnBxztS
   Q==;
X-CSE-ConnectionGUID: mEHNoDeSRlyydm8FPzTqDg==
X-CSE-MsgGUID: q1L8g1TRS0umEY3nfJEB3g==
X-IronPort-AV: E=McAfee;i="6600,9927,11091"; a="13724862"
X-IronPort-AV: E=Sophos;i="6.08,210,1712646000"; 
   d="scan'208";a="13724862"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 00:02:52 -0700
X-CSE-ConnectionGUID: OV4f8bkoQ+mKerJwXjAxTA==
X-CSE-MsgGUID: ZJ8n/1TcQgaN/f3m5k4zAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,210,1712646000"; 
   d="scan'208";a="41875252"
Received: from unknown (HELO yungchua-desk.intel.com) ([10.247.119.183])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 00:02:49 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.intel.com,
	bard.liao@intel.com
Subject: [PATCH] soundwire: intel_ace2.x: add AC timing extensions for PantherLake
Date: Mon,  3 Jun 2024 15:02:40 +0800
Message-Id: <20240603070240.5165-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

The ACE3 IP used in PantherLake exposes new bitfields in the ACTMCTL
register to better control clocks/delays. These bitfields were
reserved/zero in the ACE2.x IP, to simplify the integration the new
bifields are added unconditionally. The behavior will only be impacted
when the firmware exposes DSD properties to set non-zero values.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/intel.h           |  5 +++++
 drivers/soundwire/intel_ace2x.c     | 15 +++++++++++++++
 drivers/soundwire/intel_auxdevice.c | 20 ++++++++++++++++++++
 include/linux/soundwire/sdw_intel.h |  5 +++++
 4 files changed, 45 insertions(+)

diff --git a/drivers/soundwire/intel.h b/drivers/soundwire/intel.h
index b68e74c294e7..68838e843b54 100644
--- a/drivers/soundwire/intel.h
+++ b/drivers/soundwire/intel.h
@@ -59,6 +59,11 @@ struct sdw_intel {
 };
 
 struct sdw_intel_prop {
+	u16 clde;
+	u16 doaise2;
+	u16 dodse2;
+	u16 clds;
+	u16 clss;
 	u16 doaise;
 	u16 doais;
 	u16 dodse;
diff --git a/drivers/soundwire/intel_ace2x.c b/drivers/soundwire/intel_ace2x.c
index 8b1b6ad420cf..0dadf46faca6 100644
--- a/drivers/soundwire/intel_ace2x.c
+++ b/drivers/soundwire/intel_ace2x.c
@@ -27,6 +27,11 @@ static void intel_shim_vs_init(struct sdw_intel *sdw)
 	void __iomem *shim_vs = sdw->link_res->shim_vs;
 	struct sdw_bus *bus = &sdw->cdns.bus;
 	struct sdw_intel_prop *intel_prop;
+	u16 clde;
+	u16 doaise2;
+	u16 dodse2;
+	u16 clds;
+	u16 clss;
 	u16 doaise;
 	u16 doais;
 	u16 dodse;
@@ -34,12 +39,22 @@ static void intel_shim_vs_init(struct sdw_intel *sdw)
 	u16 act;
 
 	intel_prop = bus->vendor_specific_prop;
+	clde = intel_prop->clde;
+	doaise2 = intel_prop->doaise2;
+	dodse2 = intel_prop->dodse2;
+	clds = intel_prop->clds;
+	clss = intel_prop->clss;
 	doaise = intel_prop->doaise;
 	doais = intel_prop->doais;
 	dodse = intel_prop->dodse;
 	dods = intel_prop->dods;
 
 	act = intel_readw(shim_vs, SDW_SHIM2_INTEL_VS_ACTMCTL);
+	u16p_replace_bits(&act, clde, SDW_SHIM3_INTEL_VS_ACTMCTL_CLDE);
+	u16p_replace_bits(&act, doaise2, SDW_SHIM3_INTEL_VS_ACTMCTL_DOAISE2);
+	u16p_replace_bits(&act, dodse2, SDW_SHIM3_INTEL_VS_ACTMCTL_DODSE2);
+	u16p_replace_bits(&act, clds, SDW_SHIM3_INTEL_VS_ACTMCTL_CLDS);
+	u16p_replace_bits(&act, clss, SDW_SHIM3_INTEL_VS_ACTMCTL_CLSS);
 	u16p_replace_bits(&act, doaise, SDW_SHIM2_INTEL_VS_ACTMCTL_DOAISE);
 	u16p_replace_bits(&act, doais, SDW_SHIM2_INTEL_VS_ACTMCTL_DOAIS);
 	u16p_replace_bits(&act, dodse, SDW_SHIM2_INTEL_VS_ACTMCTL_DODSE);
diff --git a/drivers/soundwire/intel_auxdevice.c b/drivers/soundwire/intel_auxdevice.c
index 17cf27e6ea73..54cb455ed870 100644
--- a/drivers/soundwire/intel_auxdevice.c
+++ b/drivers/soundwire/intel_auxdevice.c
@@ -159,11 +159,31 @@ static int sdw_master_read_intel_prop(struct sdw_bus *bus)
 		return -ENOMEM;
 
 	/* initialize with hardware defaults, in case the properties are not found */
+	intel_prop->clde = 0x0;
+	intel_prop->doaise2 = 0x0;
+	intel_prop->dodse2 = 0x0;
+	intel_prop->clds = 0x0;
+	intel_prop->clss = 0x0;
 	intel_prop->doaise = 0x1;
 	intel_prop->doais = 0x3;
 	intel_prop->dodse  = 0x0;
 	intel_prop->dods  = 0x1;
 
+	fwnode_property_read_u16(link,
+				 "intel-sdw-clde",
+				 &intel_prop->clde);
+	fwnode_property_read_u16(link,
+				 "intel-sdw-doaise2",
+				 &intel_prop->doaise2);
+	fwnode_property_read_u16(link,
+				 "intel-sdw-dodse2",
+				 &intel_prop->dodse2);
+	fwnode_property_read_u16(link,
+				 "intel-sdw-clds",
+				 &intel_prop->clds);
+	fwnode_property_read_u16(link,
+				 "intel-sdw-clss",
+				 &intel_prop->clss);
 	fwnode_property_read_u16(link,
 				 "intel-sdw-doaise",
 				 &intel_prop->doaise);
diff --git a/include/linux/soundwire/sdw_intel.h b/include/linux/soundwire/sdw_intel.h
index 8e78417156e3..d537587b4499 100644
--- a/include/linux/soundwire/sdw_intel.h
+++ b/include/linux/soundwire/sdw_intel.h
@@ -182,6 +182,11 @@
 #define SDW_SHIM2_INTEL_VS_ACTMCTL_DODSE	BIT(2)
 #define SDW_SHIM2_INTEL_VS_ACTMCTL_DOAIS	GENMASK(4, 3)
 #define SDW_SHIM2_INTEL_VS_ACTMCTL_DOAISE	BIT(5)
+#define SDW_SHIM3_INTEL_VS_ACTMCTL_CLSS		BIT(6)
+#define SDW_SHIM3_INTEL_VS_ACTMCTL_CLDS		GENMASK(11, 7)
+#define SDW_SHIM3_INTEL_VS_ACTMCTL_DODSE2	GENMASK(13, 12)
+#define SDW_SHIM3_INTEL_VS_ACTMCTL_DOAISE2	BIT(14)
+#define SDW_SHIM3_INTEL_VS_ACTMCTL_CLDE		BIT(15)
 
 /**
  * struct sdw_intel_stream_params_data: configuration passed during
-- 
2.40.1


