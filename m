Return-Path: <linux-kernel+bounces-220838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F18090E7FE
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 12:12:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E9421F221CD
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 10:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2213812FB37;
	Wed, 19 Jun 2024 10:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="JhNZRKjD"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261C082494
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 10:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718791934; cv=none; b=fwcikOjAQxS737dXtsHtZLFSm3RS/CsEb11IAUjjajWGTOJMNIUaWwXl+Zpz43gNQiUrq113xQhkPR6ZrHjpBzwpNATmfd2VGFgHih04CZAkOA/mIFsrSq/pj/Pitji+VDhvsoupCWjL85EnIIIB7H+wxffcSNXfL+I9kCJ6YEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718791934; c=relaxed/simple;
	bh=stG4EosrRZoLl+rGkaCdgcYZ2i4JpRbIXzGPd14Nook=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gphi7ci/YEd7WjtjLw2/aLEgg/mYqD/8HaHawdK4lrnhVRklV01gzWPtKO0ujtNAlg65BHZpHyPpBiRvCOrwN2Hb1TrxdRRRdXfdG43+iGp2BDqtONK6nMvvSpboOckVsgy8FEZVvL+K1PqyWLdWC2lX0DHhCMeHFtBzfzgBO3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=JhNZRKjD; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42249a4f9e4so45941785e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 03:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718791930; x=1719396730; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fWXZAlLTUOX+tTobWucYGS5J3I+aXFzRea0PJgB3aYU=;
        b=JhNZRKjDKrGGojub8BBT2dLvMIYwLNbW6sZ3CkPa8xXXytbzSy7JohGaFSwOdvJROR
         rBA2iPvw9SYnh54b5rCxm7KoPCHR1SK7NOCUa8Hy22a7whbMp9+5wTF9BCKCHwta7M1+
         r7z335YXFzlR/GZiD8P/wQp70fXmAvFMck28YA7oFZH/WPAtS4sNrEhaBJIX6I69UYDP
         nxbglpIkGZWYnCQcdAYb3lKbTS0qgJt24GvSLMfHshDzFmhmxWAFP/4uWcB/QV1RvGzj
         R8pSrDxb+esbYqad8wPMLA0+ntd/yr4SYQTAM3gwOH10jjqhDqmxYqCpCG2AQQ4A7YEr
         LQSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718791930; x=1719396730;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fWXZAlLTUOX+tTobWucYGS5J3I+aXFzRea0PJgB3aYU=;
        b=Bdm+ux4h5qZtfe0pBfv0JgiX/P7XwWzZZv0DZAJ3jOig1Uncd1VEg51yqcoEGSsaFV
         i6bu6S4RC6ofnjVKS7MZXIbl021+zdGQRO6NpWF8t0ckf5v7q5Eo6zGCMhmI7fLAaoh5
         +dYqzbtDusvBKcEwrDyY/pctf04+waebqruDqUzElMsGP5SKovnTRD1RoDjpDs7yQ0t3
         QuG60/QbzHAEtM0AaHfQQkYobUmOfbRgq0sYFYm+mJSuSIbK39plthyGEtMlNypAUVXu
         7oWnZQxBfLNM00cd9hU6HI/3dPEgXWxtQArxMuxUOZ+Z5y6vrHf3KQWd7IlvAELUpUnq
         nIZw==
X-Forwarded-Encrypted: i=1; AJvYcCXD7USXdbqdUkJFis+dE8w+dr19Fcor4sZpdf+kt1Q7J8/aseM1mj8k5BN6SjBsO1pxdc8r7LOJrU9Xaiih3gmusiiU4SgP8cGbz+GV
X-Gm-Message-State: AOJu0YyUkpKfnmrFpWq5uof7oTjWyIZJVpoQz70nVnjjOz3GheW+Wm51
	oOdMUNGVdulumCFi8yh7m5riD7Mc2HNeLWAeSkErF/IcGXLR4zTBYG+jf5zgmjA=
X-Google-Smtp-Source: AGHT+IHIxrQqbYiuGPGtgLfNvQ8yNK+7Isq3Mu1k2EywX94rSO7C16VmJUJD0LF/8DIYPtV/McCtnQ==
X-Received: by 2002:a05:600c:4652:b0:422:615f:649e with SMTP id 5b1f17b1804b1-42475298ba0mr15577755e9.27.1718791930619;
        Wed, 19 Jun 2024 03:12:10 -0700 (PDT)
