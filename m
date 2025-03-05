Return-Path: <linux-kernel+bounces-546765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91EA3A4FE79
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 13:18:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2E11189157E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 12:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22F8B2451D7;
	Wed,  5 Mar 2025 12:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="f3NtY/bM"
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C740624502C
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 12:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741177046; cv=none; b=nK+tt7oRgosxia1lzrLbmKsf5uhIbew+aVZLnXxRN2csn8r+OvbrbgjVVbh63z4GIlvskqviL0QL0ifD3lmiErFdi0OS2AC5blNcGJQM4ikVJ308Ycuwo0Vt3pGaEBjR2TK4UsiHEkP63KnnAiJXJeA8Rr49mdz/BP3WvLpaPok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741177046; c=relaxed/simple;
	bh=h3LIfw0I/qKn/+CSvk5G5jME+xih+7mH8xxfN82sOxE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ppEY2lnMuP1DlzCUadwux9HhX1zVHjP+QLJqOszmsQRgW9HZZyUg9KL3flAhqw0K3GJTP6Brqg8xBKzdA4qeEtAToc/wNVDsGWgpjPF43dvvGsrrFepVsx782Kgchas2YhYCED+DUSOt2+8CQK+4dFocXMdBR8VzVMCLU7CUUGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=f3NtY/bM; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1741177042; x=1741436242;
	bh=+GSH/hGM0OM2xxx0GMJ7cgHDZ+8cY8JDPb0xY0nCJMc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=f3NtY/bMlHjj1xRn53fMb6LBZ95iZDwS/cyXyohz46VfWXb7+B50S6ZNioi2B5TwS
	 SFL8OdKv6uDC0h9BcKAzWBrmXtiBEgye5ZpXrzYvSGn/aYyn1RqgB08GNrD7u/n2FJ
	 0hLrCAmhtXCVpFLyeQdNTeicRm8d6KcydTSOdFParG2l9Oe+BfibwIq7STInHoLfSV
	 nVpvv08dM3MmskXYLQdAnTcSf98Hc/osog6/MrH+87Qp/Kyybj1T5DE6wrMS+QYxMP
	 GIz0hhY8TCxlmteJ5XMdNfDGjpMW1GkKZ83Lylm5iyhSv0FvBMz/zj8aGVjU45wnK4
	 u2/LQeDOi75qw==
Date: Wed, 05 Mar 2025 12:17:18 +0000
To: Alice Ryhl <aliceryhl@google.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/22] rust: pin-init: move impl `Zeroable` for `Opaque` and `Option<KBox<T>>` into the kernel crate
Message-ID: <D88BQVG0KLC5.27DTUSDE9D8C6@proton.me>
In-Reply-To: <CAH5fLghL+qzrD8KiCF1V3vf2YcC6aWySzkmaE2Zzrnh1gKj-hw@mail.gmail.com>
References: <20250304225245.2033120-1-benno.lossin@proton.me> <msi970CObD4bpxAIjK__fZnRG2q-BXd4FHuA1U1NR80D_dTqSXuQ-0-4R1TS7-7CglN6StcS3Os-IumgWcVLqw==@protonmail.internalid> <20250304225245.2033120-10-benno.lossin@proton.me> <87a59zen0l.fsf@kernel.org> <D88BHSCKZ8MO.10J627BIF6I97@proton.me> <CAH5fLghL+qzrD8KiCF1V3vf2YcC6aWySzkmaE2Zzrnh1gKj-hw@mail.gmail.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: f5e96b7eb593c9b24e4fd2b57a30ba5166e79fe2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed Mar 5, 2025 at 1:11 PM CET, Alice Ryhl wrote:
> On Wed, Mar 5, 2025 at 1:05=E2=80=AFPM Benno Lossin <benno.lossin@proton.=
me> wrote:
>>
>> On Wed Mar 5, 2025 at 12:26 PM CET, Andreas Hindborg wrote:
>> > "Benno Lossin" <benno.lossin@proton.me> writes:
>> >
>> >> In order to make pin-init a standalone crate, move kernel-specific co=
de
>> >> directly into the kernel crate. Since `Opaque<T>` and `KBox<T>` are p=
art
>> >> of the kernel, move their `Zeroable` implementation into the kernel
>> >> crate.
>> >>
>> >> Signed-off-by: Benno Lossin <benno.lossin@proton.me>
>> >> ---
>> >>  rust/kernel/alloc/kbox.rs | 8 +++++++-
>> >>  rust/kernel/types.rs      | 5 ++++-
>> >>  rust/pin-init/src/lib.rs  | 8 +-------
>> >>  3 files changed, 12 insertions(+), 9 deletions(-)
>> >>
>> >> diff --git a/rust/kernel/alloc/kbox.rs b/rust/kernel/alloc/kbox.rs
>> >> index 39a3ea7542da..9861433559dc 100644
>> >> --- a/rust/kernel/alloc/kbox.rs
>> >> +++ b/rust/kernel/alloc/kbox.rs
>> >> @@ -15,7 +15,7 @@
>> >>  use core::ptr::NonNull;
>> >>  use core::result::Result;
>> >>
>> >> -use crate::init::{InPlaceWrite, Init, PinInit};
>> >> +use crate::init::{InPlaceWrite, Init, PinInit, Zeroable};
>> >>  use crate::init_ext::InPlaceInit;
>> >>  use crate::types::ForeignOwnable;
>> >>
>> >> @@ -100,6 +100,12 @@
>> >>  /// ```
>> >>  pub type KVBox<T> =3D Box<T, super::allocator::KVmalloc>;
>> >>
>> >> +// SAFETY: All zeros is equivalent to `None` (option layout optimiza=
tion guarantee).
>> >> +//
>> >> +// In this case we are allowed to use `T: ?Sized`, since all zeros i=
s the `None` variant and there
>> >> +// is no problem with a VTABLE pointer being null.
>> >> +unsafe impl<T: ?Sized, A: Allocator> Zeroable for Option<Box<T, A>> =
{}
>> >
>> > Could you elaborate the statement related to vtable pointers? How does
>> > that come into play for `Option<Box<_>>`? Is it for fat pointers to
>> > trait objects?
>>
>> Yes it is for fat pointers, if you have a `x: *mut dyn Trait`, then you
>> aren't allowed to write all zeroes to `x`, because the VTABLE pointer
>> (that is part of the fat pointer) is not allowed to be null.
>>
>> Now for `Option<Box<_>>`, this doesn't matter, as there if the normal
>> pointer part of the fat pointer is all zeroes, then the VTABLE pointer
>> part is considered padding bytes, as it's the `None` variant.
>
> The standard library only guarantees that all zeros is valid for
> Option<Box<T,A>> when T:Sized and A=3DGlobal.
> https://doc.rust-lang.org/stable/std/option/index.html#representation

Oh! That's a problem then... I'll remove that then (and I can also get
rid of the `ZeroableOption` trait).

We should also backport (& fix it in mainline), I'll submit a patch
shortly.

---
Cheers,
Benno


