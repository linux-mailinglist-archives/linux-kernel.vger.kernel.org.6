Return-Path: <linux-kernel+bounces-553750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3150DA58E6E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 09:42:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F75F1669F5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 08:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A708322422D;
	Mon, 10 Mar 2025 08:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CeYDNCM5"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A02B22370A;
	Mon, 10 Mar 2025 08:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741596141; cv=none; b=hbgnpQ4XAUx9gKnzqS5Ley7i7MJw1oP+7dMyBWw4Eyx+RIVek77nSJpsVlCfpGNYVFx0phAg4AYEhsRZr4N+RwGnrFuLlVjslGMYtb8KPT+bp5aleFTlgQrK/EqzXbTqo05Y88sGOAP5qIgZPhR4v6VTNNQ1folvn7x8dmtnOJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741596141; c=relaxed/simple;
	bh=PXuQmvsVxN3m72BnR6ST/tTb9xlntmcfVC+/hzMx5Xg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IzgnUSB0aPy6m32RmklRnO5miSFwbLxBsx80+Zs+KG4TIQfuDKCzugiota2P1HZ9pQZdIOnGYolKwRQmKnl0zoF66je2RVQRUV8WE3yiMSyQsoh4uS991Ci6gAKF2fOTUzORFhuqBdkXWfCZnBAXSZeMCCOBSASrkgS5GIoGRsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CeYDNCM5; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5e56b229d60so9140607a12.0;
        Mon, 10 Mar 2025 01:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741596137; x=1742200937; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YfIpDSCu41Ig3X26NPNtdponl0+k33/p8Qk35er3Ujs=;
        b=CeYDNCM5Vt7llbEY6iJDs1C0aQ4tTSFaDeq3bM2m0cxtHm5WXuNZn9UE0G+BLqE5Mg
         vnPPPZhXb4qXTpijCJ+h0DZf7+BXc5sq6CWJNXASWAwoG/1aIwBWjuHeFJHxAEcNBFlu
         spkkvHQYXmbBrtiiTzKp7JoS6QCH/Ojk6TUcbAZvGx60Tf0NwgqcPZiIp6kE/3/IPxf+
         8IiLFz5ejrYLk4IlzwiWDREmEPzAQxl0d/jJZtFUJaemgAJbw/HtQvoVLWsRRYEMemYx
         GyU/o9xVGueNcYx1mXxugz8nj6ZAZywdcfkZF88ui7ama+fgm0vdkM/GGiCXXwZl2zhr
         n85g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741596137; x=1742200937;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YfIpDSCu41Ig3X26NPNtdponl0+k33/p8Qk35er3Ujs=;
        b=tdTpf6nYDY0X3f0jPBxi/K1M5CQZNxUx/ITcPryZoJDic5h5a9d9innvVb7iR95ypv
         +H/WVNcgQAwzfIcQ/8+LOAFfyWHSDRaWOcmiPb19Pis2wa7tBeOMnzUI9Dn9DkHxdkGP
         KuZ/h4rNJqGAjRiXrpvaTfQ2FYtf1xa/h+1sQ3BRhc7ZT43RAzK8q4ftfdguCTY9+oS6
         I+9tNbea1sKfcn+SiQIRjG7vOeRlEj+InLkylk2xGDeARv3eaTp7CiteRJEPzGCFZ250
         bfqujd1qfU7mDGrqNKl1kaIgeXThE1lpV8bmcCchFyXck1UmFe0Y0muD8b4jBQv0+UNb
         ZQfg==
X-Forwarded-Encrypted: i=1; AJvYcCUsQROZA55sn9vaCmfnrWuvx7SJrZgq7DStOV2UL1s7D6p0dVm2YliKXPUGs5VQbfMlGBB/Dzc1G3Ei9io=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJsrM5/eXWFZGRYl/8C6WNRnAO2MzcrktFlVQjuycA/jeB0cCX
	6qAsO56BmM3SitbOEfqH8uQXsYelaqXq3QytI/prgrgTL/is434T
