Return-Path: <linux-kernel+bounces-423434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 890549DA750
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 13:02:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E8D7163DE6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 12:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF1BF1FA246;
	Wed, 27 Nov 2024 12:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JU9LhwK2"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E341F7574
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 12:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732708907; cv=none; b=supax0ho/aG/ipalOjBHRWkwq5WaHuk0dVdZ21fWPyBFW0uJ/jFR8sE/tuKoUfVmr1d8dH2ENKb3qVnETvD3SYI9FxlZlKdZyUU63EQPNOTWqeouPoBv96vP71j/6/t5m3lXTRZTOFGUpeH99kjZd4G7URi5C9ECJmBiyaEcuLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732708907; c=relaxed/simple;
	bh=y/d+AdUBHAvfWeUx9r1GJYMljSO9U0xh/zkVkaxDIX8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s6s+wWvDldbuJcY+0bHvGrNLW1NpkdedTOSOZvu9cuk/Yvx50g9XDogQS5SLmN08Ad4vPPu28mK9RJr/NSGQAesjZkYEEYjObqgJLMVxQh0WrrEvr9gCZoU1/clRe9wWdprDkkGkIK8LDnALEzJq4CyLFf55XkBeOc/WwAXt5C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JU9LhwK2; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-434aabd688fso3449515e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 04:01:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732708904; x=1733313704; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LttQy60/kWcqxExcUEWFDW36cE0UWcTmyvNbFBXdz84=;
        b=JU9LhwK20GNaKLDxB6OwzUNB9Ke5LxJjS7HvZKe00xrgatDvZo1VZYIi7a8tftT7Qn
         exzJcrETHgpUcShL2W9XnjSedEaDZLUHy5BTfw8M5crrrGlMAmdxKhamZDjN+g5ZOaQJ
         oojM6sq+FYijEiEl6wUManrUWaS54/RTOGAHWoqpLnSE8uhjEjtkkEZoYhjhw1Qezvrl
         H1xRtkW7f6fWPLBgq4cXtAldJfeUKS+Pi7Toxe3Cu5YuDjKJMSBKSiaDuYh/xYGuHMwV
         AOrvSPPau0el8lCLXgm3lpi7AZfZ6YjaCNI/uzDDrrWS0CnXG30VXVgjqo51g14O2g0o
         tl5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732708904; x=1733313704;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LttQy60/kWcqxExcUEWFDW36cE0UWcTmyvNbFBXdz84=;
        b=sPSDZNbdiDmgAggbw6rLf/dmcqxGUbBNmTwy0dqXzm5x0aS9Kqo6JssAzP8k2fpAVF
         I+aLwSVWaDr4AQ0Z1m8JeqqxSsfHKlcPqt5+82pJz2NDFCQyTsIPhIg262G5uc5yntsV
         zmXes5MtrJFx7JOpNbeWJUtLtt1W0ZyPRsRc8VHHZ5vYERSXqWulOev7r5QpmSdLY85t
         5kL9G1VoTfP3VdXn9dC4LDTEl3ROA9vt37PCtzWAb98sGiR3NBrg7QMmKlZ9YpDhD4+1
         Gt4+brLyRi9ZPbo6ooLaGHklMrmPrVdr4JTyYohfnP3ndKgB+dLmkkOF3rdXU2OEXpdX
         BhkQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJDsYq8zEVtWLNJ2jbFXHIpD/T4NkWWS39cVbTozLaZe5YKMGlh1Kob4bTCSilJkeiYqsff/uYhomzmSg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlSQrWpURm2c4ZH0t1rHBMorw0cZgiAv5+8QgwdzzG85MpcMx2
	0JwxwOicLHmtCBZhMlt4wePe1xHWdWZ5fGyblbjk88f9bqxw4PiszHMWdXAuBPdgzpvBNx0/Hdy
	qyIWo5GEi6GqtCF1CPqBDLtbIKVr0QDWSbFn/
