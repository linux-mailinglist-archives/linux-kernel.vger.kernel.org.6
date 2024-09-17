Return-Path: <linux-kernel+bounces-331871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E284897B23D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 17:49:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A1FFB29A2A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 15:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 764851925B7;
	Tue, 17 Sep 2024 15:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W5I0mnN4"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27433175D57;
	Tue, 17 Sep 2024 15:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726587696; cv=none; b=jxd3UaPla4fuOoPixaJroDYOuSa986/CkUCbDSze4lvzVJG0uNstPWM0ykhhCvV6L31NpCJFI57O8vnJIcb3b6ZZzDWNIyMdFz3e7MPY1dD86j57lMHCbtY9I3QK6+LePNA/nZVGnW34F23dQSxcQBRTCFKrMtM8zJmava3k63o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726587696; c=relaxed/simple;
	bh=B95BDudSjFAy/R2H+SL/kqDBaib+V3s8HTtOB08FwEQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UPt0FjasRkuFOERg1O/Z/W5AKE0SKZi+MlVHxvu4cZrNeAnIyde+neQArOW0Crnsf8p7Gy3wHZWaqsOeP3oIKu2794C9GpZRP9xMxCIa/BXQDboEPjXzKkeGUXTTXzSa8ryFb1N7j3OHn9WwEQkBKlzjt2mtUhH8hHy1F/QezJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W5I0mnN4; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7db238d07b3so4607714a12.2;
        Tue, 17 Sep 2024 08:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726587672; x=1727192472; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zyMjeXu3OpqjGRYJSQIFTO8OVuBFAop/R2lwpRCjT10=;
        b=W5I0mnN4dnZqIjCLakqBDOSp0VOuVv3D+KBbgYNq7GUhEiNt2pB2qJxJrt4dWIkrDt
         HVRVD1ssc7MH6bjywqMXYCaNvQWqQj6lLU6fm/J/eUpRjmb4x09NxgBHcA8An8QgZZEY
         FDv8b3DIbECya3A/W5Xyg37/E6TD/STef5nJyh4+Lx2sNilV+m33tX6nw5lV/ER6SzXx
         kQBYy+DciTXEv/xb1ix5s68LG9s99AXeVkkSejXsC3XhrCNlj2vmGLoLCF6mOO2VA4gn
         DQ9pRKydj4o3iyuA0XkJohuaw7Jz1F41ve4aBQccmVsB6j0HRaaBz13QAJMFkU8eBKrH
         Yt3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726587672; x=1727192472;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zyMjeXu3OpqjGRYJSQIFTO8OVuBFAop/R2lwpRCjT10=;
        b=qYltnpAW3LI/TYauhalvxG9lRAfJh4mvvHuew22lSnUtFl6xlfm6Ks5G0esKxpjHTE
         WcTITmJXAN8oXeOq6kg6lvAO4okYCaPCSPw+cIMy2xyQdfZZSEsg92KLnES+LHPsRsH4
         Mrl6l1dmvoOiCWblawh4SSkviZJ73pfm/xe+Q1ePOq9e4dCRG0/yraBIa765YUs+EnNb
         PQMRwPCFQLljF+qSe3+NH9E/uQAe8jP1r7bfY+z4cjOkj8H8TVBPm+qH8m3aRAtQ92hg
         mH6Cx5XfDjSXwxlfoKf9+OneRH6GT0sonL+H08OMCZsBzpHG/8vRMS+qbs9aWuArWqDL
         ZVCg==
X-Forwarded-Encrypted: i=1; AJvYcCV33YcPu+/d+TvXo0CZPkpn8EPH8lxu1n4Phyf/J5ptbDdEOplRtIqx6ZYXiEer5xbsthN2Hdx6OlsoA8s=@vger.kernel.org, AJvYcCW7MxC4AyyXErg3MZLjs9GXHLBm875oNLVyy9zAFkFHo1U2cW6C1oAnDPooc9jCkyKzYoLP9C4z2ILN@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2iXRjs50cgCFTcVTRL+bmNymNVskQBeA7m/AubZ9Iwh48kFa1
	5Lu4QlVu3I84rizMW8zEJs4wJ0KoSx0Ab4fFzSoATy5cAxsdHHdk41HenrEZ
X-Google-Smtp-Source: AGHT+IHcXfIZM/MxapOHro6O3vkHE9BRbzKVHnujFEAm01zqaoFisDVKcQUiTRm3Vg/hQZdXjfBAuQ==
X-Received: by 2002:a17:90a:7408:b0:2d8:b91d:d284 with SMTP id 98e67ed59e1d1-2db9ff91f8bmr22007709a91.16.1726587672133;
        Tue, 17 Sep 2024 08:41:12 -0700 (PDT)
