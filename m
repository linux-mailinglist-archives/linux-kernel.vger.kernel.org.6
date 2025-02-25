Return-Path: <linux-kernel+bounces-530953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37EC9A43A6A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 10:57:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F0AD3A41FD
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 09:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49340267B17;
	Tue, 25 Feb 2025 09:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KsBR87sn"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63C7266F17
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 09:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740477317; cv=none; b=NfqoqFHZypv6oivEHnSsv1h8wcRiteIh2jKq49psReMifTHkkaz2Li1HMs3aWujOYDUhgmtJcswMaZkR+pHJkobL7UnbgcrpjMIXdSfoNDqw5MlbAl92zHMGXpTijipThZuqqW2nb2KaJVzwp2RwJqg0AMzgMpTcSk/llnihT48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740477317; c=relaxed/simple;
	bh=uLdRblJEcBgqrdlNhpGIwJYjD/vcY62yplB7gd+NKqw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WEAM2CHQc5IbK7HZdiN/P9pR7of30qFPD2qkWli5oQR/XifDqv3jyWCFnm5Ci032hlUa2wsGYrzgS1mQGBU/NkG8yoRxE0deGgjg/dwqrfy51FdzY4xF/PF4PxgvcIht8LlB9lUDOQqkuGqS8N983lgss5gzt/seG5m8/zyp4UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KsBR87sn; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-30a69c1a8d3so25628401fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 01:55:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740477314; x=1741082114; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pr2oSZFQs/khvnnGeJohJHSvChXi9NfDOygi+WZQm/M=;
        b=KsBR87sn1h1cQnlN7/yhRasb8Xa/TpVanY4PqIiqnVmsK6ZidVP7nwiCc2nl5/Uwd2
         46+/9vI+q1SXHJEuh/6SbbIVT7Psl1S1BBN1W4iicRIiMcg3RDrpZ42m++0M8zsmCr7+
         slbdaxAm4xAb09gKvu/cF6i9jcKALX/x8pKDJBHnKQ5oqBqs533U6+AwBah4QRhauM+l
         xnDRWuzw/izkFC81bGwp0HrF8/4iT6MPJuNAFYBjZPLLS0eW17ASAAyxCbW9ikU7zrjw
         /sSJ24JNQy6kWKt2WmaUQxYrJxwr+HXbMKlclqa8h6HDWAnaS9po0Wh6o/AMja0rKSyv
         GdBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740477314; x=1741082114;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pr2oSZFQs/khvnnGeJohJHSvChXi9NfDOygi+WZQm/M=;
        b=fHkVPixgUBCVFdaWmn5t3a/AWsTmvvelprQct8jyJ40Bvl7B7L7myzBLCfJoYnzne/
         WG6lGr4EEeSNX+SkCa8JBA2sg/cfoXN29EuAiKFJ79w2rXuBKM4om/oaNjWoS6+Ejo3n
         fHZhLRLbt23KX0sqU1dNPqMlFFUSWBHCa14GNt62ELEELd0Y9K3+E0kvGbIyu7QEtXdv
         wBAW9nm5gg0u0/Q1/5AuIOTVEsXoarEHF7mi5U6E5OPWXXlqM2E6ELsCIWWhd4Fzf2Lb
         lBPn19eaWalbPCBjJi5euR5eahhFA1gfjSruaVRVFa7M5WFj8AI/kPC6LuA/+PFcxsHg
         8eEw==
X-Forwarded-Encrypted: i=1; AJvYcCVGeWfLvj+lOtU/lUbJg7VfVQWcRIiosy9M5AL+VJ1thM3TtAorZWUua93m3w4a1Qv8jiUfADCyZLgOXzo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwV9ATqvyljTfzNGICcQCXuIs+YE/yUNUoVT65xggGS6wDW+yJY
	ouNSRGXzHO0Rqw0bBF8ZzbyG34QUDrNcpwSRRlVQ2Zk57Yi/FJnpGc9sTG4xoJY=
X-Gm-Gg: ASbGncvfKiLI/avUKDdNOEwmP82FXUVE8c7Fi+rhedxZIVx5d4kbqryR7PiGpadpy3u
	WtHRN/wOaUcGzTN7lNOGJK7QogNlxS+1OW7tH67j4RK4Cf0A5Kbv0WdObDoAuJkRSVDBxNHdNp1
	4pNYy2cYtH6B43Oe81sv8NTSPEOhDdCU2QkLM6Lika7p7FfUWMMhkXahrGTts7h6dYBQsi9dHcu
	zlKJx3vpZhvjjNcAIQeh9svFwYs23ANBM4qekNId7coWyAt96YqQhU2p0bV4cESlgCgurXrwKrH
	01njAjTQVRV7284VMeY6UnLUj36IBp0sJedK
X-Google-Smtp-Source: AGHT+IFeLR30oGpW5vklNxUSsMhMgUVaKjzRtV+OjULqK8ylumNd1C7a3hr2K2xQCsmZr/q/cwPOIA==
X-Received: by 2002:a05:6512:3297:b0:549:2ae5:99d8 with SMTP id 2adb3069b0e04-5492ae59d04mr117932e87.3.1740477313811;
        Tue, 25 Feb 2025 01:55:13 -0800 (PST)
