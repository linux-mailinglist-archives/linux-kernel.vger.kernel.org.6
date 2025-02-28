Return-Path: <linux-kernel+bounces-538897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EC67A49E85
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 17:17:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D1C4175344
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 16:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ABF626FD9F;
	Fri, 28 Feb 2025 16:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G81ZoidY"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108A026A1A9;
	Fri, 28 Feb 2025 16:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740759462; cv=none; b=ipSReIPPy+w0XKpSKG6/BKlCDhes13vawK2n6dbLmCrx1ozIwoivbrnOJbmaSFoNZbGVLWx6pB5vOm6FZb0Gk9saartaw6/Dq4kl5395j0FD2p+SGe5yc7yPFLE7USPs/uVWI2dAofcLV9I8WD5g0k98t99HMDLWEoqouG/0iS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740759462; c=relaxed/simple;
	bh=uVQYl/FGt5qUqkrCI1KgjT4jsxGm7eJodSmGjovP57M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iiw5XsTd6twaBfAQfYsKj3JrHnLW5fnwcmNL3jLjhTeZp70r5WQNA36sWr8v0EFDAy+HwjBLL777e5gWrGGZF8x5o20mjaQtULnvk0Sep+eG7Sd7zzs44aPsiN3eRYAeh9eqEqUwVwtsK7g30PVu4dp35yKmZCQ1b8at0gTmFu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G81ZoidY; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740759461; x=1772295461;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uVQYl/FGt5qUqkrCI1KgjT4jsxGm7eJodSmGjovP57M=;
  b=G81ZoidYQKbwAgWB1yvfk3WJBIhU0NruqJJV58oXiGthj8mPdivDaaSh
   7fzoEKVtVGMcXH2Fdl8ZGbY56jhdZaL91w9Q6cFyfbNLwaaid3U6KdSRb
   blm11c/T1JO/o2xdmx5bNafNaPMKvHDDCd8l4uAFehtlNZItE8+a6Vc1f
   Y86kzWd9Jdp/JTAVTwXYJGoHT9oQpbAFZQp512uuoZkefYOOOs4+taAEH
   XsDQ57uRf6KvUqBRBPNnoQveU+/9VephKGdw4XvawXWVH9SfiqCBCGWcL
   jx+gB4l7y/OnLkbs1jFKkUP1YTqEA68LUQ+m14Q3lU9wWQRvTI+P84sOx
   A==;
X-CSE-ConnectionGUID: jUu8TiITTqOXaVTZV8AyoQ==
X-CSE-MsgGUID: SY9uRyLES9eX7ig6TCcDpQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11359"; a="53080474"
X-IronPort-AV: E=Sophos;i="6.13,322,1732608000"; 
   d="scan'208";a="53080474"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 08:17:40 -0800
X-CSE-ConnectionGUID: 4GYkvk58SCmL11QXlcdRVQ==
X-CSE-MsgGUID: AW0btBUvQ4eEjMsmYWgaxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,322,1732608000"; 
   d="scan'208";a="117401062"
Received: from unknown (HELO mattu-haswell.fi.intel.com) ([10.237.72.199])
  by orviesa006.jf.intel.com with ESMTP; 28 Feb 2025 08:17:39 -0800
From: Mathias Nyman <mathias.nyman@linux.intel.com>
To: michal.pecio@gmail.com,
	ki.chiang65@gmail.com
Cc: <gregkh@linuxfoundation.org>,
	<linux-usb@vger.kernel.org>,
	linux-kernel@vger.kernel.org,
	Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: [RFT PATCH] xhci: Handle spurious events on Etron host isoc enpoints
Date: Fri, 28 Feb 2025 18:18:24 +0200
Message-ID: <20250228161824.3164826-1-mathias.nyman@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <41847336-9111-4aaa-b3dc-f3c18bb03508@linux.intel.com>
References: <41847336-9111-4aaa-b3dc-f3c18bb03508@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Unplugging a USB3.0 webcam from Etron hosts while streaming results
in errors like this:

[ 2.646387] xhci_hcd 0000:03:00.0: ERROR Transfer event TRB DMA ptr not part of current TD ep_index 18 comp_code 13
[ 2.646446] xhci_hcd 0000:03:00.0: Looking for event-dma 000000002fdf8630 trb-start 000000002fdf8640 trb-end 000000002fdf8650
[ 2.646560] xhci_hcd 0000:03:00.0: ERROR Transfer event TRB DMA ptr not part of current TD ep_index 18 comp_code 13
[ 2.646568] xhci_hcd 0000:03:00.0: Looking for event-dma 000000002fdf8660 trb-start 000000002fdf8670 trb-end 000000002fdf8670

Etron xHC generates two transfer events for the TRB if an error is
detected while processing the last TRB of an isoc TD.

The first event can be any sort of error (like USB Transaction or
Babble Detected, etc), and the final event is Success.

The xHCI driver will handle the TD after the first event and remove it
from its internal list, and then print an "Transfer event TRB DMA ptr
not part of current TD" error message after the final event.

