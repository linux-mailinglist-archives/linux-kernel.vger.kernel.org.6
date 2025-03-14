Return-Path: <linux-kernel+bounces-561893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC7C9A6183B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 18:40:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E7F11896E02
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 17:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 099F22046A6;
	Fri, 14 Mar 2025 17:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xoLqgRv4"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1456202C55
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 17:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741974012; cv=none; b=ZXTRsXLny1fDMo1wU6vcDLN8ID2QthYwOAH8Dz/CyqdNQONFkW4Cn7EMMbCAIvOFURgtnZOnlFt7rfb+4TSHrY/I7Lb5ol5351gOQCAj69bN8r6vAHAWyRq+O6cJQfkdiup2LI6rN/ErTbPup8/XbA0dvHPCzyiSi1Cy1M1bWOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741974012; c=relaxed/simple;
	bh=+y5PhC4XzO/VnRIwG5rJiSt/p4JA+JB3Z4/wrDzAWAk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=djoz3FS15Li8osfIZr6h2M4aNE0KGJtKxhJCBnVbm/XIva8P6pEXqgXR1Ng9a0ymSDGN14aWllaJm1iJxdmV1L5s+nM1oH0JgCIvVD0qnTkKvN6rq9JHqN+A/ODDLHFF55INmlXDa88+5kZAraRJfed0sOpqUYGEnveue+2IhuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xoLqgRv4; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-391342fc148so1572859f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 10:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741974008; x=1742578808; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=68pP/H0ssSIUIb0wMm11zyV+DWPe8FTOSDazoy8xF8o=;
        b=xoLqgRv43DEFE8NTmiEA/MhNCCgK6xJqIZ3RbqVbOWKDrcK55lgBeXNbDFV186sd8a
         ooWc/jhZWUmFCkdixADFP2aN+qS7JhtkepiKIgBFFVLEuvMVvmksWIo8wjaJ6Y+vV8t/
         PqDafPH/8ACk3gP3HYiHUzfHhDI3RKd2wDPfvfcTxZeEA4pGGDPkAI1KaqV1MLdHGKRd
         N4PvT7Js1m7EH0Q+zVa7PniE045AdMPY2LWA/DIjpsrzbPzjaQsuzD1af1Qk0Gmk02DO
         N07gsTE9JyqTJDPH8ErRsJXbYuW8aBEbWBTmyZZCod1c74M0ggMLHXg11DezBikId/g8
         x0Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741974008; x=1742578808;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=68pP/H0ssSIUIb0wMm11zyV+DWPe8FTOSDazoy8xF8o=;
        b=JK7jZ8VFErQzuZRSyiCSDxad/l47P7vI1HFaQMkaXpHb1bdp0VHLstr6wNdN1/bQHr
         xGv6tt6GdJG3lCET/pTNyRSAY1Z7OI1nQ17lFsGFM4+eEtgkjvtzWuUVBCqR8l9Y1WK9
         xd0xjmudfzN+FPZDYBznk8HlJUQrFuo0A7+aTvmOg6w8SQ7LG63WBb3h8HPSsLdHrj8j
         FjTb/eXROgUX+M7Dpf5GMwhvl2mfoilim6j+HadVGviUSkjY9tSeXi1pqZTRUlXIlCvd
         oiYzO7Goer33/gFOTJguu+eISgG4+VA6CvUJG6o4kM5xnN11hYbVh2Cymu474QWHSZ7Y
         xS6w==
X-Forwarded-Encrypted: i=1; AJvYcCVJmwUiSXT/YRZ8lERBWfaIq2EIDl7mYPnYO4wMttuFb4EA95hMI6AZIyH10TYf1bvaPfgJsW0XNo4H9Sc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjE+bUBXkh/S2ASfsZIr2xiHV+B4O6VBzwc4EV4+fl1mzPPN6n
	qVygs4KoBho415WeRc6yfZ7C0qurMAlbFWi44IvYMLHNxhmQa+HqTifHnJo7O6k=
