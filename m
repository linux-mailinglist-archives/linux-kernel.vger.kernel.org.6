Return-Path: <linux-kernel+bounces-381021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A079F9AF932
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 07:40:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3E401C21ED0
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 05:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CD0319069B;
	Fri, 25 Oct 2024 05:40:33 +0000 (UTC)
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFFC118FDAC
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 05:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729834832; cv=none; b=KpUoBxiRKg1FfljTMEPDirdG9YH0fR+nC3dxtHVwebiz4rFMNNMIugA+DJVCtTFSBURn3yELoheS2jZY+RJZVHI9kE56JKE5CdQyk5ZIOEOKjvier+kEdflVFyAd5PE3FRQG88EBdBSMZkKLLf9m5l+QZeusnKr+iupPXiUJyW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729834832; c=relaxed/simple;
	bh=7wR0TmyIijUT4Rnb0eGGqftPDtRq2PlSvAoORW2cFrg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h5R/EaGid46gJgW01EIygBHD8J56h8HubY3JGy+wBLQWY3vksxgH5HMrKzpd6klTdRVly0vqaiOOgUTQH+PB67ivCIzs6YUK6gkMeHsvtz7JSwuHlC1UITN+TruE6i8WGGB86C5Hgv2bNhYx98/4y99mETGsAEBSM1dxPMy131w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-83aad99d6bfso64749739f.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 22:40:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729834829; x=1730439629;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RXiOlnqfIZ5UQcIRrhIu2F+HmvTXciykMfU7IrMNRL0=;
        b=M/3AgLVbX6tpXpInP2dM2ZOUZ7ySK9TNdZeiqpcU/yesMVJ47nKTIoPscYHdbnFtMF
         N0Px7D9GSeuWZXXzpSgcGR2czKvaKoE67XE/4O/kaZI3cGnQzUzqWkgRlJ5QEwTFd1BM
         3u94b34yLHawxlT0MLwHKavfDDHmz/sMEK67T6uU6sid6dYbMKJI7ExcVnfUgiIHjelP
         WFLZr0PwAwkCBcAhiGICKDeFwVYCUs7q4QSOkeI9w59UMnol6DylOxpNB8YnBAxuh6A6
         uE9Phj5Pdw301WUf5kuqfOhhbdThaTrAUrVo2xZLgptvnu5sSLpWx/aLghSJiquDMLZ1
         Xf7w==
X-Forwarded-Encrypted: i=1; AJvYcCWBpbg9jJDucH85RO4P6L/NslaShXauTWHBgGBLUoTVcO9MkAH3FHi5fDvvL4vc8tEMwjz/ZmJnZCNVkCA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyA+YYz7P+eDDqp+Ud7JgKFYoKqUheqsFE/8OFVsxn3sF2nPGZU
	lqxd8LUqHLKVsZbw8zlQW2Z4Q3j+wHJlzbXxvAu8+ZxDaG+UaZKH
X-Google-Smtp-Source: AGHT+IGIyEf18qVSaCWAKvZsY8UgMeiGQWCmR4R5X5ggObXaDA5oY0wgXY+x/Py/P7zYulFC6KQNvw==
X-Received: by 2002:a05:6e02:180a:b0:3a0:4d1f:519c with SMTP id e9e14a558f8ab-3a4d592e278mr90195845ab.3.1729834828644;
        Thu, 24 Oct 2024 22:40:28 -0700 (PDT)
Received: from localhost (c-76-141-129-107.hsd1.il.comcast.net. [76.141.129.107])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a4e6df614esm1182335ab.46.2024.10.24.22.40.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 22:40:27 -0700 (PDT)
From: David Vernet <void@manifault.com>
To: tj@kernel.org
Cc: sched-ext@meta.com,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] scx: Fix raciness in scx_ops_bypass()
Date: Fri, 25 Oct 2024 00:40:14 -0500
Message-ID: <20241025054014.66631-2-void@manifault.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241025054014.66631-1-void@manifault.com>
References: <20241025054014.66631-1-void@manifault.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

scx_ops_bypass() can currently race on the ops enable / disable path as
follows:

1. scx_ops_bypass(true) called on enable path, bypass depth is set to 1
2. An op on the init path exits, which schedules scx_ops_disable_workfn()
3. scx_ops_bypass(false) is called on the disable path, and bypass depth
   is decremented to 0
4. kthread is scheduled to execute scx_ops_disable_workfn()
5. scx_ops_bypass(true) called, bypass depth set to 1
6. scx_ops_bypass() races when iterating over CPUs

Fixing this is difficult because we can't take any locks when enabling
bypass due to us not being able to trust the BPF scheduler. This is
problematic, because what we really need to do is coordinate between
possible concurrent calls of scx_ops_bypass(true) and
scx_ops_bypass(false), but the whole point of that code is that we can't
use any locks to coordinate. Instead of taking a lock, however, we can
instead just serialize the calls to enable and disable bypass by executing
the calls on the scx_ops_helper kthread that's currently responsible for
disabling a BPF scheduler.

This patch therefore adds a new schedule_scx_bypass_delta() function which
schedules changes to scx_ops_bypass() to occur on the scx_ops_helper
kthread (where necessary).

Without this change, we observe the following warnings when running the
'exit' sched_ext selftest (sometimes requires a couple of runs):

.[root@virtme-ng sched_ext]# ./runner -t exit
===== START =====
TEST: exit
...
[   14.935078] WARNING: CPU: 2 PID: 360 at kernel/sched/ext.c:4332 scx_ops_bypass+0x1ca/0x280
[   14.935126] Modules linked in:
[   14.935150] CPU: 2 UID: 0 PID: 360 Comm: sched_ext_ops_h Not tainted 6.11.0-virtme #24
[   14.935192] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Arch Linux 1.16.3-1-1 04/01/2014
[   14.935242] Sched_ext: exit (enabling+all)
[   14.935244] RIP: 0010:scx_ops_bypass+0x1ca/0x280
[   14.935300] Code: ff ff ff e8 48 96 10 00 fb e9 08 ff ff ff c6 05 7b 34 e8 01 01 90 48 c7 c7 89 86 88 87 e8 be 1d f8 ff 90 0f 0b 90 90 eb 95 90 <0f> 0b 90 41 8b 84 24 24 0a 00 00 eb 97 90 0f 0b 90 41 8b 84 24 24
[   14.935394] RSP: 0018:ffffb706c0957ce0 EFLAGS: 00010002
[   14.935424] RAX: 0000000000000009 RBX: 0000000000000001 RCX: 00000000e3fb8b2a
[   14.935465] RDX: 0000000000000001 RSI: 0000000000000004 RDI: ffffffff88a4c080
[   14.935512] RBP: 0000000000009b56 R08: 0000000000000004 R09: 00000003f12e520a
[   14.935555] R10: ffffffff863a9795 R11: 0000000000000000 R12: ffff8fc5fec31300
[   14.935598] R13: ffff8fc5fec31318 R14: 0000000000000286 R15: 0000000000000018
[   14.935642] FS:  0000000000000000(0000) GS:ffff8fc5fe680000(0000) knlGS:0000000000000000
[   14.935684] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   14.935721] CR2: 0000557d92890b88 CR3: 000000002464a000 CR4: 0000000000750ef0
[   14.935765] PKRU: 55555554
[   14.935782] Call Trace:
[   14.935802]  <TASK>
[   14.935823]  ? __warn+0xce/0x220
[   14.935850]  ? scx_ops_bypass+0x1ca/0x280
[   14.935881]  ? report_bug+0xc1/0x160
[   14.935909]  ? handle_bug+0x61/0x90
[   14.935934]  ? exc_invalid_op+0x1a/0x50
[   14.935959]  ? asm_exc_invalid_op+0x1a/0x20
[   14.935984]  ? raw_spin_rq_lock_nested+0x15/0x30
[   14.936019]  ? scx_ops_bypass+0x1ca/0x280
[   14.936046]  ? srso_alias_return_thunk+0x5/0xfbef5
[   14.936081]  ? __pfx_scx_ops_disable_workfn+0x10/0x10
[   14.936111]  scx_ops_disable_workfn+0x146/0xac0
[   14.936142]  ? finish_task_switch+0xa9/0x2c0
[   14.936172]  ? srso_alias_return_thunk+0x5/0xfbef5
[   14.936211]  ? __pfx_scx_ops_disable_workfn+0x10/0x10
[   14.936244]  kthread_worker_fn+0x101/0x2c0
[   14.936268]  ? __pfx_kthread_worker_fn+0x10/0x10
[   14.936299]  kthread+0xec/0x110
[   14.936327]  ? __pfx_kthread+0x10/0x10
[   14.936351]  ret_from_fork+0x37/0x50
[   14.936374]  ? __pfx_kthread+0x10/0x10
[   14.936400]  ret_from_fork_asm+0x1a/0x30
[   14.936427]  </TASK>
[   14.936443] irq event stamp: 21002
[   14.936467] hardirqs last  enabled at (21001): [<ffffffff863aa35f>] resched_cpu+0x9f/0xd0
[   14.936521] hardirqs last disabled at (21002): [<ffffffff863dd0ba>] scx_ops_bypass+0x11a/0x280
[   14.936571] softirqs last  enabled at (20642): [<ffffffff863683d7>] __irq_exit_rcu+0x67/0xd0
[   14.936622] softirqs last disabled at (20637): [<ffffffff863683d7>] __irq_exit_rcu+0x67/0xd0
[   14.936672] ---[ end trace 0000000000000000 ]---
[   14.953282] sched_ext: BPF scheduler "exit" disabled (unregistered from BPF)
[   14.953352] ------------[ cut here ]------------
[   14.953383] WARNING: CPU: 2 PID: 360 at kernel/sched/ext.c:4335 scx_ops_bypass+0x1d8/0x280
[   14.953428] Modules linked in:
[   14.953453] CPU: 2 UID: 0 PID: 360 Comm: sched_ext_ops_h Tainted: G        W          6.11.0-virtme #24
[   14.953505] Tainted: [W]=WARN
[   14.953527] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Arch Linux 1.16.3-1-1 04/01/2014
[   14.953574] RIP: 0010:scx_ops_bypass+0x1d8/0x280
[   14.953603] Code: c6 05 7b 34 e8 01 01 90 48 c7 c7 89 86 88 87 e8 be 1d f8 ff 90 0f 0b 90 90 eb 95 90 0f 0b 90 41 8b 84 24 24 0a 00 00 eb 97 90 <0f> 0b 90 41 8b 84 24 24 0a 00 00 eb 92 f3 0f 1e fa 49 8d 84 24 f0
[   14.953693] RSP: 0018:ffffb706c0957ce0 EFLAGS: 00010046
[   14.953722] RAX: 0000000000000001 RBX: 0000000000000000 RCX: 0000000000000001
[   14.953763] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff8fc5fec31318
[   14.953804] RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
[   14.953845] R10: ffffffff863a9795 R11: 0000000000000000 R12: ffff8fc5fec31300
[   14.953888] R13: ffff8fc5fec31318 R14: 0000000000000286 R15: 0000000000000018
[   14.953934] FS:  0000000000000000(0000) GS:ffff8fc5fe680000(0000) knlGS:0000000000000000
[   14.953974] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   14.954009] CR2: 0000557d92890b88 CR3: 000000002464a000 CR4: 0000000000750ef0
[   14.954052] PKRU: 55555554
[   14.954068] Call Trace:
[   14.954085]  <TASK>
[   14.954102]  ? __warn+0xce/0x220
[   14.954126]  ? scx_ops_bypass+0x1d8/0x280
[   14.954150]  ? report_bug+0xc1/0x160
[   14.954178]  ? handle_bug+0x61/0x90
[   14.954203]  ? exc_invalid_op+0x1a/0x50
[   14.954226]  ? asm_exc_invalid_op+0x1a/0x20
[   14.954250]  ? raw_spin_rq_lock_nested+0x15/0x30
[   14.954285]  ? scx_ops_bypass+0x1d8/0x280
[   14.954311]  ? __mutex_unlock_slowpath+0x3a/0x260
[   14.954343]  scx_ops_disable_workfn+0xa3e/0xac0
[   14.954381]  ? __pfx_scx_ops_disable_workfn+0x10/0x10
[   14.954413]  kthread_worker_fn+0x101/0x2c0
[   14.954442]  ? __pfx_kthread_worker_fn+0x10/0x10
[   14.954479]  kthread+0xec/0x110
[   14.954507]  ? __pfx_kthread+0x10/0x10
[   14.954530]  ret_from_fork+0x37/0x50
[   14.954553]  ? __pfx_kthread+0x10/0x10
[   14.954576]  ret_from_fork_asm+0x1a/0x30
[   14.954603]  </TASK>
[   14.954621] irq event stamp: 21002
[   14.954644] hardirqs last  enabled at (21001): [<ffffffff863aa35f>] resched_cpu+0x9f/0xd0
[   14.954686] hardirqs last disabled at (21002): [<ffffffff863dd0ba>] scx_ops_bypass+0x11a/0x280
[   14.954735] softirqs last  enabled at (20642): [<ffffffff863683d7>] __irq_exit_rcu+0x67/0xd0
[   14.954782] softirqs last disabled at (20637): [<ffffffff863683d7>] __irq_exit_rcu+0x67/0xd0
[   14.954829] ---[ end trace 0000000000000000 ]---
[   15.022283] sched_ext: BPF scheduler "exit" disabled (unregistered from BPF)
[   15.092282] sched_ext: BPF scheduler "exit" disabled (unregistered from BPF)
[   15.149282] sched_ext: BPF scheduler "exit" disabled (unregistered from BPF)
ok 1 exit #
=====  END  =====

