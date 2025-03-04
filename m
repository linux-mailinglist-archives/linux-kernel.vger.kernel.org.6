Return-Path: <linux-kernel+bounces-543579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5078AA4D728
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 10:00:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53956188E7A5
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 08:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FB131FE44E;
	Tue,  4 Mar 2025 08:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="br+aWbNg"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6605204088
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 08:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741078438; cv=none; b=Y3DbEIjhPq/IhJyKQRuztiPWqNmyCaq6UTbq0xiTUPqBa0rFqvkJ0nwZmDlTRTPN8AODEX2dOvNsqZZItZWIlHAPTQ8CyT1mW/sufSY6iXpwy35PPG1FNUmhCHkEIffj9ASJqBDLCf7bJKRix5MsQAvvhMo9IE1tBoZ4Z0HubrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741078438; c=relaxed/simple;
	bh=wzgVeH2iZAgK+OV0AmNH5+torfAgfEWzdJZTvzH35RY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JKD2xL3NFNA+mM6CTE5GF6sU40IBU1IBtiDm0co4gHjsXHFWEvo+qypYMbZ9VgGVGe8u658+eSWtWAknVYpEd45OWDT1mpLlN/sF0R/UbJ+prRINHbXtvQNHaMvZDtxVTynu370FDvMxS5kv2fvFFXJp0w+G8xYg+hJm9J71Qsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=br+aWbNg; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2feb96064e4so8495857a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 00:53:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741078435; x=1741683235; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=E0x864LV9vrzBzd/PsD5RrZ/kDJqjI2owc7G6mwEbH0=;
        b=br+aWbNgaU5TNBEy7LA6bvRYNsXIRj6KMqH6MYZfQsjgOM3TP6M9d0PrOgNzTDdatL
         4kigRFO0ugoO1PgyB/1Uz7k7GDv9m6YaoYnbS5bYvhbqVT0UbllMn0K5rqz46tn3G/LK
         tm7hHEVs/zf0XabTvQyBtvwXeAivJLUcRFG7Ep4kbS7qboOZTlhCoRLcM/GsIv4mhsDW
         I1p4+gEUtnnpYang5mbleu49diq8qSd87Ii8C5zpccUJLD6FmyQ43zEtZRKjtDpq6Idf
         Kh45B7cvO7cr49xJ2go5s8jFCqKJWQo3VTGiW6DGS0SUfdvnyFNzHA0lI4tpPARi2SRX
         qqeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741078435; x=1741683235;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E0x864LV9vrzBzd/PsD5RrZ/kDJqjI2owc7G6mwEbH0=;
        b=VQTi1YV+aLYFyocpc/4yys901FGzy0u2Q5wxTa6rD+uKd7a8h8o3aAlXGgJ3OvlmGA
         luAbUR/C7jlxl44OdKMhRWqBuysNwhAewFWSU3wZ+FL7U3/E+iMd9422f6bPS2iXF0/9
         Y4xcSudbsu/RkOmYbXoMYgBuwtCd0bKy1LlBsBcEc8WCnPtu6rquiF4KshvlBvEs6EGY
         bXM90HHkodkIjETt8AeZamoB14T9WdGnTtS9LjmPz3b0S2s42R6UwQMXcAJWMFusyCc3
         jk88uYwvUaQxPBegmDF3uPg4ApyRuVWcEexonGw3Q6r+He+pX1QxMvHug+iQiqGgENoU
         tfDg==
X-Forwarded-Encrypted: i=1; AJvYcCXSmfEcVYwUWGoMjART4uu5YRFAhxoPXY3Hn39kBUYgpqM+vBbovPW3snaSD30NpweupPypiOBcTLXEP9o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBMmpQB8Xxhw/FzeLETJWS/fKVWN+UFmR5EkGe1ELaYHts0d4f
	mC4VtwgWWmyypC9tsiY724fSUZ0qRdrGCRpCxMcvq03yZiqSKtfetex9l7XTd+c=
X-Gm-Gg: ASbGncs8xvhuTCrURCyE/ZZ+fZyys8C9lLevh7q3cJW/QnYYCHyT4DH4QXEnt1382dY
	bd0mpB6VtCskjCC/7pDkSiUIlV7zN1FqsZ+QdaBkVsKe+sdWa4SU7flKB4oHNepFLXH93k1U9dn
	RZUvtMY6OlY0D762tIQiRmjGLFrEWDU8kfDOKwzvJDyYee/ffXzcnVNzpC4kLebrP5yq/yn77VO
	EiNzcNOxL8LwquFkGA+ladTYeKeDqvp4Mup6FG6AsCCfUphyXJfgKLP3Ud9AT7DbYqfQgIg/qXJ
	6x7wGQXILYNeAnf+zdgsu6x2V8EtINFuZgUciqKV2Q7Zxw==
