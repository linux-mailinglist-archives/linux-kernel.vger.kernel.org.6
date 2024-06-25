Return-Path: <linux-kernel+bounces-228612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80860916241
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 11:23:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CDA5EB26640
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 09:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18810149C5A;
	Tue, 25 Jun 2024 09:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="LDnc7mAO"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24341494AF
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 09:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719307389; cv=none; b=mXm0ivDOudWz4XI8Nt/r2vaepYWIvJYdKzAm+RoTbOrRRYjymBUxcGmfYw7fjHKJ+HoWO2kcyZkZIUUcSnmRQLVHzsluFBPWeXP9PUnDMFU88k7XDQkqE9SU3ZWqkZ227wneaafU3qWLCiw424oRFQ4MwLQdunx7EsYL1CgfEIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719307389; c=relaxed/simple;
	bh=8SACIkCe/rEQcO2uzmtJLJ1fzayy+8J8k4KMfAwiNO0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=bLhZLLR3x0wP0IZscT0tIt5MLI4gm9NP7QemcYHMivHwVMLW7dd3WX/TW5QtMediNUPlvlZ9IWuwWkRLCT5Eu7ZlMY6bB51F7jI14NCe4geILC2ecICo6cd6otTFGOyY6jihDd3BjE/aagTLyYidRWwQT6/Btbw5W/Wq4F0GWvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=LDnc7mAO; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-52cdea1387eso2972426e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 02:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1719307385; x=1719912185; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LlRhdkp6kAFepHjID66aLvJv1DZVnaI5n6pLIDvUVYM=;
        b=LDnc7mAOVIQyQw9YX0yh10j84cYwv+flect6lYWP9eaDqBApGiMZpKOanwg6r+IoRB
         NLiJ4vMxUIcXon/uwT6m6NelzHct10gJa8hmWyM6Z9a/RAGvHe/uRfPwQw4+XsmyBe5T
         KywcylE0go9nqjbopOv0qscZ9I3HAtqLIL0/4Sb+mvxxlhk6KkAO6oh8Zxik258u2Syk
         T2qtsP4+xpPk4yWc+CwP8ySivyBBw44BIlQLaXJ2BiFxjBo/vm/fleedrZAAPzUbKpUs
         ZvDCfj9xn2CkBaq7M4vLio//ZtlQwEDnTM/bG98Kglv/wTXWJt2Q31ej+AXUu8Pq01y9
         XGIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719307385; x=1719912185;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LlRhdkp6kAFepHjID66aLvJv1DZVnaI5n6pLIDvUVYM=;
        b=lqYF9+CWexGtcRe96b/YwOBMqSPUuirwuHliph42JBoH9P3f29fMPO84ItQdNKAAW0
         sbyVIxPKGnghYycJiLz/U2uSSMAi6PbJZWL3KvF153Pi41J5QrEPL5OtU/CnzptoGo4M
         aTzAEi+4zIkBYe9rQ98vxblNZAUnqZQmPO1BuUagHCxyyJrrK3fXWR1tNIsGhSuYxyA5
         TScegp8NzW4CKcw/H+4JqcIhm9m92XfSsftCqUTzvpZIYIE8LgHnnLwa8UmJh46XeJn3
         WPkblKAGB6zbCfOZOQ9iD9Yt/DojGtPAFk+nX53ndllNewpqcYhsYedEz7v2m1ilUCHj
         wfJg==
X-Forwarded-Encrypted: i=1; AJvYcCVFUaEOWU/gpOKTQdtA/Rr+Fb4gaPg2UfH4zZiE5qW+P4AvfK9apaIAokoZxbC4j1Npeb8/nYBFJf6tMBnCRifBIXeVFXXAJyWDkAzc
X-Gm-Message-State: AOJu0Yzzb3JIxYIOrXhinb5l3Si53Q1Ep1Ij+6KrXGuvy9Yy+1s+zYLM
	ALDWi8HefssZz3A7P16znhlAO0+ZJAVH+V86xNvWTz1gEdVjRIuYouaI9/6mst0=
