Return-Path: <linux-kernel+bounces-271397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C236944DA2
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 16:07:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E10121F241A8
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 14:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AF351A4885;
	Thu,  1 Aug 2024 14:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VlPxlJyK"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC22C61FF2
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 14:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722521238; cv=none; b=HhOXZXk3FwPiTYGKV1XUxTSXMnSGFS7t8ExlIq7c5Y92gEAD4nQolsP0+ZktZ7ONIFpeO9lWaAIHUAWUJzLZvO+mjct4A4DqKA+1zqddtGr45KbSM9rWXdZAAv3PoteA9KI4HiFKHOVPaoa81wc+lugy4MOH2YAYsKQzEhWqzxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722521238; c=relaxed/simple;
	bh=+p16S8GS0ouZfd2TsKNdCxP8LYTgusGnamhyrVa/Ofo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UsxaPpcCqcJu6aoTyKOxMllkKPBNucGWI660P/O+uc62CpZj6MLZV8+OXpgxXAjtqX5/Q8Vp55CDiA4ybqMNcFJwI4oDpHN1Q+DgjT5s8Ir9x4m7XeG9vQTazqNHWPjUd/ZSQGDy9sM+MJT3mn/qW7BebZyk3THvTBKyxkXPaCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VlPxlJyK; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2cb566d528aso5392361a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 07:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722521236; x=1723126036; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dyBBuohO0Hs+IuvszCA+reGtTKvxPWc+GPkqz6wW5/c=;
        b=VlPxlJyK+wSosYAtgZsX2PUGv41jHdZQmOsi8AWg7Q+1KcB0UKRB7R64BsjLoOs7C6
         tlULqEBw0+wXBAQE4PcSI061XUD7rgYV/cGVOe7K8ekHcbvutjHs3ljFg+YxlJ5WE3oa
         l4Hm7nECd/7mBZQ7CNWyfvD25fqkNz8zVsTQYDxO0Xj26BY3e7jt7+/WWwqTI/YYmkPA
         XHFHnSr5dZAaC02jlkdDrD4eL0t5QXQYh/PRaVeKcRHXH8LPuXsUdaei9IQYC3gZ6NGd
         tAbDXNyNmpklBCyYzjNMgSSTqqbe3tuhDYx8Pu6CVzkAEmVt5VtJ2a/2EB0hPYkwkPeC
         esjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722521236; x=1723126036;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dyBBuohO0Hs+IuvszCA+reGtTKvxPWc+GPkqz6wW5/c=;
        b=WB9Vg69SMNZ0fiOqQMbf1k6id70a7uXCFaH3D2FeeN0BpN12hCEVHN1ZLwNlow012Q
         zai8mzXV7kC7+xueCc3RNV0XQkJUSQbHzJF5ahDTAAzk9OGspppKnrWvT7yXFq48x9eS
         4XFcVUYBYln98sug82/hWfxnua8tdWIyAeblNroG3EyxFWaocaf1S2UHDHdHqPjjKeCK
         nbr0zlvblxU4QOo9riVN+FN2KDGrlCupxs5p74dCl2XM3wT377g7v2IzPapLv28N9+dh
         8AJJqioAZDpMro4jxFOdtyWzZ5tmkTgJ0Gk9HnIzIKXSNy6rYE8iIAGQDyZQdd0VxZF5
         aXBQ==
X-Forwarded-Encrypted: i=1; AJvYcCXLPCBZA/lEg817xJMQyDxXyEU669PpOBb5MTcI7Btm9QLwsoxqeOUPQ4rMQrNu0J2qnZ6iD/Ep5wFA+xpz3yVQ+eivMbSJMTbPUgKh
X-Gm-Message-State: AOJu0YyHxNA++BZ8jZgMupCBXSYCxAEGQdWBKqQMMachIfze0r/gpYBP
	3CoZV4rfuozQJXi4cA3e8vgz2kTkIBdE76MMQbb6uHLvex8HMxqh7vaNICa90T6SSlLGZph5jCf
	0QKBOuQH593K7MPAK3HSr3mWqptsggEIVPL8i
X-Google-Smtp-Source: AGHT+IH8wLTy4OfUI1N/iRPbfsy9jlveCpM3VPGUpvU5ua9Ijad6Tf3V2cLkv7wRzPOiYho4OXsD/vmRzOEqdosk0dw=
X-Received: by 2002:a17:90a:9e5:b0:2c7:c6c4:1693 with SMTP id
 98e67ed59e1d1-2cff9487f9emr346403a91.21.1722521235525; Thu, 01 Aug 2024
 07:07:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240801-vma-v3-1-db6c1c0afda9@google.com> <ZquVcyeLqGGRbgx-@pollux>
