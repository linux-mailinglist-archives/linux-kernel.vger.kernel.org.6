Return-Path: <linux-kernel+bounces-336737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 196EF984006
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 10:11:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA96028429E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 08:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61DD714F124;
	Tue, 24 Sep 2024 08:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CD5N5gaW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8AF14EC4E;
	Tue, 24 Sep 2024 08:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727165478; cv=none; b=RPf19VRqapH7gmtetQM3kj1O6tgnBn1Z0WHdVzoXlMOtb2ajlzhxIKw/s2N2PdYznsNpRvHWW2z4l/LE+o4Ik5+f3SZDeCjqWt8RqNh4vIktTgHAlJZgaXXIVnHVdLPFPZVbZ2v6Zk+XhQf2aQSYbPzbl9m9m3Fxwg1IzBleFw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727165478; c=relaxed/simple;
	bh=MnVSJWbRxqkO6NY7e/f2PauGA5csDQ/WM/hwqPA2+0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AeFkrfSSbyeASOHz1f28oQOvNLSH8QKYkmbI5z3Ig45bV2H5dZO1obvyOA7i+LYdEXcG9rU8+Xl9OW1tahTYf9p6YKodvPrEXgDyM9c/D8UZOkGVD/fQF1ebe2XwZRGoqIElJRKLXau5p1NkZabkv2NOXEREbSmO3DibZwhHmf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CD5N5gaW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3867C4CED6;
	Tue, 24 Sep 2024 08:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727165478;
	bh=MnVSJWbRxqkO6NY7e/f2PauGA5csDQ/WM/hwqPA2+0w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CD5N5gaWatbBBM96x8Zy+RSbdxJiihmUO9NPklH+ViGqOaeo041YplrZK+sLGER90
	 19tlg6TDGqFwJnTSigcEMSUFTFLGFTfTVaHXJQ+5p4gUy4XI+AZevMdff1FX0sEjVx
	 1TqkrGAqL5Ow8WwaiEH5FuTYE+6NqWxAch3fWKW3nB/hRHKZzao1ZAzJIb1rQrd0Xj
	 aq8V4X5I6e9PN6TpJLhAl/dM5QZ5IceGLs/ilkfMbLuD/BayXAn7psp4jXtSY43Lwn
	 8RaYzSU07KBU2evZLua+hNDB5UHFTkpe4E+DjUX5t0WRNbhHMKDCEPQ38c0E4rzGEo
	 +3S9MmW1VEaDA==
Date: Tue, 24 Sep 2024 10:11:12 +0200
From: Mark Brown <broonie@kernel.org>
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Guenter Roeck <linux@roeck-us.net>, Liam Girdwood <lgirdwood@gmail.com>,
	Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
	linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH 4/5] hwmon: (pmbus/core) improve handling of write
 protected regulators
Message-ID: <ZvJ0ICVqXrlYaVpd@finisterre.sirena.org.uk>
References: <20240920-pmbus-wp-v1-0-d679ef31c483@baylibre.com>
 <20240920-pmbus-wp-v1-4-d679ef31c483@baylibre.com>
 <4052294e-7b7f-4238-9b47-92727de4d516@roeck-us.net>
 <1jsettz1hh.fsf@starbuckisacylon.baylibre.com>
 <2f3cec6e-7b05-4510-8c62-244ed114ad17@roeck-us.net>
 <1jo74hymsh.fsf@starbuckisacylon.baylibre.com>
 <ZvFdYtwlqsr4mLym@finisterre.sirena.org.uk>
 <1j7cb2z4zw.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="811CMa6RECgMAk6q"
Content-Disposition: inline
In-Reply-To: <1j7cb2z4zw.fsf@starbuckisacylon.baylibre.com>
X-Cookie: Editing is a rewording activity.


--811CMa6RECgMAk6q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 23, 2024 at 06:53:07PM +0200, Jerome Brunet wrote:
> On Mon 23 Sep 2024 at 14:21, Mark Brown <broonie@kernel.org> wrote:

> > So, I know we talked about this a bit on IRC but I didn't register the
> > specific use case.  Now I see that it's coming down to the fact that the
> > chip is simply write protected I'm wondering if it might not be simpler
> > to handle this at the ops level rather than the constraints level.  When
> > registering the driver could check for write protection and then instead
> > of registering the normal operations register an alternative set with
> > the relevant write operations removed.  That would have the same effect
> > that you're going for AFAICT.  Sorry for not thinking of it earlier.

> Actually I thaught about it, that was my first idea.

> There is tiny difference between the 2 approach:
> * A regulator that does not provide enable()/disable() is considered
> always-on, so it is not really checked if it is enabled or not
> * A regulator that does provide enable()/disable() but disallow status
> change will be checked with is_enabled()

> In the second case, we will pick up on regulator that is disabled and we
> can't enable. In the first case, I don't think we do. I don't know if it
> is a bug of not but that makes the 2nd case more correct for what we do
> with pmbus regs I think

I think for that we should just always use the is_enabled() operation if
it's available.  This is simply an oversight caused by not imagining a
case where a regulator could have an enable control which is locked out
like this, the normal case is that either you can control enable or
the regulator is always on.

> The other thing, although is more a pmbus implemantion consideration,
> is that the type regulator is opaque in
> pmbus_regulator_register. Different types could be registered so
> manipulating the ops is tricky. That's where a callback is helpful=20

> If building the ops dynamically is the preferred way, I'll find a way to
> make it happen. I'll need to way to identify which one need it, loose
> the 'const' qualifier in a lot of place, etc ... that will be a bit
> hackish I'm afraid.

With only a limited set of options it might be better to just have a set
of static structs and pick one to register (some other drivers do this
based on hardware options), but the number of combinations with this is
getting a bit big for that.

--811CMa6RECgMAk6q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmbydBUACgkQJNaLcl1U
h9D9Fwf8Ct+JTTvPEfsG+ZQFhaPsbwYkCrV+h80e80aziIqrbwPizjvv31XpBK3I
8xmSKZ1JfCK4XaZ+B5OrM+AoWv3a0YeaYQfbRboAYXLGsKZmltmftQBmCVO24PGh
omogNFrbwa3Io6yoFX7DLi4tSC6Xk8gx/PzFhdy1ryoAxfHa1h6on1mZfgOnnQqU
NRi9MjT5Fc4nVq3BW9BvXWeQ3P1SeY+b0fZzQar+iMKihlST9BIghEXhgOIq1l8a
w3hn2GvYGXWuYJGZ2CeLsfYb6fruHrOYGf9Z/3dyf/8wE/2Yn9ERq+7JeocvZcdl
3LGmiJ/4CSPCWs/qCFdV13YCJLX29g==
=4UfQ
-----END PGP SIGNATURE-----

--811CMa6RECgMAk6q--

