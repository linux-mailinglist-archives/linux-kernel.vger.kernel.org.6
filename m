Return-Path: <linux-kernel+bounces-261502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA8693B80A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 22:32:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A04B2839DA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 20:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AA5A132492;
	Wed, 24 Jul 2024 20:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="QVpSeYMp"
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2DD79F0;
	Wed, 24 Jul 2024 20:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721853123; cv=none; b=n2uH6uv2a9cnJNU2dQDiBdrJWAasSkJKKV4O+bnyoiqBe7mpf9ejvygmYxaEKQYA0WUOz5xM9Mg/fD6IoB1u7PI0KowZ59TcICfSpbh7sB4/T50BXqIrbUlSBKH0+ihlXUBdc/FxamYVBqXVYFoc7mGz2oGm7i9eFTkzIhufjrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721853123; c=relaxed/simple;
	bh=YfALalwPy5ZHDhepjc7XhmZxDErcHoLzWayQp6+Ngsg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q/b8p7kuCSQ1s++ynI0Xu7DL08E8xb8HPGcqUkrzsNR9X9rbGUIhWzuU7yoVFMveX3QyK1ib7+lOlNTGlee1UuswaCZp6F2sXv132Xd8gw2pg2Pp3q6MHDZpb3HqNBqCb/LcbGbE+2TKPEQ4yhcKLdC0ZA3fUGRgrIFVd8FSKpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=QVpSeYMp; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1721853118; x=1722112318;
	bh=xsg+g7ukhQLUiXTUxJFh3fSri7mRfy5DMSTdXugFFrs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=QVpSeYMpIYTU4J8bjmaKwCmeIS5GlcweKGmrenpmVcaCFL8QHJ/xYE+IcnAtKN5tS
	 gpPOJJp3qCiQb2pKBomWaT6ywQqx0krmT3Bs19kPiMzNXVdkPw7sFedyUnO0kXqFah
	 tb1Oi2+jNOSi9vDk1w4Kr+hsJolsfY0xC9xdT+1uR1Tr3PHEVESbJlKaBE0yQmuuWM
	 l1a6nHI/MvUQbDa20p8F+qX2BaGGYyvcBJpfP599ICgoJEPHmgMlrelPzGBrlJlZOY
	 CqMgoAtI26tQtuxvffcHqcPMs2ffxEdiCkerIXetF634TePNpVVjzi051vEM9wYZ3N
	 wg6RgOSf2wGMw==
Date: Wed, 24 Jul 2024 20:31:51 +0000
To: Daniel Almeida <daniel.almeida@collabora.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Jonathan Corbet <corbet@lwn.net>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [RFC PATCH 1/5] doc: rust: create safety standard
Message-ID: <a5afc0ed-2193-42f2-a7ef-50fba68980a6@proton.me>
In-Reply-To: <99DF6A0F-BAE9-4341-8B42-6C1F1C69E2C6@collabora.com>
References: <20240717221133.459589-1-benno.lossin@proton.me> <20240717221133.459589-2-benno.lossin@proton.me> <99DF6A0F-BAE9-4341-8B42-6C1F1C69E2C6@collabora.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 0547db950573e86caff1319c253c6a4a0bff0b4c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 19.07.24 18:24, Daniel Almeida wrote:
> Hi Benno,
>=20
> It=E2=80=99s nice to see this shaping up. I do agree that it=E2=80=99s a =
bit of a wild
> west right now.
>=20
> IMHO, we need a lint to enforce compliance, unless we plan to have every =
patch
> reviewed by the RFL community, which is unrealistic as time goes forward.=
 I
> myself have forgotten to properly document unsafe blocks because it=
=E2=80=99s easy
> to miss things when submitting more than a thousand LOC.
>=20
> A new clippy lint would make sense here, since we already have clippy sup=
port
> in the kernel anyways.

I definitely see the potential, but I have no experience writing clippy
lints. I also have no idea if it can detect comments.
I also think that a lint solution will be very difficult, since it will
either have to be a full proof assistant that mathematically checks if
the safety comments are correct, or we still need human review.
I think that if people are more familiar with safety comments, it will
be easier, it's just how one improves at coding.

