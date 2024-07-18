Return-Path: <linux-kernel+bounces-256584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E7B89350B6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 18:31:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD9EA282329
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 16:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A1C0144D3C;
	Thu, 18 Jul 2024 16:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kpIE0f0Z"
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2E213A3F6
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 16:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721320292; cv=none; b=MmuRUStKUfvFVffGXkMjux0gv++NTvY+YJtKIAgoUCGX77UMj5qqWeId8zpidirlytcq2Zov4OwNo3wWbRwjcxTPATfkiQ/y8nHtP5yVudAh4z/8gz4z3yN21BnK5Z1GHhHX/yJC3+W5kP6U+sx/Oco1D7lb235yta87+CBXb4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721320292; c=relaxed/simple;
	bh=iBUIcBwnMuihOnq59qynpcixcuRU2Gtb0ufDRZgAdNI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jfc1MleSIcf0WTeXn2Z/t27VDETtmjvBZkSE3rsx8rjZ/fV0yIZklroX9JEgVD3sCT4YcyGqW5lun7mAN8ygw86/0DP5LDiNjnUY4eGzMNVOilEkyFxAZvXbIHWIQ7RXW22T2K3SUb4zClt8rb8iH+wOtKZykt7+NG+P4Wv48aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=kpIE0f0Z; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6b79b93a4c9so7598416d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 09:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1721320286; x=1721925086; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kYXM0M2L9/ShtUVFb30rLFi4Wo4QnGam8REPnb23O7o=;
        b=kpIE0f0ZVjhmD1e8l6uzdVoUwMPivx+XiL1f/7L4S0MbvIt5J0gsChF1K8rfVgVxCe
         C58xqFSf8ryYuGn6Gi9unHm/17c3EbVJAQfOULO7Ja/1q4MLBKbgpxrnYMZKFvBtsve8
         eOpif559kLORQhJ8OMTdlB0T4jApfSSRyKHT0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721320286; x=1721925086;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kYXM0M2L9/ShtUVFb30rLFi4Wo4QnGam8REPnb23O7o=;
        b=GLvBm3y6RuJZMlygYBRHT95JSMmWv3cMP5EDiHPeznhmKIyC6sak1Mzc76Na9EQ2aG
         cBSGOu0vCvdVdJgBlpCnB9izH0kw9qWcKKsXc1u2ZkCByZ8hzgpL5WF0AMlzSpBKVl8G
         R/V2xk+lI7KcSdbC0Hb/b2G8kcTP/CsvgtCjtqBZJ4SysbPmNxqUgqJO87seKjXQALAL
         pxEjXg+RPR2cKhSBMXg+QUdsGaibSDjFGfKbuyuf1jQLKrziSQNL8bLXo0pYoo2JfmWC
         y5rKzI87/lQfyh4FWnu6n88lIwe0uA9mgB/mnDHZ+eiTl4Xui/ZlT0uxXWCUmhs5v26L
         JAwg==
X-Forwarded-Encrypted: i=1; AJvYcCWTFFgdFrKq6bz9KLHq+GkrO/C1lL4VGAKDmLVmT2xpkUJMRMXFmMpsNyVS7oqA9j0C90PyoXwxs7gtyAHYGyS3s7gHCzL6Op4CGQt6
X-Gm-Message-State: AOJu0YzBGy/OLjPgudqfEbnzejN6bDzIbHhH4s8enTh4Oecz8uuqC7QO
	yKTMUPHkBfKmg1lRAhbQ2WY0GbS7uJEXCncTuVmLuj5V7pUsrz1b9hj5IVtfNjiOH8QZJzUXUdI
	=
X-Google-Smtp-Source: AGHT+IHcum8BpJ7codTKPfq06pY0TKyDYCqPRdnVw25EjglSVMO461WgcndOguwWxZ9j0GZjOOtSng==
X-Received: by 2002:a0c:f9c2:0:b0:6b0:8ac1:26bc with SMTP id 6a1803df08f44-6b79cc45e4cmr51308216d6.14.1721320286272;
        Thu, 18 Jul 2024 09:31:26 -0700 (PDT)
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com. [209.85.160.182])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44f96ac4475sm3832621cf.82.2024.07.18.09.31.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jul 2024 09:31:25 -0700 (PDT)
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-447f8aa87bfso2391cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 09:31:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWv5MtsOUTijvIGl4XfLXE8DluAE08WEXqA5ni5Yf3GTPqPw53NrR5RLgq96Za7x/B4ECmACGLYuXR0kULYIQKC8vgS1EAZe4GhepUr
X-Received: by 2002:ac8:53cd:0:b0:447:ed90:7396 with SMTP id
 d75a77b69052e-44f96ac4b5dmr1388311cf.24.1721320284402; Thu, 18 Jul 2024
 09:31:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240717215847.5310-1-robdclark@gmail.com> <CAD=FV=XCOKJHJ-yzENpvm_MD34tMR5LRy2m2jYdcWzZXP4pfXQ@mail.gmail.com>
 <CAF6AEGuBZqV4zg1asUNbMLvq0-i-iyFwfi37uKS3kWNuRSOU+g@mail.gmail.com>
 <CAD=FV=UMiDTLBBEMk3fpg+TfE_K23fyL+JDZj77Fe9fCY8DyjA@mail.gmail.com> <CAF6AEGs22brXntJ-eDv_uTZGc2=rH2q2V4y6Vt8K4s+dsO=4-A@mail.gmail.com>
