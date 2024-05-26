Return-Path: <linux-kernel+bounces-189728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 966308CF426
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2024 14:01:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB11F1C20917
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2024 12:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25976D53C;
	Sun, 26 May 2024 12:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="cZxp1FGp"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE36883D
	for <linux-kernel@vger.kernel.org>; Sun, 26 May 2024 12:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716724880; cv=none; b=s23GyUiNJYKGk67o502rsdqrBF7oZOyBIyT+0HyLfxfPsgTj96jLYK279y/QLBL+aQtcRWOHSja2bjITs9gVIEuXtAnS0zTI+TdltrygyDiGaH5EOM0gOkDtdiiZc26YJpJkjnVHEXOewBCXGtpVm+7jE4MgREOytxgRWpTmUOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716724880; c=relaxed/simple;
	bh=in2sBYIbdKVYfw+Qb1jCBsiXEMEqYYBkJtxjrunmwvA=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MuXgbWN2FmTSRbMvEq+CPKzw7phlZSpxD3V2WWF0SoeEIwYpk0x3UZnsqZEyDKedmn9DmMh39BaL1PJQdDYloA1gAaYEG888JAfFbcuIhNhVOdYo9gaKA2zKQfN+/rdnklw18RlIvEZni0Cu7zMS1Ihqy05pz7kyqonvnTLr3RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=cZxp1FGp; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id CCE643F682
	for <linux-kernel@vger.kernel.org>; Sun, 26 May 2024 12:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1716724868;
	bh=tvkwPnG/2WS9EBDE3dwEymI8zBU1MKtjDDlk1d+P43Y=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=cZxp1FGpu5+RT5MxAL/6L5ZboOyid6UKX6919bXRJ/p3k7xPvz5aKiEDCBLbVaIxZ
	 Pr2aepMBY86bZyZiItsSPG/JI3CXVuqkscX+RpffDvYSZ7S0NMlNHuQ9MBJhFl+D1A
	 waIdkb1yeDnZ06EkiH2R7fCjx3MSU50dewrzEiJ1K0hsMh9EVfWnzhLdRqeqgc4qIm
	 dosU+iVZzeC89Uyr+dcHCAwNurbzSYrgllJC0PgwVttH+o8B0cuv3tPLaY6VvOxB9+
	 HUQ+qZFL0OiGTwFHkzupJTYyl7+2y5PB/65PVA21/60nAk79SSFUGTB2YW9hLnS/Ti
	 gCL+dL6G0pdJg==
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-43fb098389aso40092581cf.1
        for <linux-kernel@vger.kernel.org>; Sun, 26 May 2024 05:01:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716724868; x=1717329668;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tvkwPnG/2WS9EBDE3dwEymI8zBU1MKtjDDlk1d+P43Y=;
        b=Efmgugmk07OA7PPSrlMETtXvGEriq5y3cRIL+u0GD2t+sL0A5YIhIaVuUnOkCUQtKL
         agJqUWGa8RdsN2MQV6FOvzVl0a9QnelvSnbo/B37eRhDADOc9k/AATDiNXDjzdUuAoMg
         8kmh6sTbmV3TotQIQeCoNkixz6pqHao6baPBBbrJ0q82UGJHNmB3sOeCRdozOAJ8oSNr
         z6NXxvy4ib/brVsFqVln13W51RnsIUWbWF3KKyZ8O5IN6RL+v0Jd/0clBz78SSwAQOz4
         3fBRQwLX0ipQJN9ZYFDJLYhWCzy4vGPcPOc+P5YR7kunVAsUpxHWsuu+MjuisfvSicA7
         2AZA==
X-Forwarded-Encrypted: i=1; AJvYcCVW36c/3G7XSZaGmj7ma6d1BbaIuv86sz+LKWUfR/KDXlkoV7B9XiEOIhqjEekajiZggeFL41R/vjPLPs+iAT5HyCFXTGWkqOTjli2I
X-Gm-Message-State: AOJu0YzUERh5+joghOWN7z3rS4BA0UOALb8+G1f/osu7u04SW7qKHlpt
	7zdKqaPSbyQmUFwf6pBfcFH5t+g32lcCxcH7LFGHOk7v7us2J5fnOvCRusC6oRa76Hj07ZsDJws
	YHrd8JmZz7by64e94SodYd2ZSWFyfIObPhrWePXDM6LEW7h2rwdqVnZe78bqiT+RPwjm/d7V5/v
	pr0PPoG7W1WqF4P6UGTIdglfC3xkYSt1kT5Mnv8Q9/AtjWfiTq8XHU
X-Received: by 2002:ac8:7c44:0:b0:43e:b52:eea1 with SMTP id d75a77b69052e-43fa746b00cmr180430651cf.16.1716724867832;
        Sun, 26 May 2024 05:01:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJkeH2LUqAq82Lwd2C/Zgjoasg6mKLwrH8I1wgWYFfVMAYYWA5MjWZNr4+CmcBQiREsO5oMSN6bb46jagFZVU=
