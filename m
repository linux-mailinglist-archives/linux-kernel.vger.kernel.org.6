Return-Path: <linux-kernel+bounces-532166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96A05A449D0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 19:12:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CA56881037
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 18:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BCED1C6FFF;
	Tue, 25 Feb 2025 18:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MwkoDxnm"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A32719D071
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 18:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740506549; cv=none; b=FbVxxYwogL+3Xvz75BfV3AAgnR3oj0RsVr9BeNA7M59MAG4g2ywhJ5vbuVayRjlvU/PqgTMdFfeLLJUIJ6jkCvKaXOQ5ikp9xjG/a/4kx2KxLSgVmsWhiBVzDs/n9jQHSnj/uf5b9bemLwsIystO6Oxc3ccccKJPUN4ySTER1ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740506549; c=relaxed/simple;
	bh=TdAhhfTdihbKHkgKSQ3rmFE7THORmVJYHYEaKZXuA2Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=V0tIkKeZJLyShp2T0xoj3YuTd575DulacGcIfidotiqu7QSuoj3FlJsZOXK8iXJL+B2deZjHu7VQbxSUDWb/qS+LEfdB6l7rbByeqCvdq+5rofc7RTdGwPZ/uXDG8fD0uNUX63Wf0+YLot7hQWb9fdFcQ2Xby9cg9YBOvi/PN2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MwkoDxnm; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4394c0a58e7so47028885e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 10:02:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740506546; x=1741111346; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wlfPVBZZ/vh6rgusKPck6fWTpnCZt+dxCUkOfORTBvc=;
        b=MwkoDxnm/jHPOIuI4DdLR2gKcGSV9S+xFaRCVuDtGINyBOiLUdDLIdbc9S+G6f6TpT
         lpFkTREasEUMHqCQVkI/ZmDRWG5SORRTDNVfOeK0hLIohEH1rTHmBFSKZmpztrlcSNFt
         Zg14DBiyWTPSrsfD82fyNBSGA6pYEscC0GITuLG5qxHW5eC9wJ0nt9giE3NMKGNSUNDq
         YVV6t1J57WnbZbWvkXDhIUqEPJPJXzbdanr9Iy93WKeV6PSoAIngqiQEXyi/kegBvQxP
         E0GXNid4LI3HabwGKDiWMlcFCdJ6MkCj3QO3YM+m+h7kwqYRFQmXLzDTjHdaaojFX23X
         3BRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740506546; x=1741111346;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wlfPVBZZ/vh6rgusKPck6fWTpnCZt+dxCUkOfORTBvc=;
        b=m6iLF4okNKARdXSc7WWkGPZaexXhq7+QDKi4bSCIbStlBr6haEv6rhssVYglTWXVe4
         uNLWMawH7qK5tL49muIV8UgFwRYECSf4/6AUU2u2uGQaDTUmRp3FRDyTfDmtFYbE92Ku
         NWCCXBNgYNe7JFrG/ZTkJdKoVUtyl/5hvSqTlbu6Ix5bKCqFo40pDDCvEgl13FsSSrcu
         dEFdRDthz+pVtcaeI20gW8Ex9pRJ7Ecnbj70bJKoGsk98spCPVfpGwjaBZb468mqF59i
         xD/VvXcvWkV2+T22vOc5DEddscj3JKHCCTwqGXRe4owwn7BIk1PwbmRDdQCYp3Px4JFh
         GltQ==
X-Forwarded-Encrypted: i=1; AJvYcCXN6N9CzjYgX6xlZRIA+qSTPkJG+W9i5ZELXbqRxT/BuNiafvCscmaIcpECw9KfCeHRG3elo/2fV9BNBec=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo5MbV42NiHJ0F2tI300F0meGTa1zzRWYZLsB5kkd4mKlPe8uM
	hjFnxu6cGhZXFkXjEhHQ9FLvHEK/3dOu8XSyFukCGjpITLMnMH0kCmSUiGIAw7Mkoy1GzOGorU+
	cMG/jn9Tx5SCWnA==
X-Google-Smtp-Source: AGHT+IGHoNzZZoRl34BGjDpP1UGjlZR7bNfueBgNuOPcBxOqARcnLGpsh7/8isF4XnVML+cE0SAWGX0G/ZNCpks=
X-Received: from wmbjg14.prod.google.com ([2002:a05:600c:a00e:b0:439:4366:35c2])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3b91:b0:439:9e13:2dd7 with SMTP id 5b1f17b1804b1-43aa7a63c45mr75548655e9.2.1740506545880;
 Tue, 25 Feb 2025 10:02:25 -0800 (PST)
