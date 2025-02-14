Return-Path: <linux-kernel+bounces-515197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A156A361A0
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 16:26:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4E3D7A5734
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 15:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8181C266590;
	Fri, 14 Feb 2025 15:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XMIc7Dg9"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B43F2661A9
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 15:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739546631; cv=none; b=PKmErWxyRpPgRxveW72YnIJ0EqelBA9XdfMlp6goYzivEbO+T56DNZOjmZb4vLTSZn9ucZ6w1JrgrWiXq6xSXkCoA+m4ArpD8tAVRTWCzPusecplVFm5/IlYLzf04MxMDvBtj4c7o+RvgNZWV22wv8JLvoqWsq57ofgziwyYL1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739546631; c=relaxed/simple;
	bh=OSD2cdfVTG+aYygmsNY8I461+agBuQLfxetkATo0Y88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=husFdOLLCdfBjveCqWotlXJHrUYRP+ZCSR6E5YHeexz2sxzPqH1IxpW9iFpXBdto005rPEhrb8evw2iyq9HTz3oSfDQYZYlxhQvvjss9JTOmGqta2I23RfODSAocuhcVdy6ijNqf+0SPDK3NKBN6hJUxju8GAjC1sYaqtJ2IxZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XMIc7Dg9; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-54505191cdcso2109206e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 07:23:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739546628; x=1740151428; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7K8BSTw7ta7yWsbqLgOVUyOnvRZYzOV19aJnHy0TwW4=;
        b=XMIc7Dg9I55PXCYZQQEr0SuC1yeFfV3yycqUkAA27VQQS5KJkQE/hKWlf1pH3iM/dA
         bwvsdeMeUR4DxFY8kFyOse5/j2iG03Hzdylo+5Gf4WL8GMkZ8XB4mVTXSGlCLf0uft3k
         5pI8rdZENaQSqPJnfgFxifB5Eov210taPPDGng0Y36v8bkjPF1zXRRDZISUVFpP7afhw
         y1e165Ear+UDeW9USS8E/ZmWonxb7kdDyoORl85/gDMvx41nk9AxJ9UWCHs1nFob2dSu
         +AtSXQfsKcZzfr8nZ8Lj8BexaUzZVjvl+g1lsbqiyyKVBxmQkCiiUA13D6V1MP7hSUIq
         9lUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739546628; x=1740151428;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7K8BSTw7ta7yWsbqLgOVUyOnvRZYzOV19aJnHy0TwW4=;
        b=UmLaiyIfwTLqztFnMMtzHID0CtQnI9q1yvwmVJdaQRdlxVHhdicjHAQsD0WhuSrHJt
         RHe3RnabYFpx6cRynwd83JdkoZwEqtu3h6FIfeKN9hIMBTNRQV4WORBHx2KOd8vtcedl
         pb/thuKF0HBzAY5MkK0ELj3f3o8iunovVWyE0bvYwVfKam4cKn6+U9MBWTzX4rhCOFvq
         ZP63t7JZGpAeA54p1fLHdNwe1FFYqlOm6X4ZKYpiGm/GbmSl8lBiE+U2KusPe6Em1A6h
         o0s+nhV0KkB+i/diGovUX7mHYo8FL81/pAuwfFQLtFcPt/A54k7Wejke9ScmtMa36Pr1
         JNbQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZwQ/1aGgucgeyswVqqihsB9j1ev8zhlCYNnUf/fvIrAMiKafADFTzpeIhltFojF5e5evKr6McncABzyM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8RI27DwcyzbuSWjFFYoYtVEIUpjNarhPEaoXrPrzVZNTspVW5
	ieuwZKhr3G4L3UnRbzqXCTmK69F5mDf2nsLXQLnA+Od6EZL2iT7iYAZEzVk94M4=
X-Gm-Gg: ASbGncup6sP2g2KrW9i1OBy+L1Pz7tE0xthg7CnV4CO2WBnxEqR7aMXm+HQNurGLeKF
	EfyFgTECVe8ZTY9DYfrplb78TQ66VaNm1ukceIMaseySxay5xcrHpLvW48Jus75Zb4j2mntDDTO
	hpRa/Vk0I982mz5NTO/+MS56I2a0BATf9igcju0BlCtqWb5mRWZbdSSq7CFao/KY7OfxgpUit+i
	7pG4G23vyO+ePpqybft1NGjY6H//4TDwB4pJTMnNZKb2vlxd2AvEFwO6ybNVZ3ZA98kOLDaXKp0
	meGJc0wk40eX82KjanSJjysvEHE2JKDnpT9KR7YPmzvxh4sSZwUyE1TP1XHBJVNTGkU8CCA=
X-Google-Smtp-Source: AGHT+IGALhJWUcXuaBCuFD7xYR2u6KjGzOjmwJRF/DL2JlsD9cMVL8yeOcM9QHBZZp3Db4bqrZQnzw==
X-Received: by 2002:a05:6512:1250:b0:545:6fa:bf60 with SMTP id 2adb3069b0e04-5451dd8fd27mr3053085e87.19.1739546628171;
        Fri, 14 Feb 2025 07:23:48 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54526ecd59bsm299535e87.31.2025.02.14.07.23.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 07:23:47 -0800 (PST)
Date: Fri, 14 Feb 2025 17:23:45 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Rob Clark <robdclark@gmail.com>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] drm/msm/dsi: Simplify with dev_err_probe()
Message-ID: <26p4fibtwqoiagzce7r46dumwzwe3swyjyy7wddreeksz5kg4i@sbys6hoqye5a>
References: <20250214-drm-msm-cleanups-v2-0-1bec50f37dc1@linaro.org>
 <20250214-drm-msm-cleanups-v2-2-1bec50f37dc1@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214-drm-msm-cleanups-v2-2-1bec50f37dc1@linaro.org>

On Fri, Feb 14, 2025 at 02:17:45PM +0100, Krzysztof Kozlowski wrote:
> dsi_get_config(), dsi_clk_init() and msm_dsi_host_init() are called only
> from platform driver probe function, so using dev_err_probe() is both
> appropriate and beneficial:
>  - Properly marks device deferred probe status,
>  - Avoids dmesg flood on probe deferrals,
>  - Already incorporates printing ERR value,
>  - Shows device name (in contrast to pr_err()),
>  - Makes code smaller and simpler.
> 
> Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Changes in v2:
> 1. Update commit msg
> 2. Tags
> ---
>  drivers/gpu/drm/msm/dsi/dsi_host.c | 100 +++++++++++++++----------------------
>  1 file changed, 41 insertions(+), 59 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

