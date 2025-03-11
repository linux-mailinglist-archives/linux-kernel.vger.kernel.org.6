Return-Path: <linux-kernel+bounces-556884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B685EA5CFDB
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 20:49:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 551603A68EC
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 19:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9F37264A89;
	Tue, 11 Mar 2025 19:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sq4SUvLz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C7E264633
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 19:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741722405; cv=none; b=XCKsWw37KQlLjPkES8/w66cuFp6JGo5VV8FZBHn3D1a83u2esC4x2QqjwJb/f0htyCwbnLp2BVMPsY6uP4G1kuL5RLc/yfdD/EIcbXeLxpFTebumw++Im/pCqCIOKFHhrloLWlnnImGcfs6q1ikTyLpqdYFdhQZBWbt9z2VVBqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741722405; c=relaxed/simple;
	bh=FMrHmimwuL7y/rhrAvw0eIdTqLiAViP8PtCNYlWUMFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W15Gacy+mBXZEb426ThZdu8CFcN4xK3ywKAj58M8IYnHIdndFRa18gLKGHA0n/MJVV9gfzJmnOX1AjMyX9pa6gSFiUONxuV+DdJKa4v9uJ9Q5zjScEOiPCW0KJ9LfcVKBWDXpfbiUZEqEUc9Jq9EgPKiW5SP+MWjNanLkQPHRPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sq4SUvLz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46DBCC4CEE9;
	Tue, 11 Mar 2025 19:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741722404;
	bh=FMrHmimwuL7y/rhrAvw0eIdTqLiAViP8PtCNYlWUMFo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sq4SUvLzbyLCoYUV/Yj2NyflNcE26NFzLob9g03G75M01V46rZRGa19PwWa49BQVC
	 4JVqqHby+tRA0TENZ7Iccfb1QDXty8GNH4hutkiQJJP0h205xrgjQcesG4rUND90fW
	 YdFQJQUVxkMaoumIGwwvBBhFf7+c45gat5j7RyIwqW1PYiFTtPTqSGJMRFvcjLHQqN
	 XRtMfCgRLwtubkoSbGDT11mxOmAJwwtGp4FlduhPmgh4L2gz7JIhnf+nOz8j8iGP/u
	 LNcPlURVPEv66luArhD62aLWWqqZIuivmANZpWpycAfJsIc0kxv0drO8ipfACX9DA9
	 kH6DRPFVkQ7KQ==
Date: Tue, 11 Mar 2025 21:46:39 +0200
From: Dmitry Baryshkov <lumag@kernel.org>
To: Maxime Ripard <mripard@kernel.org>
Cc: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Dave Stevenson <dave.stevenson@raspberrypi.com>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	kernel@collabora.com, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/7] drm/connector: hdmi: Use YUV420 output format as
 an RGB fallback
Message-ID: <g25hgb2mocl4sjny26k4nzn2hwpwhlodenqganzcqfzzg6itms@herenniualnw>
References: <20250311-hdmi-conn-yuv-v2-0-fbdb94f02562@collabora.com>
 <20250311-hdmi-conn-yuv-v2-4-fbdb94f02562@collabora.com>
 <20250311-hypersonic-mature-leopard-d3afdc@houat>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250311-hypersonic-mature-leopard-d3afdc@houat>

On Tue, Mar 11, 2025 at 04:55:17PM +0100, Maxime Ripard wrote:
> Hi,
> 
> I think the first thing we need to address is that we will need to
> differentiate between HDMI 1.4 devices and HDMI 2.0.
> 
> It applies to YUV420, which is HDMI 2.0-only, and I guess your patches
> are good enough if you consider YUV420 support only, but scrambler setup
> for example is a thing we want to support in that infrastructure
> eventually, and is conditioned on HDMI 2.0 as well.
> 
> On Tue, Mar 11, 2025 at 12:57:36PM +0200, Cristian Ciocaltea wrote:
> > Try to make use of YUV420 when computing the best output format and
> > RGB cannot be supported for any of the available color depths.
> > 
> > Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> > ---
> >  drivers/gpu/drm/display/drm_hdmi_state_helper.c | 69 +++++++++++++------------
> >  1 file changed, 35 insertions(+), 34 deletions(-)
> > 

[...]

> >  	return -EINVAL;
> >  }
> >  
> > +static int
> > +hdmi_compute_config(const struct drm_connector *connector,
> > +		    struct drm_connector_state *conn_state,
> > +		    const struct drm_display_mode *mode)
> > +{
> > +	unsigned int max_bpc = clamp_t(unsigned int,
> > +				       conn_state->max_bpc,
> > +				       8, connector->max_bpc);
> > +	int ret;
> > +
> > +	ret = hdmi_try_format(connector, conn_state, mode, max_bpc,
> > +			      HDMI_COLORSPACE_RGB);
> > +	if (!ret)
> > +		return 0;
> > +
> > +	if (connector->ycbcr_420_allowed)
> > +		ret = hdmi_try_format(connector, conn_state, mode, max_bpc,
> > +				      HDMI_COLORSPACE_YUV420);
> 
> I think that's conditioned on a few more things:
>   - That the driver supports HDMI 2.0

Isn't that included into connector->ycbcr_420_allowed? I'd expect that
HDMI 1.4-only drivers don't set that flag.

>   - That the display is an HDMI output
>   - That the mode is allowed YUV420 by the sink EDIDs
> 
> > +	else
> > +		drm_dbg_kms(connector->dev,
> > +			    "%s output format not allowed for connector\n",
> > +			    drm_hdmi_connector_get_output_format_name(HDMI_COLORSPACE_YUV420));
> 
> And I think we should keep the catch-all failure message we had.
> 
> Maxime



-- 
With best wishes
Dmitry

