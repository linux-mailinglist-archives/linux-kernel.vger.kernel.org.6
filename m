Return-Path: <linux-kernel+bounces-424447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE8DD9DB47E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 10:03:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA76B164435
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 09:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56D1B14C5BF;
	Thu, 28 Nov 2024 09:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WpHlPe5m"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F3652F88
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 09:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732784574; cv=none; b=qUSqWYKXN+gktEy4A62xYg8CAbo2Y58gPa18E+ryoCpoGTaMB3wDQ8lzrHmCvxt8fMg+G93WhqHMQP9PLlQQ2UbWz74sLfFF3mSjYV+yl7diehX6KtFeCVJPIglEj8ll2wn3P5p/UYz1i+qglx3zokt0T0/3O3hbiRiKpm7uc0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732784574; c=relaxed/simple;
	bh=tgBIfB8SxWwQp8+zMp6ASTsC0WZ3pIoK7QGA2cAXRcM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KaEitAfpR6eoVFtTMz+p+zor8pGf2W4/7OH2WpO1I8T0psvKxSbwcGEEzXS4/x9F7uBTkaRBquTGjkP2Ob/lNiOs/pviHxmvSY31nk66zKJjZ3SqCzjwEyyd/W/QCI/3pil8e14jZwFms0Ym6JDOjUP06+C8wSFYTpvtq32Ng4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WpHlPe5m; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2ffc1009a9fso268261fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 01:02:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732784571; x=1733389371; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H8Tx6Iiuy8eVN6hHJzNzsfvX/A9uglxUHEhu2KC59CI=;
        b=WpHlPe5mIaqyo91Q1YDai1FDoKt2Za/HqMbW33on098F4W901FjG0CjDK2ux0vQ8GR
         Hhu3StF1iRv2gqBnFM5tODGOg84GvZzTBPK1xu2zU+eYhnYtrNBtXMbH1S3dewbKN6Ri
         qMkuEKiKBbPdZNVkU9UIvj+x0cV2OqNmYAGUlaYeOQt6ms2sfMVAiawvCiqVv0eCgwV2
         0sueyfKhzv+ajnNGvQJd+g0WAVlaQQ3kh14uCsuBEyLv+F9YgDWDntoLpTmbFujyvtz9
         2QXg+uNc4gEJRZZNBSj/AwonwGHV3we4klpv1sW/HSbGiK7WapSSs2nW/Sre9+s62E0K
         lpIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732784571; x=1733389371;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H8Tx6Iiuy8eVN6hHJzNzsfvX/A9uglxUHEhu2KC59CI=;
        b=kYh7CvtdCAZUNw3O6IAztEgnvaCXGnqyCF6cMZp8zPuDGaX01fH7MA736p50ZvRjYw
         47M+RNVyxFUdXoTmkxyYgOf6Qbxk0PfucVaS8n3Eb3jEhfIIoXbTBdTqnjgG9Xt2qmxe
         b2tjK6OeLUbDRWilUXZ1OJtCDuXCMnlYEA6basXt+K2DTMR6duWWPuJQI+5/sSWE2z2c
         XWYDu+vg4MDf+NsPHljjmL5Ie0hXwPGU/aUE57Br+1Cmd3iHZONVR4U06gP15eEz65il
         tktwm9koQb2BoqltmcBqmAMQ2de9xXzIZoyd2afvjEyZvb1lIfEhmZFQV+j7w1t7TUwO
         l4dw==
X-Forwarded-Encrypted: i=1; AJvYcCUPQx6yeVHf3ZvHtGZybY0foqFVL6+HU0BspIxmIXEAwTC2PFiwnM1pIUSkX/9TRrwK1ZUMTm5mpg8DW7o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCydk25/E2aCuz2cAcH1HT6HOqgpIFM/8zCup0jFV0AWdE+tBm
	rSE93dyA5FRlXdu9AG8XejDyFuBQWUgvSCn+DgpC2i7gRTpjcY9f6gDEJV+uzvM=
X-Gm-Gg: ASbGnctKlvHIqlZCDcUl6RmVjjoSt3FoX2a0BJN4RBjUvjMLG1QEp7dV56VxKZjVLNB
	Am3psxBLvO+S6B3Qa8e3PmWkltkUdAbOCcVErJwEqwvjulP1HFdr9Imompc5w3awn2VROpqzzjB
	e/4+JOSpCRJKJSN5n713qaOhGSJVotEmriPoCnxH6Wa+LqWul2mluQG4zBnN7dCDiPiDAabbyOi
	YHF2FWtoAny32m9cmggddDOk4a4gHEx0m6SslcaDy6QHUP953mvk8rtA3cFuKZ+JbXbafrBVrKO
	Ca2OuTj5Y057Qgr4F6kHJF0AKGBx
X-Google-Smtp-Source: AGHT+IHFCYv/L+GfgztX9o167DNb3MQyZOqjXulx2fah3yuoiM9+QVfRTsflijOJMqAsVCMCc9ktCA==
X-Received: by 2002:a2e:a98f:0:b0:2ff:9449:fe02 with SMTP id 38308e7fff4ca-2ffd5e9a69cmr7842171fa.0.1732784570235;
        Thu, 28 Nov 2024 01:02:50 -0800 (PST)
Received: from [192.168.1.4] (88-112-131-206.elisa-laajakaista.fi. [88.112.131.206])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ffdfc74f94sm1348201fa.83.2024.11.28.01.02.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Nov 2024 01:02:48 -0800 (PST)
Message-ID: <ad906baa-a93f-42c4-bbe5-968fa939c653@linaro.org>
Date: Thu, 28 Nov 2024 11:02:46 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] media: venus: Add support for static video
 encoder/decoder declarations
