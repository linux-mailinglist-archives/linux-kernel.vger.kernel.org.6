Return-Path: <linux-kernel+bounces-256568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 094C9935051
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 17:58:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DA8C1C20D34
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 15:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EABBE14532A;
	Thu, 18 Jul 2024 15:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LBnt4bVA"
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A1E746E
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 15:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721318292; cv=none; b=ZfBqXdEpMwn30QUV4IGSgH2Owox81Y/g8HPwBRyNnWY1IhSG8bWGqxyodCp2WR89yObJO2bp3Xcc6zC46lNbxkJGzuBsnRNHGMc80aO5K7ncec2cjySc5XfL5fSULlFAClmAkF4u8E4SB5e3l34JBCfGYuRWGpDnHlrW2MuCoxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721318292; c=relaxed/simple;
	bh=9in/nxqI6rP0aldY+QBnsVwMEb3YdRvMqSwnuwcXguo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OLG6WbFLk9kUUqYOVxkbeOe81bnjHs6e5KGdTuGo6Hv4X+XpLZ/I/Ya4lCTnGtLBcJsUzqRS4u3R8uZLV1zooKBeh89uC8ISs0v9FxmQqBY1V1EADKDY3YPY19rTQY2kMv++mcTS/g6MskhYZxKXjRfOEP9LKoU3YzvRHzCtUmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=LBnt4bVA; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6b78c980981so5436306d6.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 08:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1721318287; x=1721923087; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KI6+OUVJCzVw8+deYC/JOskjFnoamUOWD+xEmu+wUIw=;
        b=LBnt4bVAqBd7xyNVZhtnhsC15RqAm3gZF5uZOuvT2fOgCYDcjOZFb7RbOny3ecmbNb
         sOskZsI6SNN7tQ7ZAmjhPvG1EW86G/7Xeu8xRu0xTR2v+KX2fJmprJvLr06d+2Jk0/kG
         Ry3JTdC+e+9hMPPcSaJqJKrmsOpxoTzWkDOUA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721318287; x=1721923087;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KI6+OUVJCzVw8+deYC/JOskjFnoamUOWD+xEmu+wUIw=;
        b=ROykQoZlEMjio79v1D+N8Xir60OHRYFRmiyfpSku/BYFJF1x6g7jW4rZK+X666auJT
         bJ+HlrYH+tpicLwjw+twqW5T8pop0I8/TguJssT3NwmaIX/3Npe/Ltl3hUw9Cjgt3nWE
         uYwxW6/Zile3EZwJlkhdnCPkEWqyg3oYB9s2y5T0MW8zwz6HefL3LndExdG0S/fuH09K
         yqHdbr07hyJm6aGHbb4VaDarA7sj3wqtVoDSceHITNh8MorushAymgfPq5GdsYpvaPao
         7amOdWix8VgxVzEyRb4d1PayEsGcLSMTtJf00fFN1f7JOKWl2vlOeIYqd4LyNGyj2HV9
         1EHw==
X-Forwarded-Encrypted: i=1; AJvYcCX7skGNOnNg6YT4BR0RXRjLTRowsAQPnb7hQ9Bp85iPbsm13u8ZkM82euIx4vZZN2IfFmzKoWdNZYj2yfHuo2PAGYMPKIspd+rU7AK3
X-Gm-Message-State: AOJu0YwlUbdHTBdDAIVJlN8xdEjMBSf2XBVmrDy74bCsmv9A51x0M3DI
	TI8ZqlhtW7FJkAwoP2pvh3esA1z8f1OvChor459IR5yY7u6KeJtrWTn9/0cGwCpY1KedJxa2S6I
	=
