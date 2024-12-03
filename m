Return-Path: <linux-kernel+bounces-429522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC9279E1D62
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 14:19:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92E1A16551D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 13:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 460311F131E;
	Tue,  3 Dec 2024 13:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UPLYwTgV"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5911EF09C;
	Tue,  3 Dec 2024 13:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733231913; cv=none; b=RK1iIsElBOWUE3gA+68DRNvX0AeX/35+5dR8iYghvBN9tS5CmdCGhhvCS2XQCiDvl0d7XaAu11bDFkm0NMHBUMr6zsuJOZciLk4v50Hlgr/2hy0rN6uC28X2/6ecnRlaDzdwFIJMbyw9AXVapu7a/NC0pcKMHA4Iuq1xiFq5nbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733231913; c=relaxed/simple;
	bh=59bEtfRaVj423x64sYt038E3O0mYimIWQQSEY98Z8tE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q9dfWaIX8wsepRiw0eaqtlrcE20Sz5TG4CJ/wS5QuotWny3YfHUN9dnL+RufXpmQ80/HHQPKF56vMFI4Qtc+Z97lzezRYiQfi6M5m3Ruv/ynQWJWdynb/2E/R0hhqgrMXx7aUqU7+AWnan8xOwabDOKzOhsv/9wMuejlm4iA/GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UPLYwTgV; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733231912; x=1764767912;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=59bEtfRaVj423x64sYt038E3O0mYimIWQQSEY98Z8tE=;
  b=UPLYwTgVXH3/OWM1KVvoTaRmmZfAMgnFM41a91PEHo31UpeAQ6KJy92F
   7CCiruD1HVgxeuypb4ao96dWLoDej2/DsgEt4KrycifcxjQ90RqVTw3bp
   QZaIXNdI7rOil8lwlagNmzlhgZhTZjIgkA1nNHbuFnCIKAAul9mPeb0Uq
   jCKuEuCujhmGbLbZ5QXjYH7gDnTwUX3baSwmG3akyE6uf4Q7r1oYFHk8/
   FL/+rt77LXoITx8icEZznGWzDy8Z7iP2OVhUqlmckiocJTKevc7InTi4x
   fbupkX5NmQO5fuwpKhPJVr/1ifkn7noL2vbLiW6KU+TeB+noCI7hNnd4k
   w==;
X-CSE-ConnectionGUID: xxR7KK75S/2IbV5t8HtPkA==
X-CSE-MsgGUID: +gNvtIrhQASAVkVZcbTxqA==
X-IronPort-AV: E=McAfee;i="6700,10204,11274"; a="33500719"
X-IronPort-AV: E=Sophos;i="6.12,205,1728975600"; 
   d="scan'208";a="33500719"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 05:18:31 -0800
X-CSE-ConnectionGUID: tQq0hz2HQKOtA23ibmczvg==
X-CSE-MsgGUID: a9awDaagRZ2oWRQeOqTVLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,205,1728975600"; 
   d="scan'208";a="130896061"
Received: from ccbilbre-mobl3.amr.corp.intel.com (HELO yungchua-desk.intel.com) ([10.124.223.75])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 05:18:30 -0800
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.dev,
	bard.liao@intel.com
Subject: [PATCH v2 02/14] soundwire: mipi_disco: read lane mapping properties from ACPI
Date: Tue,  3 Dec 2024 21:18:01 +0800
Message-ID: <20241203131813.58454-3-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241203131813.58454-1-yung-chuan.liao@linux.intel.com>
References: <20241203131813.58454-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The DisCo for SoundWire 2.0 added support for the
'mipi-sdw-lane-<n>-mapping' property.

Co-developed-by: Chao Song <chao.song@linux.intel.com>
Signed-off-by: Chao Song <chao.song@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/mipi_disco.c | 40 +++++++++++++++++++++++++++++++++-
 include/linux/soundwire/sdw.h  |  5 +++++
 2 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/drivers/soundwire/mipi_disco.c b/drivers/soundwire/mipi_disco.c
