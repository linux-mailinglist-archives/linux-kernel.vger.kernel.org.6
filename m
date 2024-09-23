Return-Path: <linux-kernel+bounces-335846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C4D497EB70
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 14:22:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D816BB20F15
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 12:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FABF198826;
	Mon, 23 Sep 2024 12:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jsB9jDOe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C0045003;
	Mon, 23 Sep 2024 12:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727094119; cv=none; b=RqPnK7iij6vq4f7npy98YJpVuKio+iwKfwNDiX491I1B023ibBtQlXdGFDITDeUFNzDn7/aiQr0oqniiIeCgv+KGATPjnDW4g65k9aqv2aWm8gy9JdpIp0Hptf5zp3FFq8PjL8RmeOGBwhStoF3PIKCbX1c237k65xoNPklZkPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727094119; c=relaxed/simple;
	bh=floE/8UHUdfb+dwdVVqVEXFDYokMKQ/W7jzFCBfbfJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sGxpxrnAnJOnBGmyafoeFkCoPCIZKKrzWgiHRvG3VUP63Oj5xt5qXYwy5NUiRT0Dz3Lt3mBlX5QI71QMUfyW5s7HH7YK9tAS1g6iQPefl0H1xoTUsJNJtYYRXjk1cZWlxCkvcMQE9Fqi9Mw21Mb4OjBhg8mCgJp9pJDaCt4xWP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jsB9jDOe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D2CCC4CEC4;
	Mon, 23 Sep 2024 12:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727094119;
	bh=floE/8UHUdfb+dwdVVqVEXFDYokMKQ/W7jzFCBfbfJw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jsB9jDOe5l+tIVVsWUALwcSetONkdfVsz+VITIG60vgQy8/EGM6z0d1LIu2U2E3YU
	 PG3tG2wsOb8I37bOKzVmECSnWuPbmehyjNh1cAvm3rgJsiof4qx4kkvcBLDrezkT1y
	 1bfqjiuGO7cCgVZK3E5ANoROl4gPBfVN8kNlTyxoP+L8d5raahwUKqNI41qgcTBHxg
	 HJxSKz/ePobD5QXI1xySagI1ZzBBnDuFXx3m63zK9LQae4YjkjZx/7m/9iAtBGj0Dq
	 ZwUSQcKRxYe0U9mMFbwnTbf2eKmOYiVQke2RApnzxMD05Jr9O8yqCcIBmhGq65oowL
	 mEvuBVnsY/kMQ==
Date: Mon, 23 Sep 2024 14:21:54 +0200
From: Mark Brown <broonie@kernel.org>
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Guenter Roeck <linux@roeck-us.net>, Liam Girdwood <lgirdwood@gmail.com>,
	Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
	linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH 4/5] hwmon: (pmbus/core) improve handling of write
 protected regulators
Message-ID: <ZvFdYtwlqsr4mLym@finisterre.sirena.org.uk>
References: <20240920-pmbus-wp-v1-0-d679ef31c483@baylibre.com>
 <20240920-pmbus-wp-v1-4-d679ef31c483@baylibre.com>
 <4052294e-7b7f-4238-9b47-92727de4d516@roeck-us.net>
 <1jsettz1hh.fsf@starbuckisacylon.baylibre.com>
 <2f3cec6e-7b05-4510-8c62-244ed114ad17@roeck-us.net>
 <1jo74hymsh.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="N9BzeYMWoWKB7STk"
Content-Disposition: inline
In-Reply-To: <1jo74hymsh.fsf@starbuckisacylon.baylibre.com>
X-Cookie: Editing is a rewording activity.


--N9BzeYMWoWKB7STk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Sep 21, 2024 at 06:49:34PM +0200, Jerome Brunet wrote:
> On Sat 21 Sep 2024 at 08:22, Guenter Roeck <linux@roeck-us.net> wrote:

> > In other words, if always-on is _not_ set in
> > regulator constraints, I'd see that as request to override write-protect
> > in the driver if there is a change request from regulator code.