X-Google-Smtp-Source: AGHT+IFdFTTfqIOr3puUYW+t+84g8sQqcnrDMvn/JLyondd0YLc+BE2wI//6xrrG8j4UY3K/GoC9Rw==
X-Received: by 2002:a17:90b:3b85:b0:2f4:434d:c7ed with SMTP id 98e67ed59e1d1-2febab75e0bmr28826018a91.16.1741078434808;
        Tue, 04 Mar 2025 00:53:54 -0800 (PST)
Received: from localhost ([122.172.84.15])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fea696e3f0sm10429399a91.37.2025.03.04.00.53.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 00:53:54 -0800 (PST)
Date: Tue, 4 Mar 2025 14:23:51 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Russell King <linux@armlinux.org.uk>, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Daniel Almeida <daniel.almeida@collabora.com>
Subject: Re: [PATCH V3 2/2] rust: Add initial clk abstractions
Message-ID: <20250304085351.inrvjgixvxla4yn3@vireshk-i7>
References: <cover.1740995194.git.viresh.kumar@linaro.org>
 <023e3061cc164087b9079a9f6cb7e9fbf286794e.1740995194.git.viresh.kumar@linaro.org>
 <CANiq72kdWzFOZ39EoFNxEAbk4KYgzLi1OAEc1zn8BM07VpXy3g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72kdWzFOZ39EoFNxEAbk4KYgzLi1OAEc1zn8BM07VpXy3g@mail.gmail.com>

On 03-03-25, 11:16, Miguel Ojeda wrote:
> On Mon, Mar 3, 2025 at 11:00 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > +/// Frequency unit.
> > +pub type Hertz = crate::ffi::c_ulong;
> 
> Do we want this to be an alias or would it make sense to take the
> chance to make this a newtype?

