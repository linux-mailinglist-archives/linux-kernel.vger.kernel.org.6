Return-Path: <linux-kernel+bounces-225844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B212913608
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 22:42:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 039662822A4
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 20:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 076305F860;
	Sat, 22 Jun 2024 20:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YdXn7FP3"
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBEF02119
	for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2024 20:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719088938; cv=none; b=Yun085wblKhvCEX/0IMYSQ0S57wmuTVmIRwDV67fJ2RHTkZSey+hvZvy+2oA2iYxIbh/JKWWJcpz4lG0K3lpM8AgiG6Zvqoc0mr5+xq4nuHwfNEivibIhcZenhUTi6BKDUFBofeknxzwYV79hclDMVnCeCGMfOSs3mo0Y2rih8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719088938; c=relaxed/simple;
	bh=Vk05ePhxsCIzTFVxLwTdKTqVJE6Ctl2IWn46VN0lfY4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=uVR0Y036tNVQ7HkMssEJW9FLLSrMjneVdeEcDD0QVGnjNolNhrkVnP4oHbSsOAVLmS6lKim7tEAx3p216E74LkRBdr9NM1PaLNU48/0uPvVOzHUbn6Or8DvsLpPJZGZOumf8oyOX7KmMhVJyCkW1R4ZPg7/5TptUDeS8d902CJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YdXn7FP3; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-25cae7464f5so1678750fac.3
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2024 13:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719088936; x=1719693736; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P5XgKBpDi3THJPHfD0RkMG/eJrm8KfwifEQRqIr5T9w=;
        b=YdXn7FP3z1vbEZe5KTurePmjLcwKwfTOzYwcCk9AMaLdyeAVf6bXIYfBr+UDuKCEO3
         CYGINKIkigrs/xh7ZKK6MBuMbkcDsDB3DRUefULp/NQGQ+iMaiZnPj8WAJGZT+lwU6Re
         CthU4auEDpWhiQci7y9voIeZaJGajOVLjbQ4IszITM1QewOc4/xT3z/gHz2mwC8VksdJ
         qVGDlKus321vw52oq8qB64Ex3BPLr3ZpRpxq5LE91hE6xSoVqYf8DcsiSP2uW7FKIvwB
         TogqpHyIVihS8uN3DG7C1rJYh6brW6Dn+QxNCc2JUT31Io0ShOJYbwPz+m9ZGewHypFT
         NKqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719088936; x=1719693736;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P5XgKBpDi3THJPHfD0RkMG/eJrm8KfwifEQRqIr5T9w=;
        b=aJn6CobPO90uGcMcZ1BYZ5DIEiFLwoGrfQwqiVgo/Xx+K+U+VGXuFBeLBziCHIAgp1
         hHUyLuZ2wwk8gv/03cCk7YUsBf4a8lu4pyFj1bBLk648hTyERw0QBF7vNXpIbSy62U7w
         u+RAy8QWZA/95mzPBcN9VxwqQOTheBRxxJfl+0s9FjDtF7ooAFYmIuyJOIi6j/GMxjiF
         vJvkD05/VMOCazc6bK0W8XXY5y5v7IRMNoO455RrfENcSsigg3/tnsbW9pNtU4K8NL6e
         sXYrF9EN2s6Ve1mXQpYESAbrkt9ODFKUWGdbPiPrW2KyuZYbIivyu0wGqYqLXvP+TQlb
         pmPw==
X-Forwarded-Encrypted: i=1; AJvYcCVwg1Aa6evANUlHigLrYZ5tnzwjy6oy2i9X+Qih93nAC07gB7jWn3/O+GeJd1qHYoryN2oFB/uZVjhwMOtev9XXey36ilQO15zYL6XN
X-Gm-Message-State: AOJu0YxTMJCuBg3n3+Dd6t+oZid4DC+CmUN7pBn4IHK+ADigDo1V/cMb
	eEFMeonz9+VD/RcZT3XAoCm70daDlfdCRPA7UsxWCYzDlHpsQcSu
X-Google-Smtp-Source: AGHT+IGtXy+bZztPd+TWjBQZAs+WBJGh1vx8nunagsjtajUmAJM5HGMHNVq7/uhqFIEzL57suTCCiw==
X-Received: by 2002:a05:6870:2054:b0:24c:57b4:fb2c with SMTP id 586e51a60fabf-25d06eb9ef1mr867159fac.52.1719088935649;
        Sat, 22 Jun 2024 13:42:15 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:d2ec:59a0:2c5f:4460])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7065107cc88sm3594974b3a.15.2024.06.22.13.42.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jun 2024 13:42:15 -0700 (PDT)
