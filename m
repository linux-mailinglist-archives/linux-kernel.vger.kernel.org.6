Return-Path: <linux-kernel+bounces-391368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42A9E9B85B2
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 22:48:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB05E1F2142E
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 21:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B98981CB51C;
	Thu, 31 Oct 2024 21:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aXahOckG"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D6114A4F9
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 21:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730411280; cv=none; b=GdXxepoBGUBya0kXWFjVNjq4Lc22n3IU3LKjH/SlmD28q8il0ML/P9EXt0UhWAD4+LB3Lh1LiKF4PqakFMlU0PQBcutSffArmmiVCywh/fUItpLdXRNkF9BlnG2Ml+Bb/n5UgsLPVdjzgJO67N+9HdRtEItbXCuIcjKJSKNVKoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730411280; c=relaxed/simple;
	bh=NktlY3tdQyoFrO5VKYFjdUpNklGcTsM11VVrvOHZ8X0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XSML6/wb6SDIkLU08spnmuE6TWFJf8mR/iZC8R/FvDbrBROgCADt8BccsT8INo+cgk0HE50ZvheapHEYVIb4VTmN5+7yfUkd7N/BLQuliBbll1MBMLQpk4lXop0OFATKbSqfbqofpdgseUg+g1uhxqf4BNcxfws9cDwBJN4mRJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aXahOckG; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-539f8490856so1514013e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 14:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730411272; x=1731016072; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=44veBpIl+GX243f33ENVvs6P/c3vJWxcpTOysMsCe2k=;
        b=aXahOckGLTvf2z6+4dkdcE4cK0xZHiS1j4ULJmchNiJDoDrGuLT1EQJ7+q6OoUrTQx
         9tRUOnYKRZJnbr8wVSul2eHvYyEiLg5i7Xt4C/fyee5GSMfPOgdnCct3gYfxTtxGFIaY
         HQT/fE4tff8/dDn0aMtXmiUeCBqr18wARJtQ75fEIQLsLlmBGSvmTWmnoe+qszVEZcQ1
         oFZBKJmMjFtHKPdtBTaHTCV0IjykVtzpldarUPN3Nxf9dXtnqsQ2lsopVdzlYGbrcZZO
         FR2W0SYRPOEhkNpzpWHpW2GWwsnmNu/ioZ41FA5cCn8yEGg9OY3PckjHseF/V+9XU23H
         92ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730411272; x=1731016072;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=44veBpIl+GX243f33ENVvs6P/c3vJWxcpTOysMsCe2k=;
        b=xTq9ifyjz/p3nQT20q7Bdsq0/3praa4oUN6gYItWFG/DBpbR3l10bVBFTpBIqrt+Kc
         kjpFWLq/QXF35D0WElzYQ8NTtLX7sTBvIHs/VmnOCm9ZPw8Nh8MB0os0651ehzxOvJTi
         xHoqVFUb9c7Kpj3kh03Pay6yPJGFyK3tgJuft4LsRsXzdvL5aQAP70MTxhbX9gCD+Ixv
         Pxw/AiogHtKEMyWleJd1AiIxvKfZJuQrKvbpgrpGaBucSRaCuBE2nmAsJGjZk9BUnpTL
         4exjqJ+XH7CS5IzxAteXNillAC3wbjBs8qinrtQ03CRcSzDRpU+f+f8W/RSiPR0471Zu
         RDvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhLSufAeYWpRlXWPqTA68NNksj/MDXarYY9HOkTKy372hknSMga3CoFky4OR2AYabr8CA2dxUItDx0Hs4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBdjIZ/5/MzOtnIDGyRPs5ozsesQ3GxJOrJ+jd4ZIBLdNXH5FO
	R8zku3wj8Mji23C5Gtvp+1wMU92/mEH81L8YKjm/jpkAUCf/mgZ8ozOUrYN7Q4k=
X-Google-Smtp-Source: AGHT+IEIapgg5DVnCXQcCKTJDdnsKNNws2VBmTMX5U5wUyPS2yMtmQ7RGuiNTdd+tOoV+nZ18wQmRA==
X-Received: by 2002:a05:6512:23a1:b0:52e:7ef1:7c6e with SMTP id 2adb3069b0e04-53c79ea57edmr2543415e87.51.1730411271842;
        Thu, 31 Oct 2024 14:47:51 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53c7bde0a53sm336086e87.262.2024.10.31.14.47.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 14:47:50 -0700 (PDT)
