Return-Path: <linux-kernel+bounces-211684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A96CA905556
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 16:39:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DC84284010
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 14:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49CC917E8F9;
	Wed, 12 Jun 2024 14:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="H9ZYcwD/"
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F9817DE39
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 14:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718203159; cv=none; b=mG+Zl2tHzu3p9FaYuIfK/nE/BhLVK/UqoFmFN0hLur4o1hV6scTDlxQx6tMWIqeRSaM+TVTzGUzcFgKPBMhAI8R/2nJ7jMgeYnAgeqP3hbQu1nWS3gyOYEhWuu/3h0LXRhmeLhV+qeMRoHoJ0ax2CmMRRLfESKhCxiQUExcSkDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718203159; c=relaxed/simple;
	bh=k7T4B0Thfp0UyTe4JzEOApM5BqV9p4UeUFs9C1mTxKk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RMf4VdpM0Lu1/3faEGwt+osFKT3Bbhgprx5KgbifSwfWGUPF8jXTRreUPbaT0yGx8saQaqink4wIuQFNn1tx+KvvKmQjlBzon1/cDF8sJi8s3kD5kW4Vbo8N60xJaywl71CWN6pWJShDRQqtHQb/ZLzffn8Vrv5yQe6WzNPAFE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=H9ZYcwD/; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-6f9611fc320so2505193a34.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 07:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718203155; x=1718807955; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UY8FyGhFzNz8kU02mOEKGYBexw/0qw3Ur3irWH55yC0=;
        b=H9ZYcwD/rv70qFE2Pl5/FWEQwUviLjyASruJKNdG3fVcatgmWxJhRTOpEDTiRGbb1m
         9Yvn+x3IIE9QiNen6XAq91KWNN3b8tmDTxJZqlVkz2ifPgorZhvqejckcfgobc3axwTs
         8cG5p9CFTsz7KGRKGbVnSJhuUmCoOu7uZdH6M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718203155; x=1718807955;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UY8FyGhFzNz8kU02mOEKGYBexw/0qw3Ur3irWH55yC0=;
        b=hwCYeFmbpGhFV2R6+sVVq/mKt/mnapf9c0sHxb83u5wDCcAxhm6NWYtsMDwGridnf0
         QMNcVuUUKmvjp+ANxm7gE18QB1ELEVvgfp5gqAmAzlc4xVofMg0iplaMtfZkxAQ91yN8
         gmVMfYEf4hVChWJYhSEin1bW+BIQcDBNHTG5O4o4YEcOFjcYGfhbSfr0YAaqhMCYbK0S
         LcH2H+yJdkeseXD3h6F0SMnV7EX65CSz4vOKRppg6NMdPjYcgSPuyKvvWZX4a9x2cauV
         TuJVRFxlNLMY2IdG6PtqlR1KMbtT4KuM5mHu0kunCUg9vhzx8TJLX5MpHzyt0l3w/vJF
         GHbg==
X-Forwarded-Encrypted: i=1; AJvYcCU6PyXSbDH1F7cln3A2Wb+xowmAD3/SXNdMlP3jBAVOKugxxAEl5Xx9otWT+2RDFlvLW6NwYBA+8wBH6L6gif4xaQl7eZYaob7f+YhU
X-Gm-Message-State: AOJu0YzDTiAL4WbM0KOAigUxgV7OJSbbO5/8/GJl0ofV816VXCLksYu1
	VFA53y7S+lwquddo/IHWTd//fPTLGuzjXb103E3Np6RPJ7fNeBMRC7EzuOB9aQhbw5QuiOI5a+Q
	=
X-Google-Smtp-Source: AGHT+IEYcBz0cmV8miYzCMMRWkiXGptEYENyYuf5+zfMi/IsI/g0dQBg68DL12Kga97X8qMrmls5Eg==
X-Received: by 2002:a9d:6b0c:0:b0:6f9:64f1:5b14 with SMTP id 46e09a7af769-6fa1c222cb2mr2221853a34.27.1718203155364;
        Wed, 12 Jun 2024 07:39:15 -0700 (PDT)
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com. [209.85.160.169])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7955a737829sm364260285a.51.2024.06.12.07.39.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jun 2024 07:39:14 -0700 (PDT)
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4405cf01a7fso339221cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 07:39:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV05XgUvFPYmbNv4GBBnSjydN9PoVHWEc07v/tlfS6Jgml2+e40VIykcfT8CEpvk/5fFARyeiXtJDBASdyyDCWYc1TZRkwQJutv55Vz
X-Received: by 2002:a05:622a:998:b0:43f:bba6:3759 with SMTP id
 d75a77b69052e-44158bc6537mr4241291cf.10.1718203153602; Wed, 12 Jun 2024
 07:39:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240611074846.1.Ieb287c2c3ee3f6d3b0d5f49b29f746b93621749c@changeid>
 <20240612-garnet-condor-from-saturn-1c51bb@houat>
