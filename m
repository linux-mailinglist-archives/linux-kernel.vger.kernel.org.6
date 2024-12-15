Return-Path: <linux-kernel+bounces-446551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D8BC9F2604
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 21:18:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35D191646F3
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 20:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E34A1BC08B;
	Sun, 15 Dec 2024 20:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fOQCIK1X"
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86BF189905;
	Sun, 15 Dec 2024 20:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734293877; cv=none; b=UCKhAESEowRrrCWlT1Ht/2Qvem4INq/0eYokonPx9TE5MUfrUbsfN6UkO3ymJR2cZ9j658V8bH91afah3zdyW+KXCWwtgiQ/lyXCuwt3U54CLiysUI9usg7U3t7ZzzATnLZkmqlm6Lv49vgulnEvvHPUKuzVbeH/xPJoARUOpLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734293877; c=relaxed/simple;
	bh=Fy9B0AEG3flGCVswO76R2mq6DS1CYSTqSpVqCHtWa2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H5XVIqINKK3YwNxhgH1Za/lrxt7PX/OfYL/ma2XURrh64jwxvUoi65Mvz0zCa+rqN1/K0xPXp8xgLAWagS5z7eJzu60+MaLJcYiqyaqOcCTBDLqDY5ceF348QXVJJRbEskrR0feQBN+qmiQzhXWmpZZcndk1RTnotqYDxqFA+JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fOQCIK1X; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6d89a727a19so43075316d6.0;
        Sun, 15 Dec 2024 12:17:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734293875; x=1734898675; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hUjPRb60UOKxlJX9P7WCdKWYJ4xgoEt+z+ky4eQN6ys=;
        b=fOQCIK1XhzoLHMslc9rdyUT/fkTg7kh70Ds1/Dej+BRpnV7XLam8fbxgcBzRd+rXRN
         3baxRUoUqT09BWkpqlo20ByBv5uQ9MO6JlajOO0PIh+wmNVNAiNDLQ1YkwnaQxN5NH+E
         Ev7cCECverQrbRJKeRSubnJi+1uZeoLL6qTm+lJPZrWKN8wmCMfDqPJMQZOTkUHpSbya
         n2Ejosek2rS+O0VfB2hFQX3vGY6Ga076gFaxCub4QaO4cOgSxpto6sFURZcaK+zd/grY
         ZX4LXZ+wiYTvcMnnQmqEGaEsqCxwNggzlMKWQicWINVc2QKizsKNCQeH4QbpwjIfH2tf
         NBcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734293875; x=1734898675;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hUjPRb60UOKxlJX9P7WCdKWYJ4xgoEt+z+ky4eQN6ys=;
        b=oddNGD0mESah0BWJY1J9c+W0xBx3zC2+3+rIU4C7pwvUAze7/hoxBMj0s5H6sEj4/A
         WaP7BRWkBPkIn9Ya1tH5uE8iMpZ2CNV81+sEiZn/ICjqzDmyThEZ3EFuer4PZ9hYYdAN
         L6Jy3qjHdBj/MX+bdv3DsjkAeoVj/p/cUSKGF8d2i3r9R9evo/1QxrTLBnZOndMpa3Oj
         wWvD49q+zgSd1ktJzi0phr0acIDWYyhT1vBvCR/CsnINkw94vOPxyWtmpH8NINM3Plda
         ReBQIzZ6Ggcvf21rJMuSSjJMKXVfWMaEagVLDCbVjwbUkdAK5tkBdc0mv0HGuUGDex3e
         KIVw==
X-Forwarded-Encrypted: i=1; AJvYcCUYu5bZjplreUSFB2i8avPixX2CmHSjRbC/bQz9riMjsS2TT6BWXbzG8Cyigxva+vcpx3D+U7BiFoJ5LoM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfO9wcW5QE4D9E2TMVVtoYmGdbSZGLQHBKQwtwoLyjGxLVjdEi
	JXeHgg23IsS/FiqJ/1EFOEBPpPVWjq7z4dDUIT9zeLA5lRpmhcNC
X-Gm-Gg: ASbGncsc4mbGrztIsvzyt3IG0Plj84oPdguCeNcE1upGMEyZRNcghqpTgHjtJcpWXFP
	BwP/0Le/izIsHZvrnGfhHbHwfBRgC9ztObA+pm5sD2H1MClxzpsf/X76NvFJn5oYJauSRys6CQF
	bJU9tQ33KsQrOwOFamVxCVfIYEOdO6b9yki5WMfCYSORczl1GNhkbCVhxAbZpxpnEW6eo9qZLMM
	P2ixKh2qRgr9PVu786Xp6Xe9ktgCscbLVUh6tJ6XC8sjVS2JxXiFmyin95DkL7vj+Hk92Xdq0yt
	1H+PTOmVAD+oXhjgqCJ6uC6FeHmyliCvNPs61EmZGxF9Xtw=
