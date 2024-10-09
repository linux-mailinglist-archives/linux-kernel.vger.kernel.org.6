Return-Path: <linux-kernel+bounces-356466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91CCD99617D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 09:53:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CA6C1F2138E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 07:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78766187859;
	Wed,  9 Oct 2024 07:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="FbPPFQvJ"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F79186E4A
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 07:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728460405; cv=none; b=gteCY5ptQBo3OUY0YBPw86ww6QuM550e5K6ak6gNWU6xHSull4qwKIUvRq54DfKqIe1Els99QQYDbrgh8o0krXlV0JJCs5NaGxnfsCysUj1HUgpLtVHORl8LYbDaF7a6SE2BfRpxmofZNLldH4hLXk/l7OzCeybkB9+NTe2M1/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728460405; c=relaxed/simple;
	bh=0nVeT7W5+Phhjja0nEmY6ftWXeXsW/gjY9Bp9By1aqc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WNLursL6WtAYfFUU3QEKRMdIFa7gJUYD/tsajgf9txaBSlVUulEWH1an0VOAknw+AI5lDjgKSA4knBzL7rnNsSu84fnYCKbPvguYKtMEfySfDqMPi/i0Xi3OzqkkuDpvzBNK7mf8tGSh+F5jPj4np/J0R+/+BJ4DAQB3PUoJstg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=FbPPFQvJ; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a99543ab209so399226466b.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 00:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1728460402; x=1729065202; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2HCfwfKIq9ZbARroJ3ctAyi9/a5TyTRYtSwRyww5eKk=;
        b=FbPPFQvJ76u70lTZmv6PYQKszH/Sh80zhvXmGS44iJDYoO+r0Mpk8lKmZ05sbWiRxy
         LVRRWlW/mUEzpWhQSlH6Tm1zCt4V/9VlvQLvJomx84jC5pjvv7ff2JLwnok/kLPa7pxm
         KhL2KJ96mmrgTm6r9gZgrMzwvTBmA+VICjfXOd/oGrX9aHuVBveGVvNoShaaZQ3pEtr3
         eDH6MxdhFngDUBhk2yYcutDITf322TSMhNuz3cRwMB5qrmKAhKt5EVDf2KK4Q1jMIjF8
         4Tr9gu+mdABJZ7rbm5PNhQY5duyD9+csx17CNr/Wzvnkiqd09FeirnwLrWpLPju90o9m
         dbLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728460402; x=1729065202;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2HCfwfKIq9ZbARroJ3ctAyi9/a5TyTRYtSwRyww5eKk=;
        b=DQnk5Eyf+m5x8FXlE4Kesrt72WxoRpegrfPOMiErlEaydJeWtvYGzybiYgDLM8IHGe
         mB8lSF/o1xTNndfF/Jf1jc3P9ytBErtKcCzZnDAWtJcTI+rPepvSLtGlAPxyXMXrUK4b
         m+BpF5tUNxJDtrjZ18kvCoadLKkq4evF7eh3RoNf+FDneDKqQs6692RpddzjKMN6cDSe
         cZHZA6Ptkw0OTUQUcddwerO0ePce9FxbBpcATQfbzBUg83QbcCHVrKCGCOF8XfdX/f86
         vwp/QxWBHmXek4+rhwiv5MS/TOHsUhhTUjrEfYzPR7/ltN91QlYnjVNPJp7yZiff/0g/
         PTkw==
X-Forwarded-Encrypted: i=1; AJvYcCU+fiLcls4YNcdWL6TTJaBocz2S9pxDB/zbQ0zfhL7Le18YK/NIUco2Bw7v6qgXCDwq3rZQlF8HgzyUyvQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4qgeiIYSRxK2vQ0kJctzALXIdblWJYnO2mdoKr1sdJ4dMOCzv
	/q3BfX0/powK4HeqvDJpVufRp3oQtg1DhsgYEVw/bI28EbzQeb6JsNX0lfXLCUQ=
