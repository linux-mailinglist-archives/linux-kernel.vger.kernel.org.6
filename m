Return-Path: <linux-kernel+bounces-423650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FBA59DAAE9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 16:41:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3E5E281B80
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 15:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5889F20010B;
	Wed, 27 Nov 2024 15:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ahFbmLjd"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864501FF7CF
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 15:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732722093; cv=none; b=kXD1YFj5VslxnDPRTT1mY/MgrKbqQT2ttFUqlSEeQ6wlKrrHKK99FimS3rYF+b+uQW+wjM/Yl/3EtZJ9jOh6J0gUn1V0goEsyXycke0F7Ux4ELkAR8iCzyITX9/u0wMqYDa+/TsHYx7NB8k7FxpINWkY1uXUJU3B4WelVXUC/eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732722093; c=relaxed/simple;
	bh=58cuDrsg/OQLT2Ug3JOIoWAzpXpMMSW9mIf+RUrd1Ws=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V+7qUpnh0v9yYDxZ6Sl0nr9bjycI0e6VMWl4M+kr5WAy/jCPgdsnScU9AUXokUGvrSCmWYnBFbyvcUwp4qvA1N7cgSf9Mf9/WQE9knSTZBzuprS+tochf+H1BDyPWvm3sw9OQyyVlPrDzW5XqWphyxfyw30/Q1t8zfMcuACIt1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ahFbmLjd; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5cfc264b8b6so9980a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 07:41:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732722089; x=1733326889; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xOp+x0lSSqAbodyySD8EebFArHIya2dNPwG3ZPMkL8Y=;
        b=ahFbmLjdDMlIGezMIDuL74S2YGtwkbuJWSYOJQB2e6nvFpsD+JKKp1aL7HoXXr9jfx
         qeMUIbwMRkQOvHJYpFmolw4ZXRE5C2Kthqboaxq+SJ27QQ+ZC5gKVEN/9QMMIPPGUL6o
         IpGo7A/BJsNT7PLoWf5EfVTG4jJXXqPZaZyT5Fqzfm5+att5zdgH5lmVxngb905xiQc4
         Ra0geHpvGvIp57FZOl2VH5+sadVbhosmTFU8W42WiIwbphyMhCcGPAEWZdPjJInpOdQh
         ZmFQn+nTgT0oaq6AGtardkAnRXW9SrnlfxxwWXi70hbcMUBt86H5SZ/T+fap/YInnYE1
         hu/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732722089; x=1733326889;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xOp+x0lSSqAbodyySD8EebFArHIya2dNPwG3ZPMkL8Y=;
        b=IbKvmAUOM3XqXDzhaKwd3We9S50dO2H1fi8k2cnf2AvYbsu+cybRyku+RAKmXAaX3G
         iAhNLICuJzHW3HHmEoG+gh782wdfebE9CiRPJ39DPVEHgzvYUUm4USnN61Cs5itTUIVW
         TWUp59eY04u3ktGNZqocGhcULsd/OobIjL4BkBASxzhb8wQx4sMCEKSpRMtxoSpYbUNR
         EuoginozdM2RqrGfnEZDVej9vkoUnedtHT/aKXWFgGUrOr76mHQMRYTaF1775XQxPvF5
         ptderY51tsudguwFc32wGphuDV0U0pcncDZvgzSHshOGvVsBaN6yG8Cp0gqBDjpb6b4f
         DFxg==
X-Forwarded-Encrypted: i=1; AJvYcCVpbGqWXUvkipd0dsKNg5KU32rBXsNFoae0TDBf9B8UA9NAtqvIjSF6FeZcnj49/hodjOMFPRxmGg1PqHA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz00IWVQiDPjNzVZSWk882jVI3/YOg4zMrNNhpqqd+IV04Mps8n
	XivlPH2r/+BzvYXXNZ/rNPvfsueqPCCh/WNopW9hKnIUwxGosCojcHZ+lE5mGUhIogHyatMaKZl
	xSmq5M8VY/G1Bc0FG6OiRrXSsVZ4iMHGamUJ5
X-Gm-Gg: ASbGncsdTh+bhXvamenC60Pn2L+sBp+AngqAuahyp9f1aAagcJOvek3a7b4MimiEXRm
	axZMPfnIA2mtKJCRW3n2BhhAKG44yEOnKViqBIJ+roGD53luwkb/wXcCRadY=
