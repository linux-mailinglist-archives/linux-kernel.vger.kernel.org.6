Return-Path: <linux-kernel+bounces-382563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43E5B9B0FE7
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 22:39:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F703B21D8C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 20:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36C02215C4E;
	Fri, 25 Oct 2024 20:39:43 +0000 (UTC)
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E240C1865FC
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 20:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729888782; cv=none; b=U/NneGG/6SE+b4qsT7uQSIb3tT1p/9TOpmzV5GAHo/07rpa2Z9S2v2sQsZMlhS5/WyxQ+ecBAG/ocujn4heaUW7PeQBQSpgcjnUha94dZnBZrjJeTB/46FBxtTMBi0FG3qbSK1e1dYEYL1a1o1+tiUckZN1p0trl1Z1AUSlQ0lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729888782; c=relaxed/simple;
	bh=Xut5KuytrUvddzVGamLiiy9qRd+yCANnXjkrwlKkXhY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LrJO8x5ALx8uqkou6X9iyYnnvo1xOLZXwbL5ogxS/yr0txVyYCiMe8+H51xZzV1Fa+qyeQrYbv1XKo6vmHJtaxy+ub9K77HPrKiviwmpAVitiIhJQEr23HIkWoqu8onllHswugkSGWGJ2SLbgsi9U7pkDlJNf8uCDxqjg6UVKEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-84ff43e87cbso717550241.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 13:39:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729888779; x=1730493579;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d/DJHUYcQpCOSuSzbbERlzMOmm+qJF5o0ZdmXuDg43Y=;
        b=FY7+E8jYZLONAk2HgmZx8WExgwFbYC6LbnwpLZ7qGcErK3w4TO30hcTqKxlBYldYRb
         tVenCvsg785ZQEYH8RhPLcMJxTlMStxvr+P2Yy8/g+gzh/hkmAn4tZPPxweWEmTDN832
         r8JTO737wpM1BDUHkypDxQAm+/srXDRH89e10t0drFmDeGEkrq4zlfBZMQlDQEDKcgvV
         zRIxBun212yAHucfGalz0WtY+BpgiwIjWZ1ipjW6F/lv+iaFNuBKnYJATvHqHw0P/cgb
         dMJyCdbvN+TP3PaAvV89iME1xttm4Owt4FYZdZHKORBTI8fS8KkYWwzx2Z9m+FkSu6nj
         X7Rg==
X-Forwarded-Encrypted: i=1; AJvYcCVPBsRuL4tCukrOFmUlyW+OqzRXiebiRnfbwrukKYhmlJZIPqnZHLbPCRK7CUEBNnRc3ktxk4aVKBPqotM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyptrHgpX1zRXGqL6KtbGQJJlVgFIvY2PxJS6w/FSbkgE7FWbaD
	XCz6lBorPKNNfT7Nf51E+RuHxI9AW8DCD/zQIrW3Em3rNSfdNjx3
X-Google-Smtp-Source: AGHT+IGA65NNSOeSTH2N8k1D39AaIGHxuStnoyLGBu8FXJ0ppMQGUBYPiRV0pbCdLGKBsLPWEYOWww==
X-Received: by 2002:a05:6102:390f:b0:498:c11b:7a8b with SMTP id ada2fe7eead31-4a8cfd21da3mr884039137.21.1729888778707;
        Fri, 25 Oct 2024 13:39:38 -0700 (PDT)
Received: from localhost (c-76-141-129-107.hsd1.il.comcast.net. [76.141.129.107])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46132134d3dsm9381811cf.27.2024.10.25.13.39.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 13:39:37 -0700 (PDT)
From: David Vernet <void@manifault.com>
To: tj@kernel.org
Cc: sched-ext@meta.com,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] scx: Fix raciness in scx_ops_bypass()
Date: Fri, 25 Oct 2024 15:39:29 -0500
Message-ID: <20241025203929.22839-1-void@manifault.com>
X-Mailer: git-send-email 2.46.1
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

While it's not safe to take any blocking locks on the bypass path, it is
safe to take a raw spinlock which cannot be preempted. This patch therefore
updates scx_ops_bypass() to use a raw spinlock to synchronize, and changes
scx_ops_bypass_depth to be a regular int.

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

And with it, the test passes without issue after 1000s of runs:

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

v1: https://lore.kernel.org/lkml/20241025054014.66631-2-void@manifault.com/

Changes v1 -> v2:
- Just use a raw spinlock instead of using scheduling contexts to
  synchronize (Tejun)

 kernel/sched/ext.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 6eae3b69bf6e..58d6a6a89ac6 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -862,7 +862,8 @@ static DEFINE_MUTEX(scx_ops_enable_mutex);
 DEFINE_STATIC_KEY_FALSE(__scx_ops_enabled);
 DEFINE_STATIC_PERCPU_RWSEM(scx_fork_rwsem);
 static atomic_t scx_ops_enable_state_var = ATOMIC_INIT(SCX_OPS_DISABLED);
-static atomic_t scx_ops_bypass_depth = ATOMIC_INIT(0);
+static int scx_ops_bypass_depth;
+static DEFINE_RAW_SPINLOCK(__scx_ops_bypass_lock);
 static bool scx_ops_init_task_enabled;
 static bool scx_switching_all;
 DEFINE_STATIC_KEY_FALSE(__scx_switched_all);
@@ -4298,18 +4299,20 @@ bool task_should_scx(struct task_struct *p)
  */
 static void scx_ops_bypass(bool bypass)
 {
-	int depth, cpu;
+	int cpu;
+	unsigned long flags;
 
+	raw_spin_lock_irqsave(&__scx_ops_bypass_lock, flags);
 	if (bypass) {
-		depth = atomic_inc_return(&scx_ops_bypass_depth);
-		WARN_ON_ONCE(depth <= 0);
-		if (depth != 1)
-			return;
+		scx_ops_bypass_depth++;
+		WARN_ON_ONCE(scx_ops_bypass_depth <= 0);
+		if (scx_ops_bypass_depth != 1)
+			goto unlock;
 	} else {
-		depth = atomic_dec_return(&scx_ops_bypass_depth);
-		WARN_ON_ONCE(depth < 0);
-		if (depth != 0)
-			return;
+		scx_ops_bypass_depth--;
+		WARN_ON_ONCE(scx_ops_bypass_depth < 0);
+		if (scx_ops_bypass_depth != 0)
+			goto unlock;
 	}
 
 	/*
@@ -4367,6 +4370,8 @@ static void scx_ops_bypass(bool bypass)
 		/* resched to restore ticks and idle state */
 		resched_cpu(cpu);
 	}
+unlock:
+	raw_spin_unlock_irqrestore(&__scx_ops_bypass_lock, flags);
 }
 
 static void free_exit_info(struct scx_exit_info *ei)
-- 
2.46.1


