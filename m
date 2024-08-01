Return-Path: <linux-kernel+bounces-271209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 320E6944B05
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 14:12:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6B201F258D2
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 12:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98C3E19F460;
	Thu,  1 Aug 2024 12:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jXqwDOXp"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F6249641;
	Thu,  1 Aug 2024 12:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722514316; cv=none; b=KgXgPpwSTruJf1RHZzehuCmTf2a4lDkJzBAO92r5A0IK5WAFMPxgklDl1YYSUW2VY0bFJ5/nq7pL21Ocrnez8gw+CKh0UiQYXrPYGqQ4jAwv1FMcfVR3zziLlQC16TI0be5Ah93gnm11eFaImMGu10GDXL4hhdvRO+RZOjoGvNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722514316; c=relaxed/simple;
	bh=W9Qc/55ng05JMIOTPMomqUaUFWY5RNPO+RVd1n5jl+I=;
	h=From:To:Cc:Subject:Date:Message-Id; b=ucA6a9kqBb+pAik2E70asWl4Gifop+scG0MzqzjBkke+kdPg+2ZHeP2ObsgoE1a9NEE+freuxNng9JfNTlqALbWzdDfo3ymLE9F3DEfP4cyLHEFEd79Gg8bHGC7y1AFsxRGq9F8UpxFOBuGJvEvnPy5ba4OMLsw2df7+8N8GSVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jXqwDOXp; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a7a8e73b29cso568626766b.3;
        Thu, 01 Aug 2024 05:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722514313; x=1723119113; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XPaGIKLPWeVlrZZW5XmRbjkG6ikPmbAIc8nclr/Awfw=;
        b=jXqwDOXpyxMsRloTu1yjTyl60YEFJ1ixjwFmva1lkEzIDJ/+nDp4QWxbuFpaaAQX2Y
         T/Ma/uk/0kmDJhLZ8BD9cMGBiaiFXIYvi7AjN0yh9Lq3uDIvx8joQ+pS4gw3AsPGgJ9R
         H6Z/Z5q55qNkVBsqb/jd/JTpc9V7SXvvhmN0IXmQOTZcVcNaX7Xs+fcLyvVkyd1xg24g
         uxOS5fyukA5Hl9wrndX7Zj2PKHuQmjZYpqrLRcxmGTPpNY3rPveUraALU/nPiEh6ZYjM
         qBhWHDZK3yfRKdhO8bZc0hyCpdutfIS+kReYXlwRyRVohuix/OXnqMFFGnQ2UEHM/oV+
         viPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722514313; x=1723119113;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XPaGIKLPWeVlrZZW5XmRbjkG6ikPmbAIc8nclr/Awfw=;
        b=S1Cq+nRZ3wjPCzQ/SU7/VMy0U7nTqMcah+asxQI5uzkupIPw7qhmJbzqNy7sDwLD6I
         ao+uYlAleXwA8jBezVrZQRxLGug5NwRpmaYBjVx0p5kbbXLmAYnOXeio8HLVWMRmobzs
         Vjtlc06WdRqIFjXZHMUhY/w2bX26YLhuTqbWpVtzw56TFxpXidHi7HbypddkvOwFzT0m
         hua3I15Gh93jfsD/zWctnNgMmQJy/PgOwHQ06PsPZasiAnjbntnn59xU9tcbpfEFV28x
         +/vhmag44xtQH+aX+mSgPVYv8vnr75UpfApW+qdwGCpAPuIBDoi5GOMfBi1AV8Mn93Md
         wgRg==
X-Forwarded-Encrypted: i=1; AJvYcCUqawiYWDIXs7KLuUGszlPHWG0cu0eMhWjQf6EcejewG7nAIdxa4PUEgjmR3F1ii3lbmCr7tYZLr9QcWS7y3TjxSOgOb/x2nuylqva6tzAE95yOSxxsX5+ZDRgjMstZy6OIGZcduKit
X-Gm-Message-State: AOJu0YzPLY6DGP/hWUQTLqNgu4vJd/HnqbTMjbJv5M644bU5wWYu99C+
	6oVIv7y4Fvv8Slm3yFhjzKo7BoXWY67YloID6qEkfm1Z+JDHL45N
