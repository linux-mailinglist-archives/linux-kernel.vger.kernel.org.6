Return-Path: <linux-kernel+bounces-326603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A179A976AA0
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 15:31:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E9602834E7
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 13:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 103D61AD27A;
	Thu, 12 Sep 2024 13:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="rEZRq1ss";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="omVDyfQP"
Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258E81A0BEE
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 13:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726147850; cv=none; b=dWm9Fv5d4Dj94eoACv97XLSv+ictVAYTWSOz51kgFz00FPgl2KXC5HNTEDkCjhmCB5xzI7XBT6cRQNukVDs03b4VBls1Qkz/J46Q4nkX9Fka/av8zbDpFEh6F+B8J8hLlvOmxy4XIyPmfp7ShfBapf2GxxHkEGdjulU4iNFQoaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726147850; c=relaxed/simple;
	bh=o6UqXQnfrAI5lPpgHSFkYycMXhQQ1ysYNKfzj0CGNUY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PJodcqHOo+iW4BiY2v/WgtihlMu6zlixLp+D8nnUPTLtXCMoc3aVBy7hAuhXQGzlnKRzeclsOpAiuZCjGwH7Wh/KeacS3Em3Q+yyV65HjL7e5TW8z8Dc4t975rEAMfx7Es9TxWYo+DfAO//Z+qJKw1183qXftfFnhU+3SFb52n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=rEZRq1ss; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=omVDyfQP; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 496A5138056D;
	Thu, 12 Sep 2024 09:30:47 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Thu, 12 Sep 2024 09:30:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1726147847; x=
	1726234247; bh=hOL3pXdPLkPf7uAd5iia3Mmqf1qjh1jea0RIAuKN/g0=; b=r
	EZRq1ss/tDmMaOQ6AbIHQB+Gjh3RC/amDsWQNwyRCUUJkYs8cwd6r9uqRWT3brPI
	kRBg0f6nwM53Z4VGZwT91I/gMsL8xZkn9GAwYP4Z3CP/8uv+yRyhfONDnlecBDer
	8oqWLWvc1O1cQPNwG2KfxzXB7hENIz9H7IaU3IH2BjWdz0/9Vqoty4m9Fj9PqdJs
	rnygEWeu3gjICME5y0OdKsLt/7TU5Gwzvsc+Z9+bny57+WwpM9ePJRCDgL72wSQG
	i2qQhsMj0+rDNq+Q+FYaPBuYtMvXYH9rqXzacJRAmiV2L+DpEAUOEZwMAP9wfhuw
	rnMRy5WztGnL29uJjYBAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1726147847; x=
	1726234247; bh=hOL3pXdPLkPf7uAd5iia3Mmqf1qjh1jea0RIAuKN/g0=; b=o
	mVDyfQPh1PCuoMseNNefo4yI/Ov460TBQAz0Ccpb9bJFPwR+dadqrhmC3cwFP2Og
	nSpqX+bkR9qzywZP90KC9ucNIWR23LIQGgRLDntbjCCB1H7bd5AoGx4KZcFY8gNV
	amALtsdEYqOZzU0xqHFzF7E7/HQIzp7ltDYpRBiEaHK50n4Dye7rxHmfpLTDrFoi
	rW1FBinzI4wzhg8T0UHJDYfr3onehLO9QU06ecDx9zZUn8PWW+PPjF4qWD3EcdL6
	x9mLhiTE8JmANi+ohHO0m2eXfUfWE4voOmKGOWEzfV4Xxj/5CNorLAUk0YwKNSQu
	BUnfrXO1DEJjpGAmGgliA==
X-ME-Sender: <xms:B-3iZuS3dD348nXz1mLkVBAvKpWXN06Kv7peNvn9JXmofQb-dbWdwQ>
    <xme:B-3iZjxAD442D_UzytPETyz2r8QhDZx3ytac31Q6JsLIZ_7K-TqoddtUydSmgdFUq
    if7pXKOPjoEmvLxgOs>
