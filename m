Return-Path: <linux-kernel+bounces-530967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA396A43A87
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 11:02:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC52717C82A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 09:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 993C226989A;
	Tue, 25 Feb 2025 09:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dl6pwGNE"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A632690F1
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 09:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740477332; cv=none; b=Q1wzQ3TMeRX08nysMULQVzuYMM7ELoGZqsCJJwS0D9bfrIjEwWKqBkOyUI5RARTw37wjzud75TQSZFws/HdVD+d825DXR1NJS8/5o7UxTHcGcCmf5XCYEKtPbJ6gpWhh2xRmcnCpxa3z7/CBoEFpEHfVSUvxIRZFilFjhIdwMyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740477332; c=relaxed/simple;
	bh=6WofqscdOjqMijz3N9pp8TU409eaANCWzBo+sQz0RLA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rGQoGUGpLWwbh4Tkp7CLKYCaBzUpBwLQSvo2QSqGtBPij48XPDAVKr4spjpCCcf2LJ6mMSybsNZEHCR1szCmV4XmZg4HRZMC2sSIQNFo+SHT1ABZ2WhKqviD3QyPPT13LILD7hP4SJMAAlRZ2dUUr+GM68BXvyG9m5DigU9ymFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dl6pwGNE; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-38f403edb4eso3096581f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 01:55:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740477329; x=1741082129; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DPxaQia6Cvd2gxcPU/EG6ad16GELvZyMWz258B0x5vU=;
        b=dl6pwGNE0xkTnOzaQfvTSfrRRqCTh7tV8WJZOtE0y5pLgbg2kNOtpEUjfMREgJtcDO
         XA8tTky6i/QOdKs8OiI9cHp7kK6QzVqbjxUjJnq1v498agOrW6URiYmWUrH/7kWca2bg
         kSC13xtAhRZYNTEt9VmRJUhtMj7j83GGK5gueLQS4pwePiL/h84ugSM/PRrCmWUgpmqY
         Es7EdPsnXQbgAmtGekNoclXuN1FR01Smwm4JdbR60yITLiTF+vyfGaoIewXdd8jVR4P7
         rjZ0pUK6DtDnc8t6r0Swnq/X4wyhSL+kGuhfuTnIs8sgf0eEsc9c/6Jlk6xUczIp+pqI
         b/wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740477329; x=1741082129;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DPxaQia6Cvd2gxcPU/EG6ad16GELvZyMWz258B0x5vU=;
        b=Js0dFulRwarIYUA+Q0Z4t+ntwFKPLTcnCskRcMufs294Rp0LTlLmJMkpzSrxaYJB2/
         lhRHm7+E4TQKbKP51wxyQ+iBEw21/Lugym5L5UmVFRQ+49zSEl5IewLSXypBVn1PgLT6
         Gfco8X8kiUCjrezs0slJn0bQZdpoycMehzR1skn8ZxfXC6Tr/wi/YVT8tL/onMxyLNGy
         xGx87Mjz4N38HQ3PSdSAyrc2hxOyUqXP7Air+ztr0+qCK2fAPavWsTk/UTVU5rG9ZWTr
         o1ISUeilWDdBT7lBJ9itGwRwxUDS2u3Xq2O0NxJD6BJMnksI3feq64OheKSg/MMG/hqE
         qyUw==
X-Forwarded-Encrypted: i=1; AJvYcCXrYxK1j80VT5JXlMFxRkROCHIR+SmWdr0jW/sXf6Z2Qp275jzjMET08fRBOQVm2eT1XlN2TM1bXmUWfDA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxid4Rbib9Iqe9LTvoCjrIXJRv3PQPVJmw8QaSEgfgzSVcm3rQJ
	A1PRirguyfReg56AuDGCgqfoDPkx2jLiDIukWHHuQ5cu5FuMolGv3fcoDKVCLXcON+Eti+uUENg
	mmouQzrDYNoH4ls2z21nxElOXv+VuHymFoX/f
X-Gm-Gg: ASbGncuzwiJMFlW8EPPcEjo/6jHUQyOTa8C49oLg8i6Z+9KR9iHyfugXY2FuzzvoK4m
	uDCuFfFFIqT3O0WHPB8KVAsjq2EzV3xhuIQzlS02vI3WLAowdpf91jiRm9e1SS+U4Zzd0+MFkTw
	T08NoFnzhDOBVoTTJH8uebzzMtLArles2ZaHZfSg==
