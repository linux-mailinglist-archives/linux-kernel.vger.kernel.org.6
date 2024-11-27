Return-Path: <linux-kernel+bounces-423699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7B959DAB9E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 17:17:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98C3A281105
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 16:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3772200B95;
	Wed, 27 Nov 2024 16:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KVsGd87q"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7846F1FE45B
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 16:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732724259; cv=none; b=NmmwhWqBAUXJrXVwgvvrY9PSLuMs/+MRTTW4i/a/4bHpaHr1lbwm1e5qIm0NMkqCW0jVUo6ZcDJ6ek14TjDInurH3W4WGFa0jjt8eKbOoJKvWigciXr+2Idolbf1vdwjKP05RouTl+GXJclUxaQqUWvEXN+vYLA5KBcBlduz0F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732724259; c=relaxed/simple;
	bh=7STCVhprixM7tc3z0rAW0i4uBFwhGRrBfI6ydfiJfl4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QjbfBNxwiuDySe/ZjxIjEnnnjuFudBeZEJohQJkvZ1SL/GSZ/HGcyiWHUnZLmP0xbJdHPO7B9cEoEPiGAsdBfs+gqynTxlNsI0A4dVCRl17dAGie5y2HVW4/EDJkjZE09MVE+8HCDAkHJXonyx/Sr6t8S55O1UOgZWPHRLWVCC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KVsGd87q; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5d027dc53ccso10290a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 08:17:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732724256; x=1733329056; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QZfqcNlPKbC2bnXSpyLfxx/nYb9jLK1fIKJvCta3m5I=;
        b=KVsGd87qTVxgu21bFhhIBzzUstll9sU5bDSkP/82I0qKUGekVFpox1wujek7V41oU8
         QzNV+DNJe+hIkC9t1A6ASFv1w0zKbdaqFfSsdb4i6oqavY1kVa3Lv8MYNr91+wMtEIC1
         IrxacyLPX0VQ2VellhEaIQbrLGP0pm5+93a9yrrHvhXP0vo4J+oXd4QcoMocaEsR3js7
         qoInwwbrBzOID0nPK07YqPPe1XRMu0o7MAGkR3BuB0QVDiaCz9kRZMHfvqRrl2cXbEZd
         mX9kFFpufgH/kzS/eQHN7NNyXvsmb+m7IyEat6mTQ/RRCGK+n0jSfmYx63SeL8HiT/NZ
         6hKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732724256; x=1733329056;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QZfqcNlPKbC2bnXSpyLfxx/nYb9jLK1fIKJvCta3m5I=;
        b=RzlABabEkIz2gKkBdyYXmw0zd61NWbZL8zJcEbvc+70NxmC3M8/fRBSq1CDYonDiN1
         xI+KThFPphvrrfDAEvvfAq9yKEhEvTuobNWV9KWC6x3JoAUgimlokYUwuII/dZZZvIu1
         S6KCJJ/err5Hvx/tYUgEl6smKgyrs2M0wC0DkMDzKvN/xDAuj6ueTr0p1iqwq3sU32mD
         KtwY0cRVdLuLSImUHySFvuYOWmS/WiTkFYKeE2A8d4/ITTOwwffU+F7dz5fjFKrquPxk
         SH6VNo7b7lFsqRx4OVfvEvaT6PN3kkfAeIgZ4qjvrewkOo83AstCg2B88N2CLptzKtWi
         x1ZA==
X-Forwarded-Encrypted: i=1; AJvYcCWZ2PezsGPSqPIopXTDQ46xghn4M7CsqKD7xQ0tUBjfS9g9fpP90TpPMjkrFFifbHRda4D/D39QgAus+34=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUMDTzw1ek5Zd/xIHqQXBFa44iRMFoQfSUKEPcLZJVje4C5Vpg
	52zROaXFnzwyE/grHZqaBh57j9Zums0wipy4AuUrXcjlIbYMwwnABND9YJpdLafDl0UpnT4Owjx
	mOqAFGVlgBfAnYyCEE26EUMVvrjuPkYiwNs2J
X-Gm-Gg: ASbGncuMTShlozfIUzTdA+JxARdNBzv6ExaCoQ8b2Av5R4RDj75UzzszPAT9Q6KIyw2
	ngtBxWLGqI0rCReoFjgqfYzA6mtlZK2VMuMTpK9sejzhpxLkEB+ncXd7CoOw=
X-Google-Smtp-Source: AGHT+IFi4sjpJs/jiGm3WsRPclEJPb0VqSZyAZ6190zFqKsFlA1P7nnjtHWJJrmYhsCdQtveOqxd0wwWr/r4zunc7EQ=
X-Received: by 2002:aa7:cacf:0:b0:5cf:c93f:36f3 with SMTP id
 4fb4d7f45d1cf-5d08356e19bmr84170a12.7.1732724255341; Wed, 27 Nov 2024
 08:17:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241122-vma-v9-0-7127bfcdd54e@google.com> <20241122-vma-v9-2-7127bfcdd54e@google.com>
 <CAG48ez28kzjrvMN66Yp9n+WziPzE5LU_Y320405Q=PoOzdzStg@mail.gmail.com>
 <CAH5fLggh7HeOm8wGZH=hnR+SyPoW8Hik3uy4RodibyjY1UT36w@mail.gmail.com>
 <CAG48ez0QmQ7s_MmPj3Q9joEvGSkr9DUWoeJ6dvD=6icq+3DwKQ@mail.gmail.com> <CAH5fLgiO3ovUhcaPPukM9KeaDZzA+6CKPH8wNHKFUD4rY_EC=Q@mail.gmail.com>
