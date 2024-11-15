Return-Path: <linux-kernel+bounces-410328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E40809CD9FA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 08:34:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4B8A28286E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 07:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7900187876;
	Fri, 15 Nov 2024 07:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vlJGk5FP"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B1B1862B8
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 07:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731656030; cv=none; b=A9FVWOjrpE8NBkoc+85FiP3kgpYf4kBLbyPR9mUutf7ZE9B+WNFvsplpf+D3Ql1/Ix7HuAggl+n83dZ9c9w3SF4X13BaCJ+Sk+wWPyHLDXv8WdLFKwsNHeAlgJHeOwqln/do/hpx3X5g8XnqtJPhtbg71Ali42T6eC1Di0Xvl+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731656030; c=relaxed/simple;
	bh=DhDT7iMvKoUsMu+17Bo1UmwumbgR9hDqrlhAcDX87U4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TVPp09PoPIzvfyUTdq12X+BBFvlc4Y2wHgicGNtI5AMxvu8eLpiPdH3tDwZoAN45o0S7yZByG+v680ijBeYk0B9bAQhLiCDL4uQo9vS4TQsTcn0wjtNZqf833lpDGEDYfUwk7hWJY2TH3Mr/CwuCq2M7hRGVfAjNy2IUJnjbA5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vlJGk5FP; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2ff589728e4so15812051fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 23:33:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731656026; x=1732260826; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VXUA+xFQvFcv5jH0QqKITZEkbXxSgGAOHInFqY1wEGU=;
        b=vlJGk5FP/dlpwCFVZ0r+IKCrAuMDjPkL62k0L198WF2bVpJikoBOXMtxtfMMJCD/0i
         aFb6mWIoMhnuyqXdNPwoATUwfzbcNjaDJxgqXgCtTyPMlyN6TmoCFmHbnuyS4KO8tNJK
         KOaI5hKHkLVQiNmfm3vh61mIpTCiyNDZHIspJzcgXLICf4uaD1jnXiOZZMgHBaFvWyC8
         EIQKqnq7OR0RYnJ3zNQBWH34aSATKTCU0H4U0TjvyCEL8H0PzVcv9FxuGYZmFNQZxKoy
         EaCF7Coy3TJ2vGQjHs4EoZfUPuGYYAx7rmuiJuBCE5feYfctcgdV0z4KMZdTHs04y7oj
         dJ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731656026; x=1732260826;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VXUA+xFQvFcv5jH0QqKITZEkbXxSgGAOHInFqY1wEGU=;
        b=FDp3kZx/4oQvatlPaBgxQfYdOsX7y7KXwLKWR3w38A2u3fZ0zngyRdjP8PGsMGG/2L
         m5tJED85eoFuh30IskE6DfCNNQJ6rh/96n89lcFFkIc7nKBiIld074YOnPrcpVeikpz0
         uQzYRDRtv8PjGjAPe4spQXkiWQ7LEAuR82aQL/7lPI8HGYPbA7pX+jhoWqP3AR4lTiB6
         7wZDnov3wpFOf44bRlXtrMz5QYgKgPYUP4zd+10CK8MzBo4q0J7wbFUg+PehG26Zy1pa
         SbQLTAfj5fxui9osLJs3/9S0pxIJlTjlwmlZNHKcFvEUiqupnNiQEyD5aXfcKV8/9l0s
         ektA==
X-Forwarded-Encrypted: i=1; AJvYcCWE6+LPny14ezV8r289k8OLVh/IYt51X0Uso/b6WlPksjTvnNvHw5BYxUqNfQrPDFkLrFgM1F6X6+RSOJM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBcOla6BZkpoBL0soI3PLdgwVk2rmOsa23NjLfg4DU8RkSQYtn
	qsdInWiu4YTx+yZ9dBIg5rN7fp62B6MKu/f2Z0fKPWxAJWZAey4jV1sEqO6x8tY=
X-Google-Smtp-Source: AGHT+IEG2HyAK/keKdAkffHHfxXY9upS6+zDWPBk8B70ezx4vv7IgjX67R5jNW80lSYbongEkvCjpA==
X-Received: by 2002:a2e:a883:0:b0:2ff:5d45:883d with SMTP id 38308e7fff4ca-2ff606937e2mr5432671fa.13.1731656026282;
        Thu, 14 Nov 2024 23:33:46 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ff5aad77b9sm4273791fa.73.2024.11.14.23.33.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 23:33:44 -0800 (PST)
