Return-Path: <linux-kernel+bounces-357881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0C8899774A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 23:12:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6A1D1C214F9
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 21:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3F851E261A;
	Wed,  9 Oct 2024 21:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="d9lL2ZB+"
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F2B1A0BD7
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 21:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728508317; cv=none; b=n96lE+Hv30lt1Zgm/Ez25s4R6lHs7Duf7Dn+SWIiPFg3Nhi0cGPLpTfV7SUMKEK9WtnTyjWPZeNB5kEk8GimcN0DKW+ZVwMImkq5L6rPzFrC2dK6QJF87Nu+PwS/tnjWB/WENnpz3NKTPlnppU+yptRQqiWPrP4x1kXx60c2qL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728508317; c=relaxed/simple;
	bh=dLQCCQQtufIVRgZujVQA7cz/RTTXW+jz4SwFA6lj5kI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RtNVdU3lFtTGq/ECw/6mvB81RTKxnhTGvBw5N2MPdVjai8LgemHK/LN68Ii3rSUso44EBW+mstl4o/Z9Zl9flhxGI8KDe9ATgzPqfFaR2T6ZMeotAEGsfWl3PSEoGeLXonxR+lmVCmJlUxvgTz2DfSK9FzlELDDNTco+qjflsRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=d9lL2ZB+; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5e98bfea0ceso124036eaf.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 14:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1728508313; x=1729113113; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=85xyWXXyK86Bi+Vmln4tAd1ehUyjEiDpAVUverCE2bw=;
        b=d9lL2ZB+OKLqCoqZCEWWaOaf3uueN10eA9s2fIKDfWkupTjTDG1ZPwshgjTLqjW48E
         MXqgFnrdd/1KYgXEiwn1vKyR9kchIVEbXr7YP2FHBw6yDZ9u8b9UN9RpxGtUObjDHg4U
         IMdsniKE1XfudJY2tL/BvqXO1FZ+yih6Bv85blMyFhlx3U816VTJekS7G73vpaJwrNA1
         4kLxn/2JlOvTCjqtkWWh2o8z5z9Mog2HnUNv0jvJ3SPi7roTpCcj9U7W6H1xBM0UoFGm
         EqZlFhiNF9nujSVDBniSTjMwakUNycSwmHyftuCDfYsrUIn9XJvG4m2jlVpqqvA7+hNC
         taXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728508313; x=1729113113;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=85xyWXXyK86Bi+Vmln4tAd1ehUyjEiDpAVUverCE2bw=;
        b=mZFuw6xZEpwen8qmHL4Rq8zTxXouexPAco8ljOXcDqd0eAvGdhm0GG5W4cNfPriFWZ
         E9zF8Vxy9rtfJLazBN0iWE6inDHcVToLR5acE3qy/TY5pniQtrOejvfp+iqV9iLt2zrL
         66PYsFL5bRkjmMlfZjvzQSRBJ3RXdsBWAl9I/xIts9IytinzTga3IoevnEEqcLetRGQs
         ini1WZSQhnGQJRcTSv83ZOV1JYsYUw4XKYDXggNsY9olH+kJJGzjfXdTIDbCwT1XNcL8
         LezXCuTvhRtrkGsONGOuTOhruwzIrsX1y1bgbSpHZQjXQ1S8OG2uT/eLn0qJvt1GmZur
         WQUw==
X-Forwarded-Encrypted: i=1; AJvYcCWeSCDDYH5I1Ijs3ILmLHySAGDApc3Sa6/2L2o6tRwm/+p3fDUMwXOB9oB1u42EAR+txsxGHbk80c1QkWY=@vger.kernel.org
X-Gm-Message-State: AOJu0YywagRV6GaYg0x0iAm2GtwwW6DvaJtpQeJ+X8OMnU/Oyyp66wyT
	sc/2gTevZqqOjXr47MWQpu/NASJ3Xmk0vIx/vTYrkXnHeREC7zYz4z1mkqy3grw=
X-Google-Smtp-Source: AGHT+IG9U3vkypzlVrStYFq5tKuDwHhP0eam5EiIGPAzX0+MxGE0J9VvLF6lY5aEtgeJJ/YMNlYClQ==
X-Received: by 2002:a05:6820:1690:b0:5e1:eba9:8fe7 with SMTP id 006d021491bc7-5e987b51200mr3161499eaf.3.1728508313372;
        Wed, 09 Oct 2024 14:11:53 -0700 (PDT)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7155688a874sm2455747a34.81.2024.10.09.14.11.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 14:11:53 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 09 Oct 2024 16:11:49 -0500
