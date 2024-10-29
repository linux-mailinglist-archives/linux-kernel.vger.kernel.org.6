Return-Path: <linux-kernel+bounces-386765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 671AE9B47B2
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 12:03:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 239AD283DAC
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 11:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38B5120E33E;
	Tue, 29 Oct 2024 10:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rDzmJj8q"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD5A20E034
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 10:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730199217; cv=none; b=sa0vdOPd19Rh9/qi7g+odOOcMi8t1/d9a+Jmn5z8J0J1aU3UKHyxS7DGlCyVIRybAg3GbP7IpE2VYS9j81ZVQnzNpftI5X/kSojO7vEIO32yfa2z/ZASb4v6NrfI2MQAh0MOIm9VTN7fIXzZk5Wy7eIHcbn8ojm8BfOYWuU6pe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730199217; c=relaxed/simple;
	bh=1+xGn+I5zGJWUmASKFRl6SMQB/wIv78GqsCAwMsFqAA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Xh0zY+GoBlRTNu+I02qupVuFxZoX5igNqOl+e3uWY4b79hUDuNVI8b2N1PZ449wa89PLbtLfaFfEXgy20PIqByiSwKLpf+kwaIgarG3uHpMAZBoIYtlaDtthrstEpWUjDfpVE0ZjXQdZH9yJxp2Z6bqcQZj6AscOtxBlk1HTU5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rDzmJj8q; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-539f0f9ee49so5633413e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 03:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730199214; x=1730804014; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e/3IXPLtEzkdPxakYsKtSl6x7P98QonT1kDDJ6tUink=;
        b=rDzmJj8qs6GBlIeQ4AEb/W5rR3G6Usf1zycSEqnNmDafPcXaPXtCrO9dI6OBzAnw9E
         kXdgQNuKwZxos+uA+qVG2uLfoKhZF19CUif/Uv5WshpSelS5bXnvg3yC3Cn43HXC0DSM
         gKWsivB2ggeGKhhvEBnOGCpuVaBFafT0eerAmjjr05PyxXBIOS1L1ntAdOK6UDpbRooX
         KDEFieZRWbU7SavjQkhaKA5BG1vfWwY2JJHMl3uV1mfBWM3MSlUK4jwMGr+c5UK5mRqI
         qT0T2X3xn6Gy9uCiQTTNRXY6UL1veVvw7ZAgm23j1vS05m+vlcHas3xwrLCOdAxJ/+4c
         G4gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730199214; x=1730804014;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e/3IXPLtEzkdPxakYsKtSl6x7P98QonT1kDDJ6tUink=;
        b=sKXwQ0f+tq3vojb2hIZvuuPNI2XKjQJslyy4qd924/7XtlU66wfem5aweUDmtRp0dE
         nuQjn6oSM6kjrzRdfWUFN5nm+3P54/SbBbxiMfvHUWSb4mEgAFvX47KUvsC9eRKG/WRq
         hzG+5rT/RBDxWUdNToCC4bq1+NMwPhHULhcdyYKtgWlSNIVHKKj1gSaSb1OsDbMypvSz
         1ilMT4Wjy29Z7bMDylfV+QkmP6PJRm4mkEn1sTloUgrsKTOQLON1osQp613X2g1zphaV
         sz5SZ4QYI39aKGzJLK6ArDTg+3ZzD7tdh50Akd5QybOt+20xxSmlr72plQ2i8u7jpLL1
         OaOg==
X-Forwarded-Encrypted: i=1; AJvYcCW/+CUS6qU5cWvre1/2KEc86wvaDn6250tHYIY2W8d3QQkHWrQq3hPKU5lDZ0M//AA9x3B6jrCiNrRN0Mk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9oB9fkERgfDlfAplajYMlKY+vmOdL1smpnqFdZS873oSL5eOx
	P9ypKH85Gvaf82/NSGJGd+8GcM6za3tlkgtdEtpz8w4v95vFNbfBNyE2HW0GxWkbw9AZZmZi+Y4
	K
X-Google-Smtp-Source: AGHT+IEv5OXz88Rah8wOjpkuPKbULq5MyD1fSlWtEkl9G05R3LmA9cdfp5t7ybciPjtapRrrDr8Jpw==
X-Received: by 2002:a05:6512:3084:b0:539:fed8:321 with SMTP id 2adb3069b0e04-53b34a31cdbmr4939966e87.51.1730199213675;
        Tue, 29 Oct 2024 03:53:33 -0700 (PDT)
Received: from lino.lan ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53b2e12452fsm1351307e87.73.2024.10.29.03.53.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 03:53:32 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 29 Oct 2024 11:53:05 +0100
Subject: [PATCH RFC v2 25/28] ARM: entry: Create irqentry calls from kernel
 mode
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241029-arm-generic-entry-v2-25-573519abef38@linaro.org>
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
index 8b8cc9a1eefb..a78bc5054b09 100644
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
index bd468d58dc02..21b11fe199cb 100644
--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -204,6 +204,9 @@ ENDPROC(__und_invalid)
 	get_thread_info tsk
 	uaccess_entry tsk, r0, r1, r2, \uaccess
 
+	mov	r0, sp				@ 'regs'
+	bl	irqentry_enter_from_kernel_mode
+
 	.if \trace
 #ifdef CONFIG_TRACE_IRQFLAGS
 	bl	trace_hardirqs_off
diff --git a/arch/arm/kernel/entry-header.S b/arch/arm/kernel/entry-header.S
index 51c7f93c1ded..49a9c5cf6fd5 100644
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
index d7fdb9df3331..674b5adcec00 100644
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
2.46.2


