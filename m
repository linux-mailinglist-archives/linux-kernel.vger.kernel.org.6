Return-Path: <linux-kernel+bounces-364820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EB7699D9D8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 00:38:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A0D0B21D84
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 22:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 529451D5AD8;
	Mon, 14 Oct 2024 22:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="Yvpegfnz"
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B85A1D31AF
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 22:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728945519; cv=none; b=rmKSICExMZLMTp/Fizmx3Q3PLr2vd36w1TqccNSIlAifqtTk6gvuKFAO55FIBzzIPsoxFK0KRHgZsS4BGlHeCxI9rS09990ArEqNPbxExsOr12SDk6bntQBX0gZPg6/kZpMScpESS1gtfdTdux/tfotklZYjgiAgbI/hvkhp9F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728945519; c=relaxed/simple;
	bh=rZX+S+qAjlcCuNV4zhkfDLlYh/dPDT4D/9JOYTwkpmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T9AJGhhrpB+rVCZbrA9DBBaV8/LQhabr43Ka9KucB+Tjec8JMuB6u6+YXgS2ncjAn2XzZlOO6rdNx6Mm6k/InDU9inocvxYVn3xTyoy0hORp0Ma0oImIQuzCoPx8WJ/E7vlIx147mQ8DMdKtFPrzpOXektSiruVcaLyCh5MATro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=Yvpegfnz; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7afcd322cabso438380785a.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 15:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1728945516; x=1729550316; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dDxLrTOjtztTPOdPfS/2HucdWvOPHnw6CLT4pCaqd24=;
        b=YvpegfnzPCdDF/V9ajmXR9blNjcPmxKUghUHkY+vkpXlaxISur9MshYty8fXaV4Ly8
         1MDEpw/FhneQHS49gxtKyQ/3ysmpz9iyaZToLymzUxgGq6XbfvvX15x2PSbinEnbiQ0V
         MCzixTTqEegPOCoz8W+HFuoXGjJLuXMmUWQLj0old0gNOW4dFbQNx/FEOK3GXR2HUmNJ
         H6Y2078HYFGR6KVn66wohgwOtIpKga45MrNB+WserrGhakemkUWIDO6lecwdzJ+Abs6x
         Wd99Xxyf69tFpAIo5ho3s8ja0tSmGbULV08cRwIRpZa+DlziDidkLHlV1R14URmGfbD2
         Wyjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728945516; x=1729550316;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dDxLrTOjtztTPOdPfS/2HucdWvOPHnw6CLT4pCaqd24=;
        b=InTDzRno+suJI5yi11KkaibRfhe33Cld+SFkElSw/VZ6n41026+i9A7fzoYZJMus/t
         /q5ALjhfyDS1YCiQidUXELFsVQXl92DI/k9Xl0GXez5DEQFaXjD9McP7v8t2+5R9ZyFK
         kD6s4WdR1vnIdffCgf8rl7gukyS439UpRu7bxlNTzdkLi0irbSsmbfvOaTDj1JCgNQ7j
         xRbEZA+UBpyDvTb8HV5QtddauuBFevFOGAXczX3MnoMM1/IQsuYtcYIx+42icy6WJSQQ
         ohTgRn5HZhxZZs+7fsx00EQyeV6F4VY2KQFV1NbMTaspdjwaMC4s2F4cRdtVOjDnqPZc
         LIhw==
X-Gm-Message-State: AOJu0YxP82BubHQdr3NWaXu7T4WYOiTauEhEw1+ZhEmofelUJUyhiWmV
	Nhz6VJgXGkvuBjZkHD+aX+pWAFqI315AvMAxqCoo3/A9hJR5cEwh/CAbzSLQHQ==
X-Google-Smtp-Source: AGHT+IHIKwJkYho3CBwfkGcN0GmO2wkLT3O+UXvucd2+jHtDkxqkJQA1Vhwit0y9BzudR9fHQ06U6g==
X-Received: by 2002:a05:620a:141:b0:7b1:2242:e3fc with SMTP id af79cd13be357-7b12242e65emr1141161085a.31.1728945515966;
        Mon, 14 Oct 2024 15:38:35 -0700 (PDT)
Received: from rowland.harvard.edu ([2601:19b:681:fd10::7dde])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b1363c9d24sm2020785a.133.2024.10.14.15.38.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 15:38:35 -0700 (PDT)
Date: Mon, 14 Oct 2024 18:38:32 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: syzbot <syzbot+f342ea16c9d06d80b585@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [usb?] INFO: task hung in usb_port_suspend
Message-ID: <d662ba74-2c02-4298-adfe-f12b3d65471c@rowland.harvard.edu>
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

This line in the console log confirms it:

[  170.681412][ T6529] dummy_hcd dummy_hcd.1: Dequeue norestart: 0 ffff8881067e9700 active 0

