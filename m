Return-Path: <linux-kernel+bounces-546740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 623C9A4FE31
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 13:05:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0596B189326B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 12:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D20BA241103;
	Wed,  5 Mar 2025 12:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="KfAZBhIk"
Received: from mail-10629.protonmail.ch (mail-10629.protonmail.ch [79.135.106.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B4123370F
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 12:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741176339; cv=none; b=AplU9t6PZqD9z/6Euw7Ozov5fdWwVsaZumDUgi51y3lgTpUOPqdLJ39Uvr6CCd7fdCu+rKurua/5TnvBaTUBVzGEq9XOVnX9X9OVdoWxtCQApfeHzGSmirFCDM25zYpS+ISXRLE3hmNysDvGW+mv1EsgZnHqT6DLvIoFmtl8Hlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741176339; c=relaxed/simple;
	bh=9pybT0/UMgEz4/wJUXE2cHJv2mhc5VAlGwBfHsQcdhA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZtfbrlnpOlT/8EcUQHrSm+nqraIlV/vC2L1x0pOoB6DNhfgofIpyS537Y7oOgNrPucBilax5neZ4JnUW2TZqH7dpVRkFZ0JfN4kGb3n1bQzYHCxjEre7+W8OBu5qi89L+Uxh7FSGAwv1nkw9oE29hu6XOgTICn/BtXOFVk4Qozk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=KfAZBhIk; arc=none smtp.client-ip=79.135.106.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1741176334; x=1741435534;
	bh=l3OwM3zQ666uofylTyexnRNIzrNX4/a4VSd9lnoA0s4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=KfAZBhIkHAdtsWMP4u7MfD5ESw+1VGRWCiNJjszAptWoHh8wPMmYvHqP8Ig5zrSN3
	 CJHjJKhkXwKq9lJMwNPZpIHbW4JUWlTI+uhKgZd8tlzc39RgxoQW/GlKPDhfi6Eoxf
	 ye8+Z0p0/QaLHdHV7Y3hOstP4kiWnxXM7iw4UwsDAPOmOHNcCVKqLQdnlHp0fPfS1p
	 ofVBPu76wNk4AP05mWRqdTcZkfu9wBCIziySv3nKTMTyExOTPaV5NTKY4roD7y3TWs
	 I92GHvuAR8t98pLi3OXdws6l4CVrWNJa722REOaOh41kgX8g+TuT8VFqjK7AWkoDMZ
	 TntoKgtHUXOYw==
Date: Wed, 05 Mar 2025 12:05:28 +0000
To: Andreas Hindborg <a.hindborg@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/22] rust: pin-init: move impl `Zeroable` for `Opaque` and `Option<KBox<T>>` into the kernel crate
Message-ID: <D88BHSCKZ8MO.10J627BIF6I97@proton.me>
In-Reply-To: <87a59zen0l.fsf@kernel.org>
References: <20250304225245.2033120-1-benno.lossin@proton.me> <msi970CObD4bpxAIjK__fZnRG2q-BXd4FHuA1U1NR80D_dTqSXuQ-0-4R1TS7-7CglN6StcS3Os-IumgWcVLqw==@protonmail.internalid> <20250304225245.2033120-10-benno.lossin@proton.me> <87a59zen0l.fsf@kernel.org>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 56d0fd40d987fa40038aa6364ee7ae75ae9f27d9
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed Mar 5, 2025 at 12:26 PM CET, Andreas Hindborg wrote:
> "Benno Lossin" <benno.lossin@proton.me> writes:
>
>> In order to make pin-init a standalone crate, move kernel-specific code
>> directly into the kernel crate. Since `Opaque<T>` and `KBox<T>` are part
>> of the kernel, move their `Zeroable` implementation into the kernel
>> crate.
>>
>> Signed-off-by: Benno Lossin <benno.lossin@proton.me>
>> ---
>>  rust/kernel/alloc/kbox.rs | 8 +++++++-
>>  rust/kernel/types.rs      | 5 ++++-
>>  rust/pin-init/src/lib.rs  | 8 +-------
>>  3 files changed, 12 insertions(+), 9 deletions(-)
>>
>> diff --git a/rust/kernel/alloc/kbox.rs b/rust/kernel/alloc/kbox.rs
>> index 39a3ea7542da..9861433559dc 100644
>> --- a/rust/kernel/alloc/kbox.rs
>> +++ b/rust/kernel/alloc/kbox.rs
>> @@ -15,7 +15,7 @@
>>  use core::ptr::NonNull;
>>  use core::result::Result;
>>
>> -use crate::init::{InPlaceWrite, Init, PinInit};
>> +use crate::init::{InPlaceWrite, Init, PinInit, Zeroable};
>>  use crate::init_ext::InPlaceInit;
>>  use crate::types::ForeignOwnable;
>>
>> @@ -100,6 +100,12 @@
>>  /// ```
>>  pub type KVBox<T> =3D Box<T, super::allocator::KVmalloc>;
>>
>> +// SAFETY: All zeros is equivalent to `None` (option layout optimizatio=
n guarantee).
>> +//
>> +// In this case we are allowed to use `T: ?Sized`, since all zeros is t=
he `None` variant and there
>> +// is no problem with a VTABLE pointer being null.
>> +unsafe impl<T: ?Sized, A: Allocator> Zeroable for Option<Box<T, A>> {}
>
> Could you elaborate the statement related to vtable pointers? How does
> that come into play for `Option<Box<_>>`? Is it for fat pointers to
> trait objects?

Yes it is for fat pointers, if you have a `x: *mut dyn Trait`, then you
aren't allowed to write all zeroes to `x`, because the VTABLE pointer
(that is part of the fat pointer) is not allowed to be null.

Now for `Option<Box<_>>`, this doesn't matter, as there if the normal
pointer part of the fat pointer is all zeroes, then the VTABLE pointer
part is considered padding bytes, as it's the `None` variant.

---
Cheers,
Benno


