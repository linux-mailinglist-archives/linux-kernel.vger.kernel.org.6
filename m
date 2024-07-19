Return-Path: <linux-kernel+bounces-256893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB339371ED
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 03:19:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B340B21624
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 01:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B235515D1;
	Fri, 19 Jul 2024 01:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="MX9B/i7B"
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9066028E3
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 01:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721351946; cv=none; b=rtbrxRLlyeYQHI2sGXg13wNIS+zAALDDjJLlATiES4J7yscEPWZcbBr2/Hwt7IR4l0ExDNAxjGWrWdmDCZLXPsx+9xzq+MRwCgpQIgtMW85zFxIWqhdbwG3tq9TUtNJhA4p+hKOMSNJ7YXswgPjLOI3tHjwyEgKQ8jImjoTo1Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721351946; c=relaxed/simple;
	bh=j5tLGDY9gGcd5udPLL80op5rVUZUjouE/1JD3eGh7rQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pWCmdSXnEwQAZZCnEx/ozo9CUNtLeQP3h/T21IOH6i8rG+RKTgAL+nDCfgV0oLEWxD3KNlaJ0pkuT9VXf2Cx0sj6AwmQIdtXi0GAAcQ19hcKuD8aMvBV22UK22ziLuBc+0N+5q/QGNrQjqzEQ0jsplCDyaErhmbCaWCuIoA3SRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=MX9B/i7B; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-80557928673so55711039f.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 18:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1721351944; x=1721956744; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kitCVRPpRWuruusdc0xZBytLiueygrYSLQr8urocHpw=;
        b=MX9B/i7BWGtQWRGJ8adnZKH0yaObZVMgaixJ4r/lTGv/559R/2Y3LoqCrMLgfpOuWa
         ErTlvDM6KTiPwkdML11/iQIqVPmznWwmNJF00d9vjEDIimnD6hPTilhnLe2vxnHkYh3h
         zZYuODibXVYHl3oxeWXdZc9UnEr7tHpRCxTZRmz8efh4ZyeJJ2pHPFUAsNP89JsBXeFU
         7vRm9Vbe4ro3WKdI18YHLMfSLbrXrm0aHk+LjFi0gGK8Ty0kfl3H5A+vIga40W1jOuaG
         BjsLeeFJ+/y06PZYPDY/Ol9Bu6tMW4PNypgrjn2Ko8uFkcxUbYZ9nXF/W868amHwd2JB
         O/Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721351944; x=1721956744;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kitCVRPpRWuruusdc0xZBytLiueygrYSLQr8urocHpw=;
        b=jFrtzGQQH5IYHFEvxFt41vh5M85eUoYiwYgKWliR7BvDqvewTPX5FAHGxiEJD/CMy5
         i9X1kVhiiowyfZsHI0sslQ42/F1jZnR7tOPmUjgsC/TjwFuf8+66ajx5IDxm1r/4DWUJ
         n0sPJez/VnUWCC9zU3dhZwaecXMCQGo6sCv5DoxdDMd+dP6AV18C/1O/c/1AeElIVLRc
         thNHWT4WN72M3JE3H8aHU3+ks8bivXuSETIZ99iMZQcMJ9dFLxDmTJKj5ilKdA8Z5J0I
         9BCUFVP/ScSgwJZfT/OP6QQokx9wQ6x5MUxqtcHW1vBpMpE1UwkbyCbUfeRyiqI7gsiU
         jQaA==
X-Gm-Message-State: AOJu0YzeauMYc8YgMyz2enl0nssuThqNVaQ2Zhy98wiFFArHLB3jHSeg
	GzgbbmCHwgMKAbQzYA52SVKvrDx0WHvmyE9BRdlXpKyAym7NMRVl+3dAawTbuZ0=
X-Google-Smtp-Source: AGHT+IGfm/S/FHPE7LA6XdxIKq5BMcfnNylk0g5mtJMSuhuINcBoNq6L3E2sbbLECTpJVZZr2PHwmA==
X-Received: by 2002:a05:6602:6212:b0:807:1908:b095 with SMTP id ca18e2360f4ac-81712003641mr780048939f.13.1721351943793;
        Thu, 18 Jul 2024 18:19:03 -0700 (PDT)
Received: from [100.64.0.1] ([147.124.94.167])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4c234405dd7sm107960173.176.2024.07.18.18.19.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jul 2024 18:19:03 -0700 (PDT)
Message-ID: <3a7996d6-1137-44b8-b35d-d9c56bd98277@sifive.com>
Date: Thu, 18 Jul 2024 20:19:01 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] riscv: dts: add mailbox for Sophgo cv18x SoCs
To: Yuntao Dai <d1581209858@live.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-riscv@lists.infradead.org, jassisinghbrar@gmail.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, unicorn_wang@outlook.com,
 inochiama@outlook.com, paul.walmsley@sifive.com, palmer@dabbelt.com,
 aou@eecs.berkeley.edu
References: <SYBP282MB223825D5903777B937A8A377C4A02@SYBP282MB2238.AUSP282.PROD.OUTLOOK.COM>
 <SYBP282MB2238CE3A016F21B632E61219C4A02@SYBP282MB2238.AUSP282.PROD.OUTLOOK.COM>
Content-Language: en-US
From: Samuel Holland <samuel.holland@sifive.com>
In-Reply-To: <SYBP282MB2238CE3A016F21B632E61219C4A02@SYBP282MB2238.AUSP282.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-07-14 11:36 AM, Yuntao Dai wrote:
> Add mailbox node for Sophgo cv18x SoCs
> 
> Signed-off-by: Yuntao Dai <d1581209858@live.com>
> ---
>  arch/riscv/boot/dts/sophgo/cv18xx.dtsi | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/riscv/boot/dts/sophgo/cv18xx.dtsi b/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
> index 891932ae4..1c7035737 100644
> --- a/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
> +++ b/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
> @@ -310,5 +310,14 @@
>  			reg = <0x74000000 0x10000>;
>  			interrupts-extended = <&cpu0_intc 3>, <&cpu0_intc 7>;
>  		};
> +
> +		mailbox: mailbox@1900000 {

Please keep nodes sorted by unit address.

> +			compatible = "sophgo,cv1800-mailbox";
> +			reg = <0x01900000 0x1000>;
> +			interrupts = <101 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "mailbox";
> +			interrupt-parent = <&plic>;
> +			#mbox-cells = <2>;
> +		};
>  	};
>  };


