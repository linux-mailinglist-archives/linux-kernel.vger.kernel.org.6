Return-Path: <linux-kernel+bounces-348706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2667A98EAC5
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 09:50:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95B4B1F21AD7
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 07:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5296126C12;
	Thu,  3 Oct 2024 07:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="NY5AGyPf"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC9C81AB6
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 07:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727941797; cv=none; b=YyLssgWy7PTTbrth1sohay4T4j5LJ8Cp8vwYS0LmfoMRhXQsB+knaXfMznq6pyyGePIJhx081EaZP7TdmJIyWSENIvyv2i4qgtJyPoqn878nDyNvUQF+79uCZw/+dI1tG7ZrK9az1ODgPOxIe3tGiBdboMqphU8BEqDDFr0j2q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727941797; c=relaxed/simple;
	bh=KrsnW3KRAU1JoynmwJH5u2a/eU+TzfBlvEJS/tdrM3M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MeaMM5I9GbYDMduQKXW3oc2Qg5r3EQNXZ1aOZaK3PZgJ9ltoK++E6n/o3gxYgRn8hBcnMP+XvFA4+V+qGNmAXlGwCKu6CsfoMUEtPpHh5vPlb3CxRAfiVmLRH35iRpdGwx8UeLKj6Cbby9K31S79hJGrmvUCWq+l/lEcKNnRr2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=NY5AGyPf; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-37cea34cb57so466290f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 00:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1727941793; x=1728546593; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u1YwTr9h8LtbzMOl0TrTDXIEzjgLgPj2qUkc0qSTvso=;
        b=NY5AGyPfts8ukv9a4Itka6xJaXvDEWU4q9mVM5kt5ZJ0qeXpFaIfxK7vf+bDcg3Jr3
         9ZzE3u0sbQ2XLpiOQAsuF4U033FrtnFQJXVvM9BkskF0f14Y5roIGSiCR9GkbS8LZauy
         K2kKjppKnZZmPSxcxGOBwYtDfAyoZz68iKNhh1Z7N+cSghmxRbXDMdS7edqktELig3RV
         YH3y+SoauCTbg0ZBfFrrlHX9tAL+2pSHvXJKApT5Sxj7RoTiDyw6bKeVeTWRICD/VkbC
         dYKmcySNFIQOdIWF4fKegSAe7esV/1ItMW5jSY+viKAv0nAbH7H7G/uXO6rh0Dptc1fV
         bWfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727941793; x=1728546593;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u1YwTr9h8LtbzMOl0TrTDXIEzjgLgPj2qUkc0qSTvso=;
        b=SNBA0HZUwzntjEIsIox5AF2IEbsaNHd94v7frD7cqwkkB9UlRNWSxDEQ37y3sLAyVO
         G4FibqNsSEoItgCOa3grxbkWHTEEh1nQ6SapltwIWAbdtcK0U8svvKmbcG9f36DhFZW9
         XFpx0svKYH/pxU8BpHu33m3GMujQ4Wk+cAKO5yPwXzldz7K91aqvEjmZFFpo8h9IyXPz
         gy3OsjoHw4o+OjNMALtHDSKr4zbEH3HhL0/8ObMQd0MZmq2/S+tQhr44SnRny5O9HEtN
         tB4p68OA3LiHGXaGYsSpUr0iVMq30ZIvEvWy5gEXO/ddamYp97MBCSqEWSWgd7r03KyN
         LH/Q==
X-Forwarded-Encrypted: i=1; AJvYcCX2Px9VO1IQ61vigMCnFn2S425zGs/Vxit/NSzUa1MzDnrquNNrEmVtoDf+XAEyekR3pNIbXTXY1kOjTNU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsHSeGsdxbSccHk4VXPOSmEq5bw9oFniYrBjdzh42SJ2aAPy6w
	pVRFpnk2WnRQnALmkhtrb1D46eBJWx6o6xxBJg5/Uci7b9lEsR3jEjsLB0+E3qE=
X-Google-Smtp-Source: AGHT+IGLcxSI9tvWu0h1tUW6RfGSAAByFwWwvbEAOy5Bn8EDCgNaJ6vYB5LX4/TpSeyYiKyDH03HuA==
X-Received: by 2002:a5d:504e:0:b0:37c:d26c:8dc4 with SMTP id ffacd0b85a97d-37cfba03ea9mr4035595f8f.36.1727941792805;
        Thu, 03 Oct 2024 00:49:52 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:e17:9700:16d2:7456:6634:9626? ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d0823ed00sm657222f8f.49.2024.10.03.00.49.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Oct 2024 00:49:52 -0700 (PDT)
