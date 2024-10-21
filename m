Return-Path: <linux-kernel+bounces-374478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF1429A6ADB
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 15:45:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F7F31F23E16
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 13:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A4AA1F8900;
	Mon, 21 Oct 2024 13:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AT3Gsfvb"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8FF1F819A
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 13:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729518279; cv=none; b=SSyupaH/LaDfs3NhFm3cI3agGqR4btLxm50dzktiG6ZtUgaQOliFyAimxm+thvskqa3dx/xXitVn5jMJyI2P0Mn+L2uJKNeRq/VB+fq8cbPy76RQYDBIDb5Uti9uNktsTE3CgGb69F+mYq2d0jFidlD/A7GbSMkr3bDi2Stz9OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729518279; c=relaxed/simple;
	bh=kPuLEYWwCH86IGS2zEuCcMab9gc+4AGP/aatGr3hRJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qcv9Z6W++8qOjo2GMTKQVUtj6Pwd+CY3mjGgJ6bYpbrftfkB/VUFUQpWz1PMQqtEVcsy8iL3WN2v1dFfZZgLlQ0UrptmdnrUm/20ZIsSDb67UBVzwRYsggIhIOUgdHE1mqGBzn3TAdJ1nvNXsSl9EeAK48fb2KaPb5hzKmmhjZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AT3Gsfvb; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-53a097aa3daso4216419e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 06:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729518275; x=1730123075; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wA9D1co2BPCyRcKrOGgUmRJb42G/2xnYI/PJRf0sfiI=;
        b=AT3GsfvbPROaXFsIodpn/TacEUJEvtWVgBL6lvGOIM+4l32xLhD/II+yJv+K1tV3wn
         S33JPUdJQjhKoLkCjz70BYth2VReuuTc+LpxEUUNlBj8hs1acYd+cz7VSfkA9UQb8aK6
         laijwC/Dm5W3R4nZi5/Ctz2kQxct/kMIZUypNlR59fRajO7VIyTcfQow+2a0B7c7DkfV
         mq6qs9SrC+AcLJaFZfz4C9Lp97YlDlWvqA/+dnSu7d8yalBMFljYZ99Jr1IQol1g4wRS
         KJ8wbGzVgGrvu5125ATeDkhwqlTaLIqKrpSjeOk7lCmaRCPx3DSNHho2HEKnNPJnBKA7
         fV7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729518275; x=1730123075;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wA9D1co2BPCyRcKrOGgUmRJb42G/2xnYI/PJRf0sfiI=;
        b=H9FjdtipakupqZ8jI5qmYtjrFhr3T6fKpftcYTSOoAOoq73jcClyVQcSOjAa3PdcWZ
         ZXnMLnmiWtG4dljPuGt6rlcXdP8gJ0JN1Ms8k9SPTI7CElMMuF5DwP8Ly2iJvEt6PMC4
         DlV78PwLfiTkbgoRJ7PzTPJ7AMOalg5lOcoKNXAnBz99wWx/Bu5QTI/pkCqsNtfUlAqg
         +/aoRhdNsodXrL2GnGg176PiMMSBKf2gbvPUMre+an+eHKmgmcOMDimlgigpNBE/yKlo
         AK9jGlWPFowX4870KnKEULqye7F49uRSpzc/3ou0d/TP4CiqAEW5MRDD1f/MDrKCNUu/
         ywHg==
X-Forwarded-Encrypted: i=1; AJvYcCVy2J2Ps8o3uGKIxwboZy3G9Pi7Vdn47/GIAEQAWTYSkwjRvPhteRDN9MN7RlQRA/rkmmTMNsHzLnRcPHc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywa2vpi5Sm9y7eiOo1CEqs2/adIlvS2+iOc2EYX9rDOtqDpZvgH
	SdkNM7SRZjNNS3pHqzJqP5v9PT22CTTHWGdii6NmmP8XVyQ1VaLA14tTXj28wqM=
