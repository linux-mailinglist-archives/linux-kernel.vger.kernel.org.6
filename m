Return-Path: <linux-kernel+bounces-330488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14925979F30
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 12:23:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0E4028246D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 10:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4B58149C4D;
	Mon, 16 Sep 2024 10:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2KW4TwoG"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B42A935
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 10:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726482178; cv=none; b=NKFd9eAVayMfC25I+WeNw9HiX+EDLroAzim/4u42s/YWqmmGid0acTeuXLJT+zDbYSWBrz2Y6QGm8bUhIFDt3IVqRr6iL+npHEHoXUpJ42XDP2I0xlJYQFDQlHgj4jp5iB4Fu3hUJkLW6GZk9vTnZ/ed1Z6+C0O99ieVPleAdP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726482178; c=relaxed/simple;
	bh=yo3Pcnvp0KuRsnfJjJxO7iC33RlP7+mllK+Ek6MGVBc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KnSmiZ4nsoOs9azTG6ZqyyK+EpQjwHaVCGspstL3LL2VzR7gOHlANRgFSI520lQ3Sh67DqS4lSoGYGNdY09XGPlzo8z/JQauC2QS2n3WrwXds9Rp3owDee63fZqQd9IvrmXRfdCe7n4l79BquQNOhCSUX+grDCC2N/h7AHLX/mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2KW4TwoG; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42cba8340beso32832785e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 03:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726482175; x=1727086975; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aMbnJdw15F4YGIh0jwgo5boSJ7mMbxGA37N7/Qizef4=;
        b=2KW4TwoG9zlmOkJsvOpMb83fcPiqp43q8KVOISTl8QJQ1LzVAeLsS2RAQakTr+NX62
         8x0dzph/61pLEzvLnQ03OuxMAUDNM1Tuwa85yXbCidQ0IfCaP0g5XdWDxmkKv2WING1M
         xGkmjG3Nf4/ehtyV662rB1uSfOcOpLx7A/2I+R5QBUe1Mr/GKOgVe8uNXXYBMX+kqQ95
         k7Eqfs+TnXnArJJD6hb8xPtYdT0q7F1zfqzwJjWC4wAX25pnDIdCp4JNgvtOaEpSpBoY
         IQAZrbi8tCaOL8VsFyGoyVSv7KTZJIwDIfKKnNlqAsdZ5qnvNacqvq+kVNKXDg8eZ+w3
         sFMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726482175; x=1727086975;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aMbnJdw15F4YGIh0jwgo5boSJ7mMbxGA37N7/Qizef4=;
        b=oNAf2Bp/lqt9irv6w/Pj1RPDz/IBtJvSy0kY1jURtnasgrW0qPGARobptdhQgXAhpV
         KT/Q5G54RVzQ8UY0QS9LWwDyHcNepGjuURwrOrZv602EY4L1ogb0s3MfS+kr/Bbt4iDQ
         jTIG4tVSAac75X5puWDIkuqnjfEg0b73+SfSy/9WwiYTzBSZ3Y9AxSWHc2HPELyzc2wl
         5pDP63ykJyI25/evbwKieoQSpn/z2cxK08wv2hfy/v32ELET3jmEAtylvlvVebEOifN/
         T//09SD/UARa3+UU7JwdkKMT1b7jLNSBYcltOGUt5yp/wFVihI5RFgk0PR+u0QrgTQfZ
         iuJw==
X-Forwarded-Encrypted: i=1; AJvYcCVZpoykEE1jxLXAfdx3bQmRP8WqGL1ovIdt/VvKzZafYaE0m86d7ENPBHmpZXJVtWHd4+DxIAvNwex4EoQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8mWPUOytvGsig+yiBisBxPzOc5s/Hu6eP5Ll2pMMuEYURMqmC
	pX5RWQll4nV4KHhPnRnFvdp8HK9kJYftUYyNkInIuv4HirRcrJ/9c+UwFfPk1e/ivte+9VEjoYM
	cyMSDluTm7As6f8sZmj16icQiEYLF3nLiH70n
X-Google-Smtp-Source: AGHT+IGTeHSGKjxyOIBQqUEzMABc1A7njdZDqYuFGdwfUyBxHw+hpXyfrPpmjqB2EUzeaNg5V4jDjFr9eCBIy/D91g8=
X-Received: by 2002:a5d:46c2:0:b0:371:8685:84c with SMTP id
 ffacd0b85a97d-378c27b0c2dmr8791936f8f.15.1726482174454; Mon, 16 Sep 2024
 03:22:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240912-shrinker-v1-1-18b7f1253553@google.com> <ZuefFhomRvqtFzSn@dread.disaster.area>
