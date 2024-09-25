Return-Path: <linux-kernel+bounces-339328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D6A986365
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 17:25:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35DAC1F27B2A
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 15:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DF5218593D;
	Wed, 25 Sep 2024 15:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ASQu25Vc"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5EBF15623A
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 15:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727276789; cv=none; b=pUB1cXd/kF27Cr7OSDIo2cwKNuK3z0qkHbjXJ0ZmqzwzxO5j3Yb6te/rVnNnrU9lIpdFgqd+0Co4eQ8spH6/ismK1IHVsDhtkGOutaPckQwomdtes9t97GyKVryq4rAt6ftIElsl9lI5GfKdd6wdbwh+9Yk3hkB+TDQQCSLDO/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727276789; c=relaxed/simple;
	bh=LUKbfunRecVuYfJ8G0Lir1SSiMNVQRMfYPtinEX6e/g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iudqBGJbrXQHYfPuE+73rTXIyQoW4neJ7LjYYJSuRNR6RaorS9T0g0JzrvZ8fXRuDcB0Vea70Lu7iRfHVmWh3jShIV9HpeJmt05umGiK5J1/O31TciME1cP1isro3HorwDNRaTkBmlNJSKZnrDl3lBCKcyc3gt0/zdFJ2cn9GUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ASQu25Vc; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2f759b87f83so74059031fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 08:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727276785; x=1727881585; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=48tc8SG27vBYFvQ5zAQ542g7tFhfOjr7SSLh16Fe278=;
        b=ASQu25VcLLmT3TfxI8sDgR1dPFtYFt+dKsmjPPpUY/TLrW8krfqP+g7Ih2rQKaVjTi
         CpiOcW3k5WPs9BINKihcNqQ2/yzkmJuX84pYGuRnIdWNvxXkIyFcWTedFPM9YOkTTG8r
         rdb0IoWw5PqroPX9dA2LwXlYBJDXi7No7Y3igKlX+hUfGRvfZncwLO/QPYHVJBFhWHD/
         tG1RBJZ6zw7//OXusLo27+OdmSKclMLYB/1U5PbXAaSdKyp0+CjIDljBTqmWUp/aax+K
         xzpie7xpJPnrPOQzmwhXrkh7kDPhIQtu3dGr9VXtgQ75j4l3w59+LY9TFOwQ50I3Pqr0
         SazA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727276785; x=1727881585;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=48tc8SG27vBYFvQ5zAQ542g7tFhfOjr7SSLh16Fe278=;
        b=Es8c9TJodfPW6QhClyFYJGueRj5hYaXZ39+2VaP2/Ja7NVDRp+ltSbbelWL/aGBw9X
         BlytZ7fj9SNkgkA+ho8lOdXX6PQ1ZK8MhJ1KBSvtEddDCBO5k5scng/xTk9FTE5+Ro4K
         hx9mrMO3CnOqRpCqf3RRUSx6Y0vsWvTJpVqVvjUIuaBKieWPg0X88XWsREk2rCWA5w7n
         qOwCTw94Av4GmpJmBGEEv9whA7HmPjkOCgVYG7aghIaFl0juzagmvV+LmV/EKe6A7jwM
         N46e8s0n7hMmXwJrFUPyM8ZsA31+PC9NJvRkFQrcvrBEgyVhXKPyZucKVZJZBAiqyvDJ
         gQ3A==
X-Forwarded-Encrypted: i=1; AJvYcCV4nu4mZ7zpwFKqgcfpFjbwAIdEW7LT5jdDS3MU2y2OyxUGiL+rZ92wLhbsuaey5+mr+SeHPJpW2fhh94g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyY/lu+Iwf7zJkbWuRqzTpwZgmjsWObTiAXIOt4KV0Orw5oMu0e
	cTb5DjAPyh+3wSRBu1tBhpFrKxvqJRUCo0U53o6mCg8ueRrAxGxoQlbqGMLk4hFfTid4kHOXDrw
	b3wB0C8RH9jfkO4S0zA69wOvMNhVWR78Aly3z
