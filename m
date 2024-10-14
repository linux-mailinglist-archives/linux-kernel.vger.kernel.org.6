Return-Path: <linux-kernel+bounces-363046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A7999BD48
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 03:24:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A6201F21D9A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 01:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98668101EE;
	Mon, 14 Oct 2024 01:24:35 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78EE71171C
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 01:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728869075; cv=none; b=nkJJJHypWJF2d1RfZCYgi3WNU8H2XGEs8w94p9X5IdG7jn+08HiDnu/3YxA09gmUaWaqhwjg8gkIIYJ3dOmovDnLh45mhyLqMk6HHTCTq73+D/Hh7EOyFoW71KcjmpMEItmC3JW6Xg64NV92nd4d5LJCs91rFI3GkB0xJVRma5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728869075; c=relaxed/simple;
	bh=BFl7TmfHJhkhGQVBlv7GqszMaPh1Vsk5zimOvdSrV64=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=it006eHcJ5qqCN0j2isASVc+n0YnQAK/qwffJGFESmZn02QgGzBSONeOnNn0+1C7/twBh9C48cDG/h4fV9bOUnGw+gFT8JJrKJLb9xUbx4aNo5aA9K/+rmxeoNBEROTrjsTsBPCM1Cz5d+PSD+nemYHPQK8GG0iCg73idt8T1lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a3b4395dedso28657075ab.1
        for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2024 18:24:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728869072; x=1729473872;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AhR+YBOmGdmNfdYCu74B1dPdNH77/rrRtE4b/gY0pQA=;
        b=JkhseF12LCzYPjmabXbknWMS6JbFFetJ7mf3Ck7lHZ1CfwSawVtkkyPTjD/if7paJd
         X3dkNHGIC7c5Z9HmCpaYqUXnjHoBb22PGTL87diCYx+649EaLLu3orOG1MFtFCk1QOF5
         liVUrMfrpQZNF9oKCiKVISUl9Zgwx8DdP1MiMIYEDm5mAXXZHCOj63+oBwFm/FrRoBjI
         htZxk/S5E5qjIjc/8ZsFyOg6wPSjxRkAc4/NPqlVvNoQxtoN7Z0x3av2MITfuKpZgb8Z
         HrKQxwjFedhtr6I7iVLuT/KnSOMj4UnbtAw1wcJc2Uvns9ndGzma7aErVoOAqfwBXjo8
         fqQA==
X-Gm-Message-State: AOJu0Yy3dAK1eIz9LioiaMd3weAFKfqhF8/7mS8uTCeIriXyjZPwvJx7
	ef1Tb1OvTmjVCp5QXGUNjAQ+ctIy2ZhtqKUWmGk++JIgVCfzMRmEWMz9Rn2fc9+WeorH15Mn0vE
	4mNyuMXQvNcdaqNZQFazuZRHoSXWZPL3SvHhle0NiG/GiqdTXYLyz18U=
X-Google-Smtp-Source: AGHT+IEDZyGfMsSNRCSbLh7Lj7IOigWtuK6JD+7r7UVEuAEtZWZp7fV0ZkXKgCm3n5ibTFUy1jotTZXOBep+6Y4Vf7L8ESwJyDnt
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1548:b0:3a3:6045:f8bd with SMTP id
 e9e14a558f8ab-3a3b5f7845dmr91039845ab.5.1728869072424; Sun, 13 Oct 2024
 18:24:32 -0700 (PDT)
Date: Sun, 13 Oct 2024 18:24:32 -0700
In-Reply-To: <6709234e.050a0220.3e960.0011.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <670c72d0.050a0220.4cbc0.003d.GAE@google.com>
Subject: Re: [syzbot] Re: [syzbot] [usb?] INFO: task hung in usb_port_suspend
From: syzbot <syzbot+f342ea16c9d06d80b585@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [syzbot] [usb?] INFO: task hung in usb_port_suspend
Author: stern@rowland.harvard.edu

On Sun, Oct 13, 2024 at 01:34:05PM -0700, syzbot wrote:
> Hello,
> 
> syzbot has tested the proposed patch but the reproducer is still triggering an issue:

Okay, that's more like it.  This exercise has focused my mind on one 
particular spot in the code, and I believe I see the problem.  The 
driver needs to do a more careful job keeping track of whether the 
hrtimer callback is pending; neither hrtimer_active() nor 
dum_hcd->rh_state is quite the right thing to test.  In particular, the 
root hub can be in the DUMMY_RH_RUNNING state without the timer being 
active.

