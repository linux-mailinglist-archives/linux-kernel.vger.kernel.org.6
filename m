Return-Path: <linux-kernel+bounces-213267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4890B907351
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 15:15:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FB741C20A45
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 13:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41E59144D2C;
	Thu, 13 Jun 2024 13:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="PHMMmZc7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hE0I+fm8"
Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C027D144317
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 13:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718284491; cv=none; b=kd5PIc3sjYRIBVc1d7pjAtIi7CPMhR9RtM2AorUkmBTnQUrEx7K3sa9DWKYq1HsWK0T+6yYgQVb4sgOHiZxNqxBP8tIQYtuKLsiNOTXulj+DKtDasL7QDOELe9g3bFYJaomTn+N/F1Nap/Z4B6j3v0+hgbUGzkYF4vNsonPqrpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718284491; c=relaxed/simple;
	bh=DNAd5eIRD9yZedPq+Gjt6Mq/bDz4/sayjNafIi7DlJU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V4a5RACzyyIe0BRAp3bmRoNIq7v2IAOY8HEe7BrrX+RXmo4ZEq3MrX8CWFjIAX49QXz31l/xyeU8vq6pb0UvfftXmncmgHkuDgKUfn3Q3jatTt5D6tMBrK8TTgiHFNwVU/X5Z3fBa4vOHWvEowADGDXSv0HZDTtxE19ZZVXNObs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=PHMMmZc7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hE0I+fm8; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id DEDBE13800CA;
	Thu, 13 Jun 2024 09:14:48 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 13 Jun 2024 09:14:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1718284488; x=
	1718370888; bh=BW6OLSA8eA0sNRRDy/oHw2tZ3PYVfyjw3JlPniCEi10=; b=P
	HMMmZc7O5x27VmnBb5CpUkc8rSV1X7h+YrdVHF5CWA/0XGMbElvIAB47Qn0vX9xs
	wQaMMj4yOqN4YeyHJO9LAakLhZHXdOnxyg1Mnd+NWxX8eNaYqX4+pAvLIaVzCps5
	OSjMWiD0PvJtcxHB2O1skCXdp8/ZzKTEsJj571+nuXyHirgwsQUBkdS8WV4VX8Xd
	qjrM4TUen3T63zebvRyJUnCImPxvZTiVf78wJSBsIRqOAZYzXivTbwM0QGhjj47n
	ETbLMfTxHw2JXwynP4ulmckTxUEpA0TVBgtVAv93jG+oD4DgbngL3i+l+dl4PDkS
	qnqtoOsSz9cPsz7WcutOg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1718284488; x=
	1718370888; bh=BW6OLSA8eA0sNRRDy/oHw2tZ3PYVfyjw3JlPniCEi10=; b=h
	E0I+fm8UCtfEX/OEtBOa0VydLof4+im1td8JWivHwCu379wdWhr1aUkh68LbFtCZ
	t82NT8F7XEpzBKBNmoJbw14R89riswyxzvhSU+NaHSKIsSb+7HTx9ZOFoLB6eH0M
	krW1vPcoPZTD4c/tqolVRoznIQkt111ottR15ozBViPlsQcrZmSRgLYJb8hFtRum
	WXhNu/JMbPJgA38OBDSDHxl+UwptEeQVMDrPL9mGlG4CW9tDwOWx7WQKfG0Mk3Eq
	mvZmDx5LKLdCedS+6zWlORTILnE5yd22EorCzwI8mXnJ9vDRsuj9kooL/E3QvgP3
	5qN8m7SSrWdNnDpDbd7JA==
X-ME-Sender: <xms:yPBqZtgqz0T4xPBqhjDcbtBVN2nctHhAGGpDLF1mBzwv6HYvF2Ca1g>
    <xme:yPBqZiBqyYPbfkOZAPdhDJoY9AkPaLjgoOXWAUl3woXJ_kO5eOOR5j54AMwwZ4d5d
    KWCTtowO_ZaG5OWHnI>
X-ME-Received: <xmr:yPBqZtFH-56mQUXuSGXq7GjZWcH_Sj4V5Xjij31PN7lj6eXG0Y-HsE4N4F27nF_EAuSf9oTckfIFmibYRKT4_ArUP2jtSbuMuOmr2_byUDkMzA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedujedgheelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghk
    rghshhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpedvjefgje
    euvdfguddukeelveetgfdtvefhtdfffeeigfevueetffeivdffkedvtdenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhise
    hsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:yPBqZiTGEiuGv9plWJP2B_FC-Xyk5LQWwPRc1J71NdwF39cAMH1KKw>
    <xmx:yPBqZqx5dlLDl3jupwxIEqoC28cToDWA3iu7dI77ofmMgXeqLo6_Zw>
    <xmx:yPBqZo7yOGFF06M4meXVOb0pXYYgiq6zf8HwKzqpfFcAeGCcmdMlsQ>
    <xmx:yPBqZvxrsMBx3ZUoJnoBW_G7jF_ZibBzH10YDy5WNdMetBzV1k0Z6Q>
    <xmx:yPBqZl-Qfl3SMQY9q_qdSNsbLc70d9mKGXfcKIbJ7NQoi9D4VPMAUr7->
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Jun 2024 09:14:47 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 3/8] firewire: core: record card index in tracepoinrts events derived from async_inbound_template
Date: Thu, 13 Jun 2024 22:14:35 +0900
Message-ID: <20240613131440.431766-4-o-takashi@sakamocchi.jp>
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
 drivers/firewire/core-transaction.c |  8 ++++----
 include/trace/events/firewire.h     | 20 ++++++++++++--------
 2 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/drivers/firewire/core-transaction.c b/drivers/firewire/core-transaction.c
