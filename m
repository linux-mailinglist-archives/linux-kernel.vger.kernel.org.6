Return-Path: <linux-kernel+bounces-530973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A59FEA43A7C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 11:00:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF1177A7CEA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 09:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41F0226AA8A;
	Tue, 25 Feb 2025 09:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Og5sPRYN"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9930826A1A0
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 09:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740477339; cv=none; b=agb1e0RHzvuY7MrDPgpoaxh6ECWyrckugIERUhwO9TPTwcGABdhsVW6InNSbnTKZA9nV9DW4ifDSxO9+V4rRFWxY2STkVpU6yD+j9bQUwlkIoKRL6NsFEurdCqVW/YxQNuNxQPO04Tam1pypt0/7NKM8ZVExjFXWO2LlwrEi+l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740477339; c=relaxed/simple;
	bh=E22mkU7jEFL4ZHmD3IpEdAIvC0obWKhhIqtvRZZoLw8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E5vroAPYqkk9qiZl9zdEp3ai08pE8PhOVd2G+7yFjv9VAuvejhmuKlQdjjV/iTvfWhgd5upNNG33gzNw3LPK93wpXSqJ8xXXhdjD56AZV0MtO0Mwe3djqpL8CR6W59R+qav7A0D9tkpIUStYKMsha41v034r+t+U0ej8yy7IBXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Og5sPRYN; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-543d8badc30so6249370e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 01:55:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740477336; x=1741082136; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oIYvJaonUYyfEumf+Z+WmSCNyMMQcgPh7imvn/7wUEM=;
        b=Og5sPRYNmm4f01RVojE4Cc49++ftLZx80CCa5DHjryIjJQSGP6GwnLtTf8uxkcGKx2
         vbinvMtwiapnWt/7iMLiDcPyi7GxgXMgfzinfwtxVBzXFNk8sO0uKucqWI9t8d1PMUqw
         6q+VErHtZm8AbAF4GWvq9IkdAhPCi9o7V4RnYS2OPTBbtx3bkz0Y6/8FOQUQmVzvRnag
         eougkTZXhnj/iLUQxMXigGjh1meC79smAN1oxJC256BzecLEvw6Xf/swKf+n6A6nhuCw
         h7Xvy4zyjwdSkcQYR1Onig2ibPEF8yy5GPTI30QYCPL12Cx+Vxyj+69tDev13jG9K9Yd
         u55w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740477336; x=1741082136;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oIYvJaonUYyfEumf+Z+WmSCNyMMQcgPh7imvn/7wUEM=;
        b=PyECK7lCrmRVcM47j5o6wUnWp+MlunzEuJXbDm4RtyLtdYh5M3VDKBgY+h9JEBjigi
         1utvNx1F21Nv0LTYgj/3Vw7u8fGqQtgOIiHJSrRE65Iq9kueINFuQGbkUByIQxh21Dqh
         YRriTnbtmCNpffd5+gG6HQMS/9INwtH87shoTHn9HIa5Mc0uZxVxX/HdRSUjtlSuVOym
         YHNItJ89AXyUWzgxJG5JOoCgFp4bM6wcrZRyY4MTYBxLHx9EELduDfigBulyNgB/H7RO
         3oEYdi5K6Tas/zrE5qYsfO1uZ4SfHrjZqYyhy76+eRfx1TyuoZUlLCTvvsBvFewW619S
         c0lg==
X-Forwarded-Encrypted: i=1; AJvYcCURj0GOUoIeoX9OQPe9HAN96kTVb4BDLGDj+V0V49N8x32lC71M5auiswzhJ45G5BwQOoHydlXwwGorf74=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSLTbi+2LJZKw3DSa+eLqC6jJDBLLQYkjzqLLWd/ERlqemKOb3
	AyxH6uS1lLS6MJIchHVcEGgtwPuyE6vMC/1gzfPzi7WgamJUnNj52G6uiM7H0dE=