Content-Language: en-US
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
 Vikash Garodia <quic_vgarodia@quicinc.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: quic_renjiang@quicinc.com, quic_vnagar@quicinc.com,
 quic_dikshita@quicinc.com, konradybcio@kernel.org,
 linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Stanimir Varbanov <stanimir.varbanov@linaro.org>, devicetree@vger.kernel.org
References: <20241127-media-staging-24-11-25-rb3-hw-compat-string-v2-0-c010fd45f7ff@linaro.org>
 <20241127-media-staging-24-11-25-rb3-hw-compat-string-v2-1-c010fd45f7ff@linaro.org>
From: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
In-Reply-To: <20241127-media-staging-24-11-25-rb3-hw-compat-string-v2-1-c010fd45f7ff@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/27/24 13:44, Bryan O'Donoghue wrote:
> Add resource structure data and probe() logic to support static
> declarations of encoder and decoder.
> 
> Right now we rely on video encoder/decoder selection happening in the dtb
> but, this goes against the remit of device tree which is supposed to
> describe hardware, not select functional logic in Linux drivers.
> 
> Provide two strings in the venus resource structure enc_nodename and
> dec_nodename.
> 
> When set the venus driver will create an OF entry in-memory consistent
> with:
> 
> dec_nodename {
>      compat = "video-decoder";
> };
> 
> and/or
> 
> enc_nodename {
>      compat = "video-encoder";
> };
> 
> This will allow us to reuse the existing driver scheme of relying on compat
> names maintaining compatibility with old dtb files.
> 
> dec_nodename can be "video-decoder" or "video0"
> enc_nodename can be "video-encoder" or "video1"
> 
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> ---
>   drivers/media/platform/qcom/venus/core.c | 56 ++++++++++++++++++++++++++++++++
>   drivers/media/platform/qcom/venus/core.h |  2 ++
>   2 files changed, 58 insertions(+)
> 
> diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
> index 4e26b18790537885a77d66c1917a4e7a146eaf57..17506d547a6172b89acb77879337750c22f993cf 100644
> --- a/drivers/media/platform/qcom/venus/core.c
> +++ b/drivers/media/platform/qcom/venus/core.c
> @@ -286,6 +286,36 @@ static irqreturn_t venus_isr_thread(int irq, void *dev_id)
>   	return ret;
>   }
>   
> +static int venus_add_video_core(struct device *dev, struct of_changeset *ocs,
> +				const char *node_name, const char *compat)
> +{
> +	struct device_node *np, *enp;
> +	int ret;
> +
> +	if (!node_name)
> +		return 0;
> +
> +	enp = of_find_node_by_name(dev->of_node, node_name);
> +	if (enp) {
> +		of_node_put(enp);
> +		return 0;
> +	}
> +
> +	np = of_changeset_create_node(ocs, dev->of_node, node_name);
> +	if (!np) {
> +		dev_err(dev, "Unable to create new node\n");
> +		return -ENODEV;

Leaked reference to np.

> +	}
> +
> +	ret = of_changeset_add_prop_string(ocs, np, "compatible", compat);
> +	if (ret)
> +		dev_err(dev, "unable to add %s\n", compat);
> +
> +	of_node_put(np);
> +
> +	return ret;
> +}
> +
>   static int venus_probe(struct platform_device *pdev)
>   {
>   	struct device *dev = &pdev->dev;
> @@ -365,6 +395,32 @@ static int venus_probe(struct platform_device *pdev)
>   	if (ret < 0)
>   		goto err_runtime_disable;
>   
> +	if (core->res->dec_nodename || core->res->enc_nodename) {
> +		struct of_changeset *ocs;
> +
> +		ocs = devm_kmalloc(dev, sizeof(*ocs), GFP_KERNEL);
> +		if (!ocs) {
> +			ret = -ENOMEM;
> +			goto err_runtime_disable;
> +		}
> +
> +		of_changeset_init(ocs);
> +
> +		ret = venus_add_video_core(dev, ocs, core->res->dec_nodename, "venus-decoder");
> +		if (ret)
> +			goto err_runtime_disable;
> +
> +		ret = venus_add_video_core(dev, ocs, core->res->enc_nodename, "venus-encoder");
> +		if (ret)
> +			goto err_runtime_disable;
> +
> +		ret = of_changeset_apply(ocs);
> +		if (ret) {
> +			dev_err(dev, "applying changeset fail ret %d\n", ret);
> +			goto err_runtime_disable;
> +		}
> +	}
> +
>   	ret = of_platform_populate(dev->of_node, NULL, NULL, dev);
>   	if (ret)
>   		goto err_runtime_disable;
> diff --git a/drivers/media/platform/qcom/venus/core.h b/drivers/media/platform/qcom/venus/core.h
> index 27784fd7082c321222b23ca4b2902a04c49e19ca..4ce98a3ef186823a57ac40e2e8e42b08fafed575 100644
> --- a/drivers/media/platform/qcom/venus/core.h
> +++ b/drivers/media/platform/qcom/venus/core.h
> @@ -90,6 +90,8 @@ struct venus_resources {
>   	u32 cp_nonpixel_start;
>   	u32 cp_nonpixel_size;
>   	const char *fwname;
> +	const char *enc_nodename;
> +	const char *dec_nodename;
>   };
>   
>   enum venus_fmt {
> 

--
Best wishes,
Vladimir

