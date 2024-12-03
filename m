Return-Path: <linux-kernel+bounces-429531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F4C49E1D6D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 14:21:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C470328249A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 13:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 432761F755A;
	Tue,  3 Dec 2024 13:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dGoqR1c6"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9761F708D;
	Tue,  3 Dec 2024 13:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733231926; cv=none; b=N87niiPhrDucGInsglXpoTZDnKKptQTnlXESA4kYX+8XA4IZkTFW205jxF7FGfTfBjBs4c84XdR7LP6PlMbs4C2L8Nl8n7spDN/7zMIFE9Q33dTnAgXh2hlVlxeMKG6zHVExRNO/mgiE9b/aEhPrRWizDoYeyKlHRXIze9bMGaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733231926; c=relaxed/simple;
	bh=+p0bNfMVStF6aL8WXNasIV9PMMgF2EisV64c7d8wmVU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GL7L2MzQRRgd1trNpZzgHwNNzBiMVsBFb12d09v2qRHyA6NA7X324Te0g4uyjfzJycOViJisCZS7Z44SR2u2IFkofVf9AN0LIAzQumF7om+9LbzCls23oVZhcYGyX7/E08v9KkWftwC4RshRQGbede6pVjAA9IrWShIsOUWEzJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dGoqR1c6; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733231925; x=1764767925;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+p0bNfMVStF6aL8WXNasIV9PMMgF2EisV64c7d8wmVU=;
  b=dGoqR1c6CMITyzntOrdQS498EEYb38pYfPpc7ncx9RBNEO6eCxVTQenq
   rocnMb9lFx4Mvm9dE8B7wbA+rtPVQErK8X5qyRwIm+UfhLBtc5dX9+q2e
   QvkWK0GX4+JMAMj90ZlG8DHAUdDozw24TdmHnLR8boFXQ1y/tE2JgpXnj
   CBRM6HVMVkm0NFQGC9YuqB1YoYLS+hgu+08RdWlAoB0bdMjzSXYMQtgJ8
   0Uqm/9OK6Ny4Cimg2tcjIAkCRoSdI5Mc22HTthvKKiYsbez4f2IdBL8oL
   6lLeLs49NckBxoQO/aZ7kexC600zHl72tHifY6ws+im5I8gP31EuJzCom
   Q==;
X-CSE-ConnectionGUID: gncE9Hi2TxyL+K3ls5OAWQ==
X-CSE-MsgGUID: 2AmzMAI1T96g0cBJmoU+wA==
X-IronPort-AV: E=McAfee;i="6700,10204,11274"; a="33500771"
X-IronPort-AV: E=Sophos;i="6.12,205,1728975600"; 
   d="scan'208";a="33500771"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 05:18:44 -0800
X-CSE-ConnectionGUID: gtAAn45iQqe1Hq0EOus1tA==
X-CSE-MsgGUID: ny+0jefCS2+n0pmnW7aeDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,205,1728975600"; 
   d="scan'208";a="130896132"
Received: from ccbilbre-mobl3.amr.corp.intel.com (HELO yungchua-desk.intel.com) ([10.124.223.75])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 05:18:43 -0800
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.dev,
	bard.liao@intel.com
Subject: [PATCH v2 11/14] soundwire: generic_bandwidth_allocation: select data lane
Date: Tue,  3 Dec 2024 21:18:10 +0800
Message-ID: <20241203131813.58454-12-yung-chuan.liao@linux.intel.com>
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

If a peripheral supports multi-lane, we can use data lane x to extend
the bandwidth. The patch suggests to select data lane x where x > 0
when bandwidth is not enough on data lane 0.

Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
---
 .../soundwire/generic_bandwidth_allocation.c  | 133 +++++++++++++++++-
 drivers/soundwire/stream.c                    |  20 ++-
 2 files changed, 146 insertions(+), 7 deletions(-)

diff --git a/drivers/soundwire/generic_bandwidth_allocation.c b/drivers/soundwire/generic_bandwidth_allocation.c
index d2632af9c8af..39b4d25ab19e 100644
--- a/drivers/soundwire/generic_bandwidth_allocation.c
+++ b/drivers/soundwire/generic_bandwidth_allocation.c
@@ -336,6 +336,82 @@ static bool is_clock_scaling_supported(struct sdw_bus *bus)
 	return true;
 }
 
