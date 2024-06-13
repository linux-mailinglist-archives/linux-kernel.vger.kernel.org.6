Return-Path: <linux-kernel+bounces-213268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A14BB907352
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 15:15:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA2381C2111E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 13:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A1AC144D2F;
	Thu, 13 Jun 2024 13:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="AuFr9FRx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DFMNXnWv"
Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC5A144D10
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 13:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718284495; cv=none; b=XFVloQL3kvmU+gdT3MDjPWA0K6J7kEbVFTx8hJphvzspB646jfu0q3XqqUbty4S+3ZSiCVVGtQmVqjzt3Sq2LfRF80CRjgOPv+WV3QhfT6r9q+pU+OirDCez5PBGoAtKfEZ5LIPJqKFER/sxnvk+rBOS517a+3v/vPTP5cUWvrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718284495; c=relaxed/simple;
	bh=7L1gd/DIa6bveNbIw8EQeC/U0pFIIXBZQ3326vb4SvM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HMQr6xf9/dB32L6TJUDXvqYE9zbjK0CD9bMwxCHSMxWOWAey3EgvVkFDxPmaRxK2zfxLimSdR+sf/ZvcH/KvbOx6xDbxU6jW/5bIWoWc7y+IInCi9so29UwYuFDvHoP3qtDhKh1GzAZRxf28xDxxrR/WPOMBGPm/srLtjDA2qcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=AuFr9FRx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DFMNXnWv; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id D50521380099;
	Thu, 13 Jun 2024 09:14:51 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 13 Jun 2024 09:14:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1718284491; x=
	1718370891; bh=a3iKFf3cgzA8fuhlXuxo5mFXhLHZpHmIQrt+HGCliT0=; b=A
	uFr9FRxT94ZornUIuVu0mtp0WshtQK4TabiCvmYdjWk2oBswq4Bp8cfq7vP7NUXI
	dBSpciW7RhAKmOPsQU0vF2Ah+276ymDh+F7IJO2161qUk9JbN19Lrq+/wR2FmVeC
	r2jr2CmqLjYI4kOOm9uAdIU8oS6Iwt01VHww1bh5bE5KKguOG7oPdeMxyVF3r3Px
	7R2NPrEhzRsz5Cx1BVahlO7heuHEcGhb828Af+b4ND0ftDXHkaJMQSgfMb8xvONW
	lgFknLDMRqiBg2MZ4ktIrOKAiLjITIhJNosGi+ddv9iaUNRjAhllGwP4ONJw/sru
	vpcddIyoWmCGQCO7HtMmw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1718284491; x=
	1718370891; bh=a3iKFf3cgzA8fuhlXuxo5mFXhLHZpHmIQrt+HGCliT0=; b=D
	FMNXnWvNeoQ8bv/xK7GsC1IMCuzZIOgQt4PedrVK7SEer/qFyHwOTX4ta9TZJ41S
	OqTvkW+NhruRmTh8YjQbA8TqXCib57vMD2M1Cdo/by1kpDqird8V4koAhXJrEUOX
	PgU81kJv9/XgfYVPe6eYTtvhanv58ZdJo1kU5kx0H2ywWm3fVf68Fog0/jRn57D7
	zX1+xcw8IMl1RZd94gUL8wPuyXSYH0C/MGVNSRn3RI/4ROEhmeOoUqwBNqNF7jly
	hsO4iFK2wFEYt7OnyniFbL7YOY0VpDBxL2cdRSEsKuPWy/HWhAxiW/03N+7CKvOr
	k0HPUbcW0lBlyV7URLjhA==
X-ME-Sender: <xms:y_BqZklUwJedKip6nKL345PjS_5hiMcdqbeUUNDdTWkmf4n0EOlBqA>
    <xme:y_BqZj2V37F3oaVWEtQhFk-MzztkN26OTN0DHATKZhmlqFBYQeHRsPLsDLE7yXRkl
    mBrGrszuhzWXi-jejk>