Received: from localhost (p509153eb.dip0.t-ipconnect.de. [80.145.83.235])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3615d7a1a0csm4234227f8f.23.2024.06.19.03.12.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 03:12:10 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	William Breathitt Gray <wbg@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: linux-pwm@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Thorsten Scherer <T.Scherer@eckelmann.de>
Subject: [PATCH v2 2/5] mfd: stm32-timers: Add some register definitions with a parameter
Date: Wed, 19 Jun 2024 12:11:43 +0200
Message-ID:  <05df15f61dde81033407d3b4fcb67ee403ecc8db.1718791090.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1718791090.git.u.kleine-koenig@baylibre.com>
References: <cover.1718791090.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=6869; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=stG4EosrRZoLl+rGkaCdgcYZ2i4JpRbIXzGPd14Nook=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBmcq7k0muWLeHuQ6CBwgj3N6qOjE3WGeJGtti5m ryq8Pb9UQKJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZnKu5AAKCRCPgPtYfRL+ TumdB/45ANiIOKmrxtVh0tAsSOvCQJW7uCAA6Y6U4alc+bMWmJzMzms7t1yeL8+ytmfgYESjlKY xeZs7/c/s8Qh75yAh63Qk/kRytlJj6ChbwmFSQqKIZHVzOKkdyMxDCjWgobMO6C0k8uKBGYbnfP yWCc1L/wLfg7UKYkwzbq8xQUXxnz/Me59MYkgc52zwQHs3jbLIgMU9QTBiIzqlMWytuc+udR5Su bDdMiKZS1Q+MVX2MqR5Ros+Oidq/DKoCGgqGX4Qv2xZxMtk0I/XRsDHrM9ZOeTCk76VvlTbkGYG eNlg+EWaBcbWpmtfERFdUlOmQUUNvXNzLo/wAOH4OFKXES74
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

There are some registers that belong together and are numbered from 1 to
4. Introduce a macro definition for these that takes the channel number
as parameter and define the previously available constants using the new
ones.

This allows to simplify some users that up to now use constructs like

	TIM_CCER_CC1NE << (ch * 4)

which is an ugly mix of using a predefined value and still knowing
internal details about it.

