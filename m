Return-Path: <linux-kernel+bounces-336256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2A8197F12A
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 21:19:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC81E1C2160E
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 19:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D822B19F42C;
	Mon, 23 Sep 2024 19:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Bsw4bIrJ"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A44F15E86
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 19:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727119172; cv=none; b=OSJ/vfl7aeKqW8bKud/WeAYfehMI6+pCgc8tzO4wUydRCSnoYgw0bt0zvLxihNwp0/yFI1NeH2yK6OgLTsmyfJU2DIXPKbtijNvUbDmfZvrjsWANP5eE3vHgiO28M9vcQvrU22qbh1ERC3i47ognICgZ1UamHLdfqZYmCKJes/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727119172; c=relaxed/simple;
	bh=xf364lZIbnjp5yXv/kYTrKS69WYtJ5dXPHV7dU2ANQM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BaxxZG3L5DY04sD34aWd616bvNw72TrSWJms0Z9mWdlTrXEo2bZvscJhS6bQVoIZAHlW61HDFMjntMhBctk/H7u4Avo8TeaEGI6bbz2bZVKNCL4N+HpaZA0A20i5xoXiUJmmjKFs/pB9ctK9Z4RAkCDYEj2GiV3IRIMUBVFtt4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Bsw4bIrJ; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2f8ca33ef19so14927321fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 12:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727119168; x=1727723968; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FTdpdNtDHKc5MwXK6gfkOgHrOXbWdY15It+qZL/P+lM=;
        b=Bsw4bIrJ7MVo53cx9kA2Hks3qWvCvslh0cpLY1io2xk57RdPiPQy/3Bw+nJ3HRE3mJ
         t5T6RS12PrBt9N8QnUl0IofBQAuIkigjzn1XxR5e4HbxqmTN1XRODhe6gXPdYHlxhem9
         Wn9XFmYdbcGEDOLNOD1uVs8GkWBg/jM7fw0iM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727119168; x=1727723968;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FTdpdNtDHKc5MwXK6gfkOgHrOXbWdY15It+qZL/P+lM=;
        b=FP5Rx/6/COUJCtpNcnC8dZi6IERQKVfeBmeaEdCVCudBbjn9pyELmPMOvKCOj/dqPA
         X9EX/T69FUONNR0jL+1UNNLzyb7RIJHycea+X4v6KlZ35cjtbfzPwbw1qDxHaSoR8Ydx
         2ICZpEl6TwqlP3Daq5z1+VznViT8OgxE661Jy77olQ1h/XSoEicGSzQeFrHyq78ClT15
         cbLGsldEWSTEff/8oomvPKXTVZzgP4Cc//PbK2x1VE6nyQu/exhi3vHyZ4lhM5pyJkZy
         We6hsN7nbfbUYK2zT77xh++w2N2xAYqpgHCIXLHoii6bZyaM62NtaTxlJV/brXWpaZwy
         iD4g==
X-Forwarded-Encrypted: i=1; AJvYcCV9VOC8mD25DeLYKXX6ym6QQa+euoZOiG19DdK7dlXY+pbTtGmQFubvD0EyQVFVyn/BZpUcgngpSNg99ZY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuG59f/3q4tN7BosCaeyZMVbYW97A8LxkiaPnNKSpJ9bLfVUhX
	omCLNKHWR60cwvzP9YxJhReAIaqAdrGkFhvRAksxVxoy4HVUc0H/Si/aOpMDomVDF9IzttWT+YJ
	N1+kR
X-Google-Smtp-Source: AGHT+IGUa72o0IKpreml8gAXbRBsuzn29RhY83M+ZCZnTLwVCAGULN79dAmH5ab5RLA7oSm212/TQw==
X-Received: by 2002:a05:6512:ea8:b0:533:407f:5cbd with SMTP id 2adb3069b0e04-536ac2d6a95mr9036831e87.7.1727119167977;
        Mon, 23 Sep 2024 12:19:27 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-536870b8cd6sm3346090e87.290.2024.09.23.12.19.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2024 12:19:27 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2f761461150so55033341fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 12:19:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUYkW6cRNeyrTJfVruULfs3iI0IyKM2to3RbX76WK3y2Daw9AkKNZdKr6QodQYgvAvXbHkHE5foBVEEXpA=@vger.kernel.org
X-Received: by 2002:a05:6512:2309:b0:536:5625:511f with SMTP id
 2adb3069b0e04-536ac32f109mr8497177e87.45.1727118764064; Mon, 23 Sep 2024
 12:12:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240911072751.365361-1-wenst@chromium.org> <20240911072751.365361-9-wenst@chromium.org>
 <CAD=FV=XvPA0UC87fQ+RvFzPv9qRSEP6eQhT79JOx9Arj87i9Mg@mail.gmail.com> <CAGXv+5EcxGfdzvarg8hmk1zR9X0s8KUzayQdxfWTrasEGpj=1g@mail.gmail.com>
In-Reply-To: <CAGXv+5EcxGfdzvarg8hmk1zR9X0s8KUzayQdxfWTrasEGpj=1g@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 23 Sep 2024 12:11:49 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Wv1uFmxFsaxT9tY=-fwnPsXDjnabNxQ-cK3hm2a9Wo7A@mail.gmail.com>
Message-ID: <CAD=FV=Wv1uFmxFsaxT9tY=-fwnPsXDjnabNxQ-cK3hm2a9Wo7A@mail.gmail.com>
Subject: Re: [PATCH v7 08/10] i2c: of-prober: Add GPIO support to simple helpers
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Wolfram Sang <wsa@kernel.org>, 
	Benson Leung <bleung@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>, 
	Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	chrome-platform@lists.linux.dev, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>, 
	Jiri Kosina <jikos@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	linux-i2c@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Sep 17, 2024 at 5:41=E2=80=AFAM Chen-Yu Tsai <wenst@chromium.org> w=
rote:
>
> > > +static void i2c_of_probe_simple_disable_gpio(struct device *dev, str=
uct i2c_of_probe_simple_ctx *ctx)
> > > +{
> > > +       if (!ctx->gpiod)
> > > +               return;
> > > +
> > > +       dev_dbg(dev, "Setting GPIO to input\n");
> > > +
> > > +       gpiod_direction_input(ctx->gpiod);
> >
> > This is weird. Why set it to input?
>
> It seemed to me this would be more like the initial state, without knowin=
g
> the actual initial state.

In this case, though, you're trying to turn off the resource, not
trying to get back to the initial state. IMO deasserting the GPIO is
the way to do this. If the output needs to make it an input in this
case then it can use some type of open drain mode.


> > I would also say: given that you're providing a parameter anyway and
> > you're giving the GPIO name, can you please move away from the "raw"
> > values and move to "logical" values?
>
> I disagree. When hardware engineers design for swappable components, they
> likely look at the electrical compatibility of them. In this case, an
> active-high "enable" pin is electrically compatible with an active-low
> "reset" pin. If we use the logical value here, then we would need more
> logic to know when the logical polarity has to be reversed.
>
> Note that this doesn't work for components that are electrically
> incompatible. But in that case a lot more board dependent code would be
> needed anyway.

As we talked about in person, that made sense in the previous version
of the patch where you were looking for all GPIOs willy-nilly. Now
you'll be specifically asking for a GPIO by name and we should honor
the "active high" or "active low" nature of it.

-Doug

