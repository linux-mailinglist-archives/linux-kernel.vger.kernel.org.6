Return-Path: <linux-kernel+bounces-280597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5946194CCA6
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 10:48:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D2ED1C21323
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 08:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4C6818F2E1;
	Fri,  9 Aug 2024 08:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bbDiKZzF"
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407A84431
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 08:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723193296; cv=none; b=Ka8yy/dpxf3wVYGy6MNtXD9TER0XelQKxapaddBaQmdU8di38tR04hX+hiC31nyK1Lz+mAf+3HmezKMeZHQ4AL4jz7Gz8sPvrUh4UFk7mKgGbon56jh5lrO51z1ZWKv9YD4nFrX4z217vpab2SXf4xozDw20/GKVKMPP8P8pkFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723193296; c=relaxed/simple;
	bh=PcshSDScND4eQSBNKDTsQZE/P4nK2JEWpBOUjaOfy3A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qTaglInM+/0GgLFhrv1sq1esGOyGCV8DXmDL9C11LSC1il99RPIzG7Pw4HPYxZ2IyXeWoSM+eEVGuy11kJ7q2WCCLLtYUzqifGrrAEriRKR1SoGDpdlyj8ZBI/ojKM0Z/O8Im3CsZLZzjUAAZ9MOF4nDyqTFWhaHSId1uheX9Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bbDiKZzF; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-826fee202d3so704893241.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 01:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723193294; x=1723798094; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jwg2cjOZZPVR9Lr9Y/oCQfiAGsyONN4P4/iI9UPEYzM=;
        b=bbDiKZzFOFCeEW1GQ4y/+oFdEYVutfH04tIGc4y6QeUXB+dut0WT8KIjqT084z2yGa
         ONSVpQ1wy8Fcc9O/xYd8ALJsAPP2N+dNJCHmKOns7JcckP2gqwqXLviLiw6gfO00IcMO
         dQXSpNbFD5E8ZKbhB7pJf7tH9mCQd1BM3gVg297uiq17y/aokBkwGU4/cCGovE2gjm81
         iTcAtFIY0dvjAoYMvyDqDMOneYUhYsLuUKaFdJMfAjmBnujhw0okhr2E0h5uuPLcXgWG
         2pwGDwKlo8kPlGDDpK9M3RPQOOOpBObGHjAw+AHQwaOLsW4611AlUJlYBnDqom7OtJFC
         CrVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723193294; x=1723798094;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jwg2cjOZZPVR9Lr9Y/oCQfiAGsyONN4P4/iI9UPEYzM=;
        b=D3+wSuDcToIBtgRkqgqSRhtcGD+6WKL75rekdWzb6pwP7Cj/AggrARcPrni/Vw0jLC
         M9Idi47qw43sb9/ZMkzejzpJ1ieAr5+029oIwd15pJrK2WhwynriGKBpMEQ9TREskbht
         cVavOjtuChAlGB/ScID0iZq66a2lrndVloZ5SzI1VKRYFOfivH0SEy+cbREla8WyEIer
         zyVxTY+zIueTOYPSPft5KH6Va5xBoELWeYCxaWIla5XlBJdS+Rp96Rh6AaFUrHSbDIN4
         YkmiTjoRNkm5nfhIcNXxmaXen4y1VubIMxi/LpKvRMaFrMNYRi5KBynSQyXb5okIroVF
         Al9g==
X-Forwarded-Encrypted: i=1; AJvYcCUP9FYm0sQTBT7BlPZ1mpi1Ov+//RrI8XS6XZyxungr5+Jk3TwtjKWNSx8UkUFlEA6u7cRqfypqKEgkEXDYEylDDF14VO21bw8PRtWs
X-Gm-Message-State: AOJu0Yx8NQvS/zpXA4wKsELu4SK+XXxPfmmsvYNl3VcPDy7XN7B1aqWd
	I4ozUftCd3vVuKS9kZp1gsrhVk+l9duDS2x91wLilwxgtpLf3vWVzzxg3WKEiAFOGhzRRNW5fv9
	APDN2pNegBjxZkcv5YyhwFiQOLsE=