Commit 5372c65e1311 ("xhci: process isoc TD properly when there was a
transaction error mid TD.") is designed to address isoc transaction
errors, but unfortunately it doesn't account for this scenario.

This issue is similar to the XHCI_SPURIOUS_SUCCESS case where a success
event follows a 'short transfer' event, but the TD the event points to
is already given back.

Expand the spurious success 'short transfer' event handling to cover
the spurious success after error on Etron hosts.

Kuangyi Chiang reported this issue and submitted a different solution
based on using error_mid_td. This commit message is mostly taken
from that patch.

Reported-by: Kuangyi Chiang <ki.chiang65@gmail.com>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
---
 drivers/usb/host/xhci-ring.c | 36 +++++++++++++++++++++++++-----------
 drivers/usb/host/xhci.h      |  2 +-
 2 files changed, 26 insertions(+), 12 deletions(-)

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 965bffce301e..3d3e6cd69019 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -2644,6 +2644,22 @@ static int handle_transferless_tx_event(struct xhci_hcd *xhci, struct xhci_virt_
 	return 0;
 }
 
+static bool xhci_spurious_success_tx_event(struct xhci_hcd *xhci,
+					   struct xhci_ring *ring)
+{
+	switch (ring->old_trb_comp_code) {
+	case COMP_SHORT_PACKET:
+		return xhci->quirks & XHCI_SPURIOUS_SUCCESS;
+	case COMP_USB_TRANSACTION_ERROR:
+	case COMP_BABBLE_DETECTED_ERROR:
+	case COMP_ISOCH_BUFFER_OVERRUN:
+		return xhci->quirks & XHCI_ETRON_HOST &&
+			ring->type == TYPE_ISOC;
+	default:
+		return false;
+	}
+}
+
 /*
  * If this function returns an error condition, it means it got a Transfer
  * event with a corrupted Slot ID, Endpoint ID, or TRB DMA address.
@@ -2697,8 +2713,8 @@ static int handle_tx_event(struct xhci_hcd *xhci,
 	case COMP_SUCCESS:
 		if (EVENT_TRB_LEN(le32_to_cpu(event->transfer_len)) != 0) {
 			trb_comp_code = COMP_SHORT_PACKET;
-			xhci_dbg(xhci, "Successful completion on short TX for slot %u ep %u with last td short %d\n",
-				 slot_id, ep_index, ep_ring->last_td_was_short);
+			xhci_dbg(xhci, "Successful completion on short TX for slot %u ep %u with last td comp code %d\n",
+				 slot_id, ep_index, ep_ring->old_trb_comp_code);
 		}
 		break;
 	case COMP_SHORT_PACKET:
@@ -2846,7 +2862,7 @@ static int handle_tx_event(struct xhci_hcd *xhci,
 		 */
 		if (trb_comp_code != COMP_STOPPED &&
 		    trb_comp_code != COMP_STOPPED_LENGTH_INVALID &&
-		    !ep_ring->last_td_was_short) {
+		    !xhci_spurious_success_tx_event(xhci, ep_ring)) {
 			xhci_warn(xhci, "Event TRB for slot %u ep %u with no TDs queued\n",
 				  slot_id, ep_index);
 		}
@@ -2890,11 +2906,12 @@ static int handle_tx_event(struct xhci_hcd *xhci,
 
 			/*
 			 * Some hosts give a spurious success event after a short
-			 * transfer. Ignore it.
+			 * transfer or error on last TRB. Ignore it.
 			 */
-			if ((xhci->quirks & XHCI_SPURIOUS_SUCCESS) &&
-			    ep_ring->last_td_was_short) {
-				ep_ring->last_td_was_short = false;
+			if (xhci_spurious_success_tx_event(xhci, ep_ring)) {
+				xhci_dbg(xhci, "Spurious event dma %pad, comp_code %u after %u\n",
+					 &ep_trb_dma, trb_comp_code, ep_ring->old_trb_comp_code);
+				ep_ring->old_trb_comp_code = trb_comp_code;
 				return 0;
 			}
 
@@ -2922,10 +2939,7 @@ static int handle_tx_event(struct xhci_hcd *xhci,
 	 */
 	} while (ep->skip);
 
-	if (trb_comp_code == COMP_SHORT_PACKET)
-		ep_ring->last_td_was_short = true;
-	else
-		ep_ring->last_td_was_short = false;
+	ep_ring->old_trb_comp_code = trb_comp_code;
 
 	ep_trb = &ep_seg->trbs[(ep_trb_dma - ep_seg->dma) / sizeof(*ep_trb)];
 	trace_xhci_handle_transfer(ep_ring, (struct xhci_generic_trb *) ep_trb, ep_trb_dma);
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index 8c164340a2c3..c75c2c12ce53 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1371,7 +1371,7 @@ struct xhci_ring {
 	unsigned int		num_trbs_free; /* used only by xhci DbC */
 	unsigned int		bounce_buf_len;
 	enum xhci_ring_type	type;
-	bool			last_td_was_short;
+	u32			last_td_comp_code;
 	struct radix_tree_root	*trb_address_map;
 };
 
-- 
2.43.0


