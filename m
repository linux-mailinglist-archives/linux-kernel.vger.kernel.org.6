Return-Path: <linux-kernel+bounces-225948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19961913811
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 07:59:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C67F4281E8C
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 05:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E49BA17C7C;
	Sun, 23 Jun 2024 05:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wjjK8Hst"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98943F9E9
	for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 05:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719122367; cv=none; b=IGwjhNRb366dBwrdh5Kk2MYFxok57g3ZiZs6pZAHePMxW1INU0NVxgzwSfSFaQgN1lT5fDImGbYGQem8YaNNrmUnRFVFcssMGV3hqoCo7yWWM+lVodqFb4z8yxRVRrkreJl9FbMZKZX9gtsIoCsdWI6knTcynjrhlhJwsvPkO4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719122367; c=relaxed/simple;
	bh=YjxfZqe0EZANRqjml3+wYXxJUqgsw3jOPlTubWLT1AM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oKnbpLewRbyaD+vPcyPgY8tu2GwSRRewrDKkEtbQimFpj4AU2jp3MEKtNfH85U95YyGmHH3Eg8JlzBw21H+lr2yoiZh2RPiZTAVDPufrWfA31KT+0v2FcQf1fxq9Zcx4QVXQ6PfAQZW44O66L9PK7+RiMck5IMF+whzz8A9XzZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wjjK8Hst; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2ec52fbb50bso12803821fa.2
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2024 22:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719122364; x=1719727164; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uV6ZdsyWs/0K8RTllxKQAwLax2534ZjABCMu7Optue0=;
        b=wjjK8HsthXgxVtnhgAO1JK+6cOBifSFYmV+zi6uXfudHKd28C8BQGwqurqX9EX5jb+
         K3Ri3mdm1Wmchq7kbraTt5NAGTuH5rTTXTD+/mD+aGkJ1clThXon+DIB5x1SWOW4WlaI
         pMJ2QRLLDN1rsQGDBOHSHFDiaX0ag836manWVi9TpwHna+G+7rKxchu6t4SGEFP/SkbW
         PA7z3XcgA6eAtQaGlk6d6diRAdEoyMvm6J/y8TQ85oL/xecyJ59pjhJUhbP2XoallK8J
         fOVLAoPTcNgO2UKj215tw5q7kxwLkNoZEcNN7Stn7OMpNbwaOAgzIk56qv64EsnC1Fiv
         xmqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719122364; x=1719727164;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uV6ZdsyWs/0K8RTllxKQAwLax2534ZjABCMu7Optue0=;
        b=HlW72UCrRDD6RVbG9/TP6d62n8rNwLXqSe8Zh3Wcu4o0F1WYpUyQD3x5XqNgPP1Yxl
         EpZjdSfUawJ2XVJXEWlnO6O+JubKur4BYnOGRgPW/aDrz8MP+yjjf9XbkmmKCm+RE+Nw
         RG6JEqTg2/UwrToWO9XLj/BrxGHg1BdJ74u8LhaWXavd3t/5Q7hXNLWR8tPfQ7YqsBiE
         ILE+0APS1tLRtl8qRiGPtwsHTPQrFzx4eKTW7rtQ/NvTsJ/9O/GEPS4NwkgXRJsdcPey
         3Z8qsX5SrcJb50ZwEbspElx4wbqCBCXJspDoDO4o2gXANBuA8UiV+9/epzrZPirSoofl
         7ACg==
X-Forwarded-Encrypted: i=1; AJvYcCWK1H34gVjaciicrQAa+YBPdnd1vDTHhBxGNtUSsLjT2+UsC/aSBvQmRgHLMyo2FtZ0YgsJj41C4HbD4SaU7Y+deLZU3mFoeWZiadAb
X-Gm-Message-State: AOJu0Yz7YeXa8LkgNpQeteZK8ewstn/56xNolbck+ZsVXXTRwFCZ6RsH
	G+WXp/EUKqHJay81R7gD1WI9y/Li+GEzEFy0ZihF/FA4QtQyd3rJo57AhFBynQw=
X-Google-Smtp-Source: AGHT+IGcHezaqPv4f6l+aRS6cpymyT8QWqnho+MGi0nRzclFQouvXc2Vz5OXXDqk0xU0di91OghoDA==
X-Received: by 2002:a2e:9f05:0:b0:2ec:fa4:e310 with SMTP id 38308e7fff4ca-2ec5b3d48ccmr7355091fa.34.1719122363747;
        Sat, 22 Jun 2024 22:59:23 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ec4d60130csm6301061fa.13.2024.06.22.22.59.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jun 2024 22:59:23 -0700 (PDT)
Date: Sun, 23 Jun 2024 08:59:21 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: =?utf-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <trabarni@gmail.com>
Cc: Rob Clark <robdclark@gmail.com>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Krishna Manikandan <quic_mkrishn@quicinc.com>, 
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Daniil Titov <daniilt971@gmail.com>
Subject: Re: [PATCH 2/4] drm/msm/mdp5: Add MDP5 configuration for MSM8937
Message-ID: <hzslz54iq5sjmfhcbuj3my7cbjsu73acxeelih3jekr6rznz44@qie4c4w5lt2d>
References: <20240623-dsi-v1-0-4ab560eb5bd9@gmail.com>
 <20240623-dsi-v1-2-4ab560eb5bd9@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240623-dsi-v1-2-4ab560eb5bd9@gmail.com>

On Sun, Jun 23, 2024 at 01:25:52AM GMT, Barnab�s Cz�m�n wrote:
> From: Daniil Titov <daniilt971@gmail.com>
> 
> Add the mdp5_cfg_hw entry for MDP5 version v1.14 found on msm8937.
> 
> Signed-off-by: Daniil Titov <daniilt971@gmail.com>
> Signed-off-by: Barnab�s Cz�m�n <trabarni@gmail.com>
> ---
>  drivers/gpu/drm/msm/disp/mdp5/mdp5_cfg.c | 89 ++++++++++++++++++++++++++++++++
>  1 file changed, 89 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_cfg.c b/drivers/gpu/drm/msm/disp/mdp5/mdp5_cfg.c
> index c5179e4c393c..6413c0d3e237 100644
> --- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_cfg.c
> +++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_cfg.c
> @@ -1011,6 +1011,94 @@ static const struct mdp5_cfg_hw msm8917_config = {
>  	.max_clk = 320000000,
>  };
>  
> +static const struct mdp5_cfg_hw msm8937_config = {
> +	.name = "msm8937",
> +	.mdp = {
> +		.count = 1,
> +		.caps = MDP_CAP_CDM |
> +			MDP_CAP_SRC_SPLIT,

Could you please point out the SRC_SPLIT reference?

Other than that LGTM

-- 
With best wishes
Dmitry

