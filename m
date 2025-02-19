Return-Path: <linux-kernel+bounces-521646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EC9EA3C03A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 14:43:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07B75188CAE1
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 13:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C75161E7C23;
	Wed, 19 Feb 2025 13:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="Sy1GdYfn"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9578745C14
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 13:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739972591; cv=none; b=ZV7DEsj5aMvsvr5quzPOQkeA1THwQi8PfnUpVFZ1a2kmdgjLkt200eMhau/fgEAXC3VohqVEqUO53mXCoDemHMTpkapKn+AjD2LeHcwzmwDknwL1DTSYcNB2Qu5nrx9Foi7UrTzmfcu06i7n1cMiGJU7ZU3rff9OMzMBk56wO84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739972591; c=relaxed/simple;
	bh=2ZTdAQt9df8PaTguKr01nU1Fak9WbZrG4FFH1ejRmE8=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S8YxgWBDz56D1UfymWh7voP5csUwCQsj0PzJKuH+7Hfmhq7/RyldQnoUuk4Jut9x8QCNyV1tet80zlXYQFJRiw5OUUGZWXYb9TrZ2X8949Vcr1zJ5bTvdje0Sngubk7FV/+EgcPuWuBgLVcf3ChuJjnWpkjR4OkU7LMYQxosU/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=Sy1GdYfn; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com [209.85.161.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id F32A63F2F0
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 13:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1739972588;
	bh=WFjePigVwF4Z8j9CYTif0ybYr6jQ2TZ/Iin7O5BwwQ4=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=Sy1GdYfnf0ibXu9MD7IVANlxgA5M+uiNrl+9OfU+GPV+FMWjwnhXXM4t4sIs/9fE3
	 3xfTi2QbzESK+biWiF/5dxO3iv+LbDoULGpFKp4G6zRVv/animRcaxX8atCQNMnxK2
	 I8lTJBCYhmUDGrQ7Aj++2sPA0omHtbhD8O7zc+cqKEV/aB+BAVGseXdn2SzDeb8vVc
	 p2LFBO8tJiR5kZr7NQrEr4i7+gZw0ttB94pagxjqvmCskiSiotwmPGef+64qkVBYa1
	 JXteMJfHht34KMA1KFjYEK5mmoV19grosRstT2TkwK/CO69cjH7y6xAa5VYkQWDI2p
	 QM03VYq3b/x4A==
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-5fcec4e9f78so1995581eaf.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 05:43:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739972586; x=1740577386;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WFjePigVwF4Z8j9CYTif0ybYr6jQ2TZ/Iin7O5BwwQ4=;
        b=cNb9jArgZg/bfsa+G0i+MXC1iLCDs/AVf9izO9Rvu2EaCfkIWAa+YcSCqoYo4jjAzY
         rnTmfYqKqMFWOZzqCNnW+677jQybIZGdPBlFDk8o8p3gVBIDh6KLnf3OIoX2zy/t74mz
         xa9F5S1XdqlpT8On/jbUSxQ8p++4zM4rTHzO3knWvq38g61Lnnmyc+p9tqzDintCjgGV
         ae4Ht2FhIyiWJxzaeOTw4x9SMkJ2tGyvrNMAI+c9iFjbuSz1x1zBS4Kv28wlAwYWCW4r
         HNqpnovL2z66iNNfYuQNeK7sUnyPToN3rtK1X40j6zdeagIU1yKhWiY7U9ccBnmLyeZo
         HAfA==
X-Forwarded-Encrypted: i=1; AJvYcCXP6AnOyeZxyIOevfp8P5tgDnmY6P6QLcOyrq2KA0HhtKF9JYf1PatNn4hWP0kLP7X2rTvxAU1dHhpv48Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx77QmssHZX9WChioeh35P/XQ9I0Jw+lZYD4hoPQ/6etN6OCJsd
	kEMJcKf+iK2BhauCrdFg2NQqbbp9TcHneT9ulzNTi1qDVr53DttM1SePdSJxumsodXh822GaJgw
	Ouz8r8nJQI8xapw4Af9wRxrLuMU9O+vDO6xByNhsjf8/IkZGV7uGNB7YRPAGezNFIB6FzVXHGK6
	BF8kWiJT6quMGMd89HMWJHn5kyUrhjeWgdhllhR1koJPYaKfZagRRo
X-Gm-Gg: ASbGnctIsnciK49Mjw8i2SAYJ2vRlG+L9CVR7xitCoNYxvqiqyklETSgk+dHKm+f63E
	xtuG/0DY9GADzEDwYiyZYzuSzEWyCMsH2ptSuiNYNLb1aeStipjxddJKitKnvvlMVW5FZCJzSxV
	1kq/Y4IKS7xk98UA8=
X-Received: by 2002:a05:6808:398a:b0:3f4:d61:36cf with SMTP id 5614622812f47-3f40f236581mr2682847b6e.30.1739972586673;
        Wed, 19 Feb 2025 05:43:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGYn9lRXBv/JpzO42HxdnnTEcRnjUT2CvEOcRyp+AhxkqJL3rRw8dalMjzUUDUoa47Zxxh/fN+SUIulaLwLwpw=
X-Received: by 2002:a05:6808:398a:b0:3f4:d61:36cf with SMTP id
 5614622812f47-3f40f236581mr2682828b6e.30.1739972586434; Wed, 19 Feb 2025
 05:43:06 -0800 (PST)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 19 Feb 2025 05:43:05 -0800
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 19 Feb 2025 05:43:05 -0800
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <20250207093618.126636-1-sandie.cao@deepcomputing.io>
References: <20250207093618.126636-1-sandie.cao@deepcomputing.io>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Wed, 19 Feb 2025 05:43:05 -0800
X-Gm-Features: AWEUYZknIHcy7u_-bftvl8Qvj-VvK3o4Nv3eX4N0vbhXOKNS0iUj00wp-j9bK3U
Message-ID: <CAJM55Z-Csuw+sUgKkNUdsXfX0LkhsQKRTXfVXxm4kmKeABodTg@mail.gmail.com>
Subject: Re: [PATCH] riscv: dts: starfive: fml13v01: enable pcie1
To: Sandie Cao <sandie.cao@deepcomputing.io>, Conor Dooley <conor@kernel.org>, 
	Emil Renner Berthing <kernel@esmil.dk>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Sandie Cao wrote:
> Starfive Soc common defines GPIO28 as pcie1 reset, GPIO21 as pcie1 wakeup;
> But the FML13V01 board uses GPIO21 as pcie1 reset, GPIO28 as pcie1 wakeup;
> redefine pcie1 gpio and enable pcie1 for pcie based Wi-Fi.
>
> Signed-off-by: Sandie Cao <sandie.cao@deepcomputing.io>

Unfortunately I don't yet have a board to test this on, but it looks ok to me.

Reviewed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>

> ---
>  .../jh7110-deepcomputing-fml13v01.dts         | 34 +++++++++++++++++++
>  1 file changed, 34 insertions(+)
>
> diff --git a/arch/riscv/boot/dts/starfive/jh7110-deepcomputing-fml13v01.dts b/arch/riscv/boot/dts/starfive/jh7110-deepcomputing-fml13v01.dts
> index 30b0715196b6..8d9ce8b69a71 100644
> --- a/arch/riscv/boot/dts/starfive/jh7110-deepcomputing-fml13v01.dts
> +++ b/arch/riscv/boot/dts/starfive/jh7110-deepcomputing-fml13v01.dts
> @@ -11,6 +11,40 @@ / {
>  	compatible = "deepcomputing,fml13v01", "starfive,jh7110";
>  };
>
> +&pcie1 {
> +	perst-gpios = <&sysgpio 21 GPIO_ACTIVE_LOW>;
> +	phys = <&pciephy1>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pcie1_pins>;
> +	status = "okay";
> +};
> +
> +&sysgpio {
> +	pcie1_pins: pcie1-0 {
> +		clkreq-pins {
> +			pinmux = <GPIOMUX(29, GPOUT_LOW,
> +					      GPOEN_DISABLE,
> +					      GPI_NONE)>;
> +			bias-pull-down;
> +			drive-strength = <2>;
> +			input-enable;
> +			input-schmitt-disable;
> +			slew-rate = <0>;
> +		};
> +
> +		wake-pins {
> +			pinmux = <GPIOMUX(28, GPOUT_HIGH,
> +					      GPOEN_DISABLE,
> +					      GPI_NONE)>;
> +			bias-pull-up;
> +			drive-strength = <2>;
> +			input-enable;
> +			input-schmitt-disable;
> +			slew-rate = <0>;
> +		};
> +	};
> +};
> +
>  &usb0 {
>  	dr_mode = "host";
>  	status = "okay";
>
> base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
> --
> 2.34.1
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

