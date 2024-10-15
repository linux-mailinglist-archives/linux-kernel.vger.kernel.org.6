Return-Path: <linux-kernel+bounces-366331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6B2C99F3E8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 19:19:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B9D92815B9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 17:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A5841FAEF4;
	Tue, 15 Oct 2024 17:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z4ZvLcB4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C421FAF1F;
	Tue, 15 Oct 2024 17:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729012765; cv=none; b=tesfC382MlMo4tKJqjUPWguk5ZXIzHa2ScLeoDt14SvJMAZtB0i3pz5wEBGcnIkOeYe9lGK3b4wVS3u3ZSbVjUkivKIdWskwy5QdlDj2yUJU4Oag6YnAeDE5oA7IQHzXm4l9GkK7Pu42ZDKha6PDytRLWuSq322brm5GKSt7pUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729012765; c=relaxed/simple;
	bh=FhkbhlgNxWEmO+oPRyTU6uVeuYw5m/gMtNzAr+fT0u0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hz3PMcIHCfGaytbEfpVc9XVys1To95cAlEeZaai6Mv+DsnI4ok50Sphw9w/IUzZzmtHS9oY9yV1Ti3JDMPVIf7x9XW23uxTL4kOrJ9N3xVtpdF8Vj99y6T7ASGNMRtV50PViseH8CU/YEXfKyQgMbX+3msnU1upBq9+/NPHjUmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z4ZvLcB4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CADEC4CEC7;
	Tue, 15 Oct 2024 17:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729012764;
	bh=FhkbhlgNxWEmO+oPRyTU6uVeuYw5m/gMtNzAr+fT0u0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z4ZvLcB4rzhfcEMm/U9LacCQopKJrXmaFY7/0vZ7NnfOSW3gBDltxBAgVu0rU9a5/
	 wog0LZiXa9ccbp0RhgsQ2eAzOvfB6Z0xqia4uR5MEPsKHCCgsZh0NLmltsLeqf8YXX
	 BgLIW4Ma8EeUxls6ZHjQnDWtSOIOjMV/VSaGCX8hZ5bMnv2TgOwpO+sc8vQyh67emF
	 seTwrtpPmrXqqtZw7JBKeU7Le3OaQVlTpzYrH20rCKn6iG6Eu7ZwwUbj/1GGhwX7q8
	 L66WGygvbv37g4aV1tGN75PYJk8rtm8ZC0ciVoBzf16imH0eF+9/OMT6LLn7nLKUVP
	 oINQnr6t+AYQg==
Date: Tue, 15 Oct 2024 18:19:19 +0100
From: Conor Dooley <conor@kernel.org>
To: Drew Fustini <dfustini@tenstorrent.com>
Cc: Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Drew Fustini <drew@pdp7.com>, Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>, Linus Walleij <linus.walleij@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Thomas Bonnefille <thomas.bonnefille@bootlin.com>,
	Kanak Shilledar <kanakshilledar@gmail.com>,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/8] riscv: dts: thead: Add TH1520 pin controller support
Message-ID: <20241015-thriving-dizzy-4708ff6b6ebe@spud>
References: <20241014-th1520-pinctrl-dts-v1-0-268592ca786e@tenstorrent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7eHvARJ0qZ9bqrij"
Content-Disposition: inline
In-Reply-To: <20241014-th1520-pinctrl-dts-v1-0-268592ca786e@tenstorrent.com>


--7eHvARJ0qZ9bqrij
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 10:54:17AM -0700, Drew Fustini wrote:
> This series of device tree patches enables the TH1520 pin controllers on
> the BeagleV Ahead and Lichee Pi 4A boards.
>=20
> Patches 1-7 have all been cherry picked from esmil's th1520 branch [1].
> They do not have the issues pointed out in the previous series [2] that
> I sent out which contained out dated versions of the patches.
>=20
> The final patch was suggested by Emil as there are not currently any
> users of the spi0 node so there is no need to enable it in the board dts
> files.
>=20
> I have tested on the BeagleV Ahead and the LicheePi 4A. The leds on the
> BeagleV can be controlled as expected through sysfs.
>=20
> [1] https://github.com/esmil/linux
> [2] https://lore.kernel.org/lkml/20240930-th1520-pinctrl-v3-0-32cea2bdbec=
b@tenstorrent.com/

btw, this should have continued the version numbering from [2] and been
v4

--7eHvARJ0qZ9bqrij
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZw6kFwAKCRB4tDGHoIJi
0iKiAP9mkgOWt54JWWibeBYm9kQHvB+cdUrB5/JTwwsTV4QJ6AEAtT6lhapsuR6A
c3DRBdDzUaomKNpiObcWJE5ZXd49DQQ=
=bgwm
-----END PGP SIGNATURE-----

--7eHvARJ0qZ9bqrij--

