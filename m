Return-Path: <linux-kernel+bounces-516163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A422A36D83
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 11:59:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E611188CF68
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 11:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0F0E1A5B8B;
	Sat, 15 Feb 2025 10:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LUSl3slT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8114A08;
	Sat, 15 Feb 2025 10:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739617187; cv=none; b=XH68jjXRYaa6D74I+9Y/o1LECZ6p2hxI3AtkB5MJz1FvIFKkgyHrHmhAtRG0lee0BF9M+jTxqqL5Laj8uqpzfO4pwp6MuTA85HIL3qmgQAn7v1JrWn7LCAgwyBRjzXd4vGeHlXG/a7fBFh4tozzSnWJWK6T0yUNWwwQj4VILpxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739617187; c=relaxed/simple;
	bh=IlbUBSOJy8hOCCuGT+m8jqc2wR8Ma7WO/ztuxQvUf0U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kGG8PxAX3ifySvVNNG69Q00smdXXOtNqrAAwqvY2qrPhS4h5W1u/QZn2ActdzjOgfR+1wYALqtmu1u/cmtkgSShitx8L0gGO3UUoZZAInObXhQ3DjqIARaJ1V4m5DwtGF2Ar6UylfFq7teFgBFoYoDSnZeuwVALfCkiiVz4PSwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LUSl3slT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95D3FC4CEDF;
	Sat, 15 Feb 2025 10:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739617186;
	bh=IlbUBSOJy8hOCCuGT+m8jqc2wR8Ma7WO/ztuxQvUf0U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=LUSl3slT0ZUUyJPm7yt5eaId153RO4WYRqzjHXQnrQeuhhxrWfvCWEFnYSKAFFs69
	 Fgoz2B8bbtcoHXkA/00gDJM0kpaOLFd2rOz/LNYnzQSWQTBbXKCYGSpl69w4qSPSRZ
	 vjq5CNs/2HOaMJ/6ar8xOK7B5eMRXguifXOJSvf72Xk7Xc6lBI14oUoelBOqgowmr2
	 Y8FqG912N9T5XlQ+WO1P5APZYHqR2sAW7HAwBSaS25ON6+iZTGTRmCRVunZz9O2h8l
	 6MWY6hmUsemRgsCtqvti5mKeRb5snng2PFK/2JTNydoqumLbFZujehPiLJzX7/QGQ5
	 dyiWZjtfbKKwA==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Lyude Paul" <lyude@redhat.com>
Cc: "Miguel Ojeda" <ojeda@kernel.org>,  "Anna-Maria Behnsen"
 <anna-maria@linutronix.de>,  "Frederic Weisbecker" <frederic@kernel.org>,
  "Thomas Gleixner" <tglx@linutronix.de>,  "Danilo Krummrich"
 <dakr@kernel.org>,  "Alex Gaynor" <alex.gaynor@gmail.com>,  "Boqun Feng"
 <boqun.feng@gmail.com>,  "Gary Guo" <gary@garyguo.net>,  =?utf-8?Q?Bj?=
 =?utf-8?Q?=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  "Benno Lossin" <benno.lossin@proton.me>,
  "Alice Ryhl" <aliceryhl@google.com>,  "Trevor Gross" <tmgross@umich.edu>,
  "Guangbo Cui" <2407018371@qq.com>,  "Dirk Behme" <dirk.behme@gmail.com>,
  "Daniel Almeida" <daniel.almeida@collabora.com>,  "Tamir Duberstein"
 <tamird@gmail.com>,  <rust-for-linux@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 04/14] rust: hrtimer: implement `HrTimerPointer` for
 `Arc`
In-Reply-To: <4ce7b3dcbac5ba71d3f58d72f3c01d250da784e7.camel@redhat.com>
	(Lyude Paul's message of "Mon, 10 Feb 2025 17:28:45 -0500")
References: <20250203-hrtimer-v3-v6-12-rc2-v7-0-189144725399@kernel.org>
	<20250203-hrtimer-v3-v6-12-rc2-v7-4-189144725399@kernel.org>
	<5J6GLBNLTKE7HjIIlETU_xZcmzd9Nr1riVbm43DFR6LqAC_YnxQAMqMx8_QGZAqJ4wbTUkzHVn3Yra_irTB0Hg==@protonmail.internalid>
	<4ce7b3dcbac5ba71d3f58d72f3c01d250da784e7.camel@redhat.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Sat, 15 Feb 2025 11:35:08 +0100
Message-ID: <874j0vv6lf.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Lyude Paul" <lyude@redhat.com> writes:

> On Mon, 2025-02-03 at 16:07 +0100, Andreas Hindborg wrote:
>> This patch allows the use of intrusive `hrtimer` fields in structs that are
>> managed by an `Arc`.
>>
>> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
>> ---
>>  rust/kernel/time/hrtimer.rs     |  3 +-
>>  rust/kernel/time/hrtimer/arc.rs | 89 +++++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 91 insertions(+), 1 deletion(-)
>>
>> diff --git a/rust/kernel/time/hrtimer.rs b/rust/kernel/time/hrtimer.rs
>> index a6332924efabd40c475a112bbc434db77596a16f..3494c00481a4bd25735edf44b6bdcbec9810243e 100644
>> --- a/rust/kernel/time/hrtimer.rs
>> +++ b/rust/kernel/time/hrtimer.rs
>> @@ -119,7 +119,6 @@ unsafe fn raw_get(ptr: *const Self) -> *mut bindings::hrtimer {
>>      /// # Safety
>>      ///
>>      /// `self_ptr` must point to a valid `Self`.
>> -    #[allow(dead_code)]
>>      pub(crate) unsafe fn raw_cancel(self_ptr: *const Self) -> bool {
>>          // SAFETY: timer_ptr points to an allocation of at least `HrTimer` size.
>>          let c_timer_ptr = unsafe { HrTimer::raw_get(self_ptr) };
>> @@ -310,3 +309,5 @@ unsafe fn raw_get_timer(ptr: *const Self) ->
>>          }
>>      }
>>  }
>> +
>> +mod arc;
>> diff --git a/rust/kernel/time/hrtimer/arc.rs b/rust/kernel/time/hrtimer/arc.rs
>> new file mode 100644
>> index 0000000000000000000000000000000000000000..d1c90631d00362bdc38be1ccc75429ae294ab544
>> --- /dev/null
>> +++ b/rust/kernel/time/hrtimer/arc.rs
>> @@ -0,0 +1,89 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +use super::HasHrTimer;
>> +use super::HrTimer;
>> +use super::HrTimerCallback;
>> +use super::HrTimerHandle;
>> +use super::HrTimerPointer;
>> +use super::RawHrTimerCallback;
>> +use crate::sync::Arc;
>> +use crate::sync::ArcBorrow;
>> +use crate::time::Ktime;
>> +
>> +/// A handle for an `Arc<HasHrTimer<T>>` returned by a call to
>> +/// [`HrTimerPointer::start`].
>> +pub struct ArcHrTimerHandle<T>
>> +where
>> +    T: HasHrTimer<T>,
>> +{
>> +    pub(crate) inner: Arc<T>,
>> +}
>> +
>
> BTW - I noticed the other day that it doesn't seem like we actually expose
> this type to users anywhere, even though we would want access to it for
> storing the timer handle in structures
>

Thanks for noticing! I'll make sure to `pub use` then handles in the
parent module.


Best regards,
Andreas Hindborg




