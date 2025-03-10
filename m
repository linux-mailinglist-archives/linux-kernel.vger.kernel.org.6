Return-Path: <linux-kernel+bounces-553737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8A5FA58E49
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 09:38:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D610816B8C0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 08:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0090224227;
	Mon, 10 Mar 2025 08:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i7yiwgjh"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F50223704;
	Mon, 10 Mar 2025 08:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741595875; cv=none; b=GbQ015g3zIz50V55NcV55cYb4vzQvxurv5B1TGCT7BtLSN0mkRGzIQz9rJDBvkvHAj13yV0V1rUXV9b4XJnDLJnEE/UbDzz6eey/NvTls50EDrjljs8YoGasXXTMhegfytTLlHTfNSAEpAdaQWfZ2ewrhUbBk2YVDTY7OpYMylw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741595875; c=relaxed/simple;
	bh=WwzChQUR0/Orj8v4gVEr8SzL6nweKeVJJMunMAUDTNg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fYZgBWIS9fmZs8E7gGx25T3561w1xt6qUTR4NaXFwJ7hn+PcNbh3Hi1BHJwdr3BTmKmPFJdlVV95utO9zKgpSzlkGWGagi8cMWPBvlXqxKkEs1xUWV6F2dk1ce6U8wKBj1ZOx1aFs49FHmKMTiKTkVFOjd6WvuyvxyN6MXDIt0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i7yiwgjh; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5e535e6739bso6161670a12.1;
        Mon, 10 Mar 2025 01:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741595871; x=1742200671; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PzM2FI7xwyYh3FQWLyCsyYca8N8fg915Jvc3iX3DzCA=;
        b=i7yiwgjhTt7ondUNwHxCzVo3xo6GRfb3Rz55x2aTVfHAzs/3kvxw+hXOLwm7gd94ap
         S41em9IMVKe8gJ6ud93iKaEiUcqWIjz7THxTfpFcuCJwQ9gu/clA7AL0avjTysRrSGmZ
         hKBXPG5xYbt5HzIRbqOILJujaUTkrhLAJ/TY13mWpAlwR1LGyhZW8XDpAfLYOEWwAS62
         hUv3FeejQhp4tjAX9yBldG1Yqcc5E9eBUigUqJ5wD/mTB8EdLZyheP6yzPPP/OfhE9kv
         0oEF4/udt9X3hulIiB3yDRm+hZGiPRlFqYjjqjt8NecJn8XeuKL4fLhivdM+5KvQdIuM
         WK/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741595871; x=1742200671;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PzM2FI7xwyYh3FQWLyCsyYca8N8fg915Jvc3iX3DzCA=;
        b=K4Oqdup5ut1p4zIc223Cx06mpy7AwttBA4VCPkoQpDs+hUO5bgEs2k+0uduKWuI6Ud
         JUZuBEmFxb6NXaJA+oI03Q1OQl09hfdsX7jPI4DnakOVVUxWkm/fovDnkcxrbpYt8Ixr
         QFZRmNJDuREVukZzvlTFVk/6eGOg2/xg+P37KpECoQ6m//MvBo2Z0IeOhVloABzOBujP
         1SyMKf3iRXJIFsuTWkl61kP/2jWMaNuj/Dxktq2qLs+hm3YEUWvflTdy8iE1KViXy5jQ
         /36IvIBsqNYjRWYxue1eQmoyN99tK3qE9n74JhtIADIQPL9GFQ/gC19hNK6NxFzSKTR/
         CIIw==
X-Forwarded-Encrypted: i=1; AJvYcCUhtMDufje62WAhfB+9yCvZFTGNz122Ki6jCnZTW/UuH25330+pGiER9i4+/R5CH5mYGo7l2scr/exfbKM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRZjjhuHUpe0PIM8/imepFINB7eNM8tHZOFDBKR95t0wMyhD32
	6idXfFUZ64I9ZUB396C64l87nppwQaYBqAiogE9/1+xnJn77oJ4O
X-Gm-Gg: ASbGncvB9GAnxoVRPdH35oNlJlPTBK5asd4kOV9DUSY9gxMHuW1tHhfaSjV45u/V5SE
	LFWERwSXdEWMjbRTduNfmMrg3EcY6aC9/k7Z7MQLaJK+eJ0jKRhn2Ai/s3dcZCTPOyBq9ZkMW1y
	KE52eWwsEdMuPNqVBlFpl5x3sdWB8BUBMgMrG4F/56Weg3zemqNRU1jZrIUfl9iKKBmliRz6gah
	MLxGf0FW+63cH5IEzWWCFxf4KZ/MCgOErENzzcQCN0yRNYKoMj65VE8F63aldK552u7v0HX3ILb
	0S29VdIv845OQLpbcYUeEGBUzW3ASD+IEtptYLDZZJ537MiA3o0Nadr443LTRg==
X-Google-Smtp-Source: AGHT+IEA88nbsP/2GVWNBm0DAGnRT9RKYSapr/mIao77wh/OXRQAhQ2TnBS6HICb+VzXnLu1ToJwhQ==
X-Received: by 2002:a05:6402:3547:b0:5e4:d2c9:455c with SMTP id 4fb4d7f45d1cf-5e5e22b7935mr12418985a12.10.1741595871370;
        Mon, 10 Mar 2025 01:37:51 -0700 (PDT)
