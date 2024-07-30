Return-Path: <linux-kernel+bounces-268239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D531942214
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 23:16:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 693B61C230FA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 21:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E26718E022;
	Tue, 30 Jul 2024 21:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="oTr+Xkn5"
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEFAE14B06A
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 21:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722374176; cv=none; b=aWQlNulbth8kM3BilGcFy8Re2FHgqJm/7cf8BITcFhNeflKMyDoSbyB1LY80LrLq6bOnSVkUfFComutSAnmHd0r2PJHipg7blhgNrPSeM6eOTOYvqvzh0D1edUh46MMqCuR07R1vofVZqIG5z54MTgbQGoJewfq5zAvjv0i4zT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722374176; c=relaxed/simple;
	bh=ORTj1whOmho9EBXBhVyx/Aod4OLgvVRSILSuObjsbck=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UmsUFCPGg5+X9fRaJW9cQrfJ/To3AVBLQVD4KRGHviCaPPrKrhY2/ggKuW/DuOLT/zWM/zNNAvUAoJb9MUlXBoc15KYDd/OF9wvcKUbRnrO9pZuS4vPJpOE4y0F2HF4zZEJ971f4UVLaeeluhK2YFOTIi1doQEvvYAWkLQh3Wkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=oTr+Xkn5; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-25e3d8d9f70so3216497fac.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 14:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1722374173; x=1722978973; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=3SNgZGwTB2OgZzwunwEodtuAzjkcRKhZuJtkoHDBu5E=;
        b=oTr+Xkn5h/qwuJThagnlLaF4yBndOz/gaTEy51pqX7TtGsSpyG7lm1Y+h46oavZ4Bu
         UBLkYxOe2u0bSAcW9uflJVbTSLsuQJY71E0J1ILAqwzQgRjeLd2R/0SVe1epmUas6IGN
         ShwbgQtTM+B91FrN27FGpOHCcLg5nwT9o4dxsyL4fvr/tGSEFXqjq1owqMeC+adRnEyW
         Qxl+RsU3ryVWIIus2Ekcp9ioDy+/7OHzJ8x8OyWzycFjTeh8Pdc6r28eMuelvRyPlmag
         qMxUOQfUXZTRwCa7i/2xJYywmlEA7J8tk+CY0dFen2MS8uId2/AkJsIVIE+Ukfr8LJ0c
         qf+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722374173; x=1722978973;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3SNgZGwTB2OgZzwunwEodtuAzjkcRKhZuJtkoHDBu5E=;
        b=kXCf9AKubHlKRq5DCk8EVxQAwq+7Kjinp/0a0TTEEUL/IU0yBRq8kU8ks/BBhvYKrd
         sKm2XIKP9udfDN6GW5IWH5PMeNJPFTfjyILG490qG2JBt12M1LKzqiouANDi4fSW9GsT
         BhGl47bKGG1g4DPZC1UjL06Tl6xN/+zb7iwjcZdtOD9s1W5aTfddOXyEBi8KQOx4yDcS
         6WVsSwrA4aEqafgz65nbXA8ze5JEXB/mcw6OBsp2R5dYKipsLqDTmwNxzysTlBP1aweP
         karRZx4E5pVuFXD2DejcbBgzosT7Lnw1+3Ob2WAXAveCxLyG7jlr+uUc+t5ckstVhf49
         IwyA==
X-Forwarded-Encrypted: i=1; AJvYcCUW4mnNvTqTJB1ZzsZy78aKeXCgcySiWI02ZQTdugjcEALTxbyyH9gF24LvCTLYy9FJJ8GDESKdT/jzzSRalZJbEBlVlLxrDNhSVRe4
X-Gm-Message-State: AOJu0YwmQLmmZqO28oUpuAnyFf6tkJsN8guBT0sSwxs6XFJ0Hg3ONb2q
	29UjoQzAiC4CXFgKBGAbEdBpGSJ56HFP/TYswEUhbnbFRI6JdVfFW+L2OmeZsGY=
X-Google-Smtp-Source: AGHT+IEOaxswI3H9GFDKwy5yHX/0pb4wx+ESzHZirngCc6mranrs6dBot2o0wvrjYlgus5dT9h5zxw==
X-Received: by 2002:a05:6870:468e:b0:24e:8987:6f34 with SMTP id 586e51a60fabf-267d4cae74cmr15605740fac.3.1722374172963;
        Tue, 30 Jul 2024 14:16:12 -0700 (PDT)
