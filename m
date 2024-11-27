Return-Path: <linux-kernel+bounces-423654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3299A9DAAF1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 16:46:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4899DB21157
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 15:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DFA020010C;
	Wed, 27 Nov 2024 15:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hVymYqjI"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A0B322A
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 15:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732722371; cv=none; b=ofRqNQlrfSCaVSOEH/KWwxTdbxw6wlr5PgPO/xSLhzOZpRohrjQYFY9E5qk/t/3isDNX2oAcpmsIGEy5lzh4aEykW9NEKtK4es1QBhFfGECrg8SHI4fPmF6pec5oNlJ072YoQaARphIZL2e+wkVaaVk4msbLxY6HrFU/I/g17sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732722371; c=relaxed/simple;
	bh=B+jmqfrWM/EKvpF2u1XZ28ibHwrKj9SwMDV1NimB9CE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b1UyQr1KWZozC8R/u82vB9OKY7CSjYcHNPvmpCIiK14g2z0VKzhJGGp6EU65biVtPYgM/itXIh5lVzhLVHThcXbtGe6ZBN1ckMpFiLWwy8Zotj1bccChhuRo8/eum66SKuO7hmyVT3PrqmA3FJ00rjls1uejSpwhWMpQDmCZ4hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hVymYqjI; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-38232cebb0cso5231738f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 07:46:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732722368; x=1733327168; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PXMPfZWRhjLS8qOrb4f6pSt8s/tpQyEcD7eDM+Hjasg=;
        b=hVymYqjIqLOzGY2p4xd2AkszAYUFwv8MLg2vaqqb9rlDlJQ4Fd2RNFaGgq6ZR4/dRZ
         ayaI0UufX/cLNoawkvs+LkvxW96CMAj/zUQuB7PVo5wEeQxY0fj0g8vSDntPr+5VIeAP
         Vub4J9yRMkmeME+oinV+qQNqjqsa8518Jt6ufi65S7qAag+Mga3ayqsupfYI4ce3KNBd
         YSg8mvhNoYlUwDxA7z129cPaGDRJgLZjUOXxCFn8W5FxiabLwZvypE8NH571S4hDGgoD
         WrCwpfgtXbFniEbcZOCHtpF+Yq4EK4UP/tMciq/sske5U4ZK+RYSpKRoek+jmXJ/hGC4
         pPVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732722368; x=1733327168;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PXMPfZWRhjLS8qOrb4f6pSt8s/tpQyEcD7eDM+Hjasg=;
        b=FpR1LTqqjcWhsdznxvjN8nqXfUScDw2cESF9khzjlq83YUXFhQ2C1Y6+Ux5VEpvb9d
         za7gpVtNjdcuQ88DFZW3CAaQTzQE3rgG4shcfB1SD591shNewHVTZMQE8b7JC0uOmBxX
         qyh5F39GZ5zvK3mEWkHCqwM/T9kWsYjiwjYvoJ/mJafctKwt6id//VjRg/TTsuKBh9xz
         yyQIsBFKpRp6/xRCad11CjENi9MznZSy8q7AJQKt2nvAjPWgD/y+4PnKIYzFgQoa8hh4
         wAQhB/54I3TCNB+mBOBpbKBvv4nwn9pYdAghhqqPheiQKq/26ujvm0ixRYmGNP9+O1U6
         pBQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPiqtfY2XY9dBLeQDmtgYTirhwPfPkXMP7/Z60Gt9ZzIrnP/KgDG7qiAdaSGrM1o7Q+UuHbyiUHOkWLC8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6rofNojHsfgKXz2NFAcgYyCV2FOtP4wfPMtDxPIHex3eiiyNn
	lq/Wgd2SQu8gJaZzrfe8xRODyAYdBGjvT6W4ghY/Xk1f1mWH2NcshtRMDpV80YJB2z5OSPeE5j8
	Cb2Ck+o++sED5RVzRyNeeh/ZZxtvVVXuneqdQ
X-Gm-Gg: ASbGncs5Tbo6dNfh5DJlikCQwiHfv7Ya0C7JB7by74R/MvdiFnGuaMspLacVdeTa27X
	LdK13oGE5OLihpGEm8opMty3qOyWazyIU3IwXt8yu6CPMtXhuG6RAr8US2zwvHg==
X-Google-Smtp-Source: AGHT+IGDwrFX1rI3+Zmj9OqMkY68rfDsh0lNdwaGAF+wFEhJ3s/r1DcCWW7uJv3M/3bmy6ZbAMIuWWJy0I9D4wbOcPg=
X-Received: by 2002:a5d:5f85:0:b0:382:49b3:17b2 with SMTP id
 ffacd0b85a97d-385c6ebf0a4mr2729408f8f.33.1732722368392; Wed, 27 Nov 2024
 07:46:08 -0800 (PST)
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
Date: Wed, 27 Nov 2024 16:45:55 +0100
Message-ID: <CAH5fLgiO3ovUhcaPPukM9KeaDZzA+6CKPH8wNHKFUD4rY_EC=Q@mail.gmail.com>
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

Can there be a page at the top of the address space? If so, I have to
be a bit careful in the wrap-around check, because it should only fail
if the addition wraps around *and* the sum is non-zero.

Alice

