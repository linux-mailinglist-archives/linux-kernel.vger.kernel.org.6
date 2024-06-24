Return-Path: <linux-kernel+bounces-226549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0412291403B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 03:55:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC7712815CB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 01:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8C0A46B5;
	Mon, 24 Jun 2024 01:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="Crc2bhX1"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F957FD;
	Mon, 24 Jun 2024 01:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719194129; cv=none; b=ltrEhmJLktMsTOulgemzTXSiqQOG1q0Q2wrzkErV2bjL+5zIG3e5eNAzIZdrPuHlqGUVLrAgx3Iyxb4XF78lkBC/u016AZ2IEYlKJdVL7kMwKFp+nWYvi7bKH8tbI9Hoq28Hvu0WwAqdudiia2n3bQBYd/4zvi9Te3pLYyogljo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719194129; c=relaxed/simple;
	bh=d8J1/c4Ecsgwo3/6MlhO2q5ewrlddl1e9QMNrWXaAr4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pdy8beguosGGRgGeQU+odfgfw2cP/qgqtqT754MaQeiaLaOJrozQ/+IEBY1E8CYOx/vp1fiKBhLiu7jQZjioZu3n24QCDTcQJRnyPWCqXweUL6dqLZvT7rodcjM4X5r8J+ZM7bEtvAW/cW/bB9T/NFNhqpPbzfJJtoVDqFTnlfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au; spf=pass smtp.mailfrom=gmail.com; dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b=Crc2bhX1; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-362bc731810so3350898f8f.1;
        Sun, 23 Jun 2024 18:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google; t=1719194124; x=1719798924; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Mv5F3gJNSVhzn+e6PbmhdJJ5gm0AtweUP0e5uStvQLY=;
        b=Crc2bhX1t0WqEYuTf6cQqtU0Cw8Gxdmwj0vsh12c5fkRvSQuHEwVn4CQ1ub4kTHunj
         4T0ydppFGih8Iruu0zLdpRtEbFBk3gBiIv62iQ1gO8BFJ0T6EupKZHIVaW4lq85G0epu
         YIOmUNpjiQefF5k6eSxKaFovte4Gn3VrdtHoQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719194124; x=1719798924;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mv5F3gJNSVhzn+e6PbmhdJJ5gm0AtweUP0e5uStvQLY=;
        b=BKVcC2dJNYh5a3kMu+Xe7YJDE9CUja3TnHgBmUMFqlP+tISHJB9ubFhxJKJBgix1gc
         L0Vj/R02aCNGePK/SX7yvKGNEcpKZSHvF0Ehlf1STWpHPsylCEKDjWPoZGZzWxvnKUmd
         LRx6bV9aSthDQtd7j7wyGNHrWr+APOQnb4OkYrSPwTLaI6Y6Cdj4+l64wynFb2w4/91n
         JXlubnXmaV7CKxtiBm2+23IxCshOR/xEUTb04wGMJ3lQyG9WAd++FQT64xcFYiYpcFE4
         S4Wc2dRF3wVzISLv+QfN+sVxLk1b4mvOtepuvjnou57CfmjInJFbOczHWkCdkO5JE8px
         HYJg==
X-Forwarded-Encrypted: i=1; AJvYcCWwTlf+epBk+PfHsbh09fmWCVoil4efqJ4Ol07b9kL4K5qP8VkkIzCXXzC8DSytZd1zORHuQjl1dR6aWu2USioPTeT50g4deJMkBaE6QkRjPBJisOY21Mg4Hdg5/BLC356LPhXMwXp64Q==
X-Gm-Message-State: AOJu0YzjjOoI2Xpjw1HY2skjhOXanVTH5JzlICZsBSqmZCXqODZVzLmV
	uzOa9m1cfJTFZ3JQKVTHYTWwBS8vZDnThkb1vxw4QMQXcsj/SMjmuJyl7+7/y91bQc49fiAJPUl
	36FgbboCMlupujX7xKdCQkO/M2KW2RTDK
