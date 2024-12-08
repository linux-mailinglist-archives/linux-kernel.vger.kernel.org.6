Return-Path: <linux-kernel+bounces-436268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E13649E83A5
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 06:30:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A77AF18848F6
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 05:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E35C4174A;
	Sun,  8 Dec 2024 05:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mx0o2C2U"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85EAF46B8
	for <linux-kernel@vger.kernel.org>; Sun,  8 Dec 2024 05:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733635831; cv=none; b=bRGIWYfjCqcR/Ukc+d9wfLiCXnhwcaTOhYjZQZlHQKDahrDBIRXIw80s7MaZPL2bbfw0Dj3kEo7SuB158xxOIVAVqRhQQaGMdfzsf3FclQ4lTMEhOfJ6XLHjzNtDeT+Sn4L4v61/i0o6Rl0FgAV1Fv7NFdmmkzS532YUPccvYnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733635831; c=relaxed/simple;
	bh=KvnIfFf8P+FLDr+t06zo2ANjcZmqdeZgnkbH9neKfp8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uXhCWt3oU+ORjTFTddqA4tO7ZEXVIxtGPXLOfVNQRsFok5j5J2y9wAqML3lk0Yr16C90Hflm1bQRaHilVpHxZ4nV1oW+8FQbjQSCw0p/A12ahF0FuIv7cSfzdGaEyEGBIzvrsvtussz96oWzEBYlWZCtVYgJNMUK1hJNI+ZPj2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mx0o2C2U; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-3001e7d41c5so28326741fa.2
        for <linux-kernel@vger.kernel.org>; Sat, 07 Dec 2024 21:30:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733635828; x=1734240628; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Wvacb83oMug8ZaJH3xcieEjmfoUkx49WyZ97VXV3ZeM=;
        b=mx0o2C2UYAfyxuPhYQ4zF+/r38aKN9+/2jiaOtQfv5vlKbXYKwBNfy2bB52g9jOtR2
         dcSW/16Y9mVFUOOrzwMBBp+2dUyUoMBlpn9fHbfS2r9HMH2sbBJRYA4w7mQW15ri8kZm
         T8rkTuccUp6OUALmooc7B/lVKEBntNpFN+R/Uk+xxMljs6p2qnOh9gUFzepWB7qoyHKo
         l8mmUFdphT1cs/GfaESue2UC3N5bs9K4sFopCUOUbeF7V2v9pA/JRUNndAMhli9zV4G6
         DP+s5snisJKACnsl9hkIDHbcQ+870UdzBEbc/YZ3VbCg628GnWwJEDQn8+QE7QG//Fa0
         OzUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733635828; x=1734240628;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wvacb83oMug8ZaJH3xcieEjmfoUkx49WyZ97VXV3ZeM=;
        b=s9n0u/6v7EfJhtPDp7KmjnvPJbvIZMWCuQBxmsyvCHqw16CvlefyiFtk8z81QudMVp
         j7PF4mfumGG9sEAFIxx4p52JvHAXcPZqIvSQGCgPDVcyvKs8ckKqcq4Ja1zALbyje5mt
         2sfR0iwuBE0y75de+kgolKIwVKiMEZ9EZW4yXKgzZYpBL2tqoAQD8JcWkuz38zfPfINR
         2iJKVoF9syx5nP5H8ofEFnlgiAMZeMyqkCavrJvqKgfQI6v4MRYmAU9P2Rpcjov1oHxt
         isHPYvMaq1BuV5q8pwYBM8FdhsuCCtq4sJmkIDZjmceO4MxU23R6QgrfWbMz+JAJ6hfX
         jgaQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLazExb+6fS5Myf5Qaj5OBC5lRkWJtbK43JFB3dBIVVQu9AD2QpR5KfmL1qojURUqYGt/9H26+yob2o/A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEQA5hdlg9qfgYSaSYe3x2LRGjL0nOr2K2tVu+BTPHEawyUBhN
	wGah3kGErjzr4IgiTPVZF+Ft17+/aAkIp2VUZ0nb7+Y/rKjDuDcNW3Rv+WWkRP0ileC6bWTnIgL
	K
X-Gm-Gg: ASbGncu6nm5G2Vv9IEKnJTLvtghmyZLGFTsq37MAr8sk9yJlBZ4a8Y1hZuSGkPCjFlO
	UYW5PBwjYoM8G5wJrkFvlueCe7+0LsPnil5ieproIJcDRurk9kfQApQ6WwWPvo/LPbUcuYSKnvD
	KJK9lWruwzWX5Mlr41/Oc8kDqFlySF8R2E5ltlnrI5lemJnvP19Bo2v/yxo/0bajJkYs9/YRu4y
	7A8CAdXDvYsVjLE6rEbEME3XgpMjwEZtVuPlldjO5zKJEXrhcxelW+k3ddenSASEsoSFTGGp7xH
	w8ftk2mxG9ZfDkpgET70D76sgH5KKg==
