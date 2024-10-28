Return-Path: <linux-kernel+bounces-384025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA3E29B235A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 03:56:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A57C281362
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 02:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A40218B48B;
	Mon, 28 Oct 2024 02:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hrcj6PaW"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D3118858E;
	Mon, 28 Oct 2024 02:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730084108; cv=none; b=FCi3mm+5ghc3DgfC/pPBU3B8iyz+C2A9Adcxf/R/VEu62GBRpRQ4KFLs1WaxoFZtdli68o6sHG8rxCFMJwa/2cDlhh6dA43sQxcxS9tFtsatqpKNzngXl8GBD8lBYh0+Bb90lGTpv6TQlSl6B7xD+vFaNTtIFo0rQzcWspRxd1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730084108; c=relaxed/simple;
	bh=OvqEXPqvXBkzuyq/8dwNHAkExETVfjQgts5CQ+WWSdI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZG3CBfamBcYhCBK/Q6mcq1oYN70I79KfENSrx9O4KjUEdNlQfIn+TkoUwTMw3RlSh1kJ6AggN1NBcQKKnJxwOj0ZKfOyCYDp+niA6prk/2XacWenSHk/IWke0nWDiHADgcaN7w64xI0VJXgFenGvpaeGuafmlqtIKpBPhLVEXkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hrcj6PaW; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2e2bb1efe78so2510267a91.1;
        Sun, 27 Oct 2024 19:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730084106; x=1730688906; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/7R76DTFIGHT3/ZwOkD+UOJ8gdIJ1q/s6dEZm9rOVzM=;
        b=hrcj6PaWXOEwLTnk9l4HwmbWTVSCyCTE1f09v31TjaH1qC+B1uUmZPz+r9/SFGZc7r
         6WI/uZ/MWH6RLwm3iQbtqMpO97ivjPfKxIL11+af93IThIAjkrjrIhVxgOaz90FgsGH8
         z9rW/vub2aIhBqS/J0YXyAoNNuCe3K+KsCusR9jY7U7Tya3YhdL3jv43bJPKUOkZEIl0
         Q6lQidjnbNdw56100gB6zIfCS4BuqNjZCKFz+JzwEdGzttCK8vYk44mZ0HHLMPFf9/hh
         D+wU9+WMoL5JB7IGpHgYQmECjIf88eQ2C+1V1TncK3HqZSakY5CuGUB1yb4aUpZFfMgf
         bUtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730084106; x=1730688906;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/7R76DTFIGHT3/ZwOkD+UOJ8gdIJ1q/s6dEZm9rOVzM=;
        b=eHisj7HeckPBIBM7Yx5lxMvPGKdwqMDEHRDdVzMGDK8iG/ZXKGRdPCZv5oSulx3K1O
         BFRiJ6qgVuHVVIujl/N+CKIP6miJjX8EE6kYOYNuXWOV73t6ntuNOsu7EKxXxfdalN3X
         y1fZeTNJJhtXqNGFglxwzWScgdyO1n1kHMadx7jG+o86QeQtxmoSPR6CitW/Cc1/QqPW
         Xvf46HI28nV9oqhgKNJAUZ4zam2/KzkwJdhS3qfIkr4cZK0zYsMwfXCMO0CQMMtdZrwc
         0gdEPXDwRqiXT3t6V03rSrW92oqN2TYycMDkXcQVPq44ZhaW8tewDfl8HjCXlbCjKGsI
         KtEA==
X-Forwarded-Encrypted: i=1; AJvYcCVmvqD61jPbsy2xfOCeefTKtZCtOIjos4Yi0yn9JrCn+vkyQSg/oYBEXeRZpAoFE1DpuknzaTUOReK2K1w=@vger.kernel.org
X-Gm-Message-State: AOJu0YycNTOU3FfTlpp0MSMz95nho1Eqn/wXQP/XvEvFI5LSECin3GEU
	KX0sykmocXqw9bpTReVgdg8SB6Z5mZCShuI7BdRKoyffanj15l/liyA32w==
X-Google-Smtp-Source: AGHT+IES92iz8ovreAv3UEhDJQFHin9vugvKJpXlxX5PqYxDCIWhKr79Y4P6gqNMgc0xEQaI+AD6gw==
X-Received: by 2002:a17:90a:68c5:b0:2c9:6abd:ca64 with SMTP id 98e67ed59e1d1-2e8f076cfadmr10477605a91.9.1730084105616;
        Sun, 27 Oct 2024 19:55:05 -0700 (PDT)
Received: from kic-machine.localdomain (122-117-151-175.hinet-ip.hinet.net. [122.117.151.175])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e77e4ca3fcsm8062236a91.13.2024.10.27.19.55.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Oct 2024 19:55:05 -0700 (PDT)
From: Kuangyi Chiang <ki.chiang65@gmail.com>
To: mathias.nyman@intel.com,
	gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ki.chiang65@gmail.com
Subject: [PATCH v2 5/5] xhci: Correct handling of one-TRB isoc TD on Etron xHCI host
Date: Mon, 28 Oct 2024 10:53:37 +0800
Message-Id: <20241028025337.6372-6-ki.chiang65@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241028025337.6372-1-ki.chiang65@gmail.com>
References: <20241028025337.6372-1-ki.chiang65@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Unplugging a USB3.0 webcam while streaming results in errors
like this:

[ 132.646387] xhci_hcd 0000:03:00.0: ERROR Transfer event TRB DMA ptr not part of current TD ep_index 18 comp_code 13
[ 132.646446] xhci_hcd 0000:03:00.0: Looking for event-dma 000000002fdf8630 trb-start 000000002fdf8640 trb-end 000000002fdf8650 seg-start 000000002fdf8000 seg-end 000000002fdf8ff0
[ 132.646560] xhci_hcd 0000:03:00.0: ERROR Transfer event TRB DMA ptr not part of current TD ep_index 18 comp_code 13
[ 132.646568] xhci_hcd 0000:03:00.0: Looking for event-dma 000000002fdf8660 trb-start 000000002fdf8670 trb-end 000000002fdf8670 seg-start 000000002fdf8000 seg-end 000000002fdf8ff0

If an error is detected while processing an one-TRB isoc TD,
the Etron xHC generates two transfer events for the TRB that
the error was detected on. The first event is "USB Transcation
Error", and the second event is "Success".

The xHCI driver will handle the TD after the first event and
remove it from its internal list, and then print an "Transfer
event TRB DMA ptr not part of current TD" error message after
the second event.

As a solution, we can set the flag after the first error event
and don't print the error message after the second event if
the flag is set.

Commit ad808333d820 ("Intel xhci: Ignore spurious successful
event.") implements a similar mechanism that we can reuse to
solve this problem since short transfer and transfer error
doesn't occur concurrently. Also, rename the flag to make it
more meaningful.

Check if the XHCI_ETRON_HOST quirk flag is set before invoking
the workaround in process_isoc_td().

This patch doesn't affect other host controllers that have the
XHCI_SPURIOUS_SUCCESS quirk flag applied.

Signed-off-by: Kuangyi Chiang <ki.chiang65@gmail.com>
---
 drivers/usb/host/xhci-ring.c | 26 +++++++++++++++-----------
 drivers/usb/host/xhci.h      |  2 +-
 2 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 9e132b08bfde..33fa8a11c934 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -2437,6 +2437,10 @@ static int process_isoc_td(struct xhci_hcd *xhci, struct xhci_virt_ep *ep,
 		sum_trbs_for_length = true;
 		if (ep_trb != td->last_trb)
 			td->error_mid_td = true;
+		if ((xhci->quirks & XHCI_ETRON_HOST) &&
+		    td->urb->dev->speed >= USB_SPEED_SUPER &&
+		    td->first_trb == td->last_trb)
+			ep_ring->spurious_event = true;
 		break;
 	case COMP_STOPPED:
 		sum_trbs_for_length = true;
@@ -2655,8 +2659,8 @@ static int handle_tx_event(struct xhci_hcd *xhci,
 	case COMP_SUCCESS:
 		if (EVENT_TRB_LEN(le32_to_cpu(event->transfer_len)) != 0) {
 			trb_comp_code = COMP_SHORT_PACKET;
-			xhci_dbg(xhci, "Successful completion on short TX for slot %u ep %u with last td short %d\n",
-				 slot_id, ep_index, ep_ring->last_td_was_short);
+			xhci_dbg(xhci, "Successful completion on short TX for slot %u ep %u with spurious event %d\n",
+				 slot_id, ep_index, ep_ring->spurious_event);
 		}
 		break;
 	case COMP_SHORT_PACKET:
@@ -2801,13 +2805,13 @@ static int handle_tx_event(struct xhci_hcd *xhci,
 	if (list_empty(&ep_ring->td_list)) {
 		/*
 		 * Don't print wanings if ring is empty due to a stopped endpoint generating an
-		 * extra completion event if the device was suspended. Or, a event for the last TRB
-		 * of a short TD we already got a short event for. The short TD is already removed
-		 * from the TD list.
+		 * extra completion event if the device was suspended. Or, the spurious event flag
+		 * is set at the last TD of the TD list due to a short transfer or an one-TRB isoc
+		 * TD error, and such TD is already removed from the TD list.
 		 */
 		if (trb_comp_code != COMP_STOPPED &&
 		    trb_comp_code != COMP_STOPPED_LENGTH_INVALID &&
-		    !ep_ring->last_td_was_short) {
+		    !ep_ring->spurious_event) {
 			xhci_warn(xhci, "Event TRB for slot %u ep %u with no TDs queued\n",
 				  slot_id, ep_index);
 		}
@@ -2851,11 +2855,11 @@ static int handle_tx_event(struct xhci_hcd *xhci,
 
 			/*
 			 * Some hosts give a spurious success event after a short
-			 * transfer. Ignore it.
+			 * transfer or an one-TRB isoc TD error. Ignore it.
 			 */
 			if ((xhci->quirks & XHCI_SPURIOUS_SUCCESS) &&
-			    ep_ring->last_td_was_short) {
-				ep_ring->last_td_was_short = false;
+			    ep_ring->spurious_event) {
+				ep_ring->spurious_event = false;
 				return 0;
 			}
 
@@ -2884,9 +2888,9 @@ static int handle_tx_event(struct xhci_hcd *xhci,
 	} while (ep->skip);
 
 	if (trb_comp_code == COMP_SHORT_PACKET)
-		ep_ring->last_td_was_short = true;
+		ep_ring->spurious_event = true;
 	else
-		ep_ring->last_td_was_short = false;
+		ep_ring->spurious_event = false;
 
 	ep_trb = &ep_seg->trbs[(ep_trb_dma - ep_seg->dma) / sizeof(*ep_trb)];
 	trace_xhci_handle_transfer(ep_ring, (struct xhci_generic_trb *) ep_trb);
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index 4f5b732e8944..dca9091b8134 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1359,7 +1359,7 @@ struct xhci_ring {
 	unsigned int		num_trbs_free; /* used only by xhci DbC */
 	unsigned int		bounce_buf_len;
 	enum xhci_ring_type	type;
-	bool			last_td_was_short;
+	bool			spurious_event;
 	struct radix_tree_root	*trb_address_map;
 };
 
-- 
2.25.1


