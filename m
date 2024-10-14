Return-Path: <linux-kernel+bounces-364320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19D8299D259
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 17:24:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D17E1C23C69
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 15:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CA461BE238;
	Mon, 14 Oct 2024 15:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CkQ6wuYj"
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0DEA1ABEC1;
	Mon, 14 Oct 2024 15:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728919396; cv=none; b=qzaf1zs0p5z03iZb/J5IQrN2vLzZcMN9VJ4U+eCXVSmS+yHiPo0cbgzGjVbnixAwUn9m+CwHnsWSlKyKM5C/XG4EwynRN8jdPDU8kMtQB7ch0KckHIhxY4BzwrZE0KJha15tZZQ2VIf9Ta6J18j9JTcbuU6K20FdL5jT7DAZNpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728919396; c=relaxed/simple;
	bh=HmG8gHpe7Pk7xmHCuSCkUVjnWYTusrP+og3EBTWVrDc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vCQiTixGx6RSDsVKyjgU9dd1GSygMAzPJQ3u0RUZTVga5lUoSmm2S6O1NWApyLgybLO3gmMcM6bs+4z4DMDdKBdiNndMGZJHiFO+AlpV1Z9OUzTSsq9jtfAOa6abjwhWErhN/cPAEMRG0AQjeB9HkwAdITVSf5VyroEeCUBv0dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CkQ6wuYj; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-716a5f33df3so2147212a34.3;
        Mon, 14 Oct 2024 08:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728919392; x=1729524192; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QZ1aKJWhOh7UyW1Fyw96UmLE5q8y4A4XXpM/oQ6mHx4=;
        b=CkQ6wuYji4asP3yad3HMgdjJ1pFccG5H8WOIx7nNECW9ibU+wzrNW5MrdfKOSoxy+x
         vYws/yltiJY27d5pZtlAHahe1ReLoyC4FQ9rznRRElJt+A3/QB7mSjoEIdhtcPVOn1Zo
         CVjTOIp6IUWrJg3WAAL4tehk99mnjCyiSVmAWXRnlHFnWtfef2jFO2hh85Ipt0Qz5wJl
         UvbtsZcZmBS9lzAJ+4S5BEBAkBAmIlf25/NFdQ/e5M9d2ZNRzpmzvGt9O30l/qSltvVH
         tZLRyoPeK4ebiD2TaAbTb6zd2PEk5DqgH9BRrM+hObB8hxvmk0LR8CsTuISW16lvOYBI
         OBRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728919392; x=1729524192;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QZ1aKJWhOh7UyW1Fyw96UmLE5q8y4A4XXpM/oQ6mHx4=;
        b=K/T/VaYatZqzJQ2cbbH7wEQ6DPBtJqhShQw9SnbNWHlThuAaIl9BiP3syXX0pxEa8Y
         HFtHWXumgsZfz9zE5r1RRgm7T/rrWKYcV+D/P+hZJc+4VLFIf9QuE4Jd4PiO9/hmGHlF
         2cTXUA/bNKLuUhO0Q0IzjZ9wpYtzE+rmyPVWBh9jc/nx1VYMhBCGCtlz9X6VI/1iUVq6
         QahZ33y0eHrehOmQNtbVVOyTnl8XZC64ypSO6z4jOmsgMnq/qPUvAiDvvY70+ZInoe0e
         wYqgboQb9BO6ZkBJYPGmAEURe54RtjsRWdvZEw9xGaAdrZ9OUYfQcVPVKDdUWXRTULFj
         Iq4w==
X-Forwarded-Encrypted: i=1; AJvYcCVVhFyfILGGiWw1vBs6WaKA/rK3PQ1Ep5so+UEuo2Kf1rdkdRMZ/KNeeSOtZXCYdVKOTlCsEkXLU/g6rts=@vger.kernel.org, AJvYcCVaK2G9eqkX3IXGwGY2PwgqiH0k30YXBh7Mhz275I8sip3uYXd8T8BTearFQ5mfv35yQU97Z5to4ufSDAC1DZs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi3PqGeMzr25zC4tnhBX30Yvl8NpKS8xffQp0t1uxOXdaSI/KR
	xGmePaD4VtXY1V/cv7bHyMC+KkwjjLp5EqpbHuA0DgmX3+kqJVx+
X-Google-Smtp-Source: AGHT+IElTnw6zB96cIaZtkJ6cn2gcUyHxWk53Y0bM7ceo6QJ+zsGDXKybR7R/Z/6vGIpvRHwR8ev6g==
X-Received: by 2002:a05:6358:716:b0:1b8:5022:327 with SMTP id e5c5f4694b2df-1c32bcacf4fmr231635055d.17.1728919392257;
        Mon, 14 Oct 2024 08:23:12 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b114958016sm429406685a.81.2024.10.14.08.23.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 08:23:11 -0700 (PDT)
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id C25931200043;
	Mon, 14 Oct 2024 11:23:10 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 14 Oct 2024 11:23:10 -0400
