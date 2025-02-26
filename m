Return-Path: <linux-kernel+bounces-533688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A50F5A45DA2
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 12:49:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A42947A2736
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 11:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A40021D3C7;
	Wed, 26 Feb 2025 11:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AV3Ym0x5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F16217701;
	Wed, 26 Feb 2025 11:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740570512; cv=none; b=HCgzQrwbCJHTHk2s236pS1n9STMvon1e45XsJyC2m7ATCdH9y84zw16wQwzTwg1vfOiW9XgH+Jiwe/g7xtf/a5ErVEU+zbElX+4PnYUAW8GNs5FS/TEO8dH7M4Fu2ss99Sr0MpBT3GTLl4IK6DboUZi70/E06VVyuHnDLIHJfL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740570512; c=relaxed/simple;
	bh=GUzhGjNO5ocbKYgDd8dEbRVtIpH0rClgFTMO3hPnsIY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WoYPhubvz99qUiBNwmpJ8Mn2duv8u5mIw+jYKGfAbdUjrlpcug/UFGA1u6pICxJD05R+sh72iQtJpjf4eXnyaVpxz5eP+O0LD0nFEzF/Dbl1qTvW8rMzaPuwx5yA8Qwc2Frfb7n3K2nQsLbqCbttmvpZGallvkPIKdFQh6XuKWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AV3Ym0x5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3118EC4CEE4;
	Wed, 26 Feb 2025 11:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740570512;
	bh=GUzhGjNO5ocbKYgDd8dEbRVtIpH0rClgFTMO3hPnsIY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=AV3Ym0x5ULM+3BGpd9Zh/0shz+/jZdo1GKeLUmTJoVq9dUnLivFifFkHHZHkHGga2
	 Xk+qhXAN6yrjxM7ZlVU+p5etMNuh6dNTq9EmbIYm3XG6ZYqIxCM6rbOwNGIMmvayv1
	 Y+EQ395xelLSHSNlhNteYqkGwwvbGcQKiKA1AsUwMQNKRhivPVE4a6im6iOs7bm06c
	 OgP7e5LeL8NnunR9dD8V3TWUdLPhGuDohgZIxcNzEG/mBPSaiWWCwILO3AZHGOPP6C
	 GH+NBqDo3TpYEuf9KIF3dwjdDyJj+UUkY3mFDdL4znrwwQtrJ+zdIzadfam3DYPqYK
	 ulEIGu8w9KT3Q==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Tamir Duberstein" <tamird@gmail.com>
Cc: "Miguel Ojeda" <ojeda@kernel.org>,  "Anna-Maria Behnsen"
 <anna-maria@linutronix.de>,  "Frederic Weisbecker" <frederic@kernel.org>,
  "Thomas Gleixner" <tglx@linutronix.de>,  "Danilo Krummrich"
 <dakr@kernel.org>,  "Alex Gaynor" <alex.gaynor@gmail.com>,  "Boqun Feng"
 <boqun.feng@gmail.com>,  "Gary Guo" <gary@garyguo.net>,  =?utf-8?Q?Bj?=
 =?utf-8?Q?=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  "Benno Lossin" <benno.lossin@proton.me>,
  "Alice Ryhl" <aliceryhl@google.com>,  "Trevor Gross" <tmgross@umich.edu>,
  "Lyude Paul" <lyude@redhat.com>,  "Guangbo Cui" <2407018371@qq.com>,
  "Dirk Behme" <dirk.behme@gmail.com>,  "Daniel Almeida"
 <daniel.almeida@collabora.com>,  <rust-for-linux@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v9 01/13] rust: hrtimer: introduce hrtimer support
