Return-Path: <linux-kernel+bounces-449301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1801C9F4CF8
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 14:59:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC17E188711D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 13:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BAC41F4731;
	Tue, 17 Dec 2024 13:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J9heHZ3M"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B581F4709;
	Tue, 17 Dec 2024 13:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734443935; cv=none; b=tfWezqv37RJeIlwKSqQFfaBPGzpl3GOkgB9rVwbI6msRAx4CcwLS0G6+VJejwU0c/jLac7Lxyf4u8hq1ajXYjxOYtw0K77itxrR5QZu2cBC1QmG01ApWDH+ed/8+Zf7pNKi2BgFy+N7M13/akdLjJtWOOzk/jxd6skZMyqFPnDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734443935; c=relaxed/simple;
	bh=XtOzAojt8SPqapBFcvWSKRgjZ1YwFdgzYc3syrc1FbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RIIpb5+hARXMSSuIny8Z4I4jpzSfqrIoLdMAYhWvEHbBR0+5bc7W4JAzwmpbrtGVw1YsIH5pXxq6j7qE9KkllN/S9TZ3yUTnE+qVbJyneMLFZt/gbS2uZmhDMO1CzjxNVXcs8C3jDmU/yCbKM4qt3ILWZBAL6cTkOziVJzsL1BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J9heHZ3M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0276C4CED3;
	Tue, 17 Dec 2024 13:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734443935;
	bh=XtOzAojt8SPqapBFcvWSKRgjZ1YwFdgzYc3syrc1FbQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J9heHZ3M17lG7OmKwcjR7ssCnGSkfd8Wp4jjvOKSrwtaaqcjadQqaRrRdNhWzdHVK
	 44fR4YkUHrTQvKJDj/icIhua/mMwDMflmkROPaQb0OSHRXz0ScRIwTxEpkHOy0QTJP
	 gNNhFQrPRqwZpOUG459uSNGfpMwJwswK+vTZUtzsMpo2t4RzTIpLceA2SoVnOt80Iv
	 4ABb1Ud5YackxYrrDd0TaDphAFnAvfNAzRslJv4eDTygbELM5IRUsOq9At2QSk32im
	 sULg/4ybpD6H55O/G25WwfRWiJPSyfs8tOEZiAjP1QdUbcya/Pu2vWoYy8ACR6VccM
	 9aM/O0WG2tZBQ==
Date: Tue, 17 Dec 2024 14:58:52 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Paul Kocialkowski <paulk@sys-base.io>, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Paul Kocialkowski <contact@paulk.fr>
Subject: Re: [PATCH] pinctrl: sunxi: Use minimal debouncing period as default
Message-ID: <20241217-impossible-chameleon-of-flowers-8ce18a@houat>
References: <20241119140805.3345412-1-paulk@sys-base.io>
 <20241119-prudent-jasmine-lizard-195cef@houat>
 <CACRpkdbcDwJaLmCa_YoP2zFw3fiWn-d1Q773jGh9kcVN8aWQKQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="fmngw2akgqtiotkg"
Content-Disposition: inline
In-Reply-To: <CACRpkdbcDwJaLmCa_YoP2zFw3fiWn-d1Q773jGh9kcVN8aWQKQ@mail.gmail.com>


--fmngw2akgqtiotkg
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] pinctrl: sunxi: Use minimal debouncing period as default
MIME-Version: 1.0

On Tue, Dec 17, 2024 at 02:41:36PM +0100, Linus Walleij wrote:
> On Tue, Nov 19, 2024 at 3:43=E2=80=AFPM Maxime Ripard <mripard@kernel.org=
> wrote:
>=20
> > [Paul]
> > > The pinctrl code supports an input-debounce device-tree property to s=
et
> > > a specific debouncing period and choose which clock source is most
> > > relevant. However the property is specified in microseconds, which is
> > > longer than the minimal period achievable from the high-frequency
> > > oscillator without a pre-scaler.
> >
> > That can be fixed by introducing a new property with a ns resolution.
>=20
> Perhaps, but I think a setting of 0 should just yield the minimum
> resolution in this case, as apparently the debounce cannot be
> turned off? This would also make sense to expose for
> gpiod_set_debounce() as explained in my other mail.

Yeah, if we want to have 0 =3D=3D lowest resolution, I'm all for it.

Maxime

--fmngw2akgqtiotkg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZ2GDmAAKCRAnX84Zoj2+
doNUAX0SGEEc2COqYPAEcGxCntC52XBXJzHjAagNNW0LH235odQkGdtI2AF/bUB9
FcxbRikBf1fW676Lu6RJzC/s3juQeRS4Y/zPRIIfSZpzNHQ7em9kXV3WNMtTUC7/
CD2hcqnSTA==
=tuS5
-----END PGP SIGNATURE-----

--fmngw2akgqtiotkg--

