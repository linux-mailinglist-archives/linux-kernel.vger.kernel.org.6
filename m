Return-Path: <linux-kernel+bounces-551261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92DC4A56A2F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 15:20:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6CC0167C1B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 14:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A52021B8F5;
	Fri,  7 Mar 2025 14:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SaR2hhRV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8FF410A1F;
	Fri,  7 Mar 2025 14:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741357230; cv=none; b=lGCPGHtz9UYOSv/JmEKm5jx2bAvdA20fAMyPdrBGKB9tio2824Xq0JYwMFpXIqStWpXwUz5pDj/TXlqIqNjeK6Oan9rjyhZNKaO5e3L+0QMfNenhve0kIhT2pEDH2PIOugL5869loze3qmq8j89A5o9x95lD/bpXsIvBt6+zaTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741357230; c=relaxed/simple;
	bh=jZbWa1wTG7Y6KvG5/3TYBZD5pBt0bJYzn2u2Pp08soo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Nb5c96WQ/YAGkmg9ECFwgLUzq2khZcVe8HBeaHvsrGoftrEm/BjnfM2ZcnpVtyMHZqRcv7r1rKV0w2gan8XgtLfUx0dhxLmK2/jjdi3hDNBAZ9UiMPZsy+jvgB0ftuX+dGj47cxIwKkTR5TsC5UawdrMXL/fMqOXPbe6GOjklGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SaR2hhRV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBC18C4CED1;
	Fri,  7 Mar 2025 14:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741357230;
	bh=jZbWa1wTG7Y6KvG5/3TYBZD5pBt0bJYzn2u2Pp08soo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=SaR2hhRVKgOH6St0M56iWe1sEkr2oPND7uijZiUDvtRrGtOjPY01ia43pGeRFOqzd
	 QkPgr4w2+fA6WVnwFIzYTcV9z8oCuj5MMY7KTeLbRPzalUViE4R1ZeLW43yZmFgbiK
	 EjulGaGkFkdOo3yFtNL32lhxvVoEaljGlbgz4L65+4xNsqNF3fF0YEujIPg5iBjmtG
	 QzCEdhjS0zSb2DgTafjRyHVt3P35fZtwFtd+hNe6Ck4a1ElnZtqY5ELkrsqZvYP9jt
	 ca3OrQ94U/foKMyM+y4wo5HD2osCIQTCniM4GRLA/RE7nySIcqTusTlwab/79DdB+n
	 9B/PF1GC1zLRg==
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
Subject: Re: [PATCH v10 08/13] rust: hrtimer: implement
 `UnsafeHrTimerPointer` for `Pin<&mut T>`
In-Reply-To: <D8A2YP4GF2XL.2MN17TTXW6GM1@proton.me> (Benno Lossin's message of
	"Fri, 07 Mar 2025 13:49:43 +0000")
References: <20250307-hrtimer-v3-v6-12-rc2-v10-0-0cf7e9491da4@kernel.org>
	<20250307-hrtimer-v3-v6-12-rc2-v10-8-0cf7e9491da4@kernel.org>
	<sIEuYk9D6r8c2AxgPTpe_uHYrv32dOdTQKwdf_y30USi9BgyaPbWxXV7JgNCf3xSiw4bcz9mcLxwxSKdxCrIRQ==@protonmail.internalid>
	<D8A2YP4GF2XL.2MN17TTXW6GM1@proton.me>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Fri, 07 Mar 2025 15:20:20 +0100
Message-ID: <87o6yc3ot7.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Benno Lossin" <benno.lossin@proton.me> writes:

> On Fri Mar 7, 2025 at 11:11 AM CET, Andreas Hindborg wrote:
>> Allow pinned mutable references to structs that contain a `HrTimer` node to
>> be scheduled with the `hrtimer` subsystem.
>>
>> Acked-by: Frederic Weisbecker <frederic@kernel.org>
>> Reviewed-by: Lyude Paul <lyude@redhat.com>
>> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
>> ---
>>  rust/kernel/time/hrtimer.rs         |   2 +
>>  rust/kernel/time/hrtimer/pin_mut.rs | 101 ++++++++++++++++++++++++++++++++++++
>>  2 files changed, 103 insertions(+)
>>
>> diff --git a/rust/kernel/time/hrtimer.rs b/rust/kernel/time/hrtimer.rs
>> index 2ca56397eade..d2791fd624b7 100644
>> --- a/rust/kernel/time/hrtimer.rs
>> +++ b/rust/kernel/time/hrtimer.rs
>> @@ -441,3 +441,5 @@ unsafe fn timer_container_of(ptr: *mut $crate::time::hrtimer::HrTimer<$timer_typ
>>  pub use arc::ArcHrTimerHandle;
>>  mod pin;
>>  pub use pin::PinHrTimerHandle;
>> +mod pin_mut;
>> +pub use pin_mut::PinMutHrTimerHandle;
>> diff --git a/rust/kernel/time/hrtimer/pin_mut.rs b/rust/kernel/time/hrtimer/pin_mut.rs
>> new file mode 100644
>> index 000000000000..4f4a9e9602d8
>> --- /dev/null
>> +++ b/rust/kernel/time/hrtimer/pin_mut.rs
>> @@ -0,0 +1,101 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +use super::HasHrTimer;
>> +use super::HrTimer;
>> +use super::HrTimerCallback;
>> +use super::HrTimerHandle;
>> +use super::RawHrTimerCallback;
>> +use super::UnsafeHrTimerPointer;
>> +use crate::time::Ktime;
>> +use core::pin::Pin;
>> +
>> +/// A handle for a `Pin<&mut HasHrTimer>`. When the handle exists, the timer might
>> +/// be running.
>> +pub struct PinMutHrTimerHandle<'a, T>
>> +where
>> +    T: HasHrTimer<T>,
>> +{
>> +    pub(crate) inner: Pin<&'a mut T>,
>
> I just noticed, if `T: Unpin`, this is unsound in combination with you
> creating another `Pin<&mut T>` reference below for the callback, since
> then we have two `&mut T` pointing to the same value. So you should
> store a raw pointer instead.

Will fix.


Best regards,
Andreas Hindborg



