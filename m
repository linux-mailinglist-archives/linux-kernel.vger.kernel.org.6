Return-Path: <linux-kernel+bounces-303387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5A70960B67
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 15:11:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D315285F3C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 13:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E281C6889;
	Tue, 27 Aug 2024 13:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BzcnpWlq"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE461C57AC;
	Tue, 27 Aug 2024 13:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724764111; cv=none; b=hVaZw50z3zUYOzy5WTjmxvTfn2FMaqLcwyScU+/wGTRGfg+8bHV1kAUG3efPrNGMIA+vcPbzV44O2U3Foc+tSfpwAicc4a7fKeFnJaOTMotHALke39yXAorHQjPJqrXxMv2Oa2/p63BBmECjJTJimUDWq6bu9r6HW+nQn9hHmPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724764111; c=relaxed/simple;
	bh=eSJuvZ4Q+njTExXsTZ7XIOuYEEP6S/r8p97JVTQ9T/c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i9CLi4JHFatwGFlmhlzpQuHuHdB6VdCSrFuA23TmfnB/44ShfztaIYKs2xakHN3YueR+Qpmd1RHm8fA6TOa3drMlCVL7uxSDu8JzK5qFnOqLT6dgDyB78YKZezCuq+LP/DUXwgQeYFTgotE0KXxwqmdFgQAyLq0gMPLfR6JztPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BzcnpWlq; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724764109; x=1756300109;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eSJuvZ4Q+njTExXsTZ7XIOuYEEP6S/r8p97JVTQ9T/c=;
  b=BzcnpWlqwCGTp2bGVBf+JrvGDh2Cyl0Ku29rUg+992WGdwh1RPsmLnlj
   EJacq67igJF7avRm6oLPCqawgE5vIcd5am46QSDn5+HGQEMtswo0nQhR6
   F1BUiGJE1EgJzW18nZaTusvBn5v6vPIBTzLQenSnTiOPMKbJxqiRN22jP
   QyUwP5faZcmTBTqFNWgKG/63alGjK7cuThp7+RFdHTYVIPln2oU98R+mi
   YZPEdimkn/k/LZhH/RcZqvMmtPTCYUhp3cCmPWYPlJ9lQRpDcHYq35ogX
   GDO5fHkJrIsmz0mY890MKQi946Ui4QkeoIKJzqn2xjLzJwiB84wtb5iOO
   w==;
X-CSE-ConnectionGUID: mDzeN8TeTFqy+v/3Ji4yzQ==
X-CSE-MsgGUID: kVwqhwI3Sp2p3YQSjZY9hQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11176"; a="23400661"
X-IronPort-AV: E=Sophos;i="6.10,180,1719903600"; 
   d="scan'208";a="23400661"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 06:08:29 -0700
X-CSE-ConnectionGUID: qyz7k+CiT7efcD87cWMQdw==
X-CSE-MsgGUID: V+IjgattRnem//1MWGS9uw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,180,1719903600"; 
   d="scan'208";a="67552168"
Received: from anmitta2-mobl4.gar.corp.intel.com (HELO yungchua-desk.intel.com) ([10.247.118.39])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 06:08:27 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.intel.com,
	bard.liao@intel.com
Subject: [PATCH 14/14] soundwire: mipi-disco: add support for DP0/DPn 'lane-list' property
Date: Tue, 27 Aug 2024 21:07:07 +0800
Message-ID: <20240827130707.298477-15-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240827130707.298477-1-yung-chuan.liao@linux.intel.com>
References: <20240827130707.298477-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

The SoundWire specification did not clearly require that ports could
use all Lanes. Some SoundWire/SDCA peripheral adopters added
restrictions on which lanes can be used by what port, and the DisCo
for SoundWire 2.1 specification added a 'lane-list' property to model
this hardware limitation.

When not specified, the ports can use all Lanes. Otherwise, the
'lane-list' indicates which Lanes can be used, sorted by order of
preference (most-preferred-first).

