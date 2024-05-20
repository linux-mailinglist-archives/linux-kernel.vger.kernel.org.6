Return-Path: <linux-kernel+bounces-183622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 506568C9B8D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 12:43:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B660281535
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 10:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D50A524C4;
	Mon, 20 May 2024 10:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Jjevzvox"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D225F51C28
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 10:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716201810; cv=none; b=lqcYDR6BulgZNCjNuBtphYHWzvUKkWfu6eyZkPOMc5nrX082BMbUM5ifH4sHEh1r77KEkmm7ZKphFA7iwZP2CYOwcFdTy+2O1f1sz1Tn87tu/w7oJY1rGh6HH4ha0JY3yV+7NdunlXClj964g6H0SbwyZzu61vKUFODBaM/vIAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716201810; c=relaxed/simple;
	bh=Iz9ztzUrzHwU28kEfAv2CoCZ/02g4GuMeMy9kUlFIHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iJ7ejVPY+kE1fYCCZHdU2mHFkEpt9RFnTAqApSLobvkvNDF42jpkCt/AJCIohINF3BD87DxiH/Q5Kw/tnpD46FNzNROZP7XT8JzYtAd+6Fo1chs18enQDMa2VtEv9gptNQZO69mijB3kNNiWXeBiRcX21aapjFFI3A597Xv46Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Jjevzvox; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5238fe0cfc9so2405304e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 03:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716201807; x=1716806607; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=icwVF42TmZ2hZjEXcduZvhpSy5tVelIfuJSjSBSENHo=;
        b=JjevzvoxGXMN/CsZU5tmAFIdRnE096bNWj6r84plZJljWfyPHFwe5QP70aIm5F5sTW
         6NcgLFLpXBtUqPmg/4sk5Lmn8tFwsx/0S/cGCNXsmOO2PQ6h8J54x5ZeyYXy89TTU5Iz
         RjF6yR+QZnLQjl230ckniBWVOBEJlYuY5//LnVOs+KxGWA3Zr/grvYQUACbLN+V6E3Yr
         lIzPiVw8d4O4heYAtRkFdbVGDHeyibZs/KRtugcTp9RO9ls29a8zLKN8RKzz9c1nYlXn
         3es76vaLZYho8/6ZP5DoNT5bvaPYGfvEOKo7OBMChyVFXoe807h2KVLTk5GdTQ0WPijm
         4OuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716201807; x=1716806607;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=icwVF42TmZ2hZjEXcduZvhpSy5tVelIfuJSjSBSENHo=;
        b=XQYlLUPl/uZxFkxA+hRQtNIqx3jH02uiR5Z98n98o38ALcBegK1xK6JMrohRr2GRjN
         bzzO8F7rhzxDAF/CmFoDJxstJICzae2jmTT8pmWCVJuyrw3VeIhGORMnQAHqN2fpHvLe
         W28ScE94lJwPWW7QUYM6i1bNdkrvit5Y88/d6mKgDCrPF/cQdqZY4fsYqj/JqsQHn/iL
         P7eRxI1WqbcyTy/WSYqrVsZHirj9xtS9XbsQCdMHkL8n07hQMUGeq8EgVuKjd+gFv445
         zSH8bBWlbFhY69hr4Cl+HSGR7MC5wISBKEsMEX/d2ai37hjSyH7ZWX9c6JG8mA+zxw+m
         +yUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXrReSl+X7VSCw/19zKH/o1MpZU0UFKHc/UJUX831hNtajBXsOpc7hufLa6MIU4r0ta1s5JB4lxmPxgIt9xDttvfJyCsstyqCh/Br7
X-Gm-Message-State: AOJu0YxKr2ndk4F1mceHvSJKX0gCPYSDlS+13YJgH0Li3oheZ+2UtnVm
	oLve+xXXd7HCQj4+af0WozeGzdzzx3IRNXBW0LvqxnfKULx5MSPuCB20LIm55rU=
