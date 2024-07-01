Return-Path: <linux-kernel+bounces-236049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D8091DCD9
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 12:38:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E48DA1C21463
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 10:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 785585A7AA;
	Mon,  1 Jul 2024 10:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ae+X98ha"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0669C347B4
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 10:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719830274; cv=none; b=W6TZwK3uDpJuqcs1TwnOMls7iN39HzkrXbziR0CgBIlJ2ljMWCyyWRTW5Iz/2AJMzsahR+RIMmCqt9AMLWyNetu7TmEs9i4iE4KUq4366FMBcEZoAaPnDxXkqTOOAL22m5QzysA8Ny14JVnCgLU/6Y5jLW/kCHZYIHyRVb41dMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719830274; c=relaxed/simple;
	bh=j2ig+q6+3JyYnMeSLXBc2H5XVqFWeXdI+eP+suNEt3g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u01uI1XI82Tam20OEQtc2DcDXCeH0ceUIYmGy5geZClqU6Bwuobi6Ow/rcAiSaOSijbH7VR42iYFiX8SiI6MqFMe24M68CiqdMdd8BDtCFrgK9x/DdtGu9RFOaeTcfXxlxdzDoeiq0quySyud/tooj9fcpO2DVz5T/hOXtI4WVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ae+X98ha; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-57d07464aa9so70604a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 03:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719830271; x=1720435071; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vWK8rSjCA61r7Gr5Pz/lFiaUPoyy/i2wr10vJSbNf/c=;
        b=ae+X98haRcItwTxlYDesl6RpjItamPcc2k7kbKuDwwiWTwuabToUAMBTJTnNaHX4Go
         jGf94SzY8FCX2JAy/QW/VTAzBOn1Rt21tAOIIIRJPxaHb+spu5651CR6SYZbx0dS3wkZ
         s91qs4xzX6Rz4aXMECEqJ3FX21RKLJSyziuy+vc3Zh210Yk5Cuda88xpqdOgVf39lxd8
         ULO5d8flOsydi6TW4gjgEkSQlxqHqzR5PmUNcn2ved9eiswg/jYlGPBb+XBw5SP4WXrg
         KwK88y4vKwIMQOuh9XIt1c0ga2K4oEZB9DotCkj1rylD7uuUjXkslNLTJe98HC7d8DDq
         T2xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719830271; x=1720435071;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vWK8rSjCA61r7Gr5Pz/lFiaUPoyy/i2wr10vJSbNf/c=;
        b=X4JgG07/oExq4K3thtTo6bjiZ1enNI5nlrzvChVKR/m5FmO4OKGTZRPDxgtFyj6PzZ
         so9OSImQEd9mqE4oWq0uQzt4W36LnGKsXHmBVNWRiNxlNEee9FHNOvalnX+ox5dTY56a
         a/lrEbfcs0oL0R1JwZblImKFmOGbj0x3Vr2Bgy/KqLCU91DKqUFCHwRxg6s+srNuwc5s
         Yc3Bitt0kZC+jP/QIbbsxkNufWAkQhn2UdsEYG+RuFs4QWrzs/Pw4DErAj+mvZf3HGFU
         18lotsYmrqdz+EehvJFogJ/ulzGBMmueep/I4bzVzwZi1SEJKfwamgTx1ozl3iSre0tD
         B/mQ==
X-Forwarded-Encrypted: i=1; AJvYcCWiN5QfosAClK8gq2lc4TNExzHK3dC/CRXt5c441NvbX1+P/Fkb6IYi263yuE86iDNzaaGWG4OrnYVkTLGuJDb/hMb3I/CmD1rjW2cv
X-Gm-Message-State: AOJu0YwtQ03XGUKdCrujWtkZ+oXbQAaL+f96HCRH8EQXorGipFnxTyH+
	jrM3fthN78yuF7O9CImj1r755/A/62tbNAAVOCRAh+nf8MGtv9aY1AdGS0ivouaVp37CygvHUix
	REUBDE3aVb4Jf99UOM5fqmXOvqhq3D2y8bbc=
