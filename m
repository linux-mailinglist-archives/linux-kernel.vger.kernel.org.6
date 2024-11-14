Return-Path: <linux-kernel+bounces-409743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DBC689C90FF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 18:42:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6866B2DB9F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 17:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3559F189F2A;
	Thu, 14 Nov 2024 17:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HrVSuCId"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971B6262A3
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 17:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731605183; cv=none; b=mGJHPI5YPXD+TJEb3DlCfqyoR1W3WwmVl+NJiOVHV7ksgP1cWfSg/z8Kqo9SM+jAOCwiCuzUllRGQRwb+jig7EcARcGav03NPx23M+1vr/JETFqpBh7mq8SjnsAvKnk5I0GyqANKg7TZpXPs1kmhB+BSxjCKT1GuPE8HhLEblHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731605183; c=relaxed/simple;
	bh=5hGCd31SN5Qi9dUD4wIjwIZmmp0Tgn2wooM79cTvkkE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CrNqwy6sEr4MDzDCC/FKBPqSPQDRknAmT13inQM6k6pQ0J+QBosDSRAy4Q8dsUd6r6Pr4xhhbPL/Sn7sc7ozfIljorClIlcuxqZ7yighU5I76KlWPhZpcLDzUJG2d7t7NjxLtHxEuwEeSH7zFIcuc8jA3IB7pWaX6S2H2UM1gHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HrVSuCId; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A43D6C4CECD;
	Thu, 14 Nov 2024 17:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731605183;
	bh=5hGCd31SN5Qi9dUD4wIjwIZmmp0Tgn2wooM79cTvkkE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HrVSuCIdoc2bqcq85EJcvcGlN5X7lugCIb0IjxcSyO81aVK7jdUU40jHs7kQGsrMB
	 Fdkv+S1UcG8Iqs2Ut4uvlq+/7zwiMhr+YhoW8muameFzVwKTgWAV4S/PGpiZDERLBw
	 g5E4aMfeRMBd/Q17eP2CyNdiOQRU4wZjbVtS9QXJzaepLGgbWIvkC3xWbBaMJ4Axnc
	 DdIau+To5rCntmO5vtM+23MASpnMwjpW1M04Ov9hy7MD290z23jGgW8Q4sUj/6MM1e
	 2zZpVr3NEkdLkkCpssXaqUU3qSvDlCB+dGTvtJAuKmoAeD5x2C9ZIxoIpDw1IL/Y8T
	 2VDWvXTaiDLtw==
Date: Thu, 14 Nov 2024 17:26:19 +0000
From: Mark Brown <broonie@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Frank Li <Frank.Li@nxp.com>
Subject: Re: regmap I3C support
Message-ID: <ZzYyu4ptPtYT6vJC@finisterre.sirena.org.uk>
References: <67d549d0-64c6-4d62-add6-0958ef24910f@roeck-us.net>
 <ZzSxKctLlLZexdF5@finisterre.sirena.org.uk>
 <feda265f-f7ba-4017-a08d-b35916aafe96@roeck-us.net>
 <ZzS6ph8KulEITt5C@finisterre.sirena.org.uk>
 <88f34137-b215-4bee-b117-3ff00402ba6c@roeck-us.net>
 <ZzXfmonkRB-KaBhi@finisterre.sirena.org.uk>
 <85584c2e-2c45-4ec4-89a0-111fa5ad1080@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9vTZSd0LYpocvE/C"
Content-Disposition: inline
In-Reply-To: <85584c2e-2c45-4ec4-89a0-111fa5ad1080@roeck-us.net>
X-Cookie: Editing is a rewording activity.


--9vTZSd0LYpocvE/C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 14, 2024 at 06:45:52AM -0800, Guenter Roeck wrote:

> We now use

> config SENSORS_TMP108
>         tristate "Texas Instruments TMP108"
>         depends on I2C
>         depends on I3C || !I3C
>         select REGMAP_I2C
>         select REGMAP_I3C if I3C

> and in the i3c_probe function

> #ifdef CONFIG_REGMAP_I3C
>         regmap = devm_regmap_init_i3c(i3cdev, &tmp108_regmap_config);
> #else
>         regmap = ERR_PTR(-ENODEV);
> #endif
>         if (IS_ERR(regmap))

> Clumsy, and not my preferred solution, but it works.

Right, so the fact that I3C depends on I2C deals with a lot of the
problems that plague the I2C/SPI combination.  Ugh.  I guess the helper
should be OK and there's not much doing for I2C/SPI.

--9vTZSd0LYpocvE/C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmc2MrsACgkQJNaLcl1U
h9CRFgf/TnpLYBtfHxPthpqAfQNa9j9PgYni+zZZWgwi128PbH0D9yuc4qzm6kwZ
ClKFNu9VPrNS/4RCQsks6C3XA1Qxb+J1XtLlAMUoIf8qVFt2xjA/Y3MsIyCGHoJk
lExUpeq3SvFW2h/MZhQYbotxcZEvdzn84QlcGpcUO9fxuMtwDoP0qu30LYNvMEUz
GHX8s7TwshjfGCAp1K5ugl9mB1yYmhhgrdK+cl5E68z3wkMWG8hfNAofVh7nYQ2T
nqbsby/RvUyGnYRXsnZ/24gtqy/JxD8FQaJIkNOnOUeyUIot4CWkwOt4n4GSTXFU
AonmcGm5m4Z1rlfafKAxjw4wHC14zQ==
=3uu4
-----END PGP SIGNATURE-----

--9vTZSd0LYpocvE/C--

