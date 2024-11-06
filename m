Return-Path: <linux-kernel+bounces-397604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A482A9BDDE7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 05:12:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E60928506B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 04:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C49771917EE;
	Wed,  6 Nov 2024 04:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qqc/Jouw"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39181917CE;
	Wed,  6 Nov 2024 04:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730866312; cv=none; b=ZBubmAiYwbix3u72v1+nQCbUUDOtEzFKm7kSMiDly+Ntu9sOKboBr6+A6LY28Y88kWT+guQB+7E6n9LjXRQPHHYMMtPjPlardmEbZaGZwHnNbzUExYfFkfeGlZ8fKZ0w/cqKKpK+j/KTCxJ8yktLixocn/Qo1THh7r5gEuH82NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730866312; c=relaxed/simple;
	bh=XkFnXu3Nbs+LBYkhmSZDcZZRbbQQ1gwS6Y0z4RTJorQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=NMCJKhnMTvO/KFSwbsJpb6YzB3W/1Ob9/JoBpUCro4AIL+X01YW/Uv+nq4oQTB8vrfwjiQCADRZXmvbEpqLZ4qIY9XNKJ9XYBWJ+3vBHLCt7KVIexS39G2VqRWYY2mro6t1OHTUNQzYdD7lMV08zDUSDiwoUmKR6RY3uz4cQ104=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qqc/Jouw; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7ed9c16f687so4325231a12.0;
        Tue, 05 Nov 2024 20:11:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730866310; x=1731471110; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NNft/kQrWN+6wLuYAR1EXFuR73F5xeJoDqmeVVt2J3s=;
        b=Qqc/JouwoRYBCc79EbQze2hfIZyWmgAF1aqg8dZwQwuhcOMeihjwlU4pSm76Ic+mlD
         2++V20D34WWHAuWqS7wOE/VkbFCe5fG2l8hvc5/JtsmQT6DhdQu1Cjo71fpz+kRhD2QG
         ZZij48J2HP/BNBgFdNHnORJNeaZpd76UBdB5WfHDxUIqKMtnyjNOMDSF5TOPfNTFiNXZ
         5ZGeizBkhjdstUmMk7FKP25tdfvCMkATIS1Cm/Q7Rf7RcOey1XOOPilmENSdu1WhYJoR
         5xg90dP904T1bevGU1/onXGIIPAdWeUmOeK/XLos+aZ/yJGRuWd48GFB8nXZsfGvGqxZ
         Hmzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730866310; x=1731471110;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NNft/kQrWN+6wLuYAR1EXFuR73F5xeJoDqmeVVt2J3s=;
        b=Ix94tSVaF5vkxPsZo4++0X4AWZZZLTVUjn5gcAq83KxcMMLjl8uGTGwCzZURwbaSyo
         zPtzzrqZGWzdt6OaKbMFpVWcKL4v9GwSiQQKYATnS+k4bU71K83UT/WAFCFbbIRlKr1U
         p1iFVuMGLPGsJoKC3QwNKhN9VSTUgpXpGzO6h3AmTHXEOWKRl5YMTcC1/iwBqcILLdzO
         ohKpBucs/9GPhSrwUt7XVshT524EWzfvyr9FAsOJxKlaFotvlNjTtimR4uxS8ij63FE9
         xq8QvofOi+QDTUxGiRswChu6maTdG+NuYfBxJtv89vbgQMZxGywcvKp6fQx1H1LQ1R2K
         Ggqw==
X-Forwarded-Encrypted: i=1; AJvYcCVK25WSEgSrkdA0NKQ0kZbPNQgQouaWiRwBB6icsdswlXnKBftrEC3HX9G4Ap7D3XdHLbFN5weNmXN0@vger.kernel.org, AJvYcCXiuI3cjysVtOIpqRRyxU2PGjCsJZ1gD0au0cG8NvPd7BTySwcJV1ZO8ymn3M4ZRG3dQ8uhOsn3Jy20moc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7t8QWWh4LVbcC5JyXAuheIyG1Lh4c7znLHjuYC24jkETXIbbV
	QZRf7htbzYFo4JqOT/m9HTQ94yb4e9tZdbk1nvVhEVphEcjJCGCz
