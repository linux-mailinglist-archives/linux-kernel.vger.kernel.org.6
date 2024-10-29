Return-Path: <linux-kernel+bounces-386747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 359909B479A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 11:59:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8206283501
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 10:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E85642076A6;
	Tue, 29 Oct 2024 10:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OEImcMy7"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939842071EB
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 10:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730199183; cv=none; b=FORBWZdBlMvKgr+hlwvehPNdhIkJL7gMIasng4ghzmjJk8EvP0jv+bwuuaW+777LgRz/1esHfoOak4VEUbO3yoEi2pk0LuHYIPhU47TmMxI9leTfiIagKl1bKgQM+U3CgVDMY+7H75bC+HMSpmQv1Lpxi+phf7tFIdGpFaViWF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730199183; c=relaxed/simple;
	bh=g9d64KHtUbVDBZrCbOcA7Q4EzM8BIaX3zFAaGvQCJXo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=omdnnZZxMNfCo6P9BGBFtLWz6Mm5QSLTpjWo0qDQnJn9q2or6C76KlvnnzgFOX8uGbO5/sgfcNHHmUWwt8fLiUUwwrdB8Mj6fiz9/pEu4anY9StiX2ldVpbPZKm5IyBtImU+7I6/w0tJg7LNSkLv4PtulErVvzoVzUxSXQOTudY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OEImcMy7; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2fb5fa911aaso71610661fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 03:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730199179; x=1730803979; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wUlF8zw6dAVB0pDGKJAXIn96hGOC+sJV5+syU6CZdaU=;
        b=OEImcMy7UVw2IibYda8XCj3l45Em5rFyG8Vup9ZNgrqVMZhHA+YbwZ+f57RFN8Qa4o
         dfK1/of2S/JVpkBFvpjApt6y6vVWCJVHvR8t9Z8G8jrqu8CBrfB6/GD5oDoxEhJEypR0
         xmwEJJnqCboCJVFv0H9MYdc9lea4zvdws6exkdKxQGdv3mg2YOcN8qhxnZKzsuA3dHKo
         2wGMYSDWg/bKzcUKMrAjIKr5xEXZcI4Gc681f9MPM5IhARs+v/QxcKyvk3Jkr8Vws+C5
         r8dhN+YqdoCdSFVhN2kxZFnX2zeyDgKOcfvxfPTqydmy2UGUntLGD1AYNfH/4LdM5fFw
         jF7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730199179; x=1730803979;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wUlF8zw6dAVB0pDGKJAXIn96hGOC+sJV5+syU6CZdaU=;
        b=UZPyK7E2Zu+Up9JEvSOasSh8zyL3vn+sR9SS/DfLy1X7mtJMKqVxkopQiVasSvH0hH
         rOH5cgtcFlLF+kXY0I5/3Jx7NRpOzIPuRqPIQEh1nHTLmSgwXiL8aDAnaccLuc6w5w95
         MRo5O/yQXpKMCUiPYCQ4gtsVACHqSh1VRyiiznwngWcefOx0XC2x0YqszpunnHPHb3Kk
         C2mTcSMLiVeUe2qLTD2YX49mYcQay+Ykk+skD0pmbRE08gyi+1OR/RpszNqvOhjIcso3
         6zBI62FBucSR+PL4e+ONL1hk6mHq06sly+9hrwGSQzNeSjA+ShXnYscExfIbBPRtt1Yr
         KyjA==
X-Forwarded-Encrypted: i=1; AJvYcCXH5uFHzBdCMOdp4jP+E/dNbW5Bymmf01AjwOW4sbNlagX+ooEovbYKo7KPCFVEj+xmHbGx/+rlU48hIy0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8dYkVqb4v6Ul//MAXI3nYIETv1/Nbb7G4QIZmbzTANfYjTvSU
	BbwC3ypkRI7T2MCfC6r4Z4NpYIav6zkNUDmqjohQBSpy3lWPGfPTnZRhI3lQKuM=
X-Google-Smtp-Source: AGHT+IE1Zk4oQJfcQ3ydT5j4hWbXtZadfIMGcMOO6V/a6kzdw22mTKnF7LA+e5CH2gcq4VfHFz9bfA==
X-Received: by 2002:a05:6512:3ba3:b0:533:483f:9562 with SMTP id 2adb3069b0e04-53b3491e07amr8032028e87.42.1730199178733;
        Tue, 29 Oct 2024 03:52:58 -0700 (PDT)
Received: from lino.lan ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53b2e12452fsm1351307e87.73.2024.10.29.03.52.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 03:52:57 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 29 Oct 2024 11:52:47 +0100
Subject: [PATCH RFC v2 07/28] ARM: entry: Rewrite two asm calls in C
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241029-arm-generic-entry-v2-7-573519abef38@linaro.org>
References: <20241029-arm-generic-entry-v2-0-573519abef38@linaro.org>
In-Reply-To: <20241029-arm-generic-entry-v2-0-573519abef38@linaro.org>
To: Oleg Nesterov <oleg@redhat.com>, Russell King <linux@armlinux.org.uk>, 
 Kees Cook <kees@kernel.org>, Andy Lutomirski <luto@amacapital.net>, 
 Will Drewry <wad@chromium.org>, Frederic Weisbecker <frederic@kernel.org>, 
 "Paul E. McKenney" <paulmck@kernel.org>, 
 Jinjie Ruan <ruanjinjie@huawei.com>, Arnd Bergmann <arnd@arndb.de>, 
 Ard Biesheuvel <ardb@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.14.0

