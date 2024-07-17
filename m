Return-Path: <linux-kernel+bounces-255040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F3A933AE8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 12:08:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3486B1F2338F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 10:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F4A217E915;
	Wed, 17 Jul 2024 10:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FB7y2PxQ"
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7637157A5B
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 10:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721210855; cv=none; b=puicQFV9kxQwdMAKaf8vZukGVhvsyndpRhgJq+n8kFwjl2+4GAgFkc8H055tj2P5XjR2T0ywOJDe/aTgFI9T7sEpFALfEBoGAVuVnZ/xsqSs2aqlju8GfUGWzexvv7tCDv8jyWBUniWAPjJeornWMhRn+kbkiz+mx2dE2vVZMG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721210855; c=relaxed/simple;
	bh=N25FP7TvOgXONsgo6Q/FwqUi16Iwa+P8KpZGR+wN1B8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iiCsd1sxitSbsA4BcyRTkV2gj7Kw5s3yHIJHvgC7ZvyGYxbnwBtbGZkYqqvwmI9EIwLcqPHfP0Dx0YxdMzanjKdYCb3k2aN4Ae1eBUrEnUC/Rkyu1c3KrEQs3JlrsyXneRMIHa0N4GzqPWvyJ6VGRHGHRJkA0UbK/jSmmQY8Q7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FB7y2PxQ; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e05ecb3dbf6so524519276.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 03:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721210853; x=1721815653; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iiFPGR0gU3k4tCZTtBUGT3nSA1nwJ4HhDZsrK4BmglM=;
        b=FB7y2PxQGgmCUxpoe4baukaHOjSWDoH43ZgRMlbrjYRD2be2PxCYT7Ujl2iM//OQby
         7Zk1XMWQEEfA9KVYarpb3S7vaKCQCN+R2FdCUCdTY+FrkPaS8t4Kfrk4ZQ/WOhjTI/d6
         +RrrGGv9gemDPDzKE2yM6vAvvqZ2+25H3jO1pGQKHKGyJb+VD4MYDvi6JrduXO6u8TKE
         VY6tNqTMWHV0Df7IRgjYnDu049WlBdYYpkarmBvqyoMXHRUxv05rwBx9jocuo68VWKH9
         goVJz5aLdE7/NOd4ipXRkF25Mn77SMFJ3ZmOLmkuaIYkBXNhhWVQ07Vxhj0sxwChSaGA
         wVmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721210853; x=1721815653;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iiFPGR0gU3k4tCZTtBUGT3nSA1nwJ4HhDZsrK4BmglM=;
        b=aPMQCQj7ytz/LI1OzfWjEAx9rmYuz+B1zYUWqOqqrOBlwfFP44+B+Wbkh2ZLZlksI0
         dm4iQhCCy3Jq3Tmabx8AbQPHfagFaAgGp/hVNWifE0KGoVsqBX1cWmhpccIbWb+ekabx
         XzZiHZYzzbcDPGMffw2748+wOakQJwpaqa2XKh0Z4ArL9pFOgXHlV62R7xPZwE1Gaq3a
         icPM0eCpE31UOcHQHR6byEFJ5/sacDsZf8HYFvx6Kpvjl1UAT1VztYAG3tiFEcyNSFMh
         r//wrn3oL19rxxJczcA/UMmqhU/p/gzp/cmhvYSCNVFik2Lu4QbTexmNQHlE5rBRdm/N
         OfKg==
X-Forwarded-Encrypted: i=1; AJvYcCWcK7y4o7K7B8tbSDSpsz28rfr1VXSmXYW2nHCE5R0r6ZD0ASb5IX8Wr7W9v45WqW6yJsq3bfzzbhkOwjcm8JNqC3F6PbxR+CnJN8SK
X-Gm-Message-State: AOJu0Yw6LWpgWI2IcqKmAX5veM/CP4uXKSoQu71fQMaA+P2z15jBxgFf
	4fXw+CTrMguoONLG5VMcO3Qi3ciY106e5WkrqV3h5xDfpZhXNQtPdzjFQ6/Py90409l96cSd8/5
	OTxrvcLKmMgt2C3KPNC+aajiYjrSycUn5reI/7Q==
X-Google-Smtp-Source: AGHT+IHc8TGqZAwqFDlo6Dq21pNEyUGk0iKQ7/Kg+Qq13x9l/X18noftNvx9aDoaiAU4YcJRXQyyKKTDSXzpl9HWJIM=
X-Received: by 2002:a05:6902:2b84:b0:e03:b61f:22e6 with SMTP id
 3f1490d57ef6-e05ed69b163mr1422398276.9.1721210852748; Wed, 17 Jul 2024
 03:07:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240716133117.483514-1-tejasvipin76@gmail.com>
 <p7fahem6egnooi5org4lv3gtz2elafylvlnyily7buvzcpv2qh@vssvpfci3lwn> <a05b4e6e-272a-43be-8202-2b81049a41a4@gmail.com>
