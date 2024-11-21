Return-Path: <linux-kernel+bounces-416844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E73979D4B09
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 11:45:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACBC428654B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 10:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 936B41CB528;
	Thu, 21 Nov 2024 10:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xAVtialq"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA0E1D0B8B
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 10:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732185908; cv=none; b=GNdlcuphPLQxplXBxHw99qRxM+1Z/r45K5ckfzr2jdDo7PiPyIIxGAmj/DicrFUrsrozaPRCZdS6TxHuM8NhWh8xF2CZITWMmjFaG360uc2aokcIAwEmvljc2l1jZ0EC0yjUfl/ET9nBKWYdu5fUISSFyJQiBEtu1Qg8t24ra1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732185908; c=relaxed/simple;
	bh=CwIShjUsfcnOqesiDbb35NKm4hTygyydM61hfALVz0c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A3hEraUsrd+FTzcz6WQKUrhqqLsdM0wScb79NJ4lVMNKwS9IlZRWv7t2uT4VNntKUt2/4QPBCbAWh2lznYkuv2aaK1/9zzHPa/OGYUCHJRYu2kCs5WHXMb4iyNjB0KOLlN4S0K3v8tH2MJa/uSLTpziAIDJqPIWuso5vVLUWyHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xAVtialq; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3823cf963f1so426953f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 02:45:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732185904; x=1732790704; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xK4Cfg9DlwufnPePVmxDaoaAvTYsonxko5dLjDtr1k8=;
        b=xAVtialqQzD68QZEOQHJDmZf3qmHqdQ8bp91F5fe9qhXoRabP9C70i6mCgXZKyXqOt
         ydh/Rg/x/4d0A1kbEJesdDir49SzkB6aYTqTek+xekz64Q4r7sgM+yFq5uKTV8gGXWXw
         xAswTAL09qpNQBqNc9DSBQHNiiHl1Dyckrpy7tShGYvLSb+uRlOZk+1zAb+ZmhTMnj2M
         /r4cM726rD6tkwMwI9sjR4C4wGGlSe9bzCGA6Lgye3hT3ejgq2clB8UjdrBN8rmo65KO
         /a37wCnbi+TkIr13jcF2vOZirZ+OqtYCKlOilCzL15IjMO9g9SCsEnq8XckO8H02wMBP
         gCbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732185904; x=1732790704;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xK4Cfg9DlwufnPePVmxDaoaAvTYsonxko5dLjDtr1k8=;
        b=sxGEqSthch4PtGcFjGz8O6jI9p2mK7BQC7nX0t5nG1Z9yU0ltgfTOrqnCbUvQDYw7Z
         4ivj2XI6zZzeJ9BkntThUDSJydHfeRGRQk7sR9nkljknUpmXQenIws/Z22+RI2uBOGDo
         Q18Ue9RHi9qWanEiuXV1YKU+pWLuZxI1uRYI8MLYB9jG6k2qyBHCyykhHIjGOUbDdCfo
         1WZTzqYIPIWmBb9hxUJAmb3+iCiSv28S4X+nvAccsc1n88bwq9Crcvahk5WWZYR4qEnr
         u0rFdnZmbElHKYGP+c/IaRkBzX19Mtpdl26te2YhVY8tYxSWtF5uiOLHlaVJTgeWY7L6
         lhIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPodRKCrScZm0tatwNNsARTjiTU0g4Sfg0E6bXKWyUrFwMN9KKO8f8chDP0slWOZG/FU+Rql+yq1F55Kw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyDcofAC+sFPMz4xhfa2Zs1EqzdZpt09DKvYTeq3Xuwdxa2G3w
	ZSLd1zSJyQVV87STWaEhoUFgZZezZfpRy8lLiGoSTPiqCzQgF1WpnOZtDc5EpLlJCGX5K0KvUgB
	56T946mcqhjRk8A0YjQx2CKwOQAOs7sYpikmD
X-Gm-Gg: ASbGnctxwawX5XRzp+zAD0s4pnnmvX/7eVgxbDD2J1Nvg44Hh7hBoPzUYCpINWdMBYq
	T/jZzIOjcdc76Amy3gS8P2Zj3prXqFgStxiQrHdUsHxSSv7IugL1bPSJaX6oQAQ==
X-Google-Smtp-Source: AGHT+IFNLFXfFTPNcf0Jy6eL0FhPoWe5bssVRl6BmWr16Rlaom5gN2QQBv1a2lad6azAjMDYL8YEC8lFmavr2ot49Tw=
X-Received: by 2002:a5d:5f86:0:b0:382:5393:43cf with SMTP id
 ffacd0b85a97d-38254af6394mr4794445f8f.13.1732185904176; Thu, 21 Nov 2024
 02:45:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241120-vma-v8-0-eb31425da66b@google.com> <20241120-vma-v8-4-eb31425da66b@google.com>
 <40be19b0-4c32-4554-a01f-649c12f889da@lucifer.local>
