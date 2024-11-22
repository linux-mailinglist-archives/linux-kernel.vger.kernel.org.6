Return-Path: <linux-kernel+bounces-418128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D47F19D5D90
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 11:59:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E3B5B22453
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 10:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 554721CC8AA;
	Fri, 22 Nov 2024 10:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MKFun1Nf"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0476A175D32
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 10:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732273174; cv=none; b=Iw1Zc8URxyPPLCWYYFGSwEgi6zkI3U3YtqHN7StrnYyIsEfbBhMdnIKEiY3Fia3rL/5rQlTVKtMqg//qHwELsg8+V0M7gDAeUd+7RZQS5pdbbmN9S8o+FbuuLZo4j9hJVI9msjp95o0a9S9wsElPHN8d9FZVNSG69YrKgsLLnYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732273174; c=relaxed/simple;
	bh=nEzgREpChasM34b4gISMzAEe13sm7XvSNaprCZAX5HU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LHUvKy63//u7JFp7IfgKT6SO2i8anTcH9NYJZk4JtG7pqCeUO3PWANvtLD/qxNCSpNy+riTUl8LbAiR3yR7wKBTtI0/U3UPyCUceaIwMIEYNwBcV6041csIC++fO2YEYg74wRvx6aZMOixkiZUQFaJ3ct7N4OUkuRh9LCPfBQUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MKFun1Nf; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2fb599aac99so22940801fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 02:59:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732273171; x=1732877971; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ca1wh/KO+WUPMC9ZKsaxo5mo5dUX/wOwJn5Ib1h7hEA=;
        b=MKFun1NfHOOc1g6GQm9fqqJB0kZlGHqEbo4JbbYuHdu3Ufn3qQ58UYfNiHLqWMTyta
         PkvDgtd/FzsEZa4GnUf9vPqdBkG6s0yo9eiLukStnCcMZyGb+F1EGHRCJ4f1Vl0pqexI
         nL+vIHsN1DMinyjMV6l2SFa9ZMatd5P6ri3tCjVlaJIw2v7LSzeBxNZoMCAQNqeGxA9A
         idYRJ8URIXUvK+8nLn65/3k7+TM+ZFN1fiLwP2s6usDW06FW+XUdodSPsyat/8iqxePU
         efu2xEFQENda2jCkpoxFDVzT9YbtQluuLErbwevQtkIlwR4xuf4194O/76Z9EpbsuKP1
         +GlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732273171; x=1732877971;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ca1wh/KO+WUPMC9ZKsaxo5mo5dUX/wOwJn5Ib1h7hEA=;
        b=hROobzgW5b5FoXe/sdcp9RKtWqXlVf2zuqiOovyTYCceyzwGMr3QU633Q4tpnCudbJ
         Liab4xFGOUrL/gbLFaWeDIMcyGN/oEsLTb6UOI3lTykpOMDRl+bweN+eLd6NEurX3jVk
         IJ3TNxaIT+zZriaiY+qvrSVhEnq00IlN4KcqSpZ7IbnKKrtdW94g4/EUwqL3MMAgSXg1
         AhE0AsPLT0cSNTWhhd7kmyFd9hOIGKnEouMJVH0wFp2Fs23vic4g0C5Aabk+Z/iPCAgL
         akC1eyIW7XzTqci0k6DFnQ/OC1BOt1A4ntukhAbKVkQuPq0fzbxBKvfjeD6+9FHHx697
         Cc0w==
X-Forwarded-Encrypted: i=1; AJvYcCUWpWb9Jtt2GfnrBPsjRo67Ji7qO/mdHUAZnoZbqoaxO+MKjjMhBsx4KmhaYXPfWmQBUpIMvjLM3WwYmkg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdBMiEr2HyYcGe387PNByhw88waDfSz14OdLsmFFXCNNDvxmzy
	ovBepQSQCiOI23Jdfb3B+VF8BeZbV9zHlnZ9PhHCr8B0zcUyPNtVNhcsL478tik=
X-Gm-Gg: ASbGncvX3blf85qAw2I6tTp6AfqPged0GeS78pcHy5YDsOX3mRzG1tJcdU7PnOTGfPY
	ztvkGru0zk4cjAG59GEHTaSVFhD2zYp9xa3pVfiIJBqKi3MSbfwf0qzjht2KvooIZa2xzmcFO7o
	0c1kCCniBaUYuUe0K1sYtuKIstZ2pZWIinGGn/NAr7S5ZXIRdEexkzLfspE9WbygquoW4x9rpri
	etzSA51lX2of/23HKZMi/r3/M5TS3XVCfMj4zHgiGg8s2sUFGU2udKzGsY0loyivHXWdbv+rxvy
	jpC0J0J2RcIlUN0CIEHcJi6e8DHhXg==
