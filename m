Return-Path: <linux-kernel+bounces-226466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C58B8913ECE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 00:09:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27E71B21948
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 22:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E31C5185E61;
	Sun, 23 Jun 2024 22:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="bL4dBHfY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="svkd+hGR"
Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D84718508D
	for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 22:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719180549; cv=none; b=evBssix/WgJWk4IqUdNiWJZe07hAg+AcR2IUiJLiKnnWstLvAXGo6tMNWrhwxcvI9KZQdiHUPOdH4q6hHwIkB9P6R9Aq3FIqK6XWDHKjzn8XMYAaKDieLdtLlh5TzoHQD6w99kP1ymosQ9zpCOn1rluS5+S2eagbNJ3BwshN+GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719180549; c=relaxed/simple;
	bh=XJFw1xMnMXR2LHmRhzOLGhcnU619r3UCq1C7J9NU/xw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nI8mzT8EwB+r+wbNEd7tBL/eqHNJVqdbFaQrPPbPOvZDf9S6QFrQFlnKPkXSbUpO9NOZtEg08mbz1irjflSdkwT867jQ1VWX9ktYEf6O99sBfA0V5txwoDIDCsIj5hU3j21b2v2e7F/fg/K+kGbxbQ4yirJgrLrtytEsgLEOV5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=bL4dBHfY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=svkd+hGR; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id 87C7C1380230;
	Sun, 23 Jun 2024 18:09:06 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Sun, 23 Jun 2024 18:09:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1719180546; x=
	1719266946; bh=4jv+vH9w4muGcg/CaV1mNrjjlpC8b6fJLqUg5lO7nd8=; b=b
	L4dBHfY9jNVzuFy/lfbTazdIWgx4o/l7Bx2VpdSJiZtB+kAVAVAADr8ahUNyWRqp
	aF69/jKl2M0Iv+Kb35ZFMUti2MrCZgPdXzpjCXs+6Q+QUMhsXD1INtIhhiioIGQV
	ilsS0YCeOHuHGKZrC/S8S30ge+Ik4A36/n6N8qTnCljkctBwXmbxovq5I2jYUNwL
	WbjMIL4axQT5LN4eji9AiHkz0pa9RKpXU6+er6UtFvy16yYqv8lZ3Ob8+XEjS3yr
	g1NC/WRnWQ4iw0Zm2zg2aLrcLTEEvjBkTsgmmw8ZNNl8p9rx1PiCK7lpx2VtxkFb
	ZVdWhln/AxbRaN+iWkg+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1719180546; x=
	1719266946; bh=4jv+vH9w4muGcg/CaV1mNrjjlpC8b6fJLqUg5lO7nd8=; b=s
	vkd+hGRkKbx5V8pLbMMmTF6WW/Lr1SdFfsApmPP6pp3DgN5I4sS2swc++xyaAobC
	VUXcHWzaADMZAiBd3S7i90caufHSWBbP6P7ljUcDCSIVCBbhqDZlcS9x9NO3NiuS
	xq4s8CStvlgW2FoaPW80HYA4ijLQAnktQvvKafbb3m/F0IfZf704N2enA3beD2wv
	SuQkPGlol2Om9GMA42iAOOcVMa6K/Y4yaRAcc7bmyQklD2lEc7LxNq4hNGMmV96B
	mgUOn858WZYj9FvAYJMiiJWcn1Vd+OivjiOSEeLZALaqnYjh9Il5dNprEHFsH4ZO
	orJmoxw20qDdsY9iKlOKQ==
X-ME-Sender: <xms:Ap14Zi2cAnuk8awYDFcQ-GVB2o_PbgDD5VCV6DGbVmd2dqTA2EcyqA>
    <xme:Ap14ZlEJ3_-BLDhxIusJh8RbEeL7ad6Fq6ylbmmW3f5poQgCVlF8KJsbHIGzDKl7p
    h8n5J6M2pCNMjWg83U>
