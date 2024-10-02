Return-Path: <linux-kernel+bounces-346926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5842B98CB1A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 04:17:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17399286237
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 02:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7D3A9450;
	Wed,  2 Oct 2024 02:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="KlYgkNSi"
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1F579E1
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 02:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727835445; cv=none; b=k5c6HE6nM0PN/oxwXPCUeKvzKjcT2frVlfU60u2kb+FSfzcgWbD8njoY5ETJcsq82fEggPzVW3w7XLxPQZFAjrI3Jm5sNmj9Anzbpc/3fi4Y3X7rbVjDJo5OVczg7k+770u00nnw2KM+lwZ0aDFMesGxqFw6xh6hRqpKYZqzt3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727835445; c=relaxed/simple;
	bh=2gjiiAewp7ifne2STDdDKuouTm98qn+k93uMQwvotGk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TYe93t2sKuxaNTo7yojxEENlPFvHa6cUOQUWmhy3zIolKUBUqWXGvqTvy4E4zKeqJfJfxxf+6E3oS6KeehIie4K7z3DRh1+M3lFYOd9/cE8AKqbHhxznu53C5CvjqArkfLK/0pi30PRMxnlB8jVLMXA1lcMVqKbWS94WKWb3eCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=KlYgkNSi; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1727835436; x=1728094636;
	bh=ODUjzTitlDnZ7cX13Tfv6e9WF1sDadVWp4nHV0f82Rk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=KlYgkNSiWM0NLjnmhF7CUx7aMIK2tK6+SaDSKaZ/EItj3+1aCDU8JVWVJyWhy7s14
	 QXIx5cgvMdixqe68C7NsUN0iWkOnb78JMeSTL9Nd/e0n9ygHb9ZRN16pRVLtrNKpGY
	 lGSIUnX7raJQSnKpR9LJ6u1VczlxrZAm0ugtfoNkczLjqW1upDCeyoYvZ2Lt0cvezc
	 IPJqhbqnrpqLA14Mpp6JmEEUFdraJpqsy3ZbffrNxdXa1k2VY7hW76vPQyCKkoIMXS
	 5WqkrtzAP/gGSeteESb2uEh8zP+pPo6QAfM6e0eUlizwtrk60QoN77KfUnEThf0tus
	 iUnpP7rf9ST+A==
Date: Wed, 02 Oct 2024 02:17:08 +0000
To: Hridesh MG <hridesh699@gmail.com>
From: Patrick Miller <paddymills@proton.me>
Cc: Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>, Dwaipayan Ray <dwaipayanray1@gmail.com>, Lukas Bulwahn <lukas.bulwahn@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, linux-newbie@vger.kernel.org
Subject: Re: [PATCH v3 2/2 RESEND] checkpatch: warn on empty rust doc comments
Message-ID: <t5SyWXgKghM_fSdMQNH3tTuqZKJck9qMTeUJUWzCWphs_cc7cocnj1gO5cCh0pzzVTCQbEBRqOsYC0om9JIOatBKU3AcoEyFwySAK6B1_Cw=@proton.me>
In-Reply-To: <CALiyAo=udy-P4ki1-_CAk7bHWfAjoioYEZ_ah+i6DJZ0MmmCQg@mail.gmail.com>
References: <dbb63b5698aa507bbe3dec54b4458a3f151899d3.1727606659.git.hridesh699@gmail.com> <bf6544faba2b53ce901b2e031f3d944babcc7018.1727606659.git.hridesh699@gmail.com> <CALNs47vT=g2D7A_cDq_8F2xJRJTK-7KtQY4brFYfkopyCSjLTw@mail.gmail.com> <67il2JOf-dSurc3O-294W5k5mS-kf1FtFxKzXlxHHykGmIvIkfPel_pPe2LGX04HSnTg85LwEdU4Zz2VCrfXgIl5KVItUm5vPhbtkThc3BM=@proton.me> <CALiyAo=udy-P4ki1-_CAk7bHWfAjoioYEZ_ah+i6DJZ0MmmCQg@mail.gmail.com>
Feedback-ID: 45271957:user:proton
X-Pm-Message-ID: 24652b6518865115bb25c5b18c0d58ebf6a8b891
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha512; boundary="------6e9c0b4724622ca2873f2dc07faaadd38d4565d60e5b04cb49ae2ce015d54162"; charset=utf-8

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------6e9c0b4724622ca2873f2dc07faaadd38d4565d60e5b04cb49ae2ce015d54162
Content-Type: multipart/mixed;boundary=---------------------808725a943ee40242c6bec3ccc1f694e

-----------------------808725a943ee40242c6bec3ccc1f694e
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;charset=utf-8






On Monday, September 30th, 2024 at 6:34 AM, Hridesh MG <hridesh699@gmail.c=
om> wrote:

> =


> =


> On Mon, Sep 30, 2024 at 8:11=E2=80=AFAM Patrick Miller paddymills@proton=
.me wrote:
> =


> > After the latest revision of my patch 1, I split the if statement so t=
hat
> > there is a parent check for rust files for future rust patch checks. S=
o,
> > this would perfectly fit within that block.
> > =


> > Do you want me to add your code and credit you in my patch?
> =


> =


> Please disregard my prior email, I had failed to CC everyone. Since
> the change is small I'm okay with adding it as part of your patch,
> please do add the Co-developed-by tag, thanks!
> =


> However, I was curious how conflicts like these are generally
> resolved. For example, if there are two large patchsets which conflict
> with each other, how does one ensure that they are compatible, and
> even if they are, how do the maintainers ensure that they are applied
> in the correct order?

2 changes that I am making to your patch as I merge it with mine (I tested=
 these)
  - Added a @fix option. I ran into this with my patch and was requested t=
o
      add it by a checkpatch maintainer
  - Revised your $prevrawline regex to check against existing blank lines =
as
      well as added blank lines (made the leading + optional). Otherwise I
      think the checkpatch would not match against a blank doc comment lin=
e
      added after an existing blank doc line.
-----------------------808725a943ee40242c6bec3ccc1f694e--

--------6e9c0b4724622ca2873f2dc07faaadd38d4565d60e5b04cb49ae2ce015d54162
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wnUEARYKACcFgmb8rRoJkJtRGrsur54RFiEE3KdIkSvUnCve801mm1Eauy6v
nhEAAMF4AQCLWQUOtp5+mg3j/o0JBoheDulcy8I2mrzVF4W5OOon7wEAyCOW
8Mi39DzrVpDEkeJEblr54UfE2ssXM7l+bTbw1g4=
=Z2AR
-----END PGP SIGNATURE-----


--------6e9c0b4724622ca2873f2dc07faaadd38d4565d60e5b04cb49ae2ce015d54162--


