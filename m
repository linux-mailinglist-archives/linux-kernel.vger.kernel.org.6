Return-Path: <linux-kernel+bounces-288027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10234953119
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 15:50:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF6862880DA
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 13:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F113819F471;
	Thu, 15 Aug 2024 13:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="dvruiuGc"
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4BE21494C5;
	Thu, 15 Aug 2024 13:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723729808; cv=none; b=h7a8cox5ri62i0FhQOwDpxOsgF199qyP9I0INcDEowJe8iEPGpBLCcLBEOfhRbbPltjw/sONY55HWTOCviyyd6VDT6LwukqXhSownzRryVSYefakdIxv0NAFQcVhSAf/q60KGO6sJcQDtmBrJjeiMeXIHPYHDY9vCTrOl7H8AzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723729808; c=relaxed/simple;
	bh=VHcZHRipWBwVJFTK+W08oRNQL269lIOOCvroraVRk0Q=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q16Y229ZWTwObViXn0Xn7lCftrHcbpc8etIInjww0HaQsc85rOh5X0n0XErF1gn0iBKwsFGmSpxZ+7f2h3c+JzsRKZdY9uPxkdFuEfGRL8MfDInFpmxJ9scunoQQmNduN9lm1S74YmR9cRI3H7igDITjSs38Z2sJ6+XgExpbC0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=dvruiuGc; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1723729802; x=1723989002;
	bh=KEupb37DrZI7fKTirvjR5sFyvknSbw5Bw1SxzjumzWg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=dvruiuGcYy9XjfiiXN+udkg0CQt6KsH/wfuGMotUl+tnvX/rODk0lST+iZ2OiQnQn
	 ofK+rV6bfXB5BUFhwHkRxXwWDbezOi0xfPg0756FKGYyko8o/b79S1V06eYZuxyHt+
	 olkc4sDvKn+RBP7ZOArwu/H7xbH5d1LEEOJsqFMcncPRFEwttVn8oo/66GYbKFp35y
	 cp60QNWMkTBXeqheFwSolxhdtTIe812KSB77CrmxZFDgEpLb0lrSyZFpi4mC5UVFtA
	 wbFxvRhSfAR91QgmTFQfuFuRKFGccDTbekjEe3FbVsWgbvlV1dGGXzXXhuGKHo+hq6
	 S/wzOuYpuS4HQ==
Date: Thu, 15 Aug 2024 13:49:55 +0000
To: Danilo Krummrich <dakr@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@samsung.com, aliceryhl@google.com, akpm@linux-foundation.org, daniel.almeida@collabora.com, faith.ekstrand@collabora.com, boris.brezillon@collabora.com, lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, airlied@redhat.com, ajanulgu@redhat.com, lyude@redhat.com, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v5 01/26] rust: alloc: add `Allocator` trait
Message-ID: <a2462e9e-0b65-4cbd-82d9-32298dfb781e@proton.me>
In-Reply-To: <Zr1Izo9Qp8mYkbpr@cassiopeiae>
References: <20240812182355.11641-1-dakr@kernel.org> <20240812182355.11641-2-dakr@kernel.org> <cfcdaa42-6a62-4a17-a8dc-2382e88774dc@proton.me> <Zr1Izo9Qp8mYkbpr@cassiopeiae>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 93fe3d43e70bb7f12b5d0fa2bcfee2ab778e703f
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 15.08.24 02:16, Danilo Krummrich wrote:
> On Wed, Aug 14, 2024 at 04:13:06PM +0000, Benno Lossin wrote:
>> On 12.08.24 20:22, Danilo Krummrich wrote:
>>> +/// # Safety
>>> +///
>>> +/// Memory returned from an allocator must point to a valid memory buf=
fer and remain valid until
>>> +/// it is explicitly freed.
>>
>> I wouldn't say that an allocator "returns memory", and in general I
>> don't think the structure of the safety comment here is nice, how about
>> the following: we put "Implementers must ensure that all trait functions
>> abide by the guarantees documented in the `# Guarantees` sections."...
>=20
> Sounds reasonable to me. Additionally, I'd still keep the part below, tha=
t says
> that any pointer to a memory allocation must bbe valid to be passed to an=
y other [`Allocator`]
> function of the same type.

