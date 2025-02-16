Return-Path: <linux-kernel+bounces-516839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5469A3780F
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 23:30:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94942188BA36
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 22:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE8DE1A3A8D;
	Sun, 16 Feb 2025 22:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HTrTYdYz"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891B31A256B
	for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2025 22:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739745010; cv=none; b=YkB5HtEBMgS5K0p0aWv1krgekEQRLohlenhw/KfCItJzdWsh74rk8Raw4CNGzAqdeIQVZwUG5UCZA06dU645xEsekA3lUM22qMG/lLLbTTaRQuDClnwobQ7NRyBpm44hKScivUbT+37jGClyYOiJ1YtADhaskGxXS/B7hbhKQbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739745010; c=relaxed/simple;
	bh=LQHcicrNmgiAow4s/z1Kr2I6yAyQolTRZ7P8h/rJKd4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ZjoxtQVZetbPUVIL/r6rZtDPUNcQmSVfbINUhc6N6pLYuyLeaOPZN711CeFyxV02J6i5FMnAiwZH8XYiYA70ji0GUABBSBbGqqfqP0UiQacKx3M5Q0wh+WCKXM0azfP4BPnbj7A2zWm2ccUfl83WJ8n0wrbe90tWDDLeOLgenLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--badhri.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HTrTYdYz; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--badhri.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2210121ac27so33235685ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2025 14:30:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739745008; x=1740349808; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PNKnjIND1cDqA5voAjCPjINYGDuyBQKKS2ATUZdV07o=;
        b=HTrTYdYzEwr6Bug/GQHjkynDKvBrMthfudcaGYNf2cgLVBGghkLjm3RUIzybtSsFnP
         Rzae/0w2bNONvGRBnky3GXepr50TkAnQ6pzqpr/m8TYOcyCjuJrkoNHK/tgQOUBy4Q3E
         pfgiVn2d9LacNCMx2/9j8LrbKbRQxTz7AkLZ6WA9SRwVCo8T9SQibtfqy1w6m1orImf0
         yc8Cb3vt4nCVgHOCHGZk21YKHVIWMPtwvx1wD4j+Pm8fSS4Tn7FsuccDawsKmJPJXyLs
         ZxlZOmnp11fzZaAqQeUT2orFPtVMpybTL+uI1cZ1SsBkK23E+5lZZUlPtKehrR2tNWg0
         DImQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739745008; x=1740349808;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PNKnjIND1cDqA5voAjCPjINYGDuyBQKKS2ATUZdV07o=;
        b=ALirGiu+vx/A6uI/CX4p7dQghxAXY/w/AGf2+RCDHLnr5vrQ2bz8ASnNwDjCM/LFPY
         iKxLONI5MKL7xaQ9gdkeHgSdXWaiCdMPPaCBHez8H7cNt1kgp9YtdADXAB7tldUNMLel
         AaBS1atnqDU4HG0KHB8AyTot24dXVnHWBvKmdgLCbss/nfTeTO9b55dHUpvXx3SBhGxb
         11JiZGbgs47d6GAE2k5bRCfFmNWnNe/xW+HVUzBsZ9azDG5mHMtraVAajF5+1DuG7Oi3
         NZ+Qd/E+RImofdzZHBOoa9dpfNay3w02PVW+3P35ik0b3+xvHUiLzdwfWPVsSwgyHXiY
         wOHA==
X-Forwarded-Encrypted: i=1; AJvYcCXPjoiJX9uXQjo2DNx7IyN0Ukz5gUd6eraN1dTkT4rV4aC+R1dyl9ikSif4cqXMDkydlEsM10tiiR9Xzi0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjSRV1PzEynxGWxR17jFJSthbe/rGbqrpQaW/4UqWZIjKSvoPm
	vz+LVHXl3phnOTJ5V1TVNS5OfRhy3C5QwIk0HCIi+KNC7BGyTmH2FMmfdvW7Wznb00o/GkKqqHT
	sqw==
