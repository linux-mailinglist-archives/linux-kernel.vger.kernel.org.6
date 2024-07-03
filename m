Return-Path: <linux-kernel+bounces-238688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F69F924DDF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 04:35:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4263284672
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 02:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FD2D4409;
	Wed,  3 Jul 2024 02:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d6ke4umP"
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8744683
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 02:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719974108; cv=none; b=KB/nMb2falGccyAlrtUWUFzkwrK81FKibNKkLp/ALJluGHDW+tWjl0/vNUC8XB0aVydj83anM8zuQxQhYywi1hJWyB09e5GGPNTEe+wRUop5yB+NkOO7zvjIqShmzniFQGHQ6VbGu8y+d+ayhb4S3r5qMmZcI6MA68W+bGEO27s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719974108; c=relaxed/simple;
	bh=WMfapxlfTD2njzFm74yIjvK4BTDi9nxXiv8VY2FD0GA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=elbOweTIPyh5DgYSMbDF5tSagcCYCRgKfemhVrQWSI/17ftY7A9Ig9rK6/bS4rOOsDkokb18paybqWMAyiFhaB+0gekeScMFO6cXQEE2OjHlJ3uA0doQbZdviww+/Neu0R5QfzQs4yjdKLpQRLYSDPbgmo4K9gN9F3cjQjeqBxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d6ke4umP; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-48fddd09ba2so55446137.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 19:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719974106; x=1720578906; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ruvas3khZrC/B13qfnO4yyfQhv4rJjj6J6cC5+FuVww=;
        b=d6ke4umPbvdEOjVcZTYocZ82DE3j9017TaewzQAupIcYRhfndfJjgHofozVSK/+7+q
         WdH8Urfxg9srWuaS7mwbpmMI6JfnFZ+4zbN8BiCFhQRUrlGvqiRj+WFUeZm5luAeQpRO
         CVpiQg1WW5Nxw5tVN/U4OvBG9UlRIpObDG7q0OFZgaQuNe+I90bp5g29wo40GUKwZ2m9
         iSpd2TMT2y9rui9edsaveUpTmYB7D4+s0in5Jey1IOA+ZBtBUZ5yhYJO8ykQfthEM8bT
         QyBUQonSVT6GVvlcZvgrT28xVuxWtEnKxvNjLd6dAO+Yq1BMS/Yt5whWleeFWSRQ4ttK
         YJ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719974106; x=1720578906;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ruvas3khZrC/B13qfnO4yyfQhv4rJjj6J6cC5+FuVww=;
        b=PEkR/kEi7EnHvhndZ+UpirDglTiHc8tZ0f1nGrcSwC4kNHOBxWPLIn37raFysyBuLj
         OoeWvCJHzeFsuBYEaxcNb0wlY0QZm/B4iHGZQ0MMrU0Z/yeRLkDAmgb5iM8Wkhh2JsDm
         n2pH6Bji2280s4icZgmJM3ml15e8hkJgkbh0ulI3AfRBbFAqaxml920IjYoiE2FMmqBA
         qIp2av+tN6fEF9lgrfXY7m27CdEKGD/1mIuui77DaHBucnK8CvMVxTsjbYlhrbBjyV03
         PYbdaxUmwE4BZH6l9M5R78H+s8IGFcGeevzL2FOP0e+lgL85oxtHIKWe4/PKbniHuI5x
         ieLw==
X-Forwarded-Encrypted: i=1; AJvYcCVT0wbib+AU7F+1jGxWfiimroTIXMgzdiNk/XTzJmDRKqh6TCb0V53KQOxJOZBgv7JRgjtRCWcze1CmopwWoArUGtrrvethHOP3nsqY
X-Gm-Message-State: AOJu0YxEZdV5vcqHqfq4dHJszcpKPLc9gw4aW+eOghiVoHLj5bp9BBYa
	c9RrRXkIXSrzxzOuNVofS+xNFg9slZa0Brb9tKm3zpLR0oFG5mbQDKIPRQ24F4OqNUVW9ytltg0
	d4iAhQItm7Wc8llFliyTjK2VicIo+1g==
X-Google-Smtp-Source: AGHT+IFqPTyDSbqJ95dxhUcwADW5HMUYYPETXq2E7N0v3z5D4nmrIWNtCjp5NcD+lseyyRcQp6qVXKcAGD13o9MqU8Y=
X-Received: by 2002:a05:6102:548d:b0:48f:d683:f46e with SMTP id
 ada2fe7eead31-48fd683f75emr3271895137.22.1719974105840; Tue, 02 Jul 2024
 19:35:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240702215804.2201271-1-jim.cromie@gmail.com>
 <20240702215804.2201271-31-jim.cromie@gmail.com> <ZoSOMClB0MeWeokU@intel.com>
