Return-Path: <linux-kernel+bounces-366002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A358A99EF64
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 16:23:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 322B51F26968
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 14:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C2E71B21AE;
	Tue, 15 Oct 2024 14:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="bPSRGPlh"
Received: from mail-qt1-f195.google.com (mail-qt1-f195.google.com [209.85.160.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4FA1B2190
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 14:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729002174; cv=none; b=k2nMiHYd/mtWsVXYXBU1cFymwK8jNIYS3xmKC8iE1ekJ6Ss8ZTOMdtVblVEZQ8TBHxDe1mEwGqd/Mf5W3vZNYK7a+I9XEKJ3GZZOH4AA5c2Dgvr5ZUilJVAHW6q0NMWiz04UUPDhXYHrAenBcVprELG7wu0E/tF4XdLUq1Xk2qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729002174; c=relaxed/simple;
	bh=4u3qgZyM+Q7kIt2lxt4kT2bkL3UXmztsY91i8UJeVH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CgaB8w3lh+/eRW1hfntkY/YznvR6TryJHcR2hPFhXiIVdLHzdG0IpVqpIFzJ7V/T2iG93sBj7jDY6Oe+aiI4IEkedyWCmpVwbr6MB6ov97r2l1esgTPK94aSot4SVnGnILX8F1I4oq+cr8NMzGOSfu4uMD543WiP9z1OKqzYSnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=bPSRGPlh; arc=none smtp.client-ip=209.85.160.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qt1-f195.google.com with SMTP id d75a77b69052e-46045199e4dso59608261cf.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 07:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1729002171; x=1729606971; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mtaywtD8FtBBxtFmOw75hrMWs/bJcHjdQ2KQnYpTH78=;
        b=bPSRGPlh3a7nVhUc7ioCJrRonG3YSzRYBrUgMPqeVRCn1wlN0Bpb0gqg411PRBbFJR
         4yER6vLF/NAk1+6WPY+9yymGyJVCvwJq8YfL5Fz9ywMVbZMJdxdAXridiXzKLaCa+JHz
         fAM5zOy2UGCozODkVMJ45Nxqfrkru/e+fDG2YfyOaRPjqUdUvavJNEbzNI6tPGynQtsm
         9Y1VKbN6UpCthBHhFGFhYx+OFbNNrzHd7t9IXvizjuFoNPd6YlaNtsRNAMOoRX7+h1MA
         ZDBjleMXtiT+ahMXuF5lvz1kcM+DTjEpB2UqsAgmcfujj5Jjc5YcnHDm82y4Em/Ue1If
         Uvrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729002171; x=1729606971;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mtaywtD8FtBBxtFmOw75hrMWs/bJcHjdQ2KQnYpTH78=;
        b=rIT+oXRLeKxtSxVETXU3WASo7jTGwAzq3XJE2TOA+XWhEe5MwWz9Pji/68/7W1a3H9
         TgGlycpy0ZojTlsMbsHrPhFJPHYnvv4RRyNljHWsJRf9MmxlbWTF1J4AOWWgJNfAli3R
         rMJ6nuxYazf4/VTivEQgpKEApdkn91PR8E4Bf6Zn3oCU0RxoNbn6yCeyy3lHrJZpIjhU
         PYbw2xDIyre0VMueP3WpvZu+CykUHjrDYWNbtx4DYfEvo5ndfrMxt4M3ITObJsK6BX2A
         yR/N+mmKXT5R4yzkCrwKBkPWhpuDKRU0DN2JOT2wW4MjpCRN7wcNKnutX+x8ZG0zVfVV
         aS6A==
X-Forwarded-Encrypted: i=1; AJvYcCWcYuUxc0GNMQn6M+Pdx+qJxtnJyHOpJmY6FmgDJJM/HqJfF7HJUi60QzqZrvIvkS9+T9OcBwT99tRKWms=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9fuAEVSmOCz63mQmGVqhqC18Dk1uCshXJFdRapeTgbxfr5d9j
	CRUyssQmQhEclJLcrUOKZXEljLs927c39DsgkpPCg2TtvBoypMB6qP7jyIq8wg==
X-Google-Smtp-Source: AGHT+IGW7uRY87XHdnKU1SVqgZZDs/qHLhPtwKgQnBTJYONAi0ig/rGkwVjj/oqkVIUJRhaJ1Ow3VQ==
X-Received: by 2002:ac8:5a11:0:b0:45d:8950:c02 with SMTP id d75a77b69052e-460583fc5e0mr208183881cf.22.1729002171210;
        Tue, 15 Oct 2024 07:22:51 -0700 (PDT)
Received: from rowland.harvard.edu ([2607:fb60:2501:2805:c6d5:fe22:7fa3:ec54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-460815dd392sm5212761cf.39.2024.10.15.07.22.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 07:22:50 -0700 (PDT)
Date: Tue, 15 Oct 2024 10:22:47 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: syzbot <syzbot+f342ea16c9d06d80b585@syzkaller.appspotmail.com>
Cc: USB mailing list <linux-usb@vger.kernel.org>,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [usb?] INFO: task hung in usb_port_suspend
Message-ID: <6ae97ef8-bcbe-448a-9276-ad21631e43dc@rowland.harvard.edu>
References: <6f7bdad6-d266-45c6-ad2d-2d0b1c33e4a6@rowland.harvard.edu>
 <670d65fa.050a0220.3e960.00c1.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <670d65fa.050a0220.3e960.00c1.GAE@google.com>

On Mon, Oct 14, 2024 at 11:42:02AM -0700, syzbot wrote:
> Hello,
> 
> syzbot has tested the proposed patch but the reproducer is still triggering an issue:

Let's try to get some more debugging info.

Alan Stern

#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git v6.12-rc3

Index: usb-devel/drivers/usb/gadget/udc/dummy_hcd.c
===================================================================
--- usb-devel.orig/drivers/usb/gadget/udc/dummy_hcd.c
+++ usb-devel/drivers/usb/gadget/udc/dummy_hcd.c
@@ -50,7 +50,7 @@
 #define POWER_BUDGET	500	/* in mA; use 8 for low-power port testing */
 #define POWER_BUDGET_3	900	/* in mA */
 
-#define DUMMY_TIMER_INT_NSECS	125000 /* 1 microframe */
+#define DUMMY_INT_KTIME	ns_to_ktime(125000)	 /* 1 microframe */
 
 static const char	driver_name[] = "dummy_hcd";
 static const char	driver_desc[] = "USB Host+Gadget Emulator";
@@ -257,6 +257,9 @@ struct dummy_hcd {
 	unsigned			active:1;
 	unsigned			old_active:1;
 	unsigned			resuming:1;
+
+	int				alanflag;
+	const char			*alanstr;
 };
 
 struct dummy {
@@ -323,6 +326,14 @@ static inline struct dummy *gadget_dev_t
 	return container_of(dev, struct dummy, gadget.dev);
 }
 
+void alandbg(struct dummy_hcd *dum_hcd, const char *str);
+void alandbg(struct dummy_hcd *dum_hcd, const char *str)
+{
+	dum_hcd->alanstr = str;
+	if (dum_hcd->alanflag)
+		dev_info(dummy_dev(dum_hcd), str);
+}
+
 /*-------------------------------------------------------------------------*/
 
 /* DEVICE/GADGET SIDE UTILITY ROUTINES */
@@ -1303,9 +1314,11 @@ static int dummy_urb_enqueue(
 		urb->error_count = 1;		/* mark as a new urb */
 
 	/* kick the scheduler, it'll do the rest */
-	if (!hrtimer_active(&dum_hcd->timer))
-		hrtimer_start(&dum_hcd->timer, ns_to_ktime(DUMMY_TIMER_INT_NSECS),
+	if (!hrtimer_active(&dum_hcd->timer)) {
+		alandbg(dum_hcd, "start1");
+		hrtimer_start(&dum_hcd->timer, DUMMY_INT_KTIME,
 				HRTIMER_MODE_REL_SOFT);
+	}
 
  done:
 	spin_unlock_irqrestore(&dum_hcd->dum->lock, flags);
@@ -1325,9 +1338,19 @@ static int dummy_urb_dequeue(struct usb_
 
 	rc = usb_hcd_check_unlink_urb(hcd, urb, status);
 	if (!rc && dum_hcd->rh_state != DUMMY_RH_RUNNING &&
-			!list_empty(&dum_hcd->urbp_list))
-		hrtimer_start(&dum_hcd->timer, ns_to_ktime(0), HRTIMER_MODE_REL_SOFT);
-
+			!list_empty(&dum_hcd->urbp_list)) {
+		dev_info(dummy_dev(dum_hcd), "Dequeue restart %p\n", urb);
+		hrtimer_start(&dum_hcd->timer, DUMMY_INT_KTIME,
+				HRTIMER_MODE_REL_SOFT);
+		alandbg(dum_hcd, "start2");
+	} else {
+		dev_info(dummy_dev(dum_hcd), "Dequeue norestart: %d %d %d %p active %d %s\n",
+				rc, dum_hcd->rh_state,
+				list_empty(&dum_hcd->urbp_list), urb,
+				hrtimer_active(&dum_hcd->timer),
+				dum_hcd->alanstr);
+	}
+	++dum_hcd->alanflag;
 	spin_unlock_irqrestore(&dum_hcd->dum->lock, flags);
 	return rc;
 }
@@ -1813,10 +1836,12 @@ static enum hrtimer_restart dummy_timer(
 
 	/* look at each urb queued by the host side driver */
 	spin_lock_irqsave(&dum->lock, flags);
+	alandbg(dum_hcd, "handler1");
 
 	if (!dum_hcd->udev) {
 		dev_err(dummy_dev(dum_hcd),
 				"timer fired with no URBs pending?\n");
+		alandbg(dum_hcd, "handler2");
 		spin_unlock_irqrestore(&dum->lock, flags);
 		return HRTIMER_NORESTART;
 	}
@@ -1984,6 +2009,8 @@ return_urb:
 			ep->already_seen = ep->setup_stage = 0;
 
 		usb_hcd_unlink_urb_from_ep(dummy_hcd_to_hcd(dum_hcd), urb);
+		if (dum_hcd->alanflag)
+			dev_info(dummy_dev(dum_hcd), "Giveback %p\n", urb);
 		spin_unlock(&dum->lock);
 		usb_hcd_giveback_urb(dummy_hcd_to_hcd(dum_hcd), urb, status);
 		spin_lock(&dum->lock);
@@ -1994,12 +2021,17 @@ return_urb:
 	if (list_empty(&dum_hcd->urbp_list)) {
 		usb_put_dev(dum_hcd->udev);
 		dum_hcd->udev = NULL;
+		alandbg(dum_hcd, "handler3");
 	} else if (dum_hcd->rh_state == DUMMY_RH_RUNNING) {
-		/* want a 1 msec delay here */
-		hrtimer_start(&dum_hcd->timer, ns_to_ktime(DUMMY_TIMER_INT_NSECS),
+		alandbg(dum_hcd, "handler-start");
+		hrtimer_start(&dum_hcd->timer, DUMMY_INT_KTIME,
 				HRTIMER_MODE_REL_SOFT);
+	} else {
+		alandbg(dum_hcd, "handler4");
 	}
 
+	if (dum_hcd->alanflag > 0)
+		--dum_hcd->alanflag;
 	spin_unlock_irqrestore(&dum->lock, flags);
 
 	return HRTIMER_NORESTART;
@@ -2390,8 +2422,11 @@ static int dummy_bus_resume(struct usb_h
 	} else {
 		dum_hcd->rh_state = DUMMY_RH_RUNNING;
 		set_link_state(dum_hcd);
-		if (!list_empty(&dum_hcd->urbp_list))
-			hrtimer_start(&dum_hcd->timer, ns_to_ktime(0), HRTIMER_MODE_REL_SOFT);
+		if (!list_empty(&dum_hcd->urbp_list)) {
+			alandbg(dum_hcd, "start3");
+			hrtimer_start(&dum_hcd->timer, DUMMY_INT_KTIME,
+					HRTIMER_MODE_REL_SOFT);
+			}
 		hcd->state = HC_STATE_RUNNING;
 	}
 	spin_unlock_irq(&dum_hcd->dum->lock);
@@ -2490,6 +2525,7 @@ static int dummy_start(struct usb_hcd *h
 {
 	struct dummy_hcd	*dum_hcd = hcd_to_dummy_hcd(hcd);
 
+	dum_hcd->alanstr = "init";
 	/*
 	 * HOST side init ... we emulate a root hub that'll only ever
 	 * talk to one device (the gadget side).  Also appears in sysfs,
@@ -2521,6 +2557,7 @@ static void dummy_stop(struct usb_hcd *h
 {
 	struct dummy_hcd	*dum_hcd = hcd_to_dummy_hcd(hcd);
 
+	alandbg(dum_hcd, "cancel");
 	hrtimer_cancel(&dum_hcd->timer);
 	device_remove_file(dummy_dev(dum_hcd), &dev_attr_urbs);
 	dev_info(dummy_dev(dum_hcd), "stopped\n");