X-Google-Smtp-Source: AGHT+IEGWyfmfMdOOWg2y1WPhvOD4Je6bh0ZK678xD9W3i2q/SCD+U4JO0yDb00ekQtqi9O1yIIVaw==
X-Received: by 2002:a05:6512:3d07:b0:53e:3ac2:9c03 with SMTP id 2adb3069b0e04-53e3ac29ca4mr1184966e87.31.1733635827566;
        Sat, 07 Dec 2024 21:30:27 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53e378c4264sm574040e87.239.2024.12.07.21.30.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Dec 2024 21:30:26 -0800 (PST)
Date: Sun, 8 Dec 2024 07:30:23 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Taniya Das <quic_tdas@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Ajit Pandey <quic_ajipan@quicinc.com>, Imran Shaik <quic_imrashai@quicinc.com>, 
	Jagadeesh Kona <quic_jkona@quicinc.com>, linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/3] clk: qcom: branch: Extend invert logic for branch2
 mem clocks
Message-ID: <oylnao5wjtqyczivesfg46eexfb5oj6o2azprtwf4bl7yhko2c@saqzbycbixqk>
References: <20241206-sm8750_videocc-v1-0-5da6e7eea2bd@quicinc.com>
 <20241206-sm8750_videocc-v1-1-5da6e7eea2bd@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241206-sm8750_videocc-v1-1-5da6e7eea2bd@quicinc.com>

On Fri, Dec 06, 2024 at 11:07:11PM +0530, Taniya Das wrote:
> Extend the support for mem ops implementation to handle the
> sequence of enable/disable of the memories for the invert
> logic.

This mostly duplicates the patch contents. Instead commit message should
explain what is the "invert logic" and why it is relevant.

> 
> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
> ---
>  drivers/clk/qcom/clk-branch.c | 14 +++++++++++---
>  drivers/clk/qcom/clk-branch.h |  4 ++++
>  2 files changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/clk/qcom/clk-branch.c b/drivers/clk/qcom/clk-branch.c
> index 229480c5b075a0e70dc05b1cb15b88d29fd475ce..6caded8688c081e51ad0649f9c2f82919e461668 100644
> --- a/drivers/clk/qcom/clk-branch.c
> +++ b/drivers/clk/qcom/clk-branch.c
> @@ -142,8 +142,12 @@ static int clk_branch2_mem_enable(struct clk_hw *hw)
>  	u32 val;
>  	int ret;
>  
> -	regmap_update_bits(branch.clkr.regmap, mem_br->mem_enable_reg,
> -			   mem_br->mem_enable_ack_mask, mem_br->mem_enable_ack_mask);
> +	if (mem_br->mem_enable_invert)
> +		regmap_update_bits(branch.clkr.regmap, mem_br->mem_enable_reg,
> +				mem_br->mem_enable_mask, 0);
> +	else
> +		regmap_update_bits(branch.clkr.regmap, mem_br->mem_enable_reg,
> +			mem_br->mem_enable_ack_mask, mem_br->mem_enable_ack_mask);
>  
>  	ret = regmap_read_poll_timeout(branch.clkr.regmap, mem_br->mem_ack_reg,
>  				       val, val & mem_br->mem_enable_ack_mask, 0, 200);
> @@ -159,7 +163,11 @@ static void clk_branch2_mem_disable(struct clk_hw *hw)
>  {
>  	struct clk_mem_branch *mem_br = to_clk_mem_branch(hw);
>  
> -	regmap_update_bits(mem_br->branch.clkr.regmap, mem_br->mem_enable_reg,
> +	if (mem_br->mem_enable_invert)
> +		regmap_update_bits(mem_br->branch.clkr.regmap, mem_br->mem_enable_reg,
> +			   mem_br->mem_enable_mask, mem_br->mem_enable_mask);
> +	else
> +		regmap_update_bits(mem_br->branch.clkr.regmap, mem_br->mem_enable_reg,
>  			   mem_br->mem_enable_ack_mask, 0);
>  
>  	return clk_branch2_disable(hw);
> diff --git a/drivers/clk/qcom/clk-branch.h b/drivers/clk/qcom/clk-branch.h
> index 292756435f53648640717734af198442a315272e..6bc2ba2b5350554005b7f0c84f933580b7582fc7 100644
> --- a/drivers/clk/qcom/clk-branch.h
> +++ b/drivers/clk/qcom/clk-branch.h
> @@ -44,6 +44,8 @@ struct clk_branch {
>   * @mem_enable_reg: branch clock memory gating register
>   * @mem_ack_reg: branch clock memory ack register
>   * @mem_enable_ack_mask: branch clock memory enable and ack field in @mem_ack_reg
> + * @mem_enable_mask: branch clock memory enable mask
> + * @mem_enable_invert: branch clock memory enable and disable has invert logic
>   * @branch: branch clock gating handle
>   *
>   * Clock which can gate its memories.
> @@ -52,6 +54,8 @@ struct clk_mem_branch {
>  	u32	mem_enable_reg;
>  	u32	mem_ack_reg;
>  	u32	mem_enable_ack_mask;
> +	u32	mem_enable_mask;
> +	bool	mem_enable_invert;
>  	struct clk_branch branch;
>  };
>  
> 
> -- 
> 2.45.2
> 

-- 
With best wishes
Dmitry

