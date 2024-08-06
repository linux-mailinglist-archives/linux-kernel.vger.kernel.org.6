Return-Path: <linux-kernel+bounces-275735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 243BE94892D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 08:10:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1E441F23CEA
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 06:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E76771BC091;
	Tue,  6 Aug 2024 06:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kIB26Hlx"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E9D6173355;
	Tue,  6 Aug 2024 06:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722924586; cv=none; b=tWhgQOavH8UBzF3JvFDdJXo93tRoojzebFqyF1e4PxCEdInZrj1FTzdn/GBm6H3pm2b12HzaM7FuGnaOPkiMXsaiWH9I+0cIclUaTaqa6OHB1Gzsaci8QSx4daC4VWsRAe1dpNDJRkpPzlp36WuDz9ka1QnTLT1hijmiLp/L614=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722924586; c=relaxed/simple;
	bh=NLPE2unbjlIkQEEfMyKb8wnCPg2MGxqBLITscCraHUU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aPeftFQ44K3JBKbX2nLCuMaje6BTFElK5k5TXgo09sqYtDzX962WFFTpHEoJKNKjRNFFKo9jZR2hQuo8mbeL4P4ROQtlVdupNmQi7skIJRp8ELBToVXkHMSE3qzSQBfqVg9UESXP72ERPZX5LEyGvPdY62i8JEXmg/HaS9r+5uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kIB26Hlx; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722924584; x=1754460584;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=NLPE2unbjlIkQEEfMyKb8wnCPg2MGxqBLITscCraHUU=;
  b=kIB26Hlxlyrv4+cocAkPxIbUdgSRc6SI7c/h0ditN0mIodvgxXpu1jZV
   GIkrXzvtx/sLWr8UaIu3wt8uYEozE+23TELdhyKjDGIkeVW8r1n7yjHTf
   nS8xkpAsRFACb6KyT+fYS+BXUiBqJoQVlg6rwUqSmentW5bz4lRc0/1UN
   0LQp34dtqs6/vpQdAVlEQ8tEL1ZA5FvhxzHCXq66pKvMo0HGk6qoTMY1S
   40Q9Q/haM0sj3k+WVeZAidK4ZgAs3i5rttqvMO8sn/GWgK4UehcM+mKo5
   9viPKR8bTjC6uFYwuN3lu4YMvV1ESFBK7gZXS3I836PNI0OlM0FQIFdy5
   A==;
X-CSE-ConnectionGUID: pyTDu2FXSxynapcP0krN1g==
X-CSE-MsgGUID: zjW9qD69QDO7cqxTy+pZaA==
X-IronPort-AV: E=McAfee;i="6700,10204,11155"; a="20498137"
X-IronPort-AV: E=Sophos;i="6.09,266,1716274800"; 
   d="scan'208";a="20498137"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2024 23:09:43 -0700
X-CSE-ConnectionGUID: 0kjO4AeeRZi9R2Mf6T7tZQ==
X-CSE-MsgGUID: UUtMKR7nRvK1bNvFOcF5OQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,266,1716274800"; 
   d="scan'208";a="61263556"
Received: from anmitta2-mobl4.gar.corp.intel.com (HELO yungchua-desk.intel.com) ([10.247.119.23])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2024 23:09:40 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.intel.com,
	bard.liao@intel.com
Subject: [PATCH] soundwire: add lane field in sdw_port_runtime
Date: Tue,  6 Aug 2024 14:09:30 +0800
Message-ID: <20240806060930.10433-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.43.0
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
index 0d01849c3586..babb580f3124 100644
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


