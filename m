Return-Path: <linux-kernel+bounces-429520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81F439E214C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 16:10:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95DA0B2B9A1
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 13:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 302181F12ED;
	Tue,  3 Dec 2024 13:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QBQW9DEi"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DAFC193403;
	Tue,  3 Dec 2024 13:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733231912; cv=none; b=arB1OqGtC8HdDNK15I9ABVqLeh4dDYBbKs5NyIEUdAqpSRbUC2K57zlWqa8KDnavWF2pIgAZ/R6ryjYXp5Xc4ophMZ65cH0FN/qKLrnv7K0ff/OY0EjNBEZ9eUB/VXDn/DW0l3uO9mdkuazIpRJIV0k772dWAmAKnri1jnOQrEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733231912; c=relaxed/simple;
	bh=i7szRebw6WQA5QpBUiel/GHy/A8mHrGYWbddHxs31ms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DSBtwnDdCfRbZOSB7gzdrfOWOvJOkc6XWVGj9AkOSQKjXBfUZqMOF251Oqcpjq3AOCHWncEJY0l1MA9Xwyu2BDQxeg7DAS1kroXSkYkPJUPoMZt3eV9+chrRaRXQzcR+alcDTMRYsoJzEoKSaTR5FCGPSz06aWBS70vRjX3nNDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QBQW9DEi; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733231910; x=1764767910;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=i7szRebw6WQA5QpBUiel/GHy/A8mHrGYWbddHxs31ms=;
  b=QBQW9DEi8Ex3X0kN6urbAAfnsfr6rr+YNJR/HzcIh5AfDI/33pehvtTO
   RKqYee05EIz5lGh24PC6h244/5Lh0tnWWtpsm1+3MUaoiEZXvdUjKVRUJ
   2XHkwH6TXO30fsn5mkQHObA8UDCkwwmFUYT1fsYpxn6Lvp2dkZ5eTrbEw
   iwF0L2zgALvBH96CjU4wUrZP34wTtPdbywFjhHDtO/W9BXxB42zPB6h8r
   MlmLOexbdx3IcAZWETDBKO5Wa27Esh7vyeGZIqsAdQtYZpbfhR/KzlA/I
   SUXfkneWk/Hx+ygphWcXVqI3SBsDj+Mskgw8czqqTpsOXdIif++qxRlND
   A==;
X-CSE-ConnectionGUID: QCBg9sApQSmpVMTJl+8jyA==
X-CSE-MsgGUID: 3Tz/ch/STpKe/B0yUziNsw==
X-IronPort-AV: E=McAfee;i="6700,10204,11274"; a="33500711"
X-IronPort-AV: E=Sophos;i="6.12,205,1728975600"; 
   d="scan'208";a="33500711"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 05:18:30 -0800
X-CSE-ConnectionGUID: 2ofiEKzESa2de5yu/56FbQ==
X-CSE-MsgGUID: 96S9exBNS8i0GrTcr/98+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,205,1728975600"; 
   d="scan'208";a="130896051"
Received: from ccbilbre-mobl3.amr.corp.intel.com (HELO yungchua-desk.intel.com) ([10.124.223.75])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 05:18:29 -0800
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.dev,
	bard.liao@intel.com
Subject: [PATCH v2 01/14] soundwire: add lane field in sdw_port_runtime
Date: Tue,  3 Dec 2024 21:18:00 +0800
Message-ID: <20241203131813.58454-2-yung-chuan.liao@linux.intel.com>
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

Currently, lane_ctrl is always 0. Add a lane field in sdw_port_runtime
to indicate the data lane of the data port.
They are 0 by default.

Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/amd_manager.c                  | 2 +-
 drivers/soundwire/bus.h                          | 2 ++
 drivers/soundwire/generic_bandwidth_allocation.c | 4 ++--
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/soundwire/amd_manager.c b/drivers/soundwire/amd_manager.c
index 5a4bfaef65fb..f47d4cd656ae 100644
--- a/drivers/soundwire/amd_manager.c
+++ b/drivers/soundwire/amd_manager.c
@@ -410,7 +410,7 @@ static int amd_sdw_compute_params(struct sdw_bus *bus)
 			sdw_fill_xport_params(&p_rt->transport_params, p_rt->num,
 					      false, SDW_BLK_GRP_CNT_1, sample_int,
 					      port_bo, port_bo >> 8, hstart, hstop,
-					      SDW_BLK_PKG_PER_PORT, 0x0);
+					      SDW_BLK_PKG_PER_PORT, p_rt->lane);
 
 			sdw_fill_port_params(&p_rt->port_params,
 					     p_rt->num, bps,
diff --git a/drivers/soundwire/bus.h b/drivers/soundwire/bus.h
index fda6b24ac2da..ff03b97f1d8b 100644
--- a/drivers/soundwire/bus.h
+++ b/drivers/soundwire/bus.h
@@ -90,6 +90,7 @@ int sdw_find_col_index(int col);
  * @transport_params: Transport parameters
  * @port_params: Port parameters
  * @port_node: List node for Master or Slave port_list
+ * @lane: Which lane is used
  *
  * SoundWire spec has no mention of ports for Master interface but the
  * concept is logically extended.
@@ -100,6 +101,7 @@ struct sdw_port_runtime {
 	struct sdw_transport_params transport_params;
 	struct sdw_port_params port_params;
 	struct list_head port_node;
+	unsigned int lane;
 };
 
 /**
diff --git a/drivers/soundwire/generic_bandwidth_allocation.c b/drivers/soundwire/generic_bandwidth_allocation.c
index b9316207c3ab..abf9b85daa52 100644
--- a/drivers/soundwire/generic_bandwidth_allocation.c
+++ b/drivers/soundwire/generic_bandwidth_allocation.c
@@ -56,7 +56,7 @@ void sdw_compute_slave_ports(struct sdw_master_runtime *m_rt,
 					      sample_int, port_bo, port_bo >> 8,
 					      t_data->hstart,
 					      t_data->hstop,
-					      SDW_BLK_PKG_PER_PORT, 0x0);
+					      SDW_BLK_PKG_PER_PORT, p_rt->lane);
 
 			sdw_fill_port_params(&p_rt->port_params,
 					     p_rt->num, bps,
@@ -109,7 +109,7 @@ static void sdw_compute_master_ports(struct sdw_master_runtime *m_rt,
 		sdw_fill_xport_params(&p_rt->transport_params, p_rt->num,
 				      false, SDW_BLK_GRP_CNT_1, sample_int,
 				      *port_bo, (*port_bo) >> 8, hstart, hstop,
-				      SDW_BLK_PKG_PER_PORT, 0x0);
+				      SDW_BLK_PKG_PER_PORT, p_rt->lane);
 
 		sdw_fill_port_params(&p_rt->port_params,
 				     p_rt->num, bps,
-- 
2.43.0


