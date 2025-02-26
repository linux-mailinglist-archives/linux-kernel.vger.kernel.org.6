Return-Path: <linux-kernel+bounces-533161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA0E0A45644
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 08:04:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D27E43A5627
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 07:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5154026A090;
	Wed, 26 Feb 2025 07:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kZp+kkNi"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9B025D537;
	Wed, 26 Feb 2025 07:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740553466; cv=none; b=XBTF2cfD3cGpwPEPvyDBkLgHonzjAPumiGgIRmSATnj/PQjgvAalwR9U9KAY/cgxJlm8IqyQRIETkh00FPFsLZ3L/rcNxFSYX5+HA6o4mxMpnc8EBTp6cJra175UXvxI3EdHrUCkR7wGNDtPuBpkQ19qjCcyyEdJDGZ4DZjfG/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740553466; c=relaxed/simple;
	bh=Hf47wUPU5PSZdp8K88iySJw3zZhHMlfTz18hB0UbGWo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZJluzcFF1r80rNvvc2onD6EPo3xmP3BhwseBJlQ1YBzS/wPt+7vMkEYcIAebidFJ+TczRTx3hYGlHtNa/Jlu+GdR+AN7j+2MT0Pf22fEeU0q/6PsqOK/IYT4Kyv4tXCStThsZ8GK5sEXRwn60dljhr+pf7biBfgmQBFCSoCTPzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kZp+kkNi; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-aaec61d0f65so1295929266b.1;
        Tue, 25 Feb 2025 23:04:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740553463; x=1741158263; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EY9NxuSsp68sAr3D7gRmaRundsRETCiw9T3ziIxTlVc=;
        b=kZp+kkNi+S8xlk+SabNvN8vhYKFVVL6orMtqme2dE1Cr3j95/SMWL4QSN1FKTmi+39
         2Fk3F4n1xBswakd7XTY9ERovqVl4wtciI2R2TIdXKXhi3UdRPO9lm11C6Dl+Kg0MUph7
         qjfOdwx5VComQKYFktUixHiAwbAGtrD9Cf0QkOX5YCIbJXo3HaHAvuK/FUQ6+AuXl1hL
         amE7uCRyyng+pcYqiLbRjsQX70TB2+J3Imgm5C8QxZRn2O270Ye6tFKg+RyiZCyKTJQt
         XvKmmtZLY2co0YCIH99mu5smJ9j/jvXghvuE/Iv85uxmyT5DLmqgbHOXIMWdHUI+seZD
         aeiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740553463; x=1741158263;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EY9NxuSsp68sAr3D7gRmaRundsRETCiw9T3ziIxTlVc=;
        b=YBXSaHoOeM0c3lXbFke5woV9ClitoweCE/1x93YpThB/3/8f52mu2V9vzgpAFuWpSW
         5KwPFKyDosXielOJq8XOAELKRQPyCTPvMZTYAZnG/KhQdtdxLne8FI/ju6O/0NrniBWU
         nsq9YWp77bquBumHN0zMxK73QVAtGUlMP09SpuT6NSS1iCljERRaX/imO1HnSOJhHz1n
         sZo57m+jyT7nZqUXj3jS1YvrhWn1m+N5OLd0wyspDj+rnaqVPd50mXrBPkTz50Ahne8h
         7osXDXZYbSc7jZ0rKFZmk83mbZVOinKZ4ye8N+6D9D+upgdOaMke2oWqzFU1hIHk0/J4
         tN+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUstZhJGwdOmDC99lKsPpUHPJ0mfG7STOJRU3avA0oG/uBJbyoP5T7H4hpQQ7QIMnCyRN3bdJhCgKN5@vger.kernel.org, AJvYcCXqG9G6YI7Q12fy0521PmoMRRzkcDIRE15v/cU0mndWm8uXGVmLoWzEmaCke8KHgdJFiovjTGyN9FGJsCA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9SVH/mpZQ9xcx7V2SH6RkdojBVEH7uI9qzfBirkpu5V/aXM8k
	semNFfN9RdwgQNOG2COP/FVeejb0q+Xr7mZNkT4I1GX/SA+EBcFT
X-Gm-Gg: ASbGnctMiY26AjYd7lL23Y1k+AIy3ucIjrwBUftVkrTMPNf9q7I50aTJKHnzRr3R2k9
	1eCvx8EL+QpQ2oG8qLh2TneqClsf3rtzcHRlEJR40/6cuXa0DWGKFUnexGoo5ukrlOJ7MYNRBrG
	4GERLjcJEhfgWROBib5+tQbNDUKDXIpfw1RVNrLMyLs+HU+9nEslA/AW9G8lFnmEdG/y5Q3CISQ
	FB3h8pWcciolpvj6EdC1dIjASHRbfvDu3+O4KcChgCQCFF1InHfA1lvbfq3MkeN1BeCGL6P3IFY
	Kh4SxSig3xfw69O5qB8EXeZgGvw94cpiKgQwlqUo
