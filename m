Return-Path: <linux-kernel+bounces-178822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79C158C583C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 16:45:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FDE31C21565
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 14:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A500217BB39;
	Tue, 14 May 2024 14:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BGmWHQIi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5161E487
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 14:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715697931; cv=none; b=oMeqgyXtsgTh2YRXLULZG6y8TV8Ti0Owc4OfLOfglOLLfw9jFU8l+SMrbrKhpUmNzwwf7oWYs1gQJddII0C4w1n8ty+zDnswteSU87pOCQap8Wltr/0xPzl2SrgTiDBapizv0Aj+cBF7/HbZhdhxmyczwZxE1IoyAs3jrr2rZ3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715697931; c=relaxed/simple;
	bh=wzTmRzJutMuitj1ZyyTCjWRU/hDuecvlwjfoxvBzzJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U32iwGpB0SJBV5qKtBcNX9fXKKYRkIRaHzOUIm/cXe9+yDHCzm8EMpFFXOpiBqSsVHRhu7SVAOluqkqwjp84CPtSP+Byk+Fyvfs6DMnv+UFZBb9nplQrv6LC2+iP6eU9seEOWeGW49QSD1TDAvFnWc9HEfabUnNnxdWumXglCp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BGmWHQIi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5018FC2BD10;
	Tue, 14 May 2024 14:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715697930;
	bh=wzTmRzJutMuitj1ZyyTCjWRU/hDuecvlwjfoxvBzzJY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BGmWHQIieVE2KDMVTUWg2LKGRaVwFMaoi1G3oWxRV58XyoKWK6P9sYUiaEf8PItdk
	 MfMArjQiI7Xd3vhA/Of13m0f19rQbs5R86V+fPdJyquNBgCUxfl9Cvz7lOWctuJksI
	 Sb04bSJ7vLGkIpsBXYJWQyjtwi9reEV3hFOSCofIsJJ5CpbTUo/yVSK1WYAOposC6q
	 lXRrLW9GutUgkf0MnCSG+AHV0Xoa78yw3QfiQJetws8/I1s0fj5/W99zmFRH+iPVwS
	 2vk19i4TliOK8yw6a0egdIqc55cFrjhLWXMPcSqHjH0UASF/pZzQFKOdtBkk9tPSry
	 Q2q4S/wb7sXGA==
Date: Tue, 14 May 2024 15:45:26 +0100
From: Mark Brown <broonie@kernel.org>
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
	linux-amlogic@lists.infradead.org
Subject: Re: [PATCH RFC] ASoC: amlogic: do not use dpcm_playback/capture flags
Message-ID: <46daae9b-10dc-4f49-8a25-c387d03ae87a@sirena.org.uk>
References: <87o79azh65.wl-kuninori.morimoto.gx@renesas.com>
 <20240514143116.3824376-1-jbrunet@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3SR10CprQBp87L0m"
Content-Disposition: inline
In-Reply-To: <20240514143116.3824376-1-jbrunet@baylibre.com>
X-Cookie: In the war of wits, he's unarmed.


--3SR10CprQBp87L0m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 14, 2024 at 04:30:46PM +0200, Jerome Brunet wrote:
> dpcm_playback/capture flags are being deprecated in ASoC.
> Use playback/capture_only flags instead
>=20
> Suggested-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>=20
> Following Kuninori's series, dpcm_playback/capture will be ignored.
> However, properly disabling stream direction is important for Amlogic
> audio drivers.
>=20
> I'm not too sure how this should be applied to avoid breaking bisect,
> before or after Kuninori's series. Maybe it should be merged into it ?

Probably better to integrate it I think?

--3SR10CprQBp87L0m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZDeQUACgkQJNaLcl1U
h9Cj2Qf9HLVOdSH5HaXxIypjX5tfpQwLPzkXCL218MMV73bB2xh2jUSxphoymOOH
g/jtFZsI35zWgGd/xrN/JDW03rRJSbdDd+ZnNU+k8Cgvt7IiRG1dI8ZH7LjhDaw2
ufxmUFtogpQOsuF23t1oWroO7Yrd85fnl/yQp53uTfeOqr+3zWGkRjJUxkl39UA1
4zgESYgpKV6HkvjSak9//kWPz9MlIZN1zjiIg7kA4k2Y1+utiPrkE0ysSt0Q8Vbf
jZyNJbacqoEYv2UeukWrsHiw6gqyrA5f8cGC1w6Jw27AScoSDVB2lviUxOMoifL6
R+0iAdSYEauoEee4GA6jE08l4zyBMQ==
=vfji
-----END PGP SIGNATURE-----

--3SR10CprQBp87L0m--