Message-ID: <6b735be2-93d2-4cc2-b690-438f6e71cf0b@rivosinc.com>
Date: Thu, 3 Oct 2024 09:49:51 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v1 2/5] RISC-V: add f & d extension validation checks
To: Conor Dooley <conor@kernel.org>, linux-riscv@lists.infradead.org
Cc: Conor Dooley <conor.dooley@microchip.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Andy Chiu <andybnac@gmail.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241002-defeat-pavestone-73d712895f0b@spud>
 <20241002-stuffed-trance-1323386dd80b@spud>
Content-Language: en-US
From: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <20241002-stuffed-trance-1323386dd80b@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 02/10/2024 18:10, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> Using Clement's new validation callbacks, support checking that
> dependencies have been satisfied for the floating point extensions.
> 
> The check for "d" might be slightly confusingly shorter than that of "f",
> despite "d" depending on "f". This is because the requirement that a
> hart supporting double precision must also support single precision,
> should be validated by dt-bindings etc, not the kernel but lack of
> support for single precision only is a limitation of the kernel.
> 
> Since vector will now be disabled proactively, there's no need to clear
> the bit in elf_hwcap in riscv_fill_hwcap() any longer.
> 
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  arch/riscv/kernel/cpufeature.c | 36 +++++++++++++++++++++++-----------
>  1 file changed, 25 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> index 84a2ad2581cb0..b8a22ee76c2ef 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -101,6 +101,29 @@ static int riscv_ext_zicboz_validate(const struct riscv_isa_ext_data *data,
>  	return 0;
>  }
>  
> +static int riscv_ext_f_validate(const struct riscv_isa_ext_data *data,
> +				const unsigned long *isa_bitmap)
> +{
> +	if (!__riscv_isa_extension_available(isa_bitmap, RISCV_ISA_EXT_d)) {
> +		pr_warn_once("This kernel does not support systems with F but not D\n");
> +		return -EINVAL;
> +	}
> +
> +	if (IS_ENABLED(CONFIG_FPU))
> +		return -EINVAL;

Hey Conor,

Shouldn't this be !IS_ENABLED(CONFIG_FPU)) ? I mean, if the f extension
is enabled but not CONFIG_FPU, then disable it.

Clément

> +
> +	return 0;
> +}
> +
> +static int riscv_ext_d_validate(const struct riscv_isa_ext_data *data,
> +				const unsigned long *isa_bitmap)
> +{
> +	if (IS_ENABLED(CONFIG_FPU))
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
>  static int riscv_ext_vector_x_validate(const struct riscv_isa_ext_data *data,
>  				     const unsigned long *isa_bitmap)
>  {
> @@ -351,8 +374,8 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
>  	__RISCV_ISA_EXT_DATA(i, RISCV_ISA_EXT_i),
>  	__RISCV_ISA_EXT_DATA(m, RISCV_ISA_EXT_m),
>  	__RISCV_ISA_EXT_DATA(a, RISCV_ISA_EXT_a),
> -	__RISCV_ISA_EXT_DATA(f, RISCV_ISA_EXT_f),
> -	__RISCV_ISA_EXT_DATA(d, RISCV_ISA_EXT_d),
> +	__RISCV_ISA_EXT_DATA_VALIDATE(f, RISCV_ISA_EXT_f, riscv_ext_f_validate),
> +	__RISCV_ISA_EXT_DATA_VALIDATE(d, RISCV_ISA_EXT_d, riscv_ext_d_validate),
>  	__RISCV_ISA_EXT_DATA(q, RISCV_ISA_EXT_q),
>  	__RISCV_ISA_EXT_SUPERSET(c, RISCV_ISA_EXT_c, riscv_c_exts),
>  	__RISCV_ISA_EXT_SUPERSET_VALIDATE(v, RISCV_ISA_EXT_v, riscv_v_exts, riscv_ext_vector_float_validate),
> @@ -912,15 +935,6 @@ void __init riscv_fill_hwcap(void)
>  		}
>  	}
>  
> -	/*
> -	 * We don't support systems with F but without D, so mask those out
> -	 * here.
> -	 */
> -	if ((elf_hwcap & COMPAT_HWCAP_ISA_F) && !(elf_hwcap & COMPAT_HWCAP_ISA_D)) {
> -		pr_info("This kernel does not support systems with F but not D\n");
> -		elf_hwcap &= ~COMPAT_HWCAP_ISA_F;
> -	}
> -
>  	if (__riscv_isa_extension_available(NULL, RISCV_ISA_EXT_ZVE32X)) {
>  		/*
>  		 * This cannot fail when called on the boot hart