In-Reply-To: <CAF6AEGs22brXntJ-eDv_uTZGc2=rH2q2V4y6Vt8K4s+dsO=4-A@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 18 Jul 2024 09:31:07 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WJQBTjt61ma-CoJQeGYKigEyXpA6j25JSyEfikrLeSNQ@mail.gmail.com>
Message-ID: <CAD=FV=WJQBTjt61ma-CoJQeGYKigEyXpA6j25JSyEfikrLeSNQ@mail.gmail.com>
Subject: Re: [RFC] drm/panel/simple-edp: Add Samsung ATNA45DC02
To: Rob Clark <robdclark@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org, 
	Rob Clark <robdclark@chromium.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jul 18, 2024 at 9:25=E2=80=AFAM Rob Clark <robdclark@gmail.com> wro=
te:
>
> On Thu, Jul 18, 2024 at 9:00=E2=80=AFAM Doug Anderson <dianders@chromium.=
org> wrote:
> >
> > Hi,
> >
> > On Wed, Jul 17, 2024 at 6:09=E2=80=AFPM Rob Clark <robdclark@gmail.com>=
 wrote:
> > >
> > > On Wed, Jul 17, 2024 at 5:19=E2=80=AFPM Doug Anderson <dianders@chrom=
ium.org> wrote:
> > > >
> > > > Hi,
> > > >
> > > > On Wed, Jul 17, 2024 at 2:58=E2=80=AFPM Rob Clark <robdclark@gmail.=
com> wrote:
> > > > >
> > > > > From: Rob Clark <robdclark@chromium.org>
> > > > >
> > > > > Just a guess on the panel timings, but they appear to work.
> > > > >
> > > > > Signed-off-by: Rob Clark <robdclark@chromium.org>
> > > > > ---
> > > > > This adds the panel I have on my lenovo yoga slim 7x laptop.  I c=
ouldn't
> > > > > find any datasheet so timings is just a guess.  But AFAICT everyt=
hing
> > > > > works fine.
> > > > >
> > > > >  drivers/gpu/drm/panel/panel-edp.c | 2 ++
> > > > >  1 file changed, 2 insertions(+)
> > > >
> > > > Given that this is a Samsung ATNA<mumble>, is there any chance it's=
 an
> > > > OLED panel? Should it be supported with the Samsung OLED panel driv=
er
> > > > like this:
> > > >
> > > > https://lore.kernel.org/r/20240715-x1e80100-crd-backlight-v2-0-31b7=
f2f658a3@linaro.org
> > >
> > > it is an OLED panel, and I did see that patchset and thought that
> > > samsung panel driver would work.  But changing the compat string on
> > > the yoga dts only gave me a black screen (and I didn't see any of the
> > > other mentioned problems with bl control or dpms with panel-edp).  So
> > > :shrug:?  It could be I overlooked something else, but it _seems_ lik=
e
> > > panel-edp is fine for this panel. Plus, it would avoid awkwardness if
> > > it turned out there were other non-samsung 2nd sources, but so far
> > > with a sample size of two 100% of these laptops have the same panel
> >
> > Hmm, OK. One question for you: are you using the "enable" GPIO in
> > panel-edp? IMO the code handling that GPIO in panel-edp is somewhat
> > dodgy, but it predates my deeper involvement with panels. I've never
> > seen an eDP panel that could use panel-edp where it was actually
> > required--every instance where someone thought it was required was
> > better modeled by using that GPIO as the backlight enable. On the
> > other hand, the "enable" GPIO in the Samsung OLED panel driver came
> > straight from the panel datasheet and it makes sense for it to be in
> > the panel driver since the backlight is handled straight by the
> > panel...
>
> hmm, at least current dts doesn't have an enable gpio.  Which could be
> why panel-samsung-atna33xc20 wasn't working.
>
> It is entirely possible we are relying on something left on by the bootlo=
ader.

That would be my best guess. Is there any way for you to find out if
there's an enable GPIO?


> > In any case, I guess if things are working it doesn't really hurt to
> > take it in panel-edp for now...
> >
>
> I wonder if using compatible=3D"edp-panel" everywhere isn't a great idea
> if we want to switch drivers later.  But I guess that is already water
> under the bridge (so to speak)

For panels that aren't OLED it's all very standard and we're kinda
forced to use something generic since manufacturers want lots of 2nd
(and 3rd and 4th and ...) sourcing. As far as I've been able to tell
you can't do 2nd sourcing between OLED panels and other panels since
the wires hooked up to the panels are a little different for the OLED
panels and the power sequencing is a bit different. It would also be
pretty obvious to an end user if some of their devices had an OLED
panel and some didn't. I'm not aware of OLED panels other than the
Samsung ones, but I haven't done any real research here...

-Doug

