Return-Path: <linux-kernel+bounces-324818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E258B975151
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 13:59:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9804528721F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 11:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7084418FDBD;
	Wed, 11 Sep 2024 11:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BBY2/Y7F"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253BD1885A7;
	Wed, 11 Sep 2024 11:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726055945; cv=none; b=lht+1hdov5mvPwXUn9lME0u1A0Z3ti1TLKC6H7c8ydCbRRwunbKnAYFo/bnxE3HDZGj5dcfeZRN3ZuXm6XNXc4Ii7jxHcqH5xgWMj1KmKf3rzVizH9nyShhsYFewYyXOVuKe6fJG0SYP1QPqTL8GAXNWInlifIxFKh+AQN9s5Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726055945; c=relaxed/simple;
	bh=CG9df6F+03dKHnVkxP0n+YhDuVOghFDYTIJ+MPKHnM0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JktV8r2q+MZgKxGrWp1q2QpdzqVvDF1ugFrgvT0yso7TWK7F8luSJ8ZN+sUDU4ZGECvDOAdMSBKkzNGhJGaGyOecqVoojgl9ECPZb+3dMykCH/PCaymohHmxKEGS7MxakYB/SYYQsvxLVToaEHnQvIlEIL+3KvXx2Ul5CAxcivs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BBY2/Y7F; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726055944; x=1757591944;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CG9df6F+03dKHnVkxP0n+YhDuVOghFDYTIJ+MPKHnM0=;
  b=BBY2/Y7Fe+ZJvOLft/Ow4/QzEsBW5BI6jwFb9OK9w4cxYUSCyq6t4SA5
   4xrdtEXuGKrEKpozSzGOBRTw6Ae6aq3mx5gIusg5lfS78n7KfrFRXRuzB
   2Jo6sFqHdNUn66ZBo4/pLy8GZJvDsY01GUq/rmq2bFwJMnppH5GRGhhMP
   QdEavV9hnCMA2IbaewRGbLEVEBdEVe/RzKFzd35VG6lFVzb1BwmARr1NK
   3BK2xXP+zL1kX6syJXCyYn0UMtKkRqm+ae6+uku26tyg2yylruBJ2/X5X
   7q2SCNcs0lgLhy/omi74W5N0qx/+aW0uDFSe3ewveVbqpq2iDOMKOmP6X
   Q==;
X-CSE-ConnectionGUID: H0MMd+sqSF6QBfkrudW+7Q==
X-CSE-MsgGUID: JUqaFUfaSO614pYOoax58A==
X-IronPort-AV: E=McAfee;i="6700,10204,11191"; a="35417210"
X-IronPort-AV: E=Sophos;i="6.10,219,1719903600"; 
   d="scan'208";a="35417210"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2024 04:59:04 -0700
X-CSE-ConnectionGUID: xtXFVfZvStG+TGBo06TOFw==
X-CSE-MsgGUID: lgRKWtBaRwes+aYbZB9wyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,219,1719903600"; 
   d="scan'208";a="67292715"
Received: from bvivekan-mobl2.gar.corp.intel.com (HELO yungchua-desk.intel.com) ([10.247.118.254])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2024 04:59:01 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.intel.com,
	bard.liao@intel.com
Subject: [PATCH v2 01/14] soundwire: mipi_disco: add MIPI-specific property_read_bool() helpers
Date: Wed, 11 Sep 2024 19:58:14 +0800
Message-ID: <20240911115827.233171-2-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240911115827.233171-1-yung-chuan.liao@linux.intel.com>
References: <20240911115827.233171-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

The existing device/fwnode_property_read_bool() helpers only check if
the property is present.

The MIPI DisCo for SoundWire specification allows properties to be
exposed with a value of 'false'. Using the standard helpers to
retrieve the MIPI-defined properties causes all kinds of logical
inversions leading to loss of functionality - such as jack detection
in clock-stop mode broken when the device properties are read in
Realtek codec drivers.

This patch adds new MIPI/SoundWire helpers which first check if the
property is present, and then return the actual value extracted from
platform firmware.

Modifying the default property handling was considered as a possible
solution, but it could lead to other types of logical inversions
breaking 'working' setups. Andy Shevchenko also pointed out that DT
keeps values in the BE32 format, it's probably best to avoid
endianness complications.

The path of least resistance was chosen, with MIPI-specific helpers
which can be tested and with no side effects outside of the SoundWire
subsystem.

Closes: https://github.com/thesofproject/linux/issues/5129
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/mipi_disco.c | 50 ++++++++++++++++++++++++----------
 1 file changed, 35 insertions(+), 15 deletions(-)

diff --git a/drivers/soundwire/mipi_disco.c b/drivers/soundwire/mipi_disco.c
index e5d9df26d4dc..fdab3d4a1379 100644
--- a/drivers/soundwire/mipi_disco.c
+++ b/drivers/soundwire/mipi_disco.c
@@ -23,6 +23,26 @@
 #include <linux/soundwire/sdw.h>
 #include "bus.h"
 
