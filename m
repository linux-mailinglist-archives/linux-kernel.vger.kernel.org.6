Return-Path: <linux-kernel+bounces-531297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B99A43E98
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 13:02:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 990EF19C45C9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 12:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94F1F267F55;
	Tue, 25 Feb 2025 12:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k4GX/Xkc"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30B51FC7ED;
	Tue, 25 Feb 2025 12:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740484848; cv=none; b=qntBO+IY5rNixIkV2nylWJpYgr4etfsdgzAOUn5lweITgzsUgT6MKK+Gn2OcLVu2nl1InCY5I7ksg+h4P6OjuyHNqZfFx6/y8cTReBUiA2nDUkoqfL4XQqnQdrVWf2QPWqsyo40Dwvf9FHu8He+63B2zOq9xOvAsMQng1ekNdpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740484848; c=relaxed/simple;
	bh=qYkO5LfimN1/Jer9OMR+Qou9Gu4IEH+fQfeFB5lkWSo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=II4fa5joE/ohRyx4uy8gQqkvJ+DCia6agX5g56jwY210UHS4z6VXVF9ukfcgWE3YnJOgM5xtJzmuEm1fJxI5hvYxWYxRXpHYQXizjDjmyvCjZKSEGNKi/k/2owXlFkMV+EWXl6AP1IvzLSCY21wXsLQ7JVf3LxKuAmCX0loI4tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k4GX/Xkc; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-38f378498c9so5371018f8f.1;
        Tue, 25 Feb 2025 04:00:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740484843; x=1741089643; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AMXPKOnzcnUZjITiabLZD5X8E/oVFJtUkF9Rv7OIemk=;
        b=k4GX/Xkc0PFzG6FPwW+5EQJab+HWPam9QWr6t/HkgJyCJB2JdcAA0SZBSBBlL/ccrN
         oXmQY0l06XzTzjx+6ZqtqCXXV5VRNSrzk+heJ5tugBslX5EON4YvhUR9JIP3TqxPcH8R
         Tw8+Ch7sjKtC9kWDlrTqrdzno8PZZsBnPQS9kGzKTGDR5eEQlbY2ii3/6lxbzaoyCn9S
         fAcygWEmCz+Y2dft+ovU888WsbV0yl5xfsH3V/vwRrqRdEqsDxtWe2ma5sGF20nBNgAK
         jhpF/vBUXOPzFf1liPkx5JtAPlbQ01J2WGqRdpuOLk9Yz4LYYcNXn5EPgZjeV3PkhtVi
         MWYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740484843; x=1741089643;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AMXPKOnzcnUZjITiabLZD5X8E/oVFJtUkF9Rv7OIemk=;
        b=iSb6JUbfmLSMPveASCou2RBzwfGd/cZSCEcDJg5qRXi3l/iebxLvsISKlZUKDAPRf9
         jTwSpE3IFTyDQtZcsZU3qRJZ7on4hgNwlqXu5NMzZkR5JlM0JvVRriLvArAarg70HjnJ
         mA0SLHQcGyY1djAFyjA38liI1wr08WTn2wjZkS4/Mb3h1cpsbgUhhzCVSrv606QNae/X
         Nv2IWM8oAoG2tW8RifA3nF4oZhLfTeWPHRMqPh5jERufADqE7pqj+vk3zblxj4r9e5cJ
         IhC9E069NGp/1oCwkmwre1jMgvQ3G66kzlyJf5KEktzr8YDhZaae+RskuujiQfEh959k
         6ElQ==
X-Forwarded-Encrypted: i=1; AJvYcCXbvi/rRhnrwULDGnjvXUGmAyJTnWUDk6IYrZZjUm28C3xV/eVZE/sRlLEmTDqFXwOJHIzUyiDXnKP1DTg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhOa6HMF9k79aCVVLk0mdVvLxoEvkHrsJldj0gRlrozqE5zdOx
	PsY02gxsat+M204GXxfFtFUXQ25kAK5tAh8csUb1zE/v3OqGo0JddEF9jA==
X-Gm-Gg: ASbGncvUABxcK5MA6esuoDM5BHiqlZpWiQpY9cxx9OD9l6J8IaMAC3aat0p4zM1HqbJ
	vQuqoK56ba74Tr7iUonK/GUHaeQ2C8kgmbjsieGb6643WWg/FtKipYaNpWWZaMiRvafFP8slbiF
	nPbE59C7K3EIGUfdD8zrrWCivxVyz9TSEk893cBKzGnUZqWbCEnkFRciOE5mvGrPE6N6vP0sthI
	ElWRsSprxHPtABbYiq2wRdDl9S8XnIe9vVDQRpQxc/LVXNeZyQ6xfD0nwcMQ5jF8DHUDJzbmxBu
	xKh0BM0xU9/uYiUolfVpyIv156CXXocjuVMoIetwX2E=
