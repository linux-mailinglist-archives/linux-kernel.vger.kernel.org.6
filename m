Return-Path: <linux-kernel+bounces-551209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEC0BA56964
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 14:51:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 094193B5DB3
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 13:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F18F421CC6D;
	Fri,  7 Mar 2025 13:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="mWBD89Ur"
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1ADE21ADBA
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 13:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741355395; cv=none; b=WbvYJyTAOEIThK07ozmrxTa2g1/EtGAfMGT0vJ84DX7HQQvQy6nz0oLdk3sGleb3HVL6Mox1hUsV5v5KC3Xp68ttmJgiX9AttPYzRNGpJo6UWejSqjwquLuiRvtmQqvoxDORlzqcnoXq7feOpNDkwcOSjlcSXc3EwUk3PcbBMv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741355395; c=relaxed/simple;
	bh=yW9/4dLSersMO4DNHldQci8zupCYVd7u26yzS3h3m0o=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SFXLDj9jLK0JeldL8iG7s9iHFTS/do3muBbTjNX8awNp5Aq9pE0TBrdWz88rzFEcnTT/cGCglE54Xa+BaiMo6nNRunyKgMtnjrXWnz+pYtdD7MIt9Iylcy7k5Z6ozws0eF4zskUnOSm7pFytXjEcEwcyiIVPsF7fb0ModfUfpGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=mWBD89Ur; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=6fptnopq2ffptbx2q4fbd7bngq.protonmail; t=1741355389; x=1741614589;
	bh=EEYoYNAuUuPoPs1W8X1jIbMyhvVpA6cLe6iGvpj1uPg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=mWBD89UrSunFxSSed9piHZRVnTVTQbSfHGj68T4nj05bbQwvR4DgIxFkpHzZ/J6Zt
	 Q1kHAQezzzYRAFj6jIH+35y9OadKXgOuHlSefrTqaS9YfNxMWMge7w3fXunyCjD1yR
	 90sIhMEiMhSHMyQv4KJUjHXihlyonOYxW6ZYYwKwjoI1LsCJaVU6ZePMpLR4Ez+sRy
	 dO07ivR/bO690AQwCmNLOmVxjEP54qsiauNBQ9SyhFw7aYmrSJnuIDnD3/CRtY6ZiH
	 ke30h7hELhG3moZxZR+uFvWWTO5Ig1MoOeCpfDdiZDPTzjte18xw82Zu7DCBeuRAzY
	 hBX0mCFcydjBA==
Date: Fri, 07 Mar 2025 13:49:43 +0000
To: Andreas Hindborg <a.hindborg@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Danilo Krummrich <dakr@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Lyude Paul <lyude@redhat.com>, Guangbo Cui <2407018371@qq.com>, Dirk Behme <dirk.behme@gmail.com>, Daniel Almeida <daniel.almeida@collabora.com>, Tamir Duberstein <tamird@gmail.com>, Markus Elfring <Markus.Elfring@web.de>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 08/13] rust: hrtimer: implement `UnsafeHrTimerPointer` for `Pin<&mut T>`
Message-ID: <D8A2YP4GF2XL.2MN17TTXW6GM1@proton.me>
In-Reply-To: <20250307-hrtimer-v3-v6-12-rc2-v10-8-0cf7e9491da4@kernel.org>
References: <20250307-hrtimer-v3-v6-12-rc2-v10-0-0cf7e9491da4@kernel.org> <20250307-hrtimer-v3-v6-12-rc2-v10-8-0cf7e9491da4@kernel.org>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 1f35bcd8df090977494af4ce67698d317ace72b0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri Mar 7, 2025 at 11:11 AM CET, Andreas Hindborg wrote:
> Allow pinned mutable references to structs that contain a `HrTimer` node =
to
> be scheduled with the `hrtimer` subsystem.
>
> Acked-by: Frederic Weisbecker <frederic@kernel.org>
> Reviewed-by: Lyude Paul <lyude@redhat.com>
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
> ---
>  rust/kernel/time/hrtimer.rs         |   2 +
>  rust/kernel/time/hrtimer/pin_mut.rs | 101 ++++++++++++++++++++++++++++++=
++++++
>  2 files changed, 103 insertions(+)
>
> diff --git a/rust/kernel/time/hrtimer.rs b/rust/kernel/time/hrtimer.rs
> index 2ca56397eade..d2791fd624b7 100644
> --- a/rust/kernel/time/hrtimer.rs
> +++ b/rust/kernel/time/hrtimer.rs
> @@ -441,3 +441,5 @@ unsafe fn timer_container_of(ptr: *mut $crate::time::=
hrtimer::HrTimer<$timer_typ
>  pub use arc::ArcHrTimerHandle;
>  mod pin;
>  pub use pin::PinHrTimerHandle;
> +mod pin_mut;
> +pub use pin_mut::PinMutHrTimerHandle;
> diff --git a/rust/kernel/time/hrtimer/pin_mut.rs b/rust/kernel/time/hrtim=
er/pin_mut.rs
> new file mode 100644
> index 000000000000..4f4a9e9602d8
> --- /dev/null
> +++ b/rust/kernel/time/hrtimer/pin_mut.rs
> @@ -0,0 +1,101 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +use super::HasHrTimer;
> +use super::HrTimer;
> +use super::HrTimerCallback;
> +use super::HrTimerHandle;
> +use super::RawHrTimerCallback;
> +use super::UnsafeHrTimerPointer;
> +use crate::time::Ktime;
> +use core::pin::Pin;
> +
> +/// A handle for a `Pin<&mut HasHrTimer>`. When the handle exists, the t=
imer might
> +/// be running.
> +pub struct PinMutHrTimerHandle<'a, T>
> +where
> +    T: HasHrTimer<T>,
> +{
> +    pub(crate) inner: Pin<&'a mut T>,

I just noticed, if `T: Unpin`, this is unsound in combination with you
creating another `Pin<&mut T>` reference below for the callback, since
then we have two `&mut T` pointing to the same value. So you should
store a raw pointer instead.

---
Cheers,
Benno


