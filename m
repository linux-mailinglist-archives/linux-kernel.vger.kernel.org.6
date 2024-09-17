Return-Path: <linux-kernel+bounces-331246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9AF997AA54
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 04:00:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A5121C21DA3
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 02:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AD9D4B5AE;
	Tue, 17 Sep 2024 01:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="2+eLjWPD"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF53325761
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 01:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726538397; cv=none; b=DeuRbChjNBCkfVsIYJ3Dpq6jACv4pLYZCK4GuiRa7DVP+GSNbxhokrm+cnwVJpJSS7Q8yRo9jQh0ye0bFNdbGM2/Gu1al4TweZqPM7vvqN8UsXAUtz3y/s8FMNpO4F+FDl+K+LaCOfYE0vdSKDVWxbJRHmY06w0XGwjV6kkYJ8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726538397; c=relaxed/simple;
	bh=maATjhNijp0xT498YPX3M5eDfze66pzpSqJwg9xmE/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G5p+QP3tDkjgUJX+nhmA5CJo4KC+YBks5hPDqIjqBmUuLfMS8o9Yg/s+b7ssRLjvmIBwlKt3PKL85M/KtZrxEvvfBE/oDu2+TzcGKO0smgPtsdp3UofJIaXuypQ9+gDoxt2wDZ+cZAs0T2I3kRx/VGtrTpzLISXZhRfb94xaAgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=2+eLjWPD; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20536dcc6e9so28570145ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 18:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1726538395; x=1727143195; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Cw2U/XEaaQG67q1n3SHABwcmT4ImShucmpz9PcbS1PQ=;
        b=2+eLjWPDR5GFj6oJ3ouqjmGKIfONZscCNkowg7d31wjkOrWk6CL47FDqKzxxCa4Kda
         E8h6qaWMiY7UbejN9hbQ5yyA40+0u9BtL04EEXWnU+k8gwJuQP7vw1lfNkdIGBWb0WR2
         4bHd+uIXvoO5iFWAQoMKdBxYDY7OKmyTPYvNCSYPhHBTb5H/syDPUz8Tki3RwiUdd/Yu
         C8zTz4micsQCYOyL4Wz8Mvzmp2Oo1pZnviNbUZer+T6fAPqdaw5Xd1BbZh7XEbaia5Bi
         zvJVdk39vM9w0feJzMQ5PPeMba9VJwZt30BR0OOqtV4HM16BUhDI602LL7uD8UPVp0Hu
         H6Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726538395; x=1727143195;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cw2U/XEaaQG67q1n3SHABwcmT4ImShucmpz9PcbS1PQ=;
        b=AijEvMysF8WQAzCEBbs8IFMP9FE3Ob9+sauo+0oKaWj5Yha/3plMY/X64KpFJo4FFo
         lYhzJK5iRiU8lPjJxw5hxpVATYqMG0b9A9RvBqXlht0S5ouoYGj6zEUhxOVmkbjqTK7t
         gyUh5DRIvA6KDou8MN16EYOpln3y46J6zv+hmBkmu/c+TLXdSF00AX8FXWO1TYvZqRrP
         504kwiA9K8uBUhyiY982VTtAFeGcOXgoTGX5rGKcWl4/xWJ9SAsQvhYNsk4TJOFuRi1C
         v6uecQMxbglo+wj1G+meK11mfeyG++KRVNr2RuSHYYB+f98R+UAeXjB9XqJJwr6zt9nv
         Ucog==
X-Forwarded-Encrypted: i=1; AJvYcCVC0uGXW7beM2Dg+9p7JOuJXLKmb+48P82k2JIbHQ0v4joqSDZeMxfSX3h4gN3upbMbvKDQrEQTso+eHug=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvQiFVzv+RiHislsy7IvRfFy1nKaGB4divA8gUkszHzgUDJouX
	FOs2ZgnuN7MIs4NBSIMz0Sj/xXwI2hIfQQMMngK1TFLxCVwdkraktY93JFj7Uhs=
X-Google-Smtp-Source: AGHT+IHgKznBoUF0CPOd86StgVoFTb9npVIpk6TXb6/8gY4dAvicDfZVh1n0dEI6Ubz6KFnFSPsVcA==
X-Received: by 2002:a17:903:32cb:b0:206:9536:9778 with SMTP id d9443c01a7336-2078284c185mr189609555ad.19.1726538394849;
        Mon, 16 Sep 2024 18:59:54 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-78-197.pa.nsw.optusnet.com.au. [49.179.78.197])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2079471a2e6sm42244585ad.240.2024.09.16.18.59.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 18:59:54 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1sqNVP-006Apv-09;
	Tue, 17 Sep 2024 11:59:51 +1000
Date: Tue, 17 Sep 2024 11:59:51 +1000
From: Dave Chinner <david@fromorbit.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH] rust: shrinker: add shrinker abstraction
Message-ID: <ZujilxJumUAafp+3@dread.disaster.area>
References: <20240912-shrinker-v1-1-18b7f1253553@google.com>
 <ZuefFhomRvqtFzSn@dread.disaster.area>
 <CAH5fLgjRuGZWMRWTbmS5w+eLG1kPQNo95c6E6db9y8nUt2RH2A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH5fLgjRuGZWMRWTbmS5w+eLG1kPQNo95c6E6db9y8nUt2RH2A@mail.gmail.com>

On Mon, Sep 16, 2024 at 12:22:40PM +0200, Alice Ryhl wrote:
> On Mon, Sep 16, 2024 at 4:59 AM Dave Chinner <david@fromorbit.com> wrote:
> >
> > On Thu, Sep 12, 2024 at 09:54:01AM +0000, Alice Ryhl wrote:
> > > Rust Binder holds incoming transactions in a read-only mmap'd region
> > > where it manually manages the pages. These pages are only in use until
> > > the incoming transaction is consumed by userspace, but the kernel will
> > > keep the pages around for future transactions. Rust Binder registers a
> > > shrinker with the kernel so that it can give back these pages if the
> > > system comes under memory pressure.
> > >
> > > Separate types are provided for registered and unregistered shrinkers.
> > > The unregistered shrinker type can be used to configure the shrinker
> > > before registering it. Separating it into two types also enables the
> > > user to construct the private data between the calls to `shrinker_alloc`
> > > and `shrinker_register` and avoid constructing the private data if
> > > allocating the shrinker fails.
> >
> > This seems a bit nasty. It appears to me that the code does an
> > unsafe copy of the internal shrinker state between the unregistered
> > and registered types. Shrinkers have additional internal state when
> > SHRINKER_MEMCG_AWARE and/or SHRINKER_NUMA_AWARE flags are set,
> > and this abstraction doesn't seem to handle either those flags or
> > the internal state they use at all.
> 
> Doing an unsafe copy of the internal shrinker state is certainly not
> my intent. The UnregisteredShrinker and RegisteredShrinker types just
> wrap a non-null pointer, so the moves inside `register` are not copies
> of the whole `struct shrinker` but just copies of a pointer to the
> shrinker.

So you're playing type casting games with the same structure just to
avoid the potential doing a little bit of unnecessary work in an
error situation?

This all seems rather convoluted and largely unnecessary to me as
the shrinker_free() C code transparent handles both registered and
unregistered shrinkers being passed to it. There really is no
difference between the two cases in terms of error handling and
teardown....

