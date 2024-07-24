Return-Path: <linux-kernel+bounces-261508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A945D93B811
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 22:34:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11BD6B23677
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 20:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AD5813A86A;
	Wed, 24 Jul 2024 20:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="RdDoynbG"
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2CD5136658
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 20:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721853211; cv=none; b=aelAQFuCgV0dEJtt1eL8SXdD3OrSU0INtXDXNwWVHykuqnDnmFIhncz6SMVbiiPlBchMUMLZsCw/lJs480Y1ThwIZ67Wcn4+5IBePpAEOIVk79uXsFel5Tkrkd1dVNkCZLv45cO4QziR5eFH8iIs5UHtyVtfJTk1AHsywbJlvz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721853211; c=relaxed/simple;
	bh=CMhACvVzLXUZhXtGxNgzUxiCqd5Uj24IQen7sRNf0Y4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z3c+YaYiXH7PhAS1vpC5EfCk3gisM+t3DnXySeu5+2rWe0x7SijZ/EQ4muRJuv7hgpjSYUG/WDDATfaIEFz4yT0Zc+U/kMEd41J0WcVgyFpE2EZyQDJdra5xbUITeIlx0gQX8DJApR4t7JxJ5eboHJpzM8jF96rSbWxkZWMgYbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=RdDoynbG; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-79f1828ed64so10524985a.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 13:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1721853208; x=1722458008; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EKGazB9ClhJRcAnoyFkGgUjUokS0gyXTYpAGog1A94A=;
        b=RdDoynbGML9GmbxT2aXhOT6s6uUQL4PWVsqNnlmGIMpFhEo41EuSuvU57Exb0qk3gF
         KhxkkfTia88HIFZL3BoNEa01qmCXzvR33mHZfr+0Lg24JsddmxiAs9cxhb8l2EYpXCU5
         SvSYIpZbv+YBK64SpZtZJG4UqKsn/KZJNGmKT5i8I4VCnZtlzQNwNz4fZQ8p3AaUasAc
         j22r2H3pNH3w7PKeNgnalxSEBI37+NWYODEQH3Rg9joKhMIoM0sF085OK4RtHRGsgrOU
         kv3Q15vkmbsxgIsMxXfwFz4S9svQVAn8hrY942H3v3QpJajpUbMCwQKjKqqdaCKUTpcv
         beTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721853208; x=1722458008;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EKGazB9ClhJRcAnoyFkGgUjUokS0gyXTYpAGog1A94A=;
        b=JaGJb8JHieW/ELF7ezffAzasBI7xiM3lq6MT2Ws82xfFo6p3RJGonHIf4l3Tu3YzZT
         m4Q685H8PiywRl47G+JRnQxyvB7kIGx5eUuVA8zlvt411d1b+bZbBQ7TshLzmYEykBfV
         Amq7pLd68tMSafmcwW860MGYJXjsCpRcbBp2AyRkfxH3Hs2nRpmMkEmBBd2Cza9Z6FCk
         E704Fcuz7HxMdnNZmiumj0T5gf+HZhjbXgIa+zKM0vFGTxi27+YkfG3xos/ULSZYBZaw
         vArnOZZ3NkkKmippLGaIZFnKgn3ObNFOXJ/kzq56KGbq9yWuUzBX08goXRVzNudDzEbw
         9Pyg==
X-Forwarded-Encrypted: i=1; AJvYcCVv84SyCXcr9Dk6ydtUyso1y77mlCNqaJifWnIYYYhfAHVs++TS/5aCUBeOiQaLi/YvVgZpJLGaDN6NeAwI6syuLeHfEPvpYaGnLfeK
X-Gm-Message-State: AOJu0YxCUFSJ+5FooSD94ANJJImbvQADt70/GH9IovNYhQ4MoFLPSHQj
	fZwFPHQZqNmnmeD9ruDhWLQySP/VBDskbhxbQq8Q/7cCUNNDVX7ZYsCa6H88NA8=
X-Google-Smtp-Source: AGHT+IGdbA77q0Ryd5vfCl/zff1MduhOE0tjAnp/J35IRonbXQFsuFvYQZxmL8WXYNZns3Wr9gC6Dg==
X-Received: by 2002:a05:620a:40d3:b0:79f:17a8:b83 with SMTP id af79cd13be357-7a1d45850b0mr104907085a.33.1721853208537;
        Wed, 24 Jul 2024 13:33:28 -0700 (PDT)
Received: from soleen.c.googlers.com.com (197.5.86.34.bc.googleusercontent.com. [34.86.5.197])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a1d73b1786sm466485a.33.2024.07.24.13.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 13:33:28 -0700 (PDT)
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
	linux-mm@kvack.org
Subject: [PATCH v5 3/3] task_stack: uninline stack_not_used
Date: Wed, 24 Jul 2024 20:33:22 +0000
Message-ID: <20240724203322.2765486-4-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.45.2.1089.g2a221341d9-goog
In-Reply-To: <20240724203322.2765486-1-pasha.tatashin@soleen.com>
References: <20240724203322.2765486-1-pasha.tatashin@soleen.com>
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
index ae5ef3013a55..f5861f64e960 100644
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
2.45.2.1089.g2a221341d9-goog


