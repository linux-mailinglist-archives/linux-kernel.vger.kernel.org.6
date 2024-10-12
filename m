Return-Path: <linux-kernel+bounces-361994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F378A99AFC2
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 02:48:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 722BA1F22D95
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 00:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41859C13C;
	Sat, 12 Oct 2024 00:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="om34IrCf"
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE679454
	for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 00:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728694114; cv=none; b=eg7jXXU73BQ/5q4VFOS5sccIOzOYCrwdLm14URNiAEJxMB/SRVR89GtLwl2Fe2Wc/ZYVAj19n4lWak24KsJNoq6Ko4rM8gpXKnN68Fy+v8czKU7S7g/xlgkLyqA2sE7bdl51JqlXGaWgMb0lhVbD+irxAP0Gf9uzh1W4QaPfEB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728694114; c=relaxed/simple;
	bh=xh4p8qY2PKHhzg5Mrku4x2L2HkNZ727S8TrV5OgEXNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QDNgCSQQQwXGZ/difq9qCCAZUOHJlsp9vJt8Sci32Xud3vRlkYgzk/rjTBY/wqHsg8ME7Iq7I8smO1agVSnQa2EzJxMxvq+0Fyw7JGZVtj7TH+NgeqtsGgxDJ+FqJb6kNaI7ndzegEHoqpxriSS24RHwqNil10MEDytlYLTsWFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=om34IrCf; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6cbceb48613so16360196d6.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 17:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1728694111; x=1729298911; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dvGmZasmMz7a7rSBmjAPnt1JQnG8byZMZuMs1krQh+M=;
        b=om34IrCfXdTPB4khTXrh1Z9A40ZlkExLFvYYoDv0oeNh4x6zr+lciM7XKYoes2nzeS
         lCRXxxYbhZRQuFaxUsMzIsc3xgcasNCsGo594VcxItwa/xottMBz72gw8AI5WJw0hI1M
         Mt9DDIfKvVlyX+UVeShwEGNW+IwwqDh0TxESfyTqyggn01H4UdYfs4F6BdfoGR8f7DIS
         E6Of3mJ+W2DdWH1fhaHjOoLpK7NWIj03p1dKnyhBgPFdVmX53l8GmurlJhJH9WXgMlQO
         W5M1Hu5IMbpwI0Cp/HOITfbb/RJidwK51qeu3wbDH0AFXFkjPYAwkY7cqrwzLXXJpvFv
         4+cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728694111; x=1729298911;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dvGmZasmMz7a7rSBmjAPnt1JQnG8byZMZuMs1krQh+M=;
        b=h2Y0C6sj+HtM80dlNhJIcX1oFitBc7o0PSPvUkSM22/8c+dNwGcjrrKXAvWv4xkgit
         OHD0P+RcGPYgJUAErF89fWaltlMfce4wTJSqGcbu7v33DicBZWRiZzFKbpbco8CXUW5e
         /iCT3jIn3et6lway1VGaU3Gpc0XI759sZLNqUnZ52egA7MZaGimEP+Vtqm7uo7Vv/pMT
         B7tAMycvH0awTc0LmCBOntN0vWOSQBds/FQLW/8mw2/wjuLCMlMjiPcfpCwHgVkW4eWL
         Zx1VcYyoZ+L96lDSJbTFyEJnNil+eHmjinEo6FaD/M6IlCQXJY6Xeml8RIpVs4pTjBb4
         8mFg==
X-Forwarded-Encrypted: i=1; AJvYcCVUJVBcd57WeTGR2vT3bTJh+CsLHQ59lau9Je0kH3fX6GJ2/KZ1zgvz7sGRwQ5N1AheRQ2TC8XyV037Q+Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEU+Yi/On9Kfzwh5L0CX2DJ+JX+e8SJMOVaDUNFRwHQQnU4GKx
	G0XojJt+Z/6wQF7hIFjasLhaXUC8ZYM/fOJkMyZPJFbmJgOa2U8st704yBulSQ==
X-Google-Smtp-Source: AGHT+IGgvlBZKyu3axvdmxAHg+jmoIsmRxYXnsc82wv3hzVuUAdS+Y54Z6nYO32W6VVwSphR4wbhwQ==
X-Received: by 2002:a05:6214:4984:b0:6cb:d583:3765 with SMTP id 6a1803df08f44-6cbf0003300mr51048116d6.1.1728694110812;
        Fri, 11 Oct 2024 17:48:30 -0700 (PDT)
