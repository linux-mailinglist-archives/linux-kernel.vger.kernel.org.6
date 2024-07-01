Return-Path: <linux-kernel+bounces-235873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23B1791DAA7
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 10:56:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5461D1C215A0
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 08:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 007951553BC;
	Mon,  1 Jul 2024 08:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="hGBlxvwO"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E121494C1
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 08:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719823874; cv=none; b=u5hr0wXQcl3XPCLR8lJ1cGy3c9qUBRYtRyLNWYc9qqT5XYy5+QZUuxYg+WOJoEASk9OojHG1OMYs6GlJLnL/BVboL6WHGd960c5oJDoD/pDBRw5Y78oG17S7ZxNYMbSHaiXa4hSgkApi85JI4nRd/CI6bFKEo3kn9/cLjC6oj0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719823874; c=relaxed/simple;
	bh=rL247NBQSvqiNNQkTDaaFdrDHdJWz/2L3qB0qtsNmAc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lzf2WdzQ/DyczrA6H0HJzW54Ufyw1I2s7YIiaN/0tRUVXUeqsa5INl3FYTZKJkSlR49GGn4pJGXVEQE5UBuH9OLwY1AXd+x8gMh70ty2D0kFzZFEeMZ1QWE3KUDcROUkdrE4+9TfxvHPpEMtmZ9tIZBWJ8WfB28DWStTh4w8gBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=hGBlxvwO; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2ebed33cb65so28988371fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 01:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1719823871; x=1720428671; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y6IGt/O8Ag/DD0EC0oRxl+iz1s9f79lZeasOTV/wsyo=;
        b=hGBlxvwOoQNQriY16ha0YAk1En+lQ+IlUUSFNTZR6mqtec5iKlmTfWkndr1A6wt5Ad
         83jdVPYfbskA24f6WzNe2reQwu+BwiLjsPcrRZc6J23fKtDZ7oIlQ+JTQ4bOFWBtq4WP
         Jw+wfvgHOrcI8wrY/Y23sG5fvleSKWWkHONY4y4qlAus6Hs/l/gvm3iYRrRffJk/QoRO
         yYZ4IPspkvYKcpFq5oOaAgkBQZatZc/6ca19a899qHUuWjOmy0q3S7q2jWUmEmPa6Pmq
         ELd5Az9XZkQZFWNA84Kcykh+5Pg7lDST4kde2bQvCfJFEzu2C25io9KyLg4QZ7tABSuk
         eXfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719823871; x=1720428671;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y6IGt/O8Ag/DD0EC0oRxl+iz1s9f79lZeasOTV/wsyo=;
        b=dVkVTQB0pi9bAAwgUHVRIFaSjYQ/n0KeV/MlzZhZmCX1nlgpPLq04jSKRa+G8lILuL
         vt6d7UR4q5OaMaVnjN8WfJMhRqIy6y4Jxer1M+0YwahzOTPsKrVRaSeAmv0zLKpK1rJh
         WCgLxW8ZDlInsgKKyd/nNGXu5wIg7fTP+EEElZR26UMp5P2TtMTAB9CVLYa9CN3W1b2+
         u1vq/ipckxqCNnexnO2NjnPA9x9zPkdae68wHygFHW2tXe0EOzVTfTwBx9pmByn4N7M2
         q4zt8xCrcp3O2LcK8h2lZ2fz+QoTBere+vTOiL6q9TpzrHGm8Tzdk9gcG9OSkn2a4jsk
         VwJQ==
X-Forwarded-Encrypted: i=1; AJvYcCVcIXpnVtP9WixPDQcHb/WkIqceO9c902Y5UwbRennXysTksrUoO2hdrPQeyrlGWV9jsvP7IKjnM9orC9PRs6R3itTDBsG2TlbDe9+7
X-Gm-Message-State: AOJu0YyrWt4X/NmLFRSNd7J6voLrCe6wtN2OAkHSBagila/6ZcUPS4Y1
	UEgNq2UPGJD7f+fpOvAkENEuagCTf/MABuQo1fQZ4l480PqX4qyl9WFsp1bPu60qnbOEpdzMDyC
	kALawCAB6tEA1BkvmYGLlGVx5rF8j3yrXIkDr0Q==
