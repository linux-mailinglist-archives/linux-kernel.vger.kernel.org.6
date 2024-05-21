Return-Path: <linux-kernel+bounces-185010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BD1C8CAF60
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 15:27:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 426AC283D1A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 13:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B10FD7D40B;
	Tue, 21 May 2024 13:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="aVbZHAxk"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BCD97D3F6
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 13:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716297999; cv=none; b=VCo+GtSkdRudmjA7U6Y0DYWOCS+tr81trh+mq7McOPAnZe4wJTUDqv8qz7K9Sp5ahFIFBwdBLNfghh0jzQ2pJxdnx7ZJRfa029NMuSN11O3Ru5MVP2RYwPKE1kZgrIYF5MY4Ue+gLM1MKhnE3M74PXR4S5ZjGzBRd4k3G8Tv9EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716297999; c=relaxed/simple;
	bh=sGedCRsF/aBEVrXCHETX6pOiIKrl00t0EgYxvQcGMWM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=uKaZax9ugLjKD87N4QNsKEHG1rCdVzZE/LtlB0d9N3p6zy/9GU+bEvMzUXHNmugfo16wY/zCPcvtvnQWnBw0SHXttHwIFzY/Wz7YElGD6YBpTa/ChStp9+ly22XW/wFM1Od5gePOQ52K/PeUhohKLNw8wTgsmpz6oypAM4wxU9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=aVbZHAxk; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-41fd5dc04f0so23104895e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 06:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1716297995; x=1716902795; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CrL09oMV4rZV1d29tFPXs1+jTnHwORy7lGYYvN9rls4=;
        b=aVbZHAxkhEX7zrVqgRTemQtdJnRafyOZT4cqQpEqY3UG3vMAsxRW3qvyIga8WSLoZZ
         6wN0K38IZLQ6m8+6zSxZkEDrG8AZ+/ZJ+YfVFxeu0j/VfNupDnsv667BSvNGt/YYwXhU
         vPq3Q4vITMJulrlAu3kHUFmLU6lOOfbprsfCIXxdAS3csY/qeZ8+rqkGxfZASEn2xs0N
         ellGhB2vALcdkcwJhazcTLofz4eJuK69nhJbUy1xu/E0Z0HRuttiA9IvAi/J2GS1n3tp
         EAIG+V1T7dZSkiIbhFLcnYUZKx0z9F7vtj0nAsvZF9gtQmOveM9W2y6b94Kqhix+Y3Vv
         Iyzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716297995; x=1716902795;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CrL09oMV4rZV1d29tFPXs1+jTnHwORy7lGYYvN9rls4=;
        b=CK4JV6Hxvx4LJ0PHWFiKnJQjUDpZy96iOEzOHhoeQ87xjxjqlT3Da2n127yr5uVDIz
         WXZBNUGmwpia2wqoX4bSdgjnITcOapLk0XAzjGpEJPZWA4ONGsk4nfGq5CrMUaR1Trvb
         q1mSpTQYaVzOC/e+c7RnCasZYaV2C6RnfC3Uw8IUulaDehK0Sn6vlXDRcxJgDZN6+7lc
         QNFs3tcTIBvh/GU8EUQrBwi2YxTq97YhlzK2cIo1b7Ccp+a2sLqb2zq3acV3dai2AMEm
         EIG/CKvDz5Q2rvUgKzTlhEqTn/PW51xmvAv/wEavmu31/hzjppCgM2iomy5Vc2VbZ1kL
         2Gwg==
X-Forwarded-Encrypted: i=1; AJvYcCU70rDSDxz0ueeEtNp97IRkI/80Wdkz34wm4Em4QF4AdUxbXek8DANXa8/hG1sPbdsu5xJa+2EzP4PG7P6qtpLsHqYS/utgJuY5iKGg
X-Gm-Message-State: AOJu0Yw3bjcgmG1MsBLxO2EGBLz5WEbHGs2l2W3zYskLMI/4Urw51CEa
	qz66UVquY2+WQ74ZgqZUCqY9TVSLbMgUEdQuFDjxrhLmLoqwGohFcISIPIakiag=
X-Google-Smtp-Source: AGHT+IHajWBe4PJHeY8YA0P+l+lgbTtcda22gyAdxfcJX54x099wwj6g4B4hBH/MjPhF/cyGyoO7hA==
X-Received: by 2002:a05:600c:3512:b0:41b:f979:e19b with SMTP id 5b1f17b1804b1-41fead6441amr318373205e9.39.1716297994532;
        Tue, 21 May 2024 06:26:34 -0700 (PDT)
