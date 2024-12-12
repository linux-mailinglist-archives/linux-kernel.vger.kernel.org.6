Return-Path: <linux-kernel+bounces-444019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06C789EFF71
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 23:38:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACE12287EC7
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 22:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D27771DE3C8;
	Thu, 12 Dec 2024 22:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yPo8SBB8"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F9119995A
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 22:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734043111; cv=none; b=XjcdQk6dni6z9DIXSqjzEX5YlYCAWxfMmMdmApS4obj1c3Fa4IVP/3HRcbK5k/dmICqgGMbIguAw9fRnBTPkLnEb6ZE9BUKSBLr9wagJPdFYWv1SlgMgNispQVdr3peM/eyJS4llmzovn6yyMae6+G9u9kjBZyhgoWkkNuwSXs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734043111; c=relaxed/simple;
	bh=vmMOhQElAxZQubssqoZ76ueioUb543GwFQ2fpiQoszs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=PMx3YWDt5jBflPUDhV2ospcLKkFwjp8SRw9VnqCjJcGPVRFAEML1Z3gWaRDHWbyWQjrNflJ7I7j6ejRHdD5DG7qV5NIljuxLOx2DRXwRopADqYTH1xZiym/0qaXMXLBGKxJoZFioDpmWhJAlwHfntBFG0HhbIX0aBAnOkmY5Bi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yPo8SBB8; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-7fcb7afb4e1so1192771a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 14:38:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734043109; x=1734647909; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dbplPvmkMOFKgoh6rXsCMhFFJzzGm6gRkOYRbMLbYjA=;
        b=yPo8SBB8b8IqywA++/XB/ddAAcxo6kFOOmXiesQd6d5dh9YF+dARpae2Tg6ozrsvkz
         i78S+G52HUAFFfHGrfdv+88WBR2xBKd2bYbIeCEQoXtz/ooLtvTqhSQi3M0p4jZfmqiL
         xEM4soDfPx6p1RJAoDqdk1SBwBR52l3Q6mb2EJ1QeFatAqQPnL1PqRFsQVhbyZFmJu3k
         DidBd1h/SB13H1+CaprSAuEt9RvpWGfyRZQETDfJePuCJ9AG6JaGe/SNzxsCZmOyTS6X
         r1298qe8v5S4tND04Ws9FnYvzFiJl1OfQDxVlEWciJXJNpWD0Jg/vAS65D3CrNwZI+i9
         84Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734043109; x=1734647909;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dbplPvmkMOFKgoh6rXsCMhFFJzzGm6gRkOYRbMLbYjA=;
        b=NkkbEVxRo/hKdOg27/S23+/qkDcaahu0dmWgcu557N+Ir4T+eJgWAsGNNpQt+Aqxyp
         vbzLKU6SIkCx8NKiUxWjechLq2fz0Ogiu5gIVrynE/UwcQBuQiNOyRWxviVEs7mKTay9
         dd+1sLo320jqXU9mQR2MdodK7gp24QBqqwSACBwn3MJ9vGd6JrO7EgYtkBTW5ASWTkBg
         22vQbtDOK9sy6Yh4o9NDg2bilQ1Fa4nV/KGFkK7YO61sM7ZwQ7Eb3gpXsZhkvKTaQtsZ
         g81oFQN7h+iREH+nYBTvmhZtFu9TRAhDfJ5Cuw6Ty3PaGpUrnfZFqOX+k3Kh1wj23nku
         OMUw==
X-Gm-Message-State: AOJu0Ywq1Xq43z1N9IoS6BaQVbhsIVzWax2qtoacQkujPorOazUdYQ3f
	CRFurVRoaJmJ8uHVkkhZm8qjRtF9v9zWQkpwKIEV7+84QXR8gCpRtdtcwF1OfZ3zcDCoO0E+rFI
	oDZ/cvgPtHS2oMxN9M5SPBnAZeoLgpwOTS97Qr28hVFdEvjlqFheFY734KVwNbJfh9KDiMqspau
	i0aW1Mcck1Nbz5AcZ3dBnmJkvxdA/uBTOjEjUk9j5zRtUj
