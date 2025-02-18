Return-Path: <linux-kernel+bounces-519955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BAEB3A3A3F7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 18:20:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E542C188E74C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 17:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24A1D26FA66;
	Tue, 18 Feb 2025 17:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kw/15SdQ"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA8C198E60
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 17:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739899186; cv=none; b=OiTWUMCkkR44iFpJe/9QW5BCD3iufCAX3dPs4GeYVDLWw5jqyFrw5dmh2wqsoRjxGXvLoirMJon0S7Le6kcplai+XRlU3Wu5zWUMuBX1efwHsiZpcXOZBBaxKpVQ7VmgrgXZtqcAJpFsRzOZa57ksjkzEHm7s8bJllD67mfD7vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739899186; c=relaxed/simple;
	bh=tVBHMmEXDmoYxEdlqakaqCFK5BLyyxIxpli4iqdG7BE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QyMSOcyGRE+D0+nYIjZsXSSju9CD3KAW8P0iDMntKEUEn5OoTW10ATyVMou09mnk7rMnE0PexKhXjDIFToNM3ndXsIADk2Sz7dRpTB1qiYTB9nX9DWbeMrhHlUmgoqOTZTNmewli8lS37pW3PaUr4HcKE+b4BhoqZWbmjk5l0T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kw/15SdQ; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-54622940ef7so2402401e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 09:19:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739899183; x=1740503983; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SvAo89UO99HSD3rJiBDkEJnB8KDXy8CyHLH5pSzUYZg=;
        b=kw/15SdQVLEXtivHUemnZ5k++gTuzSIr3baweHHStntx/Bzh51mx0OheSayYJQgrf7
         sEfgHbRTx+36FLf8ydan/OISgHpd8uRMRszaiSS4q1AD6Td87ojg8yIvz0h/Q848YQok
         u2sXY3Rifb3B+lvhY7wD2c+RvjwV2hj1sfiQcD6PSYj+Y7MISqLJ0nySXxFJjAoKQWq1
         Q8EuOdNhp0KYo7Wa5jlClhJ6WVXxeT/bxYbnduL4rmEO3WMgTChGto/iQJoMpdUcNhcm
         GYz+fEJWe7ewF03Z1tB+aIsKQ28yULRy76PGCkQzALOB1yJy/L/dwfjZiPDo4wKPZmuH
         HyPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739899183; x=1740503983;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SvAo89UO99HSD3rJiBDkEJnB8KDXy8CyHLH5pSzUYZg=;
        b=MIv1Rp558Y5862MTLQ36XQeLcXYXOtcgDh1CsHRfvf++ml78lmkGrhcHt72P62n75X
         YFb4OFcGmC3lqb1kifeMyoHXexaqoJF9cMCaco36aCm/+Lt61xoHgfEehilvRwdttma6
         ifuQnOIO+J7M9BV+L1PRjM9+/eMRLbTR/UPQ5YzpziGrS7xpebm65iZkPO54mW7jRmzO
         WaArAP8/JMpk0yxuuKzbqyu52MhOFLZryROpSBJpnRhi5SV6TQK78pcpL69RIibGhlWZ
         g0orcEXvV0gAm5YizYpUv9jSOPlH1Uaz9TWGAck49WoPiC8LadEFwp00CI65dVRxpWOe
         zzIQ==
X-Forwarded-Encrypted: i=1; AJvYcCXumWnkQmCkn+oV7UjbcXREsmhPDFXASn2CSJOpMyqec+f0FIofzSxenaHkh8iX0V7T8B7FudW5onSeAhk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3OJoURrHfEV2E0/iZVCATdkuZ8gNuXhZR7hdelh2fvzRnfg5h
	j4+G4pbvc3UloyIgcGHPnviFxZkh5+gALbvxWjWmvaAOi+WsUP99OklAj8E1qW0=
X-Gm-Gg: ASbGnctdhvvY7Ih8x+JljcuiUs+z0AWF8jeWSDN5yRfSLzroWyIJAQ8Y32PdvYKjpwG
	0RAv19PnuA+AfBDgUSOkLyyx9SNkjh5hSDOaHYd7aIr2VAQ1UoB+cYU2vMqtQmNDkdzU6B6/GyP
	Zy4lgYHuirkzN83Tq6bMrG8ta33DoqPGWWkKnSH2NhGLQVA4vFrP8+1wGXwovy8Z2YsesG3EgXU
	+0D/jeXhlXUctH7of1fblXgjUFOsNkx1Fy22YakfSvd0K+Or34DLTQAJ62sFA8tQo/kyC1INS7x
	3O1LP4WSWU2skuXsc50lx6/MM0KSGBN7JV2zX8ISScGjSzNAWT6k/TH0DrWW59+iSGie0x0=
