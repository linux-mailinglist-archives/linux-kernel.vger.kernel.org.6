Return-Path: <linux-kernel+bounces-274401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 553229477BA
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 10:58:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9C921F224F7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 08:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99EE1158A03;
	Mon,  5 Aug 2024 08:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="RgVEt70r";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uAXVTM86"
Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EBA31581F7
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 08:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722848077; cv=none; b=jDIcHRrQNZ+vNsg/BkD8TlKg97RpETGqJG0cIK5EeuHzxywflM3ahClWEioc9/QW0pHH3A6wVC6eQpnScsRvsT6UFZgYwvzVzLkM3Be4F7MA1skziJ0MNvyCHMwR4+ER398gxWpLUuFbmf5A1F2dOGfEctxyJrYVLb9Ml1QyOn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722848077; c=relaxed/simple;
	bh=svBF9jtACmNy7W1IHbAFhFQHdueMPV/of/FXrm7txro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fjlsILxQ9pkBvFVXqpdopFyKb6mRCqhozvPLCPJXZF6TEpIB+d16SvAWWrT/stdDayZt7Cdd4VpCgJxY++GgbZwHXAmJN1muX17rMbSsdX34cQnVoaJCF75/aBqOC7AZqmHHEeYY8zYPmV0cIlNFmfJZJClqNCZV19C4uXNIgUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=RgVEt70r; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uAXVTM86; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id C01D5138FDBC;
	Mon,  5 Aug 2024 04:54:34 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 05 Aug 2024 04:54:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1722848074; x=
	1722934474; bh=kdsG2PJz0GJocG9ZLnehQX7pZUw+tAe5s31sau+KXtk=; b=R
	gVEt70rTfS1JwNrhu5vYJEx+jHTnuzPXV8NZNG0z8dC1D0se7MN/u+SJ5PNbx1UD
	e1pTdSLchBbetska/vHtAu5K3VPwOqOAhRrSimrtyRXlm8co0/GG81EgMzAhsqyx
	LdGjFfnjpfwgEUhn/d6I+FOI7y9A+AJggL05NeNZRrVNFTOSPEiio/4+0wy1+Jk4
	kKZLGfs+r0zwAYV6krnKa6Q+BnHw1bgHkMI+kA6klaf5pxehoHe76JwQZdu7ogSd
	ZZeH7YTJN4HM1Y4lJkaucdSiXdUmGzYT73kKq+WAS7TmNybwD0DC+HaRAn8vf+/k
	UhgFc/qF5PPhlz3kfpWaA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1722848074; x=
	1722934474; bh=kdsG2PJz0GJocG9ZLnehQX7pZUw+tAe5s31sau+KXtk=; b=u
	AXVTM86HIotktWfkHbSJ3ErlRO6Mt2xXP/rYheQdXSnZDWQ/VTMWnhzd+lgZaC8o
	fqI7xBFlSFKM303D/m5Ws5S61AIuxLNwdt6UrrQasVga2pBUDnE+DL6YuNh62YFs
	6zeReIOHKn2k9P7XTtx5zv42dLGAaVVGaEUD3S8wnvi3bRT17owIC/EsspNdpiXK
	rdEKRM4mALE3f7VDdewc8mQyfML3llUMgCvHJ+eAMdowOWUdftrC6DbCPxA23j/b
	aSiviUS6jbtfV4FsLzslm5f0kia2IbXuz+uy/fHZx+aXGz9I9ls/ryOZ0ShklvtK
	EBzOsDhFmyAxDQaiy7wOQ==
X-ME-Sender: <xms:SpOwZjohnsn1C0YKLGb7FgMoaDbvLulEwNJFyXICRJBTbUi6PV9qmw>
    <xme:SpOwZtpdnB8QS4nrowr7H9tmjEUBhT8hS1YMihPjz4kBkw0ZlSYj2zZTXn2QUt24H
    ghMl03ttlFDYUNWsgY>
X-ME-Received: <xmr:SpOwZgMqPnp3NPFlVI9861G9PFrm-jtjwlmFxASxNuiyoN6I50PKBMnVPOZSFIMyvfI83zT-spvOZI0cer4SDch_Tri5a-IEQOD4juwIcWI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeeigddutdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgr
    shhhihesshgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhepvdejgfejue
    dvgfduudekleevtefgtdevhfdtffefiefgveeuteffiedvffekvddtnecuvehluhhsthgv
    rhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepohdqthgrkhgrshhhihessh
    grkhgrmhhotggthhhirdhjphdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:SpOwZm4B3n_tu-UiJoJtGENYiGsGLwI-8NhMDiLjsDbK9GnxISB6WA>
    <xmx:SpOwZi40e9gf5wU6LrRutM50rf1KYZjXuLfXoQgnfPO1RYSRlXWAzA>
    <xmx:SpOwZugnpVytPvlUYOKvtnALyykiXCT45bsWEcrHXQakKtddc7AxUg>
    <xmx:SpOwZk7_qUA38y741B27iSMW4GN-zsQewMUA0JEiczcsfdIstMKxKw>
    <xmx:SpOwZiFZu0ZbUmxk6H8s6RfK4_omwYfKENccVuvVxYjX6nVfKbIXRRFS>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Aug 2024 04:54:33 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH v2 17/17] firewire: ohci: use guard macro to serialize operations for isochronous contexts
Date: Mon,  5 Aug 2024 17:54:08 +0900
Message-ID: <20240805085408.251763-18-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240805085408.251763-1-o-takashi@sakamocchi.jp>
References: <20240805085408.251763-1-o-takashi@sakamocchi.jp>
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
 drivers/firewire/ohci.c | 182 +++++++++++++++++-----------------------
 1 file changed, 77 insertions(+), 105 deletions(-)

diff --git a/drivers/firewire/ohci.c b/drivers/firewire/ohci.c
index 368420e4b414..e1d24e0ec991 100644
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
@@ -3146,20 +3135,18 @@ static struct fw_iso_context *ohci_allocate_iso_context(struct fw_card *card,
  out_with_header:
 	free_page((unsigned long)ctx->header);
  out:
-	spin_lock_irq(&ohci->lock);
-
-	switch (type) {
-	case FW_ISO_CONTEXT_RECEIVE:
-		*channels |= 1ULL << channel;
-		break;
+	scoped_guard(spinlock_irq, &ohci->lock) {
+		switch (type) {
+		case FW_ISO_CONTEXT_RECEIVE:
+			*channels |= 1ULL << channel;
+			break;
 
-	case FW_ISO_CONTEXT_RECEIVE_MULTICHANNEL:
-		ohci->mc_allocated = false;
-		break;
+		case FW_ISO_CONTEXT_RECEIVE_MULTICHANNEL:
+			ohci->mc_allocated = false;
+			break;
+		}
+		*mask |= 1 << index;
 	}
-	*mask |= 1 << index;
-
-	spin_unlock_irq(&ohci->lock);
 
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