And with it, the test passes without issue after 100 runs:

.[root@virtme-ng sched_ext]# ./runner -t exit
===== START =====
TEST: exit
DESCRIPTION: Verify we can cleanly exit a scheduler in multiple places
OUTPUT:
[    7.412856] sched_ext: BPF scheduler "exit" enabled
[    7.427924] sched_ext: BPF scheduler "exit" disabled (unregistered from BPF)
[    7.466677] sched_ext: BPF scheduler "exit" enabled
[    7.475923] sched_ext: BPF scheduler "exit" disabled (unregistered from BPF)
[    7.512803] sched_ext: BPF scheduler "exit" enabled
[    7.532924] sched_ext: BPF scheduler "exit" disabled (unregistered from BPF)
[    7.586809] sched_ext: BPF scheduler "exit" enabled
[    7.595926] sched_ext: BPF scheduler "exit" disabled (unregistered from BPF)
[    7.661923] sched_ext: BPF scheduler "exit" disabled (unregistered from BPF)
[    7.723923] sched_ext: BPF scheduler "exit" disabled (unregistered from BPF)
ok 1 exit #
=====  END  =====

=============================

RESULTS:

PASSED:  1
SKIPPED: 0
FAILED:  0

Fixes: f0e1a0643a59 ("sched_ext: Implement BPF extensible scheduler class")
Signed-off-by: David Vernet <void@manifault.com>
---
 kernel/sched/ext.c | 84 ++++++++++++++++++++++++++++++++++++----------
 1 file changed, 66 insertions(+), 18 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 6eae3b69bf6e..859720c4d55d 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -863,6 +863,8 @@ DEFINE_STATIC_KEY_FALSE(__scx_ops_enabled);
 DEFINE_STATIC_PERCPU_RWSEM(scx_fork_rwsem);
 static atomic_t scx_ops_enable_state_var = ATOMIC_INIT(SCX_OPS_DISABLED);
 static atomic_t scx_ops_bypass_depth = ATOMIC_INIT(0);
