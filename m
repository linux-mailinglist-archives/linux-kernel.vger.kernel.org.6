Return-Path: <linux-kernel+bounces-422748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E059D9DB1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 19:57:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3355168542
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 18:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 623771DE2BD;
	Tue, 26 Nov 2024 18:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sedlak-dev.20230601.gappssmtp.com header.i=@sedlak-dev.20230601.gappssmtp.com header.b="eWFkV+Fj"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB751DDA0E
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 18:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732647467; cv=none; b=HC/KkF4TqMCPcXgxi9Tm10hzs6Q+2l7z2PFygNw83dDlEEQcq6321OaWrDiqcARgVm1KeS+ApN0QnRMHrXolSzeyHP/TZY0mE9zoUXU5FNZAxyMdvx7DLdL79UFfzm9yurUJQXb3crwg07osS65WNDQK+TwChPd5CRO7FggbRPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732647467; c=relaxed/simple;
	bh=FQdexGUZlaE4KFC2ddg2t0lNwQkVn1TXZdOgt3YQ8z0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FnAOeYYPb9QSoX06ILLpNvMxmb6f49XG464cK6RSUJb93YxrWRB/0DTkCbzvhs9DFXRIts/hM3BCgGKDY+whgsW5NTD6Cj/0bVD9xlkiSuY1xEj82aH0PMb8Kl3pKmzVlaOIRHfxpYmf4p+GJwnyWlUnCNe5Xwok4ICvvFqQAtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sedlak.dev; spf=none smtp.mailfrom=sedlak.dev; dkim=pass (2048-bit key) header.d=sedlak-dev.20230601.gappssmtp.com header.i=@sedlak-dev.20230601.gappssmtp.com header.b=eWFkV+Fj; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sedlak.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sedlak.dev
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-434a742481aso7898365e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 10:57:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sedlak-dev.20230601.gappssmtp.com; s=20230601; t=1732647463; x=1733252263; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lH+EuN7XG/opD7jydmM6mpYlIbILE0ML+h/J6BW4iZQ=;
        b=eWFkV+FjJX6XeZ0HBcMg3E9cGdSQwFY+IjsxjkcBg9DjN7AeounDmCV/j0XZ2fUthw
         H8IXKVeoDK44Pn1KGrtXIa+lenvnJxXRYHc0C+vj24WgGuH3gyxeZBi/15VvVz2uYp5w
         JNW2ye/srmkJfz5GiBrrbb1ssMMzK+AR/qu3jzauWuHlFPTOKwJCPFbEj+yHLdkgPOyL
         QdMOdMAIJHgG/jUlDII76Ay8C2s3KAk967v/HnftdYnbFpsLBkHoMqvvBQlyo+p2RiFA
         9C8eax4SxQ00KZrUKve7ujuxgNrtG0tZCMamBEkrouJLemfEVZtPAX8pfhfAxzM0ggXU
         a8XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732647463; x=1733252263;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lH+EuN7XG/opD7jydmM6mpYlIbILE0ML+h/J6BW4iZQ=;
        b=n/6vK1tybBBgHcmOA2bLD8THJ2oVMevbFE7HBZuj0MFbBDEIkBmAiUAjOllY9JPoC5
         NkKc9LJKlAVaEEfbf3DWCUaqnNtd1d6w6RONNhC9FqHl8nrF+EZbypA8CyUrerLuqO8d
         z8dKABzrJrxneVfVexr4Nlg7z8oHDS5QvL3/nLohY1Q1wCN6ntM4RnSkDmGweJjo5H9l
         reeHBKyJFEsx4KNH9TDUhKhPPYaOiGmpykj0xmhvLgresCmaswofpOeoSdhWgLrt4Iok
         Jury+8XB0vPh7aC3ovBCY0t3fNbjJQL/SZeEMsMRTcFhP2qJk+LvBBCqGAWiO8lTLtGK
         GOVQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHY+7TkB3aD1UTH/K+ztxhhXtkREub9Aoam6u41VtLkeFYK1Qbhi4t88/w7j9DOLhCqPdJhNBL6e9NMkw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWahAhEv+ZpCXookxo+bvdqGU6qZmwDks1Pdg+BasGtWracR3l
	xx/xNijmZ4B7Hx5jmpZzNGVquv9AtnvhbXhFaaxMdhBUpk1woMfZpVRZrN/GlW0=
