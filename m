Return-Path: <linux-kernel+bounces-331935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AA4E697B326
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 18:48:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0CBC6B28BDE
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 16:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2AF517B4ED;
	Tue, 17 Sep 2024 16:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hYwdv2dJ"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4CE3B1A2;
	Tue, 17 Sep 2024 16:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726591718; cv=none; b=twM+DxU26cXE4lffLK8vpy0wyWakxcPhV0HWpZHfEYfvnGm9qms7mRuAX75lPojkxctttWN9946Z/hWLUYiGToDMshvpbNLpSV3iKqFSm/PNEMXDy6xiRkJEo3r1IxU2xB9FISkiFBhaW/qW3HiZgYEJKnZYfU/MIZSxMDqK3cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726591718; c=relaxed/simple;
	bh=fH3plaBt0O+m/Vc13Tt0/wRtia4okRWIxHD+zFt0LHM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=d2k/utU+lexPrxBjb3YFErhfuN0fN93X4CxI4Bpvq/lTv2PcLHxL19WlLbWG1O5CA72Q21YxFOiRIodjcIpCh/cDTIfvk2aSizzRurpu+uoU18179mZxjn+p/4nCqzBfvAdm1gdd6wjJGWu/GdY95dQKJVKxgPMGDvhk+8qW+C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hYwdv2dJ; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2d885019558so4016569a91.2;
        Tue, 17 Sep 2024 09:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726591716; x=1727196516; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=L8Nl24p1XGq2gNfzD83xHLfViuR+0yvfPZUWWcKsgR0=;
        b=hYwdv2dJm72zUw8s4Dy0gsY1xHukoTsiLJtxqTq6RX+sKbvoI3yoVHQCBCVIemvanb
         ugcfAkZQC0vB5st6+y5UHtaJ2jlxlSlivrIsoXnbbnKjUYwCySGdZ0I/O5COHcRzj45p
         7Iip9tMjAZFhuZH2tHArtxy2z9h2f7mssPCq/jnd3zbb3/iaHItEFXUW7oMuMAzmzjV+
         /S4TBnnH91wDF7p1DuLlmZq6uWYhVQQqa/bJ6FgyLDlMyZucMImti5F7ydlg4QQbdoG8
         YDrRw3i6zFEXIuP4Bd+zsnguD1Q0VcF0AQCEGQ61O3deahAeTwnSvQtT9jJWb37nxbaq
         BViQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726591716; x=1727196516;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L8Nl24p1XGq2gNfzD83xHLfViuR+0yvfPZUWWcKsgR0=;
        b=hiZve44yDc1Eqdqj2CjtOyI/fZ5cUpZ6MUaIn/O5Oa0Pm8H1agP14SUDKj1MG92dDe
         NMhMmlutp8uYmdU/uJ45zy5/OnwjwfXpDqF9Q6MT/rgYQpXnU8Hk1hLvGFyKvsTZDaw6
         RJGy6a7+L1GkGOFwvQOV31tfgbLjtch3RUXu0YHUg9IXzxavjYnydXiogOyv+NL3x+q6
         QloVlXZvuFdUGT1yFyVNCU/acguSHtPV4v77RdTfevARFDyF6lTaZw53PMowLVtuwfm1
         po/5oixCOwumkO9Xo7kyZ0AVU4EV6oNPRPSyHu1XjSOFT+4hSXDtk4AjKPX1ZOXEcoal
         z2dg==
X-Forwarded-Encrypted: i=1; AJvYcCUA8rdCvv+YHnlgBvVLrODpDix1hd1YBJbAaxiYi0rEAyUdMnGznqFGrxvcoBGevVzpWJEcK5p9TVL0LH4=@vger.kernel.org, AJvYcCWyYNSkhGhsC5nj9qgRo0xU+tJsyC8Id6N4dU6UW7bH5BucQdoFVxYbSGy2k2FRa72yhZtUp5ysd6qC@vger.kernel.org
X-Gm-Message-State: AOJu0Yw70KU7EU3NRdWruzS68ijxBEsW1pDQAEjIdaZfWScJAoFEb8uM
	7l6jENc+mAQ3hwyUeDUdIDwqu+fwk7VPiog7lTFO7SjwadAoksW+
X-Google-Smtp-Source: AGHT+IEW1mfraWGIQ2l6x9WAabgd0zKN/ED+ZiVRPXKH9n+oj6g96LWnoy24+nOgYLDWS3p9az/ABA==
X-Received: by 2002:a17:90a:d34c:b0:2d8:87d3:903b with SMTP id 98e67ed59e1d1-2dba0083863mr20529172a91.35.1726591715702;
        Tue, 17 Sep 2024 09:48:35 -0700 (PDT)
Received: from kernelexploit-virtual-machine.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dd52e3171fsm755569a91.1.2024.09.17.09.48.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2024 09:48:35 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: gregkh@linuxfoundation.org,
	oneukum@suse.com
Cc: colin.i.king@gmail.com,
	aha310510@gmail.com,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] usb: using mutex lock and supporting O_NONBLOCK flag in iowarrior_read()
Date: Wed, 18 Sep 2024 01:48:20 +0900
Message-Id: <20240917164820.143197-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

iowarrior_read() uses the iowarrior dev structure, but does not use any 
lock on the structure. This can cause various bugs including data-races,
so it is more appropriate to use a mutex lock to safely protect the 
iowarrior dev structure. When using a mutex lock, you should split the
branch to prevent blocking when the O_NONBLOCK flag is set.

In addition, it is unnecessary to check for NULL on the iowarrior dev 
structure obtained by reading file->private_data. Therefore, it is 
better to remove the check.

Fixes: 946b960d13c1 ("USB: add driver for iowarrior devices.")
Signed-off-by: Jeongjun Park <aha310510@gmail.com>
---
 drivers/usb/misc/iowarrior.c | 46 ++++++++++++++++++++++++++++--------
 1 file changed, 36 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/misc/iowarrior.c b/drivers/usb/misc/iowarrior.c
index 6d28467ce352..a513766b4985 100644
--- a/drivers/usb/misc/iowarrior.c
+++ b/drivers/usb/misc/iowarrior.c
@@ -277,28 +277,45 @@ static ssize_t iowarrior_read(struct file *file, char __user *buffer,
 	struct iowarrior *dev;
 	int read_idx;
 	int offset;
+	int retval;
 
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

