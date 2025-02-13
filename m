Return-Path: <linux-kernel+bounces-512077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E95ECA333C8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 01:04:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C3233A58C7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 00:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9227A4A01;
	Thu, 13 Feb 2025 00:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lksfB6+M"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94922F44
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 00:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739405070; cv=none; b=EbaUZSPPPOGtIVEpz4ae/usCG7fIjztEXz4bqFKedV0QifT0UKBQ6qop0cOap8Yclw04XM3fHRmBLmgAz8yaZyoNmoO34gWsWO/tjv/G3aiU5cOneNHgFmGJjJ/4saRAGfu8ThjKdyK0CFDPfMnNJXLYdCZS1JE4CwC73Y1vP6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739405070; c=relaxed/simple;
	bh=yXEn6M4zmOSH0mBgsox+8yvEgc9Smd7J4BruiCZC2Kw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nv7t8/MR1zgmrntVWi7J5mzwdUhylmX68K+qy9Osq1JA9rR2AiPX8v/uNnsVqhkX/4z6I9lKoNOl7WvXtetlgRpSD66XHyQ2TsgDUMfLehmG9jC+XMBqI/ZQDGvqVk6fdsT+oD8EBSQPrKevw3jnzUwm4B/l/16QTvxUHV1qA3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lksfB6+M; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5439a6179a7so301842e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 16:04:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739405067; x=1740009867; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=g/dX/qzqd6dVtCQvTD6EDKh/RRBcZW8oAwKMkEiG/94=;
        b=lksfB6+MvL2Nl+mseP21+ZYi4C8Av454X7nucJRlRnBTFMJtQq97A6nCjl9nco+bMg
         8HkoLa4hveCk+w2zxe/BKDSHaacda/SS/SJpZ7wkBVovCYR2XlxW71BAD/A5wWp7+t/5
         hr5dfePE3Eo06AcV/wFFfti9PrHJr19+k5LKan76jqVtfWfwYSKl0p4qvr1jkJuXPBO0
         r9lAOH5QhByMLq64qUEEz3XMIIm1Bp4Gj6LJjCchDbQB9VRa/g0xZ3Na91HmUmfqB+x9
         4NIcBUfLrS0ggbsuHI33owl9jS8eoPlSBLT3mI1P7iNUl4k512K0DoqzU2A15P1Elvbm
         QJ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739405067; x=1740009867;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g/dX/qzqd6dVtCQvTD6EDKh/RRBcZW8oAwKMkEiG/94=;
        b=YOYsxVKbevLhp3SwOEenzttlmetYjhFnlCjFGcclvaYkkdQGM8SRv096kW23Z8sGLD
         C8/TnSeqjzJriTuwysUkfrzdEV3bwG3g4GOyrphyE/jB+QQth2vPFtDz1vNuOPn0fawN
         nv5h0juF7XCStP1SW9L/eJBI30yrfxoHmwvY9s9EqKQ6G/4C+vhTFjMybrO8B+0foFLY
         iQ2JczqoVjlG/9MFwKj+aF3HGGeGv2ze4NUOtPyWV1QFWugdWKcyZZhAp/Whz5B16lmu
         5z2kEGKRoh1yGptqRgCNRZBlAOGfyKnDHpqj2O24zCFe2HwmXZA47cSIQbSNhUETGZy0
         VZnw==
X-Forwarded-Encrypted: i=1; AJvYcCViLDVYrebfGI8SJx5e2sBXFoTyP7SISZx9NrcDS0/8PZLoankbMguypLgOCKWylkvE9L7wL81k6c/wIYA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxqa9Je6czW9xsAB+TZVxmChwE6xw/KJobwDxahZAyKNxrQMuhs
	XfiTPRB+kqGqo1Mp97hdUyOdxi4a6dvd54F0JND2spYqpBAqpkpWFk+h60mImcI=