X-Google-Smtp-Source: AGHT+IF7Q966CidmsWMMn+XFu0HxutWsKfg6Bw/SWMj3O7CxaP2N7VqvVpZyQ4TtcjFOeET21JVaARUAO/17q5KdgGo=
X-Received: by 2002:a2e:a985:0:b0:2ef:1db2:c02c with SMTP id
 38308e7fff4ca-2f915fe71f9mr22285521fa.10.1727276784326; Wed, 25 Sep 2024
 08:06:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240912-shrinker-v1-1-18b7f1253553@google.com>
 <ZuefFhomRvqtFzSn@dread.disaster.area> <CAH5fLgjRuGZWMRWTbmS5w+eLG1kPQNo95c6E6db9y8nUt2RH2A@mail.gmail.com>
 <ZujilxJumUAafp+3@dread.disaster.area>
In-Reply-To: <ZujilxJumUAafp+3@dread.disaster.area>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 25 Sep 2024 17:06:12 +0200
Message-ID: <CAH5fLghMi+CHs=UOJCs+COi3rOq6Bhi4ZkiVwcYC+fKwXmGmOA@mail.gmail.com>
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

On Tue, Sep 17, 2024 at 3:59=E2=80=AFAM Dave Chinner <david@fromorbit.com> =
wrote:
>
> On Mon, Sep 16, 2024 at 12:22:40PM +0200, Alice Ryhl wrote:
> > On Mon, Sep 16, 2024 at 4:59=E2=80=AFAM Dave Chinner <david@fromorbit.c=
om> wrote:
> > >
> > > On Thu, Sep 12, 2024 at 09:54:01AM +0000, Alice Ryhl wrote:
> > > > Rust Binder holds incoming transactions in a read-only mmap'd regio=
n
> > > > where it manually manages the pages. These pages are only in use un=
til
> > > > the incoming transaction is consumed by userspace, but the kernel w=
ill
> > > > keep the pages around for future transactions. Rust Binder register=
s a
> > > > shrinker with the kernel so that it can give back these pages if th=
e
> > > > system comes under memory pressure.
> > > >
> > > > Separate types are provided for registered and unregistered shrinke=
rs.
> > > > The unregistered shrinker type can be used to configure the shrinke=
r
> > > > before registering it. Separating it into two types also enables th=
e
> > > > user to construct the private data between the calls to `shrinker_a=
lloc`
> > > > and `shrinker_register` and avoid constructing the private data if
> > > > allocating the shrinker fails.
> > >
> > > This seems a bit nasty. It appears to me that the code does an
> > > unsafe copy of the internal shrinker state between the unregistered
> > > and registered types. Shrinkers have additional internal state when
> > > SHRINKER_MEMCG_AWARE and/or SHRINKER_NUMA_AWARE flags are set,
> > > and this abstraction doesn't seem to handle either those flags or
> > > the internal state they use at all.
> >
> > Doing an unsafe copy of the internal shrinker state is certainly not
> > my intent. The UnregisteredShrinker and RegisteredShrinker types just
> > wrap a non-null pointer, so the moves inside `register` are not copies
> > of the whole `struct shrinker` but just copies of a pointer to the
> > shrinker.
>
> So you're playing type casting games with the same structure just to
> avoid the potential doing a little bit of unnecessary work in an
> error situation?
>
> This all seems rather convoluted and largely unnecessary to me as
> the shrinker_free() C code transparent handles both registered and
> unregistered shrinkers being passed to it. There really is no
> difference between the two cases in terms of error handling and
> teardown....

Well another thing it does is make it possible to specify shrinker
without making it mandatory. I don't think it's so bad to have a
builder type, but I can drop it if you prefer that.

If we replace the builder with a single function for constructing it,
then we need to pick one of:
* Not accept a value for "seeks" at all.
* Always require an explicit value for "seeks".
* Make a "shrinker options" struct that we can pass to the constructor.
* Have multiple constructors.

