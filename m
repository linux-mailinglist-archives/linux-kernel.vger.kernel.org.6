Return-Path: <linux-kernel+bounces-290862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E12C89559AB
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 22:47:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A9ED2829E7
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 20:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0D33156C49;
	Sat, 17 Aug 2024 20:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="l+1pcYK2"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4C015624D
	for <linux-kernel@vger.kernel.org>; Sat, 17 Aug 2024 20:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723927610; cv=none; b=ddfAo4C14FaXE4MnwszSgOoZCbMd/ImQqwTMaAVlCIqwZ0RT23aqYb5yhFc1qZDZOiwHjd7I5F1gOMCpfzM0AkeksIZhBippXySCYeMVsUB/7hIfDOGWPML3tomS/lhsxXhvT2fAs2DIXs/vocQ0TMTVMR01BTWxEaQpfiCOWAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723927610; c=relaxed/simple;
	bh=BmTe2CyYLeUX7cn6C5aHi1iNgZg8GBCBNyLdqX9hEhI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZS7M0ObWoNPHYuR+GX3nqcEdYKY6eBLf+zvErrMJkjdNtakqRdO+B8OpFejjlXGkAlRQ51rEZGqPFWKS1TdCrUnR2QCUxJTbZuz5e1bB7j5zOVGhjA7Jq+OtpHFVWQKLRSgeo4WvMi+csLKRIt63b8I634HOVBB4aiphcTm5uJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=l+1pcYK2; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2d3ed48c748so353997a91.3
        for <linux-kernel@vger.kernel.org>; Sat, 17 Aug 2024 13:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1723927608; x=1724532408; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fqE65oF4WU06KhnFO6TGzqMahCVuqHBDZ2qPq59QCiU=;
        b=l+1pcYK21cr/Ey8IjhY72AqkH5mBgTQimwTXqEBGFQFqGFRgHPv3gNVtFBFjcY5m75
         1F04tloCpCMrw518ZdB7fLg6dP0Kt2qw+eYNCfX/mc6wf+qJqtG+WtMTPxLeTuL4Spi6
         l4Xt/TomASWa/BgmC6Mvoxhd4wbLkuJQ/f/GJ/9hU2Dm4ROsBnR9riC8qr8XS9CB5rjP
         cK6outfpMQmrqlPCLQ0lMfDNCWNeLSeaZskpwnHta9GaOjVD5nD0JW3+wRD0Kkahtco1
         LhbBZ34nOMEdAAHblH3TtKlx31VVS8ZW4EsLsyfpEl52PjRixPgDY7BgdiWmssvdVkrC
         I5oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723927608; x=1724532408;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fqE65oF4WU06KhnFO6TGzqMahCVuqHBDZ2qPq59QCiU=;
        b=pGXdL+vDWuFlCa7Ir5rmYr4eIOv8mytqNOuxCQmANsvyEGNBHwfV5ocdHNGUnWUteC
         DZyHO3V4IVCDsdor9mzR+ZTxX9TYeCQbTkAcg1gKrV2j/rG5sGJZeoneV4SCXvRru8n/
         ekXLjhREuxe7Nw2hC5WoMcOWWXp/8GHo4OdalzxyCQmW9U1TNIehRJ8CYMKuF2K9BJfF
         ySOwByiV0bmdx1BluKLjH6jIGX32CGr0Fl/SMPSRb+sJOUvOUUGU68LZ9AE7brALJvHq
         Wo04zFbd2jO79+SdZw+1Pn1GzHkRLq3MTc+rAMZlpODU46PXuLWMUotZkhDLwPKtGSUo
         wuew==
X-Gm-Message-State: AOJu0Yyb5PH6VL1jK+aiAMsPaksoltuN7e0vWtjVtrTBUZsPY232drXQ
	5BstPq3h/P0kbSOe5Ij9q3R3dRiiMTFG3tQnB3CDmEwonMUYP0aLdxWOZDdnCkyxmahP7LFt3AK
	W
X-Google-Smtp-Source: AGHT+IGjVuqQzi5Vz0aVyh+txyYvwjdEKreZuWKgms7U6azB9teX3pOfS9dgfoxt8zyxLln1F1i1Ag==
X-Received: by 2002:a05:6a21:6da3:b0:1c4:9567:18fe with SMTP id adf61e73a8af0-1c905052543mr4722461637.6.1723927608077;
        Sat, 17 Aug 2024 13:46:48 -0700 (PDT)
Received: from localhost.localdomain ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127ae07e41sm4411039b3a.65.2024.08.17.13.46.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Aug 2024 13:46:47 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: peterz@infradead.org,
	tglx@linutronix.de,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 3/4] sched/core: have io_schedule_prepare() return a long
Date: Sat, 17 Aug 2024 14:45:12 -0600
Message-ID: <20240817204639.132794-4-axboe@kernel.dk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240817204639.132794-1-axboe@kernel.dk>
References: <20240817204639.132794-1-axboe@kernel.dk>
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
index ddabf20cd9e0..7cb7ca38fdfc 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7427,16 +7427,16 @@ static inline void preempt_dynamic_init(void) { }
 
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


