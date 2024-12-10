Return-Path: <linux-kernel+bounces-438664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 070769EA417
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 02:08:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 083EC18835A6
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 01:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62E95224D4;
	Tue, 10 Dec 2024 01:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LwVXzbxd"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E9812E4A
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 01:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733792904; cv=none; b=mZ7YZV74qZVGdoDTzUyAoQkSUn3LrRPnKWU8tPlwyXTQKcNCiSUyp/D1N9V5F/oG4R1kCOQCH0BU+nu5/FNOp36S0uMYp2w/8Q5h68Kqc+CJbny3hTviuclBjtLxi9ljk7LiU8xMSqYk/9WJGnnZ3mrj2ZGnN35L9ybKojfAXqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733792904; c=relaxed/simple;
	bh=PIWd8VPMP31XYl+r2SGvHjZUYUh6vaX3fjfKF+nW1oE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XPc28RZNQ6fU5+akxiLo4QrIFsGlJLDM9T63yY8e3Swkoadkw+AKwxBHWNoWuC8WL1p+SaT+YtO6Gm0Bs8pbGwq720VgjQsSbd1AUgR/QRmNNtBNBhywOC76OI89/8HibwsSpN6L/Oirm2GvOzAPXH1NzKc8e4egcbRls21eJSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LwVXzbxd; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-54020b0dcd2so1359216e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 17:08:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733792901; x=1734397701; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NYIU0x1F0X5vDbNZBSV6aS5bWwBkPV0Ut8+9pSrSb6A=;
        b=LwVXzbxd7VCuz3kGV7+nCzl9xOAqs6rPazFkE4u52NO5ZeEIuCWQDamq71ItvMVtaT
         3R0SxHmnsgS4TOa6e7hSD5L420IkkOYqdxxqhLTAvh9tNFg09V01qyFCLkJJ60SaLnNj
         cYGVWhPuY59xWOeAsB0aoXIDes1bW/OlDp29ahq8MfYimKft/gwsZPMmBfQK9GCC676U
         y74nhuavVZ7ECjcAiu+ItQowfbZEyfdzGruvY7lo5cjYlKpo8+1gcaAEjhzPRwWzo868
         XMyJ/WlUE7qBicXyalY8b8vNQFO2tCxc38eHDnFHxXa/tV9sOcRFOQY+Nnu9trzXEKIm
         cpEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733792901; x=1734397701;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NYIU0x1F0X5vDbNZBSV6aS5bWwBkPV0Ut8+9pSrSb6A=;
        b=Nz90N7Dywp3Cgg63rJ77SL91rfEvFk/HyOS4UdVXtzojnTkRhVom5KijsqVnVIwxNd
         IiCVctQ1/3KiC73/6VPgLxlaAvO3pOIMsXlwgSGQHpRDF+WHxPnfVg0BkPMflJIM9oXJ
         zfL1IQvaT1b00jMa5qcHXcrjnq73Kt5fHinWiBcj7J1byrldgSUwZlSf6lAyY0FIWtUi
         dvQFeryboKUZ7SIz8AkB6SiAf4JdeYMN/CPZVGCKjZFKBFyrG3oV6B2rYSjNkW8LEM6q
         k60hbBbKPWkkJHuWcLaAVGO++fHemsINaIe5QWAtteQNsDfupnCQdfA4c1jrTbEEeL7e
         X2JQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQo83n3/s5kjQu8wPWaOKcZDuOrnqH1FHX0UncGxYxdL6+4vdCLRBaoInFE/I5ZEMma4YRPGYujclCBxo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzp97X+R/ZHBQd9dwowFO/5/yU+rKBRjyTvqXfVOux2Lj7+asLh
	0TrSZMZ5svsD7v5TpmsP7w7vbodDpz/TZeaI5Y7ZnPmDxUP9t6ovhGiW34Dg0w8=
X-Gm-Gg: ASbGncs5lQue3nfP4GsUpV/BrAnjCJjOgnPQIMXiFElQc0yBARmngn9dY2k8S47q/Jb
	+AHqv3Ed3/sQeNr/FWg8vhDfNtosbtWFvWCDLbZoFZOgynW3x7eRLFfH0iAA3WxIn7s6VmVXlRv
	4QNYk5anclq40RkBqB/VTq8nzkvzeuadzS5iTwNeJ2mZoFggf8suxTuyWoLfgSHAsuZVfn6JRWU
	v270VFmRO0um3Ki/p6soYKyzflLe6ZoDUqJBM2uFTaRxUVnx05dSpAhSQYqtLWrxW2+x54cFnBx
	qOod332SxpLDCsWbbZg29rCO0eO40yGuDQ==
