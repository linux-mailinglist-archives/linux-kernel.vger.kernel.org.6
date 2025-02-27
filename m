Return-Path: <linux-kernel+bounces-536176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89B64A47C6C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 12:42:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 388193AA166
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 11:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0762122C352;
	Thu, 27 Feb 2025 11:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="S4/H1GK9"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6AB22AE7F
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 11:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740656517; cv=none; b=HNcgg0iszcj5gVqssuZxMr8G70mrNV1w6qhFsgG67ceU0AQQqFn8ZuwOhgyk8z4NiQlSMpqkEsh54dh5OqWXg7JLH9t567y0Ag8AOG+h8xI5MisWUEZ2q72cCXIsSHIwfXhBYVvMFIVifkmfxrdkBMvk6OszUvWGW/J7HJAAZsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740656517; c=relaxed/simple;
	bh=JhL4VgHuPPPEuyz31SdjmZkHfh6Eby4oiSU8+vRSwCI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UiPHvJnJwiIjzatJ3ryTcJCmSNhW5FLiVFekngSCSoiJDStqZj57K7jTVxwl6vD1QrdCygTSRcVA4gcxebJSEjn2GsLu15AQSvXzb/AvsgrguRxoGSFTnUhpXsw8eaiiswiI8skvYDew293dMqC9SwgQF4SMvnTl6tVe+IyCdYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=S4/H1GK9; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-38f3ac22948so402001f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 03:41:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1740656513; x=1741261313; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BRh+H2PuFgTlD64uCNpuQxP5luq67fhWyXvs8/VrBHU=;
        b=S4/H1GK95/UUCKnOrUkFEeQ4lzTCLf4GgBAVj3ahRSBS3urAqXBmQkwC41V1DXrprP
         8eYnreZQJxWVhrJM7FnQDEQGDeLj70S4Z5htf6obO3o8+Rm6pYn8WRPdbDNjJ188YAzf
         bVSjo2yYm+qFjISLX6XjR6SaHw3+OHKWR1noYR4qOb90DsYLewRq2FOKjkLl/hcvJaaI
         9IkaYN7/6ihKIxCsiu/q7zbFa+TBBMls/CYj0CBKzlm5YA2ZdI6iAQJiaMM++SA3nRwc
         0S4OE0O6tQLzmhNbt+EXvZbxQvvJvjgsYjpaogdhK9wdtJtVvFv8Lk2SqZaMfIJwBCTM
         EFaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740656513; x=1741261313;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BRh+H2PuFgTlD64uCNpuQxP5luq67fhWyXvs8/VrBHU=;
        b=lSl4r+c48wjlrRbybkNP7oRPBp6oYKmm3Afvv1TCHxD4vn+vessO3nRb2ncKZ6qE6r
         eCT/KudKz/usy5iYMsP/5EK17L10neJwd49+wx5B+d2Ds8OzutA7AEW5+h6oJuEMPx6x
         rl0heYFX0AmIic8v8Pv4qlijvOF3yGDdfCdHBZXTwYCXFXINKBE4IXWYTLdYWnujtdXh
         BQrnG2vTPRRy/CONlr9R8zm8GF6Aizn1eiVWJzlVIulndmcz0KGF8Rys1jsFL/M3vG55
         96RDk7nk+fK+3McY/0RpclmFXcylNc5Sn1sujoM0C0u1sn+ffPbKz9MIE0LjTmDC7W1Q
         uEXA==
X-Forwarded-Encrypted: i=1; AJvYcCWl75vHERd95Sp2lkOgAt5tTyGHkH7Ypt9oBYWWiuXaCxkPrattwvUF/tYIYfrTAz2m7r58YAvSWlG3OgU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmOORAHAJ6gIxh4xLXkuzB4+x39HuTNcfZf+wBTAEA41GjxrvB
	DcgnB5e0LiV36qmJ0/wwfH1rSsO04QYV1gIHx9YXp4v/2M1mtFIRKRJv878WYtw=
X-Gm-Gg: ASbGnctTYAm9P9NoiHfHb8+ccv9n6YrFZdSFIwF5bBd+zCyPDiy0isTKa/MH/YDxT49
	LuPk0VCixPJPiMm7CGuVApGy9GpvTsytHVK6AHKa542F7N6lHoaOKbB59ulPC0Jv5wqvO9RdUMR
	WRc4Nv2IR1QHBocryzSQdKrV4sx0VNqa5xb7PWv7GdewHu2SmaU4LXG3AtXy19SBn856HEeqJIA
	QQvXydj/OlZ67T/rP0ZD6Y7UuV6V2dd+oB7I2m8bp+wtbjFJTwjojTo4bUNdemOUoKw4SsFFfaI
	Bd4c9JVHS8LVo3Zm1MTznRyCZIAvp4Xs+2y/bSPrROEQteqddw==
X-Google-Smtp-Source: AGHT+IE6oX22O1927G0yOyFo0W8zGGk0bK+1h46WjJ6OxMU8SWwnc1ehnwdi/fI8b6GICCoxgoVpFA==
X-Received: by 2002:a05:6000:1864:b0:390:d954:5e7c with SMTP id ffacd0b85a97d-390d9546117mr6173503f8f.38.1740656513579;
        Thu, 27 Feb 2025 03:41:53 -0800 (PST)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e485d6cdsm1738374f8f.84.2025.02.27.03.41.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 03:41:53 -0800 (PST)
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
Subject: [PATCH v3 1/1] MIPS: Fix idle VS timer enqueue
Date: Thu, 27 Feb 2025 12:41:41 +0100
Message-ID: <20250227114141.242421-2-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250227114141.242421-1-marco.crivellari@suse.com>
References: <20250227114141.242421-1-marco.crivellari@suse.com>
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
 arch/mips/kernel/genex.S | 40 ++++++++++++++++++++++------------------
 arch/mips/kernel/idle.c  |  1 -
 2 files changed, 22 insertions(+), 19 deletions(-)

diff --git a/arch/mips/kernel/genex.S b/arch/mips/kernel/genex.S
index a572ce36a24f..7b66ab239049 100644
--- a/arch/mips/kernel/genex.S
+++ b/arch/mips/kernel/genex.S
@@ -104,25 +104,28 @@ handle_vcei:
 
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
 	/* end of rollback region (the region size must be power of two) */
 1:
@@ -136,9 +139,10 @@ LEAF(__r4k_wait)
 	.set	push
 	.set	noat
 	MFC0	k0, CP0_EPC
-	PTR_LA	k1, __r4k_wait
-	ori	k0, 0x1f	/* 32 byte rollback region */
-	xori	k0, 0x1f
+	PTR_LA	k1, 1b
+	/* 32 byte idle interrupt region */
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