I don't want to reject formal verification from the get-go; on the
contrary, I would like to see it applied more in the kernel. Rust has
several different implementations, but I haven't yet taken an in-depth
look at them. However, from my past experience with formal proof
assistants, I have my doubts that everyday developers will pick them up
more easily/in favor of just plain safety comments.

I think that we should apply formal verification to those areas that
have been shown to be very difficult to get right. We currently do not
have enough Rust to have such areas, but when we do, it might be a
powerful tool. But I don't see it becoming the norm for Rust code (but
maybe I am wrong, and I would be very happy to be wrong in this
instance).

There are also several clippy lints [1] that we could start using:
- missing_safety_doc
- multiple_unsafe_ops_per_block
- undocumented_unsafe_blocks
- unnecessary_safety_comment
- unnecessary_safety_doc

I personally think we should enable all of them.

[1]: https://rust-lang.github.io/rust-clippy/master/index.html#/safety

What did you expect/wish for with a clippy lint? Is it already present
or did you want something that verifies your safety comments?

>> On 17 Jul 2024, at 19:12, Benno Lossin <benno.lossin@proton.me> wrote:
>>
>> `unsafe` Rust code in the kernel is required to have safety
>> documentation. This is to ensure the correctness of `unsafe` code and is
>> thus very important.
>> However, at this point in time there does not exist a standard way of
>> writing safety documentation. This leads to confusion, as authors
>> struggle to find the right way to convey their desired intentions.
>> Readers struggle with correctly interpreting the existing documentation.
>>
>> Add the safety standard that will document the meaning of safety
>> documentation. This first document gives an overview of the problem and
>> gives general information about the topic.
>>
>> Signed-off-by: Benno Lossin <benno.lossin@proton.me>
>> ---
>> Documentation/rust/general-information.rst   |   1 +
>> Documentation/rust/index.rst                 |   1 +
>> Documentation/rust/safety-standard/index.rst | 246 +++++++++++++++++++
>> 3 files changed, 248 insertions(+)
>> create mode 100644 Documentation/rust/safety-standard/index.rst
>>
>> diff --git a/Documentation/rust/general-information.rst b/Documentation/=
rust/general-information.rst
>> index e3f388ef4ee4..ddfe4e2e5307 100644
>> --- a/Documentation/rust/general-information.rst
>> +++ b/Documentation/rust/general-information.rst
>> @@ -54,6 +54,7 @@ the same invocation used for compilation, e.g.::
>> Please note that Clippy may change code generation, thus it should not b=
e
>> enabled while building a production kernel.
>>
>> +.. _rust-abstractions:
>>
>> Abstractions vs. bindings
>> -------------------------
>> diff --git a/Documentation/rust/index.rst b/Documentation/rust/index.rst
>> index 46d35bd395cf..968e9aace301 100644
>> --- a/Documentation/rust/index.rst
>> +++ b/Documentation/rust/index.rst
>> @@ -39,6 +39,7 @@ configurations.
>>     quick-start
>>     general-information
>>     coding-guidelines
>> +    safety-standard/index
>>     arch-support
>>     testing
>>
>> diff --git a/Documentation/rust/safety-standard/index.rst b/Documentatio=
n/rust/safety-standard/index.rst
>> new file mode 100644
>> index 000000000000..1cbc8d3dea04
>> --- /dev/null
>> +++ b/Documentation/rust/safety-standard/index.rst
>> @@ -0,0 +1,246 @@
>> +.. SPDX-License-Identifier: GPL-2.0
>> +.. highlight:: rust
>> +
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> +Rust Safety Standard
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> +
>> +Safe Rust code cannot have memory related bugs. This is a guarantee by =
the Rust compiler. Of course
>> +it is not without caveats: no compiler bugs, no bugs in the specificati=
on etc. But the possibly most
>> +important caveat is that of ``unsafe`` code. ``unsafe`` code needs to f=
ollow certain rules in order
>> +for safe code to enjoy the no-memory-bugs privilege. A simple example o=
f such a rule is that
>> +references must be valid for the duration of their lifetime. If any rul=
e is violated, it can lead
>> +to undefined behavior even in safe code! The term undefined behavior in=
 Rust has a lot stricter
