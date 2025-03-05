Return-Path: <linux-kernel+bounces-547921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43089A53C63
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 00:01:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 571BB3ADFE9
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 23:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E799202F80;
	Wed,  5 Mar 2025 23:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="MsL/TzQg"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1AC71FCFF5
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 23:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741215650; cv=none; b=Z/c61eQZ3uVCzP/3ShvK1DxhCMQ3T89mv8KdlcDS3lw33xKLHvxIxm7b6OWuQiAZ6LU8T9WIKYDpyeZCEK2Tm+xRO4T2C1QJcDU/HUZN3MNJCVbOocGlBGrJJZ6//lqOzIX+Weydzirc4PAcE/vJpnsSIoCqia2zPNvY9A7FQSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741215650; c=relaxed/simple;
	bh=j7ZO4FXV1Hf14yiJt7JLsFHCp0FLrXbd7xunBuFQ9j8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YQ9p9EE0j4051mqombEQpB3YZWg9y5AdVQarciZ6j/mkNZGX9uGsj4OIHLW9p6i+EBmiXe/b/Dq4WIPBXgZfv2ALNMQMsW+sg35TXuXTNfZA3JKgZ8moILLBUceWZLvUSIOJ7doI4CiWoBKPSyzJOl4rzgEA3+zUjVZoOeO+UPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=MsL/TzQg; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2ff615a114bso578053a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 15:00:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1741215648; x=1741820448; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p30t3bidsL8DH7wJ55Ht0+lyyt5ZTgdtBsNdg8zXD0s=;
        b=MsL/TzQgcQgfntgUTm8OXFdtO8Y99ejKBrC67e7Papoz4ByUIZ4hfOGAAYqpKLif/Z
         yAKNZB0JIwzwTBQVG/KJQX+bymsXEEjtbz3+3E1w0MJ3YyULaICbVJVBRh26a8Bf1zPW
         GdAXML3Q7OTXQon+bKRVpiq5zLOz5Et1zzzR6QY7F2CDzphP9jNFVFf+YGDWFBApBhPu
         bXjkYFHfksJfL0lPJP9UQ4RB5W3qSIT4HB7Kc7iChhPghOIlQk9Mgcn7p+GY/Lq8gS5P
         zSR3p3RwhHK2Mo2EHn4N57hHPxjVQyNIQLp7aVQk5UIRl8WxsUEPxctd4+VAZHnAdr5E
         3XVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741215648; x=1741820448;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p30t3bidsL8DH7wJ55Ht0+lyyt5ZTgdtBsNdg8zXD0s=;
        b=vAQaYWj6s3Xg7uC7UWD/ytWrD++r0hx28UlZCKa2eiG7WXmhnKc5GZGLqpjMnATDtb
         4yAieHXxU7mu7JyOFVu21dUJFn48e5NPCfMygjeTwYTO1GM+oUjwpIPj8Qy6ZVCMXj+M
         FEKtH0iCoUCqoldpFpIlbpVZQbsCr02OWotS7nUgA2FPRdRpRxMS4By7f5AvXXVQVnXd
         qm+OiHiDoDapMcEYFxU4xJP8fzLNflBLoSgnFmP9T41RMmNHTVwke4dvQDc9TlmzM5S3
         YQsVdHTZ3eKvuON6jcAC1KHbF5mmaXpPRleItrhuRjLkBrdR/caVFs0nwDjmtn0SqUCv
         iZBw==
X-Forwarded-Encrypted: i=1; AJvYcCX1rIz/3EHyu5qMSxpHmyEg/PAWPWvvSFCRAHDD8dW890gUk+ESzSvdj76/E0FJA+rZZaxTDCYrdjmjlRE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4d/rbv4hTXzWt6jYWh3Vnul4aLDvm00cFZLqQdfWXlZEYYhOg
	w3BPv4VJDycQ4vkyae7oFdBDHB/nkPS31+Hnx2tANXcNSWqO0796iTzpKdQezGs=