X-Gm-Gg: ASbGnctw+ZCcwnwzxV1XiI70o71fIxGLbL8cCgGnCoFKKGQVl4D4n3LjpFHrmCVv8r5
	pKdFRiwbIdPcvDmwA8F9K1QXUnMQLdBNxs/J52eq/Ps9hD1BvucZpVZ2RznAqsg==
X-Google-Smtp-Source: AGHT+IHqg6CrZWcGbjXGFSKqCo16d2ZolJeyMhRXXeaa5dMC7DrpyRxOtPnCH2W00kCXyLasTa2O9cyFsPYSfR0A0N8=
X-Received: by 2002:a05:6000:4402:b0:382:5088:936a with SMTP id
 ffacd0b85a97d-385c6ec029amr1647814f8f.28.1732708903384; Wed, 27 Nov 2024
 04:01:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241122-vma-v9-0-7127bfcdd54e@google.com> <20241122-vma-v9-2-7127bfcdd54e@google.com>
 <CAG48ez28kzjrvMN66Yp9n+WziPzE5LU_Y320405Q=PoOzdzStg@mail.gmail.com>
In-Reply-To: <CAG48ez28kzjrvMN66Yp9n+WziPzE5LU_Y320405Q=PoOzdzStg@mail.gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 27 Nov 2024 13:01:31 +0100
Message-ID: <CAH5fLggh7HeOm8wGZH=hnR+SyPoW8Hik3uy4RodibyjY1UT36w@mail.gmail.com>
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

On Tue, Nov 26, 2024 at 11:10=E2=80=AFPM Jann Horn <jannh@google.com> wrote=
:
>
> On Fri, Nov 22, 2024 at 4:41=E2=80=AFPM Alice Ryhl <aliceryhl@google.com>=
 wrote:
> > This adds a type called VmAreaRef which is used when referencing a vma
> > that you have read access to. Here, read access means that you hold
> > either the mmap read lock or the vma read lock (or stronger).
> >
> > Additionally, a vma_lookup method is added to the mmap read guard, whic=
h
> > enables you to obtain a &VmAreaRef in safe Rust code.
> >
> > This patch only provides a way to lock the mmap read lock, but a
> > follow-up patch also provides a way to just lock the vma read lock.
> >
> > Acked-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com> (for mm bits)
> > Signed-off-by: Alice Ryhl <aliceryhl@google.com>
>
> Reviewed-by: Jann Horn <jannh@google.com>

Thanks!

> with one comment:
>
> > +    /// Zap pages in the given page range.
> > +    ///
> > +    /// This clears page table mappings for the range at the leaf leve=
l, leaving all other page
> > +    /// tables intact, and freeing any memory referenced by the VMA in=
 this range. That is,
> > +    /// anonymous memory is completely freed, file-backed memory has i=
ts reference count on page
> > +    /// cache folio's dropped, any dirty data will still be written ba=
ck to disk as usual.
> > +    #[inline]
> > +    pub fn zap_page_range_single(&self, address: usize, size: usize) {
> > +        // SAFETY: By the type invariants, the caller has read access =
to this VMA, which is
> > +        // sufficient for this method call. This method has no require=
ments on the vma flags. Any
> > +        // value of `address` and `size` is allowed.
>
> If we really want to allow any address and size, we might want to add
> an early bailout in zap_page_range_single(). The comment on top of
> zap_page_range_single() currently says "The range must fit into one
> VMA", and it looks like by the point we reach a bailout, we could have
> gone through an interval tree walk via
> mmu_notifier_invalidate_range_start()->__mmu_notifier_invalidate_range_st=
art()->mn_itree_invalidate()
> for a range that ends before it starts; I don't know how safe that is.

I could change the comment on zap_page_range_single() to say:

"The range should be contained within a single VMA. Otherwise an error
is returned."

And then I can add an overflow check at the top of
zap_page_range_single(). Sounds ok?

Alice

