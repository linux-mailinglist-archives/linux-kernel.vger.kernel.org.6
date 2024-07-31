Return-Path: <linux-kernel+bounces-269840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E91494375F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 22:48:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A256DB228D0
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 20:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6EC0168C26;
	Wed, 31 Jul 2024 20:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="TavgKwuM"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4747A16087B;
	Wed, 31 Jul 2024 20:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722458875; cv=none; b=fBtGToW2f5eSG9EAL71BKXzhrYXs8udNG8OYykR+zVt1rPi4Clid/Yar6twfYVAWQwN1EbUjALCpwHBKVMfO1JfqLYYZzlGZ/bbjijWIFNvGcH79/6KXdbdpfb2zpGuY7Mp3CtbOY8AI8sbA8h3AzRfxaHyIjUnoPQlz/csFksk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722458875; c=relaxed/simple;
	bh=T+bxtDsypoLZuohvEpFnoUYBkgJSQsGGu/MQFPg+TOc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T7RVUYUEyKF0bo9F3th48Rdcu8ZE407k2YwAvfphHjmF/NxCeSskOqfsXKJVzzDqwPpyO4cQ/2U+ita1Arjij9VD7wFsTzKgzH4tY7zOH6+Op2mfVwmiVVIq7nr4zno1VCn7XcwW0aiykuFCU2da8haTBw4s3BOj93aGwErJqRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=TavgKwuM; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1722458872; x=1722718072;
	bh=pd9iNbqzsLLrheaLjTGk3cr9YXPx27FeADL9bde0lPQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=TavgKwuMerzXMQg9cvfC/OiJ3ceY/aNT7TA+sFCIQ+V0GtzMvyKc4S/8xSJS6UHFx
	 wm88gNTwEl1ldmBbGVz4/K/hocbVa7J8Rl+j0RdG87nBy3XQDT/WbCEScCUZgX48IP
	 Jmqv64m0o3+kkRluQ3LHy+PzpsXhxsWbODfBhzepAEt7S9vmgUCigKUhMrDpbr02ZT
	 ErGuJKBP4wjJjEKlm9mVE8buvCrc0DZFDC7XEtBGmELWsimUG2nEGf7gm5uWaqGkmc
	 4WxIgjPd5eqp4VJCyfU8yf2SYUgRBTvNiElj4aOb+apoh/quK97+rNkeumdeX7ikYj
	 dCoQt1+hVj07g==
Date: Wed, 31 Jul 2024 20:47:48 +0000
To: Gary Guo <gary@garyguo.net>, Matt Gilbride <mattgilbride@google.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?utf-8?Q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, Christian Brauner <brauner@kernel.org>, Rob Landley <rob@landley.net>, Davidlohr Bueso <dave@stgolabs.net>, Michel Lespinasse <michel@lespinasse.org>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/6] rust: kernel: add `drop_contents` to `BoxExt`
Message-ID: <52cc1987-ec62-46dd-9d81-4afc155fe88f@proton.me>
In-Reply-To: <20240731210206.2b56b432.gary@garyguo.net>
References: <20240711-b4-rbtree-v6-0-14bef1a8cdba@google.com> <20240711-b4-rbtree-v6-1-14bef1a8cdba@google.com> <20240731210206.2b56b432.gary@garyguo.net>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 7db0d0a6009e4b0532f4c4605b81b7899702302c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 31.07.24 22:02, Gary Guo wrote:
> On Thu, 11 Jul 2024 16:20:57 +0000
> Matt Gilbride <mattgilbride@google.com> wrote:
>=20
>> From: Benno Lossin <benno.lossin@proton.me>
>>
>> Sometimes (see [1]) it is necessary to drop the value inside of a
>> `Box<T>`, but retain the allocation. For example to reuse the allocation
>> in the future.
>> Introduce a new function `drop_contents` that turns a `Box<T>` into
>> `Box<MaybeUninit<T>>` by dropping the value.
>>
>> Signed-off-by: Benno Lossin <benno.lossin@proton.me>
>> Link: https://lore.kernel.org/rust-for-linux/20240418-b4-rbtree-v3-5-323=
e134390ce@google.com/ [1]
>> ---
>>  rust/kernel/alloc/box_ext.rs | 24 +++++++++++++++++++++++-
>>  1 file changed, 23 insertions(+), 1 deletion(-)
>>
>> diff --git a/rust/kernel/alloc/box_ext.rs b/rust/kernel/alloc/box_ext.rs
>> index 829cb1c1cf9e..557895db4f48 100644
>> --- a/rust/kernel/alloc/box_ext.rs
>> +++ b/rust/kernel/alloc/box_ext.rs
>> @@ -4,7 +4,7 @@
>>
>>  use super::{AllocError, Flags};
>>  use alloc::boxed::Box;
>> -use core::mem::MaybeUninit;
>> +use core::{mem::MaybeUninit, ptr};
>>
>>  /// Extensions to [`Box`].
>>  pub trait BoxExt<T>: Sized {
>> @@ -17,6 +17,20 @@ pub trait BoxExt<T>: Sized {
>>      ///
>>      /// The allocation may fail, in which case an error is returned.
>>      fn new_uninit(flags: Flags) -> Result<Box<MaybeUninit<T>>, AllocErr=
or>;
>> +
>> +    /// Drops the contents, but keeps the allocation.
>> +    ///
>> +    /// # Examples
>> +    ///
>> +    /// ```
>> +    /// use kernel::alloc::flags;
>> +    ///
>> +    /// let value =3D Box::new([0; 32], flags::GFP_KERNEL);
>> +    /// let value =3D value.unwrap().drop_contents();
>> +    /// // Now we can re-use `value`:
>> +    /// Box::write(value, [1; 32]);
>> +    /// ```
>> +    fn drop_contents(self) -> Box<MaybeUninit<T>>;
>=20
> Should this have signature `fn drop_contents(this: Self) -> ...`? Box
> types normally don't have methods to avoid shadowing functions that the
> pointee may have.

Note that the newest version of this patch can be found at [1]. I agree,
it should probably take `this: Self` instead of a `self` receiver.

@Miguel, do you think I should send a new version with that change?

[1]: https://lore.kernel.org/rust-for-linux/20240708205325.1275473-1-benno.=
lossin@proton.me/

---
Cheers,
Benno

>>  }
>>
>>  impl<T> BoxExt<T> for Box<T> {
>> @@ -53,4 +67,12 @@ fn new_uninit(flags: Flags) -> Result<Box<MaybeUninit=
<T>>, AllocError> {
>>          // zero-sized types, we use `NonNull::dangling`.
>>          Ok(unsafe { Box::from_raw(ptr) })
>>      }
>> +
>> +    fn drop_contents(self) -> Box<MaybeUninit<T>> {
>> +        let ptr =3D Box::into_raw(self);
>> +        // SAFETY: `ptr` is valid, because it came from `Box::into_raw`=
.
>> +        unsafe { ptr::drop_in_place(ptr) };
>> +        // SAFETY: `ptr` is valid, because it came from `Box::into_raw`=
.
>> +        unsafe { Box::from_raw(ptr.cast()) }
>> +    }
>>  }
>>
>=20
> Best,
> Gary


