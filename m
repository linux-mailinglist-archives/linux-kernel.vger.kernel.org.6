Return-Path: <linux-kernel+bounces-370411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 725369A2C01
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 20:19:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AD8E1C26FEF
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 18:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEAA11E0088;
	Thu, 17 Oct 2024 18:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cVZS3FrS"
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3EF1DEFCB
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 18:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729189134; cv=none; b=X9/SCkk80gmK8moHK6LcDUB2NwtIDCpKkazx8Y5zyIWnopG22czG1WePwJpfnYo0kKVje4RN3LpGoKRxV+7EsxIQ5QrcHZFmdBaHdTje6OPoaCMGq2QmKfYBmmr+LUVCHbDQ0eIYmoNmxGNWRjJAWlMO/qoliIbTzVo5xAdvRZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729189134; c=relaxed/simple;
	bh=pBUBfkr8/fW0oB5ReZykvFsW52qP8GgrsSgKekuVPD4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A8ImXha9gIHsqAS6jrrAulivlG84bf8dUyN5/ftbgx9KD1gYe50RS20wUFCAWX96Et3r4ne40fC+cLAHvAYr52+euqtQ4icOqPsadgXYD9D7otlcPeMZx3R8Tv1JBbBnZlEbVZrwJvbHYMpLxGCnf+1NPQM1YMFjbE7z3clLBVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cVZS3FrS; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3e5f835c024so668153b6e.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 11:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729189131; x=1729793931; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vh+Fe+JVI07ZHvub7dZIuFupJMAI8JV+zQomFL2+VuI=;
        b=cVZS3FrShfijivkpqilhpngM+QXqkkBMQOaehCn15gsOHhZL12XQWck5AJg36c3GgB
         EjNGibRm2GYEX7lH23rqYBfFMMBPNDFuGfd6pXWUN8aIl5ZoI+aH0YLouHjL3xmzFKSh
         d+4u9gjjZoNW/iwn6O8CCkdO1SHP2ojKjKHfXuiFb91E+AAZjfk4n6yDn2xnc4FI7yaz
         AGsy80JSvd5d91ZP1Bax7zDnmmWmRaw8B5W6Yz8ubzSUFqDYceWSxTyuHZvQjDdbrYhf
         H43j5EbL8OC1DD/sSf2l7kqC3k4N7nHnJ5Oob4zuY2g6u3CdZNDXCPoYty7R6s137eFZ
         d0lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729189131; x=1729793931;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vh+Fe+JVI07ZHvub7dZIuFupJMAI8JV+zQomFL2+VuI=;
        b=q3rLS3ZvZ5Q+4wpmjYQQwovOvf8HslINcYmlmLJQBBYFPpqoMbqfuf1WFQiD07eIVO
         E2o/h8dckXdyB0uzJDl6yfysfsKKVxc/bGwjmLxCCAVXFF5qM1wasPNBkgmxSfe9pQV3
         KaHDoq7/g/h8qGq3pxKt1hi57/YhhywAYS3A5+ZJK8uYhMi9WgDBZmo2IXIpQA+R6juo
         Z0X0807zqL3qNuxrhr4WvasqkRDwj+8iK96XvvgsaYCmvtFeSW6iaDamYwkJxYTyn7N2
         lnX88aFDkHeDVZADfnuprbkp+jghQjoGMI/VPqEG+1ImLTx+8qEol99OvWRPqm1BVZVq
         IFHQ==
X-Forwarded-Encrypted: i=1; AJvYcCURO69wxjljygAOQg7HNvxnP3RDA2lWTqZ80eT5CiALwL+TvxQqywOwx0Ci8vXFVqTbsCIsBL+AFDomX6Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwadXuEzUS8ITYI6JdAIEhjUmXk7sqH2ndxME3mFBw5ZvE8JhIu
	YA8Iy81/lnf2QI7XmF6FPwCO1PLK8AwblQ/zl9Vfft+Xx8aJT0pjL+XBHbz5yggIgeHhXAt4n50
	BRcxX7Z/pB4T8MP7eKg89M+Dk+wz/EjB+6vBP
X-Google-Smtp-Source: AGHT+IFBixTSBteXjwgBE0GYuX+NzgPSES2v1B6Ij68JD+0kTXTGGXPYuvL0IrejXDh8IRXrjdun0Idt0xKpZbj2+ug=
X-Received: by 2002:a05:6808:1887:b0:3e5:e347:55c7 with SMTP id
 5614622812f47-3e5f0237482mr7872066b6e.11.1729189131234; Thu, 17 Oct 2024
 11:18:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241017181528.3358821-1-weixugc@google.com>
In-Reply-To: <20241017181528.3358821-1-weixugc@google.com>
From: Wei Xu <weixugc@google.com>
Date: Thu, 17 Oct 2024 11:18:38 -0700
Message-ID: <CAAPL-u-pZNu6A_n8VNqC_9P4BSLm_wtu5QPSR4tu1yg4zkBQxg@mail.gmail.com>
Subject: Re: [PATCH v2] mm/mglru: reset page lru tier bits when activating
To: Yu Zhao <yuzhao@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Axel Rasmussen <axelrasmussen@google.com>, 
	Brian Geffon <bgeffon@google.com>, Jan Alexander Steffens <heftig@archlinux.org>, 
	Suleiman Souhlal <suleiman@google.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Changelog since v1:
- Addressed Yu Zhao's comments on not clearing PG_workingset.
- Updated the commit message.

