Return-Path: <linux-kernel+bounces-191812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF8DA8D1485
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 08:36:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 544B51F225A5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 06:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE8D66CDBA;
	Tue, 28 May 2024 06:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ne0vD+UC"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74C243AA0;
	Tue, 28 May 2024 06:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716878197; cv=none; b=oeuq31fjrAnSbCQCn5lZ1675DJJ3of3WyU06uvlBB4qE3JCIrdcKam2DhTmhhssntOjjTEN/23Mm4y3mOZ1OVbXuHPgiifQwFLhlSl6/a0PK2moAwIZXh6Vqjn5y0n5B8vNwLmQo+OZG7C3lJnxYMwlw7dgvLx2ZOTqEjosdPko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716878197; c=relaxed/simple;
	bh=Sg+IcNNEjBjx+fva33u11Pc6mvukNwmfXvMaetmyd5o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=S2zAntbvRqhNHF9nwA3nKtecCKaeH0UBN+NLr6WFxLi3pRjIwuKg0REoArvff7yKmngYk4bCFKrQbV7tAfOvsn7IJ7CWCLO0XTbhA3/u/y69tAMwgWIbbfBO7QiIVVByQyeL0wRqnJi2ZImmz/8XJDfr+Cy+ZGkwm92OLA/NW7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ne0vD+UC; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716878192; x=1748414192;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Sg+IcNNEjBjx+fva33u11Pc6mvukNwmfXvMaetmyd5o=;
  b=Ne0vD+UC928izlhBxU8ueKufz0MYNOvLWUrqonXDPVpVnw9dZoCgWzcG
   Ene695TMJ7TyLi270tbgpkKkrO0XAWY/fu8nhNHWcnntOtM/yY7XpC98m
   V5DV2PXIhTMFW4+OjjNDOT2CiXXwVWOWYbDQ4sygQ4VF8wufT5/3qGzm9
   Z0l9rRvSVlkUMpmWykP3tqjttxUJkxYRMQvQ+DPQCw8eUteLfJYcAtPFx
   M9AaE2Vv6PhiiQ2ZMwX9KsUXDPOCRaeRd1tGDXc74W9p+u7VeX4H3kRho
   ATxj0yisW6wNguEm9Mn9svaG1I3SmhJMK5O6E6fluakA7zg3Cc7ZrDwCV
   A==;
X-CSE-ConnectionGUID: f6CHiFheTYGtvV5iq+d1zg==
X-CSE-MsgGUID: yQyk7HEPSBSI74YwgfvZCQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="16992793"
X-IronPort-AV: E=Sophos;i="6.08,194,1712646000"; 
   d="scan'208";a="16992793"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 23:35:47 -0700
X-CSE-ConnectionGUID: ewdttm7NRViisvzAi3k7Lg==
X-CSE-MsgGUID: 2kCWKMdGRHumPrZb9qiT+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,194,1712646000"; 
   d="scan'208";a="39402253"
Received: from bvivekan-mobl2.gar.corp.intel.com (HELO yungchua-desk.intel.com) ([10.247.119.83])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 23:35:42 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.intel.com,
	bard.liao@intel.com
Subject: [PATCH RESEND] soundwire: fix usages of device_get_named_child_node()
Date: Tue, 28 May 2024 14:35:33 +0800
Message-Id: <20240528063533.26723-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

The documentation for device_get_named_child_node() mentions this
important point:

"
The caller is responsible for calling fwnode_handle_put() on the
returned fwnode pointer.
"

Add fwnode_handle_put() to avoid leaked references.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/amd_manager.c     |  3 +++
 drivers/soundwire/intel_auxdevice.c |  6 +++++-
 drivers/soundwire/mipi_disco.c      | 30 +++++++++++++++++++++++------
 3 files changed, 32 insertions(+), 7 deletions(-)

diff --git a/drivers/soundwire/amd_manager.c b/drivers/soundwire/amd_manager.c
index 20d94bcfc9b4..795e223f7e5c 100644
--- a/drivers/soundwire/amd_manager.c
+++ b/drivers/soundwire/amd_manager.c
@@ -571,6 +571,9 @@ static int sdw_master_read_amd_prop(struct sdw_bus *bus)
 	amd_manager->wake_en_mask = wake_en_mask;
 	fwnode_property_read_u32(link, "amd-sdw-power-mode", &power_mode_mask);
 	amd_manager->power_mode_mask = power_mode_mask;
+
+	fwnode_handle_put(link);
+
 	return 0;
 }
 
diff --git a/drivers/soundwire/intel_auxdevice.c b/drivers/soundwire/intel_auxdevice.c
index 17cf27e6ea73..18517121cc89 100644
--- a/drivers/soundwire/intel_auxdevice.c
+++ b/drivers/soundwire/intel_auxdevice.c
@@ -155,8 +155,10 @@ static int sdw_master_read_intel_prop(struct sdw_bus *bus)
 		SDW_MASTER_QUIRKS_CLEAR_INITIAL_PARITY;
 
 	intel_prop = devm_kzalloc(bus->dev, sizeof(*intel_prop), GFP_KERNEL);