Received: from kernelexploit-virtual-machine.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dbb9c7c7a8sm9599246a91.15.2024.09.17.08.41.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2024 08:41:11 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: oneukum@suse.com
Cc: aha310510@gmail.com,
	colin.i.king@gmail.com,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: Re: [PATCH] usb: use mutex_lock in iowarrior_read()
Date: Wed, 18 Sep 2024 00:41:07 +0900
Message-Id: <20240917154107.137653-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <d88289f9-e22a-4960-9b3b-ad0b3ab17a89@suse.com>
References: <d88289f9-e22a-4960-9b3b-ad0b3ab17a89@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Oliver Neukum <oneukum@suse.com> wrote:
>
> On 17.09.24 12:01, Jeongjun Park wrote:
>
> > Okay, I understand. Then I think it would be appropriate to do
> > the patch below to prevent blocking, but I have one question.
> >
> > Currently, many misc usb drivers do not seem to handle the
> > O_NONBLOCK flag when using mutex_lock. If this is really
>
> Yes. The quality of many drivers could be improved.
> Feel free to make patches. However, the lack of quality elsewhere
> does not justify a regression. Hence code fixing drivers already
> correctly supporting O_NONBLOCK must be correct in that regard.
>
> > necessary code, I think it would require code modifications to
> > other functions inside iowarrior and many misc usb drivers.
> >
> > What do you think about this?
>
> The formatting seems to be broken. In terms of content it is good.

Oh, this format was sent broken. I'm sending you the patch below again.
I'll send you a new patch with this patch right away.

And I'll try to write a patch for other functions and misc usbs that don't
support O_NONBLOCK properly soon.

Regards,
Jeongjun Park

---
 drivers/usb/misc/iowarrior.c | 46 ++++++++++++++++++++++++++++--------
 1 file changed, 36 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/misc/iowarrior.c b/drivers/usb/misc/iowarrior.c
index 6d28467ce352..dbf0ed04f7c3 100644
--- a/drivers/usb/misc/iowarrior.c
+++ b/drivers/usb/misc/iowarrior.c
@@ -277,28 +277,45 @@ static ssize_t iowarrior_read(struct file *file, char __user *buffer,
 	struct iowarrior *dev;
 	int read_idx;
 	int offset;
+	int retval = 0;
 
 	dev = file->private_data;
 
+	if (file->f_flags & O_NONBLOCK) {
+		retval = mutex_trylock(&dev->mutex);
+		if (!retval)
+			return -EAGAIN;
+	} else {
+		retval = mutex_lock_interruptible(&dev->mutex);
+		if (retval)
+			return -ERESTARTSYS;
+	}
+
 	/* verify that the device wasn't unplugged */
-	if (!dev || !dev->present)
-		return -ENODEV;
+	if (!dev->present) {
+		retval = -ENODEV;
+		goto exit;
+	}
 
 	dev_dbg(&dev->interface->dev, "minor %d, count = %zd\n",
 		dev->minor, count);
 
 	/* read count must be packet size (+ time stamp) */
 	if ((count != dev->report_size)
-	    && (count != (dev->report_size + 1)))
-		return -EINVAL;
+	    && (count != (dev->report_size + 1))) {
+		retval = -EINVAL;
+		goto exit;
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
+				goto exit;
+			}
 			else {
 				//next line will return when there is either new data, or the device is unplugged
 				int r = wait_event_interruptible(dev->read_wait,
@@ -309,28 +326,37 @@ static ssize_t iowarrior_read(struct file *file, char __user *buffer,
 								  -1));
 				if (r) {
 					//we were interrupted by a signal
-					return -ERESTART;
+					retval = -ERESTART;
+					goto exit;
 				}
 				if (!dev->present) {
 					//The device was unplugged
-					return -ENODEV;
+					retval = -ENODEV;
+					goto exit;
 				}
 				if (read_idx == -1) {
 					// Can this happen ???
-					return 0;
+					retval = 0;
+					goto exit;
 				}
 			}
 		}
 
 		offset = read_idx * (dev->report_size + 1);
 		if (copy_to_user(buffer, dev->read_queue + offset, count)) {
-			return -EFAULT;
+			retval = -EFAULT;
+			goto exit;
 		}
 	} while (atomic_read(&dev->overflow_flag));
 
 	read_idx = ++read_idx == MAX_INTERRUPT_BUFFER ? 0 : read_idx;
 	atomic_set(&dev->read_idx, read_idx);
+	mutex_unlock(&dev->mutex);
 	return count;
+
+exit:
+	mutex_unlock(&dev->mutex);
+	return retval;
 }
 
 /*
--

>
>         Regards
>                 Oliver