X-Google-Smtp-Source: AGHT+IEfW/qmQj4KsLpIo2klPN3XPeLxSxp4L4FhkU4f1Q8DXDIL1EEZDscAu7IgOq3tqLRtMFGP1A==
X-Received: by 2002:a05:6214:2583:b0:6b7:a118:4eb1 with SMTP id 6a1803df08f44-6b7a11850cbmr27783496d6.3.1721318286977;
        Thu, 18 Jul 2024 08:58:06 -0700 (PDT)
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com. [209.85.160.181])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b79c609f74sm9196436d6.93.2024.07.18.08.58.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jul 2024 08:58:06 -0700 (PDT)
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-44a8b140a1bso132051cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 08:58:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXEoW+SwqIDKmY007rpWnzUMwvVBmbtqQYGcdjfru48x4/PSTxVFW1txjev8BF3y+5TGuaOIYezyQW8/tDZwayEFiTVug7lsWmN471L
X-Received: by 2002:a05:622a:4116:b0:447:e01a:de95 with SMTP id
 d75a77b69052e-44f9681efaemr1462911cf.0.1721318285517; Thu, 18 Jul 2024
 08:58:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240717215847.5310-1-robdclark@gmail.com> <CAD=FV=XCOKJHJ-yzENpvm_MD34tMR5LRy2m2jYdcWzZXP4pfXQ@mail.gmail.com>
 <CAF6AEGuBZqV4zg1asUNbMLvq0-i-iyFwfi37uKS3kWNuRSOU+g@mail.gmail.com>
In-Reply-To: <CAF6AEGuBZqV4zg1asUNbMLvq0-i-iyFwfi37uKS3kWNuRSOU+g@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 18 Jul 2024 08:57:50 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UMiDTLBBEMk3fpg+TfE_K23fyL+JDZj77Fe9fCY8DyjA@mail.gmail.com>
Message-ID: <CAD=FV=UMiDTLBBEMk3fpg+TfE_K23fyL+JDZj77Fe9fCY8DyjA@mail.gmail.com>
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

On Wed, Jul 17, 2024 at 6:09=E2=80=AFPM Rob Clark <robdclark@gmail.com> wro=
te:
>
> On Wed, Jul 17, 2024 at 5:19=E2=80=AFPM Doug Anderson <dianders@chromium.=
org> wrote:
> >
> > Hi,
> >
> > On Wed, Jul 17, 2024 at 2:58=E2=80=AFPM Rob Clark <robdclark@gmail.com>=
 wrote:
> > >
> > > From: Rob Clark <robdclark@chromium.org>
> > >
> > > Just a guess on the panel timings, but they appear to work.
> > >
> > > Signed-off-by: Rob Clark <robdclark@chromium.org>
> > > ---
> > > This adds the panel I have on my lenovo yoga slim 7x laptop.  I could=
n't
> > > find any datasheet so timings is just a guess.  But AFAICT everything
> > > works fine.
> > >
> > >  drivers/gpu/drm/panel/panel-edp.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> >
> > Given that this is a Samsung ATNA<mumble>, is there any chance it's an
> > OLED panel? Should it be supported with the Samsung OLED panel driver
> > like this:
> >
> > https://lore.kernel.org/r/20240715-x1e80100-crd-backlight-v2-0-31b7f2f6=
58a3@linaro.org
>
> it is an OLED panel, and I did see that patchset and thought that
> samsung panel driver would work.  But changing the compat string on
> the yoga dts only gave me a black screen (and I didn't see any of the
> other mentioned problems with bl control or dpms with panel-edp).  So
> :shrug:?  It could be I overlooked something else, but it _seems_ like
> panel-edp is fine for this panel. Plus, it would avoid awkwardness if
> it turned out there were other non-samsung 2nd sources, but so far
> with a sample size of two 100% of these laptops have the same panel

Hmm, OK. One question for you: are you using the "enable" GPIO in
panel-edp? IMO the code handling that GPIO in panel-edp is somewhat
dodgy, but it predates my deeper involvement with panels. I've never
seen an eDP panel that could use panel-edp where it was actually
required--every instance where someone thought it was required was
better modeled by using that GPIO as the backlight enable. On the
other hand, the "enable" GPIO in the Samsung OLED panel driver came
straight from the panel datasheet and it makes sense for it to be in
the panel driver since the backlight is handled straight by the
panel...

In any case, I guess if things are working it doesn't really hurt to
take it in panel-edp for now...


> But that was the reason for posting this as an RFC.  I was hoping
> someone had some hint about where to find datasheets (my google'ing
> was not successful), etc.

I don't personally have any hints.

-Doug

