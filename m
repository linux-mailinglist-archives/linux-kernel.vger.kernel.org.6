Return-Path: <linux-kernel+bounces-226469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 390DE913ED9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 00:10:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E043B217EC
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 22:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F38441850B2;
	Sun, 23 Jun 2024 22:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="jXJ4mpZl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kHzSj2sb"
Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2541862A3
	for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 22:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719180554; cv=none; b=MacRvmoQLF7hgl4uHy91Py8B3q5kQSCzjcejIuwuepOBLQDwaOSXXvSp7+sa+OIPIPvSfy4J+8tN9/MW7nO1+cXwzh4e+L8wpuXATM/EPPucz0d1PoE2SEyjcuwwULXobMeAvcl1R+e6h3S6Du8pjPcY+C0a17D2uq6QG43Xo7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719180554; c=relaxed/simple;
	bh=CQ6NzmF9egpcqvZCRqIyhgjTx6e9q2/Ev2fAB6oinL8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A9gIr1OFemaRNxVeOqJnE3E2SgxMKqzEiBtHyHbYWPYpmlYMF1/pVg4lhAI9MhhXcRyNM6h/JeJHqSHMFkanpzpVaIgO/mmkiY/rn8vig9OZpJyMC5dX2dM3sXrkOTKL8FABiBrkXuoaNnedPDVZj16mmNxNS+bQhM6y5euD46k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=jXJ4mpZl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kHzSj2sb; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id 8266F1380233;
	Sun, 23 Jun 2024 18:09:11 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Sun, 23 Jun 2024 18:09:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1719180551; x=
	1719266951; bh=vrAz9favDBg/4g1lGjoFO1edTxLzgyyvZvPQK9eEMNc=; b=j
	XJ4mpZlZ5dBJbjgmJhE4nUhnyUdOa7KsSL45cckZV+hCLfbZfnp++TX4YtXUQyDe
	mMDE7g8Ll3b9gNUAIt6+cjZwSHdCEv5OYsBcsHf7wEQQuPXdD/MeXHjmOlEfYwaP
	ycD8/HHkwWyFBl7eM55C4L92Ef0zZFZtPpYfMxyfUlUwOq2XMIHKQNQp2P47bI+B
	IljBQUYYKXvW7UNVAHSg2XTv6kmv+wbp8My1OcJlg0xALAFckPz7MQC+XwxGQ50c
	7FAS/6pwbsspK6VGKB54gZZ86TEhD5F7VLpkwD96aaZ1IfmUTwWgbfAc1I8PjrG3
	9CoohDdDr6FlfaAT0BKAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1719180551; x=
	1719266951; bh=vrAz9favDBg/4g1lGjoFO1edTxLzgyyvZvPQK9eEMNc=; b=k
	HzSj2sb45KzER1tg7D1be/vhCesFlEPIsUX276cnyX5S5rpa8MUjUP9Qjl7Eia9Y
	48JojUXjznWL+ggK+8SW51QecR3FyhBdYzCoAfttR/t/i+Nnq4zp+Q/gn2iTHBDB
	/0B/HKLm3z/t/OXi2YBKSwUxisVOddG9qtITHJs3SAmOQWMlxXT6pxjVG28Kc3tN
	MxYNVmaYuc3QZR8/2IzIn0pA0UJm5ZROOIPzgRqhuk+LtoqEWz1rFhJG53JWHMkg
	X+30p7DP5Vm6rUf3TU2TKnNpCAlK1FrX58EUtJZrPVBeeXP0HC7zw42ggYGtRLjb
	DKI+CP/Jsl/X1gV6CtP3g==
X-ME-Sender: <xms:B514ZrqEiDtK6E_PLuFSJVk_2tdWhdQ5GCq8lkcniiY9zrgZB5ZHEA>
    <xme:B514Zlq7ze9jAxqRmRsREkKCmNfbHiSrUnkiATa6Z4cr19qVGSyTFGGGxDvkNJg2q
    NQPqZjQXVk2kdbT7W8>
