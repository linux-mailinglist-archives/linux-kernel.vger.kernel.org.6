Return-Path: <linux-kernel+bounces-425511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 209879DC30C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 12:44:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67A16B209EE
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 11:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C83B1199FDE;
	Fri, 29 Nov 2024 11:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c6X3XaTz"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632EE199FAF
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 11:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732880666; cv=none; b=D5z3Z7lfbwHoOCHdeS7DNGmICU4S3ep3jZ43dr93NoTpKeOz5dsOYvaD1rPrRMhiADLScSHRo3Glqj9Iqs24MvsB0HwkdAK5PMBN5sW83N6yLZVZgcCoEHoHfVYx2iVm4ZARn46ILnz9Mn/BH3jTP51hnNDJKi0mFjgUvYUmdxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732880666; c=relaxed/simple;
	bh=3sAs6F81cANeFF9ASZzbDRGXFDC2tykN+Iczubr0H60=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RibWweW80q5T0vq3+J3twXgSatfOmAyh5mEOUQBUKQFpeB4fIOhco2R1sKY2Vt+sIKaJWpdIDRh5oAjW28CWb/ggL1k6ALDa3t/UBRwtRNvwAIxg1Py6SxM2OXcWKDspdYbiXwv4zqYIJgJcu8XUjMu4A3OUAn59yQDNiGZLnUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c6X3XaTz; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-382296631f1so1540973f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 03:44:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732880663; x=1733485463; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OQ73yuMOKPHbjjTrctlmL2Ii8jjSbh3c7dyfWFA6sg0=;
        b=c6X3XaTz2k7qXCy6idwNn3sylWmxJyflZQFCtVjCPK4TeQ82hybcFQg2jWZJhrnqpj
         FO73JczbT/xe1RmtmLiXLO6Shfdg5fkXcr7Gk3XhkSiV8qcZWdT4nu9h5933+PSftAU8
         a53mS/l3WtF74SypxpDZvfYX3THGC7Mju9K39/nthmZ0dXXkBD3dygB2t+NauoPS0g3H
         1P0LLgmfSjoNn+WT8E3r7OItljgShUF+RwFdBUB0+lV412rFjW8FOKfXptME74+BeLId
         Gko8HJYgCKTUPfOeLzEpCVVwjUye8SVHamWNjrppXJ2MUKO9zWtG8/SdMMCTf+os6qQP
         3vrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732880663; x=1733485463;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OQ73yuMOKPHbjjTrctlmL2Ii8jjSbh3c7dyfWFA6sg0=;
        b=meH27vMKO7bs8mhBkwjFE51/LZRYiBEi1EmUNiMiclSmaStjJa76CKsTPnD5QoSZNy
         rNd/KbxHMzkCoT4JDfuYg7IevkZ+ibPvp4GtYO6P1Rlg0BzUTivQW2PbdTeM3/MSJEvd
         lScXY84yJZzuPW4VtNnhBQDi/Q1zhul3QeZRDzRUtAsi0CS5P8ddbV2tKPpY6yC8LgXI
         nn8c1lctyo645u5uGLzTzR/B/3NZEhQR4C4MgX9xNjPntOevrk+YSZrGiwb9cM+c043Z
         wUQrhlClGs8hQRvtoQyfrnna3m+pxkf+ZP7gVMZghHsVt0FUhE8qwvCjZL2T9Q4QM+bA
         UTcg==
X-Forwarded-Encrypted: i=1; AJvYcCWFdKZjEXerm5HmWHagiM0ADM9uPRt4vymrzzAlhcGkNUlA9Z7nscYyDZAwKntr50k9+PQO3ZUTXLCkTpw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFXw22pQRbyYxO4+TIH0AKaapXDL/+OF2A8fRnUqQ6svKmY+9+
	lR2OZTakT5eVFmkIdmB9VKOOSLwIXlQ2phmlXlCP+qhaOgW82Bl7FOsx33B8XJrdo9gOcK5Ltai
	2wPpJcwmutMtUKN5oa50Gp5ANOaJku46QHFLd
X-Gm-Gg: ASbGncvQAZc3cpvK86LkFHLrbyN+8Fs9kVgYnxFX0XkwYI1Akn1guQxd+4jRPnUuIk8
	HSFzASGGUcYGVjyGSiek1VZYtKjbd0mbe1R92vefsQWzsFGqfeMASvet8MlamyQ==
