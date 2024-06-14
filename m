Return-Path: <linux-kernel+bounces-214508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FBAE9085C5
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 10:11:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 726971C22266
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 08:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B96918509A;
	Fri, 14 Jun 2024 08:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="OkBqznYk"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBFC918309C
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 08:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718352646; cv=none; b=BbSfyZzvDg1UztZTtpVdEACjXK5+B8xc8r/ZWttejptfcD4BhVPWvSMXZvoHfeXDuMMGot3UnFzALKuz6j+0mYIM3M20JRro1pF6Azo35Oo9qY7jMpcZ0RUuCNfnz+80kIHDOv3U9TQqnTu/945PChT9ypTLF/Ze1CjCsR41YVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718352646; c=relaxed/simple;
	bh=stG4EosrRZoLl+rGkaCdgcYZ2i4JpRbIXzGPd14Nook=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ib+xrPKP7z+lUrTul6RXfr4MNHWYnYhljNR5Mel4IFCCmEDvsKTR/fpt+KMwrcCIgCBweipt5UC9ZWeKSpRqEE+oNJhPs8gr+RvxGFGeFWBx/C3P4S95uniO/b9jNLqLgrJnpnWKTDc6j4dXubDlUp13RSL62tmeKL+RRbrW6Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=OkBqznYk; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a6ef64b092cso233232366b.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 01:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718352642; x=1718957442; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fWXZAlLTUOX+tTobWucYGS5J3I+aXFzRea0PJgB3aYU=;
        b=OkBqznYkw/IwatnyS/Nsv/YY1x3Fug1eAKpNp/rlqDadjvXC6aTzOvs1xZBbxgI9YV
         MIBMADpNR4tJNUrTac6XTxAtCRLlObZU2hBbblvtxiV2H2O/N+1rR2p6EIVJQhRZVicq
         94b2NyNydOPdKg0wPVMmPNJ0qL1kLq8XTWRD/tTEsDCVZLmLVim9tj/ATgHoWaVbJ9aF
         9ejr3CBfCX8pJ3Ly/OKD9I/CWALShOqmCpDLeP6hI8Q44p7HdHJTGmiN4PAvJ1x/f07Y
         cdit7yYxLhehIHWl6d9+SGp2WQQjrdZaI9EMp3wDBWa1mrPn+I4GxqXSIh6rTGbuzp3i
         fIbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718352642; x=1718957442;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fWXZAlLTUOX+tTobWucYGS5J3I+aXFzRea0PJgB3aYU=;
        b=WFNgq5f4tUX7FgF4I4R8XCOHmTeWZXXz0txNkHvdm0JAzSzYspMbjyJVQnPit0qxIU
         W2AWM4FS9emENb0sZu5SQ6/169ApUCP8WbqQvd4zEXev72k1GILT/sBUxcdYB8r/Ibq7
         J59GFe2edNYyj0PMuPkv8nBCDPLhW3kdK7ci6a+w/h24eAKTcmKLKhu1MVQMu/NNWimY
         Q4+bBYj5XJUedkBZSYnMmnumyv2U1OV2VoZ1Xkas1gONxstlZM+rmfvsfxGyFOlVF7dv
         2ZTBB68BWGBpAm4k0V1W/70cQ9zo/y2irnhH0yE2nG4i0rXsD/lKHs+pQ7sU2nesDYi7
         PvuA==
X-Forwarded-Encrypted: i=1; AJvYcCUP5EGkug2nn5iEYhKrTtRPp9KsK65gDSqcBYdA12mxDhGbe3HogJn8IiCfX4r02Qdez+DXMLHnKdJM0vz5ycGTgwOlw9S0KnCB46DI
X-Gm-Message-State: AOJu0Yxl5fP9OhIUs6CGUyBXh2Ha9nmwaPNh7pMXR08c6D+NoGyDEAqc
	BTlF40qSpdycJdR6qVMKJYVecPh5we0RXOFT/+wDUfEwRCy/8ZvDb36feDa5tSc=
X-Google-Smtp-Source: AGHT+IHXP/bduZwGF5xd10v/r24aHwCwwIbka062NQzyXpF0rBDGdwKmbt5RtxLSg119J/dD+F/jRw==
X-Received: by 2002:a17:906:3948:b0:a6d:f339:f8 with SMTP id a640c23a62f3a-a6f60d296femr132378266b.31.1718352642102;
        Fri, 14 Jun 2024 01:10:42 -0700 (PDT)
Received: from localhost (p509153eb.dip0.t-ipconnect.de. [80.145.83.235])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f63f7e9d8sm54167266b.182.2024.06.14.01.10.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 01:10:41 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	William Breathitt Gray <wbg@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Lee Jones <lee@kernel.org>
Cc: linux-iio@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] mfd: stm32-timers: Add some register definitions with a parameter
Date: Fri, 14 Jun 2024 10:10:12 +0200
Message-ID:  <1edd88b690ba244d0c576cee3097c7c31a6e1d76.1718352022.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1718352022.git.u.kleine-koenig@baylibre.com>
References: <cover.1718352022.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=6869; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=stG4EosrRZoLl+rGkaCdgcYZ2i4JpRbIXzGPd14Nook=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBma/rqrNlrzLJxB1jwM/QXvIrx1yt4VvxB4YXhg Y2X3caXp4uJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZmv66gAKCRCPgPtYfRL+ TraPCAC5PWbxY/R2n3+WIfQsrI0nJhUPfmgW9cIkQL7IsZ2V5UV9i6ag34q9tj6gc7PdhBMO2+C +uy3fQDWzvR8l2KnFFP4wwNNHTWt9c5LUKXg4G/4f8GnhUfc5KRntrw9FcQf62RwfM1aLGl8g4s pjI7ZpdcGeDBkqQgtL9wVe+ukvCIWidOzszCYFhVTCFoRz8hAFB7GMDqP6HByWVa1ezKqX9krfu mxJlywKBm1z6U8s1ajVEj5kp7RABotjNo8VV46sidaHFvLLKruh8AH7z64R2Bwleqg3a8oZAMqc +lCVr9KGyVKw80rg7pgzKeYPx7IBiap3LBs7l8t0lMgvI+jV
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


