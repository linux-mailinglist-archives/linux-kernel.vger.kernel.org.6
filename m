Return-Path: <linux-kernel+bounces-525841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEBC6A3F621
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 14:36:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C31827A16E5
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 13:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E4F120D4E4;
	Fri, 21 Feb 2025 13:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pfMEaAbR"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3553E2066F4
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 13:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740144962; cv=none; b=m+MJvH1h6WB0/g06daHVciA7FKywiDBjShPwjpmNVr/cuTuqYMeKhv3LuHO3sphc5RQGyOHmjleqLR6Cakg1CmXFFuU46uuF6IT3rPd7yMgyeyEBwGSIhu4XW5vboaDTqnQpRNPONVP2MiWdzR/hv0eUvaw4Arj6zq7Uy9KKsxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740144962; c=relaxed/simple;
	bh=THgkhVyuplqOpdHYAC0kWmjFIeHTr4YYGuvs3oaScrU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lSJqkoX6dbI9cUPmwrRENznRr+xN+N4ZSOtX1lSkVi2IGKFIWeqfGsBG5G6sqqSPz1GMaP27wDeWfycBRSlBkaF/yNFTH7TNKSthplXQxU1B1t7B6FzK5+SNYWMbCxzYxggBB0UO1xjzRXA0c4esI+0NZh+1L8Tp1FLJD/S4QYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pfMEaAbR; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5452efeb87aso2122322e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 05:35:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740144957; x=1740749757; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=anN5YXbb780RfbrD6epAALpoKQXWItZZl79huLI3wIo=;
        b=pfMEaAbRAcD1oKfTnI/5LbjEW7MB/zQQxLzC9o/8YS23qdyO9I89kV5BVs3LKt6aVS
         JtglPdaXfAmGMgTqSLj08wf8X2tMIO5C2jXLl1aBSQbKjejSOXlVOz92rIhCLl9g2ood
         g58hlkYi49nKj8aHUal9b81+ZM6+fwazyBCKQa4ZfgaZPDvag64MYafkoZ9ySirMVGIa
         EgP0HROPzPLeFDzPBEk5PBPe9Qoz4e4KDyp6JU07YBsIU9W5jFDP440rMZrflpgNTu7r
         09czbLkP+O7T29Je8f/KkCwia4UiuB8czZ3ZYKw9hutSGFMLNuLtAAFPr3qArZxuCx8N
         GRiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740144957; x=1740749757;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=anN5YXbb780RfbrD6epAALpoKQXWItZZl79huLI3wIo=;
        b=VClUgDlq1pvnZeXPy7AYAAWIkwhwKclk85X6VX3HflxBml/xVaOoGLuN/mTQkUQLAV
         +KR5aUkFtQN/+GO7dTEXi2L77e97WmzPerXQ/SpwoagAJ77hxhOtF+zwhcnLHaYO9tzQ
         SEfDVnLaYEgBHzp6mZxLaKN+0y+hyfdcG63neQSC+N1ZwPspexsi16cpVhO62h49o/Ox
         ELtSbGpM7WP+mUprbRhbrj8/iiz3d6zZH3b5zgi5cT10j/uWRizoLzlbWtnocFEPI/wt
         YiX/3jxVndCO/5Bgdjr5ZD1+jCuxwjjFUA0xk6HPFPhAsYMNlsroD548YcSWOx16BEd7
         NRxA==
X-Forwarded-Encrypted: i=1; AJvYcCXJM3UCtqtD+O0s3m+4jdk44yMVm23xIVWRN4oNZjmLbuAo4m2GG/sq1HQWPWncnpt57FnxhN1T5JpKzNA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7/qyJ+M1En9TjtP2iQ/Grf476rnjVEIuPU2w3oa9CRKpabLga
	XVhvLLTM6Za5p7zXj/o3ULvUzw7E5StY6o2RomdmTAZWJf3nS6y/Grdk0Nkp+Ww=
X-Gm-Gg: ASbGncsD7W055uA+4561rAc8JhN/usfM0BWPAGmR/3gOeYyPrSuw2GyIomyuRFt4Y/D
	yCt53eWWUS60wwh7OZMUamsWJW3z9N3cg7xPb7AQ8v4upIKAz1JRZjHKh4jaYgm2yfg2O0qUgFW
	5Mf2EJb/DTSkssZdhFmM1KJEYIjMWvW7Pb4lyGwSMv6Ouyt2KiPoMvHxGiOlJkk/LSEuD/HfRlQ
	YzobodFC9E5xKADGQ7QBKP3ztyNaDZmZt1v0pcKm0LxJ6pgjPvtllX/xMoSfGv3vTZkNVZseSjy
	gGZUpucUqtP0A3X1+sJK0LiPRFI50Nsnz4SRUEjIRlVWPhTg2semTq67Jc5fhnCJEikM7M8TlQG
	YDtSBQg==
