Return-Path: <linux-kernel+bounces-524841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A361DA3E7B8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 23:45:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23CC619C06EE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 22:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AD26264FB4;
	Thu, 20 Feb 2025 22:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bFyz9Vm8"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B834B264F8A;
	Thu, 20 Feb 2025 22:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740091505; cv=none; b=Q3gHGO6ef+LS8PyA+5MJI9S3t6Oo5jn6zDRbAVBChz2iQFLFOruELo7L/CUeZsiifxO8VTEqtRP2iUT2hPtTlSonQkAOvT/scil/rSsVymPF8SWqNhC5A9rfIevxQvzw1yFbcBYvbv+O+AU7ehGzf7e2xYvTP5stL9f/ITE1ir0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740091505; c=relaxed/simple;
	bh=GEqCOQtv+n0Zy2Xw5qOEdrTlH2FbjxKSiXWw31DnuKs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qSI1JYl6HGQRcNuiXE07nR3t/F5IY4zPxoTQ/nNL6jxAumqeRRvuHgxeREKCDNJk+2gMk57CVnT9G7da0qlaPD1LrcWAIj1hAowRwOFwFVzQy+Fn6v2BR/uXu9EPXQB93CAWGDof1tC5TgJfjxGDDfhxInAsZinguZxCuyi6XZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bFyz9Vm8; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5ded46f323fso2069110a12.1;
        Thu, 20 Feb 2025 14:45:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740091502; x=1740696302; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q5wnXrTG8IMccKKXxpr7vLhowLZyE76xRdUTl7hiSiQ=;
        b=bFyz9Vm8xng5E66EtjSpe0yKchK8ONgPUhZJvTnII3pLyvmdpDFYkkqfmHV0pLi3HE
         mZgBpyLKPQGCaikYBWVcw2Vs7COm7SHBC6LBT7ZIJp2NRTS/YU7Z8MNKArVCDzWrYdJQ
         ifIQoLIQJvOvQRBxmetio/sFZ84Guh3J1b70Ywu7otok7tiXeeaVFnzPAqP372osdr7X
         g+YWAwEpibazigoKGSCy0L7y/HJHG1GGRlQLtlG+sXKYHybSS2LNfl0FtKMrvbx6lrsQ
         szYNLo69G7rcHcrfkBT0KIVNXSXHw6pnl4SPdw6+Uq8qsYDOwCCKfG76fwcd3+xgJZnc
         9Dkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740091502; x=1740696302;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q5wnXrTG8IMccKKXxpr7vLhowLZyE76xRdUTl7hiSiQ=;
        b=Kz3+HPya0UrRIHedSMPOWdZL5ZrsMq2RR1Th7WJdnFb0jl9WFlA+lp2Bma2llL0OWo
         uS8edub9lH+0GxJTONjmFKHJrNYZCx7R2U2i0PaguDwHeSwnmSPA/0h6Wi++5Z9J7VSX
         sIHkF8FynPsY8ZVBbcgWs+ktyB6FJ2nJRdKh46EhW7IVnlIFBtwE8FeM9I0W2gerVqv1
         ifE0iTrzaFxCGv8kq6g7Semaw9zjUU0eL5B9TadNUbMHsqMZy1RwAG9e4hLDOO6WKGWm
         qNpVlqINCuTipKdSEm2Un+o5lYHlsKg4ZW/3kQz82w3SYdcRahkIYcTBXNrVkoHrJ9iV
         76ew==
X-Forwarded-Encrypted: i=1; AJvYcCW8BSgNLXdqug4h6r76Or4AerpSLl/Oi+WTUmgyHrnF9eXqj8WKFAeW58DhB7/oLMUv30oYJbSZmwIW/TY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw39TUQBPa85b331wR3LfkV+LhsPrsVyDBJt36BaIzGRmS7hTlZ
	4d6hlD+16w7zYYFNTh0sXLkUMISVMKVXRRjIpBcsGyMPBuAbdjOmAYC59g==
X-Gm-Gg: ASbGncvpzS384vJ9MZSHss6ePClz7gHZ0OgvcpmGNPj6sO4LK2kuxPzDKT6vUoBclSa
	5o1NJHykkFS+IpBQAES8zTxzu/TwsO3sqnjZzUpR9/jYloPfNz7nR53jvPGVON5tqg9/1soyh2Y
	PPCzTTUsCO1q6YKyssNz+Fl0Hl5MFlT4wt8lvWSZYRtIQwPLFvBKxv26l6F7iTq6Bs7wg7OidMk
	ID/rbnee7QgMunR9TdGW7kwg6c3fF5t2MmKbdO7Fk8bo6KBWDVLfDS8a8kVGLNVk1p8ENE2FDKm
	/fSgtUJ8KHco3Ycsnd9Vqwbl/TMYwhmp
