Return-Path: <linux-kernel+bounces-519770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57EC0A3A1A8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 16:47:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50E1D1895627
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 15:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B68E226B2AC;
	Tue, 18 Feb 2025 15:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jYcnuSx4"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310BB243379
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 15:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739893581; cv=none; b=Wk1NuHVIBDJ8wUVutILnqhlVeGIVTKr10UpuYgc3vzhjGE/czq+N3LmdW5v1cqHqZQjByto0iZwrJnVlVhWT0M0IHXZUBIykZ3Wuz+ld1F8UHF1E8vx9v5P5riHx0nbAVLsT0XgGDE1Qq1x4tx6hp97r9o6/pjCCPtICIoeDM1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739893581; c=relaxed/simple;
	bh=natQqwqvpTM4A8Kit7p6e55YJWa67GNvNJc5yP+W5xA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qpn2mUBezJ3cyac6ox0kwi+gIMUGGBtpmnBAVSUSjpKMh9mxF9f8LouUFAqEs5vt9UgAGiF+GUdLlk6n8vOMzywsbuWYGvCUet/tslP3h9zIIHWl8fRXkgO5VX+Yto3HQTQ7ejFDMs0qVaJy3PCfpbP5y0Xv7flSaPS5AIpF2wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jYcnuSx4; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-38f488f3161so1041473f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 07:46:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739893577; x=1740498377; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WzXPNVEIO0ktgw6x8v211u9KQdCOQpvJxEt97diBw0c=;
        b=jYcnuSx4Fx6djgpcR16YuqSPbz4DCFvhXtqBgl0h8hsIG4zZnZqnuzYvVb0c+0m0oj
         mz/h1WEtYQyrEmsj6zEV5RnzMD9V/33csitKZe7C9zaOBfCDpaVFXEAa2TZji3DOMHsC
         rNxLIVWZOeDCPO5T1qYjLxsqaGKqLo2mAT3Y1aBl6PBt9UHJNp0z/r3TSaIZZzNccaX4
         kF/bBCK5rd6tmPvvKOTe0ne+Vywi4xT4NHPMxSKAnEXl5YSN7G0zTLSmJwixakp2A1eT
         ZO0MB8AnAwkXD6aar0uaIVnl/M7t7aZg33R+GSGueSiHR3BrVcNQkOBc+VQEsB8WYEfm
         5Y6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739893577; x=1740498377;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WzXPNVEIO0ktgw6x8v211u9KQdCOQpvJxEt97diBw0c=;
        b=ktgmwad3A5dMRUtKSA59So31oTerRFtus0zBW+WrLnjjvPPhonCt/y9ngrKFEbRxk3
         3KRp7kyHfmVQWGMg9oEKowRAgToxh5X4T23snTXLGNOBLH3+BDMsQ/QNhu0A/H1hUmwq
         zwQ2dMV1ouVFVJOjlXIA9iGflr20xLGGSLnhPzVdfKfuawY0oMmJYU4i4uoRhM34B9UO
         Lz1Ez2X6mVUfAyc66YxaAqz/JU2CVieigEaa3ndevaFl0/WsM/wGTQtKSG8AuLXJwElk
         p0H9OBkU6RjJldVSrOAvON7Jt6aCQT9cb4eptXBtdy6hxzqMLdANfvuWlUlhakDYAw4Y
         NFxg==
X-Forwarded-Encrypted: i=1; AJvYcCVNLs0tT8KvmaEvnckjMjQ8CAqlkjYTBe/AjY7p9jZaQdwUn6z4Lat/IF/JQd7ZBRlvY/4m5Gk+CBDoy48=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywec1LG/Poq+/tgHDSIvYJiie8d/zIOzK7pXFg808QipccYPmkG
	zgOaPDl35jEsJxeVNxJiXuG81WgCY5hZrJ21SFP5qJQOfXV08EqmPj+K1MB+ivE=
X-Gm-Gg: ASbGnct+H37r86kWCFfWFFDjl2PLRQhCYA9wJqkXHWNxCQoro9/Xs9eohwMFfwHNS55
	YheeaPHZeaannAJZ5kE4WqPg1GfET9W9sH/hwkjHOo/0uAl9LTzXfmy2thtoAD94ZvvD21XtnJ7
	1Rrf8Juoh2/YFK7I4Oz7Leu4EQcWaW1cwcYAzhlR58sN8BINijEuv9mQFLvRdd6Q99At9CpbPjF
	SVnnxRIR7LSx9XbjuaqHAFnsvHqOda6oNkYGI2HE8ZWA1dA6B0fs60DtcRtckaBTv6Vxj5+wWmv
	ba4O3LmWqWe8uq1iEcWlO1Zw9R0CH9V8ss56Pdf8lcSQ6DA1Rh/67loW
