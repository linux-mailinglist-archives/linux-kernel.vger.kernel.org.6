Return-Path: <linux-kernel+bounces-333125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B208697C436
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 08:19:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7564B2832F1
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 06:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34B3918B492;
	Thu, 19 Sep 2024 06:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GXg+Ohdl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D261804F;
	Thu, 19 Sep 2024 06:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726726759; cv=none; b=orrLXlxoG7dIbqajmgquAe6Q1Xhd3dZ7L8qsFIPHb2yQdHTClq+wI0K2wZuY7+o8+romwvNF46QyO/PhLg4+wPDZoqKKuUYpdleSx8Yv+72XQBnXw5e8TW+4kSM5tX8gnJHCNv7qFWj0g9ksM7Q9OCGbHqnojWv+7N1VhgELsx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726726759; c=relaxed/simple;
	bh=O3+KD1aEgMlytNwpJ/m3GJud5SAVm2MTMn9TmKmaVLA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lFmYj7/Q+utzcBgyTpzZUfRj8WS3ZULHaZ4vjFyP5MM5tijZ23VENU0QWnzM48o4YAoDYTuSt7SAC6cuNUZ098Zw7Esea39A8KwZtHQFtSB/V6H3Bk8xtsNKavx1FOoF4H9Fw09QmVbt+TO9BFGGKhBfYFrblNBGdoue38QVof8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GXg+Ohdl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DD68C4CEC4;
	Thu, 19 Sep 2024 06:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726726759;
	bh=O3+KD1aEgMlytNwpJ/m3GJud5SAVm2MTMn9TmKmaVLA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=GXg+Ohdlm3GwqVscJQJbWybf4ilppyhpX1sPlnv4WLAkhGkBOypmfIQtTq6av8NUX
	 yNXE4sjQp1uiCUU82nApV0a/3sFJPYmpBqobOL0fihuVZxlB3ATwXjO8a4b0NALsSu
	 H+GVk2xLZT5toO4HLn1eCpG4zg5duMqw6snbjewQEcIOrsbd9ntmifurfAiR27f9uG
	 m75RiIV6WQxxk1CFGTZClR+pBXIq8RGTieRUCHiBfLZ8DDmEpgXm7mR95pC4INLZ3l
	 LkzMKPL0dEumTZgc299EM7jarhkaXvuJrkQBs7PBXVMW62ZZRN7KBlb2FRmICIMs4R
	 J/ne0E+nC31uQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Benno Lossin" <benno.lossin@proton.me>
Cc: "Miguel Ojeda" <ojeda@kernel.org>,  "Alex Gaynor"
 <alex.gaynor@gmail.com>,  "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
  "Frederic Weisbecker" <frederic@kernel.org>,  "Thomas Gleixner"
 <tglx@linutronix.de>,  "Boqun Feng" <boqun.feng@gmail.com>,  "Gary Guo"
 <gary@garyguo.net>,  =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  "Alice
 Ryhl" <aliceryhl@google.com>,  <rust-for-linux@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 04/14] rust: sync: add `Arc::clone_from_raw`
In-Reply-To: <874j6cjiip.fsf@kernel.org> (Andreas Hindborg's message of "Thu,
	19 Sep 2024 07:54:06 +0200")
References: <20240917222739.1298275-1-a.hindborg@kernel.org>
	<20240917222739.1298275-5-a.hindborg@kernel.org>
	<uQyhqKNsbshVFUyAbdqOai1BfuYEl6ygcM8T-tTRf2rvmh6yIVNKqODmQavLegAedRUKVZ8JZoe7O-obhoz3Uw==@protonmail.internalid>
	<43b9bc9b-f64c-4421-8cf2-795f1f0ec94a@proton.me>
 <874j6cjiip.fsf@kernel.org>
Date: Thu, 19 Sep 2024 08:19:14 +0200
Message-ID: <87v7ysi2sd.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Andreas Hindborg <a.hindborg@kernel.org> writes:

> "Benno Lossin" <benno.lossin@proton.me> writes:
>
>> On 18.09.24 00:27, Andreas Hindborg wrote:
>>> Add a method to clone an arc from a pointer to the data managed by the
>>> `Arc`.
>>>
>>> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
>>> ---
>>>  rust/kernel/sync/arc.rs | 20 ++++++++++++++++++++
>>>  1 file changed, 20 insertions(+)
>>>
>>> diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
>>> index a57ea3e2b44c..2c95712d12a2 100644
>>> --- a/rust/kernel/sync/arc.rs
>>> +++ b/rust/kernel/sync/arc.rs
>>> @@ -282,6 +282,26 @@ pub unsafe fn from_raw(ptr: *const T) -> Self {
>>>          unsafe { Self::from_inner(ptr) }
>>>      }
>>>
>>> +    /// Clones an [`Arc`] instance from a pointer to the contained data.
>>> +    ///
>>> +    /// # Safety
>>> +    ///
>>> +    /// `ptr` must point to an allocation that is contained within a live [`Arc<T>`].
>>> +    pub unsafe fn clone_from_raw(ptr: *const T) -> Self {
>>> +        // SAFETY: The caller promises that this pointer points to data
>>> +        // contained in an `Arc` that is still valid.
>>> +        let inner = unsafe { ArcInner::container_of(ptr).as_ref() };
>>> +
>>> +        // INVARIANT: C `refcount_inc` saturates the refcount, so it cannot
>>> +        // overflow to zero. SAFETY: By the function safety requirement, there
>>> +        // is necessarily a reference to the object, so it is safe to increment
>>> +        // the refcount.
>>> +        unsafe { bindings::refcount_inc(inner.refcount.get()) };
>>> +
>>> +        // SAFETY: We just incremented the refcount. This increment is now owned by the new `Arc`.
>>> +        unsafe { Self::from_inner(inner.into()) }
>>
>> The implementation of this function looks a bit strange to me, how about
>> this?:
>>
>>     // SAFETY: this function has the same safety requirements as `from_raw`.
>>     let arc = unsafe { Self::from_raw(ptr) };
>>     let clone = arc.clone();
>>     // Prevent decrementing the refcount.
>>     mem::forget(arc);
>>     clone
>>
>
> We do not own
> a refcount on the Arc. For a short duration you will have a wrong
> refcount. If you have two Arcs and the refcount is 1, the ArcInner might
> be dropped after the first line of this suggestion, before you do clone,
> and then this is not sound.

Well, disregard that. This is why one should not reply to emails before
coffee in the morning.

Of course, a precondition for calling this function is that the arc
containing the data pointed to by `ptr` is live for the duration. So
what you wrote would work. But I still do not like having two `Arc`s in
existence with the wrong refcount. 

BR Andreas


