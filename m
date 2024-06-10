Return-Path: <linux-kernel+bounces-208183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B493902204
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 14:52:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28A591C21E2D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 12:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EF0F80C07;
	Mon, 10 Jun 2024 12:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gBffsuMx"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A3D7FBA8
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 12:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718023940; cv=none; b=cLWih4LD4kTP4K2yEMP2Cvq+3GCScBbbiv0AGl7S2unnP37BoAngVTHDIvRyCW6YIABB/YS2xauT3bn7Zvh6bIIpmq2CHdTcIOL35/Fjf1lwtQPxbufND/YPtdf2o49citfTjxmUdXn1qfwyIOhku4ZIR8S1mlRe15B7sHK5IsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718023940; c=relaxed/simple;
	bh=wfOgF41QMKeLyD4tqdxrMVChnZ0cOUXyJNls4KmAiUI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t/lMlv9vQLB7QWpusE3YpcLhG0V9qt4FNu/KOFMScBmGUfTVKpvPzsYnuqSWKLztqQNFmDamu52wUljcLrBIYZmYlzoAoKpUIhoDzgnI+v0aG2gAsYuX1W6Qn6Aa1JDmpUqXUWHRv7L+y4KTCeIJzHivuFmQB9vOle19XFKx0JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gBffsuMx; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2eabd22d441so70051671fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 05:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718023937; x=1718628737; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=XGLVSb1Y+eBpheC9Z0/MTJkkla59b032G7MA36nJcSI=;
        b=gBffsuMxn948hNZzFbAvg0WqZF7+H9VqHmw2HjsShLzIorjeZ5xBKvqbUIRUvtUton
         qTAud7pAN3DV1c4RvFAtXKi8uWKUsTunEbhfDj8O6vDZvWEtTEAFyZ+GXdFacuMNNUSW
         ve+oMOtIf4X1SDJ2YMtWXZa5zwEssTLCeHskQGuogcULwlWialnmEUCzOHRK8bp2/Kzj
         9SR5Qub5MkfFdUkvKygfR98Gfa7ijLH/Bh7JYFCfG4auOOg+96tWKF7rdnoL1S56xaoJ
         f3NwLJDCXvh3kMlUfYbTe7ZXDHXbm6RwNZ6E3JEz7xWeQS9NVJdd+AFGNnnGGfueenqI
         /RTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718023937; x=1718628737;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XGLVSb1Y+eBpheC9Z0/MTJkkla59b032G7MA36nJcSI=;
        b=mOkhNEj/L7q9OrpZHV2Nu1xKC6EvuwXn8/Pq6ABH4hDo39M+xCz1HxAHIi5CDAawnq
         uNVLMzMvW8yaDxb1/DhxTPwvG53tSxl6shMtb3tDREtCh+HUVa0vmU6gk0bEbxcmj8Ha
         bv71D71l+ohJ+oDuYeX6OnViGVB2r50huhiMoOUq8kj0DQdV/XevJT3DN5smYuZJF3aE
         /FFCDL9iOa5NXWXFaGLhrEmU17qliWbXUet/6L9kdBlrNfKCdBfmwUi8nAelAGFqt84z
         hyOpGXkjnJ5DPXc8lj6Hia8gwbHLbJ8YFsEOEMGUnZZgQ0+FonsYL3Y0FqdxCDJLlGfX
         nFgA==
X-Forwarded-Encrypted: i=1; AJvYcCV5D2njcZm9+0RCH52YHSJlEhLd9WtyJzWOY88MXWPBF04FBYSjK/uAQqzUVZD5CEvDurYKq+7OzxwyHKMMr9MnoMiHQXhTWX/j5Br+
X-Gm-Message-State: AOJu0YzKYn2+l61IicMX+CBGf0eq0dcDjv7gpxvlNhLa256nDWY/jO91
	FYpRUnDK8CugWZAelDqRMjM45+dqACSNAO6NoSftH2YtnnDJmGZTmCo0KkFlma0=
X-Google-Smtp-Source: AGHT+IHZRoQhx2FmfsF5PBu/eRgcGV4h/6ljayTeb7IPjuuUuRC3X5LeK8HnpYoEenriSCcN0dQGaw==
X-Received: by 2002:a2e:8759:0:b0:2eb:de35:5c60 with SMTP id 38308e7fff4ca-2ebde355ea0mr33849961fa.8.1718023937293;
        Mon, 10 Jun 2024 05:52:17 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35f29629231sm743934f8f.67.2024.06.10.05.52.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jun 2024 05:52:16 -0700 (PDT)
Message-ID: <6a9fa18f-c91b-4805-858f-510dbe9a69c5@linaro.org>
Date: Mon, 10 Jun 2024 14:52:14 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] interconnect: qcom: Add MSM8976 interconnect provider
 driver
To: Adam Skladowski <a39.skl@gmail.com>
Cc: phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
 Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Georgi Djakov <djakov@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240609182112.13032-1-a39.skl@gmail.com>
 <20240609182112.13032-3-a39.skl@gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240609182112.13032-3-a39.skl@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09/06/2024 20:20, Adam Skladowski wrote:
> Add driver for interconnect busses found in MSM8976 based platforms.
> The topology consists of four NoCs that are partially controlled
> by a RPM processor.
> 
> Signed-off-by: Adam Skladowski <a39.skl@gmail.com>

> +
> +static const struct qcom_icc_desc msm8976_snoc_mm = {
> +	.type = QCOM_ICC_NOC,
> +	.nodes = msm8976_snoc_mm_nodes,
> +	.num_nodes = ARRAY_SIZE(msm8976_snoc_mm_nodes),
> +	.bus_clk_desc = &bus_2_clk,
> +	.regmap_cfg = &msm8976_snoc_regmap_config,
> +	.qos_offset = 0x7000,
> +	.ab_coeff = 154,
> +};
> +
> +static const struct of_device_id msm8976_noc_of_match[] = {
> +	{ .compatible = "qcom,msm8976-bimc", .data = &msm8976_bimc },
> +	{ .compatible = "qcom,msm8976-pcnoc", .data = &msm8976_pcnoc },
> +	{ .compatible = "qcom,msm8976-snoc", .data = &msm8976_snoc },
> +	{ .compatible = "qcom,msm8976-snoc-mm", .data = &msm8976_snoc_mm },

Please run scripts/checkpatch.pl and fix reported warnings. Then please
run `scripts/checkpatch.pl --strict` and (probably) fix more warnings.
Some warnings can be ignored, especially from --strict run, but the code
here looks like it needs a fix. Feel free to get in touch if the warning
is not clear.

undocumented compatible



Best regards,
Krzysztof


