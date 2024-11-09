Return-Path: <linux-kernel+bounces-402708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3A1B9C2AA1
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 07:29:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7595E1F22246
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 06:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4F7E2E628;
	Sat,  9 Nov 2024 06:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fjlzSABq"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B424328E8
	for <linux-kernel@vger.kernel.org>; Sat,  9 Nov 2024 06:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731133751; cv=none; b=bukgl5UlBsj7VBFOe3Cyo5I//mtHTE7g5ulLRorvFaHuXl4T7AbiESZ1ESp/drN7S83j2WNvNNWZr/7o5jv3qDWG5/lGEdLxJ2iSPHgaGwieyXJob0Z8IKKlyp8EoHy/644jnx0LhYlwC8ln5q9umNyLcQuGuRBSgtxVl12LTAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731133751; c=relaxed/simple;
	bh=1rzZiIUcLW6xBOzJywoX33J87RLpIJApIFv2nHCH+fc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P1TS62Apn2J71dLk4PClSiGZbqNP8jGNBVVClyJug3Z6CWwh11Yu04joBhm54JhcSr1a6n556ntXfRzg5y/NRnCiaYMovKLU4kbc84D0JR9QDO5Z5htNC0AWBihHz9lKDe72ng7vfzT+ZDlTLRigpkhST1pPQWjr5oee0kEXNyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fjlzSABq; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20c6f492d2dso32011975ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 22:29:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731133749; x=1731738549; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=M8RT0nuc0fYONeNqL5hdX3RZ0JJOsejx8XGNjeCURk0=;
        b=fjlzSABqJqrzOT93OGyAEm9Q3nKHEUGXmqYKatsoLRmT4rX5m+1Aqh8A21TKQGRq+e
         /DHjH9lnc3CGDsmKzG1GGN+8Y8E1EWz8yKRUZZP3EU23o++YWONzu/Gi2wh7IQxx5kHC
         byEiekGmOeMoXqy/JjNhj7MQ6IEunzaydiwS5wlbJ6In9elCAGeMZ78mFhnSyhwVE1on
         Aesr3WaxpTRNWj3jzYNWR6+FRxxLaFJrF+NvavoFt06PXmoh60DktUXObmPKjvpqcdQE
         jqtDU0XsGaALQVGbdAzAV22xu7FPELVNxI2X1EyBKZUsYfINM24ArTcO5z1rYhsNbxx4
         Nb3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731133749; x=1731738549;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M8RT0nuc0fYONeNqL5hdX3RZ0JJOsejx8XGNjeCURk0=;
        b=v6ULz4d3V5e+Uk1J/ORWsM30Gec0ZKtYYt36AatFFizN/M+BAlHTvyhDqFbipGuyOV
         qC1RKGmmMZqu4pkOxAOFCbapACYBH2tI6SzQMeDP/iZeqZxml3eUsobHeb2t1yvVg+OL
         Fqsqz0/sjGHEqqMPif1TibMR1MB/1TXQzmRZfBgJqS+sIoSCSgowNCa9VBEDtZ9T5/1K
         5JX8SdOwQeQGTsOGz/V0gAP9Xs69VowCeuy/6aeNi/P6z79jjtbZ3CcrqImzzQdHp36m
         rPlqR2i38iJQGoE0T1Jmg/GOduT6qlZRXai7sSxormOTTZFpmiXD24clFtcu+k+6cT+n
         GKpg==
X-Forwarded-Encrypted: i=1; AJvYcCUaZeg/fipoyRq+q2Ld40KqCnXKYb8Ync75qYA9IE7pzjEh1Vl7tVUaiwL5GNW1ebKbOcZsWf0MWBuVht4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1Xm1sXQpBXtPUTodowW/EkRGyAaOvKdHwyon6m82LMs+QLzN+
	V6G8hEBe2gtQvhVIke2H/QoMDuP4+rGhhCCRLKw28n/cJ4F9XvsH
