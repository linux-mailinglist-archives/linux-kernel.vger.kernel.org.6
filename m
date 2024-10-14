Return-Path: <linux-kernel+bounces-364236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7378099CE67
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 16:43:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED1EE1F23D42
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 14:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1516D19E802;
	Mon, 14 Oct 2024 14:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1Xb9Cad5"
Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7085C1AB52F
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 14:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728916999; cv=none; b=sL+ephW7VfCqWK1NXNpQ8sLT1ClSRAyHkrUewi9j+oSXgOMyzOrZ07t26nmJQnv2sVGu99cWUY1PDGUNRsrTVPW6NpTP6HmO4O2mSOXRWe5o4lZKp0thdCk5YpW2rJqcIBLu853/odOKc0zzpZUf/79a8ONDhA09nJMqC+JC9e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728916999; c=relaxed/simple;
	bh=wLvOwsrQa5UKm+jKDOIwN8m2RXDdyYXBQWdLNdWkHNQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=SwqlST/Pg0Pow301nN0MafVpkLwXDDw0bBK67Gy5IhAfX7mtpaWDOErZxSv4ebKFYLzdhsGMXIhtzQ9Kz27ZnEoXFXehbvXZpphfmOpI0Gz9d4zKooH2OpZrL1O+q8yR+8/sNVjStRzrBiA8MNCJoD37uDRTiqe/vv/kve7J+o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--elver.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1Xb9Cad5; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elver.bounces.google.com
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-5c930ca5d12so4802277a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 07:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728916996; x=1729521796; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YAANA2HCjAYrDp100j/+RFsOVPjXu6D4EaWrswZHDqg=;
        b=1Xb9Cad5GoAIwQdhoORSz4fQno6+UoTTVYxOn4tZSZTPghvVfQBhPy+QA7Kg44s2K/
         f4nsnt+QRrb59KjP1xaz4wDqDAIRaJX0xuTytTURzUQypr2oJvFz9k0aAlPchtA3NrYc
         KdfW6zbFx7B5Iu3CJxY4ytSU1Dqko5X4pnnGjZdRyzHoLoZF4EQef7oezjVH3YCOnbTR
         LTtNbW4lQopHpY/XfUC2rvMB3/K8UCXLleXbzw1kj2zIGUqr4dVVztxzK6sasg/JkRzc
         iD8w88MhgyQPyxXH+oreS+BwPQooZHMJaHoCkdA9XRXEnDPiIG6Tr54unx0JVssTRhjP
         0aLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728916996; x=1729521796;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YAANA2HCjAYrDp100j/+RFsOVPjXu6D4EaWrswZHDqg=;
        b=REiDV7hhRj443N4GGNFAdwGD+z8tQeESQssx1qbBSdOj/zCybJUG65b8fOvDVB5dXj
         KkliNCidOjZpcyp8WSksbAvutUsJlfICDCAp9nEjFi7ZhYBJwo2yOClUyYH9PfRsPHN3
         jAqYUtKUrPmCbaMYlqW5DRPNBvVvuRPWT03kTFwrlABTupOnE/vYIbpTOWvIqadY+alS
         Ix1W8cBqf6DCNQkPXYegkhGMjDthSbhXn+9aqozmMegYt0YsecWoe7WphHO0uYfDnbdE
         OuxyS5NHXSpkyHplZJ4MBrHHqkKacIvPYc74k+W8kMYGGqBI9p8skKEF7bncVRrHAY9D
         T19g==
X-Forwarded-Encrypted: i=1; AJvYcCXy9LvQG6H+kVNMdUcCGAsNwLZrk7gLq1WKA6YSUKx8dbZo4XuOL1muYCXlkT5vu3iumTDOltRRAoBe+J8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ+SUq7cLjHRG7iuwqC4iTGUk6Begnl1C1ZGwkPtEdQFhGBKqN
	UvRphbDbRFAfLAaIrVCrqea6hSGdgMKr5LqnMVqv17GYf8wHScJe/5BYOX+unZ0zt/pjyf/kSw=
	=
X-Google-Smtp-Source: AGHT+IFTDRF0Qp8CoLx60Mh7xmAgB7am+mThKZHAtPtMAiCGJFiISia+nccgZzSQGx3npJ8PyJ1tYeEM4w==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:9c:201:9a7c:c6fa:d24e:a813])
 (user=elver job=sendgmr) by 2002:a05:6402:1e96:b0:5c7:20c1:1ce with SMTP id
 4fb4d7f45d1cf-5c9475dba4cmr5899a12.2.1728916995470; Mon, 14 Oct 2024 07:43:15
 -0700 (PDT)
