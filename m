Return-Path: <linux-kernel+bounces-328206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D695D97808F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 14:53:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55AEEB2123C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 12:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C1D31DA626;
	Fri, 13 Sep 2024 12:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oC/7ZtWo"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5EB1DA60A
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 12:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726232002; cv=none; b=qHmMBEe4KUGeSBX8iMB1/5RR1Qje3O9uz3/HznCDYCaug9iQ+h7rxNvftmXwsnxy8Fegi2VYR9Id/LrlaoJuNr0gZGLKJooFxxQjyMZuB4rIJwwQs/LPsJ+1+6vTusKx0YPWDYTMdCcdo8OPxgXypuCYBcWdKa5y/f9hinsFvdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726232002; c=relaxed/simple;
	bh=C6SsqUkpTyfLzyYxGxgCFwe8trUiuCmZPYRrNQEXuRg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hK92oH9cZT6wf/FM4yfXngP52CqOeRznGhSnZqCzjADWz/uoafQxS/je1cfrKU/OAzcuUirTdkb8zESOC1fXhznwlSDP8vzvGHTVKoK0IEezIby32uYt4La7OuBFh/JlGi5y9Yg8mEDMyM1q85dgORp569UajZBezrAQY5+iDwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oC/7ZtWo; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5365d3f9d34so1082043e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 05:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726231998; x=1726836798; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ulKGIPWaoiiyEGEWVD2HKaFFVOQIntGXX/Asbla3YVM=;
        b=oC/7ZtWo0dg9LdpFzgnrUMyy2wTeGf/imTYJmkCJyyYnFDdWVRXkfAjXOgBB9X3Al3
         fE1XnTZln+7ja2oDbt72GcBafquB8EJVer8vUngqeygoqXfdwFT75SYZd2IkZPWS4o9o
         8bPHpcMo5DV6ZhkVa8UXtcfmqSEKNCN1arJ5ntefLV3Pwq/ONbmQv1x/SRMEJQd7OhhL
         JJutA367edrexZHextWRTpHqxDaiSEYYUlrlmdj6fXVl5vajIikN/zQiObtdLtxJ7BVa
         z/ZfvGkvmgbMiZmnu/V8sptOKV4Nbc/apGG8jatbBOMda4eacLGDKexFgY8yfgeQnNpe
         LBXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726231998; x=1726836798;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ulKGIPWaoiiyEGEWVD2HKaFFVOQIntGXX/Asbla3YVM=;
        b=dbm5/l1Pv9K4DP19ieocIKaLQZ77IumyAOMMUGWwXxg65ZTQPMvv+nuHtaioJTEZgU
         Hy3mJuvc0/xFbs2wXkKv2eqTHhUtFLE8FS+erVZma8KhU0F45T50G5sBBTrshoMu2oOg
         3VGyve6kn4iDi6D0Cy3e5XedRB5ZWlZ8rB6m4uSI1v4iFi4qK+Rqp3rihNl3kbU9Bsdn
         ZGxaikK36txZQVyoQaVM4l9I5gDBdz6XLqK/1rqZz66DTZG60gz7X0K6mDpyPbWXvC+P
         vth47h2BBjsFQVLpCR5PQFeaNyEAj1ZbtcHRDYcjZHK9kNsI+Qi+q6EmALRhC5BcRVZQ
         tIhw==
X-Forwarded-Encrypted: i=1; AJvYcCWRdlg6jX0EL9F+eK46f3pBg2G2Uz8B3Bs8h2k1bizD8cX6tr+dRMSeAudrvEChC4ELg1q8QeVkUIq2iQg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx890Zn4+Bjj37I23E2D1bWJ3dhGZncTkJIgzse80RspeixsNkA
	Ce/4iep2l/XQOxWBOfhecMoIjXbCcDB+VWRTWHDIv4tsbTL6klgfrzaK2oUEP9c=
X-Google-Smtp-Source: AGHT+IGMrI1iP0NSdtqsSAApfYvR65iW6wVAWhHwP/sGM4okfHDWoDQvz4JwneKed7XnN5mSPcy7Yg==
X-Received: by 2002:a05:6512:4020:b0:536:533c:c460 with SMTP id 2adb3069b0e04-5367ff295a6mr1358763e87.50.1726231998229;
        Fri, 13 Sep 2024 05:53:18 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5365f90d482sm2280238e87.262.2024.09.13.05.53.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 05:53:17 -0700 (PDT)
Date: Fri, 13 Sep 2024 15:53:16 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Sricharan R <quic_srichara@quicinc.com>
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, mturquette@baylibre.com, sboyd@kernel.org, 
	ulf.hansson@linaro.org, linus.walleij@linaro.org, catalin.marinas@arm.com, 
	p.zabel@pengutronix.de, geert+renesas@glider.be, neil.armstrong@linaro.org, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, quic_varada@quicinc.com
Subject: Re: [PATCH 8/8] arm64: defconfig: Enable IPQ5424 SoC base configs
Message-ID: <4dxqbm4uuuuht5db7kt6faz2pdeodn224hd34np322divs22ba@dzmjveze3b4f>
References: <20240913121250.2995351-1-quic_srichara@quicinc.com>
 <20240913121250.2995351-9-quic_srichara@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240913121250.2995351-9-quic_srichara@quicinc.com>

On Fri, Sep 13, 2024 at 05:42:50PM GMT, Sricharan R wrote:
> From: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> 
> Enable the clock and pinctrl configs for Qualcomm IPQ5332 SoC

Please name the device rather than the platform. The defconfig affects
all users, so it should be justified.

> 
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>

Usual comment.

> ---
>  arch/arm64/configs/defconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 81ca46e3ab4b..f1043a40846a 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -595,6 +595,7 @@ CONFIG_PINCTRL_IMX93=y
>  CONFIG_PINCTRL_MSM=y
>  CONFIG_PINCTRL_IPQ5018=y
>  CONFIG_PINCTRL_IPQ5332=y
> +CONFIG_PINCTRL_IPQ5424=y
>  CONFIG_PINCTRL_IPQ8074=y
>  CONFIG_PINCTRL_IPQ6018=y
>  CONFIG_PINCTRL_IPQ9574=y
> @@ -1304,6 +1305,7 @@ CONFIG_IPQ_APSS_6018=y
>  CONFIG_IPQ_APSS_5018=y
>  CONFIG_IPQ_GCC_5018=y
>  CONFIG_IPQ_GCC_5332=y
> +CONFIG_IPQ_GCC_5424=y
>  CONFIG_IPQ_GCC_6018=y
>  CONFIG_IPQ_GCC_8074=y
>  CONFIG_IPQ_GCC_9574=y
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