X-Google-Smtp-Source: AGHT+IGimr17LrcrOJVFoDyG28j2uaoSa1qW7nDuBEqMagI93FDjZ+5itHfCRBNoeBZXHeX5KcpLhm/yiak=
X-Received: from plkl5.prod.google.com ([2002:a17:902:d345:b0:21f:347:73a8])
 (user=badhri job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2f88:b0:220:c4f0:4ee7
 with SMTP id d9443c01a7336-22103ef2039mr123034435ad.1.1739745007775; Sun, 16
 Feb 2025 14:30:07 -0800 (PST)
Date: Sun, 16 Feb 2025 22:30:02 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250216223003.3568039-1-badhri@google.com>
Subject: [PATCH v3] usb: dwc3: gadget: Prevent irq storm when TH re-executes
From: Badhri Jagan Sridharan <badhri@google.com>
To: Thinh.Nguyen@synopsys.com, gregkh@linuxfoundation.org, 
	felipe.balbi@linux.intel.com
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	jameswei@google.com, Badhri Jagan Sridharan <badhri@google.com>, stable@kernel.org
Content-Type: text/plain; charset="UTF-8"

While commit d325a1de49d6 ("usb: dwc3: gadget: Prevent losing events in
event cache") makes sure that top half(TH) does not end up overwriting the
cached events before processing them when the TH gets invoked more than one
time, returning IRQ_HANDLED results in occasional irq storm where the TH
hogs the CPU. The irq storm can be prevented by the flag before event
handler busy is cleared. Default enable interrupt moderation in all
versions which support them.

ftrace event stub during dwc3 irq storm:
    irq/504_dwc3-1111  ( 1111) [000] .... 70.000866: irq_handler_exit: irq=14 ret=handled
    irq/504_dwc3-1111  ( 1111) [000] .... 70.000872: irq_handler_entry: irq=504 name=dwc3
    irq/504_dwc3-1111  ( 1111) [000] .... 70.000874: irq_handler_exit: irq=504 ret=handled
    irq/504_dwc3-1111  ( 1111) [000] .... 70.000881: irq_handler_entry: irq=504 name=dwc3
    irq/504_dwc3-1111  ( 1111) [000] .... 70.000883: irq_handler_exit: irq=504 ret=handled
    irq/504_dwc3-1111  ( 1111) [000] .... 70.000889: irq_handler_entry: irq=504 name=dwc3
    irq/504_dwc3-1111  ( 1111) [000] .... 70.000892: irq_handler_exit: irq=504 ret=handled
    irq/504_dwc3-1111  ( 1111) [000] .... 70.000898: irq_handler_entry: irq=504 name=dwc3
    irq/504_dwc3-1111  ( 1111) [000] .... 70.000901: irq_handler_exit: irq=504 ret=handled
    irq/504_dwc3-1111  ( 1111) [000] .... 70.000907: irq_handler_entry: irq=504 name=dwc3
    irq/504_dwc3-1111  ( 1111) [000] .... 70.000909: irq_handler_exit: irq=504 ret=handled
    irq/504_dwc3-1111  ( 1111) [000] .... 70.000915: irq_handler_entry: irq=504 name=dwc3
    irq/504_dwc3-1111  ( 1111) [000] .... 70.000918: irq_handler_exit: irq=504 ret=handled
    irq/504_dwc3-1111  ( 1111) [000] .... 70.000924: irq_handler_entry: irq=504 name=dwc3
    irq/504_dwc3-1111  ( 1111) [000] .... 70.000927: irq_handler_exit: irq=504 ret=handled
    irq/504_dwc3-1111  ( 1111) [000] .... 70.000933: irq_handler_entry: irq=504 name=dwc3
    irq/504_dwc3-1111  ( 1111) [000] .... 70.000935: irq_handler_exit: irq=504 ret=handled
    ....

Cc: stable@kernel.org
Suggested-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Fixes: d325a1de49d6 ("usb: dwc3: gadget: Prevent losing events in event cache")
Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
---
Changes since v2:
* Consolidate logic for default enabling interrupt moderation as suggested
  by Thinh.Nguyen@
---
 drivers/usb/dwc3/core.c   | 16 ++++++----------
 drivers/usb/dwc3/gadget.c | 10 +++++++---
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index dfa1b5fe48dc..2c472cb97f6c 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -1835,8 +1835,6 @@ static void dwc3_get_properties(struct dwc3 *dwc)
 	dwc->tx_thr_num_pkt_prd = tx_thr_num_pkt_prd;
 	dwc->tx_max_burst_prd = tx_max_burst_prd;
 
-	dwc->imod_interval = 0;
-
 	dwc->tx_fifo_resize_max_num = tx_fifo_resize_max_num;
 }
 
@@ -1854,21 +1852,19 @@ static void dwc3_check_params(struct dwc3 *dwc)
 	unsigned int hwparam_gen =
 		DWC3_GHWPARAMS3_SSPHY_IFC(dwc->hwparams.hwparams3);
 
-	/* Check for proper value of imod_interval */
-	if (dwc->imod_interval && !dwc3_has_imod(dwc)) {
-		dev_warn(dwc->dev, "Interrupt moderation not supported\n");
-		dwc->imod_interval = 0;
-	}
-
 	/*
+	 * Enable IMOD for all supporting controllers.
+	 *
+	 * Particularly, DWC_usb3 v3.00a must enable this feature for
+	 * the following reason:
+	 *
 	 * Workaround for STAR 9000961433 which affects only version
 	 * 3.00a of the DWC_usb3 core. This prevents the controller
 	 * interrupt from being masked while handling events. IMOD
 	 * allows us to work around this issue. Enable it for the
 	 * affected version.
 	 */
-	if (!dwc->imod_interval &&
-	    DWC3_VER_IS(DWC3, 300A))
+	if (dwc3_has_imod((dwc)))
 		dwc->imod_interval = 1;
 
 	/* Check the maximum_speed parameter */
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index d27af65eb08a..fad115113d28 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -4467,14 +4467,18 @@ static irqreturn_t dwc3_process_event_buf(struct dwc3_event_buffer *evt)
 	dwc3_writel(dwc->regs, DWC3_GEVNTSIZ(0),
 		    DWC3_GEVNTSIZ_SIZE(evt->length));
 
+	evt->flags &= ~DWC3_EVENT_PENDING;
+	/*
+	 * Add an explicit write memory barrier to make sure that the update of
+	 * clearing DWC3_EVENT_PENDING is observed in dwc3_check_event_buf()
+	 */
+	wmb();
+
 	if (dwc->imod_interval) {
 		dwc3_writel(dwc->regs, DWC3_GEVNTCOUNT(0), DWC3_GEVNTCOUNT_EHB);
 		dwc3_writel(dwc->regs, DWC3_DEV_IMOD(0), dwc->imod_interval);
 	}
 
-	/* Keep the clearing of DWC3_EVENT_PENDING at the end */
-	evt->flags &= ~DWC3_EVENT_PENDING;
-
 	return ret;
 }
 

base-commit: 9682c35ff6ecd76d9462d4749b8b413d3e8e605e
-- 
2.48.1.601.g30ceb7b040-goog


