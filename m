Return-Path: <linux-kernel+bounces-205443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31E398FFBF2
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 08:14:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FE591C21220
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 06:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ADF514F127;
	Fri,  7 Jun 2024 06:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b="AeseLwtd"
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9DE1C2BE
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 06:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717740868; cv=none; b=ZYkBrn00TYEh9p5YAuUI+KLXY2jWLKbf71A1i1vFlZ0hmv5jGuh1/nG8n71flBzBD18ltPL1ZjANwVUesHRBqU0ual1HaPu7qTcv9WBS+GmJFMyddkFN45qza5t8Et5SOfGtl2CiuuIxkOwL49NDpJ111Xf8uiPv+TNgllxuk9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717740868; c=relaxed/simple;
	bh=z3O0J7dQLwl+IKWnRZJ8cn/LgvGtXJlQ/SIWe8WlR9I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jHPd7K22rW3c4JZugQfvbeXYpxeSJ7aUksugBDoL6+ZjRkFiZina3d5qMYo7Rsq0kXOqLFiqnsgxbigapORGyjc/1OyCF5unC2kFaJyY4VZUdt/FkF8mV8su06b/LDyPkhHg8U+cGf7HM8G5ZXm3XGJpGtUzASYyoqNrg0l4Lk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com; spf=pass smtp.mailfrom=tenstorrent.com; dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b=AeseLwtd; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tenstorrent.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-dfa8394d3f4so194528276.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 23:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tenstorrent.com; s=google; t=1717740865; x=1718345665; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7SBe0khJYPcKe88Z20mPvCwpcr89NxfQGoP3AH5L95A=;
        b=AeseLwtdEKPOheK8s5kefTVqbVxhU7V5g6+9PiYuVpih8Q1DZVHgTGtpYf/RdiBhl2
         AUrUd5b0M9tfbgoo/JFcP5g9LYHXVbLg+VDBk14RQ6UrnveWN/NDEDWUoIMT65mCpMtp
         snLN8f8T8ISMcMXVYdDQZreOQB6zg4zJZmdLEzpf79bSWiWPltwE/wczYQd35D9ImvHY
         gDVEEmSpNuEhTHA/L4peFecQooHWqRvjMZh6lZsIBR2wR/ziqwgdX02EaCa80huBcxNH
         r31i2b9I9mkU9mR34KHS0eKMfJdUNRQZIc6b5Xevcf2EC/v/wwIrDxA72079DqcQOM5k
         zfsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717740865; x=1718345665;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7SBe0khJYPcKe88Z20mPvCwpcr89NxfQGoP3AH5L95A=;
        b=uAaj79AIfQiWsQRCygN0hHJR+RztL030q3ZUCq2OVCrtJ1Um6YmTDp9aLc2GGsTvCY
         xEsti2haunue/1wL0p31rDwPc4GVaLvGJmqVreTbNdNBzsSqvNL+03v7SCQrDfKFASJy
         E54H4B+WQJ1gSplEDI6eT64JqoKc7GnROgvWEsN7sa1DO0EPkYO4TDMDeQIDWay1V7Ap
         fLdHQZekkXqjxjZ4oglD28fNx+rZmQ5/9m/zPatUXzSsAQUCvu/vqW89rEwgUodb8Rx7
         0ZEzc1k1Y92aQ/H7mgAz9ctCEbdWc8foyHVAU7YT7LLmxa2RT0mP+DNWC3DQvfIy8CGM
         8hnw==
X-Forwarded-Encrypted: i=1; AJvYcCURmex00zcBC++38Yb550KaNcvm8N+BSdpCX1Y+ZEuLxqni/rD5xidYip95wsFrbK7xB45TTxbsGO/wZSBms/P5gXmH9pxlFLsrYk1v
X-Gm-Message-State: AOJu0YyFTqEw7zCeW6jS/baQCHdAI8TfJGnmBOb24zdNIV3w81/+PJLY
	YMYYQqyc6X+7cXJVNIyvj4jl5lozh+0zN7mzz8voyI1OYTcqRvXhYZc3MzZh4g==
X-Google-Smtp-Source: AGHT+IF+YQ5lJDKmqA+WH/WoIEvyjrQ78iQvA3dqU25oe5V7nAI6uAGAEswdWk6Jk9UqgkFGFGFpJQ==
X-Received: by 2002:a81:8d0c:0:b0:61a:e298:54bd with SMTP id 00721157ae682-62cd56bb40amr12741747b3.5.1717740864945;
        Thu, 06 Jun 2024 23:14:24 -0700 (PDT)
