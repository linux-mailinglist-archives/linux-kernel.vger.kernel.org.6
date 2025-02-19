Return-Path: <linux-kernel+bounces-521456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AAF38A3BD91
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 12:58:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E74316ABCD
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 11:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FF1D1DFE25;
	Wed, 19 Feb 2025 11:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gtzgLa0N"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840EA1DF25D
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 11:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739966263; cv=none; b=m8qVQLNMVTLMBS4DUYX7SJY2BbcKmnM8kDwb2riB9Mel+7LTpgDNFTB5+J9YZa1dDtUjBUD5FAKYN6QjPbWDBeK/MrNnubSoaC44/BcknBMK6aOgtnrCtCZyrSb9crmBz4LAQ5WqUoXOmv8hmLdhiL1E1DNA3+sv6uoheBqzsus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739966263; c=relaxed/simple;
	bh=kRms6J0w0K8ZO7wZUeNbLbD3dLIuggXRMxSjihVx9a0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mjo0cg7pi5tbwrOUMImXCDjVYjumr2zbjlV8UPCm42GuYEY2jgzHJ+h6htuk2J0p5I+wqFL/y0lVuVrgOOVy/1pamLv9jmcxoHpXnGbZsMhrBFTrSsAo8S6aFUUrOBMHnrcHJVa6AaJwqkPVrQEU14dy42KeK4r96qdgFTx5meY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gtzgLa0N; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-543cc81ddebso6887283e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 03:57:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739966260; x=1740571060; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yl/X30LKsnqNL0hLrSqKOQZayaA3Z0KhIiM4VXXv7pg=;
        b=gtzgLa0NkSvgZDwcbm10idn6affYlZGVbxr4QEdcoqfWDS+oO3g2ND4wLVFs1LSy9l
         BL9WdWEyMHrOJ82VxM7nwegCWmZbz6LPoiAirytW1OlbBBpKnpQXSsF+Cy8apfqBZzOT
         kFwWsv+ihNA9wMC32qFHqbMeIie5iMRhW1FULpVmRRFutMwhPHUB8taKDg76RMTDwd29
         kb87rjQWsytbbPtVRId8O3Rt7flv1q+AKwyFXhN8iC4eZaud186PZuLG7fKyKDF5fQQ9
         VY+lh30lv/jswHNND1zCIWoG+0AlLOXWoeYkoi6vFXTnqfBqeQiZaj91b/BWDklKOsRr
         RCAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739966260; x=1740571060;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yl/X30LKsnqNL0hLrSqKOQZayaA3Z0KhIiM4VXXv7pg=;
        b=iSw+k+xZcqsGtwpQ8U5wM8rRkz0RkVeQjGwvXzFVcIncnj9mKSlncfAmkzai2Hxb6g
         neEEJiHoxaD5xSVqNtZ9ZXNpOSzw4RAMZfiXxmnJXjuSv1NL/jn2R/Y3Z1F6bdVgxSL0
         JtHCqPX6ZUe713Pl2ig3Gf39uKbTKC907/1QsPtrEQmwcPrTn/XvZkSAJCEtU6Ojc9zU
         6OK7iIK4cycyNgPGvlEu+KmLX9L0tKs6ezxRuC2wr6k225T51497DZKy0bCkWx/7Lkh8
         pwbcGmK3xA6gSwZY09ca6JBQChEHNBgQdS1Nb5+VWylp3JrEpg2ZqBIdfXb8Q3a6EVaf
         9WsA==
X-Forwarded-Encrypted: i=1; AJvYcCVjqgb6NnRSucKWOqjG544aLqvLWn6hLy5zDeDapxP9vIM7Pk4uQYx6//CAzqRCXocgkD0FCbQ+mLFb03M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxfj6bCBVAdn8pq2oypAd2vVCaG4UozdcZUIxaUzkLifNKhO1A6
	0WCnxGky7Xf43WGyPGhzPd1HblzFdZ9HxWciMhzFvWPtZlnHAo4APJoqLicvEXE=
X-Gm-Gg: ASbGncstoirqf2tuYfjR6u1LuhtSryVohr8bgnSvG3Fuedqe4nyT5skwdlA59QdL6Bh
	UefDKxxlGaNj4iLipG05iXdZ14ETjadpqdzLlRzNTvLd4Qg8iLYBPRVCccafqA1j3S7mxRr+3ko
	gUowhZ/2YfIfpZINR4RTN/Jt6cw7CEcQe8t6JCHG9fuSENXVS1UMI2oOsD3okZx4w9zv32I7Ch0
	o7YKSUMwGSBGnU0zf4INNTubePo7r4xG1TGViYuO64hGrJ3i5LON4ReACT+W8GX7+apyA7ffDNo
	/1bLOAuyVpAOeWCbDX3xC8CxefWtVLVfQ53QBIoFhUkknPhcsuYr/Mhg2N6bsT8EbxSjEck=
