Return-Path: <linux-kernel+bounces-372400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB4CB9A4816
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 22:34:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A9E51C22263
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 20:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32BF920C00A;
	Fri, 18 Oct 2024 20:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Hxt4pvgU"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4922071FD
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 20:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729283530; cv=none; b=YtUfLzus6GY5okvv2m7sfwOU15QgYAFXeKVnB42QVWfZRFTL/7Xe8ToR+1Y2QePGbl19h21wkN9voEid8wNac3xpiOnVjNyuLO++Nb2UQbBM9yNymTq+7E0TWbGcXb/EfPQyupznSLmw95da53vZ1pKvXF2X44fYaZ5v/MEs73o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729283530; c=relaxed/simple;
	bh=vZrUCXE8YGc26ZVy4k0n5qZLKO3lXiAaTGLW/lCy1ro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nIYRvszNNe6Rp+bvOnGf8nAfLmjB1BnmaQwGiHHts1aFYT9FGbRTVBzb8U0XoE7g4R7r7eG0gBrVCPkmQSi26u1eBZaNZyZZ8G2V1rzvTPxmJvuLMeZl00CNWWaiyrHO/vCUZ6a5KafDRBmuFUmpxyDXMWkE55Memgpoj4ux6VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Hxt4pvgU; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2fb5111747cso32393451fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 13:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729283526; x=1729888326; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=s1rvr/Uij2iiVVXujz3U4dUZfoWm7VsepVb5jVAgW5U=;
        b=Hxt4pvgUJM8IN2Hy78zeIwf5q4f5cd/N9Bg/H/UtiN5+XOOf4mlUQd7gOKznG+E4Vl
         dcN2OYapXcv3YrJQw+j3T6xipuFTgzQ5bxJ1yoQ4L89cAXprh6WjvIfPfm2RTi6IeS8o
         ekWWcIJ/btjCPxWGq45C5sixXWVVkDAZbFSbcPMVHtT6Qld6kfGZ+En1gWAaJm06LfV4
         JzgK2s9HsNfPL6SSVswMhxRqkAvnvsImQSsupr1S8TW1T9nXOZw5nVRDuVy3W/0gHpEW
         p5NP5N5+elKljPlCYW99uLSud9YMSLX9YwViUvf92fHeobc5BOU/vC5i4lBEGRlvM/a5
         XCgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729283526; x=1729888326;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s1rvr/Uij2iiVVXujz3U4dUZfoWm7VsepVb5jVAgW5U=;
        b=o50Yee2bARwch3I0QHBa9e47yza6OzDrL2Bqv/7kbd5ytIMGxuQtVCOWrCRSZdDvuG
         nSThR4LuUCSJDo5z5QlcR+oeQ2+PVYlyW9He92NCvoV+cFxJCoD4lxPAWLRBwUVxonES
         xLIH7st8rC7jl6CEl8zpY+gZymi1IJWyzVDQfNf1DlS6AOgs2WbAbOQYFKZk9pshAQHO
         rWNHjFG50pjtB/dhSSW6vVbEv7uUA8y77p/j1TJ3M/fyD8tS9JmujIttVnPdCiw9u9kL
         vHzHUN8wYdjzAEtjsHywLupVry++0mN6GXMi9MrIN+incI3VJTHxaIjEqr1jBS7M/ORH
         HUQw==
X-Forwarded-Encrypted: i=1; AJvYcCV8bZ9FEbPSbafR2uqEakGalH8+O+p5tuifo8h0RTDvqmGVOTbthDeTXrscFrwMnN3bOX0Ex7hUIzLb9co=@vger.kernel.org
X-Gm-Message-State: AOJu0YzErEUmtRiZBCzSnmbYmT96r006nrQbqAHyH5ysIBfwUwCTy8cQ
	3sjPLz7SAdWTxEOWjyvVxJzhYe7/FRnsfkb31vOViWoxp1uzkYo1Ipinl2x0TxU=
X-Google-Smtp-Source: AGHT+IFjhTDa04c0wkzsox8Nf4dTMwUSokqIXtmRgUfX6rTWuRzthFwhBOET/4mRAznXMvDflm/CFQ==
X-Received: by 2002:a2e:bea2:0:b0:2fb:59dc:735a with SMTP id 38308e7fff4ca-2fb8320b27dmr21181791fa.41.1729283526338;
        Fri, 18 Oct 2024 13:32:06 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fb80a08de7sm2994311fa.118.2024.10.18.13.32.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 13:32:05 -0700 (PDT)
Date: Fri, 18 Oct 2024 23:32:02 +0300
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
Subject: Re: [PATCH 11/11] arm64: defconfig: Enable QCS615 clock controllers
Message-ID: <zbkqqweb6e6sw6cic3klg4pauxoi5wkcq5js5g4axp64ghpank@7q7jowwrwp5x>
References: <20241019-qcs615-mm-clockcontroller-v1-0-4cfb96d779ae@quicinc.com>
 <20241019-qcs615-mm-clockcontroller-v1-11-4cfb96d779ae@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241019-qcs615-mm-clockcontroller-v1-11-4cfb96d779ae@quicinc.com>

On Sat, Oct 19, 2024 at 12:45:47AM +0530, Taniya Das wrote:
> Enable the QCS615 display, video, camera and graphics clock
> controller for their respective functionalities on Qualcomm QCS615.

.... used on Qualcomm ABCDEF board, please.

> 
> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
> ---
>  arch/arm64/configs/defconfig | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 730f303350c36a75661dc267fdd0f8f3088153fc..2fa666156b88b44a8298651e276c196cded9a7f8 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -1322,7 +1322,11 @@ CONFIG_MSM_GCC_8998=y
>  CONFIG_MSM_MMCC_8998=m
>  CONFIG_QCM_GCC_2290=y
>  CONFIG_QCM_DISPCC_2290=m
> +CONFIG_QCS_DISPCC_615=m
> +CONFIG_QCS_CAMCC_615=m
>  CONFIG_QCS_GCC_404=y
> +CONFIG_QCS_GPUCC_615=m
> +CONFIG_QCS_VIDEOCC_615=m
>  CONFIG_QDU_GCC_1000=y
>  CONFIG_SC_CAMCC_8280XP=m
>  CONFIG_SC_DISPCC_7280=m
> 
> -- 
> 2.45.2
> 

-- 
With best wishes
Dmitry

