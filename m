Return-Path: <linux-kernel+bounces-394160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C51279BAB3F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 04:26:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F7A7B22A0C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 03:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF80E1A7AF6;
	Mon,  4 Nov 2024 03:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nE4YXAnn"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60BCE18FC7C;
	Mon,  4 Nov 2024 03:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730690646; cv=none; b=YrxtDzIzSHNL9FXrqi9gv695PZ2vBbbqK3NB5oLEXc2VOESoBzOMNaUjwN7pMTcRv21W/oWKofMh3TYcNcybWQ73Vd9VpHlYNNQUUC2I0wBEosbzI9pX2cyHCNmOgDJRN3enckQWySTqnHfF+5hCaZQfFXNTMafAYJHjIqczZ+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730690646; c=relaxed/simple;
	bh=YRLDQntUqAiTAHoXLlFFneQK20cy3UtJZIMNELWRj8c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=s87ufwI5Hcxd4UiK0HNl0EdHejx9CKQuLKbK6DCYssf50We5Sp+oBOSH8D00yZRVCpBOVZnRmJgi9dQrQP6VRKqDzZvvKJHBB8GXQP5v4PZiMrb3l1FocQHq58sUTIvPwOiI+HqKUdZCwn6hyStfXTMPiQpiREWw9x4ZZyHK+7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nE4YXAnn; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730690644; x=1762226644;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YRLDQntUqAiTAHoXLlFFneQK20cy3UtJZIMNELWRj8c=;
  b=nE4YXAnnV1GuAqTcg4yM/XZRem37VoCsOGu1oI1KXsoKOuuJQQtKydlX
   nroRFaWDFtQuTrfO0c6zUMVTZUUejl2W5iBhDV3FMEjzlG/UbFEdyHr/4
   wlpxMl9pPNJkbfQvwT1tRaA9Q5pYJYpKP4DpKHhEsK0QgdXL/nIjaYKRY
   aZYu/JlyaU1AY2S6fMGN/XVL7CXzLd07yUKu/fMhMYE3dEob5sEJU3/Jv
   HVHmv6THGmTvngfG8SKuVp8N9bOEvHkCcGKZ/3iBv/z7Sn2VpK4lVxWut
   EO18KnzhZt7aItEvjbCqbr3YN5+Pq1oGqrN8OYPabp8nAMurRN+i8HgHj
   A==;
X-CSE-ConnectionGUID: XA7DEfz1R2SG+AsBE1yNUA==
X-CSE-MsgGUID: voeS5PJvRISik+yeo90qyg==
X-IronPort-AV: E=McAfee;i="6700,10204,11245"; a="30594313"
X-IronPort-AV: E=Sophos;i="6.11,256,1725346800"; 
   d="scan'208";a="30594313"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2024 19:23:57 -0800
X-CSE-ConnectionGUID: sJcKRCqbQYOlQ/3TOXqWdg==
X-CSE-MsgGUID: Zs5ymgZeQtKAw5KQxYyCvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,256,1725346800"; 
   d="scan'208";a="114331846"
Received: from yungchua-ws.ostc.intel.com (HELO yungchua-ws.intel.com) ([10.54.69.90])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2024 19:23:58 -0800
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.dev,
	bard.liao@intel.com
Subject: [PATCH 12/12] soundwire: generic_bandwidth_allocation: add lane in sdw_group_params
Date: Mon,  4 Nov 2024 03:23:58 +0000
Message-Id: <20241104032358.669705-13-yung-chuan.liao@linux.intel.com>
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
2.34.1