X-Gm-Gg: ASbGncvfHM3SPBv6aMXgI9MoOxWANpr5cSxLS/1DgCP/5A3rIEoxAo49a2K5Xo/1WaK
	02W1pIwIWjCo2BOAguHEVO4uP5mfhOdtoZvW/AcmbdDJMXyBko9IcdL+E8h/R8V3ds/Yban6yVx
	YuETXrVMxOa4IMmiIkUenApTdLiQN9soGn3l/qfnsgeab5r5t+4KvLaQo7mHnIU3G2qH1H2naeZ
	8oAFLjfSQ+EvwCWpmLb20xh517m95ceNq2ED8kTBOSwVdigNWs=
X-Google-Smtp-Source: AGHT+IGqhYhQxwauHfnqcW1RwJZkdzHaoXh+dpbEcywdiTUJgvy/B3VA3nxqbz3Ou/oyHhKC09ewsQ==
X-Received: by 2002:a5d:6484:0:b0:382:455b:eec6 with SMTP id ffacd0b85a97d-385c6ec0cebmr32663f8f.35.1732647463113;
        Tue, 26 Nov 2024 10:57:43 -0800 (PST)
Received: from [192.168.88.249] ([95.85.217.110])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fd04ef5sm13970343f8f.111.2024.11.26.10.57.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Nov 2024 10:57:42 -0800 (PST)
Message-ID: <230b3602-5d68-4e79-969d-0d2df1fdf033@sedlak.dev>
Date: Tue, 26 Nov 2024 19:57:40 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] rust: Add `OnceLite` for executing code once
To: jens.korinth@tuta.io, Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>
Cc: rust-for-linux@vger.kernel.org,
 FUJITA Tomonori <fujita.tomonori@gmail.com>,
 Dirk Behme <dirk.behme@gmail.com>, linux-kernel@vger.kernel.org
References: <20241126-pr_once_macros-v4-0-410b8ca9643e@tuta.io>
 <20241126-pr_once_macros-v4-1-410b8ca9643e@tuta.io>
