Return-Path: <linux-kernel+bounces-423769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0403A9DAC71
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 18:30:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8268281EA7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 17:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17AAE20102B;
	Wed, 27 Nov 2024 17:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HUPT+0oQ"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5CD520110E
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 17:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732728614; cv=none; b=ugdrxe3fMifRe8PlLx99SEcFGDk2sqlamv54Vxh5RXd21DVwhSVGzbNyXRT+dcJ8XKu1JuIbtRyyhLsfXarnuDf1OKlPrVVwRQD0kHjyFDNvxeawnUkwo1KrlR8rw5FioJ3QL+q41rOGySuklFrmmXWZV5/evzxw6uQ92bdRzCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732728614; c=relaxed/simple;
	bh=fBBghbhDRzpIZuEVSxoyhU2mCVIh66Al5FJPjlygwv4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U9BAKF6q9Yg0+wUFxk5SSGWbxtsepD5cb0YKVXdRb4BInFRfAoYZ8tYHUpnds0XMam4XHm7f7LJde251wwTtNHnwjLNL9LUiFdAgcfTrBl5td/HDcQudvh0KhIv9tdFId6m9pu0z/yP5RYl57c+7yPB5hyVmYZ7cgyMM3sxU4+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HUPT+0oQ; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7fc2b84bc60so2725206a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 09:30:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732728612; x=1733333412; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hlixj4dxi1hv7t1eaE352YtuPYrxmNR32TDpbYYyUtI=;
        b=HUPT+0oQFFz+ZlHR1NRYwQM6BgItK/xYFY9pmxN7HRmDzfEmapMzhRH6ZNMQt8X+KV
         EJowJLMsvcUEnqlcbFfjey6LLqPtxeX+O7wn0lFSkY2S64qfW002WvUDjzhyoy5aeTNb
         lCJF8UoAc74VyoXqgaXofut+S/RX6XL82O1wyzWHb6Zk06N29kwQkL3fnubzLMUOxSL5
         qkkixDqDJWsr7HUQEnxXrjn9jvhWrmBqK2w1riKXPgV9xNUXPm13MCYDj8NxBNPuahT6
         p7YoLsJu1n0ca2eJPbdMDb68pqIsn2u8CIs1yzm59RvxXhTgaVVILLOgboSnpC+Nyv2/
         xfQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732728612; x=1733333412;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hlixj4dxi1hv7t1eaE352YtuPYrxmNR32TDpbYYyUtI=;
        b=qpMbFXwjVp84Aljk3vWKq1WkySy5SLd8Z6iK62uEI0sJySVhiITkdtjcKDSxUw5xuC
         1xj3FF58vb8kiNzcCd0QUS84625jRQlP/6lAH7ZthR6OjjYCXFk/v1XYMvV5vl9a3mw/
         +ts9+cNkB7KOq6bwpyVnFW61DCs5eXd7sSj3wZ/Sja/jKcW1bfkmMhrnJKShD2JH2nK3
         Oxc2psPhAX2aXJ1hUu62ynr0VXyWUFFIfw9zip50Ic3F+IeozO8PFZArJ0aP8kHwF0Hw
         GhLN4CnZkmYGdkkVmfzteXf6MZ+DhIve+5YtbTkr6U8ktG07cqOsPwp0RvoYVRtYW3gM
         fLzg==
X-Forwarded-Encrypted: i=1; AJvYcCWmIz214uC6nfzWZyzDM7MtqFuxndxpDqwTYSWCLL4RWiACxZ4m85vXhRNb1eTU0NQMbDqCB71XColiyMI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzHTClVxh11/nO2uGCoSG7NaMeRLaQnCJN/d6/bIARZPgK4ov5
	xwkbMLZWicMrsdKh3J625BMSlEUSySW+CxF77qwxMHaAXhFULSyq
X-Gm-Gg: ASbGnctG5rIWXqPqkbEoVEd8BDqhdAlSxKCERNKjjIAoN7YfjMe87e3uNx0e6KA0l64
	pSzAcHw8TDkvD9kWnHs0Ik6ACCLyJvD+FlltP/rslo4EENyhGojmiTYSx5MlUuDIdRoDu+DjatR
	SQlhIp/+fyoJrXXH8j2m3SCluU2cc45kPzUJIUwCmRDYgedZq4CifzUrvY86hC1tFW8TuQIAXer
	6GvrpubtGXQ+Ar8GRNysFsNtCCH25L6XOMBqpUdJxGE83BVSuZ1c+pxHv8UBv97eLoQRMUDpHIi
	YtvGxIYRfakpizzKUW7hSO2Z7wgi
X-Google-Smtp-Source: AGHT+IG4NurKvJEqxA2cpsneqQG887+tFx88JjKBx3q3M02mZmw0BTNFpg0m60820Xm5RX2iTEn9oA==
X-Received: by 2002:a05:6a21:e8c:b0:1e0:c56f:7da8 with SMTP id adf61e73a8af0-1e0e0aa83camr5657700637.4.1732728611949;
        Wed, 27 Nov 2024 09:30:11 -0800 (PST)
