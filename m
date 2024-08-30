Return-Path: <linux-kernel+bounces-308816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F38C396621D
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 14:57:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB69E1F23FF6
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 12:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA017199FC0;
	Fri, 30 Aug 2024 12:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="hhjWIyCj"
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB15166F28
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 12:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725022615; cv=none; b=MP/vUDBYb2KOEGcai8EdAo3itWpqySqOp3SLB0UaEdbHoG8XVIyCAinYYg/iKtk1XIpqww64r1sAUZjRd7qDZTxSAFwRjGkeWhHRxGUpOsccaA3DTx7iRihgSJ8pcpcPWS6y+kI0p9i4dgjV34o4CscqcdJ4xqmHmB0N0ovdwyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725022615; c=relaxed/simple;
	bh=jQJAbrPwBtjdv0Jox7TZADvxOKePvfpsRVCUiQpuo9c=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oO7PHwMp6BSED2+bSwaVmKUCKhtpzhfxRIoyONxtXKAPvdM9JYLCdz5H0tejs4bLspyHAG+LboGd6WUjxrDDF9msgHJPCVlsYn5Gj5ApfudVhAS/8ipvu1PqDbAP37tHkj1LbycxGvlsYKvY9hII0YfyyBQnAsSl2NGB4clZWiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=hhjWIyCj; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1725022608; x=1725281808;
	bh=4+gjy/Hs8b3AqyO8Vm08sJpbUTrKaPC+6nBp0PfO5Oc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=hhjWIyCjxO5t0cmJNVR9isGB2yN8YNFK6cNgoEE1XjHDq43gDW5qvNh7XWkbNEgZ1
	 04TOx0Uaq399+YlA1nYPBAf3AGUpxsIPQZ2dTS9oNtUTV8hZ5NAbKIVncKBJh7ZxUv
	 dN5jV92FE71SV3f18PZzKtpNZgSkW3/xW4MiAkR8i6pPKSTlE9iOEU6bhZDMs1AOyn
	 r+BcdiNAqI4XIN8Q5BnNFkAxivveeyYttJuoR4dJ2IZ0rf+IrcNE2uj/kSCHKkgRup
	 Xk14xQJhCrOKTdX8jf/IGkJQ7kodOHr67P3Tb1unr2IDFCBWFWRxzdWxrmlZUn0FpP
	 lS3KcweFgdHqg==
Date: Fri, 30 Aug 2024 12:56:44 +0000
To: Danilo Krummrich <dakr@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@samsung.com, aliceryhl@google.com, akpm@linux-foundation.org, daniel.almeida@collabora.com, faith.ekstrand@collabora.com, boris.brezillon@collabora.com, lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, airlied@redhat.com, ajanulgu@redhat.com, lyude@redhat.com, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v6 22/26] rust: alloc: implement `Cmalloc` in module allocator_test
Message-ID: <f37e3b3f-2401-4f61-88d7-ad8eff9c0d03@proton.me>
In-Reply-To: <ZtD1TsGm0swi7gyv@pollux.localdomain>
References: <20240816001216.26575-1-dakr@kernel.org> <20240816001216.26575-23-dakr@kernel.org> <e3ccbf52-224e-4869-992b-4fcaa0ec3410@proton.me> <ZtD1TsGm0swi7gyv@pollux.localdomain>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: e94a7edc10b5d6f82b2d1567cb6823eaaf31655d
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 30.08.24 00:25, Danilo Krummrich wrote:
> On Thu, Aug 29, 2024 at 07:14:18PM +0000, Benno Lossin wrote:
>> On 16.08.24 02:11, Danilo Krummrich wrote:
>>> +impl Cmalloc {
>>> +    /// Adjust the size and alignment such that we can additionally st=
ore `CmallocData` right
>>> +    /// before the actual data described by `layout`.
>>> +    ///
>>> +    /// Example:
>>> +    ///
>>> +    /// For `CmallocData` assume an alignment of 8 and a size of 16.
>>> +    /// For `layout` assume and alignment of 16 and a size of 64.
>>
>> This looks like you want it rendered as bulletpoints (but it won't).
>=20
> Actually, that wasn't my intention, but I'm fine changing that.

I see, in that case not putting a newline there is also fine with me.
But I think bulletpoints are probably easier to read.

>>> +    fn alloc_store_data(layout: Layout) -> Result<NonNull<u8>, AllocEr=
ror> {
>>> +        let requested_size =3D layout.size();
>>> +
>>> +        let layout =3D Self::layout_adjust(layout)?;
>>> +        let min_align =3D layout.align() / 2;
>>> +
>>> +        // SAFETY: Returns either NULL or a pointer to a memory alloca=
tion that satisfies or
>>> +        // exceeds the given size and alignment requirements.
>>> +        let raw_ptr =3D unsafe { libc_aligned_alloc(layout.align(), la=
yout.size()) } as *mut u8;
>>> +
>>> +        let priv_ptr =3D NonNull::new(raw_ptr).ok_or(AllocError)?;
>>> +
>>> +        // SAFETY: Advance the pointer by `min_align`. The adjustments=
 from `Self::layout_adjust`
>>> +        // ensure that after this operation the original size and alig=
nment requirements are still
>>> +        // satisfied or exceeded.
>>
>> This SAFETY comment should address why it's OK to call `add`. You
>> justify something different, namely why the allocation still satisfies
>> the requirements of `layout`. That is something that this function
>> should probably guarantee.
>=20
> So, I guess you're arguing that instead I should say that, we're still wi=
thin
> the bounds of the same allocated object and don't exceed `isize`?

Yes.

>>> +    unsafe fn free_read_data(ptr: NonNull<u8>) {
>>> +        // SAFETY: `ptr` has been created by `Self::alloc_store_data`.
>>> +        let data =3D unsafe { Self::data(ptr) };
>>> +
>>> +        // SAFETY: `ptr` has been created by `Self::alloc_store_data`.
>>> +        let priv_ptr =3D unsafe { ptr.as_ptr().sub(data.offset) };
>>> +
>>> +        // SAFETY: `priv_ptr` has previously been allocatored with thi=
s `Allocator`.
>>> +        unsafe { libc_free(priv_ptr.cast()) };
>>> +    }
>>> +}
>>> +
>>> +unsafe impl Allocator for Cmalloc {
>>> +    fn alloc(layout: Layout, flags: Flags) -> Result<NonNull<[u8]>, Al=
locError> {
>>> +        if layout.size() =3D=3D 0 {
>>> +            return Ok(NonNull::slice_from_raw_parts(NonNull::dangling(=
), 0));
>>> +        }
>>> +
>>> +        let ptr =3D Self::alloc_store_data(layout)?;
>>> +
>>> +        if flags.contains(__GFP_ZERO) {
>>> +            // SAFETY: `Self::alloc_store_data` guarantees that `ptr` =
points to memory of at least
>>> +            // `layout.size()` bytes.
>>> +            unsafe { ptr.as_ptr().write_bytes(0, layout.size()) };
>>> +        }
>>
>> This makes me wonder, what other flags should we handle for this
>> allocator?
>=20
> I don't think there are any other flags that we can handle. The only othe=
r one
> that'd make sense is __GFP_NOFAIL, but we can't guarantee that.
>=20
> If any specific gfp flags are needed, I think it's simply not a candidate=
 for a
> userspace test.
>=20
> If we really want to do something here, we could whitelist the flags we i=
gnore,
> since they do not matter (such as __GFP_NOWARN) and panic() for everythin=
g else.
>=20
> But I don't think that's really needed.

Makes sense, just wanted to check that this has been accounted for.

---
Cheers,
Benno


