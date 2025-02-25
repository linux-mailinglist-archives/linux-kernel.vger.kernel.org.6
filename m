Return-Path: <linux-kernel+bounces-530961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10FF7A43A7D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 11:00:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CBC117299E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 09:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49EFA268C7C;
	Tue, 25 Feb 2025 09:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EJ6Z4LY7"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1044D2686AC
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 09:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740477326; cv=none; b=jOUAp+l1ELTWtiqn5H6VoUsbXF4LDEjSlqv0cnqjAGUhuE13ke6XRTH4N3hip5ZIyxiRw03HJTeolT+0Fmxq+Fq+tt9z4NY3dkvHE6HDpmNZDOBUxNFe7yMpgVrNm2y+9TY9ZjK3eNF501rgb/7DZUMYYzcO8WWJUa5rLzeeVz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740477326; c=relaxed/simple;
	bh=KX7L2dj8FdPfM34FoyLp2Zt4Q5Ia48cTxoohJeqgi1s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U6qyyoYyX9z5Qh7E6BOVpqFWayP+2DWTjQ3I0d0fkTLDC0SseuGKluQ0pz700+CLbvPKY3Aos7C5nSvXT4kmojYzhC/LNY7zOqdlXZg5OTvfm+S2HtzIh0DvwHxaJTiKHmP1U3+2i7LpxWdbEzzQQIJLXPJyFcpB9zRgxZvVG5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EJ6Z4LY7; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-543e4bbcd86so6218975e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 01:55:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740477323; x=1741082123; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hLPL0cxSmhQjzTuSazqL5ULZpLc4BXlPwpKFYiv7qfk=;
        b=EJ6Z4LY74YQamwvpPR4RZ6v/UE0Qfqk75Trml7Ni8f5UCWvFvlaoQZI2UDoXB0LYsO
         G8O9N7Vdqplch6GEtl4eQddIQ8hR1WUESnUvqvVG4tkr6ypNnK/eWjZ1XLGul6xTP1AJ
         ORF0784XzACgN/C6NE+oNQc8f60Fn2/XvgfQlRwmD938RfEGQ3hJjPhCti362TWemiyQ
         3uab5VWuwiVWMh1c5iJceorb9H3FwR2XAdIsCA9ach+U1VORQzCb6FXkMs1gwKTn04hT
         1lN7GIMkYveA3T4FR3KdRTwhw331ajw2sGvsGXOt8YuQFXEJd8zl9rjAPFxQmDa0k3ZC
         VVLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740477323; x=1741082123;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hLPL0cxSmhQjzTuSazqL5ULZpLc4BXlPwpKFYiv7qfk=;
        b=JQUZ6rKrIVOKE1Z/mgmKlCUsOR3L6hzOTiAjeu+5yjPdvZESw1IHX+fbkIo2nj5zLq
         g4/31QCPOpV7Rd/tYbqFgGBx+uXDl6MLtua2Pw6Wjpd8y8TUAikxe6ycIXYeIrMECqwa
         4u1twIR2my1GSOl+IeiteXgJdn2V6JvMdNKbaQtTy+FMD+FGXyQ2Y8fOOziSHmCOYQPg
         d46FZRXzKIeq6uau0p4VwxzseXM+gF4L6zFU1HGV3hefivb4UD6fv/0UpCUA8Kmco9BS
         KUm3vX7CPdf05NG3uYW1IHTHNQ1YKWFF8qr1GMcC+5A7mRTmXNbZ3yJ62rTMOJFqgshG
         VPpw==
X-Forwarded-Encrypted: i=1; AJvYcCWPYh6YZF83m5mwPKRBXM17yA7MjmRPaOSQDzgTkHjg827DzERBzkQxOn0PRViAdpH4qUa/frBRikkjc0U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGIMRTeM5/rP71SBUIqr8GEMBtbIpns4Icu9aM6lnuxHWLAVF4
	HI8b3GXqPWfrdGboYr8MJP0bMOciM+DEiin3QzY24tvCx4N/JETiUdbfE05UM80=
