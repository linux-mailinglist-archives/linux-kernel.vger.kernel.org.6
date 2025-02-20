Return-Path: <linux-kernel+bounces-524844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77DB3A3E7BF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 23:47:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 899C619C5061
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 22:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F541264620;
	Thu, 20 Feb 2025 22:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FQyiDzvp"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0030286280;
	Thu, 20 Feb 2025 22:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740091647; cv=none; b=u+P3baZwgV0+S/jg9EXstdZbNBFf3UGNXkzgaojcv49XSE6qa0L4ETN6VTZGneXzKijkKOjrBq7iwt+bzrOCsRCQp7HmGkaMYxR8RteHpnPLCVgcmUjQedmIbTj+ab9eju23zqWt62LJnacTQolaSbkdLeE+nxpdqGOVH4ASdgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740091647; c=relaxed/simple;
	bh=s/2C/idZxVr/sUnGevnEWDwOoLaTWT84lBSdQHf+vBI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IM0TizmWt7vNrJAlVXZFXLX9nkSazXQAro0QF9u3W1d7KqVBe8/Q1rLb6QIop04Btu8+tsTu5BY9UC4Bx3+Raoee6sR5t+2tVIRzZABSB6WYUghjGiCUemtrdvoU7MmS+FHvzZogXsMNkeM9d2jUQcXbcyHvyKUx2UUnFjwkYmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FQyiDzvp; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-abb81285d33so303523866b.0;
        Thu, 20 Feb 2025 14:47:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740091644; x=1740696444; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/gLpErkNQE0KsQqHzgUG/3dHmMGvVfVAYhb8vCOOc5s=;
        b=FQyiDzvp93eBtA3fO1g8zWD367kuQY0/VdYS1BVCHRUMJhxm3r1aKpZ8c6C2OOXIHm
         zB4nMLbi1SIzGYV+VZyxoewS+XDA1waTGy4QrwZk7vNFuTL6PvAYEyy1uynYuIiXTpQf
         lrmGPn8kArIg0EAhmu00oRmNkcFYDIcdlUY8u3in5EwyNFE/HcA0X4hrqeZ1SMnzMQ6S
         azQmLrxQD9UL8TP3lK35Sp22ZnrXjNxh6bRxxqtVeTx7RMFf6IoB0FMZypKsJH7wPPmg
         mUEcWUaLJpTXvCmVXcPSRq03QJJF0uHxN2JjKSoCF5m4WJOGP+za1bP39y+wYomQ9GVm
         8YEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740091644; x=1740696444;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/gLpErkNQE0KsQqHzgUG/3dHmMGvVfVAYhb8vCOOc5s=;
        b=FmI0RqoNjcmjBi6eZj7/07+fQE+NZkqFajsHUR85ryq9qP0XheiMuWS2VKv3nkWwMJ
         HFkwFCeWXO33QEI6cPvaVGrj6rCsAnWaALw49HGDK5ppI81h6qY1kovX2VKVfwPGOMJN
         vhVatx9m0ltiJdbov6yyQTg6OmqDOJsVYOd1fCG7S5vIgOKZ+mZ7C4ZHQqVqyd5wGHH3
         EbCR0Y0kQ0dt6nKT5fSFieOr5mhPs6F4M3QYwFOfh5Gf2tu7TZvkFsd1QQEeDecF+C9h
         iIl9egSGDpiruh8SdTmdb6k2h9zlMnJEzah0FnoVQQN6qNHpHLvRBGGrw5Ljzyt04pIh
         d7AA==
X-Forwarded-Encrypted: i=1; AJvYcCUTau9wvCBnpWRc/UPU3TlXXufTqcnXZU331Ij0eg6DdDT9UhRDVFJhJxZa/CYrWNwK+lPO01Qp4J9OKiY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3e+UB+WiU35tvD7kCH5DTapvUmbCa2evIUnQxNFTis+x1WHE/
	w/uVk0ZqVxmGb04oHDP5QiIXKydE4vsj9L+bGhmY/lSh16q5aeL8
X-Gm-Gg: ASbGncsV4YV7kbM9PkksiNxCi8uiUn+eBLj7s5ByVhnoFefA87tD9g68dlCcuyAGExj
	e2pPxtrg9iUVVUJ9fSZeyLDuMP41csmjfe12xRNtv26MBjDfGAl+GVBEGRSUO0xZtxfKjwVZdBy
	JAaG5U6GKDgmwBObJwYKerbpMCCiU5suBfV0dZaTU6IA2AxgXK6e7xCPF/p96mD8tsQkzJwpiKN
	UOmnLArXsM9IROewtLPUpxI53/f+RJwGfp1QATm2Txbwr5Mw5oFjUFnymq9ChHPjA4rnpcTfb9k
	aWb0CCovRqV//0BtMl3RdHF0IRsef6qm
