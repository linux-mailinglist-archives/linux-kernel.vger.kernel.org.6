Return-Path: <linux-kernel+bounces-287993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 485FA952F5E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 15:31:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04CF52896AF
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 13:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AED6D1714D0;
	Thu, 15 Aug 2024 13:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="jvMeqsm7"
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC447DA78;
	Thu, 15 Aug 2024 13:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723728708; cv=none; b=EpbAIlQTzLGemaV5asDueljht0TgFw1lQSWoAuZLp7v71bE4CgrfmbjC6dSBM+1vcwrQQuPpmzC4qfsCp9VmOhoolxFvsiSXsKFWVoqAjeWaJhTRhk3sqtmTAAFe+qLoBWryf3Va3ltHkHMA0JWXYBDiHZTwDP8a7/6XWKWoUKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723728708; c=relaxed/simple;
	bh=iCnuZJbdXmo2gqrQkF5SpoX5x7+7hv2Z9zoLrxahULI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gXvXSg9AoTgUlfU8tJ9CqO5/ABF1q3paABchpg+Ru0o25V9qiwsjrqfH/ayVY9OLRVGi346XCHNwssTMb/KmWeu0hUKtke1fx6FtYgkfVxOs6CJzhpB4BsvwY+UhP28HozRknJjOy+xRDCxzPcYn5jn3fRQOTn1YiLhYVtWoFIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=jvMeqsm7; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1723728703; x=1723987903;
	bh=uU47n+wkC+UeRYLmqKmwAIBmv3vLI79nYT3sZhrTkGc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=jvMeqsm7ztgEz9ue0tqevr6T9jbwmf3veSnuf3A4l2ZTXnpbk+XIfv/GuprPX4ooV
	 cIWbTzRpSBp3E9ai1mLX8WZWH7QMSEjxu8Em6bIL4W7m/+tsMEYDycTFux9p9b14zH
	 cf/nkNOtkx5A5uzCs5LVDfKgJvdVSh1/7v1cfiLiRzUMMhRjYJ0aLazssbkCRykdNA
	 mxc34pxmNre5yO6vf3N54+rNxfR/8AmcQxxt1n6EDcjbC34ev7KSCWRFA3qhp8UFDB
	 EIoP84Z12xxi5teezRLzT34gPSAFgkbJnmXGYjInYLMVa848FLEz/TGg0mK8JwK2sS
	 jQXLkk3DH9xmg==
Date: Thu, 15 Aug 2024 13:31:37 +0000
To: Alice Ryhl <aliceryhl@google.com>, Danilo Krummrich <dakr@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@samsung.com, akpm@linux-foundation.org, daniel.almeida@collabora.com, faith.ekstrand@collabora.com, boris.brezillon@collabora.com, lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, airlied@redhat.com, ajanulgu@redhat.com, lyude@redhat.com, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v5 13/26] rust: alloc: implement kernel `Vec` type
Message-ID: <c0b120fb-4b16-46b4-8d69-260458124177@proton.me>
In-Reply-To: <CAH5fLggbXYYSTKMUR3jRXwWn7WPi8GtZpHqhLPWW9XHieRPQRA@mail.gmail.com>
References: <20240812182355.11641-1-dakr@kernel.org> <20240812182355.11641-14-dakr@kernel.org> <CAH5fLggchaAzcRK=i=zRm7hTg6qX0yGBAyAHcO45rG-oEh-AMQ@mail.gmail.com> <ZryjN7Rn_vZNwsZU@pollux> <CAH5fLggbXYYSTKMUR3jRXwWn7WPi8GtZpHqhLPWW9XHieRPQRA@mail.gmail.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: c143637b73c9b0bc41d1b5aae22b7f967a3afdf6
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 14.08.24 14:36, Alice Ryhl wrote:
> On Wed, Aug 14, 2024 at 2:29=E2=80=AFPM Danilo Krummrich <dakr@kernel.org=
> wrote:
>>
>> On Wed, Aug 14, 2024 at 10:42:28AM +0200, Alice Ryhl wrote:
>>> On Mon, Aug 12, 2024 at 8:25=E2=80=AFPM Danilo Krummrich <dakr@kernel.o=
rg> wrote:
>>>> +#[macro_export]
>>>> +macro_rules! kvec {
>>>> +    () =3D> (
>>>> +        {
>>>> +            $crate::alloc::KVec::new()
>>>> +        }
>>>> +    );
>>>> +    ($elem:expr; $n:expr) =3D> (
>>>> +        {
>>>> +            $crate::alloc::KVec::from_elem($elem, $n, GFP_KERNEL)
>>>> +        }
>>>> +    );
>>>> +    ($($x:expr),+ $(,)?) =3D> (
>>>> +        {
>>>> +            match $crate::alloc::KBox::new([$($x),+], GFP_KERNEL) {
>>>> +                Ok(b) =3D> Ok($crate::alloc::KBox::into_vec(b)),
>>>> +                Err(e) =3D> Err(e),
>>>
>>> Hmm. This currently generates code that:
>>>
>>> 1. Creates the array.
>>> 2. Allocates the memory.
>>> 3. Moves the array into the box.
>>>
>>> Whereas the stdlib macro swaps step 1 and 2. You can do the same by
>>> utilizing new_uninit. A sketch:
>>>
>>> match KBox::<[_; _]>::new_uninit(GFP_KERNEL) {
>>>     Ok(b) =3D> Ok(KVec::from(KBox::write(b, [$($x),+]))),
>>>     Err(e) =3D> Err(e),
>>> }
>>
>> Generally, I'm fine changing that, but what's the reason for the suggest=
ion? It
>> shouldn't make a difference, does it?
>=20
> The compiler is much more likely to not put the array on the stack
> before it is copied to the heap.
>=20
> In the case where $x constructs new values, it also avoids
> create-then-destroy on allocator failure.

If we are this worried about not putting the array on the stack, then we
could also do this using `init!`, but the macro still would need to
count the number of elements in the array.

@Danilo, from the other thread:

> How do we get the size here? `#![feature(generic_arg_infer)]` seems to be
> unstable.

You can use a macro to count the number of elements:

    macro_rules! count_exprs {
        () =3D> { 0 };
        ($e:expr $(,$rest:expr)* $(,)?) =3D> {
            1 + count_exprs!($($rest,)*)
        };
    }

And then do

    match KBox::<[_; count_exprs!($($x),+)]>::new_uninit(GFP_KERNEL) {
        Ok(b) =3D> Ok(KVec::from(KBox::write(b, [$($x),+]))),
        Err(e) =3D> Err(e),
    }

---
Cheers,
Benno