Date: Thu, 31 Oct 2024 23:47:47 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: linux@treblig.org
Cc: ville.syrjala@linux.intel.com, jfalempe@redhat.com, 
	tomi.valkeinen@ideasonboard.com, maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
	tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] Revert "drm/client: Add
 drm_client_modeset_check()"
Message-ID: <4ysvn7vcynvmjc53frgj2nwuctf6kd6xdphgfjm3ulgfaxwngm@mod6oqvfmxav>
References: <20241029234706.285087-1-linux@treblig.org>
 <20241029234706.285087-4-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241029234706.285087-4-linux@treblig.org>

On Tue, Oct 29, 2024 at 11:47:05PM +0000, linux@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> drm_client_modeset_check() was explicitly added in 2020 by
> commit 64593f2a6fc9 ("drm/client: Add drm_client_modeset_check()")
> but has never been used.
> 
> This reverts commit 64593f2a6fc933bb9a410bc3f8c261f3e57a9601.

Nit: Usually this comes before the commit message.  No need for repost
though.


Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> ---
>  drivers/gpu/drm/drm_client_modeset.c | 35 ++++------------------------
>  include/drm/drm_client.h             |  1 -
>  2 files changed, 4 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_client_modeset.c b/drivers/gpu/drm/drm_client_modeset.c
> index cee5eafbfb81..39201c11eaac 100644
> --- a/drivers/gpu/drm/drm_client_modeset.c
> +++ b/drivers/gpu/drm/drm_client_modeset.c
> @@ -995,7 +995,7 @@ bool drm_client_rotation(struct drm_mode_set *modeset, unsigned int *rotation)
>  }
>  EXPORT_SYMBOL(drm_client_rotation);
>  
> -static int drm_client_modeset_commit_atomic(struct drm_client_dev *client, bool active, bool check)
> +static int drm_client_modeset_commit_atomic(struct drm_client_dev *client, bool active)
>  {
>  	struct drm_device *dev = client->dev;
>  	struct drm_plane *plane;
> @@ -1062,10 +1062,7 @@ static int drm_client_modeset_commit_atomic(struct drm_client_dev *client, bool
>  		}
>  	}
>  
> -	if (check)
> -		ret = drm_atomic_check_only(state);
> -	else
> -		ret = drm_atomic_commit(state);
> +	ret = drm_atomic_commit(state);
>  
>  out_state:
>  	if (ret == -EDEADLK)
> @@ -1126,30 +1123,6 @@ static int drm_client_modeset_commit_legacy(struct drm_client_dev *client)
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
> @@ -1168,7 +1141,7 @@ int drm_client_modeset_commit_locked(struct drm_client_dev *client)
>  
>  	mutex_lock(&client->modeset_mutex);
>  	if (drm_drv_uses_atomic_modeset(dev))
> -		ret = drm_client_modeset_commit_atomic(client, true, false);
> +		ret = drm_client_modeset_commit_atomic(client, true);
>  	else
>  		ret = drm_client_modeset_commit_legacy(client);
>  	mutex_unlock(&client->modeset_mutex);
> @@ -1246,7 +1219,7 @@ int drm_client_modeset_dpms(struct drm_client_dev *client, int mode)
>  
>  	mutex_lock(&client->modeset_mutex);
>  	if (drm_drv_uses_atomic_modeset(dev))
> -		ret = drm_client_modeset_commit_atomic(client, mode == DRM_MODE_DPMS_ON, false);
> +		ret = drm_client_modeset_commit_atomic(client, mode == DRM_MODE_DPMS_ON);
>  	else
>  		drm_client_modeset_dpms_legacy(client, mode);
>  	mutex_unlock(&client->modeset_mutex);
> diff --git a/include/drm/drm_client.h b/include/drm/drm_client.h
> index bc0e66f9c425..ead3c3526ee3 100644
> --- a/include/drm/drm_client.h
> +++ b/include/drm/drm_client.h
> @@ -177,7 +177,6 @@ int drm_client_modeset_create(struct drm_client_dev *client);
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

