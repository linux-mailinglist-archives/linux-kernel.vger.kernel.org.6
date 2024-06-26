Return-Path: <linux-kernel+bounces-230883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DD9E91834C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 15:51:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD9D41F212D1
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 13:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0658185E6A;
	Wed, 26 Jun 2024 13:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="C90fSGpG"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0877C185E79
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 13:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719409651; cv=none; b=HcuX0gfgBdtci3P8wULozU/Jbiorw2Nc40boljYuewrkI7vCg1+6KVHxn8R1HPWHl8UJg3tY1ng8oyrqyyMkivOCX8Vy/3TuzPnJJ8keJwlgRlTJlsEhvPkwg9htNbhDEmEXT2bvE5wYLoJ8aGAz15tQSHRfCTNWsfoTHxv8UAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719409651; c=relaxed/simple;
	bh=XzFkaySkKzNd6+sftzdixiRo/hq6kxEdXvpkccHPx3s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uuQFGZfPdRlhK71O1dBbVwCfEN+nZ7mj3kh7Syx+qdZ3NW0ELW16ZNImDtEoEpD299FQkNhY5nRmxggrGZ0uR5pi8eRBwhim49Vc2TzBVwQDrMgEAOiSOY33fWXhQs5/yjw6JdQh82qwPpFg1QbKJCvu5UC/Rmcv1fmB7uuirKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=C90fSGpG; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42561c16ffeso1584975e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 06:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1719409648; x=1720014448; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0CezVsx8l3fnp1A8bZcAxPsrFZeXuSQJtwlNWUBFOzQ=;
        b=C90fSGpGBeXBbgE1FCIcUQWvk0tkE0vMV+QxPTtq2RFNoI8YPbipJvILCPYoYweisT
         ViFc7Gj3G3T7fPoLcDa/lnmlTdaU6//LTj0IrF7m0D17ufvAY6aI35IX6TZOrGre2wRC
         Mv2OOFUjRWVZhKvtRoynfWPp756Sgb1pukzXlS1WCzvLBYHPVn+H+dwmj91KAh0rhikz
         Nu+P+LvTxspxpkzzZirCh4YEh4PhT0rj38cxmFsX8PZQADdsaWC+HGIzpRil9nTiNCTC
         T0nVQKlR/Bqlvg6FTNmGe6AbRk/7gljpCigMUjObEgr3JjztHjLgYwAtVY2dr1lci6hg
         BIxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719409648; x=1720014448;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0CezVsx8l3fnp1A8bZcAxPsrFZeXuSQJtwlNWUBFOzQ=;
        b=dIHeyG+SmShceVLtaIw9hPMBxz9FNK2vKfCc+ozBNKNO5KBQDY382fkZAzMzzARRuv
         QDppXIiiAJbJErWSKwcJP5v0mrLDRxGiryjL9D12iZ2Hn7g3rS6Px1jgtc83BpFkZhgA
         7z4GVLVT81cxEn2ae3+VC45wtg1GuJqgMF22au336/rQWc0IADLiPuaTMVjn5VILO9Uv
         IgvxqLGHYmH6B51ol33kF1/BvCUvr5k1sTZ0higobAEBXyMjXPqWWOB2xqdY2bLujIF7
         wEXxJ9/B1VdXIIXGy/ZEdIqQn6/d2qY0MNZ7qKhgD+WWkKbG8L/mYNQJdCgHjbrlxq7e
         EceQ==
X-Gm-Message-State: AOJu0YxDsIbff0Ut3yX23UYV8/Vh+YCRQ97eWEGzM+W0gdO+zBNsY7w2
	4OJvArI87kLOWRGFV6eh3dHx2oDZjN0a72iVqZYtYYpYm9KPodiMSfJqcGeSZ6O+jGThdRFcihb
	nhZk=
X-Google-Smtp-Source: AGHT+IGNOuXh6mPvuhnQI5HWEmwy/Yzrocc52UfBrenG80q0aWl3Qx8bK14IrXSqZbFX/3nzxXaXaw==
X-Received: by 2002:a05:600c:2192:b0:424:bb45:cdea with SMTP id 5b1f17b1804b1-424bb45cedbmr13302185e9.22.1719409648166;
        Wed, 26 Jun 2024 06:47:28 -0700 (PDT)
Received: from T14s.n1ce.space ([185.254.75.30])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-424c8475aacsm26611625e9.47.2024.06.26.06.47.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 06:47:27 -0700 (PDT)
From: Marcello Sylvester Bauer <marcello.bauer@9elements.com>
To: linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Marcello Sylvester Bauer <sylv@sylv.io>,
	Alan Stern <stern@rowland.harvard.edu>
Cc: Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Matthias Stoeckl <matthias.stoeckl@secunet.com>,
	Marcello Sylvester Bauer <marcello.bauer@9elements.com>,
	syzbot+c793a7eca38803212c61@syzkaller.appspotmail.com,
	syzbot+1e6e0b916b211bee1bd6@syzkaller.appspotmail.com,
	kernel test robot <oliver.sang@intel.com>
