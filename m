Return-Path: <linux-kernel+bounces-268246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A504C942227
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 23:23:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E9DA1F265EA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 21:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B272618E031;
	Tue, 30 Jul 2024 21:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="fiJfG0rQ"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED8411AA3FF
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 21:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722374574; cv=none; b=YasQKjelLMjZSIEY00vSMY7be7IIFG7upzUizYcVY4Q4LvXT7rCds8Ih5Bb6ZfsoHOvmFfpIdIiEMYFfSL/MXRp8qOud6rvFy0dLDT1AsnhEJ0xQoGrob3iimwUrBR3YAEh4YWM0F2tarqmK3hGWQdyN+Ke+YvbmgoxmdpqWpdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722374574; c=relaxed/simple;
	bh=RCyXB4V21ndreCSUROM/QFnhUzJbb9FhaSwMhxqy5CA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=I52g4lPu158LpqYSgcrMugvKQ0fFaIfQU9yFkhr5G5mzFEmeFOv77jZZhN9hnvymmvgVBpxt/5B7XWEr5m/OuQT4mvNm45B0Oyyj19b3HdEFKaCp5O7uNR6H5FPrN2V8dVX/1snrsSxVvgIZb05biZlc2VbFrI4AR4y3EVXOTIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=fiJfG0rQ; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-76cb5b6b3e4so3069311a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 14:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1722374570; x=1722979370; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=lSAZ/0e3vxufk97FChYubRiOc48MpM651wYXnibrJl4=;
        b=fiJfG0rQK5ZJjPeCqIIYiYsz5zUuBvo5BewcbowDxdKpy5PK8ye/vLh3T9eMY7pZ1J
         3F4QjwEyLelRB5BIpwroaAEec/p8S8lg5nuN9aM0EkHD0mLkND0DsQwL1J66/LVOgwOX
         DLpKcirBac3f5y6/iqu4FoO81wTZg0TGdNsE64MvsLsEjpT2VybXV6jDzfVUGsQanAWo
         0jSS5g4ES+EJ7qXZc075vS44StZZhpoc/wq0SGooaIzyT0GHAaUOes/ox5BGD5IfTroo
         G8/plgx2tdegUWNHW2ArI0r9N9XEnfLTed56RDeI60vsT+lB9FEobZ6mDiGLxL/xBIFQ
         D5Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722374570; x=1722979370;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lSAZ/0e3vxufk97FChYubRiOc48MpM651wYXnibrJl4=;
        b=Q759FeK9KbIxnl2RZjmh9dcO4v9LlDINy+zVKrHvMMjSlortSrnFSUnL6SNkJCacnq
         3I47f4jjRHxM5+Ufbid2YVZkIMzIkBg/5OHWvGqTjdz1f0Lj6DKIJGuR/jMw5VnzXIr5
         6E4/EDlTC8ntcOFCll6EThb3050OjXIIHQNXP9wbcoLSvpHSDvJed2aLowQQk+Intuq7
         bdrVSoZC4T0SsQaq/5t+qHTBClE4ZVmhQoXkSdocPncunaiFcsDkcMGrSkb5r1bgE2ix
         QdUAfRdCLdgDTtwHvuQB6Z9zeb4cYoUc/SV1x/3OoOdo9vq19FZ45vxAqIkcdzGd5Bfk
         BvWw==
X-Forwarded-Encrypted: i=1; AJvYcCUZICv/3rl8fqtoYyzXKNLgw0VbSch0VXHTeU1XdSSmTPZUoQ1yr6nNsI59wB2tnAUwp9ZvlmakIvHfhpGoDvi6ymEjwvRV6icGGK/Z
X-Gm-Message-State: AOJu0Ywu2Zv+vcUt3jFofs8r/hVgKKs/ggOoPfNSEBuMwf57qJfI7tpO
	GYyVpznfgk8zR0Utl/SsqUz25E2P3sdkoNT0YckJZw6BtWlE4109xswW5ld8jH0=
X-Google-Smtp-Source: AGHT+IH9bMw0hcFAvLIjZgRgjAbIFYieWwlgocGF3033Pqj4XUKk5VtAkzU1YoxPo9v4luCXtq6pAw==
X-Received: by 2002:a17:90a:468d:b0:2c9:7e80:6bc8 with SMTP id 98e67ed59e1d1-2cf7e71b37emr10000581a91.37.1722374570266;
        Tue, 30 Jul 2024 14:22:50 -0700 (PDT)
Received: from localhost (75-172-120-197.tukw.qwest.net. [75.172.120.197])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cf28c9c764sm11119757a91.26.2024.07.30.14.22.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 14:22:49 -0700 (PDT)
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
Subject: Re: [PATCH 5/5] serial: 8250: omap: Set wakeup pinctrl on suspend
In-Reply-To: <20240523075819.1285554-6-msp@baylibre.com>
References: <20240523075819.1285554-1-msp@baylibre.com>
 <20240523075819.1285554-6-msp@baylibre.com>
Date: Tue, 30 Jul 2024 14:22:49 -0700
Message-ID: <7hh6c660d2.fsf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Markus Schneider-Pargmann <msp@baylibre.com> writes:

> To enable the serial driver and it's pin to be a wakeup source in
> suspend to ram states, select the wakeup pinctrl state on suspend and
> restore the default pinctrl state on resume.
>
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>

Reviewed-by: Kevin Hilman <khilman@baylibre.com>

but with a minor nit below...

> ---
>  drivers/tty/serial/8250/8250_omap.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
> index 617a421a1396..61f056c4e78e 100644
> --- a/drivers/tty/serial/8250/8250_omap.c
> +++ b/drivers/tty/serial/8250/8250_omap.c
> @@ -1663,6 +1663,13 @@ static int omap8250_suspend(struct device *dev)
>  	struct generic_pm_domain *genpd = pd_to_genpd(dev->pm_domain);
>  	int err = 0;
>  
> +	err = omap8250_select_wakeup_pinctrl(dev, priv);
> +	if (err) {
> +		dev_err(dev, "Failed to select wakeup pinctrl, aborting suspend %pe\n",
> +			ERR_PTR(err));
> +		return err;
> +	}
> +
>  	serial8250_suspend_port(priv->line);
>  
>  	err = pm_runtime_resume_and_get(dev);
> @@ -1696,6 +1703,13 @@ static int omap8250_resume(struct device *dev)
>  	struct generic_pm_domain *genpd = pd_to_genpd(dev->pm_domain);
>  	int err;
>  
> +	err = pinctrl_select_default_state(dev);
> +	if (err) {
> +		dev_err(dev, "Failed to select default pinctrl state on resume: %pe\n",
> +			ERR_PTR(err));
> +		return err;
> +	}

Shouldn't this bit should be at the end of this resume function?
Otherwise, if this fails, the UART could be left unusable, and if it's
the console UART, you wouldn't get any logs to know why.

>  	if (uart_console(&up->port) && console_suspend_enabled) {
>  		if (console_suspend_enabled) {
>  			err = pm_runtime_force_resume(dev);
> -- 
> 2.43.0

Kevin