X-Gm-Gg: ASbGncs9/pa9r45P2MREkVOGTBUOte3+in/DQB0s1s7yZjuxd8B/2xbCGKPAf375zgk
	EUR5R/MF8FcUAH4PZMrJASn/icKiRbULnlE4eJO0W+TlwtpIKU3y5d9JZFc3v5b2SUtPSqo68tW
	vhVG/VBzAQtLKWaeX8qdpPkfP/3rA15IsQcd6mjvnVjanQ/V2n+ZvMyeN31YIqptjgeqRalBiwk
	sUAWgYbARw76FtoBBEvf3vIqnwY60+iKeZd8cpZfTssg7w4xO1dMw5hPVcU1DUCyrda3np+1Zgw
	IHiRluc/I+ivjYPQrw/VLtrR4rA7Xp58HYx3
X-Google-Smtp-Source: AGHT+IG4gnndhO6d56pPyJzHQkvZAwyB0xsXUyc/MHVXGstc6/S0wQ2MFyd0xpUKVgQgFI8a8Tye1Q==
X-Received: by 2002:a05:6512:2809:b0:545:a2f:22b4 with SMTP id 2adb3069b0e04-54838f5a9d3mr5459397e87.40.1740477323227;
        Tue, 25 Feb 2025 01:55:23 -0800 (PST)
Received: from [192.168.1.140] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-548514b261esm132867e87.24.2025.02.25.01.55.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 01:55:22 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 25 Feb 2025 10:55:07 +0100
Subject: [PATCH v5 20/31] ARM: entry: Untangle ret_fast_syscall/to_user
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250225-arm-generic-entry-v5-20-2f02313653e5@linaro.org>
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

The return to userspace is a bit hard to follow. To prepare
the ground for further refactorings we rewrite the functions
to ret_fast_syscall and ret_to_user are mostly stand-alone
symbols.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/kernel/entry-common.S | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
index d27e34d7e97a079d62e7b778cf7cf97c302e4763..ece9215717143427de7572a18a6dbe620a9193e9 100644
--- a/arch/arm/kernel/entry-common.S
+++ b/arch/arm/kernel/entry-common.S
@@ -44,20 +44,23 @@ ret_fast_syscall:
 	bl	syscall_exit_to_user_mode
 	ldr	r1, [tsk, #TI_FLAGS]		@ re-check for syscall tracing
 	movs	r1, r1, lsl #16
-	beq	no_work_pending
- UNWIND(.fnend		)
-ENDPROC(ret_fast_syscall)
-
-	/* Slower path - fall through to work_pending */
+	beq	2f
 
 	tst	r1, #_TIF_SYSCALL_WORK
-	beq	slow_work_pending
+	beq	1f
+
 	b	ret_to_user
 
-slow_work_pending:
-	mov	r0, sp				@ 'regs'
+1:	mov	r0, sp				@ 'regs'
 	bl	do_work_pending
-	b	no_work_pending
+
+2:	asm_irqentry_exit_to_user_mode
+
+#ifdef CONFIG_GCC_PLUGIN_STACKLEAK
+	bl	stackleak_erase_on_task_stack
+#endif
+	restore_user_regs
+ UNWIND(.fnend		)
 ENDPROC(ret_fast_syscall)
 
 /*
@@ -74,7 +77,9 @@ ENTRY(ret_to_user)
 ENTRY(ret_to_user_from_irq)
 	ldr	r1, [tsk, #TI_FLAGS]
 	movs	r1, r1, lsl #16
-	bne	slow_work_pending
+	beq	no_work_pending
+	mov	r0, sp				@ 'regs'
+	bl	do_work_pending
 no_work_pending:
 	asm_irqentry_exit_to_user_mode
 

-- 
2.48.1


