Return-Path: <linux-kernel+bounces-530949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADD98A43A72
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 10:58:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3F2216B7D7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 09:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C53EC2676D8;
	Tue, 25 Feb 2025 09:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EVlGLEay"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE41266F17
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 09:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740477312; cv=none; b=b2MFwg/YrQev0yPxewlSEKIi1S6+JSwbpJyW8WAyeF8Gqi0IcXLPAdddae/i9N4y1fC1mBLix3kOXvOjjuF0fTGCYQUwPD3FN7me8CTDgOPXerDINXUonHT1sZamFqQGEX3pMSeGoaJSsifM9e2bbMkYtMfHNcEdacN8cZqT42E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740477312; c=relaxed/simple;
	bh=KmFYy+Sl51pEEMIL+kYoz/kzGL3OpkwJKZPPkPqW0zo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BI2U08yG2jdl1LI9ZbnWa+DUtruKLQ3LXyEcLFpCSf9X9Lq5cp6xR0EsfLr2le0nJAzROGFaz3neqAwNJyCrlI58xu+WJkyjkJmEwFBcCK8ymfko498Tf8CnpV99azfaq2svRr+gt1pOaJHDKwFlqdKKEG7jgNqXgDrAJ/FKoyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EVlGLEay; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5461dab4bfdso6457137e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 01:55:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740477308; x=1741082108; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gCv9qyhC7Wn0x41/PmaNXNh/X9H9ffqS+9z2MGX0UwA=;
        b=EVlGLEayvMgKWsWFKu399emywj/RVV7D8qPrSBtyEvk6o1P8jxeUnapO43/MgYzv/3
         E4yk+6Eqswb+v4sp94CKCTEdNFkSgTwchqXYFck+uAoxJ9vgOtbz3/+NdyFpPCp1GVDK
         QQzwiflWVMrKOzcbG6Dl1oisCM646lRwtfqm8cDFrjziSXRzrbC8JH+fkdOB707Zz25m
         9/J9l8LpdtraRlDE2LAsvRaYjees/jxg3aAozSY8anOMQ2SYDMgPivq0yCRCKnfekvTt
         JU6/3GRMID8JZB5gPYaVfTyfTH4NiYic6OxGrlBMnPs9usU6f1wdP7Fr2MpSmIIZ8d4Y
         YYcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740477308; x=1741082108;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gCv9qyhC7Wn0x41/PmaNXNh/X9H9ffqS+9z2MGX0UwA=;
        b=Utlof5EYvgyp/tw8JfjQ2xdpFO1jqLdgnVFtfPoVDA40/JIh/xWx2FTRVlviWDIZOj
         AOBsKThMBdy9SP42341qe5YAbuA93UdEoR36s6leVok52Mhh/TTaCD98NJLDkBUPXtPX
         wIHiKM2zX7mWTuyswuJMb0I0hvYH+CSelkJA2Z/xMg7u0Wv/DLKGqVLbmN+Xfvgwj2m3
         1buChY40QrOvTVK3BitSRr5PTVWQTNTey9gbsxXfcty0hIoIsWxHmt+lcUxIlP+k2PYR
         8k+eBI7a2wjHRJje8i/r9uVlCQEuV4oBxlzK3nFy7Vn7W80a/AvT8SO+llwGW+5E3hpW
         2uVA==
X-Forwarded-Encrypted: i=1; AJvYcCV5ndYr8TnOlQQBM+TvyI628hw1hEqOEMWM4Bdx7MaJOkG+Tu/WAyoFPviApFJfZ2gvYNsv/QgykF+D470=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOmHFgoQzWExySBAA9GT6UM7JIC1/8sY4LkOEczc4kY0AnY7JI
	urvYrtKB6NRn0+0SavjTM/VIfS9SgPgfY7iCDH1jcXh0AIdC0Ld62hlPel7uvD0=
X-Gm-Gg: ASbGnctR+LX2PJoFiQef2r+ywi283B5DzRRhcuLhnsk6XtYkzcnMx32c/2lPIRAYt9v
	DcsNxfZ7uBgodNBVAp8drvGEYMtSpHYA3HrxzIKeVRWrLaNu8bDpCPVxWzqRHLfuod71iNU4wpx
	u3ho1oWwisxdkStOfk94BZCP3cuBPSztt63I73A3JWJJe/2aA7ABPlsh4anyRe11pjBWZ9x3Ybk
	QWlNQCpZ0/G5PsHdRJaHTGbVXjPd0x8T62bXz56mY9IV4c165zCWBqhIlCil8Avjn0ay5w02e0j
	u5px/r5fS/xcotUjC/6VH2zjoZkfMkjKb3eP
