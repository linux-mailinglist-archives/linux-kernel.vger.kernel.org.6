Return-Path: <linux-kernel+bounces-273856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49663946EEC
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 15:05:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA7A21F20F29
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 13:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B1A113CA8D;
	Sun,  4 Aug 2024 13:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="EWkCcxkd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GGt8fz1f"
Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE8413C661
	for <linux-kernel@vger.kernel.org>; Sun,  4 Aug 2024 13:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722776574; cv=none; b=r2naN+wEapAQFkPMW6W6cjHu0WDwqHehe+uJn4m/UVFmXa9tbHrftU4msNIcn5DfUHxpOI5bYE9vKSBH2C0LaogCisDhlRIBx0U4ROtXz2Pda4eExhJqO7SQlC0T0VdZMznNFkE8mMJPGdVrHNVLKYIUD3GBNIFCtg17in4CbPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722776574; c=relaxed/simple;
	bh=QvOuD/5y8rCGroBROVtigY3efPBGAl1FYLFEGbesjng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VFOCVsclwGnfS/CmDsABtKA3koUynNSdjQDYVUQtctgBfDJMkBO/7F5+9BW+WyTNRp0MTEf84C1e3yT44thMFka09m9OAHa6jvVbkFUKtKvqSwpSVLx+boVB4BTLWltWtXdb6DMbu7+H0BFtIV6tXscxouv47j0U8I8iRNkluLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=EWkCcxkd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GGt8fz1f; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 6726A11481AC;
	Sun,  4 Aug 2024 09:02:52 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Sun, 04 Aug 2024 09:02:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1722776572; x=
	1722862972; bh=ce1PvFpqfMZ6coYFn9GbZNurf1sO48K6AvhhScalZL0=; b=E
	WkCcxkdxBsvVGip1trnbama6KMLb54d8OWVoUzQnZXjrM4pO9xXTRIsxoToSky1I
	3cDHtpZAjXsnNLVD+gVFZXhxe54w/mwWbyYky9IS6efd28nUBqdT+HHZdZSm1em/
	OKb6+gO7jjskau+L3mbrWjBJdQ8+8Af3abbDEEl5/CFPtGfRi9X/md8Rbxr2EnJC
	S+CpEBnptBZ2ji5BwvgsRZ8O9qhF/bK/Yd1ZKwn/8sVo9i5xoOa3jqzS7AFKXuDu
	2z/iaqLYMu0MDYkJlTUl7knduAQped1zM+fCmT+6c/8zm6svNmg2gx5s2EdrUtrx
	hIUmFgAh0z6Bl7l62UIRg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1722776572; x=
	1722862972; bh=ce1PvFpqfMZ6coYFn9GbZNurf1sO48K6AvhhScalZL0=; b=G
	Gt8fz1fAfLbK4x606Rw1ZAC+GazGslRtjrxccs4Qd4cQy7WjpQ2+qiwD5kHBijkS
	O6TMt0EWevU1pqJbK/OwyB4hw/iwUm9OZZAbvcddIga4uI4ql9FhiaSH5fcpPIbH
	2/3HQv9yF4qjan2TtqRP+k9vrpFJ6ZvhjQAxHhP2gSOy3Em/zl9iRYTdp5FyYu0O
	VvLnZ2zUcTmysYzDRcG84DNkKGIPhGibIRneTWLbDcIRl08OEHVeyWgbLTA4ZRA4
	C3yQ4/bQG5X6Q1FxL94jIBPx7MMQDdaEd1elVK/yzwubkZNFid/HTnrMfAATgIlD
	z9VA5cj+SntmksN9CarhQ==
X-ME-Sender: <xms:_HuvZiwsAk-NMVCwYKVtO6-yjdhIbgyA8lyGklAyMCwzs4c1SA5few>
    <xme:_HuvZuRyIsBLdL1Sv6d8oxjDP6BJGU-s0GkdloqMklpSVXKilb9-T2o6oACjzsdM0
    fsxCmnqypE-hxFIoz4>