X-Google-Smtp-Source: AGHT+IGbQaAYFhipq5CQQ9enZUKb31QAAvTuw/+A5sSzSL6nm215jJD1+TsAczrxWGkhk6mPogx8CQ==
X-Received: by 2002:a05:6214:c6e:b0:6d8:8f81:e2ec with SMTP id 6a1803df08f44-6db0f3f3340mr221717366d6.12.1734293874587;
        Sun, 15 Dec 2024 12:17:54 -0800 (PST)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dccd38061csm19654496d6.109.2024.12.15.12.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2024 12:17:54 -0800 (PST)
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfauth.phl.internal (Postfix) with ESMTP id 6E6C61200043;
	Sun, 15 Dec 2024 15:17:53 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Sun, 15 Dec 2024 15:17:53 -0500
X-ME-Sender: <xms:cTlfZ6V1wy6Bkt2x6YYT_T0-PIOXxGM8yHqT6cLCRCqUDKJMudetQg>
    <xme:cTlfZ2lx_VabS6BP76DYPywnuybMqqlH2WHju0UYcWf3_ibRyQdWMKIEuwst6yF40
    j2-iTFlz1MBdjtSUw>
X-ME-Received: <xmr:cTlfZ-b3-U8vEv0_600j84ov68r2ZQaMvPzCg1hvlwBFrCDqpJRVd8z3B7wp>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrledugddufeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrd
    gtohhmqeenucggtffrrghtthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleei
    vedtgeeuhfegueevieduffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhi
    thihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmh
    grihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepudelpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehlhihuuggvsehrvgguhhgrthdrtghomhdprh
    gtphhtthhopehruhhsthdqfhhorhdqlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehojhgvuggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegr
    lhgvgidrghgrhihnohhrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghgrrhihsehgrg
    hrhihguhhordhnvghtpdhrtghpthhtohepsghjohhrnhefpghghhesphhrohhtohhnmhgr
    ihhlrdgtohhmpdhrtghpthhtohepsggvnhhnohdrlhhoshhsihhnsehprhhothhonhdrmh
    gvpdhrtghpthhtoheprgdrhhhinhgusghorhhgsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:cTlfZxWdEuMOjnkdS1eO4zco_19yfXZ07_FILURNrKIhSaQMqQt0Ug>
    <xmx:cTlfZ0mEralcf4ksbF6zNmCwkxPZiF9sEWQc3jMqS23A07Slz6Nf1Q>
    <xmx:cTlfZ2eF7eUMS6vZShYWt1oQmdFDeGJAzHA9RENMdFcnXIfy9_Xpcw>
    <xmx:cTlfZ2HojQu9Mty33fPqXKdiMgnX5v9OU04_SDz1526XiiOXYjaNkA>
    <xmx:cTlfZynkT8qtoavFuwRybwm1WEF57knzVQyO8IrDPDq_8X8_8xvpQm6T>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 15 Dec 2024 15:17:52 -0500 (EST)
Date: Sun, 15 Dec 2024 12:17:51 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Lyude Paul <lyude@redhat.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Dirk Behme <dirk.behme@de.bosch.com>,
	Tamir Duberstein <tamird@gmail.com>,
	Filipe Xavier <felipe_life@live.com>,
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
	Valentin Obst <kernel@valentinobst.de>,
	Wedson Almeida Filho <walmeida@microsoft.com>,
	Danilo Krummrich <dakr@kernel.org>
Subject: Re: [PATCH v2] rust: sync: Add lock::Backend::assert_is_held()
Message-ID: <Z185bwYfvVUJ2EXZ@tardis.local>
References: <20241125204139.656801-1-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241125204139.656801-1-lyude@redhat.com>

On Mon, Nov 25, 2024 at 03:40:58PM -0500, Lyude Paul wrote:
> Since we've exposed Lock::from_raw() and Guard::new() publically, we want
> to be able to make sure that we assert that a lock is actually held when
> constructing a Guard for it to handle instances of unsafe Guard::new()
> calls outside of our lock module.
> 
> So, let's do this by adding a new method assert_is_held to Backend, which
> uses lockdep to check whether or not a lock has been acquired. When lockdep
> is disabled, this has no overhead.
> 
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> 

Queued for more testing and reviews, thanks!

Regards,
Boqun

