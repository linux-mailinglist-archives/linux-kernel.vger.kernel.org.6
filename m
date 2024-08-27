Return-Path: <linux-kernel+bounces-303980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 218F29617E2
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 21:17:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9884E1F248F6
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 19:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8A881D3191;
	Tue, 27 Aug 2024 19:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CYYKf/7x"
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B235C1D172A;
	Tue, 27 Aug 2024 19:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724786264; cv=none; b=TwxQCpb+wnZ/YEbWdDVT3O2TupjjUeg1FXmMdhLceVm76vwNkxoewGKF8pxvk9PtbNgG8+CSjdnydwzxv6MQlbvUj1Qo4y8k+eVTYTqZYY3dFBfbjdfMz8j6FBNkLUdN61PjgV4GD/pODlWvmpQ7DRHxWs39K8mDZXpvb4kbT4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724786264; c=relaxed/simple;
	bh=pdtJtYcljDGIj8IElyC0oJM003X0EzKcuKt0WmW2UB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fim3s6+vEyAQpeQ1sxulrYtcpNsigG/WavGONeakU31pJCnqGUeleInyAjKeA3OWXtVfZjle0GRFxD1jSVnqRmzO64KTih58wHrVorwc2a5XqYGldPi875vTJu6DIR8vTRq9RyA7yG3yuqP9XGrzOSsseCXb92HJ62BWB+a6c3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CYYKf/7x; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6bd6f2c9d52so30827186d6.3;
        Tue, 27 Aug 2024 12:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724786261; x=1725391061; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YtFcWiFabVE+TEGEk7y46bKWyNtZQWsWB7C5BT2PA/c=;
        b=CYYKf/7xTnoDYZllfnP/CA24QBVsUSAxjOuxkwr0A60MOnTAoQYf2mZH0pcV8zltS/
         OAcSDrEu8T/0xhSg0gwsdsRxjgpJGaqs7ZLvrLx08xq//9VdYHiXH2pMW9Q2wIG060iV
         db/2L+9hQo6ojltJU2jcZzCxh+aMW1h77WcxK8YjcrNzbb5qGn4MlIZZKuBwCOwc2L72
         rpKAmFZIDP+g4jPuZQ2z83fcBsaHOu0IIHrWMQH7tbb2fZVwLA6wK+2jGVU+keQyanVA
         sOaVbYkRPfiuvfAfFbq2gM3c0XHO8Sx1wsM+z7EmFj0VrpUunfE5drQGSrKSLmMzeTWY
         H0sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724786261; x=1725391061;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YtFcWiFabVE+TEGEk7y46bKWyNtZQWsWB7C5BT2PA/c=;
        b=usVLH5twCpJAiQUdpqYpSxt/mvEitgBN8+RqliLyGRYdw8T7c34vw+SwxgccYbjsvV
         C+9+0QDk6szedUvV+KlDNc4cu/BBSNiuW+FqY7vx0kJq2S3Qt9lJizc34gjC9JdCvVzb
         nj96SZTlTZcDrNDys8hEKTeMMWTSnPvkywf5C90W6y0usMuCSATDI4Q9aBLZsQBIpsuS
         2zeKvINg5kUVXRZTKXuGhjuDxZS/BNVNZR1TamAg6FEDI7ixE0l4rSYjgBgSLC8gXRqa
         8uO1mFxILZuKkPRMXXC+t3gtpq8ZyFL23WPwao5WOACcLL5pVObzXURVE19jvipCg+Un
         7NBg==
X-Forwarded-Encrypted: i=1; AJvYcCVT4F6FKXO5xTatEpRlPdtMjgwS2xpLDT5YclJoV88Rs7l/ZkjDOJbBoEr1FiD3g1nb+JGUPc/8soarZkKgHCg=@vger.kernel.org, AJvYcCWmbb9xKuIGxPr0rWYH5sgB5W/gxM3d7k9qdylJYn3Q0jOt/EZnDANRxH8Roku+Kge6qtfpSRmh3H1KDEs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxbpFavYkG07aajJK96OcAqqC+Hu7AqjsKhq1NCF8TN2NPo3Tb
	XMyDjRB+o7v/33MrgL4H+uvqLcftm8JFuUYdProtbszWagUr9aVq
