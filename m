Return-Path: <linux-kernel+bounces-366995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD52899FD6D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 02:55:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92E892866AD
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 00:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95775200DE;
	Wed, 16 Oct 2024 00:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="v9greACD"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D70FC0C
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 00:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729040097; cv=none; b=kCQsgRA7MQ9QlHyoYcqtTD+mwGlfQMNGgCEsd71WoabJ6EvOhwqD9rVO6XtyjyLZ9RkoBjqKhWbD6KZ+Yve243tv1pCL5sYNIs5Gcf3PPucidpBJ2sJqNld9OSDOHx7CHMmpGyiJ0kADUXygilmChh9W3gB7gR7uxTRg9MX10Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729040097; c=relaxed/simple;
	bh=g1jJOLnoxh5GdZcf2w9M/zn38kxQ/BNElqyiH9geTfM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bO3XlMiZ6m79uaFIQOZdCMTtZCP1o+0RbPJkYXMLP0zHnfRRmnfBcRb1SAgp2Shnb9WBZnY+FWInQwfYCeXKjwYQvRPnIv2MPhL1ul6VD++O/OI6BXuGmeJSksxs3mrbLisleLyW+79g/U9CyvYvfZ4bS2f5t6Le5BOWLPeTP8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=v9greACD; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-460464090d5so56770571cf.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 17:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1729040095; x=1729644895; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GgIPZWwNeUzpAh0NPcsHofcQbfl+3CRk+RJHiu1ae4I=;
        b=v9greACDS+jvH2P2gS79NqKccYf3r89CaVS2NDRqbZmdNqiAGTvYEB8T+JqXxJaq2h
         0jD7RVUt7kULhkOwmsV/+9SMgsenmRda46zAgW4og/mYH2ehcdk1TWBIozFZon1T0yxi
         JsuUPNro/RUg90YPCdywba1lmhzfuq/KOWGPx3rwLnDsXLXzInrOeyPTmgzygh6zlLIl
         hYO/wQUfxzNbV7MWTCNOXAIx6e+Ezb2oDfpI/KiUmiYGpNSSwKcNjB0UuZ2urkJl8NI5
         /BOnTkWiimM+DJiIW+8BwP29V+Cqgxke99ld/QrzII1srD6pdUp0quElpByQ15ty5I9N
         1PZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729040095; x=1729644895;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GgIPZWwNeUzpAh0NPcsHofcQbfl+3CRk+RJHiu1ae4I=;
        b=tGz+izzGaomFXYI2YXLeAEHtD1a1i1kKjGDGGerUxY57DbqMItymV1j/empzSB3NUs
         09RGd3CMJtcARJn3GfbHiYE+oEFKtk77vOrgKIdAb3FPm+ARVORiFw/Dij97ZBiFij+s
         OyZRQHhxVhGOOcHN6FWnQH808V6jLBh/pDlgFetTsdqOsQIvPHwhj8HGR2RlYArjFpqv
         4pVf/GuSwuIC2VqQRzk/dl+EhNZbouhmCAOKRL8uiDfN5MDry02hDz86n6QVXlo7LBw5
         mNxImBbL8VT6TtZzCRx/57uDGlj7IcBjhMY7cPIM6PNUZYuau468YmtGV1RrddKGVILN
         tkrg==
X-Gm-Message-State: AOJu0YzKdRH2PpMnq1nHut4Bw8FHibbelkDVLHcBE/TlckEOmZRzptY0
	KUutYi+cNlV8wJHuKY4ekhrp0oPv5rV3kueJU+YSZZDdKpJEFKFVf+eeIkHkpQ==
X-Google-Smtp-Source: AGHT+IGdj7XN0o5Q5NOH/QDJFLjxUH9bTjL1NgjUadsSaE2ZO2Dl9Fn5tRUPop4OJBcC7G9JXC/PRw==
X-Received: by 2002:ac8:5915:0:b0:458:2b4e:33d6 with SMTP id d75a77b69052e-4608a6ad9famr30701391cf.55.1729040094812;
        Tue, 15 Oct 2024 17:54:54 -0700 (PDT)
Received: from rowland.harvard.edu ([2601:19b:681:fd10::7dde])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4607b0a3f98sm11972691cf.14.2024.10.15.17.54.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 17:54:53 -0700 (PDT)
Date: Tue, 15 Oct 2024 20:54:50 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: syzbot <syzbot+f342ea16c9d06d80b585@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [usb?] INFO: task hung in usb_port_suspend
Message-ID: <8b9352a4-ce86-4313-b5a7-cc6ba987b506@rowland.harvard.edu>
References: <c3d59f87-bb72-46d9-94b8-7441b837bf13@rowland.harvard.edu>
 <670ec85a.050a0220.d5849.000c.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <670ec85a.050a0220.d5849.000c.GAE@google.com>

On Tue, Oct 15, 2024 at 12:54:02PM -0700, syzbot wrote:
> Hello,
> 
> syzbot has tested the proposed patch but the reproducer is still triggering an issue:

Arghh...  Mistake in the patch caused the debugging info not to be
printed.  Here's a corrected version.

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
+	dev_info(dummy_dev(dum_hcd), "%s\n", buf);
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

