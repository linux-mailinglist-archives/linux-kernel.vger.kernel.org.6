Return-Path: <linux-kernel+bounces-290010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 672D6954E66
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 18:03:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C81C9B24142
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 16:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F40C51BE85F;
	Fri, 16 Aug 2024 16:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ad3exU48"
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B540C1BB68D
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 16:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723824189; cv=none; b=AOwOhX2BkJbMu7HBhUfYMySwg3lYCrTUTLytxEfu8psCZUAP8k8+vUvL6mwIFCjO7hX3B2rfKMZp8mYSvgxw54saylj0lsHKareAu+5xgLAVbI+rUpENwTfPcNF5Vy/PhTad/+5hP7cBsuEsKvHf8Z9uYimi6fFBeKFIu3Xks3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723824189; c=relaxed/simple;
	bh=dKR2RxE5Ng0EWSWYHKTrPIV6ivOcjtQIElndmAd6Kck=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gpm9oSkUSs/GNsdnwLqW+83nItSJw7ScySq0GNjbnAsHnD9QjrcGKoccimGFelxPQ1wVw8fRxHEZ1lLvrldyNPaBfDM+NlThw+N5qE2QwNxmzAMBau24UsZ90a/nVGZUedDHendkNDqnIKuxpnlLzjIneteyNxHDJadtKKU8Xxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ad3exU48; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5d8060662a1so1301577eaf.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 09:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723824187; x=1724428987; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X65EJtJyFY0R89syK4EYIOpaQGYFNCKJzH2qnsOU58k=;
        b=Ad3exU48hIroECq0q7bnNFG3aDfAylxMCQNxknNP2J1oRk+NoaYof+PHVPtdei6Nod
         VZJ1eZ6S59ST9IQjc5XnwaJ/VBl/c20r/uLvGiP1AjNlw1TnoRzoZHH9dc6OUQpbaHA4
         uM7QTnnDr9dp3bw6k68Vz/nyHGu77X3ox9KwrG/bUfRPlGqjOTv8TO/1Orq/ZcuzsGMH
         1O5QFJLwllCuSN1gvyyz2egZNx6W2BPALNaQE49iyXqZHIaWwmHM6aqI38XrNFxOAJ/z
         g5Ir2lNiqQY+Tk78O1MkYFvaZPlIUSsmhHQ50NK426xYNUD/zQDzw+wdBCCfGDHMHdWF
         8mNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723824187; x=1724428987;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X65EJtJyFY0R89syK4EYIOpaQGYFNCKJzH2qnsOU58k=;
        b=K3v5p9Rerrp5BkAO9msMTTxVR+gNv28KUGAYi28lS7U2qeOnenWE3PHOsGzpHNA3CM
         njNca8A2JCyNCXp+EBvCSqTTcS39zXt2jIlOqm6BJnTrJJVATlAccw7AXv7xxNO3SlEy
         UckUv2XRqusyUXnZRGHqMoF7Tvn4bOjc0IFdBtQMyR+CK00Nh0pZ8A/cCbNZVmdr3DCJ
         duplRTMfPG/NxOAwlKshBbXZJWWW5dHzLnKRiIqMKYfNDkxTYdvcw6/KpuB+cvF+1QCf
         RCOaDVJzWFuc/vGwVHJKhu4iPOeVOJBZwVrnTqBluuoALgD76+m7eNp4gHVecGzFQh1q
         7e2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXjw04OiaUl9KezhKw3TO7+E8EisGMlYSvyiiT0GebZnVGFmse26zHHCr1R9EQLiBATV7StoZBRqalI7brBVpf4JVgw1kWgwOGWvz2j
X-Gm-Message-State: AOJu0YznGFghSAC94ah64S23sF/mTBSrVnMkJJdSFmsXWxK2MYrEwMRN
	uZlPsc3fKUA4WzA3suF5npKiAFPIYcBktTtZ8r8zcS7gfF0u0MogBzUGKvLIS77U42aiolwFaZk
	MqYGkjvELVapw/bH8G9hUyZ7YoYxNOp0770gChM+kTgj5EC264w==
X-Google-Smtp-Source: AGHT+IH4gXpKHrfK8PJUzF2nfK2W+3TaIwmLMb1gIN8cptX1X6N4v/s24z7BCqP+wvr39GL0wpqwuhQGQaVQLPBDjbU=
X-Received: by 2002:a05:6358:88c:b0:1aa:d4a3:3d58 with SMTP id
 e5c5f4694b2df-1b3a3bfcee8mr15948155d.29.1723824186264; Fri, 16 Aug 2024
 09:03:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240814035451.773331-1-yuzhao@google.com> <20240814035451.773331-4-yuzhao@google.com>
 <24CDA80A-1CC1-4AD7-A35C-D1919DAA707D@nvidia.com>
