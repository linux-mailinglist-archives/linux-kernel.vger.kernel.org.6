Return-Path: <linux-kernel+bounces-176682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 429BE8C333C
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 20:47:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A99A6B2102E
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 18:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E0321CABA;
	Sat, 11 May 2024 18:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="NmqUghk/"
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65ABD1BC3F
	for <linux-kernel@vger.kernel.org>; Sat, 11 May 2024 18:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715453234; cv=none; b=oUzq1VOa3Ye4SudqPOvtDUXmktVY8uhH83etQUpWZRTHmEx1xFk+6grGZvIi4D4tYqof1SuME1AayOLAaBwba6FE42qMVPnanA8sZ1/gS+jJaoC7NV5M6X21njCcYbssap6/KAN4Wk7CgjoKdiU0Fpy5Pl3ruZT6by98PCErNvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715453234; c=relaxed/simple;
	bh=RkYbKEtD1/5EPSQ08qO6Axb20Vidm+kcYe5zuMyRkLk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SLpZUgGfQmoVyj2H1Olj7lyauZv+25u/lzQTOSoaE1nxmOUBX5V/BfgaOatSrgxcqsIb+YAkCKTEBst7JSxUYm1IR4YwKunWPnmcPNx/hCJ5SVfP9FYooW2sfzMzmK7/8+aUUHwBC5kE48Z7dyiQHIXSghoJaahGCSNr14B4bpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=NmqUghk/; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-36cca20ae15so5661335ab.2
        for <linux-kernel@vger.kernel.org>; Sat, 11 May 2024 11:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1715453232; x=1716058032; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aOG++vk1i0/Hd88Qn0YDT0yQo3hdTXW2k/18QZW7zOU=;
        b=NmqUghk/7lRhkouroZ7sZBnZbcrrkbiCwfhBvADMrhUQ3t3WOF/5Ka5G+iioja/kP3
         byE/ThF/ZpjVVseti9VkVF8/k9Jvlc+BMf/toU8m4sKKyWE5JG7OXJ/xGb46khB63idl
         oxzjtcU9xlWV+DcAxNKhqfEfcP5KgIZaPAS17S076KGBzGafhPKPLP0tuorPFJpTAavj
         3g7wMFltckS/BplnnJ9dS5tHb+iMj7+PlAr0/Vz27SXRivA8gjCIEG7pzMyfNS6obzhx
         BicZyT+b/pxUVVofCNmrJ015C0f/dvt0GUCfbtcERxOyW/QO2WLoP53VI7RAMAYtB7Cf
         EB0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715453232; x=1716058032;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aOG++vk1i0/Hd88Qn0YDT0yQo3hdTXW2k/18QZW7zOU=;
        b=Ye0+JboVlAWRm5Brt85HN1581nqBlipUaYzC7y/B58q2UdmhqaS+u1clMMKJ42Xv7A
         tDuGPOGAXeba/02fZSXkoC4sX95JntYerY932PNiinmUPXwCkG0gXf2Zc4oZ7/uazfRM
         FC8yYWYmlxruK5HNkkeBIyMM2aljYgE9cykg/hKfB3KfUw69iIWL1fUm2uAbdMHAFho7
         WwZqAQWFJiKRZAR5lPWRx1Lv/aq0vadwFSrPi+x0236MCxZzkpNn+bZX46KPPJ6ppait
         dET5P0zxLYLeox8uhWjs2JqD1ns23cRtEDIrFfsclfZfeuJjIVJMwBmvv7CZlFtXr8Kf
         AMbw==
X-Forwarded-Encrypted: i=1; AJvYcCUsqvV/BcaizRikfSPG98hdkO6VA04+jAmQvln39UeYtZB+KWMFkNqBI5EHS4+79YNV06UYiMVhZZCm/B0q6XCao9RzraxL2lc6o5u/
X-Gm-Message-State: AOJu0YxzvQZbuypT4iDooYRU1o0FXW0pE4tdrJ2ytdakMI/VF/ZFv5uq
	T41PnTHZdusKcarx1HLBIJ6blswH7h26tejd5Srp5cI4I19rKrMUNhEKKtcjz3g=
X-Google-Smtp-Source: AGHT+IFupAf3+PzUtciCUtAMd59M9Bh2uNrFENRRy+veiFORUG52P2gIZyNwUtsiccta6zle1s1HIQ==
X-Received: by 2002:a92:cda1:0:b0:36c:c6d:54ba with SMTP id e9e14a558f8ab-36cc1487041mr73054875ab.9.1715453232512;
        Sat, 11 May 2024 11:47:12 -0700 (PDT)
Received: from [100.64.0.1] ([170.85.6.179])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4893700de56sm1575232173.22.2024.05.11.11.47.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 May 2024 11:47:11 -0700 (PDT)
Message-ID: <b970012b-c078-4c8d-995d-e2789afa3e4c@sifive.com>
Date: Sat, 11 May 2024 13:47:08 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] riscv: dts: starfive: visionfive-2: Fix lower rate
 of CPUfreq by setting PLL0 rate to 1.5GHz
To: Xingyu Wu <xingyu.wu@starfivetech.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Conor Dooley <conor@kernel.org>,
 Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Hal Feng <hal.feng@starfivetech.com>, linux-kernel@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-riscv@lists.infradead.org,
 devicetree@vger.kernel.org
References: <20240507065319.274976-1-xingyu.wu@starfivetech.com>
 <20240507065319.274976-3-xingyu.wu@starfivetech.com>
Content-Language: en-US
From: Samuel Holland <samuel.holland@sifive.com>
In-Reply-To: <20240507065319.274976-3-xingyu.wu@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-05-07 1:53 AM, Xingyu Wu wrote:
> CPUfreq supports 4 cpu frequency loads on 375/500/750/1500MHz.
> But now PLL0 rate is 1GHz and the cpu frequency loads become
> 333/500/500/1000MHz in fact.
> 
> The PLL0 rate should be default set to 1.5GHz and set the
> cpu_core rate to 500MHz in safe.

Can this be accomplished by instead setting the CLK_SET_RATE_PARENT flag on the
CPU_CORE clock? That way PLL0 is automatically set when cpufreq tries to change
the CPU core frequency. Then there is no DT change and no compatibility issue.

Regards,
Samuel

> Fixes: e2c510d6d630 ("riscv: dts: starfive: Add cpu scaling for JH7110 SoC")
> Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
> ---
>  .../boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi     | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> index 45b58b6f3df8..28981b267de4 100644
> --- a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> +++ b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> @@ -390,6 +390,12 @@ spi_dev0: spi@0 {
>  	};
>  };
>  
> +&syscrg {
> +	assigned-clocks = <&syscrg JH7110_SYSCLK_CPU_CORE>,
> +			  <&pllclk JH7110_PLLCLK_PLL0_OUT>;
> +	assigned-clock-rates = <500000000>, <1500000000>;
> +};
> +
>  &sysgpio {
>  	i2c0_pins: i2c0-0 {
>  		i2c-pins {