Received: from [192.168.1.140] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-548514b261esm132867e87.24.2025.02.25.01.55.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 01:55:12 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 25 Feb 2025 10:54:59 +0100
Subject: [PATCH v5 12/31] ARM: entry: Rename syscall invocation
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250225-arm-generic-entry-v5-12-2f02313653e5@linaro.org>
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

Now that we do not have a separate trace syscall invocation
path, rename the invocation functions to be generic.

This can be squashed into the previous patch, it is just done
here for the previous patch to be easier to get a cleaner
diff and be easier to read.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/include/asm/syscall.h |  2 +-
 arch/arm/kernel/entry-common.S | 10 +++++-----
 arch/arm/kernel/syscall.c      |  8 ++++----
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm/include/asm/syscall.h b/arch/arm/include/asm/syscall.h
index 9c664d8c5718f58034f442c20a030b59faf65dd9..b94fd7ce17f82f0baf06b74800245112e1f13002 100644
--- a/arch/arm/include/asm/syscall.h
+++ b/arch/arm/include/asm/syscall.h
@@ -19,7 +19,7 @@
 
 extern const unsigned long sys_call_table[];
 
-int invoke_syscall_trace(void *table, struct pt_regs *regs, int scno);
+int invoke_syscall(void *table, struct pt_regs *regs, int scno);
 
 static inline int syscall_get_nr(struct task_struct *task,
 				 struct pt_regs *regs)
diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
index f0f1f8723965313b287158fb2a238908db72fcd2..f1e48002bd3075ea67b5883178583127fa0055c6 100644
--- a/arch/arm/kernel/entry-common.S
+++ b/arch/arm/kernel/entry-common.S
@@ -260,7 +260,7 @@ ENTRY(vector_swi)
 	stmdb	sp!, {r4, r5}			@ push fifth and sixth args
 	mov	r0, tbl
 	mov	r2, scno			@ syscall number from r7
-	bl	invoke_syscall_trace
+	bl	invoke_syscall
 	cmp	r0, #0
 	beq	ret_fast_syscall
 	/* This path taken when tracing */
@@ -390,7 +390,7 @@ ENDPROC(sys_mmap2)
  * r1: regs
  * r2: syscall number
  */
-SYM_TYPED_FUNC_START(invoke_syscall_trace_asm)
+SYM_TYPED_FUNC_START(invoke_syscall_asm)
 #ifdef CONFIG_CPU_SPECTRE
 	csdb
 #endif
@@ -400,17 +400,17 @@ SYM_TYPED_FUNC_START(invoke_syscall_trace_asm)
 	/* Make space to copy the two syscall stack arguments */
 	sub	sp, sp, #S_OFF
 	mov	scno, r2
-	badr	lr, __invoke_syscall_trace_ret	@ return right here
+	badr	lr, __invoke_syscall_ret	@ return right here
 	ldmia	r1, {r0 - r6}			@ reload r0-r6 from regs
 	stmia	sp, {r4, r5}			@ copy stack arguments
 	ldr	pc, [tbl, scno, lsl #2]		@ call sys_* routine
-__invoke_syscall_trace_ret:
+__invoke_syscall_ret:
 	/* Drop the copied stack arguments */
 	add	sp, sp, #S_OFF
 	pop	{r4 - r10, lr}
  ARM(	mov	pc, lr		)
  THUMB(	bx	lr		)
-SYM_FUNC_END(invoke_syscall_trace_asm)
+SYM_FUNC_END(invoke_syscall_asm)
 
 #ifdef CONFIG_OABI_COMPAT
 
diff --git a/arch/arm/kernel/syscall.c b/arch/arm/kernel/syscall.c
index 36330023b5484399a4ca2fdb5727b410e2c74b6f..6f518ec3870fb36a64d1b671b20f96d63a52bf78 100644
--- a/arch/arm/kernel/syscall.c
+++ b/arch/arm/kernel/syscall.c
@@ -8,10 +8,10 @@ static inline bool has_syscall_work(unsigned long flags)
 	return unlikely(flags & _TIF_SYSCALL_WORK);
 }
 
-int invoke_syscall_trace_asm(void *table, struct pt_regs *regs, int scno);
-__ADDRESSABLE(invoke_syscall_trace_asm);
+int invoke_syscall_asm(void *table, struct pt_regs *regs, int scno);
+__ADDRESSABLE(invoke_syscall_asm);
 
-__visible int invoke_syscall_trace(void *table, struct pt_regs *regs, int scno)
+__visible int invoke_syscall(void *table, struct pt_regs *regs, int scno)
 {
 	unsigned long flags = read_thread_flags();
 	int ret;
@@ -23,7 +23,7 @@ __visible int invoke_syscall_trace(void *table, struct pt_regs *regs, int scno)
 	}
 
 	if (scno < NR_syscalls) {
-		ret = invoke_syscall_trace_asm(table, regs, scno);
+		ret = invoke_syscall_asm(table, regs, scno);
 		goto exit_save;
 	}
 

-- 
2.48.1


