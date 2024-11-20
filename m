Return-Path: <linux-kernel+bounces-415747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1305E9D3AD3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 13:40:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C845A283573
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 12:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B66E19EED7;
	Wed, 20 Nov 2024 12:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NWpIpd0K"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D949319F128
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 12:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732106448; cv=none; b=UngID2NGL+xpvZKTtwJetSLwwWwm1HoSdOwLlykCCvZ79L3RhcfR9vVIKSLr3iIhIeLLXjxfxK25PSFVw3JkX4yP4T6ezb3kGQ6DiiCOADLy9kElAyg50sdc20n5NNnYLMUEQd9jjGrOm+9O079QYGEdRtJVEMwpaBvbB9bmDUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732106448; c=relaxed/simple;
	bh=8yJMwcTHtcgvU7ExIkN68hrctLobhHAvOsB/vCEzUVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JeuMckKns2pQI+dPQoZJnsxvrAygufO9dIHjxGDcmaT3WfhOHP0A2V0ckYdop/bO7d0VxzMd1g2Y+YUBTV3DcuQ96e1qN2++Zr81xwXcK3Y7uSUrrzn5/mNjEXdk2b3oLCHyR0Nll0qG7mdCDI8ByY2r4lQjZbGG5DP17MTJoeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NWpIpd0K; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-53da5a27771so5330986e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 04:40:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732106445; x=1732711245; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=L956lhRe0LlEWkMS5Gwktl85mpkmY8AZuSEqvk9rvN0=;
        b=NWpIpd0Kgn79TwvM2fXv+lT7iiscWgSIdtTIEE3A1FV2ScQW35ELOfzdRkMU+ek2ib
         NgS0TAf9mFymksivorD7weh+mTlTIyL58DHm1I5r7+HJYKGeABqFqyojKyUTxDFVYGg4
         C7a18AAvjEukaXMknc+VO/pj5Ctjbp1H7ATHzRRIyHzpBqFlWqsvap+o8UD3j+QUJsMA
         hAtpHm9Kv4dk02JZXSpEMg8fHtRM8tZ39FnjidF3rGl8Q36A4R3pXE2ytOFX581TKSXC
         8UuKkmJ7ywrfcGFQoLVV6DkZsV8BGdr7jBrZMDJ6lrFI/VTvCS7ZE7fCeXSzovxbxd+I
         OqZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732106445; x=1732711245;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L956lhRe0LlEWkMS5Gwktl85mpkmY8AZuSEqvk9rvN0=;
        b=ObDZP+I3KoUa2os0WaZQvdCH38ZjP49jHTeRSUc36NzwQqaExeos4wJVI4AiaUlVy3
         B2KwuiXimctyUhrEn0EZTu4CYwXn/58Cx4rqIVucdZI+79hvshjIODUNduvgzlgdVBb6
         T/LID0kt+TpJ3Mn65QFM9JFv4oORpBtux7mt4VkFR/Hj+bdzFVUIVx6E1te5/ZaV8XA6
         3hOkwTd1BDl2YT3hQMmM5AxQiOb+Y4LFupZaZ7bCS5uEEM86LC4NVKTb0W2TC6Nyk4a5
         S5ftRq/KAMqQwg+BIkYpmjS6irICaOuJtZ1xUEyCQRwYzcCpZFvNW8IF8cqJr1s91UFp
         Sidg==
X-Forwarded-Encrypted: i=1; AJvYcCVGcK8s4EHYmzx0iByg8ezrtY2ADbVQrPe14kja9w8hqk7OmL/3tIhAgIxhMP4MUPS+wRjuILNN9LJNTCs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHEn3o+CK4oMe80wQGv50a0Tjqws31QFjtlsikPLeeDX3J/HTx
	+G9yBL8nhQU9DBEfsw+gkj/XjM1uZonTf0Zl0xG/UezR9Tz6YyLjynIgEyF2lKg=
X-Google-Smtp-Source: AGHT+IEiqeubZ5zfbphw/m8EC0uSMLGjCvjc5KM5cHWbACD1pJ+S0jBmI33wb2FQ79hEwG5asr5GVw==
X-Received: by 2002:ac2:54ab:0:b0:53d:a283:f290 with SMTP id 2adb3069b0e04-53dc1341c7amr977825e87.31.1732106445050;
        Wed, 20 Nov 2024 04:40:45 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53dbd467255sm618654e87.160.2024.11.20.04.40.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 04:40:44 -0800 (PST)
Date: Wed, 20 Nov 2024 14:40:41 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: andersson@kernel.org, konradybcio@kernel.org, conor@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] soc: qcom: llcc: Update configuration data for
 IPQ5424
Message-ID: <fkpp4ii254ewtmhg2j4nnjarvl7qkvet7i7urr6xhbblcmdb3u@tcbwmfqrnch2>
References: <20241119060754.3350320-1-quic_varada@quicinc.com>
 <20241119060754.3350320-3-quic_varada@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241119060754.3350320-3-quic_varada@quicinc.com>

