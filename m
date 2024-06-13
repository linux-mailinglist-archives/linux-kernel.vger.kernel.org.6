Return-Path: <linux-kernel+bounces-213272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9092790735B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 15:16:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D1092875A8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 13:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27106145B37;
	Thu, 13 Jun 2024 13:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="AxrXim1y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="L7AEWbE1"
Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3723F14533F
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 13:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718284498; cv=none; b=j0VTZU8ap85zut9CA57XVqpi67zFx2UG2Hk0mlIrcY1pzx+M1RVu63agk9wvwpjbwXK4yCfsChjfTjMiZuV7REZ4LAFgAfupkFhNPV5ZAVLTYiNvczeAmyNLqZTvNUkTWWL4VgdfayyOuV+EYJO9odUARwpiFXSBKrdV4FBc7l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718284498; c=relaxed/simple;
	bh=aCGZrzVKo9BdlbEpBns4eiZQ0q3VOd6LplzuPlXQRDk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HZ7R9nJBJDrg23AAqDTl7uHm8wYRTUNiuMMapF+0uVohu1cwN9PaNeNgbu++KCqaJ7F7d8t1O3lSbjA3WJEZ57mWmWhUBS4N/g2GUiXV5n5la9ws7oVRTQmUU+GdzTKhxbbZyTUrYfmFHxKN1TV80U5kEakP7tehWJidOjSwdoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=AxrXim1y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=L7AEWbE1; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id 5698B13800CA;
	Thu, 13 Jun 2024 09:14:56 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 13 Jun 2024 09:14:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1718284496; x=
	1718370896; bh=I8uNY8Z0JU6uknnPbF1XPQmmJMnq42rmOIUNt32Gy64=; b=A
	xrXim1ypDdQX1Mzo0lQ4tgvnLpiEhUVlUMhjAi1KagBDHYejLdLLAfO2Qk89KGV/
	I0BpY8JhMNvnjX/3xBKwDStXHDDx++EsybLrNE8QHWdpKqPNdEGv8mRyf75X8HBt
	7Vjoo7bgXzlxZf2bjzXHzFqQrtltnWNRWRAeluXHUbL9aJX3lDhQMaxWxPMcWzWW
	uvAigPOPM1oMyg6TiFFAWEKH2pqm7C8f4SBNeE9oPUJQ0IKLD8wXUEL1oVJXs6Y4
	HlP6bxYoVmyWfCYxepoE59Jfc7k4+B9oB5ERGcRO0NgVOK3t+xyf8bXnwKqQEB81
	imsj5V8zLiqTLA6vCyUQg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1718284496; x=
	1718370896; bh=I8uNY8Z0JU6uknnPbF1XPQmmJMnq42rmOIUNt32Gy64=; b=L
	7AEWbE1zUxczl1mBq9XIy9bOWL0x3U4xYJRf1oDApya9Jrz5W/IWhs9riI8NMYn8
	6FfmtqddN7GgMDi6w8OXFp95xlwcTru7q65Gv5fuhPAN6Dz5buz1crufra+aky5s
	dfDb2nT27Wt0Oaf8Zv1nWZVIA8yynMDSqRVwS/VXc09KYmXEb1Myj3IPwYcYIOW1
	eZ7SmKLmWQUNsW8Ce8CuceZv5zm+9nrLd+DkOm9mVEQjBOiktdRSN0D7eoydSPeH
	OvujpNIRrTpAfikAl1YpuVpT0vBGHoUOEUsL53dr4NC1cALOGwxu/NIRXSXRAKP9
	nx4R7179URoIlwmFk79HQ==
X-ME-Sender: <xms:0PBqZlGtT-lv4-sSkBpF92G-F-NRH2-2AaSh-959PaKdKyOKrFnE6g>
    <xme:0PBqZqWtRTmURMY_3ML8CfsvpjfXKhlY_YB6eClT57iig-VzHGMpb5SEpXneHeAJF
    wXRSIEZbI63br7ntWg>
