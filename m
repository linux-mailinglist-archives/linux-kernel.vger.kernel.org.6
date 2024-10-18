Return-Path: <linux-kernel+bounces-371967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A1AA9A42BA
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 17:42:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE0AF2815E4
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 15:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E76542022D1;
	Fri, 18 Oct 2024 15:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gdK61BE+"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230991D7E5C
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 15:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729266169; cv=none; b=t0lKa3KT8qrI8KOM0wySJP3+ATw9moZ1D2w4oM939LL0WOLNEWneMAnIe9P36OuHXHjvpqWXf17SMd9qPEq7gKHp/aWuq8Un3g6IJnMy4XOp3WKf7AkKhDnuS3xIEjiwQTGgiiteBq6hY39KmgOrqQfZfXpbV8/KZzAH1aoXoks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729266169; c=relaxed/simple;
	bh=yENcxXm4j3eSz2HK8UNIVUByDS3yuLDlpCk1LO7889U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dlqWJvQDaHos/NbmlvZCCVjw/cAz5nrJll/smxjuOZIS9HRC5fugDZtNT0cjd+awE9rvLzRMRJhLnqoeZp9tmQXwXMDqc4bw5Tm7b1TrDbVpLLJkWq7uJ9cXouKEztQ6EUwClEBXuV6bgpT/wDdRhkfB03MPjxVjwJJXH34Myvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gdK61BE+; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-539fb49c64aso3365546e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 08:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729266165; x=1729870965; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+KgXWbwvllwNby9h+52CbnsES0Bs6ADGLxwcV6e+Fl0=;
        b=gdK61BE+tlfRp4TzSUKZI/YYe9XHXnQB516unBOwSdXKUUwDWtjaUa01W9AYKyLpa9
         HkHeLLZPs9N8Bhdy/xAQVL6+XnvrzdP5xv/c13GtkX5IURPup3jbM88u40YekjUm2RdP
         phg68bZ51EnL72c15DhnxJzK4f/+sTvFoxHixQEJ1GNRLEXwhaPPRoqQ8M68AEodfNPI
         mWzoCtyzwuXPovfnu/YfT3MvNlt5patyU0ni68JrQuGKJeuZsrvR9WnqLFZhmGRUX/0t
         8JMrRghGVgk3BN4KJ6y3mOSPTsert5/2Jg5MH8IB+xZOmdCbaYek8yHPkPSrQWlwTKhs
         7CkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729266165; x=1729870965;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+KgXWbwvllwNby9h+52CbnsES0Bs6ADGLxwcV6e+Fl0=;
        b=AeWTzf9i8xT5fxQZS3WTiYImwVywFucDqjWyh1KqqBFWQ5ZRDs1Vv15zLyiF1vaIhx
         ZSa3RpJDSY1zIMd2ndgYIbPvW7OzdNK/McNY7i5X1CMONJ4zcsKUNP11xmOxO7krRGlY
         79BCYKMPlynm1Em/6gE6um9YdTGEn2z0eeqboqd9aH36jeFwt4IgSAVjROWO8rmN+Vra
         72ePuq7BxzLrAJRpWXdr1JArxFZhjADEJY4xpU9bXRHKWddMftqhR3pwTznY0fEJeNGK
         FV/lWOT76kd592pP5AsopvkJS2ThhzsSoH6NC+GSRmI2IK//l/fh/m8DIcZuphprGNt4
         pr9g==
X-Forwarded-Encrypted: i=1; AJvYcCUFmH4SpyTxRDH93VtLuPSQQQWt7R0xLe/XLUIFVewjp6/5OgVIrui1nsmhaPp0A/XA3EVwcK3Obrte3QA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwluXZKgHqZhymUZyxvI3PZaONwogzypPfu8Uw/lLfGijAuTCu5
	9xu76rnu2oFyc5DNliFjqhcKnOfiboGuDxhr2UbfJ+dcEz1/XoDRjJZjm04Cxg4=
X-Google-Smtp-Source: AGHT+IEeuuG9G4jzrfG5xEM36y99O8znV4/NgHPzm+CH9Ngivs41rsRud7DSIBgnjuOnHFbatE1NCQ==
X-Received: by 2002:a05:6512:1188:b0:539:8f3c:4586 with SMTP id 2adb3069b0e04-53a154da832mr2978133e87.55.1729266165060;
        Fri, 18 Oct 2024 08:42:45 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a151f0e40sm248259e87.121.2024.10.18.08.42.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 08:42:44 -0700 (PDT)
Date: Fri, 18 Oct 2024 18:42:43 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Arnd Bergmann <arnd@arndb.de>, 
	Jani Nikula <jani.nikula@intel.com>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Imre Deak <imre.deak@intel.com>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/bridge-connector: select DRM_DISPLAY_HELPER from
 DRM_BRIDGE_CONNECTOR
Message-ID: <3yqpyobkkvnan4fo5h3vx5jw5ke4zqoavo354rkw7h3frleurn@oag6vpmedaz6>
References: <20241018150850.3418359-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241018150850.3418359-1-arnd@kernel.org>

On Fri, Oct 18, 2024 at 03:08:45PM +0000, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The imx display drivers use the new bridge connector helpers but don't
> explicitly select CONFIG_DRM_DISPLAY_HELPER, leading to a link failure
> in rare configurations:
> 
> ld.lld-20: error: undefined symbol: drm_bridge_connector_init
> >>> referenced by imx-ldb.c
> >>>               drivers/gpu/drm/imx/ipuv3/imx-ldb.o:(imx_ldb_bind) in archive vmlinux.a
> >>> referenced by parallel-display.c
> >>>               drivers/gpu/drm/imx/ipuv3/parallel-display.o:(imx_pd_bind) in archive vmlinux.a
> 
> Move DRM_BRIDGE_CONNECTOR out of the DRM_DISPLAY_HELPER block and
> instead select that symbol indirectly.
> 
> Fixes: f94b9707a1c9 ("drm/imx: parallel-display: switch to imx_legacy_bridge / drm_bridge_connector")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

I think a correct fix is to select DRM_DISPLAY_HELPER instead.

> ---
>  drivers/gpu/drm/display/Kconfig | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/display/Kconfig b/drivers/gpu/drm/display/Kconfig
> index 0f07cf1483ff..beb05d9bab50 100644
> --- a/drivers/gpu/drm/display/Kconfig
> +++ b/drivers/gpu/drm/display/Kconfig
> @@ -11,14 +11,15 @@ config DRM_DISPLAY_HELPER
>  	help
>  	  DRM helpers for display adapters.
>  
> -if DRM_DISPLAY_HELPER
> -
>  config DRM_BRIDGE_CONNECTOR
>  	bool
>  	select DRM_DISPLAY_HDMI_STATE_HELPER
> +	select DRM_DISPLAY_HELPER
>  	help
>  	  DRM connector implementation terminating DRM bridge chains.
>  
> +if DRM_DISPLAY_HELPER
> +
>  config DRM_DISPLAY_DP_AUX_CEC
>  	bool "Enable DisplayPort CEC-Tunneling-over-AUX HDMI support"
>  	select DRM_DISPLAY_DP_HELPER
> -- 
> 2.39.5
> 

-- 
With best wishes
Dmitry

