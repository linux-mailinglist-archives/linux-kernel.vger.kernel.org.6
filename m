Return-Path: <linux-kernel+bounces-429532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B90899E1D6E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 14:21:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBDA21649D9
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 13:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4F7A1F756E;
	Tue,  3 Dec 2024 13:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W2byYQiC"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493D51F754A;
	Tue,  3 Dec 2024 13:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733231927; cv=none; b=uOxlloDIFN/2K3n0F0Cip+j57cqMO+TtoujGpH/qlYem5mezjSJ1ucbmU+jn0A4RIJJO0c+t/Hk0rSAOgPWDRo5v2o+SvxLmFeqk7xCTX6EqbetOAYGTUdVMBPH8wpFh+R3VI/D0wlIM9arYLcrb5SFy0FgtZVkeJUUsPqXL73Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733231927; c=relaxed/simple;
	bh=UikNoJbqbwmBIC3RSEF3Y9myZ0Uh3zNXnLBlJw80wPI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j5J39Axg4b9sThuisprg3il2xfsGG63EGq5gaOBPFpdxf54LwHbNmN5curVVRy3U+KiKey6lqa0CJzhLjVjEHW5H37rOWYCRhR3AKe68RB8xhRmVzrwbIbTviqnmHSW7GLRKKkGGoIv21ig5Cti9Ow0VaFOYO4s5so8KqOwq364=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W2byYQiC; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733231926; x=1764767926;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UikNoJbqbwmBIC3RSEF3Y9myZ0Uh3zNXnLBlJw80wPI=;
  b=W2byYQiCXvXLmpDp1I8turlOiHfr70kFtAAi1Qup/2qQBCmkLkxZilEW
   YFHBA2iyBDJDrr4mWwbyhYTIoZVNI6j9lC+yIaQcKxCEpQLLt50jcr5AJ
   6Y/YkZrqWEMvT+SXs9Ax0XtJtMEfUQOpL+Xfztd3/A1lambUmMg3+1S+3
   dy7vxDyomIF8wwb49vyh2CPxtnxD401bgOuQCnSfVbcc2en2R9P+bXDQo
   J8n7vXdO1VB8n50BZilPwuYH6m0QTbzfS/RxxlEgQr8oiIf4wWhRaqjSp
   uJIflhfnNHzW6Yhw4TfkCZFYCa6jx/ad5SkanFHP0iglS6682V0HgQtwI
   Q==;
X-CSE-ConnectionGUID: rwNpez6gRVKNI12aCYP1GQ==
X-CSE-MsgGUID: slrsao5DQpimELXWpS+DHQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11274"; a="33500778"
X-IronPort-AV: E=Sophos;i="6.12,205,1728975600"; 
   d="scan'208";a="33500778"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 05:18:46 -0800
X-CSE-ConnectionGUID: bygFS1IXTrCVjNDjxcEusQ==
X-CSE-MsgGUID: 2vN9ZNp3SCOA1D28NYBugQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,205,1728975600"; 
   d="scan'208";a="130896138"
Received: from ccbilbre-mobl3.amr.corp.intel.com (HELO yungchua-desk.intel.com) ([10.124.223.75])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 05:18:45 -0800
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.dev,
	bard.liao@intel.com
Subject: [PATCH v2 12/14] soundwire: generic_bandwidth_allocation: add lane in sdw_group_params
Date: Tue,  3 Dec 2024 21:18:11 +0800
Message-ID: <20241203131813.58454-13-yung-chuan.liao@linux.intel.com>
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

All active streams with the same parameters are grouped together and the
params are stored in the sdw_group struct. We compute the required
bandwidth for each group. However, each lane has individual bandwidth.
Therefore, we should separate different lanes in different params groups.
Add lane variable to separate params groups.

Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
---
 drivers/soundwire/bus.h                       |   1 +
 .../soundwire/generic_bandwidth_allocation.c  | 122 +++++++++++++-----
 2 files changed, 90 insertions(+), 33 deletions(-)