Received: from [192.168.1.172] ([93.5.22.158])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-351d2df8449sm15526565f8f.12.2024.05.21.06.26.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 May 2024 06:26:34 -0700 (PDT)
Message-ID: <edc43094-19a7-4e62-8fba-ac2b22f66239@baylibre.com>
Date: Tue, 21 May 2024 15:26:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] arm64: dts: mediatek: mt8365: use a specific SCPSYS
 compatible
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 MandyJH Liu <mandyjh.liu@mediatek.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20240518211159.142920-1-krzysztof.kozlowski@linaro.org>
 <20240518211159.142920-2-krzysztof.kozlowski@linaro.org>
 <f42ef151-6eee-418f-91e1-5ac08d161119@collabora.com>
 <2cc638ca-0add-4c8c-b844-606e22dbd253@linaro.org>
 <cf8c87fe-7a4f-423f-9c97-3759eeee4894@collabora.com>
 <51a47736-ffe8-49e2-b798-d409ca587501@baylibre.com>
 <75b78eaf-9b13-477c-bf02-4e9837a25dd4@linaro.org>
Content-Language: en-US
From: Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <75b78eaf-9b13-477c-bf02-4e9837a25dd4@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 21/05/2024 10:22, Krzysztof Kozlowski wrote:
> On 20/05/2024 17:23, Alexandre Mergnat wrote:
>> Hello Krzysztof,
>>
>> On 20/05/2024 12:12, AngeloGioacchino Del Regno wrote:
>>> Il 20/05/24 12:03, Krzysztof Kozlowski ha scritto:
>>>> On 20/05/2024 11:55, AngeloGioacchino Del Regno wrote:
>>>>> Il 18/05/24 23:11, Krzysztof Kozlowski ha scritto:
>>>>>> SoCs should use dedicated compatibles for each of their syscon nodes to
>>>>>> precisely describe the block.  Using an incorrect compatible does not
>>>>>> allow to properly match/validate children of the syscon device.  Replace
>>>>>> SYSCFG compatible, which does not have children, with a new dedicated
>>>>>> one for SCPSYS block.
>>>>>>
>>>>>> Signed-off-by: Krzysztof Kozlowski<krzysztof.kozlowski@linaro.org>
>>>>> Technically, that's not a SCPSYS block, but called SYSCFG in MT8365, but the
>>>>> meaning and the functioning is the same, so it's fine for me.
>>>> So there are two syscfg blocks? With exactly the same set of registers
>>>> or different?
>>>>
>>> I'm not sure about that, I don't have the MT8365 datasheet...
>>>
>>> Adding Alexandre to the loop - I think he can clarify as he should have the
>>> required documentation.
>> Unfortunately, The SCPSYS (@10006000) isn't documented, but according to the functionnal
>> specification, it seems to have only one block.
>>
>> I don't have the history why SYSCFG instead of SCPSYS.
>>
>> I've tested your serie and have a regression at the kernel boot time:
>> [    7.738117] mtk-power-controller 10006000.syscon:power-controller: Failed to create device link
>> (0x180) with 14000000.syscon
>>
>> It's related to your patch 3/4.
> I don't see how this could be related. The error is mentioning entirely
> different node - mmsys. No driver binds to 10006000.syscon, except the
> MFD syscon of course, so my change should have zero effect on drivers.
> 
> The mtk-pm-domains (so child of patch affected in 3/4) only takes regmap
> from the parent, so the cells again are not related.
> 
> Just to be sure: you are testing mainline or next, without any other
> patches on top except mine?

I've tested on next

* a018995ac19c (HEAD -> temp, me/temp) arm64: dts: mediatek: mt8173-elm: correct PMIC's syscon reg entry
* 0f118436c61c arm64: dts: mediatek: mt8365: drop incorrect power-domain-cells
* d40e424fe6dc arm64: dts: mediatek: mt8365: use a specific SCPSYS compatible
* d7caa08a4a9b dt-bindings: mfd: mediatek,mt8195-scpsys: add mediatek,mt8365-scpsys
* 82d92a9a1b9e (tag: next-20240515, linux-next/master) Add linux-next specific files for 20240515
*   77ba09d6e7cb Merge branch 'next' of git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git
|\
| * dedcf3a8e704 tools/power turbostat: version 2024.05.10
| * baac2f4c7f3b tools/power turbostat: Ignore pkg_cstate_limit when it is not available
| * a0525800e2dc tools/power turbostat: Fix order of strings in pkg_cstate_limit_strings
| * ffc2e3d90e6f tools/power turbostat: Read Package-cstates via perf


I did the test with and without "0f118436c61c arm64: dts: mediatek: mt8365: drop incorrect 
power-domain-cells"

Without this specific patch, no regression.


-- 
Regards,
Alexandre

