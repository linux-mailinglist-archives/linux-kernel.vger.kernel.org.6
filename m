Return-Path: <linux-kernel+bounces-213266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 567F090734D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 15:15:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A7E11C20E03
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 13:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29F1F1448EE;
	Thu, 13 Jun 2024 13:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="gnwcf8mF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ih9Qj/k2"
Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B791442ED
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 13:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718284490; cv=none; b=Ek5GwTwXN9MZ43obcZL6igji3gRLE/T0VS7rrCd6hAu7q42S0cOaiXfnn6yUEJc/t00CSom1eu6PFCtnlPlzl3+bCNMX4Zu2dHZW7sq640zwyZVRXmix0T2bpESMxWh4rDyHYx7XOBYqdcQb8FbTKSxIRcOlgx6FE25/XSiAAqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718284490; c=relaxed/simple;
	bh=+ZTeo/Hizo+1zprBXQtN0qsNyF9Bv+qpPIaa1bDsTbE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KG6y2ixNqYYhSGLhS1ntMagd6kK4rUohpr0PMX5BrJu8QLLuT69yRT1+DmcL8/JS3fXeNWOBWe6hqvIWsKGI/gSsU0uYcbhqcsM7ML8TAxxMNX8LdwTPl6bku6sA52fE+BXmBR/l4Uac0z/V30QTIa9sClc61XpIt2kQM16B+AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=gnwcf8mF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ih9Qj/k2; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 64B2311400B7;
	Thu, 13 Jun 2024 09:14:47 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 13 Jun 2024 09:14:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1718284487; x=
	1718370887; bh=GSAYRBUvcjGEeAPQd68KE4zWaTpTf65RgbA4e/6KOeU=; b=g
	nwcf8mFMrqdgLhjWpeVyTH1fyvITD4tCyk4k4wjRm0ri4Buu3XMXG+T+k0CKWum/
	jyxJbNMZw2mQaaJPccfChaczriERktkLAG8w/OIRkC7Vc6xYBxeQCXm5RYHM0tIQ
	9sb6x6dtDiYe9xS2nJZ0v0KRlvslcYwJsF0AIrTb30nxbRbcNS8jBfR+YEU8s90A
	kRsVmEYysI0+qZNwENZoF/GvFHiVc8YeL0Fcm2yuAvMiZD6IlJuq+dyj1StJY9Ai
	mwzrAl1e/ZK1bIQljtyljADI1Xg/ao+K9sxeW2MDrSfvnSzlvDLTjDqRGd/0Olph
	Ug29osT1iZcoOvBJZtwgQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1718284487; x=
	1718370887; bh=GSAYRBUvcjGEeAPQd68KE4zWaTpTf65RgbA4e/6KOeU=; b=I
	h9Qj/k2cMyT9k95zlQFDCX9jcS2QIEBkpXxsGdxDmQWBJZJPa5lgFQCs86W/hSyG
	4u/wxtmyI9u0F3cp0mHXnFiN4gDe7jjnb3hNpp5PvEcABi1xY+prfo+BNnNL8KSm
	tfhcMTaapmXZ/CoCQgVHabP7N7TRSUUn3tdg1aXiHdC9tcVgVnFpfIU1GEhPoj+5
	JR6iRhyckuBeIvXA3+lz23GQSPMtLwTm/G/ejRS/WYngGGfVFcj+o/uNdn4RY2My
	dqU2FZGlSFwrjfCZsOt/rs2nsrGoGvQRQH5Oeiw3CR8K1xpxMfN493rvnW0Wma1a
	UP46maPqBSbL4zBXoAuaA==
X-ME-Sender: <xms:x_BqZs0B7YWUf2xrmCJhgK6B4oQ3DUxSeWlEPrWds07Vuqo5Rp4aGQ>
    <xme:x_BqZnEOeqzFkTJVKrD45t2opqaHYgyypVzvp9WWK8kqIqv7g2a9R9ogfQLyIumow
    QbXWHwIjEBD3bVmvJ4>
X-ME-Received: <xmr:x_BqZk4Efl7CZx2FWg_IeStuUeJ4IMCZWvjJKrbTwUx2uXK1DUOZrI_18S1elrRlWSve8J_vyNCLICShMbXF1iIz2-msHENl_inb2amYIfoftQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedujedgiedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghk
    rghshhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpedvjefgje
    euvdfguddukeelveetgfdtvefhtdfffeeigfevueetffeivdffkedvtdenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhise
    hsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:x_BqZl1VUVTRgl5XsInG33MWMTOZa3uVhutnDiXMMVaH9x_DRBAsbw>
    <xmx:x_BqZvGqUo2fOO9CLcJI-S3gR_KiaAAkL3EAxdKAtLqFkqs6b5g0jw>
    <xmx:x_BqZu_q2YZiODgIIBcV0fUS0DpID0iaKdZ56MgmYyNxC0GErHs2Ww>
    <xmx:x_BqZklTzXxkLRLyenL9PJpf5EQzWkdMKOm5wWv2EmolbuUgT-GJ_w>
    <xmx:x_BqZkTFc7CYe23saoJXpzpEmvWWHvB-LbTAnhjmLuLUPqusRaU56l67>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Jun 2024 09:14:46 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2/8] firewire: core: record card index in tracepoinrts events derived from async_outbound_initiate_template
Date: Thu, 13 Jun 2024 22:14:34 +0900
Message-ID: <20240613131440.431766-3-o-takashi@sakamocchi.jp>
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

The asynchronous transaction is initiated on one of 1394 OHCI controller,
however the existing tracepoints events has the lack of data about it.

This commit adds card_index member into event structure to store the index
of host controller in use, and prints it.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/core-transaction.c | 10 ++++++----
 include/trace/events/firewire.h     | 20 ++++++++++++--------
 2 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/drivers/firewire/core-transaction.c b/drivers/firewire/core-transaction.c