In-Reply-To: <20240612-garnet-condor-from-saturn-1c51bb@houat>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 12 Jun 2024 07:39:01 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Xpu0-_kEvRWy9w8ypjo7pF7tsFWxHfhMZ=YjHugTqG1w@mail.gmail.com>
Message-ID: <CAD=FV=Xpu0-_kEvRWy9w8ypjo7pF7tsFWxHfhMZ=YjHugTqG1w@mail.gmail.com>
Subject: Re: [PATCH] drm/panel: Avoid warnings w/ panel-simple/panel-edp at shutdown
To: Maxime Ripard <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org, 
	Neil Armstrong <neil.armstrong@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, 
	Yuran Pereira <yuran.pereira@hotmail.com>, Chris Morgan <macromorgan@hotmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jun 12, 2024 at 1:09=E2=80=AFAM Maxime Ripard <mripard@kernel.org> =
wrote:
>
> Hi,
>
> On Tue, Jun 11, 2024 at 07:48:51AM GMT, Douglas Anderson wrote:
> > At shutdown if you've got a _properly_ coded DRM modeset driver then
> > you'll get these two warnings at shutdown time:
> >
> >   Skipping disable of already disabled panel
> >   Skipping unprepare of already unprepared panel
> >
> > These warnings are ugly and sound concerning, but they're actually a
> > sign of a properly working system. That's not great.
> >
> > It's not easy to get rid of these warnings. Until we know that all DRM
> > modeset drivers used with panel-simple and panel-edp are properly
> > calling drm_atomic_helper_shutdown() or drm_helper_force_disable_all()
> > then the panel drivers _need_ to disable/unprepare themselves in order
> > to power off the panel cleanly. However, there are lots of DRM modeset
> > drivers used with panel-edp and panel-simple and it's hard to know
> > when we've got them all. Since the warning happens only on the drivers
> > that _are_ updated there's nothing to encourage broken DRM modeset
> > drivers to get fixed.
> >
> > In order to flip the warning to the proper place, we need to know
> > which modeset drivers are going to shutdown properly. Though ugly, do
> > this by creating a list of everyone that shuts down properly. This
> > allows us to generate a warning for the correct case and also lets us
> > get rid of the warning for drivers that are shutting down properly.
> >
> > Maintaining this list is ugly, but the idea is that it's only short
> > term. Once everyone is converted we can delete the list and call it
> > done. The list is ugly enough and adding to it is annoying enough that
> > people should push to make this happen.
> >
> > Implement this all in a shared "header" file included by the two panel
> > drivers that need it. This avoids us adding an new exports while still
> > allowing the panel drivers to be modules. The code waste should be
> > small and, as per above, the whole solution is temporary.
> >
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
> > I came up with this idea to help us move forward since otherwise I
> > couldn't see how we were ever going to fix panel-simple and panel-edp
> > since they're used by so many DRM Modeset drivers. It's a bit ugly but
> > I don't hate it. What do others think?
>
> I don't think it's the right approach, even more so since we're so close
> now to having it in every driver.
>
> I ran the coccinelle script we started with, and here are the results:
>
> ./drivers/gpu/drm/vmwgfx/vmwgfx_drv.c:1640:25-39: ERROR: KMS driver vmw_p=
ci_driver is missing shutdown implementation
> ./drivers/gpu/drm/kmb/kmb_drv.c:621:30-49: ERROR: KMS driver kmb_platform=
_driver is missing shutdown implementation
> ./drivers/gpu/drm/tiny/arcpgu.c:422:30-52: ERROR: KMS driver arcpgu_platf=
orm_driver is missing shutdown implementation

Sure, although I think we agreed even back when we talked about this
last that your coccinelle script wasn't guaranteed to catch every
driver. ...so I guess the question is: are we willing to accept that
we'll stop disabling panels at shutdown for any drivers that might
were missed. For instance, looking at it by hand (which also could
miss things), I previously thought that we also might need:

* nouveau
* tegra
* amdgpu
* sprd
* gma500
* radeon

I sent patches for those drivers but they don't go through drm-misc
and some of the drivers had a lot of abstraction layers and were hard
to reason about. I'm also not 100% confident that all of those drivers
really are affected--they'd have to be used with panel-simple or
panel-edp...

In any case, having some sort of warning that would give us a
definitive answer would be nice. My proposed patch would give us that
warning. I could even jump to a WARN_ON right from the start.

My proposed patch is self-admittedly super ugly and is also designed
to be temporary, so I don't think of this as giving up right before
crossing the finish line but instead accepting a tiny bit of temporary
ugliness to make sure that we don't accidentally regress anyone. I
would really hope it would be obvious to anyone writing / reviewing
drivers that the function I introduced isn't intended for anyone but
panel-simple and panel-edp.

-Doug

