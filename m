Return-Path: <linux-kernel+bounces-510976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE51DA32456
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 12:09:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 796A11685EF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 11:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E934209F49;
	Wed, 12 Feb 2025 11:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UazEc6Q5"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060B4209F45
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 11:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739358554; cv=none; b=Fe6PbzbUimqlxwGMlonvz3jgpyjcpCdMpJU6uK77wTqi4XOcTvJK/Cw8JDFmt0oZwMk2bSkXgvtc80NdbSnLN7bIIEkOpOS2FNT/kObJDcXdecTEyHrcWTRbrv/WD65oNCT5rfGxF7nWZGFm4+np7VGyy8YWS5yVF/en+RPl4Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739358554; c=relaxed/simple;
	bh=V7cTxoKC4qFDUHpP6eGwhH/5GVuxqzS62ckVRbB6Tqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=awPvNTLVliGm8nq4EKYonmEZNqly4Fb8egTGTNrT3hxEItZNAQnlTZBmMNM5GiOgMrYcycEm9gEpe9qX0vSAUmG7aZHeLKkIFPDS9YcO/OqAQ/CyDLcgEX4UD5jbnAdjbhW7vVrIAYgIMzahi9gd3LOvACK1x9jGs0l7DEuW1Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UazEc6Q5; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-30738a717ffso58753021fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 03:09:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739358551; x=1739963351; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YbssXtG/QA34n1PeVVnkmd3ZznSQoiHIQujbnuL56Is=;
        b=UazEc6Q5Fz1/B1VvE1vyRkAW3PGwoqJiTvlWDOIlVPHsUNiHP5wNSd+3rfWzZtowiN
         f+7gZF6L7FSK+KASK/BVvrjYzwO1sEFaOz/HLWWCEN0y1UlqeTMdGpDC0h0HYaMGdhlC
         45QC49Pn/eR5s4mCCSFAbuRK4zW8dIhS/BtrAPsIJpmgzvcTl/GozMbfDMzRWF/j4cUg
         SdneeBaCzdDhwec3Cz5ALiM8PpQYVCKPJo013TdPy/HRhdcIkkw5mgjpBWIZu+wbrMXm
         bOhFzrfwJaJQ8IxXBawVqvu/qi2T5DMD6jmQwyPGyhPTa/1nfheFjJCeEZtWCy9n/ZFk
         Yjsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739358551; x=1739963351;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YbssXtG/QA34n1PeVVnkmd3ZznSQoiHIQujbnuL56Is=;
        b=LOzeLi2E/mIsT2ZOS7E7DTdYRCmMD+O09LaDfMG0ZePi4L1HDBoo0OH/Qgb5Q/coGQ
         TRK5V9EDUy1jMtPp1X8jtABmMzHBNkAAExSEwr1rnFcfxi3hA2EQx8S9reX0wA0SxpHQ
         iztUNI8lTHUk3lpacGFFvo3U9N7zrrDhXqS4LMmyumjAUO5hqaw39iHzFMvk9AwgaIZQ
         4wrUe5hK6qwCzl0MNJvnGpDituGH6R2RcZX4x/9dGOmH41WNFHS2qGOzbspvUX7Sn2DE
         jRsAj4ZfCdTpk7vw4gzhfmA/ivAAdqCb2Z2rDpDulRfDU03xAKp+YmZVd68AIaGRpUQq
         HpkA==
X-Forwarded-Encrypted: i=1; AJvYcCXAXh4k8d5oypIR7Y5lP04M41s/b3vL/wrhIBmESVBBueApOGv61KFo45fKA7yBMDhbo3r7xb0eldWVMHc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtRXVkUPPM+aO9ag9OBXAWwvI7I68dFSN7gNaj2ezdKbCT0/Ca
	t8C4YlPGyl41P+0oRAzv7xPuijJzQ6Z3YoZ513yR7/kChyvg4VqIXeBI2iziXQk=
X-Gm-Gg: ASbGncuQvSeUlCmg0huppWJGKY6a/eh93M1dcZyh6MjyT1WGX4XOGeg8978c8IYiJjL
	AkgpR5ekFfJ4TuhqDkumX5APWP8D2jEBCetnJIMrVDLIhhSGZqm3jswGyJqz63b06K8IDypJ1HI
	6Ost1tXgrWgaUDkFKAyi9ztf3t5DhJSWiqjP4zafEUFEh3Dt0fGo1O2x7mIucyNq+DnX789nZSH
	cZU7wAZKaQ/LFMRsJunNf/kulc7ldVB1nXJ17tQqoiett6mrHcK7YU3tLOWLV/F1ern9HnBSxDY
	d5tAiYXXEoHT0GZDLcY0chul5UPaawLfEFrvS0bcJSafDn15EO5CqSlgwzCt+buZqWZmvLc=
X-Google-Smtp-Source: AGHT+IG8DOlndM4U9VJ2z0AwAfYopx4atfO3q+HybkdNtfp+U20/vFw4YpnTunKNuceOvd0hxJ7CgQ==
X-Received: by 2002:ac2:4e05:0:b0:545:aaf:13f5 with SMTP id 2adb3069b0e04-545184a3aa5mr849690e87.37.1739358551002;
        Wed, 12 Feb 2025 03:09:11 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5450d49c661sm870125e87.162.2025.02.12.03.09.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 03:09:10 -0800 (PST)
