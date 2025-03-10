Return-Path: <linux-kernel+bounces-553615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E4E6A58C7C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 08:08:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45BC2168AA8
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 07:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF6691D5AB2;
	Mon, 10 Mar 2025 07:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pm.me header.i=@pm.me header.b="Ji6vrPU1"
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0121B87F0
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 07:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741590506; cv=none; b=DZem1L68zoFt0KDpkkkv8JCGHAn91nrG5bIhpALAmfDQL13QyqwSKyfzKqgOTzP+4L1HaVy18f8QC8zkEM/T8qicfybyHAu3wbydqZjPR/2yFQm8LBj65UCrnnPzxsblG5MO1BseFkLIqnU85DgIYFg3DmKKHUBBNiN1wtJHY5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741590506; c=relaxed/simple;
	bh=6B74n54L0OLrQUM+Vrhw7S07jKzBIU3wGOAYittwqG0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qi3ErwvI5nr2xOg9JOtZIxXhJghLf8Ux5bwz71iS0Mqmr4bSzm8Qc1z05xUaZb7e+KGwzshL8iweiYd2BTDr14vU6Kbtiu4/K41CuPW3q7s3xbvK5S1N2ACIinEeLdpLiMLEUKm8ZKMtjk+nSGqhk8EmJ/7kwESnCnC6mpOcmjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=Ji6vrPU1; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1741590497; x=1741849697;
	bh=uZQR/LswmrhhHbjTIDCiVfu+7bsoBcpECbqnnNT4gss=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=Ji6vrPU1aAepEcylsuqCepUtiLhh7Tt9vQ9WpH0oGa3DSLwdvJG3l0WDyIOAdyd8a
	 ru27w7h898KNY2y1SeiieRXGRAxMczZqZHW/BBXRtTkBj/+srLPfI2Icw8ze/DEUVZ
	 Rj4HRZQVVUvlVLbD2IxbswF54DKfT0lELA795xJLZLvaC6SJUH3dUBn7/8F3R3u3Db
	 UxnkTnrPBcPTb5qOFzhpiC7ROtYGXdf9VzNLnzeQXko9woJgKKCPLpX7tlY1DBPhbJ
	 xMdyXe0PhDMrbW2+URV4lFoF5SCwBpWye+DgdnRQZi59TNMGRJKkI9fVpSQjmmE4HH
	 gs9kGw0q9EmJg==
Date: Mon, 10 Mar 2025 07:08:12 +0000
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
From: Oliver Mangold <oliver.mangold@pm.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Asahi Lina <lina@asahilina.net>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 4/4] rust: adding OwnableRefCounted and SimpleOwnableRefCounted
Message-ID: <Z86P1Er_D8UACOQ9@mango>
In-Reply-To: <CANiq72mYfhuRWkjomb1vOMMPOaxvdS6qjfVLAwxUw6ecdqyh2A@mail.gmail.com>
References: <20250307-unique-ref-v5-0-bffeb633277e@pm.me> <20250307-unique-ref-v5-4-bffeb633277e@pm.me> <CANiq72mYfhuRWkjomb1vOMMPOaxvdS6qjfVLAwxUw6ecdqyh2A@mail.gmail.com>
Feedback-ID: 31808448:user:proton
X-Pm-Message-ID: 372f259ac21f4f3779160097243e7ecb6bd0a30a
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 250307 1416, Miguel Ojeda wrote:
> Hi Oliver,
>=20
> Some general style nits for this and other series you may send in the
> future (not a review). Please note that most may apply several times.
>=20
> On Fri, Mar 7, 2025 at 11:04=E2=80=AFAM Oliver Mangold <oliver.mangold@pm=
.me> wrote:
> >
> > Types implementing one of these traits
> > can safely convert between an ARef<T> and an Owned<T>.
>=20
> The wrapping is strange here, and it also happens in your code
> comments. Please use the same width as the rest of the code in a file
> etc.
>

Sure, I can change that, no problem. Just to explain, I didn't give that
too much thought. I just tried to stick to the 100 chars max length.
I think I tended to try to split lines at places where it fits the
sentence structure to improve readability, but I guess you are right,
using up the maximum space is easier to the deal with

> > +/// - The same safety requirements as for [`Ownable`] and [`RefCounted=
`] apply.
> I wonder if we should expand/inline them, even if they come from the
> supertraits.
>

I tried to avoid copy-paste, but I can do if it is generally preferred.
Or can rustdoc include sections?

> > +/// - the uniqueness invariant of [`Owned`] is upheld until dropped.
>=20
> Please use uppercase to start sentences.
>

Ok. I think I mostly did, but seems I missed a few.

>=20
> "same" sounds like no extra requirements -- what about something like:
>=20
>     The safety requirements from both [.....
>

> > +///         // Use a KBox to handle the actual allocation
>=20
> Please use Markdown for comments too, and period at the end (also for
> "SAFETY: ..." comments).
>=20
> > +/// // SAFETY: we implement the trait correctly by ensuring
>=20
> There is no need to say "we implement the trait correctly", i.e. the
> `SAFETY` tag is enough to introduce the comment; the same way we don't
> say "SAFETY: the following unsafe block is correct because ..." etc.
>

> > +///     }
> > +///     fn is_unique(&self) -> bool {
>=20
> Newline between items.
>=20
> > +/// let foo =3D Foo::new().unwrap();
>

> In general, we try to avoid showing patterns that people should avoid
> when writing actual code (at least in non-hidden code) -- could we
> avoid the `unwrap()`?

Sure, I will fix all of the above in the next release.

> > +// TODO: enable this when compiler supports it (>=3D1.85)
> > +// #[diagnostic::do_not_recommend]
>

On 250309 2247, Miguel Ojeda wrote:
>=20
> Oliver: I am sending a quick patch explaining this -- please feel free
> to pick it up in your series.

Thanks. I agree it is better not having to change this after compiler upgra=
de.

Best regards,

Oliver


