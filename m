Return-Path: <linux-kernel+bounces-536461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C585DA47FE2
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 14:49:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3525D188351F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 13:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D15235BE4;
	Thu, 27 Feb 2025 13:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fz/wdMuo"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A769721661C
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 13:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740663956; cv=none; b=Y7zcuhEEb+Vgj9QEvvfUHwISPkf/uGI50os/4wuUCZ+O59Ob27D35P+/N99YIscU8weUJ2eKXfwjTYuwBy5xusBNB6TpdOCpkYPK7ndP+Jss/kaYpozNDWaCZZnT/v+FTaYGmiQ4LeH4TGScKIWykACsVs48X7dwbqds/ol+Zag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740663956; c=relaxed/simple;
	bh=Ec09eJ1CRZIBn6T4Vf9gXv28y9nj2KSUGj2pvnp6G00=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aBWn2MaQijcYegvEVCzTtjeB54qfIEXG9IGfj8T/l7+x50ueebDrX3122vmUj2H0KERs0Sr9XDmsMyEJ7cSzVFvuptDFAgiQxlt1iV2fxaONsHkR5gwAjr9J04Hht5lUd/3SYzm6l5UT2lmUGdCCijPNSCmThJUAVWD/10sAlp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fz/wdMuo; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-38f24fc466aso568975f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 05:45:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1740663953; x=1741268753; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8W7IVAQyOFZ0GLVc1LIzLOYXQ/PhXwp+HbqtOmV4njM=;
        b=fz/wdMuox3rPKIytCjeCI8jW44+UNRz/irSf1YlSpEG3+NGxSNA0A6UvPDxALLKLcc
         iUCMAY1yMcobROVY3r3+qUxRJg40w8EvJlOu3hPuPpjdAM+biK8sYuioJOcj3uDpHg8O
         +o+W8uhsDFyWch9rKiAQBkgNAwaN92SoTIya/qfS4l+sP4wwupiICJy/9Ox1mQ1w9CcU
         YEAYWW4WTOS1U35hKMg1BejRDBo11F4peHSO1u73+l/hwQOt+hxmMkOPiQdFJccb0eS+
         bne/v5eWSieQucb8PafaWcUSM4SRRbyjymqoQ7wgGP4wGDNqJTv/vq0XLsMIyPFlJK3O
         4Dkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740663953; x=1741268753;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8W7IVAQyOFZ0GLVc1LIzLOYXQ/PhXwp+HbqtOmV4njM=;
        b=UqmCuEsb4W5X+2JgyAFMSrooFQj50p1d1K+3LH5UgEBu6HOawcf0zSvRfot5BRlum7
         NaRI4gpJads0Zaq1YBibrgXUoU6yJ49n+AQWZwyJ2uep4zHpOPzVg6ZXbOOGCq2HSkft
         2KRqZnGxqS+U7uD1PfprlN6t8vkgLjR2Yt7iG4izJP6Y+OnJKL4UmktwKeYQfubhQxwv
         YGSdNS5nT1yQNFOCwniTnMRo/b+rHjblX5AoY8NXsHIbAKdabYVCMmhVZEO/RxhG4Ly2
         3wdsZ3wp2auS7mAT2gGjdgPkXSW3MGsKw09iWxcLN8oF+4ov6slN8Dw3rXzihXrYoMZy
         kiRA==
X-Forwarded-Encrypted: i=1; AJvYcCXbgRoSZeCL3Yd8PG3MLr4yJhy3tIHgR4Aon39CBJiM/BGg5qjujrY3HNh1FEdCSrEgdzWSTIhB64V1nkQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx47oCZqNp5JC3EhWvZlKMOvRJbELXXpmY1ViimWlnjUkh/pbnT
	7LsmF3sQxnPwf1uYZC2Hi438L65N45zHJRMutjwBLohSkH1EcZqP7VicX50GkRybIKKkyZfhbBo
	n
X-Gm-Gg: ASbGncvlvhkULt5C61fBkOmmmg1VMNNIZqH6l+uo3BcyIG6qXdZU9/cyd6OlWnd1k6R
	s0q50krXDtyjw942PrVTxfzpvXVeWqAALXrzFzC/RjVuts76MtNIZcyDHi35RTxfykMcmpz3o9x
	ae+lL63bp1tJLgRHtrqZzFk2MMOJkBnu33SXrayoAztMN8OMJuLPfCeikUArnFKPhVmpR6JMXK7
	4XYX9T0D1p+TggjCQ9g4+khLEczthqBNajjf4ZqUOsoioiwiXPkMRjTa9IiibiLc2ow5LFBSyuu
	8MCLj0Xh3eP2J3i3i80MP6Fsh8Mdmsgd9rQhzQ==
X-Google-Smtp-Source: AGHT+IFG1/Rg83AMpBCfNFDXDfKpe7UwsDccCQZjNJy6YR3qHM3cj/0DW8MImNcAZikLJiTiB9cKhQ==
X-Received: by 2002:a5d:6c6d:0:b0:390:ead3:d13d with SMTP id ffacd0b85a97d-390ead3d3fcmr315462f8f.16.1740663952929;
        Thu, 27 Feb 2025 05:45:52 -0800 (PST)
Received: from localhost.cz ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47b7b6asm2174595f8f.51.2025.02.27.05.45.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 05:45:52 -0800 (PST)
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
Subject: [PATCH v4 1/1] MIPS: Fix idle VS timer enqueue
Date: Thu, 27 Feb 2025 14:45:39 +0100
Message-ID: <20250227134539.267169-2-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250227134539.267169-1-marco.crivellari@suse.com>
References: <20250227134539.267169-1-marco.crivellari@suse.com>
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
index a572ce36a24f..5e333cd27fc7 100644
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
+	/* end of rollback region */
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


