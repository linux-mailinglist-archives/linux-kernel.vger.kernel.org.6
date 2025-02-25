Return-Path: <linux-kernel+bounces-531293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D02C4A43EAE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 13:04:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46B393AEF77
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 11:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 541B6267B87;
	Tue, 25 Feb 2025 11:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rv9jgcjr"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D9F262D2D;
	Tue, 25 Feb 2025 11:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740484786; cv=none; b=CW0gGsVaJBeWhr2Gv5RlnbtG5mhwiQvt+Xi7O5f/WO4+AvGjhx1fmO6Pa3Jh9tYrV+oOLsYZLD2EEmUmEDwv1QCRc9AFe13LNekEV5CDD+DZJ94EMALsoAzOJkWpvnJVZ3KIGKBTDdug+h6PFZTQ7kXc4J6oI3VfpIwNSZ+LkM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740484786; c=relaxed/simple;
	bh=O+pTnhJjs6H33Ym38gmHlxqcaSfLUxX1LU4OxRu7neM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UbJsj8w/OYsOYoR0k68gLyafP7oIzS8bXNLCbjfUTlroWM0M4Wf+QBhwXJATAcWhiN2p30uiJLmfK7NVynf6S/t+WQ8uPunyjq1cP+J2SC80gm7Qcjjjvoyee6RMhFoPLjMrgZpXahKmzGT6EXShQagVCUfuQuJj5Uh3SPbDqPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rv9jgcjr; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5e02eba02e8so7485740a12.0;
        Tue, 25 Feb 2025 03:59:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740484783; x=1741089583; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rjtbe6XyfVXU7CLIUh2zIuX23o5DTHKFfpILeJ7M3lg=;
        b=Rv9jgcjr/Bj5T0HQwKjaHovfTz3kFDikgBkieyPoMjCZK0EGBfVh7Ymr1Rn+M9ZTHG
         rmoxJF+fEl1sLdPoTclHANOmp5Y2dPjkZJlHRoMHJdFSYhRiOVMQR9Evorza0JnRR/vq
         cnqRscsAhPsrlajuTDMcLc8cgHZ7zY2XFuXwCuvoV8koMsOOOcv1c2Uw7NboeKG9UeNY
         pb4PD/qPtZW8LVg94KcwSMJ2f2jt0VjNZiUbLg18RaDMTTSBp84khThzrPdad4ZH9ihY
         AFXz5Q+ssIAwjmGxlp9v1OmXKCuTutcQw4al4Y4DVJ/gAG3s+EdH/8xsorlxfu0BPmkZ
         FHhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740484783; x=1741089583;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rjtbe6XyfVXU7CLIUh2zIuX23o5DTHKFfpILeJ7M3lg=;
        b=GFkITWKvd6PBGb0qVtGRWOpAdZYaA3fJZatkmbV+iDkukabpkHmybY8wbPdBYWGrmK
         /vQ2Fo/9gJIorRkt0wrqCnqHkO/AR/VPJ5DsKpyGiyer+UOIoS7VLcsbfXSp2lgi64rO
         XUHKcMNug/rco1ChrCnAm9zm6Po+r4DPZiqKcc+kbJ1h2de1dHWZ6cKN0LNoSmfe3LYz
         +VN7HuOoK8lN2FRDj5hCIrkraZtMMwVRX+li4/nxAzna3t8TfAQsKZkwGNcBF/SJ09Bn
         uU3hFZk8xIIF4azRkffrt2MPuNiwgGwwkaoFBLLVsFSUdflhjECEJ/g6V/JypYzZ+yMe
         8/HQ==
X-Forwarded-Encrypted: i=1; AJvYcCULZ2LeQ6zC2+17td61LDCcuhW2BNQLiL196unnQpdk0xoIk+YFMBA496RtlTW/33dWqgdvAljJ8RtuTaY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmP+PRzZlMn04dxM+BoaKiHV6MkC7oE0tYKCdCwb51PTyT906o
	11BJsfDtfO9e5kCOQwOWKzTYT30N8bbdAT/RLov5k09r13hXPZyn
X-Gm-Gg: ASbGncvWuWzIa9wBuHmxPG91Gb23b6N9a5BM2A5WM2GTcWup/JXMP7oy494+UV7WIKS
	tRTv7EGjjHRtcWtedyjK8szU0jchj/zoR5/KFHpFr0pUYmVnCh9/3uJe0cyKPLjKqdLmS9JVCKl
	6nA1gEyyTwQkm33B31Cx7fG/C81eSUuLyUFfQbGPOKW08J/1eQgaMuugrIkR3ena4Czf8MddGQT
	ODB6ZNYlsndW+PRXgsAil3A1h7dMZnwYWbD6vaGsiBg7uNMPZTJI6deWgu8NJsEUb1lby6YnbkV
	Uc3u06yF4UecZTApdk+1tWtsTdY0Db+6OOWfBfvRz6c=
X-Google-Smtp-Source: AGHT+IG0z7wdec8nCHOissKNBAOpzj5lFrj/nifN83acYYVsMzUtVB9xCMZpR7bdJ0Nc8UB4kWGWag==
X-Received: by 2002:a17:906:c142:b0:ab7:5cc9:66fc with SMTP id a640c23a62f3a-abc09e46652mr1684707466b.50.1740484782838;
        Tue, 25 Feb 2025 03:59:42 -0800 (PST)
Received: from foxbook (adqm166.neoplus.adsl.tpnet.pl. [79.185.146.166])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed2054d9fsm129689866b.147.2025.02.25.03.59.42
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 25 Feb 2025 03:59:42 -0800 (PST)
Date: Tue, 25 Feb 2025 12:59:39 +0100
From: Michal Pecio <michal.pecio@gmail.com>
To: Mathias Nyman <mathias.nyman@intel.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] usb: xhci: Simplify moving HW Dequeue Pointer past
 cancelled TDs
Message-ID: <20250225125939.7a248e38@foxbook>
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
index 965bffce301e..fd2d5b371483 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -630,9 +630,9 @@ static u64 xhci_get_hw_deq(struct xhci_hcd *xhci, struct xhci_virt_device *vdev,
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
@@ -640,58 +640,31 @@ static int xhci_move_dequeue_past_td(struct xhci_hcd *xhci,
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
@@ -1055,9 +1028,8 @@ static int xhci_invalidate_cancelled_tds(struct xhci_virt_ep *ep)
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