This patch adds a flag for a pending timer callback, on top of all the 
other debugging material.  Let's see if it fixes the problem.

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
@@ -254,9 +254,12 @@ struct dummy_hcd {
 	u32				stream_en_ep;
 	u8				num_stream[30 / 2];
 
+	unsigned			timer_pending:1;
 	unsigned			active:1;
 	unsigned			old_active:1;
 	unsigned			resuming:1;
+
+	bool				alanflag;
 };
 
 struct dummy {
@@ -1303,9 +1306,11 @@ static int dummy_urb_enqueue(
 		urb->error_count = 1;		/* mark as a new urb */
 
 	/* kick the scheduler, it'll do the rest */
-	if (!hrtimer_active(&dum_hcd->timer))
-		hrtimer_start(&dum_hcd->timer, ns_to_ktime(DUMMY_TIMER_INT_NSECS),
+	if (!dum_hcd->timer_pending) {
+		hrtimer_start(&dum_hcd->timer, DUMMY_INT_KTIME,
 				HRTIMER_MODE_REL_SOFT);
+		dum_hcd->timer_pending = 1;
+	}
 
  done:
 	spin_unlock_irqrestore(&dum_hcd->dum->lock, flags);
@@ -1324,10 +1329,17 @@ static int dummy_urb_dequeue(struct usb_
 	spin_lock_irqsave(&dum_hcd->dum->lock, flags);
 
 	rc = usb_hcd_check_unlink_urb(hcd, urb, status);
-	if (!rc && dum_hcd->rh_state != DUMMY_RH_RUNNING &&
-			!list_empty(&dum_hcd->urbp_list))
-		hrtimer_start(&dum_hcd->timer, ns_to_ktime(0), HRTIMER_MODE_REL_SOFT);
-
+	if (!rc && !dum_hcd->timer_pending &&
+			!list_empty(&dum_hcd->urbp_list)) {
+		dev_info(dummy_dev(dum_hcd), "Dequeue restart %p\n", urb);
+		hrtimer_start(&dum_hcd->timer, DUMMY_INT_KTIME,
+				HRTIMER_MODE_REL_SOFT);
+		dum_hcd->timer_pending = 1;
+	} else {
+		dev_info(dummy_dev(dum_hcd), "Dequeue norestart: %d %p\n",
+				rc, urb);
+	}
+	dum_hcd->alanflag = true;
 	spin_unlock_irqrestore(&dum_hcd->dum->lock, flags);
 	return rc;
 }
@@ -1813,6 +1825,9 @@ static enum hrtimer_restart dummy_timer(
 
 	/* look at each urb queued by the host side driver */
 	spin_lock_irqsave(&dum->lock, flags);
+	dum_hcd->timer_pending = 0;
+	if (dum_hcd->alanflag)
+		dev_info(dummy_dev(dum_hcd), "Timer handler\n");
 
 	if (!dum_hcd->udev) {
 		dev_err(dummy_dev(dum_hcd),
@@ -1984,6 +1999,8 @@ return_urb:
 			ep->already_seen = ep->setup_stage = 0;
 
 		usb_hcd_unlink_urb_from_ep(dummy_hcd_to_hcd(dum_hcd), urb);
+		if (dum_hcd->alanflag)
+			dev_info(dummy_dev(dum_hcd), "Giveback %p\n", urb);
 		spin_unlock(&dum->lock);
 		usb_hcd_giveback_urb(dummy_hcd_to_hcd(dum_hcd), urb, status);
 		spin_lock(&dum->lock);
@@ -1995,11 +2012,12 @@ return_urb:
 		usb_put_dev(dum_hcd->udev);
 		dum_hcd->udev = NULL;
 	} else if (dum_hcd->rh_state == DUMMY_RH_RUNNING) {
-		/* want a 1 msec delay here */
-		hrtimer_start(&dum_hcd->timer, ns_to_ktime(DUMMY_TIMER_INT_NSECS),
+		hrtimer_start(&dum_hcd->timer, DUMMY_INT_KTIME,
 				HRTIMER_MODE_REL_SOFT);
+		dum_hcd->timer_pending = 1;
 	}
 
+	dum_hcd->alanflag = false;
 	spin_unlock_irqrestore(&dum->lock, flags);
 
 	return HRTIMER_NORESTART;
@@ -2390,8 +2408,11 @@ static int dummy_bus_resume(struct usb_h
 	} else {
 		dum_hcd->rh_state = DUMMY_RH_RUNNING;
 		set_link_state(dum_hcd);
-		if (!list_empty(&dum_hcd->urbp_list))
-			hrtimer_start(&dum_hcd->timer, ns_to_ktime(0), HRTIMER_MODE_REL_SOFT);
+		if (!list_empty(&dum_hcd->urbp_list)) {
+			hrtimer_start(&dum_hcd->timer, DUMMY_INT_KTIME,
+					HRTIMER_MODE_REL_SOFT);
+			dum_hcd->timer_pending = 1;
+		}
 		hcd->state = HC_STATE_RUNNING;
 	}
 	spin_unlock_irq(&dum_hcd->dum->lock);
@@ -2522,6 +2543,7 @@ static void dummy_stop(struct usb_hcd *h
 	struct dummy_hcd	*dum_hcd = hcd_to_dummy_hcd(hcd);
 
 	hrtimer_cancel(&dum_hcd->timer);
+	dum_hcd->timer_pending = 0;
 	device_remove_file(dummy_dev(dum_hcd), &dev_attr_urbs);
 	dev_info(dummy_dev(dum_hcd), "stopped\n");
 }

