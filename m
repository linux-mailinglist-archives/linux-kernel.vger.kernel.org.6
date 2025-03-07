Return-Path: <linux-kernel+bounces-550682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77CBDA562E5
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 09:47:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43F833AAEF8
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 08:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB7A31A2642;
	Fri,  7 Mar 2025 08:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o40S2uN1"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0271A255C
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 08:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741337271; cv=none; b=L+Z9Js4qAbzzzOUC050qZyukz0DqnlIXifJJEpuD+fC7lGlpaO9TNQNtI5D512X6wYQPmYVj1WSowYhN0ehKmXULkl67kgQd8azmsDZMA1t1HytMZhMu7XOJOqj1bbXHQ6i5p508PArmLIw4xCu53H7X7tqeNm2X/+pkidizwGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741337271; c=relaxed/simple;
	bh=1klQmpUuK3tpkUPnhlarREZmlq+0v1VMdGLEMIYqCk0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r4kV9WTCANIwMZcBx8aEVmNOZKxCuwCexeLWR+V8XPr4tMIcPcV0FjEDRShI7Q+iDw2DBNb5G1vHBOksyOCsH5ba+w16ySvddzeMYrzDYhRTaYltBJLnX3757vX/XSq17TnSNptfXzzfVxfMeLP5OtZlVOq39jxJ+5medKKXJ0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=o40S2uN1; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-30b9b1979b9so17779871fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 00:47:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741337268; x=1741942068; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LcV1MZ5e0X4Au7sgZSdAJMfYoBCfZQzOt7NC7B6Xb5o=;
        b=o40S2uN1UD4snsy1yMtLQ9aX0HoTHUsEC+4WNc+zoiie9OSmSC9NVvwhuJedncdKAc
         htJ1Oe9u3okimtRLAv3M6umbLrwvd8BV586IHDtfs3yd+CfCuccOc36nZ19qEnOGHfdM
         4mT+scV9S63ywTmTRcTiKWfuBjKhUIO7BUtgByvTF99Q9QrKzwm3BGaK6EkO4MJmhTOm
         /9AC6AqGW9oHHlpvP9e3lyK0rh9aviATAw5KUpPqsUHZm4Q6cHA9/giF8ySNG0Uju5Vj
         cQ0tHhjvrbjwuk2tICQ53z6FvTa7XKY+f8TLzwamjl79/JW/5i3nfrAzyHI+3hWxWU9z
         FZdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741337268; x=1741942068;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LcV1MZ5e0X4Au7sgZSdAJMfYoBCfZQzOt7NC7B6Xb5o=;
        b=QlWfCLrbpC5xdqFeAODINp5+AxZEBs2+H4BHUSDqobO5VA8xzRpQGoV72blQPuLzI2
         +dFVQR7OoegWI9urOU/lNDIU/Q0ixA6AlBflUqpD0YUAjXV1T9Ce7nUowyL87vMMCcQo
         klnLMTJpdYbazxqFkPbXTc5pyB90iFQn841riYQCHVy/rHo8efTRTJ5rLAHphSFy0T/R
         PiqY0XvZZBRe5vBfj/Inbfu/wHutihqMAR3mfohhRxhm1nv16VeDmAHofhAbnoneuNQg
         Bh4Kwcd0KbpL6mOrWoNqNYgR7IOlsaWBsk+FC7xb9qDYwS3jcUJ34gopR8aUhjofUOWF
         XS0w==
X-Forwarded-Encrypted: i=1; AJvYcCW521wTCVZhTYEUOlfucmtdS8oNCrSzl67ShGdu/zPKRQDchddXGZUdxnOHuCBcvlsP3KiTHw8swlfvCHc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8l2/dsBeox71Ul5G0vgdOW96kmbU264yJjYlTKUuECARgc2m3
	KbBTzjgafECtTA/6iMtoDPmpBPAupcXKPhgCqEbxMPGsTVPDurH4aGViwYMI6qw=
