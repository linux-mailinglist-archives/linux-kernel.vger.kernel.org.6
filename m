Return-Path: <linux-kernel+bounces-553043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB091A582D0
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 10:50:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40AA9188AC9A
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 09:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C39D81B3922;
	Sun,  9 Mar 2025 09:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jQZZ7z8E"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3171AC43A;
	Sun,  9 Mar 2025 09:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741513830; cv=none; b=g3ybwocqnxkCfh0goiGrcZ7mZM1u4/gNQvpDdfErM96knxaRgF0c6GjpeqjF3vCj7TQ3aRiaeci+Lzu6pg8yShF+sz2DB77fFGa+FSD23kW87CzTHM6PIxrub+RXpuz0Sz2tboQCeE7TAXV+x/Nvp81hZJIpBhl4wkBzu49H8zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741513830; c=relaxed/simple;
	bh=tiwOz2CJXeEBUYBXyjl0p2i46BaZuqvQgxrveRtJGHg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ScBFF0LN5miecnnvFlB6x5L5dJZzTeRyPoh2OrSqVxW0EPJ2+T0QbNrctUbBMYPbHsTIzL1BLcszdT+g4+MwDxJ6EgDAgkR1/jzkdryEsLpfoOl7AsnM9fnzGIKrkznYze65DAZ9/ea+mtgZ4cngspJI/qDGFB8puVdKR6k/9I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jQZZ7z8E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80096C4CEED;
	Sun,  9 Mar 2025 09:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741513829;
	bh=tiwOz2CJXeEBUYBXyjl0p2i46BaZuqvQgxrveRtJGHg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=jQZZ7z8En4yKLZCgZmMQmlYMa0ziakAk81L/oXSBWXZhFoL5h271cptaKzA9lX/nD
	 T31xkehvSO/EK1FgsIO/+AWQMwIFh65LV/ey+vJfEqPE3TuCPHkftZnfmbYKEWVVxe
	 ME/jn50lgO02r0UbnleW2hRH5ZNma5Rd4rnl94B691OuhaBDlm+ywYJeLRv4GIOhPn
	 I6HL99f/9PIPh15sgXci4WeXKjSDeDZRDZgkSz4EYOaREiX/19TnYcDyBIHk+jmdL7
	 Q44ktCWz6zFqZLUiJ+3PMBwGyaE5jIGyzbXxl7e6y37qQsuOTO289JtqKvl6zX3tzU
	 n97fyJ47zX1Ng==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Benno Lossin" <benno.lossin@proton.me>
Cc: "Miguel Ojeda" <ojeda@kernel.org>,  "Anna-Maria Behnsen"
 <anna-maria@linutronix.de>,  "Frederic Weisbecker" <frederic@kernel.org>,
  "Thomas Gleixner" <tglx@linutronix.de>,  "Danilo Krummrich"
 <dakr@kernel.org>,  "Alex Gaynor" <alex.gaynor@gmail.com>,  "Boqun Feng"
 <boqun.feng@gmail.com>,  "Gary Guo" <gary@garyguo.net>,  =?utf-8?Q?Bj?=
 =?utf-8?Q?=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  "Alice Ryhl" <aliceryhl@google.com>,  "Trevor
 Gross" <tmgross@umich.edu>,  "Lyude Paul" <lyude@redhat.com>,  "Guangbo
 Cui" <2407018371@qq.com>,  "Dirk Behme" <dirk.behme@gmail.com>,  "Daniel
 Almeida" <daniel.almeida@collabora.com>,  "Tamir Duberstein"
 <tamird@gmail.com>,  "Markus Elfring" <Markus.Elfring@web.de>,
  <rust-for-linux@vger.kernel.org>,  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v11 08/13] rust: hrtimer: implement
 `UnsafeHrTimerPointer` for `Pin<&mut T>`
In-Reply-To: <D8BMSSM6IGCD.2TWTNMT3D8OT9@proton.me> (Benno Lossin's message of
	"Sun, 09 Mar 2025 09:35:00 +0000")
References: <20250307-hrtimer-v3-v6-12-rc2-v11-0-7934aefd6993@kernel.org>
	<20250307-hrtimer-v3-v6-12-rc2-v11-8-7934aefd6993@kernel.org>
	<mDdj26GcOkyF_DHZKNEf6Q1HfA3BKDP2yfrVlr0zKu8TpJxw3eYs_-Mn9aVmnlEHGPUL_l6KTq2WjKJpjAjqnQ==@protonmail.internalid>
	<D8BMSSM6IGCD.2TWTNMT3D8OT9@proton.me>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Sun, 09 Mar 2025 10:49:15 +0100
Message-ID: <87ldtelejo.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Benno Lossin" <benno.lossin@proton.me> writes:

> On Fri Mar 7, 2025 at 10:38 PM CET, Andreas Hindborg wrote:
>> Allow pinned mutable references to structs that contain a `HrTimer` node to
>> be scheduled with the `hrtimer` subsystem.
>>
>> Acked-by: Frederic Weisbecker <frederic@kernel.org>
>> Reviewed-by: Lyude Paul <lyude@redhat.com>
>> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
>
> One problem below, with that fixed:
>
> Reviewed-by: Benno Lossin <benno.lossin@proton.me>

Thanks, will fix.

>
>> ---
>>  rust/kernel/time/hrtimer.rs         |   2 +
>>  rust/kernel/time/hrtimer/pin_mut.rs | 110 ++++++++++++++++++++++++++++++++++++
>>  2 files changed, 112 insertions(+)
>>
>> diff --git a/rust/kernel/time/hrtimer.rs b/rust/kernel/time/hrtimer.rs
>> index fee8e44447ee..ab0950a964e8 100644
>> --- a/rust/kernel/time/hrtimer.rs
>> +++ b/rust/kernel/time/hrtimer.rs
>> @@ -433,3 +433,5 @@ unsafe fn timer_container_of(
>>  pub use arc::ArcHrTimerHandle;
>>  mod pin;
>>  pub use pin::PinHrTimerHandle;
>> +mod pin_mut;
>> +pub use pin_mut::PinMutHrTimerHandle;
>> diff --git a/rust/kernel/time/hrtimer/pin_mut.rs b/rust/kernel/time/hrtimer/pin_mut.rs
>> new file mode 100644
>> index 000000000000..007f47d26df6
>> --- /dev/null
>> +++ b/rust/kernel/time/hrtimer/pin_mut.rs
>> @@ -0,0 +1,110 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +use super::{
>> +    HasHrTimer, HrTimer, HrTimerCallback, HrTimerHandle, RawHrTimerCallback, UnsafeHrTimerPointer,
>> +};
>> +use crate::time::Ktime;
>> +use core::{marker::PhantomData, pin::Pin, ptr::NonNull};
>> +
>> +/// A handle for a `Pin<&mut HasHrTimer>`. When the handle exists, the timer might
>> +/// be running.
>> +pub struct PinMutHrTimerHandle<'a, T>
>> +where
>> +    T: HasHrTimer<T>,
>> +{
>> +    pub(crate) inner: NonNull<T>,
>> +    _p: PhantomData<&'a T>,
>
> This should be `PhantomData<&'a mut T>`.

Nice catch!



Best regards,
Andreas Hindborg