> ---
> 
> V2
> * Use lockdep instead of is_locked() functions
> * Drop is_locked, replace with assert_is_held()
> ---
>  rust/helpers/mutex.c              |  5 +++++
>  rust/helpers/spinlock.c           |  5 +++++
>  rust/kernel/sync/lock.rs          | 10 ++++++++++
>  rust/kernel/sync/lock/mutex.rs    |  7 +++++++
>  rust/kernel/sync/lock/spinlock.rs |  7 +++++++
>  5 files changed, 34 insertions(+)
> 
> diff --git a/rust/helpers/mutex.c b/rust/helpers/mutex.c
> index 7e00680958ef1..06575553eda5c 100644
> --- a/rust/helpers/mutex.c
> +++ b/rust/helpers/mutex.c
> @@ -12,3 +12,8 @@ void rust_helper___mutex_init(struct mutex *mutex, const char *name,
>  {
>  	__mutex_init(mutex, name, key);
>  }
> +
> +void rust_helper_mutex_assert_is_held(struct mutex *mutex)
> +{
> +	lockdep_assert_held(mutex);
> +}
> diff --git a/rust/helpers/spinlock.c b/rust/helpers/spinlock.c
> index b7b0945e8b3cb..b26953d0d65b5 100644
> --- a/rust/helpers/spinlock.c
> +++ b/rust/helpers/spinlock.c
> @@ -26,3 +26,8 @@ int rust_helper_spin_trylock(spinlock_t *lock)
>  {
>  	return spin_trylock(lock);
>  }
> +
> +void rust_helper_spin_assert_is_held(spinlock_t *lock)
> +{
> +	lockdep_assert_held(lock);
> +}
> diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
> index 6d3c8874eb26a..bc71fda87b104 100644
> --- a/rust/kernel/sync/lock.rs
> +++ b/rust/kernel/sync/lock.rs
> @@ -85,6 +85,13 @@ unsafe fn relock(ptr: *mut Self::State, guard_state: &mut Self::GuardState) {
>          // SAFETY: The safety requirements ensure that the lock is initialised.
>          *guard_state = unsafe { Self::lock(ptr) };
>      }
> +
> +    /// Asserts that the lock is held using lockdep.
> +    ///
> +    /// # Safety
> +    ///
> +    /// Callers must ensure that [`Backend::init`] has been previously called.
> +    unsafe fn assert_is_held(ptr: *mut Self::State);
>  }
>  
>  /// A mutual exclusion primitive.
> @@ -207,6 +214,9 @@ impl<'a, T: ?Sized, B: Backend> Guard<'a, T, B> {
>      ///
>      /// The caller must ensure that it owns the lock.
>      pub(crate) unsafe fn new(lock: &'a Lock<T, B>, state: B::GuardState) -> Self {
> +        // SAFETY: The caller can only hold the lock if `Backend::init` has already been called.
> +        unsafe { B::assert_is_held(lock.state.get()) };
> +
>          Self {
>              lock,
>              state,
> diff --git a/rust/kernel/sync/lock/mutex.rs b/rust/kernel/sync/lock/mutex.rs
> index 0e946ebefce12..8ee079f6ae0ac 100644
> --- a/rust/kernel/sync/lock/mutex.rs
> +++ b/rust/kernel/sync/lock/mutex.rs
> @@ -126,4 +126,11 @@ unsafe fn try_lock(ptr: *mut Self::State) -> Option<Self::GuardState> {
>              None
>          }
>      }
> +
> +    unsafe fn assert_is_held(ptr: *mut Self::State) {
> +        // SAFETY: The `ptr` pointer is guaranteed to be valid and initialized before use.
> +        unsafe {
> +            bindings::mutex_assert_is_held(ptr);
> +        }
> +    }
>  }
> diff --git a/rust/kernel/sync/lock/spinlock.rs b/rust/kernel/sync/lock/spinlock.rs
> index 9f4d128bed983..b2c1343aabee3 100644
> --- a/rust/kernel/sync/lock/spinlock.rs
> +++ b/rust/kernel/sync/lock/spinlock.rs
> @@ -125,4 +125,11 @@ unsafe fn try_lock(ptr: *mut Self::State) -> Option<Self::GuardState> {
>              None
>          }
>      }
> +
> +    unsafe fn assert_is_held(ptr: *mut Self::State) {
> +        // SAFETY: The `ptr` pointer is guaranteed to be valid and initialized before use.
> +        unsafe {
> +            bindings::spin_assert_is_held(ptr);
> +        }
> +    }
>  }
> 
> base-commit: b7ed2b6f4e8d7f64649795e76ee9db67300de8eb
> -- 
> 2.47.0
> 