X-Google-Smtp-Source: AGHT+IHJvSiOfl5TzDxqlHeDmI9+bsr6/FH6tBTba1O0k/BRjAEYRfaxlO6UbS5Kxi233TrBpbOS8Q==
X-Received: by 2002:a05:6402:2812:b0:5df:25e8:26d2 with SMTP id 4fb4d7f45d1cf-5e444853ee3mr6864975a12.5.1740484831860;
        Tue, 25 Feb 2025 04:00:31 -0800 (PST)
Received: from foxbook (adqm166.neoplus.adsl.tpnet.pl. [79.185.146.166])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed2012142sm128078866b.117.2025.02.25.04.00.31
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 25 Feb 2025 04:00:31 -0800 (PST)
Date: Tue, 25 Feb 2025 13:00:27 +0100
From: Michal Pecio <michal.pecio@gmail.com>
To: Mathias Nyman <mathias.nyman@intel.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] usb: xhci: Unify duplicate inc_enq() code
Message-ID: <20250225130027.6ace8a2f@foxbook>
In-Reply-To: <20250225125750.1b345e2c@foxbook>
References: <20250225125750.1b345e2c@foxbook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Extract a block of code copied from inc_enq() into a separate function
and call it from inc_enq() and the other function which used this code.
Remove the pointless 'next' variable which only aliases ring->enqueue.

Note: I don't know if any 0.95 xHC ever reached series production, but
"AMD 0.96 host" appears to be the "Llano" family APU. Example dmesg at
https://linux-hardware.org/?probe=79d5cfd4fd&log=dmesg

pci 0000:00:10.0: [1022:7812] type 00 class 0x0c0330
hcc params 0x014042c3 hci version 0x96 quirks 0x0000000000000608

Signed-off-by: Michal Pecio <michal.pecio@gmail.com>
---
 drivers/usb/host/xhci-ring.c | 134 +++++++++++++++--------------------
 1 file changed, 57 insertions(+), 77 deletions(-)

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index fd2d5b371483..f325b8959a5a 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -203,6 +203,50 @@ void inc_deq(struct xhci_hcd *xhci, struct xhci_ring *ring)
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
+		 * On 0.95 and some 0.96 HCs the chain bit is set once at segment initalization
+		 * and never changed here. On all others, modify it as requested by the caller.
+		 */
+		if (!xhci_link_chain_quirk(xhci, ring->type)) {
+			ring->enqueue->link.control &= cpu_to_le32(~TRB_CHAIN);
+			ring->enqueue->link.control |= cpu_to_le32(chain);
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
@@ -211,11 +255,6 @@ void inc_deq(struct xhci_hcd *xhci, struct xhci_ring *ring)
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
@@ -223,8 +262,6 @@ static void inc_enq(struct xhci_hcd *xhci, struct xhci_ring *ring,
 			bool more_trbs_coming)
 {
 	u32 chain;
-	union xhci_trb *next;
-	unsigned int link_trb_count = 0;
 
 	chain = le32_to_cpu(ring->enqueue->generic.field[3]) & TRB_CHAIN;
 
@@ -233,48 +270,16 @@ static void inc_enq(struct xhci_hcd *xhci, struct xhci_ring *ring,
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
+	if (trb_is_link(ring->enqueue) && (chain || more_trbs_coming))
+		inc_enq_past_link(xhci, ring, chain);
 }
 
 /*
@@ -3188,7 +3193,6 @@ static void queue_trb(struct xhci_hcd *xhci, struct xhci_ring *ring,
 static int prepare_ring(struct xhci_hcd *xhci, struct xhci_ring *ep_ring,
 		u32 ep_state, unsigned int num_trbs, gfp_t mem_flags)
 {
-	unsigned int link_trb_count = 0;
 	unsigned int new_segs = 0;
 
 	/* Make sure the endpoint has been added to xHC schedule */
@@ -3236,33 +3240,9 @@ static int prepare_ring(struct xhci_hcd *xhci, struct xhci_ring *ep_ring,
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
+	if (trb_is_link(ep_ring->enqueue))
+		inc_enq_past_link(xhci, ep_ring, 0);
 
 	if (last_trb_on_seg(ep_ring->enq_seg, ep_ring->enqueue)) {
 		xhci_warn(xhci, "Missing link TRB at end of ring segment\n");
-- 
2.48.1

