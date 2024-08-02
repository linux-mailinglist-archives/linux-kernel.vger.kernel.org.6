Return-Path: <linux-kernel+bounces-272960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 581869462C9
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 19:58:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13F7A2828F7
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 17:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FF8B15C12D;
	Fri,  2 Aug 2024 17:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GuJAc3w7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A76415C126;
	Fri,  2 Aug 2024 17:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722621517; cv=none; b=B/AJlfiYT/1bZIkDPN4YDhF27irRsdwq/p9bFbOG/cLAKRDF4VpcphtrWOIsdhIHaRX2zCwkHa8FPe9jXCxMH+oOZxxxDARh2n/m9ATKf4KZ6qDhKy8rd4+7so6V9/pa45v5x9xjgtxXTilNKQ+4jYUVBtZ3Pd4XXlFdQZB6+EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722621517; c=relaxed/simple;
	bh=GgOQs8fWVA6+ODz3DoKPihPh88i0r8y5j3hiHzKyiHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YofD9HXxU2v06vY/AEMNYcf+EXl1GWk/uToTqgBRzgeXirzSect9obMLOUax6Q+8UzJtgy5h/FmOdKTJQEuJVnB8gsFr3KQzhNGypF+y6N+WXLTUwtX/N1g3N23NgtYOpkwlfn4DvvVeRvabLqa2sHl5N/ofl9/GRbgFr5t3ZR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GuJAc3w7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F38AC32782;
	Fri,  2 Aug 2024 17:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722621517;
	bh=GgOQs8fWVA6+ODz3DoKPihPh88i0r8y5j3hiHzKyiHw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GuJAc3w7YaGE2Y2S6OEZue2iJyz1YZIA2JPeGnuKiNKwMrT3uu/FNGHXBKuCrbZAt
	 YR/j3tgsN39AuIFVFdcysv3gFVrTO/GSPUU/a4q+JJ4NVGIGjr2nzGMpQsdEll04UC
	 eVRmnf6eaYu4ltcrMRZpmdXqLAfPhCsH3gGVEDJ3i7VYOwl5tv6AauO+UY2cEchWge
	 AziV3/P/0sALOjwwhXvV6wzwhAQ4flOxmDeavh27zvVumZ66QT/D2uqnVGslv4Ko0i
	 MT9FNYEWNBwTr3Fz9771S4YvcrM65/OG7jZgdeAbRZArq/LH3elXCUdu2cktNyErvM
	 3YpcHGYOPYm1g==
Date: Fri, 2 Aug 2024 18:58:31 +0100
From: Mark Brown <broonie@kernel.org>
To: Andrei.Simion@microchip.com
Cc: lgirdwood@gmail.com, claudiu.beznea@tuxon.dev,
	Nicolas.Ferre@microchip.com, krzk+dt@kernel.org,
	conor+dt@kernel.org, robh@kernel.org, alexandre.belloni@bootlin.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, Mihai.Sain@microchip.com
Subject: Re: [PATCH 1/6] regulator: mcp16502: Add supplier for regulators
Message-ID: <e0db4f2b-ce4f-4560-b586-1d8dbb75c7ff@sirena.org.uk>
References: <20240802084433.20958-1-andrei.simion@microchip.com>
 <20240802084433.20958-2-andrei.simion@microchip.com>
 <98f91a56-946c-4a40-b908-45f4c6c6d66e@sirena.org.uk>
 <f318439f-b520-4b86-99a7-eb9a2e47525f@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2wUEPk6V6lIxYR86"
Content-Disposition: inline
In-Reply-To: <f318439f-b520-4b86-99a7-eb9a2e47525f@microchip.com>
X-Cookie: -- I have seen the FUN --


--2wUEPk6V6lIxYR86
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 02, 2024 at 02:25:15PM +0000, Andrei.Simion@microchip.com wrote:

> In regulator.yaml exists .*-supply [1] which practically allows every
> char sequence before -supply. In the binding microchip,mcp16502.yaml [2]
> each node under the regulators includes all the rules/documentation
> from regulator.yaml , so I supposed that it is unnecessary to add
> in the binding of those new property.

> What is your opinion? Let me know any thoughts.

The specific names for a given device are supposed to be specified,
there's a bunch of existing bindings that appear to do that.

--2wUEPk6V6lIxYR86
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmatHkYACgkQJNaLcl1U
h9CIkwf/RsbW7SyzVKRGUscKpzn3wbeRWCz0wIKHuuAl0St8cJoZ+yOx2gfpXAG6
dvKJblD/8qEq3VDQPgDoLCvlP3rr4MyoM+4TlZQEXAZJ9tpmNqh0RstFA9pvpjSc
LrcLotb4ZX2enREjujCphZnvy4rCauddzJRPx6hDnlGvcbkAcemZRvRTyPVMiJeQ
Okc/k9h7/6NkGvf8eWEszAqEpsAytEye7Lkw9rlRpj8aCwfTQa7JJVrMqZZZmxg+
MrUHqDa20mc/RMkWhAaoxNBeTosjGcHkShnYsvVIxpNXqETaix2ym3igFUP7OG//
ztr4pub4/1pMjxdSje6vokLzBWrqbA==
=Uffm
-----END PGP SIGNATURE-----

--2wUEPk6V6lIxYR86--

