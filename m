Return-Path: <linux-kernel+bounces-230848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A819C9182A4
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 15:37:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54A711F260A4
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 13:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 606B718309C;
	Wed, 26 Jun 2024 13:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LxeuTmCZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F58CD27A;
	Wed, 26 Jun 2024 13:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719409052; cv=none; b=uCnni3IpHsTUjd6Hp2lBMM1a945F/q6jzO1fMh5bofLuTsGjPed0Zzpwy4j4lRsWZvyzB+n06z2+YcjmWAP6WdpY+DszPTsaeMLwwztQR9eq30w9XLm0ZdR5JgZJ3RqAcDNgrP4bL1gvjr3LAwkxKZjj/X6F4zI5Uk8QD6BClmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719409052; c=relaxed/simple;
	bh=As0Bh7KDJUH3zjAni78IqOcOnk5zwOW4rEU9qn+ia38=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b/HZanSJKvLiDXgrf+qGtPIO3TdfUYV1mPkAwb5kpQxQXfzU05CHX2WVc4kY70Xiten4QyimL+vvQRpZwoH0GjJGBf8T4t6sO46bVjgAWOK/TrO19rrVhTDHGEbmcMJxmSOVBsZjm+D/pQZ/IzL2iQz0xpyfY4DYlQaokTPnSW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LxeuTmCZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 354C1C4AF0A;
	Wed, 26 Jun 2024 13:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719409052;
	bh=As0Bh7KDJUH3zjAni78IqOcOnk5zwOW4rEU9qn+ia38=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=LxeuTmCZHUH/qbBAmhMOI4SSYSbx80xItazS3xwQke1kJkMGpDjfJMZaqVF9K7TtQ
	 Adg+qffBvAfo+yBA/aNae7YyabkEceAFXtEed0ova8MZJ2/3FgiGh/JwDVogDW5Cnx
	 TKiZ+nVcKvH462VwSINy0a4ql2F2R1DdYXJewiHT5+m1AHIKq6fTuDmu+0VROEGSvL
	 4x88eI4pxk//IFE3wtrwzZG+rDrYvRSIe1k/EZ+ZZ/rhDgysgiJwUjNHzu7TRhiIJM
	 etXd4nN56zWmHRihBRaXowHhI9WkyywS73vCAyJn25UaIxZy1DnWcjjXINPeA/MMYy
	 jab068L7muXlA==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-52cdf4bc083so6671357e87.2;
        Wed, 26 Jun 2024 06:37:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUHB9dHZA/DAzJ9wJ/NcuWIm7gbStaCC01M1kAnczP+Q0po2JAg7u+EryttMK9Ut7GqWcGoRuUQn4kY6e93H+Ts3266FkRdaBGlHq+tlov2+SXLPQTupyOCYO3pWaf8ksYds1AxfNCFUA==
X-Gm-Message-State: AOJu0YwuJS2+vRVXFCmlbcf3N9FockNNyLVoI3mQDbX/LKq5Fbpas2FY
	+Ai8dCee4XLxQfCmbFjhuDkx8Lur8/URDQPUIRRJttBACEJ6ptcdtW4DfFsQSGCq5B8NZfwGM9K
	LV32mwk5ymCCwPAvek+z40eOaFA==
X-Google-Smtp-Source: AGHT+IEdo1EwuO6AMJ8bC+vU4ucHZMLDoHvU4PJwBzq73H4xZeA4eiWmU/5LP9RQuRzcWgNIUJTVvO7Jkop0LJ0ijJg=
X-Received: by 2002:ac2:59c6:0:b0:529:ed29:dc94 with SMTP id
 2adb3069b0e04-52ce0641428mr8222345e87.44.1719409050558; Wed, 26 Jun 2024
 06:37:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240626090744.174351-1-Delphine_CC_Chiu@wiwynn.com> <20240626090744.174351-4-Delphine_CC_Chiu@wiwynn.com>
In-Reply-To: <20240626090744.174351-4-Delphine_CC_Chiu@wiwynn.com>
From: Rob Herring <robh@kernel.org>
Date: Wed, 26 Jun 2024 07:37:18 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+A_+P21raZKKKVxrXNfUt9hvFLghZs5LZSQBp1Jgp=dg@mail.gmail.com>
Message-ID: <CAL_Jsq+A_+P21raZKKKVxrXNfUt9hvFLghZs5LZSQBp1Jgp=dg@mail.gmail.com>
Subject: Re: [PATCH v9 03/26] ARM: dts: aspeed: yosemite4: Enable spi-gpio setting
To: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
Cc: patrick@stwcx.xyz, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
	Andrew Jeffery <andrew@codeconstruct.com.au>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 26, 2024 at 3:08=E2=80=AFAM Delphine CC Chiu
<Delphine_CC_Chiu@wiwynn.com> wrote:
>
> enable spi-gpio setting for spi flash

I don't see a flash device added.

>
> Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
> ---
>  .../aspeed/aspeed-bmc-facebook-yosemite4.dts   | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b=
/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> index dd88be47d1c8..effc2af636a4 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> @@ -53,6 +53,24 @@ iio-hwmon {
>                                 <&adc0 4>, <&adc0 5>, <&adc0 6>, <&adc0 7=
>,
>                                 <&adc1 0>, <&adc1 1>, <&adc1 7>;
>         };
> +
> +       spi_gpio: spi-gpio {
> +               compatible =3D "spi-gpio";
> +               #address-cells =3D <1>;
> +               #size-cells =3D <0>;
> +
> +               gpio-sck =3D <&gpio0 ASPEED_GPIO(X, 3) GPIO_ACTIVE_HIGH>;
> +               gpio-mosi =3D <&gpio0 ASPEED_GPIO(X, 4) GPIO_ACTIVE_HIGH>=
;
> +               gpio-miso =3D <&gpio0 ASPEED_GPIO(X, 5) GPIO_ACTIVE_HIGH>=
;

Not the right properties for GPIOS. Run 'make dtbs_check' on your DT files.

> +               num-chipselects =3D <1>;
> +               cs-gpios =3D <&gpio0 ASPEED_GPIO(X, 0) GPIO_ACTIVE_LOW>;
> +
> +               tpmdev@0 {

tpm@0

> +                       compatible =3D "tcg,tpm_tis-spi";
> +                       spi-max-frequency =3D <33000000>;
> +                       reg =3D <0>;
> +               };
> +       };
>  };
>
>  &uart1 {
> --
> 2.25.1
>
>