X-Google-Smtp-Source: AGHT+IHljUkXfiqmQvnos9EPS/iO6ae2Q7hAsy57vVzJjX3TGKTCl9MUWNi2m2Zj+jSIKpDNBGIqKw==
X-Received: by 2002:a0c:ea8d:0:b0:6c1:6ec9:605d with SMTP id 6a1803df08f44-6c16ec96164mr126616466d6.15.1724786261293;
        Tue, 27 Aug 2024 12:17:41 -0700 (PDT)
Received: from fauth2-smtp.messagingengine.com (fauth2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c162d29000sm59019426d6.10.2024.08.27.12.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 12:17:40 -0700 (PDT)
Received: from phl-compute-02.internal (phl-compute-02.nyi.internal [10.202.2.42])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 2A9AE1200043;
	Tue, 27 Aug 2024 15:17:40 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 27 Aug 2024 15:17:40 -0400
X-ME-Sender: <xms:VCbOZpfUWZvGUpQ1uOHN4ng1EDZFVFANR6npO1fMHS9mYnsPjTD7Tg>
    <xme:VCbOZnNKaQ-8LzPUmx-jhSDaIhTx3X1AeWessZ_0c4AutYdPsyq8KorrC-EeHlA7_
    CTKh9WhzUyXH-s-RA>
X-ME-Received: <xmr:VCbOZihdHHxiSVa7JNvmhViFUGyWY2bdLT1u_1UegH7YCxobo3zTN8_AvoBCCQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudeftddgudefgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilh
    drtghomheqnecuggftrfgrthhtvghrnhephfetvdfgtdeukedvkeeiteeiteejieehvdet
    heduudejvdektdekfeegvddvhedtnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhn
    odhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejje
    ekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhn
    rghmvgdpnhgspghrtghpthhtohepvdehpdhmohguvgepshhmthhpohhuthdprhgtphhtth
    hopegurghkrheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepohhjvggurgeskhgvrhhn
    vghlrdhorhhgpdhrtghpthhtoheprghlvgigrdhgrgihnhhorhesghhmrghilhdrtghomh
    dprhgtphhtthhopeifvggushhonhgrfhesghhmrghilhdrtghomhdprhgtphhtthhopehg
    rghrhiesghgrrhihghhuohdrnhgvthdprhgtphhtthhopegsjhhorhhnfegpghhhsehprh
    hothhonhhmrghilhdrtghomhdprhgtphhtthhopegsvghnnhhordhlohhsshhinhesphhr
    ohhtohhnrdhmvgdprhgtphhtthhopegrrdhhihhnuggsohhrghesshgrmhhsuhhnghdrtg
    homhdprhgtphhtthhopegrlhhitggvrhihhhhlsehgohhoghhlvgdrtghomh
X-ME-Proxy: <xmx:VCbOZi8GiSkGJAtdsFQgjrFYO5dlxyzgoG-LQXwFRrTbDf132XR5bw>
    <xmx:VCbOZlugfXwidqb0gm-fET3MZFK-ApX5AKwjrkASUkbH9zk4wiAsCg>
    <xmx:VCbOZhGlWR7ddZebimzsfc0rc4BNcQK9bTe-mZ-kH0cpUqzsmbQJTg>
    <xmx:VCbOZsMfwtJmCw1kmR_Dd753dKhrVxouWIsfAzJIvf7yVtS5aO6flQ>
    <xmx:VCbOZuOEpY9zEJdYasyS9HrClzKLhRiX8JFhNDS8bIDzPpH-HlLAJbRI>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Aug 2024 15:17:39 -0400 (EDT)
Date: Tue, 27 Aug 2024 12:17:15 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@samsung.com, aliceryhl@google.com,
	akpm@linux-foundation.org, daniel.almeida@collabora.com,
	faith.ekstrand@collabora.com, boris.brezillon@collabora.com,
	lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com,
	cjia@nvidia.com, jhubbard@nvidia.com, airlied@redhat.com,
	ajanulgu@redhat.com, lyude@redhat.com, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v6 00/26] Generic `Allocator` support for Rust
