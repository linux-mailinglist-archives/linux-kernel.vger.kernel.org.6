Return-Path: <linux-kernel+bounces-436143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B95F9E81C1
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 20:10:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65F94188468B
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 19:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5437114F9FA;
	Sat,  7 Dec 2024 19:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZQt2YXKM"
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6FF1DFE1
	for <linux-kernel@vger.kernel.org>; Sat,  7 Dec 2024 19:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733598621; cv=none; b=uWRfkRUhTFPjZqar2LXlrt61i1ooNBPolP9dDV7ZW6SbJNqsvziv64zDobYM9DLQCCmaBSpw5+TGWWidoByokuzu6Pb+A/qMoOxjJ1+JEBzxKd8lkxpcRuimJFb5YinPaL6hoU2ZWRv0BfP12m/sO2rTgkUvig8B1Va6r7suLNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733598621; c=relaxed/simple;
	bh=rXlkSv/5AfLoJSEOyu7PPim+T8dO9ZkEoc0c5gJMgm0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j+aFjVwWHPN4ohnUTuNeddARZ0unV8YGQ3TjoCpFEzRHycfzZOwFbmEIdVU07iDu/N0SVm4LM86Rw89DzMFJZR3LBWkZdjpFfvSB1+o9sOPvumQcmyyHNfqu6eLH9Ls+v4oVHUvfb74pwGTfolXaZmI4g1pAjRQ7aImayuLdVIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZQt2YXKM; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-4afac826ab6so790423137.1
        for <linux-kernel@vger.kernel.org>; Sat, 07 Dec 2024 11:10:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733598617; x=1734203417; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/15KxmJ0SxonIY9baR1wg6KbQJZwmraFLzWVHuQbZwg=;
        b=ZQt2YXKM9sSFzhXfCZ+3eplo9CogpGtdlMSzM7Yxm4FLx/cEpUlEn/2cO7+ztakN6S
         LXbBo+ob6Ss8uxsfDS7HIT8zRKcfSeKFRIwwdywwuIRIqE1Qkee44riCGLYW3t8kR2Gh
         PlliY06d6Mt6tqxNCYPlObxKLi/GNgQZRKXCqeu2SbAE7k3tdFUVBn1wEc9sqXZKUn8L
         5OjytVcJcSJgsOjtkdvx1TVyAScDy8n7cnRHse/x957AnY7Y7mEkYyhP2YV2KV5bJHk5
         QuLgL5AfdHz5aiRzutngLvbQRjqbcrk1tTy9uMOjrjgAzwCHRBrwsHzc1eMod/PnTIDw
         JGmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733598617; x=1734203417;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/15KxmJ0SxonIY9baR1wg6KbQJZwmraFLzWVHuQbZwg=;
        b=CqcWvAHmxp/7cTm2mFjZpuY79PAqHJabUJLXW6mBjBQv2RPKFmmGvyUeEpcgVsDepn
         YJmB4vTZgnFAgUFLQJvMLU5WuxpgtRmPv3nJMj6JCS1z79ehcID5Lobsczf1F05geMyD
         U5jiKxCboCM02MdD/JGqn+YVu5js71k30SYSfdm0XRk5D5NSynRJ95Qq324KQY61KnCT
         0s/Egw8tetKx9MAW2MiFN/YSlJucr75/RWQPtfOjuRzWifcGlWv/rrKKJ3b+E0qIZe0U
         Ijwg601PSeU2Ib7S31NV4BbjGfWBlVPN8zlzBx1WVlc0B6TkybDKHQOaqQXjjucnII9H
         nUzA==
