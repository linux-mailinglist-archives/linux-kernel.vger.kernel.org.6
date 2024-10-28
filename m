Return-Path: <linux-kernel+bounces-385038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FC6E9B31A1
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 14:24:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E94CB1F22850
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 13:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1755418A921;
	Mon, 28 Oct 2024 13:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TnDu+usz"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A6538396
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 13:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730121881; cv=none; b=CpVFSXGJu5fk8mgdoRwtphMEp2pKiKyCd7iEl11gov/DPSaKT1+FZVi4CBHoKi6g07B4aF3l5Rro/t+pCPmngjDs82LMrmSf8hFF8L2tXJsjV38zDD94Hs3N6wvq0/GRnBcBUnrZWs8UkFlanZbULO6+y7rx4AL/dJ7xBfAHSUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730121881; c=relaxed/simple;
	bh=t1DyrFQzCxA9ZT8I4k0y+yZcOp2aPGHQ06v/4c0F5y0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HcG7qZGXqonAm+DgX/urjZXtQSxsB0HIL6MdHS2EQsC1Ke2A9vUnm3waYuIALva13x+oE9+vWXP21t5Z1Qd32SolTg4tKcgambQ8S8OZzBbEnMGgOtPHPGDPtMNYU2htuYndzteifAvVDS30OLd+gGh6+lNcqJqSP8yHZg0+T6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TnDu+usz; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-539f53973fdso3618695e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 06:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730121877; x=1730726677; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NMNuqUjYdGsI/ewyp+O0XBZx++mguLN0/SFzlXkx3Qs=;
        b=TnDu+usztAonUkHd6UmBZEskXIPdMwe6sDDeACo+1TdfL1VpBd0dyGM7LFLndZngL3
         +oPXWeKYz6Itc5pJtCSgFf9yp578oTz3rRpkBTnD/pR54NW5L3llSHTVq1RXDNEG5abF
         3PJmg3i5fs2hRN2Etj86K9gExHfrKafnE/vOacHTT6HR0cOpj9Yn/HoOCLMSeW1fWiz7
         s3u3Bqn5z+wk4S3MrTmat8dRDv23hcPeKixqlgBTVjL63WXjHg2mm8vgAWHPgd8fee1b
         Is8gO7WayChv6YzPx0Vodtq8++hGde9JNTMlZwPQY7Ay5/NoIF1AjPm2CFjQSjUzLNTr
         mOlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730121877; x=1730726677;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NMNuqUjYdGsI/ewyp+O0XBZx++mguLN0/SFzlXkx3Qs=;
        b=Q40Gv+khg55CfXqClXUPKcciGmssPUHlPprfyrij3OTKlhTg617zqIS3gCX6fsl9Py
         zYED4bm/vL42/BfVKEwLrN5Hnf9KxZSP56Kr/K42d4HIzJ9SI3JqSPrHdsLFEOSLhgf9
         /tIS3Gf1MuNlyF0tX4vTYBBC7tJ4C1AnUb0tHlf8F1RlG4+RUrrPlTqUL5fm1NHENlBq
         4zfHQ9Dt471xSylTiU8RdyDReYntFYZ0pLjam0o9/wTgp7CM0x4Md0XhjE1gpppqQui6
         gFixWu8vtGHYp1ITXDeiEJhiZ4j7GYeiyt+gr/Lz5yMAEHpd5zu8v7eCsuGMmlQSu+X5
         aX2Q==
X-Forwarded-Encrypted: i=1; AJvYcCU2hKGZi33YfUdPBqnTz34Rs3ZMODSCzH4Zt+qFtVtdRdAG6i3JiV1B9jN9dOSkghfxlvWNzcBZm0C3pfU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzF972e3iTLXMRsiIHaLkNmEpAmsuznrux5M8BIfMo+zrUyRqob
	kiALdEKJVdDgTu8wyZtdXhzjxy4bvry+OHJ6cDt4rS2xjfr7UweMI1rl1iJt+F0=