X-Google-Smtp-Source: AGHT+IFemfasOHeY31ikiD97smK7HrcLw2GSDrHnrqEgYlwi1Y2P+HnM6DmqemXdYA6Fm88u1iCuhw==
X-Received: by 2002:a17:907:7ba1:b0:aba:5f40:75e1 with SMTP id a640c23a62f3a-abc09e3cb0bmr137522566b.57.1740091643865;
        Thu, 20 Feb 2025 14:47:23 -0800 (PST)
Received: from foxbook (adtt173.neoplus.adsl.tpnet.pl. [79.185.231.173])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb9b5218c6sm849035766b.125.2025.02.20.14.47.21
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 20 Feb 2025 14:47:23 -0800 (PST)
Date: Thu, 20 Feb 2025 23:47:19 +0100
From: Michal Pecio <michal.pecio@gmail.com>
To: Mathias Nyman <mathias.nyman@intel.com>, Greg Kroah-Hartman  
 <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] usb: xhci: Unify duplicate inc_enq() code
Message-ID: <20250220234719.5dc47877@foxbook>
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

Remove a block of code copied from inc_enq(). As often happens, the two
copies have diverged somewhat - in this case, inc_enq() has a bug where
it may leave the chain bit of a link TRB unset on a quirky HC. Fix this.
Remove the pointless 'next' variable which only aliases ring->enqueue.

Note: I don't know if any 0.95 xHC ever reached series production, but
"AMD 0.96 host" appears to be the "Llano" family APU. Example dmesg at
https://linux-hardware.org/?probe=79d5cfd4fd&log=dmesg

pci 0000:00:10.0: [1022:7812] type 00 class 0x0c0330
hcc params 0x014042c3 hci version 0x96 quirks 0x0000000000000608

Signed-off-by: Michal Pecio <michal.pecio@gmail.com>
---
 drivers/usb/host/xhci-ring.c | 135 +++++++++++++++--------------------
 1 file changed, 58 insertions(+), 77 deletions(-)

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 46ca98066856..f400ba85ebc5 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -208,6 +208,52 @@ void inc_deq(struct xhci_hcd *xhci, struct xhci_ring *ring)
 	return;
 }
 
+/*
+ * If enqueue points at a link TRB, follow links until an ordinary TRB is reached.
+ * Toggle the cycle bit of passed link TRBs and optionally chain them.
+ */
+static void inc_enq_past_link(struct xhci_hcd *xhci, struct xhci_ring *ring, u32 chain)
+{
+	unsigned int link_trb_count = 0;
+
+	while (trb_is_link(ring->enqueue)) {
+
+		/*
+		 * Section 6.4.4.1 of the 0.95 spec says link TRBs cannot have the chain bit
+		 * set, but other sections talk about dealing with the chain bit set. This was
+		 * fixed in the 0.96 specification errata, but we have to assume that all 0.95
+		 * xHCI hardware can't handle the chain bit being cleared on a link TRB.
+		 *
+		 * If we're dealing with 0.95 hardware or isoc rings on AMD 0.96 host, override
+		 * the chain bit to always be set.
+		 */
+		if (!xhci_link_chain_quirk(xhci, ring->type)) {
+			ring->enqueue->link.control &= cpu_to_le32(~TRB_CHAIN);
+			ring->enqueue->link.control |= cpu_to_le32(chain);
+		} else {
+			ring->enqueue->link.control |= cpu_to_le32(TRB_CHAIN);
+		}
+
+		/* Give this link TRB to the hardware */
+		wmb();
+		ring->enqueue->link.control ^= cpu_to_le32(TRB_CYCLE);
+
+		/* Toggle the cycle bit after the last ring segment. */
+		if (link_trb_toggles_cycle(ring->enqueue))
+			ring->cycle_state ^= 1;
+
+		ring->enq_seg = ring->enq_seg->next;
+		ring->enqueue = ring->enq_seg->trbs;
+
+		trace_xhci_inc_enq(ring);
+
+		if (link_trb_count++ > ring->num_segs) {
+			xhci_warn(xhci, "Link TRB loop at enqueue\n");
+			break;
+		}
+	}
+}
+
 /*
  * See Cycle bit rules. SW is the consumer for the event ring only.
  *
@@ -216,11 +262,6 @@ void inc_deq(struct xhci_hcd *xhci, struct xhci_ring *ring)
  * If we've enqueued the last TRB in a TD, make sure the following link TRBs
  * have their chain bit cleared (so that each Link TRB is a separate TD).
  *
- * Section 6.4.4.1 of the 0.95 spec says link TRBs cannot have the chain bit
- * set, but other sections talk about dealing with the chain bit set.  This was
- * fixed in the 0.96 specification errata, but we have to assume that all 0.95
- * xHCI hardware can't handle the chain bit being cleared on a link TRB.
- *
  * @more_trbs_coming:	Will you enqueue more TRBs before calling
  *			prepare_transfer()?
  */
