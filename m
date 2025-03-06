Return-Path: <linux-kernel+bounces-548606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12406A546E2
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 10:52:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1DA817529D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 09:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 946D920B7F8;
	Thu,  6 Mar 2025 09:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CIwIdO1W"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E558920E037;
	Thu,  6 Mar 2025 09:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741254542; cv=none; b=nKCmIBMHVbSUvxFjdltpTYiRlRfyyTxancQOU/UMuXjEJGIjFNu+7IxUzXR1yhGJZ3m7QFdFNWBLpO0Y8kY8MA0F5wiJMCx7nBQRYaBqbtNm2CnHsODkBkkFuQFwVxN2m1gOXbThWgbcwET5mgPNEjqXaBu4/KeiQ0colvAts3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741254542; c=relaxed/simple;
	bh=+h2ps//W/d4AsThHf884SeSupc3zB2T3LQHMiaaH//8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PsucuNU0DhCw+wncllLmGZI6zB++1GpPSxp8OZdiCmAIE+2LuPA1+OJW2NLoT1J9L1IEOX3/H42EXSmojTyunq0QOYSHsDdxchXAU+DaErx5ietyzXpZyPGbeutY4NNwmQEnY1Ij5lduNidNRndwTzmoIDyAqe/bTVQ72TfN6mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CIwIdO1W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 007BDC4CEE4;
	Thu,  6 Mar 2025 09:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741254541;
	bh=+h2ps//W/d4AsThHf884SeSupc3zB2T3LQHMiaaH//8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=CIwIdO1WzFl9GNhrcfa2ixHKiI0eJYRLujuLouXciNORZC9oCeH7sUHSrPXVEflfy
	 4VPFbJeiUy4lvxvikZ7nWnCsUIBoEwRGE6xJeq9aPTXVwRCAi/QqptWQQpZm9TvLFd
	 iE580iMWUxALDYEBekq4t4PApLYW/PJZj+P9vrr6ojFAkSYiSty66c8ffSvOCgn2MK
	 +5/LfWVyPz7D75C1BPLLtyd3EWG8el0SmmFYtfQbgSBmuBY7TkolV9tRhqEo2hfJJj
	 9t29uY19GisuS5N3F5qKqZoi+dmrXPzLFZ4VQrWeE1uz1vmHduT78h0/3cisdl9wHk
	 UKejv0+HEmmeQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Alice Ryhl" <aliceryhl@google.com>
Cc: "Oliver Mangold" <oliver.mangold@pm.me>,  "Miguel Ojeda"
 <ojeda@kernel.org>,  "Alex Gaynor" <alex.gaynor@gmail.com>,  "Boqun Feng"
 <boqun.feng@gmail.com>,  "Gary Guo" <gary@garyguo.net>,  =?utf-8?Q?Bj?=
 =?utf-8?Q?=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  "Benno Lossin" <benno.lossin@proton.me>,
  "Trevor Gross" <tmgross@umich.edu>,  <rust-for-linux@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] rust: adding UniqueRefCounted and UniqueRef types
