Return-Path: <linux-kernel+bounces-212717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B49E5906539
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 09:34:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F7051F2226A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 07:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4130C13D51C;
	Thu, 13 Jun 2024 07:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="iRvRIYIO"
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1047713D50A
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 07:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718263990; cv=none; b=U2Bdeb8Q7/vP6H+MyTiI5kRk7BQVfz4PPh2gXYSDASzk2USgaLP9ZPCXzuUngDpBb1nt8Ct0KNoO3m2yY8aTxmNs8WhTs2cswytgDqrO1LkoeESBwXxcqwYzHngNXGUmBbLoWS0WM/sLbe6Wn28uhqQh7Ntr1YqFSEEyNZHD3yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718263990; c=relaxed/simple;
	bh=Qip5cL32AGGgHJ2xW9xkkh9vglc7nxfsBldmU/OW3wg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pdNewMoUEkoNGxBJRcqmNzPwdrXmlSIb1dZ+GgI5gGFB5PRTzH0oXs0S7IqUGVCjAHW0Oj21Ic+BVqCE9knWLrE8d7Lx5M0Vq21VNLR78a8dmdIMHjsHfmC/DkCTzomOV/9qiwFf3ybcfgnPTv8VOL8qd78r1NU8DPSmCKqYSkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=iRvRIYIO; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3d24724514eso228780b6e.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 00:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1718263988; x=1718868788; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TeZhGtu+DoZzH37TzHgHW9NZu5mW4WfgIzkfv6QNhDQ=;
        b=iRvRIYIOrrNcIUvUYdmLBf3vNeKbUpWLvESA1dCHUUXQt8nVtTaI7UemCGutCRFY8K
         G9xrTTsoptnQtxLK1WhcmlSMmGE37YVSrGVzz1cyl+5qX5kT7FmtZ8uCbKEgKS/gbxzc
         6OE76uclx0Yv2wLQmV4MzDKVBgvq8zCDvuvoyF+vU6VMHM1VmgK5fXjzCU4lnyX5wzMu
         BhnhthKk1SwoYuk5IrS7XIa0t1wrV7cofVvXD11xhovd+bKyfKss2h5ICWt7dfkYjEfQ
         ss1GUWcA5KpvZqibYp9FjCxHFMOjtVxr4nUZh4hnqX4E5keSo81mv4VgypAjnuMKhhMi
         191A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718263988; x=1718868788;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TeZhGtu+DoZzH37TzHgHW9NZu5mW4WfgIzkfv6QNhDQ=;
        b=ZwcVnuHknL8lOIDgSLRfF7xcvDjCd90zlCKTUG3iX8YofW3tkB5kFr9qzAIbD05lhZ
         rjwsgs5AMz/fEus9in96LYhGoeCGhyUemiVwEB3aTk0NyTfXrm3aCuunJK84a2Kj4HZB
         dN+W0LttgjXynPE41JBDM5jm75IDFulqxMD6zO+lTJX1BtJXmslKDet2yj47bt/5OhE/
         LX6PRpbR1Q2phw2w/ckr2kPPMTGaCYybAbPxvRonsLUq+OazTwGoKTRPQ9OhnDKSNu0j
         GUz0/ST1FWFdD4LgXjgtdMRmN/eJsscXcjkH4YXPIIO/hN08q0VH90SR9AQXn0OlOAj2
         2Wzg==
X-Forwarded-Encrypted: i=1; AJvYcCUJHFMEDeEkBbAB6tAUqW3+Q37EnGaOiPPy1dMeUnFjfU+1xle4p1UMoawpcvkeYutxleYUhjCxXE1yUYA5R+ysXz+nyWyW423LNptx
X-Gm-Message-State: AOJu0Yy2zwlSZIr74WMsj/52hGCbIfnNazM2gOR/eJsC0qwYhqy8rdJF
	vL3qm81M/OPZ4ddgeP7yczUbM4K3k7HFFQcxDFgTOY+bicSj3IBaqJ8xwhKMIFc=
X-Google-Smtp-Source: AGHT+IG/QcH0femSCZzF6g5xhDc4dqSZTxWrgAQgosN/9/estM4RRUpCw1U0PcaMW2D86qVbhMaGwA==
X-Received: by 2002:a05:6808:2199:b0:3d2:1c8f:be0c with SMTP id 5614622812f47-3d23e045f11mr5371608b6e.30.1718263988155;
        Thu, 13 Jun 2024 00:33:08 -0700 (PDT)
Received: from [127.0.1.1] (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705cc78a1a0sm730028b3a.0.2024.06.13.00.33.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 00:33:07 -0700 (PDT)
From: Andy Chiu <andy.chiu@sifive.com>
Date: Thu, 13 Jun 2024 15:11:12 +0800
Subject: [PATCH 7/8] riscv: vector: Support calling schedule() for
 preemptible Vector
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240613-dev-andyc-dyn-ftrace-v4-v1-7-1a538e12c01e@sifive.com>
References: <20240613-dev-andyc-dyn-ftrace-v4-v1-0-1a538e12c01e@sifive.com>
In-Reply-To: <20240613-dev-andyc-dyn-ftrace-v4-v1-0-1a538e12c01e@sifive.com>
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alexghiti@rivosinc.com>, Zong Li <zong.li@sifive.com>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Puranjay Mohan <puranjay@kernel.org>
Cc: Palmer Dabbelt <palmer@rivosinc.com>, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 llvm@lists.linux.dev, Andy Chiu <andy.chiu@sifive.com>
X-Mailer: b4 0.12.4

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
index 68c3432dc6ea..02598e168659 100644
--- a/arch/riscv/include/asm/processor.h
+++ b/arch/riscv/include/asm/processor.h
@@ -95,6 +95,10 @@ struct pt_regs;
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
@@ -109,6 +113,7 @@ struct pt_regs;
 #define RISCV_PREEMPT_V			0x00000100
 #define RISCV_PREEMPT_V_DIRTY		0x80000000
 #define RISCV_PREEMPT_V_NEED_RESTORE	0x40000000
+#define RISCV_PREEMPT_V_IN_SCHEDULE	0x20000000
 
 /* CPU-specific state of a task */
 struct thread_struct {
diff --git a/arch/riscv/include/asm/vector.h b/arch/riscv/include/asm/vector.h
index 731dcd0ed4de..50693cffbe78 100644
--- a/arch/riscv/include/asm/vector.h
+++ b/arch/riscv/include/asm/vector.h
@@ -75,6 +75,11 @@ static __always_inline void riscv_v_disable(void)
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
@@ -243,6 +248,11 @@ static inline void __switch_to_vector(struct task_struct *prev,
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
@@ -253,10 +263,16 @@ static inline void __switch_to_vector(struct task_struct *prev,
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
2.43.0


