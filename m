Return-Path: <linux-kernel+bounces-217078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2553E90AA4A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 11:54:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8AA1285350
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 09:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56C75196427;
	Mon, 17 Jun 2024 09:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YRQK8qMG"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6168195FE2;
	Mon, 17 Jun 2024 09:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718617502; cv=none; b=nU3/DKSktaeN+P609HhTsV5Wc73YboDLNYk7p1ECelnIxug4Z88z0TZoMB2IWZKwpLtWM2B34kTgkrmsV2edgnTtgSnRV0xGr8LstlPL5Xrh9tPfvFUogxOw2gRA8jA18mQkaOAr32zn9mubAjoTmB31ykacrZ+qj3bQy7Im3gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718617502; c=relaxed/simple;
	bh=ulYGpQplI6j1LKMsfjUp+t3ELw7gic7cyJ0yseY/H9A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b9AJjCA7dGP9cQuXJ+7As6L38p2wVTxjnqBV6NKn2p5L5AQS7gw4uWS5kSlukmfY4Q8R2EAsKCVNqMBjPJ1d6KtUb4krh4BYPRNi6MhJ8zrD3cb+RGlMgAGlIDRcq5FLmLeKd87hvtJxvGGpVd+6nN3OTH0fhC5m15avq1NGuzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YRQK8qMG; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-57a44c2ce80so4862858a12.0;
        Mon, 17 Jun 2024 02:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718617499; x=1719222299; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X97SzOogYwfV1kCh1JrbnYsGiZ69at2aW20xoDHZcwM=;
        b=YRQK8qMG10Tu118PKZMGKDW9RjYukT6APWdm9ILfAJy9KTum4UdmI6kiQbbavH7B3M
         aTDa2R244OMWgzCnAM5KbdLTxMboiYDRfCqOePETZcbE225fzXhKFZN7o4YfUjHeMKdT
         cl2N8L3xDC2E9ZOBKHgF7fvxQ/EvY1+snOh8hcoTHs4M1RMY8eUEe/arZQAtMUxkdvvm
         OdY/K+grdVN9Tw5KZuh9QkYNM6r7Ckj8Ubeejfcld0syOJFieIJ0DG0JfD9hu43hQsfp
         avu6nKySL599b5BkUNllIgkao9T0ITmmOuWYGAPk7Na1GgB5qyLSrGAXM6HkBwMwCYfq
         SEkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718617499; x=1719222299;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X97SzOogYwfV1kCh1JrbnYsGiZ69at2aW20xoDHZcwM=;
        b=dwTdagVhdRIuwgJ1UuNb75h9mqn38B5pE68+CR0WrnySfn9dPAxsZDkrFWEZUE/VSA
         FV0FeoFaNbY40pmmeDEOFAcEFqD0wLk6bNum1e/wEQ0ycoXXYtW8I8AXSBhQaEd/D5AV
         16n5JezK3rsg5vdsCZedJPM947aCWRtwIoTavNSa+LYoY1PhRfNykl38GOnFQoXAJwN0
         va4iPd6EASMtFz90faOnX/6SRW9qGnJnCLuoH7Pr3icBs25+C9OYC9xQcvptCmmr1UGc
         LNWT/hFX5OKWbqJlIGSTCgq5GJ4WB2ZpNqtzPiE5c02aCzbaYgpsJHPXXT7+SdzIAM/7
         dsbg==
X-Forwarded-Encrypted: i=1; AJvYcCU428HcEjyAzo5OJgjKx0djqzAhI41PIhmsZpu49Wh4QqHLzV07W0PaF0lFtHEl6TymZHFqQEYpnqGT7MdbRdC5WtKXhKGLwgFhW57Fx05CQnlcoeGQlm0Xnh/4FUSs0EwDXrlFpjfwJQ==
X-Gm-Message-State: AOJu0Yz6I9gJ3GRwP4mWznN9SwIwG++gbumguQ56vLAyjklwq4ZNKxhV
	x5GtK8iqcPGU+kTDj6Em3E5N2SZ9c4DnyDh4oE6GW+5AKVEKA8ln
X-Google-Smtp-Source: AGHT+IFS75We8HO8dxXBT7VUWU1ReVIHpzlJDr8M/osvVnkMD+fe6bx8ReOw1WyqfmavqcTI87RW1Q==
X-Received: by 2002:a50:cdd5:0:b0:57a:2a46:701 with SMTP id 4fb4d7f45d1cf-57cbd68e23emr5766447a12.19.1718617498862;
        Mon, 17 Jun 2024 02:44:58 -0700 (PDT)
Received: from ?IPV6:2001:8f8:183b:6864:7071:8881:6a51:3e82? ([2001:8f8:183b:6864:7071:8881:6a51:3e82])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57cb743ada1sm6149470a12.96.2024.06.17.02.44.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jun 2024 02:44:58 -0700 (PDT)
Message-ID: <feeb8dcd-661f-415e-be08-afe175d0102e@gmail.com>
Date: Mon, 17 Jun 2024 13:44:54 +0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] arm64: dts: rockchip: Add AP6275P wireless support
 to Khadas Edge 2
Content-Language: en-GB
To: Jacobe Zang <jacobe.zang@wesion.com>, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, heiko@sntech.de
Cc: nick@khadas.com, efectn@protonmail.com, jagan@edgeble.ai,
 dsimic@manjaro.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240617071112.3133101-1-jacobe.zang@wesion.com>
 <20240617071112.3133101-5-jacobe.zang@wesion.com>
From: Alexey Charkov <alchark@gmail.com>
In-Reply-To: <20240617071112.3133101-5-jacobe.zang@wesion.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 17/06/2024 10:11, Jacobe Zang wrote:
> Khadas Edge2 uses the PCI-e Ampak AP6275P 2T2R Wi-Fi 6 module.
>
> Signed-off-by: Jacobe Zang <jacobe.zang@wesion.com>
> ---
>   .../boot/dts/rockchip/rk3588s-khadas-edge2.dts  | 17 +++++++++++++++++
>   1 file changed, 17 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts b/arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts
> index 233bab17bffd2..7d7cc3e76838c 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts
> @@ -365,6 +365,23 @@ &pcie2x1l2 {
>   	reset-gpios = <&gpio3 RK_PD1 GPIO_ACTIVE_HIGH>;
>   	vpcie3v3-supply = <&vcc3v3_pcie_wl>;
>   	status = "okay";
> +
> +	pcie@0,0 {
> +		reg = <0x400000 0 0 0 0>;
> +		#address-cells = <3>;
> +		#size-cells = <2>;
> +		ranges;
> +		device_type = "pci";
> +		bus-range = <0x40 0x4f>;
> +
> +		wifi: wifi@0,0 {
> +			compatible = "pci14e4,449d";

This doesn't seem to be listed in the bindings, nor is there a mainline 
driver that would match either this compatible or PCI ID 14e4:449d. 
Maybe submit either or both of those first, to make sure they are 
reviewed and acceptable for mainline inclusion, before this change lands 
in DTS and becomes part of the ABI?

I'm also wondering why would adding a DT node for a PCI device be needed 
in the first place, given that PCI supports device discovery? Does it 
require some sort of boot-time fixup by the bootloader? If so, it might 
be helpful to state that in comments.

Best regards,

Alexey


