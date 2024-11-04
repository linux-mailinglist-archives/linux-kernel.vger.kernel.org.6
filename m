Return-Path: <linux-kernel+bounces-394150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6003F9BAB34
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 04:24:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D2001C20DCD
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 03:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E5A617D8BF;
	Mon,  4 Nov 2024 03:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bYPggu19"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134851632EB;
	Mon,  4 Nov 2024 03:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730690639; cv=none; b=ICDMjRtNj4qkCb2P8na+/MCOXgI91ye/uvmRFG1OzTIfcNWh5fnoSWkawua3dbm+lyJdYQ97fYZ6kbr5zJ5K4IidvmJiy4h18GJ3YbPU5AZYcH1VoXPQDYAaNHVfRBL6wbLBh897siaWCdYpm9hnDVh8f8nyOQh8vYzNkXkQmeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730690639; c=relaxed/simple;
	bh=sKiIMx9zPTEQC81BFP1TKqE00pJw//lLsdszQR1Xgjs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iYpD9hJ3CUJ6JMt/Cs7gUF0yDe910VGa/qTIdGtindcuu30SMTLyG2PxGEbk1jbKLe1e/qpVQu3fTqmbVSOBDCMsM/C/UF8Lp2fIapxmI8hbJmRtZP9EqnYwqgY438lM7yd9tSs41fdJaa6ir6hOHkycgxSFionNFtoW2rWMOso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bYPggu19; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730690638; x=1762226638;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sKiIMx9zPTEQC81BFP1TKqE00pJw//lLsdszQR1Xgjs=;
  b=bYPggu19STOPA3qkpUid71kEyL4tvMOn1PytNrXtL4IPoY59JldnnaHU
   5qj6faPGf+BlCpPlZnAJJo9cbT9rmnuYg5wKtyafvcfsVHs/aM/rtLxxc
   cXM10V+nDBt4acLtyB/0ro+s94xcFiFupnQO1g5RUd6zv4UAYocrxXb78
   tbIecPzBHxpGwFdY8QxXYWbEgQqztXrZLUS2Sg3YHmLXb/HFujSMcDXZW
   4ACBC4Dg1115m2e6bigA779rE0RBxoMKZPXEbObM2Z44OEjcagVaBwLUT
   TrMREikppnFw3eCuAAXTjmbwoSQAf71x0Ic7ybYPo83lDdBm4Dlp1yzaY
   w==;
X-CSE-ConnectionGUID: kxdPynMQSY2FurXdKUdPzA==
X-CSE-MsgGUID: XZj+QRgsS1aeZ5RqP7nSBg==
X-IronPort-AV: E=McAfee;i="6700,10204,11245"; a="30594271"
X-IronPort-AV: E=Sophos;i="6.11,256,1725346800"; 
   d="scan'208";a="30594271"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2024 19:23:55 -0800
X-CSE-ConnectionGUID: SZYyy8nLTEOnV24nwr/wnw==
X-CSE-MsgGUID: ZkmV95/hQoi/Uq+mNCJKGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,256,1725346800"; 
   d="scan'208";a="114331795"
Received: from yungchua-ws.ostc.intel.com (HELO yungchua-ws.intel.com) ([10.54.69.90])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2024 19:23:56 -0800
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.dev,
	bard.liao@intel.com
Subject: [PATCH 02/12] soundwire: mipi_disco: read lane mapping properties from ACPI
Date: Mon,  4 Nov 2024 03:23:48 +0000
Message-Id: <20241104032358.669705-3-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241104032358.669705-1-yung-chuan.liao@linux.intel.com>
References: <20241104032358.669705-1-yung-chuan.liao@linux.intel.com>
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
index 73f655334fe9..928d56cd7e6d 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -46,6 +46,8 @@ struct sdw_slave;
 #define SDW_MAX_PORTS			15
 #define SDW_VALID_PORT_RANGE(n)		((n) < SDW_MAX_PORTS && (n) >= 1)
 
+#define SDW_MAX_LANES		8
+
 enum {
 	SDW_PORT_DIRN_SINK = 0,
 	SDW_PORT_DIRN_SOURCE,
@@ -348,6 +350,7 @@ struct sdw_dpn_prop {
  * and masks are supported
  * @commit_register_supported: is PCP_Commit register supported
  * @scp_int1_mask: SCP_INT1_MASK desired settings
+ * @lane_maps: Lane mapping for the slave, only valid if lane_control_support is set
  * @clock_reg_supported: the Peripheral implements the clock base and scale
  * registers introduced with the SoundWire 1.2 specification. SDCA devices
  * do not need to set this boolean property as the registers are required.
@@ -377,6 +380,7 @@ struct sdw_slave_prop {
 	u32 sdca_interrupt_register_list;
 	u8 commit_register_supported;
 	u8 scp_int1_mask;
+	u8 lane_maps[SDW_MAX_LANES];
 	bool clock_reg_supported;
 	bool use_domain_irq;
 };
@@ -442,6 +446,7 @@ struct sdw_master_prop {
 
 int sdw_master_read_prop(struct sdw_bus *bus);
 int sdw_slave_read_prop(struct sdw_slave *slave);
+int sdw_slave_read_lane_mapping(struct sdw_slave *slave);
 
 /*
  * SDW Slave Structures and APIs
-- 
2.34.1