In-Reply-To: <CAJ-ks9mCvGJoeLhkGHLU-7Q-=g_4XHfX4DBX9w=ZcP4jpWXsPQ@mail.gmail.com>
 (Tamir
	Duberstein's message of "Tue, 25 Feb 2025 15:13:51 -0500")
References: <20250224-hrtimer-v3-v6-12-rc2-v9-0-5bd3bf0ce6cc@kernel.org>
	<20250224-hrtimer-v3-v6-12-rc2-v9-1-5bd3bf0ce6cc@kernel.org>
	<q5sIYQbnCqKmdnZZy-eaKvSUY7O5pOy2-QzwWwCo9VoormFcKS6RS3OVIIby-Pf5PDpTRh67txem3sXQKSB1JQ==@protonmail.internalid>
	<CAJ-ks9nj8+fXM_oo0LJo4O6Q=skFRcHwz8TLxw-yB3QTcDF9GA@mail.gmail.com>
	<87cyf6xv7g.fsf@kernel.org>
	<Wy3wqzRK5qG3GyHC7oEg3NR3tv9-Uv7m_tmgKZTHNEU6aZX5hxrIXLudLfzQvuZNvIz1Av2fKzH5eTvomny1Vg==@protonmail.internalid>
	<CAJ-ks9=PR-Laj37NqG5s_TbKddONWxp4-Cf3C57AMk9z92mfDQ@mail.gmail.com>
	<87r03lvnx4.fsf@kernel.org>
	<RWZWPbf2ND3HRx_kFFVnjBngQMWjrmbidBCzyJr58iQsksyu5SpJVfCiEjf7WYWFOz6eWib5Q9j23QmbSqXyEQ==@protonmail.internalid>
	<CAJ-ks9mCvGJoeLhkGHLU-7Q-=g_4XHfX4DBX9w=ZcP4jpWXsPQ@mail.gmail.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Wed, 26 Feb 2025 12:48:18 +0100
Message-ID: <87eczludtp.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Tamir Duberstein" <tamird@gmail.com> writes:

> On Tue, Feb 25, 2025 at 2:12=E2=80=AFPM Andreas Hindborg <a.hindborg@kern=
el.org> wrote:
>>
>> "Tamir Duberstein" <tamird@gmail.com> writes:
>>
>> > On Tue, Feb 25, 2025 at 3:52=E2=80=AFAM Andreas Hindborg <a.hindborg@k=
ernel.org> wrote:
>> >>
>> >> "Tamir Duberstein" <tamird@gmail.com> writes:
>> >>
>> >> > Hi Andreas, mostly grammar and prose clarity comments below.
>> >> >
>> >> > I still think HasHrTimer::OFFSET is less clear and more fragile than
>> >> > just generating compiler-checked implementations in the macro (you'=
re
>> >> > already generating OFFSET and one method implementation rather than
>> >> > generating 2 method implementations).
>> >>
>> >> I don't agree with you assessment. My argument is that I would rather
>> >> generate as little code as possible in the macro, and the trait would=
 in
>> >> practice never be implemented by hand.
>> >
>> > In the current patch, the trait:
>> > - provides raw_get_timer
>> > - provides timer_container_of
>> > and the macro:
>> > - defines OFFSET
>> > - defines raw_get_timer
>> >
>> > The justification for the redundancy is that without defining
>> > raw_get_timer in the macro the user might invoke the macro
>> > incorrectly.
>>
>> It's not that they might invoke the macro incorrectly, it's that we
>> would not be able to make the macro safe. The way it is implemented now,
>> it will only compile if it is safe.
>>
>> > But why is that better than defining both methods in the
>> > macro?
>>
>> Because it is generating less code. I would rather write the library cod=
e than
>> have the macro generate the code for us on every invocation.
>
> How is it less code? It's the same amount, just harder to reason about
> because you're doing pointer arithmetic rather than relying on
> existing macros like container_of.
>
>>
>> > Either way the macro provides 2 items. The key benefit of
>> > defining both methods in the macro is that there's no dead-code
>> > implementation of raw_get_pointer in the trait. It also reduces the
>> > surface of the trait, which is always a benefit due to Hyrum's law.
>>
>> When you say that the surface would be smaller, you mean that by
>> dropping OFFSET entirely, the trait would have fewer items?
>
> Yes.
>
>
>> I'm not familiar with Hyrum's law.
>
> TL;DR is that anything that can become load bearing will. So even if
> the intent is that OFFSET is an implementation detail, there's no way
> to enforce that, and so someone will misuse it.

I don't fully agree with your assessment, but either way is fine for me.
So I shall implement your suggestion.

[...]

>> > I noticed below I had suggested talking about the handler as
>> > "returning" rather than "finishing execution"; please consider that
>> > throughout.
>>
>> I do not prefer one over the other. Do you care strongly about this one?
>
> I prefer return since it's more obvious but don't feel strongly about
> the choice, only that the usage is consistent.

Ok, let's do that then.

[...]

>> >> >> +/// Implemented by pointer types that point to structs that embed=
 a [`HrTimer`].
>> >
>> > This comment says "embed a [`HrTimer`]" but in `trait HrTimer` the
>> > wording is "Implemented by structs that contain timer nodes."
>>
>> I don't follow. There is no `trait HrTimer`, there is a `struct
>> HrTimer`, but it has no such wording.
>>
>> > Is the difference significant?
>>
>> No, I would say they are semantically the same. Whether a struct
>> contains a field of a type or it embeds another struct - I would say
>> that is the same.
>
> Can we use the same wording in both places then?

OK.

>> > Also the naming of the two traits feels inconsistent; one contains
>> > "Has" and the other doesn't.
>>
>> One is not a trait, not sure if you are looking on another item than
>> `struct HrTimer`?
>
> Sorry, I meant HasHrTimer and HrTimerPointer rather than HrTimer and
> HrTimerPointer.

`HasHrTimer` is named so because it is meant to be implemented by types
that contain a field of type `HrTimer`.

`HrTimerPointer` is meant to be implemented by pointer types that point
to types that implement `HasHrTimer`.

They are different, and the naming reflect that.

I will not rename `HasHrTimer` to `ContainsHrTimer`, because the rest of
the rust kernel uses the `HasFoo` naming scheme.


Best regards,
Andreas Hindborg