X-Google-Smtp-Source: AGHT+IHcT3I49ZcCntfNXaucNk5PZW4mqa0Uohu3g3DGhO2yRKmX5U82+iGSJxkgL6G1fVz2UZDmwg==
X-Received: by 2002:a05:6512:4025:b0:545:2f09:a3f6 with SMTP id 2adb3069b0e04-5452fe2e1b1mr5021313e87.1.1739966259567;
        Wed, 19 Feb 2025 03:57:39 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54527244fd7sm1859640e87.12.2025.02.19.03.57.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 03:57:39 -0800 (PST)
Date: Wed, 19 Feb 2025 13:57:37 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Jagadeesh Kona <quic_jkona@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Ajit Pandey <quic_ajipan@quicinc.com>, 
	Imran Shaik <quic_imrashai@quicinc.com>, Taniya Das <quic_tdas@quicinc.com>, 
	Satya Priya Kakitapalli <quic_skakitap@quicinc.com>, linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] clk: qcom: common: Attach clock power domains
 conditionally
Message-ID: <fvcmc3ibqcwzokvqomntxn2vkgduvbdsx3gd5vkctzwrik7bis@iyjrejmqkpfp>
References: <20250218-videocc-pll-multi-pd-voting-v1-0-cfe6289ea29b@quicinc.com>
 <20250218-videocc-pll-multi-pd-voting-v1-3-cfe6289ea29b@quicinc.com>
 <2c5rbbpe5muw53oemyq6vhsmhzpzcpn7on4ujl5v7i7s3fdlob@eh37gy5dpfnp>
 <bb4cd14e-a9ea-4c13-9774-cca169dcb8d1@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bb4cd14e-a9ea-4c13-9774-cca169dcb8d1@quicinc.com>

On Wed, Feb 19, 2025 at 05:06:11PM +0530, Jagadeesh Kona wrote:
> 
> 
> On 2/18/2025 10:48 PM, Dmitry Baryshkov wrote:
> > On Tue, Feb 18, 2025 at 07:56:48PM +0530, Jagadeesh Kona wrote:
> >> Attach clock power domains in qcom_cc_really_probe() only
> >> if the clock controller has not already attached to them.
> > 
> > Squash this to the previous patch and call the new function. No need to
> > duplicate the code.
> > 
> 
> I tried calling the new function here instead of duplicating code, but that
> is leading to below warning since the desc passed to qcom_cc_really_probe()
> has a const qualifier and hence we cannot update desc->pd_list inside
> qcom_cc_really_probe().
> 
> drivers/clk/qcom/common.c:305:33:   WARNING : passing argument 2 of ‘qcom_cc_attach_pds’ discards ‘const’ qualifier from pointer target type [-Wdiscarded-qualifiers]

It sounds like this can be fixed with a one-line patch.

> 
> Thanks,
> Jagadeesh
> 
> >>
> >> Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
> >> ---
> >>  drivers/clk/qcom/common.c | 9 ++++++---
> >>  1 file changed, 6 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/clk/qcom/common.c b/drivers/clk/qcom/common.c
> >> index ec27f70b24bdec24edd2f6b3df0d766fc1cdcbf0..eb7e2a56d1d135f839fd9bd470ba6231ce775a8c 100644
> >> --- a/drivers/clk/qcom/common.c
> >> +++ b/drivers/clk/qcom/common.c
> >> @@ -300,9 +300,12 @@ int qcom_cc_really_probe(struct device *dev,
> >>  	if (!cc)
> >>  		return -ENOMEM;
> >>  
> >> -	ret = devm_pm_domain_attach_list(dev, NULL, &cc->pd_list);
> >> -	if (ret < 0 && ret != -EEXIST)
> >> -		return ret;
> >> +	cc->pd_list = desc->pd_list;
> >> +	if (!cc->pd_list) {
> >> +		ret = devm_pm_domain_attach_list(dev, NULL, &cc->pd_list);
> >> +		if (ret < 0 && ret != -EEXIST)
> >> +			return ret;
> >> +	}
> >>  
> >>  	reset = &cc->reset;
> >>  	reset->rcdev.of_node = dev->of_node;
> >>
> >> -- 
> >> 2.34.1
> >>
> > 

-- 
With best wishes
Dmitry

