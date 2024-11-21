Return-Path: <linux-kernel+bounces-416840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E28E9D4AF8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 11:38:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB7DAB22685
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 10:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A566C1CFEDC;
	Thu, 21 Nov 2024 10:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DxCpHUf+"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C571CB9F9
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 10:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732185524; cv=none; b=RBD0mwBpckD3HiT9SSOXgf9YAf/MGZOB5q3hA/R0OH1uNipggMcs37QVfl5ZWEoPxAkEln+cmjjOQtgHwRIrf8eaCMb4tAUOmTTD715hMoKCEHnXm1M+TEk+d1UCgswcFLuYfyJJcEsP3nSy5GEdo6LwGAHti4Iv1mA9uXuCZlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732185524; c=relaxed/simple;
	bh=vp3VGL7tickCp/AxyyI05CAA0XadUYs0FF+9ilokDbY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BVfO8S6PjiylmhwkA9tpusTUNWqvgXCZuQz2//SCeAjoOMwcr9XUo6dDdt1rZIHidXCNtSUYszjRJ7Z/IxwUrxAPfBns+IkOzxuIfxxkfnjCZUdJd8T0tjjUpNfffDA4NUTYIRqzpE2FMaR38XmZ1O2QVfWFQbcGAGq1ZgWh7Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DxCpHUf+; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-382442b7d9aso627724f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 02:38:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732185521; x=1732790321; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=arZzzZcZ/LicC2e7GiApVwWtVcvvhGlrT9lVaNGL8IU=;
        b=DxCpHUf+FnaL0BQy2snW4r33282iu+evk07YKkSe8Ia7X+5nYzHPm8aME+nUvHPYwV
         Xj3o7AOhuxCXvgTt0yBaaczbtLPqRb9U1WQsfvLsoelblkor5A/YrkqNlvp3mw/43bPD
         rNkgWshapORvOMrVLfJB4AjynEy2ilco43urjw9rgo/XwSyMvb/BwvWTcKvfErWcyJeL
         G9jXKqfV7Sf6I4zOI7yVJgdVF7FP5HvuIOMQOvVsg2Rgx4f23Vw2C2tS+xElNRLpEV/6
         zSgGjRldkBmWZHasxUfc0jO5ma1MhWgMO3BNAj01m3izmjqQK3XlBvdh/d3e/1wNoAN+
         wFKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732185521; x=1732790321;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=arZzzZcZ/LicC2e7GiApVwWtVcvvhGlrT9lVaNGL8IU=;
        b=iMvEWYlUahfW5nL5nqAghkUAaulSoso6nf1suk0RXCu8XrVDBOhetAWeyCawc1R4p8
         1tyDSWXFJc9Jaw4s5EPmZIXHvrWvEneipBzO8vX9PUc++D9J10weyS4dix39/N283MC/
         yUwtbV6m7u9QrTqmOpEgT6SzQYrwrzJqjQ1uxcRzK5y84n7vDsVLWUTTwe/BaLA6RD84
         rxmae7NnR2NSR78rD10ILJYlKndZ8Zloc+alJsymJXzGKuaNoKd8IkjrlWElb8JtzFf2
         XSd1OmQDLoisEVylSvs9HHK5jrvV/+VvrDWkYrwlEdedCNOyPIAG/JBoHSuEjH6IsySU
         31WQ==
X-Forwarded-Encrypted: i=1; AJvYcCW8oWZyeXKw3SZW/Ln7Wq/Hehe1mQkl153yRWmJ/ylvel+/9PI4crVB75Q5g4rlu7Pw0sw8JKaB5bdfI0A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeXchyA3P+AX/cW/o0n6unawri0xyIR5PGY960zA+Yd3WyPyOg
	YE5r5lRujnTLroEZKl89sKMvOrsmvjKov/hdqCi7Qbf8PlVeRTXRAS4qze4neTiQwIIuxh74vmM
	49QC0Zx8Pq1/oGkpZmj9yeiiq1ieiklsdwp0l
