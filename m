Return-Path: <linux-kernel+bounces-546732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B02EA4FE20
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 13:00:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 128E47A50C1
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 11:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 060F5242922;
	Wed,  5 Mar 2025 12:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="KZVBeWDB"
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2432241103;
	Wed,  5 Mar 2025 12:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741176017; cv=none; b=Cs70Gn9c52r9tLfdw6L1pHOiRuETPOrGIlsSZAMO81F1BsuNwL9Hyx2US8Cyv67mn0Wl1lEBcD6gQhtx4XpKAhQ/FBJ36AxoaOdd++KTe1q9hCENjzFq8pdyEXqhH1Kt6cGbXME8a7wy6QqgUy55NEp6j/wKwPtm5A1LQ6kiIsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741176017; c=relaxed/simple;
	bh=2PsUnYxaTfPTsr8aJgtMRdMHhmGNBbPSofiwU8vfTZY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LSJKR8RWi9St14gUvrik2ECFP2Lf2Q+9hLUu6Ky5qoy6h4SbrjV5lz05qlL/THBb/X4aqZ6E2apvt0y/cs3+OMjV5kL5URVavZRl25wpPl2TzkVu5a9fRr9pvU7qZms9vjqGCh5PiJMK+QijWfbizBWzr5NpuoeeK8QMXZvHzMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=KZVBeWDB; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1741176013; x=1741435213;
	bh=IAGpGwzyWY0pJQIfsptuh5AGHP3a7e2gT1msaPBJI6E=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=KZVBeWDBjcqnERPqwQ8lxc/vMSB0HkpVyxEpJ84LMy4HkVxL9jbhgvgiOIqrzlUeM
	 +Mcex2yLtAoqlz0jUArUhsfGN7BAO/UsRyJbtMOOR9kC0Y07DdJynCZdHnjTuvn3Yt
	 e4L7NIAS0oN6kpltJ7VoxzntRJ1eQuXhvdCucpO9c18ZEv/StFVzpaAliR1+KIrWqR
	 VFsP1deQne7+XAkfc1Tea0QOI/t8HyL8yxPsDuF8YBOtaqFJIOnt0BgD2BQPXG1sFS
	 QaetkFuaxEZzzmpjdoperYg8l+RRWW6qVhpv+cLT2piJ+TSr22W5RWcpaQ2QV71UEH
	 TkAi5tJAYT2vA==
Date: Wed, 05 Mar 2025 12:00:06 +0000
To: Andreas Hindborg <a.hindborg@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/22] rust: pin-init: remove kernel-crate dependency
Message-ID: <D88BDOC74W1T.IMRXO8BE868S@proton.me>
In-Reply-To: <87senrd7eq.fsf@kernel.org>
References: <20250304225245.2033120-1-benno.lossin@proton.me> <3-KVPpYsvS6jLhJOL7kCLrypBUWO1rtUDTDUTfy8T_iGZObM3CP6YUK_QLHmL_QTivMtd3jfnRbZOGpClk37cQ==@protonmail.internalid> <20250304225245.2033120-13-benno.lossin@proton.me> <87senrd7eq.fsf@kernel.org>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 79590ef435f6f3fbea9ac9507572f67bd08ba1b7
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed Mar 5, 2025 at 12:49 PM CET, Andreas Hindborg wrote:
> "Benno Lossin" <benno.lossin@proton.me> writes:
>
>> In order to make pin-init a standalone crate, remove dependencies on
>> kernel-specific code such as `ScopeGuard` and `KBox`.
>>
>> `ScopeGuard` is only used in the `[pin_]init_array_from_fn` functions
>> and can easily be replaced by a primitive construct.
>>
>> `KBox` is only used for type variance of unsized types and can also
>> easily be replaced.
>>
>> Signed-off-by: Benno Lossin <benno.lossin@proton.me>
>
> Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
>
>> ---
>>  rust/pin-init/src/__internal.rs |  2 +-
>>  rust/pin-init/src/lib.rs        | 41 +++++++++++----------------------
>>  2 files changed, 15 insertions(+), 28 deletions(-)
>>
>> diff --git a/rust/pin-init/src/__internal.rs b/rust/pin-init/src/__inter=
nal.rs
>> index 0db800819681..74086365a18a 100644
>> --- a/rust/pin-init/src/__internal.rs
>> +++ b/rust/pin-init/src/__internal.rs
>> @@ -105,7 +105,7 @@ fn make_closure<F, O, E>(self, f: F) -> F
>>      }
>>  }
>>
>> -pub struct AllData<T: ?Sized>(PhantomData<fn(KBox<T>) -> KBox<T>>);
>> +pub struct AllData<T: ?Sized>(Invariant<T>);
>
> Off topic, trying to learn something: You define `Invariant<T>` like so:
>
>   pub(super) type Invariant<T> =3D PhantomData<fn(*mut T) -> *mut T>;
>
> Consulting the variance table at [1], could you define it as
>
>   pub(super) type Invariant<T> =3D PhantomData<*mut T>;
>
> or is there another reason for using `fn`?

Yes! There is another reason: `Send` and `Sync`, my `Invariant` type
will always be `Send` and `Sync`, but `PhantomData<*mut T>` is always
`!Send` and `!Sync`.
One could argue that an `Invariant<T>` type should impl `Send`/`Sync`
if and only if `T` does, but for my usage it doesn't matter. If you do
need to use that, you could use `PhantomData<(fn(*mut T) -> *mut T, T)>`

---
Cheers,
Benno

>
>
> Best regards,
> Andreas Hindborg
>
>
> [1] https://doc.rust-lang.org/nomicon/subtyping.html#variance


