Return-Path: <linux-kernel+bounces-228438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ACA30915FEE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 09:23:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C4231C22C92
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 07:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE22146A61;
	Tue, 25 Jun 2024 07:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NBEPCe4A"
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A94073463
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 07:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719300208; cv=none; b=a2teRoucGelIur0ZrI2x32JeBJ1WAFweann45ezLxIXxchI6L7wiFMGWip1t4p71mD2Qy2dBO8kk8SzMZVkZQW64/NMGtD+ih5Uy45uq2885Ir5QpqireXi2B/u+9IZl99T/0ASYuMhKroVmOka1zIGYKj03QlJ/kZ1rxGCUMVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719300208; c=relaxed/simple;
	bh=XInhqWjTyGgF/NczZFh8J2uxE8CZlqtIAJ6tM158O7E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tbexn4AxL1BDz7aBSwsChnH+TyLUzJznlC3EEmGVEEA3ietfYuFKC7fn5/0diBH/0bwkGcdrOWBS9aWxJdYgonYCyUXzd8RbMvN/0gFRt7vOP/4k+H0LFCprB6Hgq3qnLj54rae/JnceuaLUfwfr1+D0j6bXwHx/ZVgADHdvvnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NBEPCe4A; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e026a2238d8so5095835276.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 00:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719300206; x=1719905006; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4U4avMdImgQftnzL6jlWSke5cZt6SovRLmUKq0CgZWo=;
        b=NBEPCe4AerCy4iOPpBVfKwvjohA4tjk9806LQO8ojMRtYvdD/M8NY2AJlMZJCdK656
         8AU15czgZYS1hipM1YoHXG2OSC2PPiRwGDY+3uAs0jbABN8qXG0ow0xjqktfUaI2UhEr
         risfriju7NzPi2TY57WKgq1I9ThY8rxf5PsosZWdG4PbwlS1IxP4GAMU7Q2NNvnwunlF
         HITXLcjVcHRapDNPjkyoXZ/reqqk+IzpsLJPjr/SKQU9SELhVvFX5I41jH5rdoC4JsvU
         XDJN1TaMkwgsAq4tU6HkZSgCNGV7CoIsx+sRbQ/VDPYuuZbaBT5oJiCoOmTMi135XgO6
         YpFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719300206; x=1719905006;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4U4avMdImgQftnzL6jlWSke5cZt6SovRLmUKq0CgZWo=;
        b=sZLP1t0USrGCRF5JYlUHWSroUpqCN7tFWX8Y3pGnwTDysEQCPa6mINNd8zOBkj8p7O
         674QI9QtPpjcYxsvdHgf+rVZt/pJFI+fj8nDRRbgvD0YoGGTrj09eMw1vBHu/XxH66gi
         hmNfnWReDVrKIfHeQsuC1IlFXVhFmJ9UQs1DfX5QyhLHv7V3Ao4dESwLszqY4ZiUp4Dz
         gQK1SEj/Fmmcv97/iACAY0yScyr7C6MnhIILgBsQ1DVuirBza2SrgszLWK9prMQ1jd1s
         TNrIIkEvttoy3M9KM7Xq1ne5Nby/Opz39WGcLJWofLYcrVjZagVfEquk65LanHRRn5Lb
         XvQw==
X-Forwarded-Encrypted: i=1; AJvYcCUoI0k4OzMfFp9o6lgwsyr4pzi8YpetWe6au5/N1t/so9x7nFyXAvj+87UR4DKvxyjR7kcfsLvghZwhfddlAxKHJU6FobWgXRzzplGa
X-Gm-Message-State: AOJu0YzLBsLvsIDzBwzgOoHT7+WDQ+BGTbPACn/AhEYZvCydvZ6d+8Nd
	j2Ep5fOnoxMxh2uH0LjXCdb2IbXQ+mx4AEjJ1ofIeRM2gjRkcnqQzJojfu4osPjv4DN+3YBMdjv
	PDpK0LtxwuILzChZ0V9SOJMQPNv5iYWmoLR6vTw==
X-Google-Smtp-Source: AGHT+IEM0RHFhWq6hLIJX30Wlevk9s3pvCQZ4Q33iQ5XXrRyVvTax2Z6ZQ4ZcmC2TGM9LH8eWtH9I7nZW5r9pJKclN4=
X-Received: by 2002:a25:bd7:0:b0:e02:b548:1f06 with SMTP id
 3f1490d57ef6-e0303f52cb0mr6173827276.22.1719300205907; Tue, 25 Jun 2024
 00:23:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240623-drm-bridge-connector-fix-hdmi-reset-v2-0-8590d44912ce@linaro.org>
 <20240623-drm-bridge-connector-fix-hdmi-reset-v2-2-8590d44912ce@linaro.org>
 <99ff549c-f5c4-dc9c-42f3-396dc3d29d6b@quicinc.com> <CAA8EJppcH-z275m6xDQaigsxmVhnfJkLVsq68GHLFoAq_p_2GA@mail.gmail.com>
 <30fa4e53-5a03-4030-2be5-f383a1c60077@quicinc.com> <CAA8EJpo_dBDqLUVH-SkufhFchu64rhC+vkhVBFdt++E4pdCrQg@mail.gmail.com>
 <20240625-yellow-shrimp-of-genius-17c662@houat>