Received: from localhost (75-172-120-197.tukw.qwest.net. [75.172.120.197])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7a9f836c845sm9423606a12.37.2024.07.30.14.16.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 14:16:12 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
To: Markus Schneider-Pargmann <msp@baylibre.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Tony Lindgren <tony@atomide.com>, John Ogness <john.ogness@linutronix.de>,
 Markus Schneider-Pargmann <msp@baylibre.com>, Uwe =?utf-8?Q?Kleine-K?=
 =?utf-8?Q?=C3=B6nig?=
 <u.kleine-koenig@pengutronix.de>, Ronald Wahl <ronald.wahl@raritan.com>,
 Thomas Richard <thomas.richard@bootlin.com>, Thomas Gleixner
 <tglx@linutronix.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Arnd Bergmann <arnd@arndb.de>, Vignesh Raghavendra <vigneshr@ti.com>
Cc: Vibhore Vardhan <vibhore@ti.com>, Dhruva Gole <d-gole@ti.com>,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 devicetree@vger.kernel.org
Subject: Re: [PATCH 4/5] serial: 8250: omap: Support wakeup pinctrl state
In-Reply-To: <20240523075819.1285554-5-msp@baylibre.com>
References: <20240523075819.1285554-1-msp@baylibre.com>
 <20240523075819.1285554-5-msp@baylibre.com>
Date: Tue, 30 Jul 2024 14:16:12 -0700
Message-ID: <7hmsly60o3.fsf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Markus Schneider-Pargmann <msp@baylibre.com> writes:

> UART can be used as a wakeup source for am62 from a powered-off SoC

nit: To be a bit more precise, instead of saying UART can be used as a
wakeup source, I think you should say:

Certain UART pins can be used...

> state. To enable wakeup from UART am62 requires a wakeup flag being set
> in the pinctrl.
>
> If the device is marked as wakeup enabled, select the 'wakeup' pinctrl
> state on sys_off.
>
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>

Reviewed-by: Kevin Hilman <khilman@baylibre.com>

> ---
>  drivers/tty/serial/8250/8250_omap.c | 39 +++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
>
> diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
> index 5b7508dfb5d8..617a421a1396 100644
> --- a/drivers/tty/serial/8250/8250_omap.c
> +++ b/drivers/tty/serial/8250/8250_omap.c
> @@ -27,8 +27,10 @@
>  #include <linux/pm_qos.h>
>  #include <linux/pm_wakeirq.h>
>  #include <linux/dma-mapping.h>
> +#include <linux/reboot.h>
>  #include <linux/sys_soc.h>
>  #include <linux/pm_domain.h>
> +#include <linux/pinctrl/consumer.h>
>  
>  #include "8250.h"
>  
> @@ -149,6 +151,9 @@ struct omap8250_priv {
>  	spinlock_t rx_dma_lock;
>  	bool rx_dma_broken;
>  	bool throttled;
> +
> +	struct pinctrl *pinctrl;
> +	struct pinctrl_state *pinctrl_wakeup;
>  };
>  
>  struct omap8250_dma_params {
> @@ -1345,6 +1350,30 @@ static int omap8250_no_handle_irq(struct uart_port *port)
>  	return 0;
>  }
>  
> +static int omap8250_select_wakeup_pinctrl(struct device *dev,
> +					  struct omap8250_priv *priv)
> +{
> +	if (IS_ERR_OR_NULL(priv->pinctrl_wakeup))
> +		return 0;
> +
> +	if (!device_may_wakeup(dev))
> +		return 0;
> +
> +	return pinctrl_select_state(priv->pinctrl, priv->pinctrl_wakeup);
> +}
> +
> +static int omap8250_sysoff_handler(struct sys_off_data *data)
> +{
> +	struct omap8250_priv *priv = dev_get_drvdata(data->dev);
> +	int ret;
> +
> +	ret = omap8250_select_wakeup_pinctrl(data->dev, priv);
> +	if (ret)
> +		dev_err(data->dev, "Failed to select pinctrl state 'wakeup', continuing poweroff\n");
> +
> +	return NOTIFY_DONE;
> +}
> +
>  static struct omap8250_dma_params am654_dma = {
>  	.rx_size = SZ_2K,
>  	.rx_trigger = 1,
> @@ -1566,6 +1595,16 @@ static int omap8250_probe(struct platform_device *pdev)
>  	priv->line = ret;
>  	pm_runtime_mark_last_busy(&pdev->dev);
>  	pm_runtime_put_autosuspend(&pdev->dev);
> +
> +	priv->pinctrl = devm_pinctrl_get(&pdev->dev);
> +	if (!IS_ERR_OR_NULL(priv->pinctrl))
> +		priv->pinctrl_wakeup = pinctrl_lookup_state(priv->pinctrl, "wakeup");
> +
> +	devm_register_sys_off_handler(&pdev->dev,
> +				      SYS_OFF_MODE_POWER_OFF_PREPARE,
> +				      SYS_OFF_PRIO_DEFAULT,
> +				      omap8250_sysoff_handler, NULL);
> +
>  	return 0;
>  err:
>  	pm_runtime_dont_use_autosuspend(&pdev->dev);
> -- 
> 2.43.0

