Return-Path: <linux-kernel+bounces-324832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A34D975160
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 14:02:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD30D1C20E6F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 12:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 470B11A265D;
	Wed, 11 Sep 2024 11:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n4GN0MF1"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449AA1A262F;
	Wed, 11 Sep 2024 11:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726055978; cv=none; b=E0cAD1BdE82z+4xUS5YxOpKAUEE066YAjXWp4eQDqE8prjKODj6r2rLNEKVpTnDerWQcvQFdj4f5fAf9NWeja27OtK9lJFAEmGWFxnRSU4fCV/TO9itXQD7+oThjJhLOHif5bmzizURXC0aUaOkAJDoPD4UKo+KIU91riwoofFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726055978; c=relaxed/simple;
	bh=awf+jdv0Kcu1kulfBFzwxSCd1Qw1p3qofzbE26Kc4ow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wh40LDb+POHmarTXO9vTepHiFReF/ixFD9G2XkeBshylnoaOA6h/ZXVd8UK8dnvv2yUuUI3Ges4g0jdzNmDOJK29lceZUNP7MzDNjV7kO26XhEYgOa7jW433YbnIJNMAKVhclmEwoUOuBEuSoE9lo0KWAofyI0WyIa33aROsD+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n4GN0MF1; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726055977; x=1757591977;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=awf+jdv0Kcu1kulfBFzwxSCd1Qw1p3qofzbE26Kc4ow=;
  b=n4GN0MF193fDGqbCGJ8XkrojmcMBvbqFgDfxLD+yII5c2ZhaA4IRLAa0
   TcHuYCifUObUDw6zPqa57DxHMEGQoXem2iSZ0WJvVX3aWbz99PmClFW+E
   w9F+IMOi3YOzkIy+3nXLahAkmjufC03xfCJtPkxBQ8f+TZdWwYmh7yz/v
   tsFYRVDQU9QofsX1sl/sxYYshRURa6zyiR8CFmG7EadGVDG+lmRT1XhKW
   N6TqI7FvzhaYWL9q113xidyz1JpkWfRe8MSZScbbXO1HvQEvS7Iql6JjM
   pYl4NCQJ/+k2bYqfjLLBV5LHW14lwkPvzn2BaIuZUcYuMR0mALhCxSVVU
   w==;
X-CSE-ConnectionGUID: +dXxeMdkRgy/pTvWQNScVg==
X-CSE-MsgGUID: v1iBdf88QhiR5d8Oq7IThg==
X-IronPort-AV: E=McAfee;i="6700,10204,11191"; a="35417287"
X-IronPort-AV: E=Sophos;i="6.10,219,1719903600"; 
   d="scan'208";a="35417287"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2024 04:59:37 -0700
X-CSE-ConnectionGUID: PzjPFISkQge9sGjrLk5HYQ==
X-CSE-MsgGUID: 15xmwU5mQNi7PFMgEa+LKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,219,1719903600"; 
   d="scan'208";a="67292833"
Received: from bvivekan-mobl2.gar.corp.intel.com (HELO yungchua-desk.intel.com) ([10.247.118.254])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2024 04:59:35 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.intel.com,
	bard.liao@intel.com
Subject: [PATCH v2 14/14] soundwire: mipi-disco: add support for DP0/DPn 'lane-list' property
Date: Wed, 11 Sep 2024 19:58:27 +0800
Message-ID: <20240911115827.233171-15-yung-chuan.liao@linux.intel.com>
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
index 36e734751225..9d59f486edbe 100644
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