In-Reply-To: <a05b4e6e-272a-43be-8202-2b81049a41a4@gmail.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 17 Jul 2024 13:07:22 +0300
Message-ID: <CAA8EJpoRd3ooMnH8Z38yNH0M-L_CUd+H4WoYydd2AEmpXGeU8Q@mail.gmail.com>
Subject: Re: [PATCH] drm/mipi-dsi: Introduce macros to create mipi_dsi_*_multi functions
To: Tejas Vipin <tejasvipin76@gmail.com>
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	dianders@chromium.org, airlied@gmail.com, daniel@ffwll.ch, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 17 Jul 2024 at 12:58, Tejas Vipin <tejasvipin76@gmail.com> wrote:
>
>
>
> On 7/16/24 10:31 PM, Dmitry Baryshkov wrote:
> > On Tue, Jul 16, 2024 at 07:01:17PM GMT, Tejas Vipin wrote:
> >> Introduce 2 new macros, DSI_CTX_NO_OP and MIPI_DSI_ADD_MULTI_VARIANT.
> >>
> >> DSI_CTX_NO_OP calls a function only if the context passed to it hasn't
> >> encountered any errors. It is a generic form of what mipi_dsi_msleep
> >> does.
> >>
> >> MIPI_DSI_ADD_MULTI_VARIANT defines a multi style function of any
> >> mipi_dsi function that follows a certain style. This allows us to
> >> greatly reduce the amount of redundant code written for each multi
> >> function. It reduces the overhead for a developer introducing new
> >> mipi_dsi_*_multi functions.
> >>
> >> Signed-off-by: Tejas Vipin <tejasvipin76@gmail.com>
> >> ---
> >>  drivers/gpu/drm/drm_mipi_dsi.c | 286 ++++++++++-----------------------
> >>  1 file changed, 83 insertions(+), 203 deletions(-)
> >>
> >
> > [...]
> >
> >> -void mipi_dsi_dcs_set_tear_on_multi(struct mipi_dsi_multi_context *ctx,
> >> -                                enum mipi_dsi_dcs_tear_mode mode)
> >> -{
> >> -    struct mipi_dsi_device *dsi = ctx->dsi;
> >> -    struct device *dev = &dsi->dev;
> >> -    ssize_t ret;
> >> -
> >> -    if (ctx->accum_err)
> >> -            return;
> >> -
> >> -    ret = mipi_dsi_dcs_set_tear_on(dsi, mode);
> >> -    if (ret < 0) {
> >> -            ctx->accum_err = ret;
> >> -            dev_err(dev, "sending DCS SET_TEAR_ON failed: %d\n",
> >> -                    ctx->accum_err);
> >> -    }
> >> -}
> >> -EXPORT_SYMBOL(mipi_dsi_dcs_set_tear_on_multi);
> >> +#define MIPI_DSI_ADD_MULTI_VARIANT(proto, err, inner_func, ...)     \
> >> +proto {                                                             \
> >> +    struct mipi_dsi_device *dsi = ctx->dsi;                 \
> >> +    struct device *dev = &dsi->dev;                         \
> >> +    int ret;                                                \
> >> +    \
> >> +    if (ctx->accum_err)                                     \
> >> +            return;                                         \
> >> +    \
> >> +    ret = inner_func(dsi, ##__VA_ARGS__);                   \
> >> +    if (ret < 0) {                                          \
> >> +            ctx->accum_err = ret;                           \
> >> +            dev_err(dev, err, ctx->accum_err);              \
> >> +    }                                                       \
> >> +}                                                           \
> >> +EXPORT_SYMBOL(inner_func##_multi);
> >> +
> >> +MIPI_DSI_ADD_MULTI_VARIANT(
> >> +    void mipi_dsi_picture_parameter_set_multi(
> >> +    struct mipi_dsi_multi_context *ctx,
> >> +    const struct drm_dsc_picture_parameter_set *pps),
> >> +    "sending PPS failed: %d\n",
> >> +    mipi_dsi_picture_parameter_set, pps);
> >
> > I'd say that having everything wrapped in the macro looks completely
> > unreadable.
> >
> > If you really insist, it can become something like:
> >
> > MIPI_DSI_ADD_MULTI_VARIANT(mipi_dsi_picture_parameter_set
> >       MULTI_PROTO(const struct drm_dsc_picture_parameter_set *pps),
> >       MULTI_ARGS(pps),
> >       "sending PPS failed");
> >
> > (note, I dropped the obvious parts: that the funciton is foo_multi, its
> > return type is void, first parameter is context, etc).
> >
> > However it might be better to go other way arround.
> > Do we want for all the drivers to migrate to _multi()-kind of API? If
> > so, what about renaming the multi and non-multi functions accordingly
> > and making the old API a wrapper around the multi() function?
> >
>
> I think this would be good. For the wrapper to make a multi() function
> non-multi, what do you think about a macro that would just pass a
> default dsi_ctx to the multi() func and return on error? In this case
> it would also be good to let the code fill inline instead of generating
> a whole new function imo.
>
> So in this scenario all the mipi dsi functions would be multi functions,
> and a function could be called non-multi like MACRO_NAME(func) at the
> call site.

Sounds good to me. I'd suggest to wait for a day or two for further
feedback / comments from other developers.

>
> I also think there is merit in keeping DSI_CTX_NO_OP.
>
> What do you think?
>
> --
> Tejas Vipin



-- 
With best wishes
Dmitry