+static bool mipi_fwnode_property_read_bool(const struct fwnode_handle *fwnode,
+					   const char *propname)
+{
+	int ret;
+	u8 val;
+
+	if (!fwnode_property_present(fwnode, propname))
+		return false;
+	ret = fwnode_property_read_u8_array(fwnode, propname, &val, 1);
+	if (ret < 0)
+		return false;
+	return !!val;
+}
+
+static bool mipi_device_property_read_bool(const struct device *dev,
+					   const char *propname)
+{
+	return mipi_fwnode_property_read_bool(dev_fwnode(dev), propname);
+}
+
 /**
  * sdw_master_read_prop() - Read Master properties
  * @bus: SDW bus instance
@@ -48,11 +68,11 @@ int sdw_master_read_prop(struct sdw_bus *bus)
 		return -EIO;
 	}
 
-	if (fwnode_property_read_bool(link,
+	if (mipi_fwnode_property_read_bool(link,
 				      "mipi-sdw-clock-stop-mode0-supported"))
 		prop->clk_stop_modes |= BIT(SDW_CLK_STOP_MODE0);
 
-	if (fwnode_property_read_bool(link,
+	if (mipi_fwnode_property_read_bool(link,
 				      "mipi-sdw-clock-stop-mode1-supported"))
 		prop->clk_stop_modes |= BIT(SDW_CLK_STOP_MODE1);
 
@@ -114,7 +134,7 @@ int sdw_master_read_prop(struct sdw_bus *bus)
 	fwnode_property_read_u32(link, "mipi-sdw-default-frame-col-size",
 				 &prop->default_col);
 
-	prop->dynamic_frame =  fwnode_property_read_bool(link,
+	prop->dynamic_frame =  mipi_fwnode_property_read_bool(link,
 			"mipi-sdw-dynamic-frame-shape");
 
 	fwnode_property_read_u32(link, "mipi-sdw-command-error-threshold",
@@ -153,13 +173,13 @@ static int sdw_slave_read_dp0(struct sdw_slave *slave,
 				dp0->words, dp0->num_words);
 	}
 
-	dp0->BRA_flow_controlled = fwnode_property_read_bool(port,
+	dp0->BRA_flow_controlled = mipi_fwnode_property_read_bool(port,
 				"mipi-sdw-bra-flow-controlled");
 
-	dp0->simple_ch_prep_sm = fwnode_property_read_bool(port,
+	dp0->simple_ch_prep_sm = mipi_fwnode_property_read_bool(port,
 				"mipi-sdw-simplified-channel-prepare-sm");
 
-	dp0->imp_def_interrupts = fwnode_property_read_bool(port,
+	dp0->imp_def_interrupts = mipi_fwnode_property_read_bool(port,
 				"mipi-sdw-imp-def-dp0-interrupts-supported");
 
 	return 0;
@@ -220,7 +240,7 @@ static int sdw_slave_read_dpn(struct sdw_slave *slave,
 					 "mipi-sdw-max-grouping-supported",
 					 &dpn[i].max_grouping);
 
-		dpn[i].simple_ch_prep_sm = fwnode_property_read_bool(node,
+		dpn[i].simple_ch_prep_sm = mipi_fwnode_property_read_bool(node,
 				"mipi-sdw-simplified-channelprepare-sm");
 
 		fwnode_property_read_u32(node,
@@ -278,7 +298,7 @@ static int sdw_slave_read_dpn(struct sdw_slave *slave,
 		fwnode_property_read_u32(node, "mipi-sdw-max-async-buffer",
 					 &dpn[i].max_async_buffer);
 
-		dpn[i].block_pack_mode = fwnode_property_read_bool(node,
+		dpn[i].block_pack_mode = mipi_fwnode_property_read_bool(node,
 				"mipi-sdw-block-packing-mode");
 
 		fwnode_property_read_u32(node, "mipi-sdw-port-encoding-type",
@@ -308,19 +328,19 @@ int sdw_slave_read_prop(struct sdw_slave *slave)
 	device_property_read_u32(dev, "mipi-sdw-sw-interface-revision",
 				 &prop->mipi_revision);
 
-	prop->wake_capable = device_property_read_bool(dev,
+	prop->wake_capable = mipi_device_property_read_bool(dev,
 				"mipi-sdw-wake-up-unavailable");
 	prop->wake_capable = !prop->wake_capable;
 
-	prop->test_mode_capable = device_property_read_bool(dev,
+	prop->test_mode_capable = mipi_device_property_read_bool(dev,
 				"mipi-sdw-test-mode-supported");
 
 	prop->clk_stop_mode1 = false;
-	if (device_property_read_bool(dev,
+	if (mipi_device_property_read_bool(dev,
 				"mipi-sdw-clock-stop-mode1-supported"))
 		prop->clk_stop_mode1 = true;
 
-	prop->simple_clk_stop_capable = device_property_read_bool(dev,
+	prop->simple_clk_stop_capable = mipi_device_property_read_bool(dev,
 			"mipi-sdw-simplified-clockstopprepare-sm-supported");
 
 	device_property_read_u32(dev, "mipi-sdw-clockstopprepare-timeout",
@@ -333,13 +353,13 @@ int sdw_slave_read_prop(struct sdw_slave *slave)
 			"mipi-sdw-clockstopprepare-hard-reset-behavior",
 			&prop->reset_behave);
 
-	prop->high_PHY_capable = device_property_read_bool(dev,
+	prop->high_PHY_capable = mipi_device_property_read_bool(dev,
 			"mipi-sdw-highPHY-capable");
 
-	prop->paging_support = device_property_read_bool(dev,
+	prop->paging_support = mipi_device_property_read_bool(dev,
 			"mipi-sdw-paging-support");
 
-	prop->bank_delay_support = device_property_read_bool(dev,
+	prop->bank_delay_support = mipi_device_property_read_bool(dev,
 			"mipi-sdw-bank-delay-support");
 
 	device_property_read_u32(dev,
-- 
2.43.0


