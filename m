Return-Path: <linux-kernel+bounces-224490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B94CD912310
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 13:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C98E1F232B1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 11:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A188495E5;
	Fri, 21 Jun 2024 11:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P5QCmarH"
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB5A171679
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 11:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718968233; cv=none; b=tWtP7l92U/3MrHeX0ktefht15TjYyWQYF0NDOSh1xV27n2QyZ50oDFhIm3cx6dSQphn8OhnpR5HNp1S55yPa6sy1jRCva2iT175hU2O7ACNKAXAbF0W1juyFKmPWHE3fYVi80r9n73N99GvO2etzsOZyw180wonPio09EWu8utM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718968233; c=relaxed/simple;
	bh=tU0sblYbVCUHXuQAGr9IvIi+QR/cG41+CU64pAQS0RU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oi49+caShjwgKbPHhYoDeV7D3gu/PjqGGJBqGWoRw6HpP3LBY6Arbz83w610bvAUp9R+JgFbawsmtKLuxs9l/elqDkShb2Lrh0E4gv/zuSQ/0odh0TsowX8LNMR1z8Z5XLVc8GqqyvywSArYxd4tvYNrfjkvaQu7sV8i1elDUzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=P5QCmarH; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-62cddff7f20so18072207b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 04:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718968231; x=1719573031; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+E1WxQueOjtD6kE6cKZDHDBQDZbZc1l4ovt0rekH1Kw=;
        b=P5QCmarH/+ErmF3tzpPQ+5MID6QuMUwzEQvk5zlm+KGDuBZFx6fR5i+Ube3uxek3pf
         LTulbKlPRkxsZwEGH8gcCSTdM9RO9m580vHeEW/sfSVdtdarBP/mYlYb1IcjbqLoYxWT
         +5yvdm2z7501SfN9jU3DuDRZiK9ObmWGAJVt4AXn2FvvS4t1MVR5YlYCEpBnRW57rQBE
         9lJKu1EcDEF3OPotEq7SXL6CzHdAMAg+T/i/BClcSSOCoHadMege3EFF6PekisfBIyW0
         RrbWzbqXJJ3IJlBGP+drAh+kUmgHn+tRW3HUwnLCOcsx/SQQPDczKqRYsPRjWFpehdZT
         qdcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718968231; x=1719573031;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+E1WxQueOjtD6kE6cKZDHDBQDZbZc1l4ovt0rekH1Kw=;
        b=kNRiV6u8d54i5/nxDVyqyhsNqwFyhA5CDw0bDR/7rXW6mqKhOBzNReidSrXkFpolbm
         1HJs1eZLHjQ89QbzZA3EeflWa94OuNjwYVQ0ybw6rvl8IXOe7/LKhOhdNyagCgMmg9W+
         IOdpy2qgWVzUn8ps6Qzs9Nl7/R2PM4cpulXmzfb7lg2Aep9OUOovAGP4hzOFh21Q27SJ
         i6l9cGoBCKTxf1Ib1gf+h0sB5t0IdVR3+DE0+GQzP92SXHGBqZ0/7g7QjeLXgWPAHwSH
         rY+L//SYlNIWd3VOYLxRoQG07VrLXqhL7zxx4OjaM6CFde3Uyh4gRQLhC2AjcEs6Jy1x
         4iRQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHQj9uZJHW/Q1dxdUtZxJMAMbdRwJj7RUqBnBHTw9hW0z8hcNjPEVUbgsBTKi9ywudprLe9jUPlKijcT99cK1tzZ9hsUZrbYa8FFD/
X-Gm-Message-State: AOJu0YxK9pOyfx8cYmrtz21mzB2lFM5P4WmCih+Gv6FvI8gGW/9IVQfi
	k/1sUt9ok6lGggQoWFcLWAqeeVLBWhTjH2kmHPBuh+4pMCeTDWK5iMESOf/iiNeddbasj6UKp/P
	W2TnTRN+o2TCUgcqpQCL/KNemoo4szrh7eH/q7g==
X-Google-Smtp-Source: AGHT+IEXBAmA+PTZy09VnQ1dqNH8zl9QK3W3FwghMXSXtL+Qdc/ocbqK9PhCE4rLdN/ODpaYb6SHS4FV15K0wd/rI4s=
X-Received: by 2002:a81:87c6:0:b0:622:c964:7e24 with SMTP id
 00721157ae682-63a8e89bed9mr75983307b3.27.1718968230585; Fri, 21 Jun 2024
 04:10:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240615-drm-bridge-hdmi-connector-v1-0-d59fc7865ab2@linaro.org>
 <20240615-drm-bridge-hdmi-connector-v1-4-d59fc7865ab2@linaro.org> <20240621-polite-ruby-hyrax-c4020e@houat>
In-Reply-To: <20240621-polite-ruby-hyrax-c4020e@houat>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 21 Jun 2024 14:10:22 +0300
Message-ID: <CAA8EJppryh=LR40_5cBH5+0LZdRP5bsZ9iyqHDBFdBqu_H=1=A@mail.gmail.com>
Subject: Re: [PATCH RFC 4/5] drm/bridge: connector: add support for HDMI codec framework
To: Maxime Ripard <mripard@kernel.org>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Jaroslav Kysela <perex@perex.cz>, 
	Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	linux-sound@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 21 Jun 2024 at 12:30, Maxime Ripard <mripard@kernel.org> wrote:
>
> On Sat, Jun 15, 2024 at 08:53:33PM GMT, Dmitry Baryshkov wrote:
> > Add necessary glue code to be able to use new HDMI codec framework from
> > the DRM bridge drivers. The drm_bridge implements a limited set of the
> > hdmi_codec_ops interface, with the functions accepting both
> > drm_connector and drm_bridge instead of just a generic void pointer.
> >
> > This framework is integrated with the DRM HDMI Connector framework, but
> > can also be used for DisplayPort connectors.
> >
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > ---
> >  drivers/gpu/drm/drm_bridge_connector.c | 130 ++++++++++++++++++++++++++++++++-
> >  include/drm/drm_bridge.h               |  46 ++++++++++++
> >  2 files changed, 174 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/drm_bridge_connector.c b/drivers/gpu/drm/drm_bridge_connector.c
> > index 0869b663f17e..71d6fdc2391f 100644
> > --- a/drivers/gpu/drm/drm_bridge_connector.c
> > +++ b/drivers/gpu/drm/drm_bridge_connector.c
> > @@ -20,6 +20,8 @@
> >  #include <drm/drm_probe_helper.h>
> >  #include <drm/display/drm_hdmi_state_helper.h>
> >
> > +#include <sound/hdmi-codec.h>
> > +
> >  /**
> >   * DOC: overview
> >   *
> > @@ -95,6 +97,14 @@ struct drm_bridge_connector {
> >        * HDMI connector infrastructure, if any (see &DRM_BRIDGE_OP_HDMI).
> >        */
> >       struct drm_bridge *bridge_hdmi;
> > +     /**
> > +      * @bridge_hdmi_codec:
> > +      *
> > +      * The bridge in the chain that implements necessary support for the
> > +      * HDMI Audio Codec infrastructure, if any (see
> > +      * &DRM_BRIDGE_OP_HDMI_CODEC).
> > +      */
> > +     struct drm_bridge *bridge_hdmi_codec;
>
> Can we have a setup where one bridge would support the video stream and
> another one the audio?
>
> I think for now I'd rather make them both provided by the same bridge,
> and we can always change that later on if we need to.

The same point here (and for your second comment): DisplayPort audio support.

-- 
With best wishes
Dmitry