X-Gm-Gg: ASbGnctZ26U14NoJwv8wiqJGA7MElHI3SQdX6v7MF9wCToiSboJX2BQJVYP32VKNSul
	NSbAhjhVn4su+n2ixbcxs7ocAyE3VYr8rbhdZqI9vBKxXRBALvZW8ynml4MrOq3fIUK7nVPUfz2
	zWdqeRySpxHqRfWLkNv0Ge0M5TbNMgwvVOYuHoMxb/EaPyKm0uo8yrTB/VQ5ogJzXIJKnoCMVLs
	EcfM4TkS+g5jabvFLiVS8GltkXPv7Icx0hKua1mMV01tuv/849lZNPMf6f0Jf/SfrJe2fZit7FN
	1hRnc4QmxSHdfKrS2EfhhT0rqmLP+55dxGYFF7JSgi4v7gppMJDRq2Fiah5TZDI=
X-Google-Smtp-Source: AGHT+IH78OxZy3COSxNQ/R2QpNx/WSsG5NmsZ858z5YdVxy8Zi13E8ydSZy8fnTU59kmbAhJ0dXxlQ==
X-Received: by 2002:adf:a39b:0:b0:397:5de8:6937 with SMTP id ffacd0b85a97d-3975de869d5mr3233289f8f.41.1741974007940;
        Fri, 14 Mar 2025 10:40:07 -0700 (PDT)
Received: from [192.168.68.117] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-395c8e43244sm6339791f8f.60.2025.03.14.10.40.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Mar 2025 10:40:07 -0700 (PDT)
Message-ID: <9e42378b-b9b6-47f9-a7f5-0e003afc3ebb@linaro.org>
Date: Fri, 14 Mar 2025 17:40:05 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/5] ASoC: qdsp6: q6apm-dai: set 10 ms period and
 buffer alignment.
To: Johan Hovold <johan@kernel.org>
Cc: broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
 krzysztof.kozlowski@linaro.org, linux-sound@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 dmitry.baryshkov@linaro.org, johan+linaro@kernel.org
References: <20250314143220.6215-1-srinivas.kandagatla@linaro.org>
 <20250314143220.6215-5-srinivas.kandagatla@linaro.org>
 <Z9Rdc-EWhEH8IQPu@hovoldconsulting.com>
Content-Language: en-US
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <Z9Rdc-EWhEH8IQPu@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 14/03/2025 16:46, Johan Hovold wrote:
> On Fri, Mar 14, 2025 at 02:32:19PM +0000, Srinivas Kandagatla wrote:
>> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>>
>> DSP expects the periods to be aligned to fragment sizes, currently
>> setting up to hw constriants on periods bytes is not going to work
>> correctly as we can endup with periods sizes aligned to 32 bytes however
>> not aligned to fragment size.
>>
>> Update the constriants to use fragment size, and also set at step of
>> 10ms for period size to accommodate DSP requirements of 10ms latency.
>>
>> Fixes: 9b4fe0f1cd79 ("ASoC: qdsp6: audioreach: add q6apm-dai support")
> 
> For all of the patches, if the intention is that they should be
> backported to stable they should have a CC stable tag here.

Ideally yes. It would nice to get these back ported to stable.
> 
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
>>   sound/soc/qcom/qdsp6/q6apm-dai.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/sound/soc/qcom/qdsp6/q6apm-dai.c b/sound/soc/qcom/qdsp6/q6apm-dai.c
>> index 90cb24947f31..a636f9280645 100644
>> --- a/sound/soc/qcom/qdsp6/q6apm-dai.c
>> +++ b/sound/soc/qcom/qdsp6/q6apm-dai.c
>> @@ -231,7 +231,6 @@ static int q6apm_dai_prepare(struct snd_soc_component *component,
>>   	cfg.bit_width = prtd->bits_per_sample;
>>   	cfg.fmt = SND_AUDIOCODEC_PCM;
>>   	audioreach_set_default_channel_mapping(cfg.channel_map, runtime->channels);
>> -
> 
> nit: unrelated change
Fixed in v5.

--srini
> 
>>   	if (prtd->state) {
>>   		/* clear the previous setup if any  */
>>   		q6apm_graph_stop(prtd->graph);
> 
> Johan

