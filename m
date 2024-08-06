Return-Path: <linux-kernel+bounces-275702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5630F9488D2
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 07:08:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B46B51F2394F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 05:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E0AF1BB6A9;
	Tue,  6 Aug 2024 05:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D0EmZYpi"
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27EDB15C124
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 05:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722920922; cv=none; b=NK03dWHzMPfB2sU387CvYxYPIlSBBDycyiWEzjVKZRQClENN4gbY5onQ/bwR3sRp0UfMgN0dN5AuQzCe6rYcheowfLDuXvE/W9tCefi6EhPjYogVeJkqPdmQVub1MpilViNeia9NXl37oUPg+3AvVc2OPe7c5oTANJ9Ux4RMTC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722920922; c=relaxed/simple;
	bh=DYcRYcExpvTwKvL0HLnsyTitLjgAAyICKJ45hJgye70=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pEgG4Rwa5J6De0vCnlgxRk+miWHTIpUyYs+7TlQds9P2fryMP9RUfuSLgFnWHE9R9c+4zSpgC12nDoTiSxAG+ktKvF6Vud3XKPto1qxCFOGSzs+TFuPc83/ZmP4ZGE1rL+CIpuIxM21wIK04Pnpk3D43QoM5gUg/9acVcHn4SrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D0EmZYpi; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-44fee2bfd28so147961cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 22:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722920920; x=1723525720; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jjc5PvFQAIDEJuasUzjAKu0+WbtJ/LimH4KncpiNJ2k=;
        b=D0EmZYpiifyYnoEfClSvdWJ1bHWHUKtLW04ehtW/l8GtVPt15B2j0xVG00DE6ReJ+l
         vSvMvRUEMrAJzYZ/l8MRdofabvhVWVq6eA47/Ci17YdVjapzhaz9T3rsBpn1JJQp7Jru
         qN9RJeoJ/QC+g7GBoY0PlzJN1veHMAuFEhr45sGkFvanDTD7LSLn5qGRU2gImqbBKERe
         tScMBB4IMhJKo1MExE46ES88oNYMagfUaGq0GQpfqcF+2LLwfrRMKYnRBNpht1vyH88F
         ugrymPQyo40CmyTxb8FQMbAPBD9tzoRXWptSw01i8ZrX32KJNvoV8gQEuEa3nr5QHJgT
         S3AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722920920; x=1723525720;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jjc5PvFQAIDEJuasUzjAKu0+WbtJ/LimH4KncpiNJ2k=;
        b=wUyVfGk4ntTmY5ubeeXsQfjnKht9Qr6aKjK6jlX9VPfwfgw29zRJ7mIQUVHWZPSCMG
         h7g7iwde4LD4OI8p9ULBkXzIhTWIN27OGuxo1pw145bxWxFtFImpxefQp18FYbf9IVeG
         a7bbyxILpEiHkSX7IOzjmKPIN419zejpAjZdt6I5aDR1BQtw/dpey9y59ndZ/wuEW7t/
         E8/2NWWXwur40keKFFuUw8wReupHFsoiy/aS266/SNj69sZHYyXYfPEcQQiTrEIoTUK2
         8sMntRBqFdZNFnqlexO0CVSLIEOfc+Uj5M/7Rbq9pbj4IHnHsUHubGXJeDbaQSV39Rsx
         cfCQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9mCk4MzRCgCVWSDnkTdVtXLHaEtql1YKBUh0GXwXqzdwz4wFLJ7YaCeWt47MixbH6AotVg2x1aRlLLPviSjR6CD8NUvfbmK/oQ96s
X-Gm-Message-State: AOJu0Yybd11KY+kMCnSGIqT/jccfUtlnqfVBVom9j1wK0NGPzku22zH9
	8TMyqCfhOv33th+e3ZNUDESpGWv1Bfk8sW4bucMZ3Vw5Xtgskg5LRdTZd6kKK3YTMq4L67JOENm
	PzYUNDB6f+cBLzIyh+OrEHPjcVflSvl5FPYE/
X-Google-Smtp-Source: AGHT+IGe+hbnq8FqqpBq6h2fG7LKEjlEXbgQq7QkXIaGvlbHxBcjruOiSCjcQRxF74y9Lk6vbB+gLm+PKJ0ZasuFnCc=
X-Received: by 2002:ac8:7fd3:0:b0:447:d7ff:961d with SMTP id
 d75a77b69052e-451bd1ea570mr1055671cf.9.1722920919750; Mon, 05 Aug 2024
 22:08:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240806022114.3320543-1-yuzhao@google.com> <20240806022114.3320543-4-yuzhao@google.com>
In-Reply-To: <20240806022114.3320543-4-yuzhao@google.com>
From: Yu Zhao <yuzhao@google.com>
Date: Mon, 5 Aug 2024 23:08:01 -0600
Message-ID: <CAOUHufY-CRHoALNEenHvh6HHS=B7nX5_YyB-XZobi5zxY5nB+Q@mail.gmail.com>
Subject: Re: [RFC PATCH 3/4] arm64: pause remote CPUs to update vmemmap
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Rientjes <rientjes@google.com>, 
	Douglas Anderson <dianders@chromium.org>, Frank van der Linden <fvdl@google.com>, 
	Mark Rutland <mark.rutland@arm.com>, Muchun Song <muchun.song@linux.dev>, 
	Nanyong Sun <sunnanyong@huawei.com>, Yang Shi <yang@os.amperecomputing.com>, 
	linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 5, 2024 at 8:21=E2=80=AFPM Yu Zhao <yuzhao@google.com> wrote:
>
> Pause remote CPUs so that the local CPU can follow the proper BBM
> sequence to safely update the vmemmap mapping `struct page` areas.
>
> While updating the vmemmap, it is guaranteed that neither the local
> CPU nor the remote ones will access the `struct page` area being
> updated, and therefore they will not trigger kernel PFs.
>
> Signed-off-by: Yu Zhao <yuzhao@google.com>
> ---
>  arch/arm64/include/asm/pgalloc.h | 55 ++++++++++++++++++++++++++++++++
>  mm/hugetlb_vmemmap.c             | 14 ++++++++
>  2 files changed, 69 insertions(+)
>
> diff --git a/arch/arm64/include/asm/pgalloc.h b/arch/arm64/include/asm/pg=
alloc.h
> index 8ff5f2a2579e..1af1aa34a351 100644
> --- a/arch/arm64/include/asm/pgalloc.h
> +++ b/arch/arm64/include/asm/pgalloc.h
> @@ -12,6 +12,7 @@
>  #include <asm/processor.h>
>  #include <asm/cacheflush.h>
>  #include <asm/tlbflush.h>
> +#include <asm/cpu.h>
>
>  #define __HAVE_ARCH_PGD_FREE
>  #define __HAVE_ARCH_PUD_FREE
> @@ -137,4 +138,58 @@ pmd_populate(struct mm_struct *mm, pmd_t *pmdp, pgta=
ble_t ptep)
>         __pmd_populate(pmdp, page_to_phys(ptep), PMD_TYPE_TABLE | PMD_TAB=
LE_PXN);
>  }
>
> +#ifdef CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
> +
> +#define vmemmap_update_lock vmemmap_update_lock
> +static inline void vmemmap_update_lock(void)
> +{
> +       cpus_read_lock();
> +}
> +
> +#define vmemmap_update_unlock vmemmap_update_unlock
> +static inline void vmemmap_update_unlock(void)
> +{
> +       cpus_read_unlock();
> +}
> +
> +#define vmemmap_update_pte vmemmap_update_pte
> +static inline void vmemmap_update_pte(unsigned long addr, pte_t *ptep, p=
te_t pte)
> +{
> +       preempt_disable();
> +       pause_remote_cpus();
> +
> +       pte_clear(&init_mm, addr, ptep);
> +       flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
> +       set_pte_at(&init_mm, addr, ptep, pte);
> +
> +       resume_remote_cpus();
> +       preempt_enable();
> +}

Note that I kept this API from Nanyong for the sake of discussion.
What I actually plan to test in our production is:

#define vmemmap_update_pte_range_start vmemmap_update_pte_range_start
static inline void vmemmap_update_pte_range_start(pte_t *pte,
                                                  unsigned long start,
unsigned long end)
{
        preempt_disable();
        pause_remote_cpus();

        for (; start !=3D end; start +=3D PAGE_SIZE, pte++)
                pte_clear(&init_mm, start, pte);

        flush_tlb_kernel_range(start, end);
}

#define vmemmap_update_pte_range_end vmemmap_update_pte_range_end
static inline void vmemmap_update_pte_range_end(void)
{
        resume_remote_cpus();
        preempt_enable();
}

> +#define vmemmap_update_pmd vmemmap_update_pmd
> +static inline void vmemmap_update_pmd(unsigned long addr, pmd_t *pmdp, p=
te_t *ptep)
> +{
> +       preempt_disable();
> +       pause_remote_cpus();
> +
> +       pmd_clear(pmdp);
> +       flush_tlb_kernel_range(addr, addr + PMD_SIZE);
> +       pmd_populate_kernel(&init_mm, pmdp, ptep);
> +
> +       resume_remote_cpus();
> +       preempt_enable();
> +}
> +
> +#define vmemmap_flush_tlb_all vmemmap_flush_tlb_all
> +static inline void vmemmap_flush_tlb_all(void)
> +{
> +}
> +
> +#define vmemmap_flush_tlb_range vmemmap_flush_tlb_range
> +static inline void vmemmap_flush_tlb_range(unsigned long start, unsigned=
 long end)
> +{
> +}
> +
> +#endif /* CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP */
> +
>  #endif
> diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
> index 2dd92e58f304..893c73493d9c 100644
> --- a/mm/hugetlb_vmemmap.c
> +++ b/mm/hugetlb_vmemmap.c
> @@ -46,6 +46,18 @@ struct vmemmap_remap_walk {
>         unsigned long           flags;
>  };
>
> +#ifndef vmemmap_update_lock
> +static void vmemmap_update_lock(void)
> +{
> +}
> +#endif
> +
> +#ifndef vmemmap_update_unlock
> +static void vmemmap_update_unlock(void)
> +{
> +}
> +#endif
> +
>  #ifndef vmemmap_update_pmd
>  static inline void vmemmap_update_pmd(unsigned long addr,
>                                       pmd_t *pmdp, pte_t *ptep)
> @@ -194,10 +206,12 @@ static int vmemmap_remap_range(unsigned long start,=
 unsigned long end,
>
>         VM_BUG_ON(!PAGE_ALIGNED(start | end));
>
> +       vmemmap_update_lock();
>         mmap_read_lock(&init_mm);
>         ret =3D walk_page_range_novma(&init_mm, start, end, &vmemmap_rema=
p_ops,
>                                     NULL, walk);
>         mmap_read_unlock(&init_mm);
> +       vmemmap_update_unlock();
>         if (ret)
>                 return ret;
>
> --
> 2.46.0.rc2.264.g509ed76dc8-goog
>

