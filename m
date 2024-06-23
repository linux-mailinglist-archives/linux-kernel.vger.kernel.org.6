Return-Path: <linux-kernel+bounces-226472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD862913EDC
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 00:10:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42081B21A00
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 22:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB7C31891C0;
	Sun, 23 Jun 2024 22:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="cr8kAC5S";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="m2w/O2Lz"
Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F5D187573
	for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 22:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719180558; cv=none; b=X4TH2rGMfsLzxZ1Uj3D3/sj4SDXl1p3Lwb2kginkS06JsKnTkwji26qtoEAdku6kSHTpckddgWyBhBxnxPTLgsSplzH58GKaQqcbCy6gWsRgKe8y7N4oAAJTCrlk5GwUipCqqfFpsEvrk83BI/IXsM9df8af/yTUqhHintWOeCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719180558; c=relaxed/simple;
	bh=QCgUK82MWDAlz/HQWXxZhii7gy5IIftiFfTP2ZuLnUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BgFyrgR4svzqHYRTg7cXT6XScGa0ZOGS0yF1dTRRW92RDxpPjrACbSX/XD+nkiqgC7uZ/RIFrmHA/L/U+FjbMzu0zPXq4bwOILD67gAbGA32VwlvpHCeAboV2GrA5ctlOA5eYzWtjTk9K1COjbV+DYVZvNsV/2QubODY0m6Ll/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=cr8kAC5S; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=m2w/O2Lz; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id 2CE3C1380223;
	Sun, 23 Jun 2024 18:09:16 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Sun, 23 Jun 2024 18:09:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1719180556; x=
	1719266956; bh=SbytbCOXN4nSm+jv3TMP9PFpjfKgobFm/O7hJMPsTzI=; b=c
	r8kAC5SCVHYxDqnXRStkbHyGSblKdYnjcaEDQtnaUF0J2w/5pTrwzFP6wcst/J3g
	i7dUMSs5+X5EN6gsw2B45Lqgld17NxutYPkUj7UfTrulQZu/+ZtXhrZu84WzuI6r
	+DHK/7vKSqvVuoyTKpTUzhqnLY6Lkb1p7hZRy3AkhH5CqP5TpviHbY/SUcHWjHm0
	XTOScLx5hdy1LRTxlKy2gTS1laiilSGoy7e96xloEMqATdIC08+NLPLWO7xjh+Wk
	LR4dURf6I5SOjYCvrsTwGNkfGOEX5GpEqazZzGzWWr39n3WNGvx5DZ2K9W+eTBfA
	FC+Ygm/Ckw/03VIWnEzLQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1719180556; x=
	1719266956; bh=SbytbCOXN4nSm+jv3TMP9PFpjfKgobFm/O7hJMPsTzI=; b=m
	2w/O2LzPTudsaeGdGuw71cvMaiYS/19PzzdwsflrLljs1Ccq+9+V3q3RhAjOfJRN
	Fy6nuzcoydoVHDBcDrUPvWiMaa5f4DHzbho3xrMto2hdDt0baIZb9cIxTVWS+viI
	RiytrToH5BT4j7+aNAsJ0zBOzYBKYS4A3a3TZ9x43fqTq9XhfJvdBuDeMvE7tVYy
	SUzgsu+uI4cwp+qaoEJ1hPUPb1GBdOWOtWibkOx1uo+M7i5ODzMKKdsZl4B97l+o
	M9nqPc28f5LjHYDLXVTIGenpSqAYeWu6UqDjAqMXDH98xzWst/7bsvUcIpuzrlmv
	/aOfGVMyAXOO1mT65p6dQ==
X-ME-Sender: <xms:C514ZvrxLQsSozj_yA6Yry_zjdPJLIS4BxshfogtGPodUk6DAAMhyQ>
    <xme:C514Zpq_ZDDpkSRq7oyB9xHfnoVv5McEmrg1-5JOEphOTltZWL8eg7osa1LxmRjqt
    gKBJ9FJGGzvtRCcy7U>
