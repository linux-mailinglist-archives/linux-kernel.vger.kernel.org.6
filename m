Return-Path: <linux-kernel+bounces-448844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75D9A9F4656
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 09:45:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F5701886CD0
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 08:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B9B81DED77;
	Tue, 17 Dec 2024 08:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ChzQXF4N"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1CB31DED70
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 08:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734425065; cv=none; b=l852hbwQi+K2cHiKqJ8wla9wR3R3JlQHFwve8Iz2pp0G8JDJlJGo6eUOmaJZGJEC0+IfaYGar/IosbN02dbU+Ey/R1gege+mC7jhKf75jxboo17daLrVMHzAlL7IQooS3fQ+qDzPelAsl6jH0QKM3XtnWPFboT3ZBbOaSvuDgy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734425065; c=relaxed/simple;
	bh=oE9r30qVJ25lEtpADYxY0kb0u8ajuTEGjpH+9tV4SVo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LPScBYFHywieuIiLzeRC1dUR1prs7RZASTYXZAUtg4pmv8ABvqMbCQDjmBFecFqID0GjtspOrJKy9MJwF8VSYbUhra3D9w4nvh+82GwOCi1lwH+rAW4FSMGQdUiDXXsDEujpbJgukh9n9tPJb9daxStz8hTdI6ea7b1SulY3MIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ChzQXF4N; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43622893c3cso26405e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 00:44:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734425062; x=1735029862; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0XC2ZwAn0E++YNctCTdRNukhVgGGxBVyakf6CmRi2f4=;
        b=ChzQXF4N1xEbOmpOdBu7exm9u/BC91JmuwM71AMVGPwT3eT6wVufEUYMM8jcFdMoSP
         v7RXjdx9zImGPSKOam/lxYsXJTARHVVJnULH/dGpt5lrmotgEZfFChhlj/Qf3RuGQUwG
         Jui0HlSClDGjkoSv463uALLAAf0lDmggnPu/Y111bikek+ZqwGqj9EM5y4LSwJ5v4gfq
         2Ui4FjWmywfTHc2RLLYqdGOztGGArORd0ig6T2LI4pzkYxGXrlrXL03o3kE/NQGA+Tt2
         V3OSRnxRpB7x7U82AnQmoFu2KEMcfsQu7zFvhS4D6sY2WSk5UgcR/XGUQBk/wziIYfL8
         QZ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734425062; x=1735029862;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0XC2ZwAn0E++YNctCTdRNukhVgGGxBVyakf6CmRi2f4=;
        b=wy99ycq7hhjnIzvT2qOnmHwUwR6phx5Mt7UtYSXw/bMmW4fSOEz109UGJHlUiiaL5n
         J6rpmysVvdmtlf0zhT7burs6ikazkNhkQikFiOV6vleRX54jFw5/EDaT59pP+VFuwd75
         BaHeTh0idAC3V36J0pdhsvJuhf0FzXoefGWV8rll80+we3wMxDwQ4jpcCwI8uKIJd6vW
         jHuPsLGHVpwKH0iRHqBHUGo4jNr5WRsOeSpRMeK8xuP4T5rN6Tjrf1GmHSQrTtdF7Lvu
         vVeUVnhIXn7qZlrhLb2QCJEas+Ql/RHVAqs9/+lbomh41PvMepFa5ecNu3FTOfnSb5xq
         cVKA==
X-Forwarded-Encrypted: i=1; AJvYcCWoGrfpbw89/ui8gK9c34Mg/853stToJ1zzAsyAz6cqRTYSbcYwEaGDd5yaDaqviHahCmUt5F6U5F/ibN4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYCa5S9/vAHm58iy21hkW/htaH88fAXR94FwveCikPxNePq/9G
	UoePACybz5V5yl7uZ7NzEwqGeX+BdhT6WWLXKg5w4ltUJ1L1RN5ddwOA0MIXi3s6ui+9RUk8O3T
	phV0dFu24Vduvvo0KvZkdSaEGuptWxanscRzO
X-Gm-Gg: ASbGncvkQCW5xzZO2XXdilyn9PeoDVnvz3Wd0hbqGnXAnQFHFqysDLpKeB9kxw+tglB
	yNj1YbhBuz/NW5QynX3+rzvfUC7kBwMjkEftBr6BrhbUhfqEi8Q9Ho81CBiUTzHRDCHA=
X-Google-Smtp-Source: AGHT+IGM0bpr7//XD6OxuzJzrQz8DmDuxUXL0rgx8RL7HNA2kZE/P+I6liY2VW7R5nSj/mMRt13Okt8o4WT6PlKUZeY=
X-Received: by 2002:a05:600c:2317:b0:42c:9e35:cde6 with SMTP id
 5b1f17b1804b1-4364901b009mr920745e9.2.1734425061742; Tue, 17 Dec 2024
 00:44:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241216175803.2716565-1-qperret@google.com> <20241216175803.2716565-4-qperret@google.com>
In-Reply-To: <20241216175803.2716565-4-qperret@google.com>
From: Fuad Tabba <tabba@google.com>
Date: Tue, 17 Dec 2024 08:43:45 +0000
Message-ID: <CA+EHjTznFMF77kfUTkMeRpHnz9HAD1gSw6Do6tQvYSJ_jXG3gg@mail.gmail.com>
Subject: Re: [PATCH v3 03/18] KVM: arm64: Make hyp_page::order a u8
To: Quentin Perret <qperret@google.com>
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Vincent Donnefort <vdonnefort@google.com>, 
	Sebastian Ene <sebastianene@google.com>, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 16 Dec 2024 at 17:58, Quentin Perret <qperret@google.com> wrote:
