Return-Path: <linux-kernel+bounces-401528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 241BF9C1BC8
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 12:00:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 105E4B2231C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 11:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C99C01E47C8;
	Fri,  8 Nov 2024 10:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JxKWYNNA"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D951E3DEC
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 10:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731063598; cv=none; b=hcflyn/mCz4gxzn2wOlTMmaOBIH4gzOEWBO5n1GuGaCNWSxwbmh31LDkiW7i7pQClQRxOfU/m1XlzN3SPIHd/MN08/aiIHP6FLKBCstbVHPiYXIXz5CGkAGqth1D6Z4pIu0NT9pHTl/p91CP05ckAU/BNriWt+Apf+F/6BemA18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731063598; c=relaxed/simple;
	bh=j17qLfyvRfo5JMhyML5WkkFrvdHwmeuqNvStpfykqxg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LI/8vy8JbogTsszoX3jUuW0WClOQtT01NP1EBv4YWw1CsSkxp/8QflTOXQPrG1F+QoRobU2fuJHqGbFF7ClybJ3Lk0ZDthoyKbaHY/SK2Clg5DDQRKfbSgGJKJvOzNJIY1uOIpyIusAqFEMa2CdNLXNfUgJyyQNXVAjK6q3CUtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JxKWYNNA; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-37d43a34a0cso235036f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 02:59:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731063594; x=1731668394; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TJsZ1D0SNXJJ/V2KTKYWT1pHPn+RT1Ru2KyAMGJ4klA=;
        b=JxKWYNNAnsfeR38/P64kLcAxHCz7rJOZr5C1aOgObqAnX5gWp91Z2PfBc6yCzDnqxo
         Nr5FaeEUuoPi+Rj6A7ybMtot07IB4JIncdehwAVHSCtOncKLCaZV61+KyKb4R2bggGXk
         yM6syNAgaMl3SCglmhTUWIDB+eH1L56o5m1J9f4KCFHMuaxsmtl3mbbg6d1VeCQhkK/E
         2tHbe0jpKBacYK3y666BQzwpQ6PjpLvlEZfUQivpFJKhH4Lo7zhv5Qoh9PgpzQRjQWNE
         7jLKtEKLkCYrhOhi5PHIyvAEs2YI677Nds0j/4ShfziHOpYuP7zcd4jquim0SR+G9zYL
         5Gdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731063594; x=1731668394;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TJsZ1D0SNXJJ/V2KTKYWT1pHPn+RT1Ru2KyAMGJ4klA=;
        b=CARV6KsyRXAHyVymnOpCSb334aLn6wHGQRCEH5Lc2gvApgyGkgFVCSkOZ3xL5xagw1
         3pHM/8uXpiGnAYaC3VvwKCbcg6fYeU5FkyT3EZr7wl2R+ahWDnh8zK4UwSw2LDnFmoAc
         rDmxITDe9/TdAIVTN/xd4HN2GyF0/HC1UXSM49lmty0ddau1+YUJ1jzJGXSOLLgq41a/
         bI5Y17DA6YNTNKKBQFlBuwWj87Z8077gKAPjoEdQxN3V4zCYRSEo1wtg7+MOq//NfqIF
         SQiWTMHV8dgTUOt8RE9AOXGHusGRFglRwVja1pNJWRCVOtxUC6a6hZMyqGQmziFku0cT
         h6fA==
X-Forwarded-Encrypted: i=1; AJvYcCUb0h5M5/+cp2q4NftjX3gzIJ/2ut9N1fXzEEsQKl1oaGfCLvhoeCO7ZCGVhfINk9x1IOTMSucnUA/Vz7s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8jvJp73rMV7vIANxHME+mFR2o8aLgHaoUr7gO6uAHgC0x2EyR
	qQZzz/eUCXsOqtUa+kW9RT6s6THyZA5+mqUigDEvWWTy8mxHsJ/JChB1shERp/M=
X-Google-Smtp-Source: AGHT+IGgrtxjtNjOrPLN/qb8VJvRRiPkgkcMf9a0A9FAEvNbhVFh12ojBWAIdBWC2bxuNKwBB4qYfA==
X-Received: by 2002:a05:600c:4f8a:b0:42c:bb35:b6d0 with SMTP id 5b1f17b1804b1-432b74ffa40mr8616615e9.1.1731063594059;
        Fri, 08 Nov 2024 02:59:54 -0800 (PST)
Received: from [172.16.24.83] ([89.101.134.25])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432b0562642sm59707405e9.21.2024.11.08.02.59.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Nov 2024 02:59:53 -0800 (PST)
Message-ID: <b8dcd283-2fc6-456f-8b7e-ab3792b239e1@linaro.org>
Date: Fri, 8 Nov 2024 11:59:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/6] arm64: defconfig: Enable ARCH_BLAIZE_BLZP1600
To: Niko Pasaloukos <nikolaos.pasaloukos@blaize.com>,
 James Cowgill <james.cowgill@blaize.com>,
 Matt Redfearn <matthew.redfearn@blaize.com>,
 Neil Jones <neil.jones@blaize.com>, "robh@kernel.org" <robh@kernel.org>,
 "krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "will@kernel.org" <will@kernel.org>, "arnd@arndb.de" <arnd@arndb.de>,
 "olof@lixom.net" <olof@lixom.net>,
 "hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "hvilleneuve@dimonoff.com" <hvilleneuve@dimonoff.com>,
 "andre.przywara@arm.com" <andre.przywara@arm.com>,
 "rafal@milecki.pl" <rafal@milecki.pl>,
 "andersson@kernel.org" <andersson@kernel.org>,
 "konrad.dybcio@linaro.org" <konrad.dybcio@linaro.org>,
 "angelogioacchino.delregno@collabora.com"
 <angelogioacchino.delregno@collabora.com>, "nm@ti.com" <nm@ti.com>,
 "neil.armstrong@linaro.org" <neil.armstrong@linaro.org>,
 "nfraprado@collabora.com" <nfraprado@collabora.com>,
 "johan+linaro@kernel.org" <johan+linaro@kernel.org>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
References: <20241108103120.9955-1-nikolaos.pasaloukos@blaize.com>
 <20241108103120.9955-6-nikolaos.pasaloukos@blaize.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20241108103120.9955-6-nikolaos.pasaloukos@blaize.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 08/11/2024 11:31, Niko Pasaloukos wrote:
> Enable ARCH_BLAIZE_BLZP1600 to get proper build coverage.
> 
> Resolves: PESW-2604

How is this resolving PESW-2604? To clarify: PESW-2604 is a DC motor, so
I really don't get how DC motor relates to Blaize...


> Signed-off-by: Nikolaos Pasaloukos <nikolaos.pasaloukos@blaize.com>
> ---
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 2c30d617e180..7d368a8911bf 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -43,6 +43,7 @@ CONFIG_ARCH_BCM_IPROC=y
>  CONFIG_ARCH_BCMBCA=y
>  CONFIG_ARCH_BRCMSTB=y
>  CONFIG_ARCH_BERLIN=y
> +CONFIG_ARCH_BLAIZE_BLZP1600=y

We enable entire archs, not specific SoCs. This is supposed to be
ARCH_BLAIZE. Same for earlier patch in Kconfig.

Best regards,
Krzysztof