> That's very much different from what we initially discussed. It can
> certainly be done, what is proposed here already does 90% of the job in
> that direction. However, I'm not sure that is what people intended when
> they did not put anything. A chip that was previously locked, would be
> unlocked following such change. It's an important behaviour change.

The general approach we take for regulators is to not touch the hardware
state unless we were explicitly asked to do something by firmware
configuration.  The theory is that this avoids us doing anything that
causes physical damage by mistake.

> >> This is something that might get fix with this change [1]. Even with that
> >> fixed, passing init_data systematically would be convenient only if you
> >> plan on skipping DT provided constraints (there are lot of those), or
> >> redo the parsing in PMBus.

> > I disagree. I am perfectly fine with DT overriding constraints provided
> > by the driver. The driver can provide its own constraints, and if dt
> > overrides them, so be it.

> That's not what the regulator framework does. At the moment, it is DT
> and nothing else. After the linked change, it would be DT if no
> init_data is passed - otherwise, the init_data.

> If a something in between, whichever the one you want to give priority
> to, that will have to re-implemented on the caller side.
> This is what I meant by redo the parsing on pmbus side.

Right, and I've got a feeling that any attempt to combine constraints is
going to need to be done in a case by case manner since what's tasteful
is going to vary depending on how much we trust the various sources of
information.

> It goes way beyond what I'm proposing.
> The only thing done here is something you simply cannot put in DT
> because DT is static. Following init, if the chip write protected,
> REGULATOR_CHANGE_STATUS should not be set, regardless of what is in DT.
> If it is not set, I'm not adding it.

> Also, what I'm proposing does not get in the way of DT, or anything
> else, providing constraints. What I propose allow to make adjustement in
> the HW based on the constraint, if this is what you want to do. It also
> allows to update the constaints based on what the HW actually is.
> If the chip cannot be written, regulator needs to know.

So, I know we talked about this a bit on IRC but I didn't register the
specific use case.  Now I see that it's coming down to the fact that the
chip is simply write protected I'm wondering if it might not be simpler
to handle this at the ops level rather than the constraints level.  When
registering the driver could check for write protection and then instead
of registering the normal operations register an alternative set with
the relevant write operations removed.  That would have the same effect
that you're going for AFAICT.  Sorry for not thinking of it earlier.

> > We should not try to override devicetree constraints.

> I don't think I am. I'm just reading the chip state and adjusting the
> constraint. Even after implementing what is suggested above, it will
> still be necessary to readback and adjust the constraint based the
> read protection. Unlock is not guranteed to succeed, the chip may be
> permanently lock. Some provide the option to do that.

I'm not familiar with this hardware so I'll defer to the two of you on
what's tasteful with regard to handling this, based on the above it
might be a per device thing depending on how reversable the write
protection is.  It looks like currently we don't change this at runtime
but I might not be looking properly?

--N9BzeYMWoWKB7STk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmbxXV8ACgkQJNaLcl1U
h9AjRgf/V9ssyfMy6QiENK3CEflcbkcO+3HSF7vnVJJ5yHZct6RX5SpTKnAGcj4p
P3FDDzS6mv2Z5z6h09DsMIxgB/KLEhv8bHyrFaKrH9LcQYwVcwtHc7lUMX34vZB/
FW/+bZm1yOGlJcBY3qjkd8tFAvsFuvMdA2P0jWODOShz1gasneA0lhzxJ8t9bnsG
FhhiyxqXinMOV8NuCsWK9m/vE750bnJPPUxgodCUgm1DQa/gsiwht2gw23t+DQxa
bzSM1wmlvTAxANTxcUGoVx1f6vPX6MX2bc7j/LXzjWnUu2yETNIXqpwKt/dvSd8K
Et8PGSc4AXslHNB8OsgKk6g1+j6paA==
=rte1
-----END PGP SIGNATURE-----

--N9BzeYMWoWKB7STk--