On Thu, Oct 17, 2024 at 11:15=E2=80=AFAM Wei Xu <weixugc@google.com> wrote:
>
> When a folio is activated, lru_gen_add_folio() moves the folio to the
> youngest generation.  But unlike folio_update_gen()/folio_inc_gen(),
> lru_gen_add_folio() doesn't reset the folio lru tier bits
> (LRU_REFS_MASK | LRU_REFS_FLAGS).  This inconsistency can affect how
> pages are aged via folio_mark_accessed() (e.g. fd accesses), though
> no user visible impact related to this has been detected yet.
>
> Note that lru_gen_add_folio() cannot clear PG_workingset if the
> activation is due to workingset refault, otherwise PSI accounting
> will be skipped.  So fix lru_gen_add_folio() to clear the lru tier
> bits other than PG_workingset when activating a folio, and also
> clear all the lru tier bits when a folio is activated via
> folio_activate() in lru_gen_look_around().
>
> Fixes: 018ee47f1489 ("mm: multi-gen LRU: exploit locality in rmap")
> Signed-off-by: Wei Xu <weixugc@google.com>
> ---
>  include/linux/mm_inline.h | 15 ++++++++++++++-
>  include/linux/mmzone.h    |  2 ++
>  mm/vmscan.c               |  8 ++++----
>  3 files changed, 20 insertions(+), 5 deletions(-)
>
> diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
> index 6f801c7b36e2..355cf46a01a6 100644
> --- a/include/linux/mm_inline.h
> +++ b/include/linux/mm_inline.h
> @@ -155,6 +155,11 @@ static inline int folio_lru_refs(struct folio *folio=
)
>         return ((flags & LRU_REFS_MASK) >> LRU_REFS_PGOFF) + workingset;
>  }
>
> +static inline void folio_clear_lru_refs(struct folio *folio)
> +{
> +       set_mask_bits(&folio->flags, LRU_REFS_MASK | LRU_REFS_FLAGS, 0);
> +}
> +
>  static inline int folio_lru_gen(struct folio *folio)
>  {
>         unsigned long flags =3D READ_ONCE(folio->flags);
> @@ -222,6 +227,7 @@ static inline bool lru_gen_add_folio(struct lruvec *l=
ruvec, struct folio *folio,
>  {
>         unsigned long seq;
>         unsigned long flags;
> +       unsigned long mask;
>         int gen =3D folio_lru_gen(folio);
>         int type =3D folio_is_file_lru(folio);
>         int zone =3D folio_zonenum(folio);
> @@ -257,7 +263,14 @@ static inline bool lru_gen_add_folio(struct lruvec *=
lruvec, struct folio *folio,
>         gen =3D lru_gen_from_seq(seq);
>         flags =3D (gen + 1UL) << LRU_GEN_PGOFF;
>         /* see the comment on MIN_NR_GENS about PG_active */
> -       set_mask_bits(&folio->flags, LRU_GEN_MASK | BIT(PG_active), flags=
);
> +       mask =3D LRU_GEN_MASK;
> +       /*
> +        * Don't clear PG_workingset here because it can affect PSI accou=
nting
> +        * if the activation is due to workingset refault.
> +        */
> +       if (folio_test_active(folio))
> +               mask |=3D LRU_REFS_MASK | BIT(PG_referenced) | BIT(PG_act=
ive);
> +       set_mask_bits(&folio->flags, mask, flags);
>
>         lru_gen_update_size(lruvec, folio, -1, gen);
>         /* for folio_rotate_reclaimable() */
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index 17506e4a2835..96dea31fb211 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -403,6 +403,8 @@ enum {
>         NR_LRU_GEN_CAPS
>  };
>
> +#define LRU_REFS_FLAGS         (BIT(PG_referenced) | BIT(PG_workingset))
> +
>  #define MIN_LRU_BATCH          BITS_PER_LONG
>  #define MAX_LRU_BATCH          (MIN_LRU_BATCH * 64)
>
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index c12f78b042f3..2d0486189804 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -2602,8 +2602,6 @@ static bool should_clear_pmd_young(void)
>   *                          shorthand helpers
>   ***********************************************************************=
*******/
>
> -#define LRU_REFS_FLAGS (BIT(PG_referenced) | BIT(PG_workingset))
> -
>  #define DEFINE_MAX_SEQ(lruvec)                                         \
>         unsigned long max_seq =3D READ_ONCE((lruvec)->lrugen.max_seq)
>
> @@ -4138,8 +4136,10 @@ void lru_gen_look_around(struct page_vma_mapped_wa=
lk *pvmw)
>                 old_gen =3D folio_lru_gen(folio);
>                 if (old_gen < 0)
>                         folio_set_referenced(folio);
> -               else if (old_gen !=3D new_gen)
> +               else if (old_gen !=3D new_gen) {
> +                       folio_clear_lru_refs(folio);
>                         folio_activate(folio);
> +               }
>         }
>
>         arch_leave_lazy_mmu_mode();
> @@ -4370,7 +4370,7 @@ static bool isolate_folio(struct lruvec *lruvec, st=
ruct folio *folio, struct sca
>
>         /* see the comment on MAX_NR_TIERS */
>         if (!folio_test_referenced(folio))
> -               set_mask_bits(&folio->flags, LRU_REFS_MASK | LRU_REFS_FLA=
GS, 0);
> +               folio_clear_lru_refs(folio);
>
>         /* for shrink_folio_list() */
>         folio_clear_reclaim(folio);
> --
> 2.47.0.rc1.288.g06298d1525-goog
>

