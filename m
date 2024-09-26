Return-Path: <linux-kernel+bounces-340153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E1B62986F23
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 10:44:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44F36B21F9D
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 08:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1B0E1A7AD8;
	Thu, 26 Sep 2024 08:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ADgHN8gD"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B807E1A727A
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 08:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727340247; cv=none; b=D1bL1ZcUpstInQ8/UbxkVw3HZa39ztPqXF4o0TeMr4Etcwa8o6YgC0YRKrHO1XmUoWQAYfDhKZQXLYiyGSMhBxPl7mN9CGszeqLfvJ9u5Tnjyn620enmw7gmEP5kDllt7CvQm+8t8iV25XE4mqe0tHAEoRSv5f2ksMv6Q7lYJ68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727340247; c=relaxed/simple;
	bh=YT336u0TzzzyADlaibqjLJo1Q1OzJN93THARgvbawtE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GAuG0J6eVPRRclxUthOLtBgTc9qCtiFdDEMXutLr4rDCaSmeGs1flTk614cOWlgr793YhI0O5d6dfuHhotM1/tHGW3+isCqxHtvMrjurrUqalU0zq005prb+RWVgjWK3nVq1yafsu4XK0/A3kLIymD3ulIWEcO5sLzPphGgKEsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ADgHN8gD; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5365a9574b6so1183033e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 01:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727340244; x=1727945044; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gznSMtiYcyR3w+ziWE7zvvdEk/47hMv313+7HUPIjik=;
        b=ADgHN8gDwTv/XhcSMPLEVtRlJyFz0orDBleKqssoksS7aiBT1UQgH5QpI5ry07rv8P
         ZeuTCcxXMeXneP4kOf3iR5PNxN0GYvgXGVRAAMUlVcoQpYYau6voQZT9de6MQu5iNrnW
         br7Kaiptrt4+9rxVeNTL70XK2/mhlQDb1pr/c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727340244; x=1727945044;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gznSMtiYcyR3w+ziWE7zvvdEk/47hMv313+7HUPIjik=;
        b=VjtHK9L+BKhONYQpKOFDWyP0E/6Tf/c6iv4Gkns2IgfojljF5I/mxmpyhvI+R+8ZD7
         rYqnPJQ9URjcWns8kzg6WoUWjllFCEfnKEu5wKvvBcNkmgJuABJED7BiQIr4BaYQsxcT
         q9sSburYiZ5hSgckhRXlizCQiqaaxkacLwLEYMvUO61qTV8g8DVpzw3TWTFyDWrjJCoo
         Czwf2uR2Gp3tfJqspcOwG4ld6+GQb2WrYZtZuOFSrj6AsS7QeHrPGmLNm/1hdyHMbYTX
         1vdXtLIapekhEOGNzHgtv5P4xKImk/RuZv/6nVPucTp6O3lCyqhpxmBUNkmhvIF9tKzl
         Wpjg==
X-Forwarded-Encrypted: i=1; AJvYcCVYwOtQGffVu1ZogBIpeqvmE480P+ulrXxKQYYATUkqpgPM1MtYzvHkENgluxoThpWnUY8+Ro0nRnI87M8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYdnGNFo1H6WrVPEkqzYWXWRGqJTo1grrwGat/7r7Z/a+cl2zi
	KYZluuetWzGOvyTXQEwKRZ+2DipUR/UOwlDD5M13ZI3vyhmcaxDxHD03BEHKY7jXzst2TCIv/oe
	9CNQprvHkCibj/SKvNmjIBEit0ht9gXKz8T25
X-Google-Smtp-Source: AGHT+IHaqH2XD1kwP3As68zb4RqTHQB3YnbJsTJoL46ahD760ygreD1XSQDeJe/F8UpUYLGLJ5vsf+1cWC0dd7Zm+uM=
X-Received: by 2002:a05:6512:1310:b0:533:483f:9562 with SMTP id
 2adb3069b0e04-5387755ce6dmr5254176e87.42.1727340243659; Thu, 26 Sep 2024
 01:44:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240925093807.1026949-1-wenst@chromium.org> <20240925093807.1026949-3-wenst@chromium.org>
 <ZvPscRdWlFPmtCyR@smile.fi.intel.com>