X-Google-Smtp-Source: AGHT+IG7os5Fx2ezQcm8ByEMMWVTsuHciyJ5zoDL3EKXz/4O1QZejjqNdQj7e7rnY0M6wCtshnUxPdnGcVSjH7TFs5M=
X-Received: by 2002:a05:6402:206b:b0:578:56e1:7ba3 with SMTP id
 4fb4d7f45d1cf-587a0b037a9mr3100177a12.38.1719830271351; Mon, 01 Jul 2024
 03:37:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240628130750.73097-1-ioworker0@gmail.com> <20240628130750.73097-2-ioworker0@gmail.com>
 <4516ebbe-5d88-423a-bc45-dfb1eb6adc2d@arm.com>
In-Reply-To: <4516ebbe-5d88-423a-bc45-dfb1eb6adc2d@arm.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Mon, 1 Jul 2024 18:37:40 +0800
Message-ID: <CAK1f24m_SOKdAWggD+MRJB8TXRXhig0Tb7Xg4kJS7_wsm1DO+w@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] mm: add per-order mTHP split counters
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: akpm@linux-foundation.org, dj456119@gmail.com, 21cnbao@gmail.com, 
	david@redhat.com, shy828301@gmail.com, ziy@nvidia.com, libang.li@antgroup.com, 
	baolin.wang@linux.alibaba.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, Mingzhe Yang <mingzhe.yang@ly.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ryan,

On Mon, Jul 1, 2024 at 4:18=E2=80=AFPM Ryan Roberts <ryan.roberts@arm.com> =
wrote:
>
> On 28/06/2024 14:07, Lance Yang wrote:
> > Currently, the split counters in THP statistics no longer include
> > PTE-mapped mTHP. Therefore, we propose introducing per-order mTHP split
> > counters to monitor the frequency of mTHP splits. This will help develo=
pers
> > better analyze and optimize system performance.
> >
> > /sys/kernel/mm/transparent_hugepage/hugepages-<size>/stats
> >         split
> >         split_failed
> >         split_deferred
> >
> > Signed-off-by: Mingzhe Yang <mingzhe.yang@ly.com>
> > Signed-off-by: Lance Yang <ioworker0@gmail.com>
>
> LGTM!
>
> Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>

Thanks for taking time to review!
Lance

