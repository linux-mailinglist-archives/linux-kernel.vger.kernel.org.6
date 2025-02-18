Return-Path: <linux-kernel+bounces-518948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE3DA39672
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 10:06:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89574161AF8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 09:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66ECF154C12;
	Tue, 18 Feb 2025 09:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="E1pWsDW2"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25ABE14BF8F
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 09:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739869341; cv=none; b=KPWBMfP0Rk0l/mS4wBf5GcXBpL7LAB9gB95Qht5g4DFguoYGIWYmux82lYTscw8X+5T/HuZmUfyTPqVTPqeyuH5TANGo3yv4kAFc/b2rbO/Z0xIVEO0JMha6de+8tkV2FhMBZyIrjg204gxBQDwmbZEo5hp+w6v+uZ+TtXQHGIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739869341; c=relaxed/simple;
	bh=Toj4I6NC5ptab4sOdsBMncNyFTi9IkwbkiD1DeRYZtk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G7PmKHZdtFznetU/fi6hryOB4FMFknCWyzowsOEtLCpghCGiGibYa8gJa43BVlHvNrVHhoC1vjMxYChgcNRpF+AaR/N2UjEijzdOkJmDqCVrwSrdu3YVVwFSjMYmgTBoBWsSM2gI+zLPycXUqU4kOf3ENCzshJFmqIMpQ+YHnk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=E1pWsDW2; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5dec817f453so8950393a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 01:02:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1739869337; x=1740474137; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ttk4YP8xSl/O/+/qQANH1g5R8r3FoMRWMrYgr2MYIQU=;
        b=E1pWsDW2qf8RzCBJM0hePsW5wwc+F1ua0eQexEcvn530hmzhh0HuVpZrEN2qBCXUvQ
         0LtpiphpsU2+9Us0e4dQ0SeJppX8sqxmv4eI3Ac4OKFxucoPLP7vjNFrBuLdzSbv/5xb
         LUlDWQNzpRKnE8tx7z6IlIDEvD61yLM1jhJ3pxqe1AKi7YNlBpsu4TerpRu6qy5IkwwF
         WgaUWNq7oD7FmXThnpz3pvzFAUnHo1Ob1LSXc7jjEftdrD3rWAn5wgh5jLV8/QiUHWzr
         OpCvMTNmkOK8PN+MhCdqR2HGd4rqpkeS5ngnKMtNNwWr44tOIBpy2J32HXdPszvH8US9
         +ZKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739869337; x=1740474137;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ttk4YP8xSl/O/+/qQANH1g5R8r3FoMRWMrYgr2MYIQU=;
        b=pA6UZZrDHTycBYcxAkwhFO+kbitkQUzRrBgOaw1pXooMF7UmmJk/2ShW6NnHZ3Ma/a
         mEyKyrbACSAxUbyhtR4ktXdAykPUE6r9me477E/bgQKISn1nyox2xB+6ech7+Q/OlTTO
         ssbayzQ/ak5rAMj0MFcZ4WI/LuLP6ftjGlBTXogeBDYriiX+ZLoc7u3jtUatMP2F82VN
         uYJGl9xLp3xKrr2VgIfhjzaOwAdGv06CKXjtnoIfNhj1Iy9P1yyatBiXTV11QwuhvekQ
         Y3qWcw1P1FDPUchDlGDgX4zq3IQqFdHH6/A6HkNu9h9O4Ni9arNYidl+mFeizHwppCig
         mSeQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7jLdvgicoz+eSF1P8J3N62e0+pLGKtOh3SJMltkI+39CG+qaircKS2yCawy9H5zBhnnFwz3oIL47tQMU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr+mE8KIkyydKEefLqujOG2SFGV9tZSUQLIyigbdd0dW1tZdEF
	VH3zGKepm7caTHtDEpd/DpG8/4+ovyX97/lm7XTQQ/cooBe0QTvORE9jNyEZkl9P2+SkJs1P30i
	i720=
X-Gm-Gg: ASbGncvpVkPT5xOUNPWzRjPOvY+8qrPwoy1o5fx10BrmVOF0ivhKxuoOre4kcCAvPF9
	LFLj3J5FXr+CwOe78mU6MDcN42Jl40N+TX3Wch3JzITeX5lE3JgZrM5QPmCWpmDIDyJOYgvXAzL
	wOU3zPBxywu2DlIC7tkgYsbY8+heihfmbEeM7zgL2CVQ3y4C9xZQ+HIi2jABHxr3DEhXSXRrXBx
	g0XGyN68hpJRiyMZkvzWljlFeSvVTEpSzYCBxxQ1sg9t74HgsK6wO7/qIR6cuyFT6g3lTPlqc84
	i5yv9awE9i8echeQy4r8y4EYlPpWIM/MzOknW8A=
X-Google-Smtp-Source: AGHT+IEB18NezBAHpLOszPR7ZDRgDeDCo9SoFwSzOoZiQ+7tTjhHHgGdsHdnmldp/nJwW0VLEkJU0Q==
X-Received: by 2002:a17:906:318f:b0:ab6:eecb:41f0 with SMTP id a640c23a62f3a-abb70dda6c1mr1221775366b.35.1739869337342;
        Tue, 18 Feb 2025 01:02:17 -0800 (PST)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb89ac2e27sm477482966b.80.2025.02.18.01.02.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 01:02:17 -0800 (PST)
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
Subject: [PATCH v2 1/1] MIPS: Fix idle VS timer enqueue
Date: Tue, 18 Feb 2025 10:02:03 +0100
Message-ID: <20250218090203.43137-2-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250218090203.43137-1-marco.crivellari@suse.com>
References: <20250218090203.43137-1-marco.crivellari@suse.com>
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
 arch/mips/kernel/genex.S | 39 +++++++++++++++++++++------------------
 arch/mips/kernel/idle.c  |  1 -
 2 files changed, 21 insertions(+), 19 deletions(-)

diff --git a/arch/mips/kernel/genex.S b/arch/mips/kernel/genex.S
index a572ce36a24f..9747b216648f 100644
--- a/arch/mips/kernel/genex.S
+++ b/arch/mips/kernel/genex.S
@@ -104,25 +104,27 @@ handle_vcei:
 
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
@@ -136,9 +138,10 @@ LEAF(__r4k_wait)
 	.set	push
 	.set	noat
 	MFC0	k0, CP0_EPC
-	PTR_LA	k1, __r4k_wait
-	ori	k0, 0x1f	/* 32 byte rollback region */
-	xori	k0, 0x1f
+	PTR_LA	k1, 1b
+	/* 32 byte idle interrupt region */
+	ori 	k0, 0x1f
+	daddiu	k0, 1
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