I have tried some improvements based on your (and Alice's comments), please see
if it looks any better now.

-- 
viresh

-------------------------8<-------------------------

diff --git a/rust/kernel/clk.rs b/rust/kernel/clk.rs
new file mode 100644
index 000000000000..fc3cb0f5f332
--- /dev/null
+++ b/rust/kernel/clk.rs
@@ -0,0 +1,232 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Clock abstractions.
+//!
+//! C header: [`include/linux/clk.h`](srctree/include/linux/clk.h)
+//!
+//! Reference: <https://docs.kernel.org/driver-api/clk.html>
+
+use crate::{
+    bindings,
+    device::Device,
+    error::{from_err_ptr, to_result, Result},
+    ffi::c_ulong,
+    prelude::*,
+};
+
+use core::{ops::Deref, ptr};
+
+/// Frequency unit.
+#[derive(Copy, Clone, PartialEq, Eq, Debug)]
+pub struct Hertz(c_ulong);
+
+impl Hertz {
+    /// Creates a new `Hertz` value.
+    pub fn new(freq: c_ulong) -> Self {
+        Hertz(freq)
+    }
+
+    /// Returns the frequency in `Hertz`.
+    pub fn value(self) -> c_ulong {
+        self.0
+    }
+}
+
+/// This structure represents the Rust abstraction for a C [`struct clk`].
+///
+/// # Invariants
+///
+/// A [`Clk`] instance always corresponds to a valid [`struct clk`] created by the C portion of the
+/// kernel.
+///
+/// Instances of this type are reference-counted. Calling `get` ensures that the allocation remains
+/// valid for the lifetime of the [`Clk`].
+///
+/// ## Example
+///
+/// The following example demonstrates how to obtain and configure a clock for a device.
+///
+/// ```
+/// use kernel::clk::{Clk, Hertz};
+/// use kernel::device::Device;
+/// use kernel::error::Result;
+///
+/// fn configure_clk(dev: &Device) -> Result {
+///     let clk = Clk::get(dev, "apb_clk")?;
+///
+///     clk.prepare_enable()?;
+///
+///     let expected_rate = Hertz::new(1_000_000_000);
+///
+///     if clk.rate() != expected_rate {
+///         clk.set_rate(expected_rate)?;
+///     }
+///
+///     clk.disable_unprepare();
+///     Ok(())
+/// }
+/// ```
+///
+/// [`struct clk`]: https://docs.kernel.org/driver-api/clk.html
+#[repr(transparent)]
+pub struct Clk(*mut bindings::clk);
+
+impl Clk {
+    /// Gets `Clk` corresponding to a [`Device`] and a connection id.
+    pub fn get(dev: &Device, name: Option<&CStr>) -> Result<Self> {
+        let con_id = if let Some(name) = name {
+            name.as_ptr() as *const _
+        } else {
+            ptr::null()
+        };
+
+        // SAFETY: It is safe to call `clk_get()` for a valid device pointer.
+        Ok(Self(from_err_ptr(unsafe {
+            bindings::clk_get(dev.as_raw(), con_id)
+        })?))
+    }
+
+    /// Obtain the raw `struct clk *`.
+    #[inline]
+    pub fn as_raw(&self) -> *mut bindings::clk {
+        self.0
+    }
+
+    /// Enable the clock.
+    #[inline]
+    pub fn enable(&self) -> Result {
+        // SAFETY: It is safe to call clk APIs of the C code for a clock pointer earlier returned
+        // by `clk_get()`.
+        to_result(unsafe { bindings::clk_enable(self.as_raw()) })
+    }
+
+    /// Disable the clock.
+    #[inline]
+    pub fn disable(&self) {
+        // SAFETY: It is safe to call clk APIs of the C code for a clock pointer earlier returned
+        // by `clk_get()`.
+        unsafe { bindings::clk_disable(self.as_raw()) };
+    }
+
+    /// Prepare the clock.
+    #[inline]
+    pub fn prepare(&self) -> Result {
+        // SAFETY: It is safe to call clk APIs of the C code for a clock pointer earlier returned
+        // by `clk_get()`.
+        to_result(unsafe { bindings::clk_prepare(self.as_raw()) })
+    }
+
+    /// Unprepare the clock.
+    #[inline]
+    pub fn unprepare(&self) {
+        // SAFETY: It is safe to call clk APIs of the C code for a clock pointer earlier returned
+        // by `clk_get()`.
+        unsafe { bindings::clk_unprepare(self.as_raw()) };
+    }
+
+    /// Prepare and enable the clock.
+    #[inline]
+    pub fn prepare_enable(&self) -> Result {
+        // SAFETY: It is safe to call clk APIs of the C code for a clock pointer earlier returned
+        // by `clk_get()`.
+        to_result(unsafe { bindings::clk_prepare_enable(self.as_raw()) })
+    }
+
+    /// Disable and unprepare the clock.
+    #[inline]
+    pub fn disable_unprepare(&self) {
+        // SAFETY: It is safe to call clk APIs of the C code for a clock pointer earlier returned
+        // by `clk_get()`.
+        unsafe { bindings::clk_disable_unprepare(self.as_raw()) };
+    }
+
+    /// Get clock's rate.
+    #[inline]
+    pub fn rate(&self) -> Hertz {
+        // SAFETY: It is safe to call clk APIs of the C code for a clock pointer earlier returned
+        // by `clk_get()`.
+        Hertz::new(unsafe { bindings::clk_get_rate(self.as_raw()) })
+    }
+
+    /// Set clock's rate.
+    #[inline]
+    pub fn set_rate(&self, rate: Hertz) -> Result {
+        // SAFETY: It is safe to call clk APIs of the C code for a clock pointer earlier returned
+        // by `clk_get()`.
+        to_result(unsafe { bindings::clk_set_rate(self.as_raw(), rate.value()) })
+    }
+}
+
+impl Drop for Clk {
+    fn drop(&mut self) {
+        // SAFETY: It is safe to call clk APIs of the C code for a clock pointer earlier returned
+        // by `clk_get()`.
+        unsafe { bindings::clk_put(self.as_raw()) };
+    }
+}
+
+/// A lightweight wrapper around an optional [`Clk`].
+///
+/// An `OptionalClk` represents a [`Clk`] that a driver can function without but may improve
+/// performance or enable additional features when available.
+///
+/// # Invariants
+///
+/// An `OptionalClk` instance encapsulates a [`Clk`] with either a valid or `NULL` [`struct clk`] pointer.
+///
+/// Instances of this type are reference-counted. Calling `get` ensures that the allocation remains
+/// valid for the lifetime of the `OptionalClk`.
+///
+/// ## Example
+///
+/// The following example demonstrates how to obtain and configure an optional clock for a device.
+/// The code functions correctly whether or not the clock is available.
+///
+/// ```
+/// use kernel::clk::{OptionalClk, Hertz};
+/// use kernel::device::Device;
+/// use kernel::error::Result;
+///
+/// fn configure_clk(dev: &Device) -> Result {
+///     let clk = OptionalClk::get(dev, "apb_clk")?;
+///
+///     clk.prepare_enable()?;
+///
+///     let expected_rate = Hertz::new(1_000_000_000);
+///
+///     if clk.rate() != expected_rate {
+///         clk.set_rate(expected_rate)?;
+///     }
+///
+///     clk.disable_unprepare();
+///     Ok(())
+/// }
+/// ```
+///
+/// [`struct clk`]: https://docs.kernel.org/driver-api/clk.html
+pub struct OptionalClk(Clk);
+
+impl OptionalClk {
+    /// Gets `OptionalClk` corresponding to a [`Device`] and a connection id.
+    pub fn get(dev: &Device, name: Option<&CStr>) -> Result<Self> {
+        let con_id = if let Some(name) = name {
+            name.as_ptr() as *const _
+        } else {
+            ptr::null()
+        };
+
+        // SAFETY: It is safe to call `clk_get_optional()` for a valid device pointer.
+        Ok(Self(Clk(from_err_ptr(unsafe {
+            bindings::clk_get_optional(dev.as_raw(), con_id)
+        })?)))
+    }
+}
+
+// Make `OptionalClk` behave like [`Clk`].
+impl Deref for OptionalClk {
+    type Target = Clk;
+
+    fn deref(&self) -> &Clk {
+        &self.0
+    }
+}

