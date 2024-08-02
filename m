Return-Path: <linux-kernel+bounces-272748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C51946091
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 17:33:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13FFA1F226CE
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 15:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DE8413632B;
	Fri,  2 Aug 2024 15:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i2MEEEhe"
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B5D175D20;
	Fri,  2 Aug 2024 15:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722612797; cv=none; b=K3PdNO3VyoScYrL580wBRnm5AR8iIDTPft0Uj+40g0es+ehMPSapmaMkGePYYJPCeqlfENLR2sxKJf6AyaBxjKnk7tHaLVLNH2+7AJ3Zn4OC58cOIpZkpM7OQ8wxos12F1cNzog0VyVk95K2de130SHRuvqSC/xzITWwtYrF4CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722612797; c=relaxed/simple;
	bh=7yp9NYz/UMI4KVrvMoSSlqpujNCBlAXB2n4EFqgJhVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jsrj12ZN4v3oi6BsAmkEvPqn8uzAQRkundjASvg6AMGFSfBF6yZZH9FLk15XSBFVEp5gugmSWd+97WBxiGjb/GzSouN8rT0yWYOG9aJ6Ks6SGh37NMd6VBi1urwA2s/kUtTLCMq0ibpswx/eTPj9KYz292KBZ33MP0bvZZ5AVlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i2MEEEhe; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7a1d067d5bbso521233085a.3;
        Fri, 02 Aug 2024 08:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722612794; x=1723217594; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hjG1umlrzw0lSXr9y8w9IUcaGi7HbzKvSj4pZKikvaI=;
        b=i2MEEEheXf4Ztat1K1Alpi8OaLYRM52LBD55bTqNjJXH5mj7dtpXSO80OLc7XThstj
         ANxl5bQaZLIuEgVI+cTtF/g3TOVdgrOG805pnNS7028DtoyDYF99jxYQKgTK6NfPAEFI
         vrBONS7I3CstJlw/5C2DnCT1XuNjbQOyCyCevalecRTmy1tXhtn9H1szyLQgQjhDfLVm
         uEEhbMFHSE2UiPjLRt5Kzk+RUHjC4yYQXfl9x1NNdrR8ljlGgfKfHIm7JiE50R8wQa7f
         tzIlXbv4xXXdZAj9ex2MwUKK8RFgIV0CFC9NZHqolIIxURQAjtWX3SBrybEXuKId2pbr
         Ontw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722612794; x=1723217594;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hjG1umlrzw0lSXr9y8w9IUcaGi7HbzKvSj4pZKikvaI=;
        b=KtfFmnpYKuEK96COPeiXRTQteIYnqZwvdal5EIX7pz3rib8vQIwMb5dp9JxYK1LU0n
         vKTb5peodeFnE8RprZ2hcJscnYdCMKitJ6u6ruhY3e6XP5qqqJHWfiyjFvJd+Kr66xBm
         XTIRyNtczb8NSd+8LQ8gdOWl2fyEy24Rc75gf5kiO96Xe4cFzg5bsRPSApxqhyFvJrpB
         Xh1fOFSk8/TGsyif45opWo2D16MQqpaaBc8W2zquCvnN/TITOnEqCCclT2APUHIv69s2
         UteiyUDSXj3XcYUrBAVDTpFabl/C6hDFtV4FCSUAS3XfMROGx+8PVA+Z2b6s5DDjaMX6
         nxOQ==
X-Forwarded-Encrypted: i=1; AJvYcCVb5LimcrfB/M0pTUIIWY8ZzeboDnjdGW04/rB0bQmNKPG0h8QMCnxi59yi8yupCnK90lD1B+P4iu0O+/6u/R7MvgYHi34hynAduB3dPStl6gIJf44euxNfixsvpRY+Pqvx9XrC6ShyN7nykl0=
X-Gm-Message-State: AOJu0Yzeygb7k5o64qJRCFBfvaMukZ8sNzvz3QVx+5aPoOXgMcifygn5
	SK01nPwHvo9hEMBktvNEserMFTqKcPRvDYnntrnVsvY6RBVFx7lP
X-Google-Smtp-Source: AGHT+IHwcwh7lUDTHID/MvbPVdKokl3p8mz9boLIt6HoPbme3x6iG4qqU4gYMx7vpHo+ockIHfyadQ==
X-Received: by 2002:a05:620a:4614:b0:7a1:e93c:ccf3 with SMTP id af79cd13be357-7a34ef9e42cmr464274485a.47.1722612794075;
        Fri, 02 Aug 2024 08:33:14 -0700 (PDT)