X-Google-Smtp-Source: AGHT+IFgvJGRsWUD8wDqc0CmBB3fAAIHAhx4Jx/iLEXYfAX75626uh/92RniiahYJU5Ze0IAc077HhN54wYWIRv3SdU=
X-Received: by 2002:adf:e74a:0:b0:38f:225b:3122 with SMTP id
 ffacd0b85a97d-390cc630d47mr1713381f8f.44.1740477328936; Tue, 25 Feb 2025
 01:55:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1740475625.git.viresh.kumar@linaro.org> <68ac0f0ee3c0ebd3d3cc078a6270752778a1b732.1740475625.git.viresh.kumar@linaro.org>
In-Reply-To: <68ac0f0ee3c0ebd3d3cc078a6270752778a1b732.1740475625.git.viresh.kumar@linaro.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 25 Feb 2025 10:55:17 +0100
X-Gm-Features: AQ5f1JrlE3fKBz1AuXpYeG-8bidig5hJE5ASmGeypi8dyqvZFnkfRS8vXFlUP0o
Message-ID: <CAH5fLgg7o7hs5B4mMzPd6RzYm+RcX8gw1Aw8voJqnmfnA_aM4Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] rust: Add initial cpumask abstractions
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Yury Norov <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org, 
	Danilo Krummrich <dakr@redhat.com>, rust-for-linux@vger.kernel.org, 
	Vincent Guittot <vincent.guittot@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 10:47=E2=80=AFAM Viresh Kumar <viresh.kumar@linaro.=