This patch only reads the properties, the use of this property will
come at a later time with multi-lane support.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/mipi_disco.c | 32 ++++++++++++++++++++++++++++++++
 include/linux/soundwire/sdw.h  |  8 ++++++++
 2 files changed, 40 insertions(+)

diff --git a/drivers/soundwire/mipi_disco.c b/drivers/soundwire/mipi_disco.c
index 2215c53f95de..23c1a413598c 100644
--- a/drivers/soundwire/mipi_disco.c
+++ b/drivers/soundwire/mipi_disco.c
@@ -197,6 +197,22 @@ static int sdw_slave_read_dp0(struct sdw_slave *slave,
 	dp0->imp_def_interrupts = mipi_fwnode_property_read_bool(port,
 				"mipi-sdw-imp-def-dp0-interrupts-supported");
 
+	nval = fwnode_property_count_u32(port, "mipi-sdw-lane-list");
+	if (nval > 0) {
+		dp0->num_lanes = nval;
+		dp0->lane_list = devm_kcalloc(&slave->dev,
+					      dp0->num_lanes, sizeof(*dp0->lane_list),
+					      GFP_KERNEL);
+		if (!dp0->lane_list)
+			return -ENOMEM;
+
+		ret = fwnode_property_read_u32_array(port,
+					       "mipi-sdw-lane-list",
+					       dp0->lane_list, dp0->num_lanes);
+		if (ret < 0)
+			return ret;
+	}
+
 	return 0;
 }
 
@@ -326,6 +342,22 @@ static int sdw_slave_read_dpn(struct sdw_slave *slave,
 		fwnode_property_read_u32(node, "mipi-sdw-port-encoding-type",
 					 &dpn[i].port_encoding);
 
+		nval = fwnode_property_count_u32(node, "mipi-sdw-lane-list");
+		if (nval > 0) {
+			dpn[i].num_lanes = nval;
+			dpn[i].lane_list = devm_kcalloc(&slave->dev,
+							dpn[i].num_lanes, sizeof(*dpn[i].lane_list),
+							GFP_KERNEL);
+			if (!dpn[i].lane_list)
+				return -ENOMEM;
+
+			ret = fwnode_property_read_u32_array(node,
+						       "mipi-sdw-lane-list",
+						       dpn[i].lane_list, dpn[i].num_lanes);
+			if (ret < 0)
+				return ret;
+		}
+
 		fwnode_handle_put(node);
 
 		i++;
diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
index 952514f044f0..73f655334fe9 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -238,6 +238,8 @@ enum sdw_clk_stop_mode {
  * @simple_ch_prep_sm: If channel prepare sequence is required
  * @imp_def_interrupts: If set, each bit corresponds to support for
  * implementation-defined interrupts
+ * @num_lanes: array size of @lane_list
+ * @lane_list: indicates which Lanes can be used by DP0
  *
  * The wordlengths are specified by Spec as max, min AND number of
  * discrete values, implementation can define based on the wordlengths they
@@ -252,6 +254,8 @@ struct sdw_dp0_prop {
 	bool BRA_flow_controlled;
 	bool simple_ch_prep_sm;
 	bool imp_def_interrupts;
+	int num_lanes;
+	u32 *lane_list;
 };
 
 /**
@@ -275,6 +279,8 @@ struct sdw_dp0_prop {
  * @num_ch_combinations: Number of channel combinations supported
  * @channels: Discrete channels supported
  * @ch_combinations: Channel combinations supported
+ * @lane_list: indicates which Lanes can be used by DPn
+ * @num_lanes: array size of @lane_list
  * @modes: SDW mode supported
  * @max_async_buffer: Number of samples that this port can buffer in
  * asynchronous modes
@@ -300,6 +306,8 @@ struct sdw_dpn_prop {
 	u32 num_ch_combinations;
 	u32 *channels;
 	u32 *ch_combinations;
+	u32 *lane_list;
+	int num_lanes;
 	u32 modes;
 	u32 max_async_buffer;
 	u32 port_encoding;
-- 
2.43.0