X-ME-Received: <xmr:y_BqZiqx4w14aBUBCSU9pkgFouDW28slZH2rZksBVUphDcP5PN0Q3aAdfGYincO6DIgp2DPKvLgUwIXTAmIPmO53Sv747I8pGZjhwln5Q958xQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedujedgiedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghk
    rghshhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpedvjefgje
    euvdfguddukeelveetgfdtvefhtdfffeeigfevueetffeivdffkedvtdenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhise
    hsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:y_BqZgmXuX6C4QMmWI4KsBKt96dpSouoUyEw9_d6BaBjklb2KkXp0A>
    <xmx:y_BqZi0pR_nKRj7qKVgaLIneraSnM4Dbx7A7-kMwUoTYoyIiRbrrug>
    <xmx:y_BqZnuSrY4j2rmticLMx9pxZCe_BpcjEHiTMgkFnsgt7bw0z209DA>
    <xmx:y_BqZuVxg9eTR3sziaCkw9D5JQQxbCGHcmFL9vNWJ1co2xezbJGPjw>
    <xmx:y_BqZgBPC_iPG8Bul_W2zHv2PnVSgzYVKKFJytN6c7qCm0CY4T3fo7C8>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Jun 2024 09:14:50 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 5/8] firewire: core: record card index in async_phy_outbound_complete tracepoints event
Date: Thu, 13 Jun 2024 22:14:37 +0900
Message-ID: <20240613131440.431766-6-o-takashi@sakamocchi.jp>
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

The asynchronous transmission of phy packet is initiated on one of 1394
OHCI controller, however the existing tracepoints events has the lack of
data about it.

This commit adds card_index member into event structure to store the index
of host controller in use, and prints it.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/core-cdev.c        | 2 +-
 drivers/firewire/core-transaction.c | 2 +-
 include/trace/events/firewire.h     | 9 ++++++---
 3 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/firewire/core-cdev.c b/drivers/firewire/core-cdev.c
index ff8739f96af5..9a7dc90330a3 100644
--- a/drivers/firewire/core-cdev.c
+++ b/drivers/firewire/core-cdev.c
@@ -1559,7 +1559,7 @@ static void outbound_phy_packet_callback(struct fw_packet *packet,
 	struct client *e_client = e->client;
 	u32 rcode;
 
-	trace_async_phy_outbound_complete((uintptr_t)packet, status, packet->generation,
+	trace_async_phy_outbound_complete((uintptr_t)packet, card->index, status, packet->generation,
 					  packet->timestamp);
 
 	switch (status) {
diff --git a/drivers/firewire/core-transaction.c b/drivers/firewire/core-transaction.c
index e522dc3d9897..bd5a467cfd60 100644
--- a/drivers/firewire/core-transaction.c
+++ b/drivers/firewire/core-transaction.c
@@ -464,7 +464,7 @@ static DECLARE_COMPLETION(phy_config_done);
 static void transmit_phy_packet_callback(struct fw_packet *packet,
 					 struct fw_card *card, int status)
 {
-	trace_async_phy_outbound_complete((uintptr_t)packet, packet->generation, status,
+	trace_async_phy_outbound_complete((uintptr_t)packet, card->index, packet->generation, status,
 					  packet->timestamp);
 	complete(&phy_config_done);
 }
diff --git a/include/trace/events/firewire.h b/include/trace/events/firewire.h
index a59dc26b2a53..61c7a2461fbc 100644
--- a/include/trace/events/firewire.h
+++ b/include/trace/events/firewire.h
@@ -244,23 +244,26 @@ TRACE_EVENT(async_phy_outbound_initiate,
 );
 
 TRACE_EVENT(async_phy_outbound_complete,
-	TP_PROTO(u64 packet, unsigned int generation, unsigned int status, unsigned int timestamp),
-	TP_ARGS(packet, generation, status, timestamp),
+	TP_PROTO(u64 packet, unsigned int card_index, unsigned int generation, unsigned int status, unsigned int timestamp),
+	TP_ARGS(packet, card_index, generation, status, timestamp),
 	TP_STRUCT__entry(
 		__field(u64, packet)
+		__field(u8, card_index)
 		__field(u8, generation)
 		__field(u8, status)
 		__field(u16, timestamp)
 	),
 	TP_fast_assign(
 		__entry->packet = packet;
+		__entry->card_index = card_index;
 		__entry->generation = generation;
 		__entry->status = status;
 		__entry->timestamp = timestamp;
 	),
 	TP_printk(
-		"packet=0x%llx generation=%u status=%u timestamp=0x%04x",
+		"packet=0x%llx card_index=%u generation=%u status=%u timestamp=0x%04x",
 		__entry->packet,
+		__entry->card_index,
 		__entry->generation,
 		__entry->status,
 		__entry->timestamp
-- 
2.43.0


