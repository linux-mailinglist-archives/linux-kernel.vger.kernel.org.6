Return-Path: <linux-kernel+bounces-276609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE0A1949601
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 18:58:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02C341C21EB4
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 16:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4814546450;
	Tue,  6 Aug 2024 16:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BXK/qPaa"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04AB643ABD
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 16:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722963499; cv=none; b=pj5bRjAHEGyyRcTDrd7zzmNk4gPlSAtfrFbe5dMfhNCTZIkgEsrUP0GsKVQGjWjrRJaFhnqMLntyy1BWFFbBkEs7K8Qk219wzdO/q/EfadmLghdeM0V3Y+5sJZsZWjARbxw3dVpoTaunw2qxD0Y7pkOZ2NoTCkHFcKh2I9Pb7dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722963499; c=relaxed/simple;
	bh=2MEG2FDNb1i+49v2FGCKi32uu8okt3pIxLwTLx/NavM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l0F+VBz6NY5tUrnB16AbwqsjSA5h7rkoQrqEv54hdDUFX4tRN+21rwOF6vAVCwtuic+xbG50SfaWO93F1Usw+MhyFofgBiJwCRa3YL9S/3X36/8vWTQaLGkYYtC7ZxUtvNdS88xMgG/Ot9FI+9e0P/ResqbfK6cMXmoXVFRejyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BXK/qPaa; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-710afd56c99so39886b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 09:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722963497; x=1723568297; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AteIhxBYzhJyn1tYeIzpVUFBBzJ416KEbbM9lqDXkQI=;
        b=BXK/qPaajv1ogK8qOLvIMQaPBRORlqux4oW0QzYq8nI2FTbWaBiNWbu1TBnAtgpg2i
         E5vT9i0Wp08HHFQ/rwzGzwoL0jkXlUPE0D7MWE+qElv9AKzhu7unZG1Y5kTzwwSKHS5q
         XVvugJX4jrwPkUQcc/P5ycL1nmYFhXLMJzaflmln5MFt8kGO5yPfS948nXVB80PCAXmL
         savyiY8xGo2LbiQatQ5QDrksV/CP/AgkOSW5piJxLazTRqPCLN76cnQp5DOKYa2JwMtI
         STyJ0WkSv3bRFFcNkoPbe+7jsqi9Oap7Ngkz1MaLkE8boXG/2FpTr4IWMj+fI5IlKSoK
         MQAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722963497; x=1723568297;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AteIhxBYzhJyn1tYeIzpVUFBBzJ416KEbbM9lqDXkQI=;
        b=aOHoyOG7MZxY3q77BP0HjWeBa04YeT3ijehn6/KH10AB6+Mv8e67zhg8RbyNJuDHZY
         CF5RKP4O+7uGhAm9Rtb2+ZePSID1PIuzlpONx9CJHgbrFIzT53JqOHyChwCmzCBJxXXu
         wM2KCSgDD+7QBKJFof46GZ8UDkXAJHGyIM+Q2ESZewHoMnOeHxBqHH4b9QfPNZeMI0x7
         Lp1WJZHwYVTjH9n3Pv1YA1mC3Zt6yBgMkpjU9hXzBog0yCrdbXhFkKwGBRNHAvDo/i+N
         em8Mxrjw4q7uhH9AMC2T30t8GQkgomDfHP0kfWdtbK66RXZYaDX6to5Vta2HvaL5iZWS
         5y2w==
X-Forwarded-Encrypted: i=1; AJvYcCU4pBe3loaKo8HyT67q+bhgi5cJ/k7sPOpFWk1jFWsh6lojBYwuIsjXsV4OptNoH9DYaeR0asXR3PEsBJc5Mkidape2BDocRzPCnRV5
X-Gm-Message-State: AOJu0YweR7LbEuK9Y8VficjP5AxHBkDvp2U/asbWFIMKtoIh/Tgbvqk+
	MFyLUl2CJD0RoElMwyf59Thhu9rJ+KQcnrehgbECgdZPvyMdN+Q7
X-Google-Smtp-Source: AGHT+IGX9QiPDay2/VRkCT54En685+dc1libP8vbkdercbTFcGF1Yfp92C2prgbKNUL7feC46lOMkw==
X-Received: by 2002:a05:6a00:91d9:b0:705:d6ad:2495 with SMTP id d2e1a72fcca58-71065f1e22emr27662731b3a.12.1722963497198;
        Tue, 06 Aug 2024 09:58:17 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:5e0f:b2bc:fc41:27a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7106ec416aasm7185063b3a.70.2024.08.06.09.58.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 09:58:16 -0700 (PDT)
Date: Tue, 6 Aug 2024 09:58:14 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>,
	Daniel Mack <daniel@zonque.org>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Linus Walleij <linus.walleij@linaro.org>, soc@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/10] ARM: pxa/gumstix: convert vbus gpio to use
 software nodes
Message-ID: <ZrJWJoDdNTLuIViH@google.com>
References: <20240628180852.1738922-1-dmitry.torokhov@gmail.com>
 <20240628180852.1738922-4-dmitry.torokhov@gmail.com>
 <3f7971e1-0576-417b-8aaa-c06e1697908f@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f7971e1-0576-417b-8aaa-c06e1697908f@app.fastmail.com>

