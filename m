Return-Path: <linux-kernel+bounces-567738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDA75A689D2
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 11:40:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71B693AD4F3
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 10:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A0722505B2;
	Wed, 19 Mar 2025 10:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZoqnsAVj"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C142116E7
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 10:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742380803; cv=none; b=DsgvCkyr+B+1rLnq6CcJMGvX7GN24pAeA+9E/haoOAWSQp2gc8O8pppyjgFDsO6KuLmA643PvH/wEEwHglEe3lFWua0fP8kTN2APjs1Y3CMTKeQwTok1fsZ+oBYUA9HVW97p8RPg/kA3KHWDoYdmYLdx9SInCmZJv4j2Q0sBPPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742380803; c=relaxed/simple;
	bh=sLhVQhbgn79U8mmF2D4vdkD1GXwHduCWKO570OR9BqM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oXuucV/vdHg9tNJM81MKOglu/5gvpH2g2a+kRw5VQDyX7kHtgfNWdJWXPooqkWOkNmQaafy9n6TGSsx8ScJX8SQ9NQ1LD7EvBVUCKY+Q72dgDXE+omeTXvyQkC5ndAFdHz2ChPcbAtCyATv3AENSFFmEAw0SOi3lQ2bYT94+jz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZoqnsAVj; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-43ce245c5acso49709705e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 03:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742380799; x=1742985599; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rojAKw/tnImVC9Pde18VuvEwazqLDHb4JLkVJFWOqVE=;
        b=ZoqnsAVj1cPFoFrGYf75uS4/Ega5cxNGhM77eWpiPAvuCGJhkrOkfX6BJJ8++0J4Y4
         LUWrMSsWjuIq1wHe9PQsTyah+hpAL5FAo6BnWiibSxQL+/E6X4fIjVL38XHPHozYdtbg
         rhgNndvd/F+54PlO60eRftrXOfYiNeMTLNzJABGARqX7g6wiX+gy9FHiltrcH+ZSrH/g
         FS+DtAAGXtBPq6NKzUSdy2gooDccBpEDhwby5zoPXNxg0idpDxI7WyTfLuga9u0boZUx
         zyiGBsvYAaagrDEqzQcUW4cL9n5vDDJ1+fVYaAZMaEe7QDoeP5dftWM5P8UXA3k0OlwU
         Nsbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742380799; x=1742985599;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rojAKw/tnImVC9Pde18VuvEwazqLDHb4JLkVJFWOqVE=;
        b=WnLwgQ3exJLup+jVqniz38O6hgKOyW21UN7Q32LCshgGd8HD2CMfl0HeKdbazA/r8d
         QC7pYOxdpgDUp6WmnYTEdVS8lL9pVeRM7E78y8Tliegp/UgKoLDevl8lM7VTpnZ61prq
         mUcZzgJQ0XKVBRwiau7zYkdeP9YwTZWmzcskeN7TuzYEFUAe0r4U96Q0QipzWZ1z+G5b
         VAInL1cBxyI5lOIE99hacnU+ZPAuXCogB0EZb9GtS3gGLnHDByHPvgImk3ZGEbcL/oLP
         uBPXfw2SyjBh9ASOpZpEut5Pk5t4UHHXlc6U9u9Z5d90iW7/K4wjBsj3mmq4ctBHH8ZM
         oumw==
X-Forwarded-Encrypted: i=1; AJvYcCVaZ0Ljlw7Efaic7QY8EXJAM1HQSKp9Gdu6NSrmjlhdpXPCBABdmff2/spXjAkbS4lyJ6smzb7H/AOZnrw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1kmmMNG0XsY5elrW8aoUk4mXmNa/bnP+UsA2Q8RSsw9uI9T7n
	Wgh5v7WmSAlXXAdx9m/hqhof8BIgJ421IXeNNtlmK4YY3PXyrcctz8luLYbUaWPkfybCEWEHzrd
	VTxiyywve6ZZMmA==
