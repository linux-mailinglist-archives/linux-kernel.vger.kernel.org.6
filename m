Return-Path: <linux-kernel+bounces-196059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9AC38D56A7
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 01:56:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F3B51F23F29
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 23:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AC00186283;
	Thu, 30 May 2024 23:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oUTW42Jd"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF439183A71
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 23:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717113377; cv=none; b=hDIeN9LQMZUN7qAgGSpe3mJUZ3MeE92f+CXXX1vRT69xqG66L4cUjVobSi8cWXCiLAfepd4YosYDnNwroE/LMwqmLaKw08AAxn+dtlh914wVipRP3Sfge1IMAa/696RC/ZEsz5yFoHahMuZdml7p2xecra8lJ9QP0HwG+VuFUGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717113377; c=relaxed/simple;
	bh=u1x9WGaWjdQsG0liwfIZehg9z7MUpjxN/JdxyprkMzo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CqwsIM6WsH3sZxvwLQ/SW7UVEZ5llxMEcnxJAr959FAStOYNfkCryxw9b+aDd6E2js3Fppldua3FXLOVSooGaE4x6ze+5p30m32L8cGggp/XbNxNMyiOkGuZLJlwWHgHS4mJ/F2kU/l1CfMsj/y2nhqdkDkqalDnmoSuiAR9C/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oUTW42Jd; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2e96f298fbdso15276801fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 16:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717113374; x=1717718174; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ck/4mU0LZm3Pgy4D7+E7gErxKGmzB2tn/qzM/2E7y9I=;
        b=oUTW42JdTHDdud5F7HJMmn7+mMm53Sa69cTFcJ+5zwkAInKzOf4BMWHrVHuMp9XOgZ
         gj58JfBZUiwkEsjRlSq5Z+1Bm9bKum3mrbTJX2eYTNty2H0TD1ADs1TU/m6cSTAluaRt
         IBoZTZGRCpNoX9wBYzQPtNRxVZY9R+ISAFEqWYHN/v74Q9kT2yq1R6jQZpRlXOmZNuq5
         taihEDfy4uitbxrqN2xSNW5x2/3UfN+euyEcvpbYxtCIJDE/jXyA9nMM8Q4l56IlVvJz
         PswBWBxbh5h1tjQ1iem/z06Kg1ZAYAbeDak7Q/f60Scm4feiSujZBv+GVsbuIXygVHaH
         KiJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717113374; x=1717718174;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ck/4mU0LZm3Pgy4D7+E7gErxKGmzB2tn/qzM/2E7y9I=;
        b=k4iBOszU2/wxsngyb3GRTguZ64n415HjzWlmacNu4bI+S+NHqcApCMsEPLZgpCpoLN
         wRl4PeBgt27JLWPI+LPFfMJxw7yCo4Oh0bi2h6Pz6U7BLve23Q5mYNaF7/nC8lCJXSsH
         00mq8/CfsTZsv1MXF73hSzMDFzayxL6ndSMqlwP9gVNy6+tRpRB8121v5rI2RSEp+6BH
         ysryU3QjxbW5/fRTIIL1QI5UhtEu8EDXAK5xfZAz95IjlK2BKvk0TuvVowAL9bf/F0aT
         vMhjXoswDhAGrasvav84F6z9OedJ29hadV5cre3ToPhGKDmGXc9aiLH9XtGZsElHKiRl
         85Yg==
X-Forwarded-Encrypted: i=1; AJvYcCUNEeh0cpxtJo5zHucuYg4X64NzIq40mYkd+4EHySBFzJtZ24NCfZTWvkH5Q+TlTkYQpBMzPe7Ugkq86fTuEVLi7/lSuf559qUeA7+A
X-Gm-Message-State: AOJu0YyzuzMvsT7BnMGKz3ad9Lub2H4gsF+OaXG9SLU5KmoA0xiwtTCw
	clnKtU7ntf2FkqGs1xD4Rx81Ceg0fz3h4wAx5R+e1bgR03yAEtkLKNypyT1N/ds=
X-Google-Smtp-Source: AGHT+IEUTVqHon41x+1SSS+K+W1Rvwpf147hdypOX52i25HOqsLrwvRahXwTRl7mrNyeUkY3JvtrbA==
X-Received: by 2002:a2e:979a:0:b0:2e3:38e0:54c7 with SMTP id 38308e7fff4ca-2ea951b60f7mr1955031fa.38.1717113373865;
        Thu, 30 May 2024 16:56:13 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ea91bed98csm1206671fa.70.2024.05.30.16.56.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 16:56:13 -0700 (PDT)
Date: Fri, 31 May 2024 02:56:12 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Abel Vesa <abel.vesa@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: qcom: gcc-x1e80100: Set parent rate for USB3 sec
 and tert PHY pipe clks
Message-ID: <3ukguewuqqm5gmbd3afl62ihysdzkk44j3f2nuqht4gjuf5ruo@zu7jmmnbrpdj>
References: <20240530-x1e80100-clk-gcc-usb3-sec-tert-set-parent-rate-v1-1-7b2b04cad545@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240530-x1e80100-clk-gcc-usb3-sec-tert-set-parent-rate-v1-1-7b2b04cad545@linaro.org>

On Thu, May 30, 2024 at 05:05:24PM +0300, Abel Vesa wrote:
> Allow the USB3 second and third GCC PHY pipe clocks to propagate the
> rate to the pipe clocks provided by the QMP combo PHYs. The first
> instance is already doing that.

Which driver changes the rate of those clocks?

> 
> Fixes: ("161b7c401f4b clk: qcom: Add Global Clock controller (GCC) driver for X1E80100")
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>  drivers/clk/qcom/gcc-x1e80100.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/clk/qcom/gcc-x1e80100.c b/drivers/clk/qcom/gcc-x1e80100.c
> index 1404017be918..8c72fdc99fd9 100644
> --- a/drivers/clk/qcom/gcc-x1e80100.c
> +++ b/drivers/clk/qcom/gcc-x1e80100.c
> @@ -5269,6 +5269,7 @@ static struct clk_branch gcc_usb3_sec_phy_pipe_clk = {
>  				&gcc_usb3_sec_phy_pipe_clk_src.clkr.hw,
>  			},
>  			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
>  			.ops = &clk_branch2_ops,
>  		},
>  	},
> @@ -5339,6 +5340,7 @@ static struct clk_branch gcc_usb3_tert_phy_pipe_clk = {
>  				&gcc_usb3_tert_phy_pipe_clk_src.clkr.hw,
>  			},
>  			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
>  			.ops = &clk_branch2_ops,
>  		},
>  	},
> 
> ---
> base-commit: 9d99040b1bc8dbf385a8aa535e9efcdf94466e19
> change-id: 20240530-x1e80100-clk-gcc-usb3-sec-tert-set-parent-rate-420a9e2113d1
> 
> Best regards,
> -- 
> Abel Vesa <abel.vesa@linaro.org>
> 

-- 
With best wishes
Dmitry

