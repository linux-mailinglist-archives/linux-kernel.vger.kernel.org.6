Return-Path: <linux-kernel+bounces-304997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32F179627E7
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 14:55:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A793E1F22F51
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 12:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54C751849D9;
	Wed, 28 Aug 2024 12:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nEE/Pms6"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35B817335C
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 12:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724849705; cv=none; b=nRcYGejEWcaOaVACl/qfQSwZB9eYeWVGc1cZfvHpbsQ5JUBmcl3dzXuT0m1aR3JIbDzAp+C5SxAj5wVTHWJLWZmfhZBq/fmJZdcD6vircOsGP262Wr59qN1JIQ6nkZj7i/tzzM+okmeH9oppWfzHgrTTJTQPwG2O98BcaOO+M7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724849705; c=relaxed/simple;
	bh=DClIq0lEA5dOsxuuLj7kL8lqpLxdHTWhSJJpMQRYybQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WA3B/Di5uUQBHLYpomjqws4cTOTISXrcXJcppQKV+RZFExdXeFOgOiUywm8uOsR423xBsGgjW4ahWyv/t9oGF3H5FVFb+4ZpSSvXA5NUbcnqKApHgD4fNQsp9P8Y6CZOLkJdwP4AHav7Bb+4+LYbCI44nZrJXRUm5v0rQOzcvNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nEE/Pms6; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-37353ba8eddso78642f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 05:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724849702; x=1725454502; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3HTeO2T40tB91P9SM7WBH5qhcD/FEefKq0gln5bxlI8=;
        b=nEE/Pms6oSMPKJwh1G7Az1t1TvHzmYo+tZNKvKM4LxL4Eal9tNPLUhUyscMfM+K/IV
         CE2MM9M4T+N7kVXY6SOBYBDsT7m8sHT4QAqeIaL/hYtaiOjO8WTDht70eB/kdKh1XbQn
         89EaHb18nzG/UJpdHAUEFM/r5mOPuJzEp7Aj2CJ0A7AHRjo2SWmbOtBpVOjPERnTgEra
         w3oSXF1QOmVs7D0EYizxiz3O7PA9iIHNXzkrsBNhVLZpN508Cj+K0DwMAFGhCQz1jhWQ
         m5Pg2fByBsSdYO0mfmkKIMMMhN6lxjPC4LZOxluPXSq8iDRBrWnOWVJN2irXmLqX8k4Y
         SrsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724849702; x=1725454502;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3HTeO2T40tB91P9SM7WBH5qhcD/FEefKq0gln5bxlI8=;
        b=cE4pZMeawItV5YnDWnm43AJCDxiXrGf73D1s2Q9pEhfXcvpT/CNvzmmseGQtfVY5DJ
         RHQKtykJrxctBIe6RQf2/ZNS0/mlpcleY1C5gtYtHkUp5ngdjDwSN5Lgjsj80zcMGvQx
         5a5I5/KwI6+S4b+Mkb4nmX/8nlqqzs+oh0OlFZBc5dCoP/QsIdQcsKAJzshlG0aDWNgU
         eA8IjBwmx74khmgFLt7F3mNhTD1skQKpUROEuKgnAea4yDWcbP9bqBkBbcYsBDUTHxLO
         V9chA63hwmHysohE2tak7rwyNonTdkXm8mg33NitkaanAWDOyH73huYXPh/M/U6UqCaR
         A0Cw==
X-Forwarded-Encrypted: i=1; AJvYcCWkmR5XuaryYtTCIrT/Wue6m5YPIQxkY3OMbU+jDaUVIg7ssL6YPFpV+uoeM5tXiaGoNo8fnABrGTlQU44=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyq88zoheTWHZ57TIyLzFp0z+m3KiCfWf70SCz5gboWxfcRHMbw
	i5YEFVThN6vu8bPodCL/UxMX06P04gXToavbfLfrvi35aVPKgUpZQNl5sbQNTD4=
X-Google-Smtp-Source: AGHT+IEOyFT3so2qylNVElOSR6ackqDGLJ1vg+aHt5XB/V1TThs9GDXcpI4vqhvKtdSt8pCRfH7LyQ==
X-Received: by 2002:a5d:598d:0:b0:36d:1d66:5543 with SMTP id ffacd0b85a97d-373118ce8a5mr6204353f8f.6.1724849701728;
        Wed, 28 Aug 2024 05:55:01 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.82])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3730813c5edsm15532806f8f.31.2024.08.28.05.55.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Aug 2024 05:55:01 -0700 (PDT)
