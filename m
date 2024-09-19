Return-Path: <linux-kernel+bounces-333115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5645C97C417
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 08:01:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DA221F22C2F
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 06:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6426414B083;
	Thu, 19 Sep 2024 06:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QxGtmo3N"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0BD63BB47;
	Thu, 19 Sep 2024 06:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726725690; cv=none; b=eahr1V1kNnrgdK3bE4ErT/BxpXWuLuNB3bWDs8epvmLbCa5vx4R6Qzfw0GJ/wgl2OshOLXh+bpCD4x6e9g4rsrvWhZnWQkFj4h6oGw4x5DHwPBxxRAqS1gEs9sXZREAUsznBmmLlpP3RemLYKEpgh6jFKpiztF9gXKZ8wec8Rvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726725690; c=relaxed/simple;
	bh=sz+NdboBq3WW4iSwz34dxky2Tt2p6pPpiZJ85/hXboQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pRXadmFTHMjekOSTgMo4zYvQL5py5mH54utEkBwyulZ7IJ1qceopitdEKATdGydS/TEyPjrbMWzW40/gt5CjjwykzekLPL0Cm2Isqjl2mD1DNGWQrLqw16lzSwzyUotHC6KuTXIp+0coI/REWRxvU7yT/+en/G1ohgG4Zb2t2L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QxGtmo3N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99CD5C4CEC4;
	Thu, 19 Sep 2024 06:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726725690;
	bh=sz+NdboBq3WW4iSwz34dxky2Tt2p6pPpiZJ85/hXboQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=QxGtmo3NskYaVczjodFaX5sPXcNZuNtrnzhnmUgmSBmnHLueAfxsLeEYHkt+Ts5bU
	 9ad9wjD+SK5rflq4dI/ThCGfN9wUjdhM+hcGFw3NfSea8rrlOrZmEGCG69umHzyHAB
	 YtT38gYIZNh+hjgcZ7mnvHLKB+Hg0vQRmB9i6V76F4yOlJwG9YpgDwx5gbnHf6REvZ
	 XY2iluqlxEYlrUvyCaegcfxFX1fqX+Y5O6crIbzbZAxKC67hIzB7k0j6l6PnUAW4XR
	 BNUiCKyoRGRI7WENz03vBFIcrXIatQiXPM6Hnvk6XX13p+lszZ3JkM3G2iRFqbhIct
	 8gycgdNAF2QUw==
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
In-Reply-To: <43b9bc9b-f64c-4421-8cf2-795f1f0ec94a@proton.me> (Benno Lossin's
	message of "Wed, 18 Sep 2024 18:19:20 +0000")
References: <20240917222739.1298275-1-a.hindborg@kernel.org>
	<20240917222739.1298275-5-a.hindborg@kernel.org>
	<uQyhqKNsbshVFUyAbdqOai1BfuYEl6ygcM8T-tTRf2rvmh6yIVNKqODmQavLegAedRUKVZ8JZoe7O-obhoz3Uw==@protonmail.internalid>
	<43b9bc9b-f64c-4421-8cf2-795f1f0ec94a@proton.me>
Date: Thu, 19 Sep 2024 07:54:06 +0200
Message-ID: <874j6cjiip.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Benno Lossin" <benno.lossin@proton.me> writes:

> On 18.09.24 00:27, Andreas Hindborg wrote:
>> Add a method to clone an arc from a pointer to the data managed by the
>> `Arc`.
>>
>> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
>> ---
>>  rust/kernel/sync/arc.rs | 20 ++++++++++++++++++++
>>  1 file changed, 20 insertions(+)
>>
>> diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
>> index a57ea3e2b44c..2c95712d12a2 100644
>> --- a/rust/kernel/sync/arc.rs
>> +++ b/rust/kernel/sync/arc.rs
>> @@ -282,6 +282,26 @@ pub unsafe fn from_raw(ptr: *const T) -> Self {
>>          unsafe { Self::from_inner(ptr) }
>>      }
>>
>> +    /// Clones an [`Arc`] instance from a pointer to the contained data.
>> +    ///
>> +    /// # Safety
>> +    ///
>> +    /// `ptr` must point to an allocation that is contained within a live [`Arc<T>`].
>> +    pub unsafe fn clone_from_raw(ptr: *const T) -> Self {
>> +        // SAFETY: The caller promises that this pointer points to data
>> +        // contained in an `Arc` that is still valid.
>> +        let inner = unsafe { ArcInner::container_of(ptr).as_ref() };
>> +
>> +        // INVARIANT: C `refcount_inc` saturates the refcount, so it cannot
>> +        // overflow to zero. SAFETY: By the function safety requirement, there
>> +        // is necessarily a reference to the object, so it is safe to increment
>> +        // the refcount.
>> +        unsafe { bindings::refcount_inc(inner.refcount.get()) };
>> +
>> +        // SAFETY: We just incremented the refcount. This increment is now owned by the new `Arc`.
>> +        unsafe { Self::from_inner(inner.into()) }
>
> The implementation of this function looks a bit strange to me, how about
> this?:
>
>     // SAFETY: this function has the same safety requirements as `from_raw`.
>     let arc = unsafe { Self::from_raw(ptr) };
>     let clone = arc.clone();
>     // Prevent decrementing the refcount.
>     mem::forget(arc);
>     clone
>

We do not own
a refcount on the Arc. For a short duration you will have a wrong
refcount. If you have two Arcs and the refcount is 1, the ArcInner might
be dropped after the first line of this suggestion, before you do clone,
and then this is not sound.

Best regards,
Andreas


