Return-Path: <linux-kernel+bounces-278960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B359194B723
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 09:09:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D67B21C22C9B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 07:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85F0C187FEC;
	Thu,  8 Aug 2024 07:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SCqpZ5aE"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08857464
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 07:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723100947; cv=none; b=bM7UC+uPczbqvbKJqSpH2SkQV4JXs2jNB+7TDDkRNYBjlROE7Rx8jYfzBUGnFXt8z3E7PkkYeSZqyNEzv1LnLJXnVusk4AFhHsLteZ3ioUW8D8RTPPUNx+dzXUFLJGmy3KMnFFqTxrgq36q84eDK9XJRtoTEfiNAG1qjbOiSe9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723100947; c=relaxed/simple;
	bh=anJI/4jPgj1af/zCo24BX2d9/jAF2brxdTed+Qk5Nik=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NwQorfWdMzyVnIkVtPGcggm9SbP60F0TqU7UT9Z4LOY89JUgbUKB33tLPyKLtcbJ99OpHQmlSncpP7lqv9NBYFxrkAWO1xlw3b0NDakwFCYd9+7lmIG2bPJp1Iu1u1HDJCSMQnH2J3xUFBIm5WiVgdgqKnb7j9MAM36KN4H6XL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SCqpZ5aE; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1ff4568676eso6774515ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 00:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723100945; x=1723705745; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gGDJc5TtLW9G4T28A6rcvVF1GMWIs2BFGSUiZ3zrWr4=;
        b=SCqpZ5aE0njREaKBJeHQ9NEAVXjCSMbZRxRToPCqhesMhegWQ9nS2DO7j/sLZ135G5
         Z+XDLguwAbQgav2OcwZHldAsfAPS3o5Geo+MlvqWWSS029f05AiiihEVu/3eql0rLhnL
         5MupucgjdzbSIe0ytM0HyX7uEyvqlh6TZJixvq87K5LBsopbfJxWFhoqC5rZtt3G7/Hi
         AwsZ1dikLhZCFWEH7H5+LejgGQP3B3+eutM/75ouvpqcrXIo4oBuCvLgZLCmKYNjux8r
         RC1lsPGCwFxeTLNPjKVXUamzHfPxXkv19dV7f9lTy6loXF89AcpItpINH3vxjUWKC1OY
         Y1RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723100945; x=1723705745;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gGDJc5TtLW9G4T28A6rcvVF1GMWIs2BFGSUiZ3zrWr4=;
        b=LE553ISbcxAl14pyty5TUFaZCueNaHpf2+ViaiAIVw02RbKK/bx/l4mlVkqsZSEgpk
         ozhEVYM4qMn4DTA65PupgNMAvQ6byfrh5P3qKGGOJ0RHcwYCx43MxBwVtPHrQLaosD1g
         qYQaI0gN/wKSkCLmSpUPHauTC0DhbIWgt5zohAq9bLIVyc3EfbvctYknzEGTdVkUXSCN
         +NGXB42l+koU8pGLzs53sz193Sdy3yciilB50igbtnK3KhygvjXHAYurw/UmM47+6xwY
         J7dn0yiA/0ZcHmb9pQKsQcJ4rzZa6qQhP2KtAZw0UfYodHFpKNEz4ts3IXNb2SM1ZNtM
         xtcQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+U/p9SHy9mlVpypgweRLkV/kFZCaaLgoK/VfNqpLemh5iX3Y4AKLf/4DOmGVwQkkW7PGyKIpwgejI4ERsnigm7m2YuwNL0l+SO4/1
X-Gm-Message-State: AOJu0Yy+ahb/SVBPSK4YhEaKHYKU9FK7QUArOc9WHZEyISH2DAlgKo10
	JE+ZyyUyixsyE/rT3kHAftk0ejiMzX/4CZwPMaTdJp64S1hqgApk