X-ME-Sender: <xms:XjcNZ2pneflrlZqkF8C2ftF2x1XWff4aKjrIfKx1smudk2mZvnjF9g>
    <xme:XjcNZ0pgSNU8MWgc1zonntGAkyb_0AJCbXebCfevYwV3wP9XTzPJ70IGlYQknDplA
    Bojr09GMq7e2SjSEQ>
X-ME-Received: <xmr:XjcNZ7PT6709U4P7YB_Sf7ZwGtVe2jnN1vFG18GS5fJijJdWTuVBiPQmIjI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeghedgkeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrd
    gtohhmqeenucggtffrrghtthgvrhhnpeehjeevveejtedtgfeuvdejfeehffetleehleev
    hfevieehjeekgeefgfeuleefieenucffohhmrghinheptggrshhtrdgrshenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghs
    mhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhe
    dvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvgdp
    nhgspghrtghpthhtohepvddtpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrlh
    hitggvrhihhhhlsehgohhoghhlvgdrtghomhdprhgtphhtthhopehojhgvuggrsehkvghr
    nhgvlhdrohhrghdprhgtphhtthhopeifihhllhihsehinhhfrhgruggvrggurdhorhhgpd
    hrtghpthhtoheplhhorhgvnhiiohdrshhtohgrkhgvshesohhrrggtlhgvrdgtohhmpdhr
    tghpthhtohepvhgsrggskhgrsehsuhhsvgdrtgiipdhrtghpthhtohepjhhhuhgssggrrh
    gusehnvhhiughirgdrtghomhdprhgtphhtthhopehlihgrmhdrhhhofihlvghtthesohhr
    rggtlhgvrdgtohhmpdhrtghpthhtoheprghkphhmsehlihhnuhigqdhfohhunhgurghtih
    honhdrohhrghdprhgtphhtthhopehgrhgvghhkhheslhhinhhugihfohhunhgurghtihho
    nhdrohhrgh
X-ME-Proxy: <xmx:XjcNZ15hg2VZbmhWjOpSiAwMjfPwUY4zJfPp6oPnqY15X8d9WjeuaQ>
    <xmx:XjcNZ16tVsWDHuRUV4tIqaAjErdm61FxkP3nhsnwPZIgZOJxixdAWA>
    <xmx:XjcNZ1jhOL3vUIUtW2SVY2Tyw6oY27Z0RI1d4puTDi6aNT3okMqpFg>
    <xmx:XjcNZ_6TaitigklriDYfMkdsCvcIRN_H1Ei_XGvE_1HWLCB3FX4SGw>
    <xmx:XjcNZwIEMPiDsmSIYiAYgCuhCisBfMCOgDGicRqtE7fgMH0PYyf2xy4o>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Oct 2024 11:23:10 -0400 (EDT)
Date: Mon, 14 Oct 2024 08:23:09 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Matthew Wilcox <willy@infradead.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	John Hubbard <jhubbard@nvidia.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>, Alex Gaynor <alex.gaynor@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, rust-for-linux@vger.kernel.org,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Wedson Almeida Filho <wedsonaf@gmail.com>
Subject: Re: [PATCH v7 1/2] rust: mm: add abstractions for mm_struct and
 vm_area_struct
Message-ID: <Zw03XWF2RBCM_A17@Boquns-Mac-mini.local>
References: <20241014-vma-v7-0-01e32f861195@google.com>
 <20241014-vma-v7-1-01e32f861195@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241014-vma-v7-1-01e32f861195@google.com>

On Mon, Oct 14, 2024 at 09:29:51AM +0000, Alice Ryhl wrote:
> These abstractions allow you to manipulate vmas. Rust Binder will uses
> these in a few different ways.
> 
> In the mmap implementation, a VmAreaNew will be provided to the mmap
> call which allows it to modify the vma in ways that are only okay during
> initial setup. This is the case where the most methods are available.
> 
> However, Rust Binder needs to insert and remove pages from the vma as
> time passes. When incoming messages arrive, pages may need to be
> inserted if space is missing, and in this case that is done by using a
> stashed ARef<Mm> and calling mmget_not_zero followed by mmap_write_lock
> followed by vma_lookup followed by vm_insert_page. In this case, since
> mmap_write_lock is used, the VmAreaMut type will be in use.
> 
> Another use-case is the shrinker, where the mmap read lock is taken
> instead, and zap_page_range_single is used to remove pages from the vma.
> In this case, only the read lock is taken, so the VmAreaRef type will be
> in use.
> 
> Future extensions could involve a VmAreaRcuRef for accessing vma methods
> that are okay to use when holding just the rcu read lock. However, these
> methods are not needed from Rust yet.
> 
> This uses shared references even for VmAreaMut. This is preferable to
> using pinned mutable references because those are pretty inconvenient
> due to the lack of reborrowing. However, this means that VmAreaMut
> cannot be Sync. I think it is an acceptable trade-off.
> 
> This patch is based on Wedson's implementation on the old rust branch,
> but has been changed significantly. All mistakes are Alice's.
> 
> Co-developed-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Besides the doc issues that Miguel found,

