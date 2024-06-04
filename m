Return-Path: <linux-kernel+bounces-201107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D27D8FB998
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 18:53:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 332E01F263B0
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 16:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADC79149003;
	Tue,  4 Jun 2024 16:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N0gZLT/S"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF97148828;
	Tue,  4 Jun 2024 16:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717520030; cv=none; b=IwnoZCGV7zLjPqwTmkL3c7LMoZnktSwBwLMsO/XvblVt2iJG6Kesp3pYaCZr+aSiqxWikObyDySh0YxyysEsO/OmYZ9nMNYZhecXQs2XrgdeKUvbXpJPDGJ9FdCQMlcqHoNOMDJUNmpLQhNbIEtdlwvTgrRXfSitrAM5YBog0aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717520030; c=relaxed/simple;
	bh=3y3SJEQnabNC/ZTOS/h9D5v1FyvFsvGwCvIleX2IRlc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j4Fytr99u7m8XqkdP39ZaMBsZKe0tB4Y+Brz3djxAPJ7w06BqofNMMbqW/X6to4mzuq3ran/peh7ZQTmoS7h2h+y2bCByW77szcC5Ft9RfX2y3sl9Y3IgwmUOOyq1N0q9gd1y8b11ZHIb7YUfg0ZzikVHRhYWf7hSA0CK0pI7cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N0gZLT/S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D85BC2BBFC;
	Tue,  4 Jun 2024 16:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717520029;
	bh=3y3SJEQnabNC/ZTOS/h9D5v1FyvFsvGwCvIleX2IRlc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N0gZLT/SrbxinE5aaiPs1SfqHUfMda+zbnhDDYSVPrNZ4M0MZlKrV/z3k+CxJimpL
	 0KfQFAd9R3KNNw6P/82BDLEju2yrNKiH/kjFZBDr8TzJKrOfnFo8IxzwF6qWDzGzAa
	 gTZOnG3n6vezz58qmsQsBjHDpKOBA3HBfV5V+0E1C0HZ4dP8gtziI9YK+hqfSoTitm
	 3Pe9NWYCHmflyJqtMODczgp6rb6Q+nKX5N+RnsbucFMgR9IjOsDm7vXXZM/zWG6A1N
	 kBEKmxXQRuEQukrZ7KJTTs95LdPfj6MMpq/mZTaFFrhtffVjtlssquhEOp6g4+BOIK
	 RDF+NZEh4yMUg==
Date: Tue, 4 Jun 2024 17:53:44 +0100
From: Conor Dooley <conor@kernel.org>
To: David Abdurachmanov <david.abdurachmanov@gmail.com>
Cc: Xingyu Wu <xingyu.wu@starfivetech.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Hal Feng <hal.feng@starfivetech.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v5 0/2] Add notifier for PLL0 clock and set it 1.5GHz on
Message-ID: <20240604-defame-common-b0e056562303@spud>
References: <20240507065319.274976-1-xingyu.wu@starfivetech.com>
 <20240510-unfounded-syrup-d1263d57d05a@spud>
 <NTZPR01MB0956D48361098E8AA4B3930A9FE02@NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn>
 <20240511-unbiased-dainty-ccb5ece9b1b9@spud>
 <NTZPR01MB0956A7393097129D3CD048EB9FE32@NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn>
 <20240514-congenial-smother-1e4b0fc6a5df@spud>
 <NTZPR01MB0956CF1AA9EA5A20A174FD8A9FEC2@NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn>
 <20240515-reorder-even-8b9eebd91b45@spud>
 <CAEn-LTrKn079kbs2Wx5AuTs5+_sB4zaJsTf=MKn_nZZL04E5gA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="R3Sbf+JjNJ+j7/EU"
Content-Disposition: inline
In-Reply-To: <CAEn-LTrKn079kbs2Wx5AuTs5+_sB4zaJsTf=MKn_nZZL04E5gA@mail.gmail.com>


--R3Sbf+JjNJ+j7/EU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 04, 2024 at 12:45:48PM +0300, David Abdurachmanov wrote:
> On Wed, May 15, 2024 at 7:31=E2=80=AFPM Conor Dooley <conor@kernel.org> w=
rote:
> >
> > On Wed, May 15, 2024 at 02:23:47AM +0000, Xingyu Wu wrote:
> > > On 15/05/2024 02:08, Conor Dooley wrote:
> >
> > > > There's a push in U-Boot to move devicestrees to use "OF_UPSTREAM",=
 which
> > > > means importing devicetrees directly from Linux and using them in U=
-Boot. I
> > > > don't really want to merge a patch that would present U-Boot with a=
 problem if
> > > > the VisionFive 2 moved to that model there.
> >
> > > Would it be better  if I  change the rates of PLL0 and CPU core in th=
e driver not dts,
> > > and avoid the dts of Linux and U-Boot being different?
> >
> > I'd definitely prefer if we don't include stuff in the kernel tree that
> > would cause problems for U-Boot if imported there, yeah.
> >
>=20
> What is the current state of this patchset?

v6: https://lore.kernel.org/all/20240603020607.25122-1-xingyu.wu@starfivete=
ch.com/

Guess it didn't go to the riscv ml because the dts patch was dropped.

> I noticed this patchset on the U-Boot side from Hal Feng:
> [PATCH v1 0/4] Sync StarFive JH7110 clock and reset dt-bindings with Linux
>=20
> It seems to indicate that there is WIP for OF_UPSTREAM support.

And as a commenter on that patchset you reference said, they should
actually use OF_UPSTREAM directly rather than manual syncs like that
series. I'm not sure how the U-Boot folks want to address that w.r.t.
bisection though, in cases like this where the defines do not have
identical names.

Thanks,
Conor.


--R3Sbf+JjNJ+j7/EU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZl9GmAAKCRB4tDGHoIJi
0k+GAP96lINbMq1W/A4BwbQPVG0viC6vHyo3x/Ar2htPOhhfswD/SrQ1lr3v7H6N
VcjSz+tSQvfbcga97HxKDA4tgz3kQg0=
=58JS
-----END PGP SIGNATURE-----

--R3Sbf+JjNJ+j7/EU--

