Return-Path: <linux-kernel+bounces-524843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C0BCA3E7BB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 23:46:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04F9F7AAB9B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 22:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECA7F1F1307;
	Thu, 20 Feb 2025 22:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CEqhqW1n"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853E4286280;
	Thu, 20 Feb 2025 22:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740091575; cv=none; b=ttMR9D0uuRumNPaWZMmsuGfSRlWGx3/nQ3NkIh9kptv+QzfX5xF4YhUrJGlVTcyM32Uhnt59fR3EHuk6Yxr5nPalFW3l071S8TDFc+laGSll26yg2x4M1GLedKTUCBAhNWtH8R088rW7gUYoOHh3f++bnvcZ0aAx+CjRq3UBB9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740091575; c=relaxed/simple;
	bh=VjcdSM7jkBfOBRLluqGyxoH0x0ZruLmFMN88j3QleGs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mMCIi7OSmy5XB8lLS/FgB9h592lIJJf16vru4anUaDnJJJ4WYugt8rZbjIyFGHYaWHwZejqUrHkkeveNMGxpg7K9v/g0KQ7LoN3WtYyyofpJtKZkYA7MjONwqg+vGjaid7BX4tbFcHRPBUxoxdqkj2ESgHXAob0MN1QpRARfPaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CEqhqW1n; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-abb7f539c35so300116866b.1;
        Thu, 20 Feb 2025 14:46:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740091572; x=1740696372; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dqud8wKtVhcF+nQlewcEqgt8gw382UeB7n3VyIg4LE4=;
        b=CEqhqW1nNaJq6yy4eCJoHOpF3F7GTy+ynCQ3uebbLxiZc20yH7QnIa3tZP4qKrDrCl
         k1/K4USRKCnxfK1PXwJIBUr5IAtVu1NfhN8zBgnpJh1uxhcJ+et+eVO1ZPDwRdP4XQW6
         RgdzTWfmzQy6M0v31cWvFNqisZJftVPAPiv6eNOn7u/e94lIsUsoaHITOhjCWVyIJgbW
         E3vqkmelT1HDyvp5VJftFifBNYe+rydcbyUjK31sHXCvwfb6K/PaJ+d7cBoBfzOllm9+
         nQJAzxpHJHbXTiFD4E1nKy8TgUpI0B4TKJynnia3HUEmJppgfdGTgAv31HX69ux2PUw7
         wbng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740091572; x=1740696372;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dqud8wKtVhcF+nQlewcEqgt8gw382UeB7n3VyIg4LE4=;
        b=KoOYRU5ZHNbC2KymfCnevRsgZDTwl+VZB6hOis0eSCW1q8Uls9hDDh3a3OQfLoCbmO
         K5gu9X3W9wCodkTAKp9sHZSuWwcmUtzmEYUKq9sWabuRIT3SBT6yl1XITLcnJ8xlrVnD
         m8GzW5/+NKxKP+O2xXuX1OruZ4NcOsiAkHqqH+6Y3X9+iTZ33qkpzRxbXKO5b1S87tM1
         YpBEQPnQY5OKnP0Yi1muj6KFKZLwpl2hddaKxKKpDl3WmBWvtA0B47gwHCgoB9Q/kGy6
         aIJU7JrC2k3gi1zIBjIBu1ekZHsxpiXgK79TuaZQXUx643O+ZjPXxmbHqfpRqx23Umav
         F4Kw==
X-Forwarded-Encrypted: i=1; AJvYcCXWsMXtSSWHZUAZOEic73Cg6JD4WpVpSVCjSUVvZnaV8X82kv/kgjNuCf63sA8HA8F0DYvwCUhp8yWktis=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQlODRiwycOcqMfSL4Bk7jst/1ODzTWbTpoLUU2MTSVZqvhLVq
	dhexhtapxwcTZ/f6251Zr2NXHGorzQpdyCDFhCSRsRP9Ho9y01Gv
X-Gm-Gg: ASbGncu1jQZdI1rd8W0Gi5wLQZQe6LVPRxQQxd/VKYSwdyoIzeIlzJj3eluDODSGJSF
	T9zOcV0a2mjjX6cg/oZi7a/ss0iiCKCBhyxhTJQUkaGMfIfPtUPy68WR23to+P3rRW0BxHc66nb
	UBbGGQ1brTW6ea8Enm1R0X/XxyjPkd4uvksikgA+QFs5ByQQhfWQ080F/PXmpJP10uVUBMpvo7A
	p5PGW5i485ADZZurSUr5Fo1iKNLhHFJ1nrmHCPbyoVjIrvHHIj6ye/9foFoOiY02fD8xvYYG6l/
	gC98VQMblXM6r3xzDHbCgofB3k4omWM8
X-Google-Smtp-Source: AGHT+IEOIFyFYQBT1qwuKjOfGx8is1L8KWgVUZIaR0zB3p1JTKkDtjLVxbEMPsGSB2c/cLktR3DABw==
X-Received: by 2002:a17:907:7e91:b0:aa6:9503:aa73 with SMTP id a640c23a62f3a-abc09d2d323mr113893766b.51.1740091571712;
        Thu, 20 Feb 2025 14:46:11 -0800 (PST)
Received: from foxbook (adtt173.neoplus.adsl.tpnet.pl. [79.185.231.173])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba53231fcasm1529786866b.25.2025.02.20.14.46.10
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 20 Feb 2025 14:46:11 -0800 (PST)
Date: Thu, 20 Feb 2025 23:46:08 +0100
From: Michal Pecio <michal.pecio@gmail.com>
To: Mathias Nyman <mathias.nyman@intel.com>, Greg Kroah-Hartman  
 <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] usb: xhci: Simplify moving HW Dequeue Pointer past
 cancelled TDs
