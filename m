Return-Path: <linux-kernel+bounces-331489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 890EF97AD6F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 11:01:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC7821C21E9D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 09:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A20C5161328;
	Tue, 17 Sep 2024 08:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SvkTzFN8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B56B84D0D;
	Tue, 17 Sep 2024 08:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726563596; cv=none; b=hV/Ok1LBjnF28FZzFxAKyuGh7c1H91rHP8WJzPBQ7NjbC53QRRXBk0Mcj3wQ2w5UjPV5gIRvzZ8m1gxqWTyOURxgTyWAdXve9A5gIv5coyN2bSx19x69UJJExfiS5OftJpk+ogrGlemyr6x3JxFo3RUDACKhtvGIpk5qNQiEMyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726563596; c=relaxed/simple;
	bh=tXu0eapoLvLFmUCgPF7gO02TNtluf/3xL26Rh9QI/J4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GgG05rIH0QUzgOJ9FohdnF92AT6InI2dgFGiCGrXaN19QsJRQW+Syspls8aKKPyvGuyO8soJk3RIRFJQfHg/mt1MQgTqdd92+axVv7xiX2M4xWbomFj388JfsnGr1bsFo2YP1z7dZ9rxhOX3eD3Lc9Twvq48SjwmRbXzICW7kI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SvkTzFN8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE717C4CEC6;
	Tue, 17 Sep 2024 08:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726563595;
	bh=tXu0eapoLvLFmUCgPF7gO02TNtluf/3xL26Rh9QI/J4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SvkTzFN8DeFxz/ls3vUte30EplGhLHgY8djGjA5e2AHXZfDuo69fv/ONVb0tx3dN2
	 QpMs48VdB8Ct1luihrUSKJfSZ8vG5LESZvfbUcC95qGVzYjcWIB3PB7rs1z8HZcBA2
	 mtDDOm01DaAS3UnPBY1AQJ3m5TAxRdyxlZ94hYD0USm8DQRi8eUjHclDMwKcTRXhoX
	 6qntk6gQB3sgBcFerQKqi//MJ9fIao+T0Zy5d+W11vkOaGWOvv3JOqeJND2T0wLS0I
	 LZfE7e7ByYv0CFJPIWNjdCpu66UYcTOGzzcAsnrfZ3dv30rlRpW8tJKkeOC0yyurGu
	 VPGvd0nIfMW0g==
Date: Tue, 17 Sep 2024 10:59:49 +0200
From: Mark Brown <broonie@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: =?iso-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>,
	Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Walle <mwalle@kernel.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Will McVicker <willmcvicker@google.com>, kernel-team@android.com,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 2/2] regulator: max20339: add Maxim MAX20339 regulator
 driver
Message-ID: <ZulFBQzRdOdw9cfV@finisterre.sirena.org.uk>
References: <20240916-max20339-v1-0-b04ce8e8c471@linaro.org>
 <20240916-max20339-v1-2-b04ce8e8c471@linaro.org>
 <29f30aae-ffad-4a42-909e-b05f9cf360b5@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="iL4VU5TqXhxMEScI"
Content-Disposition: inline
In-Reply-To: <29f30aae-ffad-4a42-909e-b05f9cf360b5@kernel.org>
X-Cookie: Editing is a rewording activity.


--iL4VU5TqXhxMEScI
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 16, 2024 at 10:06:37PM +0200, Krzysztof Kozlowski wrote:
> On 16/09/2024 18:48, Andr=E9 Draszik wrote:

> > +	/* INSW status */
> > +	if ((status[3] & MAX20339_VINVALID)
> > +	    && !(status[0] & MAX20339_VINVALID)) {
> > +		dev_warn(dev, "Vin over- or undervoltage\n");

> Same with all these. What happens if interrupt is triggered constantly?

Logs on physical error conditions are a lot more appropriate than debug
logs, they should basically never be triggered in normal operation and=20
often it's a priorty to get information out about a failure in case
someone might actually see something going wrong - especially with
regulators, the system might be about to fall over if we're failing to
regulate except in cases like SD cards.  However in the case of the
regulator API where you're telling the core about the error it's good to
defer this to the core.  We should probably be doing a better job here
and logging something in the core.

> > +	if (val & MAX20339_LSWxSHORTFAULT)
> > +		*flags |=3D REGULATOR_ERROR_OVER_CURRENT;
> > +
> > +	if (val & MAX20339_LSWxOVFAULT)
> > +		*flags |=3D REGULATOR_ERROR_OVER_VOLTAGE_WARN;
> > +
> > +	if (val & MAX20339_LSWxOCFAULT)
> > +		*flags |=3D REGULATOR_ERROR_OVER_CURRENT;

These should be notified to the core too, especially over voltage.

> > +	irq_flags =3D IRQF_ONESHOT | IRQF_SHARED;

> Why shared?

Why not?  In general if a driver can support a shared interrupt it's
polite for it to do so.

--iL4VU5TqXhxMEScI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmbpRQMACgkQJNaLcl1U
h9B1Mgf/XFzszylzEWxSjxSQmg3pso1XSKZ2WVOYmEFBYlMiIVNAGDS0mqpa5Jhm
GgvQMHA0ms3TcjDmKwCklJOPZJpVyGdHU2zqiv1fsk2Ys3eytYOiyJTf37HgbDip
gLrqaPj0iJQryXnXLUlmB4vE5KvyEPnCwHtuVU4m7aD0PK4XTMAyhuujs3fX1Z5k
rIxX/DuxdvxWCNwuvalxlGRaMy9FgzDVn62xsIv+le8pNip/87Gcuy6Gr4MD+T3Y
zBqNlwdHFzl92UQx+/6M6NgTmhVosqk/PSXSbd7xra28LPTzlX/k6zpMZC182Lqe
KIjGNTi7wtXIw9YjdDR2H8XIzLhcfQ==
=cA1u
-----END PGP SIGNATURE-----

--iL4VU5TqXhxMEScI--

