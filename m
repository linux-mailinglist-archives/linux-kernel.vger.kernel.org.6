Return-Path: <linux-kernel+bounces-434135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 485959E621A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 01:19:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F00CB2827E0
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 00:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EF5D1CFB6;
	Fri,  6 Dec 2024 00:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JwkAAHyX"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6F72F42
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 00:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733444371; cv=none; b=HQyYIGxiHwn6GiVyY9ilLwz6VsKDLTOUEYk3izQBuNA0qc2sbDHM2H2QRbsBAS1yumxms/VTS28CzkvrAiUjiOtI7kZqPZcUCDo++YLxS2e2FR6E5xZ/gp3UPcaRG0u92qqJ6aRKMGOVf8eVLtd8DDVMfi4Hc3SCrHK2IdzIJKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733444371; c=relaxed/simple;
	bh=+o+uO9we61Ogto6tM+61xmVisEVe55gj1oe2gTMe3FY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nTih3IzxtNkiANhXE6GlxC5YMnfMVis6nRGEHsAPjLEoEF81qeR+3BhlF3lY2IuO3h21kxgnzinAAwgJqfl1LvnuQAPRoYbHtvSr5bz+c0IEx1B2y3c2AqEMbN1SsX1yENwlqbZOK4GIrjBEojQFsslki+W/ALsujPXPs2k6EvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JwkAAHyX; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-434a852bb6eso15098905e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 16:19:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733444368; x=1734049168; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V7GuXdIFBw0hSC/RhGqob/K/UPv4WM4UiBAEYTtPbes=;
        b=JwkAAHyXOhoAs+Qfch2GyLcCZDIfWCBf1XZ5x83PEHJFdyYuNzacMLVM3EcXFXv8Vv
         O1p/aQf4PeEYiUeionSOZGGCkxUWjqezqeNvVB6S5p8U42GdHtxmp96Dr8tGxWgF1C94
         heigV9o4rM0xIH+JmjcVvgF1tBqMtxkC6DpX5JwXlIt9+6sdmVH2WUev6B/RPmC/lb52
         vOj6ImH6GirabLJHYqaS7dQLiWfq1ChNSH38wujAU1KkvA6uFDavt96p5zABm52I+Dka
         jjCLwGanOu98TrPF/JNf8zONX9ZfdOYi16rZ+ZUs6rv+X18v88dMU4lvWIkuXZHMvHsx
         BaCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733444368; x=1734049168;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V7GuXdIFBw0hSC/RhGqob/K/UPv4WM4UiBAEYTtPbes=;
        b=kx4NXynMWCt2uyhxboGxZEbyfWbZ9aAuPQ070m7EyS3OTBqz5Je5thlL1Y9IFLmqjV
         OGlURvxe5mTLPmgINIko/Mllv6P4YqkDLNfhPOoOlKnkure/6p3IBCwBehkbz5vOcR11
         HvpXrzAUn1ogQaaaaHARz7P4+bqfzi6n6pSx/Zcugm9FIXAr5hJs67Ea1AyWj/sk1RBo
         7uQqHNo94vI6KNbCaxg05lXNAvtup8lHEra5yvhrv8APBHqlnvI+O9EHHnAxb6odxpbn
         puyT4SxDMixN8gr/l9gzcE08jIJGU1Y6E9LmXZrBI3h7vJQoz3BwiBeT0Ad5THNTKZWz
         razQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdwklrkxKn3Kr0OvPaZmiu+61HzSI+Mp3V3kL4kzxdBG2YdDG4GNbX4LgvzlPK+w5Ev8l2QT3E7zQXmb0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyV7X+DFfXWwcXgkGADWtWqSUSdxkbUszgW6W9Wql8kA70KUThU
	crk/92Bop25hu2nFxswyKGJB0poJOHrbptXsPXOJ+OcpYxLJY5w5hSIJWjGmcvQ=
X-Gm-Gg: ASbGncsCjsbMZTv+v9pk6sjzbAM3lIN8TXhJ/EQMJ5R/Sfj6taf5keJyn2FyOygEc4Z
	pn8hBnehOOOZE6zvUlu/jDhVFIefRq4pgDDLzgi+d3FJ42U1dvIg4mVDlAeW7aIkdIp9Top4767
	8Y418oS8G/0NL5Uofd+6lepB5bn+F4PAx+cp13NywbqxMOMYlbS19dzGgPj+Gxp/uxLiINE8mbc
	9reutmqDHVlQx0IUw/znxvcpwEUbt5BwlZF91IuxJZBfliQXJyn0fXVc+DeJTg=
X-Google-Smtp-Source: AGHT+IEVgR6g8ndVIAMTngaFxCk18nWwxULdTjO+OFxZxjsRo3kL/Wfx6trIPXpCNbJrzoKXXJnMng==
X-Received: by 2002:a05:600c:3ca3:b0:434:a0bf:98ea with SMTP id 5b1f17b1804b1-434ddeb04bemr9813725e9.9.1733444368473;
        Thu, 05 Dec 2024 16:19:28 -0800 (PST)
