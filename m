Return-Path: <linux-kernel+bounces-186614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37CF18CC64E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 20:27:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAB0C1F21A08
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 18:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BBD2145B33;
	Wed, 22 May 2024 18:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iLTJUGX3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B718D51E;
	Wed, 22 May 2024 18:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716402420; cv=none; b=ct4exwNZ/d2Bq2818fGRBxvcao6g1AnWcKct6knKgV1eJD7sflTTVHkvQMmIRlrdeKwNz0xVnx4mqgT9TeIcs4aPkkwEKJshjh003p5SjvYz4zpnWCZcVrh9u5F+UNs21hRl0fNMPGkoZszTv0xKkJ3OV7h0NIttWZklhutK/hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716402420; c=relaxed/simple;
	bh=6TjRp44/5yttUKhYEKEOpP4vhcfVOGvGpjaQvSnlrVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qnf2c1YmVV0UGb6677s6apZU/q7IAVDpZRXYLIG2RqlGY1Ui7nMYl5gjIeZRfedor+/xBO4EN/uPBBxN/RUIf5/LleIJpMVnVfgrLs7OXgEzVQEkd4iGpKSoEixQCdmwZ568BLJNlXrlXrHph5Php90YB9wTmq6X+QD3IZ85gjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iLTJUGX3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6100EC2BBFC;
	Wed, 22 May 2024 18:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716402420;
	bh=6TjRp44/5yttUKhYEKEOpP4vhcfVOGvGpjaQvSnlrVo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iLTJUGX3868LPM8o5ryPUtjvM3WFmliDpMHMAXs4FjniRV3Y4tICOB/704yC6Gxtc
	 qgvbja1zxqdtwFLnpyl7oNkSICh487WTXZYJBf90tzpciVkiL1oz93opIWw8bCkj5t
	 QbMHWYZWemeX/0s/AzrIFVWMM/m0/SkAOU9zJp8xoFfLBD3hlqs3V199/R28XAtUS2
	 o402M3g6mlTbvB9wB72xpMPZq+lsYfLeGEFR8s6lIsv3pn+yc7H1pDrF2LLK2ruy2E
	 8vs6esC6d8eZLG/o0H9nRb9Ns4dsKobQCddcYGc9LAL9TiStKLNUPXcLD8GpJN2W0E
	 ovQTQV1YCZbIQ==
Date: Wed, 22 May 2024 19:26:55 +0100
From: Conor Dooley <conor@kernel.org>
To: Kanak Shilledar <kanakshilledar@gmail.com>
Cc: Kanak Shilledar <kanakshilledar111@protonmail.com>,
	Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Samuel Holland <samuel.holland@sifive.com>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 0/2] dt-bindings: interrupt-controller: riscv,cpu-intc
Message-ID: <20240522-customs-jaws-d0c792b274b4@spud>
References: <20240522153835.22712-1-kanakshilledar111@protonmail.com>
 <20240522-yoga-blurt-dc5e40a0ae3a@spud>
 <CAGLn_=vfnQrNh63jWtUCojONAYqX3dm6qnXgA--Zi1KQ0P0o-A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="TFXhTa38hHk0eS3i"
Content-Disposition: inline
In-Reply-To: <CAGLn_=vfnQrNh63jWtUCojONAYqX3dm6qnXgA--Zi1KQ0P0o-A@mail.gmail.com>


--TFXhTa38hHk0eS3i
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 22, 2024 at 10:11:20PM +0530, Kanak Shilledar wrote:
> Hi Conor,
>=20
> On Wed, May 22, 2024 at 9:34=E2=80=AFPM Conor Dooley <conor@kernel.org> w=
rote:
> >
> > On Wed, May 22, 2024 at 09:08:34PM +0530, Kanak Shilledar wrote:
> > > This series of patches converts the RISC-V CPU interrupt controller to
> > > the newer dt-schema binding.
> > >
> > > Patch 1:
> > > This patch is currently at v3 as it has been previously rolled out.
> > > Contains the bindings for the interrupt controller.
> > >
> > > Patch 2:
> > > This patch is currently at v2.
> > > Contains the reference to the above interrupt controller. Thus, making
> > > all the RISC-V interrupt controller bindings in a centralized place.o
> >
> > Don't do this, it breaks tooling:
> >
> >         b4 shazam 20240522153835.22712-2-kanakshilledar111@protonmail.c=
om
> >         Grabbing thread from lore.kernel.org/all/20240522153835.22712-2=
-kanakshilledar111@protonmail.com/t.mbox.gz
> >         Checking for newer revisions
> >         Grabbing search results from lore.kernel.org
> >         Analyzing 3 messages in the thread
> >         Looking for additional code-review trailers on lore.kernel.org
> >         Will use the latest revision: v3
> >         You can pick other revisions using the -vN flag
> >         Checking attestation on all messages, may take a moment...
> >         Retrieving CI status, may take a moment...
> >         ---
> >           =E2=9C=93 [PATCH v3 1/2] dt-bindings: interrupt-controller: r=
iscv,cpu-intc: convert to dtschema
> >             =E2=9C=93 Signed: DKIM/gmail.com
> >             + Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> >           ERROR: missing [2/2]!
> >         ---
> >         Total patches: 1
> >         ---
> >         WARNING: Thread incomplete!
> >          Base: using specified base-commit 20cb38a7af88dc40095da7c2c909=
4da3873fea23
> >         Applying: dt-bindings: interrupt-controller: riscv,cpu-intc: co=
nvert to dtschema
> >
> > If you change one patch in a series, the whole series gets a new versio=
n.
> > Just let git format-patch do that for you with the "-v N" argument and
> > you'll not have to worry about breaking people's tooling.
>=20
> Sorry for the tooling breaking. I used the "-v N" argument to make the
> v2 patches but I bumped up the "riscv,cpu-intc"patch
> to v3 due to it being in v3 already and it gave errors in the previous
> patchset and you mentioned that I missed the v3 in subject line.
> How shall I proceed with this version mismatch? Shall I make the
> patchset as v3 and have both the patches at v3?

I would make it "RESEND v3".

> > Patches themselves are
> > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
>=20
> I shall include this in my commit message. Is it required to bump the
> version of the patch just for the reviewed flag?

Usually there's no need to resend patches for tags alone. Some people
treat tag-only resubmissions as a "RESEND vN" and others as "vN+1". The
latter is less likely to upset anyone.

Cheers,
Conor.

--TFXhTa38hHk0eS3i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZk447wAKCRB4tDGHoIJi
0tDmAQDppLY/t7sUt1v1hsx+ZW0rob6GusyQlodM3Y8Vtby7owEAqwNrm7dtUjb9
76loQdmxiWzfyhx4a6tq85+Nihcxow8=
=cqmE
-----END PGP SIGNATURE-----

--TFXhTa38hHk0eS3i--