In-Reply-To: <24CDA80A-1CC1-4AD7-A35C-D1919DAA707D@nvidia.com>
From: Yu Zhao <yuzhao@google.com>
Date: Fri, 16 Aug 2024 10:02:27 -0600
Message-ID: <CAOUHufY65h356h3oyZgXQM-2PjxEkBnMvkweXS6y5AKxR8oN1g@mail.gmail.com>
Subject: Re: [PATCH mm-unstable v2 3/3] mm/hugetlb: use __GFP_COMP for
 gigantic folios
To: Zi Yan <ziy@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Muchun Song <muchun.song@linux.dev>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Frank van der Linden <fvdl@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 16, 2024 at 9:23=E2=80=AFAM Zi Yan <ziy@nvidia.com> wrote:
>
> On 13 Aug 2024, at 23:54, Yu Zhao wrote:
>
> > Use __GFP_COMP for gigantic folios to greatly reduce not only the
> > amount of code but also the allocation and free time.
> >
> > LOC (approximately): +60, -240
> >
> > Allocate and free 500 1GB hugeTLB memory without HVO by:
> >   time echo 500 >/sys/kernel/mm/hugepages/hugepages-1048576kB/nr_hugepa=
ges
> >   time echo 0 >/sys/kernel/mm/hugepages/hugepages-1048576kB/nr_hugepage=
s
> >
> >        Before  After
> > Alloc  ~13s    ~10s
> > Free   ~15s    <1s
> >
> > The above magnitude generally holds for multiple x86 and arm64 CPU
> > models.
> >
> > Signed-off-by: Yu Zhao <yuzhao@google.com>
> > Reported-by: Frank van der Linden <fvdl@google.com>
> > ---
> >  include/linux/hugetlb.h |   9 +-
> >  mm/hugetlb.c            | 293 ++++++++--------------------------------
> >  2 files changed, 62 insertions(+), 240 deletions(-)
> >
> > diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> > index 3100a52ceb73..98c47c394b89 100644
> > --- a/include/linux/hugetlb.h
> > +++ b/include/linux/hugetlb.h
> > @@ -896,10 +896,11 @@ static inline bool hugepage_movable_supported(str=
uct hstate *h)
> >  /* Movability of hugepages depends on migration support. */
> >  static inline gfp_t htlb_alloc_mask(struct hstate *h)
> >  {
> > -     if (hugepage_movable_supported(h))
> > -             return GFP_HIGHUSER_MOVABLE;
> > -     else
> > -             return GFP_HIGHUSER;
> > +     gfp_t gfp =3D __GFP_COMP | __GFP_NOWARN;
> > +
> > +     gfp |=3D hugepage_movable_supported(h) ? GFP_HIGHUSER_MOVABLE : G=
FP_HIGHUSER;
> > +
> > +     return gfp;
> >  }
> >
> >  static inline gfp_t htlb_modify_alloc_mask(struct hstate *h, gfp_t gfp=
_mask)
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index 71d469c8e711..efa77ce87dcc 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -56,16 +56,6 @@ struct hstate hstates[HUGE_MAX_HSTATE];
> >  #ifdef CONFIG_CMA
> >  static struct cma *hugetlb_cma[MAX_NUMNODES];
> >  static unsigned long hugetlb_cma_size_in_node[MAX_NUMNODES] __initdata=
;
> > -static bool hugetlb_cma_folio(struct folio *folio, unsigned int order)
> > -{
> > -     return cma_pages_valid(hugetlb_cma[folio_nid(folio)], &folio->pag=
e,
> > -                             1 << order);
> > -}
> > -#else
> > -static bool hugetlb_cma_folio(struct folio *folio, unsigned int order)
> > -{
> > -     return false;
> > -}
> >  #endif
> >  static unsigned long hugetlb_cma_size __initdata;
> >
> > @@ -100,6 +90,17 @@ static void hugetlb_unshare_pmds(struct vm_area_str=
uct *vma,
> >               unsigned long start, unsigned long end);
> >  static struct resv_map *vma_resv_map(struct vm_area_struct *vma);
> >
> > +static void hugetlb_free_folio(struct folio *folio)
> > +{
> > +#ifdef CONFIG_CMA
> > +     int nid =3D folio_nid(folio);
> > +
> > +     if (cma_free_folio(hugetlb_cma[nid], folio))
> > +             return;
> > +#endif
> > +     folio_put(folio);
> > +}
> > +
>
> It seems that we no longer use free_contig_range() to free gigantic
> folios from alloc_contig_range().

We switched to two pairs of extern (to the allocator) APIs in this patch:
  folio_alloc_gigantic()
  folio_put()
and
  cma_alloc_folio()
  cma_free_folio()

> Will it work? Or did I miss anything?

alloc_contig_range and free_contig_range() also works with __GFP_COMP
/ large folios, but this pair is internal (to the allocator) and
shouldn't be used directly except to implement external APIs like
above.