Received: from sjc-lab-t7002.local.tenstorrent.com ([38.142.247.251])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b04f9f5f36sm14009226d6.128.2024.06.06.23.14.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 23:14:24 -0700 (PDT)
From: Cyril Bur <cyrilbur@tenstorrent.com>
To: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	antonb@tenstorrent.com
Subject: [PATCH v2] riscv: Improve exception and system call latency
Date: Thu,  6 Jun 2024 23:13:35 -0700
Message-Id: <20240607061335.2197383-1-cyrilbur@tenstorrent.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231225040018.1660554-1-antonb@tenstorrent.com>
References: <20231225040018.1660554-1-antonb@tenstorrent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Anton Blanchard <antonb@tenstorrent.com>

Many CPUs implement return address branch prediction as a stack. The
RISCV architecture refers to this as a return address stack (RAS). If
this gets corrupted then the CPU will mispredict at least one but
potentally many function returns.

There are two issues with the current RISCV exception code:

- We are using the alternate link stack (x5/t0) for the indirect branch
  which makes the hardware think this is a function return. This will
  corrupt the RAS.

- We modify the return address of handle_exception to point to
  ret_from_exception. This will also corrupt the RAS.

Testing the null system call latency before and after the patch:

Visionfive2 (StarFive JH7110 / U74)
baseline: 189.87 ns
patched:  176.76 ns

Lichee pi 4a (T-Head TH1520 / C910)
baseline: 666.58 ns
patched:  636.90 ns

Just over 7% on the U74 and just over 4% on the C910.

Signed-off-by: Anton Blanchard <antonb@tenstorrent.com>
Signed-off-by: Cyril Bur <cyrilbur@tenstorrent.com>
---
v2:
   Simplify jalr ra,t1 to jalr t1
   Drop extra .globl from entry.S and use ra == handle_exception
---
 arch/riscv/kernel/entry.S      | 17 ++++++++++-------
 arch/riscv/kernel/stacktrace.c |  4 ++--
 2 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
index 68a24cf9481a..c933460ed3e9 100644
--- a/arch/riscv/kernel/entry.S
+++ b/arch/riscv/kernel/entry.S
@@ -88,7 +88,6 @@ SYM_CODE_START(handle_exception)
 	call riscv_v_context_nesting_start
 #endif
 	move a0, sp /* pt_regs */
-	la ra, ret_from_exception
 
 	/*
 	 * MSB of cause differentiates between
@@ -97,7 +96,8 @@ SYM_CODE_START(handle_exception)
 	bge s4, zero, 1f
 
 	/* Handle interrupts */
-	tail do_irq
+	call do_irq
+	j ret_from_exception
 1:
 	/* Handle other exceptions */
 	slli t0, s4, RISCV_LGPTR
@@ -105,11 +105,14 @@ SYM_CODE_START(handle_exception)
 	la t2, excp_vect_table_end
 	add t0, t1, t0
 	/* Check if exception code lies within bounds */
-	bgeu t0, t2, 1f
-	REG_L t0, 0(t0)
-	jr t0
-1:
-	tail do_trap_unknown
+	bgeu t0, t2, 3f
+	REG_L t1, 0(t0)
+2:	jalr t1
+	j ret_from_exception
+3:
+
+	la t1, do_trap_unknown
+	j 2b
 SYM_CODE_END(handle_exception)
 ASM_NOKPROBE(handle_exception)
 
diff --git a/arch/riscv/kernel/stacktrace.c b/arch/riscv/kernel/stacktrace.c
index 528ec7cc9a62..5eb3d135b717 100644
--- a/arch/riscv/kernel/stacktrace.c
+++ b/arch/riscv/kernel/stacktrace.c
@@ -16,7 +16,7 @@
 
 #ifdef CONFIG_FRAME_POINTER
 
-extern asmlinkage void ret_from_exception(void);
+extern asmlinkage void handle_exception(void);
 
 static inline int fp_is_valid(unsigned long fp, unsigned long sp)
 {
@@ -70,7 +70,7 @@ void notrace walk_stackframe(struct task_struct *task, struct pt_regs *regs,
 			fp = frame->fp;
 			pc = ftrace_graph_ret_addr(current, NULL, frame->ra,
 						   &frame->ra);
-			if (pc == (unsigned long)ret_from_exception) {
+			if (pc == (unsigned long)handle_exception) {
 				if (unlikely(!__kernel_text_address(pc) || !fn(arg, pc)))
 					break;
 
-- 
2.25.1