X-Google-Smtp-Source: AGHT+IH4k6D+eqrGKlNBgwJQBKYI4j6VF1hO9C83Bnfw6RYS9XAbkJQBK2IMOcPvDzCm5InOMiWpt/jsB1IwFEmtt9U=
X-Received: by 2002:a05:6102:4191:b0:48f:82c5:90e7 with SMTP id
 ada2fe7eead31-495d8465fbbmr933927137.14.1723193293996; Fri, 09 Aug 2024
 01:48:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240808010457.228753-1-21cnbao@gmail.com> <20240808010457.228753-3-21cnbao@gmail.com>
 <36e8f1be-868d-4bce-8f32-e2d96b8b7af3@arm.com>
In-Reply-To: <36e8f1be-868d-4bce-8f32-e2d96b8b7af3@arm.com>
From: Barry Song <21cnbao@gmail.com>
Date: Fri, 9 Aug 2024 16:48:02 +0800
Message-ID: <CAGsJ_4ySN-fgKdY5QLbR=W=M1e7F5f2e4dEri3ZOL1P3Jmxd8w@mail.gmail.com>
Subject: Re: [PATCH RFC 2/2] mm: collect the number of anon large folios
 partially unmapped
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, chrisl@kernel.org, 
	david@redhat.com, kaleshsingh@google.com, kasong@tencent.com, 
	linux-kernel@vger.kernel.org, ioworker0@gmail.com, 
	baolin.wang@linux.alibaba.com, ziy@nvidia.com, hanchuanhua@oppo.com, 
	Barry Song <v-songbaohua@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 9, 2024 at 4:23=E2=80=AFPM Ryan Roberts <ryan.roberts@arm.com> =
wrote:
>
> On 08/08/2024 02:04, Barry Song wrote:
> > From: Barry Song <v-songbaohua@oppo.com>
> >
> > When an mTHP is added to the deferred_list, its partial pages
> > are unused, leading to wasted memory and potentially increasing
> > memory reclamation pressure. Tracking this number indicates
> > the extent to which userspace is partially unmapping mTHPs.
> >
> > Detailing the specifics of how unmapping occurs is quite difficult
> > and not that useful, so we adopt a simple approach: each time an
> > mTHP enters the deferred_list, we increment the count by 1; whenever
> > it leaves for any reason, we decrement the count by 1.
> >
> > Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> > ---
> >  Documentation/admin-guide/mm/transhuge.rst | 5 +++++
> >  include/linux/huge_mm.h                    | 1 +
> >  mm/huge_memory.c                           | 6 ++++++
> >  3 files changed, 12 insertions(+)
> >
> > diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation=
/admin-guide/mm/transhuge.rst
> > index 715f181543f6..5028d61cbe0c 100644
> > --- a/Documentation/admin-guide/mm/transhuge.rst
> > +++ b/Documentation/admin-guide/mm/transhuge.rst
> > @@ -532,6 +532,11 @@ anon_num
> >         These huge pages could be still entirely mapped and have partia=
lly
> >         unmapped and unused subpages.
> >
> > +anon_num_partial_unused
>
> Why is the user-exposed name completely different to the internal
> (MTHP_STAT_NR_ANON_SPLIT_DEFERRED) name?

My point is that the user might not even know what a deferred split is;
they are more concerned with whether there's any temporary memory
waste or what the deferred list means from a user perspective.

However, since we've referred to it as SPLIT_DEFERRED in other
sys ABI, I agree with you that we should continue using that term.

