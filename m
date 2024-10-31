Return-Path: <linux-kernel+bounces-390653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F0029B7CD0
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 15:27:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDA751C20A9D
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 14:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 259E71A0732;
	Thu, 31 Oct 2024 14:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SMSdNMD+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752CB1A01C6;
	Thu, 31 Oct 2024 14:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730384864; cv=none; b=i1FrLIHwigCxaxzxAS7iY+NPb9qCkff2+Yi/8zdoRnEJMddMywbUbHWPMWgd2XbDGv8bRyrNH8Eq0sSiF2z/nNffB/0Q0grRnHSQnGEfl6fZD3gvty2ccnMze/JOXZ+04pssdWFuFpqMxsTLDJawcc+8kyNtGncX60yjiz63NGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730384864; c=relaxed/simple;
	bh=0VFKeI1RdtsenUvtom72hXjYrfUswcH7nHkImzR9QY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AxEtIpzA+PCQIM6DZfkTcZokxZE1W5h13BXqpoPCWuV3fh3OOmiOio8XcAA1ATyxJh5Hyerb0dOKrHchEN69Mn6it2u+zg7nTTCLuC0GdKiuMPsVEy8gGpzcNyTsW+6H6XfteI7AJMpnpPZ1AzUmrwA6oqzdqJnxK1Ko3W90Gmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SMSdNMD+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76A4AC4CECF;
	Thu, 31 Oct 2024 14:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730384862;
	bh=0VFKeI1RdtsenUvtom72hXjYrfUswcH7nHkImzR9QY8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SMSdNMD+U58gioJZAobamXIL4QOVQC/TammrC2vS9MsmHXrB8wAQcdF5HXTuWm0Bd
	 GsgF6jUW5jN9BdIHHrUJ2H7UbF6aFNsFf/Xxbo+ybbDumCPu55HSNJ+/v57e1lYPqw
	 RJpp2wriW7qsdZF/N35UDTI6bekcS/aS6+VsPun3peJiyM1zEKr4rwUkw6afMLSiWD
	 2KBSivQr3XWHUh4yUAUyxoMj9Lt4oyn9HaUB4yXZVzf2xwY2JBVh7zF8pia91sZU3G
	 HtX6q1zvkAw///hleArznfjVKan3w0PrwyIXMpxVS5Dzstqj4n5zCV/+6UTyuS/tXY
	 r/Um/BCGySChA==
Date: Thu, 31 Oct 2024 14:27:37 +0000
From: Mark Brown <broonie@kernel.org>
To: =?iso-8859-1?B?Q3Pza+FzLA==?= Bence <csokas.bence@prolan.hu>
Cc: linux-sound@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
	Mesih Kilinc <mesihkilinc@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH v4 06/10] ASoC: sun4i-codec: Add DMA Max Burst field
Message-ID: <33f8c68a-d21a-4c04-b7be-adeab520d5c5@sirena.org.uk>
References: <20241031123538.2582675-1-csokas.bence@prolan.hu>
 <20241031123538.2582675-6-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="558g04AZnavlqknE"
Content-Disposition: inline
In-Reply-To: <20241031123538.2582675-6-csokas.bence@prolan.hu>
X-Cookie: Make a wish, it might come true.


--558g04AZnavlqknE
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 31, 2024 at 01:35:32PM +0100, Cs=F3k=E1s, Bence wrote:
> From: Mesih Kilinc <mesihkilinc@gmail.com>
>=20
> Allwinner suniv F1C100s has similar DMA engine to sun4i but it has
> smaller max burst size compared to sun4i. Add a quirk field to
> differantitate between them.

You've not copied me on the rest of the series so I don't know what's
going on with dependencies.  When sending a patch series it is important
to ensure that all the various maintainers understand what the
relationship between the patches as the expecation is that there will be
interdependencies.  Either copy everyone on the whole series or at least
copy them on the cover letter and explain what's going on.  If there are
no strong interdependencies then it's generally simplest to just send
the patches separately to avoid any possible confusion.

--558g04AZnavlqknE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmcjk9gACgkQJNaLcl1U
h9DFuwf/WrEXxsnAh3sDyS+Or2fX9sOWwQ1iCN/IUpg+CS4mWAHnkn8vSvAKQEvk
YIztm/llMpt5Nb4AmUz0BIMECSiIRlBcsT9FhQEdFvR8JFI98AHUfpwkZ/WWihyP
DGLqbnD3tIIU9ZO82mrVY7YS7Mz2meMjPtkhJndkMaWuyV6/65J1HTYn0cySykAZ
wyZtt8fCVufFlcSBO7cH0I5jSxr2dQscSIhjzO9ltJOuVvNgh6eEwH1jiwiRzBXW
uHtoSmqP4a8kutz5pOTatCs6mgBt/zud8Fa0Pf0RjHUk7IVqVYCNo4PDx/bDs9aC
JGaKxTuvIPu1SsxpxRpGJyQAKivOgA==
=uZWg
-----END PGP SIGNATURE-----

--558g04AZnavlqknE--