Subject: [PATCH v1 1/1] usb: gadget: dummy_hcd: make hrtimer expire in soft irq context
Date: Wed, 26 Jun 2024 15:47:20 +0200
Message-ID: <f0437127d9841ad23cbd458132db7ab486475c3a.1719405791.git.marcello.bauer@9elements.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1719405791.git.marcello.bauer@9elements.com>
References: <cover.1719405791.git.marcello.bauer@9elements.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since migrating to hrtime, some kernel test bots are reporting
regressions like rcu stalls and inconsistent_lock_state. the listed
cause is around usb_hcd_giveback_urb() and it's locking mechanism, which
was not changed by the patch.

The main difference between the timer list timer and the current hrtimer
integration is that the timer list timer callback runs in soft interrupt
context.

This patch changes the hrtimer in the transfer scheduler to also use soft
interrupt context.

Reported-by: syzbot+c793a7eca38803212c61@syzkaller.appspotmail.com
Reported-by: syzbot+1e6e0b916b211bee1bd6@syzkaller.appspotmail.com
Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202406141323.413a90d2-lkp@intel.com
Fixes: a7f3813e589f ("usb: gadget: dummy_hcd: Switch to hrtimer transfer scheduler")
Signed-off-by: Marcello Sylvester Bauer <marcello.bauer@9elements.com>
---
 drivers/usb/gadget/udc/dummy_hcd.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/gadget/udc/dummy_hcd.c b/drivers/usb/gadget/udc/dummy_hcd.c
index f37b0d8386c1..cd25538e999e 100644
--- a/drivers/usb/gadget/udc/dummy_hcd.c
+++ b/drivers/usb/gadget/udc/dummy_hcd.c
@@ -1304,7 +1304,7 @@ static int dummy_urb_enqueue(
 
 	/* kick the scheduler, it'll do the rest */
 	if (!hrtimer_active(&dum_hcd->timer))
-		hrtimer_start(&dum_hcd->timer, ns_to_ktime(DUMMY_TIMER_INT_NSECS), HRTIMER_MODE_REL);
+		hrtimer_start(&dum_hcd->timer, ns_to_ktime(DUMMY_TIMER_INT_NSECS), HRTIMER_MODE_REL_SOFT);
 
  done:
 	spin_unlock_irqrestore(&dum_hcd->dum->lock, flags);
@@ -1325,7 +1325,7 @@ static int dummy_urb_dequeue(struct usb_hcd *hcd, struct urb *urb, int status)
 	rc = usb_hcd_check_unlink_urb(hcd, urb, status);
 	if (!rc && dum_hcd->rh_state != DUMMY_RH_RUNNING &&
 			!list_empty(&dum_hcd->urbp_list))
-		hrtimer_start(&dum_hcd->timer, ns_to_ktime(0), HRTIMER_MODE_REL);
+		hrtimer_start(&dum_hcd->timer, ns_to_ktime(0), HRTIMER_MODE_REL_SOFT);
 
 	spin_unlock_irqrestore(&dum_hcd->dum->lock, flags);
 	return rc;
@@ -1995,7 +1995,7 @@ static enum hrtimer_restart dummy_timer(struct hrtimer *t)
 		dum_hcd->udev = NULL;
 	} else if (dum_hcd->rh_state == DUMMY_RH_RUNNING) {
 		/* want a 1 msec delay here */
-		hrtimer_start(&dum_hcd->timer, ns_to_ktime(DUMMY_TIMER_INT_NSECS), HRTIMER_MODE_REL);
+		hrtimer_start(&dum_hcd->timer, ns_to_ktime(DUMMY_TIMER_INT_NSECS), HRTIMER_MODE_REL_SOFT);
 	}
 
 	spin_unlock_irqrestore(&dum->lock, flags);
@@ -2389,7 +2389,7 @@ static int dummy_bus_resume(struct usb_hcd *hcd)
 		dum_hcd->rh_state = DUMMY_RH_RUNNING;
 		set_link_state(dum_hcd);
 		if (!list_empty(&dum_hcd->urbp_list))
-			hrtimer_start(&dum_hcd->timer, ns_to_ktime(0), HRTIMER_MODE_REL);
+			hrtimer_start(&dum_hcd->timer, ns_to_ktime(0), HRTIMER_MODE_REL_SOFT);
 		hcd->state = HC_STATE_RUNNING;
 	}
 	spin_unlock_irq(&dum_hcd->dum->lock);
@@ -2467,7 +2467,7 @@ static DEVICE_ATTR_RO(urbs);
 
 static int dummy_start_ss(struct dummy_hcd *dum_hcd)
 {
-	hrtimer_init(&dum_hcd->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	hrtimer_init(&dum_hcd->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_SOFT);
 	dum_hcd->timer.function = dummy_timer;
 	dum_hcd->rh_state = DUMMY_RH_RUNNING;
 	dum_hcd->stream_en_ep = 0;
@@ -2497,7 +2497,7 @@ static int dummy_start(struct usb_hcd *hcd)
 		return dummy_start_ss(dum_hcd);
 
 	spin_lock_init(&dum_hcd->dum->lock);
-	hrtimer_init(&dum_hcd->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	hrtimer_init(&dum_hcd->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_SOFT);
 	dum_hcd->timer.function = dummy_timer;
 	dum_hcd->rh_state = DUMMY_RH_RUNNING;
 
-- 
2.45.2