X-Gm-Gg: ASbGncsphpz0GiB8WB91qeM7s3a4an2XEUtyuJK9QUBhElV/Emjx45RCUdCoAMTCN5r
	wi4URMZtjN/LR5jo12WUc56JbBVO4JRErHFMt6GSCX1CJvKDkH3Aq9ef4+IPILQ==
X-Google-Smtp-Source: AGHT+IFKTxfTP/8V3NQnXKNt4YPbwdTYjvzZyWn+f6dBturud/k7FjFa3YKKktaiCpaNOinmPJqBmsBuDnracNpZ2O8=
X-Received: by 2002:a05:6000:178a:b0:382:59c1:ccdf with SMTP id
 ffacd0b85a97d-38259c1ccecmr2210664f8f.46.1732185521340; Thu, 21 Nov 2024
 02:38:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241120-vma-v8-0-eb31425da66b@google.com> <20241120-vma-v8-3-eb31425da66b@google.com>
 <e5660b41-c1df-47f1-83fa-c243805f74cf@lucifer.local>
In-Reply-To: <e5660b41-c1df-47f1-83fa-c243805f74cf@lucifer.local>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 21 Nov 2024 11:38:29 +0100
Message-ID: <CAH5fLgjsk_t=tQdAkB6O3cCDZQp2TC=uSB3EUsY_4qDegpVEYw@mail.gmail.com>
Subject: Re: [PATCH v8 3/7] mm: rust: add vm_insert_page
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Jann Horn <jannh@google.com>
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

On Wed, Nov 20, 2024 at 8:20=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Wed, Nov 20, 2024 at 02:49:57PM +0000, Alice Ryhl wrote:
> > The vm_insert_page method is only usable on vmas with the VM_MIXEDMAP
> > flag, so we introduce a new type to keep track of such vmas.
>
> Worth mentioning that it can be used for VMAs without this flag set, but =
if
> so we must hold a _write_ lock to be able to do so, so it can update the
> flag itself, however we intend only to use it with VMAs which already hav=
e
> this flag set.

I got the impression from Jann that the automatically-set-VM_MIXEDMAP
thing should only be used during mmap, and that VM_MIXEDMAP should not
get set after initialization even with a write lock?
https://lore.kernel.org/all/CAG48ez3gXicVYXiPsQDmYuPSsKMbES2KRQDk+0ANWSS0zD=
kqSw@mail.gmail.com/

> > The approach used in this patch assumes that we will not need to encode
> > many flag combinations in the type. I don't think we need to encode mor=
e
> > than VM_MIXEDMAP and VM_PFNMAP as things are now. However, if that
> > becomes necessary, using generic parameters in a single type would scal=
e
> > better as the number of flags increases.
> >
> > Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> > ---
> >  rust/kernel/mm/virt.rs | 68 ++++++++++++++++++++++++++++++++++++++++++=
+++++++-
> >  1 file changed, 67 insertions(+), 1 deletion(-)
> >
> > diff --git a/rust/kernel/mm/virt.rs b/rust/kernel/mm/virt.rs
> > index 1e755dca46dd..de7f2338810a 100644
> > --- a/rust/kernel/mm/virt.rs
> > +++ b/rust/kernel/mm/virt.rs
> > @@ -4,7 +4,14 @@
> >
> >  //! Virtual memory.
> >
> > -use crate::{bindings, types::Opaque};
> > +use crate::{
> > +    bindings,
> > +    error::{to_result, Result},
> > +    page::Page,
> > +    types::Opaque,
> > +};
> > +
> > +use core::ops::Deref;
> >
> >  /// A wrapper for the kernel's `struct vm_area_struct` with read acces=
s.
> >  ///
> > @@ -80,6 +87,65 @@ pub fn zap_page_range_single(&self, address: usize, =
size: usize) {
> >              )
> >          };
> >      }
> > +
> > +    /// Check whether the `VM_MIXEDMAP` flag is set.
> > +    #[inline]
> > +    pub fn check_mixedmap(&self) -> Option<&VmAreaMixedMap> {
>
> Nitty + a little bikesheddy (this may be my mistake as I am unfamiliar wi=
th
> rust idioms also) but shouldn't this be 'as_mixedmap_vma()' or something?

You're probably right that this name is more consistent with Rust
naming conventions. :)

