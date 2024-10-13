Return-Path: <linux-kernel+bounces-362884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F19D99BAB0
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 20:03:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52608B20FE9
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 18:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAB4E1487E3;
	Sun, 13 Oct 2024 18:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="HsLDe8e5"
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82BB32F5E
	for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2024 18:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728842579; cv=none; b=gJixvV6X1L53t1aV6gJBlytO7d/jbYWUxWnzTgxMCQhBFuDJYZMqKpI/gN+Viq91U5SvvPgYVS6baDtLIrOJbeS+NybQE71hNoj58IJJFj0ajzSVjY1N7q1+YjAeXLZpnJL3vSuuufzOynH8Auy1RHWUQhLc39XpSA2amuR7ygA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728842579; c=relaxed/simple;
	bh=yvzAYY08lrsrWYdWSRrpl7xU9X+yuiNiBpMyXHFOSvw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bivhENOhjHfKQRj/rDFnbrM+KHQvId/fqvgyVTL4FVtuZbIwQWrgM1WeXojuLsYnj2PgN8IYdH1suKu22BsbEpagnhWmyA6ZKTosKmvr6cDrv1ae/OL+W31tAmbskTaWUAmJEVhvIrmWL95aWY0oSvksvqMek9XuvZNDLOzRJYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=HsLDe8e5; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7afcf0625a9so418729185a.0
        for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2024 11:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1728842576; x=1729447376; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jzbcs4JBSNqBkEy18MgzokPzqXLuAN+IENP7NwJBwy0=;
        b=HsLDe8e5Lie70yca+Lr7SjmL007xO8eyJu2fSij/herE435wJ6PkK3U3nbVkDFax+O
         w8utSSBtLr4pl3tc3OcNXni6A7S+pNygDdbPp79fnhdq6Yl/r3yLWyf/dAjqnYSQqN98
         /39GGL2l6iwyKucp39mdpJtE+eUFE9VR2Qne/rcmcoFtrzCF2wzxLzsI7GbdhSvR5QUH
         8eYg/5pY0RIhythTZ9+gketyupF2qkN9xrDNbI2GpmhA91enwfPuAL+xslz8i31a0Pf0
         jdGs3/y4Ad7diDSmmThWHGivYO6CDBa8vmNPanuNs1y27qq6o9hl0TPlybIuMH04283o
         rzPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728842576; x=1729447376;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jzbcs4JBSNqBkEy18MgzokPzqXLuAN+IENP7NwJBwy0=;
        b=jOgeBpOsw/b+kG0IJFPGtQtG+d5UD1hg1EU8KCkxI1xnF15/FaIKyGocw3LtZ1k58D
         HRSeFqkMC39mih00WJRZabKGNF5rcwA00x1k20xTFRIKwgs8zKLo0WjRDS9+3asQLWCD
         /1FsiNMrdOywzm+0JKculDtgRBC9RqRIsJvCqQTvtWH0UVdRtOZ+dupz5mtPSzANjA2w
         yBzFhdTb9IIenIFXETX4zrJmCx0kelNEubTDpwfacxw9ndpaX56t4Y7eY5ksHgOD0eex
         WB+5+/65mnyGaQAKh1SaD8hbRu9eHC3SHYqDACDY+QhJBpB7z1xX62fksjmXYgGf9nRO
         Z6cA==
X-Forwarded-Encrypted: i=1; AJvYcCUOxkx3cus5GQ905kj9mxEhrT2xvEdDZNJZUZwOzDMwtzp4D7AWLKZKm9O85+KExUOYZ0n0fx7DgQNovVo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyM4XINiRQsiDBzqy7d/S8aU612XCnbFGAYoJfmzLPtNMK/Bso2
	2ZEaTiterOV2SSt17fz84TJK/OQx+Pwb3Wo63lyRCKWeCTi9RYBGhZRawnWiAQ==
X-Google-Smtp-Source: AGHT+IEtESLFCqotPyM1PSwE8LG3Crbk52UEyOdRfx4tg0ktLurZiXKSFlOFWy0ip6VeygvlG3rEEw==
X-Received: by 2002:a05:620a:170e:b0:7b1:184f:caba with SMTP id af79cd13be357-7b121006418mr1110810985a.40.1728842576413;
        Sun, 13 Oct 2024 11:02:56 -0700 (PDT)
Received: from rowland.harvard.edu ([2601:19b:681:fd10::267d])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b11497704dsm333523785a.101.2024.10.13.11.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Oct 2024 11:02:55 -0700 (PDT)
Date: Sun, 13 Oct 2024 14:02:52 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: syzbot <syzbot+f342ea16c9d06d80b585@syzkaller.appspotmail.com>
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org, sylv@sylv.io,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [usb?] INFO: task hung in usb_port_suspend
Message-ID: <2329dfa9-ef76-491a-a4aa-277230a0a96a@rowland.harvard.edu>
References: <11dd2a9d-2f1d-4cac-976c-90a1b0ee667e@rowland.harvard.edu>
 <670bf1cd.050a0220.4cbc0.0034.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <670bf1cd.050a0220.4cbc0.0034.GAE@google.com>

On Sun, Oct 13, 2024 at 09:14:05AM -0700, syzbot wrote:
> Hello,
> 
> syzbot has tested the proposed patch and the reproducer did not trigger any issue:

No good.  The console log shows too many prints from the timer handler.  
Let's just print the message when a dequeue is pending.

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
+		dev_info(dummy_dev(dum_hcd), "Dequeue norestart: %d %p\n",
+				rc, urb);
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


