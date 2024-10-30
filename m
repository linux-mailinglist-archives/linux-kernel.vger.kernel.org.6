Return-Path: <linux-kernel+bounces-388196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E88D69B5BDE
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 07:39:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D2221F21D84
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 06:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57FBE1D86E8;
	Wed, 30 Oct 2024 06:39:23 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1791D7984
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 06:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730270362; cv=none; b=Iv4MRo2M45T5uDOVCHNlWLVqhlmKCYYhYGGOMWPUJ2Wwtg3jk0OuVyiVX78PHeQfJ5vrkYLIoqJ5dQ6WEkbIzoN4EU1sgnxyFG1fxg2PU83mT2YHq9eaCv+JAwF0+uTYstee8lyAqwIawbGTp/dtTbZOgsvVStdTWZzkKj+5f3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730270362; c=relaxed/simple;
	bh=Iz4PJvwnoVM+lZc3cunWDx14lz8EsUiZH5MfThPDmWA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=OU1XtjLnSccslu65Po5ZjB33mjm5khH/nFCyxvswrHulHyNeXz/Y5VH+AVhNlHHJGw83F5tsB0ZvTyb/bI4qrRRI7PW1Ei7nUpfGUW0cnq9LWJsWX0H4xpomQDzW4fYmmeKZaxjYRawV25ouxdviQZ3YEHW6zn3VfjXWdJLx3fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-83acb657f91so585186339f.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 23:39:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730270360; x=1730875160;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WiNmaXT0ZrpACBW2FPB0Q3K0IGuXSBjbvppvGxGVBSA=;
        b=gzvqOGYf2iMj7ax/vygqZJOX9trWQJWGyCI1YIvavmglGz1oDwtVPbPome6BE3/c7N
         NGqA+okiuXA8/OruZ2h/8ISgC+5DXZQGFccVTgRAl4c45SwfRRwntwR8Wboy9ALgKhAd
         eSTuF4Tl4eC1bvU5hmXEvucl1hyRhbkevpYBXkCag5L2dLiPDFrxt/6HKRLjlOWvm8iN
         Rky3+uB66sH+eyNkX7m0FY2t70ofUSEG5zTH7EfrklDd0/k2dj4mC+vE7O1tAN7gYASd
         cUdwXMMJDC0jV+myWXVpEJ6pT2t7JveNTcm+ZY8T8hGuhTTPh12O/5mkG2d4yZP88DVl
         O9gQ==
X-Gm-Message-State: AOJu0YznPi5YElC2Q50L5Oo3jyxARJkvpT9OVKzejV/2DwBda+E5s4TR
	tH4TeQEfnFrsrxe+wtxjf5q97XryD3ciQLmkcddkEiQnesZNVNKAs6YWMimhMR67/4eRXKjBuCE
	KkaYqe3xecIW3slG3hrlChjhvydZYq9ZQzHiuPn/8d8+EbKrGmvkck9I=
X-Google-Smtp-Source: AGHT+IHO4Lo+2+dAx19U7UrqbjqjR/eCh9jhvxYMQZNNLHMAFwtenNWND4v6kLrazosXZafTaymz2kzwhrp1Z7tR2CNrbVWt9u//
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a8f:b0:3a3:b3f4:af42 with SMTP id
 e9e14a558f8ab-3a4ed28ee11mr140077265ab.7.1730270359862; Tue, 29 Oct 2024
 23:39:19 -0700 (PDT)
Date: Tue, 29 Oct 2024 23:39:19 -0700
In-Reply-To: <0000000000003c68f3061fd2c285@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6721d497.050a0220.35b515.0001.GAE@google.com>
Subject: Re: [syzbot] [PATCH] usb: raw_gadget: Fix a KMSAN double free bug in raw_release
From: syzbot <syzbot+3e563d99e70973c0755c@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: [PATCH] usb: raw_gadget: Fix a KMSAN double free bug in raw_release
Author: marcus.yu.56@gmail.com

#syz test

syzkaller reported a double free bug
(https://syzkaller.appspot.com/bug?extid=3e563d99e70973c0755c) in
raw_release. Specifically, if there are concurrent calls to raw_release
and dev->gadget_registered is false, there will be racing kref_put
calls causing dev_free to be invoked twice.

The fix is to check ref count and put under lock so that kref_put is
called at most once.

The "unregister" path is safe because checking dev->gadget_registered
and then flipping it to false under lock guarantees that this branch is
taken at most once.

Signed-off-by: Chang Yu <marcus.yu.56@gmail.com>
Reported-by: syzbot+3e563d99e70973c0755c@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=3e563d99e70973c0755c
Fixes: f2c2e717642c ("usb: gadget: add raw-gadget interface")
---
 drivers/usb/gadget/legacy/raw_gadget.c | 27 ++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/drivers/usb/gadget/legacy/raw_gadget.c b/drivers/usb/gadget/legacy/raw_gadget.c
index 112fd18d8c99..3da022aae830 100644
--- a/drivers/usb/gadget/legacy/raw_gadget.c
+++ b/drivers/usb/gadget/legacy/raw_gadget.c
@@ -445,7 +445,6 @@ static int raw_release(struct inode *inode, struct file *fd)
 	int ret = 0;
 	struct raw_dev *dev = fd->private_data;
 	unsigned long flags;
-	bool unregister = false;
 
 	spin_lock_irqsave(&dev->lock, flags);
 	dev->state = STATE_DEV_CLOSED;
@@ -453,20 +452,24 @@ static int raw_release(struct inode *inode, struct file *fd)
 		spin_unlock_irqrestore(&dev->lock, flags);
 		goto out_put;
 	}
-	if (dev->gadget_registered)
-		unregister = true;
+	if (!dev->gadget_registered) {
+		if (kref_read(&dev->count)) {
+			/* Matches dev_new() in raw_open(). */
+			kref_put(&dev->count, dev_free);
+		}
+		spin_unlock_irqrestore(&dev->lock, flags);
+		return ret;
+	}
 	dev->gadget_registered = false;
 	spin_unlock_irqrestore(&dev->lock, flags);
 
-	if (unregister) {
-		ret = usb_gadget_unregister_driver(&dev->driver);
-		if (ret != 0)
-			dev_err(dev->dev,
-				"usb_gadget_unregister_driver() failed with %d\n",
-				ret);
-		/* Matches kref_get() in raw_ioctl_run(). */
-		kref_put(&dev->count, dev_free);
-	}
+	ret = usb_gadget_unregister_driver(&dev->driver);
+	if (ret != 0)
+		dev_err(dev->dev,
+			"usb_gadget_unregister_driver() failed with %d\n",
+			ret);
+	/* Matches kref_get() in raw_ioctl_run(). */
+	kref_put(&dev->count, dev_free);
 
 out_put:
 	/* Matches dev_new() in raw_open(). */
-- 
2.47.0


