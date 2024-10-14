Return-Path: <linux-kernel+bounces-364576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9B5199D65E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 20:21:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 657291F2364C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 18:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F0DD1C8785;
	Mon, 14 Oct 2024 18:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="fvmtf3O3"
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540341AAE27
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 18:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728930107; cv=none; b=IN8Z6IiwZ3FF1/TnCcpj0FnQ78K9tpfMxPEe69Jb81/XZYq1XSFybEEMe2yvj7nJzQWoKDNDSEls7/MJsow3Y1EhLnvSQQIi/f+Xd+X2jEim9V57C9CcKBK73067m4glcbpwR9+xs/hk9y9IiwFhiUPj3au3p4cInVXS647OQnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728930107; c=relaxed/simple;
	bh=XR07Yf7roWNBWp/nyz6tRmVGe+BORCricu8ycK2qGHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DMOCneWRLHjLMtXtOVv/wQTv09L7rtIWTstxzk0/v44ip34CjSvujPKniECTR1H5E6HyAzOQuJkf7hC4pNiYHerNA3hSrir7C/lAinttA+WWGPlLP+5J786bCG56KXrv63W/o79FdqHXm9lYzbrzd0S93Tb1tqc+LlKcHsS5IXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=fvmtf3O3; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7afcf0625a9so519495385a.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 11:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1728930104; x=1729534904; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5IcQOOu0vI610jm6RHmNZ/OyosZ0GqIFeJ5g3QAiL+U=;
        b=fvmtf3O3iZtFiNrDSCTI2baIGiWiFdUJqBkGwUZP8dmlJJ6f5yKpABfAfWx3I+90Yn
         ttazvQfA2DElvxhEatXx/AUBEH+n6YgnLPy249W8mJbA+3JBxKQR4U3Otrs+nzu4UXsi
         XrS7PczogaGKzlgZFIm6ug6x4rGU9depaIkDjMoAukHvcY4a9c/i0eVTUIzlVpq8vAt8
         Cu5VeF514q6Mp7Uo0/oiFkwnrA+BG9vH6G7CxLAQcoSG0y9rIe6Ozy662lWzymX690yH
         zXA4mz7IEpPshAy0lEXKq89Lc54wJc3QhsAUbcm6MBK3zISZCzL+FDUpQibaChblT197
         yRMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728930104; x=1729534904;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5IcQOOu0vI610jm6RHmNZ/OyosZ0GqIFeJ5g3QAiL+U=;
        b=RS4DC8x5bJJgE9AsuMNw2D+Juhp8HiK+Ml6nke/LDIoq3mlIXK/wz40ynU/uMZwWMJ
         PAsDYmkEFI3qVgsScBxl2BL8ztKwnZugLt1QIjZ95/auBidVM0S4/PoITCpUmJV8YKO7
         97vrLfD9HyvdVO53ZpA81DL0iNstlDukBVGX1jVkVyR5kPJiV3WsLs/gJxVKSdCVlq5V
         lcWUaz1YaLq7tH2ZyICNiuUg9O/faio82IPVBxAd+Y5g6S7XlmeXmrVHbGmeGdgpZoIC
         JKs6hynLHwrbYMVn1SXcIIWXfDFctFVVDCvJSTmfQPueoZAVOBWmhmMAZzf9axic/fsx
         BvVQ==
X-Gm-Message-State: AOJu0YxhiFCuSuF/QYF7jn1rNLiOfo1ejOPc40wTSEjP35zLPlemhr0Q
	l40gPbX0WRhYjbZc5XDsK5/39GOVY9Ur87u6MQvowPTOOw6WOvBsKgHdiYFMhkmLhr3AKuZ/Kt0
	=
X-Google-Smtp-Source: AGHT+IEZfFdIQP6xIPH7coh6zdaKCsMxl/O+LrrDIes83D8ujk205nK510P/wN+nH+H2g7CShKaz8Q==
X-Received: by 2002:a05:620a:40d3:b0:79f:9fa:8224 with SMTP id af79cd13be357-7b120fc4bfcmr1594756685a.36.1728930104177;
        Mon, 14 Oct 2024 11:21:44 -0700 (PDT)
Received: from rowland.harvard.edu ([2601:19b:681:fd10::267d])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b1148de068sm438829285a.50.2024.10.14.11.21.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 11:21:43 -0700 (PDT)
Date: Mon, 14 Oct 2024 14:21:40 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: syzbot <syzbot+f342ea16c9d06d80b585@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [usb?] INFO: task hung in usb_port_suspend
Message-ID: <6f7bdad6-d266-45c6-ad2d-2d0b1c33e4a6@rowland.harvard.edu>
References: <f1a79484-2ee0-4160-a2f0-dbfa7b90eece@rowland.harvard.edu>
 <670d52c2.050a0220.23975.026c.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <670d52c2.050a0220.23975.026c.GAE@google.com>