In-Reply-To: <20240625-yellow-shrimp-of-genius-17c662@houat>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 25 Jun 2024 10:23:14 +0300
Message-ID: <CAA8EJpr_kn=x080KLGfwsLi3PnnNhTjJhvL=hiRNLBD=WqSuZQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] drm/connector: automatically set immutable flag
 for max_bpc property
To: Maxime Ripard <mripard@kernel.org>
Cc: Abhinav Kumar <quic_abhinavk@quicinc.com>, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Dave Stevenson <dave.stevenson@raspberrypi.com>, 
	"igt-dev@lists.freedesktop.org" <igt-dev@lists.freedesktop.org>, Petri Latvala <adrinael@adrinael.net>, 
	Kamil Konieczny <kamil.konieczny@linux.intel.com>, 
	=?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, 
	Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 25 Jun 2024 at 10:19, Maxime Ripard <mripard@kernel.org> wrote:
>
> Hi,
>
> On Tue, Jun 25, 2024 at 09:21:27AM GMT, Dmitry Baryshkov wrote:
> > On Tue, 25 Jun 2024 at 01:56, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
> > >
> > >
> > >
> > > On 6/24/2024 3:46 PM, Dmitry Baryshkov wrote:
> > > > On Tue, 25 Jun 2024 at 01:39, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
> > > >>
> > > >> + IGT dev
> > > >>
> > > >> On 6/22/2024 10:40 PM, Dmitry Baryshkov wrote:
> > > >>> With the introduction of the HDMI Connector framework the driver might
> > > >>> end up creating the max_bpc property with min = max = 8. IGT insists
> > > >>> that such properties carry the 'immutable' flag. Automatically set the
> > > >>> flag if the driver asks for the max_bpc property with min == max.
> > > >>>
> > > >>
> > > >> This change does not look right to me.
> > > >>
> > > >> I wonder why we need this check because DRM_MODE_PROP_IMMUTABLE means
> > > >> that as per the doc, userspace cannot change the property.
> > > >>
> > > >>            * DRM_MODE_PROP_IMMUTABLE
> > > >>            *     Set for properties whose values cannot be changed by
> > > >>            *     userspace. The kernel is allowed to update the value of
> > > >> these
> > > >>            *     properties. This is generally used to expose probe state to
> > > >>            *     userspace, e.g. the EDID, or the connector path property
> > > >> on DP
> > > >>            *     MST sinks. Kernel can update the value of an immutable
> > > >> property
> > > >>            *     by calling drm_object_property_set_value().
> > > >>            */
> > > >>
> > > >> Here we are allowing userspace to change max_bpc
> > > >>
> > > >>
> > > >> drm_atomic_connector_set_property()
> > > >> {
> > > >>          **********
> > > >>
> > > >>           } else if (property == connector->max_bpc_property) {
> > > >>                   state->max_requested_bpc = val;
> > > >>
> > > >>          **********
> > > >> }
> > > >>
> > > >> I believe you are referring to this IGT check right?
> > > >>
> > > >> https://gitlab.freedesktop.org/drm/igt-gpu-tools/-/blob/master/tests/kms_properties.c#L428
> > > >
> > > > Yes
> > > >
> > > >>
> > > >> I think we should fix IGT in this case unless there is some reason we
> > > >> are missing. Because just because it has the same min and max does not
> > > >> mean its immutable by the doc of the IMMUTABLE flag.
> > > >
> > > > Well, having the same min and max means that it is impossible to
> > > > change the property. So the property is immutable, but doesn't have
> > > > the flag.
> > > >
> > >
> > > True, then does DRM_MODE_PROP_IMMUTABLE need a doc update too indicating
> > > that even if the min and max is same, property will be interpreted as
> > > immutable.
> >
> > Granted that I'm only doing it for max_bpc property I don't think so.
>
> Yeah, I have to agree with Abhinav here, it does look fishy to me too,
> even more so that it's only ever "documented" through an igt routine
> that has never documented why we want that.
>
> I'm fine with the change if it's indeed what we expect, and it might
> very well be, but I'd like to clear that up and document it first.

Should I also move the setting of the IMMUTABLE flag to a more generic code?

-- 
With best wishes
Dmitry

