Return-Path: <linux-kernel+bounces-553032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A4BA582B2
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 10:35:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97134167F90
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 09:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 155E91A4F0A;
	Sun,  9 Mar 2025 09:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="cfUae+lF"
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425A935964;
	Sun,  9 Mar 2025 09:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741512914; cv=none; b=N/cTxHzaR4bBAj1YiP2YCx0ca+WJOEOs0kfs+ozzdSCykX9JFfLNX1zT6RBqOm9El24aRAftdcZsS7u613V6E13Ms/n8TZiwECEVHlHWOhZdPMDeFPEaCN/UIbK97F5RwEPtWZUyuGKi+W4mPraouOYYcRXXWZ2iw/J45PHkyrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741512914; c=relaxed/simple;
	bh=ef16vmQWr+hP9iDJ6GacPsHsiC+JXl5aqp2HwS/jCUM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=byrwdHaPi1y2xzwglGvzS7d9+eA0ZfeoFjZtaabFmxyvS86Rqx9aczpelSLeGHWk33axrMbR7HwBxklRcE5wsnq66qELE95cYTse0XyZUVpddFCCMyAN5SDjcTnvgf7V57c1RAH/P6mDH/2TRqIsouUGYneHeLFE1WqfqvndJmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=cfUae+lF; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1741512903; x=1741772103;
	bh=dmx/HBIdJFnExZ5Y+rLaBEWlh0Y9tq2BATLKSZ3zfa0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=cfUae+lFMLFSXAQPvvd+amFZLD/WZI31ipXgA61fjfm17vP7wXk/Uq2QnYzYcfReN
	 +5USo7oOeH5tidIRaexfp5rzlFNtCRBeMnTNVe3u4o5826ztmESQ8wIeR2mdjsRH7t
	 izwvuNgC6FKaOHpamdYNza+Fni9ZkAbcNfsy3Wk8HQJobMQKE4gqsiaL7+IquJKam4
	 DvHnTJf63gmcj+QhOvbMeTeLLjc0+jYykhJo5divV4N5XBhVDGdtXx1bRbg4/sA9r/
	 ziq7MZvcEYUs0A40mExl55jI76YhBx9cdMKXaIAKnjRpOPEg80Gl8tcAycFYovwKwy
	 +YQrqGr/xI4yw==
Date: Sun, 09 Mar 2025 09:35:00 +0000
To: Andreas Hindborg <a.hindborg@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Danilo Krummrich <dakr@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Lyude Paul <lyude@redhat.com>, Guangbo Cui <2407018371@qq.com>, Dirk Behme <dirk.behme@gmail.com>, Daniel Almeida <daniel.almeida@collabora.com>, Tamir Duberstein <tamird@gmail.com>, Markus Elfring <Markus.Elfring@web.de>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 08/13] rust: hrtimer: implement `UnsafeHrTimerPointer` for `Pin<&mut T>`
Message-ID: <D8BMSSM6IGCD.2TWTNMT3D8OT9@proton.me>
In-Reply-To: <20250307-hrtimer-v3-v6-12-rc2-v11-8-7934aefd6993@kernel.org>
References: <20250307-hrtimer-v3-v6-12-rc2-v11-0-7934aefd6993@kernel.org> <20250307-hrtimer-v3-v6-12-rc2-v11-8-7934aefd6993@kernel.org>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 967dc3798f38ca4a76c81d8e534b54d871371658
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri Mar 7, 2025 at 10:38 PM CET, Andreas Hindborg wrote:
> Allow pinned mutable references to structs that contain a `HrTimer` node =
to
> be scheduled with the `hrtimer` subsystem.
>
> Acked-by: Frederic Weisbecker <frederic@kernel.org>
> Reviewed-by: Lyude Paul <lyude@redhat.com>
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>

One problem below, with that fixed:

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

> ---
>  rust/kernel/time/hrtimer.rs         |   2 +
>  rust/kernel/time/hrtimer/pin_mut.rs | 110 ++++++++++++++++++++++++++++++=
++++++
>  2 files changed, 112 insertions(+)
>
> diff --git a/rust/kernel/time/hrtimer.rs b/rust/kernel/time/hrtimer.rs
> index fee8e44447ee..ab0950a964e8 100644
> --- a/rust/kernel/time/hrtimer.rs
> +++ b/rust/kernel/time/hrtimer.rs
> @@ -433,3 +433,5 @@ unsafe fn timer_container_of(
>  pub use arc::ArcHrTimerHandle;
>  mod pin;
>  pub use pin::PinHrTimerHandle;
> +mod pin_mut;
> +pub use pin_mut::PinMutHrTimerHandle;
> diff --git a/rust/kernel/time/hrtimer/pin_mut.rs b/rust/kernel/time/hrtim=
er/pin_mut.rs
> new file mode 100644
> index 000000000000..007f47d26df6
> --- /dev/null
> +++ b/rust/kernel/time/hrtimer/pin_mut.rs
> @@ -0,0 +1,110 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +use super::{
> +    HasHrTimer, HrTimer, HrTimerCallback, HrTimerHandle, RawHrTimerCallb=
ack, UnsafeHrTimerPointer,
> +};
> +use crate::time::Ktime;
> +use core::{marker::PhantomData, pin::Pin, ptr::NonNull};
> +
> +/// A handle for a `Pin<&mut HasHrTimer>`. When the handle exists, the t=
imer might
> +/// be running.
> +pub struct PinMutHrTimerHandle<'a, T>
> +where
> +    T: HasHrTimer<T>,
> +{
> +    pub(crate) inner: NonNull<T>,
> +    _p: PhantomData<&'a T>,

This should be `PhantomData<&'a mut T>`.

---
Cheers,
Benno


