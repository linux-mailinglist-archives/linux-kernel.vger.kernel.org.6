Return-Path: <linux-kernel+bounces-294956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ECAF9594BE
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 08:35:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1F611F2476B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 06:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96E9F16DED8;
	Wed, 21 Aug 2024 06:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mWYotR+Z"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9909816DEAB
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 06:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724222036; cv=none; b=bu3OXZ8nnsB9ZP6j3nQfKFI/CFbTW27JUXAheDD/UQVZyzCN1Lx38ATk5kmw2pvpGXtgbxoKVMX4I8heSxMJ5WZyCk75pXaXowMu25VVEXVcevtYFbQQghzwREiDXsTjHCMJV0nW78vq6dhf8W7gXrm67gRaNTO1oWm8dXGpAwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724222036; c=relaxed/simple;
	bh=z0ZRcAo/08zRpH7ftQct8lru6URA2oG3c5yR+ReKyLg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fXhf/O7aixTXPt36FaPM5uiAiZt6cZ3KxDPL9xpHJO8tvf3rm4Za/fgFeF70s1X637F62tjbgDxoFqhWIRxGYFMFiUpYVP9T7jeOPKTfKktNoQGJmABDa4URs2UYjwQVb4mET3Giw4F6LCYmZ4yfL/p70B433EAi/iANqcyLyzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mWYotR+Z; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5bebc865578so939626a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 23:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724222033; x=1724826833; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=FzwpAjs7GmDmzs0LCYQ3XxACz/4q7U55KXW76F9f+Zk=;
        b=mWYotR+ZrMTILJvWtvw9nLMPJqWzMQrA0riFjWnQM7Me3+TOt1OHqYhgdVotp4EhYW
         jN2eg4pVS0uLyzJ1c6IY+IVdkSdbxGJNKBmDVTPZ4m9qInG6/v9VyRm4h41c6+1oNBb4
         BLgm1woSX8P/enMURr604L2agaaGpJX3zZ4N++OouZcmm2wr/8CZxFJzJS4xXL+pksoo
         scg13+IrwVhdIiGAtPStt02RAEw/Ka4OshBIhQEmAGg+R2sWNRAdtQyYEvJfkSJBz3cY
         PQfoPrEM15XQw4jN9wADkZmNpDA/uJ8YpvzLqabcxvupzqx1wPJcemMyTER1sCtR4cq/
         3ntQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724222033; x=1724826833;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FzwpAjs7GmDmzs0LCYQ3XxACz/4q7U55KXW76F9f+Zk=;
        b=urNoCFsJpjQfDK4tYrK8dqodGc8ckoeJ+79pKbPLZKndunDsiwHPzfW75GsrbHNVro
         QNf6yHtipLt/z2L+V3ENLqnNzyigpZ62aZRoBWOwFu9qi+GpbgmU5iSxOx5xduk4QZ9U
         l1X8tsfF8UceIJHevV8kcIXIphHlsl/Ag6GEXzIQxFuiUA6S38NjUARmfW3qpjUbwgOg
         JX5Usb/YgIFTf3XaAlYw6+Yb9bLBsXXgjDvzmXfueDgwNEcEJ11gNwCdDDbLHR41a4yn
         EPUCUIPdZPfAycP474QR61HkENdPTI46x/hdrKxHnF/Olvx1ELAs91gT6m0GAxq2sObd
         V6Fg==
X-Forwarded-Encrypted: i=1; AJvYcCU1GzcNqTkN1LLRietcCil22B8+r1iEF2B4IjeaPdonSLRAxxSbaqdkktrRHtqzhUYV99YMmkVfWvhNL6Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2DIPoUzftFefw/Nh2EN1EEfedpQeIEKpBjxI8ABdk3b+rGsw/
	OnlytIeaFX2+91xmLeJqdbpsl6a5QSl/cksjn4WntOjwWru991HOY82TF/Vfuu8=
X-Google-Smtp-Source: AGHT+IEfqkrA+VqLAmGGyLam8iW2x1U8pEGAdDVa54uXUiMu7ThPjQGZ3e0R3yECG+HNGfVKgkiJvQ==
X-Received: by 2002:a05:6402:51c6:b0:5af:6c44:6807 with SMTP id 4fb4d7f45d1cf-5bf1f2c1ef2mr407102a12.6.1724222032631;
        Tue, 20 Aug 2024 23:33:52 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.215.209])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bebc080277sm7700916a12.80.2024.08.20.23.33.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Aug 2024 23:33:52 -0700 (PDT)