X-ME-Received: <xmr:C514ZsNIYkSFDYvMMEbqKbm6T5fsIPTCeNirrGFAANFn25O8Ik4zhZzFdQFdZdTFM9lYNiD5uIlbqIEVDmT0BhyPx5KauD8A9P_Ww3Zenhcf>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeegtddgtdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghk
    rghshhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpeeufedtge
    fhvdettefhgffhgedttdekveejudefledtgeekjedtgedthfeljedvleenucffohhmrghi
    nheptggrlhhlsggrtghkrdhstgdptggrlhhlsggrtghkrdhmtgenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhisehsrghk
    rghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:DJ14Zi6Z392curT0bWbMOTT31-cyqPUOqw5AoKVui4CYJ7XSBobyrg>
    <xmx:DJ14Zu5Qf7Ip4u1mkN9iwpYfSuGuLcC1y41ISktkvF8hT4XKjjQDZg>
    <xmx:DJ14ZqjlOeM-sguEkl1jH8uYqlkfD-MafwRPY1DX6FvI-bna06eUdA>
    <xmx:DJ14Zg5KeZ1OCpdxsUPvNFNNB0Ro5fC0YXUbotPw5wbKRCbvRNtqgQ>
    <xmx:DJ14ZuFN3lYqN5IY8mXAXsCzNeGODbrWt_UPWxc_4HKyIqEF84OPWaGW>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 23 Jun 2024 18:09:14 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 7/7] firewire: core: add tracepoints events for completions of packets in isochronous context
Date: Mon, 24 Jun 2024 07:08:58 +0900
Message-ID: <20240623220859.851685-8-o-takashi@sakamocchi.jp>
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

It is helpful to trace completion of packets in isochronous context when
the core function is requested them by both in-kernel units driver and
userspace applications.

This commit adds some tracepoints events for the aim.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/core-trace.c   |  4 ++
 drivers/firewire/ohci.c         | 23 +++++++---
 include/trace/events/firewire.h | 78 +++++++++++++++++++++++++++++++++
 3 files changed, 99 insertions(+), 6 deletions(-)

diff --git a/drivers/firewire/core-trace.c b/drivers/firewire/core-trace.c
index c9bc4990d66e..5acb02c18a47 100644
--- a/drivers/firewire/core-trace.c
+++ b/drivers/firewire/core-trace.c
@@ -20,4 +20,8 @@ void copy_port_status(u8 *port_status, unsigned int port_capacity,
 			self_id_sequence_get_port_status(self_id_sequence, quadlet_count, port_index);
 	}
 }
+
+EXPORT_TRACEPOINT_SYMBOL_GPL(isoc_inbound_single_completions);
+EXPORT_TRACEPOINT_SYMBOL_GPL(isoc_inbound_multiple_completions);
+EXPORT_TRACEPOINT_SYMBOL_GPL(isoc_outbound_completions);
 #endif
diff --git a/drivers/firewire/ohci.c b/drivers/firewire/ohci.c
index f35d6e193bcb..bdb206157118 100644
--- a/drivers/firewire/ohci.c
+++ b/drivers/firewire/ohci.c
@@ -2833,8 +2833,13 @@ static void ohci_write_csr(struct fw_card *card, int csr_offset, u32 value)
 	}
 }
 
