Return-Path: <linux-kernel+bounces-528659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ECA6A41A5E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 11:11:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90BB13AB861
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 10:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 261A924BBF7;
	Mon, 24 Feb 2025 10:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="nsh21lt8"
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B777F18C924;
	Mon, 24 Feb 2025 10:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740391608; cv=none; b=BWMcsKCYB8Buzb/x9SKBWfh7qPCHUnfpfmPoAY7FLtCgsgFLoI7Jpt542rVqhRFAjk9sjxAPUNN6kjHRZSzMstbSRp1ezEF1PmLHEk8h8XMtN/gmzGgO3bfjYIOumE9doiUwCEWq/TPGkRm6e3ufuUpBgrthlB0gphKFQ0hE/CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740391608; c=relaxed/simple;
	bh=iG0pOq7skTua110Kfdnnzrm6EfHdFkinT2pLrXudrJg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kz3pdejsTdF2jTMRKGA3AO6xxfjXOGHGEjpG1XYuzWml21SyHCeyGCw2QKeQgh/FFyWJbYzHp0GIRQNGPWCVxktzHgo757TBjt4g8kcBqXWiAnssKTEbrWxMQ16LDgbt4Tki/nYmUnekDL22aQhJ8DtGvWmZ59Hcblce08xtuE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=nsh21lt8; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=2eggbcunrrgmnef7zk3fuhzcjm.protonmail; t=1740391598; x=1740650798;
	bh=yBthN9NjWnE1WZ5jO+aZCi8NljUP2Ml09wtArQ+KDzo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=nsh21lt8d3j7AJIXOZnv+HKf4AQPP/Vc7IlakTcJqfMcvosWTSHoPpTbRCNXEs2A4
	 WjEuUJVyrU5JuWPhINhN5X2aGFiJPHVVRThVHuY8z4C2y5wo8ET4wtjOybHhBH6cK2
	 3iGFm0UeBVnwIxo0cSGZD34k+gTBXJADsqo0+8B+C/+wBp+/A7AmYYeEH6FaHrSK75
	 C4ImrW4UIrngBwlV446UQPh1WeBaXJZNMrA2Kjec0MKjDxVARAP3IQcKyrCGiuDkXK
	 VLWou/x84rtjBZakA95Gs/hQEcpCDbq3KSeDxzuU1srKMLzCMe7AVe0a1xQmWDLXBS
	 sa8+OfgWA829Q==
Date: Mon, 24 Feb 2025 10:06:35 +0000
To: Andreas Hindborg <a.hindborg@kernel.org>, Boqun Feng <boqun.feng@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>
Subject: Re: [PATCH] rust: sync: lock: Add an example for Guard::lock_ref()
Message-ID: <304505cb-9f68-4d34-b4f1-7d703baba012@proton.me>
In-Reply-To: <87wmdf22ae.fsf@kernel.org>
References: <20250223072114.3715-1-boqun.feng@gmail.com> <87wmdf22ae.fsf@kernel.org>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 44a2cd62d22bf5bd2b7781e011132f4265e83c73
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 24.02.25 09:08, Andreas Hindborg wrote:
> Boqun Feng <boqun.feng@gmail.com> writes:
>=20
>> To provide examples on usage of `Guard::lock_ref()` along with the unit
>> test, an "assert a lock is held by a guard" example is added.
>>
>> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
>> ---
>> This depends on Alice's patch:
>>
>> =09https://lore.kernel.org/all/20250130-guard-get-lock-v1-1-8ed87899920a=
@google.com/
>>
>> I'm also OK to fold this in if Alice thinks it's fine.
>>
>>  rust/kernel/sync/lock.rs | 24 ++++++++++++++++++++++++
>>  1 file changed, 24 insertions(+)
>>
>> diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
>> index 3701fac6ebf6..6d868e35b0a3 100644
>> --- a/rust/kernel/sync/lock.rs
>> +++ b/rust/kernel/sync/lock.rs
>> @@ -201,6 +201,30 @@ unsafe impl<T: Sync + ?Sized, B: Backend> Sync for =
Guard<'_, T, B> {}
>>
>>  impl<'a, T: ?Sized, B: Backend> Guard<'a, T, B> {
>>      /// Returns the lock that this guard originates from.
>> +    ///
>> +    /// # Examples
>> +    ///
>> +    /// The following example shows how to use [`Guard::lock_ref()`] to=
 assert the corresponding
>> +    /// lock is held.
>> +    ///
>> +    /// ```
>> +    /// # use kernel::{new_spinlock, stack_pin_init, sync::lock::{Backe=
nd, Guard, Lock}};
>> +    ///
>> +    /// fn assert_held<T, B: Backend>(guard: &Guard<'_, T, B>, lock: &L=
ock<T, B>) {
>> +    ///     // Address-equal means the same lock.
>> +    ///     assert!(core::ptr::eq(guard.lock_ref(), lock));
>> +    /// }
>=20
> This seems super useful. Perhaps add this method as part of the lock api
> instead of just having it in the example?

I don't think it should be an assert. Instead make it return a
`Result<(), ()>`. (or create better named unit error types)

---
Cheers,
Benno


