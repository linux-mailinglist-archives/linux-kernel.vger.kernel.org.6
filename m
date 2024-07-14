Return-Path: <linux-kernel+bounces-251769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C5FD93098C
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 12:21:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF8651C20C32
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 10:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E3F926AE6;
	Sun, 14 Jul 2024 10:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l+3RrpYx"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58F449629
	for <linux-kernel@vger.kernel.org>; Sun, 14 Jul 2024 10:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720952495; cv=none; b=lFiACJvF6WNjBgRD5EBTuRHh0bz0nQe0eBz3PMIQyMBpDrdZWRznIJkozDcgSawDRSf4AowiLtS9kDyKVY7pcLInzxk2IKwGvlp2Egyb6yKccexFFlotR680R52jiip5mvrnP6UqlKzleW7z0odiep4YKkEQ7RdV8tnY1VdGn/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720952495; c=relaxed/simple;
	bh=UcuDJs+XlgVYl+OTxAAxOqbM9vj+nn7D7kyPOTjhZCo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=SRDgZxHrAn5rpAkWz0xKZ6gv4AF+sdwDfqM9meMFp9pNJ8adDIIUPS182F34fbuNAngP5+cJFdkypvVQi2SsLyg4emjr6med1cmNBt0/6muywQvkLS9hsztVbwXASI0o0Wx/jzeZCMdVBKnz5TJKyFkCqxeZcuRFuYQ+jgNjgfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=l+3RrpYx; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-367e50f71bbso2277216f8f.2
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jul 2024 03:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720952492; x=1721557292; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5z/03b2vX7NcAXJ+dFsF5PuyQGEdW6/zBENfqYSkXws=;
        b=l+3RrpYxhqUq/5lLPyL0VFlV/AC+9PNpbuESUn27iR39mM7fQG59Gz5KX5Lw/qCn2H
         WRcq6PGV22qJDnAwVm9G+5Rt27UIheOdoqIWxRZ5PwfI6QaBRNvNhzDzf2G5WUslXRkK
         Zti8pEIBpXnzom8zs9FOguEp9dQnlGsi9C6oZ5QGtaPLJFA5AmjQ9dXxFCMb6bGL/+7O
         NlpvO1E7P43z0NaNrcFNd+ZclZ/6hao6vpvC4MeTzW3tIteA47fWtvX3yp3shpmYLIsR
         skZOn/Qzx1DuvBcMbpjYcHjhUU/gZCTrBaRl+vxODBzEApffFMv46F3Wev7tH/JxtBXg
         7DAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720952492; x=1721557292;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5z/03b2vX7NcAXJ+dFsF5PuyQGEdW6/zBENfqYSkXws=;
        b=meBn+Ty3teLl/q5sNzsj6M4WNvu2rv6gvxRO7vY0AdMphtLYTbQ5T0LBLhqrJYhv72
         zZtC+qSkyl6AlcmuZCrBAcJPcDNopIjdMakcVVFred1ljRY+cUg97UzAEIhvSxpzS7Ig
         TbQktdASgTky2l/MOEOkx4LRVDrZ/sLjRhjPDl7ZmX6jIrrWPg9HwNF0q0HrJqgOQViV
         oJUrVFzFZ8pKLtsEfyIUvoHsVk1WyoFIUfkbOoq0iUluxtf7dwTahBgbw5KAZT7v9BbO
         0D2I17fEOrYSpL2vJP04m1nRu5U2b1tqhwku9DBUfsJvO5lceDcEjLZiE4J6zcpuumF5
         D09Q==
X-Forwarded-Encrypted: i=1; AJvYcCXt+cUgLXYAqcbOZ0ioz0cCP/pnQN0JBZTJAwI2vD1+li7l75GykgEQi7HVi8D1zOJTcUu9Cvfxxmt3eenMLyaFr+CTl93pn0DKdhJI
X-Gm-Message-State: AOJu0Yxj60k6B24K4LXXGh9eheh0SZdg/UL1S2/b+6UbT+bSNCNWiP35
	5bi6rdqIWG+kvjPbsonOgj+nMSgZoZVoPsqzIF50ypixbcLNwkAu2AGNQxg1Wos=
X-Google-Smtp-Source: AGHT+IGm6o+vwGijyHYqejsnlf6YGOgobKUZq1j+ksyWC2JQFBR4pON627dYIWnOuAYV5DQ6aApepg==
X-Received: by 2002:a05:6000:110f:b0:361:bcc5:2e26 with SMTP id ffacd0b85a97d-367cea7382cmr11068764f8f.19.1720952491982;
        Sun, 14 Jul 2024 03:21:31 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3680dafb939sm3485997f8f.89.2024.07.14.03.21.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Jul 2024 03:21:31 -0700 (PDT)
Message-ID: <36840696-772b-4e57-a672-ec5210ebeb64@linaro.org>
Date: Sun, 14 Jul 2024 12:21:28 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ASoC: codecs: wsa884x: Implement temperature reading
 and hwmon
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Banajit Goswami <bgoswami@quicinc.com>, Jean Delvare <jdelvare@suse.com>,
 Guenter Roeck <linux@roeck-us.net>, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-arm-msm@vger.kernel.org, linux-hwmon@vger.kernel.org
References: <20240713095635.23201-1-krzysztof.kozlowski@linaro.org>
 <fd09fa44-1795-43a1-ba8d-ca2ba8f71d07@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <fd09fa44-1795-43a1-ba8d-ca2ba8f71d07@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14/07/2024 12:02, Krzysztof Kozlowski wrote:
> On 13/07/2024 11:56, Krzysztof Kozlowski wrote:
>> Read temperature of the speaker and expose it via hwmon interface, which
>> will be later used during calibration of speaker protection algorithms.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>
>> ---
>>
>> Changes in v2:
>> 1. Add missing dependency on HWMON for y!=m builds (kernel test robot
>>    report: undefined reference to
>>    `devm_hwmon_device_register_with_info').
>> ---
>>  sound/soc/codecs/Kconfig   |   1 +
>>  sound/soc/codecs/wsa884x.c | 197 +++++++++++++++++++++++++++++++++++++
>>  2 files changed, 198 insertions(+)
>>
>> diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
>> index 97bb69c9848d..09a0b209bc2f 100644
>> --- a/sound/soc/codecs/Kconfig
>> +++ b/sound/soc/codecs/Kconfig
>> @@ -2447,6 +2447,7 @@ config SND_SOC_WSA883X
>>  config SND_SOC_WSA884X
>>  	tristate "WSA884X Codec"
>>  	depends on SOUNDWIRE
>> +	depends on HWMON || !HWMON
> 
> Eh, now I got build report that hwmon does not have stubs for !HWMON (by
> design or missing?), so this still has compile failures.
> 
> I think we should have (devm_)hwmon_device_register_with_info() stubs
> for drivers not depending on hwmon, so I will propose a patch for that.
> If that approach is accepted, no changes should be needed in this
> wsa884x v2 patchset.

Answering to myself: I see now that lack of !HWMON stubs for providers
is rather by design and drivers use IS_REACHABLE. I'll send a v3 of this
patch.

Best regards,
Krzysztof


