Return-Path: <linux-kernel+bounces-378155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E7AC9ACC24
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 16:20:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6DDDB21296
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 14:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23A191BD017;
	Wed, 23 Oct 2024 14:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="e2TWy3nn"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95D81AB6FF
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 14:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729693238; cv=none; b=YtKQ7Mhph5E++sQ8wGvveA3zSn5zIljX51LbqTYC2U55ztu3W7JXvGwIVhoCs4DWI5TU1rR8kMJ1eYrQ1guyrRsUqgSc5rIbEebgZjSoqSVzvfvJEDDZOZJCFdzSukD57H3mBAU613Cdw1TmlFC+9tcw6q46fBXvkDAvdUvO6KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729693238; c=relaxed/simple;
	bh=GHWe9fi4EZBqjJfRmgg5CZkJb4egb0ZlU+qzkS/tRJo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GYGrjzj0uk7EWGFSKQv1zEaCOMIY+9/MQSBgCHmgTTG0AufOvPglPLjeK+LW8LActkSo3Ga2cbhzdEg06b/DF4LHvx1ZzdHDHQpzxNifFTxl31v5si5Iy7o7QVs8aroPjuNIEftrxrY5tLQrg6U1s/Si0mq9yEByPc/aMQJ0fE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=e2TWy3nn; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49N2bpSE023824;
	Wed, 23 Oct 2024 09:20:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=paQiDuQuMxmy8BxNih+2mxQ+SHMnq23tYtT9VmPMPik=; b=
	e2TWy3nnnE4qQ29byLwlWZegEkra8NHjDD7cd5ypYBbUEPY+BlTh88vkNx1tlqGY
	InPHTmZpBd5WtHxHszcpurCYktdXlBqOU63LdWcTaRlNOAydDqDz57DLw+SBO25B
	kNKpYlIZT6h8xUiNkhkKmqpYbI+XTX013LRnYQDdcriQNGkinsKj4dyZpVXgEd/r
	r0lPHnIbOPF84CFuZ3Ve6+J4hzm+d7gw3hFTfQ+rNtxlVDF1lEcct/HA2+d9s0Z/
	Mja6OzPIs+qPZG216mUZ6fBpYCgekgrk9cJ9E0IB6gZr1LeCVDQMIpGesf65PCeO
	cSXAoy9+tFZFRaqgMyQ8Jg==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 42c96jcy2b-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Oct 2024 09:20:22 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 23 Oct
 2024 15:20:20 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Wed, 23 Oct 2024 15:20:20 +0100
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 73CC7822563;
	Wed, 23 Oct 2024 14:20:20 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <vkoul@kernel.org>
CC: <yung-chuan.liao@linux.intel.com>, <pierre-louis.bossart@linux.dev>,
        <sanyog.r.kale@intel.com>, <linux-sound@vger.kernel.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] soundwire: Minor formatting fixups in sdw.h header
Date: Wed, 23 Oct 2024 15:20:20 +0100
Message-ID: <20241023142020.3612551-2-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241023142020.3612551-1-ckeepax@opensource.cirrus.com>
References: <20241023142020.3612551-1-ckeepax@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: QjK0L6U-cuf06jiyDuzlJ6fgCGIHLfi9
X-Proofpoint-ORIG-GUID: QjK0L6U-cuf06jiyDuzlJ6fgCGIHLfi9
X-Proofpoint-Spam-Reason: safe

Fixup some minor formatting and whitespace in the sdw.h header file.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 include/linux/soundwire/sdw.h | 40 +++++++++++++++--------------------
 1 file changed, 17 insertions(+), 23 deletions(-)

diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
index 1fd4b126287f..784656f740f6 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -616,7 +616,6 @@ struct sdw_slave_ops {
 	int (*clk_stop)(struct sdw_slave *slave,
 			enum sdw_clk_stop_mode mode,
 			enum sdw_clk_stop_type type);
-
 };
 
 /**
@@ -690,8 +689,7 @@ struct sdw_master_device {
 	container_of(d, struct sdw_master_device, dev)
 
 struct sdw_driver {
-	int (*probe)(struct sdw_slave *sdw,
-			const struct sdw_device_id *id);
+	int (*probe)(struct sdw_slave *sdw, const struct sdw_device_id *id);
 	int (*remove)(struct sdw_slave *sdw);
 	void (*shutdown)(struct sdw_slave *sdw);
 
@@ -710,7 +708,7 @@ struct sdw_driver {
 	SDW_SLAVE_ENTRY_EXT((_mfg_id), (_part_id), 0, 0, (_drv_data))
 
 int sdw_handle_slave_status(struct sdw_bus *bus,
-			enum sdw_slave_status status[]);
+			    enum sdw_slave_status status[]);
 
 /*
  * SDW master structures and APIs
@@ -792,15 +790,14 @@ struct sdw_enable_ch {
  */
 struct sdw_master_port_ops {
 	int (*dpn_set_port_params)(struct sdw_bus *bus,
-			struct sdw_port_params *port_params,
-			unsigned int bank);
+				   struct sdw_port_params *port_params,
+				   unsigned int bank);
 	int (*dpn_set_port_transport_params)(struct sdw_bus *bus,
-			struct sdw_transport_params *transport_params,
-			enum sdw_reg_bank bank);
-	int (*dpn_port_prep)(struct sdw_bus *bus,
-			struct sdw_prepare_ch *prepare_ch);
+					     struct sdw_transport_params *transport_params,
+					     enum sdw_reg_bank bank);
+	int (*dpn_port_prep)(struct sdw_bus *bus, struct sdw_prepare_ch *prepare_ch);
 	int (*dpn_port_enable_ch)(struct sdw_bus *bus,
-			struct sdw_enable_ch *enable_ch, unsigned int bank);
+				  struct sdw_enable_ch *enable_ch, unsigned int bank);
 };
 
 struct sdw_msg;
@@ -835,14 +832,11 @@ struct sdw_defer {
  */
 struct sdw_master_ops {
 	int (*read_prop)(struct sdw_bus *bus);
-	u64 (*override_adr)
-			(struct sdw_bus *bus, u64 addr);
-	enum sdw_command_response (*xfer_msg)
-			(struct sdw_bus *bus, struct sdw_msg *msg);
-	enum sdw_command_response (*xfer_msg_defer)
-			(struct sdw_bus *bus);
+	u64 (*override_adr)(struct sdw_bus *bus, u64 addr);
+	enum sdw_command_response (*xfer_msg)(struct sdw_bus *bus, struct sdw_msg *msg);
+	enum sdw_command_response (*xfer_msg_defer)(struct sdw_bus *bus);
 	int (*set_bus_conf)(struct sdw_bus *bus,
-			struct sdw_bus_params *params);
+			    struct sdw_bus_params *params);
 	int (*pre_bank_switch)(struct sdw_bus *bus);
 	int (*post_bank_switch)(struct sdw_bus *bus);
 	u32 (*read_ping_status)(struct sdw_bus *bus);
@@ -1019,12 +1013,12 @@ void sdw_release_stream(struct sdw_stream_runtime *stream);
 int sdw_compute_params(struct sdw_bus *bus);
 
 int sdw_stream_add_master(struct sdw_bus *bus,
-		struct sdw_stream_config *stream_config,
-		const struct sdw_port_config *port_config,
-		unsigned int num_ports,
-		struct sdw_stream_runtime *stream);
+			  struct sdw_stream_config *stream_config,
+			  const struct sdw_port_config *port_config,
+			  unsigned int num_ports,
+			  struct sdw_stream_runtime *stream);
 int sdw_stream_remove_master(struct sdw_bus *bus,
-		struct sdw_stream_runtime *stream);
+			     struct sdw_stream_runtime *stream);
 int sdw_startup_stream(void *sdw_substream);
 int sdw_prepare_stream(struct sdw_stream_runtime *stream);
 int sdw_enable_stream(struct sdw_stream_runtime *stream);
-- 
2.39.5