X-ME-Received: <xmr:Ap14Zq4VYiB_RE2Psh7Q-DU7OzezyGeJZOgr2K9gW33T_nrjDRNwiivIxBQqaeN1lokWglSq59SOkfD61twpBq2GLrFUZxfusurs1LA7Wuh->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeegtddgtdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghk
    rghshhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpedvjefgje
    euvdfguddukeelveetgfdtvefhtdfffeeigfevueetffeivdffkedvtdenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhise
    hsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:Ap14Zj37iA4C9T1Sm9fxMYEzMaVXXPabnEf1d1vx5GVq27y5AnuOyA>
    <xmx:Ap14ZlGLiwBy8QOofg-aWHkmXX0HgmrE7cGWusD42K_oOFKcnnEw7Q>
    <xmx:Ap14Zs-zJ8jkopzkiysGgcKTkinzzipKX03eD_SOR_SnqHY-Gr5cPg>
    <xmx:Ap14Zqka5ZsvkzEoDdn-RqaY60ReZJo8IkS18t7vrq0iLuzkyjgQzg>
    <xmx:Ap14ZqRRBOx7QRUP4f2QtkN8VI7Iyc6ASsYZUuX2yf-LKeHT-kvqr6ie>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 23 Jun 2024 18:09:05 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 1/7] firewire: core: add tracepoints events for allocation/deallocation of isochronous context
Date: Mon, 24 Jun 2024 07:08:52 +0900
Message-ID: <20240623220859.851685-2-o-takashi@sakamocchi.jp>
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

It is helpful to trace the allocation and dealocation of isochronous
when the core function is requested them by both in-kernel unit drivers
and userspace applications.

This commit adds some tracepoints events for the aim.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/core-iso.c     |  10 +++
 include/trace/events/firewire.h | 105 ++++++++++++++++++++++++++++++++
 2 files changed, 115 insertions(+)

diff --git a/drivers/firewire/core-iso.c b/drivers/firewire/core-iso.c
index af70e74f9a7e..ddb999297c72 100644
--- a/drivers/firewire/core-iso.c
+++ b/drivers/firewire/core-iso.c
@@ -22,6 +22,8 @@
 
 #include "core.h"
 
+#include <trace/events/firewire.h>
+
 /*
  * Isochronous DMA context management
  */
@@ -148,12 +150,20 @@ struct fw_iso_context *fw_iso_context_create(struct fw_card *card,
 	ctx->callback.sc = callback;
 	ctx->callback_data = callback_data;
 
+	trace_isoc_outbound_allocate(ctx, channel, speed);
+	trace_isoc_inbound_single_allocate(ctx, channel, header_size);
+	trace_isoc_inbound_multiple_allocate(ctx);
+
 	return ctx;
 }
 EXPORT_SYMBOL(fw_iso_context_create);
 
 void fw_iso_context_destroy(struct fw_iso_context *ctx)
 {
+	trace_isoc_outbound_destroy(ctx);
+	trace_isoc_inbound_single_destroy(ctx);
+	trace_isoc_inbound_multiple_destroy(ctx);
+
 	ctx->card->driver->free_iso_context(ctx);
 }
 EXPORT_SYMBOL(fw_iso_context_destroy);