X-Received: by 2002:ac8:7c44:0:b0:43e:b52:eea1 with SMTP id
 d75a77b69052e-43fa746b00cmr180430101cf.16.1716724867369; Sun, 26 May 2024
 05:01:07 -0700 (PDT)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 26 May 2024 12:01:06 +0000
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <20240517-i2c-th1520-v2-2-d364d135ccc6@bootlin.com>
References: <20240517-i2c-th1520-v2-0-d364d135ccc6@bootlin.com> <20240517-i2c-th1520-v2-2-d364d135ccc6@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Sun, 26 May 2024 12:01:06 +0000
Message-ID: <CAJM55Z_jXFx05YJFOfsguvdABALhi143xpwt61AGiXiyTwRc7A@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] riscv: dts: thead: Add TH1520 I2C nodes
To: Thomas Bonnefille <thomas.bonnefille@bootlin.com>, Andi Shyti <andi.shyti@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jisheng Zhang <jszhang@kernel.org>, Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, 
	Drew Fustini <dfustini@tenstorrent.com>, 
	Emil Renner Berthing <emil.renner.berthing@canonical.com>, Conor Dooley <conor@kernel.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	=?UTF-8?Q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>, 
	linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Hi Thomas,

Thanks for the patch. Some comments below.

Thomas Bonnefille wrote:
> Add nodes for the five I2C on the T-Head TH1520 RISCV SoC.
>
> Signed-off-by: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
> ---
>  arch/riscv/boot/dts/thead/th1520.dtsi | 50 +++++++++++++++++++++++++++++++++++
>  1 file changed, 50 insertions(+)
>
> diff --git a/arch/riscv/boot/dts/thead/th1520.dtsi b/arch/riscv/boot/dts/thead/th1520.dtsi
> index de7116290ca4..ae6cf4c441cf 100644
> --- a/arch/riscv/boot/dts/thead/th1520.dtsi
> +++ b/arch/riscv/boot/dts/thead/th1520.dtsi
> @@ -252,6 +252,36 @@ gpio2: gpio-controller@0 {
>  			};
>  		};
>
> +		i2c0: i2c@ffe7f20000 {
> +			compatible = "thead,th1520-i2c", "snps,designware-i2c";
> +			reg = <0xff 0xe7f20000 0x0 0x4000>;
> +			interrupts = <44 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clk CLK_I2C0>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			status = "disabled";
> +		};
> +
> +		i2c1: i2c@ffe7f24000 {
> +			compatible = "thead,th1520-i2c", "snps,designware-i2c";
> +			reg = <0xff 0xe7f24000 0x0 0x4000>;
> +			interrupts = <45 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clk CLK_I2C1>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			status = "disabled";
> +		};
> +
> +		i2c4: i2c@ffe7f28000 {
> +			compatible = "thead,th1520-i2c", "snps,designware-i2c";
> +			reg = <0xff 0xe7f28000 0x0 0x4000>;
> +			interrupts = <48 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clk CLK_I2C4>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			status = "disabled";
> +		};
> +

These nodes should be ordered by their memory addres, but the gpio2 controller
above has address 0xffe7f34000 which is greater than i2c0 at 0xffe7f20000.

>  		gpio@ffe7f38000 {
>  			compatible = "snps,dw-apb-gpio";
>  			reg = <0xff 0xe7f38000 0x0 0x1000>;
> @@ -342,6 +372,16 @@ uart2: serial@ffec010000 {
>  			status = "disabled";
>  		};
>
> +		i2c3: i2c@ffec014000 {
> +			compatible = "thead,th1520-i2c", "snps,designware-i2c";
> +			reg = <0xff 0xec014000 0x0 0x4000>;
> +			interrupts = <47 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clk CLK_I2C3>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			status = "disabled";
> +		};
> +
>  		dmac0: dma-controller@ffefc00000 {
>  			compatible = "snps,axi-dma-1.01a";
>  			reg = <0xff 0xefc00000 0x0 0x1000>;
> @@ -416,6 +456,16 @@ uart5: serial@fff7f0c000 {
>  			status = "disabled";
>  		};
>
> +		i2c5: i2c@fff7f2c000 {
> +			compatible = "thead,th1520-i2c", "snps,designware-i2c";
> +			reg = <0xff 0xf7f2c000 0x0 0x4000>;
> +			interrupts = <49 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clk CLK_I2C5>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			status = "disabled";
> +		};
> +

I know it's probably hard to test i2c2 with the Ahead board, but chances are
very low that the disignware driver works with i2c0, i2c1, i2c3, i2c4 and i2c5,
but not i2c2, so plaese add that node too. The audio and aon i2cs are fine to
add later.

>  		timer4: timer@ffffc33000 {
>  			compatible = "snps,dw-apb-timer";
>  			reg = <0xff 0xffc33000 0x0 0x14>;
>
> --
> 2.45.1
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