X-Google-Smtp-Source: AGHT+IH/i15/+svDVlzRmeCj49N+7fLYS0nSEMx6zNrdg8fMuOZRZIVmoIl+m7ZLFVdJmllqsHEC6Q==
X-Received: by 2002:a05:6512:3049:b0:545:3031:b4d7 with SMTP id 2adb3069b0e04-54838edda6fmr5696766e87.6.1740477308397;
        Tue, 25 Feb 2025 01:55:08 -0800 (PST)
Received: from [192.168.1.140] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-548514b261esm132867e87.24.2025.02.25.01.55.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 01:55:07 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 25 Feb 2025 10:54:55 +0100
Subject: [PATCH v5 08/31] ARM: entry: Move trace entry to C function
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250225-arm-generic-entry-v5-8-2f02313653e5@linaro.org>
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

This moves over the code entering into tracing into the
C syscall invocation code. As syscall_trace_enter() will
provide the current syscall number from the regs we need
not provide the syscall number to the invocation function
any more.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/include/asm/syscall.h | 2 +-
 arch/arm/kernel/entry-common.S | 6 +-----
 arch/arm/kernel/syscall.c      | 5 ++++-
 3 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/arm/include/asm/syscall.h b/arch/arm/include/asm/syscall.h
index 1d21f26ecf510ac00a878b4d51a5753ee49475f5..66067d165ba3fbbe0f840a89ae396eb1a311bacc 100644
--- a/arch/arm/include/asm/syscall.h
+++ b/arch/arm/include/asm/syscall.h
@@ -20,7 +20,7 @@
 extern const unsigned long sys_call_table[];
 
 int invoke_syscall(void *table, struct pt_regs *regs, int scno, void *retp);
-int invoke_syscall_trace(void *table, struct pt_regs *regs, int scno, void *retp);
+int invoke_syscall_trace(void *table, struct pt_regs *regs, void *retp);
 
 static inline int syscall_get_nr(struct task_struct *task,
 				 struct pt_regs *regs)
diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
index 77801d039b5f6562b231a6fd4979e318c7e736a6..3cfc6d952ff99be9c4c1be4481ac3039260e3e57 100644
--- a/arch/arm/kernel/entry-common.S
+++ b/arch/arm/kernel/entry-common.S
@@ -292,13 +292,9 @@ ENDPROC(vector_swi)
 	 * context switches, and waiting for our parent to respond.
 	 */
 __sys_trace:
-	add	r0, sp, #S_OFF
-	bl	syscall_trace_enter
-	mov	scno, r0
-	mov	r2, r0				@ scno into r2
 	add	r1, sp, #S_R0 + S_OFF		@ pointer to regs
 	mov	r0, tbl
-	badr	r3, __sys_trace_return
+	badr	r2, __sys_trace_return
 	bl	invoke_syscall_trace
 	cmp	r0, #-1
 	bne	__sys_trace_return
diff --git a/arch/arm/kernel/syscall.c b/arch/arm/kernel/syscall.c
index d637dc74b1c70415933898fbcadbedc71df5f654..377e16c8c53c8e809e3f8b157a889ef115d5c043 100644
--- a/arch/arm/kernel/syscall.c
+++ b/arch/arm/kernel/syscall.c
@@ -21,8 +21,11 @@ __visible int invoke_syscall(void *table, struct pt_regs *regs, int scno, void *
 int invoke_syscall_trace_asm(void *table, struct pt_regs *regs, int scno, void *retp);
 __ADDRESSABLE(invoke_syscall_trace_asm);
 
-__visible int invoke_syscall_trace(void *table, struct pt_regs *regs, int scno, void *retp)
+__visible int invoke_syscall_trace(void *table, struct pt_regs *regs, void *retp)
 {
+	int scno;
+
+	scno = syscall_trace_enter(regs);
 	if (scno == -1)
 		return -1;
 

-- 
2.48.1


