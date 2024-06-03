Return-Path: <linux-kernel+bounces-198750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20E848D7CEC
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 09:58:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E1331C21323
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 07:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63D9953392;
	Mon,  3 Jun 2024 07:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="so8JI5Uu"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A8753365
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 07:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717401526; cv=none; b=Mc4OFt0P055c/BDFxZH/yvoBuY8R64yoh1X2W2VUkkXbM1HWV3Al+teNzAws4NVRz+3HhpR1IMD5RC4yJD5KElyyd6hIMQxNOntP+q30rrdXKjk5OrMy8rhYaGDKjZloJOPKUoILthI0nb8KQwuRiNaFAd18h1KJYmGrr9oUxTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717401526; c=relaxed/simple;
	bh=6kpT2U9u7A3J+3RZvunFCZzWlEPP+Dke4NuhjUNQlWk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NA16z7gqBWGq5QBsEa5Ic39gdUcvjiNFKi1jnJUMZIqSyaBTyQvG5YUpP3wCnJc0EH/qvjCu1a5t7/JhpZ+ML1lzUUlGzewVBUuAFb74XGXkrEXj1eEMKVsPdiPpSBmujBgM3TQUKS9v8WsYa2AJo/weMW08ul3lDHbKKCggEfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=so8JI5Uu; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4213b94b8b5so6314685e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2024 00:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1717401522; x=1718006322; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6kpT2U9u7A3J+3RZvunFCZzWlEPP+Dke4NuhjUNQlWk=;
        b=so8JI5UuIsIiUgWPkuxpZZvjbPG49fCuXuZOqG6IsAmYBexbS6dJfHKvluXGo3xqJP
         dQLYOzbmFPpM39RtIzXI8BkBoubRWgMsb758T9ZwcXw4jf2FUEXac8LNF2pJiPGVknTG
         V2cJIsNuFEnJQy+YsSR+FgsFK0ROTiAm769xZrGL1AToD0sM3lMKDuOWb9xRh+WJ06E0
         yB0YLjZy9Jx3/UWH8VTRV3S4uIq4EEgM0gtd56pA6GlD19NvVz2shARskex/if2auywS
         EyuEMM4TUFU43TtS5dayW206pxD4VvMcz9aLqtha+oRYkPpFydebM/fNIG3gdNkhrCmJ
         Uw0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717401522; x=1718006322;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6kpT2U9u7A3J+3RZvunFCZzWlEPP+Dke4NuhjUNQlWk=;
        b=T4QETOc20EvqE0kmgbDI3gg5Xt80/WjvNqLz+OitM/y+SxyjU+J07ztKAmYsjsm3at
         R1LqCqZUuMOA74h+qrpBill5PCu77EnItbo5Dq99MUvU9+or7RavlT2OgHH19+MqDBAV
         xFYUsjKttO5U/OVIy1ixh4N8IBEtzPUvQv0DfDjfByeuNTdil0KcI/mMKxOj3iilDbcl
         wtjAX1HjD6uMdNJUSF6mpX+HJRHQpf38xIpgD/xzKdZ3s5U1YeMwHJqsGi6snJS2sbwi
         ZpiLrWhyG16C8EKRdiOwUC1TJDJ7fMnYBcq4OEX0JDbOAbtbADWwRP/XqeqJIhKYkYFT
         yCYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFO7P5RNM/EIlAreUU6LVr5Eh8q37aaATYsTU8892MqgY0KwVRGONy1OWXYYkkU41LBXUepR+4RK8FuaeCXdsdhbsBJjsswgePxHAG
X-Gm-Message-State: AOJu0YxkDNveHwHcQACQrKUTn5iLOzAqaMQjB6zB0AASYRRbe2UCIDJC
	6oadk9sL9BdpR62KzDXbsw0WLCOuaceBL/YhJuoC5mesm3mnP1oDroGL96nqhdg=
X-Google-Smtp-Source: AGHT+IG8BZtVsXsEGPvAsZNEuv10PYEJJ90ijcMu5Alhgovv1Icm+OT1OTewd6+DuvM0JPwdDW9vuQ==
X-Received: by 2002:a05:600c:3c98:b0:41f:3ee0:a302 with SMTP id 5b1f17b1804b1-4212e0ae746mr68261095e9.30.1717401521650;
        Mon, 03 Jun 2024 00:58:41 -0700 (PDT)
