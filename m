Return-Path: <linux-kernel+bounces-267750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0FBD941511
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 17:02:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A6E0288701
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 15:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB7651A2C39;
	Tue, 30 Jul 2024 15:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="bMbCxGXy"
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4267A1A0B1B
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 15:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722351756; cv=none; b=G+L7ypW0pizzm8dFJZA2BspIXEV2AieqLFB3I3U5raqYPt4WpPTnE0fStJcJonBu2UGrAMnK/KA9PLotZ2L7qRhN3x4nxGChHDori2uEZ0VmyTHQnbRtcyTzqRQnG5IoxVGPALUpVMeQQc2FsAWiK6/SB0Lnb6iLz2uQHCDKRwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722351756; c=relaxed/simple;
	bh=XPaZ5Zxo4tsgFR1aV1xHq2o1MzcHaPH9GzbTioUgVrg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZY4hjPtD1sqny+TZ2u0DouEem7jT2m1xkFotSm6GJXkS/6UmLjpZdlTiBejo4FI4F8QdpXUkVKtX4aIXDwSlHfYTm2/boRLUc7GljxTzAPrBMaa3RMpusQ40b2bBDGB08bd5rjYviazQThoPaJ+ZX8WWCCJ4iYsGUYdmIK9iNgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=bMbCxGXy; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7a1dcc7bc05so292582885a.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 08:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1722351754; x=1722956554; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2aHnBGDy68xwYXXDjrfSbMfL0AOPRRbHUN6FtVmc8lU=;
        b=bMbCxGXym91Bof0Au7qepUzb/x/WbP2loWNOp5b32XOcjhiyQLPjmvNfrs+HWrUFac
         JGPLTdqZMyXg9LPp+c4wzoQ+uU0bsDNIQquVY1yRhVijuZj2j8W7dwKsHdzpPRlJW4hA
         /77p+c5QGvRFFV77/q8KpraQATez48kHpayDTu4zkQhqD3D1SQbY/FbW374K4WXoGxcW
         TJroU8LBQlxZiiXP7vhLQJIGQCNDdfCwPrTLMFy3uaPbGx/au43bzHofCVLLwiD/Mz4D
         nXGlKiJbnag4/KmRoETXuXoUFH+rzME5V05GXrOyqrS5CT4PCUiiD+Je5K3lBeTQyMiz
         CWzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722351754; x=1722956554;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2aHnBGDy68xwYXXDjrfSbMfL0AOPRRbHUN6FtVmc8lU=;
        b=DTzEI30tXmFK0IFJKkssafMfoGdUZP0bjHEaWRq0/ehAEwyAyJ3nuIQF93s4W2hn54
         Y8+HpLevrMh82LLjrqrQJbNSBDgIP7VW1M+V6QCjhwUB3mifl4gTFLHCzvd1++EteDhH
         p3Pjd0jMkxUDZSmpcNH+oDKrzTTv8IQJeYF0l5NkpIQ9XcRsxbYPLcn6/S4GpQZJW9RN
         bAFbF1amzMx60yxpIr0rWyiwTfslup7oYtQvoNv3p9TZ1oMVgJDmB8jSa5JNX1QWmtRk
         9aoqdvvNMZNz5hmgdwYCEF34VewV1kQoT6ckSteQwgSQ8M0iaq0jp1RnJ8l3vdq1zzRn
         vRWA==
X-Forwarded-Encrypted: i=1; AJvYcCX59GJo0RgyRZ08vM3Ih/o91zJZ6a5CqGAyWBzhkClul2/I479Y6bCUadnlY3a+hJID5UVAhVWZlfjmmAAcOYlbrPk+yyZhlZIxDnzv
X-Gm-Message-State: AOJu0Ywl1F1iA5HhQt5ygYN7aaclTTSWsronyPTsHIfo8jtVrZ4RMxtu
	JAAanmHmkiFdxmNJ21RxrPtozeVov3qWiSYUMHVZJwkyjpbha9Am8iOEAN95hD8=
X-Google-Smtp-Source: AGHT+IFxLC8+/Z/VDyAUb7tf0WUqsksRLJR+UaYeagUb+QXKem8cCoH3WlCYwUUUbTE/PYYdq//rKQ==
X-Received: by 2002:a05:620a:269a:b0:7a1:d08d:e2fa with SMTP id af79cd13be357-7a1e5229e64mr1516298285a.1.1722351754104;
        Tue, 30 Jul 2024 08:02:34 -0700 (PDT)
