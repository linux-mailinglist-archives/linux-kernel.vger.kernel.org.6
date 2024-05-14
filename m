Return-Path: <linux-kernel+bounces-178659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 195568C560C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 14:29:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C64841F21ADF
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 12:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F19A5025A;
	Tue, 14 May 2024 12:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qI0k5HvL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908542B9B3;
	Tue, 14 May 2024 12:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715689789; cv=none; b=qmSbLz98mbI30Cj5nwGMxcygP7ZdkVvcY5zj3Ieo13KqFZy9U/Iby1loruuzUC31IIwacoZdO9h2opDwB3mSqaaOmtC3wNcSvfnFRjWFzDHXJALYHrHSJM57OBk20RX/zjwm65409do09wfon54M/1TN1vgIZ/VrFm1AwwoiC+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715689789; c=relaxed/simple;
	bh=6cPrpE0EOmonSqbDlomNuzEI4XBK54BEpKNy1lBWCU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DqZ11bsga68dRKjbz145A6Wzr/7wygGggkXjldUO1XDHUf+oa1VEw81gRXmNJerF5S/yXk34jm8PslSmw8jMzYvEEEct4zZVckokuw5YFBWHOeW3piZnkCZxIJ+DfW4C/KpWzXmXIuJLihq1/G2+IHhJGxHLt8QYgUEqbGo0NUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qI0k5HvL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06663C2BD10;
	Tue, 14 May 2024 12:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715689789;
	bh=6cPrpE0EOmonSqbDlomNuzEI4XBK54BEpKNy1lBWCU4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qI0k5HvLfn1CfWJxRrdpit474Aa9aUxoOG7lKfDGJZ4mH86QzX3tmCOKcHdYhEspa
	 Z81olAP9T5jKFCeYEubMWE6uWxP31811HsJnrqjSwJF9thfFSeATGhHwi4ckomsIch
	 tO3lrlIV8++649cRA9gyRmBnhHTOunHMMw3OQLCy8EJFoPwXUqRwN3+xSorBEBpYl7
	 vQD++G3Tkyx5/MrdedtUejyEoqkgfIVtYjOjefsyId/95tPIFGH2TDeK2jb9FjjF7S
	 aqF84E3Z/R2vVis3YdJjmzv9+FOU/I6aVtD8FSdttZSNrNy3FP/GgTYISNilqIw26E
	 iAKRAmiemJkLw==
Date: Tue, 14 May 2024 13:29:43 +0100
From: Conor Dooley <conor@kernel.org>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: linux-arm-kernel@lists.infradead.org,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Bjorn Andersson <quic_bjorande@quicinc.com>,
	Maximilian Luz <luzmaximilian@gmail.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	"open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	Stefan Wahren <wahrenst@gmx.net>
Subject: Re: [PATCH 1/3] mailbox: Make BCM2835_MBOX default to ARCH_BCM2835
Message-ID: <20240514-amiable-unequal-d4133956c80c@spud>
References: <20240513235234.1474619-1-florian.fainelli@broadcom.com>
 <20240513235234.1474619-2-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ZF82ErRhEId7DTVg"
Content-Disposition: inline
In-Reply-To: <20240513235234.1474619-2-florian.fainelli@broadcom.com>


--ZF82ErRhEId7DTVg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 13, 2024 at 04:52:32PM -0700, Florian Fainelli wrote:
> This driver is depended on by CONFIG_FIRMWARE_RASPBERRYPI which provides
> a number of essential services, including but not limited to a Linux
> common clock framework provider. Make sure that enable
> CONFIG_ARCH_BCM2835 does enable the corresponding mailbox driver.
>=20
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
> ---
>  drivers/mailbox/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
> index 42940108a187..2b4cde562a90 100644
> --- a/drivers/mailbox/Kconfig
> +++ b/drivers/mailbox/Kconfig
> @@ -109,6 +109,7 @@ config ALTERA_MBOX
>  config BCM2835_MBOX
>  	tristate "BCM2835 Mailbox"
>  	depends on ARCH_BCM2835
> +	default ARCH_BCM2835

This is just "default y", since I doubt ARCH_BCM2835 can be a module?

If so, patch 2 could also just be "default y" and I think patch 3 can
have the same logic applied to it, given you're defaulting it to a
dependency also?

Thanks,
Conor.

>  	help
>  	  An implementation of the BCM2385 Mailbox.  It is used to invoke
>  	  the services of the Videocore. Say Y here if you want to use the
> --=20
> 2.34.1
>=20

--ZF82ErRhEId7DTVg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZkNZNwAKCRB4tDGHoIJi
0g9yAQCQfW/zAiGbZezyBzVcnkHGAEnFDwul79aAYPQZhc0dGAD9H+asSEG/ICHL
HtOFDWlh1G+Pmy1k37sMldVMk4wZfAI=
=1AwS
-----END PGP SIGNATURE-----

--ZF82ErRhEId7DTVg--

