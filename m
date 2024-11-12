Return-Path: <linux-kernel+bounces-406812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DB6B9C646F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 23:43:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF57D1F234A0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 22:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B54121A6F3;
	Tue, 12 Nov 2024 22:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="ADjiEYLk"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73433217451;
	Tue, 12 Nov 2024 22:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731451428; cv=none; b=JG+KIa2eIsi95sw6OKt501QQcCbmy1071/zf9/6Lk5v+SiE5KYTahlskYFoJp6ltm5hbN+JH+ZU4Kd5lWUhcsMTrNZvqQ0rJmC2Rapu9ajBWYYOVI+l1pFYnTgA5V52eOR+LE29AwGHYICay3/2q+68HM/CFl6YsS67BiYKHU7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731451428; c=relaxed/simple;
	bh=EMVAYLUy4QlCRPX/qBMPyGOPvg4ko/8HnJaHBV8tsdw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kge04f8cPLXlPDOk7XNam3GNV6KiH9PtXjrYWvH3Xbj9kP7HUFm1slnI86/e9QJDyQqoSDlH104K5j+u9nStxqzw4y9WbOLFfnRYGun4ArjkBM5UbRZWhacSnNvLBHqrmcpPBAZ6r4cV2LInZzALFytMmwSiA0vVucsXJf37MKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=ADjiEYLk; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id C2B8A710;
	Tue, 12 Nov 2024 23:43:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1731451411;
	bh=EMVAYLUy4QlCRPX/qBMPyGOPvg4ko/8HnJaHBV8tsdw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ADjiEYLk/sUfhCJwOEVrhHzxaWlqS/f/vxwzxd5Bv8UpKa//7wt2oHPBuTqdkuTpO
	 qBCQ0DJAJTbrOwZOLr0SPw/tWwjqclZvwuLwmgE6sibRmywU1l+BgmX41hG03teQvR
	 849IGAEYOpDag0dXyH3IB9gde538k2r7wykOSODg=
Date: Wed, 13 Nov 2024 00:43:35 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Jagan Teki <jagan@amarulasolutions.com>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>, Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Douglas Anderson <dianders@chromium.org>,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/bridge: Constify struct i2c_device_id
Message-ID: <20241112224335.GA29944@pendragon.ideasonboard.com>
References: <bdba1f49b4b48e22628482b49ce81f8e1f0d97b1.1731445901.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bdba1f49b4b48e22628482b49ce81f8e1f0d97b1.1731445901.git.christophe.jaillet@wanadoo.fr>

Hi Christophe,

Thank you for the patch.

On Tue, Nov 12, 2024 at 10:12:25PM +0100, Christophe JAILLET wrote:
> 'struct i2c_device_id' is not modified in these drivers.
> 
> Constifying this structure moves some data to a read-only section, so
> increase overall security.
> 
> On a x86_64, with allmodconfig, as an example:
> Before:
> ======
>    text	   data	    bss	    dec	    hex	filename
>   15566	    987	     32	  16585	   40c9	drivers/gpu/drm/bridge/chipone-icn6211.o
> 
> After:
> =====
>    text	   data	    bss	    dec	    hex	filename
>   15630	    923	     32	  16585	   40c9	drivers/gpu/drm/bridge/chipone-icn6211.o
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> Compile tested-only.
> ---
>  drivers/gpu/drm/bridge/chipone-icn6211.c   | 2 +-
>  drivers/gpu/drm/bridge/lontium-lt9211.c    | 2 +-
>  drivers/gpu/drm/bridge/lontium-lt9611.c    | 2 +-
>  drivers/gpu/drm/bridge/lontium-lt9611uxc.c | 2 +-
>  drivers/gpu/drm/bridge/ti-sn65dsi83.c      | 2 +-
>  drivers/gpu/drm/bridge/ti-sn65dsi86.c      | 2 +-

While at it, could you address drivers/gpu/drm/i2c/tda9950.c too ? If I
were to push a tad more, there are only two other drivers in the kernel
with the same issues outside of drivers/gpu/ according to