X-Forwarded-Encrypted: i=1; AJvYcCUB1sUnZi0T1kQnmt7Q+EUPXmMcDC9wBoaT2XU0TsWB+bHK/riQ3z3VsqdXGgSkjOpEQxj6Fkcd2oWtkjU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXobYBj0O1RSXsU0M7xrlLcI5pfaJlPnmI7iR5Zt1lTTRFf/D3
	ZzoKnoDttxe1+R5vcp6YruIwGQjTZ4m9SxuIr84EQn68lWSpCRDmvbuVVtf2zwfHgR9BeYAN1VA
	rsjPP2cz2JYOXrhJ2LO6YwvXIlvMFeGijscRk
X-Gm-Gg: ASbGncvh6LdPAc3FVz0UG8FkGjLJLt1hdMzE7ngXukbC9oB/wOM/T+Dlr8607FnFlB0
	o8WFY44zgvVqLWmQSALsRIW7frHxYNsRuoEFO4zx9CO3W87xf+0Z6vN16xFd+W0ys
X-Google-Smtp-Source: AGHT+IGuq3rFffhHTtpguXfM3plGXJvmjCmHPM+myu+JVCptyY7LMNoXXEUsfJSCZauBj6tzApx30AMUgco60LAziLo=
X-Received: by 2002:a05:6102:50a0:b0:4ad:de0b:fde9 with SMTP id
 ada2fe7eead31-4afcaaf3b31mr8243693137.24.1733598616434; Sat, 07 Dec 2024
 11:10:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241206003126.1338283-1-yuzhao@google.com> <20241206003126.1338283-7-yuzhao@google.com>
 <Z1PSn79GPcCxeI_g@google.com>