X-Google-Smtp-Source: AGHT+IGQNbg3+XlDlAPHm+pG+j/DlGK4MmpO+b+YCiy639M+XJvMH8CAruvFmcbUVf8BjeF+BMsxiw==
X-Received: by 2002:a17:907:9485:b0:a8d:4631:83b0 with SMTP id a640c23a62f3a-a998d10bb80mr97448566b.5.1728460402185;
        Wed, 09 Oct 2024 00:53:22 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.23])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99309aa6afsm610392466b.112.2024.10.09.00.53.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Oct 2024 00:53:21 -0700 (PDT)
Message-ID: <bb4bf1af-ea62-433d-ab5e-982055a4cec9@tuxon.dev>
Date: Wed, 9 Oct 2024 10:53:19 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] pinctrl: renesas: rzg2l: Add support for
 enabling/disabling open-drain outputs
Content-Language: en-US
To: Prabhakar <prabhakar.csengg@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Magnus Damm <magnus.damm@gmail.com>
Cc: devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 Biju Das <biju.das.jz@bp.renesas.com>,
 Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20241004123658.764557-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20241004123658.764557-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20241004123658.764557-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 04.10.2024 15:36, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
> Add support for enabling and disabling open-drain outputs.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

I gave it a simple try on RZ/G3S. All good. You can add:

Tested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

> ---
> v1->v2
> - Implemented PIN_CONFIG_DRIVE_OPEN_DRAIN to disable open drain
> ---
>  drivers/pinctrl/renesas/pinctrl-rzg2l.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> index b2d309f742af..8d576cc74003 100644
> --- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> +++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> @@ -139,6 +139,7 @@
>  #define IEN(off)		(0x1800 + (off) * 8)
>  #define PUPD(off)		(0x1C00 + (off) * 8)
>  #define ISEL(off)		(0x2C00 + (off) * 8)
> +#define NOD(off)		(0x3000 + (off) * 8)
>  #define SD_CH(off, ch)		((off) + (ch) * 4)
>  #define ETH_POC(off, ch)	((off) + (ch) * 4)
>  #define QSPI			(0x3008)
> @@ -160,6 +161,7 @@
>  #define IOLH_MASK		0x03
>  #define SR_MASK			0x01
>  #define PUPD_MASK		0x03
> +#define NOD_MASK		0x01
>  
>  #define PM_INPUT		0x1
>  #define PM_OUTPUT		0x2
> @@ -1337,6 +1339,18 @@ static int rzg2l_pinctrl_pinconf_get(struct pinctrl_dev *pctldev,
>  		break;
>  	}
>  
> +	case PIN_CONFIG_DRIVE_OPEN_DRAIN:
> +	case PIN_CONFIG_DRIVE_PUSH_PULL:
> +		if (!(cfg & PIN_CFG_NOD))
> +			return -EINVAL;
> +
> +		arg = rzg2l_read_pin_config(pctrl, NOD(off), bit, NOD_MASK);
> +		if (!arg && param != PIN_CONFIG_DRIVE_PUSH_PULL)
> +			return -EINVAL;
> +		if (arg && param != PIN_CONFIG_DRIVE_OPEN_DRAIN)
> +			return -EINVAL;
> +		break;
> +
>  	case RENESAS_RZV2H_PIN_CONFIG_OUTPUT_IMPEDANCE:
>  		if (!(cfg & PIN_CFG_IOLH_RZV2H))
>  			return -EINVAL;
> @@ -1466,6 +1480,15 @@ static int rzg2l_pinctrl_pinconf_set(struct pinctrl_dev *pctldev,
>  			rzg2l_rmw_pin_config(pctrl, IOLH(off), bit, IOLH_MASK, index);
>  			break;
>  
> +		case PIN_CONFIG_DRIVE_OPEN_DRAIN:
> +		case PIN_CONFIG_DRIVE_PUSH_PULL:
> +			if (!(cfg & PIN_CFG_NOD))
> +				return -EINVAL;
> +
> +			rzg2l_rmw_pin_config(pctrl, NOD(off), bit, NOD_MASK,
> +					     param == PIN_CONFIG_DRIVE_OPEN_DRAIN ? 1 : 0);
> +			break;
> +
>  		case RENESAS_RZV2H_PIN_CONFIG_OUTPUT_IMPEDANCE:
>  			if (!(cfg & PIN_CFG_IOLH_RZV2H))
>  				return -EINVAL;