Message-ID: <Zs4mO8Lzayru3JFm@boqun-archlinux>
References: <20240816001216.26575-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240816001216.26575-1-dakr@kernel.org>

On Fri, Aug 16, 2024 at 02:10:42AM +0200, Danilo Krummrich wrote:
> Hi,
> 
> This patch series adds generic kernel allocator support for Rust, which so far
> is limited to `kmalloc` allocations.
> 
> In order to abstain from (re-)adding unstable Rust features to the kernel, this
> patch series does not extend the `Allocator` trait from Rust's `alloc` crate,
> nor does it extend the `BoxExt` and `VecExt` extensions.
> 
> Instead, this series introduces a kernel specific `Allocator` trait, which is
> implemented by the `Kmalloc`, `Vmalloc` and `KVmalloc` allocators, also
> implemented in the context of this series.
> 
> As a consequence we need our own kernel `Box<T, A>` and `Vec<T, A>` types.
> Additionally, this series adds the following type aliases:
> 
> ```
> pub type KBox<T> = Box<T, Kmalloc>;
> pub type VBox<T> = Box<T, Vmalloc>;
> pub type KVBox<T> = Box<T, KVmalloc>;
> 
> 
> pub type KVec<T> = Vec<T, Kmalloc>;
> pub type VVec<T> = Vec<T, Vmalloc>;
> pub type KVVec<T> = Vec<T, KVmalloc>;
> ```
> 
> With that, we can start using the kernel `Box` and `Vec` types throughout the
> tree and remove the now obolete extensions `BoxExt` and `VecExt`.
> 
> For a final cleanup, this series removes the last minor dependencies to Rust's
> `alloc` crate and removes it from the entire kernel build.
> 
> The series ensures not to break the `rusttest` make target by implementing the
> `allocator_test` module providing a stub implementation for all kernel
> `Allocator`s.
> 
> This patch series passes all KUnit tests, including the ones added by this
> series. Additionally, the tests were run with `kmemleak` and `KASAN` enabled,
> without any issues.
> 
> This series is based on [1], which hit -mm/mm-unstable, and is also available
> in [2].
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/dakr/linux.git/log/?h=mm/krealloc
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/dakr/linux.git/log/?h=rust/mm
> 

Finally managed to apply this on rust-dev ;-) A few things I resolved,
JFYI:

*	Resolve the conflicts between patch 6 & 7 and the helper split,
	note that the vmalloc() helper temporarily lives in a file
	called `slab.c`.

*	Adjust patch 9 with the introduction of InPlaceInit::PinnedSelf,
	also drop the ForeignOwnable::borrow_mut() implemenation.

*	Resolve the conflict between patch 10 and the latest rbtree
	patchset (v12).

*	Adjust patch 11 with the introduction of
	InPlaceInit::PinnedSelf.

*	Resolve the conflicts between patch 25 and the helper split.

(very likely I could make mistakes during these conflict resolution,
just let me know)

I've put this on the rust-dev based on today's rust-next (+ your mm
changes) for testing, will continue to review the series, thanks!

Regards,
Boqun

