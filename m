Return-Path: <linux-kernel+bounces-183635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03C538C9BBD
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 13:00:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FCDC1C21B4A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 11:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A6B751C30;
	Mon, 20 May 2024 11:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eo6BjmTf"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D386D1643A
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 11:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716202846; cv=none; b=qi3vJ031CKl+x4oQRgjiF2nquo+5VIEaAtJhGD1Q6oLyjblkbJFp95eQDj1/FHRppbkAWMoBkkizhDtCuN4FuTmsJt/VEIjUaeaQsJI9hScwDfj4HwKUFksI+dDsb67bu1D9INUIfgim5eX/Zg2uq27tg0lGBusFEU5HgugHbSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716202846; c=relaxed/simple;
	bh=opqwwImqcKJM//Av+ypRrBQEF3Ht3H8zS8zbCZiPUdY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KworBHTvddbCldDGAGMht2jxinCoFCbXN2kUJKMjZDlUOwAUqSocpv/QV/eNb4sSL2uNpxwM4oD09X93faMSGoECyIKnXpptspvBRORshrNLB6eB4vRyJHNjYn0JmAth4Ilw1M3g+cRhKG9D7ppWdoJdGHZVb+otaGZxJ4Up8C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eo6BjmTf; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-51fdc9af005so5170429e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 04:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716202843; x=1716807643; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zbU3zeRUyfJhQipGYR6FKYCuEp6+mBicTADebou1jyQ=;
        b=eo6BjmTfYsOE7E8NlZiKcPiegr9iaMzhPcVRP4+8vX1xsKfu/MoBv5bq//lMUJyN54
         zbVpbVdh7cmkFuuLdOtSQLrAnnarYO66zMJUpgNCiDhH+4U1/3y62TkWCVIUQKXAjIoZ
         tuhS0gNZA8sIkiUvFd+rX6vQiJPAxqEUcD4H/FqPqK1nvIt6wO80bHUrVhYqFCpmzRKN
         XyCeKmJM1vfWokhGTGxpx35I7PEMv5oj816hlCrZcdSyAffzb7E1eL+n2niuEeKtDBeR
         c/R0xUwV5MAhJnwbgcfoKij1YEhKdZ0HmE0lt3n1eQGkZqnOCjAwmC+VONFPYokuP4dl
         8VQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716202843; x=1716807643;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zbU3zeRUyfJhQipGYR6FKYCuEp6+mBicTADebou1jyQ=;
        b=QQ7aG+Aw0q+laXgap4/nramJHBl7XdwMz8Q0AN9U9r1Pc1x/vah2D5MMzZL/M+zpgZ
         vRuNuN5vR0Gaqt5D/Daueo645KnARwXcHxljqoFWl+MX/qaP9JtFSHxkjwYFOp6nOjfH
         Aeq+6FSW0dXvb4cJx0niyKCUHVIp7Jawwz7EHGr7flJEof5twf4M8pj05y+V3D7c6430
         jCe77eq3shjnzCtMwr6Ht/x1qy3amV5gMP4kbveAoydGKiASEcb9XAWTu1OavQGWgOnu
         gBJ/NTFEPbX9JhIvf1BQHGOSRWHqEH8UJHLRYerMSh+TI50ZNIK3iU6zPMkq84uD19t1
         u0fw==
X-Forwarded-Encrypted: i=1; AJvYcCUGcQkUN1CGSQYoKOYXS7uvJNAukpEQTfTY3V0Sz/arIC5RfZAJOyARixAUROS+OuY4z9pDGV/UKGjth7qRnbOAus8zb6+sK7/BfVZj
X-Gm-Message-State: AOJu0YyFcNOZnSeCnb0DI1Zj51VhefZD4tpnMlye4HnIy3oNzZ5TbkV1
	pyIhdUQN006K1h2jhCszqx8x5JLdMwHiP0UcQL9rmyP4ZzD2ZgNSCHdo8tkwmgI=
X-Google-Smtp-Source: AGHT+IEoP2+bL0oMFj4P0Aa7CMuek/Wx23WK1fJZHUBxVQUK6n4Or8upEK0eOTuockV49z8ZJoyWZA==
X-Received: by 2002:ac2:504c:0:b0:51a:df97:cc8d with SMTP id 2adb3069b0e04-5220fd7cc70mr18338046e87.26.1716202842997;
        Mon, 20 May 2024 04:00:42 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-521f35ad5fdsm4253446e87.24.2024.05.20.04.00.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 04:00:42 -0700 (PDT)
Date: Mon, 20 May 2024 14:00:40 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Vignesh Raman <vignesh.raman@collabora.com>
Cc: dri-devel@lists.freedesktop.org, daniels@collabora.com, 
	helen.koike@collabora.com, airlied@gmail.com, daniel@ffwll.ch, robdclark@gmail.com, 
	david.heidelberg@collabora.com, guilherme.gallo@collabora.com, sergi.blanch.torne@collabora.com, 
	mcanal@igalia.com, linux-mediatek@lists.infradead.org, 
	linux-amlogic@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	amd-gfx@lists.freedesktop.org, linux-arm-msm@vger.kernel.org, intel-gfx@lists.freedesktop.org, 
	virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/6] drm/ci: generate testlist from build
Message-ID: <o363vir3dqz2znrnifo6enbdwudalmxqbigdkci2ykxf5qjbnx@2ngllflxotgk>
References: <20240517092502.647420-1-vignesh.raman@collabora.com>
 <20240517092502.647420-3-vignesh.raman@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240517092502.647420-3-vignesh.raman@collabora.com>

On Fri, May 17, 2024 at 02:54:58PM +0530, Vignesh Raman wrote:
> Stop vendoring the testlist into the kernel. Instead, use the
> testlist from the IGT build to ensure we do not miss renamed
> or newly added tests.
> 
> Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
> ---
> 
> v2:
>   - Fix testlist generation for arm and arm64 builds.
> 
> ---
>  drivers/gpu/drm/ci/build-igt.sh  |   34 +
>  drivers/gpu/drm/ci/igt_runner.sh |    9 +-
>  drivers/gpu/drm/ci/testlist.txt  | 2761 ------------------------------
>  3 files changed, 39 insertions(+), 2765 deletions(-)
>  delete mode 100644 drivers/gpu/drm/ci/testlist.txt
> 
> diff --git a/drivers/gpu/drm/ci/build-igt.sh b/drivers/gpu/drm/ci/build-igt.sh
> index 7859554756c4..e62244728613 100644
> --- a/drivers/gpu/drm/ci/build-igt.sh
> +++ b/drivers/gpu/drm/ci/build-igt.sh

[...]

> @@ -26,6 +50,16 @@ meson build $MESON_OPTIONS $EXTRA_MESON_ARGS
>  ninja -C build -j${FDO_CI_CONCURRENT:-4} || ninja -C build -j 1
>  ninja -C build install
>  
> +if [[ "$KERNEL_ARCH" = "arm64" ]]; then
> +    export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/igt/lib/aarch64-linux-gnu
> +elif [[ "$KERNEL_ARCH" = "arm" ]]; then
> +    export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/igt/lib
> +else
> +    export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/igt/lib64

Could you please clarify this part? The arm64 vs arm don't look logical
from my point of view.

The rest LGTM.

> +fi
> +
> +generate_testlist
> +
>  mkdir -p artifacts/
>  tar -cf artifacts/igt.tar /igt
>  
-- 
With best wishes
Dmitry

