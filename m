Return-Path: <linux-kernel+bounces-542592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94537A4CB6E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 19:55:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1E233AB906
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 18:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D79623314A;
	Mon,  3 Mar 2025 18:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YKAfFSsj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD9122DFAF;
	Mon,  3 Mar 2025 18:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741027994; cv=none; b=lDK2Z7clJl3P4FTHnuZbuuegpqxdi+rqX+fUBfhJf4/3oejKJFj1CfyrwyedoruWDCCC47eD1QBTN+MDlQXJ4+Jz9jTodYzWfPFbSPdOVDn8E2Z6eHAKyVm1SqXFtWUHXR6k//i6RTlS2zFGr+o/slxwX3IgR9899Bul98ekwGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741027994; c=relaxed/simple;
	bh=IRUrqYES5ms9Cr5LIhAodbV0k1pLuaPq0zg09WrGVpM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D237hRkV8iWHujD5pgxPeG322LgfuSPp/y9dkO1uBJHpiBGryfdiaVRZWK59ARx+BOx4/9ZcmKFjSCxCG/Gq4rT8VDWJ78UYV0r+I7VKxoJdovqMv6knAJWwyMS/vjnknyPjIl5BhMDRm0rKvbe0xvlNx/3ZPDawU60Q7oDE1VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YKAfFSsj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BAFFC4CED6;
	Mon,  3 Mar 2025 18:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741027994;
	bh=IRUrqYES5ms9Cr5LIhAodbV0k1pLuaPq0zg09WrGVpM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YKAfFSsj1dPKBv9Wl8L1l4fnPGjQ36VWBRrLBoLufN1L9Se2ZRfYUt0pr27UFS+dt
	 OvMRhTymH3gEf0NAAcMYeww44k/o4EMHdaNkMBV5lUL6r8YqFpMUjkZ1p3dqpXssCB
	 QTV7Q0BvsivRw0AdRHkAg0yIzEr3ehrE2KHzHyO53WJV53FZUVPaQHJikzwd6w8IwM
	 8NWaM8nc5yYLGqfVg+JJze/uN3AqOpLXvx92/VvdnkETMfiURwEKk4PTBBaSLk+hkG
	 wegLw9194/ry4dVPnVn+00GvAnW8f/VpDhDK6iVWYta6i7iX4OLXhG8guvo45nTwrb
	 x7gbF5Vq60kjw==
Date: Mon, 3 Mar 2025 18:53:08 +0000
From: Mark Brown <broonie@kernel.org>
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: lgirdwood@gmail.com, peda@axentia.se, andrei.simion@microchip.com,
	nuno.sa@analog.com, paul@crapouillou.net, oder_chiou@realtek.com,
	kiseok.jo@irondevice.com, shenghao-ding@ti.com, kevin-lu@ti.com,
	baojun.xu@ti.com, srinivas.kandagatla@linaro.org,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	patches@opensource.cirrus.com
Subject: Re: [PATCH v2 13/13] ASoC: Tidy up SOC_DOUBLE_* and SOC_SINGLE_*
 helpers
Message-ID: <4db99187-63f9-41cc-966b-0c77ba86e390@sirena.org.uk>
References: <20250303171424.444556-1-ckeepax@opensource.cirrus.com>
 <20250303171424.444556-14-ckeepax@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="k9kOVSMwFlCTJ6hn"
Content-Disposition: inline
In-Reply-To: <20250303171424.444556-14-ckeepax@opensource.cirrus.com>
X-Cookie: This sentence no verb.


--k9kOVSMwFlCTJ6hn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 03, 2025 at 05:14:24PM +0000, Charles Keepax wrote:
> Re-implement SOC_DOUBLE_VALUE() in terms of SOC_DOUBLE_S_VALUE().
> SOC_DOUBLE_S_VALUE() already had a minimum value so add this to
> SOC_DOUBLE_VALUE as well, this allows replacement of several hard coded
> value entries. Likewise update SOC_SINGLE_VALUE to match, which allows
> replacement of even more hard coded values.