Yes of course, that should be kept.

>>> +///
>>> +/// Any pointer to a memory buffer which is currently allocated must b=
e valid to be passed to any
>>> +/// other [`Allocator`] function of the same type.
>>> +///
>>> +/// If `realloc` is called with:
>>> +///   - a size of zero, the given memory allocation, if any, must be f=
reed
>>> +///   - `None`, a new memory allocation must be created

Only this list should be moved.

>>> +pub unsafe trait Allocator {
>>> +    /// Allocate memory based on `layout` and `flags`.
>>> +    ///
>>> +    /// On success, returns a buffer represented as `NonNull<[u8]>` th=
at satisfies the layout
>>> +    /// constraints (i.e. minimum size and alignment as specified by `=
layout`).
>>> +    ///
>>> +    /// This function is equivalent to `realloc` when called with `Non=
e`.
>>
>> ... Then we can add this here:
>>
>>     /// # Guarantees
>>     ///
>>     /// When the return value is `Ok(ptr)`, then `ptr` is
>>     /// - valid for writes (and reads after the memory has been initiali=
zed) for `layout.size()` bytes,
>>     ///   until it is passed to [`Allocator::free`] or [`Allocator::real=
loc`],
>>     /// - aligned to `layout.align()`,
>>     /// - is valid for reads, if `flags.contains(flags::__GFP_ZERO)`,
>>
>> Do we need to handle other flags?
>=20
> The whole flags thing is a bit difficult to represent here properly.
>=20
> Theoretically, we'd need to add that it guarantees that the memory is zer=
oed for
> __GFP_ZERO, non-blocking for GFP_NOWAIT, etc. But, I think we shouldn't
> re-iterate all different behavior for the different flags.

If there are good docs, then link them.

> Another inconvenience is that not all page flags are honored or make sens=
e for
> all allocators. This is especially inconvenient for `KVmalloc` where we c=
an't
> even say if we end up in vrealloc() or krealloc(). kvmalloc() even contai=
ns a
> couple of flag fixups for this reason [2].

I am wondering if we want to encode this in the type system...

> I think we should just point to [1], which should document everything alr=
eady.
>=20
> [1] https://elixir.bootlin.com/linux/v6.10.4/source/include/linux/gfp_typ=
es.h
> [2] https://elixir.bootlin.com/linux/v6.10.4/source/mm/util.c#L612
>=20
>> Also IIRC the memory given to us by C is considered initialized by Rust
>> (though it has a non-deterministic value), so we might have an
>> unconditional "valid for reads". Am I correct?
>=20
> Yes, but as you say, unless allocated with __GFP_ZERO, it contains non-de=
terministic data. It may
> even contain old data from previous allocations.

Yeah, but IIRC that is not a soundness issue. So memory coming from C is
always considered initialized by Rust. Whereas
`MaybeUninit::uninit().assume_init()` is insta-UB, reading such memory
should be fine (just not useful).

>>> +    /// by this allocator. The alignment encoded in `layout` must be s=
maller than or equal to the
>>> +    /// alignment requested in the previous `alloc` or `realloc` call =
of the same allocation.
>>> +    ///
>>> +    /// Additionally, `ptr` is allowed to be `None`; in this case a ne=
w memory allocation is
>>> +    /// created.
>>
>> This Safety section does not talk about the case `layout.size() =3D=3D 0=
`,
>> but it should have the same requirement as `free()`.
>>
>> Also add a `# Guarantees` section here:
>>
>>     /// # Guarantees
>>     ///
>>     /// This function has the same guarantees as [`Allocator::alloc`]. W=
hen `ptr =3D=3D Some(p)`, then it
>>     /// additionally has the following:
>>     /// - when `Ok(ret_ptr)` is the return value, then
>>     ///   `ret_ptr[0..min(layout.size(), old_size)] =3D=3D p[0..min(layo=
ut.size(), old_size)]`, where
>>     ///   `old_size` is the size of the allocation that `p` points at.
>=20
> We could also say "The contents of the memory pointed to by `p` are prese=
rved
> up to the lesser of the new and old size." But I'm fine with both.

I can read and write the math-ish syntax better, so I would prefer that
over words. If others think we should use words, then we can discuss.

---
Cheers,
Benno