X-Gm-Gg: ASbGncuPRahpMEKbtY/DlArCgg5bxwZeXXl8umnfb4o/kGnI79jxKqUFLTsN8FkFyNu
	bs3qlnUHM/XzJDRrWfXCO6biorrF7Qu9vOppGu9NldkB+uZ6plKGyfHV9ewjjVEdElAb/bJFfEN
	Ptvgt9948dqZwHWvRabYQsu+/U1Rvu6HY4zNCyb/NVYM1U9UeJ7pKeFaLWE2b55mI/HUVCgHMY1
	WIZp5RIqxmUOG8dpr/VkY4kjUxV3pGeFnCdVh9jzAb/WoCr2Kio9XydLiwFPJufegm0OpIAoqcI
	1PS1IGdzIBEw1ywdJ4x/S5gP4MDtzg0bJd00w2PziLxxYtKKTuj5LdCXLuF7UUb6XcETwwA=
X-Google-Smtp-Source: AGHT+IH+fxi9VKUfSEWdeJIAsmbcn/rRwU9rp6DokXIOHewLvT5877lvjYqtDg8LhsfdCVvtFd5JDw==
X-Received: by 2002:a05:6512:220a:b0:545:1d04:5dff with SMTP id 2adb3069b0e04-5451e01f3a6mr241356e87.24.1739405066968;
        Wed, 12 Feb 2025 16:04:26 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5451f11ec34sm12035e87.235.2025.02.12.16.04.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 16:04:25 -0800 (PST)
Date: Thu, 13 Feb 2025 02:04:23 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: "James A. MacInnes" <james.a.macinnes@gmail.com>
Cc: Rob Clark <robdclark@gmail.com>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Chandan Uddaraju <chandanu@codeaurora.org>, 
	Stephen Boyd <swboyd@chromium.org>, Vara Reddy <quic_varar@quicinc.com>, 
	Tanmay Shah <tanmay@codeaurora.org>, linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Guenter Roeck <groeck@chromium.org>, Rob Clark <robdclark@chromium.org>
Subject: Re: [PATCH v2 2/2] drm/msm/disp: Correct porch timing for SDM845
Message-ID: <5yli2sqw5hxoinlaguxjq2lleez7p4qjkwvexrgn7uphnu44ws@trlvdrpep5uv>
References: <20250212-sdm845_dp-v2-0-4954e51458f4@gmail.com>
 <20250212-sdm845_dp-v2-2-4954e51458f4@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212-sdm845_dp-v2-2-4954e51458f4@gmail.com>

On Wed, Feb 12, 2025 at 03:03:47PM -0800, James A. MacInnes wrote:
> Type-C DisplayPort inoperable due to incorrect porch settings.
> - Re-used wide_bus_en as flag to prevent porch shifting

Unfortunately I don't know enough details to comment on this change.
Maybe Abhinav can check it. I can only notice that msm-4.14 disables
programmable_fetch_config for non-DSI calls. Would disabling that call
for DP interface fix your issue?

> 
> Fixes: c943b4948b58 ("drm/msm/dp: add displayPort driver support")
> Signed-off-by: James A. MacInnes <james.a.macinnes@gmail.com>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
> index abd6600046cb..a21addc4794f 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
> @@ -94,17 +94,21 @@ static void drm_mode_to_intf_timing_params(
>  		timing->vsync_polarity = 0;
>  	}
>  
> -	/* for DP/EDP, Shift timings to align it to bottom right */
> -	if (phys_enc->hw_intf->cap->type == INTF_DP) {
> +	timing->wide_bus_en = dpu_encoder_is_widebus_enabled(phys_enc->parent);
> +	timing->compression_en = dpu_encoder_is_dsc_enabled(phys_enc->parent);
> +
> +	/*
> +	 *  For DP/EDP, Shift timings to align it to bottom right.
> +	 *  wide_bus_en is set for everything excluding SDM845 &
> +	 *  porch changes cause DisplayPort failure and HDMI tearing.
> +	 */
> +	if (phys_enc->hw_intf->cap->type == INTF_DP && timing->wide_bus_en) {
>  		timing->h_back_porch += timing->h_front_porch;
>  		timing->h_front_porch = 0;
>  		timing->v_back_porch += timing->v_front_porch;
>  		timing->v_front_porch = 0;
>  	}
>  
> -	timing->wide_bus_en = dpu_encoder_is_widebus_enabled(phys_enc->parent);
> -	timing->compression_en = dpu_encoder_is_dsc_enabled(phys_enc->parent);
> -
>  	/*
>  	 * for DP, divide the horizonal parameters by 2 when
>  	 * widebus is enabled
> 
> -- 
> 2.43.0
> 

-- 
With best wishes
Dmitry

