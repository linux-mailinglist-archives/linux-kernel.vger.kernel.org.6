Return-Path: <linux-kernel+bounces-411519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC7599CFB65
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 00:59:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE0B8284D98
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 23:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18DA31AF0A5;
	Fri, 15 Nov 2024 23:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NCMaWtDq"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19AE17E44A
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 23:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731715165; cv=none; b=MTRnCptRTJBl4acIlBs/3iOGgE2+335i8NAKpYGqbGEaAkkbNp4JxNpWPIDgSRcEdXfWqX1jOY3lBIY1AbXQPq093O17Pvos5KSzb7ca3wxz1aBdD65XJiQU3QI8ArcKQH9R2C381/67W0lTPXxPTRGWc9vZfU3W9/pHtzHn0Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731715165; c=relaxed/simple;
	bh=aC29OxXKCcioAr42fPwEhfe8RiKgZ3apJ9cXGIWg1ns=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=iJKOSAGxmx3rTHVqag5F+PFkxbo1keSMbukLe+TaLLf1KOUXWb9sVLja3/9/P40c7Ga+abSjwg3+ymcIp7T9DcoAJVkDy1u2CdEp2mfaxNipe30CzQOgK/bUXjDLhI6ikfq0eJS1ot3eSBrrRgRG2sXwETdSHuI2A4A7cp3hSd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NCMaWtDq; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-7ecb7d90673so1197989a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 15:59:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731715163; x=1732319963; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=h3XRtSyry9JQzvovM4pRP52vlg5Pcx60Uk8U0JJV3GM=;
        b=NCMaWtDqny2x3LfjGEUgcRMSaXsAbyazd55svT3pSIpe3fQELfDlEDzommzfnN/noi
         sp01PtnvcgNVHHDBuGrWfefvYy9TWCRTF6dL+ymADFJXHJPnQZCwKOIbrSO8uXG81E2Z
         TEAcF/EEiXMZWNokXHJMHvtuEvvIWp4Yq4onQsFB8pBWXlKPHzR047OUkuOx9t7OIDSk
         6h8F6pADznG7k5hjdfbrya/eDMFe5FdI3n1+Ah9QH1ZXbQY0/4s96Td8qZB3b0GgoXaG
         btuIz/c6gYluNW+0Mxt/caw58f1L6+p68mga/esFUbjEuGrq6yI6Ui3migJClCGy6QWd
         ATCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731715163; x=1732319963;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h3XRtSyry9JQzvovM4pRP52vlg5Pcx60Uk8U0JJV3GM=;
        b=egx/y8xtgb4rAS40630iHcx1qnNhtW6UmOo7vWTCjs2qcCMnEhgGEvVWWMBWg8z4HO
         yprr/jgsqjrMiHTytAmqBwFhQii0MgI3O+wM1wRLFlUVDD8bDKKtQd1PsX3edCY7s+Ge
         UXRprOZ4S4I9czwKmpKaoddVhoj6sXFBMQTR6+nu7vET4fVxlBCzCKVO/CuIgz8ikxuF
         DrGikJzoorzZ00821kTloRyeOLo6G00ye01Yi38si4lTLD7yJ5IzS8VSzMKwgw+fR0TJ
         mXIW6hjjCIGPNp7tnckM11Q7PPAZv5C2CoiLg0ZT3UW9aCoRs2sO/t48IH6ABM0Jcq3u
         TLvg==
X-Gm-Message-State: AOJu0YyZG+RAz+OSehgQX5sBOTjlIx3rEXAsqx0+6dH8dwgEM2lqE2Jz
	gc2DbBG7E/aakkqtUsAIB08INigjBycrubmo4INhAQUhL/vIKmnVrKjWt7j+slbfxC4IVSTBpnI
	scNCqnRXjT1inxRgKXWCA8r2OrApRh8XsnN+Ir5wEHd3xSoR8eOekisKpmOnB5CGDDUY4KS6+Vu
	MrV7a6qtMXeyB670/FJpigWGldPxNskC3E92cEzT4/Af2x
X-Google-Smtp-Source: AGHT+IFfjneGtpUnuYhYA46URc96fuBCWIoRGNi7btQ30PJlecddKweRTZXZ6eo7bLamSvG1iHiuwtDgK5Wq
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a63:bc01:0:b0:694:4311:6eb4 with SMTP id
 41be03b00d2f7-7f8c2075c03mr8191a12.8.1731715162947; Fri, 15 Nov 2024 15:59:22
 -0800 (PST)
Date: Fri, 15 Nov 2024 15:59:10 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241115235919.1029490-1-jstultz@google.com>
Subject: [RFC][PATCH] test-ww_mutex: Allow test to be run (and re-run) from userland
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
index 10a5736a21c2..cc0d2e59049a 100644
--- a/kernel/locking/test-ww_mutex.c
+++ b/kernel/locking/test-ww_mutex.c
@@ -636,19 +636,15 @@ static int stress(int nlocks, int nthreads, unsigned int flags)
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
@@ -687,8 +683,68 @@ static int __init test_ww_mutex_init(void)
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
2.47.0.338.g60cca15819-goog