index 9d59f486edbe..65afb28ef8fa 100644
--- a/drivers/soundwire/mipi_disco.c
+++ b/drivers/soundwire/mipi_disco.c
@@ -366,6 +366,44 @@ static int sdw_slave_read_dpn(struct sdw_slave *slave,
 	return 0;
 }
 
+/*
+ * In MIPI DisCo spec for SoundWire, lane mapping for a slave device is done with
+ * mipi-sdw-lane-x-mapping properties, where x is 1..7, and the values for those
+ * properties are mipi-sdw-manager-lane-x or mipi-sdw-peripheral-link-y, where x
+ * is an integer between 1 to 7 if the lane is connected to a manager lane, y is a
+ * character between A to E if the lane is connected to another peripheral lane.
+ */
+int sdw_slave_read_lane_mapping(struct sdw_slave *slave)
+{
+	struct sdw_slave_prop *prop = &slave->prop;
+	struct device *dev = &slave->dev;
+	char prop_name[30];
+	const char *prop_val;
+	size_t len;
+	int ret, i;
+	u8 lane;
+
+	for (i = 0; i < SDW_MAX_LANES; i++) {
+		snprintf(prop_name, sizeof(prop_name), "mipi-sdw-lane-%d-mapping", i);
+		ret = device_property_read_string(dev, prop_name, &prop_val);
+		if (ret)
+			continue;
+
+		len = strlen(prop_val);
+		if (len < 1)
+			return -EINVAL;
+
+		/* The last character is enough to identify the connection */
+		ret = kstrtou8(&prop_val[len - 1], 10, &lane);
+		if (ret)
+			return ret;
+		if (in_range(lane, 1, SDW_MAX_LANES - 1))
+			prop->lane_maps[i] = lane;
+	}
+	return 0;
+}
+EXPORT_SYMBOL(sdw_slave_read_lane_mapping);
+
 /**
  * sdw_slave_read_prop() - Read Slave properties
  * @slave: SDW Slave
@@ -486,6 +524,6 @@ int sdw_slave_read_prop(struct sdw_slave *slave)
 	sdw_slave_read_dpn(slave, prop->sink_dpn_prop, nval,
 			   prop->sink_ports, "sink");
 
-	return 0;
+	return sdw_slave_read_lane_mapping(slave);
 }
 EXPORT_SYMBOL(sdw_slave_read_prop);
diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
index bd9836690da6..bb4e33a4db17 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -54,6 +54,8 @@ struct sdw_slave;
 #define SDW_MAX_PORTS			15
 #define SDW_VALID_PORT_RANGE(n)		((n) < SDW_MAX_PORTS && (n) >= 1)
 
+#define SDW_MAX_LANES		8
+
 enum {
 	SDW_PORT_DIRN_SINK = 0,
 	SDW_PORT_DIRN_SOURCE,
@@ -356,6 +358,7 @@ struct sdw_dpn_prop {
  * and masks are supported
  * @commit_register_supported: is PCP_Commit register supported
  * @scp_int1_mask: SCP_INT1_MASK desired settings
+ * @lane_maps: Lane mapping for the slave, only valid if lane_control_support is set
  * @clock_reg_supported: the Peripheral implements the clock base and scale
  * registers introduced with the SoundWire 1.2 specification. SDCA devices
  * do not need to set this boolean property as the registers are required.
@@ -385,6 +388,7 @@ struct sdw_slave_prop {
 	u32 sdca_interrupt_register_list;
 	u8 commit_register_supported;
 	u8 scp_int1_mask;
+	u8 lane_maps[SDW_MAX_LANES];
 	bool clock_reg_supported;
 	bool use_domain_irq;
 };
@@ -450,6 +454,7 @@ struct sdw_master_prop {
 
 int sdw_master_read_prop(struct sdw_bus *bus);
 int sdw_slave_read_prop(struct sdw_slave *slave);
+int sdw_slave_read_lane_mapping(struct sdw_slave *slave);
 
 /*
  * SDW Slave Structures and APIs
-- 
2.43.0


