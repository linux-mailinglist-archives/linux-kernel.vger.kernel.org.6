Return-Path: <linux-kernel+bounces-565533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03F00A66A31
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 07:15:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8E3B3BB738
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 06:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 563281DE3DC;
	Tue, 18 Mar 2025 06:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b="brKYd8M0"
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5845191F72
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 06:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742278521; cv=none; b=ZU8MEFgQerHqk0y/zxy8cFwNO3SdnbnqHqkHCJfvTSiZSWuwr5OJiB0sDrgni+3s/LTsXWwJdY3oayeRuzneUo3rjIeign8z3FKqiZ5KW3Ar1U5923HTjGkSGeDHXH2Sm5p1tHKTU91vijrhkg9Z9FeRFB/aw+SLUQ4+PnG1gJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742278521; c=relaxed/simple;
	bh=bvsaQf+q5zAPyQMLZEKjtaO7Zy1Z8ho7KoK1wQhVqTU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m+Ao8jSdJ6Ohcwsi5qrmujk8KCTsxgyPKvxh+iLoI8hfK7uesN8/0/KIw97CItvhJXFHDBjrMlz/WJnaGZOFDXVJl/8vcV2hvcu0ixBaFKUV+PO6+o9OUXhDjITK+0y3ihNaLVieShJ5JZ4HLUNz4YJWd+xjuniMjD0yzaqdIMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com; spf=pass smtp.mailfrom=tenstorrent.com; dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b=brKYd8M0; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tenstorrent.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-726819aa3fcso3235314a34.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 23:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tenstorrent.com; s=google; t=1742278518; x=1742883318; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AMSpj4Pv/tuKqFfvndPeG7a41TGSXjAKvjZxbUe88U8=;
        b=brKYd8M0wtIWM34V/R7oY3j/PqonDvXIEfc8Q+7lQPC+d7WJN7uASqrUzieXgozyhJ
         Sb6tpDaSmq5JVSrYI+nyIF22DUtF3KAopDUP274kByuiaRZKXgkgd1HDimCrxGNZTTmi
         QX/vMWCPz0zK6NuIX2MEYL8/aDPVsDPIU3KEHMnNStlGdze4ufO7w48hx3kSD+a0Drro
         NI9LiLHD5d5mNU3aH9MRCazvBSMj4EjTp1tUI3yW6WY3GWw/UeAMvV9OM0Fc+3hspUgn
         FQmtGviBB72qSOGrJ+1kjTvqaLhc0Xd7NImt2LGOJrkpoIVLGqlZxVkNaju1oYng8tus
         ydFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742278518; x=1742883318;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AMSpj4Pv/tuKqFfvndPeG7a41TGSXjAKvjZxbUe88U8=;
        b=TU3Me62kZfcTAbDjVtaEa78Y2LgPRiv4VRm+O0q9D/5IISsqeeAQmQdoGNXDQJSiPV
         LMafnrfLQmbp0ulK7KHijsCSnGRnYMZOn14exU0qqOYMUrht1jex0GP6n+VIpEeDpM3P
         2NQFVuwdaNFE02Sgi5BGbBrn1C7a3dTQyFYfdQIWjALkVWQqN8AbNT13dcwJGAzHQjS/
         zk9UDMhuJYAwEb0iVr241zcqZBG2pn+MKK+u2t5XvsZaD6vaTce4sMRAfcA6h0H9IXJr
         zQ/LAu9lqUJh3n28woqCWGvNmoJjp4x5JxsyUUKvlop1Z+dWWDhpdp3zCqJ7e+MEVPm+
         5mDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxDoxDqw+QimhHpI48fozbYelFnR5v32Rl5QCvyW3FMEvneuS5Av0Z6mvVqlNmKOD55TymYkU1tXr7+3s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx98vvGQ5ef6rIHcRxIgjkTOf802DPKVTntxIZs1ZdV0ZNNmrf8
	RhwDRUvR1pDin+NnOQRLmsm7XGPuc5hl/mXl6vHg/GbZszXtH8bQJZmNFfrH1g==
X-Gm-Gg: ASbGnctXGFPDwh4Q+G6/0yReP7LODFVlq9Zi2E1gWz36FgSzUb8iOEG2Ull41lqLMyO
	9Msu7NKN5XfxOGt/HJ0dwbaCDq2KKKki7oSfEbhtkHXWzz1tVDEo68T9rbpo7MYPne/ET5D2vJq
	qXNbJyA4kxZuVfdCpxqLnBZqW0vtpJbdVZvVf816ulTdthXwafNmk/Lv8hUhsux0UypOELLohzc
	HLE3SIwYELYC5qh7uWwlzWqtsPUqq4ORgul97SdTvb97GBcOy/XrJzDTigJZkiXZbvygwWEIYSQ
	xxBkmYLfsj+5KYD9QVasJN9PRNPxPtQjky0L3yP+aPmkxnOBKNKWwD3TrXwsGHJDRfEdz4vHGw=
	=