$ git grep '^static struct i2c_device_id'
drivers/gpu/drm/bridge/chipone-icn6211.c:static struct i2c_device_id chipone_i2c_id[] = {
drivers/gpu/drm/bridge/lontium-lt9211.c:static struct i2c_device_id lt9211_id[] = {
drivers/gpu/drm/bridge/lontium-lt9611.c:static struct i2c_device_id lt9611_id[] = {
drivers/gpu/drm/bridge/lontium-lt9611uxc.c:static struct i2c_device_id lt9611uxc_id[] = {
drivers/gpu/drm/bridge/ti-sn65dsi83.c:static struct i2c_device_id sn65dsi83_id[] = {
drivers/gpu/drm/bridge/ti-sn65dsi86.c:static struct i2c_device_id ti_sn65dsi86_id[] = {
drivers/gpu/drm/i2c/tda9950.c:static struct i2c_device_id tda9950_ids[] = {
drivers/input/keyboard/cypress-sf.c:static struct i2c_device_id cypress_sf_id_table[] = {
sound/soc/codecs/cs42l51-i2c.c:static struct i2c_device_id cs42l51_i2c_id[] = {

:-)

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

>  6 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/chipone-icn6211.c b/drivers/gpu/drm/bridge/chipone-icn6211.c
> index 9eecac457dcf..d47703559b0d 100644
> --- a/drivers/gpu/drm/bridge/chipone-icn6211.c
> +++ b/drivers/gpu/drm/bridge/chipone-icn6211.c
> @@ -785,7 +785,7 @@ static struct mipi_dsi_driver chipone_dsi_driver = {
>  	},
>  };
>  
> -static struct i2c_device_id chipone_i2c_id[] = {
> +static const struct i2c_device_id chipone_i2c_id[] = {
>  	{ "chipone,icn6211" },
>  	{},
>  };
> diff --git a/drivers/gpu/drm/bridge/lontium-lt9211.c b/drivers/gpu/drm/bridge/lontium-lt9211.c
> index c8881796fba4..999ddebb832d 100644
> --- a/drivers/gpu/drm/bridge/lontium-lt9211.c
> +++ b/drivers/gpu/drm/bridge/lontium-lt9211.c
> @@ -773,7 +773,7 @@ static void lt9211_remove(struct i2c_client *client)
>  	drm_bridge_remove(&ctx->bridge);
>  }
>  
> -static struct i2c_device_id lt9211_id[] = {
> +static const struct i2c_device_id lt9211_id[] = {
>  	{ "lontium,lt9211" },
>  	{},
>  };
> diff --git a/drivers/gpu/drm/bridge/lontium-lt9611.c b/drivers/gpu/drm/bridge/lontium-lt9611.c
> index 1b31fdebe164..8f25b338a8d8 100644
> --- a/drivers/gpu/drm/bridge/lontium-lt9611.c
> +++ b/drivers/gpu/drm/bridge/lontium-lt9611.c
> @@ -1235,7 +1235,7 @@ static void lt9611_remove(struct i2c_client *client)
>  	of_node_put(lt9611->dsi0_node);
>  }
>  
> -static struct i2c_device_id lt9611_id[] = {
> +static const struct i2c_device_id lt9611_id[] = {
>  	{ "lontium,lt9611", 0 },
>  	{}
>  };
> diff --git a/drivers/gpu/drm/bridge/lontium-lt9611uxc.c b/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
> index 4d1d40e1f1b4..f89af8203c9d 100644
> --- a/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
> +++ b/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
> @@ -913,7 +913,7 @@ static void lt9611uxc_remove(struct i2c_client *client)
>  	of_node_put(lt9611uxc->dsi0_node);
>  }
>  
> -static struct i2c_device_id lt9611uxc_id[] = {
> +static const struct i2c_device_id lt9611uxc_id[] = {
>  	{ "lontium,lt9611uxc", 0 },
>  	{ /* sentinel */ }
>  };
> diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi83.c b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
> index 57a7ed13f996..00d3bfa645f5 100644
> --- a/drivers/gpu/drm/bridge/ti-sn65dsi83.c
> +++ b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
> @@ -732,7 +732,7 @@ static void sn65dsi83_remove(struct i2c_client *client)
>  	drm_bridge_remove(&ctx->bridge);
>  }
>  
> -static struct i2c_device_id sn65dsi83_id[] = {
> +static const struct i2c_device_id sn65dsi83_id[] = {
>  	{ "ti,sn65dsi83", MODEL_SN65DSI83 },
>  	{ "ti,sn65dsi84", MODEL_SN65DSI84 },
>  	{},
> diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> index 9e31f750fd88..ce4c026b064f 100644
> --- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> +++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> @@ -1970,7 +1970,7 @@ static int ti_sn65dsi86_probe(struct i2c_client *client)
>  	return ti_sn65dsi86_add_aux_device(pdata, &pdata->aux_aux, "aux");
>  }
>  
> -static struct i2c_device_id ti_sn65dsi86_id[] = {
> +static const struct i2c_device_id ti_sn65dsi86_id[] = {
>  	{ "ti,sn65dsi86", 0},
>  	{},
>  };

-- 
Regards,

Laurent Pinchart

