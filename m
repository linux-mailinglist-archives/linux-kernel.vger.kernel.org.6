Return-Path: <linux-kernel+bounces-188570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D78728CE3AF
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 11:43:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 603811F22E79
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 09:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A79985628;
	Fri, 24 May 2024 09:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="as/fXvSL"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE7785277
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 09:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716543804; cv=none; b=InAeZ2Enif4DZahVb/vUp0WNvid/t9B0zZ0laBfUS657fHHC/YKQxZHTLJY2/Qx33f9X4rzNOOIi+YmEum7auXDZDa0T1zI/yBUmb9uXTxw+0YPaeoduuwrYpvz/DLvJT3OFZb4xaYPCiVoT6dY1Ya41ap6H0bF+8zOhBgSTeuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716543804; c=relaxed/simple;
	bh=HWGnM/wwv3ua6vnMV0Uk/fMv8L7Xpi74FGdXEyduxng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dfdfvrcaeRtocaM4+URH2vZzEbXO2W7amn6vrL83I05JVGSfeqtowQGhOFISJXbOnwVoWP1WNDL55hBqgUPxYIyQH4TKKUfoxc5LXEvOaI3fEjNiV63XkIY6cmBTweMTW5JA6thmbF76UgU8FTXmLU6kNLP48ZIFrlmLtfU5o14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=as/fXvSL; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2e95a1eff78so8389451fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 02:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716543801; x=1717148601; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OsWVQTfT7df58fpSGLkZCtsbCMRflqNxxYlAlGuL/2c=;
        b=as/fXvSL4/PHzm+BrU6xvxoxdstWDJkZAxQUA18lN0JlZP/M4BYfypZnM8llH7Nyzc
         KOhhkm1z9CPnM2Xs7n46M+uA81F0R52FxqNFdM2bIT225ccLookOnB5Vm0p4BdV7gu8D
         tLfT/9/8C0FNWk2dJYsT6TW8c9HWB5C4haU3SHqMFdLg75yWUD7E/ur4pCCHepr17pXQ
         5ZNTwrzVmINJjO2r8SkTfCoDapHGZai+nL3br5LkERfMcoCkjEpeFhhtLRIOMgJlVp4v
         PHXM2pKOV7wlZzJJea89ULJL8Z+KtrHrXK/4HvNgJ1pIBfY9+RxkNSTzsPA81ltC8fAX
         EsOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716543801; x=1717148601;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OsWVQTfT7df58fpSGLkZCtsbCMRflqNxxYlAlGuL/2c=;
        b=KS/wr1yix1+hpFugG4aMJuAD2cbLCzxQOtgzPsulHWy01pQroEXW2NNBmj6A5TCfOv
         vIPGjscm8KCMzqaNNvFuJbCtIMCLx19COPz7gdQ0OZeE84WQvjLaoYwvquFivd4IUZlt
         a9pzFvREQgX5ViVMGCNvhMXcawfwKFEMqko6XNhx+Lr8Ept0NJGqH4UxxLsmjmGfDUk0
         KArakT39/1+TW1wF0pPb0Hbyit5cCX3/p+pX100Dwwt9Cf4HSVwJ4/4uNYN+a3dq/RQD
         A2ItFaopStbai5iD4pokaNFbBXbmMtBxmJ2GSrb2IVHXBBhLn4tT/3a20nFlsd5VXRMF
         h5Nw==
X-Gm-Message-State: AOJu0YyK5ltv4dr7JGWqS6P/jtKuIbAv4bFMYba7Qy3cg3bBxfLx1XXD
	ngHzfxpU/MFLAMYouE2wBug8twP9aaPKx4nv3dZjfMdMnKjDCTYWj2AdtPuxDk4=
X-Google-Smtp-Source: AGHT+IEgvRjNTdAczPMN3IxHxRGtpPDjB3IaHz1XVZx83tnK5mdnWEeYaN9YImeJHMTSymEhtPrY4g==
X-Received: by 2002:a2e:2c19:0:b0:2e9:564a:db29 with SMTP id 38308e7fff4ca-2e95b0c4da4mr16297911fa.29.1716543800699;
        Fri, 24 May 2024 02:43:20 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2e95bdcd21esm1211721fa.100.2024.05.24.02.43.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 02:43:20 -0700 (PDT)
Date: Fri, 24 May 2024 12:43:18 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Jayesh Choudhary <j-choudhary@ti.com>
Cc: linux-kernel@vger.kernel.org, andrzej.hajda@intel.com, 
	neil.armstrong@linaro.org, rfoss@kernel.org, Laurent.pinchart@ideasonboard.com, 
	mripard@kernel.org, dri-devel@lists.freedesktop.org, jonas@kwiboo.se, 
	jernej.skrabec@gmail.com, maarten.lankhorst@linux.intel.com, tzimmermann@suse.de, 
	airlied@gmail.com, daniel@ffwll.ch, u.kleine-koenig@pengutronix.de, 
	a-bhatia1@ti.com, javierm@redhat.com, nikhil.nd@ti.com, jani.nikula@intel.com, 
	amishin@t-argos.ru
