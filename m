Return-Path: <linux-kernel+bounces-362457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4CBA99B531
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 15:48:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A0AC2832C5
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 13:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4188E1891B2;
	Sat, 12 Oct 2024 13:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="WboB9Kbf"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C54184542
	for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 13:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728740922; cv=none; b=jOJRzVQpH3EKcmt3P0/S3SYq0Pa5XqJ7fjEzkW110RNUTS5OPeOkcfbt7M1YVOoTwrVIrJ6XDwcWACCOAsvXKu+qSXKs76dKZnfmMbVrMQNDkDlVvJztXvX9n+MSLCXMfJ6h+bSA7LJYDkY1S/O3CEmHdyphxcioqgRIZnCjcMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728740922; c=relaxed/simple;
	bh=J3zfIbpiz5prGTnKXcyahwmDqrIPR/9CqfA6FNJkkyg=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SmNhWjRDepZ/gK6nfpCSXLnHEc2hvQuFiCW+qy0FNA4THE19ZC2j+PaI0TePRSXWPIT1yHPjiDOtcjfFEzdaM+YVPwVnRV9vzELFiclDf4x2B923G6LtpyweCBqAXG1N0/79UZZIMwGJmF+j1KDhBVwAChzv2VpnIHxBpAc8oyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=WboB9Kbf; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com [209.85.160.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id C8E4F3F690
	for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 13:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1728740919;
	bh=rt0UwgOB+qSrz8w0pdeUdXBOD7ZjXb/RHyISiF5KO80=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=WboB9KbfsK/oMGv0eh/8yvODS7keaaYC1/urbosYb33JQ+0KgAM8RTFHuqw6YNIlO
	 XZh0oqH/coT+n6Ei7LicaJV5iCb60epocC0bb9zZQusMs8ePRKzSufqQJxMDNaWogU
	 DEn2F5aUiiqTSrSjsbCrcZqUW7zZE12M9e/HOQrK98QJOm2r0ow4afgt4wUSsVRztX
	 xqjy29iju2zlvbLCsMx+BBEY17ZZTCshqQgMfD1Y4dvpaew5mAhSRoxFCB8gobH7TQ
	 SLrJXyVYQJXpgBbjkl567Rak3say5M6EfEGq4MNRM20UEDSefTPZiQEPsakNnA2WKM
	 Dy7oSr7+V0aDA==
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-287b3c7faf8so2545381fac.2
        for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 06:48:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728740918; x=1729345718;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rt0UwgOB+qSrz8w0pdeUdXBOD7ZjXb/RHyISiF5KO80=;
        b=fVm6tsp9ZI+DqlfEB9vc7qhtLuSKfeyaaX4pk+15LxNC0F8paOfv27OW57/JLUz7Sf
         96ovZeFp+wv1S7BEe3M7BrrAI/NSUF2B25s1md8F3PF2lQBPSR6/B1jgy68qhPJtl5Qo
         26nHhKGL8CYRcFGi1dNzzQCMI4RkTEGXke04xbU7w6qu+wNTWJyqzFWYI5QQE20YumFU
         7vXJQAhvoii0hGNv/+Q7k+9nzsZArx9zjcaNuPLrZgmWbQT9eeuCggbmrju0bfbJ6/GH
         ysMXOj4F4mnKAAbPskGUgEDAt2KA+Vxg8NkGRNjzV5fJXw6O71s5QN8FRvs5vhyZs57I
         bjeg==
X-Forwarded-Encrypted: i=1; AJvYcCXdCGt6oib2kgqFnDKb4AVkVxcsxV36YI6gk+QhJ6uBj+MI5dM/jIt2gsY2MLVbPwlk2p7taOEhDV6pPLo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUObGhR+kqgLn5dOzVF5ROB+INqcq4aV0hetYMEvZZn52HRqa4
	XvRPSvEDvgqAqfBlRzkvC52xBMn4o55b+cR+WuKayC2Gt0SOJ/X6JX89h8tYmJgeieHyug8tbt8
	6y1bVoqT2y4oWUJe/0ifL/kCy8UZHxj0mskl4cr29UVr7m+wKvwjoDnvCEe/EmuK7JdbfmAsjzy
	JnlSWLSIJNL/ZGZcbyuKQidOfvfPAapWQU68a3w5QTd/swx71ldsB0
X-Received: by 2002:a05:6871:722:b0:27b:686a:43b8 with SMTP id 586e51a60fabf-2886e0d763dmr3037262fac.47.1728740917768;
        Sat, 12 Oct 2024 06:48:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEUhb7FBT2aOLXEM13xU9YHNmJCMnEhGGv19i7zdJ6DXtz+B4k+R23VQtqo3lAABpFX8Opm/NU5UsTKo8p8s3U=
X-Received: by 2002:a05:6871:722:b0:27b:686a:43b8 with SMTP id
 586e51a60fabf-2886e0d763dmr3037258fac.47.1728740917464; Sat, 12 Oct 2024
 06:48:37 -0700 (PDT)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 12 Oct 2024 08:48:37 -0500
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <20240930-th1520-pinctrl-v3-7-32cea2bdbecb@tenstorrent.com>
References: <20240930-th1520-pinctrl-v3-0-32cea2bdbecb@tenstorrent.com> <20240930-th1520-pinctrl-v3-7-32cea2bdbecb@tenstorrent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Sat, 12 Oct 2024 08:48:37 -0500
Message-ID: <CAJM55Z_g63DMu+SAv2u1V86CYYOBUKwF_EZGbp9tb=zY777mVg@mail.gmail.com>
Subject: Re: [PATCH v3 7/8] riscv: dts: thead: Add TH1520 pinctrl settings for UART0
To: Drew Fustini <dfustini@tenstorrent.com>, Drew Fustini <drew@pdp7.com>, Guo Ren <guoren@kernel.org>, 
	Fu Wei <wefu@redhat.com>, Linus Walleij <linus.walleij@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, 
	Emil Renner Berthing <emil.renner.berthing@canonical.com>, 
	Thomas Bonnefille <thomas.bonnefille@bootlin.com>
Cc: linux-riscv@lists.infradead.org, linux-gpio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Drew Fustini wrote:
> From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
>
> Add pinctrl settings for UART0 used as the default debug console on
> both the Lichee Pi 4A and BeagleV Ahead boards.
>
> Tested-by: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
> Signed-off-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
> Signed-off-by: Drew Fustini <dfustini@tenstorrent.com>
> ---
>  arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts | 26 ++++++++++++++++++++++
>  arch/riscv/boot/dts/thead/th1520-lichee-pi-4a.dts  | 26 ++++++++++++++++++++++
>  2 files changed, 52 insertions(+)
>
> diff --git a/arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts b/arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts
> index 69f82e7afd0b..6c0b768e8d17 100644
> --- a/arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts
> +++ b/arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts
> @@ -71,7 +71,33 @@ &sdio0 {
>  	status = "okay";
>  };
>
> +&padctrl0_apsys {
> +	uart0_pins: uart0-0 {
> +		tx-pins {
> +			pins = "UART0_TXD";
> +			function = "uart";
> +			bias-disable;
> +			drive-strength = <3>;
> +			input-disable;
> +			input-schmitt-disable;
> +			slew-rate = <0>;
> +		};
> +
> +		rx-pins {
> +			pins = "UART0_RXD";
> +			function = "uart";
> +			bias-disable;
> +			drive-strength = <1>;
> +			input-enable;
> +			input-schmitt-enable;
> +			slew-rate = <0>;
> +		};
> +	};
> +};
> +
>  &uart0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&uart0_pins>;
>  	status = "okay";
>  };
>
> diff --git a/arch/riscv/boot/dts/thead/th1520-lichee-pi-4a.dts b/arch/riscv/boot/dts/thead/th1520-lichee-pi-4a.dts
> index 58ad381fc1c3..f60b1879192d 100644
> --- a/arch/riscv/boot/dts/thead/th1520-lichee-pi-4a.dts
> +++ b/arch/riscv/boot/dts/thead/th1520-lichee-pi-4a.dts
> @@ -30,7 +30,33 @@ chosen {
>  	};
>  };
>
> +&padctrl0_apsys {
> +	uart0_pins: uart0-0 {
> +		tx-pins {
> +			pins = "UART0_TXD";
> +			function = "uart";
> +			bias-disable;
> +			drive-strength = <3>;
> +			input-disable;
> +			input-schmitt-disable;
> +			slew-rate = <0>;
> +		};
> +
> +		rx-pins {
> +			pins = "UART0_RXD";
> +			function = "uart";
> +			bias-disable;
> +			drive-strength = <1>;
> +			input-enable;
> +			input-schmitt-enable;
> +			slew-rate = <0>;
> +		};
> +	};
> +};
> +
>  &uart0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&uart0_pins>;
>  	status = "okay";
>  };

For these two files you also broke the ordering.

/Emil

