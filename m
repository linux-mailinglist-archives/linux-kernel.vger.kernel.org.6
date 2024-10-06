Return-Path: <linux-kernel+bounces-352488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DDEB991FF0
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 19:32:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 262501F216AC
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 17:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0275E189BA4;
	Sun,  6 Oct 2024 17:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aAhRWZGe"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F26188721
	for <linux-kernel@vger.kernel.org>; Sun,  6 Oct 2024 17:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728235941; cv=none; b=l1Ih7yZw3j3w7exW4RKv9odaz36PwIMOaFzjK4xlW3ii8KKkSykphCiLoujt6PS+RoknVP4E0BKrtA3nJqwmvr3D1zuiM1L/DNgr37DIqoDxX/A/Bpd2g5xvwzvkk1oiTxmXfZ88hOZNsMR7LT21mKz6jg4NGGTLnh4LnaZ5qwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728235941; c=relaxed/simple;
	bh=eH2s1nSiTj3aux4IRTk8hs3hHnOMWonaaoHf+Jgu2FY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gSe7y0jTxJjKxiEAXYLvYUMrn2jSrImCs1CJ2R5h8Dpwp3OchNawkSy6KknxrOSZZiGiMkWEhUzZT1NxJ0+OMctR1me32W09mBvOWN+bd1l6YyjNFSl9/no2eJGkvvzZWPb86pqaPra+4J7CJa3ilQMfxFVrbtk0YT4QlV6p56k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aAhRWZGe; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-53995380bb3so4224080e87.1
        for <linux-kernel@vger.kernel.org>; Sun, 06 Oct 2024 10:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728235937; x=1728840737; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JkkTShwqvEkU2pXAQY0BAtAP+96Mr0a+LcjE8tjGdL0=;
        b=aAhRWZGeENSTvvbPfcy2sI6IVJeZOmrfqs69xqQjeanpzjCaA8A39v6hprFu95SXvR
         K6DLzkeewbHmo2d3XjELwgoZhvIisJ4c25quh8mak2YMErQKrcAQSRz+vRA8Oln91G/5
         mguxX7mRhx1k8rxfX3VKkVleJJ57+2IiOTvVlhjKhOv50Fgb0UWstHsvA+oHr/d+2zp7
         SZa9MTcZVMOKEoSYqxn2wd34k4BUcHMA9BvN8RbKyjpiNcpbOB+/pNnt1yxhSeY1QKfg
         GjOl0fP5EyMxb3enHp2EQecZ9ftLKk5dR18WnLN0NPZ43aIY9zI5XGvgbEo/frUgTvWm
         RSQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728235937; x=1728840737;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JkkTShwqvEkU2pXAQY0BAtAP+96Mr0a+LcjE8tjGdL0=;
        b=GvEyDIXd1fbHEZmenZj2toC9W4Akrapiu3GFj/6+hhOOb901kjOPT/bh9pMG3pioRf
         MYimi6O8LW6eAvd7Eu6a+sjfZEYS7yx2HLgiz6dfbpXsyb1aPu5aaHXNSomCEUZbx3wg
         FuHWZTy41OBnSNnIndfcLBTPa4g9OTh0kb04hVh0cej0ncmc4ydkjNDqma8EL3RBTrJe
         DesnTBH+XwgQtIVcXgxIEfxUE2QeV89S3Z6Yvn/GfGJG78YhigcBFpsg5rRqxl2SlPF0
         /PmLe8BmYQ4sNop6DrDMQ1zuj4EsaNC1bARUPQoBF+OutbTX6bq8HkMlasOFB8h2BRd4
         YHAA==
X-Forwarded-Encrypted: i=1; AJvYcCWZH4gczqdpHCf6KHejD7YUcMnOE38+zoO9H5fm7BRwEqrSwwuT3EKjOv3mhCjgevD4tJ5srMX3yuRLLvY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyF45GI82jtXrtQTnxu+e1725X/dekl6kjWREfxk8KUOKH5aYe3
	6zRmZ0TIBxz2LUouBK/r4yNjQB2zctZBrF6Kt6tu35T/vjy4jZxOa5kr67PEhFA=
X-Google-Smtp-Source: AGHT+IGK8Akt1ah5HhrTyw13URk23TpEFUe03bKEw6dqgLZPPsHuJ6XyU8+xsn5SsbthvxzekZGOIA==
X-Received: by 2002:a05:6512:3c9f:b0:539:8f2d:a3bc with SMTP id 2adb3069b0e04-539ab9ec4c3mr4196367e87.49.1728235936960;
        Sun, 06 Oct 2024 10:32:16 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00-89ea-67f6-92cd-b49.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:89ea:67f6:92cd:b49])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-539aff2336fsm572403e87.203.2024.10.06.10.32.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2024 10:32:16 -0700 (PDT)
Date: Sun, 6 Oct 2024 20:32:15 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Jonathan Marek <jonathan@marek.ca>
Cc: freedreno@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Konrad Dybcio <konradybcio@kernel.org>, 
	"open list:DRM DRIVER for Qualcomm display hardware" <linux-arm-msm@vger.kernel.org>, 
	"open list:DRM DRIVER for Qualcomm display hardware" <dri-devel@lists.freedesktop.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] drm/msm/dsi: improve/fix dsc pclk calculation
Message-ID: <hibhrxq42xoffxa57fckiwbvzjvyzxi4rrtokdpzu533ul3wnb@kas6rhji52mz>
References: <20241005143818.2036-1-jonathan@marek.ca>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241005143818.2036-1-jonathan@marek.ca>

On Sat, Oct 05, 2024 at 10:38:09AM GMT, Jonathan Marek wrote:
> drm_mode_vrefresh() can introduce a large rounding error, avoid it.
> 

Fixes?

> Signed-off-by: Jonathan Marek <jonathan@marek.ca>
> ---
>  drivers/gpu/drm/msm/dsi/dsi_host.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
> index 185d7de0bf376..1205aa398e445 100644
> --- a/drivers/gpu/drm/msm/dsi/dsi_host.c
> +++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
> @@ -542,7 +542,7 @@ static unsigned long dsi_adjust_pclk_for_compression(const struct drm_display_mo
>  
>  	int new_htotal = mode->htotal - mode->hdisplay + new_hdisplay;
>  
> -	return new_htotal * mode->vtotal * drm_mode_vrefresh(mode);
> +	return mult_frac(mode->clock * 1000u, new_htotal, mode->htotal);
>  }
>  
>  static unsigned long dsi_get_pclk_rate(const struct drm_display_mode *mode,
> -- 
> 2.45.1
> 

-- 
With best wishes
Dmitry