X-ME-Received: <xmr:_HuvZkUbdFvo2PjVQJewqFgDkPKJcvUgpUYIb06dQRuqJQCYr9D-QZPDE0pmjT4sdEGwaZ29LkF_7qcf6TnhF4VXi_u4wkpwIS7XLgXNIwAeXQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeeggdehlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgr
    shhhihesshgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhepvdejgfejue
    dvgfduudekleevtefgtdevhfdtffefiefgveeuteffiedvffekvddtnecuvehluhhsthgv
    rhfuihiivgepgeenucfrrghrrghmpehmrghilhhfrhhomhepohdqthgrkhgrshhhihessh
    grkhgrmhhotggthhhirdhjphdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:_HuvZogGb39vZuj1agBXUgn7XN0dqq3_aTcFKpcOYjFxoiZxg3Vk4w>
    <xmx:_HuvZkC8xzP1lXOOXvRuMUt8pBEbSf7ITRdrXA_llq7vlrCDQ1hnpQ>
    <xmx:_HuvZpJDEwvLqaPsDnkKyTYx-XFNYoVdXGQ0SfZ-F4DvFWjHoSo1LA>
    <xmx:_HuvZrCCHl_kHp61PVVx-K9byTjPRuD5g6EsJJdFEHnMkPLJT3LfHg>
    <xmx:_HuvZnMRtmyKGZS0w-fxKx5GqsjKssoMrQRZIH_NmJwsqHVqlQFBHjT4>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 4 Aug 2024 09:02:51 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 17/17] firewire: ohci: use guard macro to serialize operations for isochronous contexts
Date: Sun,  4 Aug 2024 22:02:24 +0900
Message-ID: <20240804130225.243496-18-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240804130225.243496-1-o-takashi@sakamocchi.jp>
References: <20240804130225.243496-1-o-takashi@sakamocchi.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The 1394 OHCI driver uses spinlock to serialize operations for
isochronous contexts.

This commit uses guard macro to maintain the spinlock.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/ohci.c | 164 +++++++++++++++++-----------------------
 1 file changed, 68 insertions(+), 96 deletions(-)

diff --git a/drivers/firewire/ohci.c b/drivers/firewire/ohci.c
index 368420e4b414..f36a0c853673 100644
--- a/drivers/firewire/ohci.c
+++ b/drivers/firewire/ohci.c
@@ -1173,13 +1173,11 @@ static void context_tasklet(unsigned long data)
 			break;
 
 		if (old_desc != desc) {
-			/* If we've advanced to the next buffer, move the
-			 * previous buffer to the free list. */
-			unsigned long flags;
+			// If we've advanced to the next buffer, move the previous buffer to the
+			// free list.
 			old_desc->used = 0;
-			spin_lock_irqsave(&ctx->ohci->lock, flags);
+			guard(spinlock_irqsave)(&ctx->ohci->lock);
 			list_move_tail(&old_desc->list, &ctx->buffer_list);
-			spin_unlock_irqrestore(&ctx->ohci->lock, flags);
 		}
 		ctx->last = last;
 	}
@@ -2122,14 +2120,12 @@ static void bus_reset_work(struct work_struct *work)
 		return;
 	}
 
-	/* FIXME: Document how the locking works. */
-	spin_lock_irq(&ohci->lock);
-
-	ohci->generation = -1; /* prevent AT packet queueing */
-	context_stop(&ohci->at_request_ctx);
-	context_stop(&ohci->at_response_ctx);
-
-	spin_unlock_irq(&ohci->lock);
+	// FIXME: Document how the locking works.
+	scoped_guard(spinlock_irq, &ohci->lock) {
+		ohci->generation = -1; // prevent AT packet queueing
+		context_stop(&ohci->at_request_ctx);
+		context_stop(&ohci->at_response_ctx);
+	}
 
 	/*
 	 * Per OHCI 1.2 draft, clause 7.2.3.3, hardware may leave unsent
@@ -2704,7 +2700,6 @@ static int ohci_enable_phys_dma(struct fw_card *card,
 				int node_id, int generation)
 {
 	struct fw_ohci *ohci = fw_ohci(card);
-	unsigned long flags;
 	int n, ret = 0;
 
 	if (param_remote_dma)
@@ -2715,12 +2710,10 @@ static int ohci_enable_phys_dma(struct fw_card *card,
 	 * interrupt bit.  Clear physReqResourceAllBuses on bus reset.
 	 */
 
-	spin_lock_irqsave(&ohci->lock, flags);
+	guard(spinlock_irqsave)(&ohci->lock);
 