This breaks an arm64 defconfig build:

In file included from /build/stage/linux/sound/soc/codecs/rk3308_codec.c:24:
/build/stage/linux/include/sound/soc.h:150:49: error: =E2=80=98shift_left=
=E2=80=99 undeclared here (not in a function)
  150 |         .private_value =3D SOC_DOUBLE_VALUE(xreg, shift_left, shift=
_right, \
      |                                                 ^~~~~~~~~~
/build/stage/linux/include/sound/soc.h:45:46: note: in definition of macro =
=E2=80=98SOC_DOUBLE_S_VALUE=E2=80=99
   45 |         {.reg =3D xreg, .rreg =3D xreg, .shift =3D shift_left, \
      |                                              ^~~~~~~~~~
/build/stage/linux/include/sound/soc.h:150:26: note: in expansion of macro =
=E2=80=98SOC_DOUBLE_VALUE=E2=80=99
  150 |         .private_value =3D SOC_DOUBLE_VALUE(xreg, shift_left, shift=
_right, \
      |                          ^~~~~~~~~~~~~~~~
/build/stage/linux/sound/soc/codecs/rk3308_codec.c:171:9: note: in expansio=
n of macro =E2=80=98SOC_DOUBLE_RANGE_TLV=E2=80=99
  171 |         SOC_DOUBLE_RANGE_TLV("DAC HPMIX Playback Volume",
      |         ^~~~~~~~~~~~~~~~~~~~
/build/stage/linux/include/sound/soc.h:150:61: error: =E2=80=98shift_right=
=E2=80=99 undeclared here (not in a function)
  150 |         .private_value =3D SOC_DOUBLE_VALUE(xreg, shift_left, shift=
_right, \
      |                                                             ^~~~~~~=
~~~~
/build/stage/linux/include/sound/soc.h:46:19: note: in definition of macro =
=E2=80=98SOC_DOUBLE_S_VALUE=E2=80=99
   46 |         .rshift =3D shift_right, .min =3D xmin, .max =3D xmax, \
      |                   ^~~~~~~~~~~
/build/stage/linux/include/sound/soc.h:150:26: note: in expansion of macro =
=E2=80=98SOC_DOUBLE_VALUE=E2=80=99
  150 |         .private_value =3D SOC_DOUBLE_VALUE(xreg, shift_left, shift=
_right, \
      |                          ^~~~~~~~~~~~~~~~
/build/stage/linux/sound/soc/codecs/rk3308_codec.c:171:9: note: in expansio=
n of macro =E2=80=98SOC_DOUBLE_RANGE_TLV=E2=80=99
  171 |         SOC_DOUBLE_RANGE_TLV("DAC HPMIX Playback Volume",
      |         ^~~~~~~~~~~~~~~~~~~~


--k9kOVSMwFlCTJ6hn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmfF+pMACgkQJNaLcl1U
h9BfjAf/VhGRXAkHhjPMizv7+M6PJyOtCjOUuOlkAOaPf+ha+fy53xFTQ4fh9WET
8isHEvh7SaagFICqNG1yfmYBw4jVZo+4Z3LDEqoGy6hrw40HGzKQ0MdWN8jQxCSL
s+M8w3fDlsPFpUimX42v86UaAKqEBxLj8ADKB+EhuH8AFdm0mynT9T0kBeglnvL/
h7B7t+t3/J0DhECzY2hACiKqy98rOw5nOxekvBcFj8jUx2l+wsdm/lP9Wt/HZvXm
9GZdFDBSqLKGdux9Q+uFiGqzTb3ISY4RliFGpOV2GGbhqVHW8wuf5zKk30LvTMK6
hre4yIDbOySUnPo8fnYVSZgYNT2uiA==
=YDnD
-----END PGP SIGNATURE-----

--k9kOVSMwFlCTJ6hn--