Received: from localhost.localdomain (1-171-29-17.dynamic-ip.hinet.net. [1.171.29.17])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fbcc1e3fdbsm9359582a12.30.2024.11.27.09.30.09
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 27 Nov 2024 09:30:11 -0800 (PST)
From: Andy Chiu <andybnac@gmail.com>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	bjorn@rivosinc.com,
	puranjay12@gmail.com,
	alexghiti@rivosinc.com,
	yongxuan.wang@sifive.com,
	greentime.hu@sifive.com,
	nick.hu@sifive.com,
	nylon.chen@sifive.com,
	tommy.wu@sifive.com,
	eric.lin@sifive.com,
	viccent.chen@sifive.com,
	zong.li@sifive.com,
	samuel.holland@sifive.com
Subject: [PATCH v3 5/7] riscv: vector: Support calling schedule() for preemptible Vector
Date: Thu, 28 Nov 2024 01:29:06 +0800
Message-Id: <20241127172908.17149-6-andybnac@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20241127172908.17149-1-andybnac@gmail.com>
References: <20241127172908.17149-1-andybnac@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Andy Chiu <andy.chiu@sifive.com>

Each function entry implies a call to ftrace infrastructure. And it may
call into schedule in some cases. So, it is possible for preemptible
kernel-mode Vector to implicitly call into schedule. Since all V-regs
are caller-saved, it is possible to drop all V context when a thread
voluntarily call schedule(). Besides, we currently don't pass argument
through vector register, so we don't have to save/restore V-regs in
ftrace trampoline.

Signed-off-by: Andy Chiu <andy.chiu@sifive.com>
---
 arch/riscv/include/asm/processor.h |  5 +++++
 arch/riscv/include/asm/vector.h    | 22 +++++++++++++++++++---
 2 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
index 5f56eb9d114a..9c1cc716b891 100644
--- a/arch/riscv/include/asm/processor.h
+++ b/arch/riscv/include/asm/processor.h
@@ -79,6 +79,10 @@ struct pt_regs;
  *       Thus, the task does not own preempt_v. Any use of Vector will have to
  *       save preempt_v, if dirty, and fallback to non-preemptible kernel-mode
  *       Vector.
+ *  - bit 29: The thread voluntarily calls schedule() while holding an active
+ *    preempt_v. All preempt_v context should be dropped in such case because
+ *    V-regs are caller-saved. Only sstatus.VS=ON is persisted across a
+ *    schedule() call.
  *  - bit 30: The in-kernel preempt_v context is saved, and requries to be
  *    restored when returning to the context that owns the preempt_v.
  *  - bit 31: The in-kernel preempt_v context is dirty, as signaled by the
@@ -93,6 +97,7 @@ struct pt_regs;
 #define RISCV_PREEMPT_V			0x00000100
 #define RISCV_PREEMPT_V_DIRTY		0x80000000
 #define RISCV_PREEMPT_V_NEED_RESTORE	0x40000000
+#define RISCV_PREEMPT_V_IN_SCHEDULE	0x20000000
 
 /* CPU-specific state of a task */
 struct thread_struct {
diff --git a/arch/riscv/include/asm/vector.h b/arch/riscv/include/asm/vector.h
index c7c023afbacd..c5b6070db99f 100644
--- a/arch/riscv/include/asm/vector.h
+++ b/arch/riscv/include/asm/vector.h
@@ -76,6 +76,11 @@ static __always_inline void riscv_v_disable(void)
 	csr_clear(CSR_SSTATUS, SR_VS);
 }
 
+static __always_inline bool riscv_v_is_on(void)
+{
+	return !!(csr_read(CSR_SSTATUS) & SR_VS);
+}
+
 static __always_inline void __vstate_csr_save(struct __riscv_v_ext_state *dest)
 {
 	asm volatile (
@@ -244,6 +249,11 @@ static inline void __switch_to_vector(struct task_struct *prev,
 	struct pt_regs *regs;
 
 	if (riscv_preempt_v_started(prev)) {
+		if (riscv_v_is_on()) {
+			WARN_ON(prev->thread.riscv_v_flags & RISCV_V_CTX_DEPTH_MASK);
+			riscv_v_disable();
+			prev->thread.riscv_v_flags |= RISCV_PREEMPT_V_IN_SCHEDULE;
+		}
 		if (riscv_preempt_v_dirty(prev)) {
 			__riscv_v_vstate_save(&prev->thread.kernel_vstate,
 					      prev->thread.kernel_vstate.datap);
@@ -254,10 +264,16 @@ static inline void __switch_to_vector(struct task_struct *prev,
 		riscv_v_vstate_save(&prev->thread.vstate, regs);
 	}
 
-	if (riscv_preempt_v_started(next))
-		riscv_preempt_v_set_restore(next);
-	else
+	if (riscv_preempt_v_started(next)) {
+		if (next->thread.riscv_v_flags & RISCV_PREEMPT_V_IN_SCHEDULE) {
+			next->thread.riscv_v_flags &= ~RISCV_PREEMPT_V_IN_SCHEDULE;
+			riscv_v_enable();
+		} else {
+			riscv_preempt_v_set_restore(next);
+		}
+	} else {
 		riscv_v_vstate_set_restore(next, task_pt_regs(next));
+	}
 }
 
 void riscv_v_vstate_ctrl_init(struct task_struct *tsk);
-- 
2.39.3 (Apple Git-145)


