Return-Path: <linux-kernel+bounces-538278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A803A49699
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 11:12:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEE6C1743F1
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 10:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7690E25F79F;
	Fri, 28 Feb 2025 10:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="FWdl9j2M"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5F525EF98
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 10:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740737124; cv=none; b=ZOj4nCEEh0xAM6Bp0J5OVm7j3H0dZ5HlBJfgbRGDXEu8XXI9Qml+xBaeKYhwWIbvUA7oCZcnZp2PhFkIC9YmbQdXo58gR5zcCCSP2wJHroVV5W8wRoD1c2wIHgKfsZ5HAPkGKxt4mDL8WqonrQkeoFQXAQf2U2wrGn+FEg9OpPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740737124; c=relaxed/simple;
	bh=uHFsJM0pfNgPoK7BchW5gfPzCuDVUIKH8FGSfezzGFs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z34Vibzm12WhPypwZoVHdyHoHhbGdYs3TXtpgu96BanInecW7qnRE80N6kYXY6HHksheCfPiz/rVQEUxgi/8g/yLTBgweBFcOnqpL/7aeRqTC+UmFvs+yN7H8b806MNKIz8BRA1joG+gqtlFvwsOe4AkKJDCaEqffmZrMsS6T6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=FWdl9j2M; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43aac0390e8so12534825e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 02:05:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1740737121; x=1741341921; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e+IOeTcr9FfXN1x3TbZ/IOmE3A4E01KQFs0hhzxybEQ=;
        b=FWdl9j2MwlQjTZ2AbD1Xhin1Nsrr6wjVmk2wzK2CGvNfI5fwj6xUXX2Dk4L3/vD0Lh
         +G95jbXQIPir5476KSoOe97oTspKu61U+TjvxEM9InxS2HUbWRDjHY0G6D9uHir2RysY
         Kkdp0aRRFYPxQ+DLhjELKhtFN2hXa8icxmQzDH8UwTJhrhRuL0COHOQflt7lx7BZZBut
         PDEqBKDL+Idq8Por9RTGH7H0TMI3JwNk/eqJvL7pLBhYJnwCA8jifauShzF04R51Y8tV
         VSgBzJzVy3QM8bdZ4HNUWonEdXAq55ALLxF5z0MXYoY4QLc7fZK3f1Nlw6H0bbil3FTO
         bFlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740737121; x=1741341921;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e+IOeTcr9FfXN1x3TbZ/IOmE3A4E01KQFs0hhzxybEQ=;
        b=YiIUPBAyD5cf7AD4egpr96ZGFRmm6MeygD1Wiey1QRXoK/SlCziEBSJ3W9dtGF0Tym
         r4ETMApYw9iQD+GA14o+O1kd1xKKpuE4IHqZ42xzA+QEydyxx47bJjz3qApNUHlbrlF3
         lyUGPCF0Zvw/uf14NgtY4IT35vvr+D4rzrWjiTFejkZ7nuwSKhVlbt89X5b34nAYqPW0
         sWsjaUE+6hD+Xvgjx78iNzGHJLCGp6nshPzx4NjsxmrCuEngg3AcC7/DOdl/HAeyAVaI
         e5+57nQ/V9rK8H50NTYZBLYzeGIzBXKLjUZYaTWheSymRvqcJIussRED2FU10sy1xz/A
         KlHw==
X-Forwarded-Encrypted: i=1; AJvYcCV1gNwEb2bbWQQlqjeamqU9Xr1IdBfeheraXEB/Cf7i7fmd8vxmyLwnwBf6+UggOixVXjwL48cYhVRZjkQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7+twKK/T9CAyzIXibwIZG5Xbgdc8I2xLZ4xKT9XNl3sdak/cO
	kj12WsLFyrcNvcawMtGixjbkRtbbw6w0jf9H1/nxPdjMFjBK9LRt+aCIp70+9gk=
X-Gm-Gg: ASbGncvMewqmysNEww0a9S/4eMOTDGZynixLSokik5jvKlQuCssMIN/QvExpSSwn2ap
	VUNAwbewjHxGlDj+xX2qKA5EVf4k/Wqj3BM4hddCLbjHKNjqfaM6eYBwJRuPujIdhBcDGQn4ZUH
	tVDs5CPDrb2kqpqv3pG4v5Nahot2trl6r12sA+Y+4MXcHzuAFkWKUXSJg3at/y0pKJiX7qPlsRc
	zqDxZJvWHxxTigwHnee64bDm5/glkeJzh5Q1AAFJ3cleCQjriPrlZXel8vFEvKePSEJeNaIrJLW
	NZzpJWQK1oYhoHVI2rmdV9TomWjZtOzmGIa+irod0iOKIz5NBQ==
X-Google-Smtp-Source: AGHT+IE69qTlkoNt4bspwaYMdtuQZJWRdcUX+kKKFK2kdN0wtA2YKvEEhK7r9HujXCouvoyFJ9xmBw==
X-Received: by 2002:a05:600c:1550:b0:439:9f19:72ab with SMTP id 5b1f17b1804b1-43ba67583ecmr18766255e9.23.1740737120817;
        Fri, 28 Feb 2025 02:05:20 -0800 (PST)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43b73717230sm49964945e9.19.2025.02.28.02.05.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 02:05:20 -0800 (PST)
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
Subject: [PATCH v5 1/1] MIPS: Fix idle VS timer enqueue
Date: Fri, 28 Feb 2025 11:05:09 +0100
Message-ID: <20250228100509.91121-2-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250228100509.91121-1-marco.crivellari@suse.com>
References: <20250228100509.91121-1-marco.crivellari@suse.com>
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
index a572ce36a24f..474738d9124e 100644
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
+	/* start of idle interrupt region */
+	MFC0	t0, CP0_STATUS
+	/* Enable Interrput */
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
+	/* end of idle interrupt region */
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
+	/* 36 byte idle interrupt region */
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