>> +meaning than in C or C++: UB in Rust is totally forbidden. In C one mig=
ht rely on the compiler
>> +implementation to ensure correct code generation, but that is not the c=
ase for Rust. You can read
>> +more about UB in Rust
>> +`here <https://doc.rust-lang.org/reference/behavior-considered-undefine=
d.html>`_.
>> +
>> +If ``unsafe`` code makes our life this difficult, one might ask the que=
stion "why do we even need
>> +it?" and the answer to that is that it gives users an escape hatch to d=
o things that the compiler
>> +normally forbids. ``unsafe`` code is a tool that enables programmers to=
 write more performant code,
>> +or code that interacts with hardware or C. These things are particularl=
y important in kernel
>> +development.
>> +
>> +The most effective way to prevent issues in ``unsafe`` code is to just =
not write ``unsafe`` code in
>> +the first place. That is why minimizing the amount of ``unsafe`` code i=
s very important. For
>> +example, drivers are not allowed to directly interface with the C side.=
 Instead of directly
>> +communicating with C functions, they interact with Rust abstractions. T=
his concentrates the usage
>> +of ``unsafe`` code, making it easy to fix issues, since only the abstra=
ction needs to be fixed.
>> +Abstractions also allow taking advantage of other Rust language feature=
s. Read more in
>> +:ref:`rust-abstractions`.
>=20
> This is something that I think we should discuss at Kangrejos. I do not t=
hink
> that we should set in stone that the kernel crate is the only place where
> unsafe code is acceptable.

Oh then I need to rephrase the above paragraph, since I don't meant to
say that. What I want to say is this:
 (1) concentrate as much `unsafe` code as possible, and put it somewhere
     where everyone can use it (ie the `kernel` crate)
 (2) abstract over common use-patterns of `unsafe` code via safe
     abstractions
 (3) disallow access to *raw* `bindings::` function calls from drivers.

From what you write below, I think that we are on the same page for (1)
and (2). What I want to accomplish with (3) is that we don't have hacky
drivers that are just like a C driver with `unsafe` sprinkled
throughout. If you want to do that, just write a C driver instead.

As Alice already replied, there should be no issue with having an
`unsafe` function in an Abstraction. But we should strive for them to be
as few as possible.

> I am in no way disagreeing with the use of safe abstractions, but I think=
 we
> should have abstractions where they make sense. This is the case in the v=
ast
> majority of times, but not in *all* of them.
>=20
> A simple example is a MMIO read or write. Should a driver be forbidden to=
 call
> readX/writeX for an address it knows to be valid? How can you possibly wr=
ite an
> abstraction for this, when the driver is the only one aware of the actual
> device addresses, and when the driver author is the person with actual ac=
cess
> to the HW docs?

One idea that I have in this concrete example would be to make the
driver specify in exactly one place what the addresses are that are
read/writeable. If there are devices with dynamic addresses, then we
could additionally provide an `unsafe` API, but link to the safe one for
people to prefer.

> If a driver is written partially in Rust, and partially in C, and it gets=
 a
> pointer to some kcalloc=E2=80=99d memory in C, should It be forbidden to =
use unsafe
> in order to build a slice from that pointer? How can you possibly design =
a
> general abstraction for something that is, essentially, a driver-internal=
 API?

This also would be a good example for an exception of (3). In this case,
you could still write a driver-specific abstraction that does everything
under the hood and then every place in the driver can use the safe
abstraction.

> For these corner cases, a simple safety comment should suffice. By all me=
ans,
> let's strive to push as much of the unsafe bits into the kernel crate. Bu=
t,
> IMHO, we shouldn=E2=80=99t treat Rust drivers as some unprivileged entity=
, they=E2=80=99re
> also kernel code, after all.

That is true, but I want to prevent that we just "ship it" and then a
couple of days later it turns out that there was a good abstraction
after all. I personally like to spend a lot of time thinking about safe
abstractions before giving in to `unsafe`, but I understand that we need
to find a balance. In the end, we can also always change things. But
when something lands, it most of the time won't get people thinking
about whether there is a better way of doing things. Not unless the
status quo is annoying/burdensome, at which point it already "was too
late", ie there could have been more thought at the beginning.

---
Cheers,
Benno


