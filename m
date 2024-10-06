Return-Path: <linux-kernel+bounces-352608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D2F599216E
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 22:52:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D73201F21616
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 20:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D219A18991C;
	Sun,  6 Oct 2024 20:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xogGelQz"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89AB31482E2
	for <linux-kernel@vger.kernel.org>; Sun,  6 Oct 2024 20:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728247920; cv=none; b=afkzD4DPMbQqEYsn+2vw53KIOwN4rfSkJ+XvXr3wON5+smU7Kt3f4roYKyMmSoRpI7mqsy+0xa+ZcaYs2cQg7hZ8XEM4bxSesc4lPOtpCIzHa+IYrZpzcCFVQWazPntdUPhKulXHvzMQ2FtZW6MW9Q4z2sAbj3VQ/Fe13hIxR/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728247920; c=relaxed/simple;
	bh=wr9NGsVm6LhI6v8Ap/Pnaiv08x7Y29AoBhRdMtTHbkk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PfQzmRVVzBriJGEF73ZBPRT5ec3KA6N1OlrHNyHdVUns43wvzCyivBIs9iDgVuaz2g548aq8KjBVuzmGz5UA+8opGpkOLLe04E9Bn9Pv0V0ijLRhKu3Ig52Oczjkr9FwlE+YiZtNtWUbEwRme7vkxC9s15pCAnROei8sbLI8VeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xogGelQz; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2fad15b3eeeso38661621fa.2
        for <linux-kernel@vger.kernel.org>; Sun, 06 Oct 2024 13:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728247917; x=1728852717; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MJEy7PuQJx4a4Y0UOaM+z+FnS+FwHznvnpR5auCDjVc=;
        b=xogGelQznoQ1n7zopHilSqljWvSudgk+r9CHeauPNPdDCOSmfe1mujgPDsBWBYpKPi
         8lvCrkugHxpQ8t1w3m9VZIu59D3vVczl2/kSsXXqLaQQa3SgRLPSWqOLpYTQfzCvf9yI
         dHzUb+1FUMteKHJRBANGdg7GMPqm2IHbRLhAQOOpnERyYfq+r0O0bUlsKRVKUSNc2hNC
         kJx5Om/kx3v5TNs000Vyv+49iRswaogPA1MDSsKfJZVGe9w6ntdjbfoPbAfVMirhUCla
         uWKgOVnoZpsiuoYeJqciUpYh/5wx3BGq5a+liLZZuTxx2rb7wup/Ta2AsMNLLJfCoMyx
         KRFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728247917; x=1728852717;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MJEy7PuQJx4a4Y0UOaM+z+FnS+FwHznvnpR5auCDjVc=;
        b=Gg81o82BIS8jzUi5G5G/CbTKAARcblTaGkbY0zGWxDUKvAkTUyAHTKL8F/YfcBaaZh
         LhVELP0ZgJtz3bD50vjX2sFro/sTeo5q0qWF1BtAdoSkNxxfXPdfot+jG/AxEg9n5Ccl
         81U9q3uxChtjViuFOXSsAfpeShnB77Bqm4wpKYyQ3syPmd5BcAbpFVDhK+hhfnLcQfzL
         rYB0qpP/CLr6iuK6llGE8xiatQxUQ5nwnMNuOMBp5QQbfuzkPfcxKc0NnRezwGd3nbhq
         1Rx2MAqMK2bKMYRM2BbxuWjmTOv9rlfHDfGIrSU3VXbrzZ+nj7E26Fo96l/VlZfrhLwt
         cUEQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVYX7K2nbu/zjAcJpjPknGKtQv1XkSf9nZVaFzg6Xmd8/gowC0V4CXfvy57zTx1cw0vq2xNa4pyorSsK0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmDDZwiIQU8t7aKqwOJpIXrLGKEPtsbqgwIbzq6zZLyLN3E0u7
	WRCmeVXNz3xRkhHJfDkvRTq23YOS06icEMlSFrZFzQxxOV+M4F+Ct910/JEoC6I=
X-Google-Smtp-Source: AGHT+IHnqEjLMz737rmSu/fnSVcQ0Z7KVW1dJ/VtpBWFpsUE17E1Urd/eqq5uHh+AtbSCWD0Opo76Q==
X-Received: by 2002:a05:6512:3088:b0:52f:368:5018 with SMTP id 2adb3069b0e04-539ab8adce3mr4288082e87.43.1728247916602;
        Sun, 06 Oct 2024 13:51:56 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00-89ea-67f6-92cd-b49.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:89ea:67f6:92cd:b49])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-539aff1d4e3sm616219e87.128.2024.10.06.13.51.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2024 13:51:55 -0700 (PDT)
Date: Sun, 6 Oct 2024 23:51:53 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: =?utf-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <barnabas.czeman@mainlining.org>
Cc: Rob Clark <robdclark@gmail.com>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Simona Vetter <simona.vetter@ffwll.ch>, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org
Subject: Re: [PATCH v2 3/4] drm/msm/dpu: Add support for MSM8937
Message-ID: <25jitdhbhknv6a6axfo7vkrnbareyeuipree5aytqburdbsaph@nucjpet5kjcq>
References: <20240930-dpu-msm8953-msm8996-v2-0-594c3e3190b4@mainlining.org>
 <20240930-dpu-msm8953-msm8996-v2-3-594c3e3190b4@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240930-dpu-msm8953-msm8996-v2-3-594c3e3190b4@mainlining.org>

On Mon, Sep 30, 2024 at 08:35:58PM GMT, Barnabás Czémán wrote:
> From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> 
> Add support for MSM8937, which has MDP5 v1.14. It looks like
> trimmed down version of MSM8996. Less SSPP, LM and PP blocks. No DSC,
> etc.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> [Remove intr_start from CTLs config, reword the commit]
> Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
> ---
>  .../drm/msm/disp/dpu1/catalog/dpu_1_14_msm8937.h   | 210 +++++++++++++++++++++
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c     |   1 +
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h     |   1 +
>  drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c            |   1 +
>  drivers/gpu/drm/msm/msm_drv.c                      |   1 +
>  5 files changed, 214 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

