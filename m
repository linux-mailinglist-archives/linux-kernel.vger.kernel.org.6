Return-Path: <linux-kernel+bounces-568350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E6EA69444
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 17:04:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F25E4276D4
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 16:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A3EB1DE3AE;
	Wed, 19 Mar 2025 16:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GFY3yTYx"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D801DDA2F
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 16:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742400231; cv=none; b=WmNDSklX5I6tINDViwcqvu7NrVbQafdN/SRearugsEoAt4VXqPdlMczpwkHrhivmCP7CPkV++Z6l/FeUBZ6OpfXIujDTLsSghqQF6b7ZEsLQ7PwTNErnRSkMTt/gThM7U4t/Ht5d3rdRzuYgozcfIZy3FrcdmFz1RnXR0jR7tjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742400231; c=relaxed/simple;
	bh=eAi0lc8RcPRGMdrSrhO/TZUzEY1q+zLsi62jnNknOiU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jLWf7WdQUbe066z0pfixZfMePKdnO5BaXboGWhms7XRSQONQWHpSALafq9Fwz7LKRvclIlk4WmUg87yuJydKDGYnqID33jFu8sw5rNIs+cGx+wkcsZIjCc2+4ANrEU0zylPEJSCkot1HUifnZT2+MdAMww/DaDjomPQX07rIzDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GFY3yTYx; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-43cf172ffe1so39647755e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 09:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742400228; x=1743005028; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BHxsFj/uocig97RZFz1WpNfGjTCy5/hwtb9C6pS20Pk=;
        b=GFY3yTYxG1CDXy9mhfkAOOs2y0PK8PCrwLfasazkKNGn2JKUCBN6nJRYmnX4J8WuoL
         daln/6RvLG1gM2aYI9d5fQnwXeQHiQUHuS/8wa/InfIDD5AnySpID24T8kqthsxg1AM9
         mNR0rWu35ndQBoBvkiVM6s+EOoOM+MNoQvJXMJEcNbwp39MRSj+MbgGLJOYng7MZabIz
         EidUJ8fvxhj67UGR4NWPqiiNOGAfpmuGGapR2+ltkPMcp5xoH+yURXF+6cKX2kAyQSBq
         gUBb/9G3OywYavBHzqiK8v4eENeRSqCoT98cKRvtg9PQr3z0sTIh1fHywfvhsJJDYHuO
         0BZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742400228; x=1743005028;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BHxsFj/uocig97RZFz1WpNfGjTCy5/hwtb9C6pS20Pk=;
        b=Oei2CRwqx2nZaOgLlU4khTn2g9cLvmiSCoxZjCUdGLXOwCpd/toa88VEpqFH2UcRow
         PwH15zIsVpXXEBob4+RzYUf/EYuTSfIx3oF0HXI4Qro+lX5d2k8T5umEC1y7a6eJI02O
         elY7e6UE5p1IfJ8HqTOSpJT45w5Y0E1vc2N036xbAWLm48GAchw0EQBKOkr3LErkvdGt
         33lT7gnKHu/igC4GGUywRadbuAad7Fyuonb46KoWC2AClE5lhNX9NrVlLyfgUf5jFeQw
         vcbOFVO1jLfhSkb35a+uyYflgrvxtTqYgDvQE5OUVaLq3nreLFTScKPG007e0kHTLv5O
         wcQA==
X-Forwarded-Encrypted: i=1; AJvYcCXrtrYh8ZPMn8S9gHABrEq0IEXKMsQ7TIwvxPF/QY1bC75HsIZvN5D1yCtAzVkKSx/HVsqDj9yPlIwDUQM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyblgmTwUnNYTrAsUcL8UyDa7bJnAU2l5T1liKZ0voFtlGd2gOS
	8Cxz0YXeRLfD5vWaqmhJtTvUBQ+mC1uFtXG4XR1Bexmc9v5kn7xdHQXuVzG2e0JIDv6MsN68x2/
	MdfoU5C0cresgBQ==
X-Google-Smtp-Source: AGHT+IEcBACVEs0HkFKRvQ8yJq+2Qu4+aoc9KdGNlHFNUdOFNeiJIeo3uHAMSxwxLbIWwWTWs7Voz7ZMWvAQw/8=
X-Received: from wmoo18.prod.google.com ([2002:a05:600d:112:b0:43d:1d5:26e6])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1e07:b0:43d:b85:1831 with SMTP id 5b1f17b1804b1-43d436c7be6mr33893625e9.0.1742400227880;
 Wed, 19 Mar 2025 09:03:47 -0700 (PDT)
