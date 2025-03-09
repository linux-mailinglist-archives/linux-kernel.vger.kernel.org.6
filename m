Return-Path: <linux-kernel+bounces-553053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6180CA582E5
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 11:04:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46B163ADE00
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 10:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 125B1192B71;
	Sun,  9 Mar 2025 10:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="c8qpYgle"
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B263EAC7
	for <linux-kernel@vger.kernel.org>; Sun,  9 Mar 2025 10:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741514691; cv=none; b=uayRUzXORXm/rAL+FK+rQ/Ha96eWccYSLziczmxAafcH9o1WX3TbRyFHwkyM9jwlR5AojVcD+BiO72twjPFu0QDRr4tUxdfi7c5RkZa9yx/9N2A2+AO4Ciw8ojEVmdh1c4195vwcicm4kx0JFT35NNY87XZ8hFqEYhC+DERyVPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741514691; c=relaxed/simple;
	bh=Y4RzcrAv3C3MxV3ublZX4KngWj4W06t5Aoo73M/dm1g=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bf9ZOlA5Tvojsm/YtJvO0hPxROgpLTdRkbVlgRvOij4/IaIYxadXrBB0m/vVhQv29BlvgiijThFKMi6aGfmD6n75cblevHvTqJZmiw4AyuFtgAtw4SgxilC33/W0PCSkKxLPfYG63QVaGwcHoOJFyK+gd7FMlVl9TpnA3p04ngI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=c8qpYgle; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1741514686; x=1741773886;
	bh=WOMrPVCPm5laEmGEnfGsypH0f9uJg3MVzLautjBZrNc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=c8qpYgleB5OfSHNqeujYY0IZaJ97ylyVSuBwPRuoUBgSzYN8qTBqnzU5mixShkfW4
	 +ukZ0NRwFF7obe/0Q0z+tOXLXcUSJXTM/iU9avU4ZZltoQLiU04zsDVBLIZqQNjrJY
	 QSX9XA4Od+FU1dvMV47r2zPL5YvHwo5oidkUB/fQHfXAI6cq1FMZAil43zbjwQ7SsL
	 UoIXOXqIKVPKqJcZ/dF7NbVQvddaaL95unS5qeEyQGMnIxOrX9/TPIGIuKEnQ81/UA
	 L+qDtRZd3K7IMh09d0XQCrJ0E23bHVazfmiiRiu36RZT4vYtaSaQd6H/kncS9PR//I
	 QADTldYA8jSvQ==
Date: Sun, 09 Mar 2025 10:04:42 +0000
To: Andreas Hindborg <a.hindborg@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Danilo Krummrich <dakr@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Lyude Paul <lyude@redhat.com>, Guangbo Cui <2407018371@qq.com>, Dirk Behme <dirk.behme@gmail.com>, Daniel Almeida <daniel.almeida@collabora.com>, Tamir Duberstein <tamird@gmail.com>, Markus Elfring <Markus.Elfring@web.de>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 08/13] rust: hrtimer: implement `UnsafeHrTimerPointer` for `Pin<&mut T>`
Message-ID: <D8BNFIK9U108.273II0I7NZUG1@proton.me>
In-Reply-To: <20250307-hrtimer-v3-v6-12-rc2-v11-8-7934aefd6993@kernel.org>
References: <20250307-hrtimer-v3-v6-12-rc2-v11-0-7934aefd6993@kernel.org> <20250307-hrtimer-v3-v6-12-rc2-v11-8-7934aefd6993@kernel.org>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: d7f9acef33476035d455c6cabdfd146334573b06
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri Mar 7, 2025 at 10:38 PM CET, Andreas Hindborg wrote:
> +impl<'a, T> RawHrTimerCallback for Pin<&'a mut T>
> +where
> +    T: HasHrTimer<T>,
> +    T: HrTimerCallback<Pointer<'a> =3D Self>,
> +{
> +    type CallbackTarget<'b> =3D Self;
> +
> +    unsafe extern "C" fn run(ptr: *mut bindings::hrtimer) -> bindings::h=
rtimer_restart {
> +        // `HrTimer` is `repr(C)`
> +        let timer_ptr =3D ptr as *mut HrTimer<T>;
> +
> +        // SAFETY: By the safety requirement of this function, `timer_pt=
r`
> +        // points to a `HrTimer<T>` contained in an `T`.
> +        let receiver_ptr =3D unsafe { T::timer_container_of(timer_ptr) }=
;
> +
> +        // SAFETY:
> +        //  - By the safety requirement of this function, `timer_ptr`
> +        //    points to a `HrTimer<T>` contained in an `T`.
> +        //  - As per he safety requirements of the trait `HrTimerHandle`=
, the
> +        //    `PinMutHrTimerHandle` associated with this timer is guaran=
teed to
> +        //    be alive until this method returns. As the handle borrows =
from
> +        //    `T`, `T` is also guaranteed to be alive for the duration o=
f this
> +        //    function.

Ah one more thing, I don't think that the second part is needed (i.e.
that `T` is alive). How about:

        //  - As per the safety requirements of the trait `HrTimerHandle`, =
the `PinMutHrTimerHandle`
        //  associated with this timer is guaranteed to be alive until this=
 method returns. That
        //  handle borrows the `T` behind `receiver_ptr` mutably thus guara=
nteeing the validity of
        //  the reference created below.

Can you also adjust the other instances of this in the other patches?
Thanks!

---
Cheers,
Benno

> +        //  - Because `PinMutTimerHandle` borrows mutably from `T`, the
> +        //    reference we create here is guaranteed to be unique.
> +        let receiver_ref =3D unsafe { &mut *receiver_ptr };
> +
> +        // SAFETY: `receiver_ref` only exists as pinned, so it is safe t=
o pin it
> +        // here.
> +        let receiver_pin =3D unsafe { Pin::new_unchecked(receiver_ref) }=
;
> +
> +        T::run(receiver_pin).into_c()
> +    }
> +}
>
> --
> 2.47.0