Subject: [PATCH 1/2] pwm: axi-pwmgen: rename 0x10 register
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241009-pwm-axi-pwmgen-enable-force_align-v1-1-5d6ad8cbf5b4@baylibre.com>
References: <20241009-pwm-axi-pwmgen-enable-force_align-v1-0-5d6ad8cbf5b4@baylibre.com>
In-Reply-To: <20241009-pwm-axi-pwmgen-enable-force_align-v1-0-5d6ad8cbf5b4@baylibre.com>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: Michael Hennerich <michael.hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Trevor Gamblin <tgamblin@baylibre.com>, linux-pwm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.1

Rename the 0x10 register from REG_CONFIG to REG_RSTN. Also rename the
associated bit macros accordingly.

While touching this, move the bit macros close to the register address
macro for better organization.

According to [1], the name of the 0x10 register is REG_RSTN, and there
is a different register named REG_CONFIG (0x18). So we should not be
using REG_CONFIG for the 0x10 register to avoid confusion.

[1]: http://analogdevicesinc.github.io/hdl/library/axi_pwm_gen/index.html

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/pwm/pwm-axi-pwmgen.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/pwm/pwm-axi-pwmgen.c b/drivers/pwm/pwm-axi-pwmgen.c
index 6e56ceb23d18..e1ddeaa4998b 100644
--- a/drivers/pwm/pwm-axi-pwmgen.c
+++ b/drivers/pwm/pwm-axi-pwmgen.c
@@ -9,7 +9,7 @@
  *
  * Limitations:
  * - The writes to registers for period and duty are shadowed until
- *   LOAD_CONFIG is written to AXI_PWMGEN_REG_CONFIG, at which point
+ *   LOAD_CONFIG is written to AXI_PWMGEN_REG_RSTN, at which point
  *   they take effect.
  * - Writing LOAD_CONFIG also has the effect of re-synchronizing all
  *   enabled channels, which could cause glitching on other channels. It
@@ -33,14 +33,14 @@
 #define AXI_PWMGEN_REG_ID		0x04
 #define AXI_PWMGEN_REG_SCRATCHPAD	0x08
 #define AXI_PWMGEN_REG_CORE_MAGIC	0x0C
-#define AXI_PWMGEN_REG_CONFIG		0x10
+#define AXI_PWMGEN_REG_RSTN		0x10
+#define   AXI_PWMGEN_REG_RSTN_LOAD_CONFIG	BIT(1)
+#define   AXI_PWMGEN_REG_RSTN_RESET		BIT(0)
 #define AXI_PWMGEN_REG_NPWM		0x14
 #define AXI_PWMGEN_CHX_PERIOD(ch)	(0x40 + (4 * (ch)))
 #define AXI_PWMGEN_CHX_DUTY(ch)		(0x80 + (4 * (ch)))
 #define AXI_PWMGEN_CHX_OFFSET(ch)	(0xC0 + (4 * (ch)))
 #define AXI_PWMGEN_REG_CORE_MAGIC_VAL	0x601A3471 /* Identification number to test during setup */
-#define AXI_PWMGEN_LOAD_CONFIG		BIT(1)
-#define AXI_PWMGEN_REG_CONFIG_RESET	BIT(0)
 
 struct axi_pwmgen_ddata {
 	struct regmap *regmap;
@@ -152,7 +152,7 @@ static int axi_pwmgen_write_waveform(struct pwm_chip *chip,
 	if (ret)
 		return ret;
 
-	return regmap_write(regmap, AXI_PWMGEN_REG_CONFIG, AXI_PWMGEN_LOAD_CONFIG);
+	return regmap_write(regmap, AXI_PWMGEN_REG_RSTN, AXI_PWMGEN_REG_RSTN_LOAD_CONFIG);
 }
 
 static int axi_pwmgen_read_waveform(struct pwm_chip *chip,
@@ -223,7 +223,7 @@ static int axi_pwmgen_setup(struct regmap *regmap, struct device *dev)
 	}
 
 	/* Enable the core */
-	ret = regmap_clear_bits(regmap, AXI_PWMGEN_REG_CONFIG, AXI_PWMGEN_REG_CONFIG_RESET);
+	ret = regmap_clear_bits(regmap, AXI_PWMGEN_REG_RSTN, AXI_PWMGEN_REG_RSTN_RESET);
 	if (ret)
 		return ret;
 

-- 
2.43.0


