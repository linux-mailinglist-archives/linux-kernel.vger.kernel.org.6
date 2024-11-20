Return-Path: <linux-kernel+bounces-416033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77D149D3F65
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 16:53:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C52528421F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 15:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEB87153BF7;
	Wed, 20 Nov 2024 15:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FDSIq9Js"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A2B1537C3;
	Wed, 20 Nov 2024 15:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732117931; cv=none; b=C4CryXEO5jEouodHGnI/8Qz/IpGmdtgQuah0KtMtLPZJhvUDDYIIHrZG2I5Z2xsw7US2zESJuGZCsDi8XDmHOhRQe4x0P9GZG06alwhLxQ39a6AIM/Zck8hXxl6QKKnFWK89QNRZrHdQ8Sl/HnDE+rOWfMiRYAbm/MnNKdeOMPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732117931; c=relaxed/simple;
	bh=IJeJGlSRTbQPQK6NydCeBy8hyj/A1Wvc9kkhQnwqGnM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eA2CTAdHkiMEK7GYLXDL7ojjj9/awndpgXjoPOtl78Cih6oNzKo7VaEeYKGiHNlJJae2KiZhfwjA3UBQXZseunRD4fxNNh/2NgYAyfpNbRYeo+NvxE6Rc2jg9Em14uV3L9X9xd7p+zi3syJEwr76csFv2tgecugNNIxC0btkfDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FDSIq9Js; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ACFCC4CECE;
	Wed, 20 Nov 2024 15:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732117930;
	bh=IJeJGlSRTbQPQK6NydCeBy8hyj/A1Wvc9kkhQnwqGnM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=FDSIq9JswBEZJqmvF8GDg1/oUc97tEejHD12OLse33HyhXqS/MpMG0CShR9vFqJ0c
	 eX0cP7RRb3d2U5Hf1h11BCnF+Hu4jWPiZrOEgvu4jCHwe/N+j4R8QZ88XFJvR0r5ip
	 27Sn4aDGU2nzHNceLLP4HS+KF+zzYWQgDA241ik29rAHuwHW2N+ti+n09xImDfdJaa
	 0eS7C3Uqmj2b3EjyqFsw664mCWX2N2XCtRbBhBEcFeXccdDp+n+J7ymDmqMjSb/7C+
	 TleN63QhKt/Q8dNiyEGZCiXsvm0MfSSwj/T3RlIZO+JxcdBge5NshDY9FdoCw+V1zX
	 mW9WwwNuK2kOw==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Lyude Paul" <lyude@redhat.com>
Cc: "Miguel Ojeda" <ojeda@kernel.org>,  "Anna-Maria Behnsen"
 <anna-maria@linutronix.de>,  "Frederic Weisbecker" <frederic@kernel.org>,
  "Thomas Gleixner" <tglx@linutronix.de>,  "Alex Gaynor"
 <alex.gaynor@gmail.com>,  "Boqun Feng" <boqun.feng@gmail.com>,  "Gary Guo"
 <gary@garyguo.net>,  =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  "Benno
 Lossin" <benno.lossin@proton.me>,  "Alice Ryhl" <aliceryhl@google.com>,
  "Trevor Gross" <tmgross@umich.edu>,  <rust-for-linux@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 04/13] rust: hrtimer: implement `TimerPointer` for `Arc`
In-Reply-To: <73814ac7e363af44ae6e410f101feb75e94244ef.camel@redhat.com>
	(Lyude Paul's message of "Wed, 13 Nov 2024 18:24:55 -0500")
References: <20241017-hrtimer-v3-v6-12-rc2-v3-0-59a75cbb44da@kernel.org>
	<20241017-hrtimer-v3-v6-12-rc2-v3-4-59a75cbb44da@kernel.org>
	<25I5c2B_KkmqpaLqb6jsZyMd9WMhQbTaIKyUYY5cKa8bvR7--HvRiXJ_5cDiyde31tnivT5_C_5IJ6XvLqCusA==@protonmail.internalid>
	<73814ac7e363af44ae6e410f101feb75e94244ef.camel@redhat.com>
Date: Wed, 20 Nov 2024 16:22:00 +0100
Message-ID: <874j423p7r.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Lyude Paul" <lyude@redhat.com> writes:

> On Thu, 2024-10-17 at 15:04 +0200, Andreas Hindborg wrote:
>> This patch allows the use of intrusive `hrtimer` fields in structs that are
>> managed by an `Arc`.
>>
>> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
>> ---
>>  rust/kernel/hrtimer.rs     |  3 +-
>>  rust/kernel/hrtimer/arc.rs | 89 ++++++++++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 91 insertions(+), 1 deletion(-)
>>
>> diff --git a/rust/kernel/hrtimer.rs b/rust/kernel/hrtimer.rs
>> index 99058a690f2e18b5c26c94c71133407019aa4a26..6427b0450c694105190c8cddea0c768ab195aca2 100644
>> --- a/rust/kernel/hrtimer.rs
>> +++ b/rust/kernel/hrtimer.rs
>> @@ -107,7 +107,6 @@ unsafe fn raw_get(ptr: *const Self) -> *mut bindings::hrtimer {
>>      /// # Safety
>>      ///
>>      /// `self_ptr` must point to a valid `Self`.
>> -    #[allow(dead_code)]
>>      pub(crate) unsafe fn raw_cancel(self_ptr: *const Self) -> bool {
>>          // SAFETY: timer_ptr points to an allocation of at least `Timer` size.
>>          let c_timer_ptr = unsafe { Timer::raw_get(self_ptr) };
>> @@ -302,3 +301,5 @@ unsafe fn raw_get_timer(ptr: *const Self) ->
>>          }
>>      }
>>  }
>> +
>> +mod arc;
>> diff --git a/rust/kernel/hrtimer/arc.rs b/rust/kernel/hrtimer/arc.rs
>> new file mode 100644
>> index 0000000000000000000000000000000000000000..881de053ecad866a26e46a0123ec2bf38511c2bc
>> --- /dev/null
>> +++ b/rust/kernel/hrtimer/arc.rs
>> @@ -0,0 +1,89 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +use super::HasTimer;
>> +use super::RawTimerCallback;
>> +use super::Timer;
>> +use super::TimerCallback;
>> +use super::TimerHandle;
>> +use super::TimerPointer;
>> +use crate::sync::Arc;
>> +use crate::sync::ArcBorrow;
>> +use crate::time::Ktime;
>
> Is there a reason you're using separate lines for each include instead of
> grouping them together by module?

No particular reason. It is often easier to rebase things around when
they are on their own line.

Are there any code guidelines to follow on this?


Best regards,
Andreas Hindborg