Date: Mon, 14 Oct 2024 16:42:52 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241014144300.3182961-1-elver@google.com>
Subject: [PATCH 1/2] kcsan: Turn report_filterlist_lock into a raw_spinlock
From: Marco Elver <elver@google.com>
To: elver@google.com, "Paul E. McKenney" <paulmck@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Alexander Potapenko <glider@google.com>, Boqun Feng <boqun.feng@gmail.com>, kasan-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, Ran Xiaokai <ran.xiaokai@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"

Ran Xiaokai reports that with a KCSAN-enabled PREEMPT_RT kernel, we can see
splats like:

| BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48
| in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 0, name: swapper/1
| preempt_count: 10002, expected: 0
| RCU nest depth: 0, expected: 0
| no locks held by swapper/1/0.
| irq event stamp: 156674
| hardirqs last  enabled at (156673): [<ffffffff81130bd9>] do_idle+0x1f9/0x240
| hardirqs last disabled at (156674): [<ffffffff82254f84>] sysvec_apic_timer_interrupt+0x14/0xc0
| softirqs last  enabled at (0): [<ffffffff81099f47>] copy_process+0xfc7/0x4b60
| softirqs last disabled at (0): [<0000000000000000>] 0x0
| Preemption disabled at:
| [<ffffffff814a3e2a>] paint_ptr+0x2a/0x90
| CPU: 1 UID: 0 PID: 0 Comm: swapper/1 Not tainted 6.11.0+ #3
| Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.0-0-ga698c8995f-prebuilt.qemu.org 04/01/2014
| Call Trace:
|  <IRQ>
|  dump_stack_lvl+0x7e/0xc0
|  dump_stack+0x1d/0x30
|  __might_resched+0x1a2/0x270
|  rt_spin_lock+0x68/0x170
|  kcsan_skip_report_debugfs+0x43/0xe0
|  print_report+0xb5/0x590
|  kcsan_report_known_origin+0x1b1/0x1d0
|  kcsan_setup_watchpoint+0x348/0x650
|  __tsan_unaligned_write1+0x16d/0x1d0
|  hrtimer_interrupt+0x3d6/0x430
|  __sysvec_apic_timer_interrupt+0xe8/0x3a0
|  sysvec_apic_timer_interrupt+0x97/0xc0
|  </IRQ>

On a detected data race, KCSAN's reporting logic checks if it should
filter the report. That list is protected by the report_filterlist_lock
*non-raw* spinlock which may sleep on RT kernels.

Since KCSAN may report data races in any context, convert it to a
raw_spinlock.

This requires being careful about when to allocate memory for the filter
list itself which can be done via KCSAN's debugfs interface. Concurrent
modification of the filter list via debugfs should be rare: the chosen
strategy is to optimistically pre-allocate memory before the critical
section and discard if unused.

Link: https://lore.kernel.org/all/20240925143154.2322926-1-ranxiaokai627@163.com/
Reported-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
Signed-off-by: Marco Elver <elver@google.com>
---
 kernel/kcsan/debugfs.c | 74 ++++++++++++++++++++----------------------
 1 file changed, 36 insertions(+), 38 deletions(-)

diff --git a/kernel/kcsan/debugfs.c b/kernel/kcsan/debugfs.c
index 53b21ae30e00..b14072071889 100644
--- a/kernel/kcsan/debugfs.c
+++ b/kernel/kcsan/debugfs.c
@@ -46,14 +46,8 @@ static struct {
 	int		used;		/* number of elements used */
 	bool		sorted;		/* if elements are sorted */
 	bool		whitelist;	/* if list is a blacklist or whitelist */
-} report_filterlist = {
-	.addrs		= NULL,
-	.size		= 8,		/* small initial size */
-	.used		= 0,
-	.sorted		= false,
-	.whitelist	= false,	/* default is blacklist */
-};
-static DEFINE_SPINLOCK(report_filterlist_lock);
+} report_filterlist;
+static DEFINE_RAW_SPINLOCK(report_filterlist_lock);
 
 /*
  * The microbenchmark allows benchmarking KCSAN core runtime only. To run
@@ -110,7 +104,7 @@ bool kcsan_skip_report_debugfs(unsigned long func_addr)
 		return false;
 	func_addr -= offset; /* Get function start */
 
-	spin_lock_irqsave(&report_filterlist_lock, flags);
+	raw_spin_lock_irqsave(&report_filterlist_lock, flags);
 	if (report_filterlist.used == 0)
 		goto out;
 
@@ -127,7 +121,7 @@ bool kcsan_skip_report_debugfs(unsigned long func_addr)
 		ret = !ret;
 
 out:
-	spin_unlock_irqrestore(&report_filterlist_lock, flags);
+	raw_spin_unlock_irqrestore(&report_filterlist_lock, flags);
 	return ret;
 }
 