X-Google-Smtp-Source: AGHT+IFNeXjFq3paeyUjIv8M9A14FXoR4HFW267SwtprEiB2S3khZdX4rFJrD0J0hkZKvSEM3C4i7DkSm+oR61KQ5uI=
X-Received: by 2002:a05:6000:178f:b0:366:ee01:30d6 with SMTP id
 ffacd0b85a97d-366ee0134b8mr2099521f8f.49.1719194124017; Sun, 23 Jun 2024
 18:55:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240531193115.3814887-1-robh@kernel.org>
In-Reply-To: <20240531193115.3814887-1-robh@kernel.org>
From: Joel Stanley <joel@jms.id.au>
Date: Mon, 24 Jun 2024 11:25:12 +0930
Message-ID: <CACPK8Xes5vp+3YpQ3L5ix=LaDv7oWtqGFVc8moQf4D+o3rnLjg@mail.gmail.com>
Subject: Re: [PATCH] arm: dts: aspeed: Use standard 'i2c' bus node name
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Andrew Jeffery <andrew@codeconstruct.com.au>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 1 Jun 2024 at 05:01, Rob Herring (Arm) <robh@kernel.org> wrote:
>
> The standard node name for I2C buses is 'i2c'.

Unfortunately this can't be merged, as it will break userspace. There
is a lot of code out there that looks up devices based on the device
tree node path:

https://github.com/openbmc/phosphor-state-manager/blob/3c1351cc2b63178876ef68f4107c9804d2e17dcc/meson.options#L140

Cheers,

Joel

