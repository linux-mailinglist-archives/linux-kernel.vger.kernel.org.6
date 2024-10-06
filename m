Return-Path: <linux-kernel+bounces-352606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C89F992166
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 22:51:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E94F1C2088F
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 20:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9EA918A94E;
	Sun,  6 Oct 2024 20:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UcLeFDnY"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5764213A27E
	for <linux-kernel@vger.kernel.org>; Sun,  6 Oct 2024 20:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728247893; cv=none; b=Q+F9BCZGRf33P9TiU9sz4NqSz/T41QZsNNQdnk2OAVFr8OPYNSM6CO3Pjv2KrQy95k3a+3MDwcPsXG0pE1xoxHwCSzllJ/Ygwya8mkUwPu+joGEwzadNnMgPlknWhyeCdYUxdKwYxEqrW48pT1Q0yzMMxRKfFfAM9IEpb5DFN5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728247893; c=relaxed/simple;
	bh=Y4euoWfGpYuL7CIb4aRqwSq4rDz5rFpsaNHU1dEcCyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qj4KbwNjQKIA6h+ZxP5F+g7A1L9AL25jSK2ums6kECsND+l0IFJ5XdqHMiXqgGYFaR4cvKMy07Gwx3TtYYHzdcNaPqpvndhSgdqPl55AgukHtUf/N+UF9o/dcBcPfE5GCLeNbcFiK+bek/zWKW30LIr+cr5fT4tF0oKfn9ealxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UcLeFDnY; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2fad8337aa4so41145131fa.0
        for <linux-kernel@vger.kernel.org>; Sun, 06 Oct 2024 13:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728247888; x=1728852688; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3HiBKSVX75LHHDNbaC77fS8s37J8jrwJ4P99mtP4pG4=;
        b=UcLeFDnYRvSomFvkdVAOUWJtSgUHVVtBufCUaccAcdR4NQlLERiRXOz/dvXuAgqw7r
         VNhQGT/K5vtOMllmoITF2fSMcYsTxTxXhUFH7buKUkMXeeRKwEfIanOZ2adU5NX/Hjwf
         hnz/xB7zYP2DQaT8HdFgOM5vQEN+EPRhpcO+KBsAuJNV23SnSQXTY2r1D0KhNZ+XicMo
         yIE7jvwm8j0akfCrBzZl3JKpBQwbKaRfwv7I4rz1uHPuGROPTUmXqfdTgMjMa0v8jqaw
         FCdkai5Gd2sdkvoJ8utmEB7Wh8pcAfRDwI32dsp8QNMEpr39vnHKP0MFrlNmVV0OLs/2
         2Bew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728247888; x=1728852688;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3HiBKSVX75LHHDNbaC77fS8s37J8jrwJ4P99mtP4pG4=;
        b=d41axu8hvxavjcS2hkPno1vF+IFWd0FwwIptFm3hwc1xa3x9ccy6MKKpTJjPy5u9iG
         b8mp5wrKCecE3zSDCpV0YU4oFYfvf4zX5iFIBGy7717wiEwC2+fcRH+QfS2ut72FeP3p
         Z2bLKpFD1xpXaJbRQrvUWnJChmbfsDT5FhknMWcPhr5wFkTpc3N50DKai1HDoFtn2sZ6
         tqJcQZlo/aJiWEE6yS8LIZgyPTreh1sgaNVbJ09ixJd7s1iGfacWYkVfU2DuWQ0TXBG7
         E90YBM+XL51mH7e/PBnm24mpkGH2g8xtACEBxUWewFQfWok8j3wtuSKRm6sSxeZsDZm+
         VGxg==
X-Forwarded-Encrypted: i=1; AJvYcCViJLqfrJvRnKZaay45OCcdDlvI0nxmAWQV60qOjLH5mSyLeDLQeZAoVNFWtaPlOXDFOE8inNhfszLZ92A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yymze1xIDJ/eQmHK8IK+hOcl+TpApA3REhNJeKKljKBfcs/APsa
	Ar3ZCm/j8frHBGoqAmLs9v47NQPX38FkNvXrT2NxTOIZimi8HtaHfb1IbJQ8nnffafN0XwbHCKE
	8louJ2b7z
X-Google-Smtp-Source: AGHT+IFYj5QIPKepGYx8O1cYCz5bguaSXuH74kBNDjDjaFAC/MHye9Vyl7Zez82XTrTQRF7q0Etevw==
X-Received: by 2002:a05:6512:230c:b0:52c:df51:20bc with SMTP id 2adb3069b0e04-539ab858874mr4118687e87.16.1728247888476;
        Sun, 06 Oct 2024 13:51:28 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00-89ea-67f6-92cd-b49.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:89ea:67f6:92cd:b49])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-539aff23334sm604877e87.184.2024.10.06.13.51.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2024 13:51:28 -0700 (PDT)
Date: Sun, 6 Oct 2024 23:51:26 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: =?utf-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <barnabas.czeman@mainlining.org>
Cc: Rob Clark <robdclark@gmail.com>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Simona Vetter <simona.vetter@ffwll.ch>, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, Konrad Dybcio <konradybcio@kernel.org>
Subject: Re: [PATCH v2 1/4] drm/msm/dpu: Add support for MSM8996
Message-ID: <c3fbm76ei3phw5y3nq76q76zkxcytiivdboe2nwifndguz7vun@pt3u6rzqxf77>
References: <20240930-dpu-msm8953-msm8996-v2-0-594c3e3190b4@mainlining.org>
 <20240930-dpu-msm8953-msm8996-v2-1-594c3e3190b4@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240930-dpu-msm8953-msm8996-v2-1-594c3e3190b4@mainlining.org>

On Mon, Sep 30, 2024 at 08:35:56PM GMT, Barnabás Czémán wrote:
> From: Konrad Dybcio <konradybcio@kernel.org>
> 
> Add support for MSM8996, which - fun fact - was the SoC that this driver
> (or rather SDE, its downstream origin) was meant for and first tested on.
> 
> It has some hardware that differs from the modern SoCs, so not a lot of
> current structs could have been reused. It's also seemingly the only SoC
> supported by DPU that uses RGB pipes.
> 
> Note, by default this platform is still handled by the MDP5 driver
> unless the `msm.prefer_mdp5=false' parameter is provided.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> [DB: rebased on top of sblk changes, add dpu_rgb_sblk]
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Acked-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> [Removed intr_start from CTLs config, removed LM_3 and LM_4]
> Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
> ---
>  .../drm/msm/disp/dpu1/catalog/dpu_1_7_msm8996.h    | 338 +++++++++++++++++++++
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c     |  94 ++++++
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h     |   1 +
>  drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c            |   1 +
>  drivers/gpu/drm/msm/msm_drv.c                      |   1 +
>  5 files changed, 435 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

