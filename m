Return-Path: <linux-kernel+bounces-518147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF26A38A90
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 18:29:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F373B3A8385
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 17:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0608F229B18;
	Mon, 17 Feb 2025 17:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="rmqFTt/m"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E33229B0D
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 17:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739813383; cv=none; b=WP0FLavCJRySu0+vBNpWGsu/jgA6SPfnTdeXsuVgMy1fsVpWKeaUP91KvhVVv76XRfT+2QLVbUZRiHkjBNcpZtFUuWKarWN206tjCvv3/6rX9f/VoaO21nZ4Rq9ae6Ujm74/xrqKLc56ruVOYCIpcs2u4AoJMfgYwQ5PbZIQgNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739813383; c=relaxed/simple;
	bh=s8dzY5m0DbaSWfX0zyqEIlUY/J7cVRud2RuXtwGN0hE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jl7+Aa+vQgCHJlFa/LrFqEXbkiOtGHoYRurDnoMFyTxz+vrnv8OVxYjL6thrIwpwKEgoKh9h3HLjl+uA9MRkcaH4At37u8D1tOqZq6R7BAudHC39yPPnVr6+j43G86mY8eIEHXaDe5ONVvLoiR6mJ1jn2GNKAjjvxdJwdUkaAkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=rmqFTt/m; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5461dab4bfdso1763458e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 09:29:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1739813378; x=1740418178; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s8dzY5m0DbaSWfX0zyqEIlUY/J7cVRud2RuXtwGN0hE=;
        b=rmqFTt/mrS84iRmLCwppxeaJvyD957kbtaLsZxyaJc6PMCcstsJcCDQYVqxW2dBnpc
         XCqsfK5M5RJwrlNORQwziLtshr8I7TYBI6uySRIfSu9ViOCTlAbLlMwFymDUmbPUtw7P
         TdpgBBAPjtkTNh8mIUAWHiacjHwR2j5HLFnUDpi++0upYyreiBXYEL0BD5uacEtmOqvv
         mTdPw/XkHhEKz70v47pxOd4e/Z66O4MRNUK9Xs+gtSPeUnh2sYHlvv4H3hH3qBSImJum
         SEithWz8VH7Owqr4fHcYIzKgGyFXtyVZn5qFF/tzEzdCkb96iYXIwuhAzs4yzWoMr+d/
         Ghrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739813378; x=1740418178;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s8dzY5m0DbaSWfX0zyqEIlUY/J7cVRud2RuXtwGN0hE=;
        b=CE+c3SU9jBmwSC0kVfJsKv7N1sAXZrP/NMig+6hc5pxQn4Id6QguBDBhXUl+4Let/0
         2gx9TAB097KmBD+YHaTivSNYeI8ZGlD4LH/RbgmZGwpysqW/UJQAq2DBn7FAIL9ITup9
         xAa6sgs5NnotrwmnE5E2wzAhhHc7xZqluqZaZcn+kKsUBZq0pNf2vTs2Wvnu9XLkkZKI
         CB0gWzEbXsJN9kPY3Uj+FI8JbVs7Rwt3DynE7v2cmq98Ikqgbi0w0t0bWysnmpzvOU57
         6Xj7SQ8ECYM6+cgqRopaf940IrukTR+PokDT4PWFedzJ8l5E7V0C5MPtJL3uRwyC9Iku
         dsrw==
X-Forwarded-Encrypted: i=1; AJvYcCWsAvh2MyAEzBk4mdT7+qCr2qBy3DdwS48la/HXq050SgVVRqcF92Z6IulnS3pVYMNR8IIw0CN+nyPmA7o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoWWyejuzIx88U7bxyvOncZRxsWE1sLffZgKzZ0ZXJW17mRJ0Z
	2yE5ojPSuhkb9q9cqY7qsYKObrguIlWZcNYlu2LVcwZxNlXi9d83C2ORQBhXLquBwiM3QQWbacn
	e2CjHyuOPX+SCg5lt2yJoQCfjEnFi8mJ6YoTfJA==
X-Gm-Gg: ASbGnct5KxjTtvS+gxvRqPk9YBdEKlgCb++nSh3t4PeMd9NrbcLy8bj6xx2mOsYzz1/
	pxz8alVxcum/yFNY2pgGkomKuW5onn69KmpyFWfmYNaAjGhDniww5jPRwPpNEflLdLtUIsoi8Ea
	sG1ygc+x8aQi0sHpuvizhPATizMw==
