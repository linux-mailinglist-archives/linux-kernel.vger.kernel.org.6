Return-Path: <linux-kernel+bounces-305655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4294F9631C1
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 22:27:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5B461F23EC7
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 20:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10F021AC44C;
	Wed, 28 Aug 2024 20:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EvD23ly0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503E015749A
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 20:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724876824; cv=none; b=dE2sZ5onqPv1FnLzhwx/g8kkWhZjK1kCqCUQ2/uQub+Vy4kNb2wSg8LL4EoJ+gmu0cDjnwRLa5+mP8Uxa+X8e/3Uz4N4FHP7AZST98Er66tIP1kn/2zuM1OetHBygkXNQPQEbVXu6etcdJJdLll7Kbv7hucZFGA2XgGaPHZk1kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724876824; c=relaxed/simple;
	bh=CmzwjkJ1vxFzbr1Eip2HWsK3aJZSJg4Hxr/r24h4P5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G/B1179RcIHsWrb84W8wYyTV8CFmhddcQyqvY6B715D3peD33+W03FXKsd1LYEWGfZG3Zv0jHPr3+4FOR37nN0RMX2cl6BOP5+1BlcTXLTpwSzUiC5b2sUmKUlG4rFOneF/NTmurYQB7WEWGq6eAx/rrnPZ4SZjg+/CQJ2aW2Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EvD23ly0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C389FC4CEC0;
	Wed, 28 Aug 2024 20:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724876823;
	bh=CmzwjkJ1vxFzbr1Eip2HWsK3aJZSJg4Hxr/r24h4P5w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EvD23ly0BWFXqFc0CjHyF5rPEKJHsLaFzY9sDU/pPYAAZkucy3alUD6E3Ly0Qgzal
	 v8laa+OaFKC7MDnDmvIbCaV9+XN9L+bNDS+PgVSJIxvQH5t9HosBqfrDGM9ofmmew4
	 0Zgjx7FDK4JYihDhxO9wIUBV8c3EFrFNPCfuOy6zVwpWyzMJb1ujjn3+mZZFrebXNJ
	 ARE9eTD//neLoV0cuVhTihC60AFOhknJpZeYrKnp63eEGBKZR1ptumSs8pyrkJQac7
	 oH5m7bl6tOh+XQfeLQI0PnD7b3/w7W1mch841pB+YC0sUhTCH7qLgelo7+gIhN8l0Y
	 THSYiuYnffYLQ==
Date: Wed, 28 Aug 2024 21:26:58 +0100
From: Mark Brown <broonie@kernel.org>
To: Nishanth Menon <nm@ti.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Lee Jones <lee@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	afd@ti.com, bb@ti.com, d-gole@ti.com,
	Jan Dakinevich <jan.dakinevich@salutedevices.com>
Subject: Re: [PATCH] mfd: syscon: Set max_register_is_0 when syscon points to
 a single register
Message-ID: <efac0d73-9a33-4851-9f66-7dae5bfc515f@sirena.org.uk>
References: <20240828121008.3066002-1-nm@ti.com>
 <f72500a5-4514-4920-a7f0-3fc8e6874615@sirena.org.uk>
 <20240828133229.67bej3utpgrmzr3p@retired>
 <ce44b268-d138-445d-a149-e5348897d3c5@sirena.org.uk>
 <20240828144434.oydsgflsqy5vibxe@sapling>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="EmOHjQImvootxwM+"
Content-Disposition: inline
In-Reply-To: <20240828144434.oydsgflsqy5vibxe@sapling>
X-Cookie: You are number 6!  Who is number one?


--EmOHjQImvootxwM+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 28, 2024 at 09:44:34AM -0500, Nishanth Menon wrote:

> This is a patch for syscon, not regmap. I am a bit confused as to what
> objection beyond the "Fixes" usage (which I can drop
> in a respin) you may have here, will appreciate if you are NAKing the
> patch and on what rationale.

> I understand that regmap considers the max_register usage entirely
> optional, but syscon does already use it (my patch doesn't introduce
> it). I am just getting syscon to catchup to what regmap already
> provides.

If you are absolutely confident that all syscon users know how big their
regmap is then modulo the claim that it's a fix for an unrelated patch
which doesn't change the behaviour for these regmaps at all then it's
fine.

--EmOHjQImvootxwM+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmbPiBIACgkQJNaLcl1U
h9B/eQf/e7JcAyioIfJEyx9QaxhxH9VpJ7Q1ikXsUdi8HaUxG2Nfh7boJKFBeQd3
/8ZwfgTAxdYHEq780ZcfcrFXvkFqAeZOQ6ODS7KeyIX9JZbbcklr3SMGI2IT+MxF
h1w5yANSjlKSym9CVGY6UKtUPV0AgvxjMzNVeOCCTqzCI3h/2R4dX+2FRv+jwYd1
lmmbzQmjkqIVvHmSPN0JYfDoLxymK3bvvvC2YFnSqA3wu+AJNYnEGU0nKqm7+0Vf
zoh8oS2b9AQH6lJyISHCDzeUuPkibwTyHI7UlfQwNTwh4NqvEXPKCbKR3sqGvB4y
heXKBp/4m64aYbYAw65OYLc86Q24Zg==
=N1aE
-----END PGP SIGNATURE-----

--EmOHjQImvootxwM+--

