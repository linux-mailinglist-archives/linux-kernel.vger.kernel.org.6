Return-Path: <linux-kernel+bounces-557539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A6D6A5DA87
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 11:37:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B6281887D47
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 10:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EDA323E33E;
	Wed, 12 Mar 2025 10:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pm.me header.i=@pm.me header.b="Em0Z9Wb/"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2BA323C8AB
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 10:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741775857; cv=none; b=unnQAMvJ18uo/gESdq0CsVPWa2IXXnGFxJ/qx1Ry/hE3MJFYcZVondPfZqNgwcb2kH1rHVH2orNRlot4R6yw+MKDe8qyq9ngCIVYHSq4g6unxAKeX94LR2JZHHc+aCwamMBhN2KYmQ4ilWOAkMhaKJl6LViE7ODvNlYfHPk1+ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741775857; c=relaxed/simple;
	bh=iJ4NlzyYcNM12rMMCIVIyvzby6LWOdymnBY0BkuExDM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ucdg/99fjSSnom8QDfjpnp+m8XkLh6MJYs8mgus0Nh9UMfwOu3FhZ91+ltDl+k9NLnYJRfZJp3n5tWh+E1ZUkeM1K0lDWQ6il7OmzHyr0TznIY9DHSi8M8gB5SbkyGW2PXoMv2/iIPdtCjo6nuH6/gEQK+t2slML3qOkMxRtTJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=Em0Z9Wb/; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1741775852; x=1742035052;
	bh=KRHpzm/tg2SHCs5xXakiwO2X7kqF1KvJIrw1VAfxtvE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=Em0Z9Wb/LTthJYVnXSW1JrssH3/A407byAVwcuu2LDuL3yrhjkqLrPtnut10+IPPr
	 U+qxkuZDTxHzXRPMSrcL0+SkGBoPlh/YDQBfX4pEMIVmOrt7SDwEVUhVNQxerLltyy
	 0C6BEhLSmj4rbZypTT0qT8AHU4eAbQj3GGJip2BvPrkhCFl/8zfv/DPpsxkA5/+kzw
	 BsrWpOAYghnwIRx10c7B8NZd+qClGs4R/67HRztHr6X13stpxmkk7pW38Hk+qlSoMi
	 BWkXz+BQOMWvDcqcRYEr1cG1/4dau24LrEc8qFCRfi7lSm6EG1yQD5E4eczkt/f+im
	 RECL5brSZqawQ==
Date: Wed, 12 Mar 2025 10:37:29 +0000
To: Boqun Feng <boqun.feng@gmail.com>
From: Oliver Mangold <oliver.mangold@pm.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Asahi Lina <lina@asahilina.net>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 4/4] rust: adding OwnableRefCounted and SimpleOwnableRefCounted
Message-ID: <Z9Fj5nROnMkj8Oau@mango>
In-Reply-To: <Z88lzDPsO7UStQ85@boqun-archlinux>
References: <20250310-unique-ref-v7-0-4caddb78aa05@pm.me> <20250310-unique-ref-v7-4-4caddb78aa05@pm.me> <Z88lzDPsO7UStQ85@boqun-archlinux>
Feedback-ID: 31808448:user:proton
X-Pm-Message-ID: 8d49b651f9b136c85ccb3250c43af42e28a547bc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 250310 1047, Boqun Feng wrote:
> On Mon, Mar 10, 2025 at 10:57:47AM +0000, Oliver Mangold wrote:
> > +pub unsafe trait SimpleOwnableRefCounted {
>=20
> Can you make this trait as a sub-trait of RefCounted:
>=20
> =09pub unsafe trait SimpleOwnableRefCounted: RefCounted {
> =09    fn is_unique(&self) -> bool;
> =09}
>=20
> ?
>=20

Good idea. Simplifies things. Will do that.

> > +    /// Checks if exactly one [`ARef`] to the object exists. In case t=
he object is [`Sync`], the
> > +    /// check needs to be race-free.
> > +    fn is_unique(&self) -> bool;
> > +
> > +    /// Increments the reference count on the object.
> > +    fn inc_ref(&self);
> > +
> > +    /// Decrements the reference count on the object when the [`Simple=
OwnableRefCounted`] is
>=20
> Should be:
>=20
> "... when ARef<SimpleOwnableRefCounted> or
> Owned<SimpleOwnableRefCounted> is dropped"
>=20
> ?
>=20
> > +    /// dropped.
> > +    ///
> > +    /// Frees the object when the count reaches zero.
>=20
> It may not end up freeing the object, because ARef<..> only tracks the
> Rust side of refcounting, we should avoid mentioning "refcount reaching
> to zero" here.
>=20

This docu will vanish together with the functions, of course, after the cha=
nge
above. One might note, though, that the last comment was a copy-paste from
AlwaysRefCounted (now RefCounted) where it still exists identically.

Best regards,

Oliver


