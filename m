Return-Path: <linux-kernel+bounces-364901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D14DE99DAC7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 02:44:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F17D1C2140E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 00:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DFEF1B7F4;
	Tue, 15 Oct 2024 00:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="hoWI8G7U"
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5BA249F9
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 00:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728953042; cv=none; b=GiGW5mrQ+Wg4Z01LOx5Y1kl0LAzNyD5KgHWhEwlmAKHvi6wFNjjGJhu62dIk4pY4bMmu+1CxFZsj83570hOa2zmfwFnLOmjH2DDAGXBjJJKrI8V8MJP2aarL24zxfnY/U+8uwJqIz/bTElsPqejVBwgz+Qzi2uFSNjWcn8PKmnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728953042; c=relaxed/simple;
	bh=Q24mWxkblhoaSuY+s+iKIMoUW/qc9/V8xFMymoxZ5Ic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qjAdowdPnsjR51bN918vP21dBexsIwaCIBvYC0fMPIHtkPhnDRnRaMoG9Q3pxVlNgz2UKNxL+45njExjFEf7hsZ8ppWVmQh4L8cH4RzgQ7O9/FgzMNni4zCYszWoHF+8Qur2iefxA7t6XI/oIK7jIzzYx1nwRuWmfMgurEafDaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=hoWI8G7U; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6cbceb48613so31605046d6.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 17:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1728953039; x=1729557839; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UqFrj8VYyv8Qc9K7z7lW3wTCvtKg+g7E/0UBWBJIjZk=;
        b=hoWI8G7UgOhjKnnweqKKi8x1cfxpQW3+TDuaCb6HL91AEwco02xQbKCCxQIT7QQRb8
         ZYiABCH69nQWEpcXzrC/TwPzB8Sm4Gz+3cO2dZ+JQBmSOeSr7W2OOue5fNWceTBtJqhY
         qQ51erc7lzYZS/jbw81b1TbDovUqTTpq3DWI0p1O+6hXNoMwI6wJYqCFseb42HY8/0vC
         NvYiowq5eZtn0rHT0kfd/v7wTORykgL0J8YKbkdOGnWVRwj3krjB42Yp7UwCYBXOI8ri
         viCZToDYkLm/krivSSfXAB/1+cGeW06ihPufymPEiAd8P6hI0vZiIY+Th5lrA6jdLMyy
         Dd6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728953039; x=1729557839;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UqFrj8VYyv8Qc9K7z7lW3wTCvtKg+g7E/0UBWBJIjZk=;
        b=bdHIVZGVm3zGrq47zgwC87igAXgHMi8/ZAXoEpcqY21QG70ZpeMBMP8jtq/A9AB9J5
         vIf1huCAQl4zlhiaaETPtMffR/HzMlXs+eOFrZQl6YriCIlKfvZnQi/zYsiZ2mCurSWB
         CF9eVo21WkXDGP7I1kyIG5+8eO6QVN5B2SLW2NLqikRakKIoIKkvb+YzxYQAwsaXszVl
         8tUaEzwDiej+nH1oQKGPVnPXMMJdg3sltTWZ5pENZ+MJkQEdvkWSxfLo2OtWRtw+qATa
         XdW7hGWA4DhF8lxbJEMnPgNkDtgPOSFIljDvQ/YcBreR/Nj8lgTNW4xjYAWeiw4sdGLw
         rnbg==
X-Gm-Message-State: AOJu0YyaqJrolCuhkyL/iPOmuWOPGgSIun6N6/hv9XVtfAYvXibyYfeB
	eJyUf4Mc2cYyDOUj6Xrcn7K9Sbx2XzAv2gKX+gaTRnByN3eJ4Wqvz3U+R35Y5w==
X-Google-Smtp-Source: AGHT+IF0sYnvzSGDVI8tN9GeQP2futsHC2cqZyIObTKH230LSvO7cpRhmBmxkmoydweXit7vBnIwNg==
X-Received: by 2002:a05:6214:2d44:b0:6cc:42d:bbb with SMTP id 6a1803df08f44-6cc042d0d35mr90754186d6.53.1728953039521;
        Mon, 14 Oct 2024 17:43:59 -0700 (PDT)
Received: from rowland.harvard.edu ([2601:19b:681:fd10::7dde])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cc2291dae8sm1148886d6.33.2024.10.14.17.43.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 17:43:58 -0700 (PDT)
Date: Mon, 14 Oct 2024 20:43:55 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: syzbot <syzbot+f342ea16c9d06d80b585@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [usb?] INFO: task hung in usb_port_suspend
Message-ID: <1336ee1b-cf5d-4081-b4f1-512e2b29dace@rowland.harvard.edu>
References: <d662ba74-2c02-4298-adfe-f12b3d65471c@rowland.harvard.edu>
 <670da1be.050a0220.f16b.0003.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <670da1be.050a0220.f16b.0003.GAE@google.com>

On Mon, Oct 14, 2024 at 03:57:02PM -0700, syzbot wrote:
> Hello,
> 
> syzbot tried to test the proposed patch but the build/boot failed:
> 
> kernel clean failed: failed to run ["make" "-j" "0" "ARCH=x86_64" "distclean"]: exit status 2
> make: the '-j' option requires a positive integer argument

Don't know what that was about.  Let's try it on a more standard commit.

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