X-ME-Received: <xmr:B-3iZr2Z5GYbTf2yY4qp1PYU_HnFrrte1fkk4yhqUxW4YrFvrom2XdSggmr_VdV3jg_XgXyhtJwyxitt76K8q2O8ovZP6ijVO8NHSqLHNWHfVg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudejfedgieeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevuf
    ffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghm
    ohhtohcuoehoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrg
    htthgvrhhnpedvjefgjeeuvdfguddukeelveetgfdtvefhtdfffeeigfevueetffeivdff
    kedvtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjhhppdhnsggprhgtphhtthhopedv
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlihhnuhigudefleegqdguvghvvg
    hlsehlihhsthhsrdhsohhurhgtvghfohhrghgvrdhnvghtpdhrtghpthhtoheplhhinhhu
    gidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:B-3iZqCvlBaDWG8owQgPjbWxyjhUjj9piAw7ofcFm31BVJU1WACtEg>
    <xmx:B-3iZnhL3BYCpNdC1BYqdTRj-Km9anHgXNE6zI6NxmLzGKmp6zffwA>
    <xmx:B-3iZmqOIMsBcMpRsbzlUSDN0gn4UFebqtY7wVMk_9J5BDQLgYoo7g>
    <xmx:B-3iZqhwJWXiSBfk5ATQQV20lUgsf2X-8P3bPAl-sUGUyMw4syL9jQ>
    <xmx:B-3iZqtPaPKlZ0qcpZoHXY3nY7UqKDG39GXVQR3WDWNWv5TDVzrTllQk>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Sep 2024 09:30:46 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] Revert "firewire: core: move workqueue handler from 1394 OHCI driver to core function"
Date: Thu, 12 Sep 2024 22:30:35 +0900
Message-ID: <20240912133038.238786-3-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240912133038.238786-1-o-takashi@sakamocchi.jp>
References: <20240912133038.238786-1-o-takashi@sakamocchi.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit 767bfb9ef27ebf760290d9f8bc303828b018c312. It appears
that the call of ohci_flush_iso_completions() in the work item scheduled
by hardIRQ of 1394 OHCI for any isochronous context changes the timing to
queue events in the view of user space application.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/core-iso.c | 26 ++++++++++++---------
 drivers/firewire/core.h     |  5 +++++
 drivers/firewire/ohci.c     | 45 +++++++++++++++++++++++++++++++++++--
 3 files changed, 64 insertions(+), 12 deletions(-)

diff --git a/drivers/firewire/core-iso.c b/drivers/firewire/core-iso.c
index 9f41c78878ad..f2394f3ed194 100644
--- a/drivers/firewire/core-iso.c
+++ b/drivers/firewire/core-iso.c
@@ -131,13 +131,6 @@ size_t fw_iso_buffer_lookup(struct fw_iso_buffer *buffer, dma_addr_t completed)
 	return 0;
 }
 
-static void flush_completions_work(struct work_struct *work)
-{
-	struct fw_iso_context *ctx = container_of(work, struct fw_iso_context, work);
-
-	fw_iso_context_flush_completions(ctx);
-}
-
 struct fw_iso_context *fw_iso_context_create(struct fw_card *card,
 		int type, int channel, int speed, size_t header_size,
 		fw_iso_callback_t callback, void *callback_data)
