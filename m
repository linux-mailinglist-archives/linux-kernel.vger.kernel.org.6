Return-Path: <linux-kernel+bounces-362666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3756A99B7D7
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 03:10:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 956D6B21E86
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 01:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29E5F2F5E;
	Sun, 13 Oct 2024 01:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="SKxKYV5e"
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3912217C9
	for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2024 01:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728781787; cv=none; b=TH1PBm97zIFV7fMBv0Hijg1Proi2vrxbO3nd9eHQg+OZtCLH6IQybHYYgmNNFpdact9oFZCoz19HmMssAmz6WYToC7lOeqS8twJl/SiJb6k9kTuWh/gNzwvV4v8RUTrhVP0iD+8UcIyGHK9+YCLtCMRCL11gpgUjB/l3jbzgvVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728781787; c=relaxed/simple;
	bh=i9l02zYzoPwEZ2PQuwyfyKNaFKIHe5dj14a4UP05FwU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lFW61ZlKt42hUavyB/ZWK7CqUADO3RtpUUWWz9sTdyn+ypyVo+Wonb/zDf7pTTuJeYWkC9K2PcyidAolbyvRxFhNaLgHsU7uR63FXzkU5FFKEx9GHjoW7kjDZvnzQ4mFfEkD9IxIvpJMGoyQDBZtv7Wn93fOs4oCsqtoxIBbK5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=SKxKYV5e; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-460464090d5so28079141cf.2
        for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 18:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1728781783; x=1729386583; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=L6Wj4IncaWW8DB4CSHkdscYzlwNbQVqFKfxtSoI7Rz0=;
        b=SKxKYV5e0PUHDDh985PfqI8Pasw3+WNVKpgrcSLyFOcvx/PJs3RCsX0TEdEATryBMr
         U0NzU8DPgqKtQvIKIuRXxZu65AJFD6NkCYLmX5ymfdpYe88S2mp63sOmhtFMRKD7A+sy
         e8UWYtaQH6c0WvjomMQuHm633YEheS8s+2a0KcXlr5VrOaaO2lg+2ZQFfDCbNTHp5JIb
         XOXMvfT3JB7p0B18zf5XnYb7imZjwEv46tkWysK7O5FdbASbm/qT1anGrvCnafH+rNrv
         PRHhCFE9fjs+cXW/torv1OVyRYfs2RtSmmxIZhIxAyb+LYiqPWzRDBV6BXfjUvJDhseZ
         1qeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728781783; x=1729386583;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L6Wj4IncaWW8DB4CSHkdscYzlwNbQVqFKfxtSoI7Rz0=;
        b=Ag6kZP52etPso6dqOnLjsibxR/zhs5Ugk8up3UwF7aIKhIl957IdLLuJv21kaeiKax
         DvZZ47jyX/QINUnB/it+YmdYX02seFhbkIIGMPdJM6T9kjnZHd/j+LUYO1W3PzPVf9U1
         tujYAx0tACuWv1XxFTcmjM6P4HOUcdF2V8aTCAh6Zkkzy1vOd7KMDWCVWKMSRseAxOp3
         E/wtRIpjbOGLEnTwt5s9f5I8LET61ek7LoMl9OTyEv+LAPUb9S+bDZczSt2J68d7Q8DZ
         5LoS6vSEMZTWH44bVBX2+yuX4cyz+DUm+R397Mhi797vqvXZqgKfMG7qOVjhMKS2YmeA
         Vuow==
X-Forwarded-Encrypted: i=1; AJvYcCXJgLauB9vh4tpLPC/SrlPbynN7W/HbmgLTETC6a4AMV73hnmPSYNjsi6zJHFMPkjMU8VBuVfd136LGLT0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/e4ntYci9SpGS4yrW5IXgMNtS3lBGraiZBPtBjMyueEs2FPZH
	SzaMSPb+jpPwXY8T5hJ3U95K8zDIoizlZcHn+UtekS50zN3V9a17cQI1QtvBVA==
X-Google-Smtp-Source: AGHT+IHmPHKh70uPFWArUWFNTndCs/54KaUXrdlh7yZErJ0yLwCs32+3VrI8HmMEvvCR6XxoJws4iQ==
X-Received: by 2002:a05:620a:2622:b0:7b1:1cf6:cfb9 with SMTP id af79cd13be357-7b11cf6d056mr1046812085a.55.1728781783183;
        Sat, 12 Oct 2024 18:09:43 -0700 (PDT)
