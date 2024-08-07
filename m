Return-Path: <linux-kernel+bounces-278199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B862894AD55
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 17:48:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78E85281461
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 15:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2637512C46F;
	Wed,  7 Aug 2024 15:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QTsG/ljY"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08FEF84A3F
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 15:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723045693; cv=none; b=mVKIqfgJrvhuHY9xpCNQpVU6obBrWtjlVsNavbcx+Zs0frIucQgh2ZbfaBYdRnbeguTk02Lo7yPoSJcquXCp3gAg0WygOoX3EVN81kmiBIzRCrOaWHyV7leuqSkhnx1ariIMIxxqgP4O0H7MQ0MCK/AJyV+0UsQcBClxkxVNvEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723045693; c=relaxed/simple;
	bh=2SG8xYet8iM4XBjJ8hMJSN23Km8jICWE9ojoQ40eHyA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g7kefe0XpkMiB2ECv0kBPI3lo/uLY/4YnLmFvGzgamKfH6ngU96P7U4tu8v/xEVsSvVKe7ZaAHMOz/ACM9O2kuN1gIWarFjdMiSM06RpmEGAMwY76yy+jcUgZPa+obf1YdkbEGaLhMfHQkvK8VV9KAJCoG7peGSyGcOG3oAJBSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QTsG/ljY; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1fc587361b6so474005ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 08:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723045691; x=1723650491; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sr3PdalUoM9aF0lpRF7K8A1S8WPpJ1QtIIVRrJ5+kaw=;
        b=QTsG/ljYNwInb0CB/7iUFmpvH1LQxc7SAvonzezUoj+TkaDgVcdNchbFmbbwh0MpNM
         lCuqkwM4d85lPvovI04hT8GxtQ/d5E8hr2tXCQbJqY0KAPm5kgA4IpqXjAefg/uENieT
         h3LM0JqprzUE75P9etFz7ROqaJs+AODESTL+jcDPpAUyDNfrgxB25R2tT8uNJ1B7O+Ue
         TOWIP6sEJaapJRNTMti4YfUQ94EoGemqSYPD7oycGR+dbQ9RYZ0wwpU+X4KXfuGSATbw
         RSfIRSk8N5hfjnlqpbjLanMtxw7kDcojzbnL+bmkohpk0QkkW+qzuoxYhIV1OQsrfSw/
         v1Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723045691; x=1723650491;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sr3PdalUoM9aF0lpRF7K8A1S8WPpJ1QtIIVRrJ5+kaw=;
        b=qsbMiKoe4x0UPaQI5OLrAHiYqjpCLnEj67z//i5GiiNbKdj+ACCMmEOYoP95FP5YaV
         r690khPwNr6ZIx4Npnvi18f/LJzVP9F+NOzO0KeCOtQW9zaGDazEmgTwjNGQCktpI30t
         9kaO1VXpPpcZvA89fASBnkSWcLqkSFz/GBl+ErXsRv7/L5bQgh6aptz2v3sgKe81bERt
         CCbNYyVDgi33FMPw+FsC/rfSlmz5JXCY/5k+REM0x2/9CsgkI5G+GRykjs/yVaj8y/pR
         Ot6jqQh9PRIi/B/WOpRf3XqJMguHm4UsvfjOx5nqGezRu9/+Pbm0v2qseyC+70Uq98E7
         auPw==
X-Gm-Message-State: AOJu0YyJwyuK4UBturZIpTJCRS6quXpAdmbBqwsno/JkTbeeWPHAF6h+
	hZhNqvSQKpFg/8TVpGrMyO+ebDbA7oyQkqEBmI+bNVvV1ovsXr8Y
X-Google-Smtp-Source: AGHT+IHE2c3/F7n0oFWFrmfUYxodKwXNn4EmQ4orrmBd1DBFmahcCgLnnm4SH6Tgep8MTZVbCCsbig==
X-Received: by 2002:a17:903:234b:b0:1fb:984c:555a with SMTP id d9443c01a7336-1ff574ba872mr192045375ad.52.1723045691067;
        Wed, 07 Aug 2024 08:48:11 -0700 (PDT)
