Return-Path: <linux-kernel+bounces-362660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BD5499B7C8
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 02:16:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B59891C215E5
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 00:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41C0E256D;
	Sun, 13 Oct 2024 00:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vecw3J+j"
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B627F819;
	Sun, 13 Oct 2024 00:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728778589; cv=none; b=rMzdjgZGpCIzh24gFBToftj4SYBatkTQHP7LltYuRWvKnNxr8GixoI+IxPuKxl/Izq6a5whE2f5PUEkN78dkOdcGy9EoetpuelFwCiUNvZ5/OF543TgxAXgFuf380eDO98906v3Y+mcUh/wxukTDuu6JzyqUsVlbUwsKa5m0cAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728778589; c=relaxed/simple;
	bh=NO15kTVgW5jexH52mxSU5X3klaAoYYLEDVbX4gH/ExM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SvDOCHibo3W6/enP1lAzXEx8bLP7PxAQYLNMQk06ARVJ+K09bHUj8THAAHEdLFg2cJ260eEm76wh9TAV2GCWj7hMr5mmLsLXw3CfIRYeVPe1yojyM2mpjqydM3f+h1490qNbCyPAL1AD0MHoq76vs6TBsyXnq7K2bDVlPlhWGmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vecw3J+j; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4603aced3a5so26393581cf.1;
        Sat, 12 Oct 2024 17:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728778585; x=1729383385; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WRXk4qjuzQVRU2Px4UHPGrBV2OP5ZCUt6zYeuf1cJ+4=;
        b=Vecw3J+jsp9ClSaqXdKf8JVjWgZwUVH1d6Cq6vBw5W7CrWTHrzvBIiwAqbrollrZFH
         zoJ2HQ/sJEbxzIf5LDccPHWCm+a+wgtMoTo8bKNZB37bi2b423/jIoyfwfhC6FC2x1Qz
         8s9PsHjTblzfnHLq6CbxTsDrfF12Y2sJVmbwvD3CeDx1fpH+Wr3kMgsXQ2U0ewv2296E
         5jX4d/pZH4giYgdnxLAIDRNullZFFHLxq2WUMEAPkOTVdD25MH7fsfZNy/DMNf3NCBVk
         qab0Tul6G1suVTFv11kifhUTl7Z3LeDw41LaDepxZri8CPlSv9q1TwUY+QE6FkK93epk
         EPbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728778585; x=1729383385;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WRXk4qjuzQVRU2Px4UHPGrBV2OP5ZCUt6zYeuf1cJ+4=;
        b=Z8b4yz4MFdCeoFCK05662CcEn7h3Q0k3icHc3gp79oYhBvqgeVArUZHkClZBRZL1Ix
         k27JKyJc21/Y/GaLdJVP7Q0+9fEBt5j3pTpMf4GDG/h9DHYUpmEoiUxSyc2H7yT/jcN9
         YvVNFlowK66BIVdUE990D2KmedaE7vXGkUmZ7Y9lPHDtH+uFjdeYxMO90WsAdjxCoKuf
         krNPYS5eMKcbYiF9X7PdN51EwKj35FL/sYPmYLCNK7olWcqQRzJLtgvN/0KUhBoGSqIC
         Q6yongGx/M5Q3HIjTm5cwmni/4dHqZXNbUkFIg0TA7jerJQWEt+bmZYSurRK7Bkwdw7W
         edkQ==
X-Forwarded-Encrypted: i=1; AJvYcCWE1u38cH31iqpdf9grBrjaEztpM4bRArQUdfyHewiPcissxeOhUkqcZd8Eah8ZAv9AP22nUAP8wD/2I5k=@vger.kernel.org, AJvYcCXqkgPl2pm62tgNL7FLM3NI2wHo3KIhs9/LrlNYkYMmvg2mHPI6ZCsj+Nj4gqKr78CW4Qw6vsHDNmBQCUM7Ukg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyp9I5oMrQiDrvXBZ1RM1wn/W3vks8BZgD/N8dZKgKWFTlsWt8E
	hXx7WfBJ3wiFXfNj/hFv3lcy3/Z0zz7AZfbq6AfsMs0archnnHEL3ojCTg==
X-Google-Smtp-Source: AGHT+IHlSpzm7FldRFgxIk8xopMUMysZW366cMw8BFoAZ0h+HCHdzb2IkZ9abhMcZCJnr3hhtpL5qg==
X-Received: by 2002:ac8:5a83:0:b0:460:3a45:9460 with SMTP id d75a77b69052e-4604bbccb32mr94388571cf.33.1728778585472;
        Sat, 12 Oct 2024 17:16:25 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b11497ad55sm270295385a.112.2024.10.12.17.16.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Oct 2024 17:16:25 -0700 (PDT)
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfauth.phl.internal (Postfix) with ESMTP id 6439A1200076;
	Sat, 12 Oct 2024 20:16:24 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Sat, 12 Oct 2024 20:16:24 -0400
X-ME-Sender: <xms:WBELZwDXz4fx9PBlo51ly6JKvyHfBzktXy0weRMFB1ZndKsBk-YB7g>
    <xme:WBELZyinngo6GC0eWsKtjHyqf4xN6JB6mNXSyEND49K8kA5vS3g4dpLpOq_MfxIQD
    ZA9yjSarrRhwcLV-A>