In-Reply-To: <CAH5fLgiO3ovUhcaPPukM9KeaDZzA+6CKPH8wNHKFUD4rY_EC=Q@mail.gmail.com>
From: Jann Horn <jannh@google.com>
Date: Wed, 27 Nov 2024 17:16:59 +0100
Message-ID: <CAG48ez01i=7W83VPr+enxpZKJVmx9vZTv_TBj4cuSek9r2ihTQ@mail.gmail.com>
Subject: Re: [PATCH v9 2/8] mm: rust: add vm_area_struct methods that require
 read access
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	John Hubbard <jhubbard@nvidia.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Arnd Bergmann <arnd@arndb.de>, Christian Brauner <brauner@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	rust-for-linux@vger.kernel.org, Andreas Hindborg <a.hindborg@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 27, 2024 at 4:46=E2=80=AFPM Alice Ryhl <aliceryhl@google.com> w=
rote:
>
> On Wed, Nov 27, 2024 at 4:41=E2=80=AFPM Jann Horn <jannh@google.com> wrot=
e:
> >
> > On Wed, Nov 27, 2024 at 1:01=E2=80=AFPM Alice Ryhl <aliceryhl@google.co=
m> wrote:
> > > On Tue, Nov 26, 2024 at 11:10=E2=80=AFPM Jann Horn <jannh@google.com>=
 wrote:
> > > >
> > > > On Fri, Nov 22, 2024 at 4:41=E2=80=AFPM Alice Ryhl <aliceryhl@googl=
e.com> wrote:
> > > > > This adds a type called VmAreaRef which is used when referencing =
a vma
> > > > > that you have read access to. Here, read access means that you ho=
ld
> > > > > either the mmap read lock or the vma read lock (or stronger).
> > > > >
> > > > > Additionally, a vma_lookup method is added to the mmap read guard=
, which
> > > > > enables you to obtain a &VmAreaRef in safe Rust code.
> > > > >
> > > > > This patch only provides a way to lock the mmap read lock, but a
> > > > > follow-up patch also provides a way to just lock the vma read loc=
k.
> > > > >
> > > > > Acked-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com> (for mm bi=
ts)
> > > > > Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> > > >
> > > > Reviewed-by: Jann Horn <jannh@google.com>
> > >
> > > Thanks!
> > >
> > > > with one comment:
> > > >
> > > > > +    /// Zap pages in the given page range.
> > > > > +    ///
> > > > > +    /// This clears page table mappings for the range at the lea=
f level, leaving all other page
> > > > > +    /// tables intact, and freeing any memory referenced by the =
VMA in this range. That is,
> > > > > +    /// anonymous memory is completely freed, file-backed memory=
 has its reference count on page
> > > > > +    /// cache folio's dropped, any dirty data will still be writ=
ten back to disk as usual.
> > > > > +    #[inline]
> > > > > +    pub fn zap_page_range_single(&self, address: usize, size: us=
ize) {
> > > > > +        // SAFETY: By the type invariants, the caller has read a=
ccess to this VMA, which is
> > > > > +        // sufficient for this method call. This method has no r=
equirements on the vma flags. Any
> > > > > +        // value of `address` and `size` is allowed.
> > > >
> > > > If we really want to allow any address and size, we might want to a=
dd
> > > > an early bailout in zap_page_range_single(). The comment on top of
> > > > zap_page_range_single() currently says "The range must fit into one
> > > > VMA", and it looks like by the point we reach a bailout, we could h=
ave
> > > > gone through an interval tree walk via
> > > > mmu_notifier_invalidate_range_start()->__mmu_notifier_invalidate_ra=
nge_start()->mn_itree_invalidate()
> > > > for a range that ends before it starts; I don't know how safe that =
is.
> > >
> > > I could change the comment on zap_page_range_single() to say:
> > >
> > > "The range should be contained within a single VMA. Otherwise an erro=
r
> > > is returned."
> > >
> > > And then I can add an overflow check at the top of
> > > zap_page_range_single(). Sounds ok?
> >
> > Yes, I think changing the comment like that and adding a check for
> > whether address+size wraps around there addresses this.
>
> Can there be a page at the top of the address space? If so, I have to
> be a bit careful in the wrap-around check, because it should only fail
> if the addition wraps around *and* the sum is non-zero.

Uh, good question... I can't think of any architectures that have
userspace mappings right at the top of the address space, and having
objects allocated right at the end of the address space would violate
the C standard (because C guarantees that pointers pointing directly
behind an array behave reasonably, and this would not work if a
pointer pointing directly behind an array could wrap around to NULL).
And unless the userspace allocator takes responsibility for enforcing
this edge case, the kernel has to do it by preventing the last page of
the virtual address space from being mapped. (This is the reason why a
32-bit process on an arm64 kernel is normally only allowed to map
addresses up to 0xfffff000, see
<https://git.kernel.org/linus/d263119387de>.)

Allowing userspace to map the top of the address space would also be a
bad idea because then ERR_PTR() could return valid userspace pointers.

Looking at the current implementation of zap_page_range_single(), in
the case you're describing, unmap_single_vma() would get called with
end_addr=3D=3D0, and then we'd bail out on the "if (end <=3D vma->vm_start)=
"
check. So calling zap_page_range_single() on such a range would
already fail.