X-Google-Smtp-Source: AGHT+IGSxiMWpP0s/sQAaaFQzjTLl+Nv+eTmOa0mh0CF6SOrWd/yecanyWkZSe+M48mi+Aq+sg1yIMNNTsFok47rbAA=
X-Received: by 2002:a05:6402:394:b0:5cf:c23c:2bee with SMTP id
 4fb4d7f45d1cf-5d0810ab5cemr83997a12.0.1732722088392; Wed, 27 Nov 2024
 07:41:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241122-vma-v9-0-7127bfcdd54e@google.com> <20241122-vma-v9-2-7127bfcdd54e@google.com>
 <CAG48ez28kzjrvMN66Yp9n+WziPzE5LU_Y320405Q=PoOzdzStg@mail.gmail.com> <CAH5fLggh7HeOm8wGZH=hnR+SyPoW8Hik3uy4RodibyjY1UT36w@mail.gmail.com>
In-Reply-To: <CAH5fLggh7HeOm8wGZH=hnR+SyPoW8Hik3uy4RodibyjY1UT36w@mail.gmail.com>
From: Jann Horn <jannh@google.com>
Date: Wed, 27 Nov 2024 16:40:52 +0100
Message-ID: <CAG48ez0QmQ7s_MmPj3Q9joEvGSkr9DUWoeJ6dvD=6icq+3DwKQ@mail.gmail.com>
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

On Wed, Nov 27, 2024 at 1:01=E2=80=AFPM Alice Ryhl <aliceryhl@google.com> w=
rote:
> On Tue, Nov 26, 2024 at 11:10=E2=80=AFPM Jann Horn <jannh@google.com> wro=
te:
> >
> > On Fri, Nov 22, 2024 at 4:41=E2=80=AFPM Alice Ryhl <aliceryhl@google.co=
m> wrote:
> > > This adds a type called VmAreaRef which is used when referencing a vm=
a
> > > that you have read access to. Here, read access means that you hold
> > > either the mmap read lock or the vma read lock (or stronger).
> > >
> > > Additionally, a vma_lookup method is added to the mmap read guard, wh=
ich
> > > enables you to obtain a &VmAreaRef in safe Rust code.
> > >
> > > This patch only provides a way to lock the mmap read lock, but a
> > > follow-up patch also provides a way to just lock the vma read lock.
> > >
> > > Acked-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com> (for mm bits)
> > > Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> >
> > Reviewed-by: Jann Horn <jannh@google.com>
>
> Thanks!
>
> > with one comment:
> >
> > > +    /// Zap pages in the given page range.
> > > +    ///
> > > +    /// This clears page table mappings for the range at the leaf le=
vel, leaving all other page
> > > +    /// tables intact, and freeing any memory referenced by the VMA =
in this range. That is,
> > > +    /// anonymous memory is completely freed, file-backed memory has=
 its reference count on page
> > > +    /// cache folio's dropped, any dirty data will still be written =
back to disk as usual.
> > > +    #[inline]
> > > +    pub fn zap_page_range_single(&self, address: usize, size: usize)=
 {
> > > +        // SAFETY: By the type invariants, the caller has read acces=
s to this VMA, which is
> > > +        // sufficient for this method call. This method has no requi=
rements on the vma flags. Any
> > > +        // value of `address` and `size` is allowed.
> >
> > If we really want to allow any address and size, we might want to add
> > an early bailout in zap_page_range_single(). The comment on top of
> > zap_page_range_single() currently says "The range must fit into one
> > VMA", and it looks like by the point we reach a bailout, we could have
> > gone through an interval tree walk via
> > mmu_notifier_invalidate_range_start()->__mmu_notifier_invalidate_range_=
start()->mn_itree_invalidate()
> > for a range that ends before it starts; I don't know how safe that is.
>
> I could change the comment on zap_page_range_single() to say:
>
> "The range should be contained within a single VMA. Otherwise an error
> is returned."
>
> And then I can add an overflow check at the top of
> zap_page_range_single(). Sounds ok?

Yes, I think changing the comment like that and adding a check for
whether address+size wraps around there addresses this.