X-Google-Smtp-Source: AGHT+IHM8uN6/PLO/UdbdTtH/kdrLhd+pOgMhaxAn2K9O3qYqurGxhOVTJrcMr7EuO2HTx/TY7eaHg==
X-Received: by 2002:a17:907:3ea1:b0:a72:9d25:8ad3 with SMTP id a640c23a62f3a-a7daf4c372emr169759166b.9.1722514313242;
        Thu, 01 Aug 2024 05:11:53 -0700 (PDT)
Received: from localhost (85.64.140.6.dynamic.barak-online.net. [85.64.140.6])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7da0b63b09sm183204566b.85.2024.08.01.05.11.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Aug 2024 05:11:52 -0700 (PDT)
From: Eli Billauer <eli.billauer@gmail.com>
To: gregkh@linuxfoundation.org
Cc: arnd@arndb.de,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	Eli Billauer <eli.billauer@gmail.com>
Subject: [PATCH] char: xillybus: Don't destroy workqueue from work item running on it
Date: Thu,  1 Aug 2024 15:11:26 +0300
Message-Id: <20240801121126.60183-1-eli.billauer@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Triggered by a kref decrement, destroy_workqueue() may be called from
within a work item for destroying its own workqueue. This illegal
situation is averted by adding a module-global workqueue for exclusive
use of the offending work item. Other work items continue to be queued
on per-device workqueues to ensure performance.

Reported-by: syzbot+91dbdfecdd3287734d8e@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/lkml/0000000000000ab25a061e1dfe9f@google.com/
Signed-off-by: Eli Billauer <eli.billauer@gmail.com>
---
 drivers/char/xillybus/xillyusb.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/char/xillybus/xillyusb.c b/drivers/char/xillybus/xillyusb.c
index 5a5afa14ca8c..33ca0f4af390 100644
--- a/drivers/char/xillybus/xillyusb.c
+++ b/drivers/char/xillybus/xillyusb.c
@@ -50,6 +50,7 @@ MODULE_LICENSE("GPL v2");
 static const char xillyname[] = "xillyusb";
 
 static unsigned int fifo_buf_order;
+static struct workqueue_struct *wakeup_wq;
 
 #define USB_VENDOR_ID_XILINX		0x03fd
 #define USB_VENDOR_ID_ALTERA		0x09fb
@@ -569,10 +570,6 @@ static void cleanup_dev(struct kref *kref)
  * errors if executed. The mechanism relies on that xdev->error is assigned
  * a non-zero value by report_io_error() prior to queueing wakeup_all(),
  * which prevents bulk_in_work() from calling process_bulk_in().
- *
- * The fact that wakeup_all() and bulk_in_work() are queued on the same
- * workqueue makes their concurrent execution very unlikely, however the
- * kernel's API doesn't seem to ensure this strictly.
  */
 
 static void wakeup_all(struct work_struct *work)
@@ -627,7 +624,7 @@ static void report_io_error(struct xillyusb_dev *xdev,
 
 	if (do_once) {
 		kref_get(&xdev->kref); /* xdev is used by work item */
-		queue_work(xdev->workq, &xdev->wakeup_workitem);
+		queue_work(wakeup_wq, &xdev->wakeup_workitem);
 	}
 }
 
@@ -2258,6 +2255,10 @@ static int __init xillyusb_init(void)
 {
 	int rc = 0;
 
+	wakeup_wq = alloc_workqueue(xillyname, 0, 0);
+	if (!wakeup_wq)
+		return -ENOMEM;
+
 	if (LOG2_INITIAL_FIFO_BUF_SIZE > PAGE_SHIFT)
 		fifo_buf_order = LOG2_INITIAL_FIFO_BUF_SIZE - PAGE_SHIFT;
 	else
@@ -2265,11 +2266,16 @@ static int __init xillyusb_init(void)
 
 	rc = usb_register(&xillyusb_driver);
 
+	if (rc)
+		destroy_workqueue(wakeup_wq);
+
 	return rc;
 }
 
 static void __exit xillyusb_exit(void)
 {
+	destroy_workqueue(wakeup_wq);
+
 	usb_deregister(&xillyusb_driver);
 }
 
-- 
2.17.1