X-Google-Smtp-Source: AGHT+IE9dCEHhNSEUdS36yalwDgnQ6lSUtajzuROrLjALRXZFS2tcFhxjwVecmB7upfnJriqyJFUDw==
X-Received: by 2002:a05:6830:6516:b0:72b:87bd:ad5b with SMTP id 46e09a7af769-72bbc247edcmr8104772a34.4.1742278517914;
        Mon, 17 Mar 2025 23:15:17 -0700 (PDT)
Received: from aus-ird.tenstorrent.com ([38.104.49.66])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3fcd403b882sm2051642b6e.8.2025.03.17.23.15.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 23:15:17 -0700 (PDT)
From: Cyril Bur <cyrilbur@tenstorrent.com>
To: palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	paul.walmsley@sifive.com,
	charlie@rivosinc.com,
	jrtc27@jrtc27.com,
	ben.dooks@codethink.co.uk,
	alex@ghiti.fr
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	jszhang@kernel.org,
	syzbot+e74b94fe601ab9552d69@syzkaller.appspotmail.com
Subject: [PATCH v4 1/5] riscv: save the SR_SUM status over switches
Date: Tue, 18 Mar 2025 06:15:10 +0000
Message-Id: <20250318061514.1223111-2-cyrilbur@tenstorrent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250318061514.1223111-1-cyrilbur@tenstorrent.com>
References: <20250318061514.1223111-1-cyrilbur@tenstorrent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ben Dooks <ben.dooks@codethink.co.uk>

When threads/tasks are switched we need to ensure the old execution's
SR_SUM state is saved and the new thread has the old SR_SUM state
restored.

The issue is seen under heavy load especially with the syz-stress tool
running, with crashes as follows in schedule_tail:

Unable to handle kernel access to user memory without uaccess routines
at virtual address 000000002749f0d0
Oops [#1]
Modules linked in:
CPU: 1 PID: 4875 Comm: syz-executor.0 Not tainted
5.12.0-rc2-syzkaller-00467-g0d7588ab9ef9 #0
Hardware name: riscv-virtio,qemu (DT)
epc : schedule_tail+0x72/0xb2 kernel/sched/core.c:4264
 ra : task_pid_vnr include/linux/sched.h:1421 [inline]
 ra : schedule_tail+0x70/0xb2 kernel/sched/core.c:4264
epc : ffffffe00008c8b0 ra : ffffffe00008c8ae sp : ffffffe025d17ec0
 gp : ffffffe005d25378 tp : ffffffe00f0d0000 t0 : 0000000000000000
 t1 : 0000000000000001 t2 : 00000000000f4240 s0 : ffffffe025d17ee0
 s1 : 000000002749f0d0 a0 : 000000000000002a a1 : 0000000000000003
 a2 : 1ffffffc0cfac500 a3 : ffffffe0000c80cc a4 : 5ae9db91c19bbe00
 a5 : 0000000000000000 a6 : 0000000000f00000 a7 : ffffffe000082eba
 s2 : 0000000000040000 s3 : ffffffe00eef96c0 s4 : ffffffe022c77fe0
 s5 : 0000000000004000 s6 : ffffffe067d74e00 s7 : ffffffe067d74850
 s8 : ffffffe067d73e18 s9 : ffffffe067d74e00 s10: ffffffe00eef96e8
 s11: 000000ae6cdf8368 t3 : 5ae9db91c19bbe00 t4 : ffffffc4043cafb2
 t5 : ffffffc4043cafba t6 : 0000000000040000
status: 0000000000000120 badaddr: 000000002749f0d0 cause:
000000000000000f
Call Trace:
[<ffffffe00008c8b0>] schedule_tail+0x72/0xb2 kernel/sched/core.c:4264
[<ffffffe000005570>] ret_from_exception+0x0/0x14
Dumping ftrace buffer:
   (ftrace buffer empty)
---[ end trace b5f8f9231dc87dda ]---

The issue comes from the put_user() in schedule_tail
(kernel/sched/core.c)
doing the following:

asmlinkage __visible void schedule_tail(struct task_struct *prev)
{
...
        if (current->set_child_tid)
                put_user(task_pid_vnr(current), current->set_child_tid);
...
}

the put_user() macro causes the code sequence to come out as follows:

1:	__enable_user_access()
2:	reg = task_pid_vnr(current);
3:	*current->set_child_tid = reg;
4:	__disable_user_access()

This means the task_pid_vnr() is being called with user-access enabled
which itself is not a good idea, but that is a separate issue. Here we
have a function that /might/ sleep being called with the SR_SUM and if
it does, then it returns with the SR_SUM flag possibly cleared thus
causing the above abort.

To try and deal with this, and stop the SR_SUM leaking out into other
threads (this has also been tested and see under stress. It can rarely
happen but it /does/ under load) make sure the __switch_to() will save
and restore the SR_SUM flag, and clear it possibly for the next thread
if it does not need it.

Note, test code to be supplied once other checks have been finished.

There may be further issues with the mstatus flags with this, this
can be discussed further once some initial testing has been done.

Reported-by: syzbot+e74b94fe601ab9552d69@syzkaller.appspotmail.com
Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
Signed-off-by: Cyril Bur <cyrilbur@tenstorrent.com>
---
 arch/riscv/include/asm/processor.h | 1 +
 arch/riscv/kernel/asm-offsets.c    | 5 +++++
 arch/riscv/kernel/entry.S          | 8 ++++++++
 3 files changed, 14 insertions(+)

diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
index 5f56eb9d114a..0de05d652e0f 100644
--- a/arch/riscv/include/asm/processor.h
+++ b/arch/riscv/include/asm/processor.h
@@ -103,6 +103,7 @@ struct thread_struct {
 	struct __riscv_d_ext_state fstate;
 	unsigned long bad_cause;
 	unsigned long envcfg;
+	unsigned long flags;
 	u32 riscv_v_flags;
 	u32 vstate_ctrl;
 	struct __riscv_v_ext_state vstate;
diff --git a/arch/riscv/kernel/asm-offsets.c b/arch/riscv/kernel/asm-offsets.c
index e89455a6a0e5..556ebcbb7e22 100644
--- a/arch/riscv/kernel/asm-offsets.c
+++ b/arch/riscv/kernel/asm-offsets.c
@@ -34,6 +34,7 @@ void asm_offsets(void)
 	OFFSET(TASK_THREAD_S9, task_struct, thread.s[9]);
 	OFFSET(TASK_THREAD_S10, task_struct, thread.s[10]);
 	OFFSET(TASK_THREAD_S11, task_struct, thread.s[11]);
+	OFFSET(TASK_THREAD_FLAGS, task_struct, thread.flags);
 
 	OFFSET(TASK_TI_CPU, task_struct, thread_info.cpu);
 	OFFSET(TASK_TI_FLAGS, task_struct, thread_info.flags);
@@ -347,6 +348,10 @@ void asm_offsets(void)
 		  offsetof(struct task_struct, thread.s[11])
 		- offsetof(struct task_struct, thread.ra)
 	);
+	DEFINE(TASK_THREAD_FLAGS_RA,
+		  offsetof(struct task_struct, thread.flags)
+		- offsetof(struct task_struct, thread.ra)
+	);
 
 	DEFINE(TASK_THREAD_F0_F0,
 		  offsetof(struct task_struct, thread.fstate.f[0])
diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
index 33a5a9f2a0d4..c278b3ac37b9 100644
--- a/arch/riscv/kernel/entry.S
+++ b/arch/riscv/kernel/entry.S
@@ -397,9 +397,17 @@ SYM_FUNC_START(__switch_to)
 	REG_S s9,  TASK_THREAD_S9_RA(a3)
 	REG_S s10, TASK_THREAD_S10_RA(a3)
 	REG_S s11, TASK_THREAD_S11_RA(a3)
+
+	/* save (and disable the user space access flag) */
+	li    s0, SR_SUM
+	csrrc s1, CSR_STATUS, s0
+	REG_S s1, TASK_THREAD_FLAGS_RA(a3)
+
 	/* Save the kernel shadow call stack pointer */
 	scs_save_current
 	/* Restore context from next->thread */
+	REG_L s0,  TASK_THREAD_FLAGS_RA(a4)
+	csrs  CSR_STATUS, s0
 	REG_L ra,  TASK_THREAD_RA_RA(a4)
 	REG_L sp,  TASK_THREAD_SP_RA(a4)
 	REG_L s0,  TASK_THREAD_S0_RA(a4)
-- 
2.34.1