Received: from soleen.c.googlers.com.com (197.5.86.34.bc.googleusercontent.com. [34.86.5.197])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a1d73efffdsm645934285a.69.2024.07.30.08.02.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 08:02:33 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: akpm@linux-foundation.org,
	jpoimboe@kernel.org,
	pasha.tatashin@soleen.com,
	kent.overstreet@linux.dev,
	peterz@infradead.org,
	nphamcs@gmail.com,
	cerasuolodomenico@gmail.com,
	surenb@google.com,
	lizhijian@fujitsu.com,
	willy@infradead.org,
	shakeel.butt@linux.dev,
	vbabka@suse.cz,
	ziy@nvidia.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	yosryahmed@google.com
Subject: [PATCH v6 3/3] task_stack: uninline stack_not_used
Date: Tue, 30 Jul 2024 15:01:58 +0000
Message-ID: <20240730150158.832783-4-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.46.0.rc1.232.g9752f9e123-goog
In-Reply-To: <20240730150158.832783-1-pasha.tatashin@soleen.com>
References: <20240730150158.832783-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Given that stack_not_used() is not performance critical function
uninline it.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 include/linux/sched/task_stack.h | 18 +++---------------
 kernel/exit.c                    | 19 +++++++++++++++++++
 kernel/sched/core.c              |  4 +---
 3 files changed, 23 insertions(+), 18 deletions(-)

diff --git a/include/linux/sched/task_stack.h b/include/linux/sched/task_stack.h
index ccd72b978e1f..bf10bdb487dd 100644
--- a/include/linux/sched/task_stack.h
+++ b/include/linux/sched/task_stack.h
@@ -95,23 +95,11 @@ static inline int object_is_on_stack(const void *obj)
 extern void thread_stack_cache_init(void);
 
 #ifdef CONFIG_DEBUG_STACK_USAGE
+unsigned long stack_not_used(struct task_struct *p);
+#else
 static inline unsigned long stack_not_used(struct task_struct *p)
 {
-	unsigned long *n = end_of_stack(p);
-
-	do { 	/* Skip over canary */
-# ifdef CONFIG_STACK_GROWSUP
-		n--;
-# else
-		n++;
-# endif
-	} while (!*n);
-
-# ifdef CONFIG_STACK_GROWSUP
-	return (unsigned long)end_of_stack(p) - (unsigned long)n;
-# else
-	return (unsigned long)n - (unsigned long)end_of_stack(p);
-# endif
+	return 0;
 }
 #endif
 extern void set_task_stack_end_magic(struct task_struct *tsk);
diff --git a/kernel/exit.c b/kernel/exit.c
index 64bfc2bae55b..45085a0e7c16 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -778,6 +778,25 @@ static void exit_notify(struct task_struct *tsk, int group_dead)
 }
 
 #ifdef CONFIG_DEBUG_STACK_USAGE
+unsigned long stack_not_used(struct task_struct *p)
+{
+	unsigned long *n = end_of_stack(p);
+
+	do {	/* Skip over canary */
+# ifdef CONFIG_STACK_GROWSUP
+		n--;
+# else
+		n++;
+# endif
+	} while (!*n);
+
+# ifdef CONFIG_STACK_GROWSUP
+	return (unsigned long)end_of_stack(p) - (unsigned long)n;
+# else
+	return (unsigned long)n - (unsigned long)end_of_stack(p);
+# endif
+}
+
 /* Count the maximum pages reached in kernel stacks */
 static inline void kstack_histogram(unsigned long used_stack)
 {
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index a9f655025607..b275f4f27e3c 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7405,7 +7405,7 @@ EXPORT_SYMBOL(io_schedule);
 
 void sched_show_task(struct task_struct *p)
 {
-	unsigned long free = 0;
+	unsigned long free;
 	int ppid;
 
 	if (!try_get_task_stack(p))
@@ -7415,9 +7415,7 @@ void sched_show_task(struct task_struct *p)
 
 	if (task_is_running(p))
 		pr_cont("  running task    ");
-#ifdef CONFIG_DEBUG_STACK_USAGE
 	free = stack_not_used(p);
-#endif
 	ppid = 0;
 	rcu_read_lock();
 	if (pid_alive(p))
-- 
2.46.0.rc1.232.g9752f9e123-goog


