Return-Path: <linux-kernel+bounces-169809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69AF78BCDE7
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 14:27:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D52C41F24AE8
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 12:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7896C143C4F;
	Mon,  6 May 2024 12:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HmZvDsXC"
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD26143888
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 12:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714998436; cv=none; b=pRArDizGtU80TkbGEZkpi0Af2ggxpEuTVLuRqAmtl/qyovRjiVUeogdtlzhXQ1adEtoFGtbfEbqjexJol6gNwJAkZ19zElDpAVRACESouou9lgPN244U9J1C8yExNwqOJgENFWz3RE3Z9TFoBms7DeLv7WQdJVlR5fEOKOvPK3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714998436; c=relaxed/simple;
	bh=xodOjtZMLhwfIlqINTkikrDZ2heude9b/24eDh7aDM4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KJRVsF3F4U3icwELOCV7CrCKBhWgjoPMS1u2aF+A7s4cIIfWwCxp6/ZO4kwnXldllEC6wBAi2Nc5sRe66xAWLMllLfBK4m8KHai54mVtOhfuRgPIz5mWG0z2t+bJvUqp1GpCgDa0VriajVsPu4LZqabwlOaVoBVOupLEm9ljunY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HmZvDsXC; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-7f17efe79a1so775462241.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2024 05:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714998434; x=1715603234; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3REQiNx8W32vr+UQbDqQaLWxlDjL0bY+bOsvnNcIwDc=;
        b=HmZvDsXC9qOaRlxBa9nWLZkNXb4fwg36/syYsK+6DSJM3t3UPX7lBZ/klLFn94W7Qa
         9rPb0MMynQgygn79nKsKnP6VQGCJJ6luvbF09aeXiyGiLWAywx5TJo1e7FtNFjbEakis
         9xp87tOuos13PeRBQPnnNDM3W2D5pEr8Znag8hXsQSJmtvekRQu1blels9KM5Ou66kRN
         IIzDfdlhsklZjleku604aVyEjexxBtU2tZtMcWeJCVNc0ad+xt9FbQNhy4TbAggY2lRU
         NqLVu1RdT/uPCGX4hZ95IbzdEH2DhlrQcixNVchxWo2xX1XssquVNEpvYDLGrwtt7cbI
         Sxzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714998434; x=1715603234;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3REQiNx8W32vr+UQbDqQaLWxlDjL0bY+bOsvnNcIwDc=;
        b=eLuVgHbElvNCWzZbYx00ogev6DX3a/iqjANvVGe+3rAAXBt9fu5r9b8JSsyQCKhZzA
         KE8TFQrNLjE0QSLkRdwfHEuh18vfAFj4l2TWux7FOUWaZBlWlE51qOpbVO9wfvLw4NGU
         NQQ9uLUUhjB5pMzvV9bFXjQeDam4Py5rAZ+j/hxVk+k6u7fC9OhI83cbywDs5ZiSUrVp
         9z0jwoohSnegZkCydT0B+v0muCZV7heXu29bIRc2QZiwZ5q014REhc+cHWxm6yGEtWnf
         p8ieC7LKvV04KtVR1rxa6IeBj/2l+7lMbN9B4KU7Ot6CU+qd7sz6y4m1iiffpVbfOnfe
         r4Pw==
X-Forwarded-Encrypted: i=1; AJvYcCUSDp/OZDgORB1+0nJWA0iJ7bPee67TP2cDHHHelcGxALYucS3CWEPdzAxgSmbgxrZeTJm1zifJlhwcxsfuwTMTwuEMvP3hB6sggppz
X-Gm-Message-State: AOJu0YyC91VC8p/B2xFcMdXuyTO1HGXVQHSYlJvv6jQzVuzcn6/J0f9Q
	DREMKaBtQK9dh8zz0H9vGlZ3qFk8AJBhBI/kPhGenrC0GK9BJ3zPcOiWa020dZA0TVzgPt0JfFn
	murOvO6sDojLEmYSKf/Ufmui4ZXM=
X-Google-Smtp-Source: AGHT+IGBuoH8XvTyRkFu2MBgE/jNhULNXD8Gg5uDj4+D5Uc4iI/wUmjoWTQTk+aJs5ghFyaErFRR+dlYOLqfkADwuf8=
X-Received: by 2002:a05:6122:3194:b0:4da:ced8:b09a with SMTP id
 ch20-20020a056122319400b004daced8b09amr9499070vkb.0.1714998433913; Mon, 06
 May 2024 05:27:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240503005023.174597-1-21cnbao@gmail.com> <20240503005023.174597-7-21cnbao@gmail.com>
 <0226a6f7-26ac-48b0-932d-1b7201cde1d7@redhat.com>
In-Reply-To: <0226a6f7-26ac-48b0-932d-1b7201cde1d7@redhat.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 7 May 2024 00:27:02 +1200
Message-ID: <CAGsJ_4zHfbzUfYJSh1d8hMa0eQDidsQ0saYOTE3oD+evQhHm5w@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] mm: swap: entirely map large folios found in swapcache
To: David Hildenbrand <david@redhat.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 
	baolin.wang@linux.alibaba.com, chrisl@kernel.org, hanchuanhua@oppo.com, 
	hannes@cmpxchg.org, hughd@google.com, kasong@tencent.com, 
	linux-kernel@vger.kernel.org, ryan.roberts@arm.com, surenb@google.com, 
	v-songbaohua@oppo.com, willy@infradead.org, xiang@kernel.org, 
	ying.huang@intel.com, yosryahmed@google.com, yuzhao@google.com, 
	ziy@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 7, 2024 at 12:05=E2=80=AFAM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 03.05.24 02:50, Barry Song wrote:
> > From: Chuanhua Han <hanchuanhua@oppo.com>
> >
> > When a large folio is found in the swapcache, the current implementatio=
n
> > requires calling do_swap_page() nr_pages times, resulting in nr_pages
> > page faults. This patch opts to map the entire large folio at once to
> > minimize page faults. Additionally, redundant checks and early exits
> > for ARM64 MTE restoring are removed.
> >
> > Signed-off-by: Chuanhua Han <hanchuanhua@oppo.com>
> > Co-developed-by: Barry Song <v-songbaohua@oppo.com>
> > Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> > ---
> >   mm/memory.c | 60 ++++++++++++++++++++++++++++++++++++++++++----------=
-
> >   1 file changed, 48 insertions(+), 12 deletions(-)
> >
> > diff --git a/mm/memory.c b/mm/memory.c
> > index 22e7c33cc747..940fdbe69fa1 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -3968,6 +3968,10 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >       pte_t pte;
> >       vm_fault_t ret =3D 0;
> >       void *shadow =3D NULL;
> > +     int nr_pages =3D 1;
> > +     unsigned long page_idx =3D 0;
> > +     unsigned long address =3D vmf->address;
> > +     pte_t *ptep;
> >
> >       if (!pte_unmap_same(vmf))
> >               goto out;
> > @@ -4166,6 +4170,36 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >               goto out_nomap;
> >       }
> >
> > +     ptep =3D vmf->pte;
> > +     if (folio_test_large(folio) && folio_test_swapcache(folio)) {
> > +             int nr =3D folio_nr_pages(folio);
> > +             unsigned long idx =3D folio_page_idx(folio, page);
> > +             unsigned long folio_start =3D vmf->address - idx * PAGE_S=
IZE;
> > +             unsigned long folio_end =3D folio_start + nr * PAGE_SIZE;
> > +             pte_t *folio_ptep;
> > +             pte_t folio_pte;
> > +
> > +             if (unlikely(folio_start < max(vmf->address & PMD_MASK, v=
ma->vm_start)))
> > +                     goto check_folio;
> > +             if (unlikely(folio_end > pmd_addr_end(vmf->address, vma->=
vm_end)))
> > +                     goto check_folio;
> > +
> > +             folio_ptep =3D vmf->pte - idx;
> > +             folio_pte =3D ptep_get(folio_ptep);
> > +             if (!pte_same(folio_pte, pte_move_swp_offset(vmf->orig_pt=
e, -idx)) ||
> > +                 swap_pte_batch(folio_ptep, nr, folio_pte) !=3D nr)
> > +                     goto check_folio;
> > +
> > +             page_idx =3D idx;
> > +             address =3D folio_start;
> > +             ptep =3D folio_ptep;
> > +             nr_pages =3D nr;
> > +             entry =3D folio->swap;
> > +             page =3D &folio->page;
> > +     }
> > +
> > +check_folio:
> > +
> >       /*
> >        * PG_anon_exclusive reuses PG_mappedtodisk for anon pages. A swa=
p pte
> >        * must never point at an anonymous page in the swapcache that is
> > @@ -4225,12 +4259,13 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >        * We're already holding a reference on the page but haven't mapp=
ed it
> >        * yet.
> >        */
> > -     swap_free_nr(entry, 1);
> > +     swap_free_nr(entry, nr_pages);
> >       if (should_try_to_free_swap(folio, vma, vmf->flags))
> >               folio_free_swap(folio);
> >
> > -     inc_mm_counter(vma->vm_mm, MM_ANONPAGES);
> > -     dec_mm_counter(vma->vm_mm, MM_SWAPENTS);
> > +     folio_ref_add(folio, nr_pages - 1);
> > +     add_mm_counter(vma->vm_mm, MM_ANONPAGES, nr_pages);
> > +     add_mm_counter(vma->vm_mm, MM_SWAPENTS, -nr_pages);
> >       pte =3D mk_pte(page, vma->vm_page_prot);
> >
> >       /*
> > @@ -4240,34 +4275,35 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >        * exclusivity.
> >        */
> >       if (!folio_test_ksm(folio) &&
> > -         (exclusive || folio_ref_count(folio) =3D=3D 1)) {
> > +         (exclusive || (folio_ref_count(folio) =3D=3D nr_pages &&
> > +                        folio_nr_pages(folio) =3D=3D nr_pages))) {
> >               if (vmf->flags & FAULT_FLAG_WRITE) {
> >                       pte =3D maybe_mkwrite(pte_mkdirty(pte), vma);
> >                       vmf->flags &=3D ~FAULT_FLAG_WRITE;
>
> I fail to convince myself that this change is correct, and if it is
> correct, it's confusing (I think there is a dependency on
> folio_free_swap() having been called and succeeding, such that we don't
> have a folio that is in the swapcache at this point).
>
> Why can't we move the folio_ref_add() after this check and just leave
> the check as it is?
>
> "folio_ref_count(folio) =3D=3D 1" is as clear as it gets: we hold the sin=
gle
> reference, so we can do with this thing whatever we want: it's certainly
> exclusive. No swapcache, no other people mapping it.

Right.
I believe the code works correctly but is a bit confusing. as you said,
we might move folio_ref_add() behind folio_ref_count(folio) =3D=3D 1.

>
>
> --
> Cheers,
>
> David / dhildenb
>

Thanks
Barry