+static atomic_t scx_ops_bypass_en_cnt = ATOMIC_INIT(0);
+static atomic_t scx_ops_bypass_dis_cnt = ATOMIC_INIT(0);
 static bool scx_ops_init_task_enabled;
 static bool scx_switching_all;
 DEFINE_STATIC_KEY_FALSE(__scx_switched_all);
@@ -2658,7 +2660,7 @@ static int balance_one(struct rq *rq, struct task_struct *prev)
 		 * scheduler wants to handle this explicitly, it should
 		 * implement ->cpu_release().
 		 *
-		 * See scx_ops_disable_workfn() for the explanation on the
+		 * See scx_ops_helper_workfn() for the explanation on the
 		 * bypassing test.
 		 */
 		if ((prev->scx.flags & SCX_TASK_QUEUED) &&
@@ -4419,7 +4421,7 @@ static const char *scx_exit_reason(enum scx_exit_kind kind)
 	}
 }
 
-static void scx_ops_disable_workfn(struct kthread_work *work)
+static void scx_ops_helper_workfn(struct kthread_work *work)
 {
 	struct scx_exit_info *ei = scx_exit_info;
 	struct scx_task_iter sti;
@@ -4428,12 +4430,23 @@ static void scx_ops_disable_workfn(struct kthread_work *work)
 	struct scx_dispatch_q *dsq;
 	int i, kind;
 
+	while (atomic_read(&scx_ops_bypass_en_cnt)) {
+		scx_ops_bypass(true);
+		atomic_dec(&scx_ops_bypass_en_cnt);
+	}
+
+	while (atomic_read(&scx_ops_bypass_dis_cnt)) {
+		scx_ops_bypass(false);
+		atomic_dec(&scx_ops_bypass_dis_cnt);
+	}
+
 	kind = atomic_read(&scx_exit_kind);
 	while (true) {
 		/*
-		 * NONE indicates that a new scx_ops has been registered since
-		 * disable was scheduled - don't kill the new ops. DONE
-		 * indicates that the ops has already been disabled.
+		 * NONE indicates either that a new scx_ops has been registered
+		 * since disable was scheduled, or that the helper was scheduled
+		 * on the enable path to disable bypass - don't kill the new
+		 * ops. DONE indicates that the ops has already been disabled.
 		 */
 		if (kind == SCX_EXIT_NONE || kind == SCX_EXIT_DONE)
 			return;
@@ -4571,9 +4584,9 @@ static void scx_ops_disable_workfn(struct kthread_work *work)
 	scx_ops_bypass(false);
 }
 
-static DEFINE_KTHREAD_WORK(scx_ops_disable_work, scx_ops_disable_workfn);
+static DEFINE_KTHREAD_WORK(scx_ops_helper_work, scx_ops_helper_workfn);
 
-static void schedule_scx_ops_disable_work(void)
+static void schedule_scx_ops_helper_work(void)
 {
 	struct kthread_worker *helper = READ_ONCE(scx_ops_helper);
 
@@ -4582,7 +4595,42 @@ static void schedule_scx_ops_disable_work(void)
 	 * scx_ops_helper isn't set up yet, there's nothing to do.
 	 */
 	if (helper)
-		kthread_queue_work(helper, &scx_ops_disable_work);
+		kthread_queue_work(helper, &scx_ops_helper_work);
+}
+
+/*
+ * schedule_scx_bypass_delta - Schedule bypass to be enabled or disabled.
+ *
+ * Record the need to either increment or decrement bypass depth, and schedule
+ * the scx_ops_helper kthread to perform the operation.
+ *
+ * In any context that an SCX scheduler may be loaded (i.e. any context other
+ * than the enable path), bypass depth must always be adjusted in the same
+ * execution context as the ops-disable path to avoid a call to
+ * scx_ops_bypass(false) racing with a call to scx_ops_bypass(true).
+ * Concurrent calls to the operations are never safe, due to the possibility of
+ * the following race:
+ *
+ * 1. scx_bypass_ops(false|true) is invoked, setting the depth to whatever
+ *    value causes the execution context to enter the actual bypass enable /
+ *    disable loop.
+ *
+ * 2. scx_bypass_ops(false|true) (whichever is the inverse of the call above)
+ *    is invoked in a different execution context, and also enters the enable /
+ *    disable loop before the context above has had a chance to iterate over
+ *    all CPUs.
+ *
+ * This is unsafe because it could cause us to e.g. set SCX_RQ_BYPASSING on an
+ * rq when it was already previously set, or _unset_ SCX_RQ_BYPASSING when we
+ * in fact need bypass to be enabled.
+ */
+static void schedule_scx_bypass_delta(bool bypass)
+{
+	if (bypass)
+		atomic_inc(&scx_ops_bypass_en_cnt);
+	else
+		atomic_inc(&scx_ops_bypass_dis_cnt);
+	schedule_scx_ops_helper_work();
 }
 
 static void scx_ops_disable(enum scx_exit_kind kind)
@@ -4594,7 +4642,7 @@ static void scx_ops_disable(enum scx_exit_kind kind)
 
 	atomic_try_cmpxchg(&scx_exit_kind, &none, kind);
 
-	schedule_scx_ops_disable_work();
+	schedule_scx_ops_helper_work();
 }
 
 static void dump_newline(struct seq_buf *s)