Received: from fauth2-smtp.messagingengine.com (fauth2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a34f6dc7besm95198285a.21.2024.08.02.08.33.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 08:33:13 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 134B3120006A;
	Fri,  2 Aug 2024 11:33:13 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Fri, 02 Aug 2024 11:33:13 -0400
X-ME-Sender: <xms:OPysZu10Fb81VF20tnEbyCPXn-dWxFlVrKZXmhtZjj_p3fS7rFoTGQ>
    <xme:OPysZhHToTuuyhJSYAok98liQ_5B4sSui-P0ipekPzmEXNpOpcUtR3y_f5UOQgKjV
    jW-9i0EVTzg2BMm0A>
X-ME-Received: <xmr:OPysZm58lBAd0bT6w0DND0coe90vnYks7JVfI1qIVx3yBnn_RSNe3JT9P7A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkedtgdeklecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveeiudff
    iedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsg
    hoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieeg
    qddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigi
    hmvgdrnhgrmhgvpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:OfysZv06T9XWpJu435IalwsEw96vYt8GFDwxrAIXVfjIZzLZM-CKjg>
    <xmx:OfysZhEwOwXJaQZ6BjTGIUuqWRdE2U1lgbN26vZSQOFnS4jhabmbkA>
    <xmx:OfysZo9Z9fWfJbE2MyyB9ypp1uTIWt1gXO3pb-BpneG0TCLk4ZajTw>
    <xmx:OfysZmktXyxKx22RGNtrZlQfrP03WB0atxEi_L_eYz_lE5TqVAXhAQ>
    <xmx:OfysZpF4z1rabOMyrBPsMJJCil6gLIPSizMIvjFZjbMBjqKTZwhqqlLW>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 Aug 2024 11:33:12 -0400 (EDT)
Date: Fri, 2 Aug 2024 08:32:21 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Matthew Wilcox <willy@infradead.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v4] rust: mm: add abstractions for mm_struct and
 vm_area_struct
Message-ID: <Zqz8BYNQ18XOI0ST@boqun-archlinux>
References: <20240802-vma-v4-1-091a87058a43@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240802-vma-v4-1-091a87058a43@google.com>

On Fri, Aug 02, 2024 at 07:38:32AM +0000, Alice Ryhl wrote:
[...]
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
> +        let mm = NonNull::new(mm)?;
> +
> +        // SAFETY: We just checked that `mm` is not null.
> +        unsafe { bindings::mmgrab(mm.as_ptr()) };
> +
> +        // SAFETY: We just created an `mmgrab` refcount. Layouts are compatible due to
> +        // repr(transparent).
> +        Some(unsafe { ARef::from_raw(mm.cast()) })

We can use from_raw() + into() here. If a type `impl`s AlwaysRefcounted,
we should have no chance to call the "refcount increment" function
directly.

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
> +    pub fn is_same_mm(&self, area: &virt::VmArea) -> bool {
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
> +    pub fn mmap_write_lock(&self) -> MmapWriteLock<'_> {
> +        // SAFETY: The pointer is valid since self is a reference.
> +        unsafe { bindings::mmap_write_lock(self.as_raw()) };
> +
> +        // INVARIANT: We just acquired the write lock.
> +        MmapWriteLock { mm: self }
> +    }
> +
> +    /// Lock the mmap read lock.
> +    #[inline]
> +    pub fn mmap_read_lock(&self) -> MmapReadLock<'_> {
> +        // SAFETY: The pointer is valid since self is a reference.
> +        unsafe { bindings::mmap_read_lock(self.as_raw()) };
> +
> +        // INVARIANT: We just acquired the read lock.
> +        MmapReadLock { mm: self }
> +    }
> +
> +    /// Try to lock the mmap read lock.
> +    #[inline]
> +    pub fn mmap_read_trylock(&self) -> Option<MmapReadLock<'_>> {
> +        // SAFETY: The pointer is valid since self is a reference.
> +        let success = unsafe { bindings::mmap_read_trylock(self.as_raw()) };
> +
> +        if success {
> +            // INVARIANT: We just acquired the read lock.
> +            Some(MmapReadLock { mm: self })
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
> +/// This `MmapReadLock` guard owns the mmap read lock.
> +pub struct MmapReadLock<'a> {
> +    mm: &'a MmWithUser,
> +}
> +
> +impl<'a> MmapReadLock<'a> {
> +    /// Look up a vma at the given address.
> +    #[inline]
> +    pub fn vma_lookup(&self, vma_addr: usize) -> Option<&virt::VmArea> {
> +        // SAFETY: We hold a reference to the mm, so the pointer must be valid. Any value is okay
> +        // for `vma_addr`.
> +        let vma = unsafe { bindings::vma_lookup(self.mm.as_raw(), vma_addr as _) };
> +
> +        if vma.is_null() {
> +            None
> +        } else {
> +            // SAFETY: We just checked that a vma was found, so the pointer is valid. Furthermore,
> +            // the returned area will borrow from this read lock guard, so it can only be used
> +            // while the read lock is still held. The returned reference is immutable, so the
> +            // reference cannot be used to modify the area.
> +            unsafe { Some(virt::VmArea::from_raw_vma(vma)) }
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
> +    pub fn vma_lookup(&mut self, vma_addr: usize) -> Option<&mut virt::VmArea> {

I think this needs to be -> Option<Pin<&mut virt::VmArea>>, otherwise,
you could swap two VMAs (from different MMs) while the address stability
is required by themselves (list_head) or others (list_head and rb_node):
	
	let vma1 = writer1.vma_lookup(x)?;
	let vma2 = writer2.vma_lookup(x)?;

	swap(vma1, vma2);

> +        // SAFETY: We hold a reference to the mm, so the pointer must be valid. Any value is okay
> +        // for `vma_addr`.
> +        let vma = unsafe { bindings::vma_lookup(self.mm.as_raw(), vma_addr as _) };
> +
> +        if vma.is_null() {
> +            None
> +        } else {
> +            // SAFETY: We just checked that a vma was found, so the pointer is valid. Furthermore,
> +            // the returned area will borrow from this write lock guard, so it can only be used
> +            // while the write lock is still held. We hold the write lock, so mutable operations on
> +            // the area are okay.
> +            unsafe { Some(virt::VmArea::from_raw_vma_mut(vma)) }
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

(Will review the locking part later)

Regards,
Boqun

[...]

