Return-Path: <linux-kernel+bounces-547159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0957FA50393
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 16:39:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CB66188D298
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 15:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1B442500AA;
	Wed,  5 Mar 2025 15:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b7OzGLsA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472F524CEF1;
	Wed,  5 Mar 2025 15:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741189147; cv=none; b=LI/H12gElgUSOjV/Orfzhxftw1vtkrRfr3dAFNJZKLn6wpgN5WPoXhLM/YQ5BU2VNlapqeijOKyLgywJQItSPUKYAC78C+exQ506MRCoh/uslCUgPl+PcA7vIdKbD/GWaKQdSktCaZxd6A1eROHs+oXECJN3bZRyf5TGBAM0xVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741189147; c=relaxed/simple;
	bh=6l/nGlRwYIypO6eZjpyaluzqiRf/pbS+i3k2kB3JrsE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jrZQdzrui8EaVu0b8eKyo90+gPViJpxQfqOyVkhjaVGDhkFWZI48FmNtnD2YJcqUXmGm/5sOsA9nl5FKt8nQPKdkak5kz1bsgBzYWMGkLmhxeRtqmFfbSuQQ9BWKsYMx9SlanxDx6UlVaoPRcMlb4BQ1I6NwQwSegYVAw62XgMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b7OzGLsA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03418C4CED1;
	Wed,  5 Mar 2025 15:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741189146;
	bh=6l/nGlRwYIypO6eZjpyaluzqiRf/pbS+i3k2kB3JrsE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=b7OzGLsA79NeQJdT/x22K3ou5RHfdxQMlukqc7QSKDGNA051YsNkhvbq86461c/l8
	 A0y3QjDoNJIA0Ve+OyFbVvsZyxkTtGSnN//yocEqb9i2mmrP1MViYounKuTf5Eoij4
	 bVQmB3wZ3MTBb8X3hxdZyZAg9JXzERXWQESGCll/lNSEwv9i8NJjqmsnrRtHyu9roQ
	 Y8OAFzIc3S2SE8Ga2fWeQMoiP/mPu91EgzYcnXMdn76hMPQfgCwXdGxTIL+NMi+0G0
	 broC+x7FKCXuVHMpWzjcXNk/X9GAK378OFB0NRM4Z1SWzuSxSGF0tSOx0tktGtFp9Z
	 cqahjmm/T0F6g==
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
In-Reply-To: <CAH5fLgjFBknTmhxQBPUdB-iNMjEkcyuLiu22-Nj-DGB1Gb7NkA@mail.gmail.com>
 (Alice
	Ryhl's message of "Wed, 05 Mar 2025 16:13:59 +0100")
References: <20250305-unique-ref-v4-1-a8fdef7b1c2c@pm.me>
	<Z8hUIPtE_9P60fAf@google.com> <Z8hmCkeZGPwc5MuU@mango>
	<mE_To6ll96gFJQD9YKkT-mwa2KCHFCgOaZFxxczeDVJd0hr1rZCKFHD-vHQfm6deCjlUJIu4U-reNMtrwfyT7w==@protonmail.internalid>
	<CAH5fLgjFBknTmhxQBPUdB-iNMjEkcyuLiu22-Nj-DGB1Gb7NkA@mail.gmail.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Wed, 05 Mar 2025 16:38:57 +0100
Message-ID: <87ldtj8p2m.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Alice Ryhl" <aliceryhl@google.com> writes:

> On Wed, Mar 5, 2025 at 3:56=E2=80=AFPM Oliver Mangold <oliver.mangold@pm.=
me> wrote:
>>
>> Hi Alice,
>>
>> On 250305 1339, Alice Ryhl wrote:
>> > On Wed, Mar 05, 2025 at 11:31:44AM +0000, Oliver Mangold wrote:
>> >
>> > > +impl<T: UniqueRefCounted> Deref for UniqueRef<T> {
>> > > +    type Target =3D T;
>> > > +
>> > > +    fn deref(&self) -> &Self::Target {
>> > > +        // SAFETY: The type invariants guarantee that the object is=
 valid.
>> > > +        unsafe { self.ptr.as_ref() }
>> > > +    }
>> > > +}
>> >
>> > What stops people from doing this?
>> >
>> > let my_unique: UniqueRef<T> =3D ...;
>> > let my_ref: &T =3D &*my_unique;
>> > let my_shared: ARef<T> =3D ARef::from(my_ref);
>> >
>> > Now it is no longer unique.
>> >
>> Oh, indeed. That's a serious problem. I see 2 options to deal with that:
>>
>> 1. remove ARef::From<&T>
>>
>> I checked the users of this, and it looks to me like there is rather
>> a limited number and they are easy to fix by replacing the &T with ARef<=
T>.
>> But I assume that wouldn't be welcome as it is intrusive nonetheless
>> and of course there is ergonomic value in having the function around.
>
> Definitely not an option. There are many users of this function that
> are in the process of being upstreamed. The ability to go &T ->
> ARef<T> is pretty fundamental for ARef.

Not having `impl From<&T> for UniqueArc` seems to work out fine.

It would be unfortunate if `impl From<&T> for ARef<T>` would prevent us
from having a unique version of `ARef`. I would say that is a valid
reason to consider removing that impl.


Best regards,
Andreas Hindborg



