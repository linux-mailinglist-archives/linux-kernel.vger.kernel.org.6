Return-Path: <linux-kernel+bounces-442337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E1339EDB19
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 00:20:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85F781885D7A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 23:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F0DD1F2C39;
	Wed, 11 Dec 2024 23:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k3cwxgTo"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734571F2389
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 23:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733959232; cv=none; b=rGiCVdB77t845+buD6FEG5JAoA5s3z+5+Lubrc1D+DQY0zbJlUi/LyX0YQ/r1Y2YcJnWGTNG/dYRHLgHoLSgeQeAeDUb2+U0fLrrKxrVjTejJdCWa0OjZNy0/64ODfEd9i5KbdDCtDRgDYxYQauljAuYbRD56K0JK3NZ6ekoOLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733959232; c=relaxed/simple;
	bh=oHJZiRt11u911Hcust7mfFsgggmIfJmojIMLjWzLLqI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K8rNQhLw2EsP0eIEmkawLC0e8TFbI5U7RWOLrTT6IZBtl551BtLVdpPGcNqvRxehLdN6nyz4xG76xf49+Nd417FmidjgqLQVGlv4vnjh1d/8D5WqdWHYxQ6JZs8YF5q4frAQYD4e4341ZHJpUNJZ4uELwaNRMTH7ryvKs0pTE44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=k3cwxgTo; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-53e384e3481so4730266e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 15:20:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733959228; x=1734564028; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rdZnIKQ/LHZQhWa+g8bmrkCZc7Dw1lYEQ4CMJReSzdA=;
        b=k3cwxgToG5atXLP75lJUnMaGPjzrDImQL6XYQpF3ViNulAdxAyx9raBHrXi9Cz2VYv
         Lh2qbvnKZ7vV30QdHiXQPgyTEeCwF+vNvV5KDGE6HZDFNF9Cp3+Ca5qWEkEWUnu9D+IZ
         GP0hMswelHRkzf4YM/5AB8Or60e4fBRd48YVR0wssnTnaDi7EVgPUH5NvTb1IcURqaO8
         Szx1UuWv2wFvsbCzP8RwKgp6UywOGYt/lrjFfy0GNtd+RHxKp+5M4jcvpIzeAtATe1gm
         usVLMT+4OLFYy3TfcrYam+niQs1sMkvek8eH/OPv3IuI3N1688m8viKfsmTbwhs8msJM
         h3Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733959228; x=1734564028;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rdZnIKQ/LHZQhWa+g8bmrkCZc7Dw1lYEQ4CMJReSzdA=;
        b=Ez7AB8ui6JMbjRcQ+FrDCxlhj+S/SCjufz26iQAvncQ7Xoi1Utl5ACjsMmS1D3vTxs
         TyyaKaW/hA7UE67WR81dtmUpKoagZwV1Me+r90rCRfY+WUIDeXNSINgsHfYhy0hDme38
         Hj1htlWrI/heyFkuybdSIFt6eXzXhBFONg061iBtCRwX6YmG0eiD7KQtFI/HlGyUE8iY
         ybVGP/YbeolVvkMrlKGlNz8PPhTeMAJxEtHkJILsQwxorKTjURRlGP/ScSHDjQcDJ0Yx
         McjLMNZx3bOLDj1we8ffnbRsWdykR/Z9T75AyNlMCJN1zTdX3kuI4jZE38A88qr409NW
         MtPQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7AcGZGTOp+ZzelMWMuzXrybzGo8bCdf6Pby71h+S6SAeyEH5ZXZmnPItStTFtO8PHV48T3C4eofW/yLI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+ONSj3OkU1Qd0KbMZNIEx/OCDu8xWOnqGdg0liL2Cw3DB7LxR
	HEHYSEbEi9XHfhmEoIsX8GtEqcPhSFV2JJPXUAtJnNt+gFlczXqdLyPm3V+WWyX4axQF4DyIxKg
	FCwXPvg==
