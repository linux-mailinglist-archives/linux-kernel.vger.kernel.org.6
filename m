Return-Path: <linux-kernel+bounces-321559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CEA9971C08
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 16:02:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAAD41F23949
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 14:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9B8A1BBBDA;
	Mon,  9 Sep 2024 14:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="JUGCcD4i";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BEbMRQfk"
Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560D2178CDE;
	Mon,  9 Sep 2024 14:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725890427; cv=none; b=P9fh1z3JrM5HdGx0T+OVHSz0qWv51lNTHAhBtpQF9GXNOsfkQnlgQ2WHtEE3sT+Plwc3POsb/as+2SjNeo4RkWHTOortAiFCVAL0iRKIjsbeqDMbXDxBPCFh8Uw744d/6jZUpcpJ2pnjPAGuUlLPP9jMTZaTszHanKRHo66Zd6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725890427; c=relaxed/simple;
	bh=wNI809TCw8dOjPZ7jI3GSjAYhudmFFPxfp4oZzcGufM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e06fRmb7XHzxU8wGLqi1rPSZkzQr7X+6NPCW5Hkz7quF5ZrgykR0Sc2oxa7/wrNy1Yf/GVjd+wJDXGk9x7qIeqjjYE0785EeD83j/lRNvpGjRJ0WfBhc2L9CGelamCq6aULZ2uQBZvtq2zMJtwbXW3n9qqhGoMfSkgEE67kSN1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=JUGCcD4i; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BEbMRQfk; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 71CC9138022D;
	Mon,  9 Sep 2024 10:00:24 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 09 Sep 2024 10:00:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1725890424; x=
	1725976824; bh=Zm1x8RMkMJ6iqGxXmzNuyEZHYUHIHWovazQAQQ9JJ5w=; b=J
	UGCcD4iuFLzBuyKAiBjoV7qxQN2cC4TiaYb0phmRo6+uaZXlwyDtW58IEQdj8YGT
	YO3aR47cLoAHl5BAqZINsfObIgM2eHQHql0JrrWDI0KbU9FdUbMHlz2Dm+Kk/x8S
	rdGiZeOy3OCFoQtpFvKGD0gcKVpFP+890wcJfPHIkSgPR8odJ+DGTD6U4raa+Fyg
	81otInY4EFIIvZFXpIhR9UaETuWgpiagkXX1i4FSSCjADX4FYYjYUXuI9ePhfR+T
	rFAVojiuvvxuU8IFrZBjwNDyqaz44uO+E5T294CcVQj5gm1W8IQLbo5g/1QLsz4s
	QOtsFyJd/XQogNjT/fRqA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1725890424; x=
	1725976824; bh=Zm1x8RMkMJ6iqGxXmzNuyEZHYUHIHWovazQAQQ9JJ5w=; b=B
	EbMRQfkPMujFllyKVl4lUO37zh5DV+Mo1kgG0beX4efymsilvTaVUbn9XnyoG0cb
	DfDCoRouaU12mQ5F4KR+iGnqW+/+inQRHZhNo8jg9k+krAW+fGjiNKPbaPk4TTbv
	e2A3LtAkrcY20URC1MhgrgmvRYk+inkUZUXtXFl3tO5HIQWB8UR2kDNhvV/53XhK
	68dP26ZMq6T1WQlDkWqsI4d57DTu6D1PV4956//W6705+YpAHJkNbfIZmw83YLXr
	TjjzbU0KdfcPZd38w7KtM18CeamTcxbxHYWZXXAKPB4r0ze1IJQnYOPwmwtveC+R
	Tj9Vv7oXhF9eGvUbF+PVQ==
X-ME-Sender: <xms:eP_eZnl0dzOpm2vQVU-vvN18NmmfwQNogqwPTaTXtLApLzH81ULmnA>
    <xme:eP_eZq1pA9J-8u0JqgjwFRRbpv3xeDbsQIqpiWQCJfQeHSv1dQrBZJT6qiMjOBJ1b
    5TuSq212sbBG9DxvMs>
