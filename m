Return-Path: <linux-kernel+bounces-328630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9969397869C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 19:23:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4335F1F25E2C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 17:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F0D3824A1;
	Fri, 13 Sep 2024 17:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m75UqRQW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A8C80BEC;
	Fri, 13 Sep 2024 17:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726248208; cv=none; b=iN8QlpjB+t5rWtkqol/v+gJ0w4VDmSLpOixXUjyjlJz+9DyrbwDTvVSrsQgH3kW2K9L6IIpOF65deGhEScuhS9wQ/1GotIVdsquZuVRys28FijUB1RcZnUxW3IANL7T5bROulyOkih3jW4FYvqtgGRDmdrBaCuHDDkwhzZ7YkoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726248208; c=relaxed/simple;
	bh=fuW1xLrho8ZyDrDvp5KKZrf25rnUr95/sDyzrJYGWrU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FVXhg/umsH4XX/b87qHwrR3U5sre92tKoSMOyEVAb1QydF3Llnv4RFQeCEj74yrr1rvrpyL9NL138Q+iCyjpz+exRE0ydCZNnF8GTQzO9SrCWER7qMkXsu05MLkmNwAwG2Wb1e5YDQwMJgNnbmBVVQ31wcHEOiWwkg7jGvoaJgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m75UqRQW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A1B5C4CEC0;
	Fri, 13 Sep 2024 17:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726248207;
	bh=fuW1xLrho8ZyDrDvp5KKZrf25rnUr95/sDyzrJYGWrU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m75UqRQWWxQp01qjARhuOIj1koH4iP0Z/IzXhjrfwrdVTmM7CT0ME4vGilO1Pk9s/
	 l7wq7xQnweGsXOIUNv8beN6zhA5shqaBX8YOpa3Kcwsi7KgLxRZIOBqodDugM1D/sk
	 VhmrsY86lrWyOOqKUg9pM9kRVx4zMHGP6eryiHfQazuud15bQMJ1a4n0sXXn307sia
	 onR5LtCFt1XiPTtFyYwWJrCyXEt9Y5V9qsbseC+2qCTtg/ThpPioUyVGjaBw1Bmoi5
	 TRrweKQW8xVX9MN5+vU1TMDbwQ3zU1FoFy4Veflw9w+WLB1GY6QIxhF0WG4VJGKSqi
	 nihueE8U/RYbw==
Date: Fri, 13 Sep 2024 18:23:22 +0100
From: Conor Dooley <conor@kernel.org>
To: Jan Dakinevich <jan.dakinevich@salutedevices.com>
Cc: Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	Jerome Brunet <jbrunet@baylibre.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-amlogic@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>
Subject: Re: [RFC PATCH v4 3/5] dt-bindings: clock: axg-audio: document A1
 SoC audio clock controller driver
Message-ID: <20240913-drainpipe-retrial-0167665f605f@spud>
References: <20240913121152.817575-1-jan.dakinevich@salutedevices.com>
 <20240913121152.817575-4-jan.dakinevich@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jIzR0wEIk82J930S"
Content-Disposition: inline
In-Reply-To: <20240913121152.817575-4-jan.dakinevich@salutedevices.com>


--jIzR0wEIk82J930S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 13, 2024 at 03:11:50PM +0300, Jan Dakinevich wrote:
> Add device tree bindings for A1 SoC audio clock and reset controllers.
>=20
> Signed-off-by: Jan Dakinevich <jan.dakinevich@salutedevices.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--jIzR0wEIk82J930S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZuR1CgAKCRB4tDGHoIJi
0pvFAP9kr7mdO9xRNEDwdDAwPHjyoLrlCTzOaiy+CSVAUFoI3QEAvZcerXPm4xol
wOmsRIFe78YlrZGiXEc6w5Rk4pTHPgE=
=Vt66
-----END PGP SIGNATURE-----

--jIzR0wEIk82J930S--