On Tue, Aug 06, 2024 at 09:19:55AM +0200, Arnd Bergmann wrote:
> On Fri, Jun 28, 2024, at 20:08, Dmitry Torokhov wrote:
> > Switch vbus gpios from using a custom GPIO lookup table to software
> > properties using PROPERTY_ENTRY_GPIO() constructs which closely mimic
> > device tree gpio properties.
> >
> > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> 
> I ran into some randconfig build failures with this one now:
> 
> > index c9f0f62187bd..b9eddc691097 100644
> > --- a/arch/arm/mach-pxa/gumstix.c
> > +++ b/arch/arm/mach-pxa/gumstix.c
> > @@ -100,26 +100,22 @@ static void __init gumstix_mmc_init(void)
> >  #endif
> > 
> >  #ifdef CONFIG_USB_PXA25X
> > -static struct gpiod_lookup_table gumstix_gpio_vbus_gpiod_table = {
> > -	.dev_id = "gpio-vbus",
> > -	.table = {
> > -		GPIO_LOOKUP("gpio-pxa", GPIO_GUMSTIX_USB_GPIOn,
> > -			    "vbus", GPIO_ACTIVE_HIGH),
> > -		GPIO_LOOKUP("gpio-pxa", GPIO_GUMSTIX_USB_GPIOx,
> > -			    "pullup", GPIO_ACTIVE_HIGH),
> > -		{ },
> > -	},
> > +static const struct property_entry spitz_mci_props[] __initconst = {
> > +	PROPERTY_ENTRY_GPIO("vbus-gpios", &pxa2xx_gpiochip_node,
> > +			    GPIO_GUMSTIX_USB_GPIOn, GPIO_ACTIVE_HIGH),
> > +	PROPERTY_ENTRY_GPIO("pullup-gpios", &pxa2xx_gpiochip_node,
> > +			    GPIO_GUMSTIX_USB_GPIOx, GPIO_ACTIVE_HIGH),
> > +	{ }
> >  };
> > 
> 
> This is missing a few #include, the name spitz_mci_props[]
> is wrong for this file and the array is not referenced anywhere.

Ugh, you are right. Its weird that it does not warn me that the compiler
did not warn me that it is not used... It built for me with
pxa_defconfig so I assumed it was all good.

Ahh, by default it forces CONFIG_USB_PXA25X to be a module and that
skips that block in gumstix.c. I'll change it to IS_ENABLED() because it
should not matter if USB/UDC is built-in or is a module.

> 
> I assume the gumstix_gpio_vbus_info needs to be turned into
> an swnode, but I haven't figured out how to do this.

It is just a matter of initializing .properties in
gumstix_gpio_vbus_info. 

> 
> Based on the recent board deprecation discussion, I expect
> that there are no users and that we will remove this machine
> early next year, so we don't need to care about making it
> pretty now, but maybe you can send a patch to make it build
> again.

Yes, of course. Could you please try the patch below? And if you see
failures, please share your .config.

> 
>     Arnd

-- 
Dmitry

From cff436e3405b7f938e60f693ca7c8410266a893b Mon Sep 17 00:00:00 2001
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Tue, 6 Aug 2024 09:12:58 -0700
Subject: [PATCH] ARM: pxa/gumstix: fix attaching properties to vbus gpio device

Commit f1d6588af93b tried to convert GPIO lookup tables to software
properties for the vbus gpio device, bit forgot the most important
step: actually attaching the new properties to the device.

Also fix up the name of the property array to reflect the board name,
and add missing gpio/property.h and devices.h includes absence of which
causes compile failures on some configurations.

Switch "#ifdef CONFIG_USB_PXA25X" to "#if IS_ENABLED(CONFIG_USB_PXA25X)"
because it should not matter if the driver is buolt in or a module, it
still need vbus controls.

Reported-by: Arnd Bergmann <arnd@arndb.de>
Fixes: f1d6588af93b ("ARM: pxa/gumstix: convert vbus gpio to use software nodes")
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 arch/arm/mach-pxa/gumstix.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-pxa/gumstix.c b/arch/arm/mach-pxa/gumstix.c
index efa6faa62a2c..1713bdf3b71e 100644
--- a/arch/arm/mach-pxa/gumstix.c
+++ b/arch/arm/mach-pxa/gumstix.c
@@ -21,6 +21,7 @@
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
 #include <linux/gpio/machine.h>
+#include <linux/gpio/property.h>
 #include <linux/gpio.h>
 #include <linux/err.h>
 #include <linux/clk.h>
@@ -40,6 +41,7 @@
 #include <linux/platform_data/mmc-pxamci.h>
 #include "udc.h"
 #include "gumstix.h"
+#include "devices.h"
 
 #include "generic.h"
 
@@ -99,8 +101,8 @@ static void __init gumstix_mmc_init(void)
 }
 #endif
 
-#ifdef CONFIG_USB_PXA25X
-static const struct property_entry spitz_mci_props[] __initconst = {
+#if IS_ENABLED(CONFIG_USB_PXA25X)
+static const struct property_entry gumstix_vbus_props[] __initconst = {
 	PROPERTY_ENTRY_GPIO("vbus-gpios", &pxa2xx_gpiochip_node,
 			    GPIO_GUMSTIX_USB_GPIOn, GPIO_ACTIVE_HIGH),
 	PROPERTY_ENTRY_GPIO("pullup-gpios", &pxa2xx_gpiochip_node,
@@ -109,8 +111,9 @@ static const struct property_entry spitz_mci_props[] __initconst = {
 };
 
 static const struct platform_device_info gumstix_gpio_vbus_info __initconst = {
-	.name	= "gpio-vbus",
-	.id	= PLATFORM_DEVID_NONE,
+	.name		= "gpio-vbus",
+	.id		= PLATFORM_DEVID_NONE,
+	.properties	= gumstix_vbus_props,
 };
 
 static void __init gumstix_udc_init(void)
-- 
2.46.0.rc2.264.g509ed76dc8-goog



