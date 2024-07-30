Return-Path: <linux-kernel+bounces-268124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3418B9420A2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 21:34:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBFE8283F4B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 19:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3196218C92D;
	Tue, 30 Jul 2024 19:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="OhghCyWA"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA03D149C41
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 19:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722368041; cv=none; b=nVrQPCYiBt9EKvz9fjmQCGaJ4o2LTFl14FshW7E+lxoM4ZvU8IfT1GPIJaO7R+TaXUzLCN40dlx8IAsY2ZGorcIECnDQvr8MPMUUI7zLbEw/hxpGCRONEoXTtIoJHFCbxeZ/f0Gzzkkiuo4YJmnfi0jpbRjpA4//trYrtWgWF1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722368041; c=relaxed/simple;
	bh=omf2X1L/LKEL4UHtKhSM2wQmgye4tQs+vDaZiXSvInQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FVDk0QuWBohYw/BP73ol8DbusGeey8c5BmqqrZBHGgRPckgLu8QkIMdp9CugXh2AUK7Cw5yV4S6dX4Nwk4F63bjIaaa25nJ9uf5CDwny95n+lKsHkXO38AQ1tvc8YWRDJePihH6ABZlv52MhE9MUL1Tn53lqvuaOqsjY+6MMU8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=OhghCyWA; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1fd69e44596so1716465ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 12:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1722368039; x=1722972839; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=VeimEcrtXREu345QOU87DnizcugtBEtpmX3D5QJy8J4=;
        b=OhghCyWATs/ozEG4uDYanTn1mnhf1y82xZ9/fNjaE/cawi3B3HoyR0jGck5QNxzirG
         Obpo8Ft7x++GlfN8AYHpR2GwhqxFNVASfDkylzN8tzUZyZFetZNj0VWIEzS6kAhK+xba
         x1QiajA6cGk481ggv+iaZEMWlRPTTbEG/+wLTs4a3z/L2kq12N9igc1KYp1jnq0Ub3tV
         OZM9PpbLcvy2xqQsMtQAklo80FI1E3lPtOmXdQBJJH2YoVpOHQN6DWLRgWug0Fi9r0ic
         mwK4/MbDf6DM6W58LrvLCfSybrRlJxQYew+JJ0qTbyK/v00s87qnXDCwG8T3Ee1T5Zz0
         R/KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722368039; x=1722972839;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VeimEcrtXREu345QOU87DnizcugtBEtpmX3D5QJy8J4=;
        b=OU6R1mMKLYX0zPnGrsBH5wLbYULZs97cHPBgT0sRZhJNd62evgPd1WI1ls4oyHNYN2
         h0x7LeBdPXtKYg0ylzhkCdHx/4xvKf4PIJW1IEmBY36Cek6cuL0I2qS4nPpdS/wEhhy2
         h+TBGuFNfggtqVu0rCME6b966QG5prbaCiTapgBssLMVPU+/6FaK/QrchwVCeELCiu1U
         yx86xHfDU/X7jJtTL+VH0dZNx8EZROzKk49p17Yahbph5gVC3Un70Gc43a5wvtNf6Vex
         QQUqvqpToj/RRfi6cwu8rg8v/eWGgGBobFzTFUEtLCfeYIrAnOrTg1I/JPuBwNS/0cuW
         vIoA==
X-Forwarded-Encrypted: i=1; AJvYcCX7AfLNw6m4TPUNG1RU5t1CtHLkBSSBwfb7H1jBMHnlW4E0FNTUZV0lVGTNupu51dO4/togy3FKxGmxRuf3t0ts3PJzned0P1rK+IUn
X-Gm-Message-State: AOJu0YwM0iZQlmWsR7b4fNrRMs+a/0o/zBI19eJwCbyhZg/0WNJIsmo7
	IB7O+pYD0Yr1SaFvIp2Jx+UHk52WCTShLiBGS9bRQ4oWHag3ms/ZxM93IxwSvRQ=
X-Google-Smtp-Source: AGHT+IFkDhc8yviwAlThuG4ZoWAs5VdPkSosPcXR0VUE/A4FR2+6AXlSgN0b2AGf1N+G4hTO/60CJA==
X-Received: by 2002:a17:902:c40f:b0:1fb:5d71:20dd with SMTP id d9443c01a7336-1ff37b2efc8mr57345095ad.0.1722368038924;
        Tue, 30 Jul 2024 12:33:58 -0700 (PDT)
Received: from localhost (75-172-120-197.tukw.qwest.net. [75.172.120.197])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7a9f8461b5asm9312814a12.36.2024.07.30.12.33.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 12:33:58 -0700 (PDT)
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
Subject: Re: [PATCH 3/5] serial: 8250: omap: Set wakeup capable, do not enable
In-Reply-To: <20240523075819.1285554-4-msp@baylibre.com>
References: <20240523075819.1285554-1-msp@baylibre.com>
 <20240523075819.1285554-4-msp@baylibre.com>
Date: Tue, 30 Jul 2024 12:33:57 -0700
Message-ID: <7hsevq65ei.fsf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Markus Schneider-Pargmann <msp@baylibre.com> writes:

> The driver sets wakeup enable by default. But not all uarts are meant to
> be wakeup enabled. Change the default to be wakeup capable but not
> enabled. The user can enable wakeup when needed.
>
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>

Acked-by: Kevin Hilman <khilman@baylibre.com>

> ---
>  drivers/tty/serial/8250/8250_omap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
> index ca456ea23317..5b7508dfb5d8 100644
> --- a/drivers/tty/serial/8250/8250_omap.c
> +++ b/drivers/tty/serial/8250/8250_omap.c
> @@ -1496,7 +1496,7 @@ static int omap8250_probe(struct platform_device *pdev)
>  
>  	platform_set_drvdata(pdev, priv);
>  
> -	device_init_wakeup(&pdev->dev, true);
> +	device_set_wakeup_capable(&pdev->dev, true);
>  	pm_runtime_enable(&pdev->dev);
>  	pm_runtime_use_autosuspend(&pdev->dev);
>  
> -- 
> 2.43.0

