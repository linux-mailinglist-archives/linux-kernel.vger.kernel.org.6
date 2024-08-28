Return-Path: <linux-kernel+bounces-305536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72FA1963030
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 20:39:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C7541F21AAB
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 18:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E8B81AAE26;
	Wed, 28 Aug 2024 18:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FrW3jhbH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764911553A2;
	Wed, 28 Aug 2024 18:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724870342; cv=none; b=hPv2WtP/c1D/mG46I6f186h3BSsyT6diG9wfeXrmTaVic0sv5xvONyPmxws1lvYWUWrB4rvHanZo2glDibmBOvhhchFjgcSzIrBsEPD2URLldL/JOjZenC7V+V3pCTnc17zeIhmdeoO66XouyWVb7xKOfKSgCJkfYU0nbskmarI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724870342; c=relaxed/simple;
	bh=x7SdE42KbvXOA6sb0fTZsjwo8QK2NhUXyigglHvanCI=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=UFG4s/jDogcg/hPH+aRW6QrnwdNMTCra9d/5og/YUYzFz9OKZPjb/P9v9amQz1EfiAyr2STpyvluINTKrW7DTY/gx4CribepCxxpijrLDaVjNwfVPEtWAQGVF4DkzBCwikFQ+lNCksc5xEEjzrSIC9lxZbUsabftAteYwwMuoow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FrW3jhbH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E101FC4CEC0;
	Wed, 28 Aug 2024 18:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724870342;
	bh=x7SdE42KbvXOA6sb0fTZsjwo8QK2NhUXyigglHvanCI=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=FrW3jhbHUQCUAUiRzCgAzlxjlUBj+MVKlL0O0jPkC45vsQeqC9l0SiJcua4GS+War
	 SYGxKqrkzUGaNDGYeS8FZL6Xt8EIMOKevkcU/plyP6H6ygJOYMgYx2HO5UGoq5rdLF
	 FRQeKHcUDmSaYWK690IMPiMXT3b9cnAqbIa/XywXaTQL/tGjYzI3U0Qqwm+E5SS3iy
	 kNZtdTE5WQ2w0xlGmohrhcXSgwvHVJfOcgIylTFOC2eW+qGSibpMdEigvDwR8+upNz
	 hc0zzCgKqp2dTn9XNwSqNvcxcKLH8G98Sy9gV+k1d+Ygmb7Erh0RoroZ/23MzM+mm9
	 E4qntQhj0QQDg==
Message-ID: <b3f983207d74a3fcf40d9615260912c5.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <Zs8iGy8zLG2zs34J@smile.fi.intel.com>
References: <20240822161452.1780149-1-andriy.shevchenko@linux.intel.com> <20240822161452.1780149-2-andriy.shevchenko@linux.intel.com> <3e782ac88cc28fb5fa7ed71e7573e60f.sboyd@kernel.org> <Zs8iGy8zLG2zs34J@smile.fi.intel.com>
Subject: Re: [PATCH v1 1/2] clk: x86: lpss-atom: Use predefined constants from units.h
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, Michael Turquette <mturquette@baylibre.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Wed, 28 Aug 2024 11:38:59 -0700
User-Agent: alot/0.10

Quoting Andy Shevchenko (2024-08-28 06:11:55)
> On Tue, Aug 27, 2024 at 05:21:00PM -0700, Stephen Boyd wrote:
> > Quoting Andy Shevchenko (2024-08-22 09:14:07)
>=20
> ...
>=20
> > >  static int lpss_atom_clk_probe(struct platform_device *pdev)
> > >  {
> > >         struct lpss_clk_data *drvdata;
> > >         struct clk *clk;
> > > +       u32 rate;
> >=20
> > Do we need a local variable?
>=20
> Hmm... The idea was to allow retrieving this via device properties, that'=
s why
> a separate variable, but that patch wasn't included here.
>=20
> Nevertheless, despite above the separate variable makes code a bit better=
 to
> read as we can see what is this value about.
>=20
> > >         drvdata =3D devm_kzalloc(&pdev->dev, sizeof(*drvdata), GFP_KE=
RNEL);
> > >         if (!drvdata)
> > >                 return -ENOMEM;
> > > =20
> > > +       /* Default frequency is 100MHz */
> > > +       rate =3D 100 * HZ_PER_MHZ;
> > > +
> > >         /* LPSS free running clock */
> > >         drvdata->name =3D "lpss_clk";
> > > -       clk =3D clk_register_fixed_rate(&pdev->dev, drvdata->name, NU=
LL,
> > > -                                     0, 100000000);
> > > +       clk =3D clk_register_fixed_rate(&pdev->dev, drvdata->name, NU=
LL, 0, rate);
> >=20
> > This should be a one line patch.
>=20
> I don't get this. You mean the entire thingy?

Yes.

>=20
> It's possible, but as I mentioned above there is a rationale for making i=
t with
> a temporary variable.

The rationale looks like future code will want a local variable. When
that happens the local variable would make sense.