Message-ID: <20250220234608.6c237c3c@foxbook>
In-Reply-To: <20250220234355.2386cb6d@foxbook>
References: <20250220234355.2386cb6d@foxbook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

xhci_move_dequeue_past_td() uses a relatively complex and inefficient
procedure to find new dequeue position after the cancelled TD.

Replace it with a simpler function which moves dequeue immediately to
the first pending TD, or to enqueue if the ring is empty.

The outcome should be basically equivalent, because we only clear xHC
cache if it stopped or halted on some cancelled TD and moving past the
TD effectively means moving to the first remaining TD, if any.

If the cancelled TD is followed by more cancelled TDs turned into No-
Ops, we will now jump over them and save the xHC some work.

Signed-off-by: Michal Pecio <michal.pecio@gmail.com>
---
 drivers/usb/host/xhci-ring.c | 64 ++++++++++--------------------------
 1 file changed, 18 insertions(+), 46 deletions(-)

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index c983d22842dc..46ca98066856 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -635,9 +635,9 @@ static u64 xhci_get_hw_deq(struct xhci_hcd *xhci, struct xhci_virt_device *vdev,
 	return le64_to_cpu(ep_ctx->deq);
 }
 
-static int xhci_move_dequeue_past_td(struct xhci_hcd *xhci,
-				unsigned int slot_id, unsigned int ep_index,
-				unsigned int stream_id, struct xhci_td *td)
+/* Move HW dequeue to the first pending TD or to our enqueue if there are no TDs */
+static int set_ring_dequeue(struct xhci_hcd *xhci, unsigned int slot_id,
+				unsigned int ep_index, unsigned int stream_id)
 {
 	struct xhci_virt_device *dev = xhci->devs[slot_id];
 	struct xhci_virt_ep *ep = &dev->eps[ep_index];
@@ -645,58 +645,31 @@ static int xhci_move_dequeue_past_td(struct xhci_hcd *xhci,
 	struct xhci_command *cmd;
 	struct xhci_segment *new_seg;
 	union xhci_trb *new_deq;
+	struct xhci_td *td;
 	int new_cycle;
 	dma_addr_t addr;
-	u64 hw_dequeue;
-	bool cycle_found = false;
-	bool td_last_trb_found = false;
 	u32 trb_sct = 0;
 	int ret;
 
-	ep_ring = xhci_triad_to_transfer_ring(xhci, slot_id,
-			ep_index, stream_id);
+	ep_ring = xhci_triad_to_transfer_ring(xhci, slot_id, ep_index, stream_id);
+
 	if (!ep_ring) {
 		xhci_warn(xhci, "WARN can't find new dequeue, invalid stream ID %u\n",
 			  stream_id);
 		return -ENODEV;
 	}
 
-	hw_dequeue = xhci_get_hw_deq(xhci, dev, ep_index, stream_id);
-	new_seg = ep_ring->deq_seg;
-	new_deq = ep_ring->dequeue;
-	new_cycle = hw_dequeue & 0x1;
+	if (!list_empty(&ep_ring->td_list)) {
+		td = list_first_entry(&ep_ring->td_list, struct xhci_td, td_list);
+		new_seg = td->start_seg;
+		new_deq = td->start_trb;
+		new_cycle = le32_to_cpu(new_deq->generic.field[3]) & TRB_CYCLE;
+	} else {
+		new_seg = ep_ring->enq_seg;
+		new_deq = ep_ring->enqueue;
+		new_cycle = ep_ring->cycle_state;
+	}
 
-	/*
-	 * We want to find the pointer, segment and cycle state of the new trb
-	 * (the one after current TD's end_trb). We know the cycle state at
-	 * hw_dequeue, so walk the ring until both hw_dequeue and end_trb are
-	 * found.
-	 */
-	do {
-		if (!cycle_found && xhci_trb_virt_to_dma(new_seg, new_deq)
-		    == (dma_addr_t)(hw_dequeue & ~0xf)) {
-			cycle_found = true;
-			if (td_last_trb_found)
-				break;
-		}
-		if (new_deq == td->end_trb)
-			td_last_trb_found = true;
-
-		if (cycle_found && trb_is_link(new_deq) &&
-		    link_trb_toggles_cycle(new_deq))
-			new_cycle ^= 0x1;
-
-		next_trb(&new_seg, &new_deq);
-
-		/* Search wrapped around, bail out */
-		if (new_deq == ep->ring->dequeue) {
-			xhci_err(xhci, "Error: Failed finding new dequeue state\n");
-			return -EINVAL;
-		}
-
-	} while (!cycle_found || !td_last_trb_found);
-
-	/* Don't update the ring cycle state for the producer (us). */
 	addr = xhci_trb_virt_to_dma(new_seg, new_deq);
 	if (addr == 0) {
 		xhci_warn(xhci, "Can't find dma of new dequeue ptr\n");
@@ -1060,9 +1033,8 @@ static int xhci_invalidate_cancelled_tds(struct xhci_virt_ep *ep)
 	if (!cached_td)
 		return 0;
 
-	err = xhci_move_dequeue_past_td(xhci, slot_id, ep->ep_index,
-					cached_td->urb->stream_id,
-					cached_td);
+	err = set_ring_dequeue(xhci, slot_id, ep->ep_index, cached_td->urb->stream_id);
+
 	if (err) {
 		/* Failed to move past cached td, just set cached TDs to no-op */
 		list_for_each_entry_safe(td, tmp_td, &ep->cancelled_td_list, cancelled_td_list) {
-- 
2.48.1

