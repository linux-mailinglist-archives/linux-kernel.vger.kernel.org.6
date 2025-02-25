Return-Path: <linux-kernel+bounces-530966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 583F2A43A7A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 11:00:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44D9B18866FB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 09:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01106269839;
	Tue, 25 Feb 2025 09:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hysZryTy"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8654B2690E3
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 09:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740477332; cv=none; b=G0Fgu/EwdLVuUZeTgtXyBvR/hy+6b2DChexTZ0qvtgf39Fa96K9PX0wwfuucOzQzl1qEKyPYdgh+axix/7dLBDjgTJ6efLQETPTJbR6vOEGVQqKXhtHfhYKN5g+zn2tXzGDrNPlLu0qNUezv6hxekv1hIjqfIhQgRiifk56zA7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740477332; c=relaxed/simple;
	bh=kbyT7iCijaIdZIkI/izvFYQDY/XRcdi53hyF8Dt7x5M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Kxkw2yLJsYshtdEoRoluGefnl6pTUE27/7SW6use4Z1OPI5RwgT/PryCAeBOysJVC1Ui0qnZPv2wGoSLQ0scaVKlJmiyhfsQ/9Er7cv2iER5nYkRfPwS1AhBE//i8jJilGHVUOLDa08U74j4XFIT5Suvx7HiSA9dTywSO3f2HMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hysZryTy; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-54622e97753so4948806e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 01:55:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740477329; x=1741082129; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NA+LzTmhZnGJ5F/6+si6C2L1JDWL6V8/wsE3A9CcZck=;
        b=hysZryTy6wY3YUkps7Iqn5G+VKRI5sIVNim4b8XuYuV3An0VLR/NF9rCbjpHCwLaCM
         oqYaCo4NoxvO4vuNMJMbfhlhpiaNvsme/uNfjViHQnF4v0K18Fc5FwyiyvtQEKYiYaDZ
         +rSZn7QTtpHsFKy5J8yaIduwq7w5NG6XWAiIaSTZ2sDPVlVCSfTE2Fe31e3ENGpMFSYK
         qKxtzZxnvEx1EpPEExMG86V19tm/uE555byCPe0IoRFeHQr1GOZdE7v9/IMVHvMdPal4
         abVn3C0uBt9U42rOopC4qJKPtHUwywqoxg3s/1n/BbDS64KVGN0DMPZkOd/k/NcPZMB1
         mBow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740477329; x=1741082129;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NA+LzTmhZnGJ5F/6+si6C2L1JDWL6V8/wsE3A9CcZck=;
        b=PpEQrn1r6Dq+z0GyEm+1uiLPS5vaJBRlAUA8GAEkjZZKhmVJ3sUELIgyUBIkpOqQmC
         aoy8XBKgRs05yENBrjL+QS4GLDrtANFmzQmOHiCvm1/l//KHu/vWjRsT9vbV/uIUmpVQ
         kATfK5/EL9VeTk6HLdi+meAsRun3+9OQUSep9Mi6CLLyZ+li66WfaNXbRbANcyzDMemk
         kR7KRsQNsnq1+HDfXtPhlhgvAKxn21mFcFyusOxwFjp4p7ypCrZcFLe7UdoTJz3XZKqb
         eBTuGZpi0Mqk1tgoURnzJRnj87LkyT2L16esoUyAneSbS9RD8FgKh0HDAohx5Qhf1nEO
         IcCg==
X-Forwarded-Encrypted: i=1; AJvYcCXWJ//72KOWPLVtlp4FvQHNfpRAGr0zTWUy0CUtFT6EarAfTBn2Uh/NvlEbghJb8LbYu6IX2PsOLZwOkWM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdnmzkDJVpvmtU/Bqx1qMaZCq6aVSgebeCu56dhe1eIRKwcFkx
	ue3d49MdBbdU0EeSy/MISxNKWC2vNBG25mKtgoQAHTTNZRL38LX7dXywqEjzCfI=
X-Gm-Gg: ASbGncsfA29l7SzAsTevd1QbA5yj/hnjE5VuWDg7IwolohoBCScFzyw0ueNB5YrAl3j
	SKpxswAeQlXJEu38y85aRvjxBqlsGtLjkQHOybFZSzQkPEidLHZX9tyJOENXXp9Gl2iFHCRJLlH
	dC+Qg0T1UT67J0MHL3OxJGZiAAvpLiQsG5XYv8NnbNH5PwRfMNMWQi6/Co02Jg1wksLEZFxetB+
	rD9NhjvLZhrqO3XRAxN8jhKhH2sKvcPiDQZVcTPWPKXIh4/Qd1XueCTabD7s9w/xRp0Ty/XVxnU
	lJy3h2YWqd+Au93m9whsvn2WwAF3/if+jmby
X-Google-Smtp-Source: AGHT+IHoExRUiD3Ptt8xtogX36HpctNeFu9+M3wDkC7ot0V3ilLsDYUXt+l8IOflXZFx+RQVrnavqw==
X-Received: by 2002:a05:6512:6c5:b0:546:2ff7:530d with SMTP id 2adb3069b0e04-546e5f76a64mr6495854e87.25.1740477328590;
        Tue, 25 Feb 2025 01:55:28 -0800 (PST)
Received: from [192.168.1.140] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-548514b261esm132867e87.24.2025.02.25.01.55.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 01:55:28 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 25 Feb 2025 10:55:12 +0100
Subject: [PATCH v5 25/31] ARM: entry: Create irqentry calls from kernel
 mode
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250225-arm-generic-entry-v5-25-2f02313653e5@linaro.org>
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


