Return-Path: <linux-kernel+bounces-511011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 557E8A324C1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 12:24:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB6BC18820BC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 11:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A08B20E02A;
	Wed, 12 Feb 2025 11:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zbUVtbiS"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5E420CCED
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 11:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739359399; cv=none; b=tcrdE/ZCTvoHQMoBqlEyDA37hZoC+yYGx1X3FGiOpJsA5kKOE1mGKMetA/XK0Us0SjqT0Y6NVmOkRg70yi2MobpEBB9c5rmMIQbgVetaBPj28+5jSAp8fpQXot57OZmn5hld2H5H48vwBnUgCFO7a+IeMlzl/2NM8CohEA8kXzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739359399; c=relaxed/simple;
	bh=KmFYy+Sl51pEEMIL+kYoz/kzGL3OpkwJKZPPkPqW0zo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Sl5qxnZ1/xxkTXL6yZR3McJYf3OE6zo3qLQ2HJJPT3VIMG94tntpO6i7puj3Lzyk9GvcJ1V62VN7uYycBPlzOAghGFjE0FFeCAibPcs8PkRLmIFLsXQ5WN3zDAvwhto6ycU0hha1xlx+4O2uBtHlgqEZ+O5vgTqKTxWxC3ByNww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zbUVtbiS; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-3061513d353so66093751fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 03:23:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739359394; x=1739964194; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gCv9qyhC7Wn0x41/PmaNXNh/X9H9ffqS+9z2MGX0UwA=;
        b=zbUVtbiS63eYORakHD1Na8q1DFvktX+A0g+cKB8/BMua0YC56neAhHTB1DdOeLkotQ
         T7ClIkilNsBkGzn6vfRc8ssTUQ3I3JPwi6XmsOtrYt/AogtivL6URHzK1FQSN+DSYvlm
         xjF1yktTf9X7I3n3mxE2fR6lv1278IdXQLvt7AGr4+7wjztDYR24U728mgwoO1XND6i8
         Tn1e04qHQf34+ZIQ+RsLM9BgrQHUgNue4php3qBDhsszLCg2lcCRXOkU41g7kW6HkIgf
         ypLokbUPTRDGTMdAo0T0jf2E8JKP23k4uRjrcpjFki/L2kyqdPw+OCkT5DMiX6dWSQBh
         R8ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739359394; x=1739964194;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gCv9qyhC7Wn0x41/PmaNXNh/X9H9ffqS+9z2MGX0UwA=;
        b=wGhzUOpwPz3HV6IqimpRXFIW1Iv+fMDu/fftQGMFi1Ql1RqjeQUtoWoVTJ3K6apAM/
         qMxF3cu53j9T67f5OEXZC1ciSokb/D9ztGO0Pxwnk6728MV6Qw8USymnvA/SyfVOfJ5o
         hW+/kzNBmDS354T6f4VwDnWRC6mu7vbTCISaU86q6HyfuDA+ziCb+SeoHKW+2UFD+Zri
         n+LU5eZrE/H6ttnskNlyfdmCbK1Oon1V7NN0imIPK5S2opJZc7qfCCrGIazUdWM45Ivd
         bWcNBTkoLCEENaZ7cNd6p6syxzoH44gZRyKLZeipn3WyCZJMuYfTpFYydZ+DqQKbOzrL
         1D3g==
X-Forwarded-Encrypted: i=1; AJvYcCUq2xgddQVbBDoO6wfjP2v4U2j9NQeRiGjySJQ5e65wz5n1F1mq7Lh3bhp1lzbiuWXpsS5qpmg7X4dhqOg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3cxEeVYmz40xn1DRobFYBZgM1G2N9YheCuZE9Rg8pMoalaJkT
	V/RA76rk0ACqGe3i5RY+iy2KBn6zntItdpbX2O9y6Sfc7nq+AiUppmoHySLneM0=
X-Gm-Gg: ASbGncsYLwAOHbWucA/FqG9i+5FZ57CSpuzsnUjylnE8tQg6NhjHQKQPLPBjIVGg70P
	Bs0oxDg2oXpzQjY39AVbK6SezSo/J5D9QqOAhCkuo00oLcpcUznNC4VoK/VFp6Gsd1yIbz2EHpb
	KJercPXSHhJJ4CC4DQzGJmcVUk7MGHRcVZanR4g70r+OhNuKwMoSjqiRXZy9pSg1V0L9ZWmuAOO
	job5koqyJAJ0pnHb68yapo9dUVkJtuusQGXq5em3MGdDh94PqSTbwZf1YHVbS12ElOSCW8hxfKA
	3aU0Q3v3iovjyrLrisJcomf3nQ==
X-Google-Smtp-Source: AGHT+IFfP7os8MQ1u1YZSNkqYKfZSgb/vW3ksTMdEyemTkz16qCj36YkFgGny3jWjjj/tutrgWjYQw==
X-Received: by 2002:a05:651c:19aa:b0:302:3534:1d68 with SMTP id 38308e7fff4ca-309037abe6fmr8480831fa.4.1739359394471;
        Wed, 12 Feb 2025 03:23:14 -0800 (PST)
Received: from [192.168.1.140] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-307de1a6531sm18310511fa.45.2025.02.12.03.23.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 03:23:13 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 12 Feb 2025 12:23:02 +0100
Subject: [PATCH v4 08/31] ARM: entry: Move trace entry to C function
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250212-arm-generic-entry-v4-8-a457ff0a61d6@linaro.org>
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