In-Reply-To: <ZoSOMClB0MeWeokU@intel.com>
From: jim.cromie@gmail.com
Date: Tue, 2 Jul 2024 20:34:39 -0600
Message-ID: <CAJfuBxzsZUpO-Q_uAfMhzXs0WHYMTnj1F8ju7af-kQZKQjLvNQ@mail.gmail.com>
Subject: Re: [PATCH v9 30/52] drm-dyndbg: adapt drm core to use dyndbg classmaps-v2
To: =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc: daniel.vetter@ffwll.ch, tvrtko.ursulin@linux.intel.com, 
	jani.nikula@intel.com, jbaron@akamai.com, gregkh@linuxfoundation.org, 
	ukaszb@chromium.org, linux-kernel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, 
	intel-gvt-dev@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
	linux@rasmusvillemoes.dk, joe@perches.com, mcgrof@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 2, 2024 at 5:33=E2=80=AFPM Ville Syrj=C3=A4l=C3=A4
<ville.syrjala@linux.intel.com> wrote:
>
> On Tue, Jul 02, 2024 at 03:57:20PM -0600, Jim Cromie wrote:
> > dyndbg's CLASSMAP-v1 api was broken; DECLARE_DYNDBG_CLASSMAP tried to
> > do too much.  Its replaced by DRM_CLASSMAP_DEFINE, which creates &
> > EXPORTs the classmap when CONFIG_DRM_USE_DYNAMIC_DEBUG=3Dy, for direct
> > reference by drivers.
> >
> > The drivers still use DECLARE_DYNDBG_CLASSMAP for now, so they still
> > redundantly re-declare the classmap, but we can convert the drivers
> > later to DYNDBG_CLASSMAP_USE
> >
> > Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
> > ---
> >  drivers/gpu/drm/drm_print.c | 25 +++++++++++++------------
> >  include/drm/drm_print.h     |  8 ++++++++
> >  2 files changed, 21 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/drm_print.c b/drivers/gpu/drm/drm_print.c
> > index 699b7dbffd7b..4a5f2317229b 100644
> > --- a/drivers/gpu/drm/drm_print.c
> > +++ b/drivers/gpu/drm/drm_print.c
> > @@ -55,18 +55,19 @@ MODULE_PARM_DESC(debug, "Enable debug output, where=
 each bit enables a debug cat
> >  #if !defined(CONFIG_DRM_USE_DYNAMIC_DEBUG)
> >  module_param_named(debug, __drm_debug, ulong, 0600);
> >  #else
> > -/* classnames must match vals of enum drm_debug_category */
> > -DECLARE_DYNDBG_CLASSMAP(drm_debug_classes, DD_CLASS_TYPE_DISJOINT_BITS=
, 0,
> > -                     "DRM_UT_CORE",
> > -                     "DRM_UT_DRIVER",
> > -                     "DRM_UT_KMS",
> > -                     "DRM_UT_PRIME",
> > -                     "DRM_UT_ATOMIC",
> > -                     "DRM_UT_VBL",
> > -                     "DRM_UT_STATE",
> > -                     "DRM_UT_LEASE",
> > -                     "DRM_UT_DP",
> > -                     "DRM_UT_DRMRES");
> > +/* classnames must match value-symbols of enum drm_debug_category */
> > +DRM_CLASSMAP_DEFINE(drm_debug_classes, DD_CLASS_TYPE_DISJOINT_BITS,
> > +                 DRM_UT_CORE,
> > +                 "DRM_UT_CORE",
> > +                 "DRM_UT_DRIVER",
> > +                 "DRM_UT_KMS",
> > +                 "DRM_UT_PRIME",
> > +                 "DRM_UT_ATOMIC",
> > +                 "DRM_UT_VBL",
> > +                 "DRM_UT_STATE",
> > +                 "DRM_UT_LEASE",
> > +                 "DRM_UT_DP",
> > +                 "DRM_UT_DRMRES");
>
> Looks like this stuff just ends up in an array, so presumably
> it should be possible to use designated initializers to make this
> less fragile?

Im not sure I got your whole point, but:

the fragility is the repetitive re-statement of the map,
in those un-modified DECLARE_s,
once replaced, the USEs just ref the struct built by the _DEFINE
(once, and exported)

I dont really like the _DEFINEs restatement of the enum-values: DRM_UT_*
especially as "strings".
I can automate the stringification with an APPLY_FN_(__stringify, ...)
but the enum-list DRM_UT_* (w.o quotes) is still needed as args.

unless there is something C can do thats like Enum.values() ?



>
> --
> Ville Syrj=C3=A4l=C3=A4
> Intel

