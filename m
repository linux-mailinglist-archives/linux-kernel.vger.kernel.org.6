Return-Path: <linux-kernel+bounces-541741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BBC2A4C10A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 13:56:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 784093A3CB8
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 12:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E130920FAB7;
	Mon,  3 Mar 2025 12:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nQgWRqwK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1E73BBD8;
	Mon,  3 Mar 2025 12:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741006575; cv=none; b=BGtR7lQsIbcWbfXcssCCdUVcVeLFDDPLdIY0y0/hQlA3BAA53hLC0gc2a0C1kUtUeeWGozS+4mcU+/kLcs/FWU2c6Bj7+TyKajy4jAN6fgmd5xwHPZJWXoS00OCFO6TD9CDXn/W1x+AaGnpILqAPk90YlipxwFOUm3ztwPl6eSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741006575; c=relaxed/simple;
	bh=Ev5SKxfHjDqDzCGwE0MrQkmFFNsf+Ifg6zSxPrf9e4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LEfY4MwppZmFrVOIBSRzbGizJiDyFMJ8jZxNijRkNIvVPN+PO6fKCk4OMcIX06tlxvTbESewme3/n/TnRP8h8SerdYk1VJwG8HWD5tLo0OZSfBXewvAQlx+LzrXX1RbgiC+RJy9fgZijIHgGMpL1d9ma6U2PWSSu1j8U/YhT7Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nQgWRqwK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB27BC4CED6;
	Mon,  3 Mar 2025 12:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741006574;
	bh=Ev5SKxfHjDqDzCGwE0MrQkmFFNsf+Ifg6zSxPrf9e4c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nQgWRqwKuT1Oo2+hzyUjZaaBeHxS+JzswVkZ3IcpxM+0txxGFd09xfUYwQdAAldMJ
	 3dxfDjO0/g0d5TI1ztufEITw41xWhqqNNpUf8L0xZ7Wvlivx+O3mY+IuTDFm7libiQ
	 wj58t/ZQu3Kbx4xnbqecGbW/T2Tt/sPxeErUViGiKe+XyhgTAvx7LoxGZn5NjgOo2Q
	 rkUoqBsdhVBRmDqHHbcUX3Xh35YRskMrkC+06fWOVf6LERp/KY4ZMM2JfjrRAXNVVc
	 NSVm9SHGlGvXk82LSYrsI24e0GObX3xEpSGRKd2ew0NAamCwyqorOXXPyD4am65Twu
	 BUKwepksALVTQ==
Date: Mon, 3 Mar 2025 12:56:09 +0000
From: Mark Brown <broonie@kernel.org>
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: lgirdwood@gmail.com, peda@axentia.se, andrei.simion@microchip.com,
	nuno.sa@analog.com, paul@crapouillou.net, oder_chiou@realtek.com,
	kiseok.jo@irondevice.com, shenghao-ding@ti.com, kevin-lu@ti.com,
	baojun.xu@ti.com, srinivas.kandagatla@linaro.org,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	patches@opensource.cirrus.com
Subject: Re: [PATCH 11/12] ASoC: Tidy up SOC_DOUBLE_R_* helpers
Message-ID: <5b319436-cf3e-4fd6-89a6-87e1afcf1ee1@sirena.org.uk>
References: <20250226153137.2791938-1-ckeepax@opensource.cirrus.com>
 <20250226153137.2791938-12-ckeepax@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="RoR8hd1BzWUnIGTH"
Content-Disposition: inline
In-Reply-To: <20250226153137.2791938-12-ckeepax@opensource.cirrus.com>
X-Cookie: No purchase necessary.


--RoR8hd1BzWUnIGTH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 26, 2025 at 03:31:36PM +0000, Charles Keepax wrote:
> Re-implement SOC_DOUBLE_R_VALUE() in terms of SOC_DOUBLE_R_S_VALUE().
> SOC_DOUBLE_R_S_VALUE() already had a minimum value so add this to
> SOC_DOUBLE_R_VALUE() as well, which makes SOC_DOUBLE_R_RANGE_VALUE()
> redundant, so its usage is replaced.

This doesn't apply against current code, please check and resend.

--RoR8hd1BzWUnIGTH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmfFpugACgkQJNaLcl1U
h9AN+Af/fKSNcDYJBdpB2CpuPssT8MvsuizseNovlE8SR67M8irBy34gVRRSEzPQ
EP+yra221mu+SjIjqlpveqTU3GLfX9gCpbr29lgACZhSeKlB310jtdUOitP7BDB2
aTxZ2/dkWWQ/CAY2Lf+qE30in5bWSj5CLCXKrDrnqdHIP2UrCxm7O3PIyVVbD+Ow
aFS7MoPpYasv8AsKpo4CrT/46/Z3blB2K9UwGZqa+yMBEQNJ+v1P5ES6+eQ/4LCr
57Tb/JsATEmXGCEWgX17X8dVnG9nkhAhZ885xFJorhcMS787R63nr6r27DZQJjWR
2num4biSZWf0fB8aoK/cCg9455a39g==
=i4Az
-----END PGP SIGNATURE-----

--RoR8hd1BzWUnIGTH--

