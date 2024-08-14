Return-Path: <linux-kernel+bounces-285858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 392F9951380
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 06:27:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAF832813C0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 04:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7F544CE13;
	Wed, 14 Aug 2024 04:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NuCPPJdN"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F32D55C3E
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 04:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723609623; cv=none; b=NY2GmAIw9xKiukLpMCYGn3J9Ab9gBVvtmr1vO8x1U7oFoaSLieQ/1uC9wRhPxStdkgGKzrlK+AHeQg5DPjQDsvVD2gCmJCu/IwdH2g/xo1icba1UoQiqr2QzlzUvRNnAF796kpP2RixUBATdC8jcg7BDW8tIi9zYtsJTCUaHrvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723609623; c=relaxed/simple;
	bh=/OjkMvtUQsuACR66qNVjtKUOKRCwnBBFDXqQ+hO5LGA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=awkY01A1EQmR1fpjLQ1CfiT77/vfr5AruV7GrSyrv4HoADvUJpF8dlCFfHyNynnsZNTRTIF24SqxkLYu2CD05WbzdQ3XezCP1FGkWhLHb4dgJN6BK0m0ALYIcgufFSgu7eicrybz29ZrIsYHEv4i5VKkKc/UPhwve1bGl6FlJ2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=NuCPPJdN; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52efd855adbso7753025e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 21:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1723609619; x=1724214419; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p2sGTnWhAAxCBideXOSfildCbbJbkxzd9wlf9Y8JEp8=;
        b=NuCPPJdNKZzhsd0tfp6D6NAqDFDhjkG0wPxzJoxakX9u0z5IZzFV99gfdSsEbikTmj
         nvGW5bB4ERW86lSUE7L+RU5kBvTIxbHzcyy+NlxNo7rsL2eM/Woi6BvYx2OF57eoo1B1
         636XrTzT+iULIPC0+dmIoae7+o6lhI52iRGTg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723609619; x=1724214419;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p2sGTnWhAAxCBideXOSfildCbbJbkxzd9wlf9Y8JEp8=;
        b=Z9iyHvn5F9i3O6r1JYV9CasvJXXak24tjS9YiE86q229GCPkzKwrdGFmLJwM0JegMM
         1MvgogRzRBDsCGbiwGrsvydqzZO3LvLiPUABj0PKMB7OxNAUJlNqPENqE2BPQhyApcT0
         ilg3BXYFgPfmRugxJBPLVO8T2+TvZwoQ05w/NZBgbpkKP4MUVmx6UOi9QUn4wW36ALBx
         NRVdpqSy6RZWXhi+wJrkqweV8YhgLV5Eq4otGgqOMETyZRu9Rt84BcYeDlw+CLw4G83I
         ZYpE5nra9b4wyh8FeBAnjUsTKuiSivWcgrMeVn24uHa1XQoZg/CorGtU8WI+N1okl2LI
         94rw==
X-Forwarded-Encrypted: i=1; AJvYcCX6Uff5JEQcS5QfFmTbdV3COTqfHwTXkN+lQEYMaHVHLxt3+y0WOJtrefHJV8/YcyQuyxSvpkqKOu+OUw+aKpMKgiybESu5l88MD+pv
X-Gm-Message-State: AOJu0YyF1f2zwEg3LOPPapPQ4PUw6mCmyRVYjH/EnHWIb7r4gfK94iXL
	1oyL5eZWDrGidWa/4DNF7Fy3KO9E14kYci5xFSFRHe0p/tWPN8wDBzZK4aL8N+vzET9sLzwhzBn
	gn+fRhe3pN4QbukcH3J9gPfWkD1jXNvjqQDd/
X-Google-Smtp-Source: AGHT+IGq5JnrkQvBmtbDIMCjqiKcKn4UUIGlSmcL8VKx33PYxUW8uxuiq5DIDlEU7bjWcTHbhZFieWS9pBfHwDH245w=
X-Received: by 2002:a05:6512:350f:b0:532:f1db:d0bc with SMTP id
 2adb3069b0e04-532f1dbd293mr332752e87.20.1723609619020; Tue, 13 Aug 2024
 21:26:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240808095931.2649657-1-wenst@chromium.org> <20240808095931.2649657-2-wenst@chromium.org>
 <Zrs_YijPxKBFQF0_@smile.fi.intel.com> <20240813191835.GA1598838-robh@kernel.org>
In-Reply-To: <20240813191835.GA1598838-robh@kernel.org>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Wed, 14 Aug 2024 12:26:47 +0800
Message-ID: <CAGXv+5ER7DDdE-778JJZu9WTQejy0W0dYM7WZhXj2MzrUWrC6g@mail.gmail.com>
Subject: Re: [PATCH v4 1/6] of: dynamic: Add of_changeset_update_prop_string
To: Rob Herring <robh@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Saravana Kannan <saravanak@google.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Wolfram Sang <wsa@kernel.org>, 
	Benson Leung <bleung@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>, 
	Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	chrome-platform@lists.linux.dev, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Douglas Anderson <dianders@chromium.org>, 
	Johan Hovold <johan@kernel.org>, Jiri Kosina <jikos@kernel.org>, linux-i2c@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 14, 2024 at 3:18=E2=80=AFAM Rob Herring <robh@kernel.org> wrote=
:
>
> On Tue, Aug 13, 2024 at 02:11:30PM +0300, Andy Shevchenko wrote:
> > On Thu, Aug 08, 2024 at 05:59:24PM +0800, Chen-Yu Tsai wrote:
> > > Add a helper function to add string property updates to an OF changes=
et.
> > > This is similar to of_changeset_add_prop_string(), but instead of add=
ing
> > > the property (and failing if it exists), it will update the property.
> > >
> > > This shall be used later in the DT hardware prober.
> >
> > ...
> >
> > > +int of_changeset_update_prop_string(struct of_changeset *ocs,
> > > +                               struct device_node *np,
> > > +                               const char *prop_name, const char *st=
r)
> > > +{
> > > +   struct property prop;
> > > +
> > > +   prop.name =3D (char *)prop_name;
> > > +   prop.length =3D strlen(str) + 1;
> > > +   prop.value =3D (void *)str;
> >
> > Is it the existing style in the file? Otherwise I often see style like =
this

Yeah. This was mostly copy pasted.

> >
> >       struct property prop =3D {
> >               .name =3D (char *)prop_name;
> >               .length =3D strlen(str) + 1;
> >               .value =3D (void *)str;
> >       };
> >
> > in the kernel (IRQ domain, platform core, ...).
>
> Okay with me to use this style regardless of existing style.

Ack. I'll update it to the more modern style.

ChenYu

