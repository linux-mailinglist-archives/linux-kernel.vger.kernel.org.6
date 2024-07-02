Return-Path: <linux-kernel+bounces-238059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E031B9242C5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 17:49:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EF121C2248D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 15:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56D671BC07B;
	Tue,  2 Jul 2024 15:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f0sVYKLj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BFE016C699;
	Tue,  2 Jul 2024 15:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719935361; cv=none; b=rffZygjO8fhVlqtV7hMffllijbTFFu4qYK9AKavV6P44aa8CFi/xPEF5Fpv2QhRGqfwc9i0WZVf6aeKY9Plvmjks4bQZdx8s4We0OsRf9+2Z6ovXhkn0SjR1gqbnsEQ89KVz+q4z4Ff5AxN6XEIhGuuCaEmX2sLuPh5CEVRH2dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719935361; c=relaxed/simple;
	bh=CLeZkRpccekGFaJDAZHh9ru+zXHtmfiQEBEBaYlfaOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lHVNZNjncjMOLXGSfG9Vnu2zWNRX8pZxLPb4YTv+za/EwP6yInKqbklgjGoYsNeMilTI4ReLX+/BBlArF5Reh0mpbCws/SPl6BX+Ufo57LDVUGB3Pn+Zkeby8ewAE+ArxPL0li4cC/COT9zPSTgjPYOhLtpsYS7M3otKANTa5WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f0sVYKLj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70D0AC116B1;
	Tue,  2 Jul 2024 15:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719935361;
	bh=CLeZkRpccekGFaJDAZHh9ru+zXHtmfiQEBEBaYlfaOI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f0sVYKLjusbr6WZiQQFq82IxLDTQYoU78dA4tpPyD2yeNrpK9uP/BA4BnBUuPzW1A
	 iLHmEAGe096X4wzpG7Ahz7gQfvu5tQr8f6KLpeICpR/bJvXqETh+skTtGF2u1Wonep
	 zF+3puhMsI9S130BoqH71SJnXOEFXyYYYI3lDxamL0pH1bLBMXZkpue59eeUN/qPhl
	 UoNc5LcAO3Fc0nhhKI/5HuDm84QgIPsvjnOt9X4qFF+UKdloD9NuagQZ82qUpEG8WT
	 lOdg+WZyz3IO/TuqmaCyS7U76OZdcU2VKv0+Y/gMSCVMyDin3nscZm6xgoF6F78NkW
	 rySOGP/Hpc70Q==
Date: Tue, 2 Jul 2024 16:49:15 +0100
From: Conor Dooley <conor@kernel.org>
To: Frieder Schrempf <frieder@fris.de>
Cc: Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-kernel@vger.kernel.org, Li Yang <leoyang.li@nxp.com>,
	Rob Herring <robh@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Frieder Schrempf <frieder.schrempf@kontron.de>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Gregor Herburger <gregor.herburger@ew.tq-group.com>,
	Hiago De Franco <hiago.franco@toradex.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Joao Paulo Goncalves <joao.goncalves@toradex.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Marco Felsch <m.felsch@pengutronix.de>,
	Markus Niebel <Markus.Niebel@ew.tq-group.com>,
	Tim Harvey <tharvey@gateworks.com>
Subject: Re: [PATCH 1/3] dt-bindings: arm: fsl: Add Kontron i.MX8MP OSM-S
 based boards
Message-ID: <20240702-pregnancy-crisped-7b77cc913c90@spud>
References: <20240702154413.968044-1-frieder@fris.de>
 <20240702154413.968044-2-frieder@fris.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Z/lfY4EWMRgbyzjc"
Content-Disposition: inline
In-Reply-To: <20240702154413.968044-2-frieder@fris.de>


--Z/lfY4EWMRgbyzjc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 02, 2024 at 05:43:19PM +0200, Frieder Schrempf wrote:
> From: Frieder Schrempf <frieder.schrempf@kontron.de>
>=20
> Add the bindings for the Kontron i.MX8MP OSM-S SoM and carrier
> boards.
>=20
> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--Z/lfY4EWMRgbyzjc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZoQhewAKCRB4tDGHoIJi
0jrhAP4vLT2qGfQJnmWAprxEz8l+mp5z4FpBIt0tTQwb9HySJAEA67/wbHuUIXSL
D1NyeB14UZiTIUUm36gEwQI2rb2P/go=
=eti4
-----END PGP SIGNATURE-----

--Z/lfY4EWMRgbyzjc--

