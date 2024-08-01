Return-Path: <linux-kernel+bounces-271380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5820944D66
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 15:46:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CA6B1F23DAC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 13:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75D6C1A38E7;
	Thu,  1 Aug 2024 13:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="k68WrCLN"
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E3A189B98
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 13:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722520000; cv=none; b=XKteemS6+Ikde6p6WTK9ZCqYq9ESf46mTI1HGRiCLnyDTo2D1xNO8KJF1dqOUk04MCdmgOTbZia4HIM5809sJK8o8VCq06RmsBF0l33tog0hFoMHwHrFMegRioOUu5cNFP/CJ+ZGcbRjPn5ATgQl71Ds9Ore/pInGbd4TktSehQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722520000; c=relaxed/simple;
	bh=sITK3pKr6Zobvg/kjShjIFRKWEFJyVWbo5cBMGKXrLM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZPz9o0j/dCH4TQAvAL5lE2G4BJ5w2hVfcz95QOUD5vnC84bER8rZjB9O0CjmiQn78zoPRJHoLvxohz+xZHvCIirJ3vjiuTi+sfr2rOXVVJ18MyyvDVPltVt95lva44KNLsL3CS/yLklBrkLqVOsrB37o0GsSWZZSsYAa4KNG/m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=k68WrCLN; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1722519996; x=1722779196;
	bh=Q3cRDO4QKzRb10Iyi1TAhCZG+F7xgQQpPMz+/EOxj5k=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=k68WrCLN5fAj4Ej5MS6qd/AC+izxLBWeC7xPuC1Ej7V3QWBOSEKTFDb3Eu8jxkHf7
	 lXjkQjr+RzGktEoNK2A+6N/VPcQM9dQvkWS3cFC8N6Gblr6kE4142ihc4YmMb7hWhf
	 mLF6XX5YMcNN4k91+lt8KZmooLP4JzfPfzLYTeSDBCetNyCjF+JnEg3N0/bqiRXEPC
	 fo/Y1IOP8YmBRYUsRviuPHwQ8UnHRVNPDZmV9WeUu1auzYKSMftidj/I5/O0McIdJx
	 0AMZzbpxq9McTC1z6fjrUUSLYYr/MNAy+LfKX6FTzvclEzV9h/5k3UkWyOc+6IdUUr
	 O9LQr1hHxxlww==
Date: Thu, 01 Aug 2024 13:46:29 +0000
To: Alice Ryhl <aliceryhl@google.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Marco Elver <elver@google.com>, Coly Li <colyli@suse.de>, Paolo Abeni <pabeni@redhat.com>, Pierre Gondois <pierre.gondois@arm.com>, Ingo Molnar <mingo@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Wei Yang <richard.weiyang@gmail.com>, Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v3 04/10] rust: list: add struct with prev/next pointers
Message-ID: <ea3ef06b-8c4c-4883-867f-b68f2eb589af@proton.me>
In-Reply-To: <CAH5fLgjntr81+OFxzVqvb+zL4RqHCap9LZnNxNvN_gzF8AKrRg@mail.gmail.com>
References: <20240723-linked-list-v3-0-89db92c7dbf4@google.com> <20240723-linked-list-v3-4-89db92c7dbf4@google.com> <1b2078d8-d93b-4626-a73f-edc5616a2357@proton.me> <CAH5fLggKphE3f=Jv+pfXc+_qjsGBVpXw_F4fOJiAi6vNtJ5x+Q@mail.gmail.com> <5b13793c-3ec8-40c2-b0c6-e7b10883d0cb@proton.me> <CAH5fLgjntr81+OFxzVqvb+zL4RqHCap9LZnNxNvN_gzF8AKrRg@mail.gmail.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 80ec9d7d263f3eca5edc93ab9fb0fa7d2fbcf829
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01.08.24 14:51, Alice Ryhl wrote:
> On Thu, Aug 1, 2024 at 12:45=E2=80=AFPM Benno Lossin <benno.lossin@proton=
.me> wrote:
>>
>> On 01.08.24 11:42, Alice Ryhl wrote:
>>> On Wed, Jul 31, 2024 at 8:41=E2=80=AFPM Benno Lossin <benno.lossin@prot=
on.me> wrote:
>>>>
>>>> On 23.07.24 10:22, Alice Ryhl wrote:
>>>>> +/// The prev/next pointers for an item in a linked list.
>>>>> +///
>>>>> +/// # Invariants
>>>>> +///
>>>>> +/// The fields are null if and only if this item is not in a list.
>>>>> +#[repr(transparent)]
>>>>> +pub struct ListLinks<const ID: u64 =3D 0> {
>>>>> +    #[allow(dead_code)]
>>>>> +    inner: Opaque<ListLinksFields>,
>>>>
>>>> Do you really need `Opaque`? Or would `UnsafeCell` be enough? (If it i=
s
>>>> enough and you change this, be aware that `Opaque` is `!Unpin`, so if
>>>> you intend for `ListLinks` to also be `!Unpin`, then you need a
>>>> `PhantomPinned`)
>>>
>>> I need the `!Unpin` part for aliasing.
>>
>> Oh good point, do you mind adding a comment for that?
>>
>>>>> +}
>>>>> +
>>>>> +// SAFETY: The next/prev fields of a ListLinks can be moved across t=
hread boundaries.
>>>>
>>>> Why? This is not a justification.
>>>
>>> What would you say?
>>
>> While trying to come up with a safety comment I thought about the
>> following: this impl does not depend on the type that is behind the
>> pointer (ie the type containing the `ListLinks`). Thus this `ListLinks`
>> will always implement `Send` even if the pointed-to value does not.
>> What we could do (and what definitely would be correct) is this:
>> `List` can only be used with `Send` types, then we could implement
>> `Send` for `ListLinks`. But I haven't actually come up with a problem,
>> so there might a more permissive solution.
>> Do you have a use-case where you need `!Send` types in a list?
>>
>> Here is a part of my reasoning: If the pointed-to value is `!Send`, then
>> the `List` item type must also be `!Send`. Thus all list operations take
>> place on the same thread (since the `List` will be `!Send`). Therefore
>> nobody can access the `prev`/`next` pointers from another thread.
>>
>> But this does not justify that `ListLinks` can be made `Send`. (although
>> there isn't actually a problem)

I think I confused myself. The paragraph above actually explains why we
are allowed to make `ListLinks: Send`. What do you think of the
following comment:

// SAFETY: The only way to access/modify the pointers inside of `ListLinks<=
ID>` is via holding the
// associated `ListArc<T, ID>`. Since that type correctly implements `Send`=
, it is impossible to
// move this an instance of this type to a different thread if the pointees=
 are `!Send`.

> I don't think there's any reason to forbid lists with !Send types. The
> List just becomes !Send too.

Yes, but that doesn't explain why `ListLinks` is allowed to be `Send`.

---
Cheers,
Benno


