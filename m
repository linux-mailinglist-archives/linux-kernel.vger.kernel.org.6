Return-Path: <linux-kernel+bounces-243263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E01349293BF
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 15:21:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B5141F21E6A
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 13:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B247812AAFD;
	Sat,  6 Jul 2024 13:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="JRDXe+Bh"
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1387320310
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jul 2024 13:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720272107; cv=none; b=T04cVtkFBd0Khi5K6xknCLGo8s5loLulSsUrjgF2t/ggGsp6fZ+F+5/jQZ7phWZYf4P0Mk6U1FsRF/fVNVtgeT4IutziqBwkyTLaU3/4qucW5oT4Tg3pduDyJGZvm60QGBhIQaaWbuhYcPOGUA9OiQls0CCA1BDz9UZqOvPqwVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720272107; c=relaxed/simple;
	bh=E/Z+a0IYTlrM9p8N8UthGlV27pBUcXL9wofd/V7P/Gc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KdxwITsugSvU1LXPSm/qCYzdBrVZbmrkeeyhBQ4w4kg68yc8O6L9hlM3kKmQAgQ9dUhcmJv3vg2NeFzHNTnzert0/B9LnBgLU2Zs45A7GC4a2taaoFmDhiYFnXZlJI4L1VD5P2o8vBeuZRVd4w6j4ayU+u9bNoVyWeRFqL2cNgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=JRDXe+Bh; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1720272103; x=1720531303;
	bh=s36rjgEJmVqwWLnrEohDXjmHZsXgc7KAt+lY3+9Djrc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=JRDXe+BhlK8YYpRfjMILF0mOIbsRV8uXH3eRgcn+SoUOXeNaY44MMhNESfegm7HLN
	 Eu3z3EEB9w+rEFkt/FXOO7pl4OeCA86pe0Y/FbmaWjCG2KBhsBauJ3Wk51HKilhjWv
	 wRh/lGFy936H20pVQxA2aIYafGwpOHkRC3zTE+uqtnYPPXndFkI/C/RFxlpw4hCi7+
	 t3YyfeZ2weK23nBg7lKjxsUWhAoK+zsf2A20iYE7SAEYb/K60KwuuPsTMRmYY48YMI
	 1794vLJYMrEFVwjFQJj/kY6+v3h5uXVF3iFzOX1RvL3dZW50fA4rWDkKP49/fU0oxr
	 GYhTnRAXwZ9cA==
Date: Sat, 06 Jul 2024 13:21:39 +0000
To: Danilo Krummrich <dakr@redhat.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@samsung.com, aliceryhl@google.com, daniel.almeida@collabora.com, faith.ekstrand@collabora.com, boris.brezillon@collabora.com, lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com, acurrid@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, airlied@redhat.com, ajanulgu@redhat.com, lyude@redhat.com, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH 07/20] rust: alloc: implement `Vmalloc` allocator
Message-ID: <796b50c4-0824-4b9f-97f9-750f34096ed6@proton.me>
In-Reply-To: <Zokm6M48WunoEohV@pollux.localdomain>
References: <20240704170738.3621-1-dakr@redhat.com> <20240704170738.3621-8-dakr@redhat.com> <596c6446-eca4-46a8-91c5-e71e92c61062@proton.me> <Zokm6M48WunoEohV@pollux.localdomain>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 2ea57d4981e071ba6a4f70d52c4ec6ea648f6785
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06.07.24 13:13, Danilo Krummrich wrote:
> On Sat, Jul 06, 2024 at 10:41:28AM +0000, Benno Lossin wrote:
>> On 04.07.24 19:06, Danilo Krummrich wrote:
>>> @@ -112,6 +118,55 @@ unsafe fn alloc_zeroed(&self, layout: Layout) -> *=
mut u8 {
>>>      }
>>>  }
>>>
>>> +unsafe impl Allocator for Vmalloc {
>>> +    unsafe fn realloc(
>>> +        &self,
>>> +        src: *mut u8,
>>> +        old_size: usize,
>>> +        layout: Layout,
>>> +        flags: Flags,
>>> +    ) -> Result<NonNull<[u8]>, AllocError> {
>>> +        let mut size =3D aligned_size(layout);
>>> +
>>> +        let dst =3D if size =3D=3D 0 {
>>> +            // SAFETY: `src` is guaranteed to be previously allocated =
with this `Allocator` or NULL.
>>> +            unsafe { bindings::vfree(src.cast()) };
>>> +            NonNull::dangling()
>>> +        } else if size <=3D old_size {
>>> +            size =3D old_size;
>>> +            NonNull::new(src).ok_or(AllocError)?
>>> +        } else {
>>> +            // SAFETY: `src` is guaranteed to point to valid memory wi=
th a size of at least
>>> +            // `old_size`, which was previously allocated with this `A=
llocator` or NULL.
>>> +            let dst =3D unsafe { bindings::__vmalloc_noprof(size as u6=
4, flags.0) };
>>> +
>>> +            // Validate that we actually allocated the requested memor=
y.
>>> +            let dst =3D NonNull::new(dst.cast()).ok_or(AllocError)?;
>>> +
>>> +            if !src.is_null() {
>>> +                // SAFETY: `src` is guaranteed to point to valid memor=
y with a size of at least
>>> +                // `old_size`; `dst` is guaranteed to point to valid m=
emory with a size of at least
>>> +                // `size`.
>>> +                unsafe {
>>> +                    core::ptr::copy_nonoverlapping(
>>> +                        src,
>>> +                        dst.as_ptr(),
>>> +                        core::cmp::min(old_size, size),
>>> +                    )
>>> +                };
>>> +
>>> +                // SAFETY: `src` is guaranteed to be previously alloca=
ted with this `Allocator` or
>>> +                // NULL.
>>> +                unsafe { bindings::vfree(src.cast()) }
>>> +            }
>>> +
>>> +            dst
>>> +        };
>>
>> If we had not a single realloc, but shrink/grow/free/alloc, then we
>> would not need these checks here, I personally would prefer that, what
>> do you guys think?
>=20
> Yeah, but look at `Kmalloc`, you'd have these checks in `Kmalloc`'s shrin=
k/grow
> functions instead, since `krealloc()` already behaves this way.

In the kmalloc case you would have different instantiations, no checks.
IIUC for freeing you would do `krealloc(ptr, 0, flags)`.

> Personally, I don't see much value in `shrink` and `grow`. I think
> implementations end up calling into some `realloc` with either `new < old=
` or
> `new > old` anyway.

I think a `resize` would make more sense. In general, splitting
resizing, creating and freeing makes sense to me.

---
Cheers,
Benno


