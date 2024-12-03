Return-Path: <linux-kernel+bounces-429533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA249E1D70
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 14:22:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78B5D166078
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 13:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 804291F756B;
	Tue,  3 Dec 2024 13:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CvCryS5d"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35D11F706B;
	Tue,  3 Dec 2024 13:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733231929; cv=none; b=Md6TuxGi99LJp06HmmCCQwI1pQvdOWHLhXWpykXkfoEnkIwP0w1owiH5V+BtzKFo6wOH60b6bQJklkQkF+ukL3tMi7nNcEtghNcVgqrxL8YAXvk5UZdTPLGi1caIB2vFQPlaaq13gyjbxKIoBPMEOjIYZyqR6RJm7l3i4qAqo90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733231929; c=relaxed/simple;
	bh=cBfk3r4npCovZRyrmuSzUJTQyDiHsvRpmWg/QdUUCH4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TA8H5OJOtnYphZ5n0dO4J9eN0TT4dT9vL/w7WZsSTT6FaTEkGutlaWA+p4voM0RSzioim7gl30EOkFMCCgIYGVM6i/iwADygzT1XhQYEtYJfvw3yeA8XLWApERXe8cLzfU8m9Xfh1eQTHakXqQPqCNPkOy49qzQ7Wml/c6I/qqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CvCryS5d; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733231928; x=1764767928;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cBfk3r4npCovZRyrmuSzUJTQyDiHsvRpmWg/QdUUCH4=;
  b=CvCryS5dqhnCX6V4Wt4JmoTGLPFADt1MC6aMoiSwA5ilK/YsArBk7mAU
   NtRJjrjXVgu3j0F9v6xVXeNddLQfuppCq5Sns6r3v8GjoACuoRaz7wab4
   J8pL7UCa+/2Lg4PRni/1Iyy+wEK03a3hpOF4F9KhKoPUHdRfRRVv8WKKD
   2eG7WH+buEfpZsXZygWqtaaJznzp7lU2Q9eQGDXuI7mQ+hVsuUr9XL9zS
   uwJs0ljNzI+UQaaeC810Ppf03ezZFAnboP3XAbOhpLb0/Yob6GAmAt+Ve
   TKW1JI3HjfQ+2MexGYjxC0DffshAgIpiDRFhwtiyrUTmPLh+N3Ns6b1PF
   w==;
X-CSE-ConnectionGUID: DemJ5qc6S4GWaclPf0Cmcw==
X-CSE-MsgGUID: PdxNwET0RUuG9daNqvbCxw==
X-IronPort-AV: E=McAfee;i="6700,10204,11274"; a="33500784"
X-IronPort-AV: E=Sophos;i="6.12,205,1728975600"; 
   d="scan'208";a="33500784"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 05:18:47 -0800
X-CSE-ConnectionGUID: uFzR2KfVSSu+DWqsDUhvOA==
X-CSE-MsgGUID: ib3ngG9OTuu/IjB2ae7HLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,205,1728975600"; 
   d="scan'208";a="130896147"
Received: from ccbilbre-mobl3.amr.corp.intel.com (HELO yungchua-desk.intel.com) ([10.124.223.75])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 05:18:46 -0800
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.dev,
	bard.liao@intel.com
Subject: [PATCH v2 13/14] SoundWire: pass stream to compute_params()
Date: Tue,  3 Dec 2024 21:18:12 +0800
Message-ID: <20241203131813.58454-14-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241203131813.58454-1-yung-chuan.liao@linux.intel.com>
References: <20241203131813.58454-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The stream parameter will be used in the follow up commit.
No function change.

Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
---
 drivers/soundwire/amd_manager.c               |   2 +-
 .../soundwire/generic_bandwidth_allocation.c  |  11 +-
 drivers/soundwire/qcom.c                      |   2 +-
 drivers/soundwire/stream.c                    |   4 +-
 include/linux/soundwire/sdw.h                 | 182 +++++++++---------
 5 files changed, 102 insertions(+), 99 deletions(-)

