Return-Path: <linux-kernel+bounces-396292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 102699BCB02
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 11:51:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FAE71C223D7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 10:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FA981D414B;
	Tue,  5 Nov 2024 10:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ikfewV4C"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9AAB1D31B5
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 10:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730803889; cv=none; b=Uz3KmZHNzgLev7nEtBqI8rTj/MMr9Drwnps+pVe5OnTxbDNhqPbFwtcwryA9TJu9lIwUr4DN8MRAfI3PU3qdT2R0CvHiJHOu2JJ+zCarqTClL1DQAWVtseRj3m4qpKYmgzTRlbxBluo8w52yT3Rcf4jAzIMsLLlqjtCLswt4iRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730803889; c=relaxed/simple;
	bh=HD+BgOOVBl5mx7chCMOpk4RtL2B+f8ert3pkr1zMpqA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QxGeur5hVIjd7bXciPrZWCum8RExpEey1PEhyS0mYnIfeJBRuYccL8sYyAoF1IZ1ju3BPfZUUAJVDMW6XctSgQ/eeQNHKMGsut34cVllB9JZ75C5mHER1CjW22hkeyw5S0kMIQHuLOyg8D5TWDIKr75f7/ITPLmPDH25+afwwYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ikfewV4C; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4314f38d274so62856445e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 02:51:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730803886; x=1731408686; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8ATNs/B/w+2yp0EYeoeJF01EDXlRzVZxzeXpZEXEEfY=;
        b=ikfewV4COefm9gwaIO0IxX3dbvV2S1d9cgPiGAJMVw2DFMm9voM9DE0lpEL+Me6AYl
         j7akomgGodRuAvryorhtNuFXzdFfAOX4qxEdVl4vxynWy8V4QdZphz5bdDy8JKEoT8Me
         ksWHuPDWGniPKqTT9/l2ekyjoxKwgLalxsLGfdlqAb5zNFwX+VMpVzsi/emgy9Jk+6dJ
         7/zK+xbnfMIRTmSDPaW6sJiI7fDuTfzOUkXecz1UaQIy/JTTWeL9/ejQaG+FzJfUE8bd
         Nfo49EWgcFAb701SbNqiUuTt2iT42xkfRk4Qy7GViIHP1q8Mls5yCRaUUlD3AR6ZPUNt
         2Rig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730803886; x=1731408686;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8ATNs/B/w+2yp0EYeoeJF01EDXlRzVZxzeXpZEXEEfY=;
        b=nhCcuaJKw/K+mEN33WU95TGyTTSj69aO3OyL7f2u4ROB7oqRdmt3rPQ1eUUB/Jinh5
         jjESEWj4dSLwnvtxp25yTz6h4EHdWW6tDlkfvIjwtXpeug9dLLy6AmNXdIo76t3eL+8Q
         xbmUxMoEN96JffSgihz5SEc8o3Tv0Jnv8N7tgFU+YomUHpGBFAjHZAfEUxd3iA6gxy2w
         tN6dCWZJU3MsJejrCPFet9LED9uwQ1F4/zwO6TGwPgnsKJFrdPwnnFGsIhDpkd1oehfL
         vCAFesnFyDtSZ4TriRPDNztyY/dN0Cf39JgSSWb5MjlFDuMzFMq1FJIvqkEF2WERMk8M
         QcvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkPl1077xoAIgEVul546kvIswLQSNZT2uzvhdhEp0I4++z255Qt2YvFeculHpXKwETPczbV6rNDVyhKZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYkFgTOUmTGVGzWH4Leg+FTMMEl/GZsEiDh98+JqrJvkqSeVPC
	JZuA9gtK7lIa5+6+fWyTzkBIfWUanj9JrfTIu44O0qli8mru3OpGTUoyviVGWmA=
X-Google-Smtp-Source: AGHT+IH71ZuNZKuI+PZhGTdJo4OsIY4DbJKX5pqqVUQT1HsIyvod98087dQv/2ssVzIfDzdbe8PZUg==
X-Received: by 2002:a05:600c:1d1e:b0:431:604d:b22 with SMTP id 5b1f17b1804b1-43283255922mr160211525e9.16.1730803884606;
        Tue, 05 Nov 2024 02:51:24 -0800 (PST)
Received: from [192.168.0.40] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c116af7esm15800883f8f.103.2024.11.05.02.51.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Nov 2024 02:51:24 -0800 (PST)
Message-ID: <640fe933-078d-4bf5-815c-7db0eb8b9de4@linaro.org>
Date: Tue, 5 Nov 2024 10:51:22 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] media: venus: hfi_parser: add check to avoid out of
 bound access
To: Vikash Garodia <quic_vgarodia@quicinc.com>,
 Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20241105-venus_oob-v1-0-8d4feedfe2bb@quicinc.com>
 <20241105-venus_oob-v1-1-8d4feedfe2bb@quicinc.com>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20241105-venus_oob-v1-1-8d4feedfe2bb@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05/11/2024 08:54, Vikash Garodia wrote:
> There is a possibility that init_codecs is invoked multiple times during
> manipulated payload from video firmware. In such case, if codecs_count
> can get incremented to value more than MAX_CODEC_NUM, there can be OOB
> access. Keep a check for max accessible memory before accessing it.
> 
> Cc: stable@vger.kernel.org
> Fixes: 1a73374a04e5 ("media: venus: hfi_parser: add common capability parser")
> Signed-off-by: Vikash Garodia <quic_vgarodia@quicinc.com>
> ---
>   drivers/media/platform/qcom/venus/hfi_parser.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/media/platform/qcom/venus/hfi_parser.c b/drivers/media/platform/qcom/venus/hfi_parser.c
> index 3df241dc3a118bcdeb2c28a6ffdb907b644d5653..27d0172294d5154f4839e8cef172f9a619dfa305 100644
> --- a/drivers/media/platform/qcom/venus/hfi_parser.c
> +++ b/drivers/media/platform/qcom/venus/hfi_parser.c
> @@ -23,6 +23,8 @@ static void init_codecs(struct venus_core *core)
>   		return;
>   
>   	for_each_set_bit(bit, &core->dec_codecs, MAX_CODEC_NUM) {
> +		if (core->codecs_count >= MAX_CODEC_NUM)
> +			return;
>   		cap = &caps[core->codecs_count++];
>   		cap->codec = BIT(bit);
>   		cap->domain = VIDC_SESSION_TYPE_DEC;
> @@ -30,6 +32,8 @@ static void init_codecs(struct venus_core *core)
>   	}
>   
>   	for_each_set_bit(bit, &core->enc_codecs, MAX_CODEC_NUM) {
> +		if (core->codecs_count >= MAX_CODEC_NUM)
> +			return;
>   		cap = &caps[core->codecs_count++];
>   		cap->codec = BIT(bit);
>   		cap->domain = VIDC_SESSION_TYPE_ENC;
> 

I don't see how codecs_count could be greater than the control, since 
you increment by one on each loop but >= is fine too I suppose.

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

