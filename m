Return-Path: <linux-kernel+bounces-304146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C0B961B09
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 02:19:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35325B21C01
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 00:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EB32F4E2;
	Wed, 28 Aug 2024 00:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gzZu3v8a"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F080C8CE;
	Wed, 28 Aug 2024 00:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724804346; cv=none; b=fazKrCcfSDZeZFqLnhcqdLnZKxoi1n+8iE0qqF2TK2Gv/nom8LKX1aBOA4E5+dQexA4fHnocLCue4pG2tAilx7a4Fl/qhzwSRMFeAQiIjIu0/ADR40M1XjmupT4DADoP2hpB4K7x4NTZZOalqqS4Vw97fEfCgg4Df3X437r17TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724804346; c=relaxed/simple;
	bh=ySyC1GdbfZa4s5iTuJ+poeRdgMEqx1eenRFNVvlu1OM=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=a76ibfzK0xSNHL7H+HgKmpnc4koKLdu/XlMRCerlQm02TpZBFwZvkpjogMr8MkcdXmEMwhLn8DF6B+4vhut1Wt0gpZU1pLuzxshJ3P+VK9nMRERCokagtv15Q2hCWQrf+ZeHNse35W0PzVpuhLmdQTncothrrFuWS9IDoMXymmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gzZu3v8a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2480CC4AF12;
	Wed, 28 Aug 2024 00:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724804346;
	bh=ySyC1GdbfZa4s5iTuJ+poeRdgMEqx1eenRFNVvlu1OM=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=gzZu3v8aCgoXrQFAo25JFycwmpwrkfPIk0v+Eh2nfSgEK1h1BEalC9D7ECAuS8gl3
	 6j9Lci3+PcOi+hApFqEiY6hkNOAHL2XILuDRw2bFpK3UUuGBS8pcNc7Ar0w1hgpGea
	 efUDgub7T3On5jH4DZ1supxGZB/VpvMplZzs9aOgYQVLm+V6VZVBdyEH5Yb43GRThV
	 eew//PEp/sEz53uzSsReJALohOW3SZuDKQ6ZFxuaQCFORB0J33i9xs3FSyTpxohTi7
	 uG7BGrOCC90/Ct/r5QLfIiNPTWkZ7d4C2afW2EuuTbbdb9qWb342c9Yy1at0O86UCF
	 EHM8ieIrtEKoQ==
Message-ID: <9e16ddb1c1a697464ce1f5438ab9ca31.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240822155822.1771677-1-andriy.shevchenko@linux.intel.com>
References: <20240822155822.1771677-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/1] clk: devres: Simplify devres handling functions
From: Stephen Boyd <sboyd@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>, Uwe =?utf-8?q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 27 Aug 2024 17:19:04 -0700
User-Agent: alot/0.10

Quoting Andy Shevchenko (2024-08-22 08:58:22)
> diff --git a/drivers/clk/clk-devres.c b/drivers/clk/clk-devres.c
> index 90e6078fb6e1..f03d60706a85 100644
> --- a/drivers/clk/clk-devres.c
> +++ b/drivers/clk/clk-devres.c
> @@ -28,15 +30,13 @@ static struct clk *__devm_clk_get(struct device *dev,=
 const char *id,
>         struct clk *clk;
>         int ret;
> =20
> -       state =3D devres_alloc(devm_clk_release, sizeof(*state), GFP_KERN=
EL);
> +       state =3D devm_kmalloc(dev, sizeof(*state), GFP_KERNEL);

When is this allocation freed if the get() fails? When the calling
device driver detaches?

>         if (!state)
>                 return ERR_PTR(-ENOMEM);
> =20
>         clk =3D get(dev, id);
> -       if (IS_ERR(clk)) {
> -               ret =3D PTR_ERR(clk);
> -               goto err_clk_get;
> -       }
> +       if (IS_ERR(clk))
> +               return clk;
> =20
>         if (init) {
>                 ret =3D init(clk);
> @@ -47,16 +47,14 @@ static struct clk *__devm_clk_get(struct device *dev,=
 const char *id,
>         state->clk =3D clk;
>         state->exit =3D exit;
> =20
> -       devres_add(dev, state);
> +       ret =3D devm_add_action_or_reset(dev, devm_clk_release, state);
> +       if (ret)
> +               goto err_clk_init;

Shouldn't we return an error here? Otherwise we call clk_put() twice?

> =20
>         return clk;
> =20
>  err_clk_init:
> -
>         clk_put(clk);
> -err_clk_get:
> -
> -       devres_free(state);
>         return ERR_PTR(ret);
>  }
> =20

I stopped reading, sorry! If you want to do this, please add a bunch of
KUnit tests.

