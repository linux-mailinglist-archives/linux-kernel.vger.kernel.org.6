Return-Path: <linux-kernel+bounces-514805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D4A8A35BDD
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 11:51:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FA4018918FA
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 10:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4906262171;
	Fri, 14 Feb 2025 10:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TcZb+12+"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E14625E44F
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 10:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739530267; cv=none; b=JzcX+MvdFN08OoPQgWRqj+z/ERBBSchMlKFMo2hTITkwzI7ccPu5IHNmS7ny3BjkeyLOLYL1G02eVpP0cNXMiLKhfTHeJr5JJwulPxtbfToaoGR0lvgcLvtdxg8R8bes0G+BdlYr3ORa9cbFBT5J6vF/vOYbTYb/Jm1wDs0EQ/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739530267; c=relaxed/simple;
	bh=gwYxyreEN3pGOV3NrZRLVqoH/zKH2QbOCm/J1S5JV60=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fdCE5sbhBAlQhysk7kujMphXWZpvzXiCC5ka2QjOhdgpucb1a1J3o/7AFkZjBYKwQsLHXGwN3K6/uW23YhtkndjB904M7LEqeoQHsJyw5Y8D5Iz0O9kkJFxKtKwoRhP5oYp/N1VL4Xr6f9540ZgljB+340WBdnJVdOM6eJvAYvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=TcZb+12+; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aaee2c5ee6eso322687066b.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 02:51:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1739530263; x=1740135063; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vxL2FaBUrpOAWNCMVoBQvC23Dop5UA6QRVM0Rz3a32k=;
        b=TcZb+12+YHL6HVU1QBoHdytCpOa+4g22pygSU0DtUnVJoAuzYx51swlW0vYp4EwBAr
         mHvFw0jiELgefMlBErcsFUxwVqd8Vf1G3wU5Mxk6XPxRHTi7J0G9PUwiG7cOEMM1JdsJ
         yu7ny3v95/tAyCNU0zcreSymb3ZhxkUKpq3Osgvd2nDlMJ32Q5bSUzMDkQgouIZhj0ZQ
         aNxIjqAUmexjFMS+XRoMbFfoEJFzV24rGayiPXa5M19SzBey/iCICabrI+kR5zihBsXQ
         KLyDCuHhr4ylAJaBtyIV81IokPmRC71Cp3RqrzymksjjDYmbzmgzQpV5Vi2cWwbNcVTH
         /EBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739530263; x=1740135063;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vxL2FaBUrpOAWNCMVoBQvC23Dop5UA6QRVM0Rz3a32k=;
        b=BuBAkfVSNvfk5G1qOY/moSHU92zCUoZIAoeTw1rCvPbLdf0UoGVXZTrEJ5OeFkJ1CT
         U9lxPOl9psrNqpcWJTyfHtuRYjT4umzb3OHaemZeY9bDLe9lcKyBS5dBtMpOKtYqyhoK
         efVlIpWGZfuw+0u1vrLIKWJevqta4X1oOiNB1e5aqlsgB3oBulsjoRqLf1Pa1dTMuxD/
         QRYZBgpNPLfbvEVpTuaEWoWnzAoCE3L31eQbtIg639JXDS853kQ35N0SsNM+pWvzBS89
         4h/OZZ3dWbhEJp6OtAwBBylfWJswQp1ay674gUCqurHo1o8if2qMhjfvBTBfHG2HXRlk
         ygtA==
X-Forwarded-Encrypted: i=1; AJvYcCUgAIsGhiv3qFOy2w7iHw0JSXbHu2SSLJMqespinWyUOODWlVBk0jV7jctUwx5XNfjcbS8AHfBlLoF76dw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxE1j5P1YbThsIoS5sP2qFx0/qOydEWDJjP2YI8eeP3DtUJ39MK
	3sJRaIN/xzu24A2nPcOim1nVizLqpS6vk4hQ+5aVR3xWV/gE5ZEBlTk1V7GZ8QA=
X-Gm-Gg: ASbGncuLqugIzOKLC8MIjjVHnxKwCm3f/RUyxHjDCTKtsdUJFtK6FZWbLv8FHtwZeTc
	iShvQS3usKGxw1qtM9QKo7ePZzoTlyzkRy3e6An+wWJCWY96QOMmMqcEX1pWTi8GTWIvGhNRMqH
	PY8qyebQrApWNNnMu4BwrQ/Kkg0tH1ex0sf78uaqrkFnpw4CGn+QDij36FvQgfbAv6ccZdzjXwA
	K/+kSn8bqTJVQVmTvwLi1dRSGcpgrDR8EwUZIRCZ7gox81rUR1bH750u3+T41yci0Ze4th/wY3A
	ENRWFDTRuCujIFtoGh6xYPTISaxCh/BNkB+4T9k=
