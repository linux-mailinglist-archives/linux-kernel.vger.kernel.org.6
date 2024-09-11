Return-Path: <linux-kernel+bounces-325011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F259753E1
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 15:29:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05E841C22E43
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 13:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A656D19CC19;
	Wed, 11 Sep 2024 13:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="OWTe8+Za"
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1E719AD6E;
	Wed, 11 Sep 2024 13:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726061202; cv=none; b=MOn0L55Fg6iehbLFU45EreXOmMZvy3TgqdAsYfMWh5NSPWj1Df4LbhsNkgchpCYvn4K0jSVHLqIZNB6gV4WUv3EJHZIXc3JJkMruW8fAEt1byYd3MDIwjC93ii508syEnYWVDvNExEXD7iiVczjgEwHni7kDICMhhpLy/7P2DeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726061202; c=relaxed/simple;
	bh=J6IXT1iZln99Z1mMtpC22DQ9PHW+aiWMF/43PDKIl5o=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jkwQ5IYcz0baz0fG1jHtvHz2rwF42nQDAzstFntXhEHULQOIkaX+xbe8vbehNdswp0GmOffCJmmlPYFFsmf4C9su7G0Z2zdhCghrFua/QAZ+ZknEUfQKBjk5AHGl1e2DLk+rwEZkBJN279xMyO4+BSi6FUGvfeQeTL445daKQhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=OWTe8+Za; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1726061198; x=1726320398;
	bh=J6IXT1iZln99Z1mMtpC22DQ9PHW+aiWMF/43PDKIl5o=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=OWTe8+Zacu+2pKXJFf6kbs3SyVbwAT9BpOmPh6uTE9T4aZsxDqT1+jZmhStMBjOSv
	 DvxnBP2PbBeMaTck4M4kNQXAAcf8oNBiQF6erNKShmWMP278lnhRO4v5T2PnvRtkwU
	 j1gORkWe4RLMKkf2pbxI0c5hU1erjpSTyRRAj08zAmqhA6regLcImzMO9O7gGZ0pf3
	 6S+Zs2Ar7Cf6wFrGWV2RcnLbdIszZNwgIjA7x0sKawwHiuXz9rD+YK+9AAhO8rzFuI
	 Tc5S7gBUD2KdGBGBpzKvu68iijC8pPVxWn6bI0WAyhK4C7jiyf17334xWU8RMsbNQg
	 QEe8A6uMVxFeQ==
Date: Wed, 11 Sep 2024 13:26:32 +0000
To: Danilo Krummrich <dakr@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@samsung.com, aliceryhl@google.com, akpm@linux-foundation.org, daniel.almeida@collabora.com, faith.ekstrand@collabora.com, boris.brezillon@collabora.com, lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, airlied@redhat.com, ajanulgu@redhat.com, lyude@redhat.com, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v6 09/26] rust: alloc: implement kernel `Box`
Message-ID: <b80cb238-5fcc-4bbb-8b03-42e173c28653@proton.me>
In-Reply-To: <ZuF444VO8gK8l7UR@pollux>
References: <20240816001216.26575-1-dakr@kernel.org> <20240816001216.26575-10-dakr@kernel.org> <0146cb78-5a35-4d6b-bc75-fed1fc0c270c@proton.me> <ZuCEneJeXcRo5qs8@pollux> <19d81a27-9600-4990-867c-624104e3ad83@proton.me> <ZuDVekRzfeBkWmKz@pollux> <77b91448-a21e-4e1b-9a8e-3d2052d79a78@proton.me> <ZuF444VO8gK8l7UR@pollux>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 151627c16fe706231a6a0e475a335428846fcd46
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11.09.24 13:02, Danilo Krummrich wrote:
> On Wed, Sep 11, 2024 at 08:36:38AM +0000, Benno Lossin wrote:
>> On 11.09.24 01:25, Danilo Krummrich wrote:
>>> On Tue, Sep 10, 2024 at 07:49:42PM +0000, Benno Lossin wrote:
>>>> On 10.09.24 19:40, Danilo Krummrich wrote:
>>>>> On Sat, Aug 31, 2024 at 05:39:07AM +0000, Benno Lossin wrote:
>>>>>> On 16.08.24 02:10, Danilo Krummrich wrote:
>>>>>>> +///
>>>>>>> +/// ```
>>>>>>> +/// # use kernel::bindings;
>>>>>>> +/// const SIZE: usize =3D bindings::KMALLOC_MAX_SIZE as usize + 1;
>>>>>>> +/// struct Huge([u8; SIZE]);
>>>>>>> +///
>>>>>>> +/// assert!(KVBox::<Huge>::new_uninit(GFP_KERNEL).is_ok());
>>>>>>> +/// ```
>>>>>>
>>>>>> Similarly, you could then say above this one "Instead use either `VB=
ox`
>>>>>> or `KVBox`:"
>>>>>>
>>>>>>> +///
>>>>>>> +/// # Invariants
>>>>>>> +///
>>>>>>> +/// The [`Box`]' pointer is always properly aligned and either poi=
nts to memory allocated with `A`
>>>>>>
>>>>>> Please use `self.0` instead of "[`Box`]'".
>>>>>>
>>>>>>> +/// or, for zero-sized types, is a dangling pointer.
>>>>>>
>>>>>> Probably "dangling, well aligned pointer.".
>>>>>
>>>>> Does this add any value? For ZSTs everything is "well aligned", isn't=
 it?
>>>>
>>>> ZSTs can have alignment and then unaligned pointers do exist for them
>>>> (and dereferencing them is UB!):
>>>
>>> Where is this documented? The documentation says:
>>>
>>> "For operations of size zero, *every* pointer is valid, including the n=
ull
>>> pointer. The following points are only concerned with non-zero-sized ac=
cesses."
>>> [1]
>>
>> That's a good point, the documentation looks a bit outdated. I found
>> this page in the nomicon: https://doc.rust-lang.org/nomicon/vec/vec-zsts=
.html
>> The first iterator implementation has an alignment issue. (Nevertheless,
>> that chapter of the nomicon is probably useful to you, since it goes
>> over implementing `Vec`, but maybe you already saw it)
>>
>>> [1] https://doc.rust-lang.org/std/ptr/index.html
>>
>> Might be a good idea to improve/complain about this at the rust project.
>=20
> Well, my point is how do we know? There's no language specification and t=
he
> documentation is (at least) ambiguous.

So I went through the unsafe-coding-guidelines issues list and only
found this one: https://github.com/rust-lang/unsafe-code-guidelines/issues/=
93
Maybe I missed something. You could also try to ask at the rust zulip in
the t-opsem channel for further clarification.

I think we should just be on the safe side and assume that ZSTs require
alignment. But if you get a convincing answer and if they say that they
will document it, then I don't mind removing the alignment requirement.

---
Cheers,
Benno