In-Reply-To: <Z1PSn79GPcCxeI_g@google.com>
From: Yu Zhao <yuzhao@google.com>
Date: Sat, 7 Dec 2024 12:09:39 -0700
Message-ID: <CAOUHufYsTbeaFE6_KXP6RQduwQpWGCt3uiHhb2F7p7c_C8UTyA@mail.gmail.com>
Subject: Re: [PATCH mm-unstable v2 6/6] mm/mglru: rework workingset protection
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Kairui Song <kasong@tencent.com>, Kalesh Singh <kaleshsingh@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 6, 2024 at 9:44=E2=80=AFPM Yu Zhao <yuzhao@google.com> wrote:
>
> On Thu, Dec 05, 2024 at 05:31:26PM -0700, Yu Zhao wrote:
> > With the aging feedback no longer considering the distribution of
> > folios in each generation, rework workingset protection to better
> > distribute folios across MAX_NR_GENS. This is achieved by reusing
> > PG_workingset and PG_referenced/LRU_REFS_FLAGS in a slightly different
> > way.
> >
> > For folios accessed multiple times through file descriptors, make
> > lru_gen_inc_refs() set additional bits of LRU_REFS_WIDTH in
> > folio->flags after PG_referenced, then PG_workingset after
> > LRU_REFS_WIDTH. After all its bits are set, i.e.,
> > LRU_REFS_FLAGS|BIT(PG_workingset), a folio is lazily promoted into the
> > second oldest generation in the eviction path. And when
> > folio_inc_gen() does that, it clears LRU_REFS_FLAGS so that
> > lru_gen_inc_refs() can start over. For this case, LRU_REFS_MASK is
> > only valid when PG_referenced is set.
> >
> > For folios accessed multiple times through page tables,
> > folio_update_gen() from a page table walk or lru_gen_set_refs() from a
> > rmap walk sets PG_referenced after the accessed bit is cleared for the
> > first time. Thereafter, those two paths set PG_workingset and promote
> > folios to the youngest generation. Like folio_inc_gen(), when
> > folio_update_gen() does that, it also clears PG_referenced. For this
> > case, LRU_REFS_MASK is not used.
> >
> > For both of the cases, after PG_workingset is set on a folio, it
> > remains until this folio is either reclaimed, or "deactivated" by
> > lru_gen_clear_refs(). It can be set again if lru_gen_test_recent()
> > returns true upon a refault.
> >
> > When adding folios to the LRU lists, lru_gen_distance() distributes
> > them as follows:
> > +---------------------------------+---------------------------------+
> > |    Accessed thru page tables    | Accessed thru file descriptors  |
> > +---------------------------------+---------------------------------+
> > | PG_active (set while isolated)  |                                 |
> > +----------------+----------------+----------------+----------------+
> > | PG_workingset  | PG_referenced  | PG_workingset  | LRU_REFS_FLAGS |
> > +---------------------------------+---------------------------------+
> > |<--------- MIN_NR_GENS --------->|                                 |
> > |<-------------------------- MAX_NR_GENS -------------------------->|
> >
> > After this patch, some typical client and server workloads showed
> > improvements under heavy memory pressure. For example, Python TPC-C,
> > which was used to benchmark a different approach [1] to better detect
> > refault distances, showed a significant decrease in total refaults:
> >                             Before      After      Change
> >   Time (seconds)            10801       10801      0%
> >   Executed (transactions)   41472       43663      +5%
> >   workingset_nodes          109070      120244     +10%
> >   workingset_refault_anon   5019627     7281831    +45%
> >   workingset_refault_file   1294678786  554855564  -57%
> >   workingset_refault_total  1299698413  562137395  -57%
> >
> > [1] https://lore.kernel.org/20230920190244.16839-1-ryncsn@gmail.com/
> >
> > Reported-by: Kairui Song <kasong@tencent.com>
> > Closes: https://lore.kernel.org/CAOUHufahuWcKf5f1Sg3emnqX+cODuR=3D2TQo7=
T4Gr-QYLujn4RA@mail.gmail.com/
> > Signed-off-by: Yu Zhao <yuzhao@google.com>
> > Tested-by: Kalesh Singh <kaleshsingh@google.com>
> > ---
> >  include/linux/mm_inline.h |  94 +++++++++++++------------
> >  include/linux/mmzone.h    |  82 +++++++++++++---------
> >  mm/swap.c                 |  23 +++---
> >  mm/vmscan.c               | 142 +++++++++++++++++++++++---------------
> >  mm/workingset.c           |  29 ++++----
> >  5 files changed, 209 insertions(+), 161 deletions(-)
>
> Some outlier results from LULESH (Livermore Unstructured Lagrangian
> Explicit Shock Hydrodynamics) [1] caught my eye. The following fix
> made the benchmark a lot happier (128GB DRAM + Optane swap):
>                             Before    After    Change
>   Average (z/s)             6894      7574     +10%
>   Deviation (10 samples)    12.96%    1.76%    -86%
>
> [1] https://asc.llnl.gov/codes/proxy-apps/lulesh
>
> Andrew, can you please fold it in? Thanks!

Never mind. syzbot found another warning. So let me fix that and post v3.

> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 90bbc2b3be8b..5e03a61c894f 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -916,8 +916,7 @@ static enum folio_references folio_check_references(s=
truct folio *folio,
>                 if (!referenced_ptes)
>                         return FOLIOREF_RECLAIM;
>
> -               lru_gen_set_refs(folio);
> -               return FOLIOREF_ACTIVATE;
> +               return lru_gen_set_refs(folio) ? FOLIOREF_ACTIVATE : FOLI=
OREF_KEEP;
>         }
>
>         referenced_folio =3D folio_test_clear_referenced(folio);
> @@ -4173,11 +4172,7 @@ bool lru_gen_look_around(struct page_vma_mapped_wa=
lk *pvmw)
>                         old_gen =3D folio_update_gen(folio, new_gen);
>                         if (old_gen >=3D 0 && old_gen !=3D new_gen)
>                                 update_batch_size(walk, folio, old_gen, n=
ew_gen);
> -
> -                       continue;
> -               }
> -
> -               if (lru_gen_set_refs(folio)) {
> +               } else if (lru_gen_set_refs(folio)) {
>                         old_gen =3D folio_lru_gen(folio);
>                         if (old_gen >=3D 0 && old_gen !=3D new_gen)
>                                 folio_activate(folio);