>
> > +       the number of anon huge pages which have been partially unmappe=
d
> > +       we have in the whole system. These unmapped subpages are also
> > +       unused and temporarily wasting memory.
> > +
> >  As the system ages, allocating huge pages may be expensive as the
> >  system uses memory compaction to copy data around memory to free a
> >  huge page for use. There are some counters in ``/proc/vmstat`` to help
> > diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> > index 294c348fe3cc..4b27a9797150 100644
> > --- a/include/linux/huge_mm.h
> > +++ b/include/linux/huge_mm.h
> > @@ -282,6 +282,7 @@ enum mthp_stat_item {
> >       MTHP_STAT_SPLIT_FAILED,
> >       MTHP_STAT_SPLIT_DEFERRED,
> >       MTHP_STAT_NR_ANON,
> > +     MTHP_STAT_NR_ANON_SPLIT_DEFERRED,
>
> So the existing MTHP_STAT_SPLIT_DEFERRED is counting all folios that were=
 ever
> put on the list, and the new MTHP_STAT_NR_ANON_SPLIT_DEFERRED is counting=
 the
> number of folios that are currently on the list?

Yep.

>
> In which case, do we need the "ANON" in the name? It's implicit for the e=
xisting
> split counters that they are anon-only. That would relate it more clearly=
 to the
> existing MTHP_STAT_SPLIT_DEFERRED too?

ack.

>
> >       __MTHP_STAT_COUNT
> >  };
> >
> > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > index b6bc2a3791e3..6083144f9fa0 100644
> > --- a/mm/huge_memory.c
> > +++ b/mm/huge_memory.c
> > @@ -579,6 +579,7 @@ DEFINE_MTHP_STAT_ATTR(split, MTHP_STAT_SPLIT);
> >  DEFINE_MTHP_STAT_ATTR(split_failed, MTHP_STAT_SPLIT_FAILED);
> >  DEFINE_MTHP_STAT_ATTR(split_deferred, MTHP_STAT_SPLIT_DEFERRED);
> >  DEFINE_MTHP_STAT_ATTR(anon_num, MTHP_STAT_NR_ANON);
> > +DEFINE_MTHP_STAT_ATTR(anon_num_partial_unused, MTHP_STAT_NR_ANON_SPLIT=
_DEFERRED);
> >
> >  static struct attribute *stats_attrs[] =3D {
> >       &anon_fault_alloc_attr.attr,
> > @@ -593,6 +594,7 @@ static struct attribute *stats_attrs[] =3D {
> >       &split_failed_attr.attr,
> >       &split_deferred_attr.attr,
> >       &anon_num_attr.attr,
> > +     &anon_num_partial_unused_attr.attr,
> >       NULL,
> >  };
> >
> > @@ -3229,6 +3231,7 @@ int split_huge_page_to_list_to_order(struct page =
*page, struct list_head *list,
> >               if (folio_order(folio) > 1 &&
> >                   !list_empty(&folio->_deferred_list)) {
> >                       ds_queue->split_queue_len--;
> > +                     mod_mthp_stat(folio_order(folio), MTHP_STAT_NR_AN=
ON_SPLIT_DEFERRED, -1);
> >                       /*
> >                        * Reinitialize page_deferred_list after removing=
 the
> >                        * page from the split_queue, otherwise a subsequ=
ent
> > @@ -3291,6 +3294,7 @@ void __folio_undo_large_rmappable(struct folio *f=
olio)
> >       spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
> >       if (!list_empty(&folio->_deferred_list)) {
> >               ds_queue->split_queue_len--;
> > +             mod_mthp_stat(folio_order(folio), MTHP_STAT_NR_ANON_SPLIT=
_DEFERRED, -1);
> >               list_del_init(&folio->_deferred_list);
> >       }
> >       spin_unlock_irqrestore(&ds_queue->split_queue_lock, flags);
> > @@ -3332,6 +3336,7 @@ void deferred_split_folio(struct folio *folio)
> >               if (folio_test_pmd_mappable(folio))
> >                       count_vm_event(THP_DEFERRED_SPLIT_PAGE);
> >               count_mthp_stat(folio_order(folio), MTHP_STAT_SPLIT_DEFER=
RED);
> > +             mod_mthp_stat(folio_order(folio), MTHP_STAT_NR_ANON_SPLIT=
_DEFERRED, 1);
> >               list_add_tail(&folio->_deferred_list, &ds_queue->split_qu=
eue);
> >               ds_queue->split_queue_len++;
> >  #ifdef CONFIG_MEMCG
> > @@ -3379,6 +3384,7 @@ static unsigned long deferred_split_scan(struct s=
hrinker *shrink,
> >                       list_move(&folio->_deferred_list, &list);
> >               } else {
> >                       /* We lost race with folio_put() */
> > +                     mod_mthp_stat(folio_order(folio), MTHP_STAT_NR_AN=
ON_SPLIT_DEFERRED, -1);
> >                       list_del_init(&folio->_deferred_list);
> >                       ds_queue->split_queue_len--;
> >               }
>

Thanks
Barry

