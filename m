Return-Path: <linux-kernel+bounces-394149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE1099BAB33
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 04:24:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63828B20C86
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 03:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63B2417965E;
	Mon,  4 Nov 2024 03:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dl8F0jmk"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4022E81727;
	Mon,  4 Nov 2024 03:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730690638; cv=none; b=d59Q+fNzljP9BGyakcF9PYdFNYgCz5mT2rnx0j0ZZgJ1thzXsim84V9pqDvLT5rGUWwAMTZlCGVQZjypHZPUtI7qb3Lf5koBQUmC/xPn650yZ0+Ua6xhIPo/LXxOyBi8sEbTqhodYjSIxz/XFmEtyNZU9qNPpa3y5lQkGCujjOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730690638; c=relaxed/simple;
	bh=eoZsQIsvRmH8SVJfRhXmend9Q1wPDSu8pZhR4mqet1E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R6Rma9Y+uJYpWJoQU+DsVQ+VKqx/nMY6l+GQyb0CqX+NBxMhMGfhzHa9MvhKWQchfg/g1/bLXnxQSoTEw3mMO8bLs4fVM/JtImyIP95A6br/K/BnMtPq/UjJca88ZOqgqFtc4p2VnvurPuV/cKVmJXkLuUKjdpawe7DV60s3KYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Dl8F0jmk; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730690637; x=1762226637;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eoZsQIsvRmH8SVJfRhXmend9Q1wPDSu8pZhR4mqet1E=;
  b=Dl8F0jmkM2An0SDgw5ub3D1j9rueLPBTRNSk0TLp5/JaTbvwNNz/Ey3l
   Za5pe8lCKlajN96ZGI0K8HnXucsvDJcQSCSt+wg+5ZTCxWpUNzw4fYq4I
   G2LSKa6Cd6K0vaQ9vtVakGH+A6DAP0Oi/qzTkT3T1m/InswdGzi5qwPB4
   4Mr3aoC+osAdKp+0xWll0GEhZusLyMjPt17aAfnQfg9xPSVMFXYLTUdIW
   2w/da44AKYI7RG9rIIAOBxTMpRB66aioKortWzgFQBOWhgRl6eWWnX5qc
   sR+RHXuS1RTRVjeU0vTFB01+rK3r233RObkmckB6L1Z8SthgkNWcHhMTA
   Q==;
X-CSE-ConnectionGUID: 1W8FyK45S6eEQ2uMv6KOSw==
X-CSE-MsgGUID: uwGSDkz6SnGqxA/qfaCulg==
X-IronPort-AV: E=McAfee;i="6700,10204,11245"; a="30594267"
X-IronPort-AV: E=Sophos;i="6.11,256,1725346800"; 
   d="scan'208";a="30594267"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2024 19:23:55 -0800
X-CSE-ConnectionGUID: WPEk3oTfSamDRIKOXesowA==
X-CSE-MsgGUID: Uccq+kSqTiyhjyUR2hVlcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,256,1725346800"; 
   d="scan'208";a="114331789"
Received: from yungchua-ws.ostc.intel.com (HELO yungchua-ws.intel.com) ([10.54.69.90])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2024 19:23:56 -0800
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.dev,
	bard.liao@intel.com
Subject: [PATCH 01/12] soundwire: add lane field in sdw_port_runtime
Date: Mon,  4 Nov 2024 03:23:47 +0000
Message-Id: <20241104032358.669705-2-yung-chuan.liao@linux.intel.com>
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
2.34.1


