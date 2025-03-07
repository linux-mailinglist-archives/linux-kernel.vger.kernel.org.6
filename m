Return-Path: <linux-kernel+bounces-551119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AB6EA5686C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 14:04:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E2F11884F05
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 13:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D662B21A445;
	Fri,  7 Mar 2025 13:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="Tinrj+6e"
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F5821A426
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 13:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741352602; cv=none; b=FEfbGouRZTFn8gbrwzdt7Qq66S+ShiCTviZfO/IsHN5t+fHC1aNcLzkSVDkLSk0Z8hZ7KKEsMhWy5Gjs8r6G2d+kKUmt3ZWlJMQgPmagwKm/m57KKFYq1Jrc7yFyg3Fr1CAMsvz5GIWeXGfBeSUtCUwyC5uk0KItnacUEkZs2jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741352602; c=relaxed/simple;
	bh=pqSaeOV+9h+L8403zJLJ7WNksnJHK55F9wFwo8FyymY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pN1aAg/yYjjzSL3cFRjnctlXJrSFy/JHpafXzZWKvSU1dwT7K5RznRhc+7Fp9rPTPTwJnYsLgQWbNpt+O6nBFRlpbSLXiPUaNxAWgUYj+SprSbyFLqWzQaVAfsbuZokYZtbU0rErkJ6cJlVKthG2MVp1q/F7gi2VeTfKe4+2oBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=Tinrj+6e; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=catky55usfc4jepym7gvk5vyj4.protonmail; t=1741352592; x=1741611792;
	bh=0vwc3sb2Vym8CTIv60MJhLOKNA4cpM6/qDwe1bhoQG8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=Tinrj+6er2T85rvq6k276L42blgQtHQDKZRZHT2inJ/iwy4HFtj8MmLzXtoISEi0e
	 TjWiDYRk97lktg3JT7V4jUyQuv8cTLJEqmqkvCFRgABgrMlRXEBh7pS/yLhj6z61Gu
	 9zGPEB903udO2WsOG6xvZQls3tTtukI+RHmKe9Ecm5XbmPz3izap2LTfoYMpSgxIuw
	 achoIh9Ue+PNIwkHxz7ORmU/hgAol0maXWtjlFV+MI5TsEFoYVsnyL2aeRaEbOhcfO
	 aXlrmg22+JJceHvcqikKEWDqoktdK+iJiZmmE1O2hoyHyjQvRzVraI7/qe6OARoCMa
	 ZAHeJGPIDAHBw==
Date: Fri, 07 Mar 2025 13:03:06 +0000
To: Andreas Hindborg <a.hindborg@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Danilo Krummrich <dakr@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Lyude Paul <lyude@redhat.com>, Guangbo Cui <2407018371@qq.com>, Dirk Behme <dirk.behme@gmail.com>, Daniel Almeida <daniel.almeida@collabora.com>, Tamir Duberstein <tamird@gmail.com>, Markus Elfring <Markus.Elfring@web.de>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 03/13] rust: hrtimer: implement `HrTimerPointer` for `Arc`
Message-ID: <D8A1Z043VPGR.2OBGSBH1ALUL6@proton.me>
In-Reply-To: <20250307-hrtimer-v3-v6-12-rc2-v10-3-0cf7e9491da4@kernel.org>
References: <20250307-hrtimer-v3-v6-12-rc2-v10-0-0cf7e9491da4@kernel.org> <20250307-hrtimer-v3-v6-12-rc2-v10-3-0cf7e9491da4@kernel.org>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 121c5d33c23670a72c1d3b48d8496542ace082b3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri Mar 7, 2025 at 11:11 AM CET, Andreas Hindborg wrote:
> +impl<T> HrTimerPointer for Arc<T>
> +where
> +    T: 'static,
> +    T: Send + Sync,
> +    T: HasHrTimer<T>,
> +    T: for<'a> HrTimerCallback<Pointer<'a> =3D Self>,
> +    Arc<T>: for<'a> RawHrTimerCallback<CallbackTarget<'a> =3D ArcBorrow<=
'a, T>>,

I don't understand why you need this bound here.

> +{
> +    type TimerHandle =3D ArcHrTimerHandle<T>;
> +
> +    fn start(self, expires: Ktime) -> ArcHrTimerHandle<T> {
> +        // SAFETY:
> +        //  - We keep `self` alive by wrapping it in a handle below.
> +        //  - Since we generate the pointer passed to `start` from a val=
id
> +        //    reference, it is a valid pointer.
> +        unsafe { T::start(Arc::as_ptr(&self), expires) };
> +        ArcHrTimerHandle { inner: self }
> +    }
> +}
> +
> +impl<T> RawHrTimerCallback for Arc<T>
> +where
> +    T: 'static,
> +    T: HasHrTimer<T>,
> +    T: for<'a> HrTimerCallback<Pointer<'a> =3D Self>,
> +{
> +    type CallbackTarget<'a> =3D ArcBorrow<'a, T>;
> +
> +    unsafe extern "C" fn run(ptr: *mut bindings::hrtimer) -> bindings::h=
rtimer_restart {
> +        // `HrTimer` is `repr(C)`
> +        let timer_ptr =3D ptr.cast::<super::HrTimer<T>>();
> +
> +        // SAFETY: By C API contract `ptr` is the pointer we passed when
> +        // queuing the timer, so it is a `HrTimer<T>` embedded in a `T`.
> +        let data_ptr =3D unsafe { T::timer_container_of(timer_ptr) };
> +
> +        // SAFETY: `data_ptr` points to the `T` that was used to queue t=
he
> +        // timer. This `T` is contained in an `Arc`.

You're not justifying all safety requirements of `ArcBorrow::from_raw`.

---
Cheers,
Benno

> +        let receiver =3D unsafe { ArcBorrow::from_raw(data_ptr) };
> +
> +        T::run(receiver);
> +
> +        bindings::hrtimer_restart_HRTIMER_NORESTART
> +    }
> +}
>
> --
> 2.47.0