X-Google-Smtp-Source: AGHT+IFffhXTgiR9p64jmJFDAizP0FvsxVONYx+9Xgwt4qfCWTB99Eu+0JiLGYm/G13z2ENHDCCi/BJggSnHpKI=
X-Received: from wrbfa7.prod.google.com ([2002:a05:6000:2587:b0:391:4866:c54c])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a5d:588a:0:b0:390:ee01:68fa with SMTP id ffacd0b85a97d-399739d54d7mr1793750f8f.24.1742380799287;
 Wed, 19 Mar 2025 03:39:59 -0700 (PDT)
Date: Wed, 19 Mar 2025 10:39:57 +0000
In-Reply-To: <Z9nUzjinU_mozCXC@thinkpad>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250318164221.1533590-1-bqe@google.com> <20250318175322.1627073-2-bqe@google.com>
 <Z9nUzjinU_mozCXC@thinkpad>
Message-ID: <Z9qe_cLk4FDg_fAE@google.com>
Subject: Re: [PATCH v4 2/3] Adds Rust Bitmap API.
From: Alice Ryhl <aliceryhl@google.com>
To: Yury Norov <yury.norov@gmail.com>
Cc: Burak Emir <bqe@google.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, Bjorn Roy Baron <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Tue, Mar 18, 2025 at 04:17:18PM -0400, Yury Norov wrote:
> On Tue, Mar 18, 2025 at 05:51:53PM +0000, Burak Emir wrote:
> > Provides an abstraction for C bitmap API and bitops operations.
> > This includes enough functionality to reimplementing a Binder
> > data structure (drivers/android/dbitmap.h). More methods can be
> > added later. We offer a safe API through bounds checks which
> > panic if violated.
> > 
> > We use the `usize` type for sizes and indices into the bitmap,
> > because Rust generally always uses that type for indices and lengths
> > and it will be more convenient if the API accepts that type. This means
> > that we need to perform some casts to/from u32 and usize, since the C
> > headers use unsigned int instead of size_t/unsigned long for these
> > numbers in some places.
> > 
> > Suggested-by: Alice Ryhl <aliceryhl@google.com>
> > Signed-off-by: Burak Emir <bqe@google.com>
> > ---
> >  MAINTAINERS           |   2 +
> >  rust/kernel/bitmap.rs | 234 ++++++++++++++++++++++++++++++++++++++++++
> >  rust/kernel/lib.rs    |   1 +
> >  3 files changed, 237 insertions(+)
> >  create mode 100644 rust/kernel/bitmap.rs
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 50f44d7e5c6e..b3bbce9274f0 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -4036,9 +4036,11 @@ F:	rust/helpers/bitmap.c
> >  F:	rust/helpers/cpumask.c
> >  
> >  BITMAP API [RUST]
> > +M:	Alice Ryhl <aliceryhl@google.com> (bitmap)
> >  M:	Viresh Kumar <viresh.kumar@linaro.org> (cpumask)
> >  R:	Yury Norov <yury.norov@gmail.com>
> >  S:	Maintained
> > +F:	rust/kernel/bitmap.rs
> >  F:	rust/kernel/cpumask.rs
> 
> If you guys are not ready to maintain this as a whole, please split
> the record. scripts/get_maintainers doesn't honor this specifications,
> and you will anyways receive all the bitmaps traffic.
> 
> I checked the existing records:
> 
>   $ grep ^M: MAINTAINERS | grep \(
>   M:	Ji-Ze Hong (Peter Hong) <peter_hong@fintek.com.tw>
>   M:	Boqun Feng <boqun.feng@gmail.com> (LOCKDEP & RUST)
>   M:	"Richard Russon (FlatCap)" <ldm@flatcap.org>
>   M:	Matthew Wilcox (Oracle) <willy@infradead.org>
>   M:	Frederic Weisbecker <frederic@kernel.org> (kernel/rcu/tree_nocb.h)
>   M:	Neeraj Upadhyay <neeraj.upadhyay@kernel.org> (kernel/rcu/tasks.h)
>   M:	Juri Lelli <juri.lelli@redhat.com> (SCHED_DEADLINE)
>   M:	Vincent Guittot <vincent.guittot@linaro.org> (SCHED_NORMAL)
> 
> As you see, it's not a common practice - only scheduler and RCU people
> do that. And I don't find this practice healthy.

Sounds reasonable enough.

> >  BITOPS API
> > diff --git a/rust/kernel/bitmap.rs b/rust/kernel/bitmap.rs
> > new file mode 100644
> > index 000000000000..e8117e0dbe05
> > --- /dev/null
> > +++ b/rust/kernel/bitmap.rs
> > @@ -0,0 +1,234 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +// Copyright (C) 2025 Google LLC.
> > +
> > +//! Rust API for bitmap.
> > +//!
> > +//! C headers: [`include/linux/bitmap.h`](srctree/include/linux/bitmap.h).
> > +
> > +use crate::alloc::{AllocError, Flags};
> > +use crate::bindings;
> > +use core::ptr::NonNull;
> > +
> > +/// Represents a bitmap.
> > +///
> > +/// Wraps underlying C bitmap API.
> > +///
> > +/// # Examples
> > +///
> > +/// Basic usage
> > +/// ```
> > +/// use kernel::alloc::flags::GFP_KERNEL;
> > +/// use kernel::bitmap::Bitmap;
> > +///
> > +/// let mut b = Bitmap::new(16, GFP_KERNEL)?;
> > +/// assert_eq!(16, b.len());
> > +/// for i in 0..16 {
> > +///   if i % 4 == 0 {
> > +///     b.set_bit(i);
> > +///   }
> > +/// }
> > +/// assert_eq!(Some(1), b.find_next_zero_bit(0));
> > +/// assert_eq!(Some(5), b.find_next_zero_bit(5));
> > +/// assert_eq!(Some(12), b.find_last_bit());
> > +/// # Ok::<(), Error>(())
> > +/// ```
> > +///
> > +/// # Invariants
> > +///
> > +/// `ptr` is obtained from a successful call to `bitmap_zalloc` and
> > +/// holds the address of an initialized array of `unsigned long`
> > +/// that is large enough to hold `nbits` bits.
> > +/// `nbits` is `<= u32::MAX` and never changes.
> > +pub struct Bitmap {
> > +    /// Pointer to an array of `unsigned long`.
> > +    ptr: NonNull<usize>,
> > +    /// How many bits this bitmap stores. Must be `<= u32::MAX`.
> 
> Must be <= i32:MAX - I already told that. For 'how many bits' we have a
> special word: length.

Sorry I think we forgot to fix this to be i32.

> > +    nbits: usize,
> > +}
> > +
> > +impl Drop for Bitmap {
> > +    fn drop(&mut self) {
> > +        // SAFETY: `self.ptr` was returned by the C `bitmap_zalloc`.
> > +        //
> > +        // INVARIANT: there is no other use of the `self.ptr` after this
> > +        // call and the value is being dropped so the broken invariant is
> > +        // not observable on function exit.
> > +        unsafe { bindings::bitmap_free(self.as_mut_ptr()) };
> > +    }
> > +}
> > +
> > +impl Bitmap {
> > +    /// Constructs a new [`Bitmap`].
> > +    ///
> > +    /// Fails with [`AllocError`] when the [`Bitmap`] could not be
> > +    /// allocated. This includes the case when `nbits` is greater
> > +    /// than `u32::MAX`.
> > +    #[inline]
> > +    pub fn new(nbits: usize, flags: Flags) -> Result<Self, AllocError> {
> 
> Are those 'drop' and 'new' something like a special rust words? If not -
> can you use alloc and free wording? Would be nice to have rust part
> looking similar to C. Nobody wants to keep two sets of names in mind.

Rewording `new` to `alloc` seems reasonable.

As for "drop", that word is special. It's the destructor that is called
automatically when the bitmap goes out of scope - you can't call it
directly. It must be called "drop".

> > +        if let Ok(nbits_u32) = u32::try_from(nbits) {
> > +            // SAFETY: `nbits == 0` is permitted and `nbits <= u32::MAX`.
> > +            let ptr = unsafe { bindings::bitmap_zalloc(nbits_u32, flags.as_raw()) };
> > +            // Zero-size allocation is ok and yields a dangling pointer.
> 
> Maybe it's OK, but I'm not aware of any a correct algorithm that needs
> 0-sized bitmaps. I already asked for it on previous iteration, right?
> So unless you can show me such an example and explain what for you need
> 0-sized bitmaps, please drop this wording.

Thinking about it, I actually think there is a good reason to support
zero-sized bitmaps for the Binder use-case. Right now, we always
allocate at least one long worth of bits even if they're all 0. But we
can improve the memory usage of this code by not allocating any memory
for the bitmap until the first time we use it.

The reason that dbitmap.h doesn't do this is historical. Originally, the
bitmap started out having BIT(0) set to 1, so we needed an allocation to
hold that from the very beginning. But that was changed in commit
11512c197d38 ("binder: fix descriptor lookup for context manager"), so
the bitmap now starts out empty.

> > +            let ptr = NonNull::new(ptr).ok_or(AllocError)?;
> > +            // INVARIANT: ptr returned by C `bitmap_zalloc` and nbits checked.
> > +            Ok(Bitmap { ptr, nbits })
> > +        } else {
> > +            Err(AllocError)
> > +        }
> > +    }
> > +
> > +    /// Returns how many bits this [`Bitmap`] holds.
> 
> This 'how many bits' may read wrong like 'how many set bits'. Refer
> find_first_bit() for example. Please use the word 'length'.

Reasonable, we will reword to use "length".

> > +    #[inline]
> > +    pub fn len(&self) -> usize {
> > +        self.nbits
> > +    }
> > +
> > +    /// Returns true if this [`Bitmap`] has length `0`.
> > +    #[inline]
> > +    pub fn is_empty(&self) -> bool {
> > +        self.nbits == 0
> > +    }
> 
> Please no. We already have bitmap_empty() with the meaning: no set bits.
> I really don't understand why are you guys so worrying about this very
> specific and most likely erroneous case...
> 
> This function is not even used in the following patch. Really don't
> need it.

The clippy linter emits a warning if you have a `len` method but don't
have an `is_empty` method, since Rust containers usually have both.

https://rust-lang.github.io/rust-clippy/master/index.html#len_without_is_empty

But the confusion with "no set bits" seems like a good reason to silence
that warning for bitmap.

> > +    /// Sets bit with index `index`.
> > +    ///
> > +    /// # Panics
> > +    ///
> > +    /// Panics if `index` is greater than or equal to `self.nbits`.
> > +    #[inline]
> > +    pub fn set_bit(&mut self, index: usize) {
> 
> set_bit() is an atomic name, but you wire it to a non-atomic operation.
> This is a mess.

Hmm. I do generally agree that we should try to match C names, but I'm
unsure about this particular case due to the underscores.

This method takes "&mut self" rather than "&self", which means that the
caller must have exclusive access to the bitmap to call this method.
Attempting to call it when the bitmap is shared will result in a
compilation failure, so it is impossible to call the non-atomic method
in cases where you must use the atomic version.

We could call this method __set_bit, but using underscore prefixes for
methods is very very rare in Rust code because prefixing a name with an
underscore usually means "do not emit warnings if this thing is unused".
For example, when locking a mutex, you might write this:

{
    let _lock = my_mutex.lock();
    // do stuff ...

    // _lock goes out of scope here, unlocking the mutex
}

Here, if you called the variable "lock" you would get an unused variable
warning, but prefixing the variable name with an underscore silences
that warning.

We can still call the method __set_bit if you think that is best, but
because underscore prefixes usually mean something different in Rust, I
wonder if we should use slightly different names in Rust. Thoughts?

> > +        assert!(
> > +            index < self.nbits,
> > +            "Bit `index` must be < {}, was {}",
> > +            self.nbits,
> > +            index
> > +        );
> > +        // SAFETY: Bit `index` is within bounds.
> > +        unsafe { bindings::__set_bit(index as u32, self.as_mut_ptr()) };
> > +    }
> > +
> > +    /// Clears bit with index `index`.
> > +    ///
> > +    /// # Panics
> > +    ///
> > +    /// Panics if `index` is greater than or equal to `self.nbits`.
> > +    #[inline]
> > +    pub fn clear_bit(&mut self, index: usize) {
> > +        assert!(
> > +            index < self.nbits,
> > +            "Bit `index` must be < {}, was {}",
> > +            self.nbits,
> > +            index
> > +        );
> > +        // SAFETY: Bit `index` is within bounds.
> > +        unsafe { bindings::__clear_bit(index as u32, self.as_mut_ptr()) };
> > +    }
> > +
> > +    /// Replaces this [`Bitmap`] with `src` and sets any remaining bits to zero.
> 
> Please: replace and set, not replaces and sets.
> 
> > +    ///
> > +    /// # Panics
> > +    ///
> > +    /// Panics if `src` is longer than this [`Bitmap`].
> > +    ///
> > +    /// # Examples
> > +    ///
> > +    /// ```
> > +    /// use kernel::alloc::{AllocError, flags::GFP_KERNEL};
> > +    /// use kernel::bitmap::Bitmap;
> > +    ///
> > +    /// let mut long_bitmap = Bitmap::new(256, GFP_KERNEL)?;
> > +    /// let short_bitmap = Bitmap::new(16, GFP_KERNEL)?;
> > +    /// long_bitmap.copy_from_bitmap_and_extend(&short_bitmap);
> > +    /// # Ok::<(), AllocError>(())
> > +    /// ```
> > +    #[inline]
> > +    pub fn copy_from_bitmap_and_extend(&mut self, src: &Bitmap) {
> 
> Let's make it a rule: if you pick a function from C code as-is, you
> pick the name as-is, too. I'm OK if you will want to drop the 'bitmap'
> prefix, because it's a method. But I want to be able to just grep the
> name and find its roots in C.
> 
> > +        assert!(
> > +            src.nbits <= self.nbits,
> > +            "Length of `src` must be <= {}, was {}",
> > +            self.nbits,
> > +            src.nbits
> > +        );
> > +        // SAFETY: `nbits == 0` is supported and access to `self` and `src` is within bounds.
> 
> I don't understand this. If nbits == 0, there's nothing to access. Can
> you instead say "handled properly by the C function", or something?
> 
> > +        unsafe {
> > +            bindings::bitmap_copy_and_extend(
> > +                self.as_mut_ptr(),
> > +                src.as_ptr(),
> > +                src.nbits as u32,
> > +                self.nbits as u32,
> > +            )
> > +        };
> > +    }
> > +
> > +    /// Replaces this bitmap with a prefix of `src` that fits into this [`Bitmap`].
> > +    ///
> > +    /// # Panics
> > +    ///
> > +    /// Panics if `src` is shorter than this [`Bitmap`].
> > +    ///
> > +    /// # Examples
> > +    ///
> > +    /// ```
> > +    /// use kernel::alloc::{AllocError, flags::GFP_KERNEL};
> > +    /// use kernel::bitmap::Bitmap;
> > +    ///
> > +    /// let mut short_bitmap = Bitmap::new(16, GFP_KERNEL)?;
> > +    /// let long_bitmap = Bitmap::new(256, GFP_KERNEL)?;
> > +    /// short_bitmap.copy_prefix_from_bitmap(&long_bitmap);
> > +    /// # Ok::<(), AllocError>(())
> 
> Why don't you make it a real test? I asked for tests on previous
> round, but I didn't think that you will make me to construct the
> test myself from scattered pieces of commented code in a foreign
> language.

Documentation examples are real kunit tests. If you run the kunit tests,
this code will run, and the kunit test will fail if the assertion inside
this method is triggered.

> > +    /// ```
> > +    #[inline]
> > +    pub fn copy_prefix_from_bitmap(&mut self, src: &Bitmap) {
> 
> Are you sure you need this 2nd function? It's almost the same as the
> previous one. If the first one works like a.copy_and_extend(b), then
> this one is simply b.copy_and_extend(a). Or I misunderstand this?
> 
> And anyways, this 'copy_prefix_from' thing is confusing and
> misleading. There are no prefixes in bitmaps.

Hmm, maybe we don't need both. We could use min(self.nbits, src.nbits)
as the third argument. Or we could take it as an argument and assert
that it's in bounds for both lengths.

> > +        assert!(
> > +            self.nbits <= src.nbits,
> > +            "Length of `src` must be >= {}, was {}",
> > +            self.nbits,
> > +            src.nbits
> > +        );
> > +        // SAFETY: `nbits == 0` is supported and access to `self` and `src` is within bounds.
> > +        unsafe {
> > +            bindings::bitmap_copy_and_extend(
> > +                self.as_mut_ptr(),
> > +                src.as_ptr(),
> > +                self.nbits as u32,
> > +                self.nbits as u32,
> > +            )
> > +        };
> > +    }
> > +
> > +    /// Finds the last bit that is set.
> > +    #[inline]
> > +    pub fn find_last_bit(&self) -> Option<usize> {
> 
> You may drop the 'find' prefix because it's a method.
> 
> > +        // SAFETY: `nbits == 0` is supported and access is within bounds.
> 
> No panics anymore? I recall Alice said you need them for hardening...

For the specific case of finding the last bit, no panics is correct.
This method returns the index of the last bit if there is a last bit.
Otherwise, if all bits are 0, it returns None. This lets the caller
handle both cases.

Burak, let's add this example:

match bitmap.last_bit() {
    Some(idx) => {
        pr_info!("The last bit has index {idx}.\n");
    }
    None => {
        pr_info!("All bits in this bitmap are 0.\n");
    }
}

> > +        let index = unsafe { bindings::_find_last_bit(self.as_ptr(), self.nbits) };
> > +        if index == self.nbits {
> > +            None
> > +        } else {
> > +            Some(index)
> > +        }
> > +    }
> > +
> > +    /// Finds the next zero bit, starting from `offset`.
> > +    #[inline]
> > +    pub fn find_next_zero_bit(&self, offset: usize) -> Option<usize> {
> > +        // SAFETY: `nbits == 0` and out-of-bounds offset is supported.
> 
> It's not supported. The request with such parameters is ignored,
> and >= nbits is returned.
> 
> > +        let index = unsafe { bindings::_find_next_zero_bit(self.as_ptr(), self.nbits, offset) };
> > +        if index == self.nbits {
> > +            None
> > +        } else {
> > +            Some(index)
> > +        }
> > +    }
> > +}
> > diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> > index efbd7be98dab..be06ffc47473 100644
> > --- a/rust/kernel/lib.rs
> > +++ b/rust/kernel/lib.rs
> > @@ -36,6 +36,7 @@
> >  pub use ffi;
> >  
> >  pub mod alloc;
> > +pub mod bitmap;
> >  #[cfg(CONFIG_BLOCK)]
> >  pub mod block;
> >  #[doc(hidden)]
> > -- 
> > 2.49.0.rc1.451.g8f38331e32-goog