Received: from rowland.harvard.edu ([2601:19b:681:fd10::31c2])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b11498a26dsm272143285a.136.2024.10.12.18.09.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Oct 2024 18:09:42 -0700 (PDT)
Date: Sat, 12 Oct 2024 21:09:38 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: syzbot <syzbot+f342ea16c9d06d80b585@syzkaller.appspotmail.com>
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org, sylv@sylv.io,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [usb?] INFO: task hung in usb_port_suspend
Message-ID: <7d3e0f43-ec5a-4448-aff6-d17a46341844@rowland.harvard.edu>
References: <b84d31a3-4353-4506-903a-04f1e1b8cbda@rowland.harvard.edu>
 <6709cd5b.050a0220.4cbc0.001a.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6709cd5b.050a0220.4cbc0.001a.GAE@google.com>

On Fri, Oct 11, 2024 at 06:14:03PM -0700, syzbot wrote:
> Hello,
> 
> syzbot has tested the proposed patch but the reproducer is still triggering an issue:
> INFO: task hung in usb_port_suspend

Okay, let's do some closer tracking of URBs waiting to be dequeued.

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
@@ -276,6 +276,7 @@ struct dummy {
 	unsigned			ints_enabled:1;
 	unsigned			udc_suspended:1;
 	unsigned			pullup:1;
+	bool				alanflag;
 
 	/*
 	 * HOST side support
@@ -1304,7 +1305,7 @@ static int dummy_urb_enqueue(
 
 	/* kick the scheduler, it'll do the rest */
 	if (!hrtimer_active(&dum_hcd->timer))
-		hrtimer_start(&dum_hcd->timer, ns_to_ktime(DUMMY_TIMER_INT_NSECS),
+		hrtimer_start(&dum_hcd->timer, DUMMY_INT_KTIME,
 				HRTIMER_MODE_REL_SOFT);
 
  done:
@@ -1325,9 +1326,13 @@ static int dummy_urb_dequeue(struct usb_
 
 	rc = usb_hcd_check_unlink_urb(hcd, urb, status);
 	if (!rc && dum_hcd->rh_state != DUMMY_RH_RUNNING &&
-			!list_empty(&dum_hcd->urbp_list))
-		hrtimer_start(&dum_hcd->timer, ns_to_ktime(0), HRTIMER_MODE_REL_SOFT);
-
+			!list_empty(&dum_hcd->urbp_list)) {
+		dum_hcd->dum->alanflag = true;
+		dev_info(udc_dev(dum_hcd->dum), "Dequeue %p\n", urb);
+		hrtimer_start(&dum_hcd->timer, DUMMY_INT_KTIME,
+				HRTIMER_MODE_REL_SOFT);
+	} else
+		dev_info(udc_dev(dum_hcd->dum), "Failed dequeue\n");
 	spin_unlock_irqrestore(&dum_hcd->dum->lock, flags);
 	return rc;
 }
@@ -1788,6 +1793,7 @@ static enum hrtimer_restart dummy_timer(
 	unsigned long		flags;
 	int			limit, total;
 	int			i;
+	int			alancnt = 0;
 
 	/* simplistic model for one frame's bandwidth */
 	/* FIXME: account for transaction and packet overhead */
@@ -1984,6 +1990,9 @@ return_urb:
 			ep->already_seen = ep->setup_stage = 0;
 
 		usb_hcd_unlink_urb_from_ep(dummy_hcd_to_hcd(dum_hcd), urb);
+		if (dum->alanflag)
+			dev_info(udc_dev(dum), "Give back %p\n", urb);
+		++alancnt;
 		spin_unlock(&dum->lock);
 		usb_hcd_giveback_urb(dummy_hcd_to_hcd(dum_hcd), urb, status);
 		spin_lock(&dum->lock);
@@ -1995,11 +2004,14 @@ return_urb:
 		usb_put_dev(dum_hcd->udev);
 		dum_hcd->udev = NULL;
 	} else if (dum_hcd->rh_state == DUMMY_RH_RUNNING) {
-		/* want a 1 msec delay here */
-		hrtimer_start(&dum_hcd->timer, ns_to_ktime(DUMMY_TIMER_INT_NSECS),
+		hrtimer_start(&dum_hcd->timer, DUMMY_INT_KTIME,
 				HRTIMER_MODE_REL_SOFT);
 	}
 
+	if (dum->alanflag) {
+		dev_info(udc_dev(dum), "Gave back %d URBs\n", alancnt);
+		dum->alanflag = false;
+	}
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

