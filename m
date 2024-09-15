Return-Path: <linux-kernel+bounces-329975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EDB9979819
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 20:19:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46E0C1C20D71
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 18:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 878DA1C9DE5;
	Sun, 15 Sep 2024 18:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FwMkfruS"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB431C7B83
	for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 18:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726424376; cv=none; b=s/1IEFZp2AlE3GPlcXEF+qsM0xnNu9yEZTuNfuraQDu0e7Yt3vPLIiAoJzA6s1na/9C+5zljhUxsonWmC4AAYzw2kMdFcyqUL7r2+fYFOz/8/01WI4Wv6TDyD80eYHFNhkeIfsF0rm5aAwz4m7CGMH8E4ExeCgv43/Fs0x//A5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726424376; c=relaxed/simple;
	bh=/96UZ+3BKceG1dPfIs1cR3XfIHSTG6SbNo21Vih+Mdw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uj92QIQjRuyL8mWAwO5xpoMq1F2HfkzZ3fKQdOmusetvnfrvEytDvl4jSi/79I0HhLuZVJuPdQLpsClRSD5DxF8MXDz8aSC7n/baFr+5F8IW893L5rudUZZqtnCeoEvnkvo0Y8PuYNeCucIrVR2K/zJHqgu8yLAFEBDZe9H2iy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FwMkfruS; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2054e22ce3fso39534435ad.2
        for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 11:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726424375; x=1727029175; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ffaYN+QpdszYrw7eGWD8NKheb7rACHJ1DfebAJa58LM=;
        b=FwMkfruSPp2z1JbkDOEsTqlof/2e2OXkgajRR3SpWiQYatwgir1uZ6GBQiDjju+tdg
         aq9JgAO0h3YqeFbFODVi2QZIng5u8GzzZusWA3XbdEDZyHeXYuuQGOOlwEfvmvWQuLob
         q0+IqYcUyWgoRMq1wcMZmCM1ZLSGhPxRAkEoV5KAUUCF7I30ZoseoW/vuaQc5L2IgRZy
         zFs3R2lNf4moycR4y/XCn9+waQQV0IcHTTh+rGRUzEaXGq3jrn3EWpBdlTWe/jc61LCQ
         uqlLhvRx/Hs+nggzuKLtYQLaubzDAXl24+uQmPC8H2mHu6xGNqV4tfmejur4EGlMWZrf
         zVEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726424375; x=1727029175;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ffaYN+QpdszYrw7eGWD8NKheb7rACHJ1DfebAJa58LM=;
        b=p+ai1moBblUn4ajGCrGXHnHUSheI+zQ8R42jMra16sQZffe8yFigJhvPtMiGyfvgDN
         Wn4xpWt+hjJuxH7LC8Cg2FI4Jx3ED8wxMWTVBlDqQugwVnetq5zN6w8iUydHxPVUHRYo
         k7z8q6ZmvpI3fq2jp/cF1raX+ZuAxE30NVyI96tMgXEw02kJWOh6njMRDt0E/NaZlDCF
         hjd7dy7JSZPUKvLbXsWpD+kxpwDSMTRzASf0z5NrXFEmTKII3hFP/o+wwF/n4roCPfBP
         fqM55cLnjVQ1LT0rJkH1Abgtf3Z0eRcgBri6mkh4Boxpw/VYU3UJI/XwWClELKuNuLeT
         mexw==
X-Gm-Message-State: AOJu0Yw4qtVX84pmuOX93eZEp/0OE1uVNU9wIMlUBxuJYkqRUMBAY2bO
	3QjENYXBdFg3k/siVMmrYF64Fkz/u7LAu49LpgkM6N3afeBbh6ba3SuCtVg/
X-Google-Smtp-Source: AGHT+IHkhHPAtcw429n8MpthqZtKIy8qvQzbfmDe8tb4/6t00jXUM/PRRFTPSGu56nDdFI6V0p6M7w==
X-Received: by 2002:a17:903:2285:b0:1fc:2b3b:1482 with SMTP id d9443c01a7336-2076e31576fmr210975175ad.12.1726424374550;
        Sun, 15 Sep 2024 11:19:34 -0700 (PDT)
Received: from kernelexploit-virtual-machine.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7db498d970fsm2852529a12.5.2024.09.15.11.19.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Sep 2024 11:19:34 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: syzbot+b8080cbc8d286a5fa23a@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [usb?] KMSAN: kernel-infoleak in iowarrior_read
Date: Mon, 16 Sep 2024 03:19:19 +0900
Message-Id: <20240915181919.20268-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <0000000000001fdbd80621e28ae3@google.com>
References: <0000000000001fdbd80621e28ae3@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

---
 drivers/usb/misc/iowarrior.c | 46 ++++++++++++++++++++++++++++--------
 1 file changed, 36 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/misc/iowarrior.c b/drivers/usb/misc/iowarrior.c
index 6d28467ce352..0475d3e6a877 100644
--- a/drivers/usb/misc/iowarrior.c
+++ b/drivers/usb/misc/iowarrior.c
@@ -277,28 +277,45 @@ static ssize_t iowarrior_read(struct file *file, char __user *buffer,
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
+	if (mutex_lock_interruptible(&dev->mutex)) {
+		retval = -ERESTARTSYS;
+		goto exit;
+	}
+
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
@@ -309,28 +326,37 @@ static ssize_t iowarrior_read(struct file *file, char __user *buffer,
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

