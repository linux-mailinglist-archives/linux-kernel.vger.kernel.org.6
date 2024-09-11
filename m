Return-Path: <linux-kernel+bounces-324467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AE26974CC8
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 10:37:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 304572867B2
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 08:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C12215C13A;
	Wed, 11 Sep 2024 08:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="IGyYJK1x"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B991531E8;
	Wed, 11 Sep 2024 08:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726043816; cv=none; b=C6MRNsvL44YeRmUCLKX9WBK0TJVzHhdaxHZCqozLxSQgdeL+BI6SJ0zTAgAA0LXW9quAgUuOIM9WE1yQ6bgoys8pPW0hclUYeQ22spJeu4Fn1+JUa7AxRQHoSYgya9nWUECKXEu+JN6YSLzZ5T7hVYElFr4tzbcChQo4+qimewU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726043816; c=relaxed/simple;
	bh=AtI1JodZDO+8/Tzk/nlctu61CodYyKWQS2JBWhZh7W4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=etltOx8aGlKJAFJJ9YFckBqzDTyS/MeulhZwKwTBpeNCph3kd1JCqBengtoIfhDc49OmzRFk0WWV75OYVSHOGqB/WN6X9IX/jonmEbwidyDSpjHVXP/wmny+5vHh5Z6/rdj4kz/VI9QtDv5pW6szMi9rTFRi25uM1X8KKFWw7iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=IGyYJK1x; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=q5xqu33p5zemxkr2vym5jgtsx4.protonmail; t=1726043805; x=1726303005;
	bh=KnWn/8TtLlH9g5YMgEkjKP7rMW4YOeNrjWYIMxEWl2U=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=IGyYJK1xJG1ico72kpnXAj/gt7H6UCJc5lWmqzFpNeh1O27PFoydWGigCtS85MI3S
	 g6b1zVwWFM8F5sMh4/GK2+Yh85kFDD/LiwizU3w9ypxO0gwiRthE+w5uYG6FQSVBTj
	 kJg+3bf0sH1iFB5RhP6VmgusnwyNrvsIOyl5pwvuwLUKZ5jchcwL12XJN8ef3iAYkM
	 CJYfOyP7DisLRjYtGc6sFq7ECkEB9uM/UhwqahyrIHLTlI4j+gITA4S3J4rIPnzXcj
	 nx5NsBmwizdxQOkYlV0WhG3kNbUxwFZ3q/BA7TdiHK72J8gH3RiKZZgZOmxydeAq+j
	 bq1gJxmaMtchg==
Date: Wed, 11 Sep 2024 08:36:38 +0000
To: Danilo Krummrich <dakr@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@samsung.com, aliceryhl@google.com, akpm@linux-foundation.org, daniel.almeida@collabora.com, faith.ekstrand@collabora.com, boris.brezillon@collabora.com, lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, airlied@redhat.com, ajanulgu@redhat.com, lyude@redhat.com, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v6 09/26] rust: alloc: implement kernel `Box`
Message-ID: <77b91448-a21e-4e1b-9a8e-3d2052d79a78@proton.me>
In-Reply-To: <ZuDVekRzfeBkWmKz@pollux>
References: <20240816001216.26575-1-dakr@kernel.org> <20240816001216.26575-10-dakr@kernel.org> <0146cb78-5a35-4d6b-bc75-fed1fc0c270c@proton.me> <ZuCEneJeXcRo5qs8@pollux> <19d81a27-9600-4990-867c-624104e3ad83@proton.me> <ZuDVekRzfeBkWmKz@pollux>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 88c99c18904d989862df81bed222d177747790f8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11.09.24 01:25, Danilo Krummrich wrote:
> On Tue, Sep 10, 2024 at 07:49:42PM +0000, Benno Lossin wrote:
>> On 10.09.24 19:40, Danilo Krummrich wrote:
>>> On Sat, Aug 31, 2024 at 05:39:07AM +0000, Benno Lossin wrote:
>>>> On 16.08.24 02:10, Danilo Krummrich wrote:
>>>>> +/// # Examples
>>>>> +///
>>>>> +/// ```
>>>>> +/// let b =3D KBox::<u64>::new(24_u64, GFP_KERNEL)?;
>>>>> +///
>>>>> +/// assert_eq!(*b, 24_u64);
>>>>> +/// # Ok::<(), Error>(())
>>>>> +/// ```
>>>>> +///
>>>>> +/// ```
>>>>> +/// # use kernel::bindings;
>>>>> +/// const SIZE: usize =3D bindings::KMALLOC_MAX_SIZE as usize + 1;
>>>>> +/// struct Huge([u8; SIZE]);
>>>>> +///
>>>>> +/// assert!(KBox::<Huge>::new_uninit(GFP_KERNEL | __GFP_NOWARN).is_e=
rr());
>>>>> +/// ```
>>>>
>>>> It would be nice if you could add something like "KBox can't handle bi=
g
>>>> allocations:" above this example, so that people aren't confused why
>>>> this example expects an error.
>>>
>>> I don't think that's needed, it's implied by
>>> `SIZE =3D=3D bindings::KMALLOC_MAX_SIZE + 1`.
>>>
>>> Surely, we could add it nevertheless, but it's not very precise to just=
 say "big
