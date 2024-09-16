Return-Path: <linux-kernel+bounces-330141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F14A0979A3E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 06:06:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B497E281DEA
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 04:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32F161F5F6;
	Mon, 16 Sep 2024 04:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G6WgjnEz"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2C717BD5;
	Mon, 16 Sep 2024 04:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726459605; cv=none; b=ApObNfNMWxey4xQV35tqsUTcpGsmq4mHpDk8FT/uggphWcZD3i+N4wMliqZuus5tc9xaKPoE8eelSqq2XpiyQYkNwGsbt+d4X7ua1CHtO8umQ7cl8PP5hoSHqIt3A0RiA5no0rrbMh2lEJGdGhRoikkMYXl/RoScOefWaIWV4XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726459605; c=relaxed/simple;
	bh=k3wl6th9v2xDtpO7yt7lewdTKlfXWNzyqZ8vkrok6QE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZAmuHcFIAuC7RRPSdr9ywtjikotzKbMxwY0xx94KF1J+nqZXrdu9Tb+auMFRd7ejSYDIBZR8ZPmLa5rqxU+Z3guCZzMZhEWto4N3QTyq8BDu0aAsaSys5feEinOuIKRS0S7LrppF6SQMeeozYuoqvbGT1I+izsEpS36AmxTJf70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G6WgjnEz; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7cd8803fe0aso2842277a12.0;
        Sun, 15 Sep 2024 21:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726459603; x=1727064403; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SxyoIYnHclGmezcPqNhJwWRMZgFqN7bon2JJ4oYPt5A=;
        b=G6WgjnEzOZ4XaKP1KhWvifqKW66q4jl826MptU6Yq2oCmQswQ8+2XkjsHGiT8XQqnn
         cIFFMg48NHdQ/XfMqVfKf2kOa7wJgauWQw4WDeBHX0afGmqTcd1C/RlHuuwyaztrRXdo
         TyzT6Xsuuz/zxf8cvxx7Q7439SBSxg8LxJ60jiN9xRfxKbDprTNqHmrzgxtyaX/iwUrw
         IZ8jJEeTFQRATia4CrZ1Q4oZ2s2zol9TrMv8mn6vezZmp6yWBxl4JoMF9hXS6B2Pk3b3
         K31cX9LNyvmZhq9aBpG+MVCCc5xKCUZk9WJR9uJPKeSCNkUCSlvmq986vhGLtUAJKhAj
         n/EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726459603; x=1727064403;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SxyoIYnHclGmezcPqNhJwWRMZgFqN7bon2JJ4oYPt5A=;
        b=h7nHgmVbz7Wzg9Wan0yjybfUmYD9+hMEobYJigIW1L2sQEYPXxs2Tw22j8zEM9j9Wb
         dFGFI7J8GEBrlpj/PAHwtGHVU6kOKQNktfidoCl7tIOipqP8ppwxf9hFDTl1rdYF+mlk
         81isBLxe5RJY/7/FWiG/JuyqoiGaiQfO3kvTgERrZzCND3tlf7nlTJXmjhme9Nj6sjrn
         5PeQ2VcUAlGJ1/Yy1/9Q7dqIbP21/58Na/dIuAfuPA/rRIGDzKvu3yBHBxq5kK7+pOs1
         IhSubEz65MeGO5ZeVB7YVlC5ViT0jymGT7z3oRIj1oB4KhUJqJvlfRrWaKgmtG6QuTd4
         MfdQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3sEevAevLdnxLaqFGA1HV9n5wQ7My/Ac50fgMsbWY09bW9VYEo0Ijoyes7Krl0C0puqC4KyCOTGXzIkA=@vger.kernel.org, AJvYcCVU7SWEZ1YhoVUg+oI8NxSVTHqqXt/CC4Y4PADZm7+/nJybxW1WpIAQ2zu9uIx3qve3qtcrk3GQ06iO@vger.kernel.org
X-Gm-Message-State: AOJu0YzkjUMdH7tU+M3XTp55ROGssvN45eTAc4WPhHWxs2/lsCbxgbkl
	q0w4UITUiAHAKB1Hne/uWBxQq2Pbpm/62MCgwVbdc1V4q+lhk6PV+qpWiv8U