Date: Wed, 12 Feb 2025 13:09:08 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Taniya Das <quic_tdas@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Ajit Pandey <quic_ajipan@quicinc.com>, 
	Imran Shaik <quic_imrashai@quicinc.com>, Jagadeesh Kona <quic_jkona@quicinc.com>, 
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/4] clk: qcom: lpassaudiocc-sc7280: Add support for
 LPASS resets for QCM6490
Message-ID: <exyxni7td5vow2n6jarav5euje6dnbue5f5yxzu6az554dthfe@zn5yd2byvkoj>
References: <20250212-lpass_qcm6490_resets-v3-0-0b1cfb35b38e@quicinc.com>
 <20250212-lpass_qcm6490_resets-v3-2-0b1cfb35b38e@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212-lpass_qcm6490_resets-v3-2-0b1cfb35b38e@quicinc.com>

On Wed, Feb 12, 2025 at 01:52:20PM +0530, Taniya Das wrote:
> On the QCM6490 boards the LPASS firmware controls the complete clock
> controller functionalities. But the LPASS resets are required to be
> controlled from the high level OS. The Audio SW driver should be able to
> assert/deassert the audio resets as required. Thus in clock driver add
> support for the resets.
> 
> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
> ---
>  drivers/clk/qcom/lpassaudiocc-sc7280.c | 23 +++++++++++++++++++----
>  1 file changed, 19 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/clk/qcom/lpassaudiocc-sc7280.c b/drivers/clk/qcom/lpassaudiocc-sc7280.c
> index 45e7264770866f929a3f4663c477330f0bf7aa84..b6439308926371891cc5f9a5e0d4e8393641560d 100644
> --- a/drivers/clk/qcom/lpassaudiocc-sc7280.c
> +++ b/drivers/clk/qcom/lpassaudiocc-sc7280.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /*
>   * Copyright (c) 2021, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2024, Qualcomm Innovation Center, Inc. All rights reserved.
>   */
>  
>  #include <linux/clk-provider.h>
> @@ -713,14 +714,24 @@ static const struct qcom_reset_map lpass_audio_cc_sc7280_resets[] = {
>  	[LPASS_AUDIO_SWR_WSA_CGCR] = { 0xb0, 1 },
>  };
>  
> +static const struct regmap_config lpass_audio_cc_sc7280_reset_regmap_config = {
> +	.name = "lpassaudio_cc_reset",
> +	.reg_bits = 32,
> +	.reg_stride = 4,
> +	.val_bits = 32,
> +	.fast_io = true,
> +	.max_register = 0xc8,
> +};
> +
>  static const struct qcom_cc_desc lpass_audio_cc_reset_sc7280_desc = {
> -	.config = &lpass_audio_cc_sc7280_regmap_config,
> +	.config = &lpass_audio_cc_sc7280_reset_regmap_config,
>  	.resets = lpass_audio_cc_sc7280_resets,
>  	.num_resets = ARRAY_SIZE(lpass_audio_cc_sc7280_resets),
>  };
>  
>  static const struct of_device_id lpass_audio_cc_sc7280_match_table[] = {
> -	{ .compatible = "qcom,sc7280-lpassaudiocc" },
> +	{ .compatible = "qcom,qcm6490-lpassaudiocc", .data = &lpass_audio_cc_reset_sc7280_desc },
> +	{ .compatible = "qcom,sc7280-lpassaudiocc", .data = &lpass_audio_cc_sc7280_desc },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, lpass_audio_cc_sc7280_match_table);
> @@ -752,13 +763,17 @@ static int lpass_audio_cc_sc7280_probe(struct platform_device *pdev)
>  	struct regmap *regmap;
>  	int ret;
>  
> +	desc = device_get_match_data(&pdev->dev);
> +
> +	if (desc->num_resets)
> +		return qcom_cc_probe_by_index(pdev, 1, desc);

Won't this break SC7280 support by causing an early return?

> +
>  	ret = lpass_audio_setup_runtime_pm(pdev);
>  	if (ret)
>  		return ret;
>  
>  	lpass_audio_cc_sc7280_regmap_config.name = "lpassaudio_cc";
>  	lpass_audio_cc_sc7280_regmap_config.max_register = 0x2f000;
> -	desc = &lpass_audio_cc_sc7280_desc;
>  
>  	regmap = qcom_cc_map(pdev, desc);
>  	if (IS_ERR(regmap)) {
> @@ -772,7 +787,7 @@ static int lpass_audio_cc_sc7280_probe(struct platform_device *pdev)
>  	regmap_write(regmap, 0x4, 0x3b);
>  	regmap_write(regmap, 0x8, 0xff05);
>  
> -	ret = qcom_cc_really_probe(&pdev->dev, &lpass_audio_cc_sc7280_desc, regmap);
> +	ret = qcom_cc_really_probe(&pdev->dev, desc, regmap);
>  	if (ret) {
>  		dev_err(&pdev->dev, "Failed to register LPASS AUDIO CC clocks\n");
>  		goto exit;
> 
> -- 
> 2.45.2
> 

-- 
With best wishes
Dmitry

