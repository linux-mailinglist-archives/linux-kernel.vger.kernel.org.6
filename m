Return-Path: <linux-kernel+bounces-218535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E593E90C1A5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 03:55:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6435F1F22E46
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 01:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65948179AE;
	Tue, 18 Jun 2024 01:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kYgzvDNW"
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDBD14C98
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 01:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718675740; cv=none; b=DtMJFmzd756CKftrn7veLa7UOKntMpr3EwPa2/vB8JPGv9JW0nH9nH+1K5iejANR3lJ0mcLF+LfYC7MgS/b/7jmvaQay8bcXChDTDGkxHpi1/1+Jeycqn/eyrS5idqqrZFvByx8plRdfpA/AcI54/TET7MjAsmZB1AmIfXYXAcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718675740; c=relaxed/simple;
	bh=kWhxQgRiUo3VEggC2ElibfY3WYE0LoeKsdSreXJqG38=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OQp/o20h8EDbyulSwCpouIB+xLv7ELWgLFVgjJGnSvrMslhdBXy2w1HwdUeDqPDk2bPCGFaK9hv1tISZzXxowEaD5Udb0tU2ro1uud25b7P7g3839M1YtQsXeUZBhTGcxbZkc70L0/P3s8WBw59Qn1OeUmvC654Kv1ES4/tWkcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kYgzvDNW; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-80b755c6c06so1677679241.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 18:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718675738; x=1719280538; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zpsy0npL52e1fCtTldxY0aQBwvhZxOEFkncwykjvpy4=;
        b=kYgzvDNWA6veeh9VE6yFErrCurEQg+th5zbv8wptLsDuF9KgkmmGoEarR0JBHZGoC9
         ztBVaOr/PCqFLrNhkaWvmexs0hRItPrv3816ofZ265dmNgnJpHsNrjfqU7y0IE7MeRLj
         tKQTpByg4ibis3w8pdJFigvDgvzGwsRn/8zy+eYW39dOgKrSTFaheiDTZgZhkIAzNHpT
         TPy+2GHtU/NB2JlwL19qL8yxbYx9kRcMU6bbH/SRSSaxt7cU9D4/h1NUHFhffg20wP0W
         hh6n5J7y9hndxI1C70M6ygIc9zJ1hSTPJGb5mf6g5ZiRhyBLvMKtZ3xzyT8UBVLBanJO
         YL+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718675738; x=1719280538;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zpsy0npL52e1fCtTldxY0aQBwvhZxOEFkncwykjvpy4=;
        b=Ff0ltvPIwDD5Eg3XtCDsAlpZKgulLuuaDX8rneapRK/quY7Pzn2ZpBCGner8E9STOh
         jFoDkFl0t2zenc8RZZ6ZQ+LkBAsV0qNNfHQ4WzIzieQqC15whDxto0HuGNePFrMbPFUs
         3jFwPQh7x17CHJLbSxCyrU1FA34xD4rgFflrTlfGjD6TGm8rcEBduPgYtLf65w8t45E0
         Dla461Xzr1VkmxYDzIzu6guv6y8eC1Lqko32YNq2dNKr9d9WWKT+PhkLLozfAyWT1BQE
         AleZGjIYwyw9Prmv6bYUDhphJjhiOE+uhnzCvzoLhtNoGm0okmvxiTHrJ/Kii5bGHLbv
         DgJw==
X-Forwarded-Encrypted: i=1; AJvYcCVpC0lpxAn0QYxwnUUUzXdr1T2qoq5a0KCY1DA81LneTsdqJuPdjLcHGUZFn1l1bZ4GbEzWs4DPS4Y3k2Xy9rnfOBDAsyUJQ3fsdQ1v
X-Gm-Message-State: AOJu0YwvYdO638Yl3Veax7HPvH6NLvLRHolcGkQqMvnmgFvif3H4Ry+I
	YtjBtVl74NMWn6Z7q4PQBNob33042zdCdUxtErtWg3prPXXaE3+HhrnV+FwqlBfokZChww2cJa+
	NECNtxgILzdnevfiKTAgrBTKyZGtoRPKDf70=
