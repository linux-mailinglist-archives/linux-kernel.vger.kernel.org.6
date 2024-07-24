Return-Path: <linux-kernel+bounces-261555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A59093B8EE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 00:02:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C69C31F23000
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 22:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06D1C13C9CA;
	Wed, 24 Jul 2024 22:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="Epg7dnUZ"
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10C2127E0D;
	Wed, 24 Jul 2024 22:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721858520; cv=none; b=KTfnfKoxsq9rsy4NuZlVXBUFgCVkql5fsT/isiYHULXr12BCagDVswTgkaezyFEBf1llLV1C19pTG5/NwC65k/Zpgs9B746QDGAoZXvGv9AMI4uH0WZOcfLmW1SN/mlMnCQM0E5SxhKYFEsa/mzmY3l8hrvNJ5Z2FkadzwbOXVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721858520; c=relaxed/simple;
	bh=S1Dcl/aj7zeooOV/7eVXDKXqAlXYLBYJEg/YcpAH2to=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OyKjvlGf4k3dmhHsES73CKSfpPwKERujE8nTB7qquTpz4L4/sx/YEpWEpJ2ePC3zy35DNVua0SDofJubrE4YiQ0H6fOpkEb1ykemxYugO91+hQGgAigb5yaCYiS2ZPyAZIg+PNBzv/0GGztl8CeoX0/SZcWvqhU8MCPfpjGFa5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=Epg7dnUZ; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1721858516; x=1722117716;
	bh=S1Dcl/aj7zeooOV/7eVXDKXqAlXYLBYJEg/YcpAH2to=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Epg7dnUZFy+76QXsfAVXA0aewFnEPWvyDMjsY3f0N8gY2Jo8kQGqEBNQflK1VEICN
	 v/Kz10R+eP2AoELNOn967z8aTkt2en1w2b2FWp3dcaNIlFpbmoFHRUB2USylc7ljNJ
	 zI6Lo+pfgrrkISW7YiatFSJmDBhwG2pFQcruLrbJgEpD2J9o510XuFKu+SXCsvTqOa
	 EDP4gYPNuauU0tPyhI6toUHx2YsZZbD16WThSUZdGbgsEPD3GepjENErN7iVuqD+A9
	 yRot9TW6o1otDBVPzL34weZJNj1TM5jFMRuSUBpAMw14oBMXyI+y6LM0xChx+4+v20
	 Pkc3IGH9VTsnQ==
Date: Wed, 24 Jul 2024 22:01:50 +0000
To: Boqun Feng <boqun.feng@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Jonathan Corbet <corbet@lwn.net>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, lkmm@lists.linux.dev
Subject: Re: [RFC PATCH 1/5] doc: rust: create safety standard
Message-ID: <289d66fb-a698-4d3b-b809-0e3305199a2c@proton.me>
In-Reply-To: <Zprkf4FrBXgYmtgg@boqun-archlinux>
References: <20240717221133.459589-1-benno.lossin@proton.me> <20240717221133.459589-2-benno.lossin@proton.me> <Zprkf4FrBXgYmtgg@boqun-archlinux>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: dc87c75b1e7cfa0abb30624c92582fc9d58573a0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 20.07.24 00:11, Boqun Feng wrote:
> Hi Benno,
>=20
> On Wed, Jul 17, 2024 at 10:12:29PM +0000, Benno Lossin wrote:
> [...]
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
>=20
> I don't disagree with your intention here (i.e. we should seek for
> UB-free program), however, during the discussion on memory model, I got
> response like in [1]:
>=20
> =09... they are technically wrong (violating the C standard), but
> =09practically well-tested. (and then above I added that there's
> =09good reasons for why they don't go wrong: volatile compilation
> =09strategies and reordering constraints relating volatile, inline
> =09asm, and non-atomics make it so that this almost 'has to' work,
> =09I think.)
>=20
> which suggests that we should rely on the compiler implementation to
> ensure the "correct" code generation.

I disagree, why can't we get the specification to specify what we need?
I would rather have a compiler and standard that are in sync and give us
what we need, than have a standard that says we aren't allowed to do X,
but compilers still allow you to do X. I don't understand why this is
the case for C (I would bet this is is because of history/legacy).

> Basically, since LKMM relies on a few things that C standard dosen't
> say, e.g. votatile accesses on certain types are atomic, behaviors of
> asm blocks, dependencies. Let alone we have data_race() where for
> example, the diagnostic code accesses the shared variable out of the
> core synchronization design.
>=20
> All of the above is difficult to implement purely UB-free in Rust IIUC.
> Of course you could argue the ideal way is to teach Rust how to model
> these useful operations/patterns as non-UBs, but that's a relatively
> high task:
>=20
> =09Or do we want to go well beyond what happens in C, and actually
> =09define a memory model that both has the performance
> =09characteristics required by Linux, and can be defined precisely
> =09as a language-level graph-based (or ideally operational)
> =09concurrency memory model? This is a monumental task and a large
> =09open problem, and should not be on the list of blocking issues
> =09for anything that needs to get done in the next 5 years. ;)
>=20
> from Ralf [2].
>=20
> Again, I don't want to rely on compiler's behaviors on UBs, it's just
> the langauge is not ready for some jobs and programmers have to be
> "creative".

I think this is something that we need to very carefully evaluate on a
case-by-case basis. I think that with Rust we have a clean slate and can
try from the beginning to ensure that there is no
compiler-but-not-specification behavior that we rely upon. AFAIK the
Rust standard moves quicker than the C standard, so we might be able to
influence it more easily.

So what I am trying to say is: let UB be an actually useful term of
forbidden behavior. If you want to convince me otherwise, I think we
should talk specifics and not in this general way, since "sometimes UB
is actually ok" is something that I don't want to accept in Rust as a
general statement. If we have an exception, it should have a damn good
reason to be an exception and then still I don't like it one bit. Can't
we just ask the Rust folks to implement some compiler magic for us that
achieves what we need without relying one some weird compiler quirk?

---
Cheers,
Benno

> Regards,
> Boqun
>=20
> [1]: https://rust-lang.zulipchat.com/#narrow/stream/136281-t-opsem/topic/=
.E2.9C.94.20Rust.20and.20the.20Linux.20Kernel.20Memory.20Model/near/4221932=
12
> [2]: https://github.com/rust-lang/unsafe-code-guidelines/issues/348#issue=
comment-1221376388
>=20
>> +more about UB in Rust
>> +`here <https://doc.rust-lang.org/reference/behavior-considered-undefine=
d.html>`_.
>> +
> [...]