diff --git a/include/trace/events/firewire.h b/include/trace/events/firewire.h
index 25289a063deb..0cca1ef841f3 100644
--- a/include/trace/events/firewire.h
+++ b/include/trace/events/firewire.h
@@ -436,6 +436,111 @@ TRACE_EVENT(self_id_sequence,
 #undef PHY_PACKET_SELF_ID_GET_POWER_CLASS
 #undef PHY_PACKET_SELF_ID_GET_INITIATED_RESET
 
+TRACE_EVENT_CONDITION(isoc_outbound_allocate,
+	TP_PROTO(const struct fw_iso_context *ctx, unsigned int channel, unsigned int scode),
+	TP_ARGS(ctx, channel, scode),
+	TP_CONDITION(ctx->type == FW_ISO_CONTEXT_TRANSMIT),
+	TP_STRUCT__entry(
+		__field(u64, context)
+		__field(u8, card_index)
+		__field(u8, channel)
+		__field(u8, scode)
+	),
+	TP_fast_assign(
+		__entry->context = (uintptr_t)ctx;
+		__entry->card_index = ctx->card->index;
+		__entry->channel = channel;
+		__entry->scode = scode;
+	),
+	TP_printk(
+		"context=0x%llx card_index=%u channel=%u scode=%u",
+		__entry->context,
+		__entry->card_index,
+		__entry->channel,
+		__entry->scode
+	)
+);
+
+TRACE_EVENT_CONDITION(isoc_inbound_single_allocate,
+	TP_PROTO(const struct fw_iso_context *ctx, unsigned int channel, unsigned int header_size),
+	TP_ARGS(ctx, channel, header_size),
+	TP_CONDITION(ctx->type == FW_ISO_CONTEXT_RECEIVE),
+	TP_STRUCT__entry(
+		__field(u64, context)
+		__field(u8, card_index)
+		__field(u8, channel)
+		__field(u8, header_size)
+	),
+	TP_fast_assign(
+		__entry->context = (uintptr_t)ctx;
+		__entry->card_index = ctx->card->index;
+		__entry->channel = channel;
+		__entry->header_size = header_size;
+	),
+	TP_printk(
+		"context=0x%llx card_index=%u channel=%u header_size=%u",
+		__entry->context,
+		__entry->card_index,
+		__entry->channel,
+		__entry->header_size
+	)
+);
+
+TRACE_EVENT_CONDITION(isoc_inbound_multiple_allocate,
+	TP_PROTO(const struct fw_iso_context *ctx),
+	TP_ARGS(ctx),
+	TP_CONDITION(ctx->type == FW_ISO_CONTEXT_RECEIVE_MULTICHANNEL),
+	TP_STRUCT__entry(
+		__field(u64, context)
+		__field(u8, card_index)
+	),
+	TP_fast_assign(
+		__entry->context = (uintptr_t)ctx;
+		__entry->card_index = ctx->card->index;
+	),
+	TP_printk(
+		"context=0x%llx card_index=%u",
+		__entry->context,
+		__entry->card_index
+	)
+);
+
+DECLARE_EVENT_CLASS(isoc_destroy_template,
+	TP_PROTO(const struct fw_iso_context *ctx),
+	TP_ARGS(ctx),
+	TP_STRUCT__entry(
+		__field(u64, context)
+		__field(u8, card_index)
+	),
+	TP_fast_assign(
+		__entry->context = (uintptr_t)ctx;
+		__entry->card_index = ctx->card->index;
+	),
+	TP_printk(
+		"context=0x%llx card_index=%u",
+		__entry->context,
+		__entry->card_index
+	)
+)
+
+DEFINE_EVENT_CONDITION(isoc_destroy_template, isoc_outbound_destroy,
+	TP_PROTO(const struct fw_iso_context *ctx),
+	TP_ARGS(ctx),
+	TP_CONDITION(ctx->type == FW_ISO_CONTEXT_TRANSMIT)
+);
+
+DEFINE_EVENT_CONDITION(isoc_destroy_template, isoc_inbound_single_destroy,
+	TP_PROTO(const struct fw_iso_context *ctx),
+	TP_ARGS(ctx),
+	TP_CONDITION(ctx->type == FW_ISO_CONTEXT_RECEIVE)
+);
+
+DEFINE_EVENT_CONDITION(isoc_destroy_template, isoc_inbound_multiple_destroy,
+	TP_PROTO(const struct fw_iso_context *ctx),
+	TP_ARGS(ctx),
+	TP_CONDITION(ctx->type == FW_ISO_CONTEXT_RECEIVE_MULTICHANNEL)
+);
+
 #undef QUADLET_SIZE
 
 #endif // _FIREWIRE_TRACE_EVENT_H
-- 
2.43.0


