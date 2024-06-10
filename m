Return-Path: <linux-kernel+bounces-208809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AB1A902977
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 21:43:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FAD51C21E24
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 19:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12DBA14E2EC;
	Mon, 10 Jun 2024 19:43:02 +0000 (UTC)
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
	by smtp.subspace.kernel.org (Postfix) with SMTP id E71A01EB5B
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 19:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.131.102.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718048581; cv=none; b=Vp05bqY0vsFIzcjep/AgzFgDQUkJ73iWDFLgj7AqrKeK4QCMlMkjNxRC/aVT5qGT9jp1c8PiubJPFxRXuxJBx5bYVCmNvT8wJnDubkzzN2MpeHOIO0iKfRzNhw6/Uw3iu3fLAYXFhmrIzl90n5Ov+AnPaVpvBnKW/jx2vHeGw4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718048581; c=relaxed/simple;
	bh=SJuoIn+XQDHZEBwCVtB22ZyWhi7TNCMTGd17Ya1myv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d4P49Eg0l7U0gZURfgClbLAen2y+6/x55xgxrzI14NXu41epbAUrkS+hp/Pk+K3L10XaNUmRvXT50jYlczm1A1b3u9pf4vB0ReKP1fDmb3fhnE0NC4xs2rox2idV8sBLQ7g6DQdwwxJgfbnegaVj0FGxfoHnPyPUabnlxA16jE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu; spf=pass smtp.mailfrom=netrider.rowland.org; arc=none smtp.client-ip=192.131.102.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netrider.rowland.org
Received: (qmail 161143 invoked by uid 1000); 10 Jun 2024 15:42:57 -0400
Date: Mon, 10 Jun 2024 15:42:57 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: syzbot <syzbot+5f996b83575ef4058638@syzkaller.appspotmail.com>
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
  linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [usb?] INFO: rcu detected stall in raw_ioctl
Message-ID: <c3073a8c-bdaa-4123-ae27-9143d916a701@rowland.harvard.edu>
References: <e8b8013b-d8b4-4eee-8643-1d512aa17133@rowland.harvard.edu>
 <000000000000ee54e1061a8ce3f6@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000ee54e1061a8ce3f6@google.com>

On Mon, Jun 10, 2024 at 10:58:02AM -0700, syzbot wrote:
> Hello,
> 
> syzbot has tested the proposed patch but the reproducer is still triggering an issue:
> BUG: soft lockup in raw_ioctl
> 
> dummy_hcd dummy_hcd.0: urbp 000000006bf6c1dd 40409880 next_frame 0000000000000000
> cdc_wdm 1-1:1.0: nonzero urb status received: -71
> cdc_wdm 1-1:1.0: wdm_int_callback - 0 bytes
> dummy_hcd dummy_hcd.0: urbp 000000003f481f40 40409880 next_frame 000000003f481f40
> watchdog: BUG: soft lockup - CPU#0 stuck for 22s! [syz-executor415:10796]

The full console log shows that the cdc-wm and dummy-hcd loop uses less 
than 60 microseconds out of every 2400 or so.  That's not enough to 
cause this.  Something else must be going on.

> Call trace:
>  __daif_local_irq_restore arch/arm64/include/asm/irqflags.h:175 [inline]
>  arch_local_irq_restore arch/arm64/include/asm/irqflags.h:195 [inline]
>  console_emit_next_record kernel/printk/printk.c:2935 [inline]
>  console_flush_all+0x67c/0xb74 kernel/printk/printk.c:2994
>  console_unlock+0xec/0x3d4 kernel/printk/printk.c:3063
>  vprintk_emit+0x1ec/0x350 kernel/printk/printk.c:2345
>  vprintk_default+0xa0/0xe4 kernel/printk/printk.c:2360
>  vprintk+0x200/0x2d4 kernel/printk/printk_safe.c:45
>  _printk+0xdc/0x128 kernel/printk/printk.c:2370
>  usb_gadget_register_driver_owner+0x1f0/0x224 drivers/usb/gadget/udc/core.c:1711

Is this a coincidence?  If CPU #0 is getting stuck, why here?  Line 1711 
is a mutex_unlock() call; it shouldn't take long.  This doesn't seem to 
make sense.

Let's try to find out what the CPU is really doing when this happens.

Alan Stern

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git 8867bbd4a056

Index: usb-devel/drivers/usb/gadget/udc/dummy_hcd.c
===================================================================
--- usb-devel.orig/drivers/usb/gadget/udc/dummy_hcd.c
+++ usb-devel/drivers/usb/gadget/udc/dummy_hcd.c
@@ -1826,6 +1826,7 @@ static void dummy_timer(struct timer_lis
 			break;
 		dum->ep[i].already_seen = 0;
 	}
+	dev_info(dummy_dev(dum_hcd), "Timer handler\n");
 
 restart:
 	list_for_each_entry_safe(urbp, tmp, &dum_hcd->urbp_list, urbp_list) {
@@ -1835,6 +1836,9 @@ restart:
 		struct dummy_ep		*ep = NULL;
 		int			status = -EINPROGRESS;
 
+		dev_info(dummy_dev(dum_hcd), "urbp %p %x next_frame %p\n",
+				urbp, urbp->urb->pipe, dum_hcd->next_frame_urbp);
+
 		/* stop when we reach URBs queued after the timer interrupt */
 		if (urbp == dum_hcd->next_frame_urbp)
 			break;
Index: usb-devel/drivers/usb/class/cdc-wdm.c
===================================================================
--- usb-devel.orig/drivers/usb/class/cdc-wdm.c
+++ usb-devel/drivers/usb/class/cdc-wdm.c
@@ -112,6 +112,7 @@ struct wdm_device {
 
 	enum wwan_port_type	wwanp_type;
 	struct wwan_port	*wwanp;
+	int			alancount;
 };
 
 static struct usb_driver wdm_driver;
@@ -255,6 +256,14 @@ static void wdm_int_callback(struct urb
 	desc = urb->context;
 	dr = (struct usb_cdc_notification *)desc->sbuf;
 
+	if (status == -EPROTO) {
+		if (desc->alancount >= 1)
+			return;
+		++desc->alancount;
+		dev_info(&desc->intf->dev, "Alan test\n");
+		dump_stack();
+	}
+
 	if (status) {
 		switch (status) {
 		case -ESHUTDOWN:

