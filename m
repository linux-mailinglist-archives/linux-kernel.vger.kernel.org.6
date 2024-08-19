Return-Path: <linux-kernel+bounces-292411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06380956F18
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 17:43:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0B4E285445
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 15:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5441D16B723;
	Mon, 19 Aug 2024 15:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="N0lfgQIR"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A68485956
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 15:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724082191; cv=none; b=Kxb8BsKtuXzFNoyciGZS8noNJmwEyg3IiJkCw5iewbuv9b35SGsxMG7iSNVzG+2MndtNAL43V/aLzp320Wp0vLWf4XPLbY3pWkiXm+sOlyaX/Cuo4NFnpTOAdrBbFkdgieHERDCSzfm0H6zkF3PxkJV83qf643/fkU5X5nX7kxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724082191; c=relaxed/simple;
	bh=xpaeZrdYp7o/3H939Bd1V1rBqFcrF4MCrxgKeTiRIas=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YinSRReczgLpcH5n2GFJ1dxSfXgJEVyWvtYSla9g7Kh96r/z8PbLv9nq8Wshe+ASOHovUv5vZsd/YFQaLvc8gAWZh3BjcZ89tvrLQS0I8quD5tRl0K81eOdpLYV55Mp/+ObXl8j6hGYXeQk7B0azPQhquNfDX4YNEQoFOn7Wwgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=N0lfgQIR; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2d3badec49eso606406a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 08:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1724082188; x=1724686988; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ez+V6hFdUaTIjdgjh9Zv2YX3S3+fART/LHqREz/LfwM=;
        b=N0lfgQIRFx6f32LmlEu7Hx+ei4iSn4U85fYmy0XLF3/85I73voL8+eErFkf4YHvsy+
         ddlGgo7gqhg/9xRfVgGojYYpueywR1X1MonZN4Hom6LPhpHC5g9Xh2kP3xVJaY/pcdvN
         92Qy4mFPJZcXz7mMtue0AUz3Ft8Ez9Sxe/L/1+lqWFD3AvXvtnOMtBLYDRK3dXUrLXeR
         HmI8egdBxjo4XMeUAPgB3WqRxUdBR63gJ34mDTSpaKH/iMzFFGi/KKBSQLAqEgocgXzF
         KzFtOpYKh1//q7OUPKn+q+mrmvhOfGFGE39B7HwPiomRqt/mMljMBlIHBDhQljZ30BJ7
         KKXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724082188; x=1724686988;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ez+V6hFdUaTIjdgjh9Zv2YX3S3+fART/LHqREz/LfwM=;
        b=XlmIZrLg+ShtZPqm+m42v5vEwslOFeF3VyJXYdtiJv83Q3VKNdZ6QRJJZGFwZjMhrB
         NjKQkbL3e9jHSv8PYKEXqSrP8R0YmqY8Mbue1Cx6OJHxXgyTMEbyjkxddCBzXCaTYabn
         YmCVJSJlWoC3a9a9xgQAl4MIBylsO2w0kwWh5MAAAreYeMZ67TaHLGjUpanNN2K2t7Kx
         4ghCn9YoGw7BX86/17h6MKmjqHbR13DjMOrsPD7op39gepuc8lYx1XmeDH26sSJGNvk7
         iiGMxi9j0bMDITAqK8XnZyNLORpif76jyIVtScKA78Lf6JcQpOpGMUNEUnknblu9/Pob
         xwrg==
X-Gm-Message-State: AOJu0YzEKtkG9o/4gBURzH47fWCMIGhnKmoze+F7REOXl4oaCG7SWuHa
	qiafzAyWaJJfU7iSrsy19VJ73Otzy/T5Vrn5G/1q43XQGwE1llsVf2Nim1aEpJCTflanIVlXfC5
	q
X-Google-Smtp-Source: AGHT+IHzSilzhTDi90d4es4HlvKwZl+ChIAk+D+HDSxeVbBgQX93kpvpg31Y7NnyqaQpbCsWJr3t3g==
X-Received: by 2002:a17:90a:2f42:b0:2cb:4382:99eb with SMTP id 98e67ed59e1d1-2d3e1736fffmr7535753a91.6.1724082187874;
        Mon, 19 Aug 2024 08:43:07 -0700 (PDT)