X-Google-Smtp-Source: AGHT+IF5crmLNVS4OCeQoPADuLPFJDj7zDwrIwNFifP10oHoV98usI+PQuU96Ob1Lx/TamY3yE/fuA==
X-Received: by 2002:a05:6512:3987:b0:545:2fa9:9704 with SMTP id 2adb3069b0e04-5462eee2407mr169982e87.19.1739899182716;
        Tue, 18 Feb 2025 09:19:42 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5453961f67fsm1170353e87.23.2025.02.18.09.19.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 09:19:42 -0800 (PST)
Date: Tue, 18 Feb 2025 19:19:40 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: Jagadeesh Kona <quic_jkona@quicinc.com>, 
	Bjorn Andersson <andersson@kernel.org>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Ajit Pandey <quic_ajipan@quicinc.com>, 
	Imran Shaik <quic_imrashai@quicinc.com>, Taniya Das <quic_tdas@quicinc.com>, 
	Satya Priya Kakitapalli <quic_skakitap@quicinc.com>, linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] clk: qcom: videocc: Add support to attach multiple
 power domains
Message-ID: <huluiiaqmunvmffoqadrhssd3kl2toutqtcw7rzamv3sqdglsf@7lz66x4sj3gv>
References: <20250218-videocc-pll-multi-pd-voting-v1-0-cfe6289ea29b@quicinc.com>
 <20250218-videocc-pll-multi-pd-voting-v1-4-cfe6289ea29b@quicinc.com>
 <eec2869a-fa8f-4aaf-9fc5-e7a8baf0f864@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eec2869a-fa8f-4aaf-9fc5-e7a8baf0f864@linaro.org>

On Tue, Feb 18, 2025 at 03:46:15PM +0000, Bryan O'Donoghue wrote:
> On 18/02/2025 14:26, Jagadeesh Kona wrote:
> > During boot-up, the PLL configuration might be missed even after
> > calling pll_configure() from the clock controller probe. This can
> > happen because the PLL is connected to one or more rails that are
> > turned off, and the current clock controller code cannot enable
> > multiple rails during probe. Consequently, the PLL may be activated
> > with suboptimal settings, causing functional issues.
> > 
> > To properly configure the video PLLs in the probe on SM8450, SM8475,
> > SM8550, and SM8650 platforms, the MXC rail must be ON along with MMCX.
> > Therefore, add support to attach multiple power domains to videocc on
> > these platforms.
> > 
> > Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
> > ---
> >   drivers/clk/qcom/videocc-sm8450.c | 4 ++++
> >   drivers/clk/qcom/videocc-sm8550.c | 4 ++++
> >   2 files changed, 8 insertions(+)
> > 
> > diff --git a/drivers/clk/qcom/videocc-sm8450.c b/drivers/clk/qcom/videocc-sm8450.c
> > index f26c7eccb62e7eb8dbd022e2f01fa496eb570b3f..b50a14547336580de88a741f1d33b126e9daa848 100644
> > --- a/drivers/clk/qcom/videocc-sm8450.c
> > +++ b/drivers/clk/qcom/videocc-sm8450.c
> > @@ -437,6 +437,10 @@ static int video_cc_sm8450_probe(struct platform_device *pdev)
> >   	struct regmap *regmap;
> >   	int ret;
> > +	ret = qcom_cc_attach_pds(&pdev->dev, &video_cc_sm8450_desc);
> > +	if (ret)
> > +		return ret;
> > +
> >   	ret = devm_pm_runtime_enable(&pdev->dev);
> >   	if (ret)
> >   		return ret;
> > diff --git a/drivers/clk/qcom/videocc-sm8550.c b/drivers/clk/qcom/videocc-sm8550.c
> > index 7c25a50cfa970dff55d701cb24bc3aa5924ca12d..d4b223d1392f0721afd1b582ed35d5061294079e 100644
> > --- a/drivers/clk/qcom/videocc-sm8550.c
> > +++ b/drivers/clk/qcom/videocc-sm8550.c
> > @@ -542,6 +542,10 @@ static int video_cc_sm8550_probe(struct platform_device *pdev)
> >   	int ret;
> >   	u32 sleep_clk_offset = 0x8140;
> > +	ret = qcom_cc_attach_pds(&pdev->dev, &video_cc_sm8550_desc);
> > +	if (ret)
> > +		return ret;
> > +
> >   	ret = devm_pm_runtime_enable(&pdev->dev);
> >   	if (ret)
> >   		return ret;
> > 
> 
> What's the difference between doing the attach here or doing it in
> really_probe() ?

I'd second this. If the domains are to be attached before calling any
other functions, move the call to the qcom_cc_map(), so that all drivers
get all domains attached before configuring PLLs instead of manually
calling the function.

> There doesn't seem to be any difference except that we will have an
> additional delay introduced.
> 
> Are you describing a race condition ?
> 
> I don't see _logic_ here to moving the call into the controller's higher
> level probe.
> 
> Can you describe some more ?
> 
> ---
> bod

-- 
With best wishes
Dmitry

