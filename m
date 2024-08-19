Return-Path: <linux-kernel+bounces-291661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F4188956552
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 10:13:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABB75282566
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 08:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF53415B0F4;
	Mon, 19 Aug 2024 08:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="KuYQjcDW"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BEC414AD3D
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 08:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724055216; cv=none; b=oSJCSPYK6ZpAxvwvBT4BcgtXlP5/VhS9RZEeJUDLNbmMKQBMg0cBvHAZEQHHXiYugD1KN04V20Y+C13/vjw37NaqLT0lDFPViiLBdWdwzDrfLo981CSQzaVsLlPRxRprcPYUmI+KP9W6O9bRWRRgB/1FgFQ9YpqiHCcUJBgiGlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724055216; c=relaxed/simple;
	bh=SxbAV8kd93f+7QswDJM7XxrhkO5ZkojrtQTWX/aGRyI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TkzEP+kRq0kND6+f5AJQcopJd5QQBz1wPF9CS2ZVUy4nisTTX2Q7KVSZGBEVjPH9j+KAG5ZGJrjKCgHqcZSDb+tPiM5xztdtUTL8eOzmGd4hsyleysdjGU5Tk7qIA22cdIGnBvwHBL9KXqryK2Ll4HW81YUYGeyH+4b9P2lqLOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=KuYQjcDW; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5bef295a2b4so1518529a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 01:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1724055211; x=1724660011; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hkaJw/3Kk9sZ53Q99+QnCuQ4WgKVgljtLdb8OyHyfdo=;
        b=KuYQjcDWpd1WytWfTeN1HmCHFW+mUULBIl+wxfurp2KtQQUs0C9NuPnt6tTnTp//EI
         kU1eacbhF/+fyeZP+rOfsmn9fAEtiT08wZy+xCNZepOpj3ORuk7NRpYuRg5KzBrSugSk
         eJyfXNGbwUtvhT3UPCOS5ZF+i49OXQiRIL9Y+Wzi887iHiXQtyEYn0K0wczk4OOt9QwB
         dWsXcfwG0R2j795t2w/8unfH9EPobWJBO4KT9uzY3xnC0bbeZq/l1BlIhmZ/PCdWwPJs
         mUi7MaKT2MCFhe6ieYOO+ryrlD5TX2z2nT8WoQxkLIyznyy5IXImGy5K+VjrpDo3tQsC
         hpcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724055211; x=1724660011;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hkaJw/3Kk9sZ53Q99+QnCuQ4WgKVgljtLdb8OyHyfdo=;
        b=rihGJEyDNNX+6vvFadnvim2+y1aIHg+A9eex5mWtKxrBTUeVYRihUUu7ypOit7K62P
         QtVFHx6BsbD6FPfv/0KAOaEBOeiGNqpIqhNE5DsO5nfk78nEM3+QQbCyMoJrGiiCz11m
         p4a2NsRV9CTGDvbVqu/zsZs5JLpGcUd2TQjJGpMUZ/VkXV6OevTEmrzrhrxLpaSJ7+wO
         TAdjZcTYBm6qq4BxmaXej9cuO0XZ9WRz1+Hae+5Cma++3HwaWmeFZRKmJpN+AjCH4W+u
         eXS+Rb7ENko0FWRdJgZHLvSQDquGTcV/HjoNu9NCpqOfugKXL2E5xLVrg4dXO46FW8B1
         bp1A==
X-Forwarded-Encrypted: i=1; AJvYcCWv4FxmkU0I9IKat6R6iKsEAk6KAawUqOjvUZJl9VY8z3oW94VV8msbcCh6xXSERUC8rAfrf3vUZKUG4HqqJumpGrFtMGZnV+yCPyaD
X-Gm-Message-State: AOJu0Ywd6JKNvi0NehQpD2M8YQHPre25QTVL17vu9q6NfN8krI2SY6cL
	TIP3RFTezlSSXeAlgIGfFltR6xfwzXeJkR7ppfLnk1dSeIfKBITtZEZt4/C+rVk=
X-Google-Smtp-Source: AGHT+IFZ9FYF/9Dfc2RD2hAOCpnhFF1tHg+n8YjsmN9PPgk6zZt0nZGweN+c++zYhXMyS5h1dLFtRA==
X-Received: by 2002:a05:6402:3604:b0:5be:fa76:55b4 with SMTP id 4fb4d7f45d1cf-5befa765749mr2385832a12.16.1724055211063;
        Mon, 19 Aug 2024 01:13:31 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.177])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bebbdfb4a3sm5292147a12.49.2024.08.19.01.13.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2024 01:13:30 -0700 (PDT)
Message-ID: <69b7f374-9037-4373-90e0-676cce0cd0fa@tuxon.dev>
Date: Mon, 19 Aug 2024 11:13:27 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/8] arm64: dts: renesas: r9a09g057: Add RIIC0-RIIC8
 nodes
Content-Language: en-US
To: Prabhakar <prabhakar.csengg@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>,
 Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20240811204955.270231-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20240811204955.270231-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20240811204955.270231-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Prabhakar,

On 11.08.2024 23:49, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
> Add RIIC0-RIIC8 nodes to RZ/V2H(P) ("R9A09G057") SoC DTSI.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> v1->v2
> - New patch
> ---
>  arch/arm64/boot/dts/renesas/r9a09g057.dtsi | 198 +++++++++++++++++++++
>  1 file changed, 198 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/renesas/r9a09g057.dtsi b/arch/arm64/boot/dts/renesas/r9a09g057.dtsi
> index 3d6c3a604ec9..c9e1e21b820d 100644
> --- a/arch/arm64/boot/dts/renesas/r9a09g057.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r9a09g057.dtsi
> @@ -141,6 +141,28 @@ ostm1: timer@11801000 {
>  			status = "disabled";
>  		};
>  
> +		i2c8: i2c@11c01000 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			compatible = "renesas,riic-r9a09g057";
> +			reg = <0 0x11c01000 0 0x400>;

According to [1] compatible and reg props are preferred to be at the
beginning of the node.

[1]
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/Documentation/devicetree/bindings/dts-coding-style.rst#n112

> +			interrupts = <GIC_SPI 222 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 523 IRQ_TYPE_EDGE_RISING>,
> +				     <GIC_SPI 522 IRQ_TYPE_EDGE_RISING>,
> +				     <GIC_SPI 224 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 225 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 223 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 226 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 227 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "tei", "ri", "ti", "spi", "sti",
> +					  "naki", "ali", "tmoi";
> +			clocks = <&cpg CPG_MOD 147>;
> +			clock-frequency = <100000>;
> +			resets = <&cpg 160>;
> +			power-domains = <&cpg>;
> +			status = "disabled";
> +		};
> +

[ ... ]