X-ME-Received: <xmr:eP_eZtrEQeW5SCWWqQ31ykg77jc82iIXPwtNBwOcB00tPdDbZmhTGZ5xxxQynKnsTn3n9CYBYCPka_Z1IyoAUP-sezFfqkwgymJ101V12t6srw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudeijedgheehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevuf
    ffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghm
    ohhtohcuoehoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrg
    htthgvrhhnpedvjefgjeeuvdfguddukeelveetgfdtvefhtdfffeeigfevueetffeivdff
    kedvtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjhhppdhnsggprhgtphhtthhopeef
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlihhnuhigudefleegqdguvghvvg
    hlsehlihhsthhsrdhsohhurhgtvghfohhrghgvrdhnvghtpdhrtghpthhtoheplhhinhhu
    gidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinh
    hugidqshhouhhnugesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:eP_eZvkYuH3Sx6PYE9kr8qIBtJGlOqoPzDlUzZUN9bexgJc5MM36hQ>
    <xmx:eP_eZl0coh3SHtVUf1Edyzgf5FNqIZg2TLCtdQUKfiRLzZPr1pQ3Uw>
    <xmx:eP_eZus9JJBHPe0wOvFOdCVsFSENk38pPgHDX22QAuh4devRd_p2XQ>
    <xmx:eP_eZpUQUUCNS6BwBxXlgkNvhtXW-WXnlRol8jHLye8jBbmXBQpIEg>
    <xmx:eP_eZuxVwOT1-_Xk7t2LZRlLtNI_MBgqElNmFyzQeTPveyF3SD7HIdKU>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Sep 2024 10:00:23 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org
Subject: [PATCH 1/2] firewire: core: move workqueue handler from 1394 OHCI driver to core function
Date: Mon,  9 Sep 2024 23:00:17 +0900
Message-ID: <20240909140018.65289-2-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240909140018.65289-1-o-takashi@sakamocchi.jp>
References: <20240909140018.65289-1-o-takashi@sakamocchi.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In current implementation, the work item for isochronous context executes
the same procedure of fw_iso_context_flush_completions() internally. There
is a space to refactor the implementation.

This commit calls fw_iso_context_flush_completions() in the work item. It
obsoletes fw_iso_context_init_work(). It also obsoletes a pair of
disable_work_sync() and enable_work() since the usage of
test_and_set_bit_lock() mediates concurrent call already.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/core-iso.c | 26 +++++++++------------
 drivers/firewire/core.h     |  5 -----
 drivers/firewire/ohci.c     | 45 ++-----------------------------------
 3 files changed, 12 insertions(+), 64 deletions(-)

diff --git a/drivers/firewire/core-iso.c b/drivers/firewire/core-iso.c
index f2394f3ed194..9f41c78878ad 100644
--- a/drivers/firewire/core-iso.c
+++ b/drivers/firewire/core-iso.c
@@ -131,6 +131,13 @@ size_t fw_iso_buffer_lookup(struct fw_iso_buffer *buffer, dma_addr_t completed)
 	return 0;
 }
 
+static void flush_completions_work(struct work_struct *work)
+{
+	struct fw_iso_context *ctx = container_of(work, struct fw_iso_context, work);
+
+	fw_iso_context_flush_completions(ctx);
+}
+
 struct fw_iso_context *fw_iso_context_create(struct fw_card *card,
 		int type, int channel, int speed, size_t header_size,
 		fw_iso_callback_t callback, void *callback_data)