X-Google-Smtp-Source: AGHT+IFlXAGD3sK0EGlwnEyIN1CvxY4RrY4KK2nu6cRisAMsP9krXv9MwqNzhjFQoZf2iPSWh3OkvQ==
X-Received: by 2002:a05:6512:1190:b0:52f:27e:a82e with SMTP id 2adb3069b0e04-53b33e4fab9mr2642044e87.21.1730121877021;
        Mon, 28 Oct 2024 06:24:37 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53b2e1ec88fsm1069465e87.282.2024.10.28.06.24.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 06:24:36 -0700 (PDT)
Date: Mon, 28 Oct 2024 15:24:35 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: linux@treblig.org
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
	tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] drm/client: Remove unused drm_client_modeset_check
Message-ID: <zvhtltfbu6dpwri7yuwwrpnno6g2hu7tv2q7ua73epfj6gi5e6@x2snh7otbalb>
References: <20241022232934.238124-1-linux@treblig.org>
 <20241022232934.238124-6-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241022232934.238124-6-linux@treblig.org>

On Wed, Oct 23, 2024 at 12:29:34AM +0100, linux@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> drm_client_modeset_check() was explicitly added in 2020 by
> commit 64593f2a6fc9 ("drm/client: Add drm_client_modeset_check()")
> but has never been used.
> 
> Remove it.

If you are removing it, it makes more sense to revert the mentioned
commit completely, dropping the third argument of
drm_client_modeset_commit_atomic().

> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> ---
>  drivers/gpu/drm/drm_client_modeset.c | 24 ------------------------
>  include/drm/drm_client.h             |  1 -
>  2 files changed, 25 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_client_modeset.c b/drivers/gpu/drm/drm_client_modeset.c
> index cee5eafbfb81..69e1ce4d18cd 100644
> --- a/drivers/gpu/drm/drm_client_modeset.c
> +++ b/drivers/gpu/drm/drm_client_modeset.c
> @@ -1126,30 +1126,6 @@ static int drm_client_modeset_commit_legacy(struct drm_client_dev *client)
>  	return ret;
>  }
>  
> -/**
> - * drm_client_modeset_check() - Check modeset configuration
> - * @client: DRM client
> - *
> - * Check modeset configuration.
> - *
> - * Returns:
> - * Zero on success or negative error code on failure.
> - */
> -int drm_client_modeset_check(struct drm_client_dev *client)
> -{
> -	int ret;
> -
> -	if (!drm_drv_uses_atomic_modeset(client->dev))
> -		return 0;
> -
> -	mutex_lock(&client->modeset_mutex);
> -	ret = drm_client_modeset_commit_atomic(client, true, true);
> -	mutex_unlock(&client->modeset_mutex);
> -
> -	return ret;
> -}
> -EXPORT_SYMBOL(drm_client_modeset_check);
> -
>  /**
>   * drm_client_modeset_commit_locked() - Force commit CRTC configuration
>   * @client: DRM client
> diff --git a/include/drm/drm_client.h b/include/drm/drm_client.h
> index 560aae47e06d..e1fd32adb3e9 100644
> --- a/include/drm/drm_client.h
> +++ b/include/drm/drm_client.h
> @@ -176,7 +176,6 @@ int drm_client_modeset_create(struct drm_client_dev *client);
>  void drm_client_modeset_free(struct drm_client_dev *client);
>  int drm_client_modeset_probe(struct drm_client_dev *client, unsigned int width, unsigned int height);
>  bool drm_client_rotation(struct drm_mode_set *modeset, unsigned int *rotation);
> -int drm_client_modeset_check(struct drm_client_dev *client);
>  int drm_client_modeset_commit_locked(struct drm_client_dev *client);
>  int drm_client_modeset_commit(struct drm_client_dev *client);
>  int drm_client_modeset_dpms(struct drm_client_dev *client, int mode);
> -- 
> 2.47.0
> 

-- 
With best wishes
Dmitry