diff --git a/drivers/soundwire/amd_manager.c b/drivers/soundwire/amd_manager.c
index f47d4cd656ae..0ee792176f22 100644
--- a/drivers/soundwire/amd_manager.c
+++ b/drivers/soundwire/amd_manager.c
@@ -384,7 +384,7 @@ static u32 amd_sdw_read_ping_status(struct sdw_bus *bus)
 	return slave_stat;
 }
 
-static int amd_sdw_compute_params(struct sdw_bus *bus)
+static int amd_sdw_compute_params(struct sdw_bus *bus, struct sdw_stream_runtime *stream)
 {
 	struct sdw_transport_data t_data = {0};
 	struct sdw_master_runtime *m_rt;
diff --git a/drivers/soundwire/generic_bandwidth_allocation.c b/drivers/soundwire/generic_bandwidth_allocation.c
index faf04d82ba0a..062e7488b226 100644
--- a/drivers/soundwire/generic_bandwidth_allocation.c
+++ b/drivers/soundwire/generic_bandwidth_allocation.c
@@ -170,6 +170,7 @@ static void _sdw_compute_port_params(struct sdw_bus *bus,
 }
 
 static int sdw_compute_group_params(struct sdw_bus *bus,
+				    struct sdw_stream_runtime *stream,
 				    struct sdw_group_params *params,
 				    struct sdw_group *group)
 {
@@ -319,8 +320,9 @@ static int sdw_get_group_count(struct sdw_bus *bus,
  * sdw_compute_port_params: Compute transport and port parameters
  *
  * @bus: SDW Bus instance
+ * @stream: Soundwire stream
  */
-static int sdw_compute_port_params(struct sdw_bus *bus)
+static int sdw_compute_port_params(struct sdw_bus *bus, struct sdw_stream_runtime *stream)
 {
 	struct sdw_group_params *params = NULL;
 	struct sdw_group group;
@@ -340,7 +342,7 @@ static int sdw_compute_port_params(struct sdw_bus *bus)
 	}
 
 	/* Compute transport parameters for grouped streams */
-	ret = sdw_compute_group_params(bus, params, &group);
+	ret = sdw_compute_group_params(bus, stream, params, &group);
 	if (ret < 0)
 		goto free_params;
 
@@ -592,8 +594,9 @@ static int sdw_compute_bus_params(struct sdw_bus *bus)
  * sdw_compute_params: Compute bus, transport and port parameters
  *
  * @bus: SDW Bus instance
+ * @stream: Soundwire stream
  */
-int sdw_compute_params(struct sdw_bus *bus)
+int sdw_compute_params(struct sdw_bus *bus, struct sdw_stream_runtime *stream)
 {
 	int ret;
 
@@ -603,7 +606,7 @@ int sdw_compute_params(struct sdw_bus *bus)
 		return ret;
 
 	/* Compute transport and port params */
-	ret = sdw_compute_port_params(bus);
+	ret = sdw_compute_port_params(bus, stream);
 	if (ret < 0) {
 		dev_err(bus->dev, "Compute transport params failed: %d\n", ret);
 		return ret;
diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
index 2b403b14066c..fd98f05bf56d 100644
--- a/drivers/soundwire/qcom.c
+++ b/drivers/soundwire/qcom.c
@@ -1072,7 +1072,7 @@ static const struct sdw_master_ops qcom_swrm_ops = {
 	.pre_bank_switch = qcom_swrm_pre_bank_switch,
 };
 
-static int qcom_swrm_compute_params(struct sdw_bus *bus)
+static int qcom_swrm_compute_params(struct sdw_bus *bus, struct sdw_stream_runtime *stream)
 {
 	struct qcom_swrm_ctrl *ctrl = to_qcom_sdw(bus);
 	struct sdw_master_runtime *m_rt;
diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
index b0868f71b63e..48b637f3c189 100644
--- a/drivers/soundwire/stream.c
+++ b/drivers/soundwire/stream.c
@@ -1415,7 +1415,7 @@ static int _sdw_prepare_stream(struct sdw_stream_runtime *stream,
 
 			/* Compute params */
 			if (bus->compute_params) {
-				ret = bus->compute_params(bus);
+				ret = bus->compute_params(bus, stream);
 				if (ret < 0) {
 					dev_err(bus->dev, "Compute params failed: %d\n",
 						ret);
@@ -1717,7 +1717,7 @@ static int _sdw_deprepare_stream(struct sdw_stream_runtime *stream)
 
 		/* Compute params */
 		if (bus->compute_params) {
-			ret = bus->compute_params(bus);
+			ret = bus->compute_params(bus, stream);
 			if (ret < 0) {
 				dev_err(bus->dev, "Compute params failed: %d\n",
 					ret);
diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
index fc0a203c3ae0..2d6c30317792 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -855,6 +855,95 @@ struct sdw_master_ops {
 					int dev_num);
 };
 
+int sdw_bus_master_add(struct sdw_bus *bus, struct device *parent,
+		       struct fwnode_handle *fwnode);
+void sdw_bus_master_delete(struct sdw_bus *bus);
+
+void sdw_show_ping_status(struct sdw_bus *bus, bool sync_delay);
+
+/**
+ * sdw_port_config: Master or Slave Port configuration
+ *
+ * @num: Port number
+ * @ch_mask: channels mask for port
+ */
+struct sdw_port_config {
+	unsigned int num;
+	unsigned int ch_mask;
+};
+
+/**
+ * sdw_stream_config: Master or Slave stream configuration
+ *
+ * @frame_rate: Audio frame rate of the stream, in Hz
+ * @ch_count: Channel count of the stream
+ * @bps: Number of bits per audio sample
+ * @direction: Data direction
+ * @type: Stream type PCM or PDM
+ */
+struct sdw_stream_config {
+	unsigned int frame_rate;
+	unsigned int ch_count;
+	unsigned int bps;
+	enum sdw_data_direction direction;
+	enum sdw_stream_type type;
+};
+
+/**
+ * sdw_stream_state: Stream states
+ *
+ * @SDW_STREAM_ALLOCATED: New stream allocated.
+ * @SDW_STREAM_CONFIGURED: Stream configured
+ * @SDW_STREAM_PREPARED: Stream prepared
+ * @SDW_STREAM_ENABLED: Stream enabled
+ * @SDW_STREAM_DISABLED: Stream disabled
+ * @SDW_STREAM_DEPREPARED: Stream de-prepared
+ * @SDW_STREAM_RELEASED: Stream released
+ */
+enum sdw_stream_state {
+	SDW_STREAM_ALLOCATED = 0,
+	SDW_STREAM_CONFIGURED = 1,
+	SDW_STREAM_PREPARED = 2,
+	SDW_STREAM_ENABLED = 3,
+	SDW_STREAM_DISABLED = 4,
+	SDW_STREAM_DEPREPARED = 5,
+	SDW_STREAM_RELEASED = 6,
+};
+
+/**
+ * sdw_stream_params: Stream parameters
+ *
+ * @rate: Sampling frequency, in Hz
+ * @ch_count: Number of channels
+ * @bps: bits per channel sample
+ */
+struct sdw_stream_params {
+	unsigned int rate;
+	unsigned int ch_count;
+	unsigned int bps;
+};
+
+/**
+ * sdw_stream_runtime: Runtime stream parameters
+ *
+ * @name: SoundWire stream name
+ * @params: Stream parameters
+ * @state: Current state of the stream
+ * @type: Stream type PCM or PDM
+ * @m_rt_count: Count of Master runtime(s) in this stream
+ * @master_list: List of Master runtime(s) in this stream.
+ * master_list can contain only one m_rt per Master instance
+ * for a stream
+ */
+struct sdw_stream_runtime {
+	const char *name;
+	struct sdw_stream_params params;
+	enum sdw_stream_state state;
+	enum sdw_stream_type type;
+	int m_rt_count;
+	struct list_head master_list;
+};
+
 /**
  * struct sdw_bus - SoundWire bus
  * @dev: Shortcut to &bus->md->dev to avoid changing the entire code.
@@ -915,7 +1004,7 @@ struct sdw_bus {
 	int controller_id;
 	unsigned int link_id;
 	int id;
-	int (*compute_params)(struct sdw_bus *bus);
+	int (*compute_params)(struct sdw_bus *bus, struct sdw_stream_runtime *stream);
 	DECLARE_BITMAP(assigned, SDW_MAX_DEVICES);
 	unsigned int clk_stop_timeout;
 	u32 bank_switch_timeout;
@@ -928,99 +1017,10 @@ struct sdw_bus {
 	unsigned int lane_used_bandwidth[SDW_MAX_LANES];
 };
 
-int sdw_bus_master_add(struct sdw_bus *bus, struct device *parent,
-		       struct fwnode_handle *fwnode);
-void sdw_bus_master_delete(struct sdw_bus *bus);
-
-void sdw_show_ping_status(struct sdw_bus *bus, bool sync_delay);
-
-/**
- * sdw_port_config: Master or Slave Port configuration
- *
- * @num: Port number
- * @ch_mask: channels mask for port
- */
-struct sdw_port_config {
-	unsigned int num;
-	unsigned int ch_mask;
-};
-
-/**
- * sdw_stream_config: Master or Slave stream configuration
- *
- * @frame_rate: Audio frame rate of the stream, in Hz
- * @ch_count: Channel count of the stream
- * @bps: Number of bits per audio sample
- * @direction: Data direction
- * @type: Stream type PCM or PDM
- */
-struct sdw_stream_config {
-	unsigned int frame_rate;
-	unsigned int ch_count;
-	unsigned int bps;
-	enum sdw_data_direction direction;
-	enum sdw_stream_type type;
-};
-
-/**
- * sdw_stream_state: Stream states
- *
- * @SDW_STREAM_ALLOCATED: New stream allocated.
- * @SDW_STREAM_CONFIGURED: Stream configured
- * @SDW_STREAM_PREPARED: Stream prepared
- * @SDW_STREAM_ENABLED: Stream enabled
- * @SDW_STREAM_DISABLED: Stream disabled
- * @SDW_STREAM_DEPREPARED: Stream de-prepared
- * @SDW_STREAM_RELEASED: Stream released
- */
-enum sdw_stream_state {
-	SDW_STREAM_ALLOCATED = 0,
-	SDW_STREAM_CONFIGURED = 1,
-	SDW_STREAM_PREPARED = 2,
-	SDW_STREAM_ENABLED = 3,
-	SDW_STREAM_DISABLED = 4,
-	SDW_STREAM_DEPREPARED = 5,
-	SDW_STREAM_RELEASED = 6,
-};
-
-/**
- * sdw_stream_params: Stream parameters
- *
- * @rate: Sampling frequency, in Hz
- * @ch_count: Number of channels
- * @bps: bits per channel sample
- */
-struct sdw_stream_params {
-	unsigned int rate;
-	unsigned int ch_count;
-	unsigned int bps;
-};
-
-/**
- * sdw_stream_runtime: Runtime stream parameters
- *
- * @name: SoundWire stream name
- * @params: Stream parameters
- * @state: Current state of the stream
- * @type: Stream type PCM or PDM
- * @m_rt_count: Count of Master runtime(s) in this stream
- * @master_list: List of Master runtime(s) in this stream.
- * master_list can contain only one m_rt per Master instance
- * for a stream
- */
-struct sdw_stream_runtime {
-	const char *name;
-	struct sdw_stream_params params;
-	enum sdw_stream_state state;
-	enum sdw_stream_type type;
-	int m_rt_count;
-	struct list_head master_list;
-};
-
 struct sdw_stream_runtime *sdw_alloc_stream(const char *stream_name);
 void sdw_release_stream(struct sdw_stream_runtime *stream);
 
-int sdw_compute_params(struct sdw_bus *bus);
+int sdw_compute_params(struct sdw_bus *bus, struct sdw_stream_runtime *stream);
 
 int sdw_stream_add_master(struct sdw_bus *bus,
 			  struct sdw_stream_config *stream_config,
-- 
2.43.0