In-Reply-To: <ZuefFhomRvqtFzSn@dread.disaster.area>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 16 Sep 2024 12:22:40 +0200
Message-ID: <CAH5fLgjRuGZWMRWTbmS5w+eLG1kPQNo95c6E6db9y8nUt2RH2A@mail.gmail.com>
Subject: Re: [PATCH] rust: shrinker: add shrinker abstraction
To: Dave Chinner <david@fromorbit.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Qi Zheng <zhengqi.arch@bytedance.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 16, 2024 at 4:59=E2=80=AFAM Dave Chinner <david@fromorbit.com> =
wrote:
>
> On Thu, Sep 12, 2024 at 09:54:01AM +0000, Alice Ryhl wrote:
> > Rust Binder holds incoming transactions in a read-only mmap'd region
> > where it manually manages the pages. These pages are only in use until
> > the incoming transaction is consumed by userspace, but the kernel will
> > keep the pages around for future transactions. Rust Binder registers a
> > shrinker with the kernel so that it can give back these pages if the
> > system comes under memory pressure.
> >
> > Separate types are provided for registered and unregistered shrinkers.
> > The unregistered shrinker type can be used to configure the shrinker
> > before registering it. Separating it into two types also enables the
> > user to construct the private data between the calls to `shrinker_alloc=
`
> > and `shrinker_register` and avoid constructing the private data if
> > allocating the shrinker fails.
>
> This seems a bit nasty. It appears to me that the code does an
> unsafe copy of the internal shrinker state between the unregistered
> and registered types. Shrinkers have additional internal state when
> SHRINKER_MEMCG_AWARE and/or SHRINKER_NUMA_AWARE flags are set,
> and this abstraction doesn't seem to handle either those flags or
> the internal state they use at all.

Doing an unsafe copy of the internal shrinker state is certainly not
my intent. The UnregisteredShrinker and RegisteredShrinker types just
wrap a non-null pointer, so the moves inside `register` are not copies
of the whole `struct shrinker` but just copies of a pointer to the
shrinker.