In-Reply-To: <Z8lsetLbHvn-6cai@google.com> (Alice Ryhl's message of "Thu, 06
	Mar 2025 09:35:54 +0000")
References: <20250305-unique-ref-v4-1-a8fdef7b1c2c@pm.me>
	<Z8hUIPtE_9P60fAf@google.com> <Z8hmCkeZGPwc5MuU@mango>
	<mE_To6ll96gFJQD9YKkT-mwa2KCHFCgOaZFxxczeDVJd0hr1rZCKFHD-vHQfm6deCjlUJIu4U-reNMtrwfyT7w==@protonmail.internalid>
	<CAH5fLgjFBknTmhxQBPUdB-iNMjEkcyuLiu22-Nj-DGB1Gb7NkA@mail.gmail.com>
	<87ldtj8p2m.fsf@kernel.org>
	<JPqvzrz3Zy0HgwNoHh2psup7imFItiN_j_VmmjVPBfwJzf040DTvZAwUDjNv1FQiLXFiSAANIxc2IegeKGCJvA==@protonmail.internalid>
	<CAH5fLgirYTV6K2QoH9LLwhHxJzz=h1R0jB4G2kpKQ_pBtBgePg@mail.gmail.com>
	<875xkn8k5z.fsf@kernel.org>
	<SmmHwmQewAgGplUKWvizn35VwbJpn0NsjjrO8FPW-eI44ywd3Xx_k1CZ5OaUHn8mqhm-s6JwhB8YvGQqr4go0A==@protonmail.internalid>
	<Z8lsetLbHvn-6cai@google.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Thu, 06 Mar 2025 10:48:54 +0100
Message-ID: <87ikom5w1l.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Alice Ryhl" <aliceryhl@google.com> writes:

> On Wed, Mar 05, 2025 at 06:24:56PM +0100, Andreas Hindborg wrote:
>> "Alice Ryhl" <aliceryhl@google.com> writes:
>>
>> > On Wed, Mar 5, 2025 at 4:39=E2=80=AFPM Andreas Hindborg <a.hindborg@ke=
rnel.org> wrote:
>> >>
>> >> "Alice Ryhl" <aliceryhl@google.com> writes:
>> >>
>> >> > On Wed, Mar 5, 2025 at 3:56=E2=80=AFPM Oliver Mangold <oliver.mango=
ld@pm.me> wrote:
>> >> >>
>> >> >> Hi Alice,
>> >> >>
>> >> >> On 250305 1339, Alice Ryhl wrote:
>> >> >> > On Wed, Mar 05, 2025 at 11:31:44AM +0000, Oliver Mangold wrote:
>> >> >> >
>> >> >> > > +impl<T: UniqueRefCounted> Deref for UniqueRef<T> {
>> >> >> > > +    type Target =3D T;
>> >> >> > > +
>> >> >> > > +    fn deref(&self) -> &Self::Target {
>> >> >> > > +        // SAFETY: The type invariants guarantee that the obj=
ect is valid.
>> >> >> > > +        unsafe { self.ptr.as_ref() }
>> >> >> > > +    }
>> >> >> > > +}
>> >> >> >
>> >> >> > What stops people from doing this?
>> >> >> >
>> >> >> > let my_unique: UniqueRef<T> =3D ...;
>> >> >> > let my_ref: &T =3D &*my_unique;
>> >> >> > let my_shared: ARef<T> =3D ARef::from(my_ref);
>> >> >> >
>> >> >> > Now it is no longer unique.
>> >> >> >
>> >> >> Oh, indeed. That's a serious problem. I see 2 options to deal with=
 that:
>> >> >>
>> >> >> 1. remove ARef::From<&T>
>> >> >>
>> >> >> I checked the users of this, and it looks to me like there is rath=
er
>> >> >> a limited number and they are easy to fix by replacing the &T with=
 ARef<T>.
>> >> >> But I assume that wouldn't be welcome as it is intrusive nonethele=
ss
>> >> >> and of course there is ergonomic value in having the function arou=
nd.
>> >> >
>> >> > Definitely not an option. There are many users of this function that
>> >> > are in the process of being upstreamed. The ability to go &T ->
>> >> > ARef<T> is pretty fundamental for ARef.
>> >>
>> >> Not having `impl From<&T> for UniqueArc` seems to work out fine.
>> >>
>> >> It would be unfortunate if `impl From<&T> for ARef<T>` would prevent =
us
>> >> from having a unique version of `ARef`. I would say that is a valid
>> >> reason to consider removing that impl.
>> >
>> > I think the impl is really important. It's required to do things such =
as:
>> >
>> > let mm =3D ARef::from(&*current!().mm());
>> >
>> > Without the impl (or something equivalent), it's not possible to
>> > increment the refcount of the &Mm returned by `current!().mm()`. There
>> > are many other examples of this.
>>
>> Right. Let's see what we can figure out of other solutions then.
>
> Ultimately, if a struct implements AlwaysRefcounted, then you can always
> increments its refcount. If you want a version of the struct where that
> is not the case, then you need a different struct that does *not*
> implement AlwaysRefcounted.
>
> I do things like that in the mm_struct series. The VmaNew struct is an
> example of that.

Yea, I see your point. I think `AlwaysRefcounted` is just not going to
work for this use case. We can invent something new that suits our
needs.


Best regards,
Andreas Hindborg




