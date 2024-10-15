Return-Path: <linux-kernel+bounces-366568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FA9C99F732
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 21:23:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BAF41F27B1A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 19:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C49BD1B6D0F;
	Tue, 15 Oct 2024 19:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="j24sqayp"
Received: from mail-qt1-f194.google.com (mail-qt1-f194.google.com [209.85.160.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6C61F80CD
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 19:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729020190; cv=none; b=DpkobVmUsj/ICBiwcEc9G9Q6EWiEpRYDgSDgNJ4FYSIVw+ULB8COgEdmiggko8Szxhq90PC5flfNFut8xbJXJtz40kikNUi8UBYe73AUIX+oDstKrnRA1HEKmuOITLMfwzxJjBRE0Z8YdGOivdYZpKF84xQSv/yCTZXpgn/GsXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729020190; c=relaxed/simple;
	bh=nuqVM5Pa10hgz7nFmmFVgpfYVQK/w/7stNQsizNYTCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HLW8wC0ZFs6RrTYV9EhowaTQ12ZkLn4UEGsO5sljB7mlwt5FHupDbwzIZLXq/5WLjTAQBPvdoZ1gWnG1JyvFZmJkYnTbxJ8QdAGgsGvrz3p83J38eFwx3E8yNRe496MSKKU0/HDULTbMF8yeiqTFf3d6tBSgy/owdsz+W+//1w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=j24sqayp; arc=none smtp.client-ip=209.85.160.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qt1-f194.google.com with SMTP id d75a77b69052e-45f07eb6f5fso1732251cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 12:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1729020187; x=1729624987; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=X7dB0pxitQeFgVMBRDLTWgDRQeKiGn5TxSEiu8/oYsk=;
        b=j24sqaypQsHAZpYbBD5eymoPomxCMouELlnwaHUtTAlFX517tTU31ifg1sAmN3GhOW
         FaEkv652ye3abptu3JNUfYYhSKRNiOlC3HiMaa6i0WWXv9Nbbs0tHR1RvdSf3VoJZHPP
         5Z7BnOjQ5T6QBkDBfb/0CGNxrHnKKdQ3qZaHfM0ccVWIVS6ooIsXIMouP9kzhHewKSr8
         n0bzJhcoA4TsZpFTkiaExDoqfIw9Yujti9QQ0w1hau6Omd+gH0ekt7MQRfMwz5OrKKrK
         JwkWCDClbAqlASxe8JAUEYzphVoWUHS+a07NeUksQCLA90xKwiUOku7RHzfuo+nJjTVU
         ADuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729020187; x=1729624987;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X7dB0pxitQeFgVMBRDLTWgDRQeKiGn5TxSEiu8/oYsk=;
        b=tup/VGpOJAgYS8kvx13tBdIYpbAMmFDN6t4jBBEcGIrZICHax0Q1agqm2YJYt7SmET
         w/3+MJ7xIZgtOV9tW2hrTEIJNPypSy35IeI96EaCRsZbsx2kqdirBvBJG/4n4pc311tc
         eOIZ9Au5jkl7/Yq1D+iuHFCBkG/cDMo9Wj6c5Ua18fB1z1kMEKZtc5p6T3w8O0mfdcGA
         8PvTHk0yIejloKDUmLVSD+GobIbNjhjXsUdAtnTuenMKagI+6KOJDuXyzViWtIuvFRwb
         KKQcp+SoWP9tr6pieKL2gJ6s+WePzwOQivxGdr/t5Eq+e8rTcPwl0HGdMQtKp6KzjQZo
         ed/w==
X-Gm-Message-State: AOJu0YxuGpx3pOS3cNyg5W52SjRAvvXp+5M8VGhfT9EdG7nqO6ekpdAw
	hebYzcK28oiv6VdG1WkBi3D1ljG53tJ1PsOhj59AKFGC8WliVCmmsryNlg32TA==
X-Google-Smtp-Source: AGHT+IEVMyd7eXgnEAfRqhwHnQdq3N+kpUIcnL/4s3rKrsYnYBtTrSPgs4TfkC0BqoBAVv/3K1YqoA==
X-Received: by 2002:a05:622a:c4:b0:458:3162:2262 with SMTP id d75a77b69052e-46089ada3f9mr30640441cf.4.1729020186916;
        Tue, 15 Oct 2024 12:23:06 -0700 (PDT)
Received: from rowland.harvard.edu ([2607:fb60:2501:2805:c6d5:fe22:7fa3:ec54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4607d89942csm9261411cf.54.2024.10.15.12.23.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 12:23:06 -0700 (PDT)
Date: Tue, 15 Oct 2024 15:23:03 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: syzbot <syzbot+f342ea16c9d06d80b585@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [usb?] INFO: task hung in usb_port_suspend
Message-ID: <c3d59f87-bb72-46d9-94b8-7441b837bf13@rowland.harvard.edu>
References: <6ae97ef8-bcbe-448a-9276-ad21631e43dc@rowland.harvard.edu>
 <670e820b.050a0220.d5849.0007.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <670e820b.050a0220.d5849.0007.GAE@google.com>

On Tue, Oct 15, 2024 at 07:54:03AM -0700, syzbot wrote:
> Hello,
> 
> syzbot has tested the proposed patch but the reproducer is still triggering an issue:

No good; the console log shows that the timer must have been activated
and then stopped during a period that wasn't printed in the log.  This
next patch tries to print out more of the history.  Will it be enough?

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
@@ -239,6 +239,12 @@ enum dummy_rh_state {
 	DUMMY_RH_RUNNING
 };
 
+struct alaninfo {
+	const char *		str;
+	int			starts, stops;
+};
+#define MAX_INFO	16
+
 struct dummy_hcd {
 	struct dummy			*dum;
 	enum dummy_rh_state		rh_state;
@@ -257,6 +263,10 @@ struct dummy_hcd {
 	unsigned			active:1;
 	unsigned			old_active:1;
 	unsigned			resuming:1;
+
+	struct alaninfo			alaninfo[MAX_INFO];
+	int				alanindex;
+	int				starts, stops;
 };
 
 struct dummy {
@@ -323,6 +333,44 @@ static inline struct dummy *gadget_dev_t
 	return container_of(dev, struct dummy, gadget.dev);
 }
 
+void alandbg(struct dummy_hcd *dum_hcd, const char *str, int type);
+void alandbg(struct dummy_hcd *dum_hcd, const char *str, int type)
+{
+	int			i = dum_hcd->alanindex;
+	struct alaninfo		*info = &dum_hcd->alaninfo[i];
+
+	if (type == 1)
+		++dum_hcd->starts;
+	else if (type == 2)
+		++dum_hcd->stops;
+	info->str = str;
+	info->starts = dum_hcd->starts;
+	info->stops = dum_hcd->stops;
+
+	if (++i >= MAX_INFO)
+		i = 0;
+	dum_hcd->alanindex = i;
+}
+
+void alandump(struct dummy_hcd *dum_hcd);
+void alandump(struct dummy_hcd *dum_hcd)
+{
+	int			i = dum_hcd->alanindex;
+	int			j;
+	struct alaninfo		*info = &dum_hcd->alaninfo[i];
+	char			*p, buf[4 * 24];
+
+	p = buf;
+	for (j = 0; j < 4; ++j) {
+		if (--i < 0)
+			i = MAX_INFO - 1;
+		info = &dum_hcd->alaninfo[i];
+		p += sprintf(p, "%s %d %d  ",
+				info->str, info->starts, info->stops);
+	}
+	dev_info(dummy_dev(dum_hcd), "%s\n", p);
+}
+
 /*-------------------------------------------------------------------------*/
 
 /* DEVICE/GADGET SIDE UTILITY ROUTINES */
@@ -1303,9 +1351,11 @@ static int dummy_urb_enqueue(
 		urb->error_count = 1;		/* mark as a new urb */
 
 	/* kick the scheduler, it'll do the rest */
-	if (!hrtimer_active(&dum_hcd->timer))
-		hrtimer_start(&dum_hcd->timer, ns_to_ktime(DUMMY_TIMER_INT_NSECS),
+	if (!hrtimer_active(&dum_hcd->timer)) {
+		alandbg(dum_hcd, "start1", 1);
+		hrtimer_start(&dum_hcd->timer, DUMMY_INT_KTIME,
 				HRTIMER_MODE_REL_SOFT);
+	}
 
  done:
 	spin_unlock_irqrestore(&dum_hcd->dum->lock, flags);
@@ -1325,9 +1375,17 @@ static int dummy_urb_dequeue(struct usb_
 
 	rc = usb_hcd_check_unlink_urb(hcd, urb, status);
 	if (!rc && dum_hcd->rh_state != DUMMY_RH_RUNNING &&
-			!list_empty(&dum_hcd->urbp_list))
-		hrtimer_start(&dum_hcd->timer, ns_to_ktime(0), HRTIMER_MODE_REL_SOFT);
-
+			!list_empty(&dum_hcd->urbp_list)) {
+		hrtimer_start(&dum_hcd->timer, DUMMY_INT_KTIME,
+				HRTIMER_MODE_REL_SOFT);
+		alandbg(dum_hcd, "start2", 1);
+	} else {
+		int active = hrtimer_active(&dum_hcd->timer);
+		dev_info(dummy_dev(dum_hcd), "Dequeue norestart: %d %d active %d\n",
+				rc, list_empty(&dum_hcd->urbp_list), active);
+		if (rc == 0 && !active)
+			alandump(dum_hcd);
+	}
 	spin_unlock_irqrestore(&dum_hcd->dum->lock, flags);
 	return rc;
 }
@@ -1813,10 +1871,12 @@ static enum hrtimer_restart dummy_timer(
 
 	/* look at each urb queued by the host side driver */
 	spin_lock_irqsave(&dum->lock, flags);
+	alandbg(dum_hcd, "handler1", 0);
 
 	if (!dum_hcd->udev) {
 		dev_err(dummy_dev(dum_hcd),
 				"timer fired with no URBs pending?\n");
+		alandbg(dum_hcd, "handler2", 2);
 		spin_unlock_irqrestore(&dum->lock, flags);
 		return HRTIMER_NORESTART;
 	}
@@ -1994,10 +2054,13 @@ return_urb:
 	if (list_empty(&dum_hcd->urbp_list)) {
 		usb_put_dev(dum_hcd->udev);
 		dum_hcd->udev = NULL;
+		alandbg(dum_hcd, "handler3", 2);
 	} else if (dum_hcd->rh_state == DUMMY_RH_RUNNING) {
-		/* want a 1 msec delay here */
-		hrtimer_start(&dum_hcd->timer, ns_to_ktime(DUMMY_TIMER_INT_NSECS),
+		alandbg(dum_hcd, "handler-start", 1);
+		hrtimer_start(&dum_hcd->timer, DUMMY_INT_KTIME,
 				HRTIMER_MODE_REL_SOFT);
+	} else {
+		alandbg(dum_hcd, "handler4", 2);
 	}
 
 	spin_unlock_irqrestore(&dum->lock, flags);
@@ -2390,8 +2453,11 @@ static int dummy_bus_resume(struct usb_h
 	} else {
 		dum_hcd->rh_state = DUMMY_RH_RUNNING;
 		set_link_state(dum_hcd);
-		if (!list_empty(&dum_hcd->urbp_list))
-			hrtimer_start(&dum_hcd->timer, ns_to_ktime(0), HRTIMER_MODE_REL_SOFT);
+		if (!list_empty(&dum_hcd->urbp_list)) {
+			alandbg(dum_hcd, "start3", 1);
+			hrtimer_start(&dum_hcd->timer, DUMMY_INT_KTIME,
+					HRTIMER_MODE_REL_SOFT);
+			}
 		hcd->state = HC_STATE_RUNNING;
 	}
 	spin_unlock_irq(&dum_hcd->dum->lock);
@@ -2490,6 +2556,10 @@ static int dummy_start(struct usb_hcd *h
 {
 	struct dummy_hcd	*dum_hcd = hcd_to_dummy_hcd(hcd);
 
+	int i;
+	for (i = 0; i < MAX_INFO; ++i)
+		dum_hcd->alaninfo[i].str = "";
+
 	/*
 	 * HOST side init ... we emulate a root hub that'll only ever
 	 * talk to one device (the gadget side).  Also appears in sysfs,
@@ -2521,6 +2591,7 @@ static void dummy_stop(struct usb_hcd *h
 {
 	struct dummy_hcd	*dum_hcd = hcd_to_dummy_hcd(hcd);
 
+	alandbg(dum_hcd, "cancel", 0);
 	hrtimer_cancel(&dum_hcd->timer);
 	device_remove_file(dummy_dev(dum_hcd), &dev_attr_urbs);
 	dev_info(dummy_dev(dum_hcd), "stopped\n");

