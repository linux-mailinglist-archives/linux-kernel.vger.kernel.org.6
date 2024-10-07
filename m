Return-Path: <linux-kernel+bounces-353289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ACD96992B9B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 14:24:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7CC41C22CE1
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 12:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DAAE1D27BB;
	Mon,  7 Oct 2024 12:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OOrKqUFV"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3353F1D278C
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 12:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728303861; cv=none; b=pVuPjzSY9MjIOcR8sP0K4dt6pt5S6w0f743YafwsgBoJ/EQOHVqx0mcDZXzH3XchCT4206A+EL4Qe98LhozAFDCayvkURmPzLMbTTrHhaJcpT2ji89y9hDvw8BQ8gR5tV0vVgC4QpSlpj/5jJ/lOzr1Pvw7RhXbXtIIQ2UmXTzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728303861; c=relaxed/simple;
	bh=t8H6KKTU1kUFSyofCbDB6hb4GjQoj/UNpvlIreQ4WHo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=snx6dlQ42oBtwcK4lV4PAKCNW4uEEh+E2J1lxw2Cg2MRPtMzf1OHuofaZ6oarPTkc5kNItQzUj6ow1k3hqS17jlEv06qFCn0QYkv9IKjCM1HVp4F8IX46Pr72balEbEkXp+Ls6mKQ5n4KsDK7Px5S9pMnjkB7L1EwnfiM5Pin/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OOrKqUFV; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-37cdac05af9so4216618f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 05:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728303856; x=1728908656; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ku7dHoXpcBGzxmDwFlzy5O2yX7mMKyvUeFGB5ab/Z98=;
        b=OOrKqUFVGN+til1KTL10MXwaAlvqfhdBAA8OaV/VrMm2yGAP2b+K+rBLws5vWOHClL
         ysNc9YSd83jY9R+nvpyM16sgL51fZuB4lSgLcGPHKLKNljiOJqu+6eFiIZSM5lLYkNA8
         ipzPteLU7kLOh6v+kFFqkcJ64PNn4JPqRzxjp7UdAJ/CZCgOAzDUZZQ/suNyknQIli93
         9frkwkis11dzWOdgunlLuqd37ysfAm+XCAVrD+EGCemfJBxrZYeP0JmxuRdAyYaecUCm
         oR6RbUoYasV6Nzd4Bf2OxK0wsMBc4FQ7X+Cl95JzEOByYKs4DCxhV2P1GLHkxLTfEQOP
         kTNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728303856; x=1728908656;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ku7dHoXpcBGzxmDwFlzy5O2yX7mMKyvUeFGB5ab/Z98=;
        b=ipbuc4f59Ks/hc3CiIWNlnsXQxRgfX7f4D7Y0o9O6cxNgxS3Clc7goP9WcuYStdhXl
         KiP59p1Sq8io1dvsOBXtQ7LSP1Jf5ltk3a7Qtb4GGropXMFtQwPES2oZBIsA/d1Qy1p/
         23qGFy7mgffA53OB07otD0CMmAS4VicfxpnaiZ4I2GbqLEr80p5fyAHD+6YUOuaB2ZDD
         b3gUfFRs+bOboEcP/e/y3wx5EOSxtaRXUOuHwVYcYAl/6YlrDgZuHyryUPsZEln2TrZ9
         7dtk5S8Wo8/DHU7K84BrY+krBYm1ERxLxayykmhT5FNc0mSnJ40BlTOUai5mnrwVw/5A
         TN7g==
X-Forwarded-Encrypted: i=1; AJvYcCWmPnkPTFpqbuZst7W4G/U8TLt5JDXY7e7wyv84tUY2ipKThvnfnQHfL2VxcM5E6nYSEWV8i5NFVZii2x4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLJ0Ve8CLnqPo71SEveVVTwQgRWree/3gTpzxTl9rfkGZOj6DT
	R13P5XgpBIwRXceI8Pp5x2OaxDKFPEzFGeEqQ+UQaQoJ4Gqvw0ncySV/PYZchoJ4y+yDSV0Qb7R
	oADx5gk/G3KGqQ9pYLYAs/cCdow0dVPxEVnFQ