X-Google-Smtp-Source: AGHT+IFeeHKUBVO2OKvtBdOKZ4KxBBCZ5G4t4E7rki1RCQkRij+Dm53Gw9xcsXfRcV+DlV1OXxPJKgNyLvLm
X-Received: from pfuj20.prod.google.com ([2002:a05:6a00:1314:b0:728:e2c6:8741])
 (user=jstultz job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:e68c:b0:1e0:d20b:4f80
 with SMTP id adf61e73a8af0-1e1dfc1846emr410754637.9.1734043108914; Thu, 12
 Dec 2024 14:38:28 -0800 (PST)
Date: Thu, 12 Dec 2024 14:38:06 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241212223825.2563659-1-jstultz@google.com>
Subject: [PATCH] test-ww_mutex: Allow test to be run (and re-run) from userland
From: John Stultz <jstultz@google.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: John Stultz <jstultz@google.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, 
	Boqun Feng <boqun.feng@gmail.com>, "Paul E . McKenney" <paulmck@kernel.org>, 
	Joel Fernandes <joelaf@google.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"

In cases where the ww_mutex test was occasionally tripping on
hard to find issues, leaving qemu in a reboot loop was my best
way to reproduce problems. These reboots however wasted time
when I just wanted to run the test-ww_mutex logic.

So tweak the test-ww_mutex test so that it can be re-triggered
via a sysfs file, so the test can be run repeatedly without
doing module loads or restarting.

To use, run as root:
  echo 1 > /sys/kernel/test_ww_mutex/run_tests

Thoughts or feedback would be appreciated!

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Will Deacon <will@kernel.org>
Cc: Waiman Long <longman@redhat.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: "Paul E . McKenney" <paulmck@kernel.org>
Cc: Joel Fernandes <joelaf@google.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: kernel-team@android.com
Signed-off-by: John Stultz <jstultz@google.com>
---
 kernel/locking/test-ww_mutex.c | 70 ++++++++++++++++++++++++++++++----
 1 file changed, 63 insertions(+), 7 deletions(-)

diff --git a/kernel/locking/test-ww_mutex.c b/kernel/locking/test-ww_mutex.c
index 5d58b2c0ef98b..45e56bbd9ad8f 100644
--- a/kernel/locking/test-ww_mutex.c
+++ b/kernel/locking/test-ww_mutex.c
@@ -638,19 +638,15 @@ static int stress(int nlocks, int nthreads, unsigned int flags)
 	return 0;
 }
 
-static int __init test_ww_mutex_init(void)
+static DEFINE_MUTEX(run_lock);
+
+static int run_tests(void)
 {
 	int ncpus = num_online_cpus();
 	int ret, i;
 
 	printk(KERN_INFO "Beginning ww mutex selftests\n");
 
-	prandom_seed_state(&rng, get_random_u64());
-
-	wq = alloc_workqueue("test-ww_mutex", WQ_UNBOUND, 0);
-	if (!wq)
-		return -ENOMEM;
-
 	ret = test_mutex();
 	if (ret)
 		return ret;
@@ -689,8 +685,68 @@ static int __init test_ww_mutex_init(void)
 	return 0;
 }
 
+static ssize_t run_tests_store(struct kobject *kobj, struct kobj_attribute *attr,
+			       const char *buf, size_t count)
+{
+	if (!mutex_trylock(&run_lock)) {
+		pr_err("Test already running\n");
+		return count;
+	}
+
+	run_tests();
+	mutex_unlock(&run_lock);
+
+	return count;
+}
+
+static struct kobj_attribute run_tests_attribute =
+	__ATTR(run_tests, 0664, NULL, run_tests_store);
+
+static struct attribute *attrs[] = {
+	&run_tests_attribute.attr,
+	NULL,   /* need to NULL terminate the list of attributes */
+};
+
+static struct attribute_group attr_group = {
+	.attrs = attrs,
+};
+
+static struct kobject *test_ww_mutex_kobj;
+
+static int __init test_ww_mutex_init(void)
+{
+	int ret;
+
+	prandom_seed_state(&rng, get_random_u64());
+
+	wq = alloc_workqueue("test-ww_mutex", WQ_UNBOUND, 0);
+	if (!wq)
+		return -ENOMEM;
+
+	test_ww_mutex_kobj = kobject_create_and_add("test_ww_mutex", kernel_kobj);
+	if (!test_ww_mutex_kobj) {
+		destroy_workqueue(wq);
+		return -ENOMEM;
+	}
+
+	/* Create the files associated with this kobject */
+	ret = sysfs_create_group(test_ww_mutex_kobj, &attr_group);
+	if (ret) {
+		kobject_put(test_ww_mutex_kobj);
+		destroy_workqueue(wq);
+		return ret;
+	}
+
+	mutex_lock(&run_lock);
+	ret = run_tests();
+	mutex_unlock(&run_lock);
+
+	return ret;
+}
+
 static void __exit test_ww_mutex_exit(void)
 {
+	kobject_put(test_ww_mutex_kobj);
 	destroy_workqueue(wq);
 }
 
-- 
2.47.1.613.gc27f4b7a9f-goog


