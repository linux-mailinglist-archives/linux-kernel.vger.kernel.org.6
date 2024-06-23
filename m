Return-Path: <linux-kernel+bounces-226470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A099913EDA
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 00:10:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36B82281D4D
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 22:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A91D818756E;
	Sun, 23 Jun 2024 22:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="jZ0p9enb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bKKjYlbX"
Received: from fhigh6-smtp.messagingengine.com (fhigh6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4D6186E4B
	for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 22:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719180555; cv=none; b=YRYDcz2mpH/ofCrVx/xUlNKMoR3L4eTlZYwdAjlNgMK3LJrxYqhJyP0oNxu+1319jKNPGQ5Ul9/9cjdhmXc78UMImKtnfqmjEfUAx7ok2qj2/bV4wYTCb5rYuui6pxBCBiIct9C3enSeKvqcaAa+agk9mTVJLL+RKKKUSmRpObM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719180555; c=relaxed/simple;
	bh=d6W03WsiWlJpqJD6mVx2ojF+rW7LlSqdIoao/ezGAVU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dBFXH4OKYtadDl1DyVgYcfxuIFFNspEzT8QUlJ5y34sBjOJhDu3MzTeuUnoIVHZbUctsHM9q6nMH6GXvw6OmGWRc5IVMuj2uKAG/xUEm77Pz9Syy3VKOnG7vs7MgYoRzIqVFx4pOlMGz7p8g93pstkRaLkYkB4grT4q4rOV09og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=jZ0p9enb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bKKjYlbX; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 1D524114008B;
	Sun, 23 Jun 2024 18:09:13 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Sun, 23 Jun 2024 18:09:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1719180553; x=
	1719266953; bh=o6KF/Qat9pVrpE9/pXeE4DRfuJY+mnOlsa6Bs6Hh1zo=; b=j
	Z0p9enbC++IesQkkK4n53WT2rju4d84i1uRfEnKjIMJ+U6My+I+qO1Z8sKC/R9FT
	qGJjNfuTrUPfYXZ4cE2vjkikjfr9CyNcPlnvbnyF5GMWPx0cqGtn3fG1rgMiLQWe
	CxB7cimW7DDlRJEAyt+cbLcFemmrJT5kxR/ql2XlqrP/fspo8Wsn9wxSom1nEmPt
	ESxdO6ozW9r32/RnTQRgjOdIbMiJP5FJHqwrvh2qLkvScs9+K9+HEHNzH9rHb49q
	ZYXvBn3KqIw0OOhTlg9ZwhIuqLcwL/NvR9IMCPtfCSqMn1hhoBg/v8e0uAdJQjWL
	8uvtVe5B49hqekYEYTMTA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1719180553; x=
	1719266953; bh=o6KF/Qat9pVrpE9/pXeE4DRfuJY+mnOlsa6Bs6Hh1zo=; b=b
	KKjYlbXe54YocNlVVbRXW/B9uK1ZteP57FpMWXZYIwBSVioB6Be4MxrG2OfGYiMg
	YlsEKLw316O7f9yIcxWwj8K5IdKIDwkjC2rE7MWS49j8G3eZWiXIi0HCH5kK0rTF
	29vq2bEBoK6bZeb+aM0z+di4/Kolfz/tHZWaqoJdthSwwvv3IOxpofef+X1ssR6v
	pYvq/GbaupJzf6sMQvEWpqcYphwgqewNYBvwp+dOrcNudZvjzfK/mU27PfRxlgv9
	a59M6X82A9dCQrMnmr5vOStKUX05WYGr2jLOb/orHl7aWTXC6deWpE+a7QnuKLZH
	pR9FSDWj1fSiauG7IpNEg==
X-ME-Sender: <xms:CJ14ZhjE5rd1JIfzVhu2C-mLrmEXgSU-Qn_Cwy6VX-rPftV1YaqUIg>
    <xme:CJ14ZmAqhX--9u69QP_p93DJExYhf9NYRnzKVw9ChBhMvm-XHzR9wFYRy86pqUi-8
    FrNelm_AhME3NPrb2Y>
X-ME-Received: <xmr:CJ14ZhGjpTfPmEni1b7MqHycnmAJQqylT9VxSwagGMUTK25umhbzn6NlsE5l0Y7wpTIuum-JbAdms1TH_CMS1mNDYHoioiB4o1CFl3SvcM4C>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeegtddgtdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghk
    rghshhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpedvjefgje
    euvdfguddukeelveetgfdtvefhtdfffeeigfevueetffeivdffkedvtdenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhise
    hsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:CJ14ZmQgl9j3jM12Ql-57iPcznTFLvk7mUaU50bJOukLPXiqrOIxxA>
    <xmx:CJ14Zuxm5s92IzN3bMUdUFPNPMGCXyVHS--uUyEuULN-b5wu8wXAjg>
    <xmx:CJ14Zs52CJAHcXWhbOASmIfY27_U6JE-BpJjziLCaOnvVkMRbFkj1g>
    <xmx:CJ14Zjw73YriHmp72e5rnx9voBlxc7N9m-Eg7os_GyEepHZadh19_Q>
    <xmx:CZ14Zp_lhhfdvkKveH2nTZzrIGcbiYMmzKYJ5fx3OeLSHSf1YtXiK2OL>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 23 Jun 2024 18:09:11 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 5/7] firewire: core: add tracepoints events for flushing completions of isochronous context
