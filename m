Return-Path: <linux-kernel+bounces-263228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63F5293D2F8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 14:29:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B51B1F23389
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 12:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84CEB17B422;
	Fri, 26 Jul 2024 12:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="b8jpo+An"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8362413C9B8
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 12:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721996985; cv=none; b=OTEDm5BUxZjAWKwqJjjFjsB8d83EeqTfUyguauNKHK8LleI3Dc+iqj1Udpsfhk9aQNuNI9XtKQbR5XH5y/7Vs+afZrFje1UOEAJX7u7lsy+9Z0DG0NGvMjaNmFgzBC2kzVjeQ2JKd47CqoEMiI7/hSIGGfBlA5HzLSDN6UhHfQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721996985; c=relaxed/simple;
	bh=v4qjjUpu5k/Fegvrs8GbMmn+a0qL30i9outYfIDOKNg=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QlRHw74UQJ/dUJBOpxwuSxB5MDjxsP8y8KEJev2NnXG8sqELHwAAkW5P3OHf8O1dTDkJZhyyPKd2V5AXOGdTkhI/QuvOVppiTww9ajnTgBz+WEA70X2v6qdWIZjBSVRoLtVLnbNOsZlcSr9MxlFt8IxtXsAVg8mi68s0ZjzuQrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=b8jpo+An; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id B982B3F4EE
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 12:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1721996981;
	bh=9LmZmw6NCs8eTK1rP6m6Jdcuf3clCtsx7hFAo9ghIiY=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=b8jpo+AntFyVkPdK3i0bWPGc6Cc99tnRets83/As9EQO2hY07wNiJCiXhcu+4Lp9f
	 M0vZaVeUJnLfIdsjSnUb0coKcgjZBIbeEMebFaDUFjtoiVULzt82dpdYJrsRlTI7HI
	 pY/5k5h5bc6Y3YV59dTwsD5h1vnf+FXjVSfobTNctkJGBYXD7lY1cFo6vzoMjVWav7
	 FrAnCDHuaAkfL+Ctr1feQRr+7xmsZH3nqej1m+N3kDxhMKB+csfG9fPNkjwwOWFJ4z
	 6af2FhXZrOHDcbQM6RDYznZk52xGKZammWc07gZ1tOON1EUrqqubTM472Hpv9tXnKc
	 ym+M13WK+BRLw==
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7a1d4335cceso121865185a.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 05:29:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721996980; x=1722601780;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9LmZmw6NCs8eTK1rP6m6Jdcuf3clCtsx7hFAo9ghIiY=;
        b=p2vMY9kSm26VeSpxtGHQiaQ1cxtQRXiC8Hcsxaq1MXgpI8ZLR6vIrrBF8iQktrOvnl
         TDhmodnFTsE9wqrJh386dkpE+48R3gFZQ8GvXOi9oIcGgTme3nr96VnD3BJQc84AK0s+
         wNfkMqrE+lwh6YHwGb5iUvC9pxEyHHG9OetBz2W4NGFMZt9t9zq0Sv5TJDK+zaOmuink
         3fljSCs8BR1jizhvy58eW4tm+E+v9ZsTsPTG0mWPT2T4+iewwfl/mE7MCabGHfHdePuY
         vR10S/o694KyqxgflcMn86Leos6gYbx05X9ka2RKdrSjfKPyh2tv0wkEOK4YOKHePPg3
         ECgg==
X-Forwarded-Encrypted: i=1; AJvYcCUzgQ/DOZKu+gxtiBQPbcE7feNQfp0RkSbEH2IoZsdwvQEJhuP5FKfWp6YOX7JPBm3yLaXeueHpJWv4L0sFGaFHdc54PPJgTxuc1xdb
X-Gm-Message-State: AOJu0YyginCOfECdBUeqYGBO1CKTEW+JsfDvu5Bmf8btja8h/ie2XVnI
	pxvJdo5vbzFL6WC87zcIx8M7VVbtMegNdH+s7kBp1PEODpzWC5v5yOWKB3BMzQQ7wvvMF5biszl
	B+BLpk7KOFWR5xLFGnZOFuGLbkB41URTcrE/q8XqTyDfMeXeqWj75w8/UJz0mafqili+4zBL2fc
	2bAA+yW+njPCv/n2aqcNDsY3W2o4H9mbf0EkGxr6cB7kt8HmocDcaE+mva6ArO
