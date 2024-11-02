Return-Path: <linux-kernel+bounces-393594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B61979BA2C2
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 23:36:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75678282667
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 22:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5BE11AAE33;
	Sat,  2 Nov 2024 22:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mKq6tEUd"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4EDB1448E3;
	Sat,  2 Nov 2024 22:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730586970; cv=none; b=dOvld+BCN20xjPVGuAj2H1AE9v6cEPEtZ+AsK9q2epoXQaKH0VDyHkC6RBgMfaZtdL5PNHHpxaIteynQ+QFUr1wpR36gaZR7UN2aRwCsCz0oI9M1UmMQQRutLxKzRKzhHbVGgOYOPsBcaQhqLVc+OaFk3QhFrb82zgHNCJCjtiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730586970; c=relaxed/simple;
	bh=mwHBxMf7a3juFKJ7kHW2dew6ogV9YEE7i2OwP3DfDMI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=miY83Pq41o46pmAoZNsp91ymcf30d0SYKNmOd4xS7IgE2MKAtQMdbjhoqZht+7ZTF4UZ3JXV2FvASmAUFPHzcxRfbWXniualiDgQ2ipc2h0+xkWghkbWE1W2LLTmwUC2H+GQR/dWMsPMDeDrScAofZbSiE5bdnVNKWnW8m771Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mKq6tEUd; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-71ec997ad06so2566527b3a.3;
        Sat, 02 Nov 2024 15:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730586968; x=1731191768; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nsvgdFa2QQsuo7kLs9myF9/L4nMgfr6Gbvr3NEv0t9o=;
        b=mKq6tEUdkRLXtxdI4KiaWomEakHGJYMGs5lUawD0z+qZqXOi2RLcXDb97WLEg0XTBB
         bYa1kFq236JH2P+WPkvygLlWHIrLI7Bvya+HzzKhy/QVtIemXKZB3WXJDFNj3KYmwarb
         z6UyXK3iE40gFWHLlmg4X4DzAbFXQDBgrV2ilf4S76zV/3VPRSSHaaKm0tFJ7tgvk9VT
         ZJ57CvZG/ky0FzuvnRI5RyfYGzXGzlPw2hyPFafd+w2iVorE33mKL8egSMzkGJOMvD+D
         Rbx0nRmPk0yoNRANFWcPE6j1SVwLA029OwjTIAIu71+QspjPYcMeeaqHA1+Eykm5mOF0
         fJNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730586968; x=1731191768;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nsvgdFa2QQsuo7kLs9myF9/L4nMgfr6Gbvr3NEv0t9o=;
        b=mRJTXAAOXxW2EbuFyIxcQ2HUMC8Va0tkNvYXIP8lA86D81Ba2JivMWT1/eqdjQ8Jiq
         LmT53/iQB9G217OcshWSuV0GiUuSi2naQvgTJT+SXMMXyBwP1mHMkaAnT6yWEGtqKgBB
         Tps2VxBqkgB60cLu7GJpEu0efD3C8VxfPAejWkBE+ihNc84H6f7XZfm8TTzTcf0FC49K
         t53ao0w7rv9nf4spTWVR7cyyJzC4pkxT32Iz4P81rxVJCwSft8mbHFlYhBLH8BDJe3hu
         JTD+mDs49zD2417nwJAINpWjqk7kLNfXCkvRaN0a50K+m2A/e9NUugQamijeixeOPrf4
         IK+g==
X-Forwarded-Encrypted: i=1; AJvYcCURxnEgkIfZPJaWlX2DskRgLs5UUc9no87s9Dz+3HdN+YzMdhXUAEuOLdnC5rfIdWxuCzE9TjWbjy3t@vger.kernel.org, AJvYcCWYFgT5gZI6tnMqRp1CBDX/Ge4f7TrvI8O3ZRmIBCyJVC7NxcAWkuJEJU7zDhkfNegERnYerB+tAfEbZVE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxI7zvOMZJmGXu1RTF7t+jlDZ8axCrb+AspHBy0qWrH1Vtua42z
	sFOHQNFMsovi8JWLrCqZKFZ13o1BJK4ifXrI64x1ZQals6/oJWGs