> > +        if self.flags() & flags::MIXEDMAP !=3D 0 {
> > +            // SAFETY: We just checked that `VM_MIXEDMAP` is set. All =
other requirements are
> > +            // satisfied by the type invariants of `VmAreaRef`.
> > +            Some(unsafe { VmAreaMixedMap::from_raw(self.as_ptr()) })
> > +        } else {
> > +            None
> > +        }
> > +    }
> > +}
> > +
> > +/// A wrapper for the kernel's `struct vm_area_struct` with read acces=
s and `VM_MIXEDMAP` set.
> > +///
> > +/// It represents an area of virtual memory.
> > +///
> > +/// # Invariants
> > +///
> > +/// The caller must hold the mmap read lock or the vma read lock. The =
`VM_MIXEDMAP` flag must be
> > +/// set.
> > +#[repr(transparent)]
> > +pub struct VmAreaMixedMap {
> > +    vma: VmAreaRef,
> > +}
> > +
> > +// Make all `VmAreaRef` methods available on `VmAreaMixedMap`.
> > +impl Deref for VmAreaMixedMap {
> > +    type Target =3D VmAreaRef;
> > +
> > +    #[inline]
> > +    fn deref(&self) -> &VmAreaRef {
> > +        &self.vma
> > +    }
> > +}
>
> Ah OK, thinking back to the 'impl Deref' from the other patch, I guess th=
is
> allows you to deref VmAreaMixedMap as a VmAreaRef, does it all sort of
> automagically merge methods for you as if they were mix-ins then?

Yeah, I use it to "merge" the method sets to avoid duplication.

The main limitation is that you can only deref to one other type, so
you can't have "diamond inheritance".

> > +impl VmAreaMixedMap {
> > +    /// Access a virtual memory area given a raw pointer.
> > +    ///
> > +    /// # Safety
> > +    ///
> > +    /// Callers must ensure that `vma` is valid for the duration of 'a=
, and that the mmap read lock
> > +    /// (or stronger) is held for at least the duration of 'a. The `VM=
_MIXEDMAP` flag must be set.
> > +    #[inline]
> > +    pub unsafe fn from_raw<'a>(vma: *const bindings::vm_area_struct) -=
> &'a Self {
> > +        // SAFETY: The caller ensures that the invariants are satisfie=
d for the duration of 'a.
> > +        unsafe { &*vma.cast() }
> > +    }
> > +
> > +    /// Maps a single page at the given address within the virtual mem=
ory area.
> > +    ///
> > +    /// This operation does not take ownership of the page.
> > +    #[inline]
> > +    pub fn vm_insert_page(&self, address: usize, page: &Page) -> Resul=
t {
>
> I'm guessing this 'Result' type encodes 0 vs. -Exxx error codes?

In this particular case, yes.

More generally, Result is a discriminated union containing either
Ok(val) for success or Err(err) with some error type. But the default
success type is the unit type () and the default error type is
kernel::error::Error which corresponds to errno numbers.

In this case, the compiler is clever enough to not use a discriminated
union and instead represents Ok(()) as 0 and Err(err) as just the
negative errno. This works since kernel::error::Error uses NonZeroI32
as its only field (as of 6.13).

> > +        // SAFETY: The caller has read access and has verified that `V=
M_MIXEDMAP` is set. The page
> > +        // is order 0. The address is checked on the C side so it can =
take any value.
> > +        to_result(unsafe { bindings::vm_insert_page(self.as_ptr(), add=
ress as _, page.as_ptr()) })
> > +    }
> >  }
>
> It's really nice to abstract this as a seprate type and then to know its
> methods only apply in known circumstances... I guess in future we can use
> clever generic types when it comes to combinations of characteristics tha=
t
> would otherwise result in a combinatorial explosion?

Yeah, so the alternate approach I mention in the commit message would
be to have something like this:

struct VmAreaRef<const MIXEDMAP: bool, const PFNMAP: bool, const
MAYWRITE: bool> { ... }

listing all the flags we care about. This way, we get 2^3 different
types by writing just one.

(There are a few different variations on how to do this, instead of
bools, we may want to allow three options: true, false, unknown.)

Alice