Received: from [192.168.0.40] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3862a4ae481sm865300f8f.25.2024.12.05.16.19.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2024 16:19:27 -0800 (PST)
Message-ID: <929636b0-0cee-4673-9d1f-5987b19c5958@linaro.org>
Date: Fri, 6 Dec 2024 00:19:26 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/16] media: qcom: camss: Add sm8550 compatible
To: Depeng Shao <quic_depengs@quicinc.com>, rfoss@kernel.org,
 todor.too@gmail.com, bryan.odonoghue@linaro.org, mchehab@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 vladimir.zapolskiy@linaro.org
Cc: quic_eberman@quicinc.com, linux-media@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel@quicinc.com
References: <20241205155538.250743-1-quic_depengs@quicinc.com>
 <20241205155538.250743-14-quic_depengs@quicinc.com>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20241205155538.250743-14-quic_depengs@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05/12/2024 15:55, Depeng Shao wrote:
> Add CAMSS_8550 enum, sm8550 compatible and sm8550 camss drvier private
> data, the private data just include some basic information now, later
> changes will enumerate with csiphy, csid and vfe resources.
> 
> Signed-off-by: Depeng Shao <quic_depengs@quicinc.com>
> ---
>   drivers/media/platform/qcom/camss/camss.c | 32 +++++++++++++++++++++++
>   drivers/media/platform/qcom/camss/camss.h |  1 +
>   2 files changed, 33 insertions(+)
> 
> diff --git a/drivers/media/platform/qcom/camss/camss.c b/drivers/media/platform/qcom/camss/camss.c
> index e24084ff88de..2f7697540578 100644
> --- a/drivers/media/platform/qcom/camss/camss.c
> +++ b/drivers/media/platform/qcom/camss/camss.c
> @@ -1634,6 +1634,29 @@ static const struct resources_icc icc_res_sc8280xp[] = {
>   	},
>   };
>   
> +static const struct resources_icc icc_res_sm8550[] = {
> +	{
> +		.name = "ahb",
> +		.icc_bw_tbl.avg = 2097152,
> +		.icc_bw_tbl.peak = 2097152,
> +	},
> +	{
> +		.name = "hf_0_mnoc",
> +		.icc_bw_tbl.avg = 2097152,
> +		.icc_bw_tbl.peak = 2097152,
> +	},
> +	{
> +		.name = "icp_mnoc",
> +		.icc_bw_tbl.avg = 2097152,
> +		.icc_bw_tbl.peak = 2097152,
> +	},
> +	{
> +		.name = "sf_0_mnoc",
> +		.icc_bw_tbl.avg = 2097152,
> +		.icc_bw_tbl.peak = 2097152,
> +	},
> +};
> +
>   /*
>    * camss_add_clock_margin - Add margin to clock frequency rate
>    * @rate: Clock frequency rate
> @@ -2644,6 +2667,14 @@ static const struct camss_resources sc8280xp_resources = {
>   	.link_entities = camss_link_entities
>   };
>   
> +static const struct camss_resources sm8550_resources = {
> +	.version = CAMSS_8550,
> +	.pd_name = "top",
> +	.icc_res = icc_res_sm8550,
> +	.icc_path_num = ARRAY_SIZE(icc_res_sm8550),
> +	.link_entities = camss_link_entities
> +};
> +
>   static const struct of_device_id camss_dt_match[] = {
>   	{ .compatible = "qcom,msm8916-camss", .data = &msm8916_resources },
>   	{ .compatible = "qcom,msm8953-camss", .data = &msm8953_resources },
> @@ -2652,6 +2683,7 @@ static const struct of_device_id camss_dt_match[] = {
>   	{ .compatible = "qcom,sdm845-camss", .data = &sdm845_resources },
>   	{ .compatible = "qcom,sm8250-camss", .data = &sm8250_resources },
>   	{ .compatible = "qcom,sc8280xp-camss", .data = &sc8280xp_resources },
> +	{ .compatible = "qcom,sm8550-camss", .data = &sm8550_resources },
>   	{ }
>   };
>   
> diff --git a/drivers/media/platform/qcom/camss/camss.h b/drivers/media/platform/qcom/camss/camss.h
> index 6dceff8ce319..cf6672baea1c 100644
> --- a/drivers/media/platform/qcom/camss/camss.h
> +++ b/drivers/media/platform/qcom/camss/camss.h
> @@ -84,6 +84,7 @@ enum camss_version {
>   	CAMSS_845,
>   	CAMSS_8250,
>   	CAMSS_8280XP,
> +	CAMSS_8550,
>   };
>   
>   enum icc_count {

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