Date: Sat, 22 Jun 2024 13:42:12 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>,
	Daniel Mack <daniel@zonque.org>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>,
	Lee Jones <lee@kernel.org>, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: spitz: fix GPIO assignment for backlight
Message-ID: <Znc3JMEgF22xDVvB@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

GPIOs controlling backlight on Spitz and Akita are coming from GPIO
expanders, not the pxa27xx-gpio block, correct it.

Additionally GPIO lookup tables operate with pin numbers rather than
legacy GPIO numbers, fix that as well. Use raw numbers instead of legacy
GPIO names to avoid confusion.

Fixes: ee0c8e494cc3 ("backlight: corgi: Convert to use GPIO descriptors")
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---

Linus, I am not sure if this is actually an issue, but I strongly
suspect that it is. I have no hardware, so no means to test it, sorry.

 arch/arm/mach-pxa/spitz.c | 30 ++++++++++--------------------
 1 file changed, 10 insertions(+), 20 deletions(-)

diff --git a/arch/arm/mach-pxa/spitz.c b/arch/arm/mach-pxa/spitz.c
index 3c5f5a3cb480..10ab16dcd827 100644
--- a/arch/arm/mach-pxa/spitz.c
+++ b/arch/arm/mach-pxa/spitz.c
@@ -520,10 +520,8 @@ static struct gpiod_lookup_table spitz_ads7846_gpio_table = {
 static struct gpiod_lookup_table spitz_lcdcon_gpio_table = {
 	.dev_id = "spi2.1",
 	.table = {
-		GPIO_LOOKUP("gpio-pxa", SPITZ_GPIO_BACKLIGHT_CONT,
-			    "BL_CONT", GPIO_ACTIVE_LOW),
-		GPIO_LOOKUP("gpio-pxa", SPITZ_GPIO_BACKLIGHT_ON,
-			    "BL_ON", GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP("sharp-scoop.1", 6, "BL_CONT", GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP("sharp-scoop.1", 7, "BL_ON", GPIO_ACTIVE_HIGH),
 		{ },
 	},
 };
@@ -531,10 +529,8 @@ static struct gpiod_lookup_table spitz_lcdcon_gpio_table = {
 static struct gpiod_lookup_table akita_lcdcon_gpio_table = {
 	.dev_id = "spi2.1",
 	.table = {
-		GPIO_LOOKUP("gpio-pxa", AKITA_GPIO_BACKLIGHT_CONT,
-			    "BL_CONT", GPIO_ACTIVE_LOW),
-		GPIO_LOOKUP("gpio-pxa", AKITA_GPIO_BACKLIGHT_ON,
-			    "BL_ON", GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP("i2c-max7310", 3, "BL_ON", GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP("i2c-max7310", 4, "BL_CONT", GPIO_ACTIVE_LOW),
 		{ },
 	},
 };
@@ -964,12 +960,9 @@ static inline void spitz_i2c_init(void) {}
 static struct gpiod_lookup_table spitz_audio_gpio_table = {
 	.dev_id = "spitz-audio",
 	.table = {
-		GPIO_LOOKUP("sharp-scoop.0", SPITZ_GPIO_MUTE_L - SPITZ_SCP_GPIO_BASE,
-			    "mute-l", GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP("sharp-scoop.0", SPITZ_GPIO_MUTE_R - SPITZ_SCP_GPIO_BASE,
-			    "mute-r", GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP("sharp-scoop.1", SPITZ_GPIO_MIC_BIAS - SPITZ_SCP2_GPIO_BASE,
-			    "mic", GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP("sharp-scoop.0", 3, "mute-l", GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP("sharp-scoop.0", 4, "mute-r", GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP("sharp-scoop.1", 8, "mic", GPIO_ACTIVE_HIGH),
 		{ },
 	},
 };
@@ -977,12 +970,9 @@ static struct gpiod_lookup_table spitz_audio_gpio_table = {
 static struct gpiod_lookup_table akita_audio_gpio_table = {
 	.dev_id = "spitz-audio",
 	.table = {
-		GPIO_LOOKUP("sharp-scoop.0", SPITZ_GPIO_MUTE_L - SPITZ_SCP_GPIO_BASE,
-			    "mute-l", GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP("sharp-scoop.0", SPITZ_GPIO_MUTE_R - SPITZ_SCP_GPIO_BASE,
-			    "mute-r", GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP("i2c-max7310", AKITA_GPIO_MIC_BIAS - AKITA_IOEXP_GPIO_BASE,
-			    "mic", GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP("sharp-scoop.0", 3, "mute-l", GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP("sharp-scoop.0", 4, "mute-r", GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP("i2c-max7310", 2, "mic", GPIO_ACTIVE_HIGH),
 		{ },
 	},
 };
-- 
2.45.2.741.gdbec12cfda-goog


-- 
Dmitry

