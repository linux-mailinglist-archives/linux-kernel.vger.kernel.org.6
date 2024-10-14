Return-Path: <linux-kernel+bounces-364422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DE4A99D46F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 18:14:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA5E01F233F6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 16:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D79E81AC8AE;
	Mon, 14 Oct 2024 16:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="fL+jI8Ft"
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6504314AA9
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 16:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728922489; cv=none; b=Fjw7KEtMXJsR9suj6GWmoF7UA4dO5fhKe2Oaej1P3YtsmIj+J86S/TA94bNpTBaijTHCOQ+UFTuy89493cbOkb+XTS8i/riqAOft4PMlER9Q646AofJij3cN0GA5+uu62ygbb74zizY8ZksyyoOB7VRTd9Ckt4rQR/xBGFWGIXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728922489; c=relaxed/simple;
	bh=d+i7rz0v/lYhzDT8S7U2kztGhbofW2nOLWBFt6tMbxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qwJtmwm5fxCiBWLhk+QDkFbJVELPTNgSmZAaSSaGG5SLXBB6779PW1ZjUdEXd6UJSfEXzuZjFHpAYNaquQWX7E8rcg7+seVoGEQnq/JcSCprxx3h/U1Ak3NPVGCM3bGCo6dynUV68VqONERxkCUYUI89zKP3Qe+3Y5ohYxbKrfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=fL+jI8Ft; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7afcf96affaso229436985a.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 09:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1728922486; x=1729527286; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8+z5rpFItk6hQgTy6bORhF+SgqBTinir6Gfegnb3yHE=;
        b=fL+jI8FtLRh458X5XbkE/GpoaSVmrlshbFy8qRziGZm6qV/D5YLOyu3tTFiTsBcjta
         yihlPsIhM4kleN2Q5zxdnRWr31RNdk8NK1olrIdRt0TXPReJvENkjQMeSykWW3ZOrcP5
         nmTKaoZ3Q5Gchn55uSL+WVCckI1zgDKeI6nq1TY56hfNKGK+aiwri6d5ShEhVnt/H8WT
         6wz4AvlBLnISKUcXmCEbsVmSAF1UguiBxF1siwEkTmoJqYCQB8Dp1lVBrdRNW9PkfMNT
         4tXDAQhayJ2u3ySkm5w5OCvIr78zHWcGTulgr0VHCIIOgKJIJxwGX8LbExKqQHsnfvqu
         O0aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728922486; x=1729527286;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8+z5rpFItk6hQgTy6bORhF+SgqBTinir6Gfegnb3yHE=;
        b=BvM+MtBjlMJSiH3beeEDxvtM2aWHw44rFlZChEP00rgteYDDt17J8nhTlUmK6qedjE
         LlVOv6zHjfEixksp55FtQkMhP/QCWmmN3vyb5aqVXbwlVXrJECAwwOWfrChprP7YMMIh
         OFWY0wtQhbkfEF1OeP9wShPIMnxJEyFwO3ASg/S++Ws61ig5+ee+NmiYBsI5FsiMb2df
         O9q9wwak8Wtq60DVe65nKLcnlIabRTxjGiid9IEFk5btWDcpc2GJEsE4waMQiRkadFWw
         GYjuQizprMbLZCkfgacrQE6jP8QN9o8ROE5uFwAZbdsbS6Yo+WEegvjAewFXgCi40tuQ
         r2Cw==
X-Gm-Message-State: AOJu0Yw7q3OjwEvueDnfQzFqoK6X8E3V6ncHidl7biXgzI07K19xEbl/
	T+Iri5zLlGb1fiGRXeCNECTTXrIRyYjVve/cCEuG8GTZnHsOKrtRBXYwfIaiOFT2RZoypqT/qqI
	=
X-Google-Smtp-Source: AGHT+IFiWvyQHPw52VbxejgOs1jzzUybj5lACemxxUJIvDLtI0pYTAU28T0GKhme31JWd+fsvKQJrQ==
X-Received: by 2002:a05:620a:24c9:b0:7b1:10ba:2ac0 with SMTP id af79cd13be357-7b11a37c2acmr1955757685a.35.1728922486285;
        Mon, 14 Oct 2024 09:14:46 -0700 (PDT)
