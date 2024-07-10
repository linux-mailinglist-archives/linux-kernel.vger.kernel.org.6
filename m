Return-Path: <linux-kernel+bounces-247866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A22EF92D5BC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 18:08:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2109D1F227C7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 16:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72AFD194C7A;
	Wed, 10 Jul 2024 16:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JSFMftbV"
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28311195FE8
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 16:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720627657; cv=none; b=idKltsk8aUKciCBr2sc6kt2ahxEoGQ92yb2LaJHy6m+onEa1YT2V3AQwaUedsC//Ksr/SCvMp6oLmkbIJjtfYppTFZbZIKL/1yAveNOZhKL98YdiGqkpOJbKpveaQMjdTATDSj1W5Kq9N9B4axWwb3AKp6w1cc11jbbr46FUFh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720627657; c=relaxed/simple;
	bh=6UgaRsBKuBqnUMotrXmGfoJp7a55bSAyLHCf5fFjFTs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=K3eHH5U6oe0VtCWLrUz3jWpOndfD3vzuSR7lPIL9RfKBQr266qbcW11Zl1pLPsRRGjZpEmmiAUPX7hUChxGj2z8QiQj+Sp1StoxwbEk8m/tqCkQL4NDTB90BhcjxQyt+iAO0nTe8OogwNQRaef+b1woSpLNSFRU+LncaSzMThmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JSFMftbV; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-dfe43dca3bfso6575089276.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 09:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720627655; x=1721232455; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5hOi+CbH+LQ53IgFxOEWuC6/Y+tbAitu1myzto5D+qI=;
        b=JSFMftbV1tFSQiqRtfGON7SDVIyPAxJ5eCfCBvGJty2O/CTfTu3VbeN+PocW704b3J
         N7HIXjqhTHDkhM9L8SYGlNJaVVKaQMkxxg1eXOvtwBh7dXQTqAvQ7KyEjEvWPAjXcB1d
         8rbqL3nzOcCpELYNcdXNRtH796UpvhD0GPuwicFBPbvy2+SQh8Iw1mKCKPxXlUzIEqXA
         4StguKylV3nP+2+k3wyaS+tjy/gBh/VRjTm83ESkHhax4QqyX/Gqk6SeMleaV5/uz/fv
         Wklofj7ktCRZkjKHtTTcf5If3dO5fxnMWyTJMeKLwgCNBzfrYfY+WVZSo+wDhJPxRi1R
         dpNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720627655; x=1721232455;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5hOi+CbH+LQ53IgFxOEWuC6/Y+tbAitu1myzto5D+qI=;
        b=KPCtmVudGbGhO/VcefN0pK2rFRSahZYy6HB/2deG702vhirNjBLBBGh1h72XX3WLiu
         GVjno6ozemhsGt7CwxjxTycwmDEBqMElrlXnIcHm4M88a50b1CIX8Z/oC44soD/St/Ai
         jgln7o3+iV3tDvTCUKbdVZxZ9U1WbmvaErE7kq3A10hy4sHMEThMr10W3odF+aRKIa4G
         Glse+IsSRGqbfGhpOXJtezOJnK+BrKtWnhESzvfgMLsZ1YMyNVfYaHn4AasiM5W9zKkK
         sVY+CVMpr0Txo0n+ayU9HzM3kHKNxvzJDPljQeP6lnQiukx8nZ2/mI4Sx2V8w16Ez4rR
         DYwg==
X-Forwarded-Encrypted: i=1; AJvYcCUITGvPeshdJe/b0aWCF1JTEfX9ZZbJpwk2DmMWauuSrGfe0/s9BNpzTrXRHB4TmrSQssi9ZFkpJrg0/4fWe/hVL3/Q8F1iz1K4K33y
X-Gm-Message-State: AOJu0Yx4I1R05WhBrFASX4IwLptLQ1MzdChOaYyZI2ejbkV5mqvt3aig
	7eh3x967o1QxNFWcJFj6eT69M6UCWUWIjiKKI1Jn3/qKtL9bY3h7X8ZfspDNTQnLF2HaRxFyngn
	gYUFYn1D1g/pKxMIwZ3/mRuPRguBN1zXEcjlg
X-Google-Smtp-Source: AGHT+IFM/MM4d9wyqLSExKu598+a2Z0e1WDGShpZknWBuRov1q90hJ4xSnWPGct7PhaG0u0h7tLK8i94ggVSXRilV0U=
X-Received: by 2002:a05:690c:f09:b0:63b:ca6d:7bb8 with SMTP id
 00721157ae682-658ee7911c8mr78026367b3.11.1720627654703; Wed, 10 Jul 2024
 09:07:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240704182718.2653918-1-Liam.Howlett@oracle.com>
 <20240704182718.2653918-6-Liam.Howlett@oracle.com> <a1f1e48c-5aed-4c03-b4d1-b4d4ac85a6de@lucifer.local>
 <jcdeostzaoalxqbtlz4x6egjay2agiox6mg5o744ovfznbxh3i@pdqvicfbbblb>