X-Gm-Gg: ASbGncv+ZEu7vqH2u5GTYZISamGfxgLe+BtXgvtd5mXXP8gih+1OuBsd2KqBs/G/Wn2
	002StCADzazvwzRKk3xy/PUkd2vuTPWpT6oNOC5ZseXKndVoRHiGBqfAuo2/4XIsUZzR9ze/APO
	sHirpvf89+3UCLrl9QtBa90LUGIvDb08rLCBxciR75Pv3/dDSXucmn/5qV8BwCMWOEo5IgpfITg
	04w+imNiEwMUXNuqBVbxluszYKV0Exb0j8EaG0nwevQwZGG3Tw2FX6Sixsn0U9TyCDhrEeuYJWY
	CtIchCWIsfoeKfFtzoiAYYG8B6y2j9dnOO/3gy8WpbAiKJCwrLPRM+NKlDRPjpmyeI7JLfd7NCq
	ExXDtAVdiceVkSIXNDk0l4nIu
X-Google-Smtp-Source: AGHT+IEiTwEYJTrTPyGNimhSVQS4rhsKdEBaz+K9T/k8At9auSzopeTRHY7N/xxUYxj35p79+k7uWg==
X-Received: by 2002:a2e:838a:0:b0:306:501:4772 with SMTP id 38308e7fff4ca-30bf4613cd7mr7319681fa.37.1741337267601;
        Fri, 07 Mar 2025 00:47:47 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30be98d0897sm4763021fa.2.2025.03.07.00.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 00:47:46 -0800 (PST)
Date: Fri, 7 Mar 2025 10:47:43 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Jagadeesh Kona <quic_jkona@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Ajit Pandey <quic_ajipan@quicinc.com>, 
	Imran Shaik <quic_imrashai@quicinc.com>, Taniya Das <quic_tdas@quicinc.com>, 
	Satya Priya Kakitapalli <quic_skakitap@quicinc.com>, linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/8] clk: qcom: common: Manage rpm, configure PLLs &
 AON clks in really probe
Message-ID: <vmxwmunmlknwp7elhp5zayoraccunxw5fex2hse2w4nwhuxzu5@atbcrfp2jgdm>
References: <20250306-videocc-pll-multi-pd-voting-v2-0-0cd00612bc0e@quicinc.com>
 <20250306-videocc-pll-multi-pd-voting-v2-3-0cd00612bc0e@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306-videocc-pll-multi-pd-voting-v2-3-0cd00612bc0e@quicinc.com>

On Thu, Mar 06, 2025 at 02:25:35PM +0530, Jagadeesh Kona wrote:
> Add support for runtime power management, PLL configuration and enabling
> critical clocks in qcom_cc_really_probe() to commonize the clock
> controller probe.

Please split this into two commits: one for the runtime PM and another
one for clock configuration, because ...

> 
> The runtime power management is not required for all clock controllers,
> hence handle the rpm based on use_rpm flag in clock controller descriptor.
> Also the power domains need to be kept enabled during pll configuration,
> hence attach all required power domains prior to calling get_sync() on the
> device.
> 
> Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
> ---
>  drivers/clk/qcom/common.c | 45 ++++++++++++++++++++++++++++++++++++---------
>  drivers/clk/qcom/common.h | 16 ++++++++++++++++
>  2 files changed, 52 insertions(+), 9 deletions(-)

[...]

> +
> +	for (i = 0; i < desc->num_plls; i++)
> +		qcom_cc_clk_pll_configure(desc->plls[i], regmap);
> +
> +	for (i = 0 ; i < desc->num_clks_cfg; i++)
> +		regmap_update_bits(regmap, clks_cfg[i].offset,
> +				   clks_cfg[i].mask, clks_cfg[i].mask);
> +

... just calling regmap_update_bits() looks like a step backwards. In
the past several years we got several sensible wrappers and helpers. I
suggest having a callback instead of a fixed 'update bits' table.

>  	reset = &cc->reset;
>  	reset->rcdev.of_node = dev->of_node;
>  	reset->rcdev.ops = &qcom_reset_ops;

The RPM part is fine with me.

-- 
With best wishes
Dmitry