-static void flush_iso_completions(struct iso_context *ctx)
+static void flush_iso_completions(struct iso_context *ctx, enum fw_iso_context_completions_cause cause)
 {
+	trace_isoc_inbound_single_completions(&ctx->base, ctx->last_timestamp, cause, ctx->header,
+					      ctx->header_length);
+	trace_isoc_outbound_completions(&ctx->base, ctx->last_timestamp, cause, ctx->header,
+					ctx->header_length);
+
 	ctx->base.callback.sc(&ctx->base, ctx->last_timestamp,
 			      ctx->header_length, ctx->header,
 			      ctx->base.callback_data);
@@ -2848,7 +2853,7 @@ static void copy_iso_headers(struct iso_context *ctx, const u32 *dma_hdr)
 	if (ctx->header_length + ctx->base.header_size > PAGE_SIZE) {
 		if (ctx->base.drop_overflow_headers)
 			return;
-		flush_iso_completions(ctx);
+		flush_iso_completions(ctx, FW_ISO_CONTEXT_COMPLETIONS_CAUSE_HEADER_OVERFLOW);
 	}
 
 	ctx_hdr = ctx->header + ctx->header_length;
@@ -2897,7 +2902,7 @@ static int handle_ir_packet_per_buffer(struct context *context,
 	copy_iso_headers(ctx, (u32 *) (last + 1));
 
 	if (last->control & cpu_to_le16(DESCRIPTOR_IRQ_ALWAYS))
-		flush_iso_completions(ctx);
+		flush_iso_completions(ctx, FW_ISO_CONTEXT_COMPLETIONS_CAUSE_IRQ);
 
 	return 1;
 }
@@ -2932,6 +2937,9 @@ static int handle_ir_buffer_fill(struct context *context,
 				      completed, DMA_FROM_DEVICE);
 
 	if (last->control & cpu_to_le16(DESCRIPTOR_IRQ_ALWAYS)) {
+		trace_isoc_inbound_multiple_completions(&ctx->base, completed,
+							FW_ISO_CONTEXT_COMPLETIONS_CAUSE_IRQ);
+
 		ctx->base.callback.mc(&ctx->base,
 				      buffer_dma + completed,
 				      ctx->base.callback_data);
@@ -2948,6 +2956,9 @@ static void flush_ir_buffer_fill(struct iso_context *ctx)
 				      ctx->mc_buffer_bus & ~PAGE_MASK,
 				      ctx->mc_completed, DMA_FROM_DEVICE);
 
+	trace_isoc_inbound_multiple_completions(&ctx->base, ctx->mc_completed,
+						FW_ISO_CONTEXT_COMPLETIONS_CAUSE_FLUSH);
+
 	ctx->base.callback.mc(&ctx->base,
 			      ctx->mc_buffer_bus + ctx->mc_completed,
 			      ctx->base.callback_data);
@@ -3012,7 +3023,7 @@ static int handle_it_packet(struct context *context,
 	if (ctx->header_length + 4 > PAGE_SIZE) {
 		if (ctx->base.drop_overflow_headers)
 			return 1;
-		flush_iso_completions(ctx);
+		flush_iso_completions(ctx, FW_ISO_CONTEXT_COMPLETIONS_CAUSE_HEADER_OVERFLOW);
 	}
 
 	ctx_hdr = ctx->header + ctx->header_length;
@@ -3023,7 +3034,7 @@ static int handle_it_packet(struct context *context,
 	ctx->header_length += 4;
 
 	if (last->control & cpu_to_le16(DESCRIPTOR_IRQ_ALWAYS))
-		flush_iso_completions(ctx);
+		flush_iso_completions(ctx, FW_ISO_CONTEXT_COMPLETIONS_CAUSE_IRQ);
 
 	return 1;
 }
@@ -3588,7 +3599,7 @@ static int ohci_flush_iso_completions(struct fw_iso_context *base)
 		case FW_ISO_CONTEXT_TRANSMIT:
 		case FW_ISO_CONTEXT_RECEIVE:
 			if (ctx->header_length != 0)
-				flush_iso_completions(ctx);
+				flush_iso_completions(ctx, FW_ISO_CONTEXT_COMPLETIONS_CAUSE_FLUSH);
 			break;
 		case FW_ISO_CONTEXT_RECEIVE_MULTICHANNEL:
 			if (ctx->mc_completed != 0)
diff --git a/include/trace/events/firewire.h b/include/trace/events/firewire.h
index 0381b3ca4d0e..d9158a134beb 100644
--- a/include/trace/events/firewire.h
+++ b/include/trace/events/firewire.h
@@ -821,6 +821,84 @@ TRACE_EVENT_CONDITION(isoc_inbound_multiple_queue,
 #undef TP_STRUCT__entry_iso_packet
 #undef TP_fast_assign_iso_packet
 
+#ifndef show_cause
+enum fw_iso_context_completions_cause {
+	FW_ISO_CONTEXT_COMPLETIONS_CAUSE_FLUSH = 0,
+	FW_ISO_CONTEXT_COMPLETIONS_CAUSE_IRQ,
+	FW_ISO_CONTEXT_COMPLETIONS_CAUSE_HEADER_OVERFLOW,
+};
+#define show_cause(cause) 								\
+	__print_symbolic(cause,								\
+		{ FW_ISO_CONTEXT_COMPLETIONS_CAUSE_FLUSH, "FLUSH" },			\
+		{ FW_ISO_CONTEXT_COMPLETIONS_CAUSE_IRQ, "IRQ" },			\
+		{ FW_ISO_CONTEXT_COMPLETIONS_CAUSE_HEADER_OVERFLOW, "HEADER_OVERFLOW" }	\
+	)
+#endif
+
+DECLARE_EVENT_CLASS(isoc_single_completions_template,
+	TP_PROTO(const struct fw_iso_context *ctx, u16 timestamp, enum fw_iso_context_completions_cause cause, const u32 *header, unsigned int header_length),
+	TP_ARGS(ctx, timestamp, cause, header, header_length),
+	TP_STRUCT__entry(
+		__field(u64, context)
+		__field(u8, card_index)
+		__field(u16, timestamp)
+		__field(u8, cause)
+		__dynamic_array(u32, header, header_length / QUADLET_SIZE)
+	),
+	TP_fast_assign(
+		__entry->context = (uintptr_t)ctx;
+		__entry->card_index = ctx->card->index;
+		__entry->timestamp = timestamp;
+		__entry->cause = cause;
+		memcpy(__get_dynamic_array(header), header, __get_dynamic_array_len(header));
+	),
+	TP_printk(
+		"context=0x%llx card_index=%u timestap=0x%04x cause=%s header=%s",
+		__entry->context,
+		__entry->card_index,
+		__entry->timestamp,
+		show_cause(__entry->cause),
+		__print_array(__get_dynamic_array(header),
+			      __get_dynamic_array_len(header) / QUADLET_SIZE, QUADLET_SIZE)
+	)
+)
+
+DEFINE_EVENT_CONDITION(isoc_single_completions_template, isoc_outbound_completions,
+	TP_PROTO(const struct fw_iso_context *ctx, u16 timestamp, enum fw_iso_context_completions_cause cause, const u32 *header, unsigned int header_length),
+	TP_ARGS(ctx, timestamp, cause, header, header_length),
+	TP_CONDITION(ctx->type == FW_ISO_CONTEXT_TRANSMIT)
+);
+
+DEFINE_EVENT_CONDITION(isoc_single_completions_template, isoc_inbound_single_completions,
+	TP_PROTO(const struct fw_iso_context *ctx, u16 timestamp, enum fw_iso_context_completions_cause cause, const u32 *header, unsigned int header_length),
+	TP_ARGS(ctx, timestamp, cause, header, header_length),
+	TP_CONDITION(ctx->type == FW_ISO_CONTEXT_RECEIVE)
+);
+
+TRACE_EVENT(isoc_inbound_multiple_completions,
+	TP_PROTO(const struct fw_iso_context *ctx, unsigned int completed, enum fw_iso_context_completions_cause cause),
+	TP_ARGS(ctx, completed, cause),
+	TP_STRUCT__entry(
+		__field(u64, context)
+		__field(u8, card_index)
+		__field(u16, completed)
+		__field(u8, cause)
+	),
+	TP_fast_assign(
+		__entry->context = (uintptr_t)ctx;
+		__entry->card_index = ctx->card->index;
+		__entry->completed = completed;
+		__entry->cause = cause;
+	),
+	TP_printk(
+		"context=0x%llx card_index=%u comleted=%u cause=%s",
+		__entry->context,
+		__entry->card_index,
+		__entry->completed,
+		show_cause(__entry->cause)
+	)
+);
+
 #undef QUADLET_SIZE
 
 #endif // _FIREWIRE_TRACE_EVENT_H
-- 
2.43.0