X-Google-Smtp-Source: AGHT+IGRewZvFr5jlBvs/DA5Q/FybcdCz7C7HSccKLVMjPKhdq3S7b0EZ6CxTJIX9dXvroKDh7u6Rw==
X-Received: by 2002:a17:907:98b:b0:abb:b1a4:b0fe with SMTP id a640c23a62f3a-abed0c63635mr722120566b.1.1740553462861;
        Tue, 25 Feb 2025 23:04:22 -0800 (PST)
Received: from foxbook (adqi59.neoplus.adsl.tpnet.pl. [79.185.142.59])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed1cd5607sm275393466b.6.2025.02.25.23.04.21
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 25 Feb 2025 23:04:22 -0800 (PST)
Date: Wed, 26 Feb 2025 08:04:19 +0100
From: Michal Pecio <michal.pecio@gmail.com>
To: Mathias Nyman <mathias.nyman@intel.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>
Cc: Niklas Neronin <niklas.neronin@linux.intel.com>,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/5] usb: xhci: Fix isochronous Ring Underrun/Overrun
 event handling
Message-ID: <20250226080419.79139d90@foxbook>
In-Reply-To: <20250226080202.7eb5e142@foxbook>
References: <20250226080202.7eb5e142@foxbook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

The TRB pointer of these events points at enqueue at the time of error
occurrence on xHCI 1.1+ HCs or it's NULL on older ones. By the time we
are handling the event, a new TD may be queued at this ring position.

I can trigger this race by rising interrupt moderation to increase IRQ
handling delay. Similar delay may occur naturally due to system load.

If this ever happens after a Missed Service Error, missed TDs will be
skipped and the new TD processed as if it matched the event. It could
be given back prematurely, risking data loss or buffer UAF by the xHC.

Don't complete TDs on xrun events and don't warn if queued TDs don't
match the event's TRB pointer, which can be NULL or a link/no-op TRB.
Don't warn if there are no queued TDs at all.

Now that it's safe, also handle xrun events if the skip flag is clear.
This ensures completion of any TD stuck in 'error mid TD' state right
before the xrun event, which could happen if a driver submits a finite
number of URBs to a buggy HC and then an error occurs on the last TD.

Signed-off-by: Michal Pecio <michal.pecio@gmail.com>
---
 drivers/usb/host/xhci-ring.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 5eaf4f9154b9..995f8a9b5b53 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -2669,6 +2669,7 @@ static int handle_tx_event(struct xhci_hcd *xhci,
 	int status = -EINPROGRESS;
 	struct xhci_ep_ctx *ep_ctx;
 	u32 trb_comp_code;
+	bool ring_xrun_event = false;
 
 	slot_id = TRB_TO_SLOT_ID(le32_to_cpu(event->flags));
 	ep_index = TRB_TO_EP_ID(le32_to_cpu(event->flags)) - 1;
@@ -2775,14 +2776,12 @@ static int handle_tx_event(struct xhci_hcd *xhci,
 		 * Underrun Event for OUT Isoch endpoint.
 		 */
 		xhci_dbg(xhci, "Underrun event on slot %u ep %u\n", slot_id, ep_index);
-		if (ep->skip)
-			break;
-		return 0;
+		ring_xrun_event = true;
+		break;
 	case COMP_RING_OVERRUN:
 		xhci_dbg(xhci, "Overrun event on slot %u ep %u\n", slot_id, ep_index);
-		if (ep->skip)
-			break;
-		return 0;
+		ring_xrun_event = true;
+		break;
 	case COMP_MISSED_SERVICE_ERROR:
 		/*
 		 * When encounter missed service error, one or more isoc tds
@@ -2855,6 +2854,7 @@ static int handle_tx_event(struct xhci_hcd *xhci,
 		 */
 		if (trb_comp_code != COMP_STOPPED &&
 		    trb_comp_code != COMP_STOPPED_LENGTH_INVALID &&
+		    !ring_xrun_event &&
 		    !ep_ring->last_td_was_short) {
 			xhci_warn(xhci, "Event TRB for slot %u ep %u with no TDs queued\n",
 				  slot_id, ep_index);
@@ -2889,6 +2889,10 @@ static int handle_tx_event(struct xhci_hcd *xhci,
 				goto check_endpoint_halted;
 			}
 
+			/* TD was queued after xrun, maybe xrun was on a link, don't panic yet */
+			if (ring_xrun_event)
+				return 0;
+
 			/*
 			 * Skip the Force Stopped Event. The 'ep_trb' of FSE is not in the current
 			 * TD pointed by 'ep_ring->dequeue' because that the hardware dequeue
@@ -2935,6 +2939,10 @@ static int handle_tx_event(struct xhci_hcd *xhci,
 	 */
 	} while (ep->skip);
 
+	/* Get out if a TD was queued at enqueue after the xrun occurred */
+	if (ring_xrun_event)
+		return 0;
+
 	if (trb_comp_code == COMP_SHORT_PACKET)
 		ep_ring->last_td_was_short = true;
 	else
-- 
2.48.1