> > > > +impl UnregisteredShrinker {
> > > > +    /// Create a new shrinker.
> > > > +    pub fn alloc(name: &CStr) -> Result<Self, AllocError> {
> > > > +        // SAFETY: Passing `0` as flags is okay. Using `%s` as the=
 format string is okay when we
> > > > +        // pass a nul-terminated string as the string for `%s` to =
print.
> > > > +        let ptr =3D
> > > > +            unsafe { bindings::shrinker_alloc(0, c_str!("%s").as_c=
har_ptr(), name.as_char_ptr()) };
> > >
> > > This passes flags as 0, so doesn't support SHRINKER_MEMCG_AWARE or
> > > SHRINKER_NUMA_AWARE shrinker variants. These flags should be
> > > passed through here.
> >
> > I don't have a user for memcg/numa aware shrinkers in Rust, which is
> > why I did not extend these abstractions to support them. However, if
> > you would like me to, I'm happy to do so.
>
> Please do. A partial implementation only makes it harder for the
> next person to use the API....

Alright.

> > It is easy to add a flags
> > argument to this method, but I imagine they also need a few other
> > additions elsewhere in the API to really be supported?
>
> In the shrinker API, nothing extra needs to be done.
>
> If you haven't added bindings to the list_lru interfaces yet, then
> you are going to need to, including the memcg and numa aware
> interfaces for that.

I'm not familiar with the memcg/numa aware interfaces for list_lru, as
I only know about Binder's usage. Is there a good example of using
them somewhere?

Or does it not require anything beyond just adding Rust versions of
list_lru_shrink_walk and list_lru_shrink_count that accept a
ShrinkControl from a shrinker?

> > Now that I think about it, perhaps Binder's shrinker *could* be memcg
> > aware? It uses the list_lru abstraction, and currently calls
> > `list_lru_count` in `count_objects`, but maybe we could just use
> > `list_lru_shrink_count` instead and magically become memcg aware ...?
>
> The scan code also needs to use list_lru_shrink_walk(), too,
> not list_lru_walk().
>
> And, yes, that's really the whole point of the list_lru abstraction -
> almost nothing extra needs to be done to enable both NUMA and memcg
> based reclaim context support for a cache once it's been converted
> to use list_lru for tracking reclaimable objects.

If it's that easy, then that's great!

> > > > +    /// Set the number of seeks needed to recreate an object.
> > > > +    pub fn set_seeks(&mut self, seeks: u32) {
> > > > +        unsafe { (*self.shrinker.as_ptr()).seeks =3D seeks as c_in=
t };
> > > > +    }
> > >
> > > Seems kinda weird to have a separate function for setting seeks,
> > > when...
> > >
> > > > +
> > > > +    /// Register the shrinker.
> > > > +    ///
> > > > +    /// The provided pointer is used as the private data, and the =
type `T` determines the callbacks
> > > > +    /// that the shrinker will use.
> > > > +    pub fn register<T: Shrinker>(self, private_data: T::Ptr) -> Re=
gisteredShrinker<T> {
> > >
> > > .... all the other data needed to set up a shrinker is provided to
> > > this function....
> > >
> > > > +        let shrinker =3D self.shrinker;
> > > > +        let ptr =3D shrinker.as_ptr();
> > > > +
> > > > +        // The destructor of `self` calls `shrinker_free`, so skip=
 the destructor.
> > > > +        core::mem::forget(self);
> > > > +
> > > > +        let private_data_ptr =3D <T::Ptr as ForeignOwnable>::into_=
foreign(private_data);
> > > > +
> > > > +        // SAFETY: We own the private data, so we can assign to it=
.
> > > > +        unsafe { (*ptr).private_data =3D private_data_ptr.cast_mut=
() };
> > > > +        // SAFETY: The shrinker is not yet registered, so we can u=
pdate this field.
> > > > +        unsafe { (*ptr).count_objects =3D Some(rust_count_objects:=
:<T>) };
> > > > +        // SAFETY: The shrinker is not yet registered, so we can u=
pdate this field.
> > > > +        unsafe { (*ptr).scan_objects =3D Some(rust_scan_objects::<=
T>) };
> > >
> > > .... and implemented exactly the same way.
> >
> > Well .. this design makes setting `seeks` optional, but `private_data`
> > mandatory. We *have* to set the two function pointers, but you don't
> > have to set `seeks` explicitly.
> >
> > It's not obvious, so it's probably worth mentioning that this design
> > doesn't actually require you to make an allocation and store a real
> > pointer in the private data.
>
> Yes, definitely worth mentioning, because I think we need to require
> new shrinkers to provide a direct pointer to the context the
> shrinker will operate on. We want to move away from anonymous
> "global" shrinkers that don't provide a context for the shrinker to
> operation on for a number of reasons...
>
> If we change the C code to work this way, then the private pointer
> in the rust binding will become mandatory. Hence it might be worth
> making the rust bindings and shrinker implementations behave this
> way from the start....

Thanks for the context. That is good to know.

> > When implementing the Shrinker trait for
> > your custom shrinker, you have to choose which pointer type to use. If
> > you choose the unit type `()` as the pointer type, then no real
> > pointer is actually stored.
> >
> > > > +/// How many objects are there in the cache?
> > > > +///
> > > > +/// This is used as the return value of [`Shrinker::count_objects`=
].
> > > > +pub struct CountObjects {
> > > > +    inner: c_ulong,
> > > > +}
> > > > +
> > > > +impl CountObjects {
> > > > +    /// Indicates that the number of objects is unknown.
> > > > +    pub const UNKNOWN: Self =3D Self { inner: 0 };
> > > > +
> > > > +    /// Indicates that the number of objects is zero.
> > > > +    pub const EMPTY: Self =3D Self {
> > > > +        inner: SHRINK_EMPTY,
> > > > +    };
> > > > +
> > > > +    /// The maximum possible number of freeable objects.
> > > > +    pub const MAX: Self =3D Self {
> > > > +        // The shrinker code assumes that it can multiply this val=
ue by two without overflow.
> > > > +        inner: c_ulong::MAX / 2,
> > > > +    };
> > > > +
> > > > +    /// Creates a new `CountObjects` with the given value.
> > > > +    pub fn from_count(count: usize) -> Self {
> > > > +        if count =3D=3D 0 {
> > > > +            return Self::EMPTY;
> > > > +        }
> > >
> > > No. A return count of 0 is not the same as a return value of
> > > SHRINK_EMPTY.
> > >
> > > A return value of 0 means "no reclaim work can be done right now".
> > >
> > > This implies that there are objects that can be reclaimed in the near
> > > future, but right now they are unavailable for reclaim. This can be
> > > due to a trylock protecting the count operation failing, the all the
> > > objects in the cache being dirty and needing work to be done before
> > > they can be reclaimed, etc.
> > >
> > > A return value of SHRINK_EMPTY means "there are no reclaimable
> > > objects at all".
> > >
> > > This implies that the cache is empty - it has absolutely nothing in
> > > it that can be reclaimed either now or in the near future.
> > >
> > > These two return values are treated very differently by the high
> > > level code. SHRINK_EMPTY is used by shrink_slab_memcg() to maintain
> > > a "shrinker needs to run" bit in the memcg shrinker search bitmap.
> > > The bit is cleared when SHRINK_EMPTY is returned, meaning the
> > > shrinker will not get called again until a new object is queued
> > > to it's LRU. This sets the "shrinker needs to run" bit again, and
> > > so the shrinker will run next time shrink_slab_memcg() is called.
> > >
> > > In constrast, a return value of zero (i.e. no work to be done right
> > > now) does not change the "shrinker needs to run" state bit, and
> > > hence it will always be called the next time the shrink_slab_memcg()
> > > is run to try to reclaim objects from that memcg shrinker...
> >
> > This is a part of the API that I was pretty unsure about, so very
> > happy to get your input. For both of the shrinkers I am familiar with,
> > they know the exact count of objects and there's no error case for any
> > lock. The shrinkers just return the exact count directly from
> > count_objects, but that seemed incorrect to me, as this means that the
> > shrinker returns 0 when it really should return SHRINK_EMPTY.
>
> Yes, they should be returning SHRINK_EMPTY and not 0 in this case.
> See super_cache_count() for example.

Okay.

> > That's
> > why I implemented `from_count` this way - the intent is that you use
> > `CountObjects::from_count` when you know the exact count, so if you
> > pass 0 to that method, then that means the shrinker really is empty.
> > If you don't know what the count is, then you return
> > `CountObjects::UNKNOWN` instead.
>
> Understood, and I see your point. I think it's a good approach to
> take, but I don't think that the rust binding implementation is the
> appropriate place to introduce such API/semantic enhancements.
>
> I would really like to avoid the situation where rust-based
> shrinkers have explicitly different API and behavioural semantics to
> the C shrinkers. Hence I would prefer the rust bindings to implement
> the existing C semantics and then, as a separate piece of work, we
> move everything (both C and Rust) to the new set of semantics as a
> single changeset.
>
> I know that is more difficult to do and co-ordinate, but I think we
> are going to be much better off in the long run if we start from a
> common base and then make improvements to both sides of the API at
> the same time. Note that I'm not asking you to change all the C code
> here - I can certainly help there - but I am asking that we try
> really hard to keep APIs and behavioural semantics as close together
> as possible.

That is reasonable. What do you prefer that I do with the CountObjects
type I have now? I can change it to this:

* CountObjects::EMPTY
* CountObjects::new(number)

Where `new` just uses the provided number as-is (unless it's too big).

I can also get rid of the CountObjects type entirely.

> > That said, I guess there is some reason that the C shrinker API is
> > designed to use the value 0 for unknown rather than empty, so perhaps
> > I should not try to do it differently.
>
> No reason, it just evolved organically that way over the past decade
> - SHRINK_EMPTY was introduced (historically speaking) fairly
> recently and only propogated into the shrinkers that needed to set
> it (i.e. the memcg aware shrinkers).
>
> This is the sort of API fragmentation I would like us to avoid - I
> don't want to see some shrinkers with SHRINK_EMPTY, some with 0, and
> then yet another new subset with UNKNOWN, yet all largely meaning
> the same thing in a global shrinker context but 2 of the three types
> being incorrect in a memcg shrinker context...

Yeah, that makes sense. I'm on board with keeping things consistent.

> > > > +impl ScanObjects {
> > > > +    /// Indicates that the shrinker should stop trying to free obj=
ects from this cache due to
> > > > +    /// potential deadlocks.
> > > > +    pub const STOP: Self =3D Self { inner: SHRINK_STOP };
> > > > +
> > > > +    /// The maximum possible number of freeable objects.
> > > > +    pub const MAX: Self =3D Self {
> > > > +        // The shrinker code assumes that it can multiply this val=
ue by two without overflow.
> > > > +        inner: c_ulong::MAX / 2,
> > >
> > > No it doesn't. This is purely a count of objects freed by the
> > > shrinker.
> >
> > In mm/shrinker.c it multiplies by two here:
> > total_scan =3D min(total_scan, (2 * freeable));
>
> freeable is derived from the return of ->count_objects, not
> from ->scan_objects (i.e. it is a CountObjects type, not a
> ScanObjects type).
>
> ->scan_objects() returns SHRINK_STOP to indicate that scanning
> should stop immediately or the number of objects freed. The only
> thing that is done with value other than SHRINK_STOP is to aggregate
> it across repeated calls to ->scan_objects().

Fair point. I can change the maximum to SHRINK_STOP-1. Or do you want
me to get rid of it completely?

> > > > +    /// Determines whether it is safe to recurse into filesystem c=
ode.
> > > > +    pub fn gfp_fs(&self) -> bool {
> > > > +        // SAFETY: Okay by type invariants.
> > > > +        let mask =3D unsafe { (*self.ptr.as_ptr()).gfp_mask };
> > > > +
> > > > +        (mask & bindings::__GFP_FS) !=3D 0
> > > > +    }
> > >
> > > This needs a check for __GFP_IO as well, as there are block layer
> > > shrinkers that need to be GFP_NOIO aware...
> >
> > Would you prefer that I add additional methods, or that I modify this
> > method to also check __GFP_IO, or that I just expose a way to get the
> > `gfp_mask` value directly?
>
> If it was C code, I would suggest the API would something like:
>
>         if (!reclaim_allowed(sc, __GFP_FS))
>                 return SHRINK_STOP;
>
> or
>         if (!reclaim_allowed(sc, __GFP_IO))
>                 return SHRINK_STOP;
>
> As this matches the typical usage (e.g. see super_cache_scan()).

I guess there are several options. A few Rust versions:

fn reclaim_allowed(&self, mode: ReclaimMode) -> bool;
enum ReclaimMode {
    __GFP_FS,
    __GFP_IO,
}

or perhaps just:

fn reclaim_fs_allowed(&self) -> bool;
fn reclaim_io_allowed(&self) -> bool;

> > > > +    /// Returns the number of objects that `scan_objects` should t=
ry to reclaim.
> > > > +    pub fn nr_to_scan(&self) -> usize {
> > > > +        // SAFETY: Okay by type invariants.
> > > > +        unsafe { (*self.ptr.as_ptr()).nr_to_scan as usize }
> > > > +    }
> > > > +
> > > > +    /// The callback should set this value to the number of object=
s processed.
> > > > +    pub fn set_nr_scanned(&mut self, val: usize) {
> > > > +        let mut val =3D val as c_ulong;
> > > > +        // SAFETY: Okay by type invariants.
> > > > +        let max =3D unsafe { (*self.ptr.as_ptr()).nr_to_scan };
> > > > +        if val > max {
> > > > +            val =3D max;
> > > > +        }
> > >
> > > No. Shrinkers are allowed to scan more objects in a batch than
> > > the high level code asked them to scan. If they do this, they
> > > *must* report back the count of all the objects they scanned so the
> > > batched scan accounting can adjust the remaining amount of work that
> > > needs to be done appropriately.
> >
> > Acknowledged.
> >
> > This is related to another question that I had, actually. Other than
> > returning SHRINK_STOP, in what situations should `nr_scanned` be
> > different from the return value of `scan_objects`?
>
> nr_scanned will almost always be different to the return value of
> ->scan_objects.
>
> There are 3 values of note here.
>
> - nr_scanned is set by the shrinker scan setup code to the batch
>   size the shrinker should scan in it's next invocation.
>
>   If the shrinker ignores nr_to_scan batch limits, it can indicate
>   how many objects it scanned by setting the number it scanned to
>   nr_scanned before it returns.
>
> - nr_to_scan is set to nr_scanned at setup.
>
>   The shrinker should then decrement nr_scanned for each object that
>   is scanned by the shrinker.  The shrinker should stop scanning and
>   return nr_freed when nr_to_scan reaches zero.
>
>   If the value of this is non-zero when the scan returns, it is an
>   indication that the shrinker either did not scan the entire
>   batch or the batch size was larger than the remaining number of
>   objects in the cache.
>
> - nr_freed: return value from the shrinker
>
>   This is a count of the number of objects the shrinker freed during
>   the scan.
>
>   If the shrinker cannot make progress for any reason it
>   should immediately return SHRINK_STOP.
>
> So on a typical shrinker pass, we'll exit with:
>
>         nr_scanned =3D batch size;
>         nr_to_scan =3D 0;
>         nr_freed =3D [0..batch size];
>
> Some shrinkers, however, have variable sized objects, and so they
> will normalise nr_freed and nr_scanned to the object size. The
> i915/gem shrinker does this, as it considers a page to be an object,
> but in reality is has a smaller number of variable sized multi-page
> objects being tracked. Hence it might be asked to scan 128 objects
> (default batch size), but the scan iterated over objects that
> contain 256 pages.
>
> In that case, it will return:
>
>         nr_scanned =3D 256;
>         nr_to_scan =3D 0;
>         nr_freed =3D [0..256]
>
> And the high level shrinker code will treat that as having scanned
> 256 objects rather than the 128 objects it asked for.
>
> There are several shrinkers that play weird accounting games like
> this. It's not really all that nice and it would be ice to clean all
> this up, but there's been no real urgency to do this because it's
> just a slightly different manner of accounting reclaim progress....

Ahh ... so the numbers can be different if you scan an object without
freeing it.

Alice