Received: from foxbook (adts246.neoplus.adsl.tpnet.pl. [79.185.230.246])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e5c7472169sm6564505a12.24.2025.03.10.01.37.50
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 10 Mar 2025 01:37:50 -0700 (PDT)
Date: Mon, 10 Mar 2025 09:37:48 +0100
From: Michal Pecio <michal.pecio@gmail.com>
To: Mathias Nyman <mathias.nyman@intel.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] usb: xhci: Deduplicate some endpoint state flag lists
Message-ID: <20250310093748.201e87cd@foxbook>
In-Reply-To: <20250310093605.2b3d0425@foxbook>
References: <20250310093605.2b3d0425@foxbook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

xhci_ring_endpoint_doorbell() needs a list of flags which prohibit
running the endpoint.

xhci_urb_dequeue() needs the same list, split in two parts, to know
whether the endpoint is running and how to cancel TDs.

Define the two partial lists in xhci.h and use them in both functions.

Add a comment about the AMD Stop Endpoint bug, see commit 28a2369f7d72
("usb: xhci: Issue stop EP command only when the EP state is running")

Signed-off-by: Michal Pecio <michal.pecio@gmail.com>
---
 drivers/usb/host/xhci-ring.c | 10 ++--------
 drivers/usb/host/xhci.c      | 16 +++++++++++-----
 drivers/usb/host/xhci.h      | 16 +++++++++++++++-
 3 files changed, 28 insertions(+), 14 deletions(-)

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 0f8acbb9cd21..8aab077d6183 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -555,14 +555,8 @@ void xhci_ring_ep_doorbell(struct xhci_hcd *xhci,
 	struct xhci_virt_ep *ep = &xhci->devs[slot_id]->eps[ep_index];
 	unsigned int ep_state = ep->ep_state;
 
-	/* Don't ring the doorbell for this endpoint if there are pending
-	 * cancellations because we don't want to interrupt processing.
-	 * We don't want to restart any stream rings if there's a set dequeue
-	 * pointer command pending because the device can choose to start any
-	 * stream once the endpoint is on the HW schedule.
-	 */
-	if (ep_state & (EP_STOP_CMD_PENDING | SET_DEQ_PENDING | EP_HALTED |
-			EP_CLEARING_TT | EP_STALLED))
+	/* Don't start yet if certain endpoint operations are ongoing */
+	if (ep_state & (EP_CANCEL_PENDING | EP_MISC_OPS_PENDING))
 		return;
 
 	trace_xhci_ring_ep_doorbell(slot_id, DB_VALUE(ep_index, stream_id));
diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 7492090fad5f..c33134a3003a 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -1762,16 +1762,22 @@ static int xhci_urb_dequeue(struct usb_hcd *hcd, struct urb *urb, int status)
 		}
 	}
 
-	/* These completion handlers will sort out cancelled TDs for us */
-	if (ep->ep_state & (EP_STOP_CMD_PENDING | EP_HALTED | SET_DEQ_PENDING)) {
+	/*
+	 * We have a few strategies to give back the cancelled TDs. If the endpoint is running,
+	 * no other choice - it must be stopped. But if it's not, we avoid queuing Stop Endpoint
+	 * because this triggers a bug in "AMD SNPS 3.1 xHC" and because our completion handler
+	 * is complex enough already without having to worry about such things.
+	 */
+
+	/* If cancellation is already running, giveback of all cancelled TDs is guaranteed */
+	if (ep->ep_state & EP_CANCEL_PENDING) {
 		xhci_dbg(xhci, "Not queuing Stop Endpoint on slot %d ep %d in state 0x%x\n",
 				urb->dev->slot_id, ep_index, ep->ep_state);
 		goto done;
 	}
 
-	/* In this case no commands are pending but the endpoint is stopped */
-	if (ep->ep_state & (EP_CLEARING_TT | EP_STALLED)) {
-		/* and cancelled TDs can be given back right away */
+	/* Cancel immediately if no commands are pending but the endpoint is held stopped */
+	if (ep->ep_state & EP_MISC_OPS_PENDING) {
 		xhci_dbg(xhci, "Invalidating TDs instantly on slot %d ep %d in state 0x%x\n",
 				urb->dev->slot_id, ep_index, ep->ep_state);
 		xhci_process_cancelled_tds(ep);
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index 46bbdc97cc4b..87d87ed08b8b 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -718,9 +718,23 @@ struct xhci_virt_ep {
  * xhci_ring_ep_doorbell() inspects the flags to decide if the endpoint can be restarted. Another
  * user is xhci_urb_dequeue(), which must not attempt to stop a Stopped endpoint, due to HW bugs.
  * An endpoint with pending URBs and no flags preventing restart must be Running for this to work.
- * Call xhci_ring_doorbell_for_active_rings() or similar after clearing any such flag.
+ * Call xhci_ring_doorbell_for_active_rings() or similar after clearing flags on the lists below.
  */
 
+/*
+ * TD cancellation is in progress. New TDs can be marked as cancelled without further action and
+ * indeed no such action is possible until these commands complete. Their handlers must check for
+ * more cancelled TDs and continue until all are given back. The endpoint must not be restarted.
+ */
+#define EP_CANCEL_PENDING (SET_DEQ_PENDING | EP_HALTED | EP_STOP_CMD_PENDING)
+
+/*
+ * Some other operations are pending which preclude restarting the endpoint. If the endpoint isn't
+ * transitioning to the Stopped state, it has already reached this state and stays in it.
+ */
+#define EP_MISC_OPS_PENDING (EP_CLEARING_TT | EP_STALLED)
+
+
 enum xhci_overhead_type {
 	LS_OVERHEAD_TYPE = 0,
 	FS_OVERHEAD_TYPE,
-- 
2.48.1