Message-ID: <7110bb85-8f62-4dae-b4ed-55a977a548ea@linaro.org>
Date: Wed, 28 Aug 2024 14:54:59 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: ti: iot2050: Add overlays for M.2 used by
 firmware
To: Jan Kiszka <jan.kiszka@siemens.com>, Rob Herring <robh+dt@kernel.org>
Cc: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Tero Kristo <kristo@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 Bao Cheng Su <baocheng.su@siemens.com>, Hua Qian Li <huaqian.li@siemens.com>
References: <cover.1724682539.git.jan.kiszka@siemens.com>
 <7062ec915ecd161f6c62952eb7c1cd5036785dba.1724682539.git.jan.kiszka@siemens.com>
 <CAL_JsqJ+czuiiBUEaPBn0E+=5intMsxr6D8c33BapAD2=n7jOg@mail.gmail.com>
 <22f22118-58f0-4974-8327-736181c71aa7@siemens.com>
 <d24b0cc5-31cc-4fd5-91e0-17254e15b826@linaro.org>
 <2e91fcd9-b674-4a42-93bc-40ce2cc004a1@siemens.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <2e91fcd9-b674-4a42-93bc-40ce2cc004a1@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 28/08/2024 07:39, Jan Kiszka wrote:
> On 27.08.24 19:30, Krzysztof Kozlowski wrote:
>> On 27/08/2024 18:20, Jan Kiszka wrote:
>>> On 27.08.24 17:33, Rob Herring wrote:
>>>> On Mon, Aug 26, 2024 at 9:29 AM Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>>>>
>>>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>>>
>>>>> To allow firmware to pick up all DTs from here, move the overlays that
>>>>> are normally applied during DT fixup to the kernel source as well. Hook
>>>>> then into the build nevertheless to ensure that regular checks are
>>>>> performed.
>>>>>
>>>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>>>> ---
>>>>>  arch/arm64/boot/dts/ti/Makefile               |  2 +
>>>>>  ...48-iot2050-advanced-m2-bkey-ekey-pcie.dtso | 27 +++++++++++
>>>>>  ...-am6548-iot2050-advanced-m2-bkey-usb3.dtso | 47 +++++++++++++++++++
>>>>>  3 files changed, 76 insertions(+)
>>>>>  create mode 100644 arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-m2-bkey-ekey-pcie.dtso
>>>>>  create mode 100644 arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-m2-bkey-usb3.dtso
>>>>>
>>>>> diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
>>>>> index e20b27ddf901..f459af7fac0d 100644
>>>>> --- a/arch/arm64/boot/dts/ti/Makefile
>>>>> +++ b/arch/arm64/boot/dts/ti/Makefile
>>>>> @@ -77,6 +77,8 @@ dtb-$(CONFIG_ARCH_K3) += k3-am6528-iot2050-basic.dtb
>>>>>  dtb-$(CONFIG_ARCH_K3) += k3-am6528-iot2050-basic-pg2.dtb
>>>>>  dtb-$(CONFIG_ARCH_K3) += k3-am6548-iot2050-advanced.dtb
>>>>>  dtb-$(CONFIG_ARCH_K3) += k3-am6548-iot2050-advanced-m2.dtb
>>>>> +dtb-$(CONFIG_ARCH_K3) += k3-am6548-iot2050-advanced-m2-bkey-ekey-pcie.dtbo
>>>>> +dtb-$(CONFIG_ARCH_K3) += k3-am6548-iot2050-advanced-m2-bkey-usb3.dtbo
>>>>
>>>> You are missing applying these overlays to anything. That is a
>>>> requirement for any overlay in the tree.
>>>
>>> You mean apply for testing purposes? How, technically?
>>
>> Apply as build a target combining base DTS and overlay. See all other
>> overlays for technical aspect (just do the same).
>>
> 
> OK, it's about the magic behind the -dtbs vars.
> 
> BTW, it's not "all". I would say about 10% of the overlays are "dangling".

Yeah, true. There were several commits adding targets for base+overlay,
but probably still not everything is corrected, so my "all" was exaggerated.

Best regards,
Krzysztof