Received: from localhost.localdomain ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d3e3c751f1sm7356041a91.38.2024.08.19.08.43.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 08:43:06 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: peterz@infradead.org,
	tglx@linutronix.de,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 3/4] sched/core: have io_schedule_prepare() return a long
Date: Mon, 19 Aug 2024 09:39:48 -0600
Message-ID: <20240819154259.215504-4-axboe@kernel.dk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240819154259.215504-1-axboe@kernel.dk>
References: <20240819154259.215504-1-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for needing more state then 32-bit on 64-bit archs,
switch it to a long instead.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-cgroup.c           | 2 +-
 include/linux/sched.h        | 4 ++--
 kernel/locking/mutex.c       | 4 ++--
 kernel/locking/rtmutex_api.c | 4 ++--
 kernel/sched/core.c          | 6 +++---
 5 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 69e70964398c..f8e6220c66a7 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1884,7 +1884,7 @@ static void blkcg_maybe_throttle_blkg(struct blkcg_gq *blkg, bool use_memdelay)
 	u64 now = blk_time_get_ns();
 	u64 exp;
 	u64 delay_nsec = 0;
-	int tok;
+	long tok;
 
 	while (blkg->parent) {
 		int use_delay = atomic_read(&blkg->use_delay);
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 2c1b4ee3234f..c1a65e19a3ac 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -319,8 +319,8 @@ asmlinkage void preempt_schedule_irq(void);
  extern void schedule_rtlock(void);
 #endif
 
-extern int __must_check io_schedule_prepare(void);
-extern void io_schedule_finish(int token);
+extern long __must_check io_schedule_prepare(void);
+extern void io_schedule_finish(long token);
 extern long io_schedule_timeout(long timeout);
 extern void io_schedule(void);
 
diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index cbae8c0b89ab..4a86ea6c7f19 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -830,7 +830,7 @@ EXPORT_SYMBOL_GPL(mutex_lock_interruptible_nested);
 void __sched
 mutex_lock_io_nested(struct mutex *lock, unsigned int subclass)
 {
-	int token;
+	long token;
 
 	might_sleep();
 
@@ -1026,7 +1026,7 @@ EXPORT_SYMBOL(mutex_lock_killable);
  */
 void __sched mutex_lock_io(struct mutex *lock)
 {
-	int token;
+	long token;
 
 	token = io_schedule_prepare();
 	mutex_lock(lock);
diff --git a/kernel/locking/rtmutex_api.c b/kernel/locking/rtmutex_api.c
index a6974d044593..ddf7f7f3f0b5 100644
--- a/kernel/locking/rtmutex_api.c
+++ b/kernel/locking/rtmutex_api.c
@@ -547,7 +547,7 @@ EXPORT_SYMBOL_GPL(mutex_lock_killable_nested);
 
 void __sched mutex_lock_io_nested(struct mutex *lock, unsigned int subclass)
 {
-	int token;
+	long token;
 
 	might_sleep();
 
@@ -579,7 +579,7 @@ EXPORT_SYMBOL(mutex_lock_killable);
 
 void __sched mutex_lock_io(struct mutex *lock)
 {
-	int token = io_schedule_prepare();
+	long token = io_schedule_prepare();
 
 	__mutex_lock_common(lock, TASK_UNINTERRUPTIBLE, 0, NULL, _RET_IP_);
 	io_schedule_finish(token);
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 7e04b84dcc55..d6c494e33206 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7415,16 +7415,16 @@ static inline void preempt_dynamic_init(void) { }
 
 #endif /* CONFIG_PREEMPT_DYNAMIC */
 
-int io_schedule_prepare(void)
+long io_schedule_prepare(void)
 {
-	int old_iowait = current->in_iowait;
+	long old_iowait = current->in_iowait;
 
 	current->in_iowait = 1;
 	blk_flush_plug(current->plug, true);
 	return old_iowait;
 }
 
-void io_schedule_finish(int token)
+void io_schedule_finish(long token)
 {
 	current->in_iowait = token;
 }
-- 
2.43.0