Subject: Re: [PATCH] drm: bridge: cdns-mhdp8546: Add mode_valid hook for the
 drm_bridge_funcs
Message-ID: <unpyokzp44mxbycjam375zp3xhxz4vtrhjbafg2hnwycm6e3g3@ywv6hwkdenlz>
References: <20240524071348.106210-1-j-choudhary@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240524071348.106210-1-j-choudhary@ti.com>

On Fri, May 24, 2024 at 12:43:48PM +0530, Jayesh Choudhary wrote:
> With the support for the 'DRM_BRIDGE_ATTACH_NO_CONNECTOR' case,
> the connector_helper funcs are not initialized if the encoder has this
> flag in its bridge_attach call. Till now we had mode_valid hook only in
> the drm_connector_helper_funcs. Add this hook in drm_bridge_funcs to
> validate the modes in this case as well.
> 
> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
> ---
>  .../drm/bridge/cadence/cdns-mhdp8546-core.c   | 31 +++++++++++++++----
>  1 file changed, 25 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
> index 8a91ef0ae065..0aee038f5db7 100644
> --- a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
> +++ b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
> @@ -1617,12 +1617,10 @@ bool cdns_mhdp_bandwidth_ok(struct cdns_mhdp_device *mhdp,
>  	return true;
>  }
>  
> -static
> -enum drm_mode_status cdns_mhdp_mode_valid(struct drm_connector *conn,
> -					  struct drm_display_mode *mode)
> +static enum
> +drm_mode_status cdns_mhdp_mode_valid(struct cdns_mhdp_device *mhdp,
> +				     const struct drm_display_mode *mode)
>  {
> -	struct cdns_mhdp_device *mhdp = connector_to_mhdp(conn);
> -
>  	mutex_lock(&mhdp->link_mutex);
>  
>  	if (!cdns_mhdp_bandwidth_ok(mhdp, mode, mhdp->link.num_lanes,
> @@ -1635,6 +1633,16 @@ enum drm_mode_status cdns_mhdp_mode_valid(struct drm_connector *conn,
>  	return MODE_OK;
>  }
>  
> +static enum drm_mode_status
> +cdns_mhdp_connector_mode_valid(struct drm_connector *conn,
> +			       struct drm_display_mode *mode)
> +{
> +	struct cdns_mhdp_device *mhdp = connector_to_mhdp(conn);
> +	const struct drm_display_mode *mod = mode;
> +
> +	return cdns_mhdp_mode_valid(mhdp, mod);
> +}
> +
>  static int cdns_mhdp_connector_atomic_check(struct drm_connector *conn,
>  					    struct drm_atomic_state *state)
>  {
> @@ -1678,7 +1686,7 @@ static int cdns_mhdp_connector_atomic_check(struct drm_connector *conn,
>  static const struct drm_connector_helper_funcs cdns_mhdp_conn_helper_funcs = {
>  	.detect_ctx = cdns_mhdp_connector_detect,
>  	.get_modes = cdns_mhdp_get_modes,
> -	.mode_valid = cdns_mhdp_mode_valid,
> +	.mode_valid = cdns_mhdp_connector_mode_valid,

Just move it to bridge_funcs and drop it from connector_helper_funcs. It
should be enough.

>  	.atomic_check = cdns_mhdp_connector_atomic_check,
>  };
>  
> @@ -2233,6 +2241,16 @@ static const struct drm_edid *cdns_mhdp_bridge_edid_read(struct drm_bridge *brid
>  	return cdns_mhdp_edid_read(mhdp, connector);
>  }
>  
> +static enum drm_mode_status
> +cdns_mhdp_bridge_mode_valid(struct drm_bridge *bridge,
> +			    const struct drm_display_info *info,
> +			    const struct drm_display_mode *mode)
> +{
> +	struct cdns_mhdp_device *mhdp = bridge_to_mhdp(bridge);
> +
> +	return cdns_mhdp_mode_valid(mhdp, mode);
> +}
> +
>  static const struct drm_bridge_funcs cdns_mhdp_bridge_funcs = {
>  	.atomic_enable = cdns_mhdp_atomic_enable,
>  	.atomic_disable = cdns_mhdp_atomic_disable,
> @@ -2247,6 +2265,7 @@ static const struct drm_bridge_funcs cdns_mhdp_bridge_funcs = {
>  	.edid_read = cdns_mhdp_bridge_edid_read,
>  	.hpd_enable = cdns_mhdp_bridge_hpd_enable,
>  	.hpd_disable = cdns_mhdp_bridge_hpd_disable,
> +	.mode_valid = cdns_mhdp_bridge_mode_valid,
>  };
>  
>  static bool cdns_mhdp_detect_hpd(struct cdns_mhdp_device *mhdp, bool *hpd_pulse)
> -- 
> 2.25.1
> 

-- 
With best wishes
Dmitry