@@ -156,7 +149,6 @@ struct fw_iso_context *fw_iso_context_create(struct fw_card *card,
 	ctx->header_size = header_size;
 	ctx->callback.sc = callback;
 	ctx->callback_data = callback_data;
-	INIT_WORK(&ctx->work, flush_completions_work);
 
 	trace_isoc_outbound_allocate(ctx, channel, speed);
 	trace_isoc_inbound_single_allocate(ctx, channel, header_size);
@@ -226,15 +218,29 @@ EXPORT_SYMBOL(fw_iso_context_queue_flush);
  * to process the context asynchronously, fw_iso_context_schedule_flush_completions() is available
  * instead.
  *
- * Context: Process context.
+ * Context: Process context. May sleep due to disable_work_sync().
  */
 int fw_iso_context_flush_completions(struct fw_iso_context *ctx)
 {
+	int err;
+
 	trace_isoc_outbound_flush_completions(ctx);
 	trace_isoc_inbound_single_flush_completions(ctx);
 	trace_isoc_inbound_multiple_flush_completions(ctx);
 
-	return ctx->card->driver->flush_iso_completions(ctx);
+	might_sleep();
+
+	// Avoid dead lock due to programming mistake.
+	if (WARN_ON_ONCE(current_work() == &ctx->work))
+		return 0;
+
+	disable_work_sync(&ctx->work);
+
+	err = ctx->card->driver->flush_iso_completions(ctx);
+
+	enable_work(&ctx->work);
+
+	return err;
 }
 EXPORT_SYMBOL(fw_iso_context_flush_completions);
 
diff --git a/drivers/firewire/core.h b/drivers/firewire/core.h
index 96ae366889e0..0ae2c84ecafe 100644
--- a/drivers/firewire/core.h
+++ b/drivers/firewire/core.h
@@ -159,6 +159,11 @@ int fw_iso_buffer_alloc(struct fw_iso_buffer *buffer, int page_count);
 int fw_iso_buffer_map_dma(struct fw_iso_buffer *buffer, struct fw_card *card,
 			  enum dma_data_direction direction);
 
+static inline void fw_iso_context_init_work(struct fw_iso_context *ctx, work_func_t func)
+{
+	INIT_WORK(&ctx->work, func);
+}
+
 
 /* -topology */
 
diff --git a/drivers/firewire/ohci.c b/drivers/firewire/ohci.c
index 02ff0363d3ad..3a911cfb5ff3 100644
--- a/drivers/firewire/ohci.c
+++ b/drivers/firewire/ohci.c
@@ -1182,6 +1182,47 @@ static void context_tasklet(unsigned long data)
 	}
 }
 
+static void ohci_isoc_context_work(struct work_struct *work)
+{
+	struct fw_iso_context *base = container_of(work, struct fw_iso_context, work);
+	struct iso_context *isoc_ctx = container_of(base, struct iso_context, base);
+	struct context *ctx = &isoc_ctx->context;
+	struct descriptor *d, *last;
+	u32 address;
+	int z;
+	struct descriptor_buffer *desc;
+
+	desc = list_entry(ctx->buffer_list.next, struct descriptor_buffer, list);
+	last = ctx->last;
+	while (last->branch_address != 0) {
+		struct descriptor_buffer *old_desc = desc;
+
+		address = le32_to_cpu(last->branch_address);
+		z = address & 0xf;
+		address &= ~0xf;
+		ctx->current_bus = address;
+
+		// If the branch address points to a buffer outside of the current buffer, advance
+		// to the next buffer.
+		if (address < desc->buffer_bus || address >= desc->buffer_bus + desc->used)
+			desc = list_entry(desc->list.next, struct descriptor_buffer, list);
+		d = desc->buffer + (address - desc->buffer_bus) / sizeof(*d);
+		last = find_branch_descriptor(d, z);
+
+		if (!ctx->callback(ctx, d, last))
+			break;
+
+		if (old_desc != desc) {
+			// If we've advanced to the next buffer, move the previous buffer to the
+			// free list.
+			old_desc->used = 0;
+			guard(spinlock_irqsave)(&ctx->ohci->lock);
+			list_move_tail(&old_desc->list, &ctx->buffer_list);
+		}
+		ctx->last = last;
+	}
+}
+
 /*
  * Allocate a new buffer and add it to the list of free buffers for this
  * context.  Must be called with ohci->lock held.
@@ -3128,6 +3169,7 @@ static struct fw_iso_context *ohci_allocate_iso_context(struct fw_card *card,
 	ret = context_init(&ctx->context, ohci, regs, callback);
 	if (ret < 0)
 		goto out_with_header;
+	fw_iso_context_init_work(&ctx->base, ohci_isoc_context_work);
 
 	if (type == FW_ISO_CONTEXT_RECEIVE_MULTICHANNEL) {
 		set_multichannel_mask(ohci, 0);
@@ -3582,8 +3624,7 @@ static int ohci_flush_iso_completions(struct fw_iso_context *base)
 	int ret = 0;
 
 	if (!test_and_set_bit_lock(0, &ctx->flushing_completions)) {
-		// Note that tasklet softIRQ is not used to process isochronous context anymore.
-		context_tasklet((unsigned long)&ctx->context);
+		ohci_isoc_context_work(&base->work);
 
 		switch (base->type) {
 		case FW_ISO_CONTEXT_TRANSMIT:
-- 
2.43.0