>
> > ---
> >  include/linux/huge_mm.h |  3 +++
> >  mm/huge_memory.c        | 19 ++++++++++++++-----
> >  2 files changed, 17 insertions(+), 5 deletions(-)
> >
> > diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> > index 212cca384d7e..cee3c5da8f0e 100644
> > --- a/include/linux/huge_mm.h
> > +++ b/include/linux/huge_mm.h
> > @@ -284,6 +284,9 @@ enum mthp_stat_item {
> >       MTHP_STAT_FILE_ALLOC,
> >       MTHP_STAT_FILE_FALLBACK,
> >       MTHP_STAT_FILE_FALLBACK_CHARGE,
> > +     MTHP_STAT_SPLIT,
> > +     MTHP_STAT_SPLIT_FAILED,
> > +     MTHP_STAT_SPLIT_DEFERRED,
> >       __MTHP_STAT_COUNT
> >  };
> >
> > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > index c7ce28f6b7f3..a633206375af 100644
> > --- a/mm/huge_memory.c
> > +++ b/mm/huge_memory.c
> > @@ -559,6 +559,9 @@ DEFINE_MTHP_STAT_ATTR(swpout_fallback, MTHP_STAT_SW=
POUT_FALLBACK);
> >  DEFINE_MTHP_STAT_ATTR(file_alloc, MTHP_STAT_FILE_ALLOC);
> >  DEFINE_MTHP_STAT_ATTR(file_fallback, MTHP_STAT_FILE_FALLBACK);
> >  DEFINE_MTHP_STAT_ATTR(file_fallback_charge, MTHP_STAT_FILE_FALLBACK_CH=
ARGE);
> > +DEFINE_MTHP_STAT_ATTR(split, MTHP_STAT_SPLIT);
> > +DEFINE_MTHP_STAT_ATTR(split_failed, MTHP_STAT_SPLIT_FAILED);
> > +DEFINE_MTHP_STAT_ATTR(split_deferred, MTHP_STAT_SPLIT_DEFERRED);
> >
> >  static struct attribute *stats_attrs[] =3D {
> >       &anon_fault_alloc_attr.attr,
> > @@ -569,6 +572,9 @@ static struct attribute *stats_attrs[] =3D {
> >       &file_alloc_attr.attr,
> >       &file_fallback_attr.attr,
> >       &file_fallback_charge_attr.attr,
> > +     &split_attr.attr,
> > +     &split_failed_attr.attr,
> > +     &split_deferred_attr.attr,
> >       NULL,
> >  };
> >
> > @@ -3068,7 +3074,7 @@ int split_huge_page_to_list_to_order(struct page =
*page, struct list_head *list,
> >       XA_STATE_ORDER(xas, &folio->mapping->i_pages, folio->index, new_o=
rder);
> >       struct anon_vma *anon_vma =3D NULL;
> >       struct address_space *mapping =3D NULL;
> > -     bool is_thp =3D folio_test_pmd_mappable(folio);
> > +     int order =3D folio_order(folio);
> >       int extra_pins, ret;
> >       pgoff_t end;
> >       bool is_hzp;
> > @@ -3076,7 +3082,7 @@ int split_huge_page_to_list_to_order(struct page =
*page, struct list_head *list,
> >       VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
> >       VM_BUG_ON_FOLIO(!folio_test_large(folio), folio);
> >
> > -     if (new_order >=3D folio_order(folio))
> > +     if (new_order >=3D order)
> >               return -EINVAL;
> >
> >       if (folio_test_anon(folio)) {
> > @@ -3253,8 +3259,9 @@ int split_huge_page_to_list_to_order(struct page =
*page, struct list_head *list,
> >               i_mmap_unlock_read(mapping);
> >  out:
> >       xas_destroy(&xas);
> > -     if (is_thp)
> > +     if (order >=3D HPAGE_PMD_ORDER)
> >               count_vm_event(!ret ? THP_SPLIT_PAGE : THP_SPLIT_PAGE_FAI=
LED);
> > +     count_mthp_stat(order, !ret ? MTHP_STAT_SPLIT : MTHP_STAT_SPLIT_F=
AILED);
> >       return ret;
> >  }
> >
> > @@ -3278,13 +3285,14 @@ void deferred_split_folio(struct folio *folio)
> >  #ifdef CONFIG_MEMCG
> >       struct mem_cgroup *memcg =3D folio_memcg(folio);
> >  #endif
> > +     int order =3D folio_order(folio);
> >       unsigned long flags;
> >
> >       /*
> >        * Order 1 folios have no space for a deferred list, but we also
> >        * won't waste much memory by not adding them to the deferred lis=
t.
> >        */
> > -     if (folio_order(folio) <=3D 1)
> > +     if (order <=3D 1)
> >               return;
> >
> >       /*
> > @@ -3305,8 +3313,9 @@ void deferred_split_folio(struct folio *folio)
> >
> >       spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
> >       if (list_empty(&folio->_deferred_list)) {
> > -             if (folio_test_pmd_mappable(folio))
> > +             if (order >=3D HPAGE_PMD_ORDER)
> >                       count_vm_event(THP_DEFERRED_SPLIT_PAGE);
> > +             count_mthp_stat(order, MTHP_STAT_SPLIT_DEFERRED);
> >               list_add_tail(&folio->_deferred_list, &ds_queue->split_qu=
eue);
> >               ds_queue->split_queue_len++;
> >  #ifdef CONFIG_MEMCG
>