Received: from rowland.harvard.edu ([2601:19b:681:fd10::c666])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b1148de09fsm436477685a.49.2024.10.14.09.14.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 09:14:45 -0700 (PDT)
Date: Mon, 14 Oct 2024 12:14:43 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: syzbot <syzbot+f342ea16c9d06d80b585@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [usb?] INFO: task hung in usb_port_suspend
Message-ID: <f1a79484-2ee0-4160-a2f0-dbfa7b90eece@rowland.harvard.edu>
References: <b9bea8cd-effc-484f-ac46-1644093adffe@rowland.harvard.edu>
 <670c7aaa.050a0220.3e960.004e.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <670c7aaa.050a0220.3e960.004e.GAE@google.com>

On Sun, Oct 13, 2024 at 06:58:02PM -0700, syzbot wrote:
> Hello,
> 
> syzbot has tested the proposed patch and the reproducer did not trigger any issue:

It seems that the problem occurs when the timer isn't active in spite of 
the fact that the root hub is running and there are URBs queued.  But 
this shouldn't happen; I need to find the reason why it does and not 
just work around it.

First make sure that it really is the cause.

Alan Stern

#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git
usb-testing

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
@@ -1301,10 +1303,12 @@ static int dummy_urb_enqueue(
 		dum_hcd->next_frame_urbp = urbp;
 	if (usb_pipetype(urb->pipe) == PIPE_CONTROL)
 		urb->error_count = 1;		/* mark as a new urb */
+	dev_info(dummy_dev(dum_hcd), "Enqueue %p type %d\n", urb,
+		usb_pipetype(urb->pipe));
 
 	/* kick the scheduler, it'll do the rest */
 	if (!hrtimer_active(&dum_hcd->timer))
-		hrtimer_start(&dum_hcd->timer, ns_to_ktime(DUMMY_TIMER_INT_NSECS),
+		hrtimer_start(&dum_hcd->timer, DUMMY_INT_KTIME,
 				HRTIMER_MODE_REL_SOFT);
 
  done:
@@ -1325,9 +1329,15 @@ static int dummy_urb_dequeue(struct usb_
 
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
@@ -1813,6 +1823,10 @@ static enum hrtimer_restart dummy_timer(
 
 	/* look at each urb queued by the host side driver */
 	spin_lock_irqsave(&dum->lock, flags);
+	if (dum_hcd->alanflag) {
+		dum_hcd->alanflag = false;
+		dev_info(dummy_dev(dum_hcd), "Timer handler\n");
+	}
 
 	if (!dum_hcd->udev) {
 		dev_err(dummy_dev(dum_hcd),
@@ -1984,6 +1998,7 @@ return_urb:
 			ep->already_seen = ep->setup_stage = 0;
 
 		usb_hcd_unlink_urb_from_ep(dummy_hcd_to_hcd(dum_hcd), urb);
+		dev_info(dummy_dev(dum_hcd), "Giveback %p\n", urb);
 		spin_unlock(&dum->lock);
 		usb_hcd_giveback_urb(dummy_hcd_to_hcd(dum_hcd), urb, status);
 		spin_lock(&dum->lock);
@@ -1995,8 +2010,7 @@ return_urb:
 		usb_put_dev(dum_hcd->udev);
 		dum_hcd->udev = NULL;
 	} else if (dum_hcd->rh_state == DUMMY_RH_RUNNING) {
-		/* want a 1 msec delay here */
-		hrtimer_start(&dum_hcd->timer, ns_to_ktime(DUMMY_TIMER_INT_NSECS),
+		hrtimer_start(&dum_hcd->timer, DUMMY_INT_KTIME,
 				HRTIMER_MODE_REL_SOFT);
 	}
 
@@ -2391,7 +2405,8 @@ static int dummy_bus_resume(struct usb_h
 		dum_hcd->rh_state = DUMMY_RH_RUNNING;
 		set_link_state(dum_hcd);
 		if (!list_empty(&dum_hcd->urbp_list))
-			hrtimer_start(&dum_hcd->timer, ns_to_ktime(0), HRTIMER_MODE_REL_SOFT);
+			hrtimer_start(&dum_hcd->timer, DUMMY_INT_KTIME,
+					HRTIMER_MODE_REL_SOFT);
 		hcd->state = HC_STATE_RUNNING;
 	}
 	spin_unlock_irq(&dum_hcd->dum->lock);


