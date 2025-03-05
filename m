Return-Path: <linux-kernel+bounces-547364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FA64A5064B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 18:25:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AB7117133F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 17:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F6AA1C7011;
	Wed,  5 Mar 2025 17:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="isfr5Yqk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CFD7567D;
	Wed,  5 Mar 2025 17:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741195505; cv=none; b=Pj/ksdWHrLOezOJBoTcWfRd2n3yxPV2QjmrksYCMla5AhZOZyXWlQe4D3EIoolOU0oN1pEuYiVkbJw++JtMeugKfenTqFPP1L8bxi3kd0Dbt6iX5d7/IzYAj0hwapjxdjGN0p8fJM3LbpLlxTTdczqt0YU2DojsqZZZzUzDyFxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741195505; c=relaxed/simple;
	bh=U18Wfl4pQFaaYNIJzuQEGPdF/5EFkPOj+sQlvfXNzwI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rrNj1DXTFo5sveD268Yzf0L1GHoHOuA5T2KcOIE/2RbZ7ModdvErJ1QNXrBWX/iB8haHBiiToMHxM//9NEl9s1eYQQVuFRzIPIQuTFQJ7IB9tRV7Gmw2KoQW9b3Mu0kSGEOVoLEoPuieQkXj4YGjN3RMg0BvMwFHAshu2ul7oSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=isfr5Yqk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B992C4CED1;
	Wed,  5 Mar 2025 17:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741195505;
	bh=U18Wfl4pQFaaYNIJzuQEGPdF/5EFkPOj+sQlvfXNzwI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=isfr5YqkrSHxijEbW83wwx73H9aHLvHo8eU+AEzJN9GQOVvjVVjja2/+jVwCaz1T1
	 4gb8nfkVojSaUqQLS3m/Cz2JuurqyGBx16qNIFiRpqnW4uatm1NJS8gQPUSBKATPFv
	 MixExuJEHlqWES55sGDYrGGmSTDGyBmQwP8gYaEzGF82riCx3dYrcK56bSFyxwJIwr
	 PutuH+CccgN4/5yAfYL6nr4JzR3wf/+sbreFPieG/DLXLMxeeM+ejH5j8DvnY2uzuB
	 7WOT96PrF2aNL7euNM8lx9zCjHZL/H+Y0NDjFsjukUbLHOxnP3MNbtu8MvTVssRKIk
	 Uoy/Ie5q7Odhg==
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
In-Reply-To: <CAH5fLgirYTV6K2QoH9LLwhHxJzz=h1R0jB4G2kpKQ_pBtBgePg@mail.gmail.com>
 (Alice
	Ryhl's message of "Wed, 05 Mar 2025 17:02:10 +0100")
References: <20250305-unique-ref-v4-1-a8fdef7b1c2c@pm.me>
	<Z8hUIPtE_9P60fAf@google.com> <Z8hmCkeZGPwc5MuU@mango>
	<mE_To6ll96gFJQD9YKkT-mwa2KCHFCgOaZFxxczeDVJd0hr1rZCKFHD-vHQfm6deCjlUJIu4U-reNMtrwfyT7w==@protonmail.internalid>
	<CAH5fLgjFBknTmhxQBPUdB-iNMjEkcyuLiu22-Nj-DGB1Gb7NkA@mail.gmail.com>
	<87ldtj8p2m.fsf@kernel.org>
	<JPqvzrz3Zy0HgwNoHh2psup7imFItiN_j_VmmjVPBfwJzf040DTvZAwUDjNv1FQiLXFiSAANIxc2IegeKGCJvA==@protonmail.internalid>
	<CAH5fLgirYTV6K2QoH9LLwhHxJzz=h1R0jB4G2kpKQ_pBtBgePg@mail.gmail.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Wed, 05 Mar 2025 18:24:56 +0100
Message-ID: <875xkn8k5z.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Alice Ryhl" <aliceryhl@google.com> writes:

> On Wed, Mar 5, 2025 at 4:39=E2=80=AFPM Andreas Hindborg <a.hindborg@kerne=
l.org> wrote:
>>
>> "Alice Ryhl" <aliceryhl@google.com> writes:
>>
>> > On Wed, Mar 5, 2025 at 3:56=E2=80=AFPM Oliver Mangold <oliver.mangold@=
pm.me> wrote:
>> >>
>> >> Hi Alice,
>> >>
>> >> On 250305 1339, Alice Ryhl wrote:
>> >> > On Wed, Mar 05, 2025 at 11:31:44AM +0000, Oliver Mangold wrote:
>> >> >
>> >> > > +impl<T: UniqueRefCounted> Deref for UniqueRef<T> {
>> >> > > +    type Target =3D T;
>> >> > > +
>> >> > > +    fn deref(&self) -> &Self::Target {
>> >> > > +        // SAFETY: The type invariants guarantee that the object=
 is valid.
>> >> > > +        unsafe { self.ptr.as_ref() }
>> >> > > +    }
>> >> > > +}
>> >> >
>> >> > What stops people from doing this?
>> >> >
>> >> > let my_unique: UniqueRef<T> =3D ...;
>> >> > let my_ref: &T =3D &*my_unique;
>> >> > let my_shared: ARef<T> =3D ARef::from(my_ref);
>> >> >
>> >> > Now it is no longer unique.
>> >> >
>> >> Oh, indeed. That's a serious problem. I see 2 options to deal with th=
at:
>> >>
>> >> 1. remove ARef::From<&T>
>> >>
>> >> I checked the users of this, and it looks to me like there is rather
>> >> a limited number and they are easy to fix by replacing the &T with AR=
ef<T>.
>> >> But I assume that wouldn't be welcome as it is intrusive nonetheless
>> >> and of course there is ergonomic value in having the function around.
>> >
>> > Definitely not an option. There are many users of this function that
>> > are in the process of being upstreamed. The ability to go &T ->
>> > ARef<T> is pretty fundamental for ARef.
>>
>> Not having `impl From<&T> for UniqueArc` seems to work out fine.
>>
>> It would be unfortunate if `impl From<&T> for ARef<T>` would prevent us
>> from having a unique version of `ARef`. I would say that is a valid
>> reason to consider removing that impl.
>
> I think the impl is really important. It's required to do things such as:
>
> let mm =3D ARef::from(&*current!().mm());
>
> Without the impl (or something equivalent), it's not possible to
> increment the refcount of the &Mm returned by `current!().mm()`. There
> are many other examples of this.

Right. Let's see what we can figure out of other solutions then.


Best regards,
Andreas Hindborg