>
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  arch/arm/boot/dts/aspeed/aspeed-g4.dtsi | 28 +++++++++++-----------
>  arch/arm/boot/dts/aspeed/aspeed-g5.dtsi | 28 +++++++++++-----------
>  arch/arm/boot/dts/aspeed/aspeed-g6.dtsi | 32 ++++++++++++-------------
>  3 files changed, 44 insertions(+), 44 deletions(-)
>
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-g4.dtsi b/arch/arm/boot/dts/aspeed/aspeed-g4.dtsi
> index 857cb26ed6d7..c669ec202085 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-g4.dtsi
> +++ b/arch/arm/boot/dts/aspeed/aspeed-g4.dtsi
> @@ -463,7 +463,7 @@ i2c_ic: interrupt-controller@0 {
>                 interrupt-controller;
>         };
>
> -       i2c0: i2c-bus@40 {
> +       i2c0: i2c@40 {
>                 #address-cells = <1>;
>                 #size-cells = <0>;
>
> @@ -478,7 +478,7 @@ i2c0: i2c-bus@40 {
>                 /* Does not need pinctrl properties */
>         };
>
> -       i2c1: i2c-bus@80 {
> +       i2c1: i2c@80 {
>                 #address-cells = <1>;
>                 #size-cells = <0>;
>
> @@ -493,7 +493,7 @@ i2c1: i2c-bus@80 {
>                 /* Does not need pinctrl properties */
>         };
>
> -       i2c2: i2c-bus@c0 {
> +       i2c2: i2c@c0 {
>                 #address-cells = <1>;
>                 #size-cells = <0>;
>
> @@ -509,7 +509,7 @@ i2c2: i2c-bus@c0 {
>                 status = "disabled";
>         };
>
> -       i2c3: i2c-bus@100 {
> +       i2c3: i2c@100 {
>                 #address-cells = <1>;
>                 #size-cells = <0>;
>
> @@ -525,7 +525,7 @@ i2c3: i2c-bus@100 {
>                 status = "disabled";
>         };
>
> -       i2c4: i2c-bus@140 {
> +       i2c4: i2c@140 {
>                 #address-cells = <1>;
>                 #size-cells = <0>;
>
> @@ -541,7 +541,7 @@ i2c4: i2c-bus@140 {
>                 status = "disabled";
>         };
>
> -       i2c5: i2c-bus@180 {
> +       i2c5: i2c@180 {
>                 #address-cells = <1>;
>                 #size-cells = <0>;
>
> @@ -557,7 +557,7 @@ i2c5: i2c-bus@180 {
>                 status = "disabled";
>         };
>
> -       i2c6: i2c-bus@1c0 {
> +       i2c6: i2c@1c0 {
>                 #address-cells = <1>;
>                 #size-cells = <0>;
>
> @@ -573,7 +573,7 @@ i2c6: i2c-bus@1c0 {
>                 status = "disabled";
>         };
>
> -       i2c7: i2c-bus@300 {
> +       i2c7: i2c@300 {
>                 #address-cells = <1>;
>                 #size-cells = <0>;
>
> @@ -589,7 +589,7 @@ i2c7: i2c-bus@300 {
>                 status = "disabled";
>         };
>
> -       i2c8: i2c-bus@340 {
> +       i2c8: i2c@340 {
>                 #address-cells = <1>;
>                 #size-cells = <0>;
>
> @@ -605,7 +605,7 @@ i2c8: i2c-bus@340 {
>                 status = "disabled";
>         };
>
> -       i2c9: i2c-bus@380 {
> +       i2c9: i2c@380 {
>                 #address-cells = <1>;
>                 #size-cells = <0>;
>
> @@ -621,7 +621,7 @@ i2c9: i2c-bus@380 {
>                 status = "disabled";
>         };
>
> -       i2c10: i2c-bus@3c0 {
> +       i2c10: i2c@3c0 {
>                 #address-cells = <1>;
>                 #size-cells = <0>;
>
> @@ -637,7 +637,7 @@ i2c10: i2c-bus@3c0 {
>                 status = "disabled";
>         };
>
> -       i2c11: i2c-bus@400 {
> +       i2c11: i2c@400 {
>                 #address-cells = <1>;
>                 #size-cells = <0>;
>
> @@ -653,7 +653,7 @@ i2c11: i2c-bus@400 {
>                 status = "disabled";
>         };
>
> -       i2c12: i2c-bus@440 {
> +       i2c12: i2c@440 {
>                 #address-cells = <1>;
>                 #size-cells = <0>;
>
> @@ -669,7 +669,7 @@ i2c12: i2c-bus@440 {
>                 status = "disabled";
>         };
>
> -       i2c13: i2c-bus@480 {
> +       i2c13: i2c@480 {
>                 #address-cells = <1>;
>                 #size-cells = <0>;
>
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed/aspeed-g5.dtsi
> index e6f3cf3c721e..6e05cbcce49c 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-g5.dtsi
> +++ b/arch/arm/boot/dts/aspeed/aspeed-g5.dtsi
> @@ -592,7 +592,7 @@ i2c_ic: interrupt-controller@0 {
>                 interrupt-controller;
>         };
>
> -       i2c0: i2c-bus@40 {
> +       i2c0: i2c@40 {
>                 #address-cells = <1>;
>                 #size-cells = <0>;
>
> @@ -607,7 +607,7 @@ i2c0: i2c-bus@40 {
>                 /* Does not need pinctrl properties */
>         };
>
> -       i2c1: i2c-bus@80 {
> +       i2c1: i2c@80 {
>                 #address-cells = <1>;
>                 #size-cells = <0>;
>
> @@ -622,7 +622,7 @@ i2c1: i2c-bus@80 {
>                 /* Does not need pinctrl properties */
>         };
>
> -       i2c2: i2c-bus@c0 {
> +       i2c2: i2c@c0 {
>                 #address-cells = <1>;
>                 #size-cells = <0>;
>
> @@ -638,7 +638,7 @@ i2c2: i2c-bus@c0 {
>                 status = "disabled";
>         };
>
> -       i2c3: i2c-bus@100 {
> +       i2c3: i2c@100 {
>                 #address-cells = <1>;
>                 #size-cells = <0>;
>
> @@ -654,7 +654,7 @@ i2c3: i2c-bus@100 {
>                 status = "disabled";
>         };
>
> -       i2c4: i2c-bus@140 {
> +       i2c4: i2c@140 {
>                 #address-cells = <1>;
>                 #size-cells = <0>;
>
> @@ -670,7 +670,7 @@ i2c4: i2c-bus@140 {
>                 status = "disabled";
>         };
>
> -       i2c5: i2c-bus@180 {
> +       i2c5: i2c@180 {
>                 #address-cells = <1>;
>                 #size-cells = <0>;
>
> @@ -686,7 +686,7 @@ i2c5: i2c-bus@180 {
>                 status = "disabled";
>         };
>
> -       i2c6: i2c-bus@1c0 {
> +       i2c6: i2c@1c0 {
>                 #address-cells = <1>;
>                 #size-cells = <0>;
>
> @@ -702,7 +702,7 @@ i2c6: i2c-bus@1c0 {
>                 status = "disabled";
>         };
>
> -       i2c7: i2c-bus@300 {
> +       i2c7: i2c@300 {
>                 #address-cells = <1>;
>                 #size-cells = <0>;
>
> @@ -718,7 +718,7 @@ i2c7: i2c-bus@300 {
>                 status = "disabled";
>         };
>
> -       i2c8: i2c-bus@340 {
> +       i2c8: i2c@340 {
>                 #address-cells = <1>;
>                 #size-cells = <0>;
>
> @@ -734,7 +734,7 @@ i2c8: i2c-bus@340 {
>                 status = "disabled";
>         };
>
> -       i2c9: i2c-bus@380 {
> +       i2c9: i2c@380 {
>                 #address-cells = <1>;
>                 #size-cells = <0>;
>
> @@ -750,7 +750,7 @@ i2c9: i2c-bus@380 {
>                 status = "disabled";
>         };
>
> -       i2c10: i2c-bus@3c0 {
> +       i2c10: i2c@3c0 {
>                 #address-cells = <1>;
>                 #size-cells = <0>;
>
> @@ -766,7 +766,7 @@ i2c10: i2c-bus@3c0 {
>                 status = "disabled";
>         };
>
> -       i2c11: i2c-bus@400 {
> +       i2c11: i2c@400 {
>                 #address-cells = <1>;
>                 #size-cells = <0>;
>
> @@ -782,7 +782,7 @@ i2c11: i2c-bus@400 {
>                 status = "disabled";
>         };
>
> -       i2c12: i2c-bus@440 {
> +       i2c12: i2c@440 {
>                 #address-cells = <1>;
>                 #size-cells = <0>;
>
> @@ -798,7 +798,7 @@ i2c12: i2c-bus@440 {
>                 status = "disabled";
>         };
>
> -       i2c13: i2c-bus@480 {
> +       i2c13: i2c@480 {
>                 #address-cells = <1>;
>                 #size-cells = <0>;
>
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
> index 7fb421153596..0c00882f111a 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
> +++ b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
> @@ -905,7 +905,7 @@ udma: dma-controller@1e79e000 {
>  #include "aspeed-g6-pinctrl.dtsi"
>
>  &i2c {
> -       i2c0: i2c-bus@80 {
> +       i2c0: i2c@80 {
>                 #address-cells = <1>;
>                 #size-cells = <0>;
>                 reg = <0x80 0x80>;
> @@ -919,7 +919,7 @@ i2c0: i2c-bus@80 {
>                 status = "disabled";
>         };
>
> -       i2c1: i2c-bus@100 {
> +       i2c1: i2c@100 {
>                 #address-cells = <1>;
>                 #size-cells = <0>;
>                 reg = <0x100 0x80>;
> @@ -933,7 +933,7 @@ i2c1: i2c-bus@100 {
>                 status = "disabled";
>         };
>
> -       i2c2: i2c-bus@180 {
> +       i2c2: i2c@180 {
>                 #address-cells = <1>;
>                 #size-cells = <0>;
>                 reg = <0x180 0x80>;
> @@ -947,7 +947,7 @@ i2c2: i2c-bus@180 {
>                 status = "disabled";
>         };
>
> -       i2c3: i2c-bus@200 {
> +       i2c3: i2c@200 {
>                 #address-cells = <1>;
>                 #size-cells = <0>;
>                 reg = <0x200 0x80>;
> @@ -961,7 +961,7 @@ i2c3: i2c-bus@200 {
>                 status = "disabled";
>         };
>
> -       i2c4: i2c-bus@280 {
> +       i2c4: i2c@280 {
>                 #address-cells = <1>;
>                 #size-cells = <0>;
>                 reg = <0x280 0x80>;
> @@ -975,7 +975,7 @@ i2c4: i2c-bus@280 {
>                 status = "disabled";
>         };
>
> -       i2c5: i2c-bus@300 {
> +       i2c5: i2c@300 {
>                 #address-cells = <1>;
>                 #size-cells = <0>;
>                 reg = <0x300 0x80>;
> @@ -989,7 +989,7 @@ i2c5: i2c-bus@300 {
>                 status = "disabled";
>         };
>
> -       i2c6: i2c-bus@380 {
> +       i2c6: i2c@380 {
>                 #address-cells = <1>;
>                 #size-cells = <0>;
>                 reg = <0x380 0x80>;
> @@ -1003,7 +1003,7 @@ i2c6: i2c-bus@380 {
>                 status = "disabled";
>         };
>
> -       i2c7: i2c-bus@400 {
> +       i2c7: i2c@400 {
>                 #address-cells = <1>;
>                 #size-cells = <0>;
>                 reg = <0x400 0x80>;
> @@ -1017,7 +1017,7 @@ i2c7: i2c-bus@400 {
>                 status = "disabled";
>         };
>
> -       i2c8: i2c-bus@480 {
> +       i2c8: i2c@480 {
>                 #address-cells = <1>;
>                 #size-cells = <0>;
>                 reg = <0x480 0x80>;
> @@ -1031,7 +1031,7 @@ i2c8: i2c-bus@480 {
>                 status = "disabled";
>         };
>
> -       i2c9: i2c-bus@500 {
> +       i2c9: i2c@500 {
>                 #address-cells = <1>;
>                 #size-cells = <0>;
>                 reg = <0x500 0x80>;
> @@ -1045,7 +1045,7 @@ i2c9: i2c-bus@500 {
>                 status = "disabled";
>         };
>
> -       i2c10: i2c-bus@580 {
> +       i2c10: i2c@580 {
>                 #address-cells = <1>;
>                 #size-cells = <0>;
>                 reg = <0x580 0x80>;
> @@ -1059,7 +1059,7 @@ i2c10: i2c-bus@580 {
>                 status = "disabled";
>         };
>
> -       i2c11: i2c-bus@600 {
> +       i2c11: i2c@600 {
>                 #address-cells = <1>;
>                 #size-cells = <0>;
>                 reg = <0x600 0x80>;
> @@ -1073,7 +1073,7 @@ i2c11: i2c-bus@600 {
>                 status = "disabled";
>         };
>
> -       i2c12: i2c-bus@680 {
> +       i2c12: i2c@680 {
>                 #address-cells = <1>;
>                 #size-cells = <0>;
>                 reg = <0x680 0x80>;
> @@ -1087,7 +1087,7 @@ i2c12: i2c-bus@680 {
>                 status = "disabled";
>         };
>
> -       i2c13: i2c-bus@700 {
> +       i2c13: i2c@700 {
>                 #address-cells = <1>;
>                 #size-cells = <0>;
>                 reg = <0x700 0x80>;
> @@ -1101,7 +1101,7 @@ i2c13: i2c-bus@700 {
>                 status = "disabled";
>         };
>
> -       i2c14: i2c-bus@780 {
> +       i2c14: i2c@780 {
>                 #address-cells = <1>;
>                 #size-cells = <0>;
>                 reg = <0x780 0x80>;
> @@ -1115,7 +1115,7 @@ i2c14: i2c-bus@780 {
>                 status = "disabled";
>         };
>
> -       i2c15: i2c-bus@800 {
> +       i2c15: i2c@800 {
>                 #address-cells = <1>;
>                 #size-cells = <0>;
>                 reg = <0x800 0x80>;
> --
> 2.43.0
>