Date: Tue, 25 Feb 2025 18:02:23 +0000
In-Reply-To: <CAH5fLggyEXyyaFNnmBCPOSX051TiFyAp0B8GfahbPg=+LrtUWA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CAH5fLggyEXyyaFNnmBCPOSX051TiFyAp0B8GfahbPg=+LrtUWA@mail.gmail.com>
X-Mailer: git-send-email 2.48.1.658.g4767266eb4-goog
Message-ID: <20250225180223.763026-1-aliceryhl@google.com>
Subject: Re: [PATCH 1/2] rust: Add initial cpumask abstractions
From: Alice Ryhl <aliceryhl@google.com>
To: aliceryhl@google.com
Cc: a.hindborg@kernel.org, alex.gaynor@gmail.com, benno.lossin@proton.me, 
	bjorn3_gh@protonmail.com, boqun.feng@gmail.com, dakr@redhat.com, 
	gary@garyguo.net, linux-kernel@vger.kernel.org, linux@rasmusvillemoes.dk, 
	ojeda@kernel.org, rust-for-linux@vger.kernel.org, tmgross@umich.edu, 
	vincent.guittot@linaro.org, viresh.kumar@linaro.org, yury.norov@gmail.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 6:12=E2=80=AFPM Alice Ryhl <aliceryhl@google.com> w=
rote:
>
> On Tue, Feb 25, 2025 at 6:02=E2=80=AFPM Viresh Kumar <viresh.kumar@linaro=
.org> wrote:
> >
> > On Tue, 25 Feb 2025 at 17:23, Alice Ryhl <aliceryhl@google.com> wrote:
> >
> > > Is it a problem if a value of type struct cpumask is moved? It looks
> > > like it is just an array of longs?
> >
> > With the current code, if I replace the Box with an on-stack variable,
> > the kernel crashes.
> >
> > In my usecase, the pointer to the cpumask array is sent to the OPP
> > core, which may update the content, though it doesn't save the pointer.
> >
> > But for another usecase, the C code may end up saving the pointer.
>
> I don't think that case applies here. Variables that could be stashed
> like that need a destructor that removes the pointer from the relevant
> C structures. This is because pinning only prevents the owner from
> moving the variable - it doesn't prevent the owner from destroying it.

I believe you can implement the offstack stuff like this. The idea is to ha=
ve
one type that corresponds to `struct cpumask` and another type that corresp=
onds
to `cpumask_var_t` on the C side. Only the latter type would need to do
anything wrt. the CPUMASK_OFFSTACK setting.


diff --git a/rust/kernel/cpumask.rs b/rust/kernel/cpumask.rs
index 13864424420b..f82dafbc4e61 100644
--- a/rust/kernel/cpumask.rs
+++ b/rust/kernel/cpumask.rs
@@ -4,111 +4,45 @@
 //!
 //! C header: [`include/linux/cpumask.h`](srctree/include/linux/cpumask.h)
=20
-use crate::{bindings, error::Result, prelude::ENOMEM};
-
-#[cfg(not(CONFIG_CPUMASK_OFFSTACK))]
-use crate::prelude::{KBox, GFP_KERNEL};
-
+use crate::{
+    alloc::{AllocError, Flags},
+    bindings,
+    prelude::*,
+    types::Opaque,
+};
 #[cfg(CONFIG_CPUMASK_OFFSTACK)]
-use core::ptr;
+use core::ptr::{self, NonNull};
=20
-/// A simple implementation of `struct cpumask` from the C code.
+/// This corresponds to the C type `struct cpumask`.
+#[repr(transparent)]
 pub struct Cpumask {
-    ptr: *mut bindings::cpumask,
-    owned: bool,
+    mask: Opaque<bindings::cpumask>,
 }