Received: from rowland.harvard.edu ([2601:19b:681:fd10::267d])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cbe85b7597sm21004916d6.42.2024.10.11.17.48.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 17:48:29 -0700 (PDT)
Date: Fri, 11 Oct 2024 20:48:27 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: syzbot <syzbot+f342ea16c9d06d80b585@syzkaller.appspotmail.com>
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org, sylv@sylv.io,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [usb?] INFO: task hung in usb_port_suspend
Message-ID: <b84d31a3-4353-4506-903a-04f1e1b8cbda@rowland.harvard.edu>
References: <b9ce2eb7-1770-4198-97b2-f5d7aa57c3d1@rowland.harvard.edu>
 <670947ff.050a0220.3e960.0014.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <670947ff.050a0220.3e960.0014.GAE@google.com>

On Fri, Oct 11, 2024 at 08:45:03AM -0700, syzbot wrote:
> Hello,
> 
> syzbot has tested the proposed patch and the reproducer did not trigger any issue:
> 
> Reported-by: syzbot+f342ea16c9d06d80b585@syzkaller.appspotmail.com
> Tested-by: syzbot+f342ea16c9d06d80b585@syzkaller.appspotmail.com
> 
> Tested on:
> 
> commit:         4a9fe2a8 dt-bindings: usb: dwc3-imx8mp: add compatible..
> git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
> console output: https://syzkaller.appspot.com/x/log.txt?x=15346f07980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=4510af5d637450fb
> dashboard link: https://syzkaller.appspot.com/bug?extid=f342ea16c9d06d80b585
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> patch:          https://syzkaller.appspot.com/x/patch.diff?x=1456db27980000
> 
> Note: testing is done by a robot and is best-effort only.

Maybe the problem occurs because the hrtimer subsystem doesn't like 
timeouts set to the current moment.  Let's try changing them all to be 
in the future.

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
@@ -1304,7 +1304,7 @@ static int dummy_urb_enqueue(
 
 	/* kick the scheduler, it'll do the rest */
 	if (!hrtimer_active(&dum_hcd->timer))
-		hrtimer_start(&dum_hcd->timer, ns_to_ktime(DUMMY_TIMER_INT_NSECS),
+		hrtimer_start(&dum_hcd->timer, DUMMY_INT_KTIME,
 				HRTIMER_MODE_REL_SOFT);
 
  done:
@@ -1326,7 +1326,8 @@ static int dummy_urb_dequeue(struct usb_
 	rc = usb_hcd_check_unlink_urb(hcd, urb, status);
 	if (!rc && dum_hcd->rh_state != DUMMY_RH_RUNNING &&
 			!list_empty(&dum_hcd->urbp_list))
-		hrtimer_start(&dum_hcd->timer, ns_to_ktime(0), HRTIMER_MODE_REL_SOFT);
+		hrtimer_start(&dum_hcd->timer, DUMMY_INT_KTIME,
+				HRTIMER_MODE_REL_SOFT);
 
 	spin_unlock_irqrestore(&dum_hcd->dum->lock, flags);
 	return rc;
@@ -1995,8 +1996,7 @@ return_urb:
 		usb_put_dev(dum_hcd->udev);
 		dum_hcd->udev = NULL;
 	} else if (dum_hcd->rh_state == DUMMY_RH_RUNNING) {
-		/* want a 1 msec delay here */
-		hrtimer_start(&dum_hcd->timer, ns_to_ktime(DUMMY_TIMER_INT_NSECS),
+		hrtimer_start(&dum_hcd->timer, DUMMY_INT_KTIME,
 				HRTIMER_MODE_REL_SOFT);
 	}
 
@@ -2391,7 +2391,8 @@ static int dummy_bus_resume(struct usb_h
 		dum_hcd->rh_state = DUMMY_RH_RUNNING;
 		set_link_state(dum_hcd);
 		if (!list_empty(&dum_hcd->urbp_list))
-			hrtimer_start(&dum_hcd->timer, ns_to_ktime(0), HRTIMER_MODE_REL_SOFT);
+			hrtimer_start(&dum_hcd->timer, DUMMY_INT_KTIME,
+					HRTIMER_MODE_REL_SOFT);
 		hcd->state = HC_STATE_RUNNING;
 	}
 	spin_unlock_irq(&dum_hcd->dum->lock);