X-Google-Smtp-Source: AGHT+IE8QEuhEYZ24C4MMRyD/iBuHqWWRbXusKYLKvI+f/pb9+H5RoRo7m8dxQTfwNFT6k/Rkn4el4mFMHaELpJojog=
X-Received: by 2002:a05:6512:308d:b0:545:2d80:a482 with SMTP id
 2adb3069b0e04-5452fdb7516mr3492740e87.0.1739813378119; Mon, 17 Feb 2025
 09:29:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250217142758.540601-1-koichiro.den@canonical.com>
 <20250217142758.540601-2-koichiro.den@canonical.com> <CAMRc=McB0bcG4jERmUyrQ=eTP+kcfLBBAOaT7mCMKbgUB1W5nw@mail.gmail.com>
 <d2qdoq3f3jk6gzgsjeqszgaqk7z523r7cfnopxfq4ghsbsqgp3@zjw67ewqzi5u> <uogv4ckqo2e2byspffvfayu44v6fl46sxtu7eudweoye62sofi@5iwsumpttpca>
In-Reply-To: <uogv4ckqo2e2byspffvfayu44v6fl46sxtu7eudweoye62sofi@5iwsumpttpca>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 17 Feb 2025 18:29:27 +0100
X-Gm-Features: AWEUYZkUECy20dI1_GnljHzFs8Mj0vatIPhRinb1LxPTtf-RSOskSmCP_32n6aA
Message-ID: <CAMRc=MdNtDW_Gbd6dsG345110SCWe1vD_rNd_QaWBYRApHBoxQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] gpio: pseudo: common helper functions for pseudo gpio devices
To: Koichiro Den <koichiro.den@canonical.com>
Cc: linux-gpio@vger.kernel.org, geert+renesas@glider.be, 
	linus.walleij@linaro.org, maciej.borzecki@canonical.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 17, 2025 at 5:21=E2=80=AFPM Koichiro Den <koichiro.den@canonica=
l.com> wrote:
>
> On Tue, Feb 18, 2025 at 01:12:17AM GMT, Koichiro Den wrote:
> > On Mon, Feb 17, 2025 at 04:46:30PM GMT, Bartosz Golaszewski wrote:
> > > On Mon, Feb 17, 2025 at 3:28=E2=80=AFPM Koichiro Den <koichiro.den@ca=
nonical.com> wrote:
> > > >
> > > > Both gpio-sim and gpio-virtuser share a mechanism to instantiate a
> > > > platform device and wait synchronously for probe completion.
> > > > With gpio-aggregator adopting the same approach in a later commit f=
or
> > > > its configfs interface, it's time to factor out the common code.
> > > >
> > > > Add gpio-pseudo.[ch] to house helper functions used by all the pseu=
do
> > > > GPIO device implementations.
> > > >
> > > > No functional change.
> > > >
> > > > Signed-off-by: Koichiro Den <koichiro.den@canonical.com>
> > > > ---
> > >
> >
> > Thanks for the review.
> >
> > > Looking at this patch now, I've realized that there is nothing
> > > GPIO-specific here. It's a mechanism for synchronous platform device
> > > probing. I don't think its place is in drivers/gpio/ if we're making
> > > it a set of library functions. Can I suggest moving it to lib/ and
> > > renaming the module as pdev_sync_probe or something else that's
> > > expressive enough to tell users what it does? You can make me the
> > > maintainer of that module if you wish (feel free to add yourself
> > > too!).
> >
> > I had vaguely envisioned that this might eventually contain some
> > GPIO-specific code for some reason, and also it's just a tiny utility t=
o
> > reduce code duplication, which is why I placed it in the neighborhood,
> > drivers/gpio/. However, of course you=E2=80=99re right, there=E2=80=99s=
 nothing
> > GPIO-specific here, so moving it to lib/ makes sense.
> >
> > I'm not really sure if this method for synchronous platform device prob=
ing
> > can be broadly accepted as a general solution, but I have no objections=
 to
> > making the change. I'll move it as you suggested and send v2, setting y=
ou
> > as its maintainer.
>
> Regarding this series, I feel that it might make discussions smoother if
> you submit it directly. So if you're okay with it, please go ahead. In
> that case, there's even no need to mention me or CC me - I can track it o=
n
> ML :)

I'm not sure I'm following. Why would I submit it myself? You did most
of the work already. If you want the changes to gpio-aggregator
merged, then I think that it's time to refactor this code before we do
that because repeating it three times is just bad programming. I
probably wouldn't have done it otherwise at this point.

The code looks good other than that, just put it under lib/, rename
functions to pdev_sync_probe_init/register/unregister() and send it to
the list as usual. With that it's good to go. Just make sure to
mention to Andrew Morton the need for this to go through the GPIO
tree, I don't think he'll mind.

Bart