X-ME-Received: <xmr:WBELZzl0-89WaFB7QVvTK1WROCwJ5sdai2hxq8L3tg7KWarl3qX4h_DeTD8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdegvddgfeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrd
    gtohhmqeenucggtffrrghtthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleei
    vedtgeeuhfegueevieduffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhi
    thihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmh
    grihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepvddtpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopegrlhhitggvrhihhhhlsehgohhoghhlvgdrtg
    homhdprhgtphhtthhopehojhgvuggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopeif
    ihhllhihsehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheplhhorhgvnhiiohdrsh
    htohgrkhgvshesohhrrggtlhgvrdgtohhmpdhrtghpthhtohepvhgsrggskhgrsehsuhhs
    vgdrtgiipdhrtghpthhtohepjhhhuhgssggrrhgusehnvhhiughirgdrtghomhdprhgtph
    htthhopehlihgrmhdrhhhofihlvghtthesohhrrggtlhgvrdgtohhmpdhrtghpthhtohep
    rghkphhmsehlihhnuhigqdhfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopehgrh
    gvghhkhheslhhinhhugihfohhunhgurghtihhonhdrohhrgh
X-ME-Proxy: <xmx:WBELZ2we60_9QQ3CV43anrCDE0m2OdXP_V7lMZRTbLoJW2ziy0dcJQ>
    <xmx:WBELZ1TARDQjC9AI5oTfqE98zdENCTz-EzZrJwrO4JYyq6SFgSCizA>
    <xmx:WBELZxb4Z6y_O98p56KJkF2kN8BpiNtvV4zhyrGXp2KFR7AvybldtA>
    <xmx:WBELZ-T2DQy3WLfuMDkgBRE5LRD4GOB310QBM68jNIrl6luUlPrYsQ>
    <xmx:WBELZ_DDowgTRiRYTgcD_eKiIQtxkQeDEVEWRsvqYhQF4bbu1NS5FxWR>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 12 Oct 2024 20:16:23 -0400 (EDT)
Date: Sat, 12 Oct 2024 17:16:22 -0700
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
Subject: Re: [PATCH v6 1/2] rust: mm: add abstractions for mm_struct and
 vm_area_struct
Message-ID: <ZwsRVtBqrRmgs6GX@Boquns-Mac-mini.local>
References: <20241010-vma-v6-0-d89039b6f573@google.com>
 <20241010-vma-v6-1-d89039b6f573@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241010-vma-v6-1-d89039b6f573@google.com>

On Thu, Oct 10, 2024 at 12:56:35PM +0000, Alice Ryhl wrote:
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

Interesting ;-) I agree it's better than using Pin.

> This patch is based on Wedson's implementation on the old rust branch,
> but has been changed significantly. All mistakes are Alice's.
> 
> Co-developed-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
[...]
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
[...]
> +
> +/// A guard for the mmap read lock.
> +///
> +/// # Invariants
> +///
> +/// This `MmapReadLock` guard owns the mmap read lock.
> +pub struct MmapReadLock<'a> {
> +    mm: &'a MmWithUser,

Since `MmWithUser` is `Sync`, so `MmapReadLock<'a>` is `Send`? However,
it cannot be a `Send` because the lock must be released by the same
thread: although ->mmap_lock is a read-write *semaphore*, but
rw_semaphore by default has strict owner semantics (see
Documentation/locking/locktypes.rst).

Also given this type is really a lock guard, maybe name it
something like MmapReadGuard or MmapReadLockGuard?

Same `Send` issue and name suggestion for `MmapWriteLock`.

> +}
> +
> +impl<'a> MmapReadLock<'a> {
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
> +impl Drop for MmapReadLock<'_> {
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
> +/// This `MmapReadLock` guard owns the mmap write lock.
> +pub struct MmapWriteLock<'a> {
> +    mm: &'a MmWithUser,
> +}
> +
> +impl<'a> MmapWriteLock<'a> {
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
> +impl Drop for MmapWriteLock<'_> {
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
[...]
> +impl VmAreaRef {
> +    /// Access a virtual memory area given a raw pointer.
> +    ///
> +    /// # Safety
> +    ///
> +    /// Callers must ensure that `vma` is valid for the duration of 'a, and that the mmap read lock
> +    /// (or stronger) is held for at least the duration of 'a.
> +    #[inline]
> +    pub unsafe fn from_raw<'a>(vma: *const bindings::vm_area_struct) -> &'a Self {

Unrelated to this patch, but since we have so many `from_raw`s, I want
to suggest that we should look into a #[derive(FromRaw)] ;-) For
example:

    pub trait FromRaw {
        type RawType;
        unsafe fn from_raw<'a>(raw: *const Self::RawType) -> &'a Self;
    }
and

    #[derive(FromRaw)]
    #[repr(transparent)] // repr(transparent) is mandatory.
    struct VmAreaRef {
        vma: Opaque<bindings::vm_area_struct> // Opaque is also mandatory.
    }

Regards,
Boqun

> +        // SAFETY: The caller ensures that the invariants are satisfied for the duration of 'a.
> +        unsafe { &*vma.cast() }
> +    }
[...]