Message-ID: <323cc7c0-8511-4d21-9925-97a6ba94280f@linaro.org>
Date: Wed, 21 Aug 2024 08:33:49 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] arm64: defconfig: Set MFD_TPS6594_I2C as built-in
To: Nishanth Menon <nm@ti.com>, Arnd Bergmann <arnd@kernel.org>
Cc: Judith Mendez <jm@ti.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, Bjorn Andersson <quic_bjorande@quicinc.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>
References: <20240819204352.1423727-1-jm@ti.com>
 <1a7def3f-a19c-4f1c-845c-a3854c165995@linaro.org>
 <20240820115331.myibtim7enhpg4cm@mortality>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240820115331.myibtim7enhpg4cm@mortality>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20/08/2024 13:53, Nishanth Menon wrote:
> On 23:01-20240819, Krzysztof Kozlowski wrote:
>> On 19/08/2024 22:43, Judith Mendez wrote:
>>> SK-AM62A-LP is a device targeting automotive front-camera applications
>>> among other use-cases. It utilizes the TPS6593x PMIC (interfaced over I2C)
>>> to power the SoC and various other peripherals on the board [1].
>>>
>>> MMCSD requires the PMIC to be setup correctly before setting the bus
>>> pins to 1.8V using the TPS6594 driver interfaced over i2c.
>>>
>>> Currently, the following could be seen when booting the am62ax platform:
>>>
>>> "platform fa00000.mmc: deferred probe pending: platform: supplier regulator-5 not ready"
>>> "vdd_mmc1: disabling"
>>>
>>> and a failure to boot the SK-AM62A-LP.
>>>
>>> One solution is to use initramfs [2], but using initramfs increases the
>>> boot time for this automotive solution which requires faster boot time
>>> parameters.
>>
>> This is a defconfig, not a distro/product config, so your product
>> constraints are not really relevant. You are supposed to boot defconfig
>> with proper initramfs with necessary modules.
>>
>> I don't get why people mistake defconfig with their product stuff...
>>
>>>
>>> Another solution is to change MFD_TPS6594_I2C to built-in, that way the
>>> PMIC is setup and the regulators are ready before MMCSD switches to UHS
>>> mode, this is the preferred solution since it does not increase boot time
>>> like the initramfs solution does.
>>
>> Use initramfs. Several devices, e.g. most Android ones, have fixed size
>> of boot partition, so size of kernel is important.
> 
> am62a products do not use android in general. Standard distros such

But I (and others) use sometimes devices with Android partitioning so
the size of vmlinux is important. I want to be able to enable KASAN. If
each person brings their modules into built-in, I won't be.

> as debian etc usage are limited as well. These products tend to have
> limited resources just sufficient for the normal operations.

So defconfig is not suitable for them in the first place.

> 
> While I understand that we do keep the product usage model separate
> from what upstream defconfig looks like, we have been very careful
> to only enable the basic configurations necessary for default system
> startup. During the initial days of K3, we had considered going down
> the initramfs route, but realized that this was not a practical
> option for developers to sustain and iterate quickly for triage or
> development. Till date, we have maintained nfs and sd card boot as
> default to allow for automated testing of upstream kernel.

I don't understand what is here not practical. Entire Qualcomm Landing
team for all products uses initramfs, my Exynos development uses
initramfs. There is no difference in building the kernel, no practical
impact, the same effort (after setting up the scripts, but we all are
scripting). I know, that 10 years ago many of developers, including
myself, did not want to switch to initramfs, but things change.

> 
> I understand that you have provided similar comments for other
> platforms[1] as well, but, I am now wondering if this is a new rule
> we are taking in aarch64 platforms to allow just initramfs and
> force all drivers to be modules (I understand that is the default

It's not particularly new. The use of modules for multi_v7 and
arm64/defconfig was since years.

> preference in android, but that is not true in other ecosystems). I am
> curious if this was some sort of conclusion in the list (my search of
> public-inbox seems to fail me here).

There are different point of views. I am presenting here mine and I back
it with arguments, that such changes accumulate and have impact on
developers workflow.

Defconfig is for developers and as starting point for distros or
products. Not as final product defconfig.

>  
> [1] https://lore.kernel.org/linux-arm-kernel/e08e6325-4b2b-c1ce-b33a-877de2c0babe@linaro.org/

Best regards,
Krzysztof


