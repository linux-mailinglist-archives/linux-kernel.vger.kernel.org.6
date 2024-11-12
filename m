Return-Path: <linux-kernel+bounces-405909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C68D29C58C0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 14:16:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CECC28103D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 13:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A68814387B;
	Tue, 12 Nov 2024 13:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EQtkHIAa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D9E5FEE6;
	Tue, 12 Nov 2024 13:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731417380; cv=none; b=c2KtRPjbl7yNpEVxWQKKb1aWmd34QyAgpuSL94O8pHEH0L9OMFo/czcIaU7VRhysMy3LjZAuh5EHkpOGUo+HM0cd/EtoS7qkMkESjyQHYRDWaqgdPApa1+DftR3jc6PdAtASD7k5ytQFzEs4nGViC/+8F4p4AJnq1rhrB6g/0Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731417380; c=relaxed/simple;
	bh=/LXILyQW0YKQwU2/DZFNOfpGJbKzQNU/KY1lRH7sWyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hfty+mKk7y8O/nDudE+cOHaG9iqVVKkndjiO1OvyAaz2SiBgGexHopjBzX+/DgSEuHJZrivhOHCHohUJjdB/5XNORs72/Y01rAckPWk0jc+1q3xruAT5GuTH6Bb+TAL2xuXuDxK7VR1cLlVHPum+0ksjna5B+UTL9QTZKYq2t/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EQtkHIAa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEE6AC4CECD;
	Tue, 12 Nov 2024 13:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731417378;
	bh=/LXILyQW0YKQwU2/DZFNOfpGJbKzQNU/KY1lRH7sWyk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EQtkHIAa6Y0YGpZn7/2Xj32/gVfaT/iWxz62OhXcodrPL3Vku8QUg+GP5FFRl73Vs
	 Jlql/AxfEgnnIp91iikhJuXbIAC89ZH48aZifwKllu8pRGP2QKt9fR94VCt0QXCF+3
	 +cwijR6zc8rHlEyP1L3MShJkB3Wm8lKM9n5g5Z9Vos9B7dJdmvYeOeHp+RZn4DTNYL
	 8KMqqt3JSqpvT2gSDm/hWljwXrczPzK8Km1H2HNu9mqi574w8IQIwEdEqpw0hobt8e
	 sSNlXjtyskzF0sntS6V8b6doqGJiK1aHqeDEqQLQVpdsDKzVc68Kj8X0k7SHZ3JpK9
	 kXSypfc87OQMg==
Date: Tue, 12 Nov 2024 13:16:15 +0000
From: Mark Brown <broonie@kernel.org>
To: Marek Maslanka <mmaslanka@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Support Opensource <support.opensource@diasemi.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org
Subject: Re: [PATCH] ASoC: da7219-aad: Fix detection of plugged jack after
 resume
Message-ID: <ZzNVH65o0ue6jn6a@finisterre.sirena.org.uk>
References: <20241112074048.1762371-1-mmaslanka@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="JB+OrQ7TuTIBolfs"
Content-Disposition: inline
In-Reply-To: <20241112074048.1762371-1-mmaslanka@google.com>
X-Cookie: Editing is a rewording activity.


--JB+OrQ7TuTIBolfs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 12, 2024 at 07:40:47AM +0000, Marek Maslanka wrote:
> Don't notify and mark the jack as unplugged during the "set_jack" action,
> because this action is called very late in during the resume process, for=
cing
> the jack to be unplugged after the resume, even if the jack is plugged in=
=2E Let's
> leave the responsibility of managing the insertion of the jack to IRQ.

> @@ -33,10 +33,6 @@ void da7219_aad_jack_det(struct snd_soc_component *com=
ponent, struct snd_soc_jac
>  	struct da7219_priv *da7219 =3D snd_soc_component_get_drvdata(component);
> =20
>  	da7219->aad->jack =3D jack;
> -	da7219->aad->jack_inserted =3D false;
> -
> -	/* Send an initial empty report */
> -	snd_soc_jack_report(jack, 0, DA7219_AAD_REPORT_ALL_MASK);
> =20
>  	/* Enable/Disable jack detection */
>  	snd_soc_component_update_bits(component, DA7219_ACCDET_CONFIG_1,

This path is also (AFAICT only?) called when registering the jack by
da7219_set_jack(), I'm not immediately seeing the path for resume.  This
suggests that what's going on here is an issue with the machine driver
unregistering the jack over suspend?

--JB+OrQ7TuTIBolfs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmczVR4ACgkQJNaLcl1U
h9DyIQf/ekR9b6q5XbqcP889qtqZCzoymtgTaSj3bvLa6JKDZd13bL9mvWgRtDRU
DK4119wZc3+5VFlG1zsgbXDaoKE4xyhJH4t2NXGBilKTLh7f97fRSXJfIfqBTPiD
fmDdNhBPWw8ayr3MynnOTXR78cFT6o3DNmSYc89eyCQFdT2H9TJre3wyepTDUKlY
O6MXbrYb7N7XItSZyyMImswSFluq6gJ8VOwdNivzC3+zR7iUA7dRLX2yh5J4ZlAJ
0XwrmmSW4OLfaVWcPZfEaI3EL7PaDrSXq0RW0AXn2bURKQta5lz4bFABA1dmtvjT
0lyUcmw5HkYerovMFLi4epvusDacmg==
=4Yij
-----END PGP SIGNATURE-----

--JB+OrQ7TuTIBolfs--

