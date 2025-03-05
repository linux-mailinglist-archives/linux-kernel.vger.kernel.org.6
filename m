Return-Path: <linux-kernel+bounces-546791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56401A4FEC8
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 13:38:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C032189511E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 12:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08D202475E8;
	Wed,  5 Mar 2025 12:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="Twpy4oN/"
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E8F2459F4
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 12:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741178257; cv=none; b=FvV7HPlIy3dK/LggXTPsY+8blhFdmGvPi4BjdfVkSjK7XYPHhn2Of0PLxT3wUzxIwkIO/c1JULqP9XbI32oOTqkI2zITqnvS8Uh/piZDc+opHMkCm9b+dPCy10g09CJ3BUVP2NHf1tVTWQr2grP1cwuzSNTe72IxVMBp4l4KsGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741178257; c=relaxed/simple;
	bh=l53mtTm1nvomhA7dpzGfvMPDXgd66j/IsHSn2dDcCv8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KyaxC1u0mOuO+ziWGvQts8n6fMIaF26+WT3tCE4zEU7o/PsfXApWbsok5hKtE4PAZ2QVmLkiRS7nKTLuIPo/QzvOuhACsldC+A1gp34ymPVcDHoLPy+fWM2rIjSCi0Ad8Br3JcRc2BFdtbTqVtsJ2/zwO7O3Zx3ilu9CN46vE3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=Twpy4oN/; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1741178252; x=1741437452;
	bh=uNHoSRbX257IpSfUVe2wyy5qbNguq0YknAjDzbCQFyM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=Twpy4oN/UbcDY9/fV3ZjeFLamZ9bXT233X/rr6Af7v17pFZu2EYj1Fcnz+EyWSddE
	 1UMHEff8WQkC8uz2jZmsrXcG8ZqRExaCQoMNeW3tBD+9s7hlQOlaSc5wriCUq0N+bE
	 EBcfCI/qDYJKeYDRt2hz5j4SgeN1jW95dCv1jj75sduiKEM+xVfe3z8Rl5+Kg6Mzd9
	 qC7TLrG9MuOlaR3083BJwZdBylA1/1mezl++R6utto36p3pfUBqMZdLENcgniAB9fc
	 9EaodDVPC0BCCFxA2WXsKIdvEw9CdELjwgEg+Kz7HC6q2N/4NZQUr5DIab30y6vFqy
	 NT+etn7h1kSgA==
Date: Wed, 05 Mar 2025 12:37:24 +0000
To: Andreas Hindborg <a.hindborg@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/22] rust: pin-init: move `InPlaceInit` and impls of `InPlaceWrite` into the kernel crate
Message-ID: <D88C68C0N7RH.2EZYDFGZDNUYY@proton.me>
In-Reply-To: <87r03bbr0w.fsf@kernel.org>
References: <20250304225245.2033120-1-benno.lossin@proton.me> <iamkKusKoPQ37SKTEy2SbZjH0szdD4f3Zss6AcRF5jAkltpuR9blYqQ3Qc0Vd_gJBwPbefblnClu4okTA-TLLg==@protonmail.internalid> <20250304225245.2033120-9-benno.lossin@proton.me> <87frjrene8.fsf@kernel.org> <yOvQB5qHfHQi6IYDiDOUtboOxQ-0xzUQZNt63_wDaqGcBbQeUy87JtAW-euoLQvXgZYu9JbaqpsDGyGaZXRJCw==@protonmail.internalid> <D88BIUUNXQK5.3BFLFUBWAS0H2@proton.me> <87r03bbr0w.fsf@kernel.org>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 25ade23883a253c33a9527c1515d0cc05176f208
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed Mar 5, 2025 at 1:28 PM CET, Andreas Hindborg wrote:
> "Benno Lossin" <benno.lossin@proton.me> writes:
>
>> On Wed Mar 5, 2025 at 12:18 PM CET, Andreas Hindborg wrote:
>>> "Benno Lossin" <benno.lossin@proton.me> writes:
>>>
>>>> In order to make pin-init a standalone crate, move kernel-specific cod=
e
>>>> directly into the kernel crate. This includes the `InPlaceInit<T>`
>>>> trait, its implementations and the implementations of `InPlaceWrite` f=
or
>>>> `Arc` and `UniqueArc`. All of these use the kernel's error type which
>>>> will become unavailable in pin-init.
>>>>
>>>> Signed-off-by: Benno Lossin <benno.lossin@proton.me>
>>>> ---
>>>>  rust/kernel/alloc/kbox.rs |   3 +-
>>>>  rust/kernel/init.rs       |  55 +++++++++++++++++
>>>>  rust/kernel/prelude.rs    |   3 +-
>>>>  rust/kernel/sync/arc.rs   |  65 +++++++++++++++++++-
>>>>  rust/pin-init/src/lib.rs  | 125 ++-----------------------------------=
-
>>>>  5 files changed, 127 insertions(+), 124 deletions(-)
>>>>
>>>
>>> [...]
>>>
>>>> --- a/rust/pin-init/src/lib.rs
>>>> +++ b/rust/pin-init/src/lib.rs
>>>> @@ -10,7 +10,7 @@
>>>>  //! To initialize a `struct` with an in-place constructor you will ne=
ed two things:
>>>>  //! - an in-place constructor,
>>>>  //! - a memory location that can hold your `struct` (this can be the =
[stack], an [`Arc<T>`],
>>>> -//!   [`UniqueArc<T>`], [`KBox<T>`] or any other smart pointer that i=
mplements [`InPlaceInit`]).
>>>> +//!   [`KBox<T>`] or any other smart pointer that supports this libra=
ry).
>>>
>>> Would you not want to remove references to `KBox` here as well? Even
>>> though you don't have to move the impl, I don't imagine `KBox` exist in
>>> user space?
>>
>> Yes, this is done in "rust: pin-init: fix documentation links".
>
> Yea, maybe I should have read the entire thing before firing off emails.

No worries, happens to me as well :)

---
Cheers,
Benno