X-ME-Received: <xmr:0PBqZnKFKR5EE98C8Nt2Jd3yEXpjEmKVqekRZjr7FYYm--W8qZQRcP0HjsKowJUuGRx4RqBIA80wVTjCI5TIbR47YbwjqASrToh8jMYiHaZ3gw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedujedgheelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghk
    rghshhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpedvjefgje
    euvdfguddukeelveetgfdtvefhtdfffeeigfevueetffeivdffkedvtdenucevlhhushht
    vghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhise
    hsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:0PBqZrGpjUukGyV2qdKZknP2VGhPml68rvxMoRWVLFvAn5S7dx25Dw>
    <xmx:0PBqZrUKNptCwwHEd8HrOYAUeR1JBhZ-EKJRLeupo6YcHv8z0vakMQ>
    <xmx:0PBqZmPJY_ktCKPE5R-2MjryIK5Fa6Dh3ic2YlMFqGwJKJsv7X2Gcw>
    <xmx:0PBqZq1CTcpT-oTJewp529fqLeIOYDFD12jNs6Y9xZiXpNFXf15kXg>
    <xmx:0PBqZojZkUZso3pVlObWOASvz8stApKBA8FC8_xE9E2y0E68EVM1pV6n>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Jun 2024 09:14:55 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 8/8] firewire: core: record card index in bus_reset_handle tracepoints event
Date: Thu, 13 Jun 2024 22:14:40 +0900
Message-ID: <20240613131440.431766-9-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240613131440.431766-1-o-takashi@sakamocchi.jp>
References: <20240613131440.431766-1-o-takashi@sakamocchi.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The bus reset event occurs in the bus managed by one of 1394 OHCI
controller in Linu system, however the existing tracepoints events has
the lack of data about it to distinguish the issued hardware from the
others.

This commit adds card_index member into event structure to store the index
of host controller in use, and prints it.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/core-topology.c | 2 +-
 include/trace/events/firewire.h  | 9 ++++++---
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/firewire/core-topology.c b/drivers/firewire/core-topology.c
index 837cc44d8d9f..8107eebd4296 100644
--- a/drivers/firewire/core-topology.c
+++ b/drivers/firewire/core-topology.c
@@ -508,7 +508,7 @@ void fw_core_handle_bus_reset(struct fw_card *card, int node_id, int generation,
 	struct fw_node *local_node;
 	unsigned long flags;
 
-	trace_bus_reset_handle(generation, node_id, bm_abdicate, self_ids, self_id_count);
+	trace_bus_reset_handle(card->index, generation, node_id, bm_abdicate, self_ids, self_id_count);
 
 	spin_lock_irqsave(&card->lock, flags);
 
diff --git a/include/trace/events/firewire.h b/include/trace/events/firewire.h
index e6485051f546..5ccc0d91b220 100644
--- a/include/trace/events/firewire.h
+++ b/include/trace/events/firewire.h
@@ -339,22 +339,25 @@ DEFINE_EVENT(bus_reset_arrange_template, bus_reset_postpone,
 );
 
 TRACE_EVENT(bus_reset_handle,
-	TP_PROTO(unsigned int generation, unsigned int node_id, bool bm_abdicate, u32 *self_ids, unsigned int self_id_count),
-	TP_ARGS(generation, node_id, bm_abdicate, self_ids, self_id_count),
+	TP_PROTO(unsigned int card_index, unsigned int generation, unsigned int node_id, bool bm_abdicate, u32 *self_ids, unsigned int self_id_count),
+	TP_ARGS(card_index, generation, node_id, bm_abdicate, self_ids, self_id_count),
 	TP_STRUCT__entry(
+		__field(u8, card_index)
 		__field(u8, generation)
 		__field(u8, node_id)
 		__field(bool, bm_abdicate)
 		__dynamic_array(u32, self_ids, self_id_count)
 	),
 	TP_fast_assign(
+		__entry->card_index = card_index;
 		__entry->generation = generation;
 		__entry->node_id = node_id;
 		__entry->bm_abdicate = bm_abdicate;
 		memcpy(__get_dynamic_array(self_ids), self_ids, __get_dynamic_array_len(self_ids));
 	),
 	TP_printk(
-		"generation=%u node_id=0x%04x bm_abdicate=%s self_ids=%s",
+		"card_index=%u generation=%u node_id=0x%04x bm_abdicate=%s self_ids=%s",
+		__entry->card_index,
 		__entry->generation,
 		__entry->node_id,
 		__entry->bm_abdicate ? "true" : "false",
-- 
2.43.0