X-Google-Smtp-Source: AGHT+IGIrvTG4rxcu0rMuqtYiO6D2xED+z4HCXdA1tX3SG/V4ptDMncNXfvuFIdfwQqI1zkp+I6VrQ==
X-Received: by 2002:a05:6a21:4d8c:b0:1cf:6c64:ee6b with SMTP id adf61e73a8af0-1cf75f0f139mr18721512637.27.1726459603102;
        Sun, 15 Sep 2024 21:06:43 -0700 (PDT)
Received: from kernelexploit-virtual-machine.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7db498d9845sm3397058a12.9.2024.09.15.21.06.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Sep 2024 21:06:42 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: gregkh@linuxfoundation.org
Cc: colin.i.king@gmail.com,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jeongjun Park <aha310510@gmail.com>
Subject: [PATCH] usb: use mutex_lock in iowarrior_read()
Date: Mon, 16 Sep 2024 13:06:29 +0900
Message-Id: <20240916040629.28750-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, iowarrior_read() does not provide any protection for the
iowarrior structure, so the iowarrior structure is vulnerable to data-race.

Therefore, I think it is appropriate to protect the structure using
mutex_lock in iowarrior_read().

Fixes: 946b960d13c1 ("USB: add driver for iowarrior devices.")
Signed-off-by: Jeongjun Park <aha310510@gmail.com>
---
 drivers/usb/misc/iowarrior.c | 42 +++++++++++++++++++++++++++---------
 1 file changed, 32 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/misc/iowarrior.c b/drivers/usb/misc/iowarrior.c
index 6d28467ce352..7f3d37b395c3 100644
--- a/drivers/usb/misc/iowarrior.c
+++ b/drivers/usb/misc/iowarrior.c
@@ -277,28 +277,41 @@ static ssize_t iowarrior_read(struct file *file, char __user *buffer,
 	struct iowarrior *dev;
 	int read_idx;
 	int offset;
+	int retval = 0;
 
 	dev = file->private_data;
 
+	if (!dev) {
+		retval = -ENODEV;
+		goto exit;
+	}
+
+	mutex_lock(&dev->mutex);
 	/* verify that the device wasn't unplugged */
-	if (!dev || !dev->present)
-		return -ENODEV;
+	if (!dev->present) {
+		retval = -ENODEV;
+		goto unlock_exit;
+	}
 
 	dev_dbg(&dev->interface->dev, "minor %d, count = %zd\n",
 		dev->minor, count);
 
 	/* read count must be packet size (+ time stamp) */
 	if ((count != dev->report_size)
-	    && (count != (dev->report_size + 1)))
-		return -EINVAL;
+	    && (count != (dev->report_size + 1))) {
+		retval = -EINVAL;
+		goto unlock_exit;
+	}
 
 	/* repeat until no buffer overrun in callback handler occur */
 	do {
 		atomic_set(&dev->overflow_flag, 0);
 		if ((read_idx = read_index(dev)) == -1) {
 			/* queue empty */
-			if (file->f_flags & O_NONBLOCK)
-				return -EAGAIN;
+			if (file->f_flags & O_NONBLOCK) {
+				retval = -EAGAIN;
+				goto unlock_exit;
+			}
 			else {
 				//next line will return when there is either new data, or the device is unplugged
 				int r = wait_event_interruptible(dev->read_wait,
@@ -309,28 +322,37 @@ static ssize_t iowarrior_read(struct file *file, char __user *buffer,
 								  -1));
 				if (r) {
 					//we were interrupted by a signal
-					return -ERESTART;
+					retval = -ERESTART;
+					goto unlock_exit;
 				}
 				if (!dev->present) {
 					//The device was unplugged
-					return -ENODEV;
+					retval = -ENODEV;
+					goto unlock_exit;
 				}
 				if (read_idx == -1) {
 					// Can this happen ???
-					return 0;
+					goto unlock_exit;
 				}
 			}
 		}
 
 		offset = read_idx * (dev->report_size + 1);
 		if (copy_to_user(buffer, dev->read_queue + offset, count)) {
-			return -EFAULT;
+			retval = -EFAULT;
+			goto unlock_exit;
 		}
 	} while (atomic_read(&dev->overflow_flag));
 
 	read_idx = ++read_idx == MAX_INTERRUPT_BUFFER ? 0 : read_idx;
 	atomic_set(&dev->read_idx, read_idx);
+	mutex_unlock(&dev->mutex);
 	return count;
+
+unlock_exit:
+	mutex_unlock(&dev->mutex);
+exit:
+	return retval;
 }
 
 /*
--

