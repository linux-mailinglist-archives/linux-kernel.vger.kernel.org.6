Return-Path: <linux-kernel+bounces-363705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA3F299C5D1
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 11:34:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 685DA1F23B1B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 09:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A498156C76;
	Mon, 14 Oct 2024 09:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a8kBHQMa"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4A115666A
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 09:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728898416; cv=none; b=X1r7pTooFRTfQTnfbjmOC2R4YKJWCEMaQQ2HI1cPg41OypkF8XDbCImN/yaevuYktnFCwl1W9wbqDkxx04G49+ficvoutiJBLIP1CqddWI9libM00eaR9NeIAzE68DLA+NtBEY02Pcjh3DeFOy/sqLvgN3tvGKdm+gb6YXNMyow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728898416; c=relaxed/simple;
	bh=/5VRsu07e7zjfxdwWnfYiEqvOggRzn381KEkEAf0NSo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rb0WtGDYFLiPw2KYFftAX7IEc+tvNC1QLp9FHyHKAqHKjm42CDPtTwcwFaGkovcwyZERUHAWy5r3zjnJ/D5M3YZcOXyFkEiQc3GyH0pZF/RYwaTNf/PPe1AZutDlcr/qivSmYRRG4Yq7Kdn/6/m3AwpHoo05Lx3XDk6/JAxo1JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a8kBHQMa; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-430f6bc9ca6so31397825e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 02:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728898413; x=1729503213; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Do+osA+eLZbyPfwfjx6Pg5S9LDhJ9bCJgF0diE+K1o=;
        b=a8kBHQMatFWY+C6tutJNRQYZNBlqNO1o5Lm8P/3wbJzG72zIsG0buVDektxpGpz0mB
         GgNg4oKu48c347DxtX+gbUycxwW5rCUdagdvn0EH5eHNg3Puaz/yYRx0Xa3Fh5Jym7TI
         255kmuKBRfZDE/X1ubgkKTuH3MBbGVTHYt4/xoYu1TIzS0qgMvHHoj5B45FCbnBpJO5k
         8aAfr0olsLIWPY0TPwa+LA5uPAPobHMstzzZv10Agwz01O9uz1Z4zWr0ja2/Za3NcZoR
         kQBHzwTwzdYFM4oeB5LSWmTRTGpWkQhBxXLouaDcnfjk7KKm28XcnFhTD27l0pGUpsWp
         /27A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728898413; x=1729503213;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Do+osA+eLZbyPfwfjx6Pg5S9LDhJ9bCJgF0diE+K1o=;
        b=Q915MxYC/zp2MucJ0Q2MnWTsDfDFrhWqtQSR57KG9ZbxJiCXErMLDvBG/TRm20ABcN
         3y8S9TyKCkoEchhBgTkqd+04wJKDm6V7Cg/T/ybh/3uul/oMpohgc62jnpYrctVuhbtI
         Ip6wefwgF1u7XHF6EndCRVN+KdLbAoTR/PM1kBTBqWi7lLr/zTBE2CPdAilttHEBtZiF
         RVop4m6i/jAZA3aiZEWmCF3wIz8NrgRx3b85oaWR7Y2IDC1nBJPjA4B9Z6mqdaY97lQQ
         E2eBIOELPgHgE5msk8ofGjKwX5kvY29JVlpwZwZK4joC2+6aQ6Wrfu2m4w74pGu5fUl9
         vxLg==
X-Forwarded-Encrypted: i=1; AJvYcCVUBkJLKhAMMg4nYT7MzOaeEkbjYoH92rT4lpkhSvTQhN9VbMGyZPm56rW+tU3GSF8yLcDmUrhXIAUqGCo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOjmHJ8bjb3/ebwXUD7TyzF5ry47RZv4OjJRXyclV0rVOhfAhA
	a8jmpEVAoa2IQUaC2P/XVsJkpv083Ng31UDFn/3TDPpror0XcBK6fXoC8AVcvjr+tsfxSIzHE/P
	nC2Ea3dGxtxQbpEey3r+Foxao9B+5A5SlzGkr
X-Google-Smtp-Source: AGHT+IGntwzOQW79lkB9HQi43v6cSR3yaLMLYz/k3lEB9teEmrOcZJQEk65UT2GN5x1c5ODrN3MzKf/h5z+nIxfyczg=
X-Received: by 2002:a05:6000:b03:b0:37d:4cee:55b with SMTP id
 ffacd0b85a97d-37d600c927bmr5096241f8f.59.1728898413070; Mon, 14 Oct 2024
 02:33:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241010-vma-v6-0-d89039b6f573@google.com> <20241010-vma-v6-1-d89039b6f573@google.com>
 <ZwsRVtBqrRmgs6GX@Boquns-Mac-mini.local>