X-Google-Smtp-Source: AGHT+IGVnUklndpXhdyscMxG8htYeF72cv7+U9W4dYUy8Ks1XP/gpsHYY0FVa0X3H1aDKz7Spt7IggS5LohLKWzjv4I=
X-Received: by 2002:a05:6000:1547:b0:382:4a8e:b81c with SMTP id
 ffacd0b85a97d-385c6ec0fefmr10140400f8f.33.1732880662644; Fri, 29 Nov 2024
 03:44:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241122-vma-v9-0-7127bfcdd54e@google.com> <20241122-vma-v9-2-7127bfcdd54e@google.com>
 <CAG48ez28kzjrvMN66Yp9n+WziPzE5LU_Y320405Q=PoOzdzStg@mail.gmail.com>
 <CAH5fLggh7HeOm8wGZH=hnR+SyPoW8Hik3uy4RodibyjY1UT36w@mail.gmail.com> <CAG48ez0QmQ7s_MmPj3Q9joEvGSkr9DUWoeJ6dvD=6icq+3DwKQ@mail.gmail.com>
In-Reply-To: <CAG48ez0QmQ7s_MmPj3Q9joEvGSkr9DUWoeJ6dvD=6icq+3DwKQ@mail.gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 29 Nov 2024 12:44:10 +0100
Message-ID: <CAH5fLgieAEKQt9CyjgFWYQBpy-651SpEU-qoYM2ORtJH9w5=Yg@mail.gmail.com>
Subject: Re: [PATCH v9 2/8] mm: rust: add vm_area_struct methods that require
 read access
To: Jann Horn <jannh@google.com>
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

On Wed, Nov 27, 2024 at 4:41=E2=80=AFPM Jann Horn <jannh@google.com> wrote:
>
> On Wed, Nov 27, 2024 at 1:01=E2=80=AFPM Alice Ryhl <aliceryhl@google.com>=
 wrote:
> > On Tue, Nov 26, 2024 at 11:10=E2=80=AFPM Jann Horn <jannh@google.com> w=
rote:
> > >
> > > On Fri, Nov 22, 2024 at 4:41=E2=80=AFPM Alice Ryhl <aliceryhl@google.=
com> wrote:
> > > > This adds a type called VmAreaRef which is used when referencing a =
vma
> > > > that you have read access to. Here, read access means that you hold
> > > > either the mmap read lock or the vma read lock (or stronger).
> > > >
> > > > Additionally, a vma_lookup method is added to the mmap read guard, =
which
> > > > enables you to obtain a &VmAreaRef in safe Rust code.
> > > >
> > > > This patch only provides a way to lock the mmap read lock, but a
> > > > follow-up patch also provides a way to just lock the vma read lock.
> > > >
> > > > Acked-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com> (for mm bits=
)
> > > > Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> > >
> > > Reviewed-by: Jann Horn <jannh@google.com>
> >
> > Thanks!
> >
> > > with one comment:
> > >
> > > > +    /// Zap pages in the given page range.
> > > > +    ///
> > > > +    /// This clears page table mappings for the range at the leaf =
level, leaving all other page
> > > > +    /// tables intact, and freeing any memory referenced by the VM=
A in this range. That is,
> > > > +    /// anonymous memory is completely freed, file-backed memory h=
as its reference count on page
> > > > +    /// cache folio's dropped, any dirty data will still be writte=
n back to disk as usual.
> > > > +    #[inline]
> > > > +    pub fn zap_page_range_single(&self, address: usize, size: usiz=
e) {
> > > > +        // SAFETY: By the type invariants, the caller has read acc=
ess to this VMA, which is
> > > > +        // sufficient for this method call. This method has no req=
uirements on the vma flags. Any
> > > > +        // value of `address` and `size` is allowed.
> > >
> > > If we really want to allow any address and size, we might want to add
> > > an early bailout in zap_page_range_single(). The comment on top of
> > > zap_page_range_single() currently says "The range must fit into one
> > > VMA", and it looks like by the point we reach a bailout, we could hav=
e
> > > gone through an interval tree walk via
> > > mmu_notifier_invalidate_range_start()->__mmu_notifier_invalidate_rang=
e_start()->mn_itree_invalidate()
> > > for a range that ends before it starts; I don't know how safe that is=
.
> >
> > I could change the comment on zap_page_range_single() to say:
> >
> > "The range should be contained within a single VMA. Otherwise an error
> > is returned."
> >
> > And then I can add an overflow check at the top of
> > zap_page_range_single(). Sounds ok?
>
> Yes, I think changing the comment like that and adding a check for
> whether address+size wraps around there addresses this.

Hmm. Looking at this again now ...

For one, the function returns void so we can at best handle overflow
by performing a no-op.

Another question is, are we actually okay to call it with ranges
outside the vma? Does that just no-op or what? Maybe the Rust side
should just bail out early if the address range is not a subset of the
vma?

Alice

