Return-Path: <linux-kernel+bounces-546815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FF25A4FF05
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 13:51:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1826C3ACFC8
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 12:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD126245029;
	Wed,  5 Mar 2025 12:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="Tv3Xo3WU"
Received: from mail-10631.protonmail.ch (mail-10631.protonmail.ch [79.135.106.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340D122331E;
	Wed,  5 Mar 2025 12:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741179104; cv=none; b=bgGrd4Le+hFcTlfxla37AsSCcmD1RHUMrSsb9BH/+x5TPHisf9TqAJHwMSVeNUJz1qUFiNmCp8up+gPTHsJuejEZzUgN13fjm4QqhtIrKthq2P7UJLv1LAlWeRLBsrQuHJ0imFWLzRuVndt0smf05zytp2CFcF/blOT/ds7ogdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741179104; c=relaxed/simple;
	bh=Nx0PdtrJ0KWnDaxv7sr2Xvk2HIndC0iHuCjz6dX5Qcc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RALG/Y2/bo56AjZky9gP8Bak3s09ga0LDvG2V8icBQOWk83qdaKh26CcAej53wYdZtlVCZefyDH1nXpimWtveIAhAOTiHdirVNxd2TrjVfWwcc9q3/QV4DSoFdXIhmiLuaXyc60fRfbOm8BvSg2ZB/XU2odv6497buQyNgoK0QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=Tv3Xo3WU; arc=none smtp.client-ip=79.135.106.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1741179099; x=1741438299;
	bh=nEYBK8uEo+sn4ZcGKgWerG3U7+qONTqrcNDuCQs22S4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=Tv3Xo3WUP71tCwIP34/DQlwKAz/iY6rEFad5ut+HpAvlQCXJjhwymjZwyBUU19oDC
	 6tAI1Gr6vQWUvoLDJ1vUjIsv/eGn5G+pWzBpjF5OwLpsxZkbr+VyRnJ4SUJPNA3E7Y
	 hDurmraaiJK+QAdVUKZkhE2GcFvAQLGfHZ62fO73pEhqUCwIe7hVU8v7WiMv3DFFsJ
	 HTlXL59cwJ3Asy2MUSO70NmQnXeZJ5yDqnYxQVkukap1hLpDGl8WkCx9nG4aweya3k
	 X+VnxaultjvruIUzrwrnb9thG0J3TTp8X6AeYNqOunx/vHQyu/gGyXsZHF2FoHvSKC
	 6CWjW2yJOko6g==
Date: Wed, 05 Mar 2025 12:51:34 +0000
To: Alice Ryhl <aliceryhl@google.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/22] rust: pin-init: move impl `Zeroable` for `Opaque` and `Option<KBox<T>>` into the kernel crate
Message-ID: <D88CH2Q39KI9.3EFU0I5J8472C@proton.me>
In-Reply-To: <CAH5fLgh4aH36QUi4T36U3NeOOL3X_bt+y5ce7DU1j-+DMcV+jQ@mail.gmail.com>
References: <20250304225245.2033120-1-benno.lossin@proton.me> <msi970CObD4bpxAIjK__fZnRG2q-BXd4FHuA1U1NR80D_dTqSXuQ-0-4R1TS7-7CglN6StcS3Os-IumgWcVLqw==@protonmail.internalid> <20250304225245.2033120-10-benno.lossin@proton.me> <87a59zen0l.fsf@kernel.org> <D88BHSCKZ8MO.10J627BIF6I97@proton.me> <CAH5fLghL+qzrD8KiCF1V3vf2YcC6aWySzkmaE2Zzrnh1gKj-hw@mail.gmail.com> <D88BQVG0KLC5.27DTUSDE9D8C6@proton.me> <CAH5fLgh4aH36QUi4T36U3NeOOL3X_bt+y5ce7DU1j-+DMcV+jQ@mail.gmail.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: cc07a7cf8d3db90b0a07be822e19232cebb83edf
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed Mar 5, 2025 at 1:49 PM CET, Alice Ryhl wrote:
> On Wed, Mar 5, 2025 at 1:17=E2=80=AFPM Benno Lossin <benno.lossin@proton.=
me> wrote:
>>
>> On Wed Mar 5, 2025 at 1:11 PM CET, Alice Ryhl wrote:
>> > On Wed, Mar 5, 2025 at 1:05=E2=80=AFPM Benno Lossin <benno.lossin@prot=
on.me> wrote:
>> >>
>> >> On Wed Mar 5, 2025 at 12:26 PM CET, Andreas Hindborg wrote:
>> >> > "Benno Lossin" <benno.lossin@proton.me> writes:
>> >> >
>> >> >> In order to make pin-init a standalone crate, move kernel-specific=
 code
>> >> >> directly into the kernel crate. Since `Opaque<T>` and `KBox<T>` ar=
e part
>> >> >> of the kernel, move their `Zeroable` implementation into the kerne=
l
>> >> >> crate.
>> >> >>
>> >> >> Signed-off-by: Benno Lossin <benno.lossin@proton.me>
>> >> >> ---
>> >> >>  rust/kernel/alloc/kbox.rs | 8 +++++++-
>> >> >>  rust/kernel/types.rs      | 5 ++++-
>> >> >>  rust/pin-init/src/lib.rs  | 8 +-------
>> >> >>  3 files changed, 12 insertions(+), 9 deletions(-)
>> >> >>
>> >> >> diff --git a/rust/kernel/alloc/kbox.rs b/rust/kernel/alloc/kbox.rs
>> >> >> index 39a3ea7542da..9861433559dc 100644
>> >> >> --- a/rust/kernel/alloc/kbox.rs
>> >> >> +++ b/rust/kernel/alloc/kbox.rs
>> >> >> @@ -15,7 +15,7 @@
>> >> >>  use core::ptr::NonNull;
>> >> >>  use core::result::Result;
>> >> >>
>> >> >> -use crate::init::{InPlaceWrite, Init, PinInit};
>> >> >> +use crate::init::{InPlaceWrite, Init, PinInit, Zeroable};
>> >> >>  use crate::init_ext::InPlaceInit;
>> >> >>  use crate::types::ForeignOwnable;
>> >> >>
>> >> >> @@ -100,6 +100,12 @@
>> >> >>  /// ```
>> >> >>  pub type KVBox<T> =3D Box<T, super::allocator::KVmalloc>;
>> >> >>
>> >> >> +// SAFETY: All zeros is equivalent to `None` (option layout optim=
ization guarantee).
>> >> >> +//
>> >> >> +// In this case we are allowed to use `T: ?Sized`, since all zero=
s is the `None` variant and there
>> >> >> +// is no problem with a VTABLE pointer being null.
>> >> >> +unsafe impl<T: ?Sized, A: Allocator> Zeroable for Option<Box<T, A=
>> {}
>> >> >
>> >> > Could you elaborate the statement related to vtable pointers? How d=
oes
>> >> > that come into play for `Option<Box<_>>`? Is it for fat pointers to
>> >> > trait objects?
>> >>
>> >> Yes it is for fat pointers, if you have a `x: *mut dyn Trait`, then y=
ou
>> >> aren't allowed to write all zeroes to `x`, because the VTABLE pointer
>> >> (that is part of the fat pointer) is not allowed to be null.
>> >>
>> >> Now for `Option<Box<_>>`, this doesn't matter, as there if the normal
>> >> pointer part of the fat pointer is all zeroes, then the VTABLE pointe=
r
>> >> part is considered padding bytes, as it's the `None` variant.
>> >
>> > The standard library only guarantees that all zeros is valid for
>> > Option<Box<T,A>> when T:Sized and A=3DGlobal.
>> > https://doc.rust-lang.org/stable/std/option/index.html#representation
>>
>> Oh! That's a problem then... I'll remove that then (and I can also get
>> rid of the `ZeroableOption` trait).
>
> Don't you still need it for KBox?

Yes that's correct, when I wrote the above, I was under the impression
that I had to remove the `Zeroable` impl for `KBox` completely, but that
is not the case. I can still keep the one for `T: Sized` (since it's
transparently wrapping `NonNull<T>`).

---
Cheers,
Benno


