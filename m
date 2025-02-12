Return-Path: <linux-kernel+bounces-511028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 14EEBA324E9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 12:29:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B17017A4BDC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 11:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A88B215172;
	Wed, 12 Feb 2025 11:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iuJaTfSJ"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE38B212B06
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 11:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739359415; cv=none; b=rM16R64KlegnX/2VFi23p4ZTaCYrgfwZSram5Hib5qJtmUuVym/LVr93i5cirOEjqeeJdAay84ehy5z1lGSliHZzx5OjI1GEjX+C8R8lOjmvwa5s9zaGxxa+0C6ubI7CSI+OjCT2XTPD80LkewNHjadwij8CaPzXrn40y11ttzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739359415; c=relaxed/simple;
	bh=kbyT7iCijaIdZIkI/izvFYQDY/XRcdi53hyF8Dt7x5M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sd/lYL7I/UVforTdczNuMm19ebGg2NvpHNe3vJmZAnWJboh3mi4wp6a62ZELQqzEqf2n8UKekRtPabAFlA97Al+Y5J5MVQnW6M2Lq1QiJFSMJsb7PZyrZRW17/XRmVlkEKasw8PmBkEVh0ARjasn1Tl++S3NopAiuj7136uxTr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iuJaTfSJ; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-308dfea77e4so7896011fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 03:23:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739359412; x=1739964212; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NA+LzTmhZnGJ5F/6+si6C2L1JDWL6V8/wsE3A9CcZck=;
        b=iuJaTfSJbYbUuBTZyqRubHMMaItvnxaYroOuGOJ7BuXNudH9cTEH/J7AX3nKY2uwcT
         aGGTnAUFPlXTBUBzuY9LQWBFnagv/9WVttvJintq/xR6ta366sV1hSKZg5XEsH7MA6bl
         3+wLtmOx6CCQUMAuJS5r4DjHZpyYd/EjOv1xTvYlRFattTGYDEZdUsAktlFiKMY3tdH3
         ATwz4PveyXuXC4h/X/E8T9iuj7qRgBpsfWTGRSEl5jOnDiPcnnoJzKniDG6QNZwQEJRE
         7r07ZQZWaN+8fLmG+yU1xYZQVOiX2LLIy7DfJNWRy9pbIZxjcxWPdz7a9UHi0zd6VfKR
         62Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739359412; x=1739964212;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NA+LzTmhZnGJ5F/6+si6C2L1JDWL6V8/wsE3A9CcZck=;
        b=IlCl6FewlvM7Yr86q/MQE8XEFZ/M+UQsQ7LgpMxwUCK1qchJ0RNH4ckN213hKqdm0k
         6u92fTWeHSZGud1y2k7i7KlSjEgtNMvdc5rUNSSIKSXqBzC3FyBNIdBrVJXypYZlkvIj
         0Ff31IRaMabUkyYb968mQLBI4QVSBHunDoWc9PDslXp5Cn9Qcr3wsozuAzx1QqAw7gSW
         GGdi4hnDlWLVozgZ44tK2QyktuKDAR2ER07jvAKhoU6YuU0Qy47iCoxT1B7cdpiM1VTz
         9kjNbyhD5NfkaypJM7WS/CYSRk5pTF+BNpR1j1EwIYKf6jN7GyF1hX6In5N81CA1H1Ug
         eZZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWUARUVD3CeGXuXdV/UcPzcmcl/hjSC7jcqkXpmUHyRvvEfCtWgOuhGmEUBtgtkPQf7EM/n1sFcZhXjLZs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx2nSyZ2OPi10zq3OXrUfbtzp87kIkUiBhYeK1mEMzdbSMc8Z8
	TOE5kAOv+ovPoIMJMaxZOzIIXy/+CrKqDnV/CLHr6pYeKRLuGEhPdcycKI5XnN0=
X-Gm-Gg: ASbGncunL46Hj1/+1JMz1rxQCcdEfH2jAh5DnglmYDDOcBhkbXzVJGOQMkVp7YC1U/m
	U25dQryns0ryGWPivD7Izu7jH8axBJSlppgmQXVkE+Qt8f5ZUabszJgnmmew/F6Ufk8UcnYh8CL
	YQUZ+3ODoCID6+yFe+AeFromGY3eoOzvAzZ0EB83akvMuJe+LxHl+pO1xNRaGhKBgLj1g28q1fr
	F+09W7YoS2czMOCZhGctIFOoB5y3uwxj/BN876qA3J6w68GDo7DhPnyIjQrvbyqIMUCKLUCZ3qj
	LqUmKj21DfT1Wyb+FZKRsTSmlQ==