Note that there are several decrements by 1 involved. These are
necessary because software guys start counting at 0 while the hardware
designer started at 1 (and having TIM_CCER_CCxE(1) be TIM_CCER_CC2E
isn't a sane option). The compiler is expected to optimize these out
nicely.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 include/linux/mfd/stm32-timers.h | 60 +++++++++++++++++++-------------
 1 file changed, 35 insertions(+), 25 deletions(-)

diff --git a/include/linux/mfd/stm32-timers.h b/include/linux/mfd/stm32-timers.h
index 5794110b2b28..92b45a559656 100644
--- a/include/linux/mfd/stm32-timers.h
+++ b/include/linux/mfd/stm32-timers.h
@@ -24,10 +24,11 @@
 #define TIM_CNT		0x24			/* Counter				*/
 #define TIM_PSC		0x28			/* Prescaler				*/
 #define TIM_ARR		0x2c			/* Auto-Reload Register			*/
-#define TIM_CCR1	0x34			/* Capt/Comp Register 1			*/
-#define TIM_CCR2	0x38			/* Capt/Comp Register 2			*/
-#define TIM_CCR3	0x3C			/* Capt/Comp Register 3			*/
-#define TIM_CCR4	0x40			/* Capt/Comp Register 4			*/
+#define TIM_CCRx(x)	(0x34 + 4 * ((x) - 1))	/* Capt/Comp Register x (x ∈ {1, .. 4})	*/
+#define TIM_CCR1	TIM_CCRx(1)		/* Capt/Comp Register 1			*/
+#define TIM_CCR2	TIM_CCRx(2)		/* Capt/Comp Register 2			*/
+#define TIM_CCR3	TIM_CCRx(3)		/* Capt/Comp Register 3			*/
+#define TIM_CCR4	TIM_CCRx(4)		/* Capt/Comp Register 4			*/
 #define TIM_BDTR	0x44			/* Break and Dead-Time Reg		*/
 #define TIM_DCR		0x48			/* DMA control register			*/
 #define TIM_DMAR	0x4C			/* DMA register for transfer		*/
@@ -41,16 +42,18 @@
 #define TIM_SMCR_SMS		(BIT(0) | BIT(1) | BIT(2))		/* Slave mode selection				*/
 #define TIM_SMCR_TS		(BIT(4) | BIT(5) | BIT(6))		/* Trigger selection				*/
 #define TIM_DIER_UIE		BIT(0)					/* Update interrupt				*/
-#define TIM_DIER_CC1IE		BIT(1)					/* CC1 Interrupt Enable				*/
-#define TIM_DIER_CC2IE		BIT(2)					/* CC2 Interrupt Enable				*/
-#define TIM_DIER_CC3IE		BIT(3)					/* CC3 Interrupt Enable				*/
-#define TIM_DIER_CC4IE		BIT(4)					/* CC4 Interrupt Enable				*/
+#define TIM_DIER_CCxIE(x)	BIT(1 + ((x) - 1))			/* CCx Interrupt Enable	(x ∈ {1, .. 4})		*/
+#define TIM_DIER_CC1IE		TIM_DIER_CCxIE(1)			/* CC1 Interrupt Enable				*/
+#define TIM_DIER_CC2IE		TIM_DIER_CCxIE(2)			/* CC2 Interrupt Enable				*/
+#define TIM_DIER_CC3IE		TIM_DIER_CCxIE(3)			/* CC3 Interrupt Enable				*/
+#define TIM_DIER_CC4IE		TIM_DIER_CCxIE(4)			/* CC4 Interrupt Enable				*/
 #define TIM_DIER_CC_IE(x)	BIT((x) + 1)				/* CC1, CC2, CC3, CC4 interrupt enable		*/
 #define TIM_DIER_UDE		BIT(8)					/* Update DMA request Enable			*/
-#define TIM_DIER_CC1DE		BIT(9)					/* CC1 DMA request Enable			*/
-#define TIM_DIER_CC2DE		BIT(10)					/* CC2 DMA request Enable			*/
-#define TIM_DIER_CC3DE		BIT(11)					/* CC3 DMA request Enable			*/
-#define TIM_DIER_CC4DE		BIT(12)					/* CC4 DMA request Enable			*/
+#define TIM_DIER_CCxDE(x)	BIT(9 + ((x) - 1))			/* CCx DMA request Enable (x ∈ {1, .. 4})	*/
+#define TIM_DIER_CC1DE		TIM_DIER_CCxDE(1)			/* CC1 DMA request Enable			*/
+#define TIM_DIER_CC2DE		TIM_DIER_CCxDE(2)			/* CC2 DMA request Enable			*/
+#define TIM_DIER_CC3DE		TIM_DIER_CCxDE(3)			/* CC3 DMA request Enable			*/
+#define TIM_DIER_CC4DE		TIM_DIER_CCxDE(4)			/* CC4 DMA request Enable			*/
 #define TIM_DIER_COMDE		BIT(13)					/* COM DMA request Enable			*/
 #define TIM_DIER_TDE		BIT(14)					/* Trigger DMA request Enable			*/
 #define TIM_SR_UIF		BIT(0)					/* Update interrupt flag			*/
@@ -70,19 +73,26 @@
 #define TIM_CCMR_CC4S		(BIT(8) | BIT(9))			/* Capture/compare 4 sel			*/
 #define TIM_CCMR_CC3S_TI3	BIT(0)					/* IC3 selects TI3				*/
 #define TIM_CCMR_CC4S_TI4	BIT(8)					/* IC4 selects TI4				*/
-#define TIM_CCER_CC1E		BIT(0)					/* Capt/Comp 1  out Ena				*/
-#define TIM_CCER_CC1P		BIT(1)					/* Capt/Comp 1  Polarity			*/
-#define TIM_CCER_CC1NE		BIT(2)					/* Capt/Comp 1N out Ena				*/
-#define TIM_CCER_CC1NP		BIT(3)					/* Capt/Comp 1N Polarity			*/
-#define TIM_CCER_CC2E		BIT(4)					/* Capt/Comp 2  out Ena				*/
-#define TIM_CCER_CC2P		BIT(5)					/* Capt/Comp 2  Polarity			*/
-#define TIM_CCER_CC2NP		BIT(7)					/* Capt/Comp 2N Polarity			*/
-#define TIM_CCER_CC3E		BIT(8)					/* Capt/Comp 3  out Ena				*/
-#define TIM_CCER_CC3P		BIT(9)					/* Capt/Comp 3  Polarity			*/
-#define TIM_CCER_CC3NP		BIT(11)					/* Capt/Comp 3N Polarity			*/
-#define TIM_CCER_CC4E		BIT(12)					/* Capt/Comp 4  out Ena				*/
-#define TIM_CCER_CC4P		BIT(13)					/* Capt/Comp 4  Polarity			*/
-#define TIM_CCER_CC4NP		BIT(15)					/* Capt/Comp 4N Polarity			*/
+#define TIM_CCER_CCxE(x)	BIT(0 + 4 * ((x) - 1))			/* Capt/Comp x  out Ena (x ∈ {1, .. 4})		*/
+#define TIM_CCER_CCxP(x)	BIT(1 + 4 * ((x) - 1))			/* Capt/Comp x  Polarity (x ∈ {1, .. 4})	*/
+#define TIM_CCER_CCxNE(x)	BIT(2 + 4 * ((x) - 1))			/* Capt/Comp xN out Ena (x ∈ {1, .. 4})		*/
+#define TIM_CCER_CCxNP(x)	BIT(3 + 4 * ((x) - 1))			/* Capt/Comp xN Polarity (x ∈ {1, .. 4})	*/
+#define TIM_CCER_CC1E		TIM_CCER_CCxE(1)			/* Capt/Comp 1  out Ena				*/
+#define TIM_CCER_CC1P		TIM_CCER_CCxP(1)			/* Capt/Comp 1  Polarity			*/
+#define TIM_CCER_CC1NE		TIM_CCER_CCxNE(1)			/* Capt/Comp 1N out Ena				*/
+#define TIM_CCER_CC1NP		TIM_CCER_CCxNP(1)			/* Capt/Comp 1N Polarity			*/
+#define TIM_CCER_CC2E		TIM_CCER_CCxE(2)			/* Capt/Comp 2  out Ena				*/
+#define TIM_CCER_CC2P		TIM_CCER_CCxP(2)			/* Capt/Comp 2  Polarity			*/
+#define TIM_CCER_CC2NE		TIM_CCER_CCxNE(2)			/* Capt/Comp 2N out Ena				*/
+#define TIM_CCER_CC2NP		TIM_CCER_CCxNP(2)			/* Capt/Comp 2N Polarity			*/
+#define TIM_CCER_CC3E		TIM_CCER_CCxE(3)			/* Capt/Comp 3  out Ena				*/
+#define TIM_CCER_CC3P		TIM_CCER_CCxP(3)			/* Capt/Comp 3  Polarity			*/
+#define TIM_CCER_CC3NE		TIM_CCER_CCxNE(3)			/* Capt/Comp 3N out Ena				*/
+#define TIM_CCER_CC3NP		TIM_CCER_CCxNP(3)			/* Capt/Comp 3N Polarity			*/
+#define TIM_CCER_CC4E		TIM_CCER_CCxE(4)			/* Capt/Comp 4  out Ena				*/
+#define TIM_CCER_CC4P		TIM_CCER_CCxP(4)			/* Capt/Comp 4  Polarity			*/
+#define TIM_CCER_CC4NE		TIM_CCER_CCxNE(4)			/* Capt/Comp 4N out Ena				*/
+#define TIM_CCER_CC4NP		TIM_CCER_CCxNP(4)			/* Capt/Comp 4N Polarity			*/
 #define TIM_CCER_CCXE		(BIT(0) | BIT(4) | BIT(8) | BIT(12))
 #define TIM_BDTR_BKE(x)		BIT(12 + (x) * 12)			/* Break input enable				*/
 #define TIM_BDTR_BKP(x)		BIT(13 + (x) * 12)			/* Break input polarity				*/
-- 
2.43.0


