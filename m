Return-Path: <linux-kernel+bounces-526803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6FCAA4037C
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 00:32:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1992D19C16EA
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 23:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D06220AF99;
	Fri, 21 Feb 2025 23:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="n3B6h/tF"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F20200BAA
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 23:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740180728; cv=none; b=PpA9uYt0GmLzP2p1UzzD45yLzy+GHbV1jTqh2yqAR4Kfu97bmmx3Igp9HQllxHcgoqnQ7WM05eGL9J3BHXga4l0KVa0cfKY6Hrrcq282IlMef4X8R0x+Ll3bkSYdByzqfomg59CDmg0Yddq8hJ3mXdQq17PFxw+hRwJh5/ks0Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740180728; c=relaxed/simple;
	bh=1P0022Uib6N7KsqjyjxXZFnDcKjlPnpt8V66JSYrJVc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t9Wwh8emX+Ix3P3eEt1OsRtmMjdspJ12RnHhzfzO/dACCmLSGuwfuIxSl9tm/k7a7lgT9gJJeJTaGoeNF3ziu+rmR8scr4BqHxP0wsG+LNFPJcbx/pTiKEKeQdf2JFqBLbFhKgcTieIN5MGOJy8+4zQZmD3KL/q22gZqAT3Nmsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=n3B6h/tF; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5e04064af07so3310438a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 15:32:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740180725; x=1740785525; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GiGCeg3ug6tpTo5Sf+ahfEJjPIEucvUSopnPD8u/sh8=;
        b=n3B6h/tF1EZtTKJWVLGaRKVCW/2klZg0QBoOrktweQLGWtDApRIO/XfiWGZ/2mxorx
         5lJRhoT3ASZYB2r4OkZHTvD3vSSY7+fGWVn40hIS4rvwcQr/H1pJtQV4smpXQ1MytXte
         95h5pEeftDvI3eFsw1niNt7ov2ghD5TqZC1sk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740180725; x=1740785525;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GiGCeg3ug6tpTo5Sf+ahfEJjPIEucvUSopnPD8u/sh8=;
        b=SfDBDPINVTxAFTRJvxzUTERkEmYys5pPY0iM/24CdKFcUEtfsHPXL+J1bi8P6dRLAu
         mJz/EW498ekn5PDM7pxZ15h19VzSKwKe5yhi74mPR5ikTTZln113jBbe2WcAQR75Es/j
         6GAGg6QMo8ftpmP0bF4fOCWno/M7iN3CI6ToUXy6ht+ALN/soxBhCGUfENPmaybLoVCH
         sohsPtzA4xzCPnwicW1Hc54TErgoZ37V8icMVeTsvlyAzBtt4KimRoHS3eWhwo69ds1u
         NWRqdoGKxVCqJg0v0DqngZGI+UYaZok5f2QaH6FJ5WBCsAhml/Otb0nk2XhTIAdripA7
         ulcA==
X-Forwarded-Encrypted: i=1; AJvYcCUIivSoiSHyH7zzhGyajwt7QAI0V0qcz2jjj3HQe+/Sbx3m+9fNEuya06AxcnhC5N9quI61XLY7urjNeXQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywhwa2cjblpvJQdnDfrE9/5zAF9ru266H5hgI7DYO4MUfdROtwM
	i/hu59MkNMhJeVEHlhuz+x24CihkI52xja3MBmIFw0Ir3C1QHzzNW52pDI7nNcDoPDMWy8eDAP0
	Q/WRs
X-Gm-Gg: ASbGncs8mUio5Qo770UBuQVP/445A2raPhh30WKmS+eZKZsPZohJ7l4pCNYPv/wTW+c
	mgqT/DpaJrJKAAQtYYOos3R+ITTtz68vQ53IAB11LaCsz4qUr1f7rLwQpDAZ0EW1o41ecylOgKL
	VwF0fX76OJ9u5qu4GL0DkYGRRj68FY/0Fm1R64kx3wyrxY092xMHXuedhzKzvwcbEYaDY5hfgve
	8O6EICY6EQcpj/QGBMjc3X5byynx5lfwFuWEoA2RJuSXYrvLSyp8osTIWDVwpNDceYPuUka2t3Z
	3t5MtNVyOXk9vpDdbciei2yxSyy/4PPbJ/a7DoF2CwfgIZY36y533Itqm5zHJw==
X-Google-Smtp-Source: AGHT+IHuQmLNSjTvAKUQCW5jD1SmabAKP2LSGxJDEczx+OYedkagZnP308jTVkMR/3wgtayIVRkrMg==
X-Received: by 2002:a05:6402:3548:b0:5df:6a:54dd with SMTP id 4fb4d7f45d1cf-5e0b70efff2mr4436196a12.10.1740180725203;
        Fri, 21 Feb 2025 15:32:05 -0800 (PST)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com. [209.85.128.47])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dece1d354bsm14614456a12.45.2025.02.21.15.32.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2025 15:32:04 -0800 (PST)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-439950a45daso16699075e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 15:32:03 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVQsxUYgeZcuZ3vA5Xb7LjNmtrDbYqRlil/jxE3uYeB6PNJQQneEDQvk73W2wvUNXT6SPigguC/cTe6DIU=@vger.kernel.org
