Return-Path: <linux-kernel+bounces-528270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A303BA415A2
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 07:46:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E66983B41DF
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 06:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B41382417C2;
	Mon, 24 Feb 2025 06:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="StHSMC3B"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A4E24168B;
	Mon, 24 Feb 2025 06:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740379528; cv=none; b=TnCs5kqC0KaF/6/LPDqM8ToHH64sTnPBT/tdpGQ2r+WURn2luhhU9VMFY3CJvasba+vTWpHic45jP3nzFEsPTRw/zITz5sRh6FC0MqvDRWuycEN0u+UsdI4iLNG4M2mAo4g+hG+9wkjjvTz/4m4DFb6nA6XF7tNg14KJdOzWWec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740379528; c=relaxed/simple;
	bh=rgmme76n2CzNqkUCcP3NAi7yfETqH2iSYt1NYJV6DOg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lNPFmaB9x+m91ue8QAUtQvw1Leg7ybisQ1Fu/qwp9odlKvtlaDlNPw76ZjAPhEz1Ic/6t/U0D14/sD0kUDTKoIgUHGgx5TdkTN0BR0Uust3iM15ejxkGP9fVQDE0IY3qrLuCsbteHurxeejwk17cXNTY2eERPGGqlzRfoXbPOZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=StHSMC3B; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740379526; x=1771915526;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rgmme76n2CzNqkUCcP3NAi7yfETqH2iSYt1NYJV6DOg=;
  b=StHSMC3BgLN13KDkGU81Q+XjRUTQo1GMET/nm++ajbjQo0JkLHvIMfV/
   hVTz+sLhg3qmXyWdYuHY2LIseYAYP7NKRBPPlrMLCGvtUdQmCtKvQ+6Zv
   g+XanLwaYpHASdktZa1MvqQWA4OR9Pu2KLFdGxxG/qyYkGMUf8jFGOI/D
   q74AoLIGw03B9q7fHEsD4vNSVuDO+c4mW+a0v6WKpGt1XeYR4FppoFQWM
   QVFSMs0iVgkf0YTmF37nkYhAPC0zdU63hgNhLVrK1rP46IIfLjVHHzr9d
   OVlVRFvqE+RLRkrVghKESTloFXSKovqNeniFGtqgrkfg6nqawge+5VfTN
   A==;
X-CSE-ConnectionGUID: Vw1NZzNQTEKvM2Ol8Ri9HA==
X-CSE-MsgGUID: UrV1tmlXQgKhfWq/TDIyZQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11354"; a="58538940"
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="58538940"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2025 22:45:25 -0800
X-CSE-ConnectionGUID: 2szbtAc2S9ulVctjVJQcQQ==
X-CSE-MsgGUID: zBip0YqjSi2wjhRzo7q1Nw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="120597696"
Received: from ssimmeri-mobl2.amr.corp.intel.com (HELO yungchua-desk.intel.com) ([10.124.222.232])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2025 22:45:23 -0800
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	broonie@kernel.org,
	tiwai@suse.de,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.dev,
	bard.liao@intel.com
Subject: [PATCH v2 05/16] soundwire: stream: special-case the bus compute_params() routine
Date: Mon, 24 Feb 2025 14:44:39 +0800
Message-ID: <20250224064451.33772-6-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250224064451.33772-1-yung-chuan.liao@linux.intel.com>
References: <20250224064451.33772-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>

For BPT support, we want to allocate the entire audio payload and
bypass the allocation based on PCM/PDM parameters.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Liam Girdwood <liam.r.girdwood@intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
---
 .../soundwire/generic_bandwidth_allocation.c  | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/drivers/soundwire/generic_bandwidth_allocation.c b/drivers/soundwire/generic_bandwidth_allocation.c
index 59965f43c2fb..b646c2ffe84a 100644
--- a/drivers/soundwire/generic_bandwidth_allocation.c
+++ b/drivers/soundwire/generic_bandwidth_allocation.c
@@ -86,6 +86,49 @@ void sdw_compute_slave_ports(struct sdw_master_runtime *m_rt,
 }
 EXPORT_SYMBOL(sdw_compute_slave_ports);
 
+static void sdw_compute_dp0_slave_ports(struct sdw_master_runtime *m_rt)
+{
+	struct sdw_bus *bus = m_rt->bus;
+	struct sdw_slave_runtime *s_rt;
+	struct sdw_port_runtime *p_rt;
+
+	list_for_each_entry(s_rt, &m_rt->slave_rt_list, m_rt_node) {
+		list_for_each_entry(p_rt, &s_rt->port_list, port_node) {
+			sdw_fill_xport_params(&p_rt->transport_params, p_rt->num, false,
+					      SDW_BLK_GRP_CNT_1, bus->params.col, 0, 0, 1,
+					      bus->params.col - 1, SDW_BLK_PKG_PER_PORT, 0x0);
+
+			sdw_fill_port_params(&p_rt->port_params, p_rt->num, bus->params.col - 1,
+					     SDW_PORT_FLOW_MODE_ISOCH, SDW_PORT_DATA_MODE_NORMAL);
+		}
+	}
+}
+
+static void sdw_compute_dp0_master_ports(struct sdw_master_runtime *m_rt)
+{
+	struct sdw_port_runtime *p_rt;
+	struct sdw_bus *bus = m_rt->bus;
+
+	list_for_each_entry(p_rt, &m_rt->port_list, port_node) {
+		sdw_fill_xport_params(&p_rt->transport_params, p_rt->num, false,
+				      SDW_BLK_GRP_CNT_1, bus->params.col, 0, 0, 1,
+				      bus->params.col - 1, SDW_BLK_PKG_PER_PORT, 0x0);
+
+		sdw_fill_port_params(&p_rt->port_params, p_rt->num, bus->params.col - 1,
+				     SDW_PORT_FLOW_MODE_ISOCH, SDW_PORT_DATA_MODE_NORMAL);
+	}
+}
+
+static void sdw_compute_dp0_port_params(struct sdw_bus *bus)
+{
+	struct sdw_master_runtime *m_rt;
+
+	list_for_each_entry(m_rt, &bus->m_rt_list, bus_node) {
+		sdw_compute_dp0_master_ports(m_rt);
+		sdw_compute_dp0_slave_ports(m_rt);
+	}
+}
+
 static void sdw_compute_master_ports(struct sdw_master_runtime *m_rt,
 				     struct sdw_group_params *params,
 				     int *port_bo, int hstop)
@@ -618,6 +661,11 @@ int sdw_compute_params(struct sdw_bus *bus, struct sdw_stream_runtime *stream)
 	if (ret < 0)
 		return ret;
 
+	if (stream->type == SDW_STREAM_BPT) {
+		sdw_compute_dp0_port_params(bus);
+		return 0;
+	}
+
 	/* Compute transport and port params */
 	ret = sdw_compute_port_params(bus, stream);
 	if (ret < 0) {
-- 
2.43.0