X-Google-Smtp-Source: AGHT+IHeuUoHNmBJX6etzjqRwU2rFGzePFITlJqydbzcSwjLfvLQ5wjO0NeGCPoWT2MH8a8EsKuBzl+yJ6zTST214pE=
X-Received: by 2002:a05:6102:50aa:b0:48c:3731:e537 with SMTP id
 ada2fe7eead31-48dae346888mr15604114137.12.1718675737576; Mon, 17 Jun 2024
 18:55:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1717492460-19457-1-git-send-email-yangge1116@126.com>
 <CAGsJ_4zvG7gwukioZnqN+GpWHbpK1rkC0Jeqo5VFVL_RLACkaw@mail.gmail.com>
 <2e3a3a3f-737c-ed01-f820-87efee0adc93@126.com> <9b227c9d-f59b-a8b0-b353-7876a56c0bde@126.com>
In-Reply-To: <9b227c9d-f59b-a8b0-b353-7876a56c0bde@126.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 18 Jun 2024 09:55:24 +0800
Message-ID: <CAGsJ_4ynfvjXsr6QFBA_7Gzk3PaO1pk+6ErKZaNCt4H+nuwiJw@mail.gmail.com>
Subject: Re: [PATCH] mm/page_alloc: skip THP-sized PCP list when allocating
 non-CMA THP-sized page
To: yangge1116 <yangge1116@126.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, baolin.wang@linux.alibaba.com, 
	liuzixing@hygon.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 18, 2024 at 9:36=E2=80=AFAM yangge1116 <yangge1116@126.com> wro=
