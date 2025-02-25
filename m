Return-Path: <linux-kernel+bounces-530964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53CCAA43A83
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 11:01:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 586B8167D3C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 09:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85A7726561A;
	Tue, 25 Feb 2025 09:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wAF6d2MJ"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485B8268FD6
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 09:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740477329; cv=none; b=iOho0we52ryTmEhHJ+Vutn6mSZzXkw8saNhe6FVvo6lxj+TqVxrLOO5k7r7Tjp1Bzab0x28Qpcqpx8UhCaE9QqJFXq8bVP6Zw3HoFlAjSUHChNtkD/AA1ydehnhI0rkW0QdSXyWIo6iO4KKkDXObKKmJVrRvCS9T6DxOKR3gDOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740477329; c=relaxed/simple;
	bh=mJo/s1lXwqzSj2v+NNK3w6LLVHD5ckMvXtVwbrlja0Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mkcpzMz+GALf7GcYLpm+DuV2XbHUbQJmYWw4Wd1uAuVDZ9PwD/lzn+4ujivBMtb7JOMsH10DPJKWbg3Fh2AODhJuAgUPOCn3G32VKggvVWBeYnz1MnwiO/BXJCEDNNd2XS2o8+pLs4d/DhDD6ytqmlc/FoWr4EDoPs+vKGE7j6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wAF6d2MJ; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-548430564d9so3040173e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 01:55:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740477326; x=1741082126; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XZE98juq0oGv0Xstj1U7TzgmKhYjLwozMlzxeXVPHlA=;
        b=wAF6d2MJ/b2GpKYv/lgbm1yiCD4f+6F0L6tTelnoOrL7inXT4tv2k/5vpdsFBcFH+P
         WtJ+xoLlWhdRao4on+rWPnCOQ64aV8L1fPRgCCAEgYZ8HJPJm/3mRFNZrlfeVwamu4wQ
         lFQR05FRjvNFiflYAnUKx7r29aiQfEWJBA5Gy+LayMguEnFVQOUGFnn2Iphrt1NGcTlt
         Q4M0x++KwNn4Xrstbm+EAKisyDgMQUEnKY6V2zR7mlUOFIA/CyQ7aCz1Al1taLzNoYJw
         gyKYcPoNQ6mEmTY8MXSQqquXINI3hT5hxLGGxR7tDKE6g/M3AtQEZ3Xv0Y38sEOQoCHX
         t0xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740477326; x=1741082126;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XZE98juq0oGv0Xstj1U7TzgmKhYjLwozMlzxeXVPHlA=;
        b=lusGceZeJj8f1QZiTkca9wZ45v8LcSJZdze8ceDe2PSy0jSLiFnul+db/VrW8W8HwJ
         EUgO/M3paRhfBGUMCy2tWuwDDqBQROq/63mAf+eTPgPYAADhDs3d9syMJQWkeF1CWGVh
         v47AZohs0lcBk91O5nqDyiFeY09B3rvQ4neOlnlmqqTBrsWkQxL/0qnf7FzETdfyR31G
         w9foFz2vTfxdxIy8CIVtMnMJ5GlfCaaOLiJBRJOOpWcFLPjCJa3Fel/gtb1QCZddEeNk
         tG7dYJL3cPVCbdDWtIZAb33l5BK2L4xrirARwnbdK/sH4lKRoztbzxfC5JMZbUKpIi9T
         QljA==
X-Forwarded-Encrypted: i=1; AJvYcCULjocvrn9Gjq9A1QgjEma2AQUAjR/kTuUBjNl09lYkzCbxW9ITQFhfwf317cjpDkXrGoS3V+kYKLFVDvk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWGQEhY9d2BS43ShP018xoH1DmSwzEE/e7gNttmCxHqcgzch/F
	jttY3aDGgMrmPN2gRbMSytQW+ODJl2B0k0W//gL0F4GVE2C+xMsmZhyEahSQovE=