The normal and trace entry code calls out to arm_syscall()
and sys_ni_syscall() from assembly, but these calls can
be moved over to the new C implementation.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/include/asm/traps.h   |  2 +-
 arch/arm/kernel/entry-common.S | 23 +++++------------------
 arch/arm/kernel/syscall.c      | 13 +++++++++++--
 arch/arm/kernel/traps.c        |  2 +-
 4 files changed, 18 insertions(+), 22 deletions(-)

diff --git a/arch/arm/include/asm/traps.h b/arch/arm/include/asm/traps.h
index 2621b9fb9b19..b888912c2450 100644
--- a/arch/arm/include/asm/traps.h
+++ b/arch/arm/include/asm/traps.h
@@ -40,7 +40,7 @@ asmlinkage void dump_backtrace_stm(u32 *stack, u32 instruction, const char *logl
 asmlinkage void do_undefinstr(struct pt_regs *regs);
 asmlinkage void handle_fiq_as_nmi(struct pt_regs *regs);
 asmlinkage void bad_mode(struct pt_regs *regs, int reason);
-asmlinkage int arm_syscall(int no, struct pt_regs *regs);
+int arm_syscall(int no, struct pt_regs *regs);
 asmlinkage void baddataabort(int code, unsigned long instr, struct pt_regs *regs);
 asmlinkage void __div0(void);
 asmlinkage void handle_bad_stack(struct pt_regs *regs);
diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
index 57aa1084a047..77801d039b5f 100644
--- a/arch/arm/kernel/entry-common.S
+++ b/arch/arm/kernel/entry-common.S
@@ -264,18 +264,10 @@ ENTRY(vector_swi)
 	mov	r0, tbl
 	/* r1 already contains regs */
 	mov	r2, scno			@ syscall number from r7
-	badr	r3, __ret_fast_syscall
-	bl 	invoke_syscall
-
-	/* Restore regs into r1 and lr after C call */
+	/* We return here no matter what, also pass this as an argument */
 	badr	lr, __ret_fast_syscall
-	add	r1, sp, #S_OFF
-
-2:	cmp	scno, #(__ARM_NR_BASE - __NR_SYSCALL_BASE)
-	eor	r0, scno, #__NR_SYSCALL_BASE	@ put OS number back
-	bcs	arm_syscall
-	mov	why, #0				@ no longer a real syscall
-	b	sys_ni_syscall			@ not private func
+	mov	r3, lr
+	b 	invoke_syscall
 
 #if defined(CONFIG_OABI_COMPAT) || !defined(CONFIG_AEABI)
 	/*
@@ -308,13 +300,8 @@ __sys_trace:
 	mov	r0, tbl
 	badr	r3, __sys_trace_return
 	bl	invoke_syscall_trace
-
-	/* Restore regs into r1 and lr after C call */
-	add	r1, sp, #S_R0 + S_OFF		@ pointer to regs
-	badr	lr, __sys_trace_return
-
-	cmp	scno, #-1			@ skip the syscall?
-	bne	2b
+	cmp	r0, #-1
+	bne	__sys_trace_return
 	add	sp, sp, #S_OFF			@ restore stack
 
 __sys_trace_return_nosave:
diff --git a/arch/arm/kernel/syscall.c b/arch/arm/kernel/syscall.c
index be193266299f..d1259c6d2805 100644
--- a/arch/arm/kernel/syscall.c
+++ b/arch/arm/kernel/syscall.c
@@ -11,16 +11,25 @@ __visible int invoke_syscall(void *table, struct pt_regs *regs, int scno, void *
 		/* Doing this with return makes sure the stack gets pop:ed */
 		return invoke_syscall_asm(table, regs, scno, retp);
 
-	return 0;
+	if (scno >= __ARM_NR_BASE)
+		return arm_syscall(scno, regs);
+
+	return sys_ni_syscall();
 }
 
 int invoke_syscall_trace_asm(void *table, struct pt_regs *regs, int scno, void *retp);
 
 __visible int invoke_syscall_trace(void *table, struct pt_regs *regs, int scno, void *retp)
 {
+	if (scno == -1)
+		return -1;
+
 	if (scno < NR_syscalls)
 		/* Doing this with return makes sure the stack gets pop:ed */
 		return invoke_syscall_trace_asm(table, regs, scno, retp);
 
-	return 0;
+	if (scno >= __ARM_NR_BASE)
+		return arm_syscall(scno, regs);
+
+	return sys_ni_syscall();
 }
diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
index 480e307501bb..42f6bb593eb4 100644
--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -606,7 +606,7 @@ do_cache_op(unsigned long start, unsigned long end, int flags)
  *  0x9f0000 - 0x9fffff are some more esoteric system calls
  */
 #define NR(x) ((__ARM_NR_##x) - __ARM_NR_BASE)
-asmlinkage int arm_syscall(int no, struct pt_regs *regs)
+int arm_syscall(int no, struct pt_regs *regs)
 {
 	if ((no >> 16) != (__ARM_NR_BASE>> 16))
 		return bad_syscall(no, regs);

-- 
2.46.2