index de75e758fd07..3f9361d15607 100644
--- a/drivers/firewire/core-transaction.c
+++ b/drivers/firewire/core-transaction.c
@@ -398,7 +398,8 @@ void __fw_send_request(struct fw_card *card, struct fw_transaction *t, int tcode
 
 	spin_unlock_irqrestore(&card->lock, flags);
 
-	trace_async_request_outbound_initiate((uintptr_t)t, generation, speed, t->packet.header, payload,
+	trace_async_request_outbound_initiate((uintptr_t)t, card->index, generation, speed,
+					      t->packet.header, payload,
 					      tcode_is_read_request(tcode) ? 0 : length / 4);
 
 	card->driver->send_request(card, &t->packet);
@@ -879,9 +880,10 @@ void fw_send_response(struct fw_card *card,
 	// Increase the reference count so that the object is kept during in-flight.
 	fw_request_get(request);
 
-	trace_async_response_outbound_initiate((uintptr_t)request, request->response.generation,
-					       request->response.speed, request->response.header,
-					       data, data ? data_length / 4 : 0);
+	trace_async_response_outbound_initiate((uintptr_t)request, card->index,
+					       request->response.generation, request->response.speed,
+					       request->response.header, data,
+					       data ? data_length / 4 : 0);
 
 	card->driver->send_response(card, &request->response);
 }
diff --git a/include/trace/events/firewire.h b/include/trace/events/firewire.h
index ca6ea9bd1eba..a3d9916cbad1 100644
--- a/include/trace/events/firewire.h
+++ b/include/trace/events/firewire.h
@@ -36,10 +36,11 @@
 #define QUADLET_SIZE	4
 
 DECLARE_EVENT_CLASS(async_outbound_initiate_template,
-	TP_PROTO(u64 transaction, unsigned int generation, unsigned int scode, const u32 *header, const u32 *data, unsigned int data_count),
-	TP_ARGS(transaction, generation, scode, header, data, data_count),
+	TP_PROTO(u64 transaction, unsigned int card_index, unsigned int generation, unsigned int scode, const u32 *header, const u32 *data, unsigned int data_count),
+	TP_ARGS(transaction, card_index, generation, scode, header, data, data_count),
 	TP_STRUCT__entry(
 		__field(u64, transaction)
+		__field(u8, card_index)
 		__field(u8, generation)
 		__field(u8, scode)
 		__array(u32, header, ASYNC_HEADER_QUADLET_COUNT)
@@ -47,6 +48,7 @@ DECLARE_EVENT_CLASS(async_outbound_initiate_template,
 	),
 	TP_fast_assign(
 		__entry->transaction = transaction;
+		__entry->card_index = card_index;
 		__entry->generation = generation;
 		__entry->scode = scode;
 		memcpy(__entry->header, header, QUADLET_SIZE * ASYNC_HEADER_QUADLET_COUNT);
@@ -54,8 +56,9 @@ DECLARE_EVENT_CLASS(async_outbound_initiate_template,
 	),
 	// This format is for the request subaction.
 	TP_printk(
-		"transaction=0x%llx generation=%u scode=%u dst_id=0x%04x tlabel=%u tcode=%u src_id=0x%04x offset=0x%012llx header=%s data=%s",
+		"transaction=0x%llx card_index=%u generation=%u scode=%u dst_id=0x%04x tlabel=%u tcode=%u src_id=0x%04x offset=0x%012llx header=%s data=%s",
 		__entry->transaction,
+		__entry->card_index,
 		__entry->generation,
 		__entry->scode,
 		ASYNC_HEADER_GET_DESTINATION(__entry->header),
@@ -142,8 +145,8 @@ DECLARE_EVENT_CLASS(async_inbound_template,
 );
 
 DEFINE_EVENT(async_outbound_initiate_template, async_request_outbound_initiate,
-	TP_PROTO(u64 transaction, unsigned int generation, unsigned int scode, const u32 *header, const u32 *data, unsigned int data_count),
-	TP_ARGS(transaction, generation, scode, header, data, data_count)
+	TP_PROTO(u64 transaction, unsigned int card_index, unsigned int generation, unsigned int scode, const u32 *header, const u32 *data, unsigned int data_count),
+	TP_ARGS(transaction, card_index, generation, scode, header, data, data_count)
 );
 
 DEFINE_EVENT(async_outbound_complete_template, async_request_outbound_complete,
@@ -178,11 +181,12 @@ DEFINE_EVENT_PRINT(async_inbound_template, async_request_inbound,
 );
 
 DEFINE_EVENT_PRINT(async_outbound_initiate_template, async_response_outbound_initiate,
-	TP_PROTO(u64 transaction, unsigned int generation, unsigned int scode, const u32 *header, const u32 *data, unsigned int data_count),
-	TP_ARGS(transaction, generation, scode, header, data, data_count),
+	TP_PROTO(u64 transaction, unsigned int card_index, unsigned int generation, unsigned int scode, const u32 *header, const u32 *data, unsigned int data_count),
+	TP_ARGS(transaction, card_index, generation, scode, header, data, data_count),
 	TP_printk(
-		"transaction=0x%llx generation=%u scode=%u dst_id=0x%04x tlabel=%u tcode=%u src_id=0x%04x rcode=%u header=%s data=%s",
+		"transaction=0x%llx card_index=%u generation=%u scode=%u dst_id=0x%04x tlabel=%u tcode=%u src_id=0x%04x rcode=%u header=%s data=%s",
 		__entry->transaction,
+		__entry->card_index,
 		__entry->generation,
 		__entry->scode,
 		ASYNC_HEADER_GET_DESTINATION(__entry->header),
-- 
2.43.0


