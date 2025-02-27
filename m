Return-Path: <linux-kernel+bounces-536521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D3F7A4812A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 15:28:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CA70421053
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 14:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 720B7239585;
	Thu, 27 Feb 2025 14:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g7kg2cyd"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D62F237702;
	Thu, 27 Feb 2025 14:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740665222; cv=none; b=EL8KnmcwxIULiHPvN6jIbySyW11K5LJ72pwtugqX7fE6yBpFtBiaZl2FORguqDqAuFXPUQQPWucD4BUeJibkGoRIy0PTkZ8PztLGWYlGuulV250mfZlLN7RBtpAfXn4A0k2rt6+rJGT/jjiFYqI/J/eArRzJ3qZ7JBOocH2GyYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740665222; c=relaxed/simple;
	bh=rgmme76n2CzNqkUCcP3NAi7yfETqH2iSYt1NYJV6DOg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BzYccWKD7vCrgcNLA1UjcsGLgBobQo+8l1V3yf3I+XT66fn8VKKWVfNTelyVDC/Fy3zfLEW4DAJTxnwPgSumBYGO2Rbx8kRBUMHlxRvPsmWzcAxZxUFB9kGp1n4KCd2I1ZJUBuhyQoUZCGV0xn/Rs6cxiGD9p1WA9r9oJpQh2Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g7kg2cyd; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740665221; x=1772201221;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rgmme76n2CzNqkUCcP3NAi7yfETqH2iSYt1NYJV6DOg=;
  b=g7kg2cydlCUJZyv5L1JWyKZQR/i4XHZ5sIrqrRwt8iFIIFjbFsy+WCpl
   mn3SKPuu4hwUseo+xG8FUpmO8MHIw7zrfOIRw4LfMaIPCl0H3bvTEw1h/
   kyxvQVmdmVMIYuZveNHwTSjGULBzHdhJGzoUFES5l3iIkMCHHzdzx7xf2
   ayQSTsk6pGn4AfL3yTCFyQHXiLFqaNCJJRVGQy2xDH5PUB9F0vYyWKh5n
   6A3soInv13+rKCK5D8inkbX7AH5K/s9IxQYk9Hw5hkT7gUoK9WA2PaT6o
   jvNUbUZrmsSH27EVf6EOMYxZZxe4NAmUn5CNsOVv0t+me05eEXBeuiHBb
   w==;
X-CSE-ConnectionGUID: L0nyWhJTSIyPxYjZiSJWgw==
X-CSE-MsgGUID: PawAcqiARAW+Zk4t/FlD8Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="41438024"
X-IronPort-AV: E=Sophos;i="6.13,319,1732608000"; 
   d="scan'208";a="41438024"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 06:06:39 -0800
X-CSE-ConnectionGUID: Nee4A5WoSDSJOHq229xGlw==
X-CSE-MsgGUID: hE5kAfS5Qc6XLHwvruSfog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,319,1732608000"; 
   d="scan'208";a="116831578"
Received: from ssimmeri-mobl2.amr.corp.intel.com (HELO yungchua-desk.intel.com) ([10.124.220.154])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 06:06:36 -0800
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	broonie@kernel.org,
	tiwai@suse.de,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.dev,
	bard.liao@intel.com
Subject: [PATCH v4 05/16] soundwire: stream: special-case the bus compute_params() routine
Date: Thu, 27 Feb 2025 22:06:04 +0800
Message-ID: <20250227140615.8147-6-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250227140615.8147-1-yung-chuan.liao@linux.intel.com>
References: <20250227140615.8147-1-yung-chuan.liao@linux.intel.com>
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