@@ -4882,7 +4930,7 @@ static void scx_ops_error_irq_workfn(struct irq_work *irq_work)
 	if (ei->kind >= SCX_EXIT_ERROR)
 		scx_dump_state(ei, scx_ops.exit_dump_len);
 
-	schedule_scx_ops_disable_work();
+	schedule_scx_ops_helper_work();
 }
 
 static DEFINE_IRQ_WORK(scx_ops_error_irq_work, scx_ops_error_irq_workfn);
@@ -4909,7 +4957,7 @@ static __printf(3, 4) void scx_ops_exit_kind(enum scx_exit_kind kind,
 
 	/*
 	 * Set ei->kind and ->reason for scx_dump_state(). They'll be set again
-	 * in scx_ops_disable_workfn().
+	 * in scx_ops_helper_workfn().
 	 */
 	ei->kind = kind;
 	ei->reason = scx_exit_reason(ei->kind);
@@ -5214,7 +5262,7 @@ static int scx_ops_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 	scx_task_iter_stop(&sti);
 	percpu_up_write(&scx_fork_rwsem);
 
-	scx_ops_bypass(false);
+	schedule_scx_bypass_delta(false);
 
 	if (!scx_ops_tryset_enable_state(SCX_OPS_ENABLED, SCX_OPS_ENABLING)) {
 		WARN_ON_ONCE(atomic_read(&scx_exit_kind) == SCX_EXIT_NONE);
@@ -5249,7 +5297,7 @@ static int scx_ops_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 err_disable_unlock_all:
 	scx_cgroup_unlock();
 	percpu_up_write(&scx_fork_rwsem);
-	scx_ops_bypass(false);
+	schedule_scx_bypass_delta(false);
 err_disable:
 	mutex_unlock(&scx_ops_enable_mutex);
 	/*
@@ -5258,11 +5306,11 @@ static int scx_ops_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 	 * scx_ops_error() wasn't already invoked and exit indicating success so
 	 * that the error is notified through ops.exit() with all the details.
 	 *
-	 * Flush scx_ops_disable_work to ensure that error is reported before
+	 * Flush scx_ops_helper_work to ensure that error is reported before
 	 * init completion.
 	 */
 	scx_ops_error("scx_ops_enable() failed (%d)", ret);
-	kthread_flush_work(&scx_ops_disable_work);
+	kthread_flush_work(&scx_ops_helper_work);
 	return 0;
 }
 
@@ -5475,7 +5523,7 @@ static int bpf_scx_reg(void *kdata, struct bpf_link *link)
 static void bpf_scx_unreg(void *kdata, struct bpf_link *link)
 {
 	scx_ops_disable(SCX_EXIT_UNREG);
-	kthread_flush_work(&scx_ops_disable_work);
+	kthread_flush_work(&scx_ops_helper_work);
 }
 
 static int bpf_scx_init(struct btf *btf)
@@ -5797,12 +5845,12 @@ static int scx_pm_handler(struct notifier_block *nb, unsigned long event, void *
 	case PM_HIBERNATION_PREPARE:
 	case PM_SUSPEND_PREPARE:
 	case PM_RESTORE_PREPARE:
-		scx_ops_bypass(true);
+		schedule_scx_bypass_delta(true);
 		break;
 	case PM_POST_HIBERNATION:
 	case PM_POST_SUSPEND:
 	case PM_POST_RESTORE:
-		scx_ops_bypass(false);
+		schedule_scx_bypass_delta(false);
 		break;
 	}
 
-- 
2.46.1


