Return-Path: <linux-kernel+bounces-171974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C0F98BEB5B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 20:16:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA3BD1C241CB
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 18:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4E6B16D322;
	Tue,  7 May 2024 18:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uUPaU451"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F7E16D307
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 18:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715105776; cv=none; b=pKDskZO41f9JOpHe6VZig0b0wVBuwRtLpkC5aJ0EPgY0BmW1/PD2/TUjV+y9CyD6gFsDgzvLEzlSFoz/LBvAFcze+76JJoQQGkggCZ63v24kSpMtXrUNSxNhmBFUStfqbwRu9SVLdhlACp7K8jfezyel1TCP3/xQ4/eWeesiVcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715105776; c=relaxed/simple;
	bh=z56DW4uwWXSfy2S2WxG5hWfb4HBVtScM8Dx6WGp0vzQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lkwrvn8hSONx3WPgzFpb9X/nJHQk1g+Wz7Fh14eYTkJHPHldIebX25hShgNWEFKnAdb0xO0VaRf/yT2JF+v9W1IUMYzWhnhB6sDk912Qqm8J9ihkbr2mTkTZTpzTjSF28N7TVZKqf4yRZ10REBFZWlmh6FVxi06+h1a7Hc/Nxl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uUPaU451; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-51f300b318cso4134500e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 11:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715105773; x=1715710573; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=FtF0ji+6sky/klPDr1qbiHk0/IYbyBDqkgtl3xUgr1E=;
        b=uUPaU451gBRCru7K58KlFwbPu0GSW6LXsrl7rS8JaZcggCUa55tzMN0o18DTPqtDE1
         5BjLzmFg8Qbfmjl2lNjqy1fQRqfe2FsGgPkrAKT9L3dgSJlPYyPBtR3jOwwWP8FAeQDE
         1EWkXd+W6WJb5Om3ylSWXVGwk3ZNb9nKDMWLIFxYm1vgccrTww0wm58+a7dUmGjzw0ht
         Q4DpUUFJwHF7eGaJl99IWD8ZXlMh7jXXFZjTKeHfcKVl8S4cfZoLAOa6Ej8ZC+oIEfZ6
         2fNmU+MikG4SyWdzN1MzjIjj6+HrZRbUOxI4o+/rqv0Eh5J3U55L7Bb3ck8IFK0Lx3KF
         9ZCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715105773; x=1715710573;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FtF0ji+6sky/klPDr1qbiHk0/IYbyBDqkgtl3xUgr1E=;
        b=hLiy6GvJj7p+XwPLnTD67lZPcsVcJ5zXen19hDLv0NvI9hYe03Iq1RLZZciVIdFlEl
         HMcXv84ReCg1TdBl1uwD/mPIf9Qj5tNIW+HajdgONDpYLygnGEoT5br0hubYVBC7uJ1f
         Ds70juWN7lG1v7KP5MonyQDKQX32h/hYdVBB+VIeh+k61VmERa3HYXmWQKzk7W/PgDPo
         JIh+bWDMc8Q7uzIZeSaNhPsyRn5ptpnfVObnuaHE8ufJArNducCkdRMD1GhZ5qDgw//c
         TXfimPeErLy+Pvw9x4KECSepSe0p7HzRfNihz2JlHZ1Qq2IITdGdi+KYKRDwEPpd/76B
         BxBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUsIthrt4gMeMm6cWRuI1V955zMHz2gxjDp/i1YfaPtwjcXzg9RrFpxSW7BRzZPtdPvEyO9NFTAMG8E/mumqvqPCKYP3Ympe8pHSUVr
X-Gm-Message-State: AOJu0YwnKqImqwWBejN8ShjcdEpe1mDOJQGqCOcR77surViJL/NaODpR
	DrWDdL8QETfCZ30Y1nDRD65zvjyKaIOJEuX6P6zb2O2x105rp3ldM5ZYvOvJyUY=
X-Google-Smtp-Source: AGHT+IEaffYJmtcSK9ATh0btRVS69w4HbbXHVxQX/eRQ4nldlJt0OgzferuLRuqtQg0E9ut8Lg5j2w==
X-Received: by 2002:ac2:4c0b:0:b0:51f:5d1a:7838 with SMTP id 2adb3069b0e04-5217c566a27mr187547e87.25.1715105772565;
        Tue, 07 May 2024 11:16:12 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.206.169])
        by smtp.gmail.com with ESMTPSA id a26-20020a50ff1a000000b005728a272753sm6516812edu.67.2024.05.07.11.16.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 May 2024 11:16:11 -0700 (PDT)
Message-ID: <cd26593f-31bc-4a1d-abd9-2fbf3539b030@linaro.org>
Date: Tue, 7 May 2024 20:16:09 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] ASoC: qcom: q6dsp: Implement proper channel mapping
 in Audioreach
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 James Schulman <james.schulman@cirrus.com>,
 David Rhodes <david.rhodes@cirrus.com>,
 Richard Fitzgerald <rf@opensource.cirrus.com>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Banajit Goswami <bgoswami@quicinc.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240507-asoc-x1e80100-4-channel-mapping-v1-0-b12c13e0a55d@linaro.org>
 <20240507-asoc-x1e80100-4-channel-mapping-v1-2-b12c13e0a55d@linaro.org>
 <89cf75d8-1f85-43d8-9c33-377a04b36121@linaro.org>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <89cf75d8-1f85-43d8-9c33-377a04b36121@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 07/05/2024 15:25, Srinivas Kandagatla wrote:
> 
> 
> On 07/05/2024 11:27, Krzysztof Kozlowski wrote:
>> Instead of relying on default channel mapping in all Audioreach
>> platforms, implement set_channel_map() callback to allow sound cards
>> customize the mapping depending on needs.
>>
>> The channel mapping is set on frontend DAIs coming from the topology,
>> not DTS, thus need to add DAI ops in topology dai_load() callback.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>>   sound/soc/qcom/qdsp6/audioreach.c |  2 +-
>>   sound/soc/qcom/qdsp6/audioreach.h |  1 +
>>   sound/soc/qcom/qdsp6/q6apm.c      | 28 +++++++++++++++++++++++++++-
>>   sound/soc/qcom/qdsp6/q6apm.h      |  8 ++++++++
>>   sound/soc/qcom/qdsp6/topology.c   | 12 ++++++++++++
>>   5 files changed, 49 insertions(+), 2 deletions(-)
> Please use the existing q6dma_set_channel_map() and set the channel map 
> for the backend dai from machine driver, this should work.
> 
> setting channels on FE is not a scalable one.
> 
> Please take a look at some of the patches that I shared privately.
> 

Ack

Best regards,
Krzysztof