> > > +impl UnregisteredShrinker {
> > > +    /// Create a new shrinker.
> > > +    pub fn alloc(name: &CStr) -> Result<Self, AllocError> {
> > > +        // SAFETY: Passing `0` as flags is okay. Using `%s` as the format string is okay when we
> > > +        // pass a nul-terminated string as the string for `%s` to print.
> > > +        let ptr =
> > > +            unsafe { bindings::shrinker_alloc(0, c_str!("%s").as_char_ptr(), name.as_char_ptr()) };
> >
> > This passes flags as 0, so doesn't support SHRINKER_MEMCG_AWARE or
> > SHRINKER_NUMA_AWARE shrinker variants. These flags should be
> > passed through here.
> 
> I don't have a user for memcg/numa aware shrinkers in Rust, which is
> why I did not extend these abstractions to support them. However, if
> you would like me to, I'm happy to do so.

Please do. A partial implementation only makes it harder for the
next person to use the API....

> It is easy to add a flags
> argument to this method, but I imagine they also need a few other
> additions elsewhere in the API to really be supported?

In the shrinker API, nothing extra needs to be done.

If you haven't added bindings to the list_lru interfaces yet, then
you are going to need to, including the memcg and numa aware
interfaces for that.

> Now that I think about it, perhaps Binder's shrinker *could* be memcg
> aware? It uses the list_lru abstraction, and currently calls
> `list_lru_count` in `count_objects`, but maybe we could just use
> `list_lru_shrink_count` instead and magically become memcg aware ...?

The scan code also needs to use list_lru_shrink_walk(), too,
not list_lru_walk().

And, yes, that's really the whole point of the list_lru abstraction -
almost nothing extra needs to be done to enable both NUMA and memcg
based reclaim context support for a cache once it's been converted
to use list_lru for tracking reclaimable objects.

> 
> > > +    /// Set the number of seeks needed to recreate an object.
> > > +    pub fn set_seeks(&mut self, seeks: u32) {
> > > +        unsafe { (*self.shrinker.as_ptr()).seeks = seeks as c_int };
> > > +    }
> >
> > Seems kinda weird to have a separate function for setting seeks,
> > when...
> >
> > > +
> > > +    /// Register the shrinker.
> > > +    ///
> > > +    /// The provided pointer is used as the private data, and the type `T` determines the callbacks
> > > +    /// that the shrinker will use.
> > > +    pub fn register<T: Shrinker>(self, private_data: T::Ptr) -> RegisteredShrinker<T> {
> >
> > .... all the other data needed to set up a shrinker is provided to
> > this function....
> >
> > > +        let shrinker = self.shrinker;
> > > +        let ptr = shrinker.as_ptr();
> > > +
> > > +        // The destructor of `self` calls `shrinker_free`, so skip the destructor.
> > > +        core::mem::forget(self);
> > > +
> > > +        let private_data_ptr = <T::Ptr as ForeignOwnable>::into_foreign(private_data);
> > > +
> > > +        // SAFETY: We own the private data, so we can assign to it.
> > > +        unsafe { (*ptr).private_data = private_data_ptr.cast_mut() };
> > > +        // SAFETY: The shrinker is not yet registered, so we can update this field.
> > > +        unsafe { (*ptr).count_objects = Some(rust_count_objects::<T>) };
> > > +        // SAFETY: The shrinker is not yet registered, so we can update this field.
> > > +        unsafe { (*ptr).scan_objects = Some(rust_scan_objects::<T>) };
> >
> > .... and implemented exactly the same way.
> 
> Well .. this design makes setting `seeks` optional, but `private_data`
> mandatory. We *have* to set the two function pointers, but you don't
> have to set `seeks` explicitly.
> 
> It's not obvious, so it's probably worth mentioning that this design
> doesn't actually require you to make an allocation and store a real
> pointer in the private data.

Yes, definitely worth mentioning, because I think we need to require
new shrinkers to provide a direct pointer to the context the
shrinker will operate on. We want to move away from anonymous
"global" shrinkers that don't provide a context for the shrinker to
operation on for a number of reasons...

If we change the C code to work this way, then the private pointer
in the rust binding will become mandatory. Hence it might be worth
making the rust bindings and shrinker implementations behave this
way from the start....

> When implementing the Shrinker trait for
> your custom shrinker, you have to choose which pointer type to use. If
> you choose the unit type `()` as the pointer type, then no real
> pointer is actually stored.
>
> > > +/// How many objects are there in the cache?
> > > +///
> > > +/// This is used as the return value of [`Shrinker::count_objects`].
> > > +pub struct CountObjects {
> > > +    inner: c_ulong,
> > > +}
> > > +
> > > +impl CountObjects {
> > > +    /// Indicates that the number of objects is unknown.
> > > +    pub const UNKNOWN: Self = Self { inner: 0 };
> > > +
> > > +    /// Indicates that the number of objects is zero.
> > > +    pub const EMPTY: Self = Self {
> > > +        inner: SHRINK_EMPTY,
> > > +    };
> > > +
> > > +    /// The maximum possible number of freeable objects.
> > > +    pub const MAX: Self = Self {
> > > +        // The shrinker code assumes that it can multiply this value by two without overflow.
> > > +        inner: c_ulong::MAX / 2,
> > > +    };
> > > +
> > > +    /// Creates a new `CountObjects` with the given value.
> > > +    pub fn from_count(count: usize) -> Self {
> > > +        if count == 0 {
> > > +            return Self::EMPTY;
> > > +        }
> >
> > No. A return count of 0 is not the same as a return value of
> > SHRINK_EMPTY.
> >
> > A return value of 0 means "no reclaim work can be done right now".
> >
> > This implies that there are objects that can be reclaimed in the near
> > future, but right now they are unavailable for reclaim. This can be
> > due to a trylock protecting the count operation failing, the all the
> > objects in the cache being dirty and needing work to be done before
> > they can be reclaimed, etc.
> >
> > A return value of SHRINK_EMPTY means "there are no reclaimable
> > objects at all".
> >
> > This implies that the cache is empty - it has absolutely nothing in
> > it that can be reclaimed either now or in the near future.
> >
> > These two return values are treated very differently by the high
> > level code. SHRINK_EMPTY is used by shrink_slab_memcg() to maintain
> > a "shrinker needs to run" bit in the memcg shrinker search bitmap.
> > The bit is cleared when SHRINK_EMPTY is returned, meaning the
> > shrinker will not get called again until a new object is queued
> > to it's LRU. This sets the "shrinker needs to run" bit again, and
> > so the shrinker will run next time shrink_slab_memcg() is called.
> >
> > In constrast, a return value of zero (i.e. no work to be done right
> > now) does not change the "shrinker needs to run" state bit, and
> > hence it will always be called the next time the shrink_slab_memcg()
> > is run to try to reclaim objects from that memcg shrinker...
> 
> This is a part of the API that I was pretty unsure about, so very
> happy to get your input. For both of the shrinkers I am familiar with,
> they know the exact count of objects and there's no error case for any
> lock. The shrinkers just return the exact count directly from
> count_objects, but that seemed incorrect to me, as this means that the
> shrinker returns 0 when it really should return SHRINK_EMPTY.

Yes, they should be returning SHRINK_EMPTY and not 0 in this case.
See super_cache_count() for example.

>
> That's
> why I implemented `from_count` this way - the intent is that you use
> `CountObjects::from_count` when you know the exact count, so if you
> pass 0 to that method, then that means the shrinker really is empty.
> If you don't know what the count is, then you return
> `CountObjects::UNKNOWN` instead.

Understood, and I see your point. I think it's a good approach to
take, but I don't think that the rust binding implementation is the
appropriate place to introduce such API/semantic enhancements.

I would really like to avoid the situation where rust-based
shrinkers have explicitly different API and behavioural semantics to
the C shrinkers. Hence I would prefer the rust bindings to implement
the existing C semantics and then, as a separate piece of work, we
move everything (both C and Rust) to the new set of semantics as a
single changeset.

I know that is more difficult to do and co-ordinate, but I think we
are going to be much better off in the long run if we start from a
common base and then make improvements to both sides of the API at
the same time. Note that I'm not asking you to change all the C code
here - I can certainly help there - but I am asking that we try
really hard to keep APIs and behavioural semantics as close together
as possible.

> That said, I guess there is some reason that the C shrinker API is
> designed to use the value 0 for unknown rather than empty, so perhaps
> I should not try to do it differently.

No reason, it just evolved organically that way over the past decade
- SHRINK_EMPTY was introduced (historically speaking) fairly
recently and only propogated into the shrinkers that needed to set
it (i.e. the memcg aware shrinkers).

This is the sort of API fragmentation I would like us to avoid - I
don't want to see some shrinkers with SHRINK_EMPTY, some with 0, and
then yet another new subset with UNKNOWN, yet all largely meaning
the same thing in a global shrinker context but 2 of the three types
being incorrect in a memcg shrinker context...

> > > +impl ScanObjects {
> > > +    /// Indicates that the shrinker should stop trying to free objects from this cache due to
> > > +    /// potential deadlocks.
> > > +    pub const STOP: Self = Self { inner: SHRINK_STOP };
> > > +
> > > +    /// The maximum possible number of freeable objects.
> > > +    pub const MAX: Self = Self {
> > > +        // The shrinker code assumes that it can multiply this value by two without overflow.
> > > +        inner: c_ulong::MAX / 2,
> >
> > No it doesn't. This is purely a count of objects freed by the
> > shrinker.
> 
> In mm/shrinker.c it multiplies by two here:
> total_scan = min(total_scan, (2 * freeable));

freeable is derived from the return of ->count_objects, not
from ->scan_objects (i.e. it is a CountObjects type, not a
ScanObjects type).

->scan_objects() returns SHRINK_STOP to indicate that scanning
should stop immediately or the number of objects freed. The only
thing that is done with value other than SHRINK_STOP is to aggregate
it across repeated calls to ->scan_objects().

> > > +    /// Determines whether it is safe to recurse into filesystem code.
> > > +    pub fn gfp_fs(&self) -> bool {
> > > +        // SAFETY: Okay by type invariants.
> > > +        let mask = unsafe { (*self.ptr.as_ptr()).gfp_mask };
> > > +
> > > +        (mask & bindings::__GFP_FS) != 0
> > > +    }
> >
> > This needs a check for __GFP_IO as well, as there are block layer
> > shrinkers that need to be GFP_NOIO aware...
> 
> Would you prefer that I add additional methods, or that I modify this
> method to also check __GFP_IO, or that I just expose a way to get the
> `gfp_mask` value directly?

If it was C code, I would suggest the API would something like:

	if (!reclaim_allowed(sc, __GFP_FS))
		return SHRINK_STOP;

or
	if (!reclaim_allowed(sc, __GFP_IO))
		return SHRINK_STOP;

As this matches the typical usage (e.g. see super_cache_scan()).

> 
> > > +    /// Returns the number of objects that `scan_objects` should try to reclaim.
> > > +    pub fn nr_to_scan(&self) -> usize {
> > > +        // SAFETY: Okay by type invariants.
> > > +        unsafe { (*self.ptr.as_ptr()).nr_to_scan as usize }
> > > +    }
> > > +
> > > +    /// The callback should set this value to the number of objects processed.
> > > +    pub fn set_nr_scanned(&mut self, val: usize) {
> > > +        let mut val = val as c_ulong;
> > > +        // SAFETY: Okay by type invariants.
> > > +        let max = unsafe { (*self.ptr.as_ptr()).nr_to_scan };
> > > +        if val > max {
> > > +            val = max;
> > > +        }
> >
> > No. Shrinkers are allowed to scan more objects in a batch than
> > the high level code asked them to scan. If they do this, they
> > *must* report back the count of all the objects they scanned so the
> > batched scan accounting can adjust the remaining amount of work that
> > needs to be done appropriately.
> 
> Acknowledged.
> 
> This is related to another question that I had, actually. Other than
> returning SHRINK_STOP, in what situations should `nr_scanned` be
> different from the return value of `scan_objects`?

nr_scanned will almost always be different to the return value of
->scan_objects. 

There are 3 values of note here.

- nr_scanned is set by the shrinker scan setup code to the batch
  size the shrinker should scan in it's next invocation.

  If the shrinker ignores nr_to_scan batch limits, it can indicate
  how many objects it scanned by setting the number it scanned to
  nr_scanned before it returns.

- nr_to_scan is set to nr_scanned at setup.

  The shrinker should then decrement nr_scanned for each object that
  is scanned by the shrinker.  The shrinker should stop scanning and
  return nr_freed when nr_to_scan reaches zero.

  If the value of this is non-zero when the scan returns, it is an
  indication that the shrinker either did not scan the entire
  batch or the batch size was larger than the remaining number of
  objects in the cache.

- nr_freed: return value from the shrinker

  This is a count of the number of objects the shrinker freed during
  the scan.

  If the shrinker cannot make progress for any reason it
  should immediately return SHRINK_STOP.

So on a typical shrinker pass, we'll exit with:

	nr_scanned = batch size;
	nr_to_scan = 0;
	nr_freed = [0..batch size];

Some shrinkers, however, have variable sized objects, and so they
will normalise nr_freed and nr_scanned to the object size. The
i915/gem shrinker does this, as it considers a page to be an object,
but in reality is has a smaller number of variable sized multi-page
objects being tracked. Hence it might be asked to scan 128 objects
(default batch size), but the scan iterated over objects that
contain 256 pages.

In that case, it will return:

	nr_scanned = 256;
	nr_to_scan = 0;
	nr_freed = [0..256]

And the high level shrinker code will treat that as having scanned
256 objects rather than the 128 objects it asked for.

There are several shrinkers that play weird accounting games like
this. It's not really all that nice and it would be ice to clean all
this up, but there's been no real urgency to do this because it's
just a slightly different manner of accounting reclaim progress....

-Dave.
-- 
Dave Chinner
david@fromorbit.com