X-Google-Smtp-Source: AGHT+IHzOZfdRSM2Cy1enSg7T07ZbtkoqDiFU+6x8+uEMYm60i0rmc+E/LrJMdVYMkOCa47Gc2pmnw==
X-Received: by 2002:a17:903:2344:b0:20b:5aff:dd50 with SMTP id d9443c01a7336-2118354c06fmr70502345ad.31.1731133748821;
        Fri, 08 Nov 2024 22:29:08 -0800 (PST)
Received: from localhost ([58.29.143.236])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177e6c368sm40711765ad.240.2024.11.08.22.29.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 22:29:08 -0800 (PST)
From: Changwoo Min <multics69@gmail.com>
X-Google-Original-From: Changwoo Min <changwoo@igalia.com>
To: tj@kernel.org,
	void@manifault.com
Cc: changwoo@igalia.com,
	kernel-dev@igalia.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] sched_ext: add a missing rcu_read_lock/unlock pair at scx_select_cpu_dfl()
Date: Sat,  9 Nov 2024 15:29:05 +0900
Message-ID: <20241109062905.204434-1-changwoo@igalia.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When getting an LLC CPU mask in the default CPU selection policy,
scx_select_cpu_dfl(), a pointer to the sched_domain is dereferenced
using rcu_read_lock() without holding rcu_read_lock(). Such an unprotected
dereference often causes the following warning and can cause an invalid
memory access in the worst case.

Therefore, protect dereference of a sched_domain pointer using a pair
of rcu_read_lock() and unlock().

