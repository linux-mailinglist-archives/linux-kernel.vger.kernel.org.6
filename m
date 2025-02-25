Return-Path: <linux-kernel+bounces-530955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AEE66A43A6E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 10:57:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C58A73AAC10
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 09:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40141267B8A;
	Tue, 25 Feb 2025 09:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JZMucDWD"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB618267B0E
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 09:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740477319; cv=none; b=JAqDv5N/i2ZxLM3wPx3zCKIW/5OQm0d9mKN8G1joLEY6QYVevKyD/uRrRmjXOESMU53I7+ElpHEQAGd1OCzeZevu6y0GnAdkGTARSXXkBpmt3V9AWib/Rufsd8K+NtXlyzgTaspt3SIexC/zLyra1KN69N2890rG2r4YbamAHEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740477319; c=relaxed/simple;
	bh=0QHPLkprIrLa7FY7skG/G0BimBto0am5TbhUU9Y2D1k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mljyKEFi1TLUNw7hVLGmEfaCv9SfX3TBa1Gl4FYQvqbNZ28mG2Ry8VV9RtQEWr9PhgmDSvet0kulwPhh/skAXBQrymAkOqeQp4lDmGHHONoMs1yyomy6AVumBmndmOxapT9AieOzR1OFPmh9u51Bwvi0ZU0tQRUqbXmubI+tBek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JZMucDWD; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-3072f8dc069so55888941fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 01:55:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740477316; x=1741082116; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MgvrpQqwFQ0R0umdPRsAplUpCRMZEe+n8Q2dyj0aMbc=;
        b=JZMucDWDimYwa8VLL9O1h0Y4C9hoy3s8AIDRyIeBY50ICopgrjAUO9RO1S3y+qU8Cg
         +/aphgPR8PqUcb3d2TsRyhl71n+GtumhdGGgWvutYXLAfXPzdLHqLemo5zAyB5J3cipE
         EjTzvq4ejWeCPi7D/nEjILlWvfBxLwD9vIWXC6a/MI3t14sblMS/n/W2/KuHwpwFyVFG
         VjJ3kH65ormzbJvO/8H3OUlQpNkF6VODdVb/rnlfeKq/mZcys39d9BNaTPKxifsSixpo
         hLMeapXHwrCar/mMH5AaD5SFHCKuKLFPn72bON6akxyFyv++IVMNUd+oyG1tUXoinARL
         7ljA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740477316; x=1741082116;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MgvrpQqwFQ0R0umdPRsAplUpCRMZEe+n8Q2dyj0aMbc=;
        b=qitUUcPcLiL8ebb2u3zgUpJ6zrAE1NbZvQgDDNjTX91OTwlpy1UuElLhOY3QOXl4VH
         o6cgtBfruURUIql2eJGX0v/ESaRXuCE2VQW1Bo9WX0m/glFsABoDVgq7+k3TOHQIp7bV
         59xZYheLQTpmDdZd290vWrRxjySVI3uMIJHfBowTsHfPhbNCg+6ZZWSGMHIo/AbyBvUk
         529AC+tuehUL741dVdvM0u4S6kMJAaC+sitXi3eM946vxOEK0CyfgnEqVpSsftVbRkDu
         6S6XE+SiW757qmErVsW7CDb7W5gnNamHi9C8w7bMPtOQBRLLKubQ3+FnesDpWj7jI0Xc
         BKoA==
X-Forwarded-Encrypted: i=1; AJvYcCU/aEj1krrgLDuJdu/QRfyPrfqF0lCaZ+spb5Kmowu/bAA+fRBPU78vsYDZxo/QADP87rhzf0aNckNbHaw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzO1h20JV7WOrtoH8XayuwcYxMu0jJHToIFa8lcGolkRJ4ItqyF
	iZcaJOHh4PQ/jCozDAcvNZA8OitmxHdaia5bdm8aKRLvUiw7Ce56dWj0i7aJHgc=
