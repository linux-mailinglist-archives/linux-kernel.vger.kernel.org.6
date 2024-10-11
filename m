Return-Path: <linux-kernel+bounces-361340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EECE299A701
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 16:55:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E71A1F216A3
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 14:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB541183CD5;
	Fri, 11 Oct 2024 14:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="P1WAoWd3"
Received: from mail-qv1-f65.google.com (mail-qv1-f65.google.com [209.85.219.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB50405FB
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 14:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728658528; cv=none; b=ekS1iAsdpS6Sy9jVsG6ldt7uuKcviw/Tk7Fdy/90POjH9W7iNzWLmApMV1oAYIyBsQ0IPyuXnDvR5MqLQItaNE6/vJVNd87FUc1Aci6tyiYgY24vb38ZuEYYRVHTM62WrAGpeZ7AmGr73G1B5eOQNdrUVReRoF4zuWcPnjgaohU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728658528; c=relaxed/simple;
	bh=aHZMY9R/W7f0WVRPhNJljkS9waE6ViiKOSOCw+2gghY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J1KKDhyTIQMC1ZaLXSYfBxE4lQ3ZjZiTPwEBOPVSsTmyMMe1hz2OwgvfJ610TXVm+jdAsDxw/Ke7skAf9TPGrLG+njHIs0hmHVhhcRovdl/yvPk6IbgUVqIVWHxXTUXTMJORxgAbEJ4GgsOgOWFq/rvrJ1tLPXp2Ml4MdoBh6RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=P1WAoWd3; arc=none smtp.client-ip=209.85.219.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qv1-f65.google.com with SMTP id 6a1803df08f44-6cbf0e6414aso4018136d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 07:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1728658525; x=1729263325; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tfXt/0V3gGz/Nl53n2+SwqZesc7IYnQqnW1L9TAWte0=;
        b=P1WAoWd3aBUx8TbkavEjFrcmgVQJYcki8d5TpK3TgvHQe1HV2ufEYp3XMVhTs3Xb4K
         7fMeeLXxiRz1WnrcjZdxZgOY+X6QIrdwn/b9jIL6z/M59J70G2tIeVvydSa/QaRnx5sT
         U2QjILtyGY3Cy0KD9ESNH6GfCJIMFl5D40e6JDHwP1vVCnjJmWFxd/IzOcGT3iMLaQMq
         eTgG5eTx938xS/jLQA/fMBUChtirSOWHdxOWQ/57X8w8CcB3U/ZcHcm+EIyy76tn/u9g
         Mzk5EcylUvvCsrjUDdo0BG3ijZ/JPG4DT14s6CcfCYCzysJ7fhYsOVn37Vm1XnsrNiJX
         0umw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728658525; x=1729263325;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tfXt/0V3gGz/Nl53n2+SwqZesc7IYnQqnW1L9TAWte0=;
        b=ZYfOMgjhVWvoGZJXFHPMbWZSHT6L0hf+UDNiW9QUKW2W/nA1fZyECDxCBH3E4C7UGB
         VVL55kJN/euXmKHeDgf9pvLyojhn2AKCSBr6oHY8ZozaAICoz8biSiUYNrW0JMgbIg87
         206eCP5c1Bwhy6jX+B4aDYdrK5GUq8iR6Zn16R7vxPdbaYipIagid0E/F+sWtkD6YoMV
         TM75emBwofSqWWLTskKRU8UJnp+h//EAs3TRGwTIgYCTnXJwMKqbtA7ZxeTcn0nmZKob
         nytUkuR56O57t6uI7jg5XfzJD1FcXSWTSfy9ArDURddN9ecq4apJEDJJxMYevuqjOh71
         Idqg==
X-Forwarded-Encrypted: i=1; AJvYcCWjSKIJxZlr45Ky8YNIML1eBJ7UMyJK/qj1tmM86Be/6pLOaeIjLpRCWOcUj/VGij4Z4OUNxI57qjYWgwQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YykuvavgUx5LT69qBGnpgjm7XCABEGqa9iputbaMIJAcD3zEhJD
	twJqEUl/PzzjtX5KjyClBWJwSZjG1zH1k/eL/Hcrs6vQ67M9QhOCxz66d1vTTQ==
X-Google-Smtp-Source: AGHT+IFG6nBmcE9lldQyQmN3k3AEJupi5pM/juawXFnijvZk8oP90eN1Kb+XkygHtzIsYs12ex6d3Q==
X-Received: by 2002:a05:6214:4587:b0:6cb:e52c:c8e6 with SMTP id 6a1803df08f44-6cbf0040c52mr44070816d6.31.1728658525268;
        Fri, 11 Oct 2024 07:55:25 -0700 (PDT)
Received: from rowland.harvard.edu ([2607:fb60:2501:2805:c6d5:fe22:7fa3:ec54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cbe8608e90sm16235646d6.99.2024.10.11.07.55.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 07:55:24 -0700 (PDT)
Date: Fri, 11 Oct 2024 10:55:22 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: syzbot <syzbot+f342ea16c9d06d80b585@syzkaller.appspotmail.com>
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org, sylv@sylv.io,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [usb?] INFO: task hung in usb_port_suspend
Message-ID: <9cc382bd-debc-42d6-977e-559d48b82f58@rowland.harvard.edu>
References: <d65e2258-2901-486a-ab83-ff57e9868a91@rowland.harvard.edu>
 <67093796.050a0220.3e960.0012.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67093796.050a0220.3e960.0012.GAE@google.com>

On Fri, Oct 11, 2024 at 07:35:02AM -0700, syzbot wrote:
> Hello,
> 
> syzbot tried to test the proposed patch but the build/boot failed:

...

> Tested on:
> 
> commit:         920e7522 usb: gadget: function: Remove usage of the de..

All right, let's try again with an explicit patch to undo the timer 
changes in dummy_hcd.c.

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
@@ -1303,8 +1301,8 @@ static int dummy_urb_enqueue(
 		urb->error_count = 1;		/* mark as a new urb */
 
 	/* kick the scheduler, it'll do the rest */
-	if (!hrtimer_active(&dum_hcd->timer))
-		hrtimer_start(&dum_hcd->timer, ns_to_ktime(DUMMY_TIMER_INT_NSECS), HRTIMER_MODE_REL);
+	if (!timer_pending(&dum_hcd->timer))
+		mod_timer(&dum_hcd->timer, jiffies + 1);
 
  done:
 	spin_unlock_irqrestore(&dum_hcd->dum->lock, flags);
@@ -1325,7 +1323,7 @@ static int dummy_urb_dequeue(struct usb_
 	rc = usb_hcd_check_unlink_urb(hcd, urb, status);
 	if (!rc && dum_hcd->rh_state != DUMMY_RH_RUNNING &&
 			!list_empty(&dum_hcd->urbp_list))
-		hrtimer_start(&dum_hcd->timer, ns_to_ktime(0), HRTIMER_MODE_REL);
+		mod_timer(&dum_hcd->timer, jiffies);
 
 	spin_unlock_irqrestore(&dum_hcd->dum->lock, flags);
 	return rc;
@@ -1779,7 +1777,7 @@ static int handle_control_request(struct
  * drivers except that the callbacks are invoked from soft interrupt
  * context.
  */
-static enum hrtimer_restart dummy_timer(struct hrtimer *t)
+static void dummy_timer(struct timer_list *t)
 {
 	struct dummy_hcd	*dum_hcd = from_timer(dum_hcd, t, timer);
 	struct dummy		*dum = dum_hcd->dum;
@@ -1810,6 +1808,8 @@ static enum hrtimer_restart dummy_timer(
 		break;
 	}
 
+	/* FIXME if HZ != 1000 this will probably misbehave ... */
+
 	/* look at each urb queued by the host side driver */
 	spin_lock_irqsave(&dum->lock, flags);
 
@@ -1817,7 +1817,7 @@ static enum hrtimer_restart dummy_timer(
 		dev_err(dummy_dev(dum_hcd),
 				"timer fired with no URBs pending?\n");
 		spin_unlock_irqrestore(&dum->lock, flags);
-		return HRTIMER_NORESTART;
+		return;
 	}
 	dum_hcd->next_frame_urbp = NULL;
 
@@ -1995,12 +1995,10 @@ return_urb:
 		dum_hcd->udev = NULL;
 	} else if (dum_hcd->rh_state == DUMMY_RH_RUNNING) {
 		/* want a 1 msec delay here */
-		hrtimer_start(&dum_hcd->timer, ns_to_ktime(DUMMY_TIMER_INT_NSECS), HRTIMER_MODE_REL);
+		mod_timer(&dum_hcd->timer, jiffies + msecs_to_jiffies(1));
 	}
 
 	spin_unlock_irqrestore(&dum->lock, flags);
-
-	return HRTIMER_NORESTART;
 }
 
 /*-------------------------------------------------------------------------*/
@@ -2389,7 +2387,7 @@ static int dummy_bus_resume(struct usb_h
 		dum_hcd->rh_state = DUMMY_RH_RUNNING;
 		set_link_state(dum_hcd);
 		if (!list_empty(&dum_hcd->urbp_list))
-			hrtimer_start(&dum_hcd->timer, ns_to_ktime(0), HRTIMER_MODE_REL);
+			mod_timer(&dum_hcd->timer, jiffies);
 		hcd->state = HC_STATE_RUNNING;
 	}
 	spin_unlock_irq(&dum_hcd->dum->lock);
@@ -2467,8 +2465,7 @@ static DEVICE_ATTR_RO(urbs);
 
 static int dummy_start_ss(struct dummy_hcd *dum_hcd)
 {
-	hrtimer_init(&dum_hcd->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	dum_hcd->timer.function = dummy_timer;
+	timer_setup(&dum_hcd->timer, dummy_timer, 0);
 	dum_hcd->rh_state = DUMMY_RH_RUNNING;
 	dum_hcd->stream_en_ep = 0;
 	INIT_LIST_HEAD(&dum_hcd->urbp_list);
@@ -2497,8 +2494,7 @@ static int dummy_start(struct usb_hcd *h
 		return dummy_start_ss(dum_hcd);
 
 	spin_lock_init(&dum_hcd->dum->lock);
-	hrtimer_init(&dum_hcd->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	dum_hcd->timer.function = dummy_timer;
+	timer_setup(&dum_hcd->timer, dummy_timer, 0);
 	dum_hcd->rh_state = DUMMY_RH_RUNNING;
 
 	INIT_LIST_HEAD(&dum_hcd->urbp_list);
@@ -2517,11 +2513,8 @@ static int dummy_start(struct usb_hcd *h
 
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