X-Google-Smtp-Source: AGHT+IFTJUprq/bmwcMITRNSMPlbwS1DQQQg3Yl2GPDaDbW3LcCyQOI+ytFxUMTdaEVsJOOusUpaCg==
X-Received: by 2002:a05:6512:158e:b0:545:2cf5:dc6c with SMTP id 2adb3069b0e04-54838f79e1fmr1089751e87.51.1740144957183;
        Fri, 21 Feb 2025 05:35:57 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54620544eacsm1606350e87.136.2025.02.21.05.35.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 05:35:55 -0800 (PST)
Date: Fri, 21 Feb 2025 15:35:53 +0200
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
Message-ID: <xrjrr34za6kl3icfoseq6jkaooee2mrg6gcojgjxpotzuonsw2@piciahpwgier>
References: <20250218-videocc-pll-multi-pd-voting-v1-0-cfe6289ea29b@quicinc.com>
 <20250218-videocc-pll-multi-pd-voting-v1-3-cfe6289ea29b@quicinc.com>
 <2c5rbbpe5muw53oemyq6vhsmhzpzcpn7on4ujl5v7i7s3fdlob@eh37gy5dpfnp>
 <bb4cd14e-a9ea-4c13-9774-cca169dcb8d1@quicinc.com>
 <fvcmc3ibqcwzokvqomntxn2vkgduvbdsx3gd5vkctzwrik7bis@iyjrejmqkpfp>
 <bf217f30-967c-4ffb-a3ee-f47e8ee97ad4@quicinc.com>
 <bap2qy5cqhdzphc7qeoqztp65g6jsmwpxkghpgagxpj4qdifts@ogj7nb34rv6f>
 <10fc47a3-a58d-4ee8-8f88-fea7d69f38d1@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <10fc47a3-a58d-4ee8-8f88-fea7d69f38d1@quicinc.com>

On Fri, Feb 21, 2025 at 05:12:58PM +0530, Jagadeesh Kona wrote:
> 
> 
> On 2/20/2025 4:18 PM, Dmitry Baryshkov wrote:
> > On Thu, Feb 20, 2025 at 12:43:42PM +0530, Jagadeesh Kona wrote:
> >>
> >>
> >> On 2/19/2025 5:27 PM, Dmitry Baryshkov wrote:
> >>> On Wed, Feb 19, 2025 at 05:06:11PM +0530, Jagadeesh Kona wrote:
> >>>>
> >>>>
> >>>> On 2/18/2025 10:48 PM, Dmitry Baryshkov wrote:
> >>>>> On Tue, Feb 18, 2025 at 07:56:48PM +0530, Jagadeesh Kona wrote:
> >>>>>> Attach clock power domains in qcom_cc_really_probe() only
> >>>>>> if the clock controller has not already attached to them.
> >>>>>
> >>>>> Squash this to the previous patch and call the new function. No need to
> >>>>> duplicate the code.
> >>>>>
> >>>>
> >>>> I tried calling the new function here instead of duplicating code, but that
> >>>> is leading to below warning since the desc passed to qcom_cc_really_probe()
> >>>> has a const qualifier and hence we cannot update desc->pd_list inside
> >>>> qcom_cc_really_probe().
> >>>>
> >>>> drivers/clk/qcom/common.c:305:33:   WARNING : passing argument 2 of ‘qcom_cc_attach_pds’ discards ‘const’ qualifier from pointer target type [-Wdiscarded-qualifiers]
> >>>
> >>> It sounds like this can be fixed with a one-line patch.
> >>>
> >>
> >> Removing const qualifier to qcom_cc_really_probe() will fix this, but that requires changes in
> >> many other drivers which are currently passing const descriptor to it.
> > 
> > And this points out that the pd_list should not be a part of the
> > struct qcom_cc_desc. You are not using it in the code, so allocate that
> > memory on the fly, pass it to devm_pm_domain_attach_list() and then
> > forget about it.
> > 
> 
> Above suggestion looks good, but we need to store the pd_list to pass it to GDSC driver to attach
> the power domains as GDSC parent domains. Instead, we can add a new API wrapper for attaching PDs
> and to map the regmap(qcom_cc_attach_pds_map) and all clock drivers that need multiple power domains
> support can update to use below new API and all new clock drivers can just use the new API.
> 
> The implementation would be something like below
> 
> --- a/drivers/clk/qcom/common.c
> +++ b/drivers/clk/qcom/common.c
> +struct regmap *qcom_cc_attach_pds_map(struct platform_device *pdev, struct qcom_cc_desc *desc)