X-Google-Smtp-Source: AGHT+IEplwuuVF82kBeGhT/TWo/XqlzuKUbj10/w8fQqnJV4OOCk8n2PPTKgIfpGykjHMApLmTymWA==
X-Received: by 2002:a2e:be85:0:b0:300:182b:91a0 with SMTP id 38308e7fff4ca-309045927b9mr9380691fa.7.1739359411856;
        Wed, 12 Feb 2025 03:23:31 -0800 (PST)
Received: from [192.168.1.140] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-307de1a6531sm18310511fa.45.2025.02.12.03.23.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 03:23:31 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 12 Feb 2025 12:23:19 +0100
Subject: [PATCH v4 25/31] ARM: entry: Create irqentry calls from kernel
 mode
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250212-arm-generic-entry-v4-25-a457ff0a61d6@linaro.org>
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

This adds a few calls to C when exceptions enter/exit from
the kernel itself, so these can be used for generic entry.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/include/asm/entry.h   | 2 ++
 arch/arm/kernel/entry-armv.S   | 3 +++
 arch/arm/kernel/entry-header.S | 5 +++++
 arch/arm/kernel/entry.c        | 8 ++++++++
 4 files changed, 18 insertions(+)

diff --git a/arch/arm/include/asm/entry.h b/arch/arm/include/asm/entry.h
index 8b8cc9a1eefbd00dd75d4e344576fc184a413768..a78bc5054b093120e903f08369fb8b1a9feb7f81 100644
--- a/arch/arm/include/asm/entry.h
+++ b/arch/arm/include/asm/entry.h
@@ -12,5 +12,7 @@ long syscall_enter_from_user_mode(struct pt_regs *regs, long);
 void syscall_exit_to_user_mode(struct pt_regs *regs);
 void irqentry_enter_from_user_mode(struct pt_regs *regs);
 void irqentry_exit_to_user_mode(struct pt_regs *regs);
+void irqentry_enter_from_kernel_mode(struct pt_regs *regs);
+void irqentry_exit_to_kernel_mode(struct pt_regs *regs);
 
 #endif /* __ASM_ENTRY_H__ */
diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
index 3cd5a80b47758867d1db6c3971030370bca1551a..f64c4cc8beda6bcd469e6ff1a1f337d52dbbaf9c 100644
--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -205,6 +205,9 @@ ENDPROC(__und_invalid)
 	get_thread_info tsk
 	uaccess_entry tsk, r0, r1, r2, \uaccess
 
+	mov	r0, sp				@ 'regs'
+	bl	irqentry_enter_from_kernel_mode
+
 	.if \trace
 #ifdef CONFIG_TRACE_IRQFLAGS
 	bl	trace_hardirqs_off
diff --git a/arch/arm/kernel/entry-header.S b/arch/arm/kernel/entry-header.S
index 51c7f93c1ded1db56f173c7aaed8094ef011ff5a..49a9c5cf6fd5fbb917f2ada6c0d6cc400b7d3fb3 100644
--- a/arch/arm/kernel/entry-header.S
+++ b/arch/arm/kernel/entry-header.S
@@ -210,6 +210,7 @@
 	.else
 	@ IRQs off again before pulling preserved data off the stack
 	disable_irq_notrace
+
 #ifdef CONFIG_TRACE_IRQFLAGS
 	tst	\rpsr, #PSR_I_BIT
 	bleq	trace_hardirqs_on
@@ -217,6 +218,10 @@
 	blne	trace_hardirqs_off
 #endif
 	.endif
+
+	mov	r0, sp				@ 'regs'
+	bl	irqentry_exit_to_kernel_mode
+
 	uaccess_exit tsk, r0, r1
 
 #ifndef CONFIG_THUMB2_KERNEL
diff --git a/arch/arm/kernel/entry.c b/arch/arm/kernel/entry.c
index d7fdb9df33312dd2a914b59512b701748f33b597..674b5adcec0001b7d075d6936bfb4e318cb7ce74 100644
--- a/arch/arm/kernel/entry.c
+++ b/arch/arm/kernel/entry.c
@@ -56,3 +56,11 @@ noinstr void irqentry_exit_to_user_mode(struct pt_regs *regs)
 	/* This context tracking call has inverse naming */
 	user_enter_callable();
 }
+
+noinstr void irqentry_enter_from_kernel_mode(struct pt_regs *regs)
+{
+}
+
+noinstr void irqentry_exit_to_kernel_mode(struct pt_regs *regs)
+{
+}

-- 
2.48.1