@@ -149,6 +156,7 @@ struct fw_iso_context *fw_iso_context_create(struct fw_card *card,
 	ctx->header_size = header_size;
 	ctx->callback.sc = callback;
 	ctx->callback_data = callback_data;
+	INIT_WORK(&ctx->work, flush_completions_work);
 
 	trace_isoc_outbound_allocate(ctx, channel, speed);
 	trace_isoc_inbound_single_allocate(ctx, channel, header_size);
@@ -218,29 +226,15 @@ EXPORT_SYMBOL(fw_iso_context_queue_flush);
  * to process the context asynchronously, fw_iso_context_schedule_flush_completions() is available
  * instead.
  *
- * Context: Process context. May sleep due to disable_work_sync().
+ * Context: Process context.
  */
 int fw_iso_context_flush_completions(struct fw_iso_context *ctx)
 {
-	int err;
-
 	trace_isoc_outbound_flush_completions(ctx);
 	trace_isoc_inbound_single_flush_completions(ctx);
 	trace_isoc_inbound_multiple_flush_completions(ctx);
 
-	might_sleep();
-
-	// Avoid dead lock due to programming mistake.
-	if (WARN_ON_ONCE(current_work() == &ctx->work))
-		return 0;
-
-	disable_work_sync(&ctx->work);
-
-	err = ctx->card->driver->flush_iso_completions(ctx);
-
-	enable_work(&ctx->work);
-
-	return err;
+	return ctx->card->driver->flush_iso_completions(ctx);
 }
 EXPORT_SYMBOL(fw_iso_context_flush_completions);
 
diff --git a/drivers/firewire/core.h b/drivers/firewire/core.h
index 0ae2c84ecafe..96ae366889e0 100644
--- a/drivers/firewire/core.h
+++ b/drivers/firewire/core.h
@@ -159,11 +159,6 @@ int fw_iso_buffer_alloc(struct fw_iso_buffer *buffer, int page_count);
 int fw_iso_buffer_map_dma(struct fw_iso_buffer *buffer, struct fw_card *card,
 			  enum dma_data_direction direction);
 
-static inline void fw_iso_context_init_work(struct fw_iso_context *ctx, work_func_t func)
-{
-	INIT_WORK(&ctx->work, func);
-}
-
 
 /* -topology */
 
diff --git a/drivers/firewire/ohci.c b/drivers/firewire/ohci.c
index 3a911cfb5ff3..02ff0363d3ad 100644
--- a/drivers/firewire/ohci.c
+++ b/drivers/firewire/ohci.c
@@ -1182,47 +1182,6 @@ static void context_tasklet(unsigned long data)
 	}
 }
 
-static void ohci_isoc_context_work(struct work_struct *work)
-{
-	struct fw_iso_context *base = container_of(work, struct fw_iso_context, work);
-	struct iso_context *isoc_ctx = container_of(base, struct iso_context, base);
-	struct context *ctx = &isoc_ctx->context;
-	struct descriptor *d, *last;
-	u32 address;
-	int z;
-	struct descriptor_buffer *desc;
-
-	desc = list_entry(ctx->buffer_list.next, struct descriptor_buffer, list);
-	last = ctx->last;
-	while (last->branch_address != 0) {
-		struct descriptor_buffer *old_desc = desc;
-
-		address = le32_to_cpu(last->branch_address);
-		z = address & 0xf;
-		address &= ~0xf;
-		ctx->current_bus = address;
-
-		// If the branch address points to a buffer outside of the current buffer, advance
-		// to the next buffer.
-		if (address < desc->buffer_bus || address >= desc->buffer_bus + desc->used)
-			desc = list_entry(desc->list.next, struct descriptor_buffer, list);
-		d = desc->buffer + (address - desc->buffer_bus) / sizeof(*d);
-		last = find_branch_descriptor(d, z);
-
-		if (!ctx->callback(ctx, d, last))
-			break;
-
-		if (old_desc != desc) {
-			// If we've advanced to the next buffer, move the previous buffer to the
-			// free list.
-			old_desc->used = 0;
-			guard(spinlock_irqsave)(&ctx->ohci->lock);
-			list_move_tail(&old_desc->list, &ctx->buffer_list);
-		}
-		ctx->last = last;
-	}
-}
-
 /*
  * Allocate a new buffer and add it to the list of free buffers for this
  * context.  Must be called with ohci->lock held.
@@ -3169,7 +3128,6 @@ static struct fw_iso_context *ohci_allocate_iso_context(struct fw_card *card,
 	ret = context_init(&ctx->context, ohci, regs, callback);
 	if (ret < 0)
 		goto out_with_header;
-	fw_iso_context_init_work(&ctx->base, ohci_isoc_context_work);
 
 	if (type == FW_ISO_CONTEXT_RECEIVE_MULTICHANNEL) {
 		set_multichannel_mask(ohci, 0);
@@ -3624,7 +3582,8 @@ static int ohci_flush_iso_completions(struct fw_iso_context *base)
 	int ret = 0;
 
 	if (!test_and_set_bit_lock(0, &ctx->flushing_completions)) {
-		ohci_isoc_context_work(&base->work);
+		// Note that tasklet softIRQ is not used to process isochronous context anymore.
+		context_tasklet((unsigned long)&ctx->context);
 
 		switch (base->type) {
 		case FW_ISO_CONTEXT_TRANSMIT:
-- 
2.43.0


