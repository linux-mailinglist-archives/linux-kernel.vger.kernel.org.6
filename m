Return-Path: <linux-kernel+bounces-372359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B77E9A47A9
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 22:06:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B985DB2492E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 20:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB8CC205ACD;
	Fri, 18 Oct 2024 20:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nywpOx8e"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A02204F86
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 20:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729281995; cv=none; b=eGbVH2U6ALc+zaQied0Of/0Xpn9jso8Zykbkabv6BfmFIjjp5iDsZPbhoDj3ucwzmTBHsFWmfX88gtIx9tJm8T+puOOOBunsJfn209N2YQYlfNBmudqMOn3GhRjSTa14IRrIpMmI1BgEw91mRmd/J0EKvMO3ETFS+4TFBliRqSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729281995; c=relaxed/simple;
	bh=/51xfUSYsUDnsKHUISmuqpPXDOu6WONAfwM4tgenvn8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J4h+k4d2AqyYpDKyfLFMyfWo3kQVztjQDdfr1gPNjDUvbraK9ert53XpG87K5HPhkK4pyRWXetrnZkyr84JtLazeeXFurmRK1I54EUxXE6uoGXCKURuqaf8Afu6qALBtF9E3L3T6pdElAzdI+GORk69ewsSGCuV4gZ8eJ3sZQ34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nywpOx8e; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2fb584a8f81so30116381fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 13:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729281990; x=1729886790; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3qqeaSgLM4urcEuCSV+5q6Je9Wo3+AKbBRfKiBnVfLY=;
        b=nywpOx8e4pbIc417fKxkCToqytuZdvTH4Qpg2rhfsdXfZ81/dgLdX256X3TZHNKQyA
         Nc6d2ElJAzjDUT42B1HEJnRtQPYTLPaNnse0wW1EpzKh6FdYeNZu0JLbQePN5pEsIt/c
         XZZpVi3eZzufQjGeoH9pkQTBiiO+zxnWGInIXWVa805r+9L27RMqNBxwtozMepc9UPCi
         y7zUjJ/En96L+nYNnnEntdoGdVgIJAkNVMOq3U7KwdULaz6jOyQmdwamv/kA88eWVTee
         GY/uEylxhOlym6G2urH3xVv3eqHhuFiPC4vPVO0AGg08NxaG/NzIzQDw4Hej8WN9cQdS
         eBmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729281990; x=1729886790;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3qqeaSgLM4urcEuCSV+5q6Je9Wo3+AKbBRfKiBnVfLY=;
        b=dBAUe6Qk2ErovIVtiSzZAsC2+umprS355xoojBvsfSSNFwR785fuRIo+IVfKH66EyV
         gQupcYlBTgvNQdaT9D6WolDEveGCwFrN4uiP/Xwz6E1FTETfM4m/9KKpE9msLBpRw8K6
         +4dxewawco3iKrNJ6KvVDOxqRLlJWzCRWr9CJKVLe8e2b2ujVaJYnMMGssepUwQ9YPGi
         NUFvCCV+4cIFy8mXja5kLudrS8U9QccBnyqqp70wllWuYh80dduNxf6Fv91+UPuidJxt
         CeWBb/Gyl+lQg4f14Od75YMkGSIb347LSZYyyDnt9Kl1KR20J18vWXQbExgzoh3P3F6a
         Udcw==
X-Forwarded-Encrypted: i=1; AJvYcCVMmwC8Zr1cRBGH9cIV5fDQMNCVfn6n0E1if3kVA7hzTCWU0w5V7ELPZNLKZS85ID2wxaJmH8Kg3wIkKrM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRCeu63ncGFEeuTrmK9F4ffFmW049B6SIylSyk0i7mM8P7k8jw
	PbBbq65Lr2ywQ6QswLv3fYUXs2ZKE3RkWcqB6KcdcWi87/6foYKIlNdnbqGpXAE=
X-Google-Smtp-Source: AGHT+IEYyQy2Sr1B6koAkEX9lbp8dGLEG2De1kXaGvAZ20tI3Rvf2hBstWggqiGwZuP1BLYC4EzDUw==
X-Received: by 2002:a2e:be84:0:b0:2fa:bb65:801f with SMTP id 38308e7fff4ca-2fb82ea2494mr22593721fa.10.1729281990154;
        Fri, 18 Oct 2024 13:06:30 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fb80a08906sm2878401fa.106.2024.10.18.13.06.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 13:06:28 -0700 (PDT)
Date: Fri, 18 Oct 2024 23:06:26 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Taniya Das <quic_tdas@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Abhishek Sahu <absahu@codeaurora.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Ajit Pandey <quic_ajipan@quicinc.com>, Imran Shaik <quic_imrashai@quicinc.com>, 
	Jagadeesh Kona <quic_jkona@quicinc.com>, Stephen Boyd <sboyd@codeaurora.org>, 
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 01/11] clk: qcom: Update the support for alpha mode
 configuration
Message-ID: <nzzijnfy4wy4ts46c55rokvgwsxc4kytro743xqoecyjpjosyu@hajjkkdw2xmg>
References: <20241019-qcs615-mm-clockcontroller-v1-0-4cfb96d779ae@quicinc.com>
 <20241019-qcs615-mm-clockcontroller-v1-1-4cfb96d779ae@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241019-qcs615-mm-clockcontroller-v1-1-4cfb96d779ae@quicinc.com>

On Sat, Oct 19, 2024 at 12:45:37AM +0530, Taniya Das wrote:
> The alpha_en_mask and alpha_mode_mask must be applied within the
> clk_alpha_pll_configure() function to ensure proper configuration of
> the alpha mode of the PLL.
> 
> Fixes: c45ae598fc16 ("clk: qcom: support for alpha mode configuration")
> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
> ---
>  drivers/clk/qcom/clk-alpha-pll.c | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> 
-- 
With best wishes
Dmitry