X-Gm-Gg: ASbGnctfqfWxOE693sEN/xzivr+q7aq9dqrv6GjZ03gFdhLxR13/QmnXZE/gFlvLtD9
	l2jQweSq+X8lUYK6MJAxlq+jLxy03Ov7uYRFuonWfNGeMYuz65R74s8+ZTg0dYUyhL20d4d58Vg
	NLhOSbAs+kA0vWgYqgbxUqPNXReoVHkVvrJjwgc5vJnppI6T5HMiwfRVPUnGVGqr284jkLDb2yP
	sKYkCZ5I2UyoeMWycRjMd14QCQjWsE2z0iUJkjnYTFONfDQSf8uXybqex2RLqNCrj79VMmBp1IM
	FIrz8niRWINQlR8tGSnxstfeA6qVBfpHGW1t
X-Google-Smtp-Source: AGHT+IEadLgBcodjV4MeijK1RxbLNXPOedOFvhDLMaZ6EVsgBHRAKm5NLB+ewxhEdUYnEE+8TXegEw==
X-Received: by 2002:a05:6512:224b:b0:545:54b:6a05 with SMTP id 2adb3069b0e04-548510eebcdmr998842e87.45.1740477335666;
        Tue, 25 Feb 2025 01:55:35 -0800 (PST)
Received: from [192.168.1.140] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-548514b261esm132867e87.24.2025.02.25.01.55.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 01:55:34 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 25 Feb 2025 10:55:18 +0100
Subject: [PATCH v5 31/31] ARM: entry: Reimplement local restart in C
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250225-arm-generic-entry-v5-31-2f02313653e5@linaro.org>
References: <20250225-arm-generic-entry-v5-0-2f02313653e5@linaro.org>
In-Reply-To: <20250225-arm-generic-entry-v5-0-2f02313653e5@linaro.org>
To: Dmitry Vyukov <dvyukov@google.com>, Oleg Nesterov <oleg@redhat.com>, 
 Russell King <linux@armlinux.org.uk>, Kees Cook <kees@kernel.org>, 
 Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 "Paul E. McKenney" <paulmck@kernel.org>, 
 Jinjie Ruan <ruanjinjie@huawei.com>, Arnd Bergmann <arnd@arndb.de>, 
 Ard Biesheuvel <ardb@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.14.2

The former local restart hack to restart syscalls inside
the kernel if we get restart signals while processing a
system call was deleted when converting the architecture
to generic entry.

This makes strace tests fail so the hack is necessary.

Now, after the conversion to generic entry, restore the
order by reimplementing this with two TIF flags that
help us to issue system call restarts immediately in the
kernel.

This is essentially a reimplementation of commit 81783786d5cf
"ARM: 7473/1: deal with handlerless restarts without leaving
the kernel" from 2012, but in C, on top of generic entry.

Link: http://lists.infradead.org/pipermail/linux-arm-kernel/2012-June/104733.html
Link: https://lore.kernel.org/all/1340377626-17075-1-git-send-email-will.deacon@arm.com/
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/include/asm/thread_info.h |  4 ++++
 arch/arm/kernel/signal.c           | 17 +++++++++++++----
 arch/arm/kernel/syscall.c          | 22 ++++++++++++++++++++++
 3 files changed, 39 insertions(+), 4 deletions(-)

