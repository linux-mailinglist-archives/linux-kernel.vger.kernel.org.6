Return-Path: <linux-kernel+bounces-404692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18EFA9C46E8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 21:32:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D25B128B589
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 20:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 673501ADFE6;
	Mon, 11 Nov 2024 20:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qORy36Cg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B791B145346;
	Mon, 11 Nov 2024 20:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731357153; cv=none; b=ojTbwPsOslkiVRlXUTm1U2C2FdOYNBeVHwJr6vQoPZCrrG2l8enYukV+dZsxwDw4jdXv/tMgLkuJty4oPwPQESSos6rwIui0h/CN55EHVgeouEOxNn2Q6DysTx1tuq2feK8SRVR0zWXjneIo4ijyw4FGxxgZu1EnpUNlmSmLMa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731357153; c=relaxed/simple;
	bh=RxN94/y+kmftv7NO4vo60abV9Ef2UWHVP7L48tWQuf8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IlWcg8u7gV4QEcQNncD0B7OcHmjzyhFunkxVFQ1p18EBh4zkhreEoYGXOeg8jTgo+XL1SuVfd/WVxb6TnmEVfCwELB08wtATZa6db/AlIab8rbTA59hYkbXUb08fxVFh7rbHdmEVFbBoNN1z3beKNd2jgIXk7BRfpHwR7BunmLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qORy36Cg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 912F6C4CECF;
	Mon, 11 Nov 2024 20:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731357153;
	bh=RxN94/y+kmftv7NO4vo60abV9Ef2UWHVP7L48tWQuf8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qORy36CgE47eGQqNg0II9Y4fFV6Jn+SbrWSJA9fYJSF5gzyLcEuuGd0Sm9UTNXIpc
	 V0OZP7BUC6gVtgwb+K9uXxddw6Hm4pVrcKfTZskZvTtaL3FLKE93Br9mR7/aTAb6+L
	 Ch8ANNjM+7tWJFUwuujd2h8emczi+lXZTeSHQVokv2jTpSunhQ5ZdE156D/QDW4Rzb
	 hKtMKbN8wb4RBQQAlMQxDdsEJwk8Ll65VFH6IKTTFL3p0+s3/vXmfqaVsUMWT/8A2V
	 2YPwZiLmhTuZ6mWguPBeM7tSEnNqUt4aNp4ZCNwC1V+6Vqmu8EBFuJDsrpggaYuxiZ
	 seJoNFbNBPRLQ==
Date: Mon, 11 Nov 2024 20:32:28 +0000
From: Conor Dooley <conor@kernel.org>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Icenowy Zheng <uwu@icenowy.me>, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/7] dt-bindings: clk: sunxi-ng: add compatible for the
 A523 PRCM-CCU
Message-ID: <20241111-translate-paddling-388fb16627de@spud>
References: <20241111004722.10130-1-andre.przywara@arm.com>
 <20241111004722.10130-6-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="z+LL5xLnfq6nr1NV"
Content-Disposition: inline
In-Reply-To: <20241111004722.10130-6-andre.przywara@arm.com>


--z+LL5xLnfq6nr1NV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 11, 2024 at 12:47:20AM +0000, Andre Przywara wrote:
> The Allwinner A523/T527 SoCs have four CCUs, this adds the binding for
> the PRCM R_CCU.
>=20
> Add the new compatible string, along with the required input clock
> lists. There is now an extra input clock (PLL_AUDIO), so add this to the
> list of allowed clocks and required it for the A523 PRCM CCU.
> Also add the DT binding headers, listing all the clocks with their ID
> numbers.
>=20
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--z+LL5xLnfq6nr1NV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZzJp3AAKCRB4tDGHoIJi
0tg8AP9KvOEQLq3CCUEfpgzQTNT5IvSk90gPk1RIl15PW87w3AD+LIrvmqN6utyI
8aDgAHpRLD2CmAMPHNCw9wxBqHOGCQ0=
=Rauh
-----END PGP SIGNATURE-----

--z+LL5xLnfq6nr1NV--

