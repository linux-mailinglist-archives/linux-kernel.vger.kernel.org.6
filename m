Return-Path: <linux-kernel+bounces-361375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B0499A75E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 17:18:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5D541F2495A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 15:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE51F194A45;
	Fri, 11 Oct 2024 15:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="d36dNglj"
Received: from mail-qt1-f195.google.com (mail-qt1-f195.google.com [209.85.160.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584DE126C01
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 15:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728659886; cv=none; b=blP/e/ozxCgUXJ25Lxs8J1FmmrM8Bt2QPbOS+AtHIiy3wK6SKdT2Wl0IAxe/bzdltwSmf0DQumALUgp2EnrrYVUdXk0hN1/QdaVUg8noNSmImShbymnFCWEWrTXhFkQso43zAqFnWfp+VU5Lwa+MGTmXG2fA6hdjxvK5rGfO1vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728659886; c=relaxed/simple;
	bh=gVnFAZwLDeEvRF72+KovXISrcg3kkc6vXYrwtwhy4Ok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gCCMscqaUTxb11cOf3V3+EbLZoPdFxbcLZ0Yivk721VyFjEEJ+J4BCxclEHJQSO6C6d/R2Uu5yqria4Jmizeugq09psCnl2NAeqqhfIYibA1jH2w4fvOQQuQihA7o3vyOXtFQuLJe4ftI4bNT2HCqCDH5cfaJuQzpvVYsv5pp/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=d36dNglj; arc=none smtp.client-ip=209.85.160.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qt1-f195.google.com with SMTP id d75a77b69052e-45f07eb6f5fso19968211cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 08:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1728659883; x=1729264683; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HXIMrHcg/8NoXkeEaeieM1EsVmARx8atMu+7yCy+Tlw=;
        b=d36dNgljDihQyB2pGIOqIrwiNiaEURgjjck6yzvVEEwd0n1BrGZFGxuc8GfdqWqzjz
         ifg9NS/l2Hhiny/PF5ARsAwCA6EoCv3RU9rrQoqEM4Nhc4oZWQS7MFCi1ejgVvns/xxU
         aRIwGJIgcL6P2hBovIGtiEu5ZykcRISdVGNzwFKT9OHxwh0HKdpcxH/Ii7tRVyYhAvY+
         kKmD7K5xKyZEJUUD7hK1hlMRxPtqFAy+QBhqSYERKu1TVtEsNUmDO2klSjquc8RykhOb
         l+cMVWf4b/dz82g4BOy+VGfVYyxF0u66wow+l/rtsa8i4KDvlLL38GS9K80uI0PpUgsf
         9avw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728659883; x=1729264683;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HXIMrHcg/8NoXkeEaeieM1EsVmARx8atMu+7yCy+Tlw=;
        b=ji7NR7elD9zREHWi9j/rXcw74HPjCkbHq7CEW5IVITq/xZvXIKfQ3uejbS4CPYB9Ij
         2tO1PqVgq5Tbb/DtbEMoLq5LsNqqQ3Zl8/hkEKiBXRiH9JyE+niNbBARgYy8lOFOX+og
         WwO1z6HINkJVyasEtDM6hlC7hn5ppH2gemNv8mD+75LIVbRPo+DlYig+UUqp3wgIb/7j
         pCDq73mWUwKYVeyHk8abgDQO7VkfLMc4ToMpa6yjqMqnhQG+E3BdRKfIU0oN3k96bXdV
         Z8VmUzoAve9SmlVeDCeBjyAwG7rYLb+lfUNO+EXdG7f2vzDZNUzF4b0cOL4KJltaessI
         x2PQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYShiFZxSCKmrTrhLF7+UyWMTl4U3qAoeDky4z3lAgAYGmSiKckq1tL9vH1uSL3/GVztewtbY0IzY+o3c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yym1rYQ5fG8tjag0m7e7wt1NuG8ivvLY5aq3HabNd0W/+adaYl7
	U9t9kw3G4AgPyBCeGE+cMEcfOX+9qWvlr9o4rfZH/jqIzGVA2139ZmOu7LD5LQ==
X-Google-Smtp-Source: AGHT+IGswve/69O8TjgyJNIbOHC/4vam8nR6YId86by2pmGUCvuoYQlE5sP1eOUVSKY2MnTO4hvgqg==
X-Received: by 2002:a05:622a:1310:b0:45f:677:d395 with SMTP id d75a77b69052e-4604b290e06mr52245981cf.17.1728659882952;
        Fri, 11 Oct 2024 08:18:02 -0700 (PDT)
Received: from rowland.harvard.edu ([2607:fb60:2501:2805:c6d5:fe22:7fa3:ec54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4604288204csm16040621cf.61.2024.10.11.08.18.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 08:18:02 -0700 (PDT)
Date: Fri, 11 Oct 2024 11:17:59 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: syzbot <syzbot+f342ea16c9d06d80b585@syzkaller.appspotmail.com>
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org, sylv@sylv.io,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [usb?] INFO: task hung in usb_port_suspend
Message-ID: <b9ce2eb7-1770-4198-97b2-f5d7aa57c3d1@rowland.harvard.edu>
References: <9cc382bd-debc-42d6-977e-559d48b82f58@rowland.harvard.edu>
 <67093d75.050a0220.4cbc0.000a.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67093d75.050a0220.4cbc0.000a.GAE@google.com>

On Fri, Oct 11, 2024 at 08:00:05AM -0700, syzbot wrote:
> Hello,
> 
> syzbot tried to test the proposed patch but the build/boot failed:
> 
> failed to apply patch:
> checking file drivers/usb/gadget/udc/dummy_hcd.c
> Hunk #4 FAILED at 1301.
> Hunk #5 FAILED at 1323.
> Hunk #6 succeeded at 1778 (offset 1 line).
> Hunk #7 succeeded at 1809 (offset 1 line).
> Hunk #8 succeeded at 1818 (offset 1 line).
> Hunk #9 FAILED at 1995.
> Hunk #10 FAILED at 2389.
> Hunk #11 FAILED at 2467.
> Hunk #12 FAILED at 2497.
> Hunk #13 succeeded at 2519 (offset 2 lines).
> 6 out of 13 hunks FAILED
> 
> 
> 
> Tested on:
> 
> commit:         4a9fe2a8 dt-bindings: usb: dwc3-imx8mp: add compatible..
> git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing

All right, one more try, this time starting from the right commit.

Alan Stern

#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing

Index: usb-devel/drivers/usb/gadget/udc/dummy_hcd.c
===================================================================
--- usb-devel.orig/drivers/usb/gadget/udc/dummy_hcd.c
+++ usb-devel/drivers/usb/gadget/udc/dummy_hcd.c
@@ -30,7 +30,7 @@
 #include <linux/slab.h>
 #include <linux/errno.h>
 #include <linux/init.h>
-#include <linux/hrtimer.h>
+#include <linux/timer.h>
 #include <linux/list.h>
 #include <linux/interrupt.h>
 #include <linux/platform_device.h>
@@ -50,8 +50,6 @@
 #define POWER_BUDGET	500	/* in mA; use 8 for low-power port testing */
 #define POWER_BUDGET_3	900	/* in mA */
 
-#define DUMMY_TIMER_INT_NSECS	125000 /* 1 microframe */
-
 static const char	driver_name[] = "dummy_hcd";
 static const char	driver_desc[] = "USB Host+Gadget Emulator";
 
@@ -242,7 +240,7 @@ enum dummy_rh_state {
 struct dummy_hcd {
 	struct dummy			*dum;
 	enum dummy_rh_state		rh_state;
-	struct hrtimer			timer;
+	struct timer_list		timer;
 	u32				port_status;
 	u32				old_status;
 	unsigned long			re_timeout;
@@ -1303,9 +1301,8 @@ static int dummy_urb_enqueue(
 		urb->error_count = 1;		/* mark as a new urb */
 
 	/* kick the scheduler, it'll do the rest */
-	if (!hrtimer_active(&dum_hcd->timer))
-		hrtimer_start(&dum_hcd->timer, ns_to_ktime(DUMMY_TIMER_INT_NSECS),
-				HRTIMER_MODE_REL_SOFT);
+	if (!timer_pending(&dum_hcd->timer))
+		mod_timer(&dum_hcd->timer, jiffies + 1);
 
  done:
 	spin_unlock_irqrestore(&dum_hcd->dum->lock, flags);
@@ -1326,7 +1323,7 @@ static int dummy_urb_dequeue(struct usb_
 	rc = usb_hcd_check_unlink_urb(hcd, urb, status);
 	if (!rc && dum_hcd->rh_state != DUMMY_RH_RUNNING &&
 			!list_empty(&dum_hcd->urbp_list))
-		hrtimer_start(&dum_hcd->timer, ns_to_ktime(0), HRTIMER_MODE_REL_SOFT);
+		mod_timer(&dum_hcd->timer, jiffies);
 
 	spin_unlock_irqrestore(&dum_hcd->dum->lock, flags);
 	return rc;
@@ -1780,7 +1777,7 @@ static int handle_control_request(struct
  * drivers except that the callbacks are invoked from soft interrupt
  * context.
  */
-static enum hrtimer_restart dummy_timer(struct hrtimer *t)
+static void dummy_timer(struct timer_list *t)
 {
 	struct dummy_hcd	*dum_hcd = from_timer(dum_hcd, t, timer);
 	struct dummy		*dum = dum_hcd->dum;
@@ -1811,6 +1808,8 @@ static enum hrtimer_restart dummy_timer(
 		break;
 	}
 
+	/* FIXME if HZ != 1000 this will probably misbehave ... */
+
 	/* look at each urb queued by the host side driver */
 	spin_lock_irqsave(&dum->lock, flags);
 
@@ -1818,7 +1817,7 @@ static enum hrtimer_restart dummy_timer(
 		dev_err(dummy_dev(dum_hcd),
 				"timer fired with no URBs pending?\n");
 		spin_unlock_irqrestore(&dum->lock, flags);
-		return HRTIMER_NORESTART;
+		return;
 	}
 	dum_hcd->next_frame_urbp = NULL;
 
@@ -1996,13 +1995,10 @@ return_urb:
 		dum_hcd->udev = NULL;
 	} else if (dum_hcd->rh_state == DUMMY_RH_RUNNING) {
 		/* want a 1 msec delay here */
-		hrtimer_start(&dum_hcd->timer, ns_to_ktime(DUMMY_TIMER_INT_NSECS),
-				HRTIMER_MODE_REL_SOFT);
+		mod_timer(&dum_hcd->timer, jiffies + msecs_to_jiffies(1));
 	}
 
 	spin_unlock_irqrestore(&dum->lock, flags);
-
-	return HRTIMER_NORESTART;
 }
 
 /*-------------------------------------------------------------------------*/
@@ -2391,7 +2387,7 @@ static int dummy_bus_resume(struct usb_h
 		dum_hcd->rh_state = DUMMY_RH_RUNNING;
 		set_link_state(dum_hcd);
 		if (!list_empty(&dum_hcd->urbp_list))
-			hrtimer_start(&dum_hcd->timer, ns_to_ktime(0), HRTIMER_MODE_REL_SOFT);
+			mod_timer(&dum_hcd->timer, jiffies);
 		hcd->state = HC_STATE_RUNNING;
 	}
 	spin_unlock_irq(&dum_hcd->dum->lock);
@@ -2469,8 +2465,7 @@ static DEVICE_ATTR_RO(urbs);
 
 static int dummy_start_ss(struct dummy_hcd *dum_hcd)
 {
-	hrtimer_init(&dum_hcd->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_SOFT);
-	dum_hcd->timer.function = dummy_timer;
+	timer_setup(&dum_hcd->timer, dummy_timer, 0);
 	dum_hcd->rh_state = DUMMY_RH_RUNNING;
 	dum_hcd->stream_en_ep = 0;
 	INIT_LIST_HEAD(&dum_hcd->urbp_list);
@@ -2499,8 +2494,7 @@ static int dummy_start(struct usb_hcd *h
 		return dummy_start_ss(dum_hcd);
 
 	spin_lock_init(&dum_hcd->dum->lock);
-	hrtimer_init(&dum_hcd->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_SOFT);
-	dum_hcd->timer.function = dummy_timer;
+	timer_setup(&dum_hcd->timer, dummy_timer, 0);
 	dum_hcd->rh_state = DUMMY_RH_RUNNING;
 
 	INIT_LIST_HEAD(&dum_hcd->urbp_list);
@@ -2519,11 +2513,8 @@ static int dummy_start(struct usb_hcd *h
 
 static void dummy_stop(struct usb_hcd *hcd)
 {
-	struct dummy_hcd	*dum_hcd = hcd_to_dummy_hcd(hcd);
-
-	hrtimer_cancel(&dum_hcd->timer);
-	device_remove_file(dummy_dev(dum_hcd), &dev_attr_urbs);
-	dev_info(dummy_dev(dum_hcd), "stopped\n");
+	device_remove_file(dummy_dev(hcd_to_dummy_hcd(hcd)), &dev_attr_urbs);
+	dev_info(dummy_dev(hcd_to_dummy_hcd(hcd)), "stopped\n");
 }
 
 /*-------------------------------------------------------------------------*/