Let's add some more debugging info to pin down more closely what's
going wrong.

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
@@ -257,6 +257,9 @@ struct dummy_hcd {
 	unsigned			active:1;
 	unsigned			old_active:1;
 	unsigned			resuming:1;
+
+	bool				alanflag;
+	const char			*alandbg;
 };
 
 struct dummy {
@@ -1303,9 +1306,11 @@ static int dummy_urb_enqueue(
 		urb->error_count = 1;		/* mark as a new urb */
 
 	/* kick the scheduler, it'll do the rest */
-	if (!hrtimer_active(&dum_hcd->timer))
-		hrtimer_start(&dum_hcd->timer, ns_to_ktime(DUMMY_TIMER_INT_NSECS),
+	if (!hrtimer_active(&dum_hcd->timer)) {
+		dum_hcd->alandbg = "s1";
+		hrtimer_start(&dum_hcd->timer, DUMMY_INT_KTIME,
 				HRTIMER_MODE_REL_SOFT);
+	}
 
  done:
 	spin_unlock_irqrestore(&dum_hcd->dum->lock, flags);
@@ -1325,9 +1330,19 @@ static int dummy_urb_dequeue(struct usb_
 
 	rc = usb_hcd_check_unlink_urb(hcd, urb, status);
 	if (!rc && dum_hcd->rh_state != DUMMY_RH_RUNNING &&
-			!list_empty(&dum_hcd->urbp_list))
-		hrtimer_start(&dum_hcd->timer, ns_to_ktime(0), HRTIMER_MODE_REL_SOFT);
-
+			!list_empty(&dum_hcd->urbp_list)) {
+		dev_info(dummy_dev(dum_hcd), "Dequeue restart %p\n", urb);
+		hrtimer_start(&dum_hcd->timer, DUMMY_INT_KTIME,
+				HRTIMER_MODE_REL_SOFT);
+		dum_hcd->alandbg = "s2";
+	} else {
+		dev_info(dummy_dev(dum_hcd), "Dequeue norestart: %d %d %d %p active %d %s\n",
+				rc, dum_hcd->rh_state,
+				list_empty(&dum_hcd->urbp_list), urb,
+				hrtimer_active(&dum_hcd->timer),
+				dum_hcd->alandbg);
+	}
+	dum_hcd->alanflag = true;
 	spin_unlock_irqrestore(&dum_hcd->dum->lock, flags);
 	return rc;
 }
@@ -1813,10 +1828,14 @@ static enum hrtimer_restart dummy_timer(
 
 	/* look at each urb queued by the host side driver */
 	spin_lock_irqsave(&dum->lock, flags);
+	dum_hcd->alandbg = "cb1";
+	if (dum_hcd->alanflag)
+		dev_info(dummy_dev(dum_hcd), "Timer handler\n");
 
 	if (!dum_hcd->udev) {
 		dev_err(dummy_dev(dum_hcd),
 				"timer fired with no URBs pending?\n");
+		dum_hcd->alandbg = "cb2";
 		spin_unlock_irqrestore(&dum->lock, flags);
 		return HRTIMER_NORESTART;
 	}
@@ -1984,6 +2003,8 @@ return_urb:
 			ep->already_seen = ep->setup_stage = 0;
 
 		usb_hcd_unlink_urb_from_ep(dummy_hcd_to_hcd(dum_hcd), urb);
+		if (dum_hcd->alanflag)
+			dev_info(dummy_dev(dum_hcd), "Giveback %p\n", urb);
 		spin_unlock(&dum->lock);
 		usb_hcd_giveback_urb(dummy_hcd_to_hcd(dum_hcd), urb, status);
 		spin_lock(&dum->lock);
@@ -1994,12 +2015,15 @@ return_urb:
 	if (list_empty(&dum_hcd->urbp_list)) {
 		usb_put_dev(dum_hcd->udev);
 		dum_hcd->udev = NULL;
+		dum_hcd->alandbg = "cb3";
 	} else if (dum_hcd->rh_state == DUMMY_RH_RUNNING) {
-		/* want a 1 msec delay here */
-		hrtimer_start(&dum_hcd->timer, ns_to_ktime(DUMMY_TIMER_INT_NSECS),
+		dum_hcd->alandbg = "scb";
+		hrtimer_start(&dum_hcd->timer, DUMMY_INT_KTIME,
 				HRTIMER_MODE_REL_SOFT);
-	}
+	} else
+		dum_hcd->alandbg = "cb4";
 
+	dum_hcd->alanflag = false;
 	spin_unlock_irqrestore(&dum->lock, flags);
 
 	return HRTIMER_NORESTART;
@@ -2390,8 +2414,11 @@ static int dummy_bus_resume(struct usb_h
 	} else {
 		dum_hcd->rh_state = DUMMY_RH_RUNNING;
 		set_link_state(dum_hcd);
-		if (!list_empty(&dum_hcd->urbp_list))
-			hrtimer_start(&dum_hcd->timer, ns_to_ktime(0), HRTIMER_MODE_REL_SOFT);
+		if (!list_empty(&dum_hcd->urbp_list)) {
+			dum_hcd->alandbg = "s3";
+			hrtimer_start(&dum_hcd->timer, DUMMY_INT_KTIME,
+					HRTIMER_MODE_REL_SOFT);
+			}
 		hcd->state = HC_STATE_RUNNING;
 	}
 	spin_unlock_irq(&dum_hcd->dum->lock);
@@ -2490,6 +2517,7 @@ static int dummy_start(struct usb_hcd *h
 {
 	struct dummy_hcd	*dum_hcd = hcd_to_dummy_hcd(hcd);
 
+	dum_hcd->alandbg = "i";
 	/*
 	 * HOST side init ... we emulate a root hub that'll only ever
 	 * talk to one device (the gadget side).  Also appears in sysfs,
@@ -2521,6 +2549,7 @@ static void dummy_stop(struct usb_hcd *h
 {
 	struct dummy_hcd	*dum_hcd = hcd_to_dummy_hcd(hcd);
 
+	dum_hcd->alandbg = "can";
 	hrtimer_cancel(&dum_hcd->timer);
 	device_remove_file(dummy_dev(dum_hcd), &dev_attr_urbs);
 	dev_info(dummy_dev(dum_hcd), "stopped\n");