X-Google-Smtp-Source: AGHT+IFXHRDcy85ee1/d4HX6Zxgy37C2+Hq/Nm/Ll9Oqk+925jbxRjDc0fXfRkY9HnW5XrkeyVxUGw==
X-Received: by 2002:a05:6512:2210:b0:539:8d9b:b624 with SMTP id 2adb3069b0e04-53a1547049dmr5031415e87.55.1729518275386;
        Mon, 21 Oct 2024 06:44:35 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a223f0067sm487737e87.81.2024.10.21.06.44.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 06:44:34 -0700 (PDT)
Date: Mon, 21 Oct 2024 16:44:31 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Maxime Ripard <mripard@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Dave Stevenson <dave.stevenson@raspberrypi.com>, =?utf-8?B?TWHDrXJh?= Canal <mcanal@igalia.com>, 
	Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 1/6] drm/display: hdmi: add generic mode_valid helper
Message-ID: <2az2ja5zrd5kw4iusvl23grvrgjcvh7jcyw66kjdsh2gftvmkb@araqcfpv246x>
References: <20241018-hdmi-mode-valid-v1-0-6e49ae4801f7@linaro.org>
 <20241018-hdmi-mode-valid-v1-1-6e49ae4801f7@linaro.org>
 <20241021-chubby-fascinating-labradoodle-144990@houat>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241021-chubby-fascinating-labradoodle-144990@houat>

On Mon, Oct 21, 2024 at 11:32:03AM +0200, Maxime Ripard wrote:
> On Fri, Oct 18, 2024 at 11:34:19PM +0300, Dmitry Baryshkov wrote:
> > Add drm_hdmi_connector_mode_valid(), generic helper for HDMI connectors.
> > It can be either used directly or as a part of the .mode_valid callback.
> > 
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > ---
> >  drivers/gpu/drm/display/drm_hdmi_helper.c | 25 +++++++++++++++++++++++++
> >  include/drm/display/drm_hdmi_helper.h     |  4 ++++
> >  2 files changed, 29 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/display/drm_hdmi_helper.c b/drivers/gpu/drm/display/drm_hdmi_helper.c
> > index 74dd4d01dd9b..0ac5cb000ee2 100644
> > --- a/drivers/gpu/drm/display/drm_hdmi_helper.c
> > +++ b/drivers/gpu/drm/display/drm_hdmi_helper.c
> > @@ -256,3 +256,28 @@ drm_hdmi_compute_mode_clock(const struct drm_display_mode *mode,
> >  	return DIV_ROUND_CLOSEST_ULL(clock * bpc, 8);
> >  }
> >  EXPORT_SYMBOL(drm_hdmi_compute_mode_clock);
> > +
> > +/**
> > + * drm_hdmi_connector_mode_valid() - Check if mode is valid for HDMI connector
> > + * @connector: DRM connector to validate the mode
> > + * @mode: Display mode to validate
> > + *
> > + * Generic .mode_valid implementation for HDMI connectors.
> > + */
> > +enum drm_mode_status
> > +drm_hdmi_connector_mode_valid(const struct drm_connector *connector,
> > +			      const struct drm_display_mode *mode)
> > +{
> > +	const struct drm_connector_hdmi_funcs *funcs = connector->hdmi.funcs;
> > +	unsigned long long rate;
> > +
> > +	rate = drm_hdmi_compute_mode_clock(mode, 8, HDMI_COLORSPACE_RGB);
> > +	if (!rate)
> > +		return MODE_ERROR;
> > +
> > +	if (!funcs || !funcs->tmds_char_rate_valid)
> > +		return MODE_OK;
> > +
> > +	return funcs->tmds_char_rate_valid(connector, mode, rate);
> > +}
> > +EXPORT_SYMBOL(drm_hdmi_connector_mode_valid);
> 
> As discussed in the discussion that sparked that change, I believe that
> we should use hdmi_clock_valid.

Ack, I will modify the code accordingly.

> 
> AFAIU, your concern was that max_tmds_clock might get stale, but then it
> would not only prevent mode_valid from running but also the commit
> entirely.

It might be stale when parsing / validating the modes. But let's try
landing it the way you had in mind and fix the drivers which misbehave
(if any).

> 
> We don't have any evidence from that, so I'd rather try to keep
> consistency between the two. And we can always try to address whatever
> issue we might have if it turned out to be a bad idea :)

-- 
With best wishes
Dmitry