In-Reply-To: <ZquVcyeLqGGRbgx-@pollux>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 1 Aug 2024 16:07:01 +0200
Message-ID: <CAH5fLgjd47eK=+k1vB2h6gDnZyVBOUi+KAr2L1Htoq3hPnqbqg@mail.gmail.com>
Subject: Re: [PATCH v3] rust: mm: add abstractions for mm_struct and vm_area_struct
To: Danilo Krummrich <dakr@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Matthew Wilcox <willy@infradead.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 1, 2024 at 4:02=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> w=
rote:
>
> On Thu, Aug 01, 2024 at 12:58:45PM +0000, Alice Ryhl wrote:
> > This is a follow-up to the page abstractions [1] that were recently
> > merged in 6.11. Rust Binder will need these abstractions to manipulate
> > the vma in its implementation of the mmap fop on the Binder file.
> >
> > This patch is based on Wedson's implementation on the old rust branch,
> > but has been changed significantly. All mistakes are Alice's.
> >
> > Link: https://lore.kernel.org/r/20240528-alice-mm-v7-4-78222c31b8f4@goo=
gle.com [1]
> > Co-developed-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> > Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> > Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> > ---
> > Changes in v3:
> > - Reorder entries in mm.rs.
> > - Use ARef for mmput_async helper.
> > - Clarify that VmArea requires you to hold the mmap read or write lock.
> > - Link to v2: https://lore.kernel.org/r/20240727-vma-v2-1-ab3e5927dc3a@=
google.com
> >
> > Changes in v2:
> > - mm.rs is redesigned from scratch making use of AsRef
> > - Add notes about whether destructors may sleep
> > - Rename Area to VmArea
> > - Link to v1: https://lore.kernel.org/r/20240723-vma-v1-1-32ad5a0118ee@=
google.com
> > ---
> >  rust/helpers.c         |  61 +++++++++
> >  rust/kernel/lib.rs     |   1 +
> >  rust/kernel/mm.rs      | 337 +++++++++++++++++++++++++++++++++++++++++=
++++++++
> >  rust/kernel/mm/virt.rs | 204 ++++++++++++++++++++++++++++++
> >  rust/kernel/types.rs   |   9 ++
> >  5 files changed, 612 insertions(+)
> >
> > diff --git a/rust/kernel/mm.rs b/rust/kernel/mm.rs
> > new file mode 100644
> > index 000000000000..ed2db893fb79
> > --- /dev/null
> > +++ b/rust/kernel/mm.rs
> > @@ -0,0 +1,337 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +// Copyright (C) 2024 Google LLC.
> > +
> > +//! Memory management.
> > +//!
> > +//! C header: [`include/linux/mm.h`](../../../../include/linux/mm.h)
>
> NIT: srctree

Ah, thanks. Good catch.

> > +
> > +    /// Returns a raw pointer to the inner `mm_struct`.
> > +    #[inline]
> > +    pub fn as_raw(&self) -> *mut bindings::mm_struct {
> > +        self.mm.get()
> > +    }
> > +
> > +    /// Obtain a reference from a raw pointer.
> > +    ///
> > +    /// # Safety
> > +    ///
> > +    /// The caller must ensure that `ptr` points at an `mm_struct`, an=
d that it is not deallocated
> > +    /// during the lifetime 'a.
> > +    #[inline]
> > +    pub unsafe fn from_raw_mm<'a>(ptr: *const bindings::mm_struct) -> =
&'a Mm {
>
> I'd just call this `from_raw`, like you call the counterpart `as_raw` abo=
ve.
> Same goes for `MmWithUser` and `VmArea`.

I've been using this naming convention since this discussion:
https://lore.kernel.org/all/20240401-marge-gepaukt-9a1972c848d9@brauner/

> > diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
> > index bd189d646adb..143a2bf06941 100644
> > --- a/rust/kernel/types.rs
> > +++ b/rust/kernel/types.rs
> > @@ -366,6 +366,15 @@ pub unsafe fn from_raw(ptr: NonNull<T>) -> Self {
> >              _p: PhantomData,
> >          }
> >      }
> > +
> > +    /// Pass ownership of the refcount to a raw pointer.
> > +    pub fn into_raw(self) -> NonNull<T> {
> > +        let ptr =3D self.ptr;
> > +        // Skip the destructor.
> > +        core::mem::forget(self);
> > +
> > +        ptr
> > +    }
>
> I think this should be a separate patch.

Sure.

Alice