I think it was established that qcom_cc_desc should be read-only. In the
end it is a description. If you want to pass this data to gdsc probing,
add new argument to qcom_cc_really_probe().

> +{
> +       int ret;
> +
> +       ret = devm_pm_domain_attach_list(&pdev->dev, NULL, &desc->pd_list);
> +       if (ret < 0 && ret != -EEXIST)
> +               return ERR_PTR(ret);
> +
> +       return qcom_cc_map(pdev, desc);
> +}
> +EXPORT_SYMBOL_GPL(qcom_cc_attach_pds_map);
> +
> 
> 
> --- a/drivers/clk/qcom/videocc-sm8550.c
> +++ b/drivers/clk/qcom/videocc-sm8550.c
> @@ -542,6 +542,12 @@ static int video_cc_sm8550_probe(struct platform_device *pdev)
>         int ret;
>         u32 sleep_clk_offset = 0x8140;
> 
> +       regmap = qcom_cc_attach_pds_map(pdev, &video_cc_sm8550_desc);
> +       if (IS_ERR(regmap)) {
> +               pm_runtime_put(&pdev->dev);
> +               return PTR_ERR(regmap);
> +       }
> +
>         ret = devm_pm_runtime_enable(&pdev->dev);
>         if (ret)
>                 return ret;
> @@ -550,12 +556,6 @@ static int video_cc_sm8550_probe(struct platform_device *pdev)
>         if (ret)
>                 return ret;
> 
> -       regmap = qcom_cc_map(pdev, &video_cc_sm8550_desc);
> -       if (IS_ERR(regmap)) {
> -               pm_runtime_put(&pdev->dev);
> -               return PTR_ERR(regmap);
> -       }
> -
> 
> This way also, we are aligning more towards common code and the code will be uniform across all
> clock drivers and this doesn't require separate callback in each individual clock driver.
> 
> Thanks,
> Jagadeesh 
> 
> >>
> >> But I can squash this to my previous patch by updating my qcom_cc_attach_pds() function
> >> prototype as below and then calling that new function here
> >>
> >> -int qcom_cc_attach_pds(struct device *dev, struct qcom_cc_desc *desc)
> >> +int qcom_cc_attach_pds(struct device *dev, struct dev_pm_domain_list *pd_list)
> >>
> >> -               ret = devm_pm_domain_attach_list(dev, NULL, &cc->pd_list);
> >> -               if (ret < 0 && ret != -EEXIST)
> >> +               ret = qcom_cc_attach_pds(dev, cc->pd_list);
> >> +               if (ret)
> >>
> >> Thanks,
> >> Jagadeesh
> >>
> >>>>
> >>>> Thanks,
> >>>> Jagadeesh
> >>>>
> >>>>>>
> >>>>>> Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
> >>>>>> ---
> >>>>>>  drivers/clk/qcom/common.c | 9 ++++++---
> >>>>>>  1 file changed, 6 insertions(+), 3 deletions(-)
> >>>>>>
> >>>>>> diff --git a/drivers/clk/qcom/common.c b/drivers/clk/qcom/common.c
> >>>>>> index ec27f70b24bdec24edd2f6b3df0d766fc1cdcbf0..eb7e2a56d1d135f839fd9bd470ba6231ce775a8c 100644
> >>>>>> --- a/drivers/clk/qcom/common.c
> >>>>>> +++ b/drivers/clk/qcom/common.c
> >>>>>> @@ -300,9 +300,12 @@ int qcom_cc_really_probe(struct device *dev,
> >>>>>>  	if (!cc)
> >>>>>>  		return -ENOMEM;
> >>>>>>  
> >>>>>> -	ret = devm_pm_domain_attach_list(dev, NULL, &cc->pd_list);
> >>>>>> -	if (ret < 0 && ret != -EEXIST)
> >>>>>> -		return ret;
> >>>>>> +	cc->pd_list = desc->pd_list;
> >>>>>> +	if (!cc->pd_list) {
> >>>>>> +		ret = devm_pm_domain_attach_list(dev, NULL, &cc->pd_list);
> >>>>>> +		if (ret < 0 && ret != -EEXIST)
> >>>>>> +			return ret;
> >>>>>> +	}
> >>>>>>  
> >>>>>>  	reset = &cc->reset;
> >>>>>>  	reset->rcdev.of_node = dev->of_node;
> >>>>>>
> >>>>>> -- 
> >>>>>> 2.34.1
> >>>>>>
> >>>>>
> >>>
> > 

-- 
With best wishes
Dmitry