X-Gm-Gg: ASbGnct4lcvOfjrZIsnlLD1xPhydhape+b6qfiJZ/il3+tvEyowsuGWIsHw1mI2FAAt
	9wNu9fEiJ2dZAPDhrdSMVQx2tepsDJeOMNmneyChbnYe3dKSxIbrgCBKHCy9HgLjFftBMB7e7tU
	vJdYyaPsJp0o+NydKVpk6LjYEjWqtpKESBz3wK4+f6v5W5sTlURddnYJtjg6dhvuLl0B+y8uG6N
	oDOfBaoCtG5f5X+jAHL1huf7a4vumv/291clhJoxe90amgw7RNYL5bFhYHUbhaTzmw0/oKUzK9N
	ALCQThbbeMtcLLsCHslbrQaaPIXKzJMtbUIK
X-Google-Smtp-Source: AGHT+IFzWjwa7+x+DsN9qo/60H31u5WVx0JVKoFSYgag5yjlwdX8Fst2CGM/hjw802aY7bipwjamsg==
X-Received: by 2002:a05:6512:ba6:b0:545:2f5d:813d with SMTP id 2adb3069b0e04-54838f5a9bcmr6922156e87.37.1740477315950;
        Tue, 25 Feb 2025 01:55:15 -0800 (PST)
Received: from [192.168.1.140] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-548514b261esm132867e87.24.2025.02.25.01.55.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 01:55:15 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 25 Feb 2025 10:55:01 +0100
Subject: [PATCH v5 14/31] ARM: entry: Drop trace argument from usr_entry
 macro
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250225-arm-generic-entry-v5-14-2f02313653e5@linaro.org>
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

The trace argument select whether to look into tracing of
the hardirqs for the exceptions from userspace, but also
selects whether to call further down to establish context
for RCU.

Split off a second macro that is called on everything
except the FIQ since this is the only outlier.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/kernel/entry-armv.S | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
index 93a37437a9520118eff411f009e8f6bd729412fc..c71110126fc105fc6ac2d6cb0f5f399b4c8b1548 100644
--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -357,7 +357,7 @@ ENDPROC(__fiq_abt)
 #error "sizeof(struct pt_regs) must be a multiple of 8"
 #endif
 
-	.macro	usr_entry, trace=1, uaccess=1
+	.macro	usr_entry, uaccess=1
  UNWIND(.fnstart	)
  UNWIND(.cantunwind	)	@ don't unwind the user space
 	sub	sp, sp, #PT_REGS_SIZE
@@ -401,13 +401,14 @@ ENDPROC(__fiq_abt)
 	@ Clear FP to mark the first stack frame
 	@
 	zero_fp
+	.endm
 
-	.if	\trace
+	/* Called after usr_entry for everything except FIQ */
+	.macro	usr_entry_enter
 #ifdef CONFIG_TRACE_IRQFLAGS
 	bl	trace_hardirqs_off
 #endif
 	asm_irqentry_enter_from_user_mode save = 0
-	.endif
 	.endm
 
 	.macro	kuser_cmpxchg_check
@@ -429,6 +430,7 @@ ENDPROC(__fiq_abt)
 	.align	5
 __dabt_usr:
 	usr_entry uaccess=0
+	usr_entry_enter
 	kuser_cmpxchg_check
 	mov	r2, sp
 	dabt_helper
@@ -439,6 +441,7 @@ ENDPROC(__dabt_usr)
 	.align	5
 __irq_usr:
 	usr_entry
+	usr_entry_enter
 	kuser_cmpxchg_check
 	irq_handler from_user=1
 	get_thread_info tsk
@@ -452,6 +455,7 @@ ENDPROC(__irq_usr)
 	.align	5
 __und_usr:
 	usr_entry uaccess=0
+	usr_entry_enter
 
 	@ IRQs must be enabled before attempting to read the instruction from
 	@ user space since that could cause a page/translation fault if the
@@ -476,6 +480,7 @@ ENDPROC(__und_usr)
 	.align	5
 __pabt_usr:
 	usr_entry
+	usr_entry_enter
 	mov	r2, sp				@ regs
 	pabt_helper
  UNWIND(.fnend		)
@@ -495,7 +500,7 @@ ENDPROC(ret_from_exception)
 
 	.align	5
 __fiq_usr:
-	usr_entry trace=0
+	usr_entry
 	kuser_cmpxchg_check
 	mov	r0, sp				@ struct pt_regs *regs
 	bl	handle_fiq_as_nmi

-- 
2.48.1


