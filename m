Return-Path: <linux-kernel+bounces-416903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B49C9D4C34
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 12:48:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78398B23CE7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 11:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CD201D1F78;
	Thu, 21 Nov 2024 11:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EAMPMI9h"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B819D1CD1EB
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 11:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732189670; cv=none; b=nWXCFD+1QLJ0VmoqT1Hpe0+g6aown2G7JXU4+noRwqzFknnTxIkvgP9KCzLkfs1rpduDxY50pRyawAbaqwuE08IH39rVoF3B9MESctzz1v20afKOJyP9vY88+BYxlp5jwbKeibCI+1xwrc/w0XEEtuZHj8yLsKKkiW+4jMD4QmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732189670; c=relaxed/simple;
	bh=6WQGbQJFRQkmsMW9o3BIxKhVWrxKGjsC0JK9++AZxok=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mo0qyKeiBLjDuk1EFyUxnoCAgrM4Z0J2SLQdtenwyFPhfzoyRWeCeIGydKSq4Jblvkfa9fgoHYWrzP5udPJp+2neaOGavsnfflDprM22L0HZNJrSgK9t8nz2nLOKEcD8YnanTDPSxl248FKQJLh+RZNMopolAfM51b7oiyqGUB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EAMPMI9h; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4315c1c7392so6692215e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 03:47:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732189666; x=1732794466; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s7Jpx3h5F/wBA3xOhCxThURBB82AusRTtrT4gd5tWfo=;
        b=EAMPMI9hHeFjxscVOgSUhci81s01hrcHhgmOhD/kcvNkaHuc0vOc+zp+Mab3qZ/921
         QO4MSxPY6jcnfLVd1LgyfDFkoZyoo0TngyHJU1gntDtZvqJ8Rd0aFsSlTzceQv9+cjZd
         Xuzm/+SZSs86254DZpYDxH/9YzH/5KUNlfwNCGLtZ1U7rYhBfi2MUieVrI77hpVcI3dW
         EMH4o6+cjYpiyIAe9BWBCcSK6onkZs/slnLVCdoldRlr+1zWWrlKFqHr4iDpOVbUe/RY
         X7muI5aKg8YTyr1sYfo+1P5WJ849p43qjc3gWywzqhYXcnaaoZvzbhr0+S07Ooy4jQUa
         s95g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732189666; x=1732794466;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s7Jpx3h5F/wBA3xOhCxThURBB82AusRTtrT4gd5tWfo=;
        b=lM++2/8BOuzm243JsVP7toP7ZbhB+g3aq3yJnt+o8fZraengqzh4ccl+pJmz1la/iF
         NTtMyodUMUNaD3fUlR3pwQLGNBwIiYewnzEsLZvMBySv91myQ2rhbGgIjUw+PavNA99I
         Dp0aT9mjEuQL3bUEB9AhAmt/wm4r0HcRRT8zMM/0DOCje0EOfzzaBbSkdVGJuUKhCuGR
         2pRSLr6MawTzbbU5D483Kv+HnDqrQ54cwaWseS4uG9NoroFEll+KHDJv7Y2KGLbGC8EN
         9zCNIvbxDBEzF0OLZrMjyKprlNpqs3ehmKOEZADDTBsA0wsNB7YIy4687J8QPjFQb6zS
         nrbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZLp/rtl2IhNn0z6cQoDVJ1SgC92EEpOyqn5Yl5+T5QylV06iJnRSXXeZb29L1JhdE3ezxmbkd4Ln1aq8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbXfHiAVwGzV1QSRfZnN3bAA4In3gnV3NQUd5SBUcHfRLPDjw1
	2WlE4rBWdax2aoJLOb1T/dga4ea7qD2kHzA7uJozwcY8Jaj1i/c0ssRbneWctk1V4mZuw/FAIa2
	GArqislYMsPV4hxF1HbrnAHqsdfh6TVmG9qNP
X-Gm-Gg: ASbGnctPKW4zkoKbf+vl8Eijx6yTSfqVqXWRjdRZNYlQgb5voXK/jCUe23VGnLUJFxw
	jdvpyrI3kPSeJja2z1wMyHlK8ozZpJPLD6blWDsv0KdCxnJq/7tj6WTrX6HYGuQ==
X-Google-Smtp-Source: AGHT+IErqV0V+AJ2UHRmioWLhU5OsHABPh0+c+ZumlE3zmUVhcVOjKRjYxRx69HpUK6hUBWpEgTlIcHN/WLV9AwIu0M=
X-Received: by 2002:a05:600c:3514:b0:431:47d4:19c7 with SMTP id
 5b1f17b1804b1-433489814a4mr60730235e9.3.1732189665908; Thu, 21 Nov 2024
 03:47:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241120-vma-v8-0-eb31425da66b@google.com> <20241120-vma-v8-6-eb31425da66b@google.com>
 <8755851f-de55-4411-9a8a-80ff69f35905@lucifer.local>
In-Reply-To: <8755851f-de55-4411-9a8a-80ff69f35905@lucifer.local>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 21 Nov 2024 12:47:33 +0100
Message-ID: <CAH5fLgiEjxN14K3QLnfxE-HFes_DmjtGSa9tJxOVJhLOv4sSEA@mail.gmail.com>
Subject: Re: [PATCH v8 6/7] mm: rust: add VmAreaNew
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