X-Gm-Gg: ASbGncvQJ9ZKzhErOHiaJHukBa79QNIPnBBrOlQ7rTRrP5c02YkFuMXnUkPuvhNOfP5
	GX8L+hNjsdvqxSSvyknCayE+rVxM9E8iLX4C070N+WuJ8QLOYfbhuVnJwhQ+ywy1I3UnGzVX4Oz
	Y6gey4HPBVxTXZRt4AMGVIujc/IQA3Dv8nom9i9snK2YOZMrxyk6oeCZVrNQcQ8W9QlALvvSzvF
	B082BdLHw4ETFWbBzVT+RB9sxrxiHBlIcVEZ11TZHdluriqhTbZ5LK6zL29FnaZQKqej86d5f3U
	6YmcvKhsPm2pUsNZ9P4SS6ipN4KRvOEhSjh0DW8wcci47Mui1uSOHoh8+Ha4
X-Google-Smtp-Source: AGHT+IHIXuq48FCG34gQSDWE/fOeG6ktun6hvvxw8iNV8AUnzyOAu2vvj3lTw8zV66HwuuHt9MjAlA==
X-Received: by 2002:a05:6a21:78a8:b0:1f3:3547:f21b with SMTP id adf61e73a8af0-1f359b16c26mr1515464637.5.1741215648040;
        Wed, 05 Mar 2025 15:00:48 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-aee7dedd22esm10593413a12.63.2025.03.05.15.00.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 15:00:47 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Wed, 05 Mar 2025 15:00:28 -0800
Subject: [PATCH RESEND v4 4/4] entry: Inline syscall_exit_to_user_mode()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250305-riscv_optimize_entry-v4-4-0d81bb45203f@rivosinc.com>
References: <20250305-riscv_optimize_entry-v4-0-0d81bb45203f@rivosinc.com>
In-Reply-To: <20250305-riscv_optimize_entry-v4-0-0d81bb45203f@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Huacai Chen <chenhuacai@kernel.org>, 
 WANG Xuerui <kernel@xen0n.name>, Thomas Gleixner <tglx@linutronix.de>, 
 Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@kernel.org>, 
 Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 loongarch@lists.linux.dev, Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5141; i=charlie@rivosinc.com;
 h=from:subject:message-id; bh=j7ZO4FXV1Hf14yiJt7JLsFHCp0FLrXbd7xunBuFQ9j8=;
 b=owGbwMvMwCXWx5hUnlvL8Y3xtFoSQ/qJ69OP3ch+/m7/lUad2VUJDPL51ybv0VH/nvKC5SkLh
 xw7y9trHaUsDGJcDLJiiiw81xqYW+/olx0VLZsAM4eVCWQIAxenAEzEjonhv4vXQjVhvjLJW47v
 WI/u84ud+Gj1tLXqLWe8m6Py1dcqMDAyrDtzKpZ5ai7br0NPPZ1Ktt3U837x7/vCZP99nPvecaj
 08AIA
X-Developer-Key: i=charlie@rivosinc.com; a=openpgp;
 fpr=7D834FF11B1D8387E61C776FFB10D1F27D6B1354

Architectures using the generic entry code can be optimized by having
syscall_exit_to_user_mode inlined.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 include/linux/entry-common.h | 43 ++++++++++++++++++++++++++++++++++++--
 kernel/entry/common.c        | 49 +-------------------------------------------
 2 files changed, 42 insertions(+), 50 deletions(-)

diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index fc61d0205c97084acc89c8e45e088946f5e6d9b2..f94f3fdf15fc0091223cc9f7b823970302e67312 100644
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -14,6 +14,7 @@
 #include <linux/kmsan.h>
 
 #include <asm/entry-common.h>
+#include <asm/syscall.h>
 
 /*
  * Define dummy _TIF work flags if not defined by the architecture or for
@@ -366,6 +367,15 @@ static __always_inline void exit_to_user_mode(void)
 	lockdep_hardirqs_on(CALLER_ADDR0);
 }
 
+/**
+ * syscall_exit_work - Handle work before returning to user mode
+ * @regs:	Pointer to current pt_regs
+ * @work:	Current thread syscall work
+ *
+ * Do one-time syscall specific work.
+ */
+void syscall_exit_work(struct pt_regs *regs, unsigned long work);
+
 /**
  * syscall_exit_to_user_mode_work - Handle work before returning to user mode
  * @regs:	Pointer to currents pt_regs
@@ -379,7 +389,30 @@ static __always_inline void exit_to_user_mode(void)
  * make the final state transitions. Interrupts must stay disabled between
  * return from this function and the invocation of exit_to_user_mode().
  */