X-Google-Smtp-Source: AGHT+IH+Kd8shLxlVykA2RBrqnQ7pohjOeQPSmzEpeVOcnbzKeqYT8+KDFdNpg+DMMDDPs6rcI65lQ==
X-Received: by 2002:a05:6a20:728d:b0:1c4:a7a0:a7d4 with SMTP id adf61e73a8af0-1c6fce762f4mr1150942637.7.1723100944743;
        Thu, 08 Aug 2024 00:09:04 -0700 (PDT)
Received: from barry-desktop.hub ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-710cb2fb0a5sm554842b3a.208.2024.08.08.00.08.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 00:09:04 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: 21cnbao@gmail.com
Cc: akpm@linux-foundation.org,
	baolin.wang@linux.alibaba.com,
	chrisl@kernel.org,
	david@redhat.com,
	hanchuanhua@oppo.com,
	ioworker0@gmail.com,
	kaleshsingh@google.com,
	kasong@tencent.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	ryan.roberts@arm.com,
	v-songbaohua@oppo.com,
	ziy@nvidia.com
Subject: Re: [PATCH RFC 1/2] mm: collect the number of anon large folios
Date: Thu,  8 Aug 2024 19:08:47 +1200
Message-Id: <20240808070847.285075-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240808010457.228753-2-21cnbao@gmail.com>
References: <20240808010457.228753-2-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, Aug 8, 2024 at 1:05 PM Barry Song <21cnbao@gmail.com> wrote:
>
> From: Barry Song <v-songbaohua@oppo.com>
>
> When a new anonymous mTHP is added to the rmap, we increase the count.
> We reduce the count whenever an mTHP is completely unmapped.
>
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> ---
>  Documentation/admin-guide/mm/transhuge.rst |  5 +++++
>  include/linux/huge_mm.h                    | 15 +++++++++++++--
>  mm/huge_memory.c                           |  2 ++
>  mm/rmap.c                                  |  3 +++
>  4 files changed, 23 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
> index 058485daf186..715f181543f6 100644
> --- a/Documentation/admin-guide/mm/transhuge.rst
> +++ b/Documentation/admin-guide/mm/transhuge.rst
> @@ -527,6 +527,11 @@ split_deferred
>          it would free up some memory. Pages on split queue are going to
>          be split under memory pressure, if splitting is possible.
>
> +anon_num
> +       the number of anon huge pages we have in the whole system.
> +       These huge pages could be still entirely mapped and have partially
> +       unmapped and unused subpages.
> +
>  As the system ages, allocating huge pages may be expensive as the
>  system uses memory compaction to copy data around memory to free a
>  huge page for use. There are some counters in ``/proc/vmstat`` to help
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index e25d9ebfdf89..294c348fe3cc 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -281,6 +281,7 @@ enum mthp_stat_item {
>         MTHP_STAT_SPLIT,
>         MTHP_STAT_SPLIT_FAILED,
>         MTHP_STAT_SPLIT_DEFERRED,
> +       MTHP_STAT_NR_ANON,
>         __MTHP_STAT_COUNT
>  };
>
> @@ -291,14 +292,24 @@ struct mthp_stat {
>  #ifdef CONFIG_SYSFS
>  DECLARE_PER_CPU(struct mthp_stat, mthp_stats);
>
> -static inline void count_mthp_stat(int order, enum mthp_stat_item item)
> +static inline void mod_mthp_stat(int order, enum mthp_stat_item item, int delta)
>  {
>         if (order <= 0 || order > PMD_ORDER)
>                 return;
>
> -       this_cpu_inc(mthp_stats.stats[order][item]);
> +       this_cpu_add(mthp_stats.stats[order][item], delta);
> +}
> +
> +static inline void count_mthp_stat(int order, enum mthp_stat_item item)
> +{
> +       mod_mthp_stat(order, item, 1);
>  }
> +
>  #else
> +static inline void mod_mthp_stat(int order, enum mthp_stat_item item, int delta)
> +{
> +}
> +
>  static inline void count_mthp_stat(int order, enum mthp_stat_item item)
>  {
>  }
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 697fcf89f975..b6bc2a3791e3 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -578,6 +578,7 @@ DEFINE_MTHP_STAT_ATTR(shmem_fallback_charge, MTHP_STAT_SHMEM_FALLBACK_CHARGE);
>  DEFINE_MTHP_STAT_ATTR(split, MTHP_STAT_SPLIT);
>  DEFINE_MTHP_STAT_ATTR(split_failed, MTHP_STAT_SPLIT_FAILED);
>  DEFINE_MTHP_STAT_ATTR(split_deferred, MTHP_STAT_SPLIT_DEFERRED);
> +DEFINE_MTHP_STAT_ATTR(anon_num, MTHP_STAT_NR_ANON);
>
>  static struct attribute *stats_attrs[] = {
>         &anon_fault_alloc_attr.attr,
> @@ -591,6 +592,7 @@ static struct attribute *stats_attrs[] = {
>         &split_attr.attr,
>         &split_failed_attr.attr,
>         &split_deferred_attr.attr,
> +       &anon_num_attr.attr,
>         NULL,
>  };
>
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 901950200957..2b722f26224c 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1467,6 +1467,7 @@ void folio_add_new_anon_rmap(struct folio *folio, struct vm_area_struct *vma,
>         }
>
>         __folio_mod_stat(folio, nr, nr_pmdmapped);
> +       mod_mthp_stat(folio_order(folio), MTHP_STAT_NR_ANON, 1);
>  }
>
>  static __always_inline void __folio_add_file_rmap(struct folio *folio,
> @@ -1582,6 +1583,8 @@ static __always_inline void __folio_remove_rmap(struct folio *folio,
>             list_empty(&folio->_deferred_list))
>                 deferred_split_folio(folio);
>         __folio_mod_stat(folio, -nr, -nr_pmdmapped);
> +       if (folio_test_anon(folio) && !atomic_read(mapped))

could have a risk here two processes unmap at the same time, so
they both get zero on atomic_read(mapped)? should read the value
of atomic_dec_return() instead to confirm we are the last one
doing unmap?

diff --git a/mm/rmap.c b/mm/rmap.c
index 2b722f26224c..f4a0f343f995 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1530,6 +1530,7 @@ static __always_inline void __folio_remove_rmap(struct folio *folio,
 	atomic_t *mapped = &folio->_nr_pages_mapped;
 	int last, nr = 0, nr_pmdmapped = 0;
 	bool partially_mapped = false;
+	bool last_unmapped = false;
 
 	__folio_rmap_sanity_checks(folio, page, nr_pages, level);
 
@@ -1545,6 +1546,8 @@ static __always_inline void __folio_remove_rmap(struct folio *folio,
 			last = atomic_add_negative(-1, &page->_mapcount);
 			if (last) {
 				last = atomic_dec_return_relaxed(mapped);
+				if (!last)
+					last_unmapped = true;
 				if (last < ENTIRELY_MAPPED)
 					nr++;
 			}
@@ -1557,6 +1560,8 @@ static __always_inline void __folio_remove_rmap(struct folio *folio,
 		last = atomic_add_negative(-1, &folio->_entire_mapcount);
 		if (last) {
 			nr = atomic_sub_return_relaxed(ENTIRELY_MAPPED, mapped);
+			if (nr == 0)
+				last_unmapped = true;
 			if (likely(nr < ENTIRELY_MAPPED)) {
 				nr_pmdmapped = folio_nr_pages(folio);
 				nr = nr_pmdmapped - (nr & FOLIO_PAGES_MAPPED);
@@ -1583,7 +1588,7 @@ static __always_inline void __folio_remove_rmap(struct folio *folio,
 	    list_empty(&folio->_deferred_list))
 		deferred_split_folio(folio);
 	__folio_mod_stat(folio, -nr, -nr_pmdmapped);
-	if (folio_test_anon(folio) && !atomic_read(mapped))
+	if (folio_test_anon(folio) && last_unmapped)
 		mod_mthp_stat(folio_order(folio), MTHP_STAT_NR_ANON, -1);
 
 	/*
 
> +               mod_mthp_stat(folio_order(folio), MTHP_STAT_NR_ANON, -1);
>
>         /*
>          * It would be tidy to reset folio_test_anon mapping when fully
> --
> 2.34.1
>