X-Google-Smtp-Source: AGHT+IH8HYWMusOnnggysgcNaVoQpA7Kkf52UHiKBHrYYgnQi3e5Rs2SF/yP/clJCEOjCdyXWS+b5b1JKOiSHyD1iX0=
X-Received: by 2002:a5d:61ca:0:b0:37c:fbf8:fc4 with SMTP id
 ffacd0b85a97d-37d0eaea686mr9189645f8f.59.1728303856278; Mon, 07 Oct 2024
 05:24:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241005122531.20298-1-fujita.tomonori@gmail.com> <20241005122531.20298-5-fujita.tomonori@gmail.com>
In-Reply-To: <20241005122531.20298-5-fujita.tomonori@gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 7 Oct 2024 14:24:03 +0200
Message-ID: <CAH5fLgjTifsDKrxZTUTo74HR34X1zusO_7h0ftWWH-iZR_NXNA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 4/6] rust: time: add wrapper for fsleep function
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, andrew@lunn.ch, 
	hkallweit1@gmail.com, tmgross@umich.edu, ojeda@kernel.org, 
	alex.gaynor@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	benno.lossin@proton.me, a.hindborg@samsung.com, anna-maria@linutronix.de, 
	frederic@kernel.org, tglx@linutronix.de, arnd@arndb.de, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 5, 2024 at 2:26=E2=80=AFPM FUJITA Tomonori
<fujita.tomonori@gmail.com> wrote:
>
> Add a wrapper for fsleep, flexible sleep functions in
> `include/linux/delay.h` which deals with hardware delays.
>
> The kernel supports several `sleep` functions to handle various
> lengths of delay. This adds fsleep, automatically chooses the best
> sleep method based on a duration.
>
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> ---
>  rust/helpers/time.c |  6 ++++++
>  rust/kernel/time.rs | 16 ++++++++++++++++
>  2 files changed, 22 insertions(+)
>
> diff --git a/rust/helpers/time.c b/rust/helpers/time.c
> index 60dee69f4efc..0c85bb06af63 100644
> --- a/rust/helpers/time.c
> +++ b/rust/helpers/time.c
> @@ -1,7 +1,13 @@
>  // SPDX-License-Identifier: GPL-2.0
>
> +#include <linux/delay.h>
>  #include <linux/ktime.h>
>
> +void rust_helper_fsleep(unsigned long usecs)
> +{
> +       fsleep(usecs);
> +}
> +
>  ktime_t rust_helper_ktime_add_ns(const ktime_t kt, const u64 nsec)
>  {
>         return ktime_add_ns(kt, nsec);
> diff --git a/rust/kernel/time.rs b/rust/kernel/time.rs
> index 3e00ad22ed89..5cca9c60f74a 100644
> --- a/rust/kernel/time.rs
> +++ b/rust/kernel/time.rs
> @@ -5,9 +5,12 @@
>  //! This module contains the kernel APIs related to time and timers that
>  //! have been ported or wrapped for usage by Rust code in the kernel.
>  //!
> +//! C header: [`include/linux/delay.h`](srctree/include/linux/delay.h).
>  //! C header: [`include/linux/jiffies.h`](srctree/include/linux/jiffies.=
h).
>  //! C header: [`include/linux/ktime.h`](srctree/include/linux/ktime.h).
>
> +use core::ffi::c_ulong;
> +
>  /// The number of nanoseconds per microsecond.
>  pub const NSEC_PER_USEC: i64 =3D bindings::NSEC_PER_USEC as i64;
>
> @@ -178,3 +181,16 @@ fn add(self, delta: Delta) -> Ktime {
>          Ktime::from_raw(t)
>      }
>  }
> +
> +/// Sleeps for a given duration.
> +///
> +/// Equivalent to the kernel's [`fsleep`], flexible sleep function,
> +/// which automatically chooses the best sleep method based on a duratio=
n.
> +///
> +/// `Delta` must be longer than one microsecond.
> +///
> +/// This function can only be used in a nonatomic context.
> +pub fn fsleep(delta: Delta) {
> +    // SAFETY: FFI call.
> +    unsafe { bindings::fsleep(delta.as_micros() as c_ulong) }
> +}

This rounds down. Should this round it up to the nearest microsecond
instead? It's generally said that fsleep should sleep for at least the
provided duration, but that it may sleep for longer under some
circumstances. By rounding up, you preserve that guarantee.

Also, the note about always sleeping for "at least" the duration may
be a good fit for the docs here as well.

Alice

