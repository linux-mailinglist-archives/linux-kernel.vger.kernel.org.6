Return-Path: <linux-kernel+bounces-427602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B2BB9E0348
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 14:24:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E66B328226F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 13:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE6641FF5F4;
	Mon,  2 Dec 2024 13:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="calzYjdH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F81F1FECA1;
	Mon,  2 Dec 2024 13:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733145842; cv=none; b=PP++oAX0hPaWo1hR7y/aJGn4orxP4QZ7JgQC17ffAvJItp9ywYpJGK1a7rrP1utW8n8p40jPru7YDKzl/FWMQQYe3lSgG9njgo2Ha2AfB5OP2ltFBUIsftFzXj7CsZDK+EZMeTzOSBA7lHQ2FrZQnpvFejz/oEatap2BQdX0AeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733145842; c=relaxed/simple;
	bh=qu1R/kK1qfP1c9hhleo/yXfnQOWc2/8uzcTJyQ0tTSI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cR9rgyRPNtHBaFhc6OlrjytsvYVq/J8IqSNfYIqq6KwfCuW4OHkksIj9qY8eKKHojpPYEZTyWcLA/zf67A3jZ6CS7fyNCGMmU/9pVTNEvQZ8yg3Lnl7KybGvM1tLkT+pk5AEBsrnnQYPftSuVlqS1ZtYuTHDDZf2vBt2AmfivzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=calzYjdH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39B96C4CED1;
	Mon,  2 Dec 2024 13:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733145841;
	bh=qu1R/kK1qfP1c9hhleo/yXfnQOWc2/8uzcTJyQ0tTSI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=calzYjdHtzyKjS6MKp04EUDD1P6auKh3QqnwpOwOQRMmMm2+lbdpsnBugzXskk9Pf
	 c+tbr1T6AHkJsUbGx/F8rSNXXNdSPn6QZIJOZSPwNiDoI6YuYyvUGEbaZ4GQYOFwJk
	 lFx7mBecy+YtXN+t5939kVaRjFsJ2jZuEzEFXWoGSzAjWDjt38IpQ3fbgp1OdmHoAr
	 ZQUMYqN1pWyeOAJUJ/O9Xv0nlfduSG3IXJg3NjsZkilKJZwa/0ObRSJF1mf8LWrJlX
	 KXwcjqSoOqbK9iMICfGR4dRk17jyCsiY5fRTRIfBWbraY71ZVkyxbhp8JTaKY+vc67
	 sYJrK2+wWeH+g==
Date: Mon, 2 Dec 2024 13:23:56 +0000
From: Mark Brown <broonie@kernel.org>
To: =?iso-8859-1?B?Q3Pza+Fz?= Bence <csokas.bence@prolan.hu>
Cc: linux-sound@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
	Mesih Kilinc <mesihkilinc@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH v5 1/3] ASoC: sun4i-codec: Add DMA Max Burst field
Message-ID: <a59c5425-4401-480f-bf26-a7d607071f75@sirena.org.uk>
References: <20241102125712.2647325-1-csokas.bence@prolan.hu>
 <20241102125712.2647325-2-csokas.bence@prolan.hu>
 <fe02df7f-16ae-4128-9af8-7de7f76734bc@sirena.org.uk>
 <47344634-9681-43a0-995a-f7dc025d1d09@prolan.hu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="TUCIIvv8937S6Tht"
Content-Disposition: inline
In-Reply-To: <47344634-9681-43a0-995a-f7dc025d1d09@prolan.hu>
X-Cookie: (null cookie


--TUCIIvv8937S6Tht
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 02, 2024 at 02:19:51PM +0100, Cs=F3k=E1s Bence wrote:

> Try v6: https://lore.kernel.org/linux-kernel/20241123123900.2656837-1-cso=
kas.bence@prolan.hu/

> If that doesn't apply either, then I'll look into it, but it seems we
> already missed the MW for 6.13... :(

That was sent the day before the merge window opened...

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--TUCIIvv8937S6Tht
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmdNtOsACgkQJNaLcl1U
h9BxDgf/QXzdQ7mVZv9iRdQN5uXStSZy2H6trQtrAXTzaKsW7xWcEkqwPJ4EnnUk
wT+JiD6BWilmxjLtmCsaLWiZw3X7OxTaJjtGA0ySTfaIgpzRuRB5WWZr9xKipDXW
9F/Gs8yMot5PpUMVW1Ho6S3Ic9jktf3N95FstgEJo5GyyFM/UiFzxvunbk/zGjJY
wT0C9PkeCYTcG7bEoe20NY4whJu3MN1solOeO1F9xW8gwCYFdPBqfavB+cIdTjCf
alflkk1+6YqqnLbfzN0tHhEqNioVzlFg2qMGOXLC7cUg39DRh6A7FuC+0XxUqQUZ
hKItXmC9FyLoMhnP9wCZ3FvZ9qGn2A==
=DN0z
-----END PGP SIGNATURE-----

--TUCIIvv8937S6Tht--