X-Google-Smtp-Source: AGHT+IGyJtvM7CUeHXDJcpGo1thqAWdmHhwVu7nI3oeJWklq0dMGiT0eLp2FpIeZZmKN2a6FjMAutg==
X-Received: by 2002:a05:6a21:e8b:b0:1d9:1f51:faeb with SMTP id adf61e73a8af0-1d9eee1e0bfmr19184510637.39.1730586967762;
        Sat, 02 Nov 2024 15:36:07 -0700 (PDT)
Received: from gmail.com ([24.130.68.0])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc2eb6a5sm4820348b3a.144.2024.11.02.15.36.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Nov 2024 15:36:07 -0700 (PDT)
Date: Sat, 2 Nov 2024 15:36:05 -0700
From: Chang Yu <marcus.yu.56@gmail.com>
To: andreyknvl@gmail.com
Cc: gregkh@linuxfoundation.org, viro@zeniv.linux.org.uk,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org, marcus.yu.56@gmail.com
Subject: [PATCH] usb: raw_gadget: Fix a KASAN double-free bug in raw_release
Message-ID: <ZyapVdMqauFmeeng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

syzkaller reported a double free bug
(https://syzkaller.appspot.com/bug?extid=3e563d99e70973c0755c) in
raw_release.

I suspect this is because a race between raw_release and
raw_ioctl_run. While kref_get in raw_ioctl_run is protected by
the spin lock, all kref_put in raw_release are not under the
lock. This makes it possible that a kref_put might occur during
kref_get, which is specifically prohibited by the kref
documentation[1].

The fix is to ensure that all kref_put calls are made under lock
and that we only call kfree(dev) after releasing the lock.

[1] https://docs.kernel.org/core-api/kref.html

Signed-off-by: Chang Yu <marcus.yu.56@gmail.com>
Reported-by: syzbot+3e563d99e70973c0755c@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=3e563d99e70973c0755c
Fixes: f2c2e717642c ("usb: gadget: add raw-gadget interface")
---
 drivers/usb/gadget/legacy/raw_gadget.c | 44 ++++++++++++++------------
 1 file changed, 24 insertions(+), 20 deletions(-)

diff --git a/drivers/usb/gadget/legacy/raw_gadget.c b/drivers/usb/gadget/legacy/raw_gadget.c
index 112fd18d8c99..0c01d491d489 100644
--- a/drivers/usb/gadget/legacy/raw_gadget.c
+++ b/drivers/usb/gadget/legacy/raw_gadget.c
@@ -225,7 +225,6 @@ static void dev_free(struct kref *kref)
 		kfree(dev->eps[i].ep->desc);
 		dev->eps[i].state = STATE_EP_DISABLED;
 	}
-	kfree(dev);
 }
 
 /*----------------------------------------------------------------------*/
@@ -330,7 +329,8 @@ static void gadget_unbind(struct usb_gadget *gadget)
 
 	set_gadget_data(gadget, NULL);
 	/* Matches kref_get() in gadget_bind(). */
-	kref_put(&dev->count, dev_free);
+	if (kref_put(&dev->count, dev_free))
+		kfree(dev);
 }
 
 static int gadget_setup(struct usb_gadget *gadget,
@@ -443,34 +443,38 @@ static int raw_open(struct inode *inode, struct file *fd)
 static int raw_release(struct inode *inode, struct file *fd)
 {
 	int ret = 0;
+	int freed = 0;
 	struct raw_dev *dev = fd->private_data;
 	unsigned long flags;
-	bool unregister = false;
 
 	spin_lock_irqsave(&dev->lock, flags);
 	dev->state = STATE_DEV_CLOSED;
-	if (!dev->gadget) {
-		spin_unlock_irqrestore(&dev->lock, flags);
-		goto out_put;
-	}
-	if (dev->gadget_registered)
-		unregister = true;
+	if (!dev->gadget)
+		goto out_put_locked;
+	if (!dev->gadget_registered)
+		goto out_put_locked;
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
+
+	spin_lock_irqsave(&dev->lock, flags);
+	/* Matches kref_get() in raw_ioctl_run(). */
+	freed = kref_put(&dev->count, dev_free);
+	if (freed)
+		goto out_free_dev;
 
-out_put:
+out_put_locked:
 	/* Matches dev_new() in raw_open(). */
-	kref_put(&dev->count, dev_free);
+	freed = kref_put(&dev->count, dev_free);
+out_free_dev:
+	spin_unlock_irqrestore(&dev->lock, flags);
+	if (freed)
+		kfree(dev);
 	return ret;
 }
 
-- 
2.47.0