-	if (ohci->generation != generation) {
-		ret = -ESTALE;
-		goto out;
-	}
+	if (ohci->generation != generation)
+		return -ESTALE;
 
 	/*
 	 * Note, if the node ID contains a non-local bus ID, physical DMA is
@@ -2734,8 +2727,6 @@ static int ohci_enable_phys_dma(struct fw_card *card,
 		reg_write(ohci, OHCI1394_PhyReqFilterHiSet, 1 << (n - 32));
 
 	flush_writes(ohci);
- out:
-	spin_unlock_irqrestore(&ohci->lock, flags);
 
 	return ret;
 }
@@ -3076,55 +3067,53 @@ static struct fw_iso_context *ohci_allocate_iso_context(struct fw_card *card,
 	u32 *mask, regs;
 	int index, ret = -EBUSY;
 
-	spin_lock_irq(&ohci->lock);
+	scoped_guard(spinlock_irq, &ohci->lock) {
+		switch (type) {
+		case FW_ISO_CONTEXT_TRANSMIT:
+			mask     = &ohci->it_context_mask;
+			callback = handle_it_packet;
+			index    = ffs(*mask) - 1;
+			if (index >= 0) {
+				*mask &= ~(1 << index);
+				regs = OHCI1394_IsoXmitContextBase(index);
+				ctx  = &ohci->it_context_list[index];
+			}
+			break;
 
-	switch (type) {
-	case FW_ISO_CONTEXT_TRANSMIT:
-		mask     = &ohci->it_context_mask;
-		callback = handle_it_packet;
-		index    = ffs(*mask) - 1;
-		if (index >= 0) {
-			*mask &= ~(1 << index);
-			regs = OHCI1394_IsoXmitContextBase(index);
-			ctx  = &ohci->it_context_list[index];
-		}
-		break;
+		case FW_ISO_CONTEXT_RECEIVE:
+			channels = &ohci->ir_context_channels;
+			mask     = &ohci->ir_context_mask;
+			callback = handle_ir_packet_per_buffer;
+			index    = *channels & 1ULL << channel ? ffs(*mask) - 1 : -1;
+			if (index >= 0) {
+				*channels &= ~(1ULL << channel);
+				*mask     &= ~(1 << index);
+				regs = OHCI1394_IsoRcvContextBase(index);
+				ctx  = &ohci->ir_context_list[index];
+			}
+			break;
 
-	case FW_ISO_CONTEXT_RECEIVE:
-		channels = &ohci->ir_context_channels;
-		mask     = &ohci->ir_context_mask;
-		callback = handle_ir_packet_per_buffer;
-		index    = *channels & 1ULL << channel ? ffs(*mask) - 1 : -1;
-		if (index >= 0) {
-			*channels &= ~(1ULL << channel);
-			*mask     &= ~(1 << index);
-			regs = OHCI1394_IsoRcvContextBase(index);
-			ctx  = &ohci->ir_context_list[index];
-		}
-		break;
+		case FW_ISO_CONTEXT_RECEIVE_MULTICHANNEL:
+			mask     = &ohci->ir_context_mask;
+			callback = handle_ir_buffer_fill;
+			index    = !ohci->mc_allocated ? ffs(*mask) - 1 : -1;
+			if (index >= 0) {
+				ohci->mc_allocated = true;
+				*mask &= ~(1 << index);
+				regs = OHCI1394_IsoRcvContextBase(index);
+				ctx  = &ohci->ir_context_list[index];
+			}
+			break;
 
-	case FW_ISO_CONTEXT_RECEIVE_MULTICHANNEL:
-		mask     = &ohci->ir_context_mask;
-		callback = handle_ir_buffer_fill;
-		index    = !ohci->mc_allocated ? ffs(*mask) - 1 : -1;
-		if (index >= 0) {
-			ohci->mc_allocated = true;
-			*mask &= ~(1 << index);
-			regs = OHCI1394_IsoRcvContextBase(index);
-			ctx  = &ohci->ir_context_list[index];
+		default:
+			index = -1;
+			ret = -ENOSYS;
 		}
-		break;
 
-	default:
-		index = -1;
-		ret = -ENOSYS;
+		if (index < 0)
+			return ERR_PTR(ret);
 	}
 
-	spin_unlock_irq(&ohci->lock);
-
-	if (index < 0)
-		return ERR_PTR(ret);
-
 	memset(ctx, 0, sizeof(*ctx));
 	ctx->header_length = 0;
 	ctx->header = (void *) __get_free_page(GFP_KERNEL);
@@ -3146,7 +3135,7 @@ static struct fw_iso_context *ohci_allocate_iso_context(struct fw_card *card,
  out_with_header:
 	free_page((unsigned long)ctx->header);
  out:
-	spin_lock_irq(&ohci->lock);
+	guard(spinlock_irq)(&ohci->lock);
 
 	switch (type) {
 	case FW_ISO_CONTEXT_RECEIVE:
@@ -3159,8 +3148,6 @@ static struct fw_iso_context *ohci_allocate_iso_context(struct fw_card *card,
 	}
 	*mask |= 1 << index;
 
-	spin_unlock_irq(&ohci->lock);
-
 	return ERR_PTR(ret);
 }
 
@@ -3243,14 +3230,13 @@ static void ohci_free_iso_context(struct fw_iso_context *base)
 {
 	struct fw_ohci *ohci = fw_ohci(base->card);
 	struct iso_context *ctx = container_of(base, struct iso_context, base);
-	unsigned long flags;
 	int index;
 
 	ohci_stop_iso(base);
 	context_release(&ctx->context);
 	free_page((unsigned long)ctx->header);
 
-	spin_lock_irqsave(&ohci->lock, flags);
+	guard(spinlock_irqsave)(&ohci->lock);
 
 	switch (base->type) {
 	case FW_ISO_CONTEXT_TRANSMIT:
@@ -3272,38 +3258,29 @@ static void ohci_free_iso_context(struct fw_iso_context *base)
 		ohci->mc_allocated = false;
 		break;
 	}
-
-	spin_unlock_irqrestore(&ohci->lock, flags);
 }
 
 static int ohci_set_iso_channels(struct fw_iso_context *base, u64 *channels)
 {
 	struct fw_ohci *ohci = fw_ohci(base->card);
-	unsigned long flags;
-	int ret;
 
 	switch (base->type) {
 	case FW_ISO_CONTEXT_RECEIVE_MULTICHANNEL:
+	{
+		guard(spinlock_irqsave)(&ohci->lock);
 
-		spin_lock_irqsave(&ohci->lock, flags);
-
-		/* Don't allow multichannel to grab other contexts' channels. */
+		// Don't allow multichannel to grab other contexts' channels.
 		if (~ohci->ir_context_channels & ~ohci->mc_channels & *channels) {
 			*channels = ohci->ir_context_channels;
-			ret = -EBUSY;
+			return -EBUSY;
 		} else {
 			set_multichannel_mask(ohci, *channels);
-			ret = 0;
+			return 0;
 		}
