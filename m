Return-Path: <linux-kernel+bounces-443466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AE149EF105
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 17:34:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAC5129EACB
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 16:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28270238E1F;
	Thu, 12 Dec 2024 16:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fPW4Urkw"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E493D23874D
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 16:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734020600; cv=none; b=kM8VrXNZYoII4dgm7ko+8z5tLaQig1zWRyau5vkrfc/h8TI95kFGnYGgguqnsOI07La88EBEf9NJL99NaanpQnEMZWVWC631tY+5wBFLw5yBHlRg6OA2IzKwUiQsIzwDBwW/n95eljK/kix55k7MJGviR1J0YWz2Y3bCu0mAL0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734020600; c=relaxed/simple;
	bh=IzklbWzy9pJje/+zq7AmwrNbl70oVhHVRnM3SQomDbM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BWxvQ+zwZOd9b4PjyO8jry6VGxpnYHHUelq7HG0MrzIEL8e80HUMsMi3P5XsW1/0ZsfXLwdqiK3qDQp+OxpIOgPQ1SzIMeLEOGUlGxfihrB5loB8Dcfcw/D8S/FjGZj7XbVkq4OUDW/hOwR2tWJsTFabQcfWdj6VoQuQwi14iiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fPW4Urkw; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-216395e151bso5434815ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 08:23:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734020598; x=1734625398; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bq/tKrrwiZQZ2snWS/YijPFN2wQqiF36DpzF3YYYeY8=;
        b=fPW4UrkwO6z2hbgoYf4lU+qrH/UdIfCEHyUfYpLno4GNGK7cBKdgKwvucrVVeA8Sc1
         6b+x/zvNw6QGiQi78SliHgFzJKVuZ6eVwabO0trU6dkS4L5kujU+JZmGonis3Pao5Vig
         khEyzN1ZSntZHxl7+38yQeZeWvxp+mhAk+AZOhB6o+hABkWRyjZPGN/FkdzKIJ5UW0ia
         3j9J3XCsBhkKMqq3eOeDoE/FzCeCNSkrpZ/Yb0ZzWY0bWp/nnHpE4CJ3hPqohhuez5Ys
         0Q/s40jPDM90fF1e/c1WMRGYDyc3eHwmsVla+b5JIWJznYyGXhA7TObbLDhqosUOwV/J
         5fDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734020598; x=1734625398;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bq/tKrrwiZQZ2snWS/YijPFN2wQqiF36DpzF3YYYeY8=;
        b=ei5I+YqJSRaBfo2ilnZAWkwj+uDdNxieG32YIejnYhaVQGWEcko8Q+08h8J2st/P+R
         CxLwKw5BQNLz7SLjVuXYZatC/OIibtkDS6BGStHR8TJu7VI8CDmFZgvTkDJLtRFAxFAL
         1ATg7mHWILgmzwKnIjWsGbOM7lNMAz511krp3KAULcGDDIAzmwUm+uUvLnOTHcO91Xth
         omcPE7IJ/QhU1lDmWEaY8QtEfBB/KDO+N2Ey3+wWXxlHKcFhjlDeyAKRn6htKpR8Eo5Y
         qa8OIq4DrF6AC3IQC3OrxfkiHOp2yrt/0LRR3qHC4P5UaZteJZUfF7aIr9UiajxDZiny
         8c1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVkgOxMi+j1a89q9Siyyp3D0yCdKzgK/HonTV+wGutH0kdKNuKmxF2vG8kxt5oZAciQUsYijALsTP9DNMI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBMsVMgOj0f54knMeBhuFaNXSdKCThTw63TD+57b14WQrA4vNW
	S91VU7QYNfwI3kwJkq+eCFlnkm0blSNck5V7YPhuHZJZyKMiZqwF
X-Gm-Gg: ASbGncvGB7q9cI24XNF7ItJcptqdlxsTQtTJAVt0T4rPHNpu1cS7VEnU8p3eFydESui
	Ccn5e5Z/4GLn9Jj+6bqQZVI0H7i15uGPjxDlkIninyQpsHDOnhamsE7AV6X568MLMTATzjauLCx
	QbNfMr20Qxp2UWOF1eKuEKUh/K74M+s3b8WRINR5v49VSmw3MUnJXA9fXXUB9FAB4NgWBArAIpZ
	P7R4dHycFxK5gv/ocu/Jae6ZeQZegXk4dKrtScMXXlsAdJmoYgZuWlGRXgReFnYyV0rFQ==
X-Google-Smtp-Source: AGHT+IFDSdz3HsqecrqzbH4bwfGPjStZ3BmAF/QNIlVOG4Eq1G9A0y1LMHnGeH2BBI8c3HCpEQbfzw==
X-Received: by 2002:a17:902:fc48:b0:216:59f1:c7d9 with SMTP id d9443c01a7336-2178c87873emr51058945ad.19.1734020598109;
        Thu, 12 Dec 2024 08:23:18 -0800 (PST)
Received: from localhost.localdomain ([101.0.62.135])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-216356f24d8sm85058595ad.242.2024.12.12.08.23.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 08:23:17 -0800 (PST)
From: eisantosh95@gmail.com
To: 
Cc: eisantosh95@gmail.com,
	Dave Penkler <dpenkler@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	"Everest K.C." <everestkc@everestkc.com.np>,
	Kees Bakker <kees@ijzerbout.nl>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] staging: gpib: Replace semaphore with completion for one-time signaling