X-Gm-Gg: ASbGnctZ/GV+UbHbY0wUfuEPLg01j5Lzw/hElR52gYZEyTQnLMdVfq2I0sod5ygTuV6
	vSATNwe344FpE91SiD3LQY3uYLeFF3KftxuA7D1a2d/6VBSINev4lYcOd+bTMcQBF9xuMLJ48cD
	+CUUOWp0fvFIW0ERBCS2dFKSk3RyRjaOsxUN5JXs+O6ilHfa4DAWvDaJj/xzUFaj+4QDNp+azqL
	tEKqpHhbJFrc1EyyaPTW7atWStZW7jsJ4cmjEgaeZhHXFtbyqtpuqHsydT4xiLv/zCYrKaH/0jg
	tA2MBpaBPUaWZR/TFoUDPbB54TwbX3tqNOY9
X-Google-Smtp-Source: AGHT+IHv2LyiSeosodUrcS8c6R5xpQiyNyga8e1Qfb63OSq/UTKN+o0/2yMM03TOk0Z2Siw/VpkP2Q==
X-Received: by 2002:a05:6512:3b4:b0:548:d4e0:82bd with SMTP id 2adb3069b0e04-548d4e08399mr321337e87.17.1740477326469;
        Tue, 25 Feb 2025 01:55:26 -0800 (PST)
Received: from [192.168.1.140] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-548514b261esm132867e87.24.2025.02.25.01.55.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 01:55:25 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 25 Feb 2025 10:55:10 +0100
Subject: [PATCH v5 23/31] ARM: entry: Stop exiting syscalls like IRQs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250225-arm-generic-entry-v5-23-2f02313653e5@linaro.org>
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

The syscalls are issued as software interrupts, and to this point
they were sharing code with the other exception handlers, but
this does not work with generic entry.

Make syscall_exit_to_user_mode do what irqentry_exit_to_user_mode
does at it's tail, and drop the invocations of
irqentry_exit_to_user_mode from the syscall path so that these
are now exception-exclusive.

Split ret_to_user and ret_to_user_from_irq into two distinct
execution paths.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/kernel/entry-common.S | 14 ++++++++++++--
 arch/arm/kernel/entry.c        |  4 ++++
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
index 5385574c4339714f3d8b5ab6894f27466b89f932..e2ac6d3216b6828d948d60c424ff95ccdad12331 100644
--- a/arch/arm/kernel/entry-common.S
+++ b/arch/arm/kernel/entry-common.S
@@ -42,7 +42,6 @@ ret_fast_syscall:
 	/* do_rseq_syscall needs interrupts enabled. */
 	mov	r0, sp				@ 'regs'
 	bl	syscall_exit_to_user_mode
-	asm_irqentry_exit_to_user_mode
 
 #ifdef CONFIG_GCC_PLUGIN_STACKLEAK
 	bl	stackleak_erase_on_task_stack
@@ -62,6 +61,18 @@ ENTRY(ret_to_user)
 	enable_irq_notrace			@ enable interrupts
 	mov	r0, sp				@ 'regs'
 	bl	syscall_exit_to_user_mode
+	ldr	r1, [tsk, #TI_FLAGS]
+	movs	r1, r1, lsl #16
+	beq	1f
+	mov	r0, sp				@ 'regs'
+	bl	do_work_pending
+1:
+#ifdef CONFIG_GCC_PLUGIN_STACKLEAK
+	bl	stackleak_erase_on_task_stack
+#endif
+	restore_user_regs
+ENDPROC(ret_to_user)
+
 ENTRY(ret_to_user_from_irq)
 	ldr	r1, [tsk, #TI_FLAGS]
 	movs	r1, r1, lsl #16
@@ -76,7 +87,6 @@ no_work_pending:
 #endif
 	restore_user_regs
 ENDPROC(ret_to_user_from_irq)
-ENDPROC(ret_to_user)
 
 /*
  * This is how we return from a fork.
diff --git a/arch/arm/kernel/entry.c b/arch/arm/kernel/entry.c
index 0e3960844b94b14325eb00ce7dd791b36c43ac3c..88a7a699306ab61153d57333c26266b9161f5466 100644
--- a/arch/arm/kernel/entry.c
+++ b/arch/arm/kernel/entry.c
@@ -30,6 +30,10 @@ void syscall_exit_to_user_mode(struct pt_regs *regs)
 	local_irq_disable();
 	if (has_syscall_work(flags))
 		do_work_pending(regs, flags);
+
+	trace_hardirqs_on();
+	/* This context tracking call has inverse naming */
+	user_enter_callable();
 }
 
 noinstr void irqentry_enter_from_user_mode(struct pt_regs *regs)

-- 
2.48.1


