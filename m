Return-Path: <linux-kernel+bounces-511009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37034A324BF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 12:24:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1A59165F05
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 11:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A74820E00D;
	Wed, 12 Feb 2025 11:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KdgSokIc"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7032E20A5C4
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 11:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739359398; cv=none; b=eOv8aKZPQvzGIKUJdSTb+VZchGIxh7VkuQsvZwUqQJlUpha5Oc7v9x41Br5pjduRuTV6HzgksguM9dnyWDJBBzkKhrd/8IuItuNAZCbz2JJWGj7PxTAqpQ7hMWcI+mfeTmTy4FsRElbzCmGo0Mv+IQEYBDLA1CDeOs+1W2vg0q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739359398; c=relaxed/simple;
	bh=hXVFyo95Fd8AEwhm82LpDlV5OS0uorB3k4MP3pL+pwA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iOe8aW8bxUcKJrKcCrRfDCam8Hp0Zu8F7kqbChLP63ibAFLwQUOjs9c/XFhynrzXgo31qpyykPK0+1im8W6ZokHZPR7v/ZSZsP93QyYx3m3sLkcZnS+fhZ9rjrhhrNkmDwhXkDHOtZsWHqP61vx3ikirKv6zkxSNoJpAHdu0LQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KdgSokIc; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-309025ec288so10966911fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 03:23:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739359393; x=1739964193; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yplTGeg8q5Jb1IHX+lZzUxdHnSw+Ki6MseFOXEsgMb4=;
        b=KdgSokIcHhP4P5KC+RsZQFxFbEqxbpxB9+QxGaC4/7BRUnSCri6S6XIom3+dlma7Ao
         wPE3kRyO6n2ORgipzV1hXFc1xo6dNJTmKM2m0IyWnf8vlxqgkq7Hza46gE4Pd0LvsHcC
         AtWjq/BeYCQNpaZV1ynKuBffEvW27kKdG7RimjpaiWQmqfYo8dzkb7XtjqvscTZz7Z5J
         3IaKtI6Gtqtl+hxFBHZRwuwxiE3OpvQ1buM+Zi/3t5YYP8spi76C7XEMFLsIj58OznEY
         4N5UpCixUalSp1XhCyxZBEB6mZGRUrtLaIrf64KnAzIuheHpbRK4L82j9/n0aDKfkqXF
         TC9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739359393; x=1739964193;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yplTGeg8q5Jb1IHX+lZzUxdHnSw+Ki6MseFOXEsgMb4=;
        b=jsWrtZIdr/wwjbArRJf1UtGd8ADQ0QsO5KbEu8uCLbvKOSCTxd9bEWtEp4S769SyAi
         UE31eTjTh672OXOQLneFQFm41KUz6I1YOrjOGyuHiIySGZzlOqii7n6Chq8YFZahArn/
         FP9id5MduQ13jFSyT5LaBgCAytT36aB9Ch3sfbS/5UvkSJmkMfEu3pmzI681gn+p+Ezf
         V8kksfz/9VryGg8vt4I2AA8ISQBx7hKos9Ba4NnF0kulHu3ZpE/jLDzq+mp4ugNfodhQ
         Dw0wMFrnSVAAPtcSC+vZFAKvAqZSDZhj/c4bMo5UYredw4KhstB6ex1aMz1JMFvibQIj
         eQZg==
X-Forwarded-Encrypted: i=1; AJvYcCWKR+kLAoKbDFTYffzfZix1R2GLP6h6PFH4ukzUr24d54+RV+6lCmNkAtkSVU5IOitoCmi3ujvt0kACRc4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2dVJ/XJoQ+J75uy16u+fvH8ViDAljPjMgDScXSLdT0qNa5GAw
	OkT1mQKaQ6oTEqiSodaaehphfl3N3icKrOIH3v2qe1+fH6VEuNrWvVDMLjWFTWU=
X-Gm-Gg: ASbGncsllI1AK1d4Jl/i2YBOJ2r65TomFkcK3Fx4mmof3ERcZ0kRZsRSbJwZ6WxaCzg
	FAnBbWdKxmg0r+Ko5cyupTWdDu0a+BQbzLMCx0FFsnPlDxwLyVms4RKXx+nnw4uzhWJKqB4n0bg
	3lPxc85ULs4S8bktaNCiZcP2YHP4/046CBRO/gBunJE4oNUqXE3dmW/dmUTbtb5d//F4F6FwfId
	4L/GT3kak5AFZPYNB+/lEENvEv97Y4E59ZXMQVuNyAnufkbP36Ap1Joza1Fzz2oBzOyuRvsWDOR
	TvYdr9fPz+mxZ6e/ZnY0aAkjkQ==
X-Google-Smtp-Source: AGHT+IEaYca91uWTU7cyiSHpPYPrfctGa1tgN1r2xzyJA7Zpo1TE5CUGZf48fi1/xqnUPpwUa4Slpw==
X-Received: by 2002:a2e:2206:0:b0:308:eb34:101e with SMTP id 38308e7fff4ca-30903911e32mr7352541fa.29.1739359393267;
        Wed, 12 Feb 2025 03:23:13 -0800 (PST)
Received: from [192.168.1.140] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-307de1a6531sm18310511fa.45.2025.02.12.03.23.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 03:23:12 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 12 Feb 2025 12:23:01 +0100
Subject: [PATCH v4 07/31] ARM: entry: Rewrite two asm calls in C
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250212-arm-generic-entry-v4-7-a457ff0a61d6@linaro.org>
References: <20250212-arm-generic-entry-v4-0-a457ff0a61d6@linaro.org>
In-Reply-To: <20250212-arm-generic-entry-v4-0-a457ff0a61d6@linaro.org>
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
index 2621b9fb9b19b064aa40a8ab4a3a89067b98a010..b888912c2450e0e8eec8139166c7292f283545c7 100644
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
index 57aa1084a0476e9c218cd100ce4fdf4aaa748234..77801d039b5f6562b231a6fd4979e318c7e736a6 100644
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
index edc0ac88ec60ce3f23149a526de7dc1205906552..d637dc74b1c70415933898fbcadbedc71df5f654 100644
--- a/arch/arm/kernel/syscall.c
+++ b/arch/arm/kernel/syscall.c
@@ -12,7 +12,10 @@ __visible int invoke_syscall(void *table, struct pt_regs *regs, int scno, void *
 		/* Doing this with return makes sure the stack gets pop:ed */
 		return invoke_syscall_asm(table, regs, scno, retp);
 
-	return 0;
+	if (scno >= __ARM_NR_BASE)
+		return arm_syscall(scno, regs);
+
+	return sys_ni_syscall();
 }
 
 int invoke_syscall_trace_asm(void *table, struct pt_regs *regs, int scno, void *retp);
@@ -20,9 +23,15 @@ __ADDRESSABLE(invoke_syscall_trace_asm);
 
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
index 6ea645939573fb65ed36f5435a9c94e98828f45b..942c77767919466d5b89d83d8eb77032b119473e 100644
--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -609,7 +609,7 @@ do_cache_op(unsigned long start, unsigned long end, int flags)
  *  0x9f0000 - 0x9fffff are some more esoteric system calls
  */
 #define NR(x) ((__ARM_NR_##x) - __ARM_NR_BASE)
-asmlinkage int arm_syscall(int no, struct pt_regs *regs)
+int arm_syscall(int no, struct pt_regs *regs)
 {
 	if ((no >> 16) != (__ARM_NR_BASE>> 16))
 		return bad_syscall(no, regs);

-- 
2.48.1


