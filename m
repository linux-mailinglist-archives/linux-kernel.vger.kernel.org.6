Return-Path: <linux-kernel+bounces-264267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DC5393E0E5
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 22:22:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCE29B2169B
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 20:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5257639FD8;
	Sat, 27 Jul 2024 20:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZS/8keje"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9F029413
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 20:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722111740; cv=none; b=WcVwhLnbcKtphGSridcT9OSM7zv9ZHJ6YMG1TxbT/Yrw8Mzk/JD5t9x2Q6+EAkxVtTRPUOVecJCumD7QWgdbMh1BpLI8wuMvCHa+4DOdD6nOiqnH7hRclcczwm92Fr3BEc8Ft4UwIr/JPKDKHn1RQAK1Guoni1pSb7vVh89CHU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722111740; c=relaxed/simple;
	bh=kHGL1U4vzMPjvspLRMbkYBQBI26OdTx3BOt3JS1aT1E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mtyKQwya5FS3+wse2MS+6KYiaZk2WlMtwRxUlTarCZGSwUECOwLaSLR27h5GIWEpyIZruPMzRh6mCNPqOHPL59aHtVtaXKrwozoRdrCgRwdKh4UGSIK6Y1dJWQFqVtydD9F8ILIv/ObOAANxdyVOR+eGUQ7YjDAGNqRfjBUyQuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZS/8keje; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2ef2c56d9dcso28914231fa.2
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 13:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722111737; x=1722716537; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Huc0K8rSvsCtHtQb7ohCUWF9mvI2cqys5jRNGU3Q/E8=;
        b=ZS/8kejeAGjjqXt76f8goBCDm9OrBjV4XlypphiZ/JnPDEdyRbsOYXZmleNmCi3jbw
         gjMm8N4NY+O2HqssvpTccHFAlO0B5mrzxaEtMDi/eV6n0DAf20fbgonBduYuNlVu4CaD
         feMrcwFcNnIhIdeI4AoxdhGyI8IKhlv5WkEkWSlZToabnwbJhPnbvOlYgYxx2oX2DfMf
         k42+IX9hJhWrOPAYi4w57f/RpOwajt+rYTMfl/0FRpy+1MKKgAGVZTbT20Lae0OoUnCY
         iN0X2x0TP3CiZqz/5zhLh4bt9Z7uj33Xt0QyMM1MsPyVtaG81LoFtxzXvhsI9zDRlBmU
         B9cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722111737; x=1722716537;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Huc0K8rSvsCtHtQb7ohCUWF9mvI2cqys5jRNGU3Q/E8=;
        b=obqrh09+SUXFTu45xr6/YES3B4Su01IHKyPwwjwa7P99YPDOP5eZJTtLjP6wdlkKjo
         PNoOgZLZORyxnDXD68n4Z1+VHwP9aF4QdrPpyAJwuUKWFmWSIwRL//g8+tq13ef3KMCQ
         3WjYtsH2aEO0ICGfl+fiL+7kz5iO//edJrF4465KkpBlgJasusoMjKHcN3+PtlFWevkG
         1NsqaM9qCsJ7t+mvt5ZmLPsRcMGxQvYXogsV85hO/ZV4fNWDjhj60GFt0/sJMsuFPwRa
         taLL99TBpgjd6lQAFbu+HuypdEUYAP5cyCYNO7bsdx+jK9u3x4caIg15RqaYvLI58rml
         cegg==
X-Forwarded-Encrypted: i=1; AJvYcCXBM086mK+/liSCWZ08MucUxsHNcn0SKhnRd8lasfqKWd+XFQdIrV0VeaACGopxgnxvUJq14hGmpmTS0ibTPyPeITja7NSOiHpql+ln
X-Gm-Message-State: AOJu0YzeRdo/LWg6OQD3jagy7hhZXZWL6EaFyBH/c4nQQn0zGQ/JP5Bv
	ubj9FqEVHIvFWSI/JcVA/QpVzjgkczkzxcF+EamqJtSqakk545yZXw9Or4uQe8M=
X-Google-Smtp-Source: AGHT+IEAM19ZrUTa03e6rXgthK0w+W59uGj7mGDLlSdELDkmYK6fX4CrolrKItgRARpBhijKL3BlCQ==
X-Received: by 2002:a05:6512:3416:b0:52c:1d8a:9716 with SMTP id 2adb3069b0e04-5309b270b3cmr3069385e87.19.1722111736812;
        Sat, 27 Jul 2024 13:22:16 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52fd5c08e9fsm843335e87.134.2024.07.27.13.22.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jul 2024 13:22:16 -0700 (PDT)
Date: Sat, 27 Jul 2024 23:22:14 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Adam Skladowski <a39.skl@gmail.com>
Cc: phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht, 
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Banajit Goswami <bgoswami@quicinc.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Stephan Gerhold <stephan@gerhold.net>, alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org, 
	linux-sound@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, Vladimir Lypak <vladimir.lypak@gmail.com>
Subject: Re: [PATCH v2 1/4] ASoC: qcom: apq8016_sbc.c: Add Quinary support
Message-ID: <hyjoqu6w4oqv5i4hvuewtgod3ngdkkanzokz5k2uh24gce74jw@ne5ctq7bfzv4>
References: <20240727182031.35069-1-a39.skl@gmail.com>
 <20240727182031.35069-2-a39.skl@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240727182031.35069-2-a39.skl@gmail.com>

On Sat, Jul 27, 2024 at 08:20:24PM GMT, Adam Skladowski wrote:
> From: Vladimir Lypak <vladimir.lypak@gmail.com>
> 
> Add support for configuring Quinary Mi2S interface
> it will be used on MSM8953 and MSM8976 platform.
> 
> Signed-off-by: Vladimir Lypak <vladimir.lypak@gmail.com>
> [Adam: Split from MSM8953 support patch,add msg]
> Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
> ---
>  sound/soc/qcom/apq8016_sbc.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)


[...]

> 
> @@ -320,6 +331,9 @@ static int apq8016_sbc_platform_probe(struct platform_device *pdev)
>  	if (IS_ERR(data->spkr_iomux))
>  		return PTR_ERR(data->spkr_iomux);
>  
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "quin-iomux");
> +	data->quin_iomux = devm_ioremap_resource(&pdev->dev, res);


This will still print an error if there is no quin-iomux. It's better to
call devm_ioremap_resource() only if res is not NULL.

LGTM otherwise

> +
>  	snd_soc_card_set_drvdata(card, data);
>  
>  	add_ops(card);
> -- 
> 2.45.2
> 

-- 
With best wishes
Dmitry

