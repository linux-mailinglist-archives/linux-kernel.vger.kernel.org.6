Return-Path: <linux-kernel+bounces-242391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3604928776
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 13:03:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23E641F28231
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 11:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10954149DEA;
	Fri,  5 Jul 2024 11:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xNy3X87O"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62EBA149C4F
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 11:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720177354; cv=none; b=fKODDxzGs1sUTa++fyzUV66XO/b1SLnrhujf4aTcqxCuml/Et1EXkmFROIICW+P4v7f6VFYMGP1u+sNUL7AubzDoGSByIHJRdJNc2PWzxWiMGweUFECIccolHhr+CzJerJENHiYG7HiqzkO2YVnms60GOVB8D3taC08SpPzCWkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720177354; c=relaxed/simple;
	bh=S7Om4GQ30fztSBIh/w1AFY6W2F2OWAuCWAmODzJ3pS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IwsmI2LV2ZMz0nGZlPsdDiIocx6Uyc1NGF4MJS5v5jM24anWPfXDd8wQ0iCjvwhXoNLr2AyIse/BZOEU/B4EjsmUu8/n6Z8MbXVjk1HyPsOxnQqAhZjFzICeeDRTSt8oJuWHmYGY/8k0x4SVlETea2VeYMnRPrBuetb7/PNzpQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xNy3X87O; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-70b04cb28acso859896b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2024 04:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720177352; x=1720782152; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=f92fjw8JYMT1dRrD53VjhAAntEQwgMhVvh6//opJzE8=;
        b=xNy3X87OrauY7Bu6xLPpMPYKCNZvtVIkC+XZvIMK+UMjyUsAKcp4Won6TSlC+o9rfa
         f2ctiZcNg1cUd16zC1ouhfxWRxMcInzUvqdnVJBER/4qoWWms/h4+rKS1Gw8BuBjpOUx
         ghwqgzyOMaSK63zDn4rYF8ET72oL/c/FSEJQFX7Y32SNYWCGIEk/yY+0GvuYwoaeFC4D
         MgkXXcnYdwjlvSDtl9/9YtSx6JS7bBvq3Rb7NkR9o04Ur+NYv1ISU+g2ROhHsRIIjOkh
         URZ3WUhJhKDis9s5qBbH3o5ceY0jYxgc815QZ9WJ3+YhmUQJRON93diW4vU+zWjExBac
         ZH5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720177352; x=1720782152;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f92fjw8JYMT1dRrD53VjhAAntEQwgMhVvh6//opJzE8=;
        b=pFv6BNma3OF7Ye2ZPSzrf59dDUk2u9rUQM/ePoi3PU2Utr75TSOItokw47fchGMAeI
         ojpPLjJNsx7F3Dok5ONuaamN4BnQdUudfhWkAIm742asak/aKF2wPITD5kDI+YhUE/vk
         I3hD2RJlwyFmrmZosStnyL7zTHjRa/gip1kc/sMe+g7SGbSUAGLVZjbQl3HnXc2aYU06
         Y7c88Thsqd/B4ekXvPfUGI3zLfmxb+aeBjGPTMYZNiKpJabO2MsyN1VMIww0mFjFz4qP
         9rUHrSTHbrfwHNwI5CxBtOYdEcYmqWTqXBm/w18kZq05qH4WZ3INvsbEHibWfct3kcgR
         aZ1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVrLM/Sed1XlfWcz6TtstRJhiBa1Ikj64r1jaYAyT1jR0K6G/m4gybEbHlFgATw+Z8+V5JycXEdqtBNm5AT4/GlsWGX6jHci1QrqpW4
X-Gm-Message-State: AOJu0YyIlBZSejTDNdIaTYl1ZYhajYxaCU0c6SV8QK08DKvw0VaSDANw
	iLR76I9ruFwisyG29b4QvYpc12Q6/wm+owTu4jZU5/nPib44g0DSsBegw8AYutI=
X-Google-Smtp-Source: AGHT+IGn1rhycWvEt5pEiJxdXzjK4S9Y8JJLU4mSVvnpE1+Y+yvmX3R8Ee/LOSlG8/Svf+b05wC0wA==
X-Received: by 2002:a62:f205:0:b0:70a:ef84:7683 with SMTP id d2e1a72fcca58-70b01980885mr6239722b3a.1.1720177351516;
        Fri, 05 Jul 2024 04:02:31 -0700 (PDT)