In-Reply-To: <jcdeostzaoalxqbtlz4x6egjay2agiox6mg5o744ovfznbxh3i@pdqvicfbbblb>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 10 Jul 2024 09:07:23 -0700
Message-ID: <CAJuCfpG+Jok-ySXzRkokU-hrvnLxxMkeufXRMk1tmPLQcgnzNw@mail.gmail.com>
Subject: Re: [PATCH v3 05/16] mm/mmap: Introduce vma_munmap_struct for use in
 munmap operations
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>, Lorenzo Stoakes <lstoakes@gmail.com>, 
	Matthew Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com, 
	"Paul E . McKenney" <paulmck@kernel.org>, Bert Karwatzki <spasswolf@web.de>, Jiri Olsa <olsajiri@gmail.com>, 
	linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 5, 2024 at 12:09=E2=80=AFPM Liam R. Howlett <Liam.Howlett@oracl=
e.com> wrote:
>
> * Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [240705 14:39]:
> > On Thu, Jul 04, 2024 at 02:27:07PM GMT, Liam R. Howlett wrote:
> > > Use a structure to pass along all the necessary information and count=
ers
> > > involved in removing vmas from the mm_struct.
> > >
> > > Update vmi_ function names to vms_ to indicate the first argument
> > > type change.
> > >
> > > Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> > > Reviewed-by: Suren Baghdasaryan <surenb@google.com>
> > > ---
> > >  mm/internal.h |  16 ++++++
> > >  mm/mmap.c     | 137 ++++++++++++++++++++++++++----------------------=
--
> > >  2 files changed, 88 insertions(+), 65 deletions(-)
> > >
> > > diff --git a/mm/internal.h b/mm/internal.h
> > > index 2ea9a88dcb95..f1e6dea2efcf 100644
> > > --- a/mm/internal.h
> > > +++ b/mm/internal.h
> > > @@ -1481,6 +1481,22 @@ struct vma_prepare {
> > >     struct vm_area_struct *remove2;
> > >  };
> > >
> > > +/*
> > > + * vma munmap operation
> > > + */
> > > +struct vma_munmap_struct {
> > > +   struct vma_iterator *vmi;
> > > +   struct mm_struct *mm;
> > > +   struct vm_area_struct *vma;     /* The first vma to munmap */
> > > +   struct list_head *uf;           /* Userfaultfd list_head */
> > > +   unsigned long start;            /* Aligned start addr */
> > > +   unsigned long end;              /* Aligned end addr */
> > > +   int vma_count;                  /* Number of vmas that will be re=
moved */
> > > +   unsigned long nr_pages;         /* Number of pages being removed =
*/
> > > +   unsigned long locked_vm;        /* Number of locked pages */
> > > +   bool unlock;                    /* Unlock after the munmap */
> > > +};
> >
> >
> > I'm a big fan of breaking out and threading state like this through som=
e of
> > these more... verbose VMA functions.
> >
> > I have a similar idea as part of my long dreamed of 'delete vma_merge()=
'
> > patch set. Coming soon :)
> >
> > > +
> > >  void __meminit __init_single_page(struct page *page, unsigned long p=
fn,
> > >                             unsigned long zone, int nid);
> > >
> > > diff --git a/mm/mmap.c b/mm/mmap.c
> > > index 8dc8ffbf9d8d..76e93146ee9d 100644
> > > --- a/mm/mmap.c
> > > +++ b/mm/mmap.c
> > > @@ -500,6 +500,31 @@ static inline void init_vma_prep(struct vma_prep=
are *vp,
> > >     init_multi_vma_prep(vp, vma, NULL, NULL, NULL);
> > >  }
> > >
> > > +/*
> > > + * init_vma_munmap() - Initializer wrapper for vma_munmap_struct
> > > + * @vms: The vma munmap struct
> > > + * @vmi: The vma iterator
> > > + * @vma: The first vm_area_struct to munmap
> > > + * @start: The aligned start address to munmap
> > > + * @end: The aligned end address to munmap
> >
> > Maybe worth mentioning if inclusive/exclusive.
>
> The "address to munmap" isn't specific enough that we are using the same
> logic as the munmap call?  That is, the vma inclusive and exclusive for
> start and end, respectively.
>
> Not a big change, either way.

+1. Every time I look into these functions with start/end I have to go
back and check these inclusive/exclusive rules, so mentioning it would
be helpful.


>
> ...
>
> >
> > Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>
> Thanks
>

