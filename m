Return-Path: <linux-kernel+bounces-402175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61FD39C24BA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 19:16:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 856C41C27464
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 18:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2499A193418;
	Fri,  8 Nov 2024 18:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SUmfGxCK"
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B499B5B1FB
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 18:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731089809; cv=none; b=q//vso7kEewIEo4z6HvMyMyv87i3TCKDQkZnZM+DXWi4CPTmN9LZEmIrWirYHie+iSdXO+l2Bd74zd9z9qg8rRmzC7wh36EYgvAVFCf19xE7178u9PkWDhS5wMBxsq2ZLrrtPOEY/HuoaWoSz+wRDtmmxwtgahFH0SNiyLDFpu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731089809; c=relaxed/simple;
	bh=eHL79MdxXAkHAIUazmydkIp6ceD8CSQFiUsCm/yFhyo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jnf0W6BbSoMyVv55MY7TAsbcY030hq1VxsM2ctDLKUKCuctcCJku6Pq33yIPeWZUeSqNDiTth+S1xRktm9Gk5gu2l3NoYgoxOQ/GpE9E5YqagYV49LmyrtTvD+Mxnr/3PXkkYnOjUj3/L6eD/ju3Xi2myyOS0airrzgOZUYaUiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SUmfGxCK; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-460969c49f2so9511cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 10:16:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731089806; x=1731694606; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tbvAIZdxHGw64yGxLAgOjeqw/WxAXQWZByWtHbzgnhg=;
        b=SUmfGxCKkZmhjMEQ4DLeRj16P0KR3+qtasNVQHpiNO9w9cqzarsfv908HyBRcsZuOd
         Vow6nHHBm/ffRmElsjsRMrWYVX7R1xEPtckYQu5kJyZ+brNG58rFYML6qnzUBTYwweZz
         RpxJFlVFNnK3ma5Z+OC7fhU4sFjJ2m//R6IEwx3qZ1LJeJw61FX0o3JltLUYOd0R82WY
         CEfKkNgN/cy2w2ARKuxmm/8AByorNwJah5HPPBQNhen0UuwiLx0X9KTgTJgqo+O++3xS
         hUOpIqOhWqXh+GntAxyTRVMDT/FZrMcw/qWPdIn4e+/s74/tXLncg1OD+3HnL/nCcrod
         YoYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731089806; x=1731694606;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tbvAIZdxHGw64yGxLAgOjeqw/WxAXQWZByWtHbzgnhg=;
        b=BZJelzHq2yxA6w9VZUVx+eomD8ybK/31Vm0y6cHXtxxgpdtPpthMonnmzE2z5UkpW/
         kIAztQZtcwyssIk3DREisY2aGbH08nX1YA9+HGzv91pSAOw7oHMSizZT3nr4EpAcYcsZ
         /A6Gf/rd6CAmulxrYC49ANujGtQag6M5kvVAWnGSNgJgErB1KvP/CvYlZOYv3tV1eYNz
         KHYCLgwiIuhM8QBTkKe2Z8YbEjF4ipm8l8JKcUAOqYUkdmvd1HXGQ6XR/5mOi+u9FUkA
         +HINPozuPnNwG+ftqaaUeS6BWKOtzWTujx1x20dLZFRdeXJ9nyl4NJDngeMHgoRLUJwI
         vZcw==
X-Forwarded-Encrypted: i=1; AJvYcCWkvQg2DJVnH31UpuQT8dt82cf4jpy5b4NWENZueuld3qmJdHoc5ipqsLkSlbcaxIdk6TVRbkZkCnRSBoM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxJ+PhSiQzi28NqqUPVEYQFPTH/mLnvJc0UhCCkP+crMyvyJAp
	qLE/pVoQNAaFkOEx/ojtWPvc01ln81yoZukiEod1lsCGxktsjTV978BxMGpH4CzHT7nUrn5CqVh
	DvXazCp2tnXmnH62HrmZaFIP2d3vMkDHCyXoP
