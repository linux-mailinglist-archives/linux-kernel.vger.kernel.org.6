Return-Path: <linux-kernel+bounces-300847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5524C95E938
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 08:46:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5E50281213
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 06:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D263683CA0;
	Mon, 26 Aug 2024 06:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iQztAJ0f"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F6881742
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 06:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724654806; cv=none; b=Io26URmuvacol+1aZmSqpfHBplvZhu8NL/2S4HonaAwTNGk11vcRZG1Xwn2W2V0vkcNYtHscyiFkG8yOfjWhJ8XZ60k1V7yqWepMY7TUIMYaDOcBv2xXwj/dd9e8HVOv84I/Sm0D3LJcn9FpHb2xijiBTHiph+LpA242k8bsbhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724654806; c=relaxed/simple;
	bh=Pb5HMPckE7rab17yr39tAC0kkeNgAa+55ZzvCXR8H9k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A44WCL9V/eGSkZPckveEKf4htReb/ZMagdUNl2lTW2kgteExGOJN93fQzGLHhc0BD6rVNpY3houQprsJXr7gBR6aEePZNEj4Xaxa5zVFkJW4r9+b0FfuNRrF05+WU0hyupCqV11amjJph5kwGl4h35jVw8WeRSaQQHVEiXkLi4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=iQztAJ0f; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2f5064816edso13670951fa.3
        for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 23:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724654802; x=1725259602; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pb5HMPckE7rab17yr39tAC0kkeNgAa+55ZzvCXR8H9k=;
        b=iQztAJ0f3ivPCDmXaRGDvLX8tFzeIzDDHh98Z4hgWZFn49PNhzdwRD5uDh/XaVtQq/
         FoAgwIDf39LsXHA2Ky+X3es9+pzKnuVGYtulZaTBuqvBTjNrk2VVyTexVAjXBEvMSeme
         pR0hpemDfEXHTXb0MEDMK//OZlHJUIibqaMcA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724654802; x=1725259602;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pb5HMPckE7rab17yr39tAC0kkeNgAa+55ZzvCXR8H9k=;
        b=IDcFsmUftzUNEK/LQpKCNLXH/f8+GwfS6LKSwqTf388+EI3YPkGeEpEeDTqQ6UOy0S
         7wYTdsb20rTt1to5e7EgpsniRR8vcsTzhrZk7QOpi13qmOEa/So603IA9d4pdFDIXmmB
         0Q2rSfRpQyo/YJu7TNqVucoBnL0dmHxzkjTX0cLXWA23xOAas3cQu7RcU8UmG1jTlo3b
         ybhshJnyGEmVBnBANgMlmxDF9ap8m4Cx0jYYt4qILbQDJReiKjobiL54+/fQ7tFLu8tC
         nTjtGyxJS/Y57+8ymlg7SsvvE1rhnZJjLpBlwVgIgisL/qWXekpJpOZiQan3HPbpcXHZ
         3e8g==
X-Forwarded-Encrypted: i=1; AJvYcCU8xq2U/PBMb3iL7K4uvRUTgCSJHHeCv/Mql8XfJnV+YL7cxJBndwApW7NpDeMyxaOj02+iTMh7HB2wqdE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjcKt5arw5Q9qWzMZw8idLSox7O9FrGmVQzsC2EJJrOiaEwe4T
	y0opPFxvl+Rq27riMuw9hzDK0NSRVeAXcJTvZyKWhX0H/kVjwVgM3WICBZxbcqJYhovRB4xmFhn
	YRwoHKSLejBxTOR2OaE3cYTn7dRlq7JIlB0gv
X-Google-Smtp-Source: AGHT+IH4DcAdsdETmFTlhuJdrATVXH7fDL01UNUX4b9VbFz9hg6UqEkKKO/I+KkXGBZXYBevq6GR/cInwzl+FyACB/c=
X-Received: by 2002:a05:6512:3b98:b0:533:4785:82a7 with SMTP id
 2adb3069b0e04-53438783b14mr7187223e87.28.1724654802231; Sun, 25 Aug 2024
 23:46:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240822092006.3134096-1-wenst@chromium.org> <20240822092006.3134096-3-wenst@chromium.org>
 <ZsdBddTDuvNasHNq@smile.fi.intel.com> <CAGXv+5FjwxGQgV6SdLfTeNRYbpcgwkEnCWvaZiWh4rs3bhs-2A@mail.gmail.com>
 <ZsiR-kizxnvZufgR@smile.fi.intel.com>
In-Reply-To: <ZsiR-kizxnvZufgR@smile.fi.intel.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Mon, 26 Aug 2024 14:46:30 +0800
Message-ID: <CAGXv+5G1OsrPSwFs64-MPSQgp28=Jk7zKs1WDDjVNrmPfSd0sw@mail.gmail.com>
Subject: Re: [PATCH v5 02/10] regulator: Move OF-specific regulator lookup
 code to of_regulator.c
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Wolfram Sang <wsa@kernel.org>, 
	Benson Leung <bleung@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>, 
	Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	chrome-platform@lists.linux.dev, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Douglas Anderson <dianders@chromium.org>, 
	Johan Hovold <johan@kernel.org>, Jiri Kosina <jikos@kernel.org>, linux-i2c@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 23, 2024 at 9:43=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Fri, Aug 23, 2024 at 02:49:59PM +0800, Chen-Yu Tsai wrote:
> > On Thu, Aug 22, 2024 at 9:47=E2=80=AFPM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > On Thu, Aug 22, 2024 at 05:19:55PM +0800, Chen-Yu Tsai wrote:
>
> ...
>
> > > > +/**
> > > > + * of_get_child_regulator - get a child regulator device node
> > > > + * based on supply name
> > > > + * @parent: Parent device node
> > > > + * @prop_name: Combination regulator supply name and "-supply"
> > > > + *
> > > > + * Traverse all child nodes.
> > > > + * Extract the child regulator device node corresponding to the su=
pply name.
> > > > + * returns the device node corresponding to the regulator if found=
, else
> > > > + * returns NULL.
> > >
> > > At the same time you may fix kernel-doc warnings (no "Return" section=
) in these
> > > three (on your wish you may fix others in a separate change, but it's=
 not
> > > related to this series).
> >
> > As you said some other functions are missing it as well, so I'll do a
> > patch separate from this series to fix them all.
>
> But you need to fix them in this patch series. We do not add patches with=
 known
> issues, which are really easy to fix beforehand.

I'd say that's a preexisting thing, and code movement shouldn't change it.
But, yeah, I can send another patch fixing up all the kerneldoc issues
in both files.

ChenYu

> (And below seems you indirectly agrees on that)
>
> > > > + */
>
> ...
>
> > > > +/** of_regulator_dev_lookup - lookup a regulator device with devic=
e tree only
> > >
> > > Something went wrong with the indentation.
> >
> > Will fix, and also add a "Return" section.
>
> Thank you!
>
> > > > + * @dev: Device pointer for regulator supply lookup.
> > > > + * @supply: Supply name or regulator ID.
> > > > + *
> > > > + * If successful, returns a struct regulator_dev that corresponds =
to the name
> > > > + * @supply and with the embedded struct device refcount incremente=
d by one.
> > > > + * The refcount must be dropped by calling put_device().
> > > > + * On failure one of the following ERR-PTR-encoded values is retur=
ned:
> > > > + * -ENODEV if lookup fails permanently, -EPROBE_DEFER if lookup co=
uld succeed
> > > > + * in the future.
> > > > + */
>
> --
> With Best Regards,
> Andy Shevchenko
>
>