>>> allocations". And I think this isn't the place for lengthy explanations=
 of
>>> `Kmalloc` behavior.
>>
>> Fair point, nevertheless I find examples a bit more useful, when the
>> intention behind them is not only given as code.
>>
>>>>> +///
>>>>> +/// ```
>>>>> +/// # use kernel::bindings;
>>>>> +/// const SIZE: usize =3D bindings::KMALLOC_MAX_SIZE as usize + 1;
>>>>> +/// struct Huge([u8; SIZE]);
>>>>> +///
>>>>> +/// assert!(KVBox::<Huge>::new_uninit(GFP_KERNEL).is_ok());
>>>>> +/// ```
>>>>
>>>> Similarly, you could then say above this one "Instead use either `VBox=
`
>>>> or `KVBox`:"
>>>>
>>>>> +///
>>>>> +/// # Invariants
>>>>> +///
>>>>> +/// The [`Box`]' pointer is always properly aligned and either point=
s to memory allocated with `A`
>>>>
>>>> Please use `self.0` instead of "[`Box`]'".
>>>>
>>>>> +/// or, for zero-sized types, is a dangling pointer.
>>>>
>>>> Probably "dangling, well aligned pointer.".
>>>
>>> Does this add any value? For ZSTs everything is "well aligned", isn't i=
t?
>>
>> ZSTs can have alignment and then unaligned pointers do exist for them
>> (and dereferencing them is UB!):
>=20
> Where is this documented? The documentation says:
>=20
> "For operations of size zero, *every* pointer is valid, including the nul=
l
> pointer. The following points are only concerned with non-zero-sized acce=
sses."
> [1]

That's a good point, the documentation looks a bit outdated. I found
this page in the nomicon: https://doc.rust-lang.org/nomicon/vec/vec-zsts.ht=
ml
The first iterator implementation has an alignment issue. (Nevertheless,
that chapter of the nomicon is probably useful to you, since it goes
over implementing `Vec`, but maybe you already saw it)

> [1] https://doc.rust-lang.org/std/ptr/index.html

Might be a good idea to improve/complain about this at the rust project.

>>     #[repr(align(64))]
>>     struct Token;
>>
>>     fn main() {
>>         let t =3D 64 as *mut Token;
>>         let t =3D unsafe { t.read() }; // this is fine.
>>         let t =3D 4 as *mut Token;
>>         let t =3D unsafe { t.read() }; // this is UB, see below for miri=
's output
>>     }
>>
>> Miri complains:
>>
>>     error: Undefined Behavior: accessing memory based on pointer with al=
ignment 4, but alignment 64 is required
>>      --> src/main.rs:8:22
>>       |
>>     8 |     let t =3D unsafe { t.read() }; // this is UB, see below for =
miri's output
>>       |                      ^^^^^^^^ accessing memory based on pointer =
with alignment 4, but alignment 64 is required
>>       |
>>       =3D help: this indicates a bug in the program: it performed an inv=
alid operation, and caused Undefined Behavior
>>       =3D help: see https://doc.rust-lang.org/nightly/reference/behavior=
-considered-undefined.html for further information
>>       =3D note: BACKTRACE:
>>       =3D note: inside `main` at src/main.rs:8:22: 8:30
>=20
> `read` explicitly asks for non-null and properly aligned even if `T` has =
size
> zero.

Dereferencing (ie `*t`) also requires that (I just didn't do it, since
then the `Token` must implement `Copy`).

---
Cheers,
Benno