> > +impl UnregisteredShrinker {
> > +    /// Create a new shrinker.
> > +    pub fn alloc(name: &CStr) -> Result<Self, AllocError> {
> > +        // SAFETY: Passing `0` as flags is okay. Using `%s` as the for=
mat string is okay when we
> > +        // pass a nul-terminated string as the string for `%s` to prin=
t.
> > +        let ptr =3D
> > +            unsafe { bindings::shrinker_alloc(0, c_str!("%s").as_char_=
ptr(), name.as_char_ptr()) };
>
> This passes flags as 0, so doesn't support SHRINKER_MEMCG_AWARE or
> SHRINKER_NUMA_AWARE shrinker variants. These flags should be
> passed through here.

I don't have a user for memcg/numa aware shrinkers in Rust, which is
why I did not extend these abstractions to support them. However, if
you would like me to, I'm happy to do so. It is easy to add a flags
argument to this method, but I imagine they also need a few other
additions elsewhere in the API to really be supported?

Now that I think about it, perhaps Binder's shrinker *could* be memcg
aware? It uses the list_lru abstraction, and currently calls
`list_lru_count` in `count_objects`, but maybe we could just use
`list_lru_shrink_count` instead and magically become memcg aware ...?

> > +    /// Set the number of seeks needed to recreate an object.
> > +    pub fn set_seeks(&mut self, seeks: u32) {
> > +        unsafe { (*self.shrinker.as_ptr()).seeks =3D seeks as c_int };
> > +    }
>
> Seems kinda weird to have a separate function for setting seeks,
> when...
>
> > +
> > +    /// Register the shrinker.
> > +    ///
> > +    /// The provided pointer is used as the private data, and the type=
 `T` determines the callbacks
> > +    /// that the shrinker will use.
> > +    pub fn register<T: Shrinker>(self, private_data: T::Ptr) -> Regist=
eredShrinker<T> {
>
> .... all the other data needed to set up a shrinker is provided to
> this function....
>
> > +        let shrinker =3D self.shrinker;
> > +        let ptr =3D shrinker.as_ptr();
> > +
> > +        // The destructor of `self` calls `shrinker_free`, so skip the=
 destructor.
> > +        core::mem::forget(self);
> > +
> > +        let private_data_ptr =3D <T::Ptr as ForeignOwnable>::into_fore=
ign(private_data);
> > +
> > +        // SAFETY: We own the private data, so we can assign to it.
> > +        unsafe { (*ptr).private_data =3D private_data_ptr.cast_mut() }=
;
> > +        // SAFETY: The shrinker is not yet registered, so we can updat=
e this field.
> > +        unsafe { (*ptr).count_objects =3D Some(rust_count_objects::<T>=
) };
> > +        // SAFETY: The shrinker is not yet registered, so we can updat=
e this field.
> > +        unsafe { (*ptr).scan_objects =3D Some(rust_scan_objects::<T>) =
};
>
> .... and implemented exactly the same way.

Well .. this design makes setting `seeks` optional, but `private_data`
mandatory. We *have* to set the two function pointers, but you don't
have to set `seeks` explicitly.

It's not obvious, so it's probably worth mentioning that this design
doesn't actually require you to make an allocation and store a real
pointer in the private data. When implementing the Shrinker trait for
your custom shrinker, you have to choose which pointer type to use. If
you choose the unit type `()` as the pointer type, then no real
pointer is actually stored.

> > +/// How many objects are there in the cache?
> > +///
> > +/// This is used as the return value of [`Shrinker::count_objects`].
> > +pub struct CountObjects {
> > +    inner: c_ulong,
> > +}
> > +
> > +impl CountObjects {
> > +    /// Indicates that the number of objects is unknown.
> > +    pub const UNKNOWN: Self =3D Self { inner: 0 };
> > +
> > +    /// Indicates that the number of objects is zero.
> > +    pub const EMPTY: Self =3D Self {
> > +        inner: SHRINK_EMPTY,
> > +    };
> > +
> > +    /// The maximum possible number of freeable objects.
> > +    pub const MAX: Self =3D Self {
> > +        // The shrinker code assumes that it can multiply this value b=
y two without overflow.
> > +        inner: c_ulong::MAX / 2,
> > +    };
> > +
> > +    /// Creates a new `CountObjects` with the given value.
> > +    pub fn from_count(count: usize) -> Self {
> > +        if count =3D=3D 0 {
> > +            return Self::EMPTY;
> > +        }
>
> No. A return count of 0 is not the same as a return value of
> SHRINK_EMPTY.
>
> A return value of 0 means "no reclaim work can be done right now".
>
> This implies that there are objects that can be reclaimed in the near
> future, but right now they are unavailable for reclaim. This can be
> due to a trylock protecting the count operation failing, the all the
> objects in the cache being dirty and needing work to be done before
> they can be reclaimed, etc.
>
> A return value of SHRINK_EMPTY means "there are no reclaimable
> objects at all".
>
> This implies that the cache is empty - it has absolutely nothing in
> it that can be reclaimed either now or in the near future.
>
>
> These two return values are treated very differently by the high
> level code. SHRINK_EMPTY is used by shrink_slab_memcg() to maintain
> a "shrinker needs to run" bit in the memcg shrinker search bitmap.
> The bit is cleared when SHRINK_EMPTY is returned, meaning the
> shrinker will not get called again until a new object is queued
> to it's LRU. This sets the "shrinker needs to run" bit again, and
> so the shrinker will run next time shrink_slab_memcg() is called.
>
> In constrast, a return value of zero (i.e. no work to be done right
> now) does not change the "shrinker needs to run" state bit, and
> hence it will always be called the next time the shrink_slab_memcg()
> is run to try to reclaim objects from that memcg shrinker...

This is a part of the API that I was pretty unsure about, so very
happy to get your input. For both of the shrinkers I am familiar with,
they know the exact count of objects and there's no error case for any
lock. The shrinkers just return the exact count directly from
count_objects, but that seemed incorrect to me, as this means that the
shrinker returns 0 when it really should return SHRINK_EMPTY. That's
why I implemented `from_count` this way - the intent is that you use
`CountObjects::from_count` when you know the exact count, so if you
pass 0 to that method, then that means the shrinker really is empty.
If you don't know what the count is, then you return
`CountObjects::UNKNOWN` instead.

That said, I guess there is some reason that the C shrinker API is
designed to use the value 0 for unknown rather than empty, so perhaps
I should not try to do it differently.

> > +impl ScanObjects {
> > +    /// Indicates that the shrinker should stop trying to free objects=
 from this cache due to
> > +    /// potential deadlocks.
> > +    pub const STOP: Self =3D Self { inner: SHRINK_STOP };
> > +
> > +    /// The maximum possible number of freeable objects.
> > +    pub const MAX: Self =3D Self {
> > +        // The shrinker code assumes that it can multiply this value b=
y two without overflow.
> > +        inner: c_ulong::MAX / 2,
>
> No it doesn't. This is purely a count of objects freed by the
> shrinker.

In mm/shrinker.c it multiplies by two here:
total_scan =3D min(total_scan, (2 * freeable));

And I guess there is even a multiplication by four a bit earlier in
the same function if priority is zero.

> > +    /// Determines whether it is safe to recurse into filesystem code.
> > +    pub fn gfp_fs(&self) -> bool {
> > +        // SAFETY: Okay by type invariants.
> > +        let mask =3D unsafe { (*self.ptr.as_ptr()).gfp_mask };
> > +
> > +        (mask & bindings::__GFP_FS) !=3D 0
> > +    }
>
> This needs a check for __GFP_IO as well, as there are block layer
> shrinkers that need to be GFP_NOIO aware...

Would you prefer that I add additional methods, or that I modify this
method to also check __GFP_IO, or that I just expose a way to get the
`gfp_mask` value directly?

> > +    /// Returns the number of objects that `scan_objects` should try t=
o reclaim.
> > +    pub fn nr_to_scan(&self) -> usize {
> > +        // SAFETY: Okay by type invariants.
> > +        unsafe { (*self.ptr.as_ptr()).nr_to_scan as usize }
> > +    }
> > +
> > +    /// The callback should set this value to the number of objects pr=
ocessed.
> > +    pub fn set_nr_scanned(&mut self, val: usize) {
> > +        let mut val =3D val as c_ulong;
> > +        // SAFETY: Okay by type invariants.
> > +        let max =3D unsafe { (*self.ptr.as_ptr()).nr_to_scan };
> > +        if val > max {
> > +            val =3D max;
> > +        }
>
> No. Shrinkers are allowed to scan more objects in a batch than
> the high level code asked them to scan. If they do this, they
> *must* report back the count of all the objects they scanned so the
> batched scan accounting can adjust the remaining amount of work that
> needs to be done appropriately.

Acknowledged.

This is related to another question that I had, actually. Other than
returning SHRINK_STOP, in what situations should `nr_scanned` be
different from the return value of `scan_objects`?

> > +
> > +        // SAFETY: Okay by type invariants.
> > +        unsafe { (*self.ptr.as_ptr()).nr_scanned =3D val };
> > +    }
> > +}
> > +
> > +unsafe extern "C" fn rust_count_objects<T: Shrinker>(
> > +    shrink: *mut bindings::shrinker,
> > +    sc: *mut bindings::shrink_control,
> > +) -> c_ulong {
> > +    // SAFETY: We own the private data, so we can access it.
> > +    let private =3D unsafe { (*shrink).private_data };
> > +    // SAFETY: This function is only used with shrinkers where `T` is =
the type of the private data.
> > +    let private =3D unsafe { <T::Ptr as ForeignOwnable>::borrow(privat=
e) };
> > +    // SAFETY: The caller passes a valid `sc` pointer.
> > +    let sc =3D unsafe { ShrinkControl::from_raw(sc) };
> > +
> > +    let ret =3D T::count_objects(private, sc);
> > +    ret.inner
> > +}
>
> Why are there two assignments to "private" here? And for the one
> that is borrowing a reference, why is it needed as the shrinker is
> supposed to hold a reference, right? Also, where is that reference
> dropped - it's not at all obvious to me (as a relative n00b to rust)
> what is going on here.

It's just to avoid having one long line. The first line obtains a void
pointer to the private data. The second line converts it into a
borrowed form of whichever pointer type the private data has chosen to
use.

For example:
* If the private data is `Box<T>`, that is, a pointer with exclusive
ownership over an allocation created with kmalloc, then the borrowed
form is a normal shared Rust reference `&T`.
* If the private data is `Arc<T>`, that is, a pointer that owns a
refcount on an allocation created with kmalloc, then the borrowed form
is `ArcBorrow<T>`, which is like `&T` but also gives you the ability
to increment the refcount and create a new `Arc<T>` if you would like
one. An `ArcBorrow<T>` does not hold a refcount itself.

Notably, the call to `borrow` does *not* increment any refcounts.
Think of it as a pointer cast from void pointer to whichever pointer
type is appropriate for the kind of ownership used with the private
data. If you look at the definition of ForeignOwnable in
rust/kernel/types.rs, which is a trait for anything that can be stored
in a void pointer, you'll find that it has three methods:

* `into_foreign` - converts an owned version of the pointer into a void poi=
nter.
* `from_foreign` - converts the void pointer back into an owned
version, effectively taking ownership of the void pointer
* `borrow` - let's you look inside a void pointer without taking ownership =
of it

Here, `from_foreign` requires that there are no active calls to
`borrow` when you take back ownership.

Alice