Content-Language: en-US
From: Daniel Sedlak <daniel@sedlak.dev>
In-Reply-To: <20241126-pr_once_macros-v4-1-410b8ca9643e@tuta.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/26/24 5:40 PM, Jens Korinth via B4 Relay wrote:
> From: Jens Korinth <jens.korinth@tuta.io>
> 
> Similar to `Once` in Rust's standard library, but with the same
> non-blocking behavior as the kernel's `DO_ONCE_LITE` macro. Abstraction
> allows easy replacement of the underlying sync mechanisms, see
> 
> https://lore.kernel.org/rust-for-linux/20241109-pr_once_macros-v3-0-6beb24e0cac8@tuta.io/.
> 
> Suggested-by: Boqun Feng <boqun.feng@gmail.com>
> Signed-off-by: Jens Korinth <jens.korinth@tuta.io>
> ---
>   rust/kernel/lib.rs       |   1 +
>   rust/kernel/once_lite.rs | 127 +++++++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 128 insertions(+)
> 
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index bf8d7f841f9425d19a24f3910929839cfe705c7f..2b0a80435d24f5e168679ec2e25bd68cd970dcdd 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -44,6 +44,7 @@
>   pub mod list;
>   #[cfg(CONFIG_NET)]
>   pub mod net;
> +pub mod once_lite;
>   pub mod page;
>   pub mod prelude;
>   pub mod print;
> diff --git a/rust/kernel/once_lite.rs b/rust/kernel/once_lite.rs
> new file mode 100644
> index 0000000000000000000000000000000000000000..723c3244fc856fe974ddd33de5415e7ced37f315
> --- /dev/null
> +++ b/rust/kernel/once_lite.rs
> @@ -0,0 +1,127 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! A one-time only global execution primitive.
> +//!
> +//! This primitive is meant to be used to execute code only once. It is
> +//! similar in design to Rust's
> +//! [`std::sync:Once`](https://doc.rust-lang.org/std/sync/struct.Once.html),
> +//! but borrowing the non-blocking mechanism used in the kernel's
> +//! [`DO_ONCE_LITE`] macro.
> +//!
> +//! An example use case would be to print a message only the first time.
> +//!
> +//! [`DO_ONCE_LITE`]: srctree/include/linux/once_lite.h
> +//!
> +//! C header: [`include/linux/once_lite.h`](srctree/include/linux/once_lite.h)
> +//!
> +//! Reference: <https://doc.rust-lang.org/std/sync/struct.Once.html>
> +
> +use core::sync::atomic::{AtomicBool, Ordering::Relaxed};
> +
> +/// A low-level synchronization primitive for one-time global execution.
> +///
> +/// Based on the
> +/// [`std::sync:Once`](https://doc.rust-lang.org/std/sync/struct.Once.html)
> +/// interface, but internally equivalent the kernel's [`DO_ONCE_LITE`]
> +/// macro. The Rust macro `do_once_lite` replacing it uses `OnceLite`
> +/// internally.
> +///
> +/// [`DO_ONCE_LITE`]: srctree/include/linux/once_lite.h
> +///
> +/// # Examples
> +///
> +/// ```rust
The `rust` part should be default value for rustdoc tests, can we please 
omit that?
> +/// static START: kernel::once_lite::OnceLite =
> +///     kernel::once_lite::OnceLite::new();
> +///
> +/// let mut x: i32 = 0;
> +///
> +/// START.call_once(|| {
> +///   // run initialization here
> +///   x = 42;
> +/// });
> +/// while !START.is_completed() { /* busy wait */ }
> +/// assert_eq!(x, 42);
> +/// ```
> +///
> +pub struct OnceLite(AtomicBool, AtomicBool);
Have you considered it to be implemented like `AtomicU32`? I think™ that 
one atomic variable is more than enough.
> +
> +impl OnceLite {
> +    /// Creates a new `OnceLite` value.
> +    #[inline(always)]
> +    pub const fn new() -> Self {
> +        Self(AtomicBool::new(false), AtomicBool::new(false))
> +    }
> +
> +    /// Performs an initialization routine once and only once. The given
> +    /// closure will be executed if this is the first time `call_once` has
> +    /// been called, and otherwise the routine will not be invoked.
> +    ///
> +    /// This method will _not_ block the calling thread if another
> +    /// initialization is currently running. It is _not_ guaranteed that the
> +    /// initialization routine will have completed by the time the calling
> +    /// thread continues execution.
> +    ///
> +    /// Note that this is different from the guarantees made by
> +    /// [`std::sync::Once`], but identical to the way the implementation of
> +    /// the kernel's [`DO_ONCE_LITE_IF`] macro is behaving at the time of
> +    /// writing.
> +    ///
> +    /// [`std::sync::Once`]: https://doc.rust-lang.org/std/sync/struct.Once.html
> +    /// [`DO_ONCE_LITE_IF`]: srctree/include/once_lite.h
> +    #[inline(always)]
> +    pub fn call_once<F: FnOnce()>(&self, f: F) {
> +        if !self.0.load(Relaxed) && !self.0.swap(true, Relaxed) {
> +            f()
> +        };
> +        self.1.store(true, Relaxed);
I think the memory ordering is wrong here. Since it is `Relaxed`, the 
`self.1` and `self.0` can get reordered during execution. So `self.0` 
can be false, even though `self.1` will be true. Not on x86, but on 
architectures with weaker memory models it can happen.

Even the implementation in the Rust std, uses at least 
`Acquire`/`Release`, where the reordering shouldn't be possible see [1].

[1]: 
https://github.com/rust-lang/rust/blob/master/library/std/src/sys/sync/once/futex.rs
> +    }
> +
> +    /// Returns `true` if some `call_once` call has completed successfully.
> +    /// Specifically, `is_completed` will return `false` in the following
> +    /// situations:
> +    ///
> +    /// 1. `call_once()` was not called at all,
> +    /// 2. `call_once()` was called, but has not yet completed.
> +    ///
> +    /// # Examples
> +    ///
> +    /// ```rust
Also here the `rust` part should be the default value.
> +    /// static INIT: kernel::once_lite::OnceLite =
> +    ///     kernel::once_lite::OnceLite::new();
> +    ///
> +    /// assert_eq!(INIT.is_completed(), false);
> +    /// INIT.call_once(|| {
> +    ///     assert_eq!(INIT.is_completed(), false);
> +    /// });
> +    /// assert_eq!(INIT.is_completed(), true);
> +    /// ```
> +    #[inline(always)]
> +    pub fn is_completed(&self) -> bool {
> +        self.1.load(Relaxed)
> +    }
> +}
> +
> +/// Executes code only once.
> +///
> +/// Equivalent to the kernel's [`DO_ONCE_LITE`] macro: Expression is
> +/// evaluated at most once by the first thread, other threads will not be
> +/// blocked while executing in first thread, nor are there any guarantees
> +/// regarding the visibility of side-effects of the called expression.
> +///
> +/// [`DO_ONCE_LITE`]: srctree/include/linux/once_lite.h
> +///
> +/// # Examples
> +///
> +/// ```
> +/// let mut x: i32 = 0;
> +/// kernel::do_once_lite!((||{x = 42;})());
> +/// ```
> +#[macro_export]
> +macro_rules! do_once_lite {
> +    ($e: expr) => {{
> +        #[link_section = ".data.once"]
> +        static ONCE: $crate::once_lite::OnceLite = $crate::once_lite::OnceLite::new();
> +        ONCE.call_once(|| $e);
> +    }};
> +}
> 

Thanks for working on that!

Daniel