X-Google-Smtp-Source: AGHT+IHtH05KKRtBRlXhCTM9Mu4Jq9sP4r2pocbQ5TNZ843XGbkVKlavbAKVels6cDt1AeBK1nrNhA==
X-Received: by 2002:a17:907:94c8:b0:abb:6722:f98c with SMTP id a640c23a62f3a-abc09aefd0fmr112247166b.34.1740091501834;
        Thu, 20 Feb 2025 14:45:01 -0800 (PST)
Received: from foxbook (adtt173.neoplus.adsl.tpnet.pl. [79.185.231.173])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb9faab9f1sm802588366b.49.2025.02.20.14.45.01
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 20 Feb 2025 14:45:01 -0800 (PST)
Date: Thu, 20 Feb 2025 23:44:58 +0100
From: Michal Pecio <michal.pecio@gmail.com>
To: Mathias Nyman <mathias.nyman@intel.com>, Greg Kroah-Hartman  
 <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] usb: xhci: Simplify
 update_ring_for_set_deq_completion()
Message-ID: <20250220234458.4bf8dcba@foxbook>
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

This function checks if the queued Set Deq pointer really belongs to the
ring it was queued on and updates the ring's dequeue state. It also used
to count free TRBs, but that part has been removed.

The code is needlessly complex and inefficent, walking TRBs one by one.
And it could "jump off the segment into la-la-land" if a segment doesn't
end with a link TRB or if the link points to another link.

Make if faster, simpler and more robust. Upgrade xhci_dbg() to xhci_err()
because this situation is a bug and shouldn't happen.

Signed-off-by: Michal Pecio <michal.pecio@gmail.com>
---
 drivers/usb/host/xhci-ring.c | 43 ++++++++++++++----------------------
 1 file changed, 16 insertions(+), 27 deletions(-)

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 965bffce301e..c983d22842dc 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -92,6 +92,11 @@ static bool trb_is_link(union xhci_trb *trb)
 	return TRB_TYPE_LINK_LE32(trb->link.control);
 }
 
+static bool trb_on_seg(struct xhci_segment *seg, union xhci_trb *trb)
+{
+	return seg->trbs <= trb && trb < seg->trbs + TRBS_PER_SEGMENT;
+}
+
 static bool last_trb_on_seg(struct xhci_segment *seg, union xhci_trb *trb)
 {
 	return trb == &seg->trbs[TRBS_PER_SEGMENT - 1];
@@ -1332,41 +1337,25 @@ void xhci_hc_died(struct xhci_hcd *xhci)
 		usb_hc_died(xhci_to_hcd(xhci));
 }
 
+/* Check if queued pointer is on the ring and update dequeue state */
 static void update_ring_for_set_deq_completion(struct xhci_hcd *xhci,
 		struct xhci_virt_device *dev,
 		struct xhci_ring *ep_ring,
 		unsigned int ep_index)
 {
-	union xhci_trb *dequeue_temp;
+	union xhci_trb *deq = dev->eps[ep_index].queued_deq_ptr;
+	struct xhci_segment *seg;
 
-	dequeue_temp = ep_ring->dequeue;
-
-	/* If we get two back-to-back stalls, and the first stalled transfer
-	 * ends just before a link TRB, the dequeue pointer will be left on
-	 * the link TRB by the code in the while loop.  So we have to update
-	 * the dequeue pointer one segment further, or we'll jump off
-	 * the segment into la-la-land.
-	 */
-	if (trb_is_link(ep_ring->dequeue)) {
-		ep_ring->deq_seg = ep_ring->deq_seg->next;
-		ep_ring->dequeue = ep_ring->deq_seg->trbs;
-	}
-
-	while (ep_ring->dequeue != dev->eps[ep_index].queued_deq_ptr) {
-		/* We have more usable TRBs */
-		ep_ring->dequeue++;
-		if (trb_is_link(ep_ring->dequeue)) {
-			if (ep_ring->dequeue ==
-					dev->eps[ep_index].queued_deq_ptr)
-				break;
-			ep_ring->deq_seg = ep_ring->deq_seg->next;
-			ep_ring->dequeue = ep_ring->deq_seg->trbs;
-		}
-		if (ep_ring->dequeue == dequeue_temp) {
-			xhci_dbg(xhci, "Unable to find new dequeue pointer\n");
-			break;
+	/* Search starting from the last known position */
+	xhci_for_each_ring_seg(ep_ring->deq_seg, seg) {
+		if (seg == dev->eps[ep_index].queued_deq_seg && trb_on_seg(seg, deq)) {
+			ep_ring->deq_seg = seg;
+			ep_ring->dequeue = deq;
+			return;
 		}
 	}
+
+	xhci_err(xhci, "Set Deq pointer not on ring\n");
 }
 
 /*
-- 
2.48.1

