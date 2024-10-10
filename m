Return-Path: <linux-kernel+bounces-358896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA4DD998519
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 13:37:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAE971C245D0
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 11:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C5FD1C4611;
	Thu, 10 Oct 2024 11:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y+ngMCmj"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6E61CB31C
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 11:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728560059; cv=none; b=aOZMAGqZbdQXcw2rVlrlE3B5wb2+45DjimVe2Q/tfwG3jd9PV1zGEbWz6IJUVMSyuTBmO0C+6rIBE5BK/T2u9wpdXo2UvR2LP0sTu8hL7jQTpCbC14942rpHIjmfIqE+G5sF4Lu7skVFNatk97KqYyJIYXivO03wlbfmI+LCxIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728560059; c=relaxed/simple;
	bh=U7+/gc2e2KuWRZx3ryccMQNU5ZCqQa+rXx8yeFy3Nh8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=vBZSnSdSeUmn4eRkBIMX6k+tK5culGQZMkhnGzmiZU3DaRuWs3Z1axLvbjlgKb+ad5Bq+tFQE2ihR1m+bBLDkbb5eNPVxz9iQLbvyvahXtFOw0S86tYr6cAUqFO5BtUclbHKo/6EYLFoV5lISj0wdwRj7OTuo+ielkyQrzoaBZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=y+ngMCmj; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a9982f90e92so152088166b.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 04:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728560056; x=1729164856; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hWWOf9VRKfs2/tqyRJcdO75r8/gLb8BcoV6DE9Ay3YY=;
        b=y+ngMCmj+bSsPqKc/Q0w5tRuLjwY9VQGzy9gEigmiB3/RsbMGw5jRDWvaaDLfUrbRq
         8Uc+lyFHf450WOksUO/Fli3YrQ198Gij05BOJ7fOSN6EY70XP9WVcx+WhWNHe6+3Zxn0
         bi3rRzCrdTnjFfnXzGuXMSATHHT0MrZhFeM+/wP185LOdGlhpJa/tWFEsWTBEbbpkBKo
         U0eF0Zxk9BIWfv69Yb6q9zJ27EITbq6iXD41qb9KRBw9Jpcv6edcBKNxH/HWzIuDwltu
         ThM4o8e15T5KyPZ1rQeSJnBt1nE7dKUBI0r11UfyinWFd7ERRv4k9qhPFPViac5a0x0O
         a5rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728560056; x=1729164856;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hWWOf9VRKfs2/tqyRJcdO75r8/gLb8BcoV6DE9Ay3YY=;
        b=b/uJy3WUBKS22EOboTda/zueg+OQhC7axm0a8pfMA0tbtUOSdLfhPR8n6y3CorYNKp
         QlU9Y9dp98HGj1YtYWd6bDaNEvqF0xI4G+Su2opZwoX+zZPRjPvQLf3Yf4VMK9nj8J/8
         0yNALIK4i73jr76mp7CXMeosNNJtvTYHa442NyP+nnAD+z7MuKzHrdzG7+Kmz90bFVDU
         bypWa5iALZK+N28W55axFEYrmcFeScQBfIOYnfoS1sdjkUUu3hKd2Ast75t0DvnG7Gg7
         GODTWJakKOe7g/imkomx1BuVl3srR2uV0PEdbGBXraZqbEj2svzHQIkcrX+wFBveDMID
         jybg==
X-Forwarded-Encrypted: i=1; AJvYcCWawyMZQWxuzoqGqybFunZIkOcoB4rNF4zT86/T+L4+OwG/G9+hY7E4brwhsMkedyavSqBrGmgNaJuWcVM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjxQHh+4mYUFgmxvC0CdsCM5tYhOVqMbrQfAKWUtd2fl6feK/q
	Eij85dyVsHnwvprpbe2ln6wZt88BdjgOIU3zo2OftRisqnx+GJ0UYJbFHyBoin4=
X-Google-Smtp-Source: AGHT+IEHCTRRp7fVGYbHaZJRdCWztPF5Cmz1ArhsR37YdkkUHo8yQ2UvzGBEaqZF9J54+PdeX3iD/A==
X-Received: by 2002:a17:906:eec7:b0:a77:ab9e:9202 with SMTP id a640c23a62f3a-a99a0eb9349mr287624366b.4.1728560056112;
        Thu, 10 Oct 2024 04:34:16 -0700 (PDT)
Received: from lino.lan ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99a7f25406sm77619066b.69.2024.10.10.04.34.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 04:34:15 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 10 Oct 2024 13:33:58 +0200
Subject: [PATCH RFC 20/28] ARM: entry: Untangle ret_fast_syscall/to_user
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241010-arm-generic-entry-v1-20-b94f451d087b@linaro.org>
References: <20241010-arm-generic-entry-v1-0-b94f451d087b@linaro.org>
In-Reply-To: <20241010-arm-generic-entry-v1-0-b94f451d087b@linaro.org>
To: Oleg Nesterov <oleg@redhat.com>, Russell King <linux@armlinux.org.uk>, 
 Kees Cook <kees@kernel.org>, Andy Lutomirski <luto@amacapital.net>, 
 Will Drewry <wad@chromium.org>, Frederic Weisbecker <frederic@kernel.org>, 
 "Paul E. McKenney" <paulmck@kernel.org>, 
 Jinjie Ruan <ruanjinjie@huawei.com>, Arnd Bergmann <arnd@arndb.de>, 
 Ard Biesheuvel <ardb@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.14.0

The return to userspace is a bit hard to follow. To prepare
the ground for further refactorings we rewrite the functions
to ret_fast_syscall and ret_to_user are mostly stand-alone
symbols.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/kernel/entry-common.S | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
index d27e34d7e97a..ece921571714 100644
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
2.46.2