@@ -135,9 +129,9 @@ static void set_report_filterlist_whitelist(bool whitelist)
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(&report_filterlist_lock, flags);
+	raw_spin_lock_irqsave(&report_filterlist_lock, flags);
 	report_filterlist.whitelist = whitelist;
-	spin_unlock_irqrestore(&report_filterlist_lock, flags);
+	raw_spin_unlock_irqrestore(&report_filterlist_lock, flags);
 }
 
 /* Returns 0 on success, error-code otherwise. */
@@ -145,6 +139,9 @@ static ssize_t insert_report_filterlist(const char *func)
 {
 	unsigned long flags;
 	unsigned long addr = kallsyms_lookup_name(func);
+	unsigned long *delay_free = NULL;
+	unsigned long *new_addrs = NULL;
+	size_t new_size = 0;
 	ssize_t ret = 0;
 
 	if (!addr) {
@@ -152,32 +149,33 @@ static ssize_t insert_report_filterlist(const char *func)
 		return -ENOENT;
 	}
 
-	spin_lock_irqsave(&report_filterlist_lock, flags);
+retry_alloc:
+	/*
+	 * Check if we need an allocation, and re-validate under the lock. Since
+	 * the report_filterlist_lock is a raw, cannot allocate under the lock.
+	 */
+	if (data_race(report_filterlist.used == report_filterlist.size)) {
+		new_size = (report_filterlist.size ?: 4) * 2;
+		delay_free = new_addrs = kmalloc_array(new_size, sizeof(unsigned long), GFP_KERNEL);
+		if (!new_addrs)
+			return -ENOMEM;
+	}
 
-	if (report_filterlist.addrs == NULL) {
-		/* initial allocation */
-		report_filterlist.addrs =
-			kmalloc_array(report_filterlist.size,
-				      sizeof(unsigned long), GFP_ATOMIC);
-		if (report_filterlist.addrs == NULL) {
-			ret = -ENOMEM;
-			goto out;
-		}
-	} else if (report_filterlist.used == report_filterlist.size) {
-		/* resize filterlist */
-		size_t new_size = report_filterlist.size * 2;
-		unsigned long *new_addrs =
-			krealloc(report_filterlist.addrs,
-				 new_size * sizeof(unsigned long), GFP_ATOMIC);
-
-		if (new_addrs == NULL) {
-			/* leave filterlist itself untouched */
-			ret = -ENOMEM;
-			goto out;
+	raw_spin_lock_irqsave(&report_filterlist_lock, flags);
+	if (report_filterlist.used == report_filterlist.size) {
+		/* Check we pre-allocated enough, and retry if not. */
+		if (report_filterlist.used >= new_size) {
+			raw_spin_unlock_irqrestore(&report_filterlist_lock, flags);
+			kfree(new_addrs); /* kfree(NULL) is safe */
+			delay_free = new_addrs = NULL;
+			goto retry_alloc;
 		}
 
+		if (report_filterlist.used)
+			memcpy(new_addrs, report_filterlist.addrs, report_filterlist.used * sizeof(unsigned long));
+		delay_free = report_filterlist.addrs; /* free the old list */
+		report_filterlist.addrs = new_addrs;  /* switch to the new list */
 		report_filterlist.size = new_size;
-		report_filterlist.addrs = new_addrs;
 	}
 
 	/* Note: deduplicating should be done in userspace. */
@@ -185,9 +183,9 @@ static ssize_t insert_report_filterlist(const char *func)
 		kallsyms_lookup_name(func);
 	report_filterlist.sorted = false;
 
-out:
-	spin_unlock_irqrestore(&report_filterlist_lock, flags);
+	raw_spin_unlock_irqrestore(&report_filterlist_lock, flags);
 
+	kfree(delay_free);
 	return ret;
 }
 
@@ -204,13 +202,13 @@ static int show_info(struct seq_file *file, void *v)
 	}
 
 	/* show filter functions, and filter type */
-	spin_lock_irqsave(&report_filterlist_lock, flags);
+	raw_spin_lock_irqsave(&report_filterlist_lock, flags);
 	seq_printf(file, "\n%s functions: %s\n",
 		   report_filterlist.whitelist ? "whitelisted" : "blacklisted",
 		   report_filterlist.used == 0 ? "none" : "");
 	for (i = 0; i < report_filterlist.used; ++i)
 		seq_printf(file, " %ps\n", (void *)report_filterlist.addrs[i]);
-	spin_unlock_irqrestore(&report_filterlist_lock, flags);
+	raw_spin_unlock_irqrestore(&report_filterlist_lock, flags);
 
 	return 0;
 }
-- 
2.47.0.rc1.288.g06298d1525-goog


