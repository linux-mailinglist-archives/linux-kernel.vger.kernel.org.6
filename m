Return-Path: <linux-kernel+bounces-372958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A36379A4FD6
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 18:29:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D25871C25507
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 16:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97E4F167DB7;
	Sat, 19 Oct 2024 16:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pUZJKrLl"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143B642A97
	for <linux-kernel@vger.kernel.org>; Sat, 19 Oct 2024 16:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729355372; cv=none; b=ggUiIqJE7SaEeA2chOMhlSmafQBNOzSoZYvl9ATf7qziMbpbKmdtU3VS8MzWh+JaJzo7QrycXIMGk+uKlQX4Uy8HmBb+GuwUQ05I5MV1DjSX/lFzoP8KibhgrFWhEGu0lJ1kiLTHO2eNfShkNLpwXRe5OaTz/CX79DtfDWvf3KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729355372; c=relaxed/simple;
	bh=c5F++auZi2YoIj//vELiQ2ypILgrwOetr/NqqDMRDBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AnkK33HRsOpUMA/SQhR1YgoaXNIE53uae6UQGiIrtuiaYEbMZVX/NL+kuOOUDpvnV1NpqDWIbVmd6GD7LOD8EuxpZlr0s2qZh4C0MR2AEpg9wWPg+15dbxL+jiCoJbtN5nVHVw0pBEKGdH3qxjvjtIQyzK6LMPYzO8wAgbHozJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pUZJKrLl; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-539e13375d3so3454081e87.3
        for <linux-kernel@vger.kernel.org>; Sat, 19 Oct 2024 09:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729355368; x=1729960168; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UnhPZOU7UUH1HoSGL559dxSCJP8oqBaVwb2UhbtDqc8=;
        b=pUZJKrLlANNsynn8ORr6bYCIxl28fZnybqBQukZWRqJbqaM5LBZhomt6/qTQbNoIej
         AGxloOTqbTgNhuy2RA6YPMHXILufXTpLr3HndXXteXkdl2b+tT/91QKlYMC9cAmnFI60
         ZmcitkY0PA0cHCgY4lqflrYkw2WqPbo6z5ubWvUZY8mwrr26BDz6dFZ5MCS5+c8qDVMx
         lvbqaOggZztT2BcAeRS72Iwa/3+dE8L3A5Tnev6HNtQXfegjq+gy3tBB1oWW9zAAAGJ8
         kd+DAMySOQNVmn8zN7kiUJYKBKknFfFpQNoIVq+xyXVSxXMsDyceCMBZICdou7Ev4tC2
         ABjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729355368; x=1729960168;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UnhPZOU7UUH1HoSGL559dxSCJP8oqBaVwb2UhbtDqc8=;
        b=eqWSUFE9IJkGlhgfF7FNNRDBAa4mDaEYO+rqxq4c/onADjaS/VEBGBO20cMr5a/UV5
         mvqV0KV/jIINFB/tIdsvvJvQJQDdC6+ksXpHriJIrAxLyiVKqEN8xlF3dLyXlZ3s9D+F
         OT8i7gFWbccjO2P6P3FjZKVTI1mWKSmfecFJa/l+efztQzPMi0jPc9jVm2Yx7RHQyThI
         bBNxrx8LhW4ZRlcPtDKUh53RMtw5StXlpvepUkDCOp6wQJAnmKNW1nHJVLaAoTF5/Y1r
         c55f0y/vNoAbmGTbo660Lt5kfqm0E3S17fJhVEGhAlkluGehnWrRXzs6g+JAAk3oPDDv
         S4iA==
X-Forwarded-Encrypted: i=1; AJvYcCWoLqkCg1NaVMdlOpOSGRy5xprP379z9pLkb25uSRAV8FlZkf/Y8rtLIpfr7fYWnN+2fUmsViSxe1VKotE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGHE//6bAluaFqAckvSvyKUYrjOMxxu0IW7+1GD5Hb0QrgHzL6
	v1jip9sLHmTRqJzCkZ/iq889+XTsLetIqPsREEvRVXxNIMVLzR8ohnVNczltpc0=
X-Google-Smtp-Source: AGHT+IEM0vuztFWZJLrY3x9Ptwp1YKrsO2wSlokW+PM1+qzucLkSShtUc5y5QHzMLT4+vy2o8RAkSg==
X-Received: by 2002:a05:6512:1383:b0:53a:aea:81cc with SMTP id 2adb3069b0e04-53a1550bdaemr3213330e87.57.1729355368053;
        Sat, 19 Oct 2024 09:29:28 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a15211401sm573378e87.249.2024.10.19.09.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Oct 2024 09:29:26 -0700 (PDT)
Date: Sat, 19 Oct 2024 19:29:24 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Jingyi Wang <quic_jingyw@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, quic_tengfan@quicinc.com, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	quic_tingweiz@quicinc.com, quic_aiquny@quicinc.com
Subject: Re: [PATCH v2 2/3] soc: qcom: llcc: Add LLCC configuration for the
 QCS8300 platform
Message-ID: <v73v4qniygxvqgdjcuydgpir2fgxmnltqaxcexoktzesnqfxod@55k43u2gmqqt>
References: <20241010-qcs8300_llcc-v2-0-d4123a241db2@quicinc.com>
 <20241010-qcs8300_llcc-v2-2-d4123a241db2@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241010-qcs8300_llcc-v2-2-d4123a241db2@quicinc.com>

On Thu, Oct 10, 2024 at 06:08:47PM +0800, Jingyi Wang wrote:
> Add LLCC configuration for the QCS8300 platform. There is an errata on
> LB_CNT information on QCS8300 platform, override the value to get the
> right number of banks.
> 
> Signed-off-by: Jingyi Wang <quic_jingyw@quicinc.com>
> ---
>  drivers/soc/qcom/llcc-qcom.c | 72 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 72 insertions(+)
> 
> @@ -3391,6 +3456,12 @@ static int qcom_llcc_probe(struct platform_device *pdev)
>  	num_banks >>= LLCC_LB_CNT_SHIFT;
>  	drv_data->num_banks = num_banks;
>  
> +	/* LB_CNT information is wrong on QCS8300, override the value */
> +	if (of_device_is_compatible(dev->of_node, "qcom,qcs8300-llcc")) {
> +		num_banks = 4;
> +		drv_data->num_banks = 4;
> +	}

Nit: I think it might be better to skip reading LLCC_COMMON_STATUS0
register completely and just set num_banks instead. See [1]

[1] https://lore.kernel.org/linux-arm-msm/20241019-sar2130p-llcc-v1-2-4e09063d04f2@linaro.org/

> +
>  	drv_data->regmaps = devm_kcalloc(dev, num_banks, sizeof(*drv_data->regmaps), GFP_KERNEL);
>  	if (!drv_data->regmaps) {
>  		ret = -ENOMEM;
> @@ -3484,6 +3555,7 @@ static int qcom_llcc_probe(struct platform_device *pdev)
>  }
>  
>  static const struct of_device_id qcom_llcc_of_match[] = {
> +	{ .compatible = "qcom,qcs8300-llcc", .data = &qcs8300_cfgs},
>  	{ .compatible = "qcom,qdu1000-llcc", .data = &qdu1000_cfgs},
>  	{ .compatible = "qcom,sa8775p-llcc", .data = &sa8775p_cfgs },
>  	{ .compatible = "qcom,sc7180-llcc", .data = &sc7180_cfgs },
> 
> -- 
> 2.25.1
> 

-- 
With best wishes
Dmitry