Date: Fri, 15 Nov 2024 09:33:42 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Akhil P Oommen <quic_akhilpo@quicinc.com>, 
	Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, 
	Konrad Dybcio <konradybcio@kernel.org>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Bjorn Andersson <andersson@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Connor Abbott <cwabbott0@gmail.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, devicetree@vger.kernel.org
Subject: Re: [PATCH RFC 6/8] drm/msm: adreno: enable GMU bandwidth for A740
 and A750
Message-ID: <nw2sqnxmhntvizzvygfho6nhiwfni4xfquwst5gd5g2tel6pnr@h66d4mw46jcf>
References: <20241113-topic-sm8x50-gpu-bw-vote-v1-0-3b8d39737a9b@linaro.org>
 <20241113-topic-sm8x50-gpu-bw-vote-v1-6-3b8d39737a9b@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241113-topic-sm8x50-gpu-bw-vote-v1-6-3b8d39737a9b@linaro.org>

On Wed, Nov 13, 2024 at 04:48:32PM +0100, Neil Armstrong wrote:
> Now all the DDR bandwidth voting via the GPU Management Unit (GMU)
> is in place, let's declare the Bus Control Modules (BCMs) and

s/let's //g

> it's parameters in the GPU info struct and add the GMU_BW_VOTE
> quirk to enable it.

Can we define a function that checks for info.bcm[0].name isntead of
adding a quirk?

> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  drivers/gpu/drm/msm/adreno/a6xx_catalog.c | 26 ++++++++++++++++++++++++--
>  1 file changed, 24 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
> index 0c560e84ad5a53bb4e8a49ba4e153ce9cf33f7ae..014a24256b832d8e03fe06a6516b5348a5c0474a 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
> @@ -1379,7 +1379,8 @@ static const struct adreno_info a7xx_gpus[] = {
>  		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
>  		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT |
>  			  ADRENO_QUIRK_HAS_HW_APRIV |
> -			  ADRENO_QUIRK_PREEMPTION,
> +			  ADRENO_QUIRK_PREEMPTION |
> +			  ADRENO_QUIRK_GMU_BW_VOTE,
>  		.init = a6xx_gpu_init,
>  		.zapfw = "a740_zap.mdt",
>  		.a6xx = &(const struct a6xx_info) {
> @@ -1388,6 +1389,16 @@ static const struct adreno_info a7xx_gpus[] = {
>  			.pwrup_reglist = &a7xx_pwrup_reglist,
>  			.gmu_chipid = 0x7020100,
>  			.gmu_cgc_mode = 0x00020202,
> +			.bcm = {
> +				[0] = { .name = "SH0", .buswidth = 16 },
> +				[1] = { .name = "MC0", .buswidth = 4 },
> +				[2] = {
> +					.name = "ACV",
> +					.fixed = true,
> +					.perfmode = BIT(3),
> +					.perfmode_bw = 16500000,

Is it a platform property or GPU / GMU property? Can expect that there
might be several SoCs having the same GPU, but different perfmode_bw
entry?

> +				},
> +			},
>  		},
>  		.address_space_size = SZ_16G,
>  		.preempt_record_size = 4192 * SZ_1K,
> @@ -1424,7 +1435,8 @@ static const struct adreno_info a7xx_gpus[] = {
>  		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
>  		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT |
>  			  ADRENO_QUIRK_HAS_HW_APRIV |
> -			  ADRENO_QUIRK_PREEMPTION,
> +			  ADRENO_QUIRK_PREEMPTION |
> +			  ADRENO_QUIRK_GMU_BW_VOTE,
>  		.init = a6xx_gpu_init,
>  		.zapfw = "gen70900_zap.mbn",
>  		.a6xx = &(const struct a6xx_info) {
> @@ -1432,6 +1444,16 @@ static const struct adreno_info a7xx_gpus[] = {
>  			.pwrup_reglist = &a7xx_pwrup_reglist,
>  			.gmu_chipid = 0x7090100,
>  			.gmu_cgc_mode = 0x00020202,
> +			.bcm = {
> +				[0] = { .name = "SH0", .buswidth = 16 },
> +				[1] = { .name = "MC0", .buswidth = 4 },
> +				[2] = {
> +					.name = "ACV",
> +					.fixed = true,
> +					.perfmode = BIT(2),
> +					.perfmode_bw = 10687500,
> +				},
> +			},
>  		},
>  		.address_space_size = SZ_16G,
>  		.preempt_record_size = 3572 * SZ_1K,
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