On Tue, Nov 19, 2024 at 11:37:53AM +0530, Varadarajan Narayanan wrote:
> The 'broadcast' register space is present only in chipsets that
> have multiple instances of LLCC IP. Since IPQ5424 has only one
> instance, both the LLCC and LLCC_BROADCAST points to the same
> register space.
> 
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
> v3: Rebase to ToT
>     Remove 'need_llcc_cfg = true'
> 
> v2: Use 'true/false' instead of '1/0' for boolean variables.
>     Add 'no_broadcast_register' to qcom_llcc_config structure
>     to identify SoC without LLCC_BROADCAST register space instead
>     of using 'num_banks'.
> ---
>  drivers/soc/qcom/llcc-qcom.c | 57 ++++++++++++++++++++++++++++++++++--
>  1 file changed, 55 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/soc/qcom/llcc-qcom.c b/drivers/soc/qcom/llcc-qcom.c
> index 32c3bc887cef..106f2619277a 100644
> --- a/drivers/soc/qcom/llcc-qcom.c
> +++ b/drivers/soc/qcom/llcc-qcom.c
> @@ -142,6 +142,7 @@ struct qcom_llcc_config {
>  	bool skip_llcc_cfg;
>  	bool no_edac;
>  	bool irq_configured;
> +	bool no_broadcast_register;
>  };
>  
>  struct qcom_sct_config {
> @@ -154,6 +155,38 @@ enum llcc_reg_offset {
>  	LLCC_COMMON_STATUS0,
>  };
>  
> +static const struct llcc_slice_config ipq5424_data[] =  {
> +	{
> +		.usecase_id = LLCC_CPUSS,
> +		.slice_id = 1,
> +		.max_cap = 768,
> +		.priority = 1,
> +		.bonus_ways = 0xFFFF,
> +		.retain_on_pc = true,
> +		.activate_on_init = true,
> +		.write_scid_cacheable_en = true,
> +		.stale_en = true,
> +		.stale_cap_en = true,
> +		.alloc_oneway_en = true,
> +		.ovcap_en = true,
> +		.ovcap_prio = true,
> +		.vict_prio = true,
> +	},
> +	{
> +		.usecase_id = LLCC_VIDSC0,
> +		.slice_id = 2,
> +		.max_cap = 256,
> +		.priority = 2,
> +		.fixed_size = true,
> +		.bonus_ways = 0xF000,
> +		.retain_on_pc = true,
> +		.activate_on_init = true,
> +		.write_scid_cacheable_en = true,
> +		.stale_en = true,
> +		.stale_cap_en = true,
> +	},
> +};
> +
>  static const struct llcc_slice_config sa8775p_data[] =  {
>  	{
>  		.usecase_id = LLCC_CPUSS,
> @@ -3185,6 +3218,16 @@ static const struct qcom_llcc_config qdu1000_cfg[] = {
>  	},
>  };
>  
> +static const struct qcom_llcc_config ipq5424_cfg[] = {
> +	{
> +		.sct_data       = ipq5424_data,
> +		.size           = ARRAY_SIZE(ipq5424_data),
> +		.reg_offset     = llcc_v2_1_reg_offset,
> +		.edac_reg_offset = &llcc_v2_1_edac_reg_offset,
> +		.no_broadcast_register = true,
> +	},
> +};
> +
>  static const struct qcom_llcc_config sa8775p_cfg[] = {
>  	{
>  		.sct_data	= sa8775p_data,
> @@ -3360,6 +3403,11 @@ static const struct qcom_sct_config qdu1000_cfgs = {
>  	.num_config	= ARRAY_SIZE(qdu1000_cfg),
>  };
>  
> +static const struct qcom_sct_config ipq5424_cfgs = {
> +	.llcc_config	= ipq5424_cfg,
> +	.num_config	= ARRAY_SIZE(ipq5424_cfg),
> +};
> +
>  static const struct qcom_sct_config sa8775p_cfgs = {
>  	.llcc_config	= sa8775p_cfg,
>  	.num_config	= ARRAY_SIZE(sa8775p_cfg),
> @@ -3957,8 +4005,12 @@ static int qcom_llcc_probe(struct platform_device *pdev)
>  
>  	drv_data->bcast_regmap = qcom_llcc_init_mmio(pdev, i, "llcc_broadcast_base");
>  	if (IS_ERR(drv_data->bcast_regmap)) {
> -		ret = PTR_ERR(drv_data->bcast_regmap);
> -		goto err;
> +		if (cfg->no_broadcast_register) {
> +			drv_data->bcast_regmap = regmap;
> +		} else {
> +			ret = PTR_ERR(drv_data->bcast_regmap);
> +			goto err;
> +		}
>  	}
>  
>  	/* Extract version of the IP */
> @@ -4032,6 +4084,7 @@ static const struct of_device_id qcom_llcc_of_match[] = {
>  	{ .compatible = "qcom,qcs615-llcc", .data = &qcs615_cfgs},
>  	{ .compatible = "qcom,qcs8300-llcc", .data = &qcs8300_cfgs},
>  	{ .compatible = "qcom,qdu1000-llcc", .data = &qdu1000_cfgs},
> +	{ .compatible = "qcom,ipq5424-llcc", .data = &ipq5424_cfgs},

I wonder why is this getting inserted at this point. The list is sorted
and your entry definitely is not in the correct place.

Please review if your addition is breaking sorting order in other places
too.

>  	{ .compatible = "qcom,sa8775p-llcc", .data = &sa8775p_cfgs },
>  	{ .compatible = "qcom,sar1130p-llcc", .data = &sar1130p_cfgs },
>  	{ .compatible = "qcom,sar2130p-llcc", .data = &sar2130p_cfgs },
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