X-Gm-Gg: ASbGncvB1yyiBhYtNZdk5Q+poni8QyKAykZrQEqZFIPeWH8jEB56GI2pxRYnClMeZvW
	1Sqn5aWUCvCBmLAuEsA/4E4X4jpCUa4RRp58OBbLsgWdl2lDTdY0LOL0QvrQ7tNrtp8dQxPp9hv
	nUU0B4OrI1VasbXPGHYDtX7ggsbZQsaDWwC7HPHc5HYCft7YqXk0wMWdbq+q3ugcU95X5qr/UuD
	qC6HQnnzwq5NIvzIRnIkTw8Ooo8ndidcTpurDOCOEh8lzawpjwvHOsuSGRdP9tDHQ0QnTgMgq9e
	gG6enNCerHSTwpSQZ5DMAARswb4PUVA7/wQ2Nf9qLfHXFTgFG9PgaCxTxrIXSQ==
X-Google-Smtp-Source: AGHT+IG4/ADwP8W171t4vUpwm7B2Fco1Sd49nJ2HQ6NR6fVUcMZufAZlzTFmYs6O+Ku0Nps74N6p1w==
X-Received: by 2002:a17:907:3906:b0:abf:6e9:3732 with SMTP id a640c23a62f3a-ac26c9d4a9dmr875613866b.3.1741596137279;
        Mon, 10 Mar 2025 01:42:17 -0700 (PDT)
Received: from foxbook (adts246.neoplus.adsl.tpnet.pl. [79.185.230.246])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac23943897esm737671766b.13.2025.03.10.01.42.16
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 10 Mar 2025 01:42:16 -0700 (PDT)
Date: Mon, 10 Mar 2025 09:42:13 +0100
From: Michal Pecio <michal.pecio@gmail.com>
To: Mathias Nyman <mathias.nyman@intel.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] usb: xhci: Update comments about Stop Endpoint races
Message-ID: <20250310094213.3afca51c@foxbook>
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

The switch statement has grown beyond its original EP_STATE_HALTED case,
so move related comments inside this case and shorten them somewhat.

Shorten EP_STATE_STOPPED comments, add some common context at the top.