diff --git a/drivers/soundwire/bus.h b/drivers/soundwire/bus.h
index ff03b97f1d8b..fc990171b3f7 100644
--- a/drivers/soundwire/bus.h
+++ b/drivers/soundwire/bus.h
@@ -151,6 +151,7 @@ struct sdw_transport_data {
 	int hstop;
 	int block_offset;
 	int sub_block_offset;
+	unsigned int lane;
 };
 
 struct sdw_dpn_prop *sdw_get_slave_dpn_prop(struct sdw_slave *slave,
diff --git a/drivers/soundwire/generic_bandwidth_allocation.c b/drivers/soundwire/generic_bandwidth_allocation.c
index 39b4d25ab19e..faf04d82ba0a 100644
--- a/drivers/soundwire/generic_bandwidth_allocation.c
+++ b/drivers/soundwire/generic_bandwidth_allocation.c
@@ -18,6 +18,7 @@
 
 struct sdw_group_params {
 	unsigned int rate;
+	unsigned int lane;
 	int full_bw;
 	int payload_bw;
 	int hwidth;
@@ -27,6 +28,7 @@ struct sdw_group {
 	unsigned int count;
 	unsigned int max_size;
 	unsigned int *rates;
+	unsigned int *lanes;
 };
 
 void sdw_compute_slave_ports(struct sdw_master_runtime *m_rt,
@@ -48,6 +50,9 @@ void sdw_compute_slave_ports(struct sdw_master_runtime *m_rt,
 		slave_total_ch = 0;
 
 		list_for_each_entry(p_rt, &s_rt->port_list, port_node) {
+			if (p_rt->lane != t_data->lane)
+				continue;
+
 			ch = hweight32(p_rt->ch_mask);
 
 			sdw_fill_xport_params(&p_rt->transport_params,
@@ -105,6 +110,8 @@ static void sdw_compute_master_ports(struct sdw_master_runtime *m_rt,
 	t_data.hstart = hstart;
 
 	list_for_each_entry(p_rt, &m_rt->port_list, port_node) {
+		if (p_rt->lane != params->lane)
+			continue;
 
 		sdw_fill_xport_params(&p_rt->transport_params, p_rt->num,
 				      false, SDW_BLK_GRP_CNT_1, sample_int,
@@ -131,6 +138,7 @@ static void sdw_compute_master_ports(struct sdw_master_runtime *m_rt,
 		(*port_bo) += bps * ch;
 	}
 
+	t_data.lane = params->lane;
 	sdw_compute_slave_ports(m_rt, &t_data);
 }
 
@@ -138,69 +146,93 @@ static void _sdw_compute_port_params(struct sdw_bus *bus,
 				     struct sdw_group_params *params, int count)
 {
 	struct sdw_master_runtime *m_rt;
-	int hstop = bus->params.col - 1;
-	int port_bo, i;
+	int port_bo, i, l;
+	int hstop;
 
 	/* Run loop for all groups to compute transport parameters */
-	for (i = 0; i < count; i++) {
-		port_bo = 1;
+	for (l = 0; l < SDW_MAX_LANES; l++) {
+		if (l > 0 && !bus->lane_used_bandwidth[l])
+			continue;
+		/* reset hstop for each lane */
+		hstop = bus->params.col - 1;
+		for (i = 0; i < count; i++) {
+			if (params[i].lane != l)
+				continue;
+			port_bo = 1;
 
-		list_for_each_entry(m_rt, &bus->m_rt_list, bus_node) {
-			sdw_compute_master_ports(m_rt, &params[i], &port_bo, hstop);
+			list_for_each_entry(m_rt, &bus->m_rt_list, bus_node) {
+				sdw_compute_master_ports(m_rt, &params[i], &port_bo, hstop);
+			}
+
+			hstop = hstop - params[i].hwidth;
 		}
-
-		hstop = hstop - params[i].hwidth;
 	}
 }
 
 static int sdw_compute_group_params(struct sdw_bus *bus,
 				    struct sdw_group_params *params,
-				    int *rates, int count)
+				    struct sdw_group *group)
 {
 	struct sdw_master_runtime *m_rt;
+	struct sdw_port_runtime *p_rt;
 	int sel_col = bus->params.col;
 	unsigned int rate, bps, ch;
-	int i, column_needed = 0;
+	int i, l, column_needed;
 
 	/* Calculate bandwidth per group */
-	for (i = 0; i < count; i++) {
-		params[i].rate = rates[i];
+	for (i = 0; i < group->count; i++) {
+		params[i].rate = group->rates[i];
+		params[i].lane = group->lanes[i];
 		params[i].full_bw = bus->params.curr_dr_freq / params[i].rate;
 	}
 
 	list_for_each_entry(m_rt, &bus->m_rt_list, bus_node) {
-		rate = m_rt->stream->params.rate;
-		bps = m_rt->stream->params.bps;
-		ch = m_rt->ch_count;
+		list_for_each_entry(p_rt, &m_rt->port_list, port_node) {
+			rate = m_rt->stream->params.rate;
+			bps = m_rt->stream->params.bps;
+			ch = hweight32(p_rt->ch_mask);
 
-		for (i = 0; i < count; i++) {
-			if (rate == params[i].rate)
-				params[i].payload_bw += bps * ch;
+			for (i = 0; i < group->count; i++) {
+				if (rate == params[i].rate && p_rt->lane == params[i].lane)
+					params[i].payload_bw += bps * ch;
+			}
 		}
 	}
 
-	for (i = 0; i < count; i++) {
-		params[i].hwidth = (sel_col *
-			params[i].payload_bw + params[i].full_bw - 1) /
-			params[i].full_bw;
+	for (l = 0; l < SDW_MAX_LANES; l++) {
+		if (l > 0 && !bus->lane_used_bandwidth[l])
+			continue;
+		/* reset column_needed for each lane */
+		column_needed = 0;
+		for (i = 0; i < group->count; i++) {
+			if (params[i].lane != l)
+				continue;
 
-		column_needed += params[i].hwidth;
+			params[i].hwidth = (sel_col * params[i].payload_bw +
+					    params[i].full_bw - 1) / params[i].full_bw;
+
+			column_needed += params[i].hwidth;
+			/* There is no control column for lane 1 and above */
+			if (column_needed > sel_col)
+				return -EINVAL;
+			/* Column 0 is control column on lane 0 */
+			if (params[i].lane == 0 && column_needed > sel_col - 1)
+				return -EINVAL;
+		}
 	}
 
-	if (column_needed > sel_col - 1)
-		return -EINVAL;
 
 	return 0;
 }
 
 static int sdw_add_element_group_count(struct sdw_group *group,
-				       unsigned int rate)
+				       unsigned int rate, unsigned int lane)
 {
 	int num = group->count;
 	int i;
 
 	for (i = 0; i <= num; i++) {
-		if (rate == group->rates[i])
+		if (rate == group->rates[i] && lane == group->lanes[i])
 			break;
 
 		if (i != num)
@@ -208,6 +240,7 @@ static int sdw_add_element_group_count(struct sdw_group *group,
 
 		if (group->count >= group->max_size) {
 			unsigned int *rates;
+			unsigned int *lanes;
 
 			group->max_size += 1;
 			rates = krealloc(group->rates,
@@ -215,10 +248,20 @@ static int sdw_add_element_group_count(struct sdw_group *group,
 					 GFP_KERNEL);
 			if (!rates)
 				return -ENOMEM;
+
 			group->rates = rates;
+
+			lanes = krealloc(group->lanes,
+					 (sizeof(int) * group->max_size),
+					 GFP_KERNEL);
+			if (!lanes)
+				return -ENOMEM;
+
+			group->lanes = lanes;
 		}
 
-		group->rates[group->count++] = rate;
+		group->rates[group->count] = rate;
+		group->lanes[group->count++] = lane;
 	}
 
 	return 0;
@@ -228,6 +271,7 @@ static int sdw_get_group_count(struct sdw_bus *bus,
 			       struct sdw_group *group)
 {
 	struct sdw_master_runtime *m_rt;
+	struct sdw_port_runtime *p_rt;
 	unsigned int rate;
 	int ret = 0;
 
@@ -237,6 +281,13 @@ static int sdw_get_group_count(struct sdw_bus *bus,
 	if (!group->rates)
 		return -ENOMEM;
 
+	group->lanes = kcalloc(group->max_size, sizeof(int), GFP_KERNEL);
+	if (!group->lanes) {
+		kfree(group->rates);
+		group->rates = NULL;
+		return -ENOMEM;
+	}
+
 	list_for_each_entry(m_rt, &bus->m_rt_list, bus_node) {
 		if (m_rt->stream->state == SDW_STREAM_DEPREPARED)
 			continue;
@@ -246,11 +297,16 @@ static int sdw_get_group_count(struct sdw_bus *bus,
 					     struct sdw_master_runtime,
 					     bus_node)) {
 			group->rates[group->count++] = rate;
-
-		} else {
-			ret = sdw_add_element_group_count(group, rate);
+		}
+		/*
+		 * Different ports could use different lane, add group element
+		 * even if m_rt is the first entry
+		 */
+		list_for_each_entry(p_rt, &m_rt->port_list, port_node) {
+			ret = sdw_add_element_group_count(group, rate, p_rt->lane);
 			if (ret < 0) {
 				kfree(group->rates);
+				kfree(group->lanes);
 				return ret;
 			}
 		}
@@ -284,8 +340,7 @@ static int sdw_compute_port_params(struct sdw_bus *bus)
 	}
 
 	/* Compute transport parameters for grouped streams */
-	ret = sdw_compute_group_params(bus, params,
-				       &group.rates[0], group.count);
+	ret = sdw_compute_group_params(bus, params, &group);
 	if (ret < 0)
 		goto free_params;
 
@@ -295,6 +350,7 @@ static int sdw_compute_port_params(struct sdw_bus *bus)
 	kfree(params);
 out:
 	kfree(group.rates);
+	kfree(group.lanes);
 
 	return ret;
 }
-- 
2.43.0


