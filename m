Return-Path: <linux-kernel+bounces-213265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E71B1907348
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 15:15:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42CEDB21575
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 13:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA33D1448C3;
	Thu, 13 Jun 2024 13:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="JdpUn8lC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HqPOEfgc"
Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7238143C41
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 13:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718284488; cv=none; b=C2dUjHNk8CwRd6H8m4HsMcsgrEOhq5vWV2gmw0T/BbIVl2QIxXfx40WNYiVZf0886NU8cP4iaXmyI6eDjwSF/G1Pmf72CFIBd86MY8ESX3iSwv22SccvbqmngsCsBjGzeSv9P51IWk9VZ98YgiyQoG9qAAwYyVTXzjvpzlys/HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718284488; c=relaxed/simple;
	bh=vPxnk30Zd1siuecB0EfxylME7Zg+Lw/YtROsl5nnZFc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dqc95BbApvhhGXUf1PwDL4IYHXWkllw7KcxKwPGJs1cZXZdyqUMxBEuDcSTifgSZCm9rINp3ClW6/Zr+uRLt5/S+1dMvQjFipf7J1LHPAL/odPMrfpSTtxi5gSGxnf4AZXmL5aaykXXORKhozlIlUxNg+hhdpk3x8SSL8fQFQUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=JdpUn8lC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HqPOEfgc; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id DD7451140116;
	Thu, 13 Jun 2024 09:14:45 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 13 Jun 2024 09:14:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1718284485; x=
	1718370885; bh=NvQzQ47m1U5OGfyvPMSQ/8AM7Gju2h3IEllXTQfsmL0=; b=J
	dpUn8lCinPAti/1z3AaRXC2eM8IzqpM0hH9khCFIarnMriHSG47ChkNMekxTtTaN
	vJELFnO5d6D47MDBcw569ePg3UK+Fi4QGilXslv0HnteLJLAX36nRjraB+PQGgrc
	q5jz7J88wkBKDpfO9I/Tf9scns8/bM/cSKfvWTtDOG9BgQLP2UcF4UE6+h0Om36B
	cZNmEaN0gWFJSB4B+J+GpmoahmdnR6FyFcrfsFlzQ2b3TcGBXLUU8LGoMwG9LIhE
	rBYEbQweNKQfgHLB0Tkym1CcrdapEycC8wloqwfYOg6G3MgBEaMxvL/eoTckmSt1
	04hLPhPOjX+pJUvyKtV/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1718284485; x=
	1718370885; bh=NvQzQ47m1U5OGfyvPMSQ/8AM7Gju2h3IEllXTQfsmL0=; b=H
	qPOEfgcXQbBaeAEtVCT5Fk7rdzcZ3hkCI+IyP+7WKn/+uh7xziPBErRS8e98760b
	ckaokiZSAjbTbJu0TkWmaDYqkSx164Vt9yQ+cQ/g7SCbVy6SjAOoZCoT0+rOrRFj
	k0YlWvWBySkw+Z6cgFiSpTSJLWUBLnmMEAh1QkyTyC/EUTjcZwTd4KwW/qlv9bmF
	B9d+E42SsKIyz397cReb9M6OGIvON3DtXR4JOJfiwfaYiNsaKi6Zt5Y5/NTk/Ou5
	RHIfzPU5IwDVGBQEWT2WQNep6tEVJpibEsz/XoJ6Sm2LIPBR7ZV/GgDzteddm96N
	y9QjPrepyQfTMh0I9LqVA==
X-ME-Sender: <xms:xfBqZncGP4svRLI5v7UBNwpJhcsXP5HPO11JGa0vMr6-ot-3uwou_Q>
    <xme:xfBqZtPGTlnKP_jqn7bAPEc3KvBSbPvw1bOs291pzbZ-fe6v7yL0rLuvcDNeOyWpl
    0nEYIZ6AlNe_riBEsM>
X-ME-Received: <xmr:xfBqZgiSEAnnizMclsCoe9M5aNYdWS6x0t3bE-iw77It_pI-DE1JKFa8IYLAHU0lSu1G0B_fQYR_x9zE7CpS_GON8qrQMeZR01jyQKOauxfAuw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedujedgheelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghk
    rghshhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpedvjefgje
    euvdfguddukeelveetgfdtvefhtdfffeeigfevueetffeivdffkedvtdenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhise
    hsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:xfBqZo_JhJNMj_sXP2PpjpdIELxLQlm7gHoNgue3RmMszD28VvQSOQ>
    <xmx:xfBqZjsQuCp8zV5xc-GkpvRu34OjpRQKhgSTFesv-rFl-kuB_40SSw>
    <xmx:xfBqZnGHPjCGuSuNAhAqooQt_YKeVRIRdOtfBka_EJMMTHKlWy4BRg>
    <xmx:xfBqZqPCGAXChUau8omklrFcPEEMJ2ZGkWmaUYzUHuJz4h1qDDDZnw>
    <xmx:xfBqZs7JII7FS7ENQ9cuT3iXSIYHCEoHyOrrvjEcuKf5DOWDM9_U-IEp>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Jun 2024 09:14:44 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 1/8] firewire: core: record card index in tracepoinrts events derived from async_outbound_complete_template