diff --git a/arch/arm/include/asm/thread_info.h b/arch/arm/include/asm/thread_info.h
index 84e58a9cdab63ad264c2cd2bad64239d1912cbe7..09dcaeef645a4ab45f40a14f8d7b46f408225f81 100644
--- a/arch/arm/include/asm/thread_info.h
+++ b/arch/arm/include/asm/thread_info.h
@@ -150,6 +150,8 @@ extern int vfp_restore_user_hwstate(struct user_vfp *,
 #define TIF_USING_IWMMXT	17
 #define TIF_MEMDIE		18	/* is terminating due to OOM killer */
 #define TIF_RESTORE_SIGMASK	19
+#define TIF_LOCAL_RESTART	20
+#define TIF_LOCAL_RESTART_BLOCK	21
 
 #define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
 #define _TIF_NEED_RESCHED	(1 << TIF_NEED_RESCHED)
@@ -157,6 +159,8 @@ extern int vfp_restore_user_hwstate(struct user_vfp *,
 #define _TIF_UPROBE		(1 << TIF_UPROBE)
 #define _TIF_NOTIFY_SIGNAL	(1 << TIF_NOTIFY_SIGNAL)
 #define _TIF_USING_IWMMXT	(1 << TIF_USING_IWMMXT)
+#define _TIF_LOCAL_RESTART	(1 << TIF_LOCAL_RESTART)
+#define _TIF_LOCAL_RESTART_BLOCK (1 << TIF_LOCAL_RESTART_BLOCK)
 
 #define _TIF_WORK_MASK		(_TIF_NEED_RESCHED | _TIF_SIGPENDING | \
 				 _TIF_NOTIFY_RESUME | _TIF_UPROBE | \
diff --git a/arch/arm/kernel/signal.c b/arch/arm/kernel/signal.c
index 35d2bb3cd2b442dac164548037262e065fbfe12a..a4fc6522124fd3ac3df7149ba38cf4b097196e06 100644
--- a/arch/arm/kernel/signal.c
+++ b/arch/arm/kernel/signal.c
@@ -541,7 +541,8 @@ void arch_do_signal_or_restart(struct pt_regs *regs)
 	unsigned int retval = 0, continue_addr = 0, restart_addr = 0;
 	bool syscall = (syscall_get_nr(current, regs) != -1);
 	struct ksignal ksig;
-	int restart = 0;
+	bool restart = false;
+	bool restart_block = false;
 
 	/*
 	 * If we were from a system call, check for system call restarting...
@@ -557,12 +558,12 @@ void arch_do_signal_or_restart(struct pt_regs *regs)
 		 */
 		switch (retval) {
 		case -ERESTART_RESTARTBLOCK:
-			restart -= 2;
+			restart_block = true;
 			fallthrough;
 		case -ERESTARTNOHAND:
 		case -ERESTARTSYS:
 		case -ERESTARTNOINTR:
-			restart++;
+			restart = true;
 			regs->ARM_r0 = regs->ARM_ORIG_r0;
 			regs->ARM_pc = restart_addr;
 			break;
@@ -593,8 +594,16 @@ void arch_do_signal_or_restart(struct pt_regs *regs)
 	} else {
 		/* no handler */
 		restore_saved_sigmask();
-		if (unlikely(restart) && regs->ARM_pc == restart_addr)
+		if (unlikely(restart) && regs->ARM_pc == restart_addr) {
+			/*
+			 * These flags will be picked up in the syscall invocation code,
+			 * and a local restart will be issued without exiting the kernel.
+			 */
+			set_thread_flag(TIF_LOCAL_RESTART);
+			if (restart_block)
+				set_thread_flag(TIF_LOCAL_RESTART_BLOCK);
 			regs->ARM_pc = continue_addr;
+		}
 	}
 	return;
 }
diff --git a/arch/arm/kernel/syscall.c b/arch/arm/kernel/syscall.c
index ed3ab51283c06c1398ece2ad3ee1fae16cd03ee8..20b59f5dfdc8d2e8c168ac04c2244cb6371e5672 100644
--- a/arch/arm/kernel/syscall.c
+++ b/arch/arm/kernel/syscall.c
@@ -11,6 +11,7 @@ __visible void invoke_syscall(void *table, struct pt_regs *regs, int scno)
 {
 	int ret;
 
+local_restart:
 	scno = syscall_enter_from_user_mode(regs, scno);
 	/* When tracing syscall -1 means "skip syscall" */
 	if (scno < 0) {
@@ -34,4 +35,25 @@ __visible void invoke_syscall(void *table, struct pt_regs *regs, int scno)
 	syscall_set_return_value(current, regs, 0, ret);
 
 	syscall_exit_to_user_mode(regs);
+
+	/*
+	 * Handle local restart: this means that when generic entry
+	 * calls arch_do_signal_or_restart() because a signal to
+	 * restart the syscall arrived while processing a system call,
+	 * we set these flags for the thread so that we don't even
+	 * exit the kernel, we just restart right here and clear
+	 * the restart condition.
+	 *
+	 * This is done because of signal race issues on ARM.
+	 */
+	if (test_thread_flag(TIF_LOCAL_RESTART)) {
+		if (test_thread_flag(TIF_LOCAL_RESTART_BLOCK)) {
+			scno = __NR_restart_syscall - __NR_SYSCALL_BASE;
+			/* Make this change visible to tracers */
+			task_thread_info(current)->abi_syscall = scno;
+			clear_thread_flag(TIF_LOCAL_RESTART_BLOCK);
+		}
+		clear_thread_flag(TIF_LOCAL_RESTART);
+		goto local_restart;
+	}
 }

-- 
2.48.1