=20
 impl Cpumask {
-    /// Creates cpumask.
-    #[cfg(CONFIG_CPUMASK_OFFSTACK)]
-    fn new_inner(empty: bool) -> Result<Self> {
-        let mut ptr: *mut bindings::cpumask =3D ptr::null_mut();
-
-        // SAFETY: Depending on the value of `gfp_flags`, this call may sl=
eep. Other than that, it
-        // is always safe to call this method.
-        if !unsafe {
-            if empty {
-                bindings::zalloc_cpumask_var(&mut ptr, bindings::GFP_KERNE=
L)
-            } else {
-                bindings::alloc_cpumask_var(&mut ptr, bindings::GFP_KERNEL=
)
-            }
-        } {
-            return Err(ENOMEM);
-        }
-
-        Ok(Self { ptr, owned: true })
-    }
-
-    /// Creates cpumask.
-    #[cfg(not(CONFIG_CPUMASK_OFFSTACK))]
-    fn new_inner(empty: bool) -> Result<Self> {
-        let ptr =3D KBox::into_raw(KBox::new([bindings::cpumask::default()=
; 1], GFP_KERNEL)?);
-
-        // SAFETY: Depending on the value of `gfp_flags`, this call may sl=
eep. Other than that, it
-        // is always safe to call this method.
-        if !unsafe {
-            if empty {
-                bindings::zalloc_cpumask_var(ptr, bindings::GFP_KERNEL)
-            } else {
-                bindings::alloc_cpumask_var(ptr, bindings::GFP_KERNEL)
-            }
-        } {
-            return Err(ENOMEM);
-        }
-
-        Ok(Self {
-            ptr: ptr as *mut _,
-            owned: true,
-        })
-    }
-
-    /// Creates empty cpumask.
-    pub fn new() -> Result<Self> {
-        Self::new_inner(true)
-    }
-
-    /// Creates uninitialized cpumask.
-    fn new_uninit() -> Result<Self> {
-        Self::new_inner(false)
-    }
-
-    /// Clones cpumask.
-    pub fn try_clone(&self) -> Result<Self> {
-        let mut cpumask =3D Self::new_uninit()?;
-
-        self.copy(&mut cpumask);
-        Ok(cpumask)
-    }
-
-    /// Creates a new abstraction instance of an existing `struct cpumask`=
 pointer.
+    /// Creates a reference to an existing `struct cpumask` pointer.
     ///
     /// # Safety
     ///
-    /// Callers must ensure that `ptr` is valid, and non-null.
-    #[cfg(CONFIG_CPUMASK_OFFSTACK)]
-    pub unsafe fn get_cpumask(ptr: &mut *mut bindings::cpumask) -> Self {
-        Self {
-            ptr: *ptr,
-            owned: false,
-        }
+    /// The caller must ensure that `ptr` is valid for writing and remains=
 valid for the lifetime
+    /// of the returned reference.
+    pub unsafe fn from_raw_mut<'a>(ptr: *mut bindings::cpumask) -> &'a mut=
 Self {
+        unsafe { &mut *ptr.cast() }
     }
=20
-    /// Creates a new abstraction instance of an existing `struct cpumask`=
 pointer.
+    /// Creates a reference to an existing `struct cpumask` pointer.
     ///
     /// # Safety
     ///
-    /// Callers must ensure that `ptr` is valid, and non-null.
-    #[cfg(not(CONFIG_CPUMASK_OFFSTACK))]
-    pub unsafe fn get_cpumask(ptr: &mut bindings::cpumask_var_t) -> Self {
-        Self {
-            ptr: ptr as *mut _,
-            owned: false,
-        }
+    /// The caller must ensure that `ptr` is valid for reading and remains=
 valid for the lifetime
+    /// of the returned reference.
+    pub unsafe fn from_raw<'a>(ptr: *const bindings::cpumask) -> &'a Self =
{
+        unsafe { &*ptr.cast() }
     }
=20
     /// Obtain the raw `struct cpumask *`.
-    pub fn as_raw(&mut self) -> *mut bindings::cpumask {
-        self.ptr
+    pub fn as_raw(&self) -> *mut bindings::cpumask {
+        self as *const Cpumask as *mut bindings::cpumask
     }
=20
     /// Sets CPU in the cpumask.
@@ -117,7 +51,7 @@ pub fn as_raw(&mut self) -> *mut bindings::cpumask {
     pub fn set(&mut self, cpu: u32) {
         // SAFETY: `ptr` is guaranteed to be valid for the lifetime of `se=
lf`. And it is safe to
         // call `cpumask_set_cpus()` for any CPU.
-        unsafe { bindings::cpumask_set_cpu(cpu, self.ptr) };
+        unsafe { bindings::cpumask_set_cpu(cpu, self.as_raw()) };
     }
=20
     /// Clears CPU in the cpumask.
@@ -126,43 +60,74 @@ pub fn set(&mut self, cpu: u32) {
     pub fn clear(&mut self, cpu: i32) {
         // SAFETY: `ptr` is guaranteed to be valid for the lifetime of `se=
lf`. And it is safe to
         // call `cpumask_clear_cpu()` for any CPU.
-        unsafe { bindings::cpumask_clear_cpu(cpu, self.ptr) };
+        unsafe { bindings::cpumask_clear_cpu(cpu, self.as_raw()) };
     }
=20
     /// Sets all CPUs in the cpumask.
     pub fn set_all(&mut self) {
         // SAFETY: `ptr` is guaranteed to be valid for the lifetime of `se=
lf`. And it is safe to
         // call `cpumask_setall()`.
-        unsafe { bindings::cpumask_setall(self.ptr) };
+        unsafe { bindings::cpumask_setall(self.as_raw()) };
     }
=20
     /// Gets weight of a cpumask.
     pub fn weight(&self) -> u32 {
         // SAFETY: `ptr` is guaranteed to be valid for the lifetime of `se=
lf`. And it is safe to
         // call `cpumask_weight()`.
-        unsafe { bindings::cpumask_weight(self.ptr) }
+        unsafe { bindings::cpumask_weight(self.as_raw()) }
     }
=20
     /// Copies cpumask.
     pub fn copy(&self, dstp: &mut Self) {
         // SAFETY: `ptr` is guaranteed to be valid for the lifetime of `se=
lf`. And it is safe to
         // call `cpumask_copy()`.
-        unsafe { bindings::cpumask_copy(dstp.as_raw(), self.ptr) };
+        unsafe { bindings::cpumask_copy(dstp.as_raw(), self.as_raw()) };
     }
 }
=20
-impl Drop for Cpumask {
-    fn drop(&mut self) {
-        if self.owned {
-            // SAFETY: `ptr` is guaranteed to be valid for the lifetime of=
 `self`. And it is safe
-            // to call `free_cpumask_var()`.
-            unsafe { bindings::free_cpumask_var(self.ptr) }
+/// This corresponds to the C type alias `cpumask_var_t`.
+pub struct CpumaskBox {
+    #[cfg(CONFIG_CPUMASK_OFFSTACK)]
+    ptr: NonNull<Cpumask>,
+    #[cfg(not(CONFIG_CPUMASK_OFFSTACK))]
+    mask: Cpumask,
+}
=20
+impl CpumaskBox {
+    pub fn new(_flags: Flags) -> Result<Self, AllocError> {
+        Ok(Self {
+            #[cfg(CONFIG_CPUMASK_OFFSTACK)]
+            ptr: {
+                let mut ptr: *mut bindings::cpumask =3D ptr::null_mut();
+                unsafe { bindings::zalloc_cpumask_var(&mut ptr, _flags.as_=
raw()) };
+                NonNull::new(ptr.cast()).ok_or(AllocError)?
+            },
             #[cfg(not(CONFIG_CPUMASK_OFFSTACK))]
-            // SAFETY: The pointer was earlier initialized from the result=
 of `KBox::into_raw()`.
-            unsafe {
-                drop(KBox::from_raw(self.ptr))
-            };
-        }
+            mask: unsafe { core::mem::zeroed() },
+        })
+    }
+}
+
+// Make CpumaskBox behave like a pointer to Cpumask.
+impl core::ops::Deref for CpumaskBox {
+    type Target =3D Cpumask;
+
+    #[cfg(CONFIG_CPUMASK_OFFSTACK)]
+    fn deref(&self) -> &Cpumask {
+        unsafe { &*self.ptr.as_ptr() }
+    }
+
+    #[cfg(not(CONFIG_CPUMASK_OFFSTACK))]
+    fn deref(&self) -> &Cpumask {
+        &self.mask
+    }
+}
+
+impl Drop for CpumaskBox {
+    fn drop(&mut self) {
+        #[cfg(CONFIG_CPUMASK_OFFSTACK)]
+        unsafe {
+            bindings::free_cpumask_var(self.as_raw())
+        };
     }
 }