index 3f9361d15607..3503c238f8ae 100644
--- a/drivers/firewire/core-transaction.c
+++ b/drivers/firewire/core-transaction.c
@@ -1009,8 +1009,8 @@ void fw_core_handle_request(struct fw_card *card, struct fw_packet *p)
 		return;
 	}
 
-	trace_async_request_inbound((uintptr_t)request, p->generation, p->speed, p->ack,
-				    p->timestamp, p->header, request->data,
+	trace_async_request_inbound((uintptr_t)request, card->index, p->generation, p->speed,
+				    p->ack, p->timestamp, p->header, request->data,
 				    tcode_is_read_request(tcode) ? 0 : request->length / 4);
 
 	offset = async_header_get_offset(p->header);
@@ -1080,8 +1080,8 @@ void fw_core_handle_response(struct fw_card *card, struct fw_packet *p)
 	}
 	spin_unlock_irqrestore(&card->lock, flags);
 
-	trace_async_response_inbound((uintptr_t)t, p->generation, p->speed, p->ack, p->timestamp,
-				     p->header, data, data_length / 4);
+	trace_async_response_inbound((uintptr_t)t, card->index, p->generation, p->speed, p->ack,
+				     p->timestamp, p->header, data, data_length / 4);
 
 	if (!t) {
  timed_out:
diff --git a/include/trace/events/firewire.h b/include/trace/events/firewire.h
index a3d9916cbad1..b72f613cfa02 100644
--- a/include/trace/events/firewire.h
+++ b/include/trace/events/firewire.h
@@ -105,10 +105,11 @@ DECLARE_EVENT_CLASS(async_outbound_complete_template,
 
 // The value of status is one of ack codes and rcodes specific to Linux FireWire subsystem.
 DECLARE_EVENT_CLASS(async_inbound_template,
-	TP_PROTO(u64 transaction, unsigned int generation, unsigned int scode, unsigned int status, unsigned int timestamp, const u32 *header, const u32 *data, unsigned int data_count),
-	TP_ARGS(transaction, generation, scode, status, timestamp, header, data, data_count),
+	TP_PROTO(u64 transaction, unsigned int card_index, unsigned int generation, unsigned int scode, unsigned int status, unsigned int timestamp, const u32 *header, const u32 *data, unsigned int data_count),
+	TP_ARGS(transaction, card_index, generation, scode, status, timestamp, header, data, data_count),
 	TP_STRUCT__entry(
 		__field(u64, transaction)
+		__field(u8, card_index)
 		__field(u8, generation)
 		__field(u8, scode)
 		__field(u8, status)
@@ -118,6 +119,7 @@ DECLARE_EVENT_CLASS(async_inbound_template,
 	),
 	TP_fast_assign(
 		__entry->transaction = transaction;
+		__entry->card_index = card_index;
 		__entry->generation = generation;
 		__entry->scode = scode;
 		__entry->status = status;
@@ -127,8 +129,9 @@ DECLARE_EVENT_CLASS(async_inbound_template,
 	),
 	// This format is for the response subaction.
 	TP_printk(
-		"transaction=0x%llx generation=%u scode=%u status=%u timestamp=0x%04x dst_id=0x%04x tlabel=%u tcode=%u src_id=0x%04x rcode=%u header=%s data=%s",
+		"transaction=0x%llx card_index=%u generation=%u scode=%u status=%u timestamp=0x%04x dst_id=0x%04x tlabel=%u tcode=%u src_id=0x%04x rcode=%u header=%s data=%s",
 		__entry->transaction,
+		__entry->card_index,
 		__entry->generation,
 		__entry->scode,
 		__entry->status,
@@ -155,16 +158,17 @@ DEFINE_EVENT(async_outbound_complete_template, async_request_outbound_complete,
 );
 
 DEFINE_EVENT(async_inbound_template, async_response_inbound,
-	TP_PROTO(u64 transaction, unsigned int generation, unsigned int scode, unsigned int status, unsigned int timestamp, const u32 *header, const u32 *data, unsigned int data_count),
-	TP_ARGS(transaction, generation, scode, status, timestamp, header, data, data_count)
+	TP_PROTO(u64 transaction, unsigned int card_index, unsigned int generation, unsigned int scode, unsigned int status, unsigned int timestamp, const u32 *header, const u32 *data, unsigned int data_count),
+	TP_ARGS(transaction, card_index, generation, scode, status, timestamp, header, data, data_count)
 );
 
 DEFINE_EVENT_PRINT(async_inbound_template, async_request_inbound,
-	TP_PROTO(u64 transaction, unsigned int generation, unsigned int scode, unsigned int status, unsigned int timestamp, const u32 *header, const u32 *data, unsigned int data_count),
-	TP_ARGS(transaction, generation, scode, status, timestamp, header, data, data_count),
+	TP_PROTO(u64 transaction, unsigned int card_index, unsigned int generation, unsigned int scode, unsigned int status, unsigned int timestamp, const u32 *header, const u32 *data, unsigned int data_count),
+	TP_ARGS(transaction, card_index, generation, scode, status, timestamp, header, data, data_count),
 	TP_printk(
-		"transaction=0x%llx generation=%u scode=%u status=%u timestamp=0x%04x dst_id=0x%04x tlabel=%u tcode=%u src_id=0x%04x offset=0x%012llx header=%s data=%s",
+		"transaction=0x%llx card_index=%u generation=%u scode=%u status=%u timestamp=0x%04x dst_id=0x%04x tlabel=%u tcode=%u src_id=0x%04x offset=0x%012llx header=%s data=%s",
 		__entry->transaction,
+		__entry->card_index,
 		__entry->generation,
 		__entry->scode,
 		__entry->status,
-- 
2.43.0