X-Gm-Gg: ASbGnctXBjygy5vrL8+XYYJ0fGe1wZ7F0TP8XS9IpOhmdZlTGXFGPtHG48kYrwd6GuX
	qMerx+pT/1P9ihQDxZNoRrPEILWKlS5k=
X-Google-Smtp-Source: AGHT+IHNgvJ5PimTrDi0dUye655zn9b0CrOkbpONn1KMYDJ9FFvfmlO4ZFERX5jgeQ9Uc2Nj95KnwUJNjLBriMSi/DU=
X-Received: by 2002:ac8:584c:0:b0:461:70cc:3799 with SMTP id
 d75a77b69052e-462fa610b20mr8118441cf.21.1731089806166; Fri, 08 Nov 2024
 10:16:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241108075004.131911-1-hao.ge@linux.dev>
In-Reply-To: <20241108075004.131911-1-hao.ge@linux.dev>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 8 Nov 2024 10:16:35 -0800
Message-ID: <CAJuCfpEp_3Dz32fdpUaUbPaP6KZ+0fXmXBvBV1jRt9Q+LMRQAQ@mail.gmail.com>
Subject: Re: [PATCH] lib/alloc_tag: Remove the sysctl configuration to prevent
 users from disabling it at runtime
To: Hao Ge <hao.ge@linux.dev>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, Hao Ge <gehao@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 7, 2024 at 11:50=E2=80=AFPM Hao Ge <hao.ge@linux.dev> wrote:
>
> From: Hao Ge <gehao@kylinos.cn>
>
> After much consideration,I have decided to remove
> the "mem_profiling" sysctl interface to prevent
> users from dynamically enabling or disabling the
> MEMORY ALLOCATION PROFILING feature at runtime.
>
> I have taken the following actions: I set
> CONFIG_MEM_ALLOC_PROFILING_ENABLED_BY_DEFAULT=3Dy to
> enable memory allocation profiling by default,
> and then made adjustments to mem_profiling dynamically
> during runtime.
>
> When I ran the OOM test program, I obtained useful
> information that was indeed very helpful for debugging.
>
> [ 1023.065402] Memory allocations:
> [ 1023.065407]     12.8 GiB     6546 mm/huge_memory.c:1328 func:do_huge_p=
md_anonymous_page
> [ 1023.065412]      873 MiB   229985 arch/arm64/mm/fault.c:986 func:vma_a=
lloc_zeroed_movable_folio
> [ 1023.065415]      187 MiB    29732 mm/slub.c:2412 func:alloc_slab_page
> [ 1023.065418]     99.8 MiB    25560 mm/memory.c:1065 func:folio_prealloc
> [ 1023.065421]     47.2 MiB     3189 mm/readahead.c:434 func:ra_alloc_fol=
io
> [ 1023.065424]     30.0 MiB       15 mm/khugepaged.c:1072 func:alloc_char=
ge_folio
> [ 1023.065428]     28.6 MiB      514 mm/compaction.c:1880 func:compaction=
_alloc
> [ 1023.065430]     25.8 MiB     6592 mm/page_ext.c:271 func:alloc_page_ex=
t
> [ 1023.065433]     25.6 MiB     6546 mm/huge_memory.c:1161 func:__do_huge=
_pmd_anonymous_page
> [ 1023.065436]     23.5 MiB     6017 mm/shmem.c:1771 func:shmem_alloc_fol=
io
>
> After running echo 0 > /proc/sys/vm/mem_profiling
> and then executing the same test program,
> I obtained the following results
>
> [ 1156.509699] Memory allocations:
> [ 1156.509703]      187 MiB    29645 mm/slub.c:2412 func:alloc_slab_page
> [ 1156.509707]      142 MiB     9357 mm/readahead.c:434 func:ra_alloc_fol=
io
> [ 1156.509710]      136 MiB    41325 arch/arm64/mm/fault.c:986 func:vma_a=
lloc_zeroed_movable_folio
> [ 1156.509713]     99.7 MiB    25531 mm/memory.c:1065 func:folio_prealloc
> [ 1156.509716]     56.0 MiB       28 mm/huge_memory.c:1328 func:do_huge_p=
md_anonymous_page
> [ 1156.509719]     30.0 MiB       15 mm/khugepaged.c:1072 func:alloc_char=
ge_folio
> [ 1156.509723]     28.6 MiB      514 mm/compaction.c:1880 func:compaction=
_alloc
> [ 1156.509725]     26.3 MiB     7460 mm/readahead.c:264 func:page_cache_r=
a_unbounded
> [ 1156.509728]     25.8 MiB     6592 mm/page_ext.c:271 func:alloc_page_ex=
t
> [ 1156.509730]     23.5 MiB     6016 mm/shmem.c:1771 func:shmem_alloc_fol=
io
>
> Because mem_profiling was disabled by executing
> echo 0 > /proc/sys/vm/mem_profiling,we are unable to
> record memory allocation information after the disablement.