X-Google-Smtp-Source: AGHT+IFzot8n6xHV0OHm6wH4k0sEr+LYxBLD0eD+umJwBs/mAovf2bSRWjBos0WaEoAs2a0risJ1Ww==
X-Received: by 2002:a05:6512:4801:b0:51d:8ff3:f835 with SMTP id 2adb3069b0e04-52407cddc3fmr1595444e87.26.1716201806986;
        Mon, 20 May 2024 03:43:26 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5238bee41afsm2044239e87.294.2024.05.20.03.43.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 03:43:26 -0700 (PDT)
Date: Mon, 20 May 2024 13:43:24 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Vignesh Raman <vignesh.raman@collabora.com>
Cc: dri-devel@lists.freedesktop.org, daniels@collabora.com, 
	helen.koike@collabora.com, airlied@gmail.com, daniel@ffwll.ch, robdclark@gmail.com, 
	david.heidelberg@collabora.com, guilherme.gallo@collabora.com, sergi.blanch.torne@collabora.com, 
	mcanal@igalia.com, linux-mediatek@lists.infradead.org, 
	linux-amlogic@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	amd-gfx@lists.freedesktop.org, linux-arm-msm@vger.kernel.org, intel-gfx@lists.freedesktop.org, 
	virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/6] drm/ci: uprev mesa version
Message-ID: <2qzmfv3oc6feihwxu3tl37rg6w3qsj2vddu5olvqk6vhqr26cc@bxu5y6ijvtfa>
References: <20240517092502.647420-1-vignesh.raman@collabora.com>
 <20240517092502.647420-2-vignesh.raman@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240517092502.647420-2-vignesh.raman@collabora.com>

On Fri, May 17, 2024 at 02:54:57PM +0530, Vignesh Raman wrote:
> zlib.net is not allowing tarball download anymore and results
> in below error in kernel+rootfs_arm32 container build,
> urllib.error.HTTPError: HTTP Error 403: Forbidden
> urllib.error.HTTPError: HTTP Error 415: Unsupported Media Type
> 
> Uprev mesa to latest version which includes a fix for this issue.
> https://gitlab.freedesktop.org/mesa/mesa/-/commit/908f444e
> 
> Use id_tokens for JWT authentication. Since s3 bucket is migrated to
> mesa-rootfs, update the variables accordingly. Also copy helper scripts
> to install, so that the ci jobs can use these scripts for logging.
> 
> Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
> ---
> 
> v2:
>   - Uprev to recent version and use id_tokens for JWT authentication
> 
> ---
>  drivers/gpu/drm/ci/build-igt.sh   |  2 +-
>  drivers/gpu/drm/ci/build.sh       |  6 +++--
>  drivers/gpu/drm/ci/container.yml  | 12 +++------
>  drivers/gpu/drm/ci/gitlab-ci.yml  | 44 +++++++++++++++++++++----------
>  drivers/gpu/drm/ci/image-tags.yml |  2 +-
>  drivers/gpu/drm/ci/lava-submit.sh |  4 +--
>  drivers/gpu/drm/ci/test.yml       |  2 ++
>  7 files changed, 44 insertions(+), 28 deletions(-)
> 

[skipped]

> diff --git a/drivers/gpu/drm/ci/test.yml b/drivers/gpu/drm/ci/test.yml
> index 8bc63912fddb..612c9ede3507 100644
> --- a/drivers/gpu/drm/ci/test.yml
> +++ b/drivers/gpu/drm/ci/test.yml
> @@ -150,6 +150,8 @@ msm:sdm845:
>      BM_KERNEL: https://${PIPELINE_ARTIFACTS_BASE}/arm64/cheza-kernel
>      GPU_VERSION: sdm845
>      RUNNER_TAG: google-freedreno-cheza
> +    DEVICE_TYPE: sdm845-cheza-r3
> +    FARM: google

I see that this is the only user of the FARM: tag. Is it correct?
Also we miss DEVICE_TYPE for several other boards. Should we be adding
them?

>    script:
>      - ./install/bare-metal/cros-servo.sh
>  
> -- 
> 2.40.1
> 

-- 
With best wishes
Dmitry

