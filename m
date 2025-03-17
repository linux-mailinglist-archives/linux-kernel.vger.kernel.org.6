Return-Path: <linux-kernel+bounces-563786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C44DA6486A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 10:59:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFB9518859F5
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 09:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 702CB22F388;
	Mon, 17 Mar 2025 09:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="FXd0ialh"
Received: from mail-24417.protonmail.ch (mail-24417.protonmail.ch [109.224.244.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA99B22DFA8;
	Mon, 17 Mar 2025 09:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742205527; cv=none; b=YzqY8/GUI9ogJT2FEoD5JCkfTCJ0G4/0CtmzGlNlA2AKIyTd8ugGJjAdZ9kTFuajdlffJDVKPe+IaIf+ELhV5gxBwBTLRYCFVIIAlkyHu36PybxZVcRyJZms3yvT9SymT1q/yRe7Dkdze6i0AGMMXsLSdePfCYcgIcCnvxUWf0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742205527; c=relaxed/simple;
	bh=+aEG912NzRn80rDLZY34hv7e8PyJfpGkE1RJ7xnNKAk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Aqh+SyWpYc1xXw7KqcQnMPHdNgd59pe+JNhMXlnNQIYtuoK049AsZljaOSupIyUfFsx++fJhzsf+cectz3eseXVSXGLPvKOsbwTnCvATt9AFXqvfl8rMHMJ5IwTc23NCGe786rYdFlMPsWjr58shzC+laMzZvrW1YyvmiabI9sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=FXd0ialh; arc=none smtp.client-ip=109.224.244.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1742205521; x=1742464721;
	bh=D2PMVOaORBnfrtdY1U2gZAT+GyRP76w9SUSPSbGMIdY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=FXd0ialhNc9Id4+9x1AuNA44/fUIPHmRQoQJHU46zro3dV/D5AwwfFy+qquSDcb1f
	 RAaQwMOHICWThugK5WNLdTPz8PCNOPcUG96lDYU2wyUJAMCjcgw4gUg5ZtMWujRCP7
	 A606gEZzw8O1+NbusItOXJOAl4PaIqA07qLQh/bXjmE+k1He12vzsKTbHkSWcXnFwY
	 wkfZhILOw56yuoWevRK0jC22gthAJGrbRNxbL4zGZ/6HFRVGGnUeJjbtM6P5vpjD4N
	 6HmC1tjqIV72Pw1sTXG3tfoSH+jtX1/Tk3Wi91HOdaLcWjH0sycwN/V5b2qU9cX6Ge
	 80FQdwkOmGqsw==
Date: Mon, 17 Mar 2025 09:58:35 +0000
To: Tamir Duberstein <tamird@gmail.com>, Danilo Krummrich <dakr@kernel.org>, Andrew Ballance <andrewjballance@gmail.com>, Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>
From: Benno Lossin <benno.lossin@proton.me>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] rust: alloc: replace `Vec::set_len` with `inc_len`
Message-ID: <D8IGB61NVPBT.1I3IZYPVPIEMU@proton.me>
In-Reply-To: <20250316-vec-set-len-v1-1-60f98a28723f@gmail.com>
References: <20250316-vec-set-len-v1-0-60f98a28723f@gmail.com> <20250316-vec-set-len-v1-1-60f98a28723f@gmail.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 02caf5a5828e2c51365c935a1ead55d2314f2be9
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sun Mar 16, 2025 at 11:32 PM CET, Tamir Duberstein wrote:
> Rename `set_len` to `inc_len` and simplify its safety contract.
> ---
>  rust/kernel/alloc/kvec.rs | 19 +++++++++----------
>  rust/kernel/str.rs        |  2 +-
>  rust/kernel/uaccess.rs    |  2 +-
>  3 files changed, 11 insertions(+), 12 deletions(-)
>
> diff --git a/rust/kernel/alloc/kvec.rs b/rust/kernel/alloc/kvec.rs
> index ae9d072741ce..d43a1d609434 100644
> --- a/rust/kernel/alloc/kvec.rs
> +++ b/rust/kernel/alloc/kvec.rs
> @@ -183,17 +183,16 @@ pub fn len(&self) -> usize {
>          self.len
>      }
> =20
> -    /// Forcefully sets `self.len` to `new_len`.
> +    /// Increments `self.len` by `additional`.

I would keep the "Forcefully".

>      ///
>      /// # Safety
>      ///
> -    /// - `new_len` must be less than or equal to [`Self::capacity`].
> -    /// - If `new_len` is greater than `self.len`, all elements within t=
he interval
> -    ///   [`self.len`,`new_len`) must be initialized.
> +    /// - `self.len + additional` must be less than or equal to [`Self::=
capacity`].
> +    /// - All elements within the interval [`self.len`,`self.len + addit=
ional`) must be initialized.
>      #[inline]
> -    pub unsafe fn set_len(&mut self, new_len: usize) {
> -        debug_assert!(new_len <=3D self.capacity());
> -        self.len =3D new_len;
> +    pub unsafe fn inc_len(&mut self, additional: usize) {
> +        debug_assert!(self.len() + additional <=3D self.capacity());

What if this overflows? Do we always have overflow debugging on when
debug assertions are enabled? If yes, then this is fine.

> +        self.len +=3D additional;
>      }
> =20
>      /// Returns a slice of the entire vector.

> diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
> index 28e2201604d6..005713839e9e 100644
> --- a/rust/kernel/str.rs
> +++ b/rust/kernel/str.rs
> @@ -840,7 +840,7 @@ pub fn try_from_fmt(args: fmt::Arguments<'_>) -> Resu=
lt<Self, Error> {
> =20
>          // SAFETY: The number of bytes that can be written to `f` is bou=
nded by `size`, which is
>          // `buf`'s capacity. The contents of the buffer have been initia=
lised by writes to `f`.
> -        unsafe { buf.set_len(f.bytes_written()) };
> +        unsafe { buf.inc_len(f.bytes_written()) };

This change seems wrong unless the code was wrong to begin with.

Otherwise the change looks good.

---
Cheers,
Benno

> =20
>          // Check that there are no `NUL` bytes before the end.
>          // SAFETY: The buffer is valid for read because `f.bytes_written=
()` is bounded by `size`
> diff --git a/rust/kernel/uaccess.rs b/rust/kernel/uaccess.rs
> index 719b0a48ff55..0aa5455a18be 100644
> --- a/rust/kernel/uaccess.rs
> +++ b/rust/kernel/uaccess.rs
> @@ -291,7 +291,7 @@ pub fn read_all<A: Allocator>(mut self, buf: &mut Vec=
<u8, A>, flags: Flags) -> R
> =20
>          // SAFETY: Since the call to `read_raw` was successful, so the n=
ext `len` bytes of the
>          // vector have been initialized.
> -        unsafe { buf.set_len(buf.len() + len) };
> +        unsafe { buf.inc_len(len) };
>          Ok(())
>      }
>  }



