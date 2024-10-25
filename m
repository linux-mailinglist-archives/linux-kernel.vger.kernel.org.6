Return-Path: <linux-kernel+bounces-381064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 936F39AF9CD
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 08:19:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B960B211E2
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 06:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7439C1B0F24;
	Fri, 25 Oct 2024 06:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N5cEVsCv"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9404F1B0F1E
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 06:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729837127; cv=none; b=PFAz9Gbdl0+cLGvZIvBcJqwX5H3hA3bCFMycnqZZH04ZEdjHzkmojMYKsJ36uY6VW+3LAzSNveffX/sb1OlRZkyfCG8j9JD39H2JSObE2HbL04vo7SaKoLkOOYRcclB6k8BqZpYLRTHWGoYsbQ4KeLGTLlww9zOF8nKMX2+1WOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729837127; c=relaxed/simple;
	bh=c2KPK3CxC4TfOLHxj+gQZEwoZT96vKaAp869u+dLzeU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KGW29WAsNQdSh4AjV350MMgVdumcHYU+NNDAAAlAD2RGgjtkcMXHIOqe9HrGpMqe1S8k7CYNCEGTcDOBN3lpimUnlKAheRzd1ZBcsGbEOsDQFKEBGDrEfoJwBEs1M6huiRn5DE7IKOu1Slwlo7gkLSgVhjI1CD4395DFzr1MKQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=N5cEVsCv; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-539fe76e802so2107180e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 23:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729837124; x=1730441924; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IhU/eN0lFYsjR1UQXQri+IBAPcpdVh86Anbk1TYigfo=;
        b=N5cEVsCvQfFrzpzB6C3yZDsUsig1JX83EVKmRWwpwQ4av1+q/EE7+r65SQ1rKFe3eO
         blQ2CA3A+x1lIuev2JmYO9s3XlwUyiz/YIr0mkh8d8Vbjz/QwbNBrNOEvoy9+CwiQseL
         ukn59As+8n8lhZP59fhKdbheRShm6Xsghh5NXwrsoOIoE6gwzawmt1Aa3zXOzZkbjKBG
         mUg5vKUKXG1ZeKrWek4yTBtmVTGQFtFT8ZwO461WQgc5er4fNviyWjtUDyQunMwHiSsw
         y4R/EkpOopLHHQz9UZGyQxBxCuLXuJXgFoNP5yiXQkPw7twNYUDo1ot5tzgFiYh2Yx8B
         srCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729837124; x=1730441924;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IhU/eN0lFYsjR1UQXQri+IBAPcpdVh86Anbk1TYigfo=;
        b=GSFf14ZqE9+QI6iNCCv69/l5kFBFAvlrrnkGC8+h48FUdxTNnBOnNow2pXbZDXmVBQ
         lPkhc2Riqit3sY1CbtQZgo8jp3OroTdv7yVGjxEtqJCTORGM5DV6LjxbIfOPOaZzIkZR
         gcVj1l4U6VDniTGs1GtlnQJny/u5+9N0y8pxuy6fEgzYteuEG737R8JHlyRolL/pg26U
         NQxOW28vhcOwzNEnxIOAM5mUDqAVmd/fW/rjZGBOKsJdyoSqHwnwyEgbo/Z6bU2tgxMO
         JUwdmvldgqNzdt3R4B2jUI79solhrzi4k5+QeXt5RcIyViSsp+iTmQsFap0kFsZEA2Pd
         kVFQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4OPdqTuRQAVMY47V26bTIV3EY4nPnN0dlOEX4ADolqbFwqV72Kd3Z3mtAnfwapH31NjKPwcM3kSliPhE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvkRI/5zxIFjMHAYv0ApgOmPP6l7vN77fFBbPB8mBOZTl8VvxO
	uDrlPf23oOsaTIyd8UNcawF0dHAyXvNNxpkISW51rhROZF9KTwZ+DPCuTyXgH2c=
X-Google-Smtp-Source: AGHT+IFxbZs0GM1bNkFMVSLEhah7LVmy7Y0F+Jb6terXMd8dieTVMbKbPMXMtSTtQeHE3dS5jZDU1Q==
X-Received: by 2002:a05:6512:131e:b0:539:e214:20e5 with SMTP id 2adb3069b0e04-53b1a394af9mr4812974e87.59.1729837123651;
        Thu, 24 Oct 2024 23:18:43 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53b2e1af331sm68514e87.152.2024.10.24.23.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 23:18:42 -0700 (PDT)
Date: Fri, 25 Oct 2024 09:18:40 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Gabor Juhos <j4g8y7@gmail.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] clk: qcom: gcc-ipq6018: remove alpha values from NSS
 Crypto PLL's config
Message-ID: <f4ip6jde5ffs6nvpllqhjleeb4s3j6hok5decxrof3inexh7ut@esgcsblz7wcj>
References: <20241021-alpha-mode-cleanup-v1-0-55df8ed73645@gmail.com>
 <20241021-alpha-mode-cleanup-v1-3-55df8ed73645@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241021-alpha-mode-cleanup-v1-3-55df8ed73645@gmail.com>

On Mon, Oct 21, 2024 at 10:21:59PM +0200, Gabor Juhos wrote:
> Since both the 'alpha' and 'alpha_hi' members of the configuration is
> initialized with zero values, the output rate of the PLL will be the
> same whether alpha mode is enabled or not.
> 
> Remove the initialization of the alpha* members to make it clear that
> alpha mode is not required to get the desired output rate.
> 
> While at it, also add a comment to indicate the frequency the PLL runs
> at with the current configuration.
> 
> No functional changes, the PLL runs at 1.2 GHz both before and after
> the change.
> 
> Tested on Xiaomi Mi Router AX1800 (IPQ6018, out-of-tree board).
> 
> Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
> ---
>  drivers/clk/qcom/gcc-ipq6018.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/clk/qcom/gcc-ipq6018.c b/drivers/clk/qcom/gcc-ipq6018.c
> index ab0f7fc665a9790dd8edba0cf4b86c5c672a337d..d861191b0c85ccc105ac0e62d7a68210c621fc13 100644
> --- a/drivers/clk/qcom/gcc-ipq6018.c
> +++ b/drivers/clk/qcom/gcc-ipq6018.c
> @@ -4194,10 +4194,9 @@ static const struct alpha_pll_config ubi32_pll_config = {
>  	.test_ctl_hi_val = 0x4000,
>  };
>  
> +/* 1200 MHz configuration */
>  static const struct alpha_pll_config nss_crypto_pll_config = {
>  	.l = 0x32,
> -	.alpha = 0x0,
> -	.alpha_hi = 0x0,

I'd say this serves documentation purposes: zero alpha value

>  	.config_ctl_val = 0x4001055b,
>  	.main_output_mask = BIT(0),
>  	.pre_div_val = 0x0,
> @@ -4206,7 +4205,6 @@ static const struct alpha_pll_config nss_crypto_pll_config = {
>  	.post_div_mask = GENMASK(11, 8),
>  	.vco_mask = GENMASK(21, 20),
>  	.vco_val = 0x0,
> -	.alpha_en_mask = BIT(24),

This is okay

>  };
>  
>  static struct clk_hw *gcc_ipq6018_hws[] = {
> 
> -- 
> 2.47.0
> 

-- 
With best wishes
Dmitry

