Return-Path: <linux-kernel+bounces-336742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B460C984015
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 10:14:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D4D41F24039
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 08:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B28A14A4F7;
	Tue, 24 Sep 2024 08:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="upH3tzoR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0561C32
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 08:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727165642; cv=none; b=dV8vCP2I2sQraF1cubbGnMEcKB1LrvSmDzPgHdi4S8fhG1eMa3DYcUT3R5KWSbPHm1VNGqM74rdwAu4kkqURkXuQotJs9ByXNNy+o8znXrKtc32xHekQ3ADTnPAdnYamKlyp9txueSus1PMem6eFVzgh5DLNjlEHYPrW8iucCdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727165642; c=relaxed/simple;
	bh=8pr9rwGUcErk0NL8euoTFsgHFRvnvjovv9UPeQmYg1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sdq6HfIS5wr2eL2DWiOyW+PGOAG2q6wnqmz44E+5aSTb2UHYICNLA0gw+WnCuooYsw9Gx6MWo0lemMwM3OUuCqK7JkkH1Cd0mlmVDqdWWNDzxyJ/B82fQt++MMcZ+CHrptk6pTz/C6s9AmpwoTOQJFSobrkrrhr8MZOu8JaEyQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=upH3tzoR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F7A2C4CEC4;
	Tue, 24 Sep 2024 08:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727165641;
	bh=8pr9rwGUcErk0NL8euoTFsgHFRvnvjovv9UPeQmYg1o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=upH3tzoRvGSTfA/S3/uoDAri7K5T2HcRtihukbyOp+n2MqV4dyqkp164O/lPIFlXY
	 xQpOW0P/ZrBpF7kAsIEp/7/BNy4RI/f8dsf0BbqeR9+PTGmC0He99RSiZTJw+UdODG
	 3LU8TIAKu5gSihgypekPpJPm4y5QZo0bv6h0RmqbSvW7hRJv00CdXBh08n2yA024nP
	 4CgHFQrK1+Rm4TKM5YfU3OP5CBC+8vYgCB2qV/euwGouy3F2WHS34DALTi1hEZAeN/
	 s8G5hkto6mVx537PRNrMTHSr86kxP5R+fttqdSaGCgUSU+E6uVt21cr/xYc8gnEWoA
	 1GnzCZTasg/Fg==
Date: Tue, 24 Sep 2024 10:13:54 +0200
From: Mark Brown <broonie@kernel.org>
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regulator: do not ignore provided init_data
Message-ID: <ZvJ0wgeztxijv14i@finisterre.sirena.org.uk>
References: <20240920-regulator-ignored-data-v1-1-7ea4abfe1b0a@baylibre.com>
 <ZvF49CZhRc2rrPQ0@finisterre.sirena.org.uk>
 <1jbk0ez546.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bQFZvieR5FOHp+Er"
Content-Disposition: inline
In-Reply-To: <1jbk0ez546.fsf@starbuckisacylon.baylibre.com>
X-Cookie: Editing is a rewording activity.


--bQFZvieR5FOHp+Er
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 23, 2024 at 06:50:33PM +0200, Jerome Brunet wrote:
> On Mon 23 Sep 2024 at 16:19, Mark Brown <broonie@kernel.org> wrote:

> > That probably means checking if regulator_of_get_init_node() can find
> > something and warning if that's the case.

> We could warn if both init_data and desc->of_match are set ?

> Setting desc->of_match is an indication regulator is expected to search
> DT, is'nt it ? Having both set be the indicaction of the conflict.

> Maybe the warn is enough then. Do you prefer if I keep the change of v1
> or drop it ?

Yes, that'd detect problems.  There's some older drivers that don't use
of_match but it'd cover most things quite cheaply.

--bQFZvieR5FOHp+Er
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmbydMEACgkQJNaLcl1U
h9AqCgf/ZH4VYz7Hya9TeVNiqa8uVQ9nq7HiuXUu0YUX63mkKm7Q+q/SKlZnBgfe
sjU5iQFBYO8DHUwe3IyLU6yOu7rBjksO5gBnsyp32MCu18oX5dGmjghEox9YFJns
p2+OrA4LrUOox3xNXCIur+3uLYuodEchA50hLsDORTOYadcC2pvZF3sUYadekZ6i
5WSdSDxfo7f+ZVBStkeWwtrlix8YIYSQ0ApTCl0VIOYZfgf/Ch7webM1owQBMVan
mNJsohmotN3Kk9HxrSW6/AyxLajoXVm6cNzzyP6qMatGeY5ejL+IXMpUAi5Bzu/c
E3MDChHqw23Kd8IT9ggGo9nOh8H0cA==
=rdIW
-----END PGP SIGNATURE-----

--bQFZvieR5FOHp+Er--

