Return-Path: <linux-kernel+bounces-410295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71F889CD939
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 07:58:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3250F2837E7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 06:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51F3F188737;
	Fri, 15 Nov 2024 06:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XflMr7xM"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93C215FD13
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 06:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731653890; cv=none; b=VUTK6EfNMmh0Y913wyBA126LeTu4lUnjXfp3RV9rQLvomtC6CFNV9UHNhhcrGTBnAIvkQ04+UDIG72kcS0WSq2IB8jGE+EutdR3r894H4TfjeeCJo4htw4SObtIrIgemEQHzgljUD3nHlAdLvAtdNAWuC4eZooZWxQkrJEP4Bgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731653890; c=relaxed/simple;
	bh=UGJREjOHz5RHJMYXmzG0Tou5gZp5PeWqq4mm1kyqUGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qXXtBmQ8jX2xbZSaoSypSNa4oHMEljr0jCUlyGn5ZtQOh7uCi+xlaYWi7sV49svIcckqKr00erDmpkjke/PaZCmAtNIdNTJyWq261NminTRaLAi09kneQI2wSinbwiaFdMC2i5XJfe1EBQR1nTqUzvEprxdc8JsQcPhifeZhZrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XflMr7xM; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-72475e29578so363100b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 22:58:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731653888; x=1732258688; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wtnA5EAAxwC1kI1kCfZtNl7bbPWqSTJS09SRk41HtKs=;
        b=XflMr7xMq06+A3TjvynmpaSqgP+2iKsTnB/EbH1QwW3PKpkU8ZOxsM5ec3URIwNtuY
         hjzIFqYoachwykUbepDvIRM+uzLviCIEr6kiFGP/TwfZ0YaGWZKUAhmPlH0EIX58R7Ma
         rEkT7wZcFxliCWtNlVz3/utbRLnie+6HMB1EH7KwKeaUm8/wVERyM6G8Lr9rtsqMqH6z
         Zs4EUpnggaNPYHhAyk9oh2Dvd1Ag6cXYdYEyxtmA4vSsBiyq2OfiazoBfiRYM+pSMsN+
         179ksAIeXwmmcCWd+0W2aqPp1O+5C6C6w4TCwgYdM/QsiaWasqyvPCoE7eOgucH1nZR0
         Ampg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731653888; x=1732258688;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wtnA5EAAxwC1kI1kCfZtNl7bbPWqSTJS09SRk41HtKs=;
        b=XWZmq0r6K1CdCCFd1D3NFftvUVir0Z6bLGBnlckd9Bad9QBw8iKbbdZECFF+yNHqlP
         j9ywIQO8IPkvxJtJoK36IJW7W0Wbe8DYXZsjAyR9bu5L3mTsgTT6ZR3Rdejzur0ieGD1
         gPsAKnI5l4eFL2snFqG9DmoncnSPIm8fRQRKDZD+wEX+r06GXBEH7QzlUCM58EJzVGX2
         MakGdFs/498j7jlqAuSFhimUYRTl49wL2+KlmzCUa3fn6WzQO0bQCkZtkWbEwuYZtPoz
         nbZ18ODDKk6xxP3TO9uS6UrOk1MjwYlzsngMyCuYEt3U6KzXyHkDWDueJY6Nv7PNK3AD
         KQ7w==
X-Gm-Message-State: AOJu0YyQ3DxM0eWuhkbjjdGv9Apgm/0DH7gET/Fc9QxORSbnEmSP0gtT
	dzjfuwqC8Et31pxvFL8WUGYmZ3+5VmbzXC+YKgpoW5U2MFFXH+h1wD9LwQ==
X-Google-Smtp-Source: AGHT+IEY20lQegcOPFc6UAgqjcSbWicOTjbzSoWgpblxhfcM6UZs0t1epSZASKHHXgNvQSyr/8ELJw==
X-Received: by 2002:a05:6a00:1890:b0:71e:634e:fe0d with SMTP id d2e1a72fcca58-72476bb01dbmr2018494b3a.12.1731653887774;
        Thu, 14 Nov 2024 22:58:07 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72477120ab4sm692382b3a.44.2024.11.14.22.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 22:58:06 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 14 Nov 2024 22:58:05 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Mark Brown <broonie@kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Frank Li <Frank.Li@nxp.com>
Subject: Re: regmap I3C support
Message-ID: <7b23e033-5cde-44e9-be97-10296833863b@roeck-us.net>
References: <67d549d0-64c6-4d62-add6-0958ef24910f@roeck-us.net>
 <ZzSxKctLlLZexdF5@finisterre.sirena.org.uk>
 <feda265f-f7ba-4017-a08d-b35916aafe96@roeck-us.net>
 <ZzS6ph8KulEITt5C@finisterre.sirena.org.uk>
 <88f34137-b215-4bee-b117-3ff00402ba6c@roeck-us.net>
 <ZzXfmonkRB-KaBhi@finisterre.sirena.org.uk>
 <85584c2e-2c45-4ec4-89a0-111fa5ad1080@roeck-us.net>
 <ZzYyu4ptPtYT6vJC@finisterre.sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZzYyu4ptPtYT6vJC@finisterre.sirena.org.uk>