X-Google-Smtp-Source: AGHT+IE6uf6X0BVJtjc0lpScjbHL3mLZ3oOMkPXkzRVM0rIYzzSA8+bdRnk3JdXUel7lmANqoMpQprqBLY10Y4VGEAc=
X-Received: by 2002:a2e:8883:0:b0:2e1:2169:a5cc with SMTP id
 38308e7fff4ca-2ee5e3ad770mr33275651fa.15.1719823870802; Mon, 01 Jul 2024
 01:51:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zn8CZ47e3LFncrDP@google.com>
In-Reply-To: <Zn8CZ47e3LFncrDP@google.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 1 Jul 2024 10:51:00 +0200
Message-ID: <CAMRc=McMn6k7QMXLHphNS03BtO=i9xKBwxa71MeVXhtNSFdiXA@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: of: fix lookup quirk for MIPS Lantiq
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Martin Schiller <ms@dev.tdt.de>, 
	Hauke Mehrtens <hauke@hauke-m.de>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 28, 2024 at 8:35=E2=80=AFPM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> As it turns out, there is a large number of out-of-tree DTSes (in
> OpenWrt project) that used to specify incorrect (active high) polarity
> for the Lantiq reset GPIO, so to keep compatibility while they are
> being updated a quirk for force the polarity low is needed. Luckily
> these old DTSes used nonstandard name for the property ("gpio-reset" vs
> "reset-gpios") so the quirk will not hurt if there are any new devices
> that need inverted polarity as they can specify the right polarity in
> their DTS when using the standard "reset-gpios" property.
>
> Additionally the condition to enable the translation from standard to
> non-standard reset GPIO property name was inverted and the replacement
> name for the property was not correct. Fix this as well.
>
> Fixes: fbbbcd177a27 ("gpiolib: of: add quirk for locating reset lines wit=
h legacy bindings")
> Fixes: 90c2d2eb7ab5 ("MIPS: pci: lantiq: switch to using gpiod API")
> Reported-by: Martin Schiller <ms@dev.tdt.de>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/gpio/gpiolib-of.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
> index 59c7f8a2431a..d21085830632 100644
> --- a/drivers/gpio/gpiolib-of.c
> +++ b/drivers/gpio/gpiolib-of.c
> @@ -203,6 +203,16 @@ static void of_gpio_try_fixup_polarity(const struct =
device_node *np,
>                  */
>                 { "qi,lb60",            "rb-gpios",     true },
>  #endif
> +#if IS_ENABLED(CONFIG_PCI_LANTIQ)
> +               /*
> +                * According to the PCI specification, the RST# pin is an
> +                * active-low signal. However, most of the device trees t=
hat
> +                * have been widely used for a long time incorrectly desc=
ribe
> +                * reset GPIO as active-high, and were also using wrong n=
ame
> +                * for the property.
> +                */
> +               { "lantiq,pci-xway",    "gpio-reset",   false },
> +#endif
>  #if IS_ENABLED(CONFIG_TOUCHSCREEN_TSC2005)
>                 /*
>                  * DTS for Nokia N900 incorrectly specified "active high"
> @@ -512,9 +522,9 @@ static struct gpio_desc *of_find_gpio_rename(struct d=
evice_node *np,
>                 { "reset",      "reset-n-io",   "marvell,nfc-uart" },
>                 { "reset",      "reset-n-io",   "mrvl,nfc-uart" },
>  #endif
> -#if !IS_ENABLED(CONFIG_PCI_LANTIQ)
> +#if IS_ENABLED(CONFIG_PCI_LANTIQ)
>                 /* MIPS Lantiq PCI */
> -               { "reset",      "gpios-reset",  "lantiq,pci-xway" },
> +               { "reset",      "gpio-reset",   "lantiq,pci-xway" },
>  #endif
>
>                 /*
> --
> 2.45.2.803.g4e1b14247a-goog
>
>
> --
> Dmitry

Can you rebase it on top of v6.10-rc6? It doesn't apply to my fixes branch.

Bart