Date: Wed, 19 Mar 2025 16:03:45 +0000
In-Reply-To: <Z9rVMJMlx4klpt4h@thinkpad>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250318164221.1533590-1-bqe@google.com> <20250318175322.1627073-2-bqe@google.com>
 <Z9nUzjinU_mozCXC@thinkpad> <Z9qe_cLk4FDg_fAE@google.com> <Z9rVMJMlx4klpt4h@thinkpad>
Message-ID: <Z9rq4aqY3PR8XzEN@google.com>
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

On Wed, Mar 19, 2025 at 10:31:12AM -0400, Yury Norov wrote:
> On Wed, Mar 19, 2025 at 10:39:57AM +0000, Alice Ryhl wrote:
> > On Tue, Mar 18, 2025 at 04:17:18PM -0400, Yury Norov wrote:
> > > On Tue, Mar 18, 2025 at 05:51:53PM +0000, Burak Emir wrote:
> 
> [...]
> 
> > > Are those 'drop' and 'new' something like a special rust words? If not -
> > > can you use alloc and free wording? Would be nice to have rust part
> > > looking similar to C. Nobody wants to keep two sets of names in mind.
> > 
> > Rewording `new` to `alloc` seems reasonable.
> > 
> > As for "drop", that word is special. It's the destructor that is called
> > automatically when the bitmap goes out of scope - you can't call it
> > directly. It must be called "drop".
> 
> OK, then drop and new.
> 
> > > > +        if let Ok(nbits_u32) = u32::try_from(nbits) {
> > > > +            // SAFETY: `nbits == 0` is permitted and `nbits <= u32::MAX`.
> > > > +            let ptr = unsafe { bindings::bitmap_zalloc(nbits_u32, flags.as_raw()) };
> > > > +            // Zero-size allocation is ok and yields a dangling pointer.
> > > 
> > > Maybe it's OK, but I'm not aware of any a correct algorithm that needs
> > > 0-sized bitmaps. I already asked for it on previous iteration, right?
> > > So unless you can show me such an example and explain what for you need
> > > 0-sized bitmaps, please drop this wording.
> > 
> > Thinking about it, I actually think there is a good reason to support
> > zero-sized bitmaps for the Binder use-case. Right now, we always
> > allocate at least one long worth of bits even if they're all 0. But we
> > can improve the memory usage of this code by not allocating any memory
> > for the bitmap until the first time we use it.
> > 
> > The reason that dbitmap.h doesn't do this is historical. Originally, the
> > bitmap started out having BIT(0) set to 1, so we needed an allocation to
> > hold that from the very beginning. But that was changed in commit
> > 11512c197d38 ("binder: fix descriptor lookup for context manager"), so
> > the bitmap now starts out empty.
> 
> Empty bitmap is not a 0-length bitmap, right?
> 
> If it was me inventing dynamic bitmaps, and if I was concerned about
> usability and performance, I would think carefully what exactly the
> request for 0-bits Bitmap object means.
> 
> I would probably consider it as a caller error, which makes total
> sense.
> 
> Or I would consider it as a special hint, like 'give me something to
> begin with'.
> 
> If I decided to go with the 2nd option, I'd probably avoid memory
> allocation at all, and re-use the pointer as the bitmap of the length
> BITS_PER_LONG. That would save _a lot_ on useless small kmalloc()
> calls.

Okay that's clever. We would probably avoid the need for allocations in
the vast vast majority of cases with that approach.

> The whole business of dynamic arrays is about potentially infinite
> number of elements. User of your array doesn't even care about the
> exact length, because it may get changed anytime, right?
> 
> In that case, the comment would sound like:
> 
>   // Zero-size Bitmap request yields a bitmap of an arbitrary
>   // non-zero length.
> 
> [...]
>  
> > The clippy linter emits a warning if you have a `len` method but don't
> > have an `is_empty` method, since Rust containers usually have both.
> > 
> > https://rust-lang.github.io/rust-clippy/master/index.html#len_without_is_empty
> > 
> > But the confusion with "no set bits" seems like a good reason to silence
> > that warning for bitmap.
>  
> So the comment at your link says:
> 
>  It is good custom to have both methods, because for some data structures,
>  asking about the length will be a costly operation, whereas .is_empty()
>  can usually answer in constant time.
> 
> In this case both len() and is_empty() are O(1), but the last one
> is totally misleading.
> 
> You guys would better teach your linter to understand when the len()
> is cheap, so is_empty() is useless.

Heh, I'm not sure I agree with the lint's explanation. But all stdlib
Rust data structures have both `len` and `is_empty` even if computing
the length is O(1). In my eyes, it's just a convention, similar to
calling the constructor "new".

> > > > +    /// Sets bit with index `index`.
> > > > +    ///
> > > > +    /// # Panics
> > > > +    ///
> > > > +    /// Panics if `index` is greater than or equal to `self.nbits`.
> > > > +    #[inline]
> > > > +    pub fn set_bit(&mut self, index: usize) {
> > > 
> > > set_bit() is an atomic name, but you wire it to a non-atomic operation.
> > > This is a mess.
> > 
> > Hmm. I do generally agree that we should try to match C names, but I'm
> > unsure about this particular case due to the underscores.
> > 
> > This method takes "&mut self" rather than "&self", which means that the
> > caller must have exclusive access to the bitmap to call this method.
> > Attempting to call it when the bitmap is shared will result in a
> > compilation failure, so it is impossible to call the non-atomic method
> > in cases where you must use the atomic version.
> 
> Does mutual access implies memory barriers? Your code doesn't add
> them. Is rust compiler so smart to realize that you need it?
> 
> I mean the following scenario:
> 
> CPU1                            CPU2
> a.set_bit(1)
>                                 a.test_bit(1) -> 0
> cache_flush()
>                                 a.test_bit(1) -> 1
> 
> If the above is impossible, then yes, your set_bit is atomic.

Yes, if a method is "&mut self" then this case is impossible.

Basically, the way it works is that the only APIs that hand out `&mut`
references to a value must somehow enforce that the access is exclusive.
How it enforces that is up to the API.

So for example, if you have a local variable that you know is not
shared, you can just obtain a `&mut` reference to it. No barriers needed
since it's a local variable that is not shared.

On the other hand, if you have a variable protected by a spinlock, then
the spinlock API will only hand out `&mut` references when the spinlock
is locked. And the borrow-checker enforces that the `&mut` can't be used
after you unlock it again. In this case, the spin_lock / spin_unlock
calls are sufficient barriers to use __set_bit.

And so on for each synchronization method.

Point is, any time you have a `&mut` reference to a value, you know that
it's exclusive, because whichever API created that reference has some
mechanism to ensure that.

> > We could call this method __set_bit, but using underscore prefixes for
> > methods is very very rare in Rust code because prefixing a name with an
> > underscore usually means "do not emit warnings if this thing is unused".
> > For example, when locking a mutex, you might write this:
> > 
> > {
> >     let _lock = my_mutex.lock();
> >     // do stuff ...
> > 
> >     // _lock goes out of scope here, unlocking the mutex
> > }
> > 
> > Here, if you called the variable "lock" you would get an unused variable
> > warning, but prefixing the variable name with an underscore silences
> > that warning.
> 
> But underscored method is not a local underscored variable. It doesn't
> have scope.

If a method isn't public, then Rust will perform a similar check to the
entire compilation unit and emit a warning if it's unused. The
underscore silences that.

Though as Miguel points out, this particular method is public, so the
check is not performed - there might be callers in other compilation
units that this rustc invocation doesn't know about.

> > We can still call the method __set_bit if you think that is best, but
> 
> No I don't. Nobody likes underscored notation for non-atomic bit ops,
> but it's a historical thing.
> 
> > because underscore prefixes usually mean something different in Rust, I
> > wonder if we should use slightly different names in Rust. Thoughts?
> 
> This is a new project, and you may decide to change notation. Just
> please be very specific about it.
> 
> So I'd suggest the following:
> 
> 1. Mirror C interface: __set_bit() and set_bit()
> 2. set_bit_nonatomic() and set_bit()
> 3. set_bit() and set_bit_atomic()
> 
> The last one looks the best to me, except that it just the opposite
> to what people got used to in Linux. If you go with #3, please add
> both atomic and non-atomic set_bit()s in the same patch, together with
> a bunch of comments, so people will be aware.

Solution #3 sounds good to me.

Alice