-	if (!intel_prop)
+	if (!intel_prop) {
+		fwnode_handle_put(link);
 		return -ENOMEM;
+	}
 
 	/* initialize with hardware defaults, in case the properties are not found */
 	intel_prop->doaise = 0x1;
@@ -184,6 +186,8 @@ static int sdw_master_read_intel_prop(struct sdw_bus *bus)
 		intel_prop->dodse,
 		intel_prop->dods);
 
+	fwnode_handle_put(link);
+
 	return 0;
 }
 
diff --git a/drivers/soundwire/mipi_disco.c b/drivers/soundwire/mipi_disco.c
index 55a9c51c84c1..e5d9df26d4dc 100644
--- a/drivers/soundwire/mipi_disco.c
+++ b/drivers/soundwire/mipi_disco.c
@@ -66,8 +66,10 @@ int sdw_master_read_prop(struct sdw_bus *bus)
 		prop->clk_freq = devm_kcalloc(bus->dev, prop->num_clk_freq,
 					      sizeof(*prop->clk_freq),
 					      GFP_KERNEL);
-		if (!prop->clk_freq)
+		if (!prop->clk_freq) {
+			fwnode_handle_put(link);
 			return -ENOMEM;
+		}
 
 		fwnode_property_read_u32_array(link,
 				"mipi-sdw-clock-frequencies-supported",
@@ -92,8 +94,10 @@ int sdw_master_read_prop(struct sdw_bus *bus)
 		prop->clk_gears = devm_kcalloc(bus->dev, prop->num_clk_gears,
 					       sizeof(*prop->clk_gears),
 					       GFP_KERNEL);
-		if (!prop->clk_gears)
+		if (!prop->clk_gears) {
+			fwnode_handle_put(link);
 			return -ENOMEM;
+		}
 
 		fwnode_property_read_u32_array(link,
 					       "mipi-sdw-supported-clock-gears",
@@ -116,6 +120,8 @@ int sdw_master_read_prop(struct sdw_bus *bus)
 	fwnode_property_read_u32(link, "mipi-sdw-command-error-threshold",
 				 &prop->err_threshold);
 
+	fwnode_handle_put(link);
+
 	return 0;
 }
 EXPORT_SYMBOL(sdw_master_read_prop);
@@ -197,8 +203,10 @@ static int sdw_slave_read_dpn(struct sdw_slave *slave,
 						    dpn[i].num_words,
 						    sizeof(*dpn[i].words),
 						    GFP_KERNEL);
-			if (!dpn[i].words)
+			if (!dpn[i].words) {
+				fwnode_handle_put(node);
 				return -ENOMEM;
+			}
 
 			fwnode_property_read_u32_array(node,
 					"mipi-sdw-port-wordlength-configs",
@@ -236,8 +244,10 @@ static int sdw_slave_read_dpn(struct sdw_slave *slave,
 						       dpn[i].num_channels,
 						       sizeof(*dpn[i].channels),
 						 GFP_KERNEL);
-			if (!dpn[i].channels)
+			if (!dpn[i].channels) {
+				fwnode_handle_put(node);
 				return -ENOMEM;
+			}
 
 			fwnode_property_read_u32_array(node,
 					"mipi-sdw-channel-number-list",
@@ -251,8 +261,10 @@ static int sdw_slave_read_dpn(struct sdw_slave *slave,
 					dpn[i].num_ch_combinations,
 					sizeof(*dpn[i].ch_combinations),
 					GFP_KERNEL);
-			if (!dpn[i].ch_combinations)
+			if (!dpn[i].ch_combinations) {
+				fwnode_handle_put(node);
 				return -ENOMEM;
+			}
 
 			fwnode_property_read_u32_array(node,
 					"mipi-sdw-channel-combination-list",
@@ -274,6 +286,8 @@ static int sdw_slave_read_dpn(struct sdw_slave *slave,
 
 		/* TODO: Read audio mode */
 
+		fwnode_handle_put(node);
+
 		i++;
 	}
 
@@ -348,10 +362,14 @@ int sdw_slave_read_prop(struct sdw_slave *slave)
 		prop->dp0_prop = devm_kzalloc(&slave->dev,
 					      sizeof(*prop->dp0_prop),
 					      GFP_KERNEL);
-		if (!prop->dp0_prop)
+		if (!prop->dp0_prop) {
+			fwnode_handle_put(port);
 			return -ENOMEM;
+		}
 
 		sdw_slave_read_dp0(slave, port, prop->dp0_prop);
+
+		fwnode_handle_put(port);
 	}
 
 	/*
-- 
2.40.1