X-Google-Smtp-Source: AGHT+IGsMMAb1DDvFmjMtF+aaP2n5k0vlIMg1XaFkk+rftooF0Uyis0c2tb4Y9A+t/xlLE92MIu12A==
X-Received: by 2002:a17:907:962a:b0:aa6:9624:78f7 with SMTP id a640c23a62f3a-ab7f3391b09mr1072096766b.17.1739530263251;
        Fri, 14 Feb 2025 02:51:03 -0800 (PST)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba532575b8sm314551266b.44.2025.02.14.02.51.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 02:51:03 -0800 (PST)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH] MIPS: Fix idle VS timer enqueue
Date: Fri, 14 Feb 2025 11:50:47 +0100
Message-ID: <20250214105047.150835-2-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250214105047.150835-1-marco.crivellari@suse.com>
References: <20250214105047.150835-1-marco.crivellari@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

MIPS re-enables interrupts on its idle routine and performs
a TIF_NEED_RESCHED check afterwards before putting the CPU to sleep.

The IRQs firing between the check and the 'wait' instruction may set the
TIF_NEED_RESCHED flag. In order to deal with this possible race, IRQs
interrupting __r4k_wait() rollback their return address to the
beginning of __r4k_wait() so that TIF_NEED_RESCHED is checked
again before going back to sleep.

However idle IRQs can also queue timers that may require a tick
reprogramming through a new generic idle loop iteration but those timers
would go unnoticed here because __r4k_wait() only checks
TIF_NEED_RESCHED. It doesn't check for pending timers.

Fix this with fast-forwarding idle IRQs return address to the end of the
idle routine instead of the beginning, so that the generic idle loop
handles both TIF_NEED_RESCHED and pending timers.

Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 arch/mips/kernel/genex.S | 36 ++++++++++++++++++++----------------
 arch/mips/kernel/idle.c  |  1 -
 2 files changed, 20 insertions(+), 17 deletions(-)

diff --git a/arch/mips/kernel/genex.S b/arch/mips/kernel/genex.S
index a572ce36a24f..a78d5132c940 100644
--- a/arch/mips/kernel/genex.S
+++ b/arch/mips/kernel/genex.S
@@ -104,18 +104,16 @@ handle_vcei:
 
 	__FINIT
 
-	.align	5	/* 32 byte rollback region */
+	.align	5
 LEAF(__r4k_wait)
 	.set	push
 	.set	noreorder
-	/* start of rollback region */
-	LONG_L	t0, TI_FLAGS($28)
-	nop
-	andi	t0, _TIF_NEED_RESCHED
-	bnez	t0, 1f
-	 nop
-	nop
-	nop
+	/* start of idle interrupt region */
+	MFC0	k0, CP0_STATUS
+	/* Enable Interrupt */
+	ori 	k0, 0x1f
+	xori	k0, 0x1e
+	MTC0	k0, CP0_STATUS
 #ifdef CONFIG_CPU_MICROMIPS
 	nop
 	nop
@@ -123,11 +121,17 @@ LEAF(__r4k_wait)
 	nop
 #endif
 	.set	MIPS_ISA_ARCH_LEVEL_RAW
+	/*
+	 * If an interrupt lands here, between enabling interrupts above and
+	 * going idle on the next instruction, we must *NOT* go idle since the
+	 * interrupt could have set TIF_NEED_RESCHED or caused a timer to need
+	 * resched. Fall through -- see rollback_handler below -- and have
+	 * the idle loop take care of things.
+	 */
 	wait
-	/* end of rollback region (the region size must be power of two) */
-1:
+	/* end of idle interrupt region (the region size must be power of two) */
+SYM_INNER_LABEL(__r4k_wait_exit, SYM_L_LOCAL)
 	jr	ra
-	 nop
 	.set	pop
 	END(__r4k_wait)
 
@@ -136,10 +140,10 @@ LEAF(__r4k_wait)
 	.set	push
 	.set	noat
 	MFC0	k0, CP0_EPC
-	PTR_LA	k1, __r4k_wait
-	ori	k0, 0x1f	/* 32 byte rollback region */
-	xori	k0, 0x1f
-	bne	k0, k1, \handler
+	PTR_LA	k1, __r4k_wait_exit
+	/* 3 instructions rollback region */
+	ori 	k0, k0, 0x0c
+	bne 	k0, k1, \handler
 	MTC0	k0, CP0_EPC
 	.set pop
 	.endm
diff --git a/arch/mips/kernel/idle.c b/arch/mips/kernel/idle.c
index 5abc8b7340f8..1f74c0589f7e 100644
--- a/arch/mips/kernel/idle.c
+++ b/arch/mips/kernel/idle.c
@@ -37,7 +37,6 @@ static void __cpuidle r3081_wait(void)
 
 void __cpuidle r4k_wait(void)
 {
-	raw_local_irq_enable();
 	__r4k_wait();
 	raw_local_irq_disable();
 }
-- 
2.48.1