X-Gm-Gg: ASbGncvGNGESDoWDWCtIiEoNCMpTAuUGXwshWBylvFmIDwQQ/SBSQTz6KBRbTzFkyGU
	Ngv5jw985B+5ns8Rlgn9V1MX610RQxRAapzTSiK/H3XywDEu3DsEmNZFrdVmrcd5tjBXB57n1PD
	WrCBC2m4rUZBN6QWP+kkSgeDLNj3f01SGvixeFuFjq1xcdw/49Ad/sF/PM8U9pKPu0QyI91jrDg
	W0IrVRwjU9JtghiECzyev5KZuJ18wVkxo2ymZu11cJLaftqXHDXAEXWCZdybo7JWE/eBXG7hZDG
	BrOyRfnTqVHgTKf88NmyyWey+srVngMrCA==
X-Google-Smtp-Source: AGHT+IEQJicMAgPo8nzkfcZiEODI37NW3NL1MWTwEmoAELXOFZY/uswhnYqoKCcWgpFW43WqVKttWQ==
X-Received: by 2002:a05:6512:3092:b0:53f:8c46:42a6 with SMTP id 2adb3069b0e04-5402f0154f1mr385964e87.27.1733959228512;
        Wed, 11 Dec 2024 15:20:28 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53eb12aba45sm1527259e87.33.2024.12.11.15.20.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 15:20:27 -0800 (PST)
Date: Thu, 12 Dec 2024 01:20:24 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Pin-yen Lin <treapking@chromium.org>
Cc: Xin Ji <xji@analogixsemi.com>, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, bliang@analogixsemi.com, 
	qwen@analogixsemi.com, treapking@google.com, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm/bridge:anx7625: Update HDCP status at
 atomic_disable()
Message-ID: <dxczrjwzevtqn4jg7iaanui66hxsmx6gr6yvcm3wbztskweqmy@jyqpt2ntd224>
References: <20241209064632.1705578-1-xji@analogixsemi.com>
 <fy6zvkdidz2srerfq5bshgcshps2wfa4syxwndwesgxcej66ws@nf5svlpkeodh>
 <CAEXTbpeC9DpLxHm2fw7hWKGfpxhUy5ZgHXtGJ0=WSxRrVa845w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEXTbpeC9DpLxHm2fw7hWKGfpxhUy5ZgHXtGJ0=WSxRrVa845w@mail.gmail.com>