X-Google-Smtp-Source: AGHT+IETSGc5PC+/KSXGB7oMPpuYoRZNE+bp/p6Mqr9WgOryoy8prGpDjhg+IZxxEgRRH3Pn20MxJA==
X-Received: by 2002:a05:6512:3e24:b0:52c:dff5:8087 with SMTP id 2adb3069b0e04-52ce185f998mr5011614e87.51.1719307384919;
        Tue, 25 Jun 2024 02:23:04 -0700 (PDT)
Received: from [192.168.1.172] ([93.5.22.158])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-366f624cdacsm4476317f8f.70.2024.06.25.02.23.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jun 2024 02:23:04 -0700 (PDT)
Message-ID: <95bab90f-b196-4e79-bb88-7fd534cca721@baylibre.com>
Date: Tue, 25 Jun 2024 11:23:02 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Alexandre Mergnat <amergnat@baylibre.com>
Subject: Re: [PATCH v6 03/16] dt-bindings: mfd: mediatek: Add codec property
 for MT6357 PMIC
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Lee Jones <lee@kernel.org>, Flora Fu <flora.fu@mediatek.com>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
References: <20240226-audio-i350-v6-0-f754ec1a7634@baylibre.com>
 <20240226-audio-i350-v6-3-f754ec1a7634@baylibre.com>
 <cd190d35-1658-43d8-9606-5e73257bbf3a@linaro.org>
Content-Language: en-US
In-Reply-To: <cd190d35-1658-43d8-9606-5e73257bbf3a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 21/06/2024 17:00, Krzysztof Kozlowski wrote:
> On 19/06/2024 16:46, Alexandre Mergnat wrote:
>> Add the audio codec sub-device. This sub-device is used to set the
>> optional voltage values according to the hardware.
>> The properties are:
>>    - Setup of microphone bias voltage.
>>    - Setup of the speaker pin pull-down.
>>
>> Also, add the audio power supply property which is dedicated for
>> the audio codec sub-device.
>>
>> Signed-off-by: Alexandre Mergnat<amergnat@baylibre.com>
>> ---
>>   .../devicetree/bindings/mfd/mediatek,mt6357.yaml   | 33 ++++++++++++++++++++++
>>   1 file changed, 33 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/mfd/mediatek,mt6357.yaml b/Documentation/devicetree/bindings/mfd/mediatek,mt6357.yaml
>> index 37423c2e0fdf..d95307393e75 100644
>> --- a/Documentation/devicetree/bindings/mfd/mediatek,mt6357.yaml
>> +++ b/Documentation/devicetree/bindings/mfd/mediatek,mt6357.yaml
>> @@ -37,6 +37,32 @@ properties:
>>     "#interrupt-cells":
>>       const: 2
>>   
>> +  vaud28-supply:
>> +    description: 2.8 volt supply phandle for the audio codec
>> +
>> +  audio-codec:
>> +    type: object
> Still not much improved. You do not have any resources there, so these
> should go to the parent node.

Hi Krzysztof,

vaud28-supply seems to be a mistake that I forward port.
In the V4, AFAII, your feedback [1] suggested me to move the vaud28-supply from the "audio-codec" 
sub-node to the parent node, which for me is the "pmic" (mfd), because the property is considered as 
power-supply.

     pwrap {
         pmic {
             ...
             audio-codec {
                 ...

Hardware side, vaud28-supply is the output of PMIC-regulator subsystem, and AVDD28 is the input of 
PMIC-audio-codec subsystem. Then:
- The property name is wrong and must be change to AVDD28, which is a consumer (power input), not a 
power-supply. => description: 2.8 volt power input for microphones (AU_VIN0, AU_VIN1, AU_VIN2)
- IMHO, move this property to the next parent (pwrap) isn't consistent. It should be moved back to 
Documentation/devicetree/bindings/mfd/mediatek,mt6357.yaml (Done in the V4) into audio-codec 
substystem, beside mediatek,micbias0-microvolt

Does this sound good to you ?

-- 
Regards,
Alexandre