In-Reply-To: <40be19b0-4c32-4554-a01f-649c12f889da@lucifer.local>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 21 Nov 2024 11:44:52 +0100
Message-ID: <CAH5fLggw4Ca59-AA+ArHYD0QrKH8cGd_i0EN83MnYYZK1bmTGQ@mail.gmail.com>
Subject: Re: [PATCH v8 4/7] mm: rust: add lock_vma_under_rcu
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
	Vlastimil Babka <vbabka@suse.cz>, John Hubbard <jhubbard@nvidia.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, 
	Christian Brauner <brauner@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	rust-for-linux@vger.kernel.org, Andreas Hindborg <a.hindborg@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 20, 2024 at 8:29=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Wed, Nov 20, 2024 at 02:49:58PM +0000, Alice Ryhl wrote:
> > All of Rust Binder's existing calls to `vm_insert_page` could be
> > optimized to first attempt to use `lock_vma_under_rcu`. This patch
> > provides an abstraction to enable that.
>
> I think there should be a blurb about what the VMA locks are, how they av=
oid
> contention on the mmap read lock etc. before talking about a use case (th=
ough
> it's useful to mention the motivating reason!)
>
> >
> > Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> > ---
> >  rust/helpers/mm.c |  5 +++++
> >  rust/kernel/mm.rs | 56 +++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
> >  2 files changed, 61 insertions(+)
> >
> > diff --git a/rust/helpers/mm.c b/rust/helpers/mm.c
> > index 7b72eb065a3e..81b510c96fd2 100644
> > --- a/rust/helpers/mm.c
> > +++ b/rust/helpers/mm.c
> > @@ -43,3 +43,8 @@ struct vm_area_struct *rust_helper_vma_lookup(struct =
mm_struct *mm,
> >  {
> >       return vma_lookup(mm, addr);
> >  }
> > +
> > +void rust_helper_vma_end_read(struct vm_area_struct *vma)
> > +{
> > +     vma_end_read(vma);
> > +}
> > diff --git a/rust/kernel/mm.rs b/rust/kernel/mm.rs
> > index ace8e7d57afe..a15acb546f68 100644
> > --- a/rust/kernel/mm.rs
> > +++ b/rust/kernel/mm.rs
> > @@ -13,6 +13,7 @@
> >  use core::{ops::Deref, ptr::NonNull};
> >
> >  pub mod virt;
> > +use virt::VmAreaRef;
> >
> >  /// A wrapper for the kernel's `struct mm_struct`.
> >  ///
> > @@ -170,6 +171,32 @@ pub unsafe fn from_raw<'a>(ptr: *const bindings::m=
m_struct) -> &'a MmWithUser {
> >          unsafe { &*ptr.cast() }
> >      }
> >
> > +    /// Try to lock the vma read lock under rcu.
>
> This reads oddly, I'd say 'try to acquire the VMA read lock'. It's not re=
ally
> necessary to mention RCU here I'd say, as while lock_vma_under_rcu() acqu=
ires
> the RCU lock in order to try to get the VMA read lock, it releases it aft=
erwards
> and you hold the VMA read luck until you are done with it and don't need =
to hold
> an RCU lock.
>
> A reader might otherwise be confused and think an RCU read lock is requir=
ed to
> be held throughout too which isn't the case (this is maybe a critique of =
the
> name of the function too, sorry Suren :P).
>
> > +    /// If this operation fails, the vma may still exist. In that case=
, you should take the mmap
> > +    /// read lock and try to use `vma_lookup` instead.
>
> This also reads oddly, you're more likely (assuming you are not arbitrari=
ly
> trying to acquire a lock on an address likely to be unmapped soon) to hav=
e
> failed due to lock contention.
>
> So I'd say 'this is an optimistic try lock operation, so it may fail, in =
which
> case you should fall back to taking the mmap read lock'.
>
> I'm not sure it's necessary to reference vma_lookup() either, especially =
as in
> future versions of this code we might want to use a VMA iterator instead.

Thanks for the doc suggestions, they sound great.

> > +    ///
> > +    /// When per-vma locks are disabled, this always returns `None`.
> > +    #[inline]
> > +    pub fn lock_vma_under_rcu(&self, vma_addr: usize) -> Option<VmaRea=
dGuard<'_>> {
>
> Ah I love having lock guards available... Something I miss from C++ :>)

I've heard that C is starting to get lock guards recently!

> > +        #[cfg(CONFIG_PER_VMA_LOCK)]
>
> Ah interesting, so we have an abstraction for kernel config operations!

Yeah, it's basically an #ifdef, but the block must still parse even if
the config is disabled.

Alice