Received: from localhost ([122.172.82.13])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70afffefeafsm2805087b3a.207.2024.07.05.04.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 04:02:30 -0700 (PDT)
Date: Fri, 5 Jul 2024 16:32:28 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>, linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
	rust-for-linux@vger.kernel.org,
	Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
	Erik Schilling <erik.schilling@linaro.org>,
	Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Joakim Bech <joakim.bech@linaro.org>, Rob Herring <robh@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH V3 1/8] rust: Add initial bindings for OPP framework
Message-ID: <20240705110228.qqhhynbwwuwpcdeo@vireshk-i7>
References: <cover.1719990273.git.viresh.kumar@linaro.org>
 <fe8e9a96b29122876346fc98a6a9ede7e4f28707.1719990273.git.viresh.kumar@linaro.org>
 <ZoVvn0QCSR8y4HQJ@Boquns-Mac-mini.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZoVvn0QCSR8y4HQJ@Boquns-Mac-mini.home>

Hi Boqun,

On 03-07-24, 08:34, Boqun Feng wrote:
> On Wed, Jul 03, 2024 at 12:44:26PM +0530, Viresh Kumar wrote:
> > +/// Operating performance point (OPP).
> > +///
> > +/// # Invariants
> > +///
> > +/// The pointer stored in `Self` is non-null and valid for the lifetime of the ARef instance. In
> > +/// particular, the ARef instance owns an increment on underlying object´s reference count.
> 
> Since you use `ARef` pattern now, you may want to rewrite this
> "invariants".

I copied it from the device's documentation. What all details should I
be writing here ? A link to some other implementation would be useful.

> > +impl Drop for OPP {
> 
> I don't think you need the `drop` implementation here, since it should
> be already handled by `impl AlwaysRefCounted`,

Right.

> could you try to a doc
> test for this? Something like:
> 
> 	let opp: ARef<OPP> = <from a raw dev_pm_opp ponter whose refcount is 1>
> 	drop(opp);

I now tested it with a kernel test to see what's going on internally

> IIUC, this will result double-free with the current implementation.

Quite the opposite actually. I am getting double get and a single put :)

Thanks a lot for pointing me to this direction as I have found that my
implementation was incorrect. This is how I understand it, I can be
wrong since I am okayish with Rust:

- What's getting returned from `from_raw_opp/from_raw_opp_owned` is a
  reference: `<&'a Self>`.

- Since this is a reference, when it gets out of scope, nothing
  happens. i.e. the `drop()` fn of `struct OPP` never gets called for
  the OPP object, as there is no real OPP object, but just a
  reference.

- When this gets converted to an `ARef` object (implicit typecasting),
  we increment the count. And when that gets dropped, we decrement it.
  But Apart from an `ARef` object, only the reference to the OPP gets
  dropped and hence again, drop() doesn't get called.

- The important part here is that `from_raw_opp()` shouldn't be
  incrementing the refcount, as drop() will never get called. And
  since we reach here from the C implementation, the OPP will remain
  valid for the function call.

- On the other hand, I can't return <&'a Self> from
  from_raw_opp_owned() anymore. In this case the OPP core has already
  incremented the refcount of the OPP (while it searched the OPP on
  behalf of the Rust code). Whatever is returned here, must drop the
  refcount when it goes out of scope. Also the returned OPP reference
  can live for a longer period of time in this case, since the call
  originates from the Rust side. So, it needs to be an explicit
  conversion to ARef which won't increment the refcount, but just
  decrement when the ARef gets out of scope.

Here is the diff that I need:

diff --git a/rust/kernel/opp.rs b/rust/kernel/opp.rs
index aaf220e6aeac..a99950b4d835 100644
--- a/rust/kernel/opp.rs
+++ b/rust/kernel/opp.rs
@@ -692,7 +692,7 @@ pub fn opp_from_freq(
         })?;
 
         // SAFETY: The `ptr` is guaranteed by the C code to be valid.