Received: from [192.168.10.4] ([43.224.156.13])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff58f5a222sm108636435ad.112.2024.08.07.08.48.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Aug 2024 08:48:10 -0700 (PDT)
Message-ID: <44ffc9bc-f14e-4576-94fe-189c1f672444@gmail.com>
Date: Wed, 7 Aug 2024 21:18:06 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [build fail] v6.11-rc2 from "ARM: 9404/1: arm32: enable
 HAVE_LD_DEAD_CODE_DATA_ELIMINATION"
Content-Language: en-GB
To: Arnd Bergmann <arnd@arndb.de>, Yuntao Liu <liuyuntao12@huawei.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Russell King <rmk+kernel@armlinux.org.uk>, Ard Biesheuvel <ardb@kernel.org>,
 harith.g@alifsemi.com
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <14e9aefb-88d1-4eee-8288-ef15d4a9b059@gmail.com>
 <c11ba413-89f6-46b4-8d59-96306c9f1f14@huawei.com>
 <52518ac5-53bb-4c70-ba99-4314593129dc@gmail.com>
 <2812367a-49ad-4c88-8844-8f8493b15bbd@huawei.com>
 <a65d0b09-466d-415f-9bd0-cbc5ff3539e7@gmail.com>
 <2083af75-e2d8-42b9-8fa6-f5b7496671bd@app.fastmail.com>
From: Harith George <mail2hgg@gmail.com>
In-Reply-To: <2083af75-e2d8-42b9-8fa6-f5b7496671bd@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 07-08-2024 21:11, Arnd Bergmann wrote:
> On Wed, Aug 7, 2024, at 17:36, Harith George wrote:
>> On 07-08-2024 20:52, liuyuntao (F) wrote:
>>> Thanks, I reproduce the link error with toolchain
>>> gcc version 9.3.0
>>> GNU ld (GNU Binutils) 2.33.1
>>>
>>> with same gcc version, just upgrading ld version to 2.36.1, it does not
>>> segfault and build completes. there should be bugs in low version of ld,
>>> and the ".reloc  .text, R_ARM_NONE, ." triggers that.
>>>
>> Thanks for confirming.
>>
>> I guess we need to add something like
>> #if !CONFIG_CC_IS_GCC || CONFIG_LD_VERSION >= 23600
>> around the entry-armv.S changes and maybe select
>> HAVE_LD_DEAD_CODE_DATA_ELIMINATION in arch/arm/Kconfig only if the same
>> conditions are met ??
> 
> I think it makes most sense to have a minimum LD
> version as a dependency for HAVE_LD_DEAD_CODE_DATA_ELIMINATION.
> Are you sure that 2.36 is the first one that works, and it's
> not just 2.33 specifically that is broken?
> 
> If so, we could use
> 
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -117,7 +117,7 @@ config ARM
>          select HAVE_KERNEL_XZ
>          select HAVE_KPROBES if !XIP_KERNEL && !CPU_ENDIAN_BE32 && !CPU_V7M && !CPU_32v3
>          select HAVE_KRETPROBES if HAVE_KPROBES
> -       select HAVE_LD_DEAD_CODE_DATA_ELIMINATION
> +       select HAVE_LD_DEAD_CODE_DATA_ELIMINATION if (LD_VERSION >= 23600 || LD_IS_LLD)
>          select HAVE_MOD_ARCH_SPECIFIC
>          select HAVE_NMI
>          select HAVE_OPTPROBES if !THUMB2_KERNEL
>
The select alone may not be enough. Wont the changes in 
arch/arm/kernel/entry-armv.S still result in LD Segfaults even if the 
HAVE_LD_DEAD_CODE_DATA_ELIMINATION flag is not set in .config for older 
toolchains?

Thanks,
Warm Regards,
Harith
> 
> binutils only takes a few seconds to build from source, so
> you could just try all version from 2.25 (the oldest supported)
> to 2.36) to see which ones work.
> 
>         Arnd