Signed-off-by: Michal Pecio <michal.pecio@gmail.com>
---
 drivers/usb/host/xhci-ring.c | 70 ++++++++++++++++++++----------------
 1 file changed, 39 insertions(+), 31 deletions(-)

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 241cd82672a6..759e8f612b4d 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -1199,20 +1199,21 @@ static void xhci_handle_cmd_stop_ep(struct xhci_hcd *xhci, int slot_id,
 	trace_xhci_handle_cmd_stop_ep(ep_ctx);
 
 	if (comp_code == COMP_CONTEXT_STATE_ERROR) {
-	/*
-	 * If stop endpoint command raced with a halting endpoint we need to
-	 * reset the host side endpoint first.
-	 * If the TD we halted on isn't cancelled the TD should be given back
-	 * with a proper error code, and the ring dequeue moved past the TD.
-	 * If streams case we can't find hw_deq, or the TD we halted on so do a
-	 * soft reset.
-	 *
-	 * Proper error code is unknown here, it would be -EPIPE if device side
-	 * of enadpoit halted (aka STALL), and -EPROTO if not (transaction error)
-	 * We use -EPROTO, if device is stalled it should return a stall error on
-	 * next transfer, which then will return -EPIPE, and device side stall is
-	 * noted and cleared by class driver.
-	 */
+
+		/*
+		 * This happens if the endpoint was not in the Running state. Its state now may
+		 * be other than at the time the command failed. We need to look at the Endpoint
+		 * Context and driver state to figure out what went wrong and what to do next.
+		 *
+		 * Many HCs are kind enough to hide their internal state transitions from us and
+		 * never fail Stop Endpoint after a doorbell ring. Others, including vendors like
+		 * NEC, ASMedia or Intel, may fail the command and begin running microseconds or
+		 * even milliseconds later (up to an ESIT on NEC periodic endpoints).
+		 *
+		 * We may see Running or Halted state after the command really failed on Stopped.
+		 * We may see Stopped after it failed on Halted, if somebody resets the endpoint.
+		 */
+
 		switch (GET_EP_CTX_STATE(ep_ctx)) {
 		case EP_STATE_HALTED:
 			xhci_dbg(xhci, "Stop ep completion raced with stall\n");
@@ -1222,8 +1223,23 @@ static void xhci_handle_cmd_stop_ep(struct xhci_hcd *xhci, int slot_id,
 			 */
 			if (ep->ep_state & EP_HALTED)
 				goto reset_done;
-
+			/*
+			 * Maybe reset failed with -ENOMEM. We are paranoid that a buggy HC may
+			 * mishandle the race and produce no transfer event before this command
+			 * completion. Or the endpoint actually was restarting, rejected Stop
+			 * Endpoint, then started and halted. The transfer event may only come
+			 * after this completion and some ASMedia HCs don't report such events.
+			 *
+			 * Try to reset the host endpoint now. Locate the halted TD, update its
+			 * status and cancel it. Reset EP completion takes care of the rest.
+			 *
+			 * Proper status is unknown here, it would be -EPIPE if the device side
+			 * endpoint stalled and -EPROTO otherwise (Transaction Error, etc).
+			 * We use -EPROTO, if device is stalled it should keep returning STALL
+			 * on future transfers which will hopefully receive normal handling.
+			 */
 			if (ep->ep_state & EP_HAS_STREAMS) {
+				/* We don't know which stream failed, attempt Soft Retry */
 				reset_type = EP_SOFT_RESET;
 			} else {
 				reset_type = EP_HARD_RESET;
@@ -1231,39 +1247,31 @@ static void xhci_handle_cmd_stop_ep(struct xhci_hcd *xhci, int slot_id,
 				if (td)
 					td->status = -EPROTO;
 			}
-			/* reset ep, reset handler cleans up cancelled tds */
 			err = xhci_handle_halted_endpoint(xhci, ep, td, reset_type);
 			xhci_dbg(xhci, "Stop ep completion resetting ep, status %d\n", err);
 			if (err)
+				/* persistent problem or disconnection, we must give back TDs */
 				break;
 reset_done:
 			/* Reset EP handler will clean up cancelled TDs */
 			ep->ep_state &= ~EP_STOP_CMD_PENDING;
 			return;
+
 		case EP_STATE_STOPPED:
 			/*
-			 * Per xHCI 4.6.9, Stop Endpoint command on a Stopped
-			 * EP is a Context State Error, and EP stays Stopped.
-			 *
-			 * But maybe it failed on Halted, and somebody ran Reset
-			 * Endpoint later. EP state is now Stopped and EP_HALTED
-			 * still set because Reset EP handler will run after us.
+			 * Maybe the command failed in Halted state and the transfer event queued
+			 * Reset Endpoint. The endpoint is now Stopped and EP_HALTED is still set,
+			 * because Reset Endpoint completion handler will run after this one.
 			 */
 			if (ep->ep_state & EP_HALTED)
 				break;
 			/*
-			 * On some HCs EP state remains Stopped for some tens of
-			 * us to a few ms or more after a doorbell ring, and any
-			 * new Stop Endpoint fails without aborting the restart.
-			 * This handler may run quickly enough to still see this
-			 * Stopped state, but it will soon change to Running.
-			 *
-			 * Assume this bug on unexpected Stop Endpoint failures.
-			 * Keep retrying until the EP starts and stops again.
+			 * We don't queue Stop Endpoint on Stopped endpoints. Assume the pending
+			 * restart case and keep retrying until it starts and stops again.
 			 */
 			fallthrough;
+
 		case EP_STATE_RUNNING:
-			/* Race, HW handled stop ep cmd before ep was running */
 			xhci_dbg(xhci, "Stop ep completion ctx error, ctx_state %d\n",
 					GET_EP_CTX_STATE(ep_ctx));
 			/*
-- 
2.48.1

