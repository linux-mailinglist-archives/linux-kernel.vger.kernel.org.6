Return-Path: <linux-kernel+bounces-409364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF7E99C8BD0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 14:28:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BB721F258EF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 13:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA5741FAF07;
	Thu, 14 Nov 2024 13:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pBjpE/RF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552B51F892A
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 13:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731590880; cv=none; b=Q/Bxqa18OkQ2wvUBRQcGApWdvKlknmfcJ1Z1lVDV99zbx6V1Hmha395vTlHLeuY7x8MZ6vQE4VWbK2N/ELKleFHr5M/MKTcw7ybEGF6kTpvv3BBkElSGKX8+ESFUu7yy1brBUMny/d1dEFIL4NWC3lH93Cn6zQglTCRhDr8oKAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731590880; c=relaxed/simple;
	bh=RyjiR2s/p80NO7QfYS4aCXIPuiFVRfRweK5zG5CaYRU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kTSZpsI2V9tD9aUof5jj5hqe5nIzI3Ba34/zIdtF7LwGFHf8CgxATGUOHwXhI5erlgMIEYmuIqrsplBeBAUi+MStqAT0tN9vL99X37YGv26VIWjqBn6RKBbPQucDiFIhF+b65e81ifAqOpdUdwd9rJYqa3rv2k6C21MD5NRFzco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pBjpE/RF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BA15C4CECD;
	Thu, 14 Nov 2024 13:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731590878;
	bh=RyjiR2s/p80NO7QfYS4aCXIPuiFVRfRweK5zG5CaYRU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pBjpE/RFmart0LVDwr5eTTYg2gu6U0csKwOdKmZ7G3ANOSCbsfCqjt1XgBpUtilDc
	 QDMbWMnxiop+5pqCQGqUfsat+XdqIi+0w8i8AMIUwI1vNH/VbWqeFiOpz5e4zPVR+D
	 4OFwaGMJvvy7Odu4i/ottS6+RO/7VgarLSK++RkH0ujQ4BzFMm0m4z6Azpqw96d2So
	 eoP5osDkAuI4LPwh9ba1qidTzq8Gc2k00mv1BspWVx+4DyHT3XovfDNRRmgs6QaCOw
	 8A5HIlHUVGTcA+LwSDTLNfA5VCul/6vClGeGfKdsC8zo8G0DDqUorgp9eFoAz1MG2O
	 VhGtiQhuJvdGw==
Date: Thu, 14 Nov 2024 13:27:55 +0000
From: Mark Brown <broonie@kernel.org>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Bjorn Andersson <andersson@kernel.org>, linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com, Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH] regulator: core: Fix resolve supply
Message-ID: <ZzX6210-5YwmIaba@finisterre.sirena.org.uk>
References: <20241113153614.1755825-1-kory.maincent@bootlin.com>
 <ZzTOWoTT2to6aW5g@finisterre.sirena.org.uk>
 <20241113173642.4d58645b@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7CzexVQWOUPpjplf"
Content-Disposition: inline
In-Reply-To: <20241113173642.4d58645b@kmaincent-XPS-13-7390>
X-Cookie: Editing is a rewording activity.


--7CzexVQWOUPpjplf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 13, 2024 at 05:36:42PM +0100, Kory Maincent wrote:

> My issue is that it does not look for the regulator supply in the OF node
> described in the regulator_config structure:
> https://elixir.bootlin.com/linux/v6.11.7/source/include/linux/regulator/d=
river.h#L445
> It looks at the parent device OF node instead.
>=20
> My use case is that a PSE controller have several PIs (Power Interface) w=
hich
> can have different regulator supply. A regulator device is registered for=
 each
> PIs. The OF node used by the regulator core to lookup for the regulator s=
upply
> is the PSE controller node and its children instead of the node of the PI=
 which
> is described by the regulator_config->of_node.

Please resubmit with a clearer commit log.

--7CzexVQWOUPpjplf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmc1+toACgkQJNaLcl1U
h9AYIwf+Jz0pq2RWtxh3nGKjn6ddDHMppJmsRGe3fQ6YA3417v/5SuPxHFt8yRPd
W9fEV929otz83g69QuWUSKMMxhHDnZ3J9AnsXPZDoSMVXlR/lqsuQMXN8P/rg0c7
xyb3iy7WsMhhfCKaqOLWXajx2nzEhonn3qvqod/vPVlDayPBsYvqyYqrxaJTT1eV
IEuY/4WltpayVwWWpo6VmFsREtlxPtyM0WKah7N1+DIqU4H4lCdlE9G4Y9NfbykH
2kRQDjZxByJn0Qiejp2ZAaF67f+SNVTBL3zO/xfmx+bTdsMUjCC/p5xC9DA9j6m5
9/1anmkcUTrHt9j3Lm3gOJ/OldvpoA==
=m2mr
-----END PGP SIGNATURE-----

--7CzexVQWOUPpjplf--