> Changes in v6:
>  - rebase onto rust-dev
>  - keep compiler annotations for {k,v,kv}realloc()
>  - documentation changes suggested by Alice, Benno
>  - remove `Box::into_pin`
>  - fix typo in `Send` and `Sync` for `Box` and `Vec`
>  - `kvec!` changes suggested by Alice
>  - free `src` after copy in `Cmalloc`
>  - handle `n == 0` in `Vec::extend_with`
> 
> Changes in v5:
>  - (safety) comment / documentation fixes suggested by Alice, Benno and Gary
>  - remove `Unique<T>` and implement `Send` and `Sync` for `Box` and `Vec`
>  - use `KMALLOC_MAX_SIZE` for `KVmalloc` test and add a `Kmalloc` test that
>    expects to fail for `KMALLOC_MAX_SIZE`
>  - create use constants `KREALLOC`, `VREALLOC` and `KVREALLOC` for
>    `ReallocFuncs`
>  - drop `Box::drop_contents` for now, will add it again, once I actually rebase
>    on the original patch that introduces it
>  - improve usage of `size_of_val` in `Box`
>  - move `InPlaceInit` and `ForeignOwnable` impls into kbox.rs
>  - fix missing `Box` conversions in rnull.rs
>  - reworked `Cmalloc` to keep track of the size of memory allocations itself
>  - remove `GlobalAlloc` together with the `alloc` crate to avoid a linker error
>  - remove `alloc` from scripts/generate_rust_analyzer.py
> 
> Changes in v4:
>  - (safety) comment fixes suggested by Alice and Boqun
>  - remove `Box::from_raw_alloc` and `Box::into_raw_alloc`, we don't need them
>  - in `Box::drop` call `size_of_val` before `drop_in_place`
>  - implement ForeignOwnable for Pin<Box<T>> as suggested by Alice
>  - in `Vec::extend_with`, iterate over `n` instead of `spare.len()`
>  - for `Vmalloc` and `KVmalloc` fail allocation for alignments larger than
>    PAGE_SIZE for now (will add support for larger alignments in a separate
>    series)
>  - implement `Cmalloc` in `allocator_test` and type alias all kernel allocator
>    types to it, such that we can use the kernel's `Box` and `Vec` types in
>    userspace tests (rusttest)
>    - this makes patch "rust: str: test: replace `alloc::format`" rather trivial
> 
> Changes in v3:
>  - Box:
>    - minor documentation fixes
>    - removed unnecessary imports in doc tests
>    - dropeed `self` argument from some remaining `Box` methods
>    - implement `InPlaceInit` for Box<T, A> rather than specifically for `KBox<T>`
>  - Vec:
>    - minor documentation fixes
>    - removed useless `Vec::allocator` method
>    - in `Vec::extend_with` use `Vec::spare_capacity_mut` instead of raw pointer operations
>    - added a few missing safety comments
>    - pass GFP flags to `Vec::collect`
>  - fixed a rustdoc warning in alloc.rs
>  - fixed the allocator_test module to implement the `Allocator` trait correctly
>  - rebased to rust-next
> 
> Changes in v2:
>   - preserve `impl GlobalAlloc for Kmalloc` and remove it at the end (Benno)
>   - remove `&self` parameter from all `Allocator` functions (Benno)
>   - various documentation fixes for `Allocator` (Benno)
>   - use `NonNull<u8>` for `Allocator::free` and `Option<NonNull<u8>>` for
>     `Allocator::realloc` (Benno)
>   - fix leak of `IntoIter` in `Vec::collect` (Boqun)
>   - always realloc (try to shrink) in `Vec::collect`, it's up the the
>     `Allocator` to provide a heuristic whether it makes sense to actually shrink
>   - rename `KBox<T, A>` -> `Box<T, A>` and `KVec<T, A>` -> `Vec<T, A>` and
>     provide type aliases `KBox<T>`, `VBox<T>`, `KVBox<T>`, etc.
>     - This allows for much cleaner code and, in combination with removing
>       `&self` parameters from `Allocator`s, gets us rid of the need for
>       `Box::new` and `Box::new_alloc` and all other "_alloc" postfixed
>       functions.
>     - Before: `KBox::new_alloc(foo, Vmalloc)?`
>     - After:  `VBox::new(foo)?`, which resolves to
>               `Box::<Foo,  Vmalloc>::new(foo)?;
> 
> 
> Danilo Krummrich (26):
>   rust: alloc: add `Allocator` trait
>   rust: alloc: separate `aligned_size` from `krealloc_aligned`
>   rust: alloc: rename `KernelAllocator` to `Kmalloc`
>   rust: alloc: implement `Allocator` for `Kmalloc`
>   rust: alloc: add module `allocator_test`
>   rust: alloc: implement `Vmalloc` allocator
>   rust: alloc: implement `KVmalloc` allocator
>   rust: alloc: add __GFP_NOWARN to `Flags`
>   rust: alloc: implement kernel `Box`
>   rust: treewide: switch to our kernel `Box` type
>   rust: alloc: remove `BoxExt` extension
>   rust: alloc: add `Box` to prelude
>   rust: alloc: implement kernel `Vec` type
>   rust: alloc: implement `IntoIterator` for `Vec`
>   rust: alloc: implement `collect` for `IntoIter`
>   rust: treewide: switch to the kernel `Vec` type
>   rust: alloc: remove `VecExt` extension
>   rust: alloc: add `Vec` to prelude
>   rust: error: use `core::alloc::LayoutError`
>   rust: error: check for config `test` in `Error::name`
>   rust: alloc: implement `contains` for `Flags`
>   rust: alloc: implement `Cmalloc` in module allocator_test
>   rust: str: test: replace `alloc::format`
>   rust: alloc: update module comment of alloc.rs
>   kbuild: rust: remove the `alloc` crate and `GlobalAlloc`
>   MAINTAINERS: add entry for the Rust `alloc` module
> 
>  MAINTAINERS                         |   7 +
>  drivers/block/rnull.rs              |   4 +-
>  rust/Makefile                       |  44 +-
>  rust/bindings/bindings_helper.h     |   1 +
>  rust/exports.c                      |   1 -
>  rust/helpers.c                      |  15 +
>  rust/kernel/alloc.rs                | 142 ++++-
>  rust/kernel/alloc/allocator.rs      | 173 ++++--
>  rust/kernel/alloc/allocator_test.rs | 185 ++++++
>  rust/kernel/alloc/box_ext.rs        |  80 ---
>  rust/kernel/alloc/kbox.rs           | 480 +++++++++++++++
>  rust/kernel/alloc/kvec.rs           | 891 ++++++++++++++++++++++++++++
>  rust/kernel/alloc/vec_ext.rs        | 185 ------
>  rust/kernel/error.rs                |   6 +-
>  rust/kernel/init.rs                 |  93 +--
>  rust/kernel/init/__internal.rs      |   2 +-
>  rust/kernel/lib.rs                  |   1 -
>  rust/kernel/prelude.rs              |   5 +-
>  rust/kernel/rbtree.rs               |  34 +-
>  rust/kernel/str.rs                  |  35 +-
>  rust/kernel/sync/arc.rs             |  17 +-
>  rust/kernel/sync/condvar.rs         |   4 +-
>  rust/kernel/sync/lock/mutex.rs      |   2 +-
>  rust/kernel/sync/lock/spinlock.rs   |   2 +-
>  rust/kernel/sync/locked_by.rs       |   2 +-
>  rust/kernel/types.rs                |  30 +-
>  rust/kernel/uaccess.rs              |  17 +-
>  rust/kernel/workqueue.rs            |  20 +-
>  rust/macros/lib.rs                  |  12 +-
>  samples/rust/rust_minimal.rs        |   4 +-
>  scripts/Makefile.build              |   7 +-
>  scripts/generate_rust_analyzer.py   |  11 +-
>  32 files changed, 1973 insertions(+), 539 deletions(-)
>  create mode 100644 rust/kernel/alloc/allocator_test.rs
>  delete mode 100644 rust/kernel/alloc/box_ext.rs
>  create mode 100644 rust/kernel/alloc/kbox.rs
>  create mode 100644 rust/kernel/alloc/kvec.rs
>  delete mode 100644 rust/kernel/alloc/vec_ext.rs
> 
> 
> base-commit: f005c686d6c1a2e66f2f9d21179d6b6bd45b20e2
> -- 
> 2.46.0
> 