org> wrote:
>
> Add initial Rust abstractions for struct cpumask, covering a subset of
> its APIs. Additional APIs can be added as needed.
>
> These abstractions will be used in upcoming Rust support for cpufreq and
> OPP frameworks.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  rust/kernel/cpumask.rs | 168 +++++++++++++++++++++++++++++++++++++++++
>  rust/kernel/lib.rs     |   1 +
>  2 files changed, 169 insertions(+)
>  create mode 100644 rust/kernel/cpumask.rs
>
> diff --git a/rust/kernel/cpumask.rs b/rust/kernel/cpumask.rs
> new file mode 100644
> index 000000000000..13864424420b
> --- /dev/null
> +++ b/rust/kernel/cpumask.rs
> @@ -0,0 +1,168 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! CPU mask abstractions.
> +//!
> +//! C header: [`include/linux/cpumask.h`](srctree/include/linux/cpumask.=
h)
> +
> +use crate::{bindings, error::Result, prelude::ENOMEM};
> +
> +#[cfg(not(CONFIG_CPUMASK_OFFSTACK))]
> +use crate::prelude::{KBox, GFP_KERNEL};
> +
> +#[cfg(CONFIG_CPUMASK_OFFSTACK)]
> +use core::ptr;
> +
> +/// A simple implementation of `struct cpumask` from the C code.
> +pub struct Cpumask {
> +    ptr: *mut bindings::cpumask,
> +    owned: bool,
> +}
> +
> +impl Cpumask {
> +    /// Creates cpumask.
> +    #[cfg(CONFIG_CPUMASK_OFFSTACK)]
> +    fn new_inner(empty: bool) -> Result<Self> {
> +        let mut ptr: *mut bindings::cpumask =3D ptr::null_mut();
> +
> +        // SAFETY: Depending on the value of `gfp_flags`, this call may =
sleep. Other than that, it
> +        // is always safe to call this method.
> +        if !unsafe {
> +            if empty {
> +                bindings::zalloc_cpumask_var(&mut ptr, bindings::GFP_KER=
NEL)
> +            } else {
> +                bindings::alloc_cpumask_var(&mut ptr, bindings::GFP_KERN=
EL)
> +            }
> +        } {
> +            return Err(ENOMEM);
> +        }
> +
> +        Ok(Self { ptr, owned: true })
> +    }
> +
> +    /// Creates cpumask.
> +    #[cfg(not(CONFIG_CPUMASK_OFFSTACK))]
> +    fn new_inner(empty: bool) -> Result<Self> {
> +        let ptr =3D KBox::into_raw(KBox::new([bindings::cpumask::default=
(); 1], GFP_KERNEL)?);

I don't really understand this CPUMASK_OFFSTACK logic. You seem to
always allocate memory, but if OFFSTACK=3Dn, then shouldn't it be on the
stack ...?

> +        // SAFETY: Depending on the value of `gfp_flags`, this call may =
sleep. Other than that, it
> +        // is always safe to call this method.
> +        if !unsafe {
> +            if empty {
> +                bindings::zalloc_cpumask_var(ptr, bindings::GFP_KERNEL)
> +            } else {
> +                bindings::alloc_cpumask_var(ptr, bindings::GFP_KERNEL)
> +            }
> +        } {
> +            return Err(ENOMEM);
> +        }
> +
> +        Ok(Self {
> +            ptr: ptr as *mut _,
> +            owned: true,
> +        })
> +    }
> +
> +    /// Creates empty cpumask.
> +    pub fn new() -> Result<Self> {
> +        Self::new_inner(true)
> +    }
> +
> +    /// Creates uninitialized cpumask.
> +    fn new_uninit() -> Result<Self> {
> +        Self::new_inner(false)
> +    }
> +
> +    /// Clones cpumask.
> +    pub fn try_clone(&self) -> Result<Self> {
> +        let mut cpumask =3D Self::new_uninit()?;
> +
> +        self.copy(&mut cpumask);
> +        Ok(cpumask)
> +    }
> +
> +    /// Creates a new abstraction instance of an existing `struct cpumas=
k` pointer.
> +    ///
> +    /// # Safety
> +    ///
> +    /// Callers must ensure that `ptr` is valid, and non-null.
> +    #[cfg(CONFIG_CPUMASK_OFFSTACK)]
> +    pub unsafe fn get_cpumask(ptr: &mut *mut bindings::cpumask) -> Self =
{
> +        Self {
> +            ptr: *ptr,
> +            owned: false,

Using an owned variable in this way isn't great, IMO. We should use
two different types such as Owned<CpuMask> and &CpuMask to represent
owned vs borrowed instead.

> +        }
> +    }
> +
> +    /// Creates a new abstraction instance of an existing `struct cpumas=
k` pointer.
> +    ///
> +    /// # Safety
> +    ///
> +    /// Callers must ensure that `ptr` is valid, and non-null.
> +    #[cfg(not(CONFIG_CPUMASK_OFFSTACK))]
> +    pub unsafe fn get_cpumask(ptr: &mut bindings::cpumask_var_t) -> Self=
 {
> +        Self {
> +            ptr: ptr as *mut _,
> +            owned: false,
> +        }
> +    }
> +
> +    /// Obtain the raw `struct cpumask *`.
> +    pub fn as_raw(&mut self) -> *mut bindings::cpumask {
> +        self.ptr
> +    }
> +
> +    /// Sets CPU in the cpumask.
> +    ///
> +    /// Update the cpumask with a single CPU.
> +    pub fn set(&mut self, cpu: u32) {
> +        // SAFETY: `ptr` is guaranteed to be valid for the lifetime of `=
self`. And it is safe to
> +        // call `cpumask_set_cpus()` for any CPU.
> +        unsafe { bindings::cpumask_set_cpu(cpu, self.ptr) };
> +    }
> +
> +    /// Clears CPU in the cpumask.
> +    ///
> +    /// Update the cpumask with a single CPU.
> +    pub fn clear(&mut self, cpu: i32) {
> +        // SAFETY: `ptr` is guaranteed to be valid for the lifetime of `=
self`. And it is safe to
> +        // call `cpumask_clear_cpu()` for any CPU.
> +        unsafe { bindings::cpumask_clear_cpu(cpu, self.ptr) };
> +    }
> +
> +    /// Sets all CPUs in the cpumask.
> +    pub fn set_all(&mut self) {
> +        // SAFETY: `ptr` is guaranteed to be valid for the lifetime of `=
self`. And it is safe to
> +        // call `cpumask_setall()`.
> +        unsafe { bindings::cpumask_setall(self.ptr) };
> +    }
> +
> +    /// Gets weight of a cpumask.
> +    pub fn weight(&self) -> u32 {
> +        // SAFETY: `ptr` is guaranteed to be valid for the lifetime of `=
self`. And it is safe to
> +        // call `cpumask_weight()`.
> +        unsafe { bindings::cpumask_weight(self.ptr) }
> +    }
> +
> +    /// Copies cpumask.
> +    pub fn copy(&self, dstp: &mut Self) {
> +        // SAFETY: `ptr` is guaranteed to be valid for the lifetime of `=
self`. And it is safe to
> +        // call `cpumask_copy()`.
> +        unsafe { bindings::cpumask_copy(dstp.as_raw(), self.ptr) };
> +    }
> +}
> +
> +impl Drop for Cpumask {
> +    fn drop(&mut self) {
> +        if self.owned {
> +            // SAFETY: `ptr` is guaranteed to be valid for the lifetime =
of `self`. And it is safe
> +            // to call `free_cpumask_var()`.
> +            unsafe { bindings::free_cpumask_var(self.ptr) }

This is missing a semicolon, but it's not the last statement in the
block. Did you compile this with CPUMASK_OFFSTACK=3Dn? I don't think it
compiles with that setting.

> +            #[cfg(not(CONFIG_CPUMASK_OFFSTACK))]
> +            // SAFETY: The pointer was earlier initialized from the resu=
lt of `KBox::into_raw()`.
> +            unsafe {
> +                drop(KBox::from_raw(self.ptr))
> +            };

This looks like you did not run rustfmt.

Alice