@@ -228,8 +269,6 @@ static void inc_enq(struct xhci_hcd *xhci, struct xhci_ring *ring,
 			bool more_trbs_coming)
 {
 	u32 chain;
-	union xhci_trb *next;
-	unsigned int link_trb_count = 0;
 
 	chain = le32_to_cpu(ring->enqueue->generic.field[3]) & TRB_CHAIN;
 
@@ -238,48 +277,16 @@ static void inc_enq(struct xhci_hcd *xhci, struct xhci_ring *ring,
 		return;
 	}
 
-	next = ++(ring->enqueue);
-
-	/* Update the dequeue pointer further if that was a link TRB */
-	while (trb_is_link(next)) {
-
-		/*
-		 * If the caller doesn't plan on enqueueing more TDs before
-		 * ringing the doorbell, then we don't want to give the link TRB
-		 * to the hardware just yet. We'll give the link TRB back in
-		 * prepare_ring() just before we enqueue the TD at the top of
-		 * the ring.
-		 */
-		if (!chain && !more_trbs_coming)
-			break;
-
-		/* If we're not dealing with 0.95 hardware or isoc rings on
-		 * AMD 0.96 host, carry over the chain bit of the previous TRB
-		 * (which may mean the chain bit is cleared).
-		 */
-		if (!xhci_link_chain_quirk(xhci, ring->type)) {
-			next->link.control &= cpu_to_le32(~TRB_CHAIN);
-			next->link.control |= cpu_to_le32(chain);
-		}
-		/* Give this link TRB to the hardware */
-		wmb();
-		next->link.control ^= cpu_to_le32(TRB_CYCLE);
-
-		/* Toggle the cycle bit after the last ring segment. */
-		if (link_trb_toggles_cycle(next))
-			ring->cycle_state ^= 1;
-
-		ring->enq_seg = ring->enq_seg->next;
-		ring->enqueue = ring->enq_seg->trbs;
-		next = ring->enqueue;
-
-		trace_xhci_inc_enq(ring);
-
-		if (link_trb_count++ > ring->num_segs) {
-			xhci_warn(xhci, "%s: Ring link TRB loop\n", __func__);
-			break;
-		}
-	}
+	ring->enqueue++;
+
+	/*
+	 * If we are in the middle of a TD or the caller plans to enqueue more
+	 * TDs as one transfer (eg. control), traverse any link TRBs right now.
+	 * Otherwise, enqueue can stay on a link until the next prepare_ring().
+	 * This avoids enqueue entering deq_seg and simplifies ring expansion.
+	 */
+	if (chain || more_trbs_coming)
+		inc_enq_past_link(xhci, ring, chain);
 }
 
 /*
@@ -3177,7 +3184,6 @@ static void queue_trb(struct xhci_hcd *xhci, struct xhci_ring *ring,
 static int prepare_ring(struct xhci_hcd *xhci, struct xhci_ring *ep_ring,
 		u32 ep_state, unsigned int num_trbs, gfp_t mem_flags)
 {
-	unsigned int link_trb_count = 0;
 	unsigned int new_segs = 0;
 
 	/* Make sure the endpoint has been added to xHC schedule */
@@ -3225,33 +3231,8 @@ static int prepare_ring(struct xhci_hcd *xhci, struct xhci_ring *ep_ring,
 		}
 	}
 
-	while (trb_is_link(ep_ring->enqueue)) {
-		/* If we're not dealing with 0.95 hardware or isoc rings
-		 * on AMD 0.96 host, clear the chain bit.
-		 */
-		if (!xhci_link_chain_quirk(xhci, ep_ring->type))
-			ep_ring->enqueue->link.control &=
-				cpu_to_le32(~TRB_CHAIN);
-		else
-			ep_ring->enqueue->link.control |=
-				cpu_to_le32(TRB_CHAIN);
-
-		wmb();
-		ep_ring->enqueue->link.control ^= cpu_to_le32(TRB_CYCLE);
-
-		/* Toggle the cycle bit after the last ring segment. */
-		if (link_trb_toggles_cycle(ep_ring->enqueue))
-			ep_ring->cycle_state ^= 1;
-
-		ep_ring->enq_seg = ep_ring->enq_seg->next;
-		ep_ring->enqueue = ep_ring->enq_seg->trbs;
-
-		/* prevent infinite loop if all first trbs are link trbs */
-		if (link_trb_count++ > ep_ring->num_segs) {
-			xhci_warn(xhci, "Ring is an endless link TRB loop\n");
-			return -EINVAL;
-		}
-	}
+	/* Ensure that new TRBs won't overwrite a link */
+	inc_enq_past_link(xhci, ep_ring, 0);
 
 	if (last_trb_on_seg(ep_ring->enq_seg, ep_ring->enqueue)) {
 		xhci_warn(xhci, "Missing link TRB at end of ring segment\n");
-- 
2.48.1

