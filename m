Return-Path: <linux-kernel+bounces-536107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BCB5A47B8E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 12:13:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3308B1891324
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 11:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6E6022D4CE;
	Thu, 27 Feb 2025 11:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KdO7qAoI"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05A022D78C;
	Thu, 27 Feb 2025 11:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740654716; cv=none; b=bA79KSbM0iRt7vpUxqX3GRt0IwshSyShVK/GgTQX4blMeZtBkDffO++2S82pe9lT5TXonMcRY7ZxwcLWYEAdsBzZUHlFt10UK8Wk1PTqMvUdYLKH6J9WL8Lmef3VBWTZ9NmTWvkmQgvbMctIUW8gdKA57e+XJu4uwJER8xTtIys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740654716; c=relaxed/simple;
	bh=JK1yMA7VJubWDxuqWmhCVh+t7kO2de2uXAdIsMJi17c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nFazix0jZczOnQqvUcIUcpwel/70rqMW2yBfjjOLONCXHcUFbsv8Ddt/NqAMB+T3SMVbraGMktsx8Vg0jLXA1yXr9q9nb2qmE5d15fiKp4lFIVeD9QhIUa96YTb8EnVK42oWKyoTbf93YU3Lmup48KYtkzJqGaOIaZq6BWRT6iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KdO7qAoI; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740654715; x=1772190715;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JK1yMA7VJubWDxuqWmhCVh+t7kO2de2uXAdIsMJi17c=;
  b=KdO7qAoIZS2v06NPh/TALQuAAYrXECZQ7a1qLHmLHs/RXX4aazFFQ/wf
   kB5lenSqpRVp5dRbIVhzHALx2GXFQ2XjeF6SNnyvw3dB+OmVcORkLNwBJ
   MhSoSUnz/esx+NgQ8pkHBKif7nPMItyQs+3YyhBLJabz5vSLYtUjcUjBr
   bnG3EBH+oi+yvsroIzwitWdEPF26PkcSgEqfIG4aDu58RNAlQoCJD+dBl
   yNnnlRamROnVO8DPbt7PenkCMY2L8kQZ4X9v0p6NDdLQWCqitKpss84jB
   7TuJO0HUrg+pEbmBzsMcJ1QsTlvbzSfmvn8zWg0K2FdAk9/BPfii4F9do
   w==;
X-CSE-ConnectionGUID: ZLaV0OYwRs2IQRS5sFh1dg==
X-CSE-MsgGUID: IzCQjViZSMe9ajDy0g0N3g==
X-IronPort-AV: E=McAfee;i="6700,10204,11357"; a="45189829"
X-IronPort-AV: E=Sophos;i="6.13,319,1732608000"; 
   d="scan'208";a="45189829"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 03:11:54 -0800
X-CSE-ConnectionGUID: nvUeJB8iQ7ORZ5UnbrmaTw==
X-CSE-MsgGUID: LBl34QNRT7GZ7Lp/u6d/aA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="154178978"
Received: from johunt-mobl9.ger.corp.intel.com (HELO yungchua-desk.intel.com) ([10.124.220.110])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 03:11:52 -0800
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	broonie@kernel.org,
	tiwai@suse.de,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.dev,
	bard.liao@intel.com
Subject: [PATCH v3 06/16] soundwire: stream: reuse existing code for BPT stream
Date: Thu, 27 Feb 2025 19:11:19 +0800
Message-ID: <20250227111130.272698-7-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250227111130.272698-1-yung-chuan.liao@linux.intel.com>
References: <20250227111130.272698-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>

DP0 (Data Port 0) is very similar to regular data ports, with minor
tweaks we can reuse the same code.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Liam Girdwood <liam.r.girdwood@intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
---
 drivers/soundwire/stream.c | 104 ++++++++++++++++++++++++++-----------
 1 file changed, 73 insertions(+), 31 deletions(-)

diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
index ae6d1c767ab9..d29d85d809c8 100644
--- a/drivers/soundwire/stream.c
+++ b/drivers/soundwire/stream.c
@@ -88,11 +88,14 @@ static int _sdw_program_slave_port_params(struct sdw_bus *bus,
 		return ret;
 	}
 