On Mon, Oct 14, 2024 at 10:20:02AM -0700, syzbot wrote:
> Hello,
> 
> syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Oops, I based that on the wrong patch.  Trying again...

Alan Stern

#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing

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
@@ -257,6 +257,8 @@ struct dummy_hcd {
 	unsigned			active:1;
 	unsigned			old_active:1;
 	unsigned			resuming:1;
+
+	bool				alanflag;
 };
 
 struct dummy {
@@ -1304,7 +1306,7 @@ static int dummy_urb_enqueue(
 
 	/* kick the scheduler, it'll do the rest */
 	if (!hrtimer_active(&dum_hcd->timer))
-		hrtimer_start(&dum_hcd->timer, ns_to_ktime(DUMMY_TIMER_INT_NSECS),
+		hrtimer_start(&dum_hcd->timer, DUMMY_INT_KTIME,
 				HRTIMER_MODE_REL_SOFT);
 
  done:
@@ -1325,9 +1327,15 @@ static int dummy_urb_dequeue(struct usb_
 
 	rc = usb_hcd_check_unlink_urb(hcd, urb, status);
 	if (!rc && dum_hcd->rh_state != DUMMY_RH_RUNNING &&
-			!list_empty(&dum_hcd->urbp_list))
-		hrtimer_start(&dum_hcd->timer, ns_to_ktime(0), HRTIMER_MODE_REL_SOFT);
-
+			!list_empty(&dum_hcd->urbp_list)) {
+		dev_info(dummy_dev(dum_hcd), "Dequeue restart %p\n", urb);
+		hrtimer_start(&dum_hcd->timer, DUMMY_INT_KTIME,
+				HRTIMER_MODE_REL_SOFT);
+	} else {
+		dev_info(dummy_dev(dum_hcd), "Dequeue norestart: %d %p active %d\n",
+				rc, urb, hrtimer_active(&dum_hcd->timer));
+	}
+	dum_hcd->alanflag = true;
 	spin_unlock_irqrestore(&dum_hcd->dum->lock, flags);
 	return rc;
 }
@@ -1813,6 +1821,8 @@ static enum hrtimer_restart dummy_timer(
 
 	/* look at each urb queued by the host side driver */
 	spin_lock_irqsave(&dum->lock, flags);
+	if (dum_hcd->alanflag)
+		dev_info(dummy_dev(dum_hcd), "Timer handler\n");
 
 	if (!dum_hcd->udev) {
 		dev_err(dummy_dev(dum_hcd),
@@ -1984,6 +1994,8 @@ return_urb:
 			ep->already_seen = ep->setup_stage = 0;
 
 		usb_hcd_unlink_urb_from_ep(dummy_hcd_to_hcd(dum_hcd), urb);
+		if (dum_hcd->alanflag)
+			dev_info(dummy_dev(dum_hcd), "Giveback %p\n", urb);
 		spin_unlock(&dum->lock);
 		usb_hcd_giveback_urb(dummy_hcd_to_hcd(dum_hcd), urb, status);
 		spin_lock(&dum->lock);
@@ -1995,11 +2007,11 @@ return_urb:
 		usb_put_dev(dum_hcd->udev);
 		dum_hcd->udev = NULL;
 	} else if (dum_hcd->rh_state == DUMMY_RH_RUNNING) {
-		/* want a 1 msec delay here */
-		hrtimer_start(&dum_hcd->timer, ns_to_ktime(DUMMY_TIMER_INT_NSECS),
+		hrtimer_start(&dum_hcd->timer, DUMMY_INT_KTIME,
 				HRTIMER_MODE_REL_SOFT);
 	}
 
+	dum_hcd->alanflag = false;
 	spin_unlock_irqrestore(&dum->lock, flags);
 
 	return HRTIMER_NORESTART;
@@ -2391,7 +2403,8 @@ static int dummy_bus_resume(struct usb_h
 		dum_hcd->rh_state = DUMMY_RH_RUNNING;
 		set_link_state(dum_hcd);
 		if (!list_empty(&dum_hcd->urbp_list))
-			hrtimer_start(&dum_hcd->timer, ns_to_ktime(0), HRTIMER_MODE_REL_SOFT);
+			hrtimer_start(&dum_hcd->timer, DUMMY_INT_KTIME,
+					HRTIMER_MODE_REL_SOFT);
 		hcd->state = HC_STATE_RUNNING;
 	}
 	spin_unlock_irq(&dum_hcd->dum->lock);