X-Received: by 2002:a05:620a:4484:b0:7a1:df6f:3632 with SMTP id af79cd13be357-7a1df6f4c34mr312157085a.32.1721996980419;
        Fri, 26 Jul 2024 05:29:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGV1mtLr9ByO8GYPcPzKfiGrDWu4OQDQV5IWb3V25ZQO93w1m0w8xqeuro6Hm7vzdR2YevzoHOr3qHn42Z+DA0=
X-Received: by 2002:a05:620a:4484:b0:7a1:df6f:3632 with SMTP id
 af79cd13be357-7a1df6f4c34mr312153485a.32.1721996980036; Fri, 26 Jul 2024
 05:29:40 -0700 (PDT)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 26 Jul 2024 08:29:39 -0400
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <20240716-majesty-antler-d9bedc7fd0af@wendy>
References: <20240716-majesty-antler-d9bedc7fd0af@wendy>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Fri, 26 Jul 2024 08:29:39 -0400
Message-ID: <CAJM55Z9FAH-uiNmXDELM0gkYjHue+g8JQgOryxOCv4OXJ9f5EA@mail.gmail.com>
Subject: Re: [PATCH v1] riscv: dts: starfive: remove non-existant spi device
 from jh7110-common.dtsi
To: Conor Dooley <conor.dooley@microchip.com>, linux-riscv@lists.infradead.org
Cc: conor@kernel.org, Emil Renner Berthing <kernel@esmil.dk>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	William Qiu <william.qiu@starfivetech.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Conor Dooley wrote:
> There is no rohm,dh2228fv on any of supported JH7110 boards - in fact
> the dh2228fv almost certainly does not exist as it is not a valid Rohm
> part number. Likely a typo by Maxime when adding the device originally,
> and should have been bh2228fv, but these boards do not have a bh2228fv
> either! Remove it from jh7110-common.dtsi - pretending to have a device
> so that the spidev driver will be bound by Linux is not acceptable.

Hi Conor,

This patch is correct, but as you mention the fake device was most likely added
in order to use spidev from userspace with random devices added on the exposed
pins. In case someone actually makes use of this wouldn't this be a regression?
What is the right way to support this?

/Emil

>
> Fixes: 74fb20c8f05d ("riscv: dts: starfive: Add spi node and pins configuration")
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
> CC: Emil Renner Berthing <kernel@esmil.dk>
> CC: Conor Dooley <conor@kernel.org>
> CC: Rob Herring <robh@kernel.org>
> CC: Krzysztof Kozlowski <krzk+dt@kernel.org>
> CC: Paul Walmsley <paul.walmsley@sifive.com>
> CC: Palmer Dabbelt <palmer@dabbelt.com>
> CC: Albert Ou <aou@eecs.berkeley.edu>
> CC: William Qiu <william.qiu@starfivetech.com>
> CC: linux-riscv@lists.infradead.org
> CC: devicetree@vger.kernel.org
> CC: linux-kernel@vger.kernel.org
> ---
>  arch/riscv/boot/dts/starfive/jh7110-common.dtsi | 6 ------
>  1 file changed, 6 deletions(-)
>
> diff --git a/arch/riscv/boot/dts/starfive/jh7110-common.dtsi b/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
> index 8ff6ea64f048..395436ec0f97 100644
> --- a/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
> +++ b/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
> @@ -346,12 +346,6 @@ &spi0 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&spi0_pins>;
>  	status = "okay";
> -
> -	spi_dev0: spi@0 {
> -		compatible = "rohm,dh2228fv";
> -		reg = <0>;
> -		spi-max-frequency = <10000000>;
> -	};
>  };
>
>  &sysgpio {
> --
> 2.43.2
>