X-ME-Received: <xmr:B514ZoP5Q6slmPVPaW_bJriT6u4drKIoknld392XL8nMPzTJcaOlGYSdQ34c9yFwh2jTYi5YjLOyu2VRKdKbtGHGQern1KxWhd5TBdw6H7L->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeegtddgtdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghk
    rghshhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpedvjefgje
    euvdfguddukeelveetgfdtvefhtdfffeeigfevueetffeivdffkedvtdenucevlhhushht
    vghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhise
    hsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:B514Zu5axOHZSSQvnLM9yIOf2RfafLAibUopKIqM2WqomB0UrEFQhQ>
    <xmx:B514Zq5P-P2RBZ14bVSbvGwYaJhJtQjJevOB3nip_El06RLpBxiHmA>
    <xmx:B514ZmjdnhMFP8xYM64BBr29yZji1_sgztCnQ-cpa-WYJDM_gXCAfg>
    <xmx:B514Zs5GDdSfEh60CAlLx01MwPYTIdwPyHUgEzxvPJOsFoAqWv5flw>
    <xmx:B514ZqFkcEkMy2MOvQW1aGrEEZ15veoWQjYm2wYlps-oCaSQD6Df6Nmc>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 23 Jun 2024 18:09:10 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 4/7] firewire: core: add tracepoints events for flushing of isochronous context
Date: Mon, 24 Jun 2024 07:08:55 +0900
Message-ID: <20240623220859.851685-5-o-takashi@sakamocchi.jp>
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

It is helpful to trace the flushing of isochronous context when the core
function is requested them by both in-kernel unit drivers and userspace
applications.

This commit adds some tracepoints events for the aim.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/core-iso.c     |  4 ++++
 include/trace/events/firewire.h | 36 +++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/drivers/firewire/core-iso.c b/drivers/firewire/core-iso.c
index 49feb4c28224..5bad23fcce0c 100644
--- a/drivers/firewire/core-iso.c
+++ b/drivers/firewire/core-iso.c
@@ -197,6 +197,10 @@ EXPORT_SYMBOL(fw_iso_context_queue);
 
 void fw_iso_context_queue_flush(struct fw_iso_context *ctx)
 {
+	trace_isoc_outbound_flush(ctx);
+	trace_isoc_inbound_single_flush(ctx);
+	trace_isoc_inbound_multiple_flush(ctx);
+
 	ctx->card->driver->flush_queue_iso(ctx);
 }
 EXPORT_SYMBOL(fw_iso_context_queue_flush);
diff --git a/include/trace/events/firewire.h b/include/trace/events/firewire.h
index c984b7d6380f..b404e6324671 100644
--- a/include/trace/events/firewire.h
+++ b/include/trace/events/firewire.h
@@ -670,6 +670,42 @@ DEFINE_EVENT_CONDITION(isoc_stop_template, isoc_inbound_multiple_stop,
 	TP_CONDITION(ctx->type == FW_ISO_CONTEXT_RECEIVE_MULTICHANNEL)
 );
 
+DECLARE_EVENT_CLASS(isoc_flush_template,
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
+);
+
+DEFINE_EVENT_CONDITION(isoc_flush_template, isoc_outbound_flush,
+	TP_PROTO(const struct fw_iso_context *ctx),
+	TP_ARGS(ctx),
+	TP_CONDITION(ctx->type == FW_ISO_CONTEXT_TRANSMIT)
+);
+
+DEFINE_EVENT_CONDITION(isoc_flush_template, isoc_inbound_single_flush,
+	TP_PROTO(const struct fw_iso_context *ctx),
+	TP_ARGS(ctx),
+	TP_CONDITION(ctx->type == FW_ISO_CONTEXT_RECEIVE)
+);
+
+DEFINE_EVENT_CONDITION(isoc_flush_template, isoc_inbound_multiple_flush,
+	TP_PROTO(const struct fw_iso_context *ctx),
+	TP_ARGS(ctx),
+	TP_CONDITION(ctx->type == FW_ISO_CONTEXT_RECEIVE_MULTICHANNEL)
+);
+
 #undef QUADLET_SIZE
 
 #endif // _FIREWIRE_TRACE_EVENT_H
-- 
2.43.0