[   20.996135] =============================
[   20.996345] WARNING: suspicious RCU usage
[   20.996563] 6.11.0-virtme #17 Tainted: G        W
[   20.996576] -----------------------------
[   20.996576] kernel/sched/ext.c:3323 suspicious rcu_dereference_check() usage!
[   20.996576]
[   20.996576] other info that might help us debug this:
[   20.996576]
[   20.996576]
[   20.996576] rcu_scheduler_active = 2, debug_locks = 1
[   20.996576] 4 locks held by kworker/8:1/140:
[   20.996576]  #0: ffff8b18c00dd348 ((wq_completion)pm){+.+.}-{0:0}, at: process_one_work+0x4a0/0x590
[   20.996576]  #1: ffffb3da01f67e58 ((work_completion)(&dev->power.work)){+.+.}-{0:0}, at: process_one_work+0x1ba/0x590
[   20.996576]  #2: ffffffffa316f9f0 (&rcu_state.gp_wq){..-.}-{2:2}, at: swake_up_one+0x15/0x60
[   20.996576]  #3: ffff8b1880398a60 (&p->pi_lock){-.-.}-{2:2}, at: try_to_wake_up+0x59/0x7d0
[   20.996576]
[   20.996576] stack backtrace:
[   20.996576] CPU: 8 UID: 0 PID: 140 Comm: kworker/8:1 Tainted: G        W          6.11.0-virtme #17
[   20.996576] Tainted: [W]=WARN
[   20.996576] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Arch Linux 1.16.3-1-1 04/01/2014
[   20.996576] Workqueue: pm pm_runtime_work
[   20.996576] Sched_ext: simple (disabling+all), task: runnable_at=-6ms
[   20.996576] Call Trace:
[   20.996576]  <IRQ>
[   20.996576]  dump_stack_lvl+0x6f/0xb0
[   20.996576]  lockdep_rcu_suspicious.cold+0x4e/0x96
[   20.996576]  scx_select_cpu_dfl+0x234/0x260
[   20.996576]  select_task_rq_scx+0xfb/0x190
[   20.996576]  select_task_rq+0x47/0x110
[   20.996576]  try_to_wake_up+0x110/0x7d0
[   20.996576]  swake_up_one+0x39/0x60
[   20.996576]  rcu_core+0xb08/0xe50
[   20.996576]  ? srso_alias_return_thunk+0x5/0xfbef5
[   20.996576]  ? mark_held_locks+0x40/0x70
[   20.996576]  handle_softirqs+0xd3/0x410
[   20.996576]  irq_exit_rcu+0x78/0xa0
[   20.996576]  sysvec_apic_timer_interrupt+0x73/0x80
[   20.996576]  </IRQ>
[   20.996576]  <TASK>
[   20.996576]  asm_sysvec_apic_timer_interrupt+0x1a/0x20
[   20.996576] RIP: 0010:_raw_spin_unlock_irqrestore+0x36/0x70
[   20.996576] Code: f5 53 48 8b 74 24 10 48 89 fb 48 83 c7 18 e8 11 b4 36 ff 48 89 df e8 99 0d 37 ff f7 c5 00 02 00 00 75 17 9c 58 f6 c4 02 75 2b <65> ff 0d 5b 55 3c 5e 74 16 5b 5d e9 95 8e 28 00 e8 a5 ee 44 ff 9c
[   20.996576] RSP: 0018:ffffb3da01f67d20 EFLAGS: 00000246
[   20.996576] RAX: 0000000000000002 RBX: ffffffffa4640220 RCX: 0000000000000040
[   20.996576] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffffa1c7b27b
[   20.996576] RBP: 0000000000000246 R08: 0000000000000001 R09: 0000000000000000
[   20.996576] R10: 0000000000000001 R11: 000000000000021c R12: 0000000000000246
[   20.996576] R13: ffff8b1881363958 R14: 0000000000000000 R15: ffff8b1881363800
[   20.996576]  ? _raw_spin_unlock_irqrestore+0x4b/0x70
[   20.996576]  serial_port_runtime_resume+0xd4/0x1a0
[   20.996576]  ? __pfx_serial_port_runtime_resume+0x10/0x10
[   20.996576]  __rpm_callback+0x44/0x170
[   20.996576]  ? __pfx_serial_port_runtime_resume+0x10/0x10
[   20.996576]  rpm_callback+0x55/0x60
[   20.996576]  ? __pfx_serial_port_runtime_resume+0x10/0x10
[   20.996576]  rpm_resume+0x582/0x7b0
[   20.996576]  pm_runtime_work+0x7c/0xb0
[   20.996576]  process_one_work+0x1fb/0x590
[   20.996576]  worker_thread+0x18e/0x350
[   20.996576]  ? __pfx_worker_thread+0x10/0x10
[   20.996576]  kthread+0xe2/0x110
[   20.996576]  ? __pfx_kthread+0x10/0x10
[   20.996576]  ret_from_fork+0x34/0x50
[   20.996576]  ? __pfx_kthread+0x10/0x10
[   20.996576]  ret_from_fork_asm+0x1a/0x30
[   20.996576]  </TASK>
[   21.056592] sched_ext: BPF scheduler "simple" disabled (unregistered from user space)

Signed-off-by: Changwoo Min <changwoo@igalia.com>
---
 kernel/sched/ext.c | 9 +++++++++
 1 file changed, 9 insertions(+)

ChangeLog v1 -> v2:
  - Extend the RCU critical section to cover the use of llc_cpus.

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 6ff501a18b88..f0e9c77eb33b 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -3302,6 +3302,12 @@ static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
 
 	*found = false;
 
+
+	/*
+	 * This is necessary to protect llc_cpus.
+	 */
+	rcu_read_lock();
+
 	/*
 	 * Determine the scheduling domain only if the task is allowed to run
 	 * on all CPUs.
@@ -3436,9 +3442,12 @@ static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
 	if (cpu >= 0)
 		goto cpu_found;
 
+	rcu_read_unlock();
 	return prev_cpu;
 
 cpu_found:
+	rcu_read_unlock();
+
 	*found = true;
 	return cpu;
 }
-- 
2.47.0