In-Reply-To: <ZwsRVtBqrRmgs6GX@Boquns-Mac-mini.local>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 14 Oct 2024 11:33:20 +0200
Message-ID: <CAH5fLgjdBTs0WEH4Qja=6ysreRGJog3C8DLp49PGwuXitCyK8g@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] rust: mm: add abstractions for mm_struct and vm_area_struct
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	John Hubbard <jhubbard@nvidia.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Arnd Bergmann <arnd@arndb.de>, Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	rust-for-linux@vger.kernel.org, Andreas Hindborg <a.hindborg@kernel.org>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 13, 2024 at 2:16=E2=80=AFAM Boqun Feng <boqun.feng@gmail.com> w=
rote:
>
> On Thu, Oct 10, 2024 at 12:56:35PM +0000, Alice Ryhl wrote:
> > These abstractions allow you to manipulate vmas. Rust Binder will uses
> > these in a few different ways.
> >
> > In the mmap implementation, a VmAreaNew will be provided to the mmap
> > call which allows it to modify the vma in ways that are only okay durin=
g
> > initial setup. This is the case where the most methods are available.
> >
> > However, Rust Binder needs to insert and remove pages from the vma as
> > time passes. When incoming messages arrive, pages may need to be
> > inserted if space is missing, and in this case that is done by using a
> > stashed ARef<Mm> and calling mmget_not_zero followed by mmap_write_lock
> > followed by vma_lookup followed by vm_insert_page. In this case, since
> > mmap_write_lock is used, the VmAreaMut type will be in use.
> >
> > Another use-case is the shrinker, where the mmap read lock is taken
> > instead, and zap_page_range_single is used to remove pages from the vma=
.
> > In this case, only the read lock is taken, so the VmAreaRef type will b=
e
> > in use.
> >
> > Future extensions could involve a VmAreaRcuRef for accessing vma method=
s
> > that are okay to use when holding just the rcu read lock. However, thes=
e
> > methods are not needed from Rust yet.
> >
> > This uses shared references even for VmAreaMut. This is preferable to
> > using pinned mutable references because those are pretty inconvenient
> > due to the lack of reborrowing. However, this means that VmAreaMut
> > cannot be Sync. I think it is an acceptable trade-off.
> >
>
> Interesting ;-) I agree it's better than using Pin.
>
> > This patch is based on Wedson's implementation on the old rust branch,
> > but has been changed significantly. All mistakes are Alice's.
> >
> > Co-developed-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> > Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> > Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> > ---
> [...]
> > +/// A wrapper for the kernel's `struct mm_struct`.
> > +///
> > +/// This type is like [`Mm`], but with non-zero `mm_users`. It can onl=
y be used when `mm_users` can
> > +/// be proven to be non-zero at compile-time, usually because the rele=
vant code holds an `mmget`
> > +/// refcount. It can be used to access the associated address space.
> > +///
> > +/// The `ARef<MmWithUser>` smart pointer holds an `mmget` refcount. It=
s destructor may sleep.
> > +///
> > +/// # Invariants
> > +///
> > +/// Values of this type are always refcounted using `mmget`. The value=
 of `mm_users` is non-zero.
> > +/// #[repr(transparent)]
> > +pub struct MmWithUser {
> > +    mm: Mm,
> > +}
> > +
> > +// SAFETY: It is safe to call `mmput` on another thread than where `mm=
get` was called.
> > +unsafe impl Send for MmWithUser {}
> > +// SAFETY: All methods on `MmWithUser` can be called in parallel from =
several threads.
> > +unsafe impl Sync for MmWithUser {}
> > +
> [...]
> > +
> > +/// A guard for the mmap read lock.
> > +///
> > +/// # Invariants
> > +///
> > +/// This `MmapReadLock` guard owns the mmap read lock.
> > +pub struct MmapReadLock<'a> {
> > +    mm: &'a MmWithUser,
>
> Since `MmWithUser` is `Sync`, so `MmapReadLock<'a>` is `Send`? However,
> it cannot be a `Send` because the lock must be released by the same
> thread: although ->mmap_lock is a read-write *semaphore*, but
> rw_semaphore by default has strict owner semantics (see
> Documentation/locking/locktypes.rst).
>
> Also given this type is really a lock guard, maybe name it
> something like MmapReadGuard or MmapReadLockGuard?
>
> Same `Send` issue and name suggestion for `MmapWriteLock`.

Fixed in v7.

https://lore.kernel.org/lkml/20241014-vma-v7-0-01e32f861195@google.com/

> > +impl VmAreaRef {
> > +    /// Access a virtual memory area given a raw pointer.
> > +    ///
> > +    /// # Safety
> > +    ///
> > +    /// Callers must ensure that `vma` is valid for the duration of 'a=
, and that the mmap read lock
> > +    /// (or stronger) is held for at least the duration of 'a.
> > +    #[inline]
> > +    pub unsafe fn from_raw<'a>(vma: *const bindings::vm_area_struct) -=
> &'a Self {
>
> Unrelated to this patch, but since we have so many `from_raw`s, I want
> to suggest that we should look into a #[derive(FromRaw)] ;-) For
> example:
>
>     pub trait FromRaw {
>         type RawType;
>         unsafe fn from_raw<'a>(raw: *const Self::RawType) -> &'a Self;
>     }
> and
>
>     #[derive(FromRaw)]
>     #[repr(transparent)] // repr(transparent) is mandatory.
>     struct VmAreaRef {
>         vma: Opaque<bindings::vm_area_struct> // Opaque is also mandatory=
.
>     }

Well, perhaps. But it's not a trait, so is a derive the right way?
Either way, it's unrelated to this patch.

Alice