Date: Thu, 13 Jun 2024 22:14:33 +0900
Message-ID: <20240613131440.431766-2-o-takashi@sakamocchi.jp>
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
 drivers/firewire/core-transaction.c |  6 +++---
 include/trace/events/firewire.h     | 17 ++++++++++-------
 2 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/firewire/core-transaction.c b/drivers/firewire/core-transaction.c
index 571fdff65c2b..de75e758fd07 100644
--- a/drivers/firewire/core-transaction.c
+++ b/drivers/firewire/core-transaction.c
@@ -174,8 +174,8 @@ static void transmit_complete_callback(struct fw_packet *packet,
 	struct fw_transaction *t =
 	    container_of(packet, struct fw_transaction, packet);
 
-	trace_async_request_outbound_complete((uintptr_t)t, packet->generation, packet->speed,
-					      status, packet->timestamp);
+	trace_async_request_outbound_complete((uintptr_t)t, card->index, packet->generation,
+					      packet->speed, status, packet->timestamp);
 
 	switch (status) {
 	case ACK_COMPLETE:
@@ -674,7 +674,7 @@ static void free_response_callback(struct fw_packet *packet,
 {
 	struct fw_request *request = container_of(packet, struct fw_request, response);
 
-	trace_async_response_outbound_complete((uintptr_t)request, packet->generation,
+	trace_async_response_outbound_complete((uintptr_t)request, card->index, packet->generation,
 					       packet->speed, status, packet->timestamp);
 
 	// Decrease the reference count since not at in-flight.
diff --git a/include/trace/events/firewire.h b/include/trace/events/firewire.h
index d695a560673f..ca6ea9bd1eba 100644
--- a/include/trace/events/firewire.h
+++ b/include/trace/events/firewire.h
@@ -71,10 +71,11 @@ DECLARE_EVENT_CLASS(async_outbound_initiate_template,
 
 // The value of status is one of ack codes and rcodes specific to Linux FireWire subsystem.
 DECLARE_EVENT_CLASS(async_outbound_complete_template,
-	TP_PROTO(u64 transaction, unsigned int generation, unsigned int scode, unsigned int status, unsigned int timestamp),
-	TP_ARGS(transaction, generation, scode, status, timestamp),
+	TP_PROTO(u64 transaction, unsigned int card_index, unsigned int generation, unsigned int scode, unsigned int status, unsigned int timestamp),
+	TP_ARGS(transaction, card_index, generation, scode, status, timestamp),
 	TP_STRUCT__entry(
 		__field(u64, transaction)
+		__field(u8, card_index)
 		__field(u8, generation)
 		__field(u8, scode)
 		__field(u8, status)
@@ -82,14 +83,16 @@ DECLARE_EVENT_CLASS(async_outbound_complete_template,
 	),
 	TP_fast_assign(
 		__entry->transaction = transaction;
+		__entry->card_index = card_index;
 		__entry->generation = generation;
 		__entry->scode = scode;
 		__entry->status = status;
 		__entry->timestamp = timestamp;
 	),
 	TP_printk(
-		"transaction=0x%llx generation=%u scode=%u status=%u timestamp=0x%04x",
+		"transaction=0x%llx card_index=%u generation=%u scode=%u status=%u timestamp=0x%04x",
 		__entry->transaction,
+		__entry->card_index,
 		__entry->generation,
 		__entry->scode,
 		__entry->status,
@@ -144,8 +147,8 @@ DEFINE_EVENT(async_outbound_initiate_template, async_request_outbound_initiate,
 );
 
 DEFINE_EVENT(async_outbound_complete_template, async_request_outbound_complete,
-	TP_PROTO(u64 transaction, unsigned int generation, unsigned int scode, unsigned int status, unsigned int timestamp),
-	TP_ARGS(transaction, generation, scode, status, timestamp)
+	TP_PROTO(u64 transaction, unsigned int card_index, unsigned int generation, unsigned int scode, unsigned int status, unsigned int timestamp),
+	TP_ARGS(transaction, card_index, generation, scode, status, timestamp)
 );
 
 DEFINE_EVENT(async_inbound_template, async_response_inbound,
@@ -194,8 +197,8 @@ DEFINE_EVENT_PRINT(async_outbound_initiate_template, async_response_outbound_ini
 );
 
 DEFINE_EVENT(async_outbound_complete_template, async_response_outbound_complete,
-	TP_PROTO(u64 transaction, unsigned int generation, unsigned int scode, unsigned int status, unsigned int timestamp),
-	TP_ARGS(transaction, generation, scode, status, timestamp)
+	TP_PROTO(u64 transaction, unsigned int card_index, unsigned int generation, unsigned int scode, unsigned int status, unsigned int timestamp),
+	TP_ARGS(transaction, card_index, generation, scode, status, timestamp)
 );
 
 #undef ASYNC_HEADER_GET_DESTINATION
-- 
2.43.0


