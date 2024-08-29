Return-Path: <linux-kernel+bounces-306792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40AD59643A8
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 13:59:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF0121F233CD
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 11:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD9B01922FE;
	Thu, 29 Aug 2024 11:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iILYfg97"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA2C9474
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 11:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724932764; cv=none; b=ngTPR9ZuZUebx/jIswD+yb9I0U0V0hLLJTpOuRxhlloyBzCKGEAZo8jsVgLmo8k9tT7Sy5Wh1ye3GyuCMgzq/1tWTJd3heNI0oDXPsAuEO6UqFXMTQdu7E6eM5EpT59LQ1dEbHj/oDq60mQYtabjodVIWuTGsuNnJnGU24HaO/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724932764; c=relaxed/simple;
	bh=YFd78PLcLUlTsv1xyfZC0dEiahah4AcdXxRUBv9/tFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EP3rjMqP3xU89FnUvkGckjh2LUC7I2Q/j/krA9y+YFqZzEof708SAU8L9n4ZsGsJf8egJj6qZQp43WKy4yl9uL2J4Fxk4q7tdQ/KbHwz3uVEKzMSBBSb/TGbqLX1EV5sJYAGJFbl2e4RN612h8N8BM+EdbMPI6TdbjFn1hsOr/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iILYfg97; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDF89C4CEC1;
	Thu, 29 Aug 2024 11:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724932763;
	bh=YFd78PLcLUlTsv1xyfZC0dEiahah4AcdXxRUBv9/tFs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iILYfg97knk9/dSZWQnoya+5CUe3qU8wVCLg22no6/eeLRol1V/UL6My17VY5crjh
	 bhuiQt3eGIAvtZIreC2aV61PBt1G0O17Hu5+1cmxFIXdL9LVpMySOU5wf5ZfmtsJ7S
	 KO+xE38Q5BRoyCbo2EJY5el4S2RbmsGqldxJTPCpY+fUkqlFjA01HrkLhsusQpieIe
	 nM24xVx/7QrzZeUr1AiBhGf3Dggei9zvxSbXm92VjdaWNTZBJ9MULOcC/6fajSdyQR
	 ixmljoFYlBtWOCWZCIF77SFDQ8KOpqhJz7r+5JYLtaJ2TRpDZum9ZokM2n6LjCoI+O
	 sREjbbMs2FqKA==
Date: Thu, 29 Aug 2024 12:59:18 +0100
From: Mark Brown <broonie@kernel.org>
To: Jian Hui Lee <jianhui.lee@canonical.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Axel Lin <axel.lin@ingics.com>, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] regulator: mt6359: Fix UBSAN shift-out-of-bounds
Message-ID: <e28a620c-4b3b-49bb-aa15-ebaad597a76a@sirena.org.uk>
References: <20240829025807.2455823-1-jianhui.lee@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="478nJuTw7MTmaEjI"
Content-Disposition: inline
In-Reply-To: <20240829025807.2455823-1-jianhui.lee@canonical.com>
X-Cookie: Go 'way!  You're bothering me!


--478nJuTw7MTmaEjI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 10:58:07AM +0800, Jian Hui Lee wrote:
> A shift-out-of-bounds will occur as caught by LTP fs:read_all_sys, if
> modeset_mask has not been set for MT6359_LDO_LINEAR regulators.
>=20
> Example command on MediaTek Genio 1200-EVK:
>  # cat /sys/devices/platform/soc/10024000.pwrap/10024000.pwrap\:pmic/regu=
lator/regulator.28/opmode
>=20
> This patch initializes the member modeset_reg to zero, and checks it
> before any further actions.

It would be better to fix this by not registering any mode operations
for the relevant regulators, that will catch these and any other or
future issues.

--478nJuTw7MTmaEjI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmbQYpUACgkQJNaLcl1U
h9CRIQf/Zo/aC6aUlz5o76RUr9hUzqtMd3T9bY67UcLQ34joOx8IYwO1sicwrbu7
SbYEiYW6IneVnHcmv9Q5xyS95UdQ+1qxhI0hrYctX0oLQntI0OEKe+Mh3HvYxhLi
T10qLw/3PkO0I+C7AhULEJjjFCJv8MQrljQ35a9iwThtMnI/0D40sacvbB29U767
ep/J7639Of3lwVr3cttNIAjZoyS7a7qSEld0nV/F1ke7WvnrvDuT5N/sDzldEwRI
+p1LTghJPA/EtWApi2b/RzH8ToH1TmeNkswoXpzmoTCLSAQv+BN5AIhiBGwAQ3dh
MFNXYaT9Y+wixhRXKkBN81RTKtP0FA==
=/dBK
-----END PGP SIGNATURE-----

--478nJuTw7MTmaEjI--

