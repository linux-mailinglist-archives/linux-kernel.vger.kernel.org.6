Return-Path: <linux-kernel+bounces-375208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB6A9A9321
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 00:16:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB6D2282CD2
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 22:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01C341FDFA3;
	Mon, 21 Oct 2024 22:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="URjA5o8g"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CBB41CBEA1;
	Mon, 21 Oct 2024 22:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729548957; cv=none; b=XjxHpWDg/rwEPW/PgS1RZsnS8M4GaVp95GXCxwC91UHJo2bo3qgVtOfOrCZleMEycrv9VfHaDccjk18O/H8naAJIDU3okIijERqjqpENoPsA8h9BrASI/A+5Oxjp+fVAF1BExzetK78zP5T0HLOTMgcQYsPxpuR5smyiPxXnbfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729548957; c=relaxed/simple;
	bh=tlzS8OUaGKKM5mELn1RLA+UMFi/tFuqHtRRxd4kXqJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RucCQfbVVSWuxIwNcmbTKCnhj1LHzyyxNBUxT9c/AYqe0wK3E3Yz5l8tfChvLpCe7IKRLjyNDsEdwp+/7nrDAGiJJ4q5Si6QoKDS0vgJodi7E0u5AJpYIHCADbp3qm4lxWGmh0HOH3JxWoOGkw5hOz0iXnxnsnT2rt1ZIxKvSYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=URjA5o8g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99A33C4CEC3;
	Mon, 21 Oct 2024 22:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729548957;
	bh=tlzS8OUaGKKM5mELn1RLA+UMFi/tFuqHtRRxd4kXqJs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=URjA5o8gwhVBxpzGXyx0rnXf3C/QswFyUUSwpGvUv/UBKeWb0sjIxB3MYkxs0dYQv
	 9dpe6Xcltn1JEVsfORiJfKZdZYHN/b5FtG3ucsHGz3wLZpocimGKA8vXUcXampTBjd
	 LP12RPeCfq5UPp3vmCbh0V8UbLV+l7+FCC24xc77hLH2zIUDDk+OZOqV+CseTO65Qz
	 HA7mDtOviNHk4WKCasAEDM/mNR+3PpeLAbbiKwJXONon+7IbaGqcAQs2l0sYxj9jV1
	 Wfz7J+JWC+QIl7+OdX/Al3MhxeIoJPPzeMmZMYiZEQ6/IUjyx97g+Jva6/3fXmdvCu
	 37baddp7RVfoQ==
Date: Mon, 21 Oct 2024 23:15:50 +0100
From: Mark Brown <broonie@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: James Calligeros <jcalligeros99@gmail.com>,
	Martin =?utf-8?Q?Povi=C5=A1er?= <povik+lin@cutebit.org>,
	David Rhodes <david.rhodes@cirrus.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	asahi@lists.linux.dev, linux-sound@vger.kernel.org,
	patches@opensource.cirrus.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Hector Martin <marcan@marcan.st>,
	Neal Gompa <neal@gompa.dev>
Subject: Re: [PATCH v2 1/3] dt-bindings: sound: Add CS42L84 codec
Message-ID: <e1d35dc6-4c58-490a-87d3-1e9694b3c650@sirena.org.uk>
References: <20241020-cs42l84-v2-0-37ba2b6721d9@gmail.com>
 <20241020-cs42l84-v2-1-37ba2b6721d9@gmail.com>
 <20241021192632.GA965116-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="AuSqP+ZlqEY4r3Ug"
Content-Disposition: inline
In-Reply-To: <20241021192632.GA965116-robh@kernel.org>
X-Cookie: Most people prefer certainty to truth.


--AuSqP+ZlqEY4r3Ug
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 02:26:32PM -0500, Rob Herring wrote:
> On Sun, Oct 20, 2024 at 12:47:31AM +1000, James Calligeros wrote:

> > CS42L84 is a headphone jack codec made by Cirrus Logic and seen in Apple
> > computer models starting with 2021 Macbook Pros. It is not a publicly
> > documented part. To a degree the part is similar to the public CS42L42.
> > (The L84 superseded L83 seen in earlier Apple models, and the L83 was
> > pretty much the same as L42.)

> Why can't this be added to=20
> Documentation/devicetree/bindings/sound/cirrus,cs42l42.yaml?

> I guess perhaps you don't know what the supplies look like? Do any of=20
> the custom properties apply?

I don't know if the Cirrus people who are listed as maintainers of that
binding might have concerns about doing things that acknowledge this
particular part.

--AuSqP+ZlqEY4r3Ug
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmcW0pYACgkQJNaLcl1U
h9BZFAf+MkynQkP7ahny4beQjJnCITxsbLUXDPAGR+wG/KKSSbtlgtwaDh9n0KS8
XBaUhZRgJoImr4uV6+0Nw8NHgsCEoQw/5E6vS2f7614m0H2j5FqZVwgK1L14HwbD
bJgpZp/Hd1GJSKSwj7mr354p6n7S3TlL8zDsTkTxXHhFwPh+j82aSTdffYG96q9r
TqfHCFrXRV1Am5DK+WOskUduHAGUXzXo/1HlQldi9Bu0Hn/LCfj9q94ZbrfCGL+P
xvwYAVpnsRqDyiwusLLDO+AvpsZENN3+eUGOy18CNy3ioxODjEqnyfusnW2VyXUq
bSRvUQpI7boxZrZtz13nHX5kPBT++Q==
=KMNB
-----END PGP SIGNATURE-----

--AuSqP+ZlqEY4r3Ug--