X-Google-Smtp-Source: AGHT+IE8B4L179M7UCSeRqYieIZg2ubmeuJoXZEdLuYX3aeNZwbrJcGxdxrOeJ94IQhyAU/+GlIUoQ==
X-Received: by 2002:a17:90b:1c8a:b0:2e2:e4d3:3401 with SMTP id 98e67ed59e1d1-2e93c174c7bmr30756891a91.20.1730866309829;
        Tue, 05 Nov 2024 20:11:49 -0800 (PST)
Received: from gmail.com ([24.130.68.0])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e99a580662sm385069a91.24.2024.11.05.20.11.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 20:11:49 -0800 (PST)
Date: Tue, 5 Nov 2024 20:11:47 -0800
From: Chang Yu <marcus.yu.56@gmail.com>
To: andreyknvl@gmail.com
Cc: gregkh@linuxfoundation.org, viro@zeniv.linux.org.uk,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stern@rowland.harvard.edu, skhan@linuxfoundation.org,
	marcus.yu.56@gmail.com,
	syzbot+3e563d99e70973c0755c@syzkaller.appspotmail.com
Subject: [PATCH] usb: raw_gadget: Add debug logs to a troubleshoot a
 double-free bug in raw_release.
Message-ID: <Zyrsg3bvNu1rswqb@gmail.com>
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

From the stack traces it looks like either raw_release was invoked
twice or there were some between kref_get in raw_ioctl_run and
kref_put raw_release. But these should not be possible. We need
more logs to understand the cause.

Make raw_release and raw_ioctl_run report the ref count before
and after get/put to help debug this.

Signed-off-by: Chang Yu <marcus.yu.56@gmail.com>
Reported-by: syzbot+3e563d99e70973c0755c@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?extid=3e563d99e70973c0755c
---
 drivers/usb/gadget/legacy/raw_gadget.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/usb/gadget/legacy/raw_gadget.c b/drivers/usb/gadget/legacy/raw_gadget.c
index 112fd18d8c99..ac4e319c743f 100644
--- a/drivers/usb/gadget/legacy/raw_gadget.c
+++ b/drivers/usb/gadget/legacy/raw_gadget.c
@@ -194,6 +194,8 @@ static struct raw_dev *dev_new(void)
 		return NULL;
 	/* Matches kref_put() in raw_release(). */
 	kref_init(&dev->count);
+	dev_dbg(dev->dev, "%s kref count initialized: %d\n",
+		__func__, kref_read(&dev->count));
 	spin_lock_init(&dev->lock);
 	init_completion(&dev->ep0_done);
 	raw_event_queue_init(&dev->queue);
@@ -464,13 +466,21 @@ static int raw_release(struct inode *inode, struct file *fd)
 			dev_err(dev->dev,
 				"usb_gadget_unregister_driver() failed with %d\n",
 				ret);
+		dev_dbg(dev->dev, "%s kref count before unregister driver put: %d\n",
+				__func__, kref_read(&dev->count));
 		/* Matches kref_get() in raw_ioctl_run(). */
 		kref_put(&dev->count, dev_free);
+		dev_dbg(dev->dev, "%s kref count after unregister driver put: %d\n",
+				__func__, kref_read(&dev->count));
 	}
 
 out_put:
+	dev_dbg(dev->dev, "%s kref count before final put: %d\n",
+			__func__, kref_read(&dev->count));
 	/* Matches dev_new() in raw_open(). */
 	kref_put(&dev->count, dev_free);
+	dev_dbg(dev->dev, "%s kref count after final put: %d\n",
+			__func__, kref_read(&dev->count));
 	return ret;
 }
 
@@ -603,8 +613,12 @@ static int raw_ioctl_run(struct raw_dev *dev, unsigned long value)
 	}
 	dev->gadget_registered = true;
 	dev->state = STATE_DEV_RUNNING;
+	dev_dbg(dev->dev, "%s kref count before get: %d\n",
+			__func__, kref_read(&dev->count));
 	/* Matches kref_put() in raw_release(). */
 	kref_get(&dev->count);
+	dev_dbg(dev->dev, "%s kref count after get: %d\n",
+			__func__, kref_read(&dev->count));
 
 out_unlock:
 	spin_unlock_irqrestore(&dev->lock, flags);
-- 
2.47.0


