Return-Path: <linux-kernel+bounces-238758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 377E4924FA3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 05:36:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64AE11C228F4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 03:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1245C1B977;
	Wed,  3 Jul 2024 03:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CXmKqFI/"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FCB717BCE
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 03:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719977774; cv=none; b=XLapxzhZTukWAOGrSU1XVDE4skZYrrnjmS7MgY/nUh096XVSUfllCZ/PG6GejcFBlle+/3U7dIvJlQNMeB+e4qSd+GFUn3xfc3hI9qwqcb5HkSN3J8Tv3fGP1jEQ6JNhbwkxkVUXWK6q4P8s7EBBSyNZC34Hnb5eXLXq8m/wYNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719977774; c=relaxed/simple;
	bh=kfVfIUpaxcr171PH8DCDoG+zD7xsW9GTLz4zvQJLWMI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=poO3aQDMYMHi2TxSZ541ehJe0keRUQ0if/zssUcB4vkYRAcalM/mMJyQ7+piHHmXsOSQn56G/kwiaRXK6x95ejaU9qf6YbfxARdzeFFFqmgcSRSk4IhOW9050tIVc98kDqHJ5Ql5b89u3wT0y5zWeKwJSPRJprhNDqtrpUikOY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CXmKqFI/; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1fab03d2f23so38079555ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 20:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719977772; x=1720582572; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4GJ1xuGIg/34+KoYPJFdTKabqBtfsZIj48w+G481zs0=;
        b=CXmKqFI/wjz+Yy3dO4pEu/r4vKYHfNmxIS7xtN/RHG19AaboGU4ZDUrST6dTi3IKR8
         VqDLmN4hLWtWSBfWrAzdImi21TKG1+3Rgg0Stg1yjaV9U/pDPUnpbqyceobAcGCyv7O+
         TzJu3MtIs4MQZprU0bhXRUv+5UbnNz/APFzb2tl+cfLAQu8RNi8QtMjoUB+AKZ5w8Yb9
         n68TANI8P+nhhCcJXBiBrBocrhOH+ZxOC5eGw3oDO4eflF+rp/dRvXe3XyIK6CvfzmjA
         gpp8WXXeY35X/lFOnJ+fa7BF3nvXVDrbEno4ePMDG5XTdDo2Z8fx/JQ/A8BZ2gadNBhM
         q4ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719977772; x=1720582572;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4GJ1xuGIg/34+KoYPJFdTKabqBtfsZIj48w+G481zs0=;
        b=G2sPakNEl94DPJ2kyb9E+HsH68fXu0m/snICB+oltchGf4G6VmHSJG3YBUAUwJOoMm
         fLc4NR3iBMUA3ZfRkJVWIvV9iXS/Xvpibb6QrghHC6ihngTzbUEeclh/jrrGfwn6Mf6V
         dfiPAAzopz1BN2VVVMPqUz+38siwjDaEf5UI2D9nyV2N9EbPQ2N9UX2Rv7yMHfpOzfM9
         WvHK4fwDG7HBJcEv/WHsRPhBQF/0nIC5Fjb7qkM+Ck4E2cc88woMX6dhXqV79iP+MQC4
         D8QKS1onBj/xOTNZCvF5AcTvR192HPL+SIqOIwHUPY0is8r00OGqfduNIos9jl/kF++M
         +7EQ==
X-Gm-Message-State: AOJu0Yy89r7OZ4KCoxowG1twF3pxZhBjzx3h2fwbgyfL5vLlQyOzXD0H
	O1o2XDdo36pV7NEz3MP7YdAzea8iB0Xqt40Qix7eMUVzJVgO+RRQfi2HHg==
X-Google-Smtp-Source: AGHT+IGWu9ztojNDm+/rzblVADUU5I3e7uzJjkc7CF3Q9H/fd/D62poomL6IIZKCcyzRNxj+qpYgHg==
X-Received: by 2002:a17:902:e88f:b0:1f7:2479:a50b with SMTP id d9443c01a7336-1fadbce9d4emr72308405ad.54.1719977772012;
        Tue, 02 Jul 2024 20:36:12 -0700 (PDT)
Received: from localhost ([198.11.178.15])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1faf92d84cbsm22478025ad.127.2024.07.02.20.36.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Jul 2024 20:36:11 -0700 (PDT)
From: Lai Jiangshan <jiangshanlai@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Lai Jiangshan <jiangshan.ljs@antgroup.com>,
	Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [PATCH 1/6] workqueue: Register sysfs after the whole creation of the new wq
Date: Wed,  3 Jul 2024 11:38:50 +0800
Message-Id: <20240703033855.3373-2-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20240703033855.3373-1-jiangshanlai@gmail.com>
References: <20240703033855.3373-1-jiangshanlai@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lai Jiangshan <jiangshan.ljs@antgroup.com>

workqueue creation includes adding it to the workqueue list.

Prepare for moving the whole workqueue initializing procedure into
wq_pool_mutex and cpu hotplug locks.

Signed-off-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
---
 kernel/workqueue.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 7a33f958dcb2..c738b3024cc2 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -5689,9 +5689,6 @@ struct workqueue_struct *alloc_workqueue(const char *fmt,
 	if (wq_online && init_rescuer(wq) < 0)
 		goto err_destroy;
 
-	if ((wq->flags & WQ_SYSFS) && workqueue_sysfs_register(wq))
-		goto err_destroy;
-
 	/*
 	 * wq_pool_mutex protects global freeze state and workqueues list.
 	 * Grab it, adjust max_active and add the new @wq to workqueues
@@ -5707,6 +5704,9 @@ struct workqueue_struct *alloc_workqueue(const char *fmt,
 
 	mutex_unlock(&wq_pool_mutex);
 
+	if ((wq->flags & WQ_SYSFS) && workqueue_sysfs_register(wq))
+		goto err_destroy;
+
 	return wq;
 
 err_free_node_nr_active:
-- 
2.19.1.6.gb485710b