+/**
+ * is_lane_connected_to_all_peripherals: Check if the given manager lane connects to all peripherals
+ * So that all peripherals can use the manager lane.
+ *
+ * @m_rt: Manager runtime
+ * @lane: Lane number
+ */
+static bool is_lane_connected_to_all_peripherals(struct sdw_master_runtime *m_rt, unsigned int lane)
+{
+	struct sdw_slave_prop *slave_prop;
+	struct sdw_slave_runtime *s_rt;
+	int i;
+
+	list_for_each_entry(s_rt, &m_rt->slave_rt_list, m_rt_node) {
+		slave_prop = &s_rt->slave->prop;
+		for (i = 1; i < SDW_MAX_LANES; i++) {
+			if (slave_prop->lane_maps[i] == lane) {
+				dev_dbg(&s_rt->slave->dev,
+					"M lane %d is connected to P lane %d\n",
+					lane, i);
+				break;
+			}
+		}
+		if (i == SDW_MAX_LANES) {
+			dev_dbg(&s_rt->slave->dev, "M lane %d is not connected\n", lane);
+			return false;
+		}
+	}
+	return true;
+}
+
+static int get_manager_lane(struct sdw_bus *bus, struct sdw_master_runtime *m_rt,
+			    struct sdw_slave_runtime *s_rt, unsigned int curr_dr_freq)
+{
+	struct sdw_slave_prop *slave_prop = &s_rt->slave->prop;
+	struct sdw_port_runtime *m_p_rt;
+	unsigned int required_bandwidth;
+	int m_lane;
+	int l;
+
+	for (l = 1; l < SDW_MAX_LANES; l++) {
+		if (!slave_prop->lane_maps[l])
+			continue;
+
+		required_bandwidth = 0;
+		list_for_each_entry(m_p_rt, &m_rt->port_list, port_node) {
+			required_bandwidth += m_rt->stream->params.rate *
+					      hweight32(m_p_rt->ch_mask) *
+					      m_rt->stream->params.bps;
+		}
+		if (required_bandwidth <=
+		    curr_dr_freq - bus->lane_used_bandwidth[l]) {
+			/* Check if m_lane is connected to all Peripherals */
+			if (!is_lane_connected_to_all_peripherals(m_rt,
+				slave_prop->lane_maps[l])) {
+				dev_dbg(bus->dev,
+					"Not all Peripherals are connected to M lane %d\n",
+					slave_prop->lane_maps[l]);
+				continue;
+			}
+			m_lane = slave_prop->lane_maps[l];
+			dev_dbg(&s_rt->slave->dev, "M lane %d is used\n", m_lane);
+			bus->lane_used_bandwidth[l] += required_bandwidth;
+			/*
+			 * Use non-zero manager lane, subtract the lane 0
+			 * bandwidth that is already calculated
+			 */
+			bus->params.bandwidth -= required_bandwidth;
+			return m_lane;
+		}
+	}
+
+	/* No available multi lane found, only lane 0 can be used */
+	return 0;
+}
+
 /**
  * sdw_compute_bus_params: Compute bus parameters
  *
@@ -343,10 +419,16 @@ static bool is_clock_scaling_supported(struct sdw_bus *bus)
  */
 static int sdw_compute_bus_params(struct sdw_bus *bus)
 {
-	unsigned int curr_dr_freq = 0;
 	struct sdw_master_prop *mstr_prop = &bus->prop;
-	int i, clk_values, ret;
+	struct sdw_slave_prop *slave_prop;
+	struct sdw_port_runtime *m_p_rt;
+	struct sdw_port_runtime *s_p_rt;
+	struct sdw_master_runtime *m_rt;
+	struct sdw_slave_runtime *s_rt;
+	unsigned int curr_dr_freq = 0;
+	int i, l, clk_values, ret;
 	bool is_gear = false;
+	int m_lane = 0;
 	u32 *clk_buf;
 
 	if (mstr_prop->num_clk_gears) {
@@ -373,11 +455,26 @@ static int sdw_compute_bus_params(struct sdw_bus *bus)
 				(bus->params.max_dr_freq >>  clk_buf[i]) :
 				clk_buf[i] * SDW_DOUBLE_RATE_FACTOR;
 
-		if (curr_dr_freq * (mstr_prop->default_col - 1) <
+		if (curr_dr_freq * (mstr_prop->default_col - 1) >=
 		    bus->params.bandwidth * mstr_prop->default_col)
-			continue;
+			break;
 
-		break;
+		list_for_each_entry(m_rt, &bus->m_rt_list, bus_node) {
+			/*
+			 * Get the first s_rt that will be used to find the available lane that
+			 * can be used. No need to check all Peripherals because we can't use
+			 * multi-lane if we can't find any available lane for the first Peripheral.
+			 */
+			s_rt = list_first_entry(&m_rt->slave_rt_list,
+						struct sdw_slave_runtime, m_rt_node);
+
+			/*
+			 * Find the available Manager lane that connected to the first Peripheral.
+			 */
+			m_lane = get_manager_lane(bus, m_rt, s_rt, curr_dr_freq);
+			if (m_lane > 0)
+				goto out;
+		}
 
 		/*
 		 * TODO: Check all the Slave(s) port(s) audio modes and find
@@ -391,6 +488,32 @@ static int sdw_compute_bus_params(struct sdw_bus *bus)
 			__func__, bus->params.bandwidth);
 		return -EINVAL;
 	}
+out:
+	/* multilane can be used */
+	if (m_lane > 0) {
+		/* Set Peripheral lanes */
+		list_for_each_entry(s_rt, &m_rt->slave_rt_list, m_rt_node) {
+			slave_prop = &s_rt->slave->prop;
+			for (l = 1; l < SDW_MAX_LANES; l++) {
+				if (slave_prop->lane_maps[l] == m_lane) {
+					list_for_each_entry(s_p_rt, &s_rt->port_list, port_node) {
+						s_p_rt->lane = l;
+						dev_dbg(&s_rt->slave->dev,
+							"Set P lane %d for port %d\n",
+							l, s_p_rt->num);
+					}
+					break;
+				}
+			}
+		}
+		/*
+		 * Set Manager lanes. Configure the last m_rt in bus->m_rt_list only since
+		 * we don't want to touch other m_rts that are already working.
+		 */
+		list_for_each_entry(m_p_rt, &m_rt->port_list, port_node) {
+			m_p_rt->lane = m_lane;
+		}
+	}
 
 	if (!mstr_prop->default_frame_rate || !mstr_prop->default_row)
 		return -EINVAL;
diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
index a4a668135d16..b0868f71b63e 100644
--- a/drivers/soundwire/stream.c
+++ b/drivers/soundwire/stream.c
@@ -1674,6 +1674,9 @@ EXPORT_SYMBOL(sdw_disable_stream);
 static int _sdw_deprepare_stream(struct sdw_stream_runtime *stream)
 {
 	struct sdw_master_runtime *m_rt;
+	struct sdw_port_runtime *p_rt;
+	unsigned int multi_lane_bandwidth;
+	unsigned int bandwidth;
 	struct sdw_bus *bus;
 	int state = stream->state;
 	int ret = 0;
@@ -1695,9 +1698,22 @@ static int _sdw_deprepare_stream(struct sdw_stream_runtime *stream)
 			return ret;
 		}
 
+		multi_lane_bandwidth = 0;
+
+		list_for_each_entry(p_rt, &m_rt->port_list, port_node) {
+			if (!p_rt->lane)
+				continue;
+
+			bandwidth = m_rt->stream->params.rate * hweight32(p_rt->ch_mask) *
+				    m_rt->stream->params.bps;
+			multi_lane_bandwidth += bandwidth;
+			bus->lane_used_bandwidth[p_rt->lane] -= bandwidth;
+			if (!bus->lane_used_bandwidth[p_rt->lane])
+				p_rt->lane = 0;
+		}
 		/* TODO: Update this during Device-Device support */
-		bus->params.bandwidth -= m_rt->stream->params.rate *
-			m_rt->ch_count * m_rt->stream->params.bps;
+		bandwidth = m_rt->stream->params.rate * m_rt->ch_count * m_rt->stream->params.bps;
+		bus->params.bandwidth -= bandwidth - multi_lane_bandwidth;
 
 		/* Compute params */
 		if (bus->compute_params) {
-- 
2.43.0