X-Google-Smtp-Source: AGHT+IElh5d3sTutspymotVQAtk9NGNlV45zvDe426ZYEjVuuh1cgCu7k0Gx3xBQRtNoHXBzuxtrCQ==
X-Received: by 2002:a5d:5f4d:0:b0:38f:31b5:b33e with SMTP id ffacd0b85a97d-38f33f43726mr15149054f8f.35.1739893577459;
        Tue, 18 Feb 2025 07:46:17 -0800 (PST)
Received: from [192.168.0.35] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259f7fe6sm15067537f8f.86.2025.02.18.07.46.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2025 07:46:17 -0800 (PST)
Message-ID: <eec2869a-fa8f-4aaf-9fc5-e7a8baf0f864@linaro.org>
Date: Tue, 18 Feb 2025 15:46:15 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] clk: qcom: videocc: Add support to attach multiple
 power domains
To: Jagadeesh Kona <quic_jkona@quicinc.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>
Cc: Ajit Pandey <quic_ajipan@quicinc.com>,
 Imran Shaik <quic_imrashai@quicinc.com>, Taniya Das <quic_tdas@quicinc.com>,
 Satya Priya Kakitapalli <quic_skakitap@quicinc.com>,
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250218-videocc-pll-multi-pd-voting-v1-0-cfe6289ea29b@quicinc.com>
 <20250218-videocc-pll-multi-pd-voting-v1-4-cfe6289ea29b@quicinc.com>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20250218-videocc-pll-multi-pd-voting-v1-4-cfe6289ea29b@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18/02/2025 14:26, Jagadeesh Kona wrote:
> During boot-up, the PLL configuration might be missed even after
> calling pll_configure() from the clock controller probe. This can
> happen because the PLL is connected to one or more rails that are
> turned off, and the current clock controller code cannot enable
> multiple rails during probe. Consequently, the PLL may be activated
> with suboptimal settings, causing functional issues.
> 
> To properly configure the video PLLs in the probe on SM8450, SM8475,
> SM8550, and SM8650 platforms, the MXC rail must be ON along with MMCX.
> Therefore, add support to attach multiple power domains to videocc on
> these platforms.
> 
> Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
> ---
>   drivers/clk/qcom/videocc-sm8450.c | 4 ++++
>   drivers/clk/qcom/videocc-sm8550.c | 4 ++++
>   2 files changed, 8 insertions(+)
> 
> diff --git a/drivers/clk/qcom/videocc-sm8450.c b/drivers/clk/qcom/videocc-sm8450.c
> index f26c7eccb62e7eb8dbd022e2f01fa496eb570b3f..b50a14547336580de88a741f1d33b126e9daa848 100644
> --- a/drivers/clk/qcom/videocc-sm8450.c
> +++ b/drivers/clk/qcom/videocc-sm8450.c
> @@ -437,6 +437,10 @@ static int video_cc_sm8450_probe(struct platform_device *pdev)
>   	struct regmap *regmap;
>   	int ret;
>   
> +	ret = qcom_cc_attach_pds(&pdev->dev, &video_cc_sm8450_desc);
> +	if (ret)
> +		return ret;
> +
>   	ret = devm_pm_runtime_enable(&pdev->dev);
>   	if (ret)
>   		return ret;
> diff --git a/drivers/clk/qcom/videocc-sm8550.c b/drivers/clk/qcom/videocc-sm8550.c
> index 7c25a50cfa970dff55d701cb24bc3aa5924ca12d..d4b223d1392f0721afd1b582ed35d5061294079e 100644
> --- a/drivers/clk/qcom/videocc-sm8550.c
> +++ b/drivers/clk/qcom/videocc-sm8550.c
> @@ -542,6 +542,10 @@ static int video_cc_sm8550_probe(struct platform_device *pdev)
>   	int ret;
>   	u32 sleep_clk_offset = 0x8140;
>   
> +	ret = qcom_cc_attach_pds(&pdev->dev, &video_cc_sm8550_desc);
> +	if (ret)
> +		return ret;
> +
>   	ret = devm_pm_runtime_enable(&pdev->dev);
>   	if (ret)
>   		return ret;
> 

What's the difference between doing the attach here or doing it in 
really_probe() ?

There doesn't seem to be any difference except that we will have an 
additional delay introduced.

Are you describing a race condition ?

I don't see _logic_ here to moving the call into the controller's higher 
level probe.

Can you describe some more ?

---
bod

