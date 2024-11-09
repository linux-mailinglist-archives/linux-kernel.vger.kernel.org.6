Return-Path: <linux-kernel+bounces-402583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0EE69C2959
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 02:54:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C01521C21926
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 01:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D91220322;
	Sat,  9 Nov 2024 01:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i8a+tv4p"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F33CD2FB
	for <linux-kernel@vger.kernel.org>; Sat,  9 Nov 2024 01:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731117265; cv=none; b=aw+VVqFuIT5jod+GDRAmZUyYrypofRq8SjVQfbq4sQwHa8JFcPPu1FbKpXQcN+9Pd+eJao/p+KDAqsgOLZLrZg4Gyn/pN1GrEibgAK8fUWV5IEn4BGn0LaZxbEpS1gk86iVR4JW1KjAPXRBsmkrU8xmV4iCN4M7HVbqjhigsyr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731117265; c=relaxed/simple;
	bh=nP/1Sq9NA/A6YaFsxYQAHWUEjcqDyrPiU342TPlsSvk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fjrZu/Croe70cR1aNdxn1RN++ZQaC6bT7d+QpSbzIcUDRcJT3id91GWVPSbE6eJBhT4gPIPAkbTB1gxcvipHL82FxXoGMvBumLygemAzzcMJwIY00XAj/UAMssN5zzeDJjdAmwYyDCdLS5dqpxZW+49R/zBE66Hdf+z277JcZqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i8a+tv4p; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20c8b557f91so31220965ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 17:54:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731117264; x=1731722064; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eujsUM6j3F42wNzRqYREbIq7CmVEiBWBphv0o0spDck=;
        b=i8a+tv4pxlQ2aXrWpvYmmJ4N4FWVFQ29LI/k0H+44lg1YtS5uqMTgK/uvBFU8oqfqz
         c/RgkDPvm9a4yiM2aSPyG7ihqN/Q5Xs9vrU3unrtOSCXQi2bdmuino99T4m5cJG78pJF
         0NXEIU2sPoJgoUdTmIZzn7HaqKS9kwdVFMgSJIurb8PnpC65808xv89EOIfy4geMYzRN
         kPX3PlHlzLMq3C7EPdJOlkaaennwluvQMq3UPX+bc9+lj+NXiCRsChvraNp5/hAacPvu
         x5Av5Ub0rKLJPpVUlbnWlej2XP7Eb2hMzk9Ihpnb3TWQYc/V/XcQIyErO7JKOW2E4I5b
         FRDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731117264; x=1731722064;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eujsUM6j3F42wNzRqYREbIq7CmVEiBWBphv0o0spDck=;
        b=Kg5P/Qdv58qeZLHUREYfwOmxZ4H5L/4ISTMKnIv8/ONt/Ja01vfJ4oQBfpnnUbx7lV
         xm+X8JBer9QYihX6T0s2KXSL6V4PSN6/Sb8G5TFx7pYp9LG8h60cL2vH8HzJkCtUDUND
         N8ae8uU+zkCPcOEaBerb9fC5PuKqmQZExISXdd/PeqZr+q0Dd1BCBvAWL2KakF7xXJ0F
         xZWGEeeh8GEfl+8uCovbp8f/3mbpK66UiGJoWGCa2XqDm+OhbXV/1A6h9px8XHuTJx/Z
         IM8BDzuG+R3dxNBvr4gC5HfIdF0DEcsLN02IDUnQi7Km8dj+AmMjk9o8CL3xueN0SV17
         4QBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdQPe+b36TWfbcoPtdR+C3kMbeC3Vnh+fr7VShNpb/OTrnl/jjd+QpMrW6fXx0Ao4xq62tOEucZeMco7c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQPWagMxaCsjcSP3Z7jHlfEO5IoV+wOUWDX1arvIPbNx5jZDFa
	uRni0hbjV/pkHFEmVe2SHB246lnGs1WmwateZV5vK+p16qQYLQAm
X-Google-Smtp-Source: AGHT+IFJNlK6bPV3VBFMz6stIoPcy7oUb9rl9K0Lva9l5emuG88n7jfDap+G9ZclKptboXsgXGLAug==
X-Received: by 2002:a17:902:d2c8:b0:211:6b21:2370 with SMTP id d9443c01a7336-21183ced53dmr57578905ad.29.1731117263572;
        Fri, 08 Nov 2024 17:54:23 -0800 (PST)
Received: from localhost ([58.29.143.236])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177e5aa01sm37218775ad.211.2024.11.08.17.54.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 17:54:23 -0800 (PST)
From: Changwoo Min <multics69@gmail.com>
X-Google-Original-From: Changwoo Min <changwoo@igalia.com>
To: arighi@nvidia.com,
	tj@kernel.org,
	void@manifault.com
Cc: changwoo@igalia.com,
	kernel-dev@igalia.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH] sched_ext: add a missing rcu_read_lock/unlock pair at scx_select_cpu_dfl()
Date: Sat,  9 Nov 2024 10:54:20 +0900
Message-ID: <20241109015420.170729-1-changwoo@igalia.com>
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
RCU dereference often causes the following warning and can cause an invalid
memory access in the worst case.

Therefore, protect RCU dereference of a sched_domain pointer using a pair
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
 kernel/sched/ext.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 6ff501a18b88..830a21d666e9 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -3320,9 +3320,11 @@ static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
 		if (static_branch_maybe(CONFIG_SCHED_MC, &scx_selcpu_topo_llc)) {
 			struct sched_domain *sd;
 
+			rcu_read_lock();
 			sd = rcu_dereference(per_cpu(sd_llc, prev_cpu));
 			if (sd)
 				llc_cpus = sched_domain_span(sd);
+			rcu_read_unlock();
 		}
 	}
 
-- 
2.47.0