>
> We don't need 16 bits to store the hyp page order, and we'll need some
> bits to store page ownership data soon, so let's reduce the order
> member.
>
> Signed-off-by: Quentin Perret <qperret@google.com>

Reviewed-by: Fuad Tabba <tabba@google.com>

Cheers,
/fuad

> ---
>  arch/arm64/kvm/hyp/include/nvhe/gfp.h    |  6 +++---
>  arch/arm64/kvm/hyp/include/nvhe/memory.h |  5 +++--
>  arch/arm64/kvm/hyp/nvhe/page_alloc.c     | 14 +++++++-------
>  3 files changed, 13 insertions(+), 12 deletions(-)
>
> diff --git a/arch/arm64/kvm/hyp/include/nvhe/gfp.h b/arch/arm64/kvm/hyp/include/nvhe/gfp.h
> index 97c527ef53c2..f1725bad6331 100644
> --- a/arch/arm64/kvm/hyp/include/nvhe/gfp.h
> +++ b/arch/arm64/kvm/hyp/include/nvhe/gfp.h
> @@ -7,7 +7,7 @@
>  #include <nvhe/memory.h>
>  #include <nvhe/spinlock.h>
>
> -#define HYP_NO_ORDER   USHRT_MAX
> +#define HYP_NO_ORDER   0xff
>
>  struct hyp_pool {
>         /*
> @@ -19,11 +19,11 @@ struct hyp_pool {
>         struct list_head free_area[NR_PAGE_ORDERS];
>         phys_addr_t range_start;
>         phys_addr_t range_end;
> -       unsigned short max_order;
> +       u8 max_order;
>  };
>
>  /* Allocation */
> -void *hyp_alloc_pages(struct hyp_pool *pool, unsigned short order);
> +void *hyp_alloc_pages(struct hyp_pool *pool, u8 order);
>  void hyp_split_page(struct hyp_page *page);
>  void hyp_get_page(struct hyp_pool *pool, void *addr);
>  void hyp_put_page(struct hyp_pool *pool, void *addr);
> diff --git a/arch/arm64/kvm/hyp/include/nvhe/memory.h b/arch/arm64/kvm/hyp/include/nvhe/memory.h
> index c84b24234ac7..45b8d1840aa4 100644
> --- a/arch/arm64/kvm/hyp/include/nvhe/memory.h
> +++ b/arch/arm64/kvm/hyp/include/nvhe/memory.h
> @@ -41,8 +41,9 @@ static inline enum pkvm_page_state pkvm_getstate(enum kvm_pgtable_prot prot)
>  }
>
>  struct hyp_page {
> -       unsigned short refcount;
> -       unsigned short order;
> +       u16 refcount;
> +       u8 order;
> +       u8 reserved;
>  };
>
>  extern u64 __hyp_vmemmap;
> diff --git a/arch/arm64/kvm/hyp/nvhe/page_alloc.c b/arch/arm64/kvm/hyp/nvhe/page_alloc.c
> index e691290d3765..a1eb27a1a747 100644
> --- a/arch/arm64/kvm/hyp/nvhe/page_alloc.c
> +++ b/arch/arm64/kvm/hyp/nvhe/page_alloc.c
> @@ -32,7 +32,7 @@ u64 __hyp_vmemmap;
>   */
>  static struct hyp_page *__find_buddy_nocheck(struct hyp_pool *pool,
>                                              struct hyp_page *p,
> -                                            unsigned short order)
> +                                            u8 order)
>  {
>         phys_addr_t addr = hyp_page_to_phys(p);
>
> @@ -51,7 +51,7 @@ static struct hyp_page *__find_buddy_nocheck(struct hyp_pool *pool,
>  /* Find a buddy page currently available for allocation */
>  static struct hyp_page *__find_buddy_avail(struct hyp_pool *pool,
>                                            struct hyp_page *p,
> -                                          unsigned short order)
> +                                          u8 order)
>  {
>         struct hyp_page *buddy = __find_buddy_nocheck(pool, p, order);
>
> @@ -94,7 +94,7 @@ static void __hyp_attach_page(struct hyp_pool *pool,
>                               struct hyp_page *p)
>  {
>         phys_addr_t phys = hyp_page_to_phys(p);
> -       unsigned short order = p->order;
> +       u8 order = p->order;
>         struct hyp_page *buddy;
>
>         memset(hyp_page_to_virt(p), 0, PAGE_SIZE << p->order);
> @@ -129,7 +129,7 @@ static void __hyp_attach_page(struct hyp_pool *pool,
>
>  static struct hyp_page *__hyp_extract_page(struct hyp_pool *pool,
>                                            struct hyp_page *p,
> -                                          unsigned short order)
> +                                          u8 order)
>  {
>         struct hyp_page *buddy;
>
> @@ -183,7 +183,7 @@ void hyp_get_page(struct hyp_pool *pool, void *addr)
>
>  void hyp_split_page(struct hyp_page *p)
>  {
> -       unsigned short order = p->order;
> +       u8 order = p->order;
>         unsigned int i;
>
>         p->order = 0;
> @@ -195,10 +195,10 @@ void hyp_split_page(struct hyp_page *p)
>         }
>  }
>
> -void *hyp_alloc_pages(struct hyp_pool *pool, unsigned short order)
> +void *hyp_alloc_pages(struct hyp_pool *pool, u8 order)
>  {
> -       unsigned short i = order;
>         struct hyp_page *p;
> +       u8 i = order;
>
>         hyp_spin_lock(&pool->lock);
>
> --
> 2.47.1.613.gc27f4b7a9f-goog
>

