Return-Path: <linux-kernel+bounces-562736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85C49A63213
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 20:40:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A1561895986
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 19:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F106719DF48;
	Sat, 15 Mar 2025 19:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="FehDi0W1"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39803199E88
	for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 19:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742067622; cv=none; b=acBuYr1hmHuD8LxqKq3VvZsuFpZVWEzEbhyF6xWt8byS212lzQ0Card+yzDKRQ18xh9CZSpkPZpDAbKGFJ5jZUYbqtmwV1Nq5TyULQQmQVaLY/SF4nM+Evz2fJ0ioKZN3D2QQ6EHKPIBwxDC6EOqOEhwC6w9B5J6vIPW+7CN1Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742067622; c=relaxed/simple;
	bh=9Y+M6QJgx6U22cGSNKYhM5RUTy101VtZCGwLHaVORcE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SMBtJFMV3hPrordrfhach/UY1vjldzQRdxTj/WrfdWIk66n5V9gQYPsUP+RY6zNKG3wbCIknocVBBbYAy87rvlaM/l0ap5r2v9x6qUg5qazwR1+ct+UgEP9uibsBnCH0HsWbeaxDS92T7VWAmqmGYghc3/CZpUIta6bHmFAe2yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=FehDi0W1; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4394345e4d5so5462255e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 12:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1742067618; x=1742672418; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HftcmsVbN478O7v8MBeUEH/LcXU7asVB/nqFSHczQLU=;
        b=FehDi0W1Jyop2PFxNoO3iVKcfzw/sbHXKSewdKy/GI2ylK6sfy9wv7kqK4x/+Z2Aok
         SpnjCQbMV4cLBJE53CpepE4sPWbj+yEwnwatG4Du9873kUb18mHE8lU4Y30TLU7GW9UL
         qS4w6BNDg2GBn+zMu9MnfOxF9VV2m3BUp+ukPVKvhixbJbZhR2k0FpPzFuzx6XQVtw4a
         dAD2A456aMli+lkjBBy4ZQGAE/2eqTAykrZEvgkLq56wY85UmY9V0QF8sfTcc2Rv54aV
         gdytbwz/obhWUOKyz6n13ArwWmDtltfP1WgvFM1CMsi0g1lAxLjpQQTbzDez8/wwRq2v
         bQ3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742067618; x=1742672418;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HftcmsVbN478O7v8MBeUEH/LcXU7asVB/nqFSHczQLU=;
        b=FEXUr+T/WA1HF6gdXYGOZlHU9y7AFPYjI9EGIqrDAoKF7p3WCPNZCnU5s6QDX3FsJG
         ty0V0lceKwJQEdjF9leyBVra4I3uDlcsrq8qBmOjj4JdGXqnSlt97GfOFk4/OedLylT2
         icnT6Z/YQukEMiCIITWwOvdNWQHH9PC8cspfJiYM1TW8/Y5D3EU42GmiHbwRDwLF1A02
         LKaWDCL0bTh1y/INGd2xi+mbgcVbkMVICfNLhDDalJyYQspbejhI1D8CXZ9adyc6vKdB
         n9eCrHAwMH9uFdjXmuvXqOOMrzPwJTZ/ykpk/Gmf7NGYikPqheEiow9+Soq4kpJnODrB
         urxA==
X-Forwarded-Encrypted: i=1; AJvYcCWGURa+I1P9O99j2iOLzCNm7p3HoAe2phCLOTmRl+2eSIMzI3cngU/Uc82gPDZTJTic1k2mI6KZq6Um4ek=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9ICk1MoJfS5p2Vfd2YNO6df4zSgxOXL5Jkby6U1hG4UzPRRzD
	F9cNBZkH0rbcBOGk254m2PSYu6DHgWu5/Tpb02gbMDxWBD5uDnPyXo2TT39L3MI=
X-Gm-Gg: ASbGncuocKlJC73XGCQQbcj20O/AZ+lfA6lyoGA/GWen+pm0qGH4PthsgN7jp9s4LVE
	xVJbtJNnxL45TJgH2NdbreZOSwWn6lG3D5kYdQ7uo8oW+CPqO8fDSl+ze2ocdvnztyvCCLuNuU+
	vhbLMcRKnbEiRJx3bPuEvCHyYKvPmdOH9zjRr0V5Nrs50NrBnv3KiN1DC6nlHWPdNaYbi9yRDOP
	78EZsRVrq7RjtdNsnnisYmFxPrfiKq3YwdjFWudd8s52Cl6ATPv851r1xs1kDiK+zVi7UVZ/dho
	W478NW7BXelZCfJLOeWuRYJnm89fuo492g7mP2sHnEiid/iVLnY0bLNeSFgintUgwPso
X-Google-Smtp-Source: AGHT+IE8rUJaBUyaTAKQ8EzuwI1SkVQyQutos0uuQDZugGQkyRMNgXKo2jDRzukmOwq1bfkYERVydA==
X-Received: by 2002:a05:600c:1c9f:b0:43c:f8fc:f686 with SMTP id 5b1f17b1804b1-43d1ec62883mr88678025e9.3.1742067618444;
        Sat, 15 Mar 2025 12:40:18 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c83b6e92sm10067447f8f.38.2025.03.15.12.40.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Mar 2025 12:40:18 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	"Maciej W . Rozycki" <macro@orcam.me.uk>
Subject: [PATCH v6 1/1] MIPS: Fix idle VS timer enqueue
Date: Sat, 15 Mar 2025 20:40:02 +0100
Message-ID: <20250315194002.13778-2-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250315194002.13778-1-marco.crivellari@suse.com>
References: <20250315194002.13778-1-marco.crivellari@suse.com>
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

CONFIG_CPU_MICROMIPS has been removed along with the nop instructions.
There, NOPs are 2 byte in size, so change the code with 3 _ssnop which are
always 4 byte and remove the ifdef. Added ehb to make sure the hazard
is always cleared.

Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 arch/mips/kernel/genex.S | 42 ++++++++++++++++++++++------------------
 arch/mips/kernel/idle.c  |  1 -
 2 files changed, 23 insertions(+), 20 deletions(-)

diff --git a/arch/mips/kernel/genex.S b/arch/mips/kernel/genex.S
index a572ce36a24f..4e012421d00f 100644
--- a/arch/mips/kernel/genex.S
+++ b/arch/mips/kernel/genex.S
@@ -104,27 +104,30 @@ handle_vcei:
 
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
-#ifdef CONFIG_CPU_MICROMIPS
-	nop
-	nop
-	nop
-	nop
-#endif
+	/* Start of idle interrupt region. */
+	MFC0	t0, CP0_STATUS
+	/* Enable interrupt. */
+	ori 	t0, 0x1f
+	xori	t0, 0x1e
+	MTC0	t0, CP0_STATUS
+	_ssnop
+	_ssnop
+	_ssnop
+	_ehb
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
+	/* End of idle interrupt region. */
 1:
 	jr	ra
 	 nop
@@ -136,9 +139,10 @@ LEAF(__r4k_wait)
 	.set	push
 	.set	noat
 	MFC0	k0, CP0_EPC
-	PTR_LA	k1, __r4k_wait
-	ori	k0, 0x1f	/* 32 byte rollback region */
-	xori	k0, 0x1f
+	PTR_LA	k1, 1b
+	/* 36 byte idle interrupt region. */
+	ori 	k0, 0x1f
+	PTR_ADDIU	k0, 5
 	bne	k0, k1, \handler
 	MTC0	k0, CP0_EPC
 	.set pop
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


