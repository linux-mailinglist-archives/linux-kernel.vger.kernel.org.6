Return-Path: <linux-kernel+bounces-179597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C11028C61EC
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 09:42:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47240B20C27
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 07:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E877C47A79;
	Wed, 15 May 2024 07:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="u7BtW7UB"
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA1744C7C
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 07:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715758962; cv=none; b=Iyki+i8+XwBMDrV5UCMC4FUaxNcJ7uGd8xno3YUBJl5gBK5I1+NppOnNxoQfMrWshet57E+qZr/dNEKPb5x+R6csmkaxgccjQlgnM3Jy+OTCGH/ejYFiVyNQg8eo4AHXtwdzdNCKDPEL/rmxK5OxnGXeKytC3cxwf2eWgLLa38M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715758962; c=relaxed/simple;
	bh=/lXf9EMdKgFFiN6QVKIcKVjgHL3SgOMRUj42IZid6xQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CxcsFvI2RqknDOJug3e/H6UGxfMHv804jAiW/TKI8O2CSR0CMPnPrQbNEbaI9hUVBF1h+fB9vAksEqx+IyWwWB0EhIh7c9bakbyFGterob1FAFaALl8r8Wk6aHu1Fa0yrEgLeLR0ux6SbtZ8KfAlG+5gPSgNL9+kry3gtDMtl5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=u7BtW7UB; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID; bh=vfHb1Zo/IA1k8fG0F3DBZbZF+mjgInSfUd6eUC5m6eY=; b=u7BtW7
	UBbPOFgmU3o940X1jTerj9yTlIVdLFxlq16giF41j/yV1ce09kRLc13Hc3Tgh2TGTmKMHP+HsjncY
	5IxWDpWfYQsP6A76iNyg3meJvSGbuZO8IV/uBYQGLZHoVzm96H0fpXx7NoH6lAS+JC3ARdEEF0Djo
	XUjWBVut+vwy+mT3Ilz0BoiNjyw14PXE4HmxKBqcSnqVRZ0t+Z4LpgTGG+BK5JZTr6DeaF8VnS1Xk
	6litofD7zbwYDH/R0rgII2UDBcYB+Gn91TY2iOGSTu/jz+hUChrtQTBPL6x+3GBz8gadnivvAOKS8
	6kR0DVytUPOqrCQRdzVptqyEGGKQ==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sean@geanix.com>)
	id 1s79HY-000K6q-5d; Wed, 15 May 2024 09:42:36 +0200
Received: from [185.17.218.86] (helo=Seans-MacBook-Pro.local)
	by sslproxy05.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <sean@geanix.com>)
	id 1s79HX-0006vy-2O;
	Wed, 15 May 2024 09:42:35 +0200
Date: Wed, 15 May 2024 09:42:34 +0200
From: Sean Nyekjaer <sean@geanix.com>
To: Yannick FERTRE <yannick.fertre@foss.st.com>
Cc: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>, 
	Philippe Cornu <philippe.cornu@foss.st.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Robert Foss <rfoss@kernel.org>, Antonio Borneo <antonio.borneo@foss.st.com>, 
	dri-devel@lists.freedesktop.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/stm: dsi: relax mode_valid clock tolerance
Message-ID: <44grbp56thhsbxf3i3yicsxgftbuhzebetioxfuibrpw6vbc6l@qqphfke5vgl5>
References: <20240322104732.2327060-1-sean@geanix.com>
 <lkrxoqhcitmvjvzslhx6mrdjaa6lpxtpmdjt7wwollm6z4h65q@jk5esjje6ppy>
 <b58c9073-02c6-4b5e-9082-fb11f388842d@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b58c9073-02c6-4b5e-9082-fb11f388842d@foss.st.com>
X-Authenticated-Sender: sean@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27275/Tue May 14 10:25:55 2024)

On Wed, May 15, 2024 at 08:39:49AM UTC, Yannick FERTRE wrote:
> Hi Sean,
> 
> thanks for your patch.
> 
> Tested-by: Yannick Fertre <yannick.fertre@foss.st.com>
> 
> I think that a helper could be useful in simplifying this part.
> This might be reworked when a new helper will be implemented.
> 
> Best regards

Hi Yannick,

Will this mean that this will patch will go in?

I still have plans to do the helper, but I'm limited on time :)

/Sean

> 
> 
> On 4/22/24 16:05, Sean Nyekjaer wrote:
> > On Fri, Mar 22, 2024 at 11:47:31AM +0100, Sean Nyekjaer wrote:
> > > When using the DSI interface via DSI2LVDS bridge, it seems a bit harsh
> > > to reguire the requested and the actual px clock to be within
> > > 50Hz. A typical LVDS display requires the px clock to be within +-10%.
> > > 
> > > In case for HDMI .5% tolerance is required.
> > > 
> > > Fixes: e01356d18273 ("drm/stm: dsi: provide the implementation of mode_valid()")
> > > Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> > > ---
> > Any feedback on this?
> > 
> > >   drivers/gpu/drm/stm/dw_mipi_dsi-stm.c | 7 +++----
> > >   1 file changed, 3 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/drivers/gpu/drm/stm/dw_mipi_dsi-stm.c b/drivers/gpu/drm/stm/dw_mipi_dsi-stm.c
> > > index d5f8c923d7bc..97936b0ef702 100644
> > > --- a/drivers/gpu/drm/stm/dw_mipi_dsi-stm.c
> > > +++ b/drivers/gpu/drm/stm/dw_mipi_dsi-stm.c
> > > @@ -322,8 +322,6 @@ dw_mipi_dsi_phy_get_timing(void *priv_data, unsigned int lane_mbps,
> > >   	return 0;
> > >   }
> > > -#define CLK_TOLERANCE_HZ 50
> > > -
> > >   static enum drm_mode_status
> > >   dw_mipi_dsi_stm_mode_valid(void *priv_data,
> > >   			   const struct drm_display_mode *mode,
> > > @@ -375,9 +373,10 @@ dw_mipi_dsi_stm_mode_valid(void *priv_data,
> > >   		/*
> > >   		 * Filter modes according to the clock value, particularly useful for
> > >   		 * hdmi modes that require precise pixel clocks.
> > > +		 * Check that px_clock is within .5% tolerance.
> > >   		 */
> > > -		if (px_clock_hz < target_px_clock_hz - CLK_TOLERANCE_HZ ||
> > > -		    px_clock_hz > target_px_clock_hz + CLK_TOLERANCE_HZ)
> > > +		if (px_clock_hz < mult_frac(target_px_clock_hz, 995, 1000) ||
> > > +		    px_clock_hz > mult_frac(target_px_clock_hz, 1005, 1000))
> > >   			return MODE_CLOCK_RANGE;
> > >   		/* sync packets are codes as DSI short packets (4 bytes) */
> > > -- 
> > > 2.44.0
> > > 