X-Google-Smtp-Source: AGHT+IFlyxZP6biD5HPPeqicl8Wlb81WmlgYHkbJwaVmdfCVMRq/sOgXjiyZs52bpQDkMT/aAiHhjQ==
X-Received: by 2002:a05:651c:503:b0:2fb:8774:440c with SMTP id 38308e7fff4ca-2ffa712017emr12224181fa.10.1732273171190;
        Fri, 22 Nov 2024 02:59:31 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ffa53a112dsm2894751fa.119.2024.11.22.02.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 02:59:29 -0800 (PST)
Date: Fri, 22 Nov 2024 12:59:27 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Renjiang Han <quic_renjiang@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Stanimir Varbanov <stanimir.k.varbanov@gmail.com>, Vikash Garodia <quic_vgarodia@quicinc.com>, 
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-media@vger.kernel.org, Taniya Das <quic_tdas@quicinc.com>
Subject: Re: [PATCH 1/2] clk: qcom: videocc: Use HW_CTRL_TRIGGER flag for
 video GDSC's
Message-ID: <zhco37pigrp4fh5alqx4xfxx3xhjitqlgw552vwiijka22bt4u@sl4ngzypwh4x>
References: <20241122-switch_gdsc_mode-v1-0-365f097ecbb0@quicinc.com>
 <20241122-switch_gdsc_mode-v1-1-365f097ecbb0@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241122-switch_gdsc_mode-v1-1-365f097ecbb0@quicinc.com>

On Fri, Nov 22, 2024 at 04:01:45PM +0530, Renjiang Han wrote:
> From: Taniya Das <quic_tdas@quicinc.com>
> 
> The video driver will be using the newly introduced

'will be' or 'is using'? Or will be using it for these platforms? Is
there any kind of dependency between two patches in the series?

> dev_pm_genpd_set_hwmode() API to switch the video GDSC to HW and SW
> control modes at runtime.
> Hence use HW_CTRL_TRIGGER flag instead of HW_CTRL for video GDSC's for
> Qualcomm SoC SC7180 and SDM845.

Is it applicable to any other platforms? Why did you select just these
two?

> 
> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
> Signed-off-by: Renjiang Han <quic_renjiang@quicinc.com>
> ---
>  drivers/clk/qcom/videocc-sc7180.c | 2 +-
>  drivers/clk/qcom/videocc-sdm845.c | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/clk/qcom/videocc-sc7180.c b/drivers/clk/qcom/videocc-sc7180.c
> index d7f84548039699ce6fdd7c0f6675c168d5eaf4c1..dd2441d6aa83bd7cff17deeb42f5d011c1e9b134 100644
> --- a/drivers/clk/qcom/videocc-sc7180.c
> +++ b/drivers/clk/qcom/videocc-sc7180.c
> @@ -166,7 +166,7 @@ static struct gdsc vcodec0_gdsc = {
>  	.pd = {
>  		.name = "vcodec0_gdsc",
>  	},
> -	.flags = HW_CTRL,
> +	.flags = HW_CTRL_TRIGGER,
>  	.pwrsts = PWRSTS_OFF_ON,
>  };
>  
> diff --git a/drivers/clk/qcom/videocc-sdm845.c b/drivers/clk/qcom/videocc-sdm845.c
> index f77a0777947773dc8902c92098acff71b9b8f10f..6dedc80a8b3e18eca82c08a5bcd7e1fdc374d4b5 100644
> --- a/drivers/clk/qcom/videocc-sdm845.c
> +++ b/drivers/clk/qcom/videocc-sdm845.c
> @@ -260,7 +260,7 @@ static struct gdsc vcodec0_gdsc = {
>  	},
>  	.cxcs = (unsigned int []){ 0x890, 0x930 },
>  	.cxc_count = 2,
> -	.flags = HW_CTRL | POLL_CFG_GDSCR,
> +	.flags = HW_CTRL_TRIGGER | POLL_CFG_GDSCR,
>  	.pwrsts = PWRSTS_OFF_ON,
>  };
>  
> @@ -271,7 +271,7 @@ static struct gdsc vcodec1_gdsc = {
>  	},
>  	.cxcs = (unsigned int []){ 0x8d0, 0x950 },
>  	.cxc_count = 2,
> -	.flags = HW_CTRL | POLL_CFG_GDSCR,
> +	.flags = HW_CTRL_TRIGGER | POLL_CFG_GDSCR,
>  	.pwrsts = PWRSTS_OFF_ON,
>  };
>  
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