Naturally you are unable to track the allocations after disabling it.
You disabled it as root, so I assume you know what you are doing.

> These output logs can mislead users. And similarly, the same
> applies to alloc_info.

I would understand if you made /proc/allocinfo empty after disabling
it to avoid confusing the user, but ripping out the ability to
enable/disable profiling at runtime does not make sense to me. Once
you collect required data, disabling profiling gets you back the
performance that you pay for it. There are usecases when a program on
a remote device periodically enables profiling for some time, records
the difference in allocations and then disables it. Your change breaks
such users.

>
> We already have boot parameters that allow users to
> choose whether to enable or disable.
> In order to maintain the accuracy of memory allocation
> information,I have decided to remove the runtime switch.

Well, I disagree with your decision.
NAK.

>
> Signed-off-by: Hao Ge <gehao@kylinos.cn>
> ---
>  lib/alloc_tag.c | 26 --------------------------
>  1 file changed, 26 deletions(-)
>
> diff --git a/lib/alloc_tag.c b/lib/alloc_tag.c
> index 81e5f9a70f22..47fa969c23f3 100644
> --- a/lib/alloc_tag.c
> +++ b/lib/alloc_tag.c
> @@ -227,31 +227,6 @@ struct page_ext_operations page_alloc_tagging_ops =
=3D {
>  };
>  EXPORT_SYMBOL(page_alloc_tagging_ops);
>
> -#ifdef CONFIG_SYSCTL
> -static struct ctl_table memory_allocation_profiling_sysctls[] =3D {
> -       {
> -               .procname       =3D "mem_profiling",
> -               .data           =3D &mem_alloc_profiling_key,
> -#ifdef CONFIG_MEM_ALLOC_PROFILING_DEBUG
> -               .mode           =3D 0444,
> -#else
> -               .mode           =3D 0644,
> -#endif
> -               .proc_handler   =3D proc_do_static_key,
> -       },
> -};
> -
> -static void __init sysctl_init(void)
> -{
> -       if (!mem_profiling_support)
> -               memory_allocation_profiling_sysctls[0].mode =3D 0444;
> -
> -       register_sysctl_init("vm", memory_allocation_profiling_sysctls);
> -}
> -#else /* CONFIG_SYSCTL */
> -static inline void sysctl_init(void) {}
> -#endif /* CONFIG_SYSCTL */
> -
>  static int __init alloc_tag_init(void)
>  {
>         const struct codetag_type_desc desc =3D {
> @@ -264,7 +239,6 @@ static int __init alloc_tag_init(void)
>         if (IS_ERR(alloc_tag_cttype))
>                 return PTR_ERR(alloc_tag_cttype);
>
> -       sysctl_init();
>         procfs_init();
>
>         return 0;
> --
> 2.25.1
>