X-Received: by 2002:a05:600c:4f91:b0:439:955d:c4e2 with SMTP id
 5b1f17b1804b1-439ae1f15b6mr40645305e9.13.1740180723180; Fri, 21 Feb 2025
 15:32:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250219-fix-power-allocator-weight-v1-1-79b1a99e94eb@chromium.org>
 <CAJZ5v0h8MyqEgC8Hf1_s4=kCj2W3Y0TWdVnbhwAiVLqED7WPow@mail.gmail.com> <32fe0e71-e8d9-4404-8b48-a8b8e9ec71e7@arm.com>
In-Reply-To: <32fe0e71-e8d9-4404-8b48-a8b8e9ec71e7@arm.com>
From: Yu-Che Cheng <giver@chromium.org>
Date: Sat, 22 Feb 2025 07:31:27 +0800
X-Gmail-Original-Message-ID: <CAKchOA3u9a2UK-xGONcEBbzrGMCGFVFDnNXuLHG+umDT2JA5gA@mail.gmail.com>
X-Gm-Features: AWEUYZlT7fvH-JMdmx4NAh1H-2g0fyV5eADSnCK8gOOETth1WegVG1e_pyJ_b4g
Message-ID: <CAKchOA3u9a2UK-xGONcEBbzrGMCGFVFDnNXuLHG+umDT2JA5gA@mail.gmail.com>
Subject: Re: [PATCH] thermal: gov_power_allocator: Update total_weight on bind
 and cdev updates
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Yu-Che Cheng <giver@chromium.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Chen-Yu Tsai <wenst@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> This is basically fine, but I would add a new function, say
> power_allocator_update_weight(), for updating the weight.
>
> >         case THERMAL_INSTANCE_WEIGHT_CHANGED:
>
> And I'd call it from here and from power_allocator_bind() below.
>
> >                 params->total_weight =3D 0;
> >                 list_for_each_entry(instance, &td->thermal_instances, t=
rip_node)
> > @@ -731,6 +730,8 @@ static int power_allocator_bind(struct thermal_zone=
_device *tz)
> >
> >         tz->governor_data =3D params;
> >
> > +       power_allocator_update_tz(tz, THERMAL_INSTANCE_WEIGHT_CHANGED);
>
> Because this is kind of confusing (although it will work AFAICS).

Thanks for the suggestion. Will apply in v2.

On Fri, Feb 21, 2025 at 6:43=E2=80=AFPM Lukasz Luba <lukasz.luba@arm.com> w=
rote:
>
>
>
> On 2/20/25 19:40, Rafael J. Wysocki wrote:
> > On Wed, Feb 19, 2025 at 8:07=E2=80=AFAM Yu-Che Cheng <giver@chromium.or=
g> wrote:
> >>
> >> params->total_weight is not initialized during bind and not updated wh=
en
> >> the bound cdev changes. The cooling device weight will not be used due
> >> to the uninitialized total_weight, until we trigger an update via sysf=
s.
> >>
> >> The bound cdev update will be triggered during thermal zone registrati=
on,
> >> where each cooling device will be bound to the thermal zone one by one=
.
> >>
> >> The power_allocator_bind can be called without additional cdev update
> >> when manually changing the policy of a thermal zone via sysfs.
>
> Thanks Yu-Che for catching this.
>
> >>
> >> Update total_weight when bind and cdev updates to ensure total_weight =
is
> >> correct.
> >>
> >> Fixes: a3cd6db4cc2e ("thermal: gov_power_allocator: Support new update=
 callback of weights")
> >> Signed-off-by: Yu-Che Cheng <giver@chromium.org>
> >> ---
> >>   drivers/thermal/gov_power_allocator.c | 9 +++++----
> >>   1 file changed, 5 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/g=
ov_power_allocator.c
> >> index 3b644de3292e..600cb0e367c3 100644
> >> --- a/drivers/thermal/gov_power_allocator.c
> >> +++ b/drivers/thermal/gov_power_allocator.c
> >> @@ -656,11 +656,10 @@ static void power_allocator_update_tz(struct the=
rmal_zone_device *tz,
> >>                          if (power_actor_is_valid(instance))
> >>                                  num_actors++;
> >>
> >> -               if (num_actors =3D=3D params->num_actors)
> >> -                       return;
> >> +               if (num_actors !=3D params->num_actors)
> >> +                       allocate_actors_buffer(params, num_actors);
> >>
> >> -               allocate_actors_buffer(params, num_actors);
> >> -               break;
> >> +               fallthrough;
> >
> > This is basically fine, but I would add a new function, say
> > power_allocator_update_weight(), for updating the weight.
> >
> >>          case THERMAL_INSTANCE_WEIGHT_CHANGED:
> >
> > And I'd call it from here and from power_allocator_bind() below.
> >
> >>                  params->total_weight =3D 0;
> >>                  list_for_each_entry(instance, &td->thermal_instances,=
 trip_node)
> >> @@ -731,6 +730,8 @@ static int power_allocator_bind(struct thermal_zon=
e_device *tz)
> >>
> >>          tz->governor_data =3D params;
> >>
> >> +       power_allocator_update_tz(tz, THERMAL_INSTANCE_WEIGHT_CHANGED)=
;
> >
> > Because this is kind of confusing (although it will work AFAICS).
> >
>
> Thanks Rafael, I agree with suggestions. It would look cleaner.

