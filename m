Return-Path: <linux-kernel+bounces-536106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E06B5A47B8F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 12:13:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DA007A65A9
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 11:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E11C22B8D2;
	Thu, 27 Feb 2025 11:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d40Fss9z"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8814722D4CE;
	Thu, 27 Feb 2025 11:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740654714; cv=none; b=UVlI6aDvqgZYfrPSSu1BoHYAa6VVoRYUu55HadZUrNr19S9glaiufjd+DJO10w02L1kpTbUcQkbfwjyTBKawj7tW5XtB9HZRJGmyDO6TkyuK8sP1XCNqx3kDrJgnKZ+dTmadGw6cbGQsvnSDQbgJA2pQJ+3Z8+yN0SNX9FpATVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740654714; c=relaxed/simple;
	bh=rgmme76n2CzNqkUCcP3NAi7yfETqH2iSYt1NYJV6DOg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P5ykL4PzrwEMb1cVAgROicF88tlK2siHOJxB39/+ixfd58M50oOCzCnvCCaDt41O6fRPyV1omjoRRWZ9EiDZnrRqwxLYiDEHBDZr9eAhF9Ybj6Qw9cUairqAbc1fC9/XjhIwS/Me/s0We3NCAqu70MGocRZyYti9setesVae6a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d40Fss9z; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740654712; x=1772190712;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rgmme76n2CzNqkUCcP3NAi7yfETqH2iSYt1NYJV6DOg=;
  b=d40Fss9z21nLbrhI0QGbXebKspNAfbHRsO391HNMsm4vt6vgCLEgnxCC
   WRxZQ7nmpL1IQE7D7fYLdooKRxgYYceao+eoKhouJ9Llym2sHLmPYGk7v
   AkS2uebn7dyAczlWOmb81dPL/UMldhFpCxFF3bvPF61nKacQGJkK2QqS4
   paQJQiGjcmMlW2jWLfFQCZEcqtkAxyLKfge5kAa5TB4NX60AGzvGipVU6
   BW1b5iq/TlrX038tFWTNaR0MyvmZiv+r2dUc5OX6S8O5DPjjA/NrRkUo+
   FI7PhrV0TbLGyzQAKWSdzxIDOyShHdyQkNC9E3SI5XGsWVEolFSdVdhP4
   w==;
X-CSE-ConnectionGUID: tk0RzhRiQ3Wp6l53cWzVKg==
X-CSE-MsgGUID: 3aelvOp8Tn6LGeEBg7UArQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11357"; a="45189822"
X-IronPort-AV: E=Sophos;i="6.13,319,1732608000"; 
   d="scan'208";a="45189822"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 03:11:52 -0800
X-CSE-ConnectionGUID: XnNK95HwSY+4kc7hSolgbA==
X-CSE-MsgGUID: kMjX9iicTg6QuVrZ7+2X5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="154178952"
Received: from johunt-mobl9.ger.corp.intel.com (HELO yungchua-desk.intel.com) ([10.124.220.110])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 03:11:50 -0800
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	broonie@kernel.org,
	tiwai@suse.de,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.dev,
	bard.liao@intel.com
Subject: [PATCH v3 05/16] soundwire: stream: special-case the bus compute_params() routine
Date: Thu, 27 Feb 2025 19:11:18 +0800
Message-ID: <20250227111130.272698-6-yung-chuan.liao@linux.intel.com>
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