Date: Mon, 24 Jun 2024 07:08:56 +0900
Message-ID: <20240623220859.851685-6-o-takashi@sakamocchi.jp>
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

It is helpful to trace the flushing completions of isochronous context when
the core function is requested them by both in-kernel unit drivers and
userspace applications.

This commit adds some tracepoints events for the aim.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/core-iso.c     |  4 ++++
 drivers/firewire/ohci.c         |  2 ++
 include/trace/events/firewire.h | 36 +++++++++++++++++++++++++++++++++
 3 files changed, 42 insertions(+)

diff --git a/drivers/firewire/core-iso.c b/drivers/firewire/core-iso.c
index 5bad23fcce0c..93ca0dec1805 100644
--- a/drivers/firewire/core-iso.c
+++ b/drivers/firewire/core-iso.c
@@ -207,6 +207,10 @@ EXPORT_SYMBOL(fw_iso_context_queue_flush);
 
 int fw_iso_context_flush_completions(struct fw_iso_context *ctx)
 {
+	trace_isoc_outbound_flush_completions(ctx);
+	trace_isoc_inbound_single_flush_completions(ctx);
+	trace_isoc_inbound_multiple_flush_completions(ctx);
+
 	return ctx->card->driver->flush_iso_completions(ctx);
 }
 EXPORT_SYMBOL(fw_iso_context_flush_completions);
diff --git a/drivers/firewire/ohci.c b/drivers/firewire/ohci.c
index 1f6097a6366c..f35d6e193bcb 100644
--- a/drivers/firewire/ohci.c
+++ b/drivers/firewire/ohci.c
@@ -43,6 +43,8 @@
 #include "packet-header-definitions.h"
 #include "phy-packet-definitions.h"
 
+#include <trace/events/firewire.h>
+
 #define ohci_info(ohci, f, args...)	dev_info(ohci->card.device, f, ##args)
 #define ohci_notice(ohci, f, args...)	dev_notice(ohci->card.device, f, ##args)
 #define ohci_err(ohci, f, args...)	dev_err(ohci->card.device, f, ##args)
diff --git a/include/trace/events/firewire.h b/include/trace/events/firewire.h
index b404e6324671..ad1546120aa3 100644
--- a/include/trace/events/firewire.h
+++ b/include/trace/events/firewire.h
@@ -706,6 +706,42 @@ DEFINE_EVENT_CONDITION(isoc_flush_template, isoc_inbound_multiple_flush,
 	TP_CONDITION(ctx->type == FW_ISO_CONTEXT_RECEIVE_MULTICHANNEL)
 );
 
+DECLARE_EVENT_CLASS(isoc_flush_completions_template,
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
+DEFINE_EVENT_CONDITION(isoc_flush_completions_template, isoc_outbound_flush_completions,
+	TP_PROTO(const struct fw_iso_context *ctx),
+	TP_ARGS(ctx),
+	TP_CONDITION(ctx->type == FW_ISO_CONTEXT_TRANSMIT)
+);
+
+DEFINE_EVENT_CONDITION(isoc_flush_completions_template, isoc_inbound_single_flush_completions,
+	TP_PROTO(const struct fw_iso_context *ctx),
+	TP_ARGS(ctx),
+	TP_CONDITION(ctx->type == FW_ISO_CONTEXT_RECEIVE)
+);
+
+DEFINE_EVENT_CONDITION(isoc_flush_completions_template, isoc_inbound_multiple_flush_completions,
+	TP_PROTO(const struct fw_iso_context *ctx),
+	TP_ARGS(ctx),
+	TP_CONDITION(ctx->type == FW_ISO_CONTEXT_RECEIVE_MULTICHANNEL)
+);
+
 #undef QUADLET_SIZE
 
 #endif // _FIREWIRE_TRACE_EVENT_H
-- 
2.43.0