Reviewed-by: Boqun Feng <boqun.feng@gmail.com>

Also ping mm, I've tried to equip myself with some mm knowledge to
review the mm bits, and seems they all follow the same locking rules as
C side, but more eyes would be appreciated.

Regards,
Boqun

> ---
>  rust/helpers/helpers.c |   1 +
>  rust/helpers/mm.c      |  55 ++++++++
>  rust/kernel/lib.rs     |   1 +
>  rust/kernel/mm.rs      | 357 +++++++++++++++++++++++++++++++++++++++++++++++++
>  rust/kernel/mm/virt.rs | 264 ++++++++++++++++++++++++++++++++++++
>  5 files changed, 678 insertions(+)
> 
> diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
> index 30f40149f3a9..907ee77b3bb9 100644
> --- a/rust/helpers/helpers.c
> +++ b/rust/helpers/helpers.c
> @@ -13,6 +13,7 @@
>  #include "build_bug.c"
>  #include "err.c"
>  #include "kunit.c"
> +#include "mm.c"
>  #include "mutex.c"
>  #include "page.c"
>  #include "rbtree.c"
> diff --git a/rust/helpers/mm.c b/rust/helpers/mm.c
> new file mode 100644
> index 000000000000..0a2c2cc1903f
> --- /dev/null
> +++ b/rust/helpers/mm.c
> @@ -0,0 +1,55 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/mm.h>
> +#include <linux/sched/mm.h>
> +
> +void rust_helper_mmgrab(struct mm_struct *mm)
> +{
> +	mmgrab(mm);
> +}
> +
> +void rust_helper_mmdrop(struct mm_struct *mm)
> +{
> +	mmdrop(mm);
> +}
> +
> +void rust_helper_mmget(struct mm_struct *mm)
> +{
> +	mmget(mm);
> +}
> +
> +bool rust_helper_mmget_not_zero(struct mm_struct *mm)
> +{
> +	return mmget_not_zero(mm);
> +}
> +
> +void rust_helper_mmap_read_lock(struct mm_struct *mm)
> +{
> +	mmap_read_lock(mm);
> +}
> +
> +bool rust_helper_mmap_read_trylock(struct mm_struct *mm)
> +{
> +	return mmap_read_trylock(mm);
> +}
> +
> +void rust_helper_mmap_read_unlock(struct mm_struct *mm)
> +{
> +	mmap_read_unlock(mm);
> +}
> +
> +void rust_helper_mmap_write_lock(struct mm_struct *mm)
> +{
> +	mmap_write_lock(mm);
> +}
> +
> +void rust_helper_mmap_write_unlock(struct mm_struct *mm)
> +{
> +	mmap_write_unlock(mm);
> +}
> +
> +struct vm_area_struct *rust_helper_vma_lookup(struct mm_struct *mm,
> +					      unsigned long addr)
> +{
> +	return vma_lookup(mm, addr);
> +}
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index 8a228bcbbe85..6fa97e8866a9 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -40,6 +40,7 @@
>  pub mod kunit;
>  pub mod list;
>  pub mod miscdevice;
> +pub mod mm;
>  #[cfg(CONFIG_NET)]
>  pub mod net;
>  pub mod page;
> diff --git a/rust/kernel/mm.rs b/rust/kernel/mm.rs
> new file mode 100644
> index 000000000000..818ff2fd5265
> --- /dev/null
> +++ b/rust/kernel/mm.rs
> @@ -0,0 +1,357 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +// Copyright (C) 2024 Google LLC.
> +
> +//! Memory management.
> +//!
> +//! C header: [`include/linux/mm.h`](srctree/include/linux/mm.h)
> +
> +use crate::{
> +    bindings,
> +    types::{ARef, AlwaysRefCounted, NotThreadSafe, Opaque},
> +};
> +
> +use core::{
> +    ops::Deref,
> +    ptr::{self, NonNull},
> +};
> +
> +pub mod virt;
> +
> +/// A wrapper for the kernel's `struct mm_struct`.
> +///
> +/// Since `mm_users` may be zero, the associated address space may not exist anymore. You can use
> +/// [`mmget_not_zero`] to be able to access the address space.
> +///
> +/// The `ARef<Mm>` smart pointer holds an `mmgrab` refcount. Its destructor may sleep.
> +///
> +/// # Invariants
> +///
> +/// Values of this type are always refcounted using `mmgrab`.
> +///
> +/// [`mmget_not_zero`]: Mm::mmget_not_zero
> +pub struct Mm {
> +    mm: Opaque<bindings::mm_struct>,
> +}
> +
> +// SAFETY: It is safe to call `mmdrop` on another thread than where `mmgrab` was called.
> +unsafe impl Send for Mm {}
> +// SAFETY: All methods on `Mm` can be called in parallel from several threads.
> +unsafe impl Sync for Mm {}
> +
> +// SAFETY: By the type invariants, this type is always refcounted.
> +unsafe impl AlwaysRefCounted for Mm {
> +    fn inc_ref(&self) {
> +        // SAFETY: The pointer is valid since self is a reference.
> +        unsafe { bindings::mmgrab(self.as_raw()) };
> +    }
> +
> +    unsafe fn dec_ref(obj: NonNull<Self>) {
> +        // SAFETY: The caller is giving up their refcount.
> +        unsafe { bindings::mmdrop(obj.cast().as_ptr()) };
> +    }
> +}
> +
> +/// A wrapper for the kernel's `struct mm_struct`.
> +///
> +/// This type is like [`Mm`], but with non-zero `mm_users`. It can only be used when `mm_users` can
> +/// be proven to be non-zero at compile-time, usually because the relevant code holds an `mmget`
> +/// refcount. It can be used to access the associated address space.
> +///
> +/// The `ARef<MmWithUser>` smart pointer holds an `mmget` refcount. Its destructor may sleep.
> +///
> +/// # Invariants
> +///
> +/// Values of this type are always refcounted using `mmget`. The value of `mm_users` is non-zero.
> +/// #[repr(transparent)]
> +pub struct MmWithUser {
> +    mm: Mm,
> +}
> +
> +// SAFETY: It is safe to call `mmput` on another thread than where `mmget` was called.
> +unsafe impl Send for MmWithUser {}
> +// SAFETY: All methods on `MmWithUser` can be called in parallel from several threads.
> +unsafe impl Sync for MmWithUser {}
> +
> +// SAFETY: By the type invariants, this type is always refcounted.
> +unsafe impl AlwaysRefCounted for MmWithUser {
> +    fn inc_ref(&self) {
> +        // SAFETY: The pointer is valid since self is a reference.
> +        unsafe { bindings::mmget(self.as_raw()) };
> +    }
> +
> +    unsafe fn dec_ref(obj: NonNull<Self>) {
> +        // SAFETY: The caller is giving up their refcount.
> +        unsafe { bindings::mmput(obj.cast().as_ptr()) };
> +    }
> +}
> +
> +// Make all `Mm` methods available on `MmWithUser`.
> +impl Deref for MmWithUser {
> +    type Target = Mm;
> +
> +    #[inline]
> +    fn deref(&self) -> &Mm {
> +        &self.mm
> +    }
> +}
> +
> +/// A wrapper for the kernel's `struct mm_struct`.
> +///
> +/// This type is identical to `MmWithUser` except that it uses `mmput_async` when dropping a
> +/// refcount. This means that the destructor of `ARef<MmWithUserAsync>` is safe to call in atomic
> +/// context.
> +///
> +/// # Invariants
> +///
> +/// Values of this type are always refcounted using `mmget`. The value of `mm_users` is non-zero.
> +/// #[repr(transparent)]
> +#[repr(transparent)]
> +pub struct MmWithUserAsync {
> +    mm: MmWithUser,
> +}
> +
> +// SAFETY: It is safe to call `mmput_async` on another thread than where `mmget` was called.
> +unsafe impl Send for MmWithUserAsync {}
> +// SAFETY: All methods on `MmWithUserAsync` can be called in parallel from several threads.
> +unsafe impl Sync for MmWithUserAsync {}
> +
> +// SAFETY: By the type invariants, this type is always refcounted.
> +unsafe impl AlwaysRefCounted for MmWithUserAsync {
> +    fn inc_ref(&self) {
> +        // SAFETY: The pointer is valid since self is a reference.
> +        unsafe { bindings::mmget(self.as_raw()) };
> +    }
> +
> +    unsafe fn dec_ref(obj: NonNull<Self>) {
> +        // SAFETY: The caller is giving up their refcount.
> +        unsafe { bindings::mmput_async(obj.cast().as_ptr()) };
> +    }
> +}
> +
> +// Make all `MmWithUser` methods available on `MmWithUserAsync`.
> +impl Deref for MmWithUserAsync {
> +    type Target = MmWithUser;
> +
> +    #[inline]
> +    fn deref(&self) -> &MmWithUser {
> +        &self.mm
> +    }
> +}
> +
> +// These methods are safe to call even if `mm_users` is zero.
> +impl Mm {
> +    /// Call `mmgrab` on `current.mm`.
> +    #[inline]
> +    pub fn mmgrab_current() -> Option<ARef<Mm>> {
> +        // SAFETY: It's safe to get the `mm` field from current.
> +        let mm = unsafe {
> +            let current = bindings::get_current();
> +            (*current).mm
> +        };
> +
> +        if mm.is_null() {
> +            return None;
> +        }
> +
> +        // SAFETY: The value of `current->mm` is guaranteed to be null or a valid `mm_struct`. We
> +        // just checked that it's not null. Furthermore, the returned `&Mm` is valid only for the
> +        // duration of this function, and `current->mm` will stay valid for that long.
> +        let mm = unsafe { Mm::from_raw(mm) };
> +
> +        // This increments the refcount using `mmgrab`.
> +        Some(ARef::from(mm))
> +    }
> +
> +    /// Returns a raw pointer to the inner `mm_struct`.
> +    #[inline]
> +    pub fn as_raw(&self) -> *mut bindings::mm_struct {
> +        self.mm.get()
> +    }
> +
> +    /// Obtain a reference from a raw pointer.
> +    ///
> +    /// # Safety
> +    ///
> +    /// The caller must ensure that `ptr` points at an `mm_struct`, and that it is not deallocated
> +    /// during the lifetime 'a.
> +    #[inline]
> +    pub unsafe fn from_raw<'a>(ptr: *const bindings::mm_struct) -> &'a Mm {
> +        // SAFETY: Caller promises that the pointer is valid for 'a. Layouts are compatible due to
> +        // repr(transparent).
> +        unsafe { &*ptr.cast() }
> +    }
> +
> +    /// Check whether this vma is associated with this mm.
> +    #[inline]
> +    pub fn is_same_mm(&self, area: &virt::VmAreaRef) -> bool {
> +        // SAFETY: The `vm_mm` field of the area is immutable, so we can read it without
> +        // synchronization.
> +        let vm_mm = unsafe { (*area.as_ptr()).vm_mm };
> +
> +        ptr::eq(vm_mm, self.as_raw())
> +    }
> +
> +    /// Calls `mmget_not_zero` and returns a handle if it succeeds.
> +    #[inline]
> +    pub fn mmget_not_zero(&self) -> Option<ARef<MmWithUser>> {
> +        // SAFETY: The pointer is valid since self is a reference.
> +        let success = unsafe { bindings::mmget_not_zero(self.as_raw()) };
> +
> +        if success {
> +            // SAFETY: We just created an `mmget` refcount.
> +            Some(unsafe { ARef::from_raw(NonNull::new_unchecked(self.as_raw().cast())) })
> +        } else {
> +            None
> +        }
> +    }
> +}
> +
> +// These methods require `mm_users` to be non-zero.
> +impl MmWithUser {
> +    /// Obtain a reference from a raw pointer.
> +    ///
> +    /// # Safety
> +    ///
> +    /// The caller must ensure that `ptr` points at an `mm_struct`, and that `mm_users` remains
> +    /// non-zero for the duration of the lifetime 'a.
> +    #[inline]
> +    pub unsafe fn from_raw<'a>(ptr: *const bindings::mm_struct) -> &'a MmWithUser {
> +        // SAFETY: Caller promises that the pointer is valid for 'a. The layout is compatible due
> +        // to repr(transparent).
> +        unsafe { &*ptr.cast() }
> +    }
> +
> +    /// Use `mmput_async` when dropping this refcount.
> +    pub fn use_mmput_async(me: ARef<MmWithUser>) -> ARef<MmWithUserAsync> {
> +        // SAFETY: The layouts and invariants are compatible.
> +        unsafe { ARef::from_raw(ARef::into_raw(me).cast()) }
> +    }
> +
> +    /// Lock the mmap write lock.
> +    #[inline]
> +    pub fn mmap_write_lock(&self) -> MmapWriteGuard<'_> {
> +        // SAFETY: The pointer is valid since self is a reference.
> +        unsafe { bindings::mmap_write_lock(self.as_raw()) };
> +
> +        // INVARIANT: We just acquired the write lock.
> +        MmapWriteGuard {
> +            mm: self,
> +            _nts: NotThreadSafe,
> +        }
> +    }
> +
> +    /// Lock the mmap read lock.
> +    #[inline]
> +    pub fn mmap_read_lock(&self) -> MmapReadGuard<'_> {
> +        // SAFETY: The pointer is valid since self is a reference.
> +        unsafe { bindings::mmap_read_lock(self.as_raw()) };
> +
> +        // INVARIANT: We just acquired the read lock.
> +        MmapReadGuard {
> +            mm: self,
> +            _nts: NotThreadSafe,
> +        }
> +    }
> +
> +    /// Try to lock the mmap read lock.
> +    #[inline]
> +    pub fn mmap_read_trylock(&self) -> Option<MmapReadGuard<'_>> {
> +        // SAFETY: The pointer is valid since self is a reference.
> +        let success = unsafe { bindings::mmap_read_trylock(self.as_raw()) };
> +
> +        if success {
> +            // INVARIANT: We just acquired the read lock.
> +            Some(MmapReadGuard {
> +                mm: self,
> +                _nts: NotThreadSafe,
> +            })
> +        } else {
> +            None
> +        }
> +    }
> +}
> +
> +impl MmWithUserAsync {
> +    /// Use `mmput` when dropping this refcount.
> +    pub fn use_mmput(me: ARef<MmWithUserAsync>) -> ARef<MmWithUser> {
> +        // SAFETY: The layouts and invariants are compatible.
> +        unsafe { ARef::from_raw(ARef::into_raw(me).cast()) }
> +    }
> +}
> +
> +/// A guard for the mmap read lock.
> +///
> +/// # Invariants
> +///
> +/// This `MmapReadGuard` guard owns the mmap read lock.
> +pub struct MmapReadGuard<'a> {
> +    mm: &'a MmWithUser,
> +    // `mmap_read_lock` and `mmap_read_unlock` must be called on the same thread
> +    _nts: NotThreadSafe,
> +}
> +
> +impl<'a> MmapReadGuard<'a> {
> +    /// Look up a vma at the given address.
> +    #[inline]
> +    pub fn vma_lookup(&self, vma_addr: usize) -> Option<&virt::VmAreaRef> {
> +        // SAFETY: We hold a reference to the mm, so the pointer must be valid. Any value is okay
> +        // for `vma_addr`.
> +        let vma = unsafe { bindings::vma_lookup(self.mm.as_raw(), vma_addr as _) };
> +
> +        if vma.is_null() {
> +            None
> +        } else {
> +            // SAFETY: We just checked that a vma was found, so the pointer is valid. Furthermore,
> +            // the returned area will borrow from this read lock guard, so it can only be used
> +            // while the read lock is still held.
> +            unsafe { Some(virt::VmAreaRef::from_raw(vma)) }
> +        }
> +    }
> +}
> +
> +impl Drop for MmapReadGuard<'_> {
> +    #[inline]
> +    fn drop(&mut self) {
> +        // SAFETY: We hold the read lock by the type invariants.
> +        unsafe { bindings::mmap_read_unlock(self.mm.as_raw()) };
> +    }
> +}
> +
> +/// A guard for the mmap write lock.
> +///
> +/// # Invariants
> +///
> +/// This `MmapReadGuard` guard owns the mmap write lock.
> +pub struct MmapWriteGuard<'a> {
> +    mm: &'a MmWithUser,
> +    // `mmap_write_lock` and `mmap_write_unlock` must be called on the same thread
> +    _nts: NotThreadSafe,
> +}
> +
> +impl<'a> MmapWriteGuard<'a> {
> +    /// Look up a vma at the given address.
> +    #[inline]
> +    pub fn vma_lookup(&mut self, vma_addr: usize) -> Option<&virt::VmAreaMut> {
> +        // SAFETY: We hold a reference to the mm, so the pointer must be valid. Any value is okay
> +        // for `vma_addr`.
> +        let vma = unsafe { bindings::vma_lookup(self.mm.as_raw(), vma_addr as _) };
> +
> +        if vma.is_null() {
> +            None
> +        } else {
> +            // SAFETY: We just checked that a vma was found, so the pointer is valid. Furthermore,
> +            // the returned area will borrow from this write lock guard, so it can only be used
> +            // while the write lock is still held.
> +            unsafe { Some(virt::VmAreaMut::from_raw(vma)) }
> +        }
> +    }
> +}
> +
> +impl Drop for MmapWriteGuard<'_> {
> +    #[inline]
> +    fn drop(&mut self) {
> +        // SAFETY: We hold the write lock by the type invariants.
> +        unsafe { bindings::mmap_write_unlock(self.mm.as_raw()) };
> +    }
> +}
> diff --git a/rust/kernel/mm/virt.rs b/rust/kernel/mm/virt.rs
> new file mode 100644
> index 000000000000..7c09813e22f9
> --- /dev/null
> +++ b/rust/kernel/mm/virt.rs
> @@ -0,0 +1,264 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +// Copyright (C) 2024 Google LLC.
> +
> +//! Virtual memory.
> +
> +use crate::{
> +    bindings,
> +    error::{to_result, Result},
> +    page::Page,
> +    types::Opaque,
> +};
> +
> +use core::ops::Deref;
> +
> +/// A wrapper for the kernel's `struct vm_area_struct` with read access.
> +///
> +/// It represents an area of virtual memory.
> +///
> +/// # Invariants
> +///
> +/// The caller must at least hold the mmap read lock.
> +#[repr(transparent)]
> +pub struct VmAreaRef {
> +    vma: Opaque<bindings::vm_area_struct>,
> +}
> +
> +/// A wrapper for the kernel's `struct vm_area_struct` with write access.
> +///
> +/// It represents an area of virtual memory.
> +///
> +/// # Invariants
> +///
> +/// The caller must at least hold the mmap write lock.
> +#[repr(transparent)]
> +pub struct VmAreaMut {
> +    vma: Opaque<bindings::vm_area_struct>,
> +}
> +
> +/// A wrapper for the kernel's `struct vm_area_struct` during initial VMA setup.
> +///
> +/// It represents an area of virtual memory.
> +///
> +/// # Invariants
> +///
> +/// The caller must have mutable access and the vma must not have been shared yet.
> +#[repr(transparent)]
> +pub struct VmAreaNew {
> +    vma: Opaque<bindings::vm_area_struct>,
> +}
> +
> +// Make all VmAreaRef methods available on VmAreaMut.
> +impl Deref for VmAreaMut {
> +    type Target = VmAreaRef;
> +    #[inline]
> +    fn deref(&self) -> &VmAreaRef {
> +        // SAFETY: We hold at least the write lock, so we have read access.
> +        unsafe { VmAreaRef::from_raw(self.vma.get()) }
> +    }
> +}
> +
> +// Make all VmAreaMut methods available on VmAreaNew.
> +impl Deref for VmAreaNew {
> +    type Target = VmAreaMut;
> +    #[inline]
> +    fn deref(&self) -> &VmAreaMut {
> +        // SAFETY: The vma is not yet shared, so we have write access.
> +        unsafe { VmAreaMut::from_raw(self.vma.get()) }
> +    }
> +}
> +
> +impl VmAreaRef {
> +    /// Access a virtual memory area given a raw pointer.
> +    ///
> +    /// # Safety
> +    ///
> +    /// Callers must ensure that `vma` is valid for the duration of 'a, and that the mmap read lock
> +    /// (or stronger) is held for at least the duration of 'a.
> +    #[inline]
> +    pub unsafe fn from_raw<'a>(vma: *const bindings::vm_area_struct) -> &'a Self {
> +        // SAFETY: The caller ensures that the invariants are satisfied for the duration of 'a.
> +        unsafe { &*vma.cast() }
> +    }
> +
> +    /// Returns a raw pointer to this area.
> +    #[inline]
> +    pub fn as_ptr(&self) -> *mut bindings::vm_area_struct {
> +        self.vma.get()
> +    }
> +
> +    /// Returns the flags associated with the virtual memory area.
> +    ///
> +    /// The possible flags are a combination of the constants in [`flags`].
> +    #[inline]
> +    pub fn flags(&self) -> usize {
> +        // SAFETY: By the type invariants, the caller holds at least the mmap read lock, so this
> +        // access is not a data race.
> +        unsafe { (*self.as_ptr()).__bindgen_anon_2.vm_flags as _ }
> +    }
> +
> +    /// Returns the start address of the virtual memory area.
> +    #[inline]
> +    pub fn start(&self) -> usize {
> +        // SAFETY: By the type invariants, the caller holds at least the mmap read lock, so this
> +        // access is not a data race.
> +        unsafe { (*self.as_ptr()).__bindgen_anon_1.__bindgen_anon_1.vm_start as _ }
> +    }
> +
> +    /// Returns the end address of the virtual memory area.
> +    #[inline]
> +    pub fn end(&self) -> usize {
> +        // SAFETY: By the type invariants, the caller holds at least the mmap read lock, so this
> +        // access is not a data race.
> +        unsafe { (*self.as_ptr()).__bindgen_anon_1.__bindgen_anon_1.vm_end as _ }
> +    }
> +
> +    /// Unmap pages in the given page range.
> +    #[inline]
> +    pub fn zap_page_range_single(&self, address: usize, size: usize) {
> +        // SAFETY: By the type invariants, the caller holds at least the mmap read lock, so this
> +        // access is okay. Any value of `address` and `size` is allowed.
> +        unsafe {
> +            bindings::zap_page_range_single(
> +                self.as_ptr(),
> +                address as _,
> +                size as _,
> +                core::ptr::null_mut(),
> +            )
> +        };
> +    }
> +}
> +
> +impl VmAreaMut {
> +    /// Access a virtual memory area given a raw pointer.
> +    ///
> +    /// # Safety
> +    ///
> +    /// Callers must ensure that `vma` is valid for the duration of 'a, and that the mmap write lock
> +    /// (or stronger) is held for at least the duration of 'a.
> +    #[inline]
> +    pub unsafe fn from_raw<'a>(vma: *const bindings::vm_area_struct) -> &'a Self {
> +        // SAFETY: The caller ensures that the invariants are satisfied for the duration of 'a.
> +        unsafe { &*vma.cast() }
> +    }
> +
> +    /// Sets the flags associated with the virtual memory area.
> +    ///
> +    /// The possible flags are a combination of the constants in [`flags`].
> +    #[inline]
> +    pub fn set_flags(&self, flags: usize) {
> +        // SAFETY: By the type invariants, the caller holds the mmap write lock, so this access is
> +        // not a data race.
> +        unsafe { (*self.as_ptr()).__bindgen_anon_2.vm_flags = flags as _ };
> +    }
> +
> +    /// Maps a single page at the given address within the virtual memory area.
> +    ///
> +    /// This operation does not take ownership of the page.
> +    #[inline]
> +    pub fn vm_insert_page(&self, address: usize, page: &Page) -> Result {
> +        // SAFETY: By the type invariants, the caller holds the mmap write lock, so this access is
> +        // not a data race. The page is guaranteed to be valid and of order 0. The range of
> +        // `address` is already checked by `vm_insert_page`.
> +        to_result(unsafe { bindings::vm_insert_page(self.as_ptr(), address as _, page.as_ptr()) })
> +    }
> +}
> +
> +impl VmAreaNew {
> +    /// Access a virtual memory area given a raw pointer.
> +    ///
> +    /// # Safety
> +    ///
> +    /// Callers must ensure that `vma` is valid for the duration of 'a, and that the vma is
> +    /// currently undergoing initial VMA setup.
> +    #[inline]
> +    pub unsafe fn from_raw<'a>(vma: *const bindings::vm_area_struct) -> &'a Self {
> +        // SAFETY: The caller ensures that the invariants are satisfied for the duration of 'a.
> +        unsafe { &*vma.cast() }
> +    }
> +
> +    /// Make this vma anonymous.
> +    #[inline]
> +    pub fn set_anonymous(&self) {
> +        // SAFETY: The vma is not yet shared.
> +        unsafe { (*self.as_ptr()).vm_ops = core::ptr::null() };
> +    }
> +}
> +
> +/// Container for [`VmArea`] flags.
> +pub mod flags {
> +    use crate::bindings;
> +
> +    /// No flags are set.
> +    pub const NONE: usize = bindings::VM_NONE as _;
> +
> +    /// Mapping allows reads.
> +    pub const READ: usize = bindings::VM_READ as _;
> +
> +    /// Mapping allows writes.
> +    pub const WRITE: usize = bindings::VM_WRITE as _;
> +
> +    /// Mapping allows execution.
> +    pub const EXEC: usize = bindings::VM_EXEC as _;
> +
> +    /// Mapping is shared.
> +    pub const SHARED: usize = bindings::VM_SHARED as _;
> +
> +    /// Mapping may be updated to allow reads.
> +    pub const MAYREAD: usize = bindings::VM_MAYREAD as _;
> +
> +    /// Mapping may be updated to allow writes.
> +    pub const MAYWRITE: usize = bindings::VM_MAYWRITE as _;
> +
> +    /// Mapping may be updated to allow execution.
> +    pub const MAYEXEC: usize = bindings::VM_MAYEXEC as _;
> +
> +    /// Mapping may be updated to be shared.
> +    pub const MAYSHARE: usize = bindings::VM_MAYSHARE as _;
> +
> +    /// Do not copy this vma on fork.
> +    pub const DONTCOPY: usize = bindings::VM_DONTCOPY as _;
> +
> +    /// Cannot expand with mremap().
> +    pub const DONTEXPAND: usize = bindings::VM_DONTEXPAND as _;
> +
> +    /// Lock the pages covered when they are faulted in.
> +    pub const LOCKONFAULT: usize = bindings::VM_LOCKONFAULT as _;
> +
> +    /// Is a VM accounted object.
> +    pub const ACCOUNT: usize = bindings::VM_ACCOUNT as _;
> +
> +    /// should the VM suppress accounting.
> +    pub const NORESERVE: usize = bindings::VM_NORESERVE as _;
> +
> +    /// Huge TLB Page VM.
> +    pub const HUGETLB: usize = bindings::VM_HUGETLB as _;
> +
> +    /// Synchronous page faults.
> +    pub const SYNC: usize = bindings::VM_SYNC as _;
> +
> +    /// Architecture-specific flag.
> +    pub const ARCH_1: usize = bindings::VM_ARCH_1 as _;
> +
> +    /// Wipe VMA contents in child..
> +    pub const WIPEONFORK: usize = bindings::VM_WIPEONFORK as _;
> +
> +    /// Do not include in the core dump.
> +    pub const DONTDUMP: usize = bindings::VM_DONTDUMP as _;
> +
> +    /// Not soft dirty clean area.
> +    pub const SOFTDIRTY: usize = bindings::VM_SOFTDIRTY as _;
> +
> +    /// Can contain "struct page" and pure PFN pages.
> +    pub const MIXEDMAP: usize = bindings::VM_MIXEDMAP as _;
> +
> +    /// MADV_HUGEPAGE marked this vma.
> +    pub const HUGEPAGE: usize = bindings::VM_HUGEPAGE as _;
> +
> +    /// MADV_NOHUGEPAGE marked this vma.
> +    pub const NOHUGEPAGE: usize = bindings::VM_NOHUGEPAGE as _;
> +
> +    /// KSM may merge identical pages.
> +    pub const MERGEABLE: usize = bindings::VM_MERGEABLE as _;
> +}
> 
> -- 
> 2.47.0.rc1.288.g06298d1525-goog
> 