X-Google-Smtp-Source: AGHT+IERcWHuH6fbZ1xEEAsxNxRCjKgZMrQp9JNEl00w9VagOlGQ26UNCBzBvV7KmpLmeH4h96niYA==
X-Received: by 2002:a05:6512:2350:b0:53f:a16f:67d5 with SMTP id 2adb3069b0e04-540251ecd9cmr484297e87.16.1733792900776;
        Mon, 09 Dec 2024 17:08:20 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53fe77cd213sm804997e87.36.2024.12.09.17.08.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 17:08:19 -0800 (PST)
Date: Tue, 10 Dec 2024 03:08:17 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Xin Ji <xji@analogixsemi.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, bliang@analogixsemi.com, 
	qwen@analogixsemi.com, treapking@google.com, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm/bridge:anx7625: Update HDCP status at
 atomic_disable()
Message-ID: <fy6zvkdidz2srerfq5bshgcshps2wfa4syxwndwesgxcej66ws@nf5svlpkeodh>
References: <20241209064632.1705578-1-xji@analogixsemi.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209064632.1705578-1-xji@analogixsemi.com>

On Mon, Dec 09, 2024 at 02:46:32PM +0800, Xin Ji wrote:
> When user enabled HDCP feature, upper layer will set HDCP content
> to DRM_MODE_CONTENT_PROTECTION_DESIRED. Next, anx7625 will update
> HDCP content to DRM_MODE_CONTENT_PROTECTION_ENABLED if down stream
> support HDCP feature.
> 
> However once HDCP content turn to  DRM_MODE_CONTENT_PROTECTION_ENABLED
> upper layer will not update the HDCP content to
> DRM_MODE_CONTENT_PROTECTION_UNDESIRED until monitor disconnect.

What is "upper layer"? Is it a kernel or a userspace?

From drm_hdcp_update_content_protection() documentation:

No uevent for DESIRED->UNDESIRED or ENABLED->UNDESIRED,
as userspace is triggering such state change and kernel performs it without
fail.This function update the new state of the property into the connector's
state and generate an uevent to notify the userspace.


> 
> So when user dynamic change the display resolution, anx7625 driver must
> call drm_hdcp_update_content_protection() to update HDCP content to
> DRM_MODE_CONTENT_PROTECTION_UNDESIRED in bridge interface
> .atomic_disable().

Why?

> 
> Signed-off-by: Xin Ji <xji@analogixsemi.com>
> ---
>  drivers/gpu/drm/bridge/analogix/anx7625.c | 25 ++++++++++++++++++-----
>  1 file changed, 20 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
> index a2675b121fe4..a75f519ddcb8 100644
> --- a/drivers/gpu/drm/bridge/analogix/anx7625.c
> +++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
> @@ -861,6 +861,22 @@ static int anx7625_hdcp_disable(struct anx7625_data *ctx)
>  				 TX_HDCP_CTRL0, ~HARD_AUTH_EN & 0xFF);
>  }
>  
> +static void anx7625_hdcp_disable_and_update_cp(struct anx7625_data *ctx)
> +{
> +	struct device *dev = ctx->dev;
> +
> +	if (!ctx->connector)
> +		return;
> +
> +	anx7625_hdcp_disable(ctx);
> +
> +	ctx->hdcp_cp = DRM_MODE_CONTENT_PROTECTION_UNDESIRED;
> +	drm_hdcp_update_content_protection(ctx->connector,
> +					   ctx->hdcp_cp);
> +
> +	dev_dbg(dev, "update CP to UNDESIRE\n");
> +}
> +
>  static int anx7625_hdcp_enable(struct anx7625_data *ctx)
>  {
>  	u8 bcap;
> @@ -2165,11 +2181,8 @@ static int anx7625_connector_atomic_check(struct anx7625_data *ctx,
>  			dev_err(dev, "current CP is not ENABLED\n");
>  			return -EINVAL;
>  		}
> -		anx7625_hdcp_disable(ctx);
> -		ctx->hdcp_cp = DRM_MODE_CONTENT_PROTECTION_UNDESIRED;
> -		drm_hdcp_update_content_protection(ctx->connector,
> -						   ctx->hdcp_cp);
> -		dev_dbg(dev, "update CP to UNDESIRE\n");
> +
> +		anx7625_hdcp_disable_and_update_cp(ctx);

No. atomic_check() MAY NOT perform any changes to the hardware. It might
be just a probe from userspace to check if the mode or a particular
option can be set in a particular way. There is no guarantee that
userspace will even try to commit it.

>  	}
>  
>  	if (cp == DRM_MODE_CONTENT_PROTECTION_ENABLED) {
> @@ -2449,6 +2462,8 @@ static void anx7625_bridge_atomic_disable(struct drm_bridge *bridge,
>  
>  	dev_dbg(dev, "drm atomic disable\n");
>  
> +	anx7625_hdcp_disable_and_update_cp(ctx);
> +
>  	ctx->connector = NULL;
>  	anx7625_dp_stop(ctx);
>  
> -- 
> 2.25.1
> 

-- 
With best wishes
Dmitry

