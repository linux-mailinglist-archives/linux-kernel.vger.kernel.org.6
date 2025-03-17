Return-Path: <linux-kernel+bounces-564870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B6E3A65C23
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 19:13:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5AA037A5BE8
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 18:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E8EB1D8DFB;
	Mon, 17 Mar 2025 18:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OMX0axTz"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96DF71527B4
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 18:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742235180; cv=none; b=Sz2mZJgQUFJYO2s/sTl0nrCeGwUSAsM6BBEngu3x8tasyH1y+Lyntx6C2ROD63By0hF5DnUGtP1eucXnjLeu1SPQHpKZ3XqbZByTSKuy/DaNJ/Kr5vHPAyAO5lHEh75AY+6YSZqbk5QjRyZODKsXjGr/K8c8zUtIg8G9Sg2W1i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742235180; c=relaxed/simple;
	bh=ttnevuuRSs70eMR3kmeQzHoRYSox7LyShyytOBIQqWM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DEC4j7DIGZ+0lX0cSq4VQ0MYTF0OYG0Rdz0VNHXK02BwPaoPeJE2nXGv5W0zlQNnG5v8BJBIWmg7q1VI8uW/wuL8CMZ7yWsa8vSYp/jK4MitjoH3cy5auGC/8quXMCj9L5QufPbUC/AZTeSP2ux2R3OQ9i/Gojfgh/9BDZ8myY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OMX0axTz; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3913290f754so614123f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 11:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742235177; x=1742839977; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=im+lzt/l8oUZkwx4sSdHAnZN7RYYo3yZ6X9EY0kQmFc=;
        b=OMX0axTzvMDnhPpgquejnb7BcSNK3Pl92Z0r03VSaO/jBLBAs+ckEKsWq+gu1LpXWU
         +uWKHaRv0DqC8SbJezyfNBVfgukzDUDid3Y323fgjbysex6oovnYfwIcGF1QpyaQunzQ
         cKO3KY/rijZqmCvcq3yf0rSXMvCXsf5Zeeie9qG8XvoPSsS1hTdWD3menRXOk4VzBTob
         Qe957H699TlclUtcZo9E1aBrcFXV5/nGyXkRIfVHL9pgQu3gJJ4TF4RZH/McwH/eSWFa
         SAoYGCrKxZ72gKNCXp/v7B+psYS4tja6Uc0sWlXsmYyLyRhLUesiFrtGTY9ByrjO/8cY
         FZqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742235177; x=1742839977;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=im+lzt/l8oUZkwx4sSdHAnZN7RYYo3yZ6X9EY0kQmFc=;
        b=Q4FsjYFkf5/AdWbWaL5PVbwaA8baWXItnbMWnKIXWtfzonmwtsyhUIU5lLZNqvyvcX
         azXFs71GQD9k1D9bgIhMQV8xA8AFNMBeN7fn89NGZZLMLUFLsSnCiR00qbWjx9yaoRVq
         fzrIn4lAspvgeapkTeRXjO897XH7gVGOJ+fK15Et+/vNb18VFHfevvepArqogFidg6xZ
         v58O4vmoErANkONET4GD7r0UzHpoIAwYwfVabaMsXSlU8/TjPgVbSktAS0PsH6jMt5Fv
         iu1IcGKR+hGxTUl81qpCp12ZneyYAKfi0qXLdyfXgrmndPuKtwoVzQ7Ccz5elcj2KaaC
         H4Sg==
X-Forwarded-Encrypted: i=1; AJvYcCWbjWgopLWFwoedw575zY16TGvnNFzeWCC0QBYTSJKrTIUtl9D2bgbQ9bq74iXLsIJERTeN38dxNAz95Z0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyI+mXWdArXCAR1s0CF8wT/lD0mvYYOxECFiFZLQgU3L4UTR28K
	Vwcj084GIQkkwePeQxOWTcWTv0eRKTelvyZpv8Bpus8FF6rDwc+OXilvtqYHPZM=