-	/* Program DPN_BlockCtrl3 register */
-	ret = sdw_write_no_pm(slave, addr2, t_params->blk_pkg_mode);
-	if (ret < 0) {
-		dev_err(bus->dev, "DPN_BlockCtrl3 register write failed\n");
-		return ret;
+	/* DP0 does not implement BlockCtrl3 */
+	if (t_params->port_num) {
+		/* Program DPN_BlockCtrl3 register */
+		ret = sdw_write_no_pm(slave, addr2, t_params->blk_pkg_mode);
+		if (ret < 0) {
+			dev_err(bus->dev, "DPN_BlockCtrl3 register write failed\n");
+			return ret;
+		}
 	}
 
 	/*
@@ -131,18 +134,28 @@ static int sdw_program_slave_port_params(struct sdw_bus *bus,
 	struct sdw_port_params *p_params = &p_rt->port_params;
 	struct sdw_slave_prop *slave_prop = &s_rt->slave->prop;
 	u32 addr1, addr2, addr3, addr4, addr5, addr6;
-	struct sdw_dpn_prop *dpn_prop;
+	enum sdw_dpn_type port_type;
+	bool read_only_wordlength;
 	int ret;
 	u8 wbuf;
 
 	if (s_rt->slave->is_mockup_device)
 		return 0;
 
-	dpn_prop = sdw_get_slave_dpn_prop(s_rt->slave,
-					  s_rt->direction,
-					  t_params->port_num);
-	if (!dpn_prop)
-		return -EINVAL;
+	if (t_params->port_num) {
+		struct sdw_dpn_prop *dpn_prop;
+
+		dpn_prop = sdw_get_slave_dpn_prop(s_rt->slave, s_rt->direction,
+						  t_params->port_num);
+		if (!dpn_prop)
+			return -EINVAL;
+
+		read_only_wordlength = dpn_prop->read_only_wordlength;
+		port_type = dpn_prop->type;
+	} else {
+		read_only_wordlength = false;
+		port_type = SDW_DPN_FULL;
+	}
 
 	addr1 = SDW_DPN_PORTCTRL(t_params->port_num);
 	addr2 = SDW_DPN_BLOCKCTRL1(t_params->port_num);
@@ -172,7 +185,7 @@ static int sdw_program_slave_port_params(struct sdw_bus *bus,
 		return ret;
 	}
 
-	if (!dpn_prop->read_only_wordlength) {
+	if (!read_only_wordlength) {
 		/* Program DPN_BlockCtrl1 register */
 		ret = sdw_write_no_pm(s_rt->slave, addr2, (p_params->bps - 1));
 		if (ret < 0) {
@@ -224,9 +237,9 @@ static int sdw_program_slave_port_params(struct sdw_bus *bus,
 		}
 	}
 
-	if (dpn_prop->type != SDW_DPN_SIMPLE) {
+	if (port_type != SDW_DPN_SIMPLE) {
 		ret = _sdw_program_slave_port_params(bus, s_rt->slave,
-						     t_params, dpn_prop->type);
+						     t_params, port_type);
 		if (ret < 0)
 			dev_err(&s_rt->slave->dev,
 				"Transport reg write failed for port: %d\n",
@@ -433,6 +446,9 @@ static int sdw_prep_deprep_slave_ports(struct sdw_bus *bus,
 	struct completion *port_ready;
 	struct sdw_dpn_prop *dpn_prop;
 	struct sdw_prepare_ch prep_ch;
+	u32 imp_def_interrupts;
+	bool simple_ch_prep_sm;
+	u32 ch_prep_timeout;
 	bool intr = false;
 	int ret = 0, val;
 	u32 addr;
@@ -440,20 +456,35 @@ static int sdw_prep_deprep_slave_ports(struct sdw_bus *bus,
 	prep_ch.num = p_rt->num;
 	prep_ch.ch_mask = p_rt->ch_mask;
 
-	dpn_prop = sdw_get_slave_dpn_prop(s_rt->slave,
-					  s_rt->direction,
-					  prep_ch.num);
-	if (!dpn_prop) {
-		dev_err(bus->dev,
-			"Slave Port:%d properties not found\n", prep_ch.num);
-		return -EINVAL;
+	if (p_rt->num) {
+		dpn_prop = sdw_get_slave_dpn_prop(s_rt->slave, s_rt->direction, prep_ch.num);
+		if (!dpn_prop) {
+			dev_err(bus->dev,
+				"Slave Port:%d properties not found\n", prep_ch.num);
+			return -EINVAL;
+		}
+
+		imp_def_interrupts = dpn_prop->imp_def_interrupts;
+		simple_ch_prep_sm = dpn_prop->simple_ch_prep_sm;
+		ch_prep_timeout = dpn_prop->ch_prep_timeout;
+	} else {
+		struct sdw_dp0_prop *dp0_prop = s_rt->slave->prop.dp0_prop;
+
+		if (!dp0_prop) {
+			dev_err(bus->dev,
+				"Slave DP0 properties not found\n");
+			return -EINVAL;
+		}
+		imp_def_interrupts = dp0_prop->imp_def_interrupts;
+		simple_ch_prep_sm =  dp0_prop->simple_ch_prep_sm;
+		ch_prep_timeout = dp0_prop->ch_prep_timeout;
 	}
 
 	prep_ch.prepare = prep;
 
 	prep_ch.bank = bus->params.next_bank;
 
-	if (dpn_prop->imp_def_interrupts || !dpn_prop->simple_ch_prep_sm ||
+	if (imp_def_interrupts || !simple_ch_prep_sm ||
 	    bus->params.s_data_mode != SDW_PORT_DATA_MODE_NORMAL)
 		intr = true;
 
@@ -464,7 +495,7 @@ static int sdw_prep_deprep_slave_ports(struct sdw_bus *bus,
 	 */
 	if (prep && intr) {
 		ret = sdw_configure_dpn_intr(s_rt->slave, p_rt->num, prep,
-					     dpn_prop->imp_def_interrupts);
+					     imp_def_interrupts);
 		if (ret < 0)
 			return ret;
 	}
@@ -473,7 +504,7 @@ static int sdw_prep_deprep_slave_ports(struct sdw_bus *bus,
 	sdw_do_port_prep(s_rt, prep_ch, prep ? SDW_OPS_PORT_PRE_PREP : SDW_OPS_PORT_PRE_DEPREP);
 
 	/* Prepare Slave port implementing CP_SM */
-	if (!dpn_prop->simple_ch_prep_sm) {
+	if (!simple_ch_prep_sm) {
 		addr = SDW_DPN_PREPARECTRL(p_rt->num);
 
 		if (prep)
@@ -490,7 +521,7 @@ static int sdw_prep_deprep_slave_ports(struct sdw_bus *bus,
 		/* Wait for completion on port ready */
 		port_ready = &s_rt->slave->port_ready[prep_ch.num];
 		wait_for_completion_timeout(port_ready,
-			msecs_to_jiffies(dpn_prop->ch_prep_timeout));
+			msecs_to_jiffies(ch_prep_timeout));
 
 		val = sdw_read_no_pm(s_rt->slave, SDW_DPN_PREPARESTATUS(p_rt->num));
 		if ((val < 0) || (val & p_rt->ch_mask)) {
@@ -507,7 +538,7 @@ static int sdw_prep_deprep_slave_ports(struct sdw_bus *bus,
 	/* Disable interrupt after Port de-prepare */
 	if (!prep && intr)
 		ret = sdw_configure_dpn_intr(s_rt->slave, p_rt->num, prep,
-					     dpn_prop->imp_def_interrupts);
+					     imp_def_interrupts);
 
 	return ret;
 }
@@ -1008,7 +1039,8 @@ static int sdw_slave_port_is_valid_range(struct device *dev, int num)
 
 static int sdw_slave_port_config(struct sdw_slave *slave,
 				 struct sdw_slave_runtime *s_rt,
-				 const struct sdw_port_config *port_config)
+				 const struct sdw_port_config *port_config,
+				 bool is_bpt_stream)
 {
 	struct sdw_port_runtime *p_rt;
 	int ret;
@@ -1020,9 +1052,13 @@ static int sdw_slave_port_config(struct sdw_slave *slave,
 		 * TODO: Check valid port range as defined by DisCo/
 		 * slave
 		 */
-		ret = sdw_slave_port_is_valid_range(&slave->dev, port_config[i].num);
-		if (ret < 0)
-			return ret;
+		if (!is_bpt_stream) {
+			ret = sdw_slave_port_is_valid_range(&slave->dev, port_config[i].num);
+			if (ret < 0)
+				return ret;
+		} else if (port_config[i].num) {
+			return -EINVAL;
+		}
 
 		ret = sdw_port_config(p_rt, port_config, i);
 		if (ret < 0)
@@ -1331,6 +1367,11 @@ struct sdw_dpn_prop *sdw_get_slave_dpn_prop(struct sdw_slave *slave,
 	u8 num_ports;
 	int i;
 
+	if (!port_num) {
+		dev_err(&slave->dev, "%s: port_num is zero\n", __func__);
+		return NULL;
+	}
+
 	if (direction == SDW_DATA_DIR_TX) {
 		num_ports = hweight32(slave->prop.source_ports);
 		dpn_prop = slave->prop.src_dpn_prop;
@@ -2116,7 +2157,8 @@ int sdw_stream_add_slave(struct sdw_slave *slave,
 	if (ret)
 		goto unlock;
 
-	ret = sdw_slave_port_config(slave, s_rt, port_config);
+	ret = sdw_slave_port_config(slave, s_rt, port_config,
+				    stream->type == SDW_STREAM_BPT);
 	if (ret)
 		goto unlock;
 
-- 
2.43.0