-        Ok(unsafe { OPP::from_raw_opp_owned(ptr)?.into() })
+        unsafe { OPP::from_raw_opp_owned(ptr) }
     }
 
     /// Finds OPP based on level.
@@ -718,7 +718,7 @@ pub fn opp_from_level(&self, mut level: u32, stype: SearchType) -> Result<ARef<O
         })?;
 
         // SAFETY: The `ptr` is guaranteed by the C code to be valid.
-        Ok(unsafe { OPP::from_raw_opp_owned(ptr)?.into() })
+        unsafe { OPP::from_raw_opp_owned(ptr) }
     }
 
     /// Finds OPP based on bandwidth.
@@ -743,7 +743,7 @@ pub fn opp_from_bw(&self, mut bw: u32, index: i32, stype: SearchType) -> Result<
         })?;
 
         // SAFETY: The `ptr` is guaranteed by the C code to be valid.
-        Ok(unsafe { OPP::from_raw_opp_owned(ptr)?.into() })
+        unsafe { OPP::from_raw_opp_owned(ptr) }
     }
 
     /// Enable the OPP.
@@ -834,31 +834,33 @@ unsafe fn dec_ref(obj: ptr::NonNull<Self>) {
 }
 
 impl OPP {
-    /// Creates a reference to a [`OPP`] from a valid pointer.
+    /// Creates an owned reference to a [`OPP`] from a valid pointer.
     ///
     /// # Safety
     ///
-    /// The caller must ensure that `ptr` is valid and remains valid for the lifetime of the
-    /// returned [`OPP`] reference.
-    pub unsafe fn from_raw_opp_owned<'a>(ptr: *mut bindings::dev_pm_opp) -> Result<&'a Self> {
-        // SAFETY: The caller guarantees that the pointer is not dangling
-        // and stays valid for the duration of 'a. The cast is okay because
-        // `OPP` is `repr(transparent)`.
-        Ok(unsafe { &*ptr.cast() })
+    /// The caller must ensure that `ptr` is valid and OPP's refcount is incremented. The refcount
+    /// will be decremented by `dec_ref` when the ARef object is dropped.
+    pub unsafe fn from_raw_opp_owned(ptr: *mut bindings::dev_pm_opp) -> Result<ARef<Self>> {
+        let ptr = ptr::NonNull::new(ptr).ok_or(ENODEV)?;
+
+        // SAFETY: The safety requirements guarantee the validity of the pointer.
+        //
+        // INVARIANT: The refcount is already incremented by the C API that returned the pointer,
+        // and we pass ownership of the refcount to the new `ARef<OPP>`.
+        Ok(unsafe { ARef::from_raw(ptr.cast()) })
     }
 
     /// Creates a reference to a [`OPP`] from a valid pointer.
     ///
     /// # Safety
     ///
-    /// The caller must ensure that `ptr` is valid and remains valid for the lifetime of the
-    /// returned [`OPP`] reference.
+    /// The caller must ensure that `ptr` is valid and remains valid for the duration of 'a. The
+    /// refcount is not updated by the Rust API unless the returned reference is converted to an
+    /// ARef object.
     pub unsafe fn from_raw_opp<'a>(ptr: *mut bindings::dev_pm_opp) -> Result<&'a Self> {
-        let opp = unsafe { Self::from_raw_opp_owned(ptr) }?;
-
-        // Take an extra reference to the OPP since the caller didn't take it.
-        opp.inc_ref();
-        Ok(opp)
+        // SAFETY: The caller guarantees that the pointer is not dangling and stays valid for the
+        // duration of 'a. The cast is okay because `OPP` is `repr(transparent)`.
+        Ok(unsafe { &*ptr.cast() })
     }
 
     #[inline]
@@ -910,10 +912,3 @@ pub fn is_turbo(&self) -> bool {
         unsafe { bindings::dev_pm_opp_is_turbo(self.as_raw()) }
     }
 }
-
-impl Drop for OPP {
-    fn drop(&mut self) {
-        // SAFETY: The safety requirements guarantee that the refcount is nonzero.
-        unsafe { bindings::dev_pm_opp_put(self.as_raw()) }
-    }
-}

Makes sense ?

-- 
viresh