On Wed, Dec 11, 2024 at 11:54:54PM +0800, Pin-yen Lin wrote:
> Hi Dimitry,
> 
> Thanks for the review.
> 
> On Wed, Dec 11, 2024 at 5:44 PM Dmitry Baryshkov
> <dmitry.baryshkov@linaro.org> wrote:
> >
> > On Mon, Dec 09, 2024 at 02:46:32PM +0800, Xin Ji wrote:
> > > When user enabled HDCP feature, upper layer will set HDCP content
> > > to DRM_MODE_CONTENT_PROTECTION_DESIRED. Next, anx7625 will update
> > > HDCP content to DRM_MODE_CONTENT_PROTECTION_ENABLED if down stream
> > > support HDCP feature.
> > >
> > > However once HDCP content turn to  DRM_MODE_CONTENT_PROTECTION_ENABLED
> > > upper layer will not update the HDCP content to
> > > DRM_MODE_CONTENT_PROTECTION_UNDESIRED until monitor disconnect.
> >
> > What is "upper layer"? Is it a kernel or a userspace?
> 
> I think Xin meant userspace, but sounds like there are some
> misunderstanding around the HDCP status.
> >
> > >From drm_hdcp_update_content_protection() documentation:
> >
> > No uevent for DESIRED->UNDESIRED or ENABLED->UNDESIRED,
> > as userspace is triggering such state change and kernel performs it without
> > fail.This function update the new state of the property into the connector's
> > state and generate an uevent to notify the userspace.
> >
> >
> > >
> > > So when user dynamic change the display resolution, anx7625 driver must
> > > call drm_hdcp_update_content_protection() to update HDCP content to
> > > DRM_MODE_CONTENT_PROTECTION_UNDESIRED in bridge interface
> > > .atomic_disable().
> >
> > Why?
> >
> > >
> > > Signed-off-by: Xin Ji <xji@analogixsemi.com>
> > > ---
> > >  drivers/gpu/drm/bridge/analogix/anx7625.c | 25 ++++++++++++++++++-----
> > >  1 file changed, 20 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
> > > index a2675b121fe4..a75f519ddcb8 100644
> > > --- a/drivers/gpu/drm/bridge/analogix/anx7625.c
> > > +++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
> > > @@ -861,6 +861,22 @@ static int anx7625_hdcp_disable(struct anx7625_data *ctx)
> > >                                TX_HDCP_CTRL0, ~HARD_AUTH_EN & 0xFF);
> > >  }
> > >
> > > +static void anx7625_hdcp_disable_and_update_cp(struct anx7625_data *ctx)
> > > +{
> > > +     struct device *dev = ctx->dev;
> > > +
> > > +     if (!ctx->connector)
> > > +             return;
> > > +
> > > +     anx7625_hdcp_disable(ctx);
> > > +
> > > +     ctx->hdcp_cp = DRM_MODE_CONTENT_PROTECTION_UNDESIRED;
> > > +     drm_hdcp_update_content_protection(ctx->connector,
> > > +                                        ctx->hdcp_cp);
> > > +
> > > +     dev_dbg(dev, "update CP to UNDESIRE\n");
> > > +}
> > > +
> > >  static int anx7625_hdcp_enable(struct anx7625_data *ctx)
> > >  {
> > >       u8 bcap;
> > > @@ -2165,11 +2181,8 @@ static int anx7625_connector_atomic_check(struct anx7625_data *ctx,
> > >                       dev_err(dev, "current CP is not ENABLED\n");
> > >                       return -EINVAL;
> > >               }
> > > -             anx7625_hdcp_disable(ctx);
> > > -             ctx->hdcp_cp = DRM_MODE_CONTENT_PROTECTION_UNDESIRED;
> > > -             drm_hdcp_update_content_protection(ctx->connector,
> > > -                                                ctx->hdcp_cp);
> > > -             dev_dbg(dev, "update CP to UNDESIRE\n");
> > > +
> > > +             anx7625_hdcp_disable_and_update_cp(ctx);
> >
> > No. atomic_check() MAY NOT perform any changes to the hardware. It might
> > be just a probe from userspace to check if the mode or a particular
> > option can be set in a particular way. There is no guarantee that
> > userspace will even try to commit it.
> 
> So, we should move the hdcp status update from .atomic_check() to
> .atomic_enable() and .atomic_disable(), right? That is, enable HDCP
> for the chip at .atomic_enable() if it is DESIRED and disable it at
> .atomic_disable() if we enabled it previously.

This is one of the options (e.g. used by cdns-mhdp8546). Another option
(i915, amd) is to enable and disable HDCP in atomic_enable() following
selected HDCP state.

> 
> Maybe we can keep some of the checks in .atomic_check(), but I doubt
> if those logics actually make sense.

I think these checks are okay, just move the
anx7625_hdcp_disable_and_update_cp() to a proper place.

> >
> > >       }
> > >
> > >       if (cp == DRM_MODE_CONTENT_PROTECTION_ENABLED) {
> > > @@ -2449,6 +2462,8 @@ static void anx7625_bridge_atomic_disable(struct drm_bridge *bridge,
> > >
> > >       dev_dbg(dev, "drm atomic disable\n");
> > >
> > > +     anx7625_hdcp_disable_and_update_cp(ctx);
> > > +
> > >       ctx->connector = NULL;
> > >       anx7625_dp_stop(ctx);
> > >
> > > --
> > > 2.25.1
> > >
> >
> > --
> > With best wishes
> > Dmitry
> 
> Regards,
> Pin-yen

-- 
With best wishes
Dmitry

