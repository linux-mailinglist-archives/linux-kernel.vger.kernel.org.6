Return-Path: <linux-kernel+bounces-523472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A720A3D745
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 11:49:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DA0F179642
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 10:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83F811F0E20;
	Thu, 20 Feb 2025 10:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Sc8l3xEe"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88371CF284
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 10:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740048501; cv=none; b=ZGs5PzVLqvy3HWfK0IPbFmoKaYg+p5Nsj77WmxEeQ3IFnVSA+VzkTnQVkyuDojeuq74LHt9Bw9n48nHGXg/NgmlCwFdOkmyXL0GpqSm/IzcbXpQycXgUGiBGDwMPQQCXq3NjOwWvHL+hs4vpZF3g9J7/oTvkX1xRfqgyH/O6mY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740048501; c=relaxed/simple;
	bh=kCgnq2aZIgwAoLAh3DaTnIbVzz+vYu5ZYZe3iLcm/1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AXCDEZjA0kzka2vV/rJzEJJd/2uFJ9uUCk82Pn/db4Q2LrwAhSIme+UfNZpwVcvoboIgpWnsYdqSX8enGdf/CwkISZOXi8lQCABfLJWwgfTuhi6AEcBMZ1fRrj2M2IqSh+Pc5zNd3ABBZtD9Q85PqVRCIlnkQ9LNp0KmCc7WUik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Sc8l3xEe; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-30a440effcfso19198201fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 02:48:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740048498; x=1740653298; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hbYYHFAZWUkRW/1SwgtbCrBI2JA7WBIEkb5Df671u0U=;
        b=Sc8l3xEeAFc0w90Qif4KgpABigj2BaImr7Zulo5CXNFD6KQDh5IBtKacipYjQLh3To
         IzjAWJ6VjAujFoHiKRd4110QDUqMzcXMu7kcHZLo61eIhUqy0N5ZthQ9YeeYfiaL81Y3
         SsjKPbm02ky5irNjeWTnRsWBp1DFlulmLCM+SHGZz2Ar7SqN3EjJ6I4qUnphUoR89WU6
         41yS1VtTPF5/LCsL4LgMTw712yqEf3eeYdqEM5xVm6J7dWY77bOPuolgvhEY6furmUIK
         AhY/YTocK/rLVK1IfAMrmM0C2koMe7xc5P6ue2I/ox2coXVh15r9t31F9ZDkF3l3Ux7H
         lOLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740048498; x=1740653298;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hbYYHFAZWUkRW/1SwgtbCrBI2JA7WBIEkb5Df671u0U=;
        b=wZ03Rujm+mcNgJMj7SNuYHbBM5fBpdTEihHjaTCXl05/MWuxYDpZfzbHODi4M7LuiJ
         y+RjY1yzqkrk8Rel1lFulSKjZEC5TPPxJ32/lt0TW6bw9ANCW/wLR8tfQ1Czjfbhy3be
         xlz4bKD2Og/v1kDpwm/cx8sMEhuME930nb9+tVbbeGcPFDNjJg7huq490YToHfHLXngm
         JmIwHl6qDcHEOsrAGuL4dSH+gGa+2wFZHySz5Rsm0KG480BeVK7u2PMWV4TqkElYosvh
         ujf+SrhAgzUdDUszdfAp6mXhJyEDCyPpg6OPZ+hXcr/A6AiJrpP8QnWf1LFX501ZBPOh
         MfhQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7gkLUV9UNclhXhxuoyTjlPLIo62eeC760b8GVhQvnVBMI6dCajhuVBbiKcnsyWwsSOSGTSog8qqTc5lQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6H6Wcz6kCetpW6BVT3UlKF7XcmCi2hgy5tzYboSRqNdHVq3ou
	EJUcVWNkAoXq5Zs3j8/1iijDpLz6MWs1kMJCp1JNJLC2DnfNhKfecx6r4zOP80lMkz1D7AFmRC2
	a
X-Gm-Gg: ASbGnctgG3/rF8oMa9R9bLFzrH+9JwoFe5qzkBw9XbOoWe128qXsFGbjPzjU61BOVjg
	greZRljrxqnhTYLSA/gfhaZdRL2yL8Tlvo8LEs6c+ftkOBhksiptLjGLQVh6Iwkrniq8b98Hxgs
	+aWveCJqTfDzC9xUvekMJXTgtkLAnrFFO/eoL+uyVHsp50MAYvHzIT+GTm9zKFiuJHik2MU8/lH
	JLb61fd9itDG5UbUdGyWbnsYG++HtFizMWOFB9+mqtA1LtRrzeG6q4q5qadeFaBqX25InSewqhm
	gwWLoKyE2zzQ2ctrBkQr/DPyKuSKNcwwLI9b79Jle5EbUMmIQdjtyzgbIMb8Ax6PvynJvRg=
X-Google-Smtp-Source: AGHT+IEf32t+fvfpq2zChjXcCyN1bej8coEi/ABFZXEMoJ+feZuLjdEeBGW+xMf+X6gWZ1YZdrnd+g==
X-Received: by 2002:a05:651c:e14:b0:308:e956:66e with SMTP id 38308e7fff4ca-30a5040201fmr7799261fa.0.1740048497691;
        Thu, 20 Feb 2025 02:48:17 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3091d025767sm22551711fa.54.2025.02.20.02.48.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 02:48:16 -0800 (PST)
