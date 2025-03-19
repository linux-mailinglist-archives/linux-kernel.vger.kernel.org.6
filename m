Return-Path: <linux-kernel+bounces-568654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D5FAA698F9
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 20:17:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA9B74614A3
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 19:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2DEF214223;
	Wed, 19 Mar 2025 19:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fTk0UqF7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3101C211710;
	Wed, 19 Mar 2025 19:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742411652; cv=none; b=UJr/EJJDieUh60YDpo3jOISOTmjvvJppurb6adsBl0Eormm6hR3i/hkfL+0FOi7wShH3B/910Wml1zraD2rOlRhcpUYRtXtfhGfQR1MCSqsWdCoyGzp085xwQWYoTBZXW33xZPcS+A87pXoa6HZkCvdSORuYjfmdZleF5K7W/qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742411652; c=relaxed/simple;
	bh=Nf5X+seE6wNfFMoZueZ+SLUM5hVg0Q+PrIZTOAXNZZ8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fb7L7jK6ZP3ZuX03nYJVin6l52krOJCxWEzaCmCT3P3r0nJELz/E6aGvUw7949/5P4HBU8alQ5biIy/uQRrMv8GPjGvRRMu5mVXLZakel0Aik0093U6CHyn1U4KLRn+UBCOTPowwBsQP9mNbCUtmX1iit5FX8YXrhMRz4BOdE9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fTk0UqF7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 585D1C4CEE4;
	Wed, 19 Mar 2025 19:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742411651;
	bh=Nf5X+seE6wNfFMoZueZ+SLUM5hVg0Q+PrIZTOAXNZZ8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=fTk0UqF73i6ZbbJPkncCGndt9O00HCdKTrw/w5Pv5xLtu9Plt77/y73wiFRpbB/ym
	 ozqdfubSymqX+zDiDWRV84CN8S8iTSjqy0dFmHOzZTQL7tmRr3rdQonhYIJBW/Ra0+
	 R0evCa3yP6FGunwlfzsBhX/IwyYk7+HsXmQfy6X+/ClZ4hpgyajJPoZE7CO8LhnQeu
	 ORrQ+F30lte/AN75xeCU2r+DSS3HxjCBl3JvzpWXHdYzomHJnBJIqCTaqfrVOcj4j8
	 DVPMAlAG9QvKEQ3caOTj173RpyK+Y4gkmLSkEuaBKqY8Z7N1UXJ62UxdhDX9dWAqsp
	 grnUkIq1qvxHQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Christian Schrefl" <chrisi.schrefl@gmail.com>
Cc: "Alice Ryhl" <aliceryhl@google.com>,  "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>,  "Alexander Viro" <viro@zeniv.linux.org.uk>,
  "Arnd Bergmann" <arnd@arndb.de>,  "Miguel Ojeda" <ojeda@kernel.org>,
  "Boqun Feng" <boqun.feng@gmail.com>,  "Gary Guo" <gary@garyguo.net>,
  =?utf-8?Q?Bj=C3=B6rn?= Roy Baron <bjorn3_gh@protonmail.com>,  "Benno
 Lossin"
 <benno.lossin@proton.me>,  "Trevor Gross" <tmgross@umich.edu>,  "Danilo
 Krummrich" <dakr@kernel.org>,  "Matthew Maurer" <mmaurer@google.com>,
  "Lee Jones" <lee@kernel.org>,  <linux-kernel@vger.kernel.org>,
  <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH 2/5] rust: iov: add iov_iter abstractions for ITER_DEST
In-Reply-To: <439baec2-dba8-4dab-abb5-faa14fbda943@gmail.com> (Christian
	Schrefl's message of "Tue, 18 Mar 2025 21:13:01 +0100")
References: <20250311-iov-iter-v1-0-f6c9134ea824@google.com>
	<20250311-iov-iter-v1-2-f6c9134ea824@google.com>
	<XR-HMXHiYqCkDupCkyfLz4Rz-ucS6r5sCg1TmHQ7KeqAvf7-4ofJJcSCc2jKmS8WDivMc5oDgAYThptx7X_ExQ==@protonmail.internalid>
	<439baec2-dba8-4dab-abb5-faa14fbda943@gmail.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Wed, 19 Mar 2025 20:14:00 +0100
Message-ID: <87v7s4g7ev.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Christian Schrefl" <chrisi.schrefl@gmail.com> writes:

> Hi Alice
>
> On 11.03.25 3:25 PM, Alice Ryhl wrote:
>> This adds abstractions for the iov_iter type in the case where
>> data_source is ITER_DEST. This will make Rust implementations of
>> fops->read_iter possible.
>>
>> This series only has support for using existing IO vectors created by C
>> code. Additional abstractions will be needed to support the creation of
>> IO vectors in Rust code.
>>
>> These abstractions make the assumption that `struct iov_iter` does not
>> have internal self-references, which implies that it is valid to move it
>> between different local variables, and that you can make a copy of it to
>> get two IO vectors into the same buffers.
>>
>> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
>> ---
>>  rust/kernel/iov.rs | 140 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
>>  1 file changed, 139 insertions(+), 1 deletion(-)
>>
>> diff --git a/rust/kernel/iov.rs b/rust/kernel/iov.rs
>> index 4498f65e1f65bd964909810c020db3a9f8fae389..dc32c27c5c76d059562fd7c6b9d4b178a8ea7c81 100644
>> --- a/rust/kernel/iov.rs
>> +++ b/rust/kernel/iov.rs
>> @@ -7,7 +7,12 @@
>>  //! C headers: [`include/linux/iov_iter.h`](srctree/include/linux/iov_iter.h),
>>  //! [`include/linux/uio.h`](srctree/include/linux/uio.h)
>>
>> -use crate::{bindings, prelude::*, types::Opaque};
>> +use crate::{
>> +    alloc::{Allocator, Flags},
>> +    bindings,
>> +    prelude::*,
>> +    types::Opaque,
>> +};
>>  use core::{marker::PhantomData, mem::MaybeUninit, slice};
>>
>>  const ITER_SOURCE: bool = bindings::ITER_SOURCE != 0;
>> @@ -168,3 +173,136 @@ fn clone(&self) -> IovIterSource<'data> {
>>          unsafe { core::ptr::read(self) }
>>      }
>>  }
>> +
>> +/// An IO vector that acts as a destination for data.
>> +///
>> +/// # Invariants
>> +///
>> +/// Must hold a valid `struct iov_iter` with `data_source` set to `ITER_DEST`. The buffers
>> +/// referenced by the IO vector must be valid for writing for the duration of `'data`.
>> +///
>> +/// Note that if the IO vector is backed by a userspace pointer, it is always considered valid for
>> +/// writing.
>> +#[repr(transparent)]
>> +pub struct IovIterDest<'data> {
>> +    iov: Opaque<bindings::iov_iter>,
>> +    /// Represent to the type system that this value contains a pointer to writable data it does
>> +    /// not own.
>> +    _source: PhantomData<&'data mut [u8]>,
>> +}
>
> It might be a bit nicer to add a (private) struct 'IovIter' that implements the common operations.
> Then 'IovIterDest' and 'IovIterSource' could store that struct and forward the implementations to
> it.
> But I'm not sure if that's really much better.

Yea, I was thinking the same. Maybe we could have an `IovInner` and a
local `AsIovInner` trait that would give all the shared methods?

I am sure Alice knows the idiomatic way to achieve code sharing here.


Best regards,
Andreas Hindborg




