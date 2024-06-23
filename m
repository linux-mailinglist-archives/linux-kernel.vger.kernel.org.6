Return-Path: <linux-kernel+bounces-226471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 275EA913EDB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 00:10:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4ABD31C2095F
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 22:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BF421891A8;
	Sun, 23 Jun 2024 22:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="NPryTV9r";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="o8A1V56X"
Received: from fhigh6-smtp.messagingengine.com (fhigh6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99EC018754B
	for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 22:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719180557; cv=none; b=TTE0QUg80UOp/w06SePgLzvcvKiNrGDJvtsaY2v9Qf1cGTc9jL8AZ3K3b6lcTPpw7mU8ijFkQtQim76kyF8Og2sJiuIWdKXWifvYXQZHhZzLLDoYI4HiRveGTRFD032LuXl8VtrpAtK285Ch8lmvetZRNKLM/2mMQQOHx2RRdHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719180557; c=relaxed/simple;
	bh=v252W92RzXy8ORK5dMJxqUSL0uBdYHFGHrhFVPRouig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=glYTAJHnIpdXAyyZ9KtB4xZqH+tJkiRQZv9BWViq2Ol2UgdutvicuCUG4n4Q5RhKvXmT4T1H7JQVU/wJwAnm3/p7La9PU8wJmoKI1Qsee430n+zNVNrcUlj/cltvkgUtBYkE+0uXwxOO8dfMBactDovFUumGtEChOkA28GApQ2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=NPryTV9r; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=o8A1V56X; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id A0963114011D;
	Sun, 23 Jun 2024 18:09:14 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Sun, 23 Jun 2024 18:09:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1719180554; x=
	1719266954; bh=5fRKzoSigHUcRzL6hQHux4tv35XsJTJ3RfGKgiIvETE=; b=N
	PryTV9rG7lIrRx0eVKEz58uKC/DwC6x40hqXqI06BwttE2x8IZ2CBmjcPgMYWmjk
	LgfBlpeeyuQFCK+0MxVlQbo1ufQBL+dn5CiHMrE4VkaPkHWSgE7l21obGr6OlshJ
	OUrxqTRNJxMeWTjAEawgl7HpgIGycKTdpdroKFTAaV58ECYVZLT1/I2VU5J/szut
	iXk+/oB7D/l20O/SBSfWfqDWz+Doq91iLsbMdWCDnT/Qc219jn7KXFC4StPcNvIw
	VowC6EiIQbkgEXpvEUanI1dgEdyZxm916Lp5ZuwiWvmEG2qEyVWDURfLx2YoViSK
	x/1OEf8voKnD3M77l3Z0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1719180554; x=
	1719266954; bh=5fRKzoSigHUcRzL6hQHux4tv35XsJTJ3RfGKgiIvETE=; b=o
	8A1V56XedFurg9Vf+oYtF1DYxuCyDovNA3rRxp2LIQGpl3E3TfCJufr8WVAB+E+I
	lHwKuyZzPAll8Pl91wRAKavTl4L3KFMPdrFiCw13x5tS1ulxKqwY/I3KoRI3160q
	Hs/Jiq2kbjpsanaj6ygnWJGfJ736YBbtNY9JMxkJPvC3IQ07r0nkVFOPK15BoNwW
	DEg/xN12W05BDK17mPqhUBV+mY5b9MWE48R5XAiVS93vnvX9Ln41lmzPbVAFTigL
	D6Jzl0gRDzoTh/5hExfyGjoTAlKuzN0yNdwLtWPdAhfpptzmZOyJP+rBn8aHbE45
	2Zy/baX37yXiDdbMeu7rg==
X-ME-Sender: <xms:Cp14ZuCFV8RxIC6uqs2m09hsLoMLr1phM4odEhcumlW6qL8iD5sjZw>
    <xme:Cp14ZohcAS5_w3S875zVnqwb8Ey-qyGblpxxSos8Zp9C7faSl-1Qz2KKfRriSGVnp
    J6HGG_iMBUsaT7hP_M>
X-ME-Received: <xmr:Cp14ZhnudgQZtk3so7ANdB8PuyPsGwSk7g6w6LwJegyn0td4GsQJOTFVyu-ftSgbYJAF6UwdhN-cuIpNdptv8M9sCqNMUMyhfb-mP087N8nj>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeegtddgtdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghk
    rghshhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpedvjefgje
    euvdfguddukeelveetgfdtvefhtdfffeeigfevueetffeivdffkedvtdenucevlhhushht
    vghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhise
    hsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:Cp14ZsxCfTLe0VZwCIYlk_3NAVqZb81mQMdwJ989U1j7efdVkaJ3ow>
    <xmx:Cp14ZjR9rMEMYD2CV1jvEtdPlbu0lDp82AkVffsGvCqXj7O1eqXC8g>
    <xmx:Cp14ZnajxHP3E9j89hR7w2rPsca_2ee6jX5DBVNQWULXjGnj_xU4Ow>
    <xmx:Cp14ZsQu-2ySmpZz9EOug_foQcdyp0Y_8cZeRS6HQr7Z8ZB-6dVRWQ>
    <xmx:Cp14Zud8Tjqm-gUS_JSGArSibLo_PMrNO-8l1Krx0YvDzZLPLsYO-N9v>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 23 Jun 2024 18:09:13 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 6/7] firewire: core: add tracepoints events for queueing packets of isochronous context
Date: Mon, 24 Jun 2024 07:08:57 +0900
Message-ID: <20240623220859.851685-7-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240623220859.851685-1-o-takashi@sakamocchi.jp>
References: <20240623220859.851685-1-o-takashi@sakamocchi.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It is helpful to trace the queueing packets of isochronous context when
the core function is requested them by both in-kernel unit drivers and
userspace applications.