Date: Thu, 20 Feb 2025 12:48:14 +0200
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
Message-ID: <bap2qy5cqhdzphc7qeoqztp65g6jsmwpxkghpgagxpj4qdifts@ogj7nb34rv6f>
References: <20250218-videocc-pll-multi-pd-voting-v1-0-cfe6289ea29b@quicinc.com>
 <20250218-videocc-pll-multi-pd-voting-v1-3-cfe6289ea29b@quicinc.com>
 <2c5rbbpe5muw53oemyq6vhsmhzpzcpn7on4ujl5v7i7s3fdlob@eh37gy5dpfnp>
 <bb4cd14e-a9ea-4c13-9774-cca169dcb8d1@quicinc.com>
 <fvcmc3ibqcwzokvqomntxn2vkgduvbdsx3gd5vkctzwrik7bis@iyjrejmqkpfp>
 <bf217f30-967c-4ffb-a3ee-f47e8ee97ad4@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bf217f30-967c-4ffb-a3ee-f47e8ee97ad4@quicinc.com>

On Thu, Feb 20, 2025 at 12:43:42PM +0530, Jagadeesh Kona wrote:
> 
> 
> On 2/19/2025 5:27 PM, Dmitry Baryshkov wrote:
> > On Wed, Feb 19, 2025 at 05:06:11PM +0530, Jagadeesh Kona wrote:
> >>
> >>
> >> On 2/18/2025 10:48 PM, Dmitry Baryshkov wrote:
> >>> On Tue, Feb 18, 2025 at 07:56:48PM +0530, Jagadeesh Kona wrote:
> >>>> Attach clock power domains in qcom_cc_really_probe() only
> >>>> if the clock controller has not already attached to them.
> >>>
> >>> Squash this to the previous patch and call the new function. No need to
> >>> duplicate the code.
> >>>
> >>
> >> I tried calling the new function here instead of duplicating code, but that
> >> is leading to below warning since the desc passed to qcom_cc_really_probe()
> >> has a const qualifier and hence we cannot update desc->pd_list inside
> >> qcom_cc_really_probe().
> >>
> >> drivers/clk/qcom/common.c:305:33:   WARNING : passing argument 2 of ‘qcom_cc_attach_pds’ discards ‘const’ qualifier from pointer target type [-Wdiscarded-qualifiers]
> > 
> > It sounds like this can be fixed with a one-line patch.
> > 
> 
> Removing const qualifier to qcom_cc_really_probe() will fix this, but that requires changes in
> many other drivers which are currently passing const descriptor to it.

And this points out that the pd_list should not be a part of the
struct qcom_cc_desc. You are not using it in the code, so allocate that
memory on the fly, pass it to devm_pm_domain_attach_list() and then
forget about it.

> 
> But I can squash this to my previous patch by updating my qcom_cc_attach_pds() function
> prototype as below and then calling that new function here
> 
> -int qcom_cc_attach_pds(struct device *dev, struct qcom_cc_desc *desc)
> +int qcom_cc_attach_pds(struct device *dev, struct dev_pm_domain_list *pd_list)
> 
> -               ret = devm_pm_domain_attach_list(dev, NULL, &cc->pd_list);
> -               if (ret < 0 && ret != -EEXIST)
> +               ret = qcom_cc_attach_pds(dev, cc->pd_list);
> +               if (ret)
> 
> Thanks,
> Jagadeesh
> 
> >>
> >> Thanks,
> >> Jagadeesh
> >>
> >>>>
> >>>> Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
> >>>> ---
> >>>>  drivers/clk/qcom/common.c | 9 ++++++---
> >>>>  1 file changed, 6 insertions(+), 3 deletions(-)
> >>>>
> >>>> diff --git a/drivers/clk/qcom/common.c b/drivers/clk/qcom/common.c
> >>>> index ec27f70b24bdec24edd2f6b3df0d766fc1cdcbf0..eb7e2a56d1d135f839fd9bd470ba6231ce775a8c 100644
> >>>> --- a/drivers/clk/qcom/common.c
> >>>> +++ b/drivers/clk/qcom/common.c
> >>>> @@ -300,9 +300,12 @@ int qcom_cc_really_probe(struct device *dev,
> >>>>  	if (!cc)
> >>>>  		return -ENOMEM;
> >>>>  
> >>>> -	ret = devm_pm_domain_attach_list(dev, NULL, &cc->pd_list);
> >>>> -	if (ret < 0 && ret != -EEXIST)
> >>>> -		return ret;
> >>>> +	cc->pd_list = desc->pd_list;
> >>>> +	if (!cc->pd_list) {
> >>>> +		ret = devm_pm_domain_attach_list(dev, NULL, &cc->pd_list);
> >>>> +		if (ret < 0 && ret != -EEXIST)
> >>>> +			return ret;
> >>>> +	}
> >>>>  
> >>>>  	reset = &cc->reset;
> >>>>  	reset->rcdev.of_node = dev->of_node;
> >>>>
> >>>> -- 
> >>>> 2.34.1
> >>>>
> >>>
> > 

-- 
With best wishes
Dmitry