-void syscall_exit_to_user_mode_work(struct pt_regs *regs);
+static __always_inline void syscall_exit_to_user_mode_work(struct pt_regs *regs)
+{
+	unsigned long work = READ_ONCE(current_thread_info()->syscall_work);
+	unsigned long nr = syscall_get_nr(current, regs);
+
+	CT_WARN_ON(ct_state() != CT_STATE_KERNEL);
+
+	if (IS_ENABLED(CONFIG_PROVE_LOCKING)) {
+		if (WARN(irqs_disabled(), "syscall %lu left IRQs disabled", nr))
+			local_irq_enable();
+	}
+
+	rseq_syscall(regs);
+
+	/*
+	 * Do one-time syscall specific work. If these work items are
+	 * enabled, we want to run them exactly once per syscall exit with
+	 * interrupts enabled.
+	 */
+	if (unlikely(work & SYSCALL_WORK_EXIT))
+		syscall_exit_work(regs, work);
+	local_irq_disable_exit_to_user();
+	exit_to_user_mode_prepare(regs);
+}
 
 /**
  * syscall_exit_to_user_mode - Handle work before returning to user mode
@@ -410,7 +443,13 @@ void syscall_exit_to_user_mode_work(struct pt_regs *regs);
  * exit_to_user_mode(). This function is preferred unless there is a
  * compelling architectural reason to use the separate functions.
  */
-void syscall_exit_to_user_mode(struct pt_regs *regs);
+static __always_inline void syscall_exit_to_user_mode(struct pt_regs *regs)
+{
+	instrumentation_begin();
+	syscall_exit_to_user_mode_work(regs);
+	instrumentation_end();
+	exit_to_user_mode();
+}
 
 /**
  * irqentry_enter_from_user_mode - Establish state before invoking the irq handler
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index e33691d5adf7aab4af54cf2bf8e5ef5bd6ad1424..f55e421fb196dd5f9d4e34dd85ae096c774cf879 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -146,7 +146,7 @@ static inline bool report_single_step(unsigned long work)
 	return work & SYSCALL_WORK_SYSCALL_EXIT_TRAP;
 }
 
-static void syscall_exit_work(struct pt_regs *regs, unsigned long work)
+void syscall_exit_work(struct pt_regs *regs, unsigned long work)
 {
 	bool step;
 
@@ -173,53 +173,6 @@ static void syscall_exit_work(struct pt_regs *regs, unsigned long work)
 		ptrace_report_syscall_exit(regs, step);
 }
 
-/*
- * Syscall specific exit to user mode preparation. Runs with interrupts
- * enabled.
- */
-static void syscall_exit_to_user_mode_prepare(struct pt_regs *regs)
-{
-	unsigned long work = READ_ONCE(current_thread_info()->syscall_work);
-	unsigned long nr = syscall_get_nr(current, regs);
-
-	CT_WARN_ON(ct_state() != CT_STATE_KERNEL);
-
-	if (IS_ENABLED(CONFIG_PROVE_LOCKING)) {
-		if (WARN(irqs_disabled(), "syscall %lu left IRQs disabled", nr))
-			local_irq_enable();
-	}
-
-	rseq_syscall(regs);
-
-	/*
-	 * Do one-time syscall specific work. If these work items are
-	 * enabled, we want to run them exactly once per syscall exit with
-	 * interrupts enabled.
-	 */
-	if (unlikely(work & SYSCALL_WORK_EXIT))
-		syscall_exit_work(regs, work);
-}
-
-static __always_inline void __syscall_exit_to_user_mode_work(struct pt_regs *regs)
-{
-	syscall_exit_to_user_mode_prepare(regs);
-	local_irq_disable_exit_to_user();
-	exit_to_user_mode_prepare(regs);
-}
-
-void syscall_exit_to_user_mode_work(struct pt_regs *regs)
-{
-	__syscall_exit_to_user_mode_work(regs);
-}
-
-__visible noinstr void syscall_exit_to_user_mode(struct pt_regs *regs)
-{
-	instrumentation_begin();
-	__syscall_exit_to_user_mode_work(regs);
-	instrumentation_end();
-	exit_to_user_mode();
-}
-
 noinstr void irqentry_enter_from_user_mode(struct pt_regs *regs)
 {
 	enter_from_user_mode(regs);

-- 
2.43.0


