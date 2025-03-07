Return-Path: <linux-kernel+bounces-551180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82EE5A5690A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 14:36:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E13F9188E03E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 13:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC7CE219E9E;
	Fri,  7 Mar 2025 13:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="Lmx2LGQ6"
Received: from mail-10628.protonmail.ch (mail-10628.protonmail.ch [79.135.106.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1FA156F5D
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 13:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741354572; cv=none; b=m/y/SlyLinPJSyrIx31/1LqqgFgbkJa52oS4GWB/e5n1Sz+LIC4i1f5uTQz/h9TcIXII0+/o4UyFhBxsFt5CP/Z3FaCh1Aaj9+TbbsN3nI1VElO+UVEglaOqZOYUMI6ANxAyYQgBP7hfh1MD2dmEnk+p9ciLfhPvNEEqWB/FIKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741354572; c=relaxed/simple;
	bh=F6uVQQTg/GPMCJj3N1q6FQSFXPVccU7anjpvAebuj6E=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PiGfY8u0e7v4SCOa8AOX5cGgF0FJe/shEB/5OuOrxFrH8ZMJ9I2dY4JhJJPYlxfbQ/bJy7cpH4Z1wNaHV7nIsvPYIaaPxRWMa2LT8d8JW7yNCR+fDKd3mjGO0ksoocASQEg9gkzOx5IB20pu/mlox+Ig0a8kB6iNkyby6Qv8nCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=Lmx2LGQ6; arc=none smtp.client-ip=79.135.106.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1741354567; x=1741613767;
	bh=WMdWKpGLI1R6XKTpe2LuhfE8N9RSdBk03KBc2gXHbzQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=Lmx2LGQ6dMF0N1W8SRj2DkMiEgUuAIjBHhxEY1KHOnchNCpCH9t1b2WL1CjL6SmqA
	 Zz6vRbFl423zuY0RIXRdgQOpGEmJ1f2YeT+k2vEU+zNH/UxO4lVDI9LFs0N4qtW0KH
	 uVMiaq7rF+wke0k9Bb0RtRHSVoN3+Kjjq4SvJj5nGz2/cBjmdksF7x7lxXRVcH8d0Z
	 Ziy8hyTjGItGBkAnacwwDfc4g3pL0jiJfmNW3+mvuPqidyK8iPzdOguSJ9S/2aTCDP
	 d7VWTdQyrRDzZRLCHikaz1jHhJ2X5hAO29LDpBHPWFqI8Fl0fyqoJOV10aflFJrurT
	 D1sa5nNUE0+hg==
Date: Fri, 07 Mar 2025 13:36:00 +0000
To: Andreas Hindborg <a.hindborg@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Danilo Krummrich <dakr@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Lyude Paul <lyude@redhat.com>, Guangbo Cui <2407018371@qq.com>, Dirk Behme <dirk.behme@gmail.com>, Daniel Almeida <daniel.almeida@collabora.com>, Tamir Duberstein <tamird@gmail.com>, Markus Elfring <Markus.Elfring@web.de>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 03/13] rust: hrtimer: implement `HrTimerPointer` for `Arc`
Message-ID: <D8A2O5QBXCRI.18W3W0EDI3UXZ@proton.me>
In-Reply-To: <87senp3r9b.fsf@kernel.org>
References: <20250307-hrtimer-v3-v6-12-rc2-v10-0-0cf7e9491da4@kernel.org> <20250307-hrtimer-v3-v6-12-rc2-v10-3-0cf7e9491da4@kernel.org> <b-T-Yv_oexMXaKG9kNNfbYz-Qaw1XhJw-VHerSPFp_sIMoztNyAj94_rH-uNYeG-Hc5WANUivDJW9WLmfZZHwA==@protonmail.internalid> <D8A1Z043VPGR.2OBGSBH1ALUL6@proton.me> <87senp3r9b.fsf@kernel.org>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: a31afa1d5c64e2ce0e65e7ee2eb2795b8e6533f1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri Mar 7, 2025 at 2:27 PM CET, Andreas Hindborg wrote:
> "Benno Lossin" <benno.lossin@proton.me> writes:
>
>> On Fri Mar 7, 2025 at 11:11 AM CET, Andreas Hindborg wrote:
>>> +impl<T> HrTimerPointer for Arc<T>
>>> +where
>>> +    T: 'static,
>>> +    T: Send + Sync,
>>> +    T: HasHrTimer<T>,
>>> +    T: for<'a> HrTimerCallback<Pointer<'a> =3D Self>,
>>> +    Arc<T>: for<'a> RawHrTimerCallback<CallbackTarget<'a> =3D ArcBorro=
w<'a, T>>,
>>
>> I don't understand why you need this bound here.
>
> This impl is applicable only when `Arc<T> has an implementation of
> `RawTimerCallback` where CallbackTarget<'a> =3D ArcBorrow<'a, T>. I don't
> want the impl to be available if that is not the case.

The impl below has less strict other bounds than this one, so this bound
doesn't change anything.

> It's just an additional check.

To me it's just additional noise.

>>> +{
>>> +    type TimerHandle =3D ArcHrTimerHandle<T>;
>>> +
>>> +    fn start(self, expires: Ktime) -> ArcHrTimerHandle<T> {
>>> +        // SAFETY:
>>> +        //  - We keep `self` alive by wrapping it in a handle below.
>>> +        //  - Since we generate the pointer passed to `start` from a v=
alid
>>> +        //    reference, it is a valid pointer.
>>> +        unsafe { T::start(Arc::as_ptr(&self), expires) };
>>> +        ArcHrTimerHandle { inner: self }
>>> +    }
>>> +}
>>> +
>>> +impl<T> RawHrTimerCallback for Arc<T>
>>> +where
>>> +    T: 'static,
>>> +    T: HasHrTimer<T>,
>>> +    T: for<'a> HrTimerCallback<Pointer<'a> =3D Self>,
>>> +{
>>> +    type CallbackTarget<'a> =3D ArcBorrow<'a, T>;
>>> +
>>> +    unsafe extern "C" fn run(ptr: *mut bindings::hrtimer) -> bindings:=
:hrtimer_restart {
>>> +        // `HrTimer` is `repr(C)`
>>> +        let timer_ptr =3D ptr.cast::<super::HrTimer<T>>();
>>> +
>>> +        // SAFETY: By C API contract `ptr` is the pointer we passed wh=
en
>>> +        // queuing the timer, so it is a `HrTimer<T>` embedded in a `T=
`.
>>> +        let data_ptr =3D unsafe { T::timer_container_of(timer_ptr) };
>>> +
>>> +        // SAFETY: `data_ptr` points to the `T` that was used to queue=
 the
>>> +        // timer. This `T` is contained in an `Arc`.
>>
>> You're not justifying all safety requirements of `ArcBorrow::from_raw`.
>
> How is this:
>
>         // SAFETY:
>         //  - `data_ptr` is derived form the pointer to the `T` that was =
used to
>         //    queue the timer.
>         //  - The `ArcTimerHandle` associated with this timer is guarante=
ed to
>         //    be alive for the duration of the lifetime of `receiver`, so=
 the

There is no `receiver` in this context?

Is the reason for the handle staying alive that when it is dropped, it
calls `cancel` and that waits until the callback finishes? If so, did
you write that down somewhere here?

>         //    refcount of the underlying `Arc` is guaranteed to be nonzer=
o for
>         //    the duration.
>         //  - We own one refcount in the `ArcTimerHandle` associted with =
this
>         //    timer, so it is not possible to get a `UniqueArc` to this
>         //    allocation from other `Arc` clones.

Otherwise this sounds good.

---
Cheers,
Benno