X-Gm-Gg: ASbGncsAYPQo6zwPMj+1kS8r1y6+llLkOVe9iwVxB+ZJHqHvGBON4OIEhSIrhFLqqX2
	rK8Ys7ul3Gd60fNrItM1xe/WrWAyoulwYY1CtPr78xnG58DtxIWEeP8xZFxjCwRXL+BPRdn507+
	6NA4pCx6RZ3YhJUD3846Kch4Jjt0ts2/gvo1sNDJOX1kdLipMlEiPUlKsoqr3GkV2UVwo4Sf98I
	oHNLl15amfqWCtPGPVISStK7m63vG/zVgaobbGt9c2zQtENS2naUdVOtz2HEV3FyVzFImuNix5L
	Rp2STfo9GItTsD9bBUjYT4wEN7En2quvsI2hiXUje838uIjOVxSuC1dM1VvTMLA=
X-Google-Smtp-Source: AGHT+IH2rR2rP8fTM7ieRv7JpMuDjG5gkeJQOZupoiDEx9W4lXSbgwq0IEaADu9evSCfumBr8hQMvw==
X-Received: by 2002:a05:6000:4008:b0:38f:2685:8457 with SMTP id ffacd0b85a97d-3971a58a449mr5344443f8f.0.1742235176916;
        Mon, 17 Mar 2025 11:12:56 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.198.86])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395cb318a80sm15993744f8f.61.2025.03.17.11.12.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Mar 2025 11:12:56 -0700 (PDT)
Message-ID: <ef163f08-35f9-4d1d-8082-c826c6cd0aa0@linaro.org>
Date: Mon, 17 Mar 2025 19:12:55 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: OCOTP and DWMAC builtin modules are needed for imx93-11x11-evk
 kernel dev via TFTP and NFS
To: Alberto Merciai <alb3rt0.m3rciai@gmail.com>
Cc: shawnguo@kernel.org, linux-kernel@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org
References: <Z9fhuVltKwqgHdLp@alb3rt0-ThinkPad-P15-Gen-1>
 <935028c6-ce56-46e0-96ff-46fa91c8f66a@linaro.org>
 <Z9hkDqcKG1xOmIB5@alb3rt0-ThinkPad-P15-Gen-1>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <Z9hkDqcKG1xOmIB5@alb3rt0-ThinkPad-P15-Gen-1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/03/2025 19:03, Alberto Merciai wrote:
> On Mon, Mar 17, 2025 at 05:07:26PM +0100, Krzysztof Kozlowski wrote:
>> On 17/03/2025 09:47, Alberto Merciai wrote:
>>> While playing with linux-next and imx93-11x11-evk via NFS and TFTP
>>> I found that the dwmac-imx, nvmem-imx-ocotp-ele drivers by default are
>>> not builtin then the I was not able to reach userland. 
>>>
>>> The following configs were needed to reach my goal:
>>> CONFIG_DWMAC_IMX8=y
>>> CONFIG_STMMAC_ETH=y
>>> CONFIG_NVMEM_IMX_OCOTP_ELE=y
>>>
>>> is that something expected?
>>
>> You mean they are disabled or you just did not put them inside your
>> initramfs?
>>
>> Best regards,
>> Krzysztof
> 
> Hello,
> 
> By default they are enabled as external modules, then until we don't

So everything is as expected...

> reach userland they are not loaded thus eth and all the mechanism behind
> that are out.
> 
> I'm not using initramfs just tftp and NFS as follows:

All arm64 platforms are supposed to use initramfs on defconfig with
necessary modules.

> setenv loaddtb "tftp 0x80400000 imx93-11x11-evk.dtb"
> setenv loadkernel "tftp 0x83000000 Image"
> setenv netargs "setenv bootargs console=ttyLP0,115200 root=/dev/nfs ip=dhcp nfsroot=192.168.1.3:/tftp/root,v3,tcp"
> setenv bootcmd "run loaddtb; run loadkernel; run netargs; booti 0x83000000 - 0x80400000;"
> 
> Do you think that initramfs can solve that?

Yes, that's the entire point of initramfs.

> 
> To be honest I was expecting to have a builtin driver for eth by

No, why? We built as much as possible as modules in defconfig. Otherwise
it would be impossible to actually boot that image because several arm64
platforms have limitations of boot partition size.

Best regards,
Krzysztof