This commit adds some tracepoints events for the aim.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/core-iso.c     |  4 ++
 include/trace/events/firewire.h | 79 +++++++++++++++++++++++++++++++++
 2 files changed, 83 insertions(+)

diff --git a/drivers/firewire/core-iso.c b/drivers/firewire/core-iso.c
index 93ca0dec1805..b3eda38a36f3 100644
--- a/drivers/firewire/core-iso.c
+++ b/drivers/firewire/core-iso.c
@@ -191,6 +191,10 @@ int fw_iso_context_queue(struct fw_iso_context *ctx,
 			 struct fw_iso_buffer *buffer,
 			 unsigned long payload)
 {
+	trace_isoc_outbound_queue(ctx, payload, packet);
+	trace_isoc_inbound_single_queue(ctx, payload, packet);
+	trace_isoc_inbound_multiple_queue(ctx, payload, packet);
+
 	return ctx->card->driver->queue_iso(ctx, packet, buffer, payload);
 }
 EXPORT_SYMBOL(fw_iso_context_queue);
diff --git a/include/trace/events/firewire.h b/include/trace/events/firewire.h
index ad1546120aa3..0381b3ca4d0e 100644
--- a/include/trace/events/firewire.h
+++ b/include/trace/events/firewire.h
@@ -742,6 +742,85 @@ DEFINE_EVENT_CONDITION(isoc_flush_completions_template, isoc_inbound_multiple_fl
 	TP_CONDITION(ctx->type == FW_ISO_CONTEXT_RECEIVE_MULTICHANNEL)
 );
 
+#define TP_STRUCT__entry_iso_packet(ctx, buffer_offset, packet)				\
+	TP_STRUCT__entry(								\
+		__field(u64, context)							\
+		__field(u8, card_index)							\
+		__field(u32, buffer_offset)						\
+		__field(bool, interrupt)						\
+		__field(bool, skip)							\
+		__field(u8, sy)								\
+		__field(u8, tag)							\
+		__dynamic_array(u32, header, packet->header_length / QUADLET_SIZE)	\
+	)
+
+#define TP_fast_assign_iso_packet(ctx, buffer_offset, packet)		\
+	TP_fast_assign(							\
+		__entry->context = (uintptr_t)ctx;			\
+		__entry->card_index = ctx->card->index;			\
+		__entry->buffer_offset = buffer_offset;			\
+		__entry->interrupt = packet->interrupt;			\
+		__entry->skip = packet->skip;				\
+		__entry->sy = packet->sy;				\
+		__entry->tag = packet->tag;				\
+		memcpy(__get_dynamic_array(header), packet->header,	\
+		       __get_dynamic_array_len(header));		\
+	)
+
+TRACE_EVENT_CONDITION(isoc_outbound_queue,
+	TP_PROTO(const struct fw_iso_context *ctx, unsigned long buffer_offset, const struct fw_iso_packet *packet),
+	TP_ARGS(ctx, buffer_offset, packet),
+	TP_CONDITION(ctx->type == FW_ISO_CONTEXT_TRANSMIT),
+	TP_STRUCT__entry_iso_packet(ctx, buffer_offset, packet),
+	TP_fast_assign_iso_packet(ctx, buffer_offset, packet),
+	TP_printk(
+		"context=0x%llx card_index=%u buffer_offset=0x%x interrupt=%s skip=%s sy=%d tag=%u header=%s",
+		__entry->context,
+		__entry->card_index,
+		__entry->buffer_offset,
+		__entry->interrupt ? "true" : "false",
+		__entry->skip ? "true" : "false",
+		__entry->sy,
+		__entry->tag,
+		__print_array(__get_dynamic_array(header),
+			      __get_dynamic_array_len(header) / QUADLET_SIZE, QUADLET_SIZE)
+	)
+);
+
+TRACE_EVENT_CONDITION(isoc_inbound_single_queue,
+	TP_PROTO(const struct fw_iso_context *ctx, unsigned long buffer_offset, const struct fw_iso_packet *packet),
+	TP_ARGS(ctx, buffer_offset, packet),
+	TP_CONDITION(ctx->type == FW_ISO_CONTEXT_RECEIVE),
+	TP_STRUCT__entry_iso_packet(ctx, buffer_offset, packet),
+	TP_fast_assign_iso_packet(ctx, buffer_offset, packet),
+	TP_printk(
+		"context=0x%llx card_index=%u buffer_offset=0x%x interrupt=%s skip=%s",
+		__entry->context,
+		__entry->card_index,
+		__entry->buffer_offset,
+		__entry->interrupt ? "true" : "false",
+		__entry->skip ? "true" : "false"
+	)
+);
+
+TRACE_EVENT_CONDITION(isoc_inbound_multiple_queue,
+	TP_PROTO(const struct fw_iso_context *ctx, unsigned long buffer_offset, const struct fw_iso_packet *packet),
+	TP_ARGS(ctx, buffer_offset, packet),
+	TP_CONDITION(ctx->type == FW_ISO_CONTEXT_RECEIVE_MULTICHANNEL),
+	TP_STRUCT__entry_iso_packet(ctx, buffer_offset, packet),
+	TP_fast_assign_iso_packet(ctx, buffer_offset, packet),
+	TP_printk(
+		"context=0x%llx card_index=%u buffer_offset=0x%x interrupt=%s",
+		__entry->context,
+		__entry->card_index,
+		__entry->buffer_offset,
+		__entry->interrupt ? "true" : "false"
+	)
+);
+
+#undef TP_STRUCT__entry_iso_packet
+#undef TP_fast_assign_iso_packet
+
 #undef QUADLET_SIZE
 
 #endif // _FIREWIRE_TRACE_EVENT_H
-- 
2.43.0


