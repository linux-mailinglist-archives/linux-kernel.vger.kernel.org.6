Return-Path: <linux-kernel+bounces-570486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B60BAA6B12E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 23:44:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F9DE483F36
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 22:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D08C222A4F6;
	Thu, 20 Mar 2025 22:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b="G2/cD79N"
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11DF01EDA2F
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 22:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742510670; cv=none; b=DaRJQCB1lqFgDTQ0AECglznFx3i5Pv51+ZoT1epYl3de2YH/eZTmbR5baZLdFa/gT+9CO4JtVXlGipkxDldKblGe52NnijIltv4eq2FAAr6j7cnktBhrn21de3W0cgDi6BXCcJCly9XHbz2UOiBe+d2coIxyNv+j4/DnzEaeMBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742510670; c=relaxed/simple;
	bh=bvsaQf+q5zAPyQMLZEKjtaO7Zy1Z8ho7KoK1wQhVqTU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h019giWRcM+wCMoDH3dSX5zIFy4iBST26PsWM/YjpREPxBq0UGNKI0VVy5VIVWmswns6lfxd3LtzTuz5Bhz//TYUzOuJbj8pDmo/HQE0s3OpdTs2/dAuhYh9/d8xsxJxHLL7ItOKOQWJ2PW5idXrw/55xb9BoC9AksA1rppNC8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com; spf=pass smtp.mailfrom=tenstorrent.com; dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b=G2/cD79N; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tenstorrent.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3fb3f4bf97aso402045b6e.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 15:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tenstorrent.com; s=google; t=1742510667; x=1743115467; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AMSpj4Pv/tuKqFfvndPeG7a41TGSXjAKvjZxbUe88U8=;
        b=G2/cD79NvvFvjnDEWf2kp/6hyaXEQ36zPC1EC//tK5UOhflA7akv2Elz8Gv1mH+n58
         /xRbNdesM9VDkVVIH3rG+A2+xEel7PaP8anZdKSN6sDElObz5tqrNfVb/gIEw4c7tOpl
         xDuvpNHYapGUCgc9xCVQwZ0/to2QGLcOlNbzgUMXdhaS8wptCSo70/WaxNdBHfyODopA
         d4ALSw/0L7wOSGi20m88BAOxZJUq5Z8mTh4AVTZoRtg8goHC8+YAPFrJ8M4oc7pNQWKo
         PHpNYXdyD8f63C1Uj+sQ+lbUrtU6BU2p6BN060v59f6V4H6ctDkzVqe04VtM9XPlYP9v
         ZQWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742510667; x=1743115467;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AMSpj4Pv/tuKqFfvndPeG7a41TGSXjAKvjZxbUe88U8=;
        b=vbUw29DhTpMwSac/jdcA8rYrn3WlX1si1a72dCuy+Nm2ETfXOffDSZt8hbO4KnnKDU
         Tk6EzCLwVRfCJOQqgeDs7Y2Vd8Q+LB9vWT1m2bqEgpBl53m5fNcZ9tb6Vguz8G3MLe5M
         /Kxp4tjF0+lTgwVJLLhFYba4sBiYs1bTl6AJ2zw0igGkxbKdIcPBmv4cML9HfToZ2bKO
         MggWmmItfE3mUsk6e3XYJzXgs463lxdWgfKG3HLN9bexy4ykdC5c8xPUYux/TQjQ2QFd
         L+d8wVQ1Wpf9rCc3bFkHthhINIVnGg8u+TC5lZ4rUN2OE2brFoTXC2xvQFHnV05WVWSW
         ccrw==
X-Forwarded-Encrypted: i=1; AJvYcCVSVEmv2admD+OZz9ABKGhSTj55dz7ibCDH7rIRNLQ8VenjfLTdYegE352lpcMKm2VHPkhQ628eR+jgO4E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJgdIyodXpcYJsVs+8kSr3zWLhQBcnr1ajHue2yaR5LKrm6Xbe
	MBu5zfilACQwg12SNVUKx392gCaW5vU9BT+xqZz0/4Xlj4x872jZ+l7IgZBOOCDKLwTHjr4Ey17
	YLA7M
X-Gm-Gg: ASbGncsBX32TskAAqKvLYxWbFRQeF8EaX4GKXQzeFGJta3H8bXIq9xKXmfXcYpJ+J8p
	X4FlAv6zLeV3ug4MTEf8ZivYdGUBwJscBdXqn4dPaAszqTJ0lno4mUgTOZCCpTQOX0bH1VP2f76
	SlF2ctv1AjXo8BhK7EVI2d81V3bsSl9myT5MZdQDsw8KJEwXDTSKl0b8irpqcu3Z9k+9XkZ+3Uq
	xrUrkRycSsuaNy6OqR0wAHHRmz4zaNtsDk4PxyjhH/KCbGV5/0+Gb7VfMo/3KRGh7G7JYZtJcr6
	wCUTRtwORYoFnzVpOzUiyMZud4cYi+d6+AufFPKKf8rl2dWljfr4nzrZkigBOYs=
X-Google-Smtp-Source: AGHT+IFd0nlvhAJDq2aqQ1KFOkNVEh4rXpWJJkMBcG9z9sJUjee94QYnGOMRYiHTi9qWadmuKL5cPg==
X-Received: by 2002:a05:6808:250d:b0:3fe:b1fd:527f with SMTP id 5614622812f47-3febf70fc7amr619142b6e.1.1742510667005;
        Thu, 20 Mar 2025 15:44:27 -0700 (PDT)
Received: from aus-ird.tenstorrent.com ([38.104.49.66])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3febf6dcc09sm103524b6e.12.2025.03.20.15.44.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 15:44:26 -0700 (PDT)
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
Subject: [PATCH v5 1/5] riscv: save the SR_SUM status over switches
Date: Thu, 20 Mar 2025 22:44:19 +0000
Message-Id: <20250320224423.1838493-2-cyrilbur@tenstorrent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250320224423.1838493-1-cyrilbur@tenstorrent.com>
References: <20250320224423.1838493-1-cyrilbur@tenstorrent.com>
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


