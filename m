Return-Path: <linux-kernel+bounces-343297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0D0898994B
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 04:42:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E00F282A6B
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 02:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60CCD2BB1B;
	Mon, 30 Sep 2024 02:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="RfuJC3qW"
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EFD411CA9;
	Mon, 30 Sep 2024 02:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727664112; cv=none; b=bMsKAJ2ABVoWu+zODHYGsKirTzYVWKDcggwuDxZJ2CFM84QlUpwd4Py9SKZdu/BeQcEx6bKDhMuP4qULEywprp7n74MkY9IS4BURTB6D1b4u2HPA6tI5mySlOWNjMWDYLHCSkyXc+NRh3VDiRLwCwcDLaKBcGa8HZEaP2Qc8bCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727664112; c=relaxed/simple;
	bh=OMkaXU6oEvpew8BeISsKzQVAsiKgDnlX8Ng+6JS2jRo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tdshcITNNxQrY5vtazg/yOj+hsxL1ALW+DzOO23wC3AednouBG5YFcyU6h98c15mx/GjytAW/P9M/fO1Ml+Cgzer82916v7g0Xr7YSLYFlgZfhDSBs3ddtOQ2XMKQbtI45lMBuuyohw7HYHKqrOFreDeI3b/z3AGmOtycSL/7yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=RfuJC3qW; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1727664107; x=1727923307;
	bh=OMkaXU6oEvpew8BeISsKzQVAsiKgDnlX8Ng+6JS2jRo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=RfuJC3qWWQtOrBRA/dk+3Z8PZ7QU2pyxNRxlODW74irsb9zAO3gneKKWc9inHJa+c
	 XONFmCU7yV+WGG4THM/2pEl2OiyO05it3aSlCqu1e1lXEmaS40pMb1Mny9qMo/o3Ro
	 8CGb7xYfuOJDwDXTV+JJha8GDlzVG8Cwsr0OhPt8bdECPerk44qfVH4UyGFVne1Aps
	 +f8ru1kYEYmiNwUKZAjRXDugnVmnpaDNqoLEJDt51KeUBUDISS0HGgK7hAnh9hcMBL
	 nxQKNt1/Sq+ltNPGmU3WUuATEUT6qSDEn8i0src2ae0n+7e8OqpICdeDj+KLZMKMKS
	 /UK46jvBU6a2Q==
Date: Mon, 30 Sep 2024 02:41:42 +0000
To: Trevor Gross <tmgross@umich.edu>
From: Patrick Miller <paddymills@proton.me>
Cc: Hridesh MG <hridesh699@gmail.com>, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>, Dwaipayan Ray <dwaipayanray1@gmail.com>, Lukas Bulwahn <lukas.bulwahn@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>
Subject: Re: [PATCH v3 2/2 RESEND] checkpatch: warn on empty rust doc comments
Message-ID: <67il2JOf-dSurc3O-294W5k5mS-kf1FtFxKzXlxHHykGmIvIkfPel_pPe2LGX04HSnTg85LwEdU4Zz2VCrfXgIl5KVItUm5vPhbtkThc3BM=@proton.me>
In-Reply-To: <CALNs47vT=g2D7A_cDq_8F2xJRJTK-7KtQY4brFYfkopyCSjLTw@mail.gmail.com>
References: <dbb63b5698aa507bbe3dec54b4458a3f151899d3.1727606659.git.hridesh699@gmail.com> <bf6544faba2b53ce901b2e031f3d944babcc7018.1727606659.git.hridesh699@gmail.com> <CALNs47vT=g2D7A_cDq_8F2xJRJTK-7KtQY4brFYfkopyCSjLTw@mail.gmail.com>
Feedback-ID: 45271957:user:proton
X-Pm-Message-ID: 6a2958af5e6234924f21848db5597bf6c7ed7c9e
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha512; boundary="------0f27110d2891e59ad77340885fda273389ec8ae54bb38c36f65c1fee007b9615"; charset=utf-8

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------0f27110d2891e59ad77340885fda273389ec8ae54bb38c36f65c1fee007b9615
Content-Type: multipart/mixed;boundary=---------------------78321cd4c36527eeab5ecdb9fa40f5a1

-----------------------78321cd4c36527eeab5ecdb9fa40f5a1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;charset=utf-8






On Sunday, September 29th, 2024 at 6:15 PM, Trevor Gross <tmgross@umich.ed=
u> wrote:

> =


> =


> On Sun, Sep 29, 2024 at 7:16=E2=80=AFAM Hridesh MG hridesh699@gmail.com =
wrote:
> =


> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > index 39032224d504..c75bc3927bf6 100755
> > --- a/scripts/checkpatch.pl
> > +++ b/scripts/checkpatch.pl
> > @@ -3884,6 +3884,13 @@ sub process {
> > }
> > }
> > =


> > +# check for consecutive empty /// lines in .rs files
> > + if ($realfile =3D~ /\.rs$/ &&
> > + $rawline =3D~ /^\+\s*\/\/\/$/ && $prevrawline =3D~ /^\+\s*\/\/\/$/) =
{
> > + WARN("RUST_DOC_EMPTY",
> > + "avoid using consecutive empty rustdoc comments\n" . $herecurr);
> > + }
> > +
> =


> =


> We got a request to add a rust-specific block in another patchset [1].
> It would probably be good to coordinate here and have a patch adding
> an empty block, to be used by both of these changes.
> =


> [1]: https://lore.kernel.org/rust-for-linux/a9112679-b251-4b98-b55e-e8aa=
bf82ad46@proton.me/

After the latest revision of my patch [1], I split the if statement so tha=
t
there is a parent check for rust files for future rust patch checks. So,
this would perfectly fit within that block.

Do you want me to add your code and credit you in my patch? =



[1]: https://lore.kernel.org/rust-for-linux/20240914181618.837227-2-paddym=
ills@proton.me/
-----------------------78321cd4c36527eeab5ecdb9fa40f5a1--

--------0f27110d2891e59ad77340885fda273389ec8ae54bb38c36f65c1fee007b9615
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wnUEARYKACcFgmb6D90JkJtRGrsur54RFiEE3KdIkSvUnCve801mm1Eauy6v
nhEAAMJGAQD96K2c0pWDa2lJoXBkFXj4FTikZ07unMXeoVmkNdxayAD/eCvA
EqK+JCgcrsPNXZAab2ICiDBLbEMvHX+Sl499OAg=
=fP/8
-----END PGP SIGNATURE-----


--------0f27110d2891e59ad77340885fda273389ec8ae54bb38c36f65c1fee007b9615--