-
-		spin_unlock_irqrestore(&ohci->lock, flags);
-
-		break;
+	}
 	default:
-		ret = -EINVAL;
+		return -EINVAL;
 	}
-
-	return ret;
 }
 
 #ifdef CONFIG_PM
@@ -3573,24 +3550,19 @@ static int ohci_queue_iso(struct fw_iso_context *base,
 			  unsigned long payload)
 {
 	struct iso_context *ctx = container_of(base, struct iso_context, base);
-	unsigned long flags;
-	int ret = -ENOSYS;
 
-	spin_lock_irqsave(&ctx->context.ohci->lock, flags);
+	guard(spinlock_irqsave)(&ctx->context.ohci->lock);
+
 	switch (base->type) {
 	case FW_ISO_CONTEXT_TRANSMIT:
-		ret = queue_iso_transmit(ctx, packet, buffer, payload);
-		break;
+		return queue_iso_transmit(ctx, packet, buffer, payload);
 	case FW_ISO_CONTEXT_RECEIVE:
-		ret = queue_iso_packet_per_buffer(ctx, packet, buffer, payload);
-		break;
+		return queue_iso_packet_per_buffer(ctx, packet, buffer, payload);
 	case FW_ISO_CONTEXT_RECEIVE_MULTICHANNEL:
-		ret = queue_iso_buffer_fill(ctx, packet, buffer, payload);
-		break;
+		return queue_iso_buffer_fill(ctx, packet, buffer, payload);
+	default:
+		return -ENOSYS;
 	}
-	spin_unlock_irqrestore(&ctx->context.ohci->lock, flags);
-
-	return ret;
 }
 
 static void ohci_flush_queue_iso(struct fw_iso_context *base)
-- 
2.43.0