On Wed, Nov 20, 2024 at 9:02=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Wed, Nov 20, 2024 at 02:50:00PM +0000, Alice Ryhl wrote:
> > When setting up a new vma in an mmap call, you have a bunch of extra
> > permissions that you normally don't have. This introduces a new
> > VmAreaNew type that is used for this case.
>
> Hm I'm confused by what you mean here. What permissions do you mean?

I just mean that there are additional things you can do, e.g. you can
set VM_MIXEDMAP.

> Is this to abstract a VMA as passed by f_op->mmap()? I think it would be
> better to explicitly say this if so.

Yeah, the VmAreaNew type is specifically for f_op->mmap(). I'll be
more explicit about that.

> > To avoid setting invalid flag values, the methods for clearing
> > VM_MAYWRITE and similar involve a check of VM_WRITE, and return an erro=
r
> > if VM_WRITE is set. Trying to use `try_clear_maywrite` without checking
> > the return value results in a compilation error because the `Result`
> > type is marked #[must_use].
>
> This is nice.
>
> Though note that, it is explicitly not permitted to permit writability fo=
r
> a VMA that previously had it disallowed, and we explicitly WARN_ON() this
> now. Concretely that means a VMA where !(vma->vm_flags & VM_MAYWRITE), yo=
u
> must not vma->vm_flags |=3D VM_MAYWRITE.

Got it. The API here doesn't allow that, but good to know we can't add
it in the future.

> > For now, there's only a method for VM_MIXEDMAP and not VM_PFNMAP. When
> > we add a VM_PFNMAP method, we will need some way to prevent you from
> > setting both VM_MIXEDMAP and VM_PFNMAP on the same vma.
>
> Yes this would be unwise.
>
> An aside here - really you should _only_ change flags in this hook (perha=
ps
> of course also initialising vma->vm_private_data state), trying to change
> anything _core_ here would be deeply dangerous.
>
> We are far too permissive with this right now, and it's something we want
> to try ideally to limit in the future.

The previous version just had a function called "set_flags" that could
be used to set any flags you want. Given Jann's feedback, I had
restricted it to only allow certain flag changes.

> > Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> > ---
> >  rust/kernel/mm/virt.rs | 169 +++++++++++++++++++++++++++++++++++++++++=
+++++++-
> >  1 file changed, 168 insertions(+), 1 deletion(-)
> >
> > diff --git a/rust/kernel/mm/virt.rs b/rust/kernel/mm/virt.rs
> > index de7f2338810a..22aff8e77854 100644
> > --- a/rust/kernel/mm/virt.rs
> > +++ b/rust/kernel/mm/virt.rs
> > @@ -6,7 +6,7 @@
> >
> >  use crate::{
> >      bindings,
> > -    error::{to_result, Result},
> > +    error::{code::EINVAL, to_result, Result},
> >      page::Page,
> >      types::Opaque,
> >  };
> > @@ -148,6 +148,173 @@ pub fn vm_insert_page(&self, address: usize, page=
: &Page) -> Result {
> >      }
> >  }
> >
> > +/// A builder for setting up a vma in an `mmap` call.
>
> Would be better to explicitly reference the struct file_operations->mmap(=
)
> hook and to say that we should only be updating flags and vm_private_data
> here (though perhaps not worth mentioning _that_ if not explicitly expose=
d
> by your interface).

I guess also vm_ops?

> I'm guessing fields are, unless a setter/builder is established, immutabl=
e?

If you have a mutable reference, you can always modify fields. When
you don't want that, fields are made private.

> > +    /// Internal method for updating the vma flags.
> > +    ///
> > +    /// # Safety
> > +    ///
> > +    /// This must not be used to set the flags to an invalid value.
> > +    #[inline]
> > +    unsafe fn update_flags(&self, set: vm_flags_t, unset: vm_flags_t) =
{
> > +        let mut flags =3D self.flags();
> > +        flags |=3D set;
> > +        flags &=3D !unset;
> > +
> > +        // SAFETY: This is not a data race: the vma is undergoing init=
ial setup, so it's not yet
> > +        // shared. Additionally, `VmAreaNew` is `!Sync`, so it cannot =
be used to write in parallel.
> > +        // The caller promises that this does not set the flags to an =
invalid value.
> > +        unsafe { (*self.as_ptr()).__bindgen_anon_2.vm_flags =3D flags =
};
>
> Hm not sure if this is correct. We explicitly maintain a union in struct =
vm_area_struct as:
>
>         union {
>                 const vm_flags_t vm_flags;
>                 vm_flags_t __private __vm_flags;
>         };
>
> Where vma->vm_flags is const, and then use helpers like vm_flags_init() t=
o
> set them, which also do things like assert locks (though not in the init
> case, of course).
>
> So erally we should at least be updating __vm_flags here, though I'm not
> sure how bindgen treats it?

I don't think using vm_flags vs __vm_flags changes anything on the
Rust side. The modifications are happening unsafely through a raw
pointer to something inside Opaque, so Rust isn't going to care about
stuff like your const annotation; it's unsafe either way.

I'll update this to use __vm_flags instead.

> > +    /// Try to clear the `VM_MAYREAD` flag, failing if `VM_READ` is se=
t.
> > +    ///
> > +    /// This flag indicates whether userspace is allowed to make this =
vma readable with
> > +    /// `mprotect()`.
> > +    #[inline]
> > +    pub fn try_clear_mayread(&self) -> Result {
> > +        if self.get_read() {
> > +            return Err(EINVAL);
> > +        }
>
> This is quite nice! Strong(er) typing for the win, again :>)

:)

Alice