te:
>
>
>
> =E5=9C=A8 2024/6/17 =E4=B8=8B=E5=8D=888:47, yangge1116 =E5=86=99=E9=81=93=
:
> >
> >
> > =E5=9C=A8 2024/6/17 =E4=B8=8B=E5=8D=886:26, Barry Song =E5=86=99=E9=81=
=93:
> >> On Tue, Jun 4, 2024 at 9:15=E2=80=AFPM <yangge1116@126.com> wrote:
> >>>
> >>> From: yangge <yangge1116@126.com>
> >>>
> >>> Since commit 5d0a661d808f ("mm/page_alloc: use only one PCP list for
> >>> THP-sized allocations") no longer differentiates the migration type
> >>> of pages in THP-sized PCP list, it's possible to get a CMA page from
> >>> the list, in some cases, it's not acceptable, for example, allocating
> >>> a non-CMA page with PF_MEMALLOC_PIN flag returns a CMA page.
> >>>
> >>> The patch forbids allocating non-CMA THP-sized page from THP-sized
> >>> PCP list to avoid the issue above.
> >>
> >> Could you please describe the impact on users in the commit log?
> >
> > If a large number of CMA memory are configured in the system (for
> > example, the CMA memory accounts for 50% of the system memory), startin=
g
> > virtual machine with device passthrough will get stuck.
> >
> > During starting virtual machine, it will call pin_user_pages_remote(...=
,
> > FOLL_LONGTERM, ...) to pin memory. If a page is in CMA area,
> > pin_user_pages_remote() will migrate the page from CMA area to non-CMA
> > area because of FOLL_LONGTERM flag. If non-movable allocation requests
> > return CMA memory, pin_user_pages_remote() will enter endless loops.
> >
> > backtrace:
> > pin_user_pages_remote
> > ----__gup_longterm_locked //cause endless loops in this function
> > --------__get_user_pages_locked
> > --------check_and_migrate_movable_pages //always check fail and continu=
e
> > to migrate
> > ------------migrate_longterm_unpinnable_pages
> > ----------------alloc_migration_target // non-movable allocation
> >
> >> Is it possible that some CMA memory might be used by non-movable
> >> allocation requests?
> >
> > Yes.
> >
> >
> >> If so, will CMA somehow become unable to migrate, causing cma_alloc()
> >> to fail?
> >
> >
> > No, it will cause endless loops in __gup_longterm_locked(). If
> > non-movable allocation requests return CMA memory,
> > migrate_longterm_unpinnable_pages() will migrate a CMA page to another
> > CMA page, which is useless and cause endless loops in
> > __gup_longterm_locked().

This is only one perspective. We also need to consider the impact on
CMA itself. For example,
when CMA is borrowed by THP, and we need to reclaim it through
cma_alloc() or dma_alloc_coherent(),
we must move those pages out to ensure CMA's users can retrieve that
contiguous memory.

Currently, CMA's memory is occupied by non-movable pages, meaning we
can't relocate them.
As a result, cma_alloc() is more likely to fail.

> >
> > backtrace:
> > pin_user_pages_remote
> > ----__gup_longterm_locked //cause endless loops in this function
> > --------__get_user_pages_locked
> > --------check_and_migrate_movable_pages //always check fail and continu=
e
> > to migrate
> > ------------migrate_longterm_unpinnable_pages
> >
> >
> >
> >
> >
> >>>
> >>> Fixes: 5d0a661d808f ("mm/page_alloc: use only one PCP list for
> >>> THP-sized allocations")
> >>> Signed-off-by: yangge <yangge1116@126.com>
> >>> ---
> >>>   mm/page_alloc.c | 10 ++++++++++
> >>>   1 file changed, 10 insertions(+)
> >>>
> >>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> >>> index 2e22ce5..0bdf471 100644
> >>> --- a/mm/page_alloc.c
> >>> +++ b/mm/page_alloc.c
> >>> @@ -2987,10 +2987,20 @@ struct page *rmqueue(struct zone
> >>> *preferred_zone,
> >>>          WARN_ON_ONCE((gfp_flags & __GFP_NOFAIL) && (order > 1));
> >>>
> >>>          if (likely(pcp_allowed_order(order))) {
> >>> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> >>> +               if (!IS_ENABLED(CONFIG_CMA) || alloc_flags &
> >>> ALLOC_CMA ||
> >>> +                                               order !=3D
> >>> HPAGE_PMD_ORDER) {
> >>> +                       page =3D rmqueue_pcplist(preferred_zone, zone=
,
> >>> order,
> >>> +                                               migratetype,
> >>> alloc_flags);
> >>> +                       if (likely(page))
> >>> +                               goto out;
> >>> +               }
> >>
> >> This seems not ideal, because non-CMA THP gets no chance to use PCP.
> >> But it
> >> still seems better than causing the failure of CMA allocation.
> >>
> >> Is there a possible approach to avoiding adding CMA THP into pcp from
> >> the first
> >> beginning? Otherwise, we might need a separate PCP for CMA.
> >>
>
> The vast majority of THP-sized allocations are GFP_MOVABLE, avoiding
> adding CMA THP into pcp may incur a slight performance penalty.
>

But the majority of movable pages aren't CMA, right? Do we have an estimate=
 for
adding back a CMA THP PCP? Will per_cpu_pages introduce a new cacheline, wh=
ich
the original intention for THP was to avoid by having only one PCP[1]?

[1] https://patchwork.kernel.org/project/linux-mm/patch/20220624125423.6126=
-3-mgorman@techsingularity.net/


> Commit 1d91df85f399 takes a similar approach to filter, and I mainly
> refer to it.
>
>
> >>> +#else
> >>>                  page =3D rmqueue_pcplist(preferred_zone, zone, order=
,
> >>>                                         migratetype, alloc_flags);
> >>>                  if (likely(page))
> >>>                          goto out;
> >>> +#endif
> >>>          }
> >>>
> >>>          page =3D rmqueue_buddy(preferred_zone, zone, order, alloc_fl=
ags,
> >>> --
> >>> 2.7.4
> >>
> >> Thanks
> >> Barry
> >>
>
>

