Return-Path: <linux-kernel+bounces-348663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C50A98EA26
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 09:11:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6B411F24317
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 07:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 142E11509B4;
	Thu,  3 Oct 2024 07:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gg5+XHlq"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A80014F121;
	Thu,  3 Oct 2024 07:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727939279; cv=none; b=GBcniyuFryfY2GMKU8XoN340W6WOU7pjWuqQ8BwMG/Hey4Riirsiym3CMvx+p2KMgUeEHoxJZ4n9qE/9zH7xdhmOS3FWkv9ThGJ52g4Kf0VerNo2EUFvArsARiIAKWFn+PfCUoBudwHWKuuPbShutri/zlXvvcagsTelORwJWqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727939279; c=relaxed/simple;
	bh=awf+jdv0Kcu1kulfBFzwxSCd1Qw1p3qofzbE26Kc4ow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RsK/PIrfXry9UYuzCR0o/ZPRVGFoosSZVpNAsOZM3qPk9wMGozpzEu1+YG2dFms0qwSJ250JZ1ITea6cQ6EjqCICNvrcrbVsi/tf5o05xoN/eYglmv6+dxM6hOqAo0RCChzpSyoT88ouiJ+ycVX159po5hyEg6Tw0R7W9iPyKoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gg5+XHlq; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727939279; x=1759475279;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=awf+jdv0Kcu1kulfBFzwxSCd1Qw1p3qofzbE26Kc4ow=;
  b=Gg5+XHlq+oGHgTyhwGrelREUkaFwf/XShxgDRXFrU5NPd32gN0hQKwN7
   Lpdm3tGgn3OkYZqt4flHdjy9/kAkymLaRd5f9xJZPMQUnIfWDF33waZ6b
   o/uFr7Vz/4swCkJTO74XfyVB3OTWnFLrWjkEnRp7zgQ+/GiL5Xli9gzNZ
   yRdO6w1mMktYb6SI72e7TZDzK8zPuz6xIUOFEmNsfDdtraQ6C11VTJ4Zx
   lNpE33IaWgydPJVOUlfN4SkatGk368BSuU/RIdMlFw5T4Qqbf76zY5D14
   X8bdv7itBD6CvPjMh/8lv3UXuyx9c0XOY5joreCLPD8qK3DXkwaU0aeol
   g==;
X-CSE-ConnectionGUID: 9gJYFQf5Rsm6CLb8DRKdBg==
X-CSE-MsgGUID: L44CRLEmTLSDdze+Thq4/g==
X-IronPort-AV: E=McAfee;i="6700,10204,11213"; a="27070815"
X-IronPort-AV: E=Sophos;i="6.11,173,1725346800"; 
   d="scan'208";a="27070815"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2024 00:07:58 -0700
X-CSE-ConnectionGUID: pCJTjvbVQJ+bPD/hTIr/8w==
X-CSE-MsgGUID: 9v+vI98uTTK/S/YePIIn5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,173,1725346800"; 
   d="scan'208";a="74508433"
Received: from anmitta2-mobl4.gar.corp.intel.com (HELO yungchua-desk.intel.com) ([10.247.118.10])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2024 00:07:55 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.dev,
	bard.liao@intel.com
Subject: [PATCH v2 RESEND 14/14] soundwire: mipi-disco: add support for DP0/DPn 'lane-list' property
Date: Thu,  3 Oct 2024 15:06:50 +0800
Message-ID: <20241003070650.62787-15-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241003070650.62787-1-yung-chuan.liao@linux.intel.com>
References: <20241003070650.62787-1-yung-chuan.liao@linux.intel.com>
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