Received: from [192.168.1.70] ([84.102.31.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4212f0f9660sm97225405e9.39.2024.06.03.00.58.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jun 2024 00:58:41 -0700 (PDT)
Message-ID: <940eec49-91d8-4d38-a3d8-e1b7e090b905@baylibre.com>
Date: Mon, 3 Jun 2024 09:58:38 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/6] arm64: dts: mediatek: mt8186: add default thermal
 zones
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Chen-Yu Tsai <wenst@chromium.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, Daniel Lezcano <daniel.lezcano@linaro.org>,
 Nicolas Pitre <npitre@baylibre.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org,
 Krzysztof Kozlowski <krzk@kernel.org>
References: <20240529-mtk-thermal-mt818x-dtsi-v6-0-0c71478a9c37@baylibre.com>
 <20240529-mtk-thermal-mt818x-dtsi-v6-4-0c71478a9c37@baylibre.com>
 <75826085-fd59-466a-b1de-b4c323c801c1@collabora.com>
 <CAGXv+5FPG4ob3mTU0Utm8Wgk0_ZLw=NLPbfFerWh4OUeAz7UHw@mail.gmail.com>
 <808db317-4cee-426b-a840-013a5e03098d@baylibre.com>
 <ad047631-16b8-42ce-8a8d-1429e6af4517@collabora.com>
Content-Language: en-US
From: Julien Panis <jpanis@baylibre.com>
In-Reply-To: <ad047631-16b8-42ce-8a8d-1429e6af4517@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/29/24 14:06, AngeloGioacchino Del Regno wrote:
> Il 29/05/24 11:12, Julien Panis ha scritto:
>> On 5/29/24 10:33, Chen-Yu Tsai wrote:
>>> On Wed, May 29, 2024 at 4:17 PM AngeloGioacchino Del Regno
>>> <angelogioacchino.delregno@collabora.com> wrote:
>>>> Il 29/05/24 07:57, Julien Panis ha scritto:
>>>>> From: Nicolas Pitre <npitre@baylibre.com>
>>>>>
>>>>> Inspired by the vendor kernel but adapted to the upstream thermal
>>>>> driver version.
>>>>>
>>>>> Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
>>>>> Signed-off-by: Julien Panis <jpanis@baylibre.com>
>>>> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>>> I'm getting some crazy readings which would cause the machine to
>>> immediately shutdown during boot. Anyone else see this? Or maybe
>>> my device has bad calibration data?
>>>
>>> gpu_thermal-virtual-0
>>> Adapter: Virtual device
>>> temp1:       +229.7 C
>>>
>>> nna_thermal-virtual-0
>>> Adapter: Virtual device
>>> temp1:       +229.7 C
>>>
>>> cpu_big0_thermal-virtual-0
>>> Adapter: Virtual device
>>> temp1:         -7.2 C
>>>
>>> cpu_little2_thermal-virtual-0
>>> Adapter: Virtual device
>>> temp1:       +157.2 C
>>>
>>> cpu_little0_thermal-virtual-0
>>> Adapter: Virtual device
>>> temp1:       -277.1 C
>>>
>>> adsp_thermal-virtual-0
>>> Adapter: Virtual device
>>> temp1:       +229.7 C
>>>
>>> cpu_big1_thermal-virtual-0
>>> Adapter: Virtual device
>>> temp1:       +229.7 C
>>>
>>> cam_thermal-virtual-0
>>> Adapter: Virtual device
>>> temp1:        +45.4 C
>>>
>>> cpu_little1_thermal-virtual-0
>>> Adapter: Virtual device
>>> temp1:       -241.8 C
>>
>> It's likely that your device has bad calibration data indeed. We observed the same
>> behavior on the mt8186 device we used (a Corsola) and finally realized that the
>> golden temperature was 0 (device not properly calibrated).
>>
>> To make a comparison, we run chromiumos v5.15 and dmesg output was:
>> 'This sample is not calibrated, fake !!'
>> Additional debugging revealed that the golden temp was actually 0. As a result,
>> chromiumos v5.15 does not use the calibration data. It uses some default values
>> instead. That's why you can observe good temperatures with chromiumos v5.15
>> even with a device that is not calibrated.
>>
>> This feature is not implemented in the driver upstream, so you need a device
>> properly calibrated to get good temperatures with it. When we forced this
>> driver using the default values used by chromiumos v5.15 instead of real calib
>> data (temporarily, just for testing), the temperatures were good.
>>
>> Please make sure your device is properly calibrated: 0 < golden temp < 62.
>>
>
> Wait wait wait wait.
>
> What's up with that calibration data stuff?
>
> If there's any device that cannot use the calibration data, we need a way to
> recognize whether the provided data (read from efuse, of course) is valid,
> otherwise we're creating an important regression here.
>
> "This device is unlucky" is not a good reason to have this kind of regression.
>
> Since - as far as I understand - downstream can recognize that, upstream should
> do the same.
> I'd be okay with refusing to even probe this driver on such devices for the
> moment being, as those are things that could be eventually handled on a second
> part series, even though I would prefer a kind of on-the-fly calibration or
> anyway something that would still make the unlucky ones to actually have good
> readings *right now*.
>
> Though, the fact that you assert that you observed this behavior on one of your
> devices and *still decided to send that upstream* is, in my opinion, unacceptable.
>
> Regards,
> Angelo

I've been trying to find some more information about the criteria
"device calibrated VS device not calibrated" because there's a
confusing comment in downstream code (the comment does not
match what I observe on my device). I'll send a separate patch
to add this feature over the next few days, when I get additional
information from MTK about this criteria.