In-Reply-To: <ZvPscRdWlFPmtCyR@smile.fi.intel.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Thu, 26 Sep 2024 16:43:52 +0800
Message-ID: <CAGXv+5Gf9+rc+vLcr-JFhO561G8dw38ksV3drat+DyCfWEVakQ@mail.gmail.com>
Subject: Re: [PATCH v8 2/3] regulator: Add devres version of of_regulator_get_optional()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Mark Brown <broonie@kernel.org>, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, Douglas Anderson <dianders@chromium.org>, 
	Johan Hovold <johan@kernel.org>, Pablo Sun <pablo.sun@mediatek.com>, 
	Macpaul Lin <macpaul.lin@mediatek.com>, 
	Sebastian Reichel <sebastian.reichel@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 25, 2024 at 6:56=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Wed, Sep 25, 2024 at 05:38:05PM +0800, Chen-Yu Tsai wrote:
> > There are existing uses for a devres version of of_regulator_get_option=
al()
> > in power domain drivers. On MediaTek platforms, power domains may have
> > regulator supplies tied to them. The driver currently tries to use
> > devm_regulator_get() to not have to manage the lifecycle, but ends up
> > doing it in a very hacky way by replacing the device node of the power
> > domain controller device to the device node of the power domain that is
> > currently being registered, getting the supply, and reverting the devic=
e
> > node.
> >
> > Provide a better API so that the hack can be replaced.
>
> ...
>
> > +#if IS_ENABLED(CONFIG_OF)
>
> Do we really need this?

What's the point of going through devres_* stuff if we already know
_of_regulator_get() is going to fail anyway?

Also, _of_regulator_get() does not have a stub version for !CONFIG_OF.

> > +static struct regulator *_devm_of_regulator_get(struct device *dev, st=
ruct device_node *node,
> > +                                             const char *id, int get_t=
ype)
> > +{
> > +     struct regulator **ptr, *regulator;
> > +
> > +     ptr =3D devres_alloc(devm_regulator_release, sizeof(*ptr), GFP_KE=
RNEL);
> > +     if (!ptr)
> > +             return ERR_PTR(-ENOMEM);
> > +
> > +     regulator =3D _of_regulator_get(dev, node, id, get_type);
> > +     if (!IS_ERR(regulator)) {
> > +             *ptr =3D regulator;
> > +             devres_add(dev, ptr);
> > +     } else {
> > +             devres_free(ptr);
> > +     }
> > +
> > +     return regulator;
>
> Why not using devm_add_action() / devm_add_action_or_reset()
> (whichever suits better here)?

Cargo cult from _devm_regulator_get() in this file. However since this is
meant to share the same release function, both functions need to use the
same mechanism.

I could also argue that this is not an action, but an allocation, and so
devres_alloc() seems to make more sense.


ChenYu

> > +}
>
> > +#endif
>
> ...
>
> > +static inline struct regulator *__must_check devm_of_regulator_get_opt=
ional(struct device *dev,
> > +                                                                      =
   struct device_node *node,
> > +                                                                      =
   const char *id)
>
> I don't know the conventions here, but I find better to have it as
>
> static inline __must_check struct regulator *
> devm_of_regulator_get_optional(struct device *dev, struct device_node *no=
de, const char *id)
>
> Similar to other stubs and declarations.

I don't think there are any conventions. This file already has three types:

1. Wrap the line with the function name on the second line
2. Wrap the arguments; wrapped arguments aligned to the left parenthesis.
3. Wrap the arguments; wrapped arguments aligned with aribtrary number of
   tabs.

I prefer the way I have put them.