Date: Thu, 12 Dec 2024 21:51:04 +0530
Message-Id: <20241212162112.13083-1-eisantosh95@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Santosh Mahto <eisantosh95@gmail.com>

Replaced 'down_interruptible()' and 'up()' calls
with 'wait_for_completion_interruptible()' and
'complete()' respectively. The completion API
simplifies the code and adheres to kernel best
practices for synchronization primitive

Signed-off-by: Santosh Mahto <eisantosh95@gmail.com>
---
 drivers/staging/gpib/ni_usb/ni_usb_gpib.c | 16 ++++++++--------
 drivers/staging/gpib/ni_usb/ni_usb_gpib.h |  2 +-
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/gpib/ni_usb/ni_usb_gpib.c b/drivers/staging/gpib/ni_usb/ni_usb_gpib.c
index b7b6fb1be379..70b8b305e13b 100644
--- a/drivers/staging/gpib/ni_usb/ni_usb_gpib.c
+++ b/drivers/staging/gpib/ni_usb/ni_usb_gpib.c
@@ -85,7 +85,7 @@ static void ni_usb_bulk_complete(struct urb *urb)
 
 //	printk("debug: %s: status=0x%x, error_count=%i, actual_length=%i\n",  __func__,
 //		urb->status, urb->error_count, urb->actual_length);
-	up(&context->complete);
+	complete(&context->complete);
 }
 
 static void ni_usb_timeout_handler(struct timer_list *t)
@@ -94,7 +94,7 @@ static void ni_usb_timeout_handler(struct timer_list *t)
 	struct ni_usb_urb_ctx *context = &ni_priv->context;
 
 	context->timed_out = 1;
-	up(&context->complete);
+	complete(&context->complete);
 };
 
 // I'm using nonblocking loosely here, it only means -EAGAIN can be returned in certain cases
@@ -124,7 +124,7 @@ static int ni_usb_nonblocking_send_bulk_msg(struct ni_usb_priv *ni_priv, void *d
 	}
 	usb_dev = interface_to_usbdev(ni_priv->bus_interface);
 	out_pipe = usb_sndbulkpipe(usb_dev, ni_priv->bulk_out_endpoint);
-	sema_init(&context->complete, 0);
+	init_completion(&context->complete);
 	context->timed_out = 0;
 	usb_fill_bulk_urb(ni_priv->bulk_urb, usb_dev, out_pipe, data, data_length,
 			  &ni_usb_bulk_complete, context);
@@ -143,7 +143,7 @@ static int ni_usb_nonblocking_send_bulk_msg(struct ni_usb_priv *ni_priv, void *d
 		return retval;
 	}
 	mutex_unlock(&ni_priv->bulk_transfer_lock);
-	down(&context->complete);    // wait for ni_usb_bulk_complete
+	wait_for_completion(&context->complete);    // wait for ni_usb_bulk_complete
 	if (context->timed_out) {
 		usb_kill_urb(ni_priv->bulk_urb);
 		dev_err(&usb_dev->dev, "%s: killed urb due to timeout\n", __func__);
@@ -210,7 +210,7 @@ static int ni_usb_nonblocking_receive_bulk_msg(struct ni_usb_priv *ni_priv,
 	}
 	usb_dev = interface_to_usbdev(ni_priv->bus_interface);
 	in_pipe = usb_rcvbulkpipe(usb_dev, ni_priv->bulk_in_endpoint);
-	sema_init(&context->complete, 0);
+	init_completion(&context->complete);
 	context->timed_out = 0;
 	usb_fill_bulk_urb(ni_priv->bulk_urb, usb_dev, in_pipe, data, data_length,
 			  &ni_usb_bulk_complete, context);
@@ -231,7 +231,7 @@ static int ni_usb_nonblocking_receive_bulk_msg(struct ni_usb_priv *ni_priv,
 	}
 	mutex_unlock(&ni_priv->bulk_transfer_lock);
 	if (interruptible) {
-		if (down_interruptible(&context->complete)) {
+		if (wait_for_completion_interruptible(&context->complete)) {
 			/* If we got interrupted by a signal while
 			 * waiting for the usb gpib to respond, we
 			 * should send a stop command so it will
@@ -243,10 +243,10 @@ static int ni_usb_nonblocking_receive_bulk_msg(struct ni_usb_priv *ni_priv,
 			/* now do an uninterruptible wait, it shouldn't take long
 			 *	for the board to respond now.
 			 */
-			down(&context->complete);
+			wait_for_completion(&context->complete);
 		}
 	} else {
-		down(&context->complete);
+		wait_for_completion(&context->complete);
 	}
 	if (context->timed_out) {
 		usb_kill_urb(ni_priv->bulk_urb);
diff --git a/drivers/staging/gpib/ni_usb/ni_usb_gpib.h b/drivers/staging/gpib/ni_usb/ni_usb_gpib.h
index 9b21dfa0f3f6..4b297db09a9b 100644
--- a/drivers/staging/gpib/ni_usb/ni_usb_gpib.h
+++ b/drivers/staging/gpib/ni_usb/ni_usb_gpib.h
@@ -56,7 +56,7 @@ enum hs_plus_endpoint_addresses {
 };
 
 struct ni_usb_urb_ctx {
-	struct semaphore complete;
+	struct completion complete;
 	unsigned timed_out : 1;
 };
 
-- 
2.25.1


