Return-Path: <linux-kernel+bounces-288074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A4CD953311
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 16:13:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E827AB27274
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 14:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF0BA1A706B;
	Thu, 15 Aug 2024 14:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="eaqSD0u5"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E40C1A00EC;
	Thu, 15 Aug 2024 14:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723731037; cv=none; b=XNSB7O6vd61k/qc6c5C5VNegFouCnYC2fD00NN63DTlFgvAk8wpcnd2gHK2nZTfebwYjtKftcLJxqtUcjPfIIVhfz3YnKahlya6k8SM41so37dj2+Nes8gRXTmvWfdbERGLgSGC0byr5m1WPXq0o+kbO3C0rkIuQkYwYcZGcxY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723731037; c=relaxed/simple;
	bh=BDHaQFo8dDeUDSWWnczHxuH+Hb4dCYs/6Cp/V24JuiQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i4YYfJC4yZgRokt8clEcSiqV+H0GsAY+OWER+iTMSeB+esOunYUj4FsXjDorZkv4/dh526gPOI6Mc+elJ7A4e8kWTrLAYzdJpkW1zaXCLBlfpekx/KclqzXvcBL7vd32lh1Oq0qROCTbdWF5bGT4KkSvxrkwZ6p79VSkB8xIw8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=eaqSD0u5; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1723731030; x=1723990230;
	bh=BDHaQFo8dDeUDSWWnczHxuH+Hb4dCYs/6Cp/V24JuiQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=eaqSD0u5FIVhekwomHdqa7qqVPhLldaCA2i9Uer6UkdNF+AtVw/u59xrQ24n14Ykb
	 ogdgNAx9ikn3GlbX4HGHbbbNuoqz1N0c00lK3saGzWZPTltSbuIS5ga2FhLHBOZpRy
	 Ufwm+37qwf8EIPjE66iMmbsSwif/LtmYwKywwybZraLauX0rmc47xRDU+AXV0TYBsZ
	 7LreQGALq77u/wCqW1j5XIVKjGnr2nhCyiFHUBFcpX4d4d0/xbqzqzsxRjzsl+Guyh
	 aRPXfR2qqwxSYYScz/nZ2ilyt3UoAiGyecPdsTPQqWbZP15iMY6Cr7rq+PKzFniasl
	 o8xbdXbqrzDmg==
Date: Thu, 15 Aug 2024 14:10:24 +0000
To: Danilo Krummrich <dakr@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@samsung.com, aliceryhl@google.com, akpm@linux-foundation.org, daniel.almeida@collabora.com, faith.ekstrand@collabora.com, boris.brezillon@collabora.com, lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, airlied@redhat.com, ajanulgu@redhat.com, lyude@redhat.com, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v5 09/26] rust: alloc: implement kernel `Box`
Message-ID: <66ed33bf-b17a-406f-b277-501ea9f002bf@proton.me>
In-Reply-To: <Zr4J4e1aLADlyDMD@cassiopeiae>
References: <20240812182355.11641-1-dakr@kernel.org> <20240812182355.11641-10-dakr@kernel.org> <a69e7280-7291-49f7-a46f-1ad465efce04@proton.me> <Zr0ocI-j3fZZM7Rw@cassiopeiae> <56ebda7b-c570-4dc6-8456-ab768d3a4b77@proton.me> <Zr4J4e1aLADlyDMD@cassiopeiae>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 90b6225e273150ef957894a0d74fa40346620329
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 15.08.24 16:00, Danilo Krummrich wrote:
> On Thu, Aug 15, 2024 at 01:24:47PM +0000, Benno Lossin wrote:
>> On 14.08.24 23:58, Danilo Krummrich wrote:
>>> On Wed, Aug 14, 2024 at 05:01:34PM +0000, Benno Lossin wrote:
>>>> On 12.08.24 20:22, Danilo Krummrich wrote:
>>>>> +///
>>>>> +/// # Examples
>>>>> +///
>>>>> +/// ```
>>>>> +/// let b =3D KBox::new(24_u64, GFP_KERNEL)?;
>>>>> +///
>>>>> +/// assert_eq!(*b, 24_u64);
>>>>> +///
>>>>> +/// # Ok::<(), Error>(())
>>>>> +/// ```
>>>>> +pub type KBox<T> =3D Box<T, super::allocator::Kmalloc>;
>>>>> +
>>>>> +/// Type alias for `Box` with a `Vmalloc` allocator.
>>>>
>>>> Same here, add that this is supposed to be used for big values (or is
>>>> this also a general-purpose allocator, just not guaranteeing that the
>>>> memory is physically contiguous? in that case I would document it
>>>> here and also on `Vmalloc`).
>>>
>>> Same as above, I'd rather not duplicate that. But I'm happy to link thi=
ngs in,
>>> just not sure what's the best way doing it.
>>
>> I took a look at the link and there is the "Selecting memory allocator"
>> section, but there isn't really just a vmalloc or kmalloc section, it is
>> rather stuff that we would put in the module documentation.
>=20
> There are no dedicated sections, but...
>=20
>> What I would write on these types would be what to use these boxes for.
>> eg large allocations, general purpose etc. I don't think that that is
>> easily accessible from the docs that you linked above.
>=20
> ...this stuff should be covered by the document, e.g.:
>=20
> "The maximal size of a chunk that can be allocated with kmalloc is limite=
d. The
> actual limit depends on the hardware and the kernel configuration, but it=
 is a
> good practice to use kmalloc for objects smaller than page size."
>=20
> or
>=20
> "For large allocations you can use vmalloc() and vzalloc(), or directly r=
equest
> pages from the page allocator. The memory allocated by vmalloc and relate=
d
> functions is not physically contiguous."

Yeah, but for that you have to read big chunks of the document and item
docs in Rust are often very short, since you only need to know what that
one item does.
Would be a good idea to talk about how we can improve this at Kangrejos.

---
Cheers,
Benno


