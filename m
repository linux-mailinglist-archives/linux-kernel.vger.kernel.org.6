Return-Path: <linux-kernel+bounces-229280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 41894916DC4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 18:08:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB691B2760F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 16:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 778EA171E5F;
	Tue, 25 Jun 2024 16:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZneuiuVh"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 219C117082D
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 16:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719331666; cv=none; b=nqQeS/fk1KgJuY7j+aNp/AmIr8iMSneyA22pe5AklBi9v18xH+Nrx+MMt1T68G7pAxfrNAGGMqO4XXzFy31en3WCS5L1PuxX940cMZn+mxyTcwSHa4UH8h5VrVZjcBikBwKoCbDP9+AyP4jwxiPsflRujxyM4bTdAyOp4qKxf6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719331666; c=relaxed/simple;
	bh=1qbtk3OuDsg5JykbAutMiYplR43VIqHxiBteHho3YMo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=j/lq2DwNB5jRmnwBJMQrpEs21cSw1MSrSBr1Mlryoj8kBUwKs7UlLyMxfStoy01m6rhJNTCobLqZD1FwIiwsp7rSxVd8HXSVWWZ7M3V4uv4b5hJ6z/9+/iMbNqTVtK7lOEsZvetxk9yLikZ4eVgfYiEfyzsY4TXS+g30Z3ENER8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZneuiuVh; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42108856c33so40136925e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 09:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719331663; x=1719936463; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FSwASthEsdX2DteIZwJkoH24oLk9aUfOcBU7wEUFdws=;
        b=ZneuiuVhKGDwXXgwxXWWQQgY4qjniYEkHeYo/aKmlN70D5gwP9PJZlPs+ZUTZjURzZ
         ba5dmdbleR+fcksMUCAuuvg8808cXupJVi/SeFWO9DJIaSuLg1B4CPn+QI7oabKnEx/J
         5PCYjGshsWrL4ZkPjN+IMJYjbUgyktiVtItB11uqpc9qUq/z9yaY2tdkLsawuB5/SCi9
         t7F1PV/75p3KuxitVHXqpmdp22t3TpYH/fGljo/zmjeaaRfhsj0FYoqfOIl1xRTgsB7k
         JGe7cL/J+4cEFdb96D9em1bixo9DWz8YL7MEO1P3wgZH2B0lxLekvOR5evFpuaEHOb+T
         v/NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719331663; x=1719936463;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FSwASthEsdX2DteIZwJkoH24oLk9aUfOcBU7wEUFdws=;
        b=k5r1ZkUopkBbwvOZrLKSowVEcA/cUcc2xQidmOd7lEbhZRb2kygUVeIhiFoZFJccRF
         TimXHO4xJ5itvogx9M6DMZv+WAw0pyqrQ3pa9GxCdDn6eNGaR/KWr6iPEkiy+Dn0xSLK
         KJFlOZznSmqsFizinKsp+LLQYP+IE1TUTaWMVuF8+rejZ7FY7wlX7Fsn3jlRUMt/vbXP
         p/WmrkrR7Zf+wpkzA0zFScuyHyZkTNrYUd410GEWnLZU2pdn20EyruHdlwJZboUFcMVB
         YPteYWEk4ZELbw6EqSClEH+GY/UXi5H85ZAPIwCqc4E5xzeALTJ/Rf/eHoig9iabjw64
         U0Vg==
X-Forwarded-Encrypted: i=1; AJvYcCVs9ZCOYkDyIcse5bRNReqOGgYlrxo3q6Xob0qlBE7sGHCSRazSvpdb0x74A7en+XXzxecvuDmmAsC/rdLay0vP/04mTwwLC6lY/OJg
X-Gm-Message-State: AOJu0YyWtPpG0mEWus3qDeekbhQ76J/yHhDiqrnsYWrZv3roR0817alc
	4X34pagUsvLUp2Wccvrka3VezwM/AThsJFf+J18xuCipFBzPuzu3NB1D8j7XvkA=
X-Google-Smtp-Source: AGHT+IED6hiE5o69v1WtTL3k7eeJk/2D8bpFnp51OGCzoqszKUCYkFDiXdUwLJ7ZvcRqmEegoDc1WQ==
X-Received: by 2002:a05:600c:4618:b0:424:a401:f012 with SMTP id 5b1f17b1804b1-424a401f0d8mr16656025e9.3.1719331663402;
        Tue, 25 Jun 2024 09:07:43 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-424819224fasm182691185e9.46.2024.06.25.09.07.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jun 2024 09:07:42 -0700 (PDT)
Message-ID: <a2b8296f-66d0-4b9a-ab3f-895f9ef647a4@linaro.org>
Date: Tue, 25 Jun 2024 17:07:41 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: codecs: lpass-rx-macro: add missing handling of
 v2.1 codec
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Banajit Goswami <bgoswami@quicinc.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
 linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240625160614.450506-1-krzysztof.kozlowski@linaro.org>
Content-Language: en-US
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20240625160614.450506-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 25/06/2024 17:06, Krzysztof Kozlowski wrote:
> We have also v2.1 version of the codec (see 'enum lpass_codec_version'),
> so handle it as well in all switch cases.
> 
> Fixes: dbacef05898d ("ASoC: codec: lpass-rx-macro: prepare driver to accomdate new codec versions")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

--srini
>   sound/soc/codecs/lpass-rx-macro.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/sound/soc/codecs/lpass-rx-macro.c b/sound/soc/codecs/lpass-rx-macro.c
> index 00ecc470ba8b..1c3429f004ed 100644
> --- a/sound/soc/codecs/lpass-rx-macro.c
> +++ b/sound/soc/codecs/lpass-rx-macro.c
> @@ -1601,6 +1601,7 @@ static bool rx_is_rw_register(struct device *dev, unsigned int reg)
>   	case LPASS_CODEC_VERSION_1_1:
>   	case LPASS_CODEC_VERSION_1_2:
>   	case LPASS_CODEC_VERSION_2_0:
> +	case LPASS_CODEC_VERSION_2_1:
>   		return rx_pre_2_5_is_rw_register(dev, reg);
>   	case LPASS_CODEC_VERSION_2_5:
>   	case LPASS_CODEC_VERSION_2_6:
> @@ -3639,6 +3640,7 @@ static int rx_macro_component_probe(struct snd_soc_component *component)
>   	case LPASS_CODEC_VERSION_1_1:
>   	case LPASS_CODEC_VERSION_1_2:
>   	case LPASS_CODEC_VERSION_2_0:
> +	case LPASS_CODEC_VERSION_2_1:
>   		controls = rx_macro_def_snd_controls;
>   		num_controls = ARRAY_SIZE(rx_macro_def_snd_controls);
>   		widgets = rx_macro_def_dapm_widgets;
> @@ -3812,6 +3814,7 @@ static int rx_macro_probe(struct platform_device *pdev)
>   	case LPASS_CODEC_VERSION_1_1:
>   	case LPASS_CODEC_VERSION_1_2:
>   	case LPASS_CODEC_VERSION_2_0:
> +	case LPASS_CODEC_VERSION_2_1:
>   		rx->rxn_reg_stride = 0x80;
>   		def_count = ARRAY_SIZE(rx_defaults) + ARRAY_SIZE(rx_pre_2_5_defaults);
>   		reg_defaults = kmalloc_array(def_count, sizeof(struct reg_default), GFP_KERNEL);

