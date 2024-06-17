Return-Path: <linux-kernel+bounces-217279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED25990ADBA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 14:14:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D54CE1C22F44
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 12:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6429F194C9B;
	Mon, 17 Jun 2024 12:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N4J23H1T"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F28E194C6A;
	Mon, 17 Jun 2024 12:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718626443; cv=none; b=BU1acoCyX3ZiHD6VebA7AGWI4IeQURHlFdwlrhQbcHfpy671tjcwVcGo2VfCH4HyeuKiJ8FFXF8ijVOsw5hco2eSlb3KH3/sI/TYbQoRunBPix4l2ySPvzTXftwwg3WEGvKA5RO4+YQZZl4aIkwev9aW25be50MblzIcXfqiZ1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718626443; c=relaxed/simple;
	bh=uy0/tSB3ASpoDH7l6Cr+SBFLv6PorMawuYN6R2WwBRM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WadbNHNwc8ro5QccBjLvJaupWeoa2AyHxJchYzmSQy8T0qh9Rn9xEpqryLETTFuJQN2DH2hMiNUxXwvPnOI7PZZxnfXqDcsmrC1brvsEWNi9psUReRda+c2v9QMcJFxLFZf2E7yJ4PJc7tiIIT1vr6pkttWld/zGMtP4l+O9Y6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N4J23H1T; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718626442; x=1750162442;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=uy0/tSB3ASpoDH7l6Cr+SBFLv6PorMawuYN6R2WwBRM=;
  b=N4J23H1T26j7Ae3GdW+u8hJlivosyrIlfpugTHi5zXHy2nhE+eA+hTp/
   Vrus0o+XXUmz5QbPs4rjo8ilrd6JAkgNEq30yh8R1UxNSVKE3rHNglPWs
   MTI49LBziiOh8nyRhDHtvyqvJ5i1s9p9aJrIBizB7Z9gJgrzYUOCwPZ+T
   96oHY8z5EvMZ9IgMjmd9bwjNX5Ks79R5rioI0O9uh0LYYsD2dvvYafc2Y
   zAsJOuS6kUEcwg5ETjnZJMFYCPbAd0pw9LT2ZyM0P+069MBSzBZ++uqYQ
   87uph5cyGOqwLiMGzZq4ZB5yDs+O/CT2AibmQ/MYMgNNZUEOuZJYxgyk4
   w==;
X-CSE-ConnectionGUID: jChq3eN9TaSJxy6fzCX07Q==
X-CSE-MsgGUID: YkELu5i+SEuaWt21fK7dxA==
X-IronPort-AV: E=McAfee;i="6700,10204,11105"; a="15164489"
X-IronPort-AV: E=Sophos;i="6.08,244,1712646000"; 
   d="scan'208";a="15164489"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2024 05:14:01 -0700
X-CSE-ConnectionGUID: 4c2JTCerSZarJ1Fw/zZvqQ==
X-CSE-MsgGUID: vxxOwhtaS/WO1rzc7rTPcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,244,1712646000"; 
   d="scan'208";a="72378560"
Received: from bvivekan-mobl2.gar.corp.intel.com (HELO yungchua-desk.intel.com) ([10.247.118.149])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2024 05:13:59 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.intel.com,
	bard.liao@intel.com
Subject: [PATCH] soundwire: generic_bandwidth_allocation: change port_bo parameter to pointer
Date: Mon, 17 Jun 2024 20:13:50 +0800
Message-Id: <20240617121350.14074-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, we do port_bo += bps * ch in both inside and outside
sdw_compute_master_ports(). We can pass port_bo as a pointer and only
calculate port_bo in sdw_compute_master_ports().
Besides, different port could use different lanes and we can't just
add port_bo based on total channels in a manager.

Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/generic_bandwidth_allocation.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/soundwire/generic_bandwidth_allocation.c b/drivers/soundwire/generic_bandwidth_allocation.c
index c70a63d009ae..b9316207c3ab 100644
--- a/drivers/soundwire/generic_bandwidth_allocation.c
+++ b/drivers/soundwire/generic_bandwidth_allocation.c
@@ -83,7 +83,7 @@ EXPORT_SYMBOL(sdw_compute_slave_ports);
 
 static void sdw_compute_master_ports(struct sdw_master_runtime *m_rt,
 				     struct sdw_group_params *params,
-				     int port_bo, int hstop)
+				     int *port_bo, int hstop)
 {
 	struct sdw_transport_data t_data = {0};
 	struct sdw_port_runtime *p_rt;
@@ -108,7 +108,7 @@ static void sdw_compute_master_ports(struct sdw_master_runtime *m_rt,
 
 		sdw_fill_xport_params(&p_rt->transport_params, p_rt->num,
 				      false, SDW_BLK_GRP_CNT_1, sample_int,
-				      port_bo, port_bo >> 8, hstart, hstop,
+				      *port_bo, (*port_bo) >> 8, hstart, hstop,
 				      SDW_BLK_PKG_PER_PORT, 0x0);
 
 		sdw_fill_port_params(&p_rt->port_params,
@@ -120,15 +120,15 @@ static void sdw_compute_master_ports(struct sdw_master_runtime *m_rt,
 		if (!(p_rt == list_first_entry(&m_rt->port_list,
 					       struct sdw_port_runtime,
 					       port_node))) {
-			port_bo += bps * ch;
+			(*port_bo) += bps * ch;
 			continue;
 		}
 
 		t_data.hstart = hstart;
 		t_data.hstop = hstop;
-		t_data.block_offset = port_bo;
+		t_data.block_offset = *port_bo;
 		t_data.sub_block_offset = 0;
-		port_bo += bps * ch;
+		(*port_bo) += bps * ch;
 	}
 
 	sdw_compute_slave_ports(m_rt, &t_data);
@@ -146,9 +146,7 @@ static void _sdw_compute_port_params(struct sdw_bus *bus,
 		port_bo = 1;
 
 		list_for_each_entry(m_rt, &bus->m_rt_list, bus_node) {
-			sdw_compute_master_ports(m_rt, &params[i], port_bo, hstop);
-
-			port_bo += m_rt->ch_count * m_rt->stream->params.bps;
+			sdw_compute_master_ports(m_rt, &params[i], &port_bo, hstop);
 		}
 
 		hstop = hstop - params[i].hwidth;
-- 
2.40.1