On Thu, Nov 14, 2024 at 05:26:19PM +0000, Mark Brown wrote:
> On Thu, Nov 14, 2024 at 06:45:52AM -0800, Guenter Roeck wrote:
> 
> > We now use
> 
> > config SENSORS_TMP108
> >         tristate "Texas Instruments TMP108"
> >         depends on I2C
> >         depends on I3C || !I3C
> >         select REGMAP_I2C
> >         select REGMAP_I3C if I3C
> 
> > and in the i3c_probe function
> 
> > #ifdef CONFIG_REGMAP_I3C
> >         regmap = devm_regmap_init_i3c(i3cdev, &tmp108_regmap_config);
> > #else
> >         regmap = ERR_PTR(-ENODEV);
> > #endif
> >         if (IS_ERR(regmap))
> 
> > Clumsy, and not my preferred solution, but it works.
> 
> Right, so the fact that I3C depends on I2C deals with a lot of the
> problems that plague the I2C/SPI combination.  Ugh.  I guess the helper
> should be OK and there's not much doing for I2C/SPI.

Is it really that difficult for I2C and SPI ? The patch below seems to work
for the LTC2947 driver. It doesn't even need dummies (the compiler drops
the unused code), though I am not sure if that can be relied on. I thought
that dummy functions are needed, but maybe I am wrong.

The Kconfig for the combined ltc2947 driver is

config SENSORS_LTC2947
        tristate "Analog Devices LTC2947 High Precision Power and Energy Monitor"
        depends on I2C || SPI
        depends on I2C || I2C=n
        select REGMAP_I2C if I2C
        select REGMAP_SPI if SPI
        help
	...

Guenter

---
From 8b72bcea4f399b3ffbea07256c5e48af63dfd230 Mon Sep 17 00:00:00 2001
From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 14 Nov 2024 17:30:01 -0800
Subject: [PATCH] Add infrastructure for supporting both I2C and SPI in single
 driver

Add support for register and unregister functions for drivers supporting
both I2C and SPI. Support situations where only one of the protocols is
enabled.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 include/linux/i2c_spi.h | 81 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)
 create mode 100644 include/linux/i2c_spi.h

diff --git a/include/linux/i2c_spi.h b/include/linux/i2c_spi.h
new file mode 100644
index 000000000000..3a8d32355338
--- /dev/null
+++ b/include/linux/i2c_spi.h
@@ -0,0 +1,81 @@
+/*---------------------------------------------------------------------------
+ *
+ * i2c_spi.h
+ *     Copyright (c) 2024 Guenter Roeck <linux@roeck-us.net>
+ *
+ * API functions to support both I2C and SPI in a single driver.
+ */
+
+#ifndef I2C_SPI_H
+#define I2C_SPI_H
+
+#include <linux/i2c.h>
+#include <linux/spi/spi.h>
+
+/**
+ * i2c_spi_driver_register() - Register an I2C and a SPI driver
+ * @i2cdrv: the I2C driver to register
+ * @spidrv: the SPI driver to register
+ *
+ * This function registers both @i2cdev and @spidev, and fails if one of these
+ * registrations fails. This is mainly useful for devices that support both I2C
+ * and SPI modes.
+ * Note that the function only registers drivers for the enabled protocol(s).
+ * If neither I2C nor SPI are enabled, it does nothing.
+ *
+ * Return: 0 if enabled registrations succeeded, a negative error code otherwise.
+ */
+static inline int i2c_spi_driver_register(struct i2c_driver *i2cdrv,
+					  struct spi_driver *spidrv)
+{
+	int ret = 0;
+
+	if (IS_ENABLED(CONFIG_I2C))
+		ret = i2c_add_driver(i2cdrv);
+	if (ret || !IS_ENABLED(CONFIG_SPI))
+		return ret;
+
+	ret = spi_register_driver(spidrv);
+	if (ret && IS_ENABLED(CONFIG_I2C))
+		i2c_del_driver(i2cdrv);
+
+	return ret;
+}
+
+/**
+ * i2c_spi_driver_unregister() - Unregister an I2C and a SPI driver
+ * @i2cdrv: the I2C driver to register
+ * @spidrv: the SPI driver to register
+ *
+ * This function unregisters both @i2cdrv and @i3cdrv.
+ * Note that the function only unregisters drivers for the enabled protocol(s).
+ */
+static inline void i2c_spi_driver_unregister(struct i2c_driver *i2cdrv,
+					     struct spi_driver *spidrv)
+{
+	if (IS_ENABLED(CONFIG_SPI))
+		spi_unregister_driver(spidrv);
+
+	if (IS_ENABLED(CONFIG_I2C))
+		i2c_del_driver(i2cdrv);
+}
+
+/**
+ * module_i2c_spi_driver() - Register a module providing an I2C and a SPI
+ *			     driver
+ * @__i2cdrv: the I2C driver to register
+ * @__spidrv: the SPI driver to register
+ *
+ * Provide generic init/exit functions that simply register/unregister an I2C
+ * and a SPI driver.
+ * This macro can be used even if CONFIG_I2C and/or CONFIG_SPI are disabled,
+ * in this case, only the enabled driver(s) driver will be registered.
+ * Should be used by any driver that does not require extra init/cleanup steps.
+ */
+#define module_i2c_spi_driver(__i2cdrv, __spidrv)	\
+	module_driver(__i2cdrv,				\
+		      i2c_spi_driver_register,		\
+		      i2c_spi_driver_unregister,	\
+		      __spidrv)
+
+#endif /* I2C_SPI_H */
-- 
2.45.2



