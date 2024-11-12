Return-Path: <linux-kernel+bounces-405875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 540E39C585E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 13:57:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA5F41F230EE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 12:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FB97136E09;
	Tue, 12 Nov 2024 12:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="m7gulnCl"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3916570819;
	Tue, 12 Nov 2024 12:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731416227; cv=none; b=ZeHKWuOhBckmVZ3o8iN/lJ57FzAkhTLDBD7XVz2sSLrZxAnxmg26yUd/DhwSKyYRZEJ/jV7BXFCTKhmYqitZ8b+npRLf/APR+bA9nQPO9jkHbLsNfyMfVXegMl2U7swkagShaTf3/e+Qt9pjbkdVlFTnte5eYBkkmK8chk6cIRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731416227; c=relaxed/simple;
	bh=DT8qynPgwAG3ppbS9qf4sgLqXZIyrV8mYST8MOyPjz0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q4b6CSetAngcvFf+W6Z23Dw33KlHrV5jWJz/nQ8fhMW+9O8YGpk9hWpNzLd2tz0Z1Wdq2UwVnMDt4s4Nfbc0W9ffxN4J0FjlJiJ3XqIFFF+ncGnV98RvIUAS7rTZgLIM1EVfgmO+2fKzqqLhKDKPEsRMg2I+HgPGR9aKrMll9gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=m7gulnCl; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AC5j6NF023683;
	Tue, 12 Nov 2024 06:56:49 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=3wVaM1acinFm61MngTCwjL4HTcqsDnmozyijHKa425o=; b=
	m7gulnClc+bICUAtJbg0MIxN+yrJr/0HJMem2xtBY3e0VmVvi8vquC4Qye3/7EK0
	h81n/FiNvSL5vsVHG7s5gBJGxKhTmGdTQ0kQj2IHq5eWqidI78EYIgogKikaBtOc
	VdkwHj9+7Sc/1SjhY65DLAd+58m5EQcd5SyYUVZ5Vhg2BCa3WJmyrAT1Z1nFqnHE
	z+LaC0CktIyEzGyQh/h92YhrBY1JvzDDmtGoY6yQRoVtDmAJxHYjjKxpVOrnmhHE
	Uz0exKO2jd4/kLkhYo0M2xzQ1V6DRQFuy6fD4gihDa77M6zZOW9+dUCoLfLplWsu
	K2cY73I5zTRNXNut/4AP2w==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 42t51p35at-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Nov 2024 06:56:49 -0600 (CST)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 12 Nov
 2024 12:56:47 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Tue, 12 Nov 2024 12:56:47 +0000
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id F2F96820258;
	Tue, 12 Nov 2024 12:56:46 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <vkoul@kernel.org>
CC: <yung-chuan.liao@linux.intel.com>, <pierre-louis.bossart@linux.dev>,
        <sanyog.r.kale@intel.com>, <linux-sound@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: [PATCH RESEND 2/2] soundwire: Minor formatting fixups in sdw.h header
Date: Tue, 12 Nov 2024 12:56:46 +0000
Message-ID: <20241112125646.590240-2-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241112125646.590240-1-ckeepax@opensource.cirrus.com>
References: <20241112125646.590240-1-ckeepax@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: _pJUJswbpsdOGkjPJoq3krWThL3zb5bJ
X-Proofpoint-ORIG-GUID: _pJUJswbpsdOGkjPJoq3krWThL3zb5bJ
X-Proofpoint-Spam-Reason: safe

Fixup some minor formatting and whitespace in the sdw.h header file.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 include/linux/soundwire/sdw.h | 40 +++++++++++++++--------------------
 1 file changed, 17 insertions(+), 23 deletions(-)

diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
index 1fd4b126287f2..784656f740f67 100644
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


