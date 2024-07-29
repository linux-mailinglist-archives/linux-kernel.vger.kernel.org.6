Return-Path: <linux-kernel+bounces-264955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8305093EA8F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 03:37:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93585281471
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 01:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D5CC2AEE4;
	Mon, 29 Jul 2024 01:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c+zygdE+"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1CA257B
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 01:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722217061; cv=none; b=qWzfZ5LgpGQLCR6GTGgOoa/61s4Ionq/Yhit6L1fklyNBOn67SQaWf0PDRIbmOpY8B7GZgFL/4UYxpaLqS5fyo2eH1ksm25etLBpD7cPwFLckfqoOEqhZ4vPOoabxxxCCmg83is881SAnaDHsKiBeNkpeCwiy/nRU+hbXMpYztc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722217061; c=relaxed/simple;
	bh=FoEvWRWRIq3LZM8FagKdWnsauuDyIuWJChBOgCYgjYU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nkdrZtZq25Oo1bjbBCLUzVN+V9yiCSaOMqx1P/VcK34F9rAjerMU/KTP6ggXe79jDeE2RJX63XDuz+hhh9ZM8uJe5MjzH4eqnpK44TGVYUrnvbNOUrj65xvN+NmMWBoLGS2Vu4meZN/kjke6c0Of+/1TaeqqQDc3EDR1tcSkM4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c+zygdE+; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1fc4fccdd78so13988295ad.2
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2024 18:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722217059; x=1722821859; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=laihnHn0tEWhiMwgpFPbHKhBIJSPYc/4lHmU8vF732k=;
        b=c+zygdE+AjF78IAuvRBEgACEZCeh1rEThHBK4fdvYOsTBKoSvluP0dcYqx5BFJTF8/
         0GfV0/1oYU7CmNFHLqrEfa32QhVRAzSdTlbkeCgVcGejVrl7qEjqGncY/6+QqRQSUX5b
         VdznKf2lOGh/x+jp2Sd3UQpor0k5JIsiktvpFTbMdOpzmE64fiw+x+I02XtF8p7IqJb6
         Ed6Xnfie6UB8txG7OQXbsCBPwg8+I1wzFiR279qVOuOcgW9uzARZrGN0VxLyXd92Xgq9
         qCVrefY198rRzBD+uYyWigfgZC80UeU2qXYyUlfu0Xf5qTGkjP6H8sXkpdg8KknmA1Ro
         X2Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722217059; x=1722821859;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=laihnHn0tEWhiMwgpFPbHKhBIJSPYc/4lHmU8vF732k=;
        b=SfMZ7a9jZ4uuCjNVVvLfHOtiS3f8wFsVot2Q5pP8voERzEmB9OMDEbiDTCtod1vMie
         CWHaJoo8JFof4XyknKVTQ6UWs8pMHihN9jJCK4FaLFI4XydKpnHfGd2iDM14zQHz+S3N
         /Cv372LsDJuSAWAaWdjLj2wrtrgtff5DzhElimcFn87koLfmGqYicfD/vHcikwhKz0U0
         8f9hoNQI14+Osn7BvEkSz4KCefvAvFzF0OheqQJoVhzRnQWNCmAiCR4kJTMH7e9zsa75
         ERhLMbqN9LBOFMZPUwsFyu9CVgQUfsBr5YQUHn0oZxg42osZLy2UPfjh5yl3LHxTL/1B
         aDOg==
X-Forwarded-Encrypted: i=1; AJvYcCVWJ2YaTQvh4uiuAfn75pickePJk/ex6758bT4JnJ6e+crxuAbihzpCUb2/UB4+H6DEoPMEp49FP7tg6V0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmbZeDXcAGTmQE8eaOEgK6xRBompfRKgtbEGHk8hS/Z506Z3kw
	N7/y3d7PnUoZCP1M8SZVg9MFO32iP1Pn/n1nuZYdzrBMLe4NYKs5
X-Google-Smtp-Source: AGHT+IFQdjRDbsHHZ4F9XyP8gJxPgF26gezLPByuD4QowAXZQtzR3gQYVihGWbncvmz8YnJvRgq63Q==
X-Received: by 2002:a17:902:c994:b0:1fc:4bdc:d413 with SMTP id d9443c01a7336-1ff0493be42mr35839175ad.60.1722217059162;
        Sun, 28 Jul 2024 18:37:39 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7ee6a1esm70873795ad.164.2024.07.28.18.37.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jul 2024 18:37:38 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: lkp@intel.com
Cc: 21cnbao@gmail.com,
	akpm@linux-foundation.org,
	baolin.wang@linux.alibaba.com,
	chrisl@kernel.org,
	david@redhat.com,
	hannes@cmpxchg.org,
	hughd@google.com,
	kaleshsingh@google.com,
	kasong@tencent.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	mhocko@suse.com,
	minchan@kernel.org,
	nphamcs@gmail.com,
	oe-kbuild-all@lists.linux.dev,
	ryan.roberts@arm.com,
	senozhatsky@chromium.org,
	shakeel.butt@linux.dev,
	shy828301@gmail.com,
	surenb@google.com,
	v-songbaohua@oppo.com,
	willy@infradead.org,
	xiang@kernel.org,
	ying.huang@intel.com,
	yosryahmed@google.com
Subject: Re: [PATCH v5 4/4] mm: Introduce per-thpsize swapin control policy
Date: Mon, 29 Jul 2024 13:37:18 +1200
Message-Id: <20240729013718.13901-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <202407271351.ffZPMT6W-lkp@intel.com>
References: <202407271351.ffZPMT6W-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On Sat, Jul 27, 2024 at 5:58 PM kernel test robot <lkp@intel.com> wrote:
>
> Hi Barry,
>
> kernel test robot noticed the following build warnings:
>
> [auto build test WARNING on akpm-mm/mm-everything]

Hi Thanks!
Would you check if the below patch fixes the problem?

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 41460847988c..06984a325af7 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -80,7 +80,7 @@ unsigned long huge_zero_pfn __read_mostly = ~0UL;
 unsigned long huge_anon_orders_always __read_mostly;
 unsigned long huge_anon_orders_madvise __read_mostly;
 unsigned long huge_anon_orders_inherit __read_mostly;
-unsigned long huge_anon_orders_swapin_always __read_mostly;
+static unsigned long huge_anon_orders_swapin_always __read_mostly;
 
 unsigned long __thp_vma_allowable_orders(struct vm_area_struct *vma,
 					 unsigned long vm_flags,
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Barry-Song/mm-swap-introduce-swapcache_prepare_nr-and-swapcache_clear_nr-for-large-folios-swap-in/20240726-181412
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
> patch link:    https://lore.kernel.org/r/20240726094618.401593-5-21cnbao%40gmail.com
> patch subject: [PATCH v5 4/4] mm: Introduce per-thpsize swapin control policy
> config: x86_64-randconfig-121-20240727 (https://download.01.org/0day-ci/archive/20240727/202407271351.ffZPMT6W-lkp@intel.com/config)
> compiler: gcc-11 (Ubuntu 11.4.0-4ubuntu1) 11.4.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240727/202407271351.ffZPMT6W-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202407271351.ffZPMT6W-lkp@intel.com/
>
> sparse warnings: (new ones prefixed by >>)
> >> mm/huge_memory.c:83:15: sparse: sparse: symbol 'huge_anon_orders_swapin_always' was not declared. Should it be static?
>    mm/huge_memory.c: note: in included file (through include/linux/smp.h, include/linux/lockdep.h, include/linux/spinlock.h, ...):
>    include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
>    mm/huge_memory.c: note: in included file (through include/linux/mmzone.h, include/linux/gfp.h, include/linux/mm.h):
>    include/linux/page-flags.h:235:46: sparse: sparse: self-comparison always evaluates to false
>    include/linux/page-flags.h:235:46: sparse: sparse: self-comparison always evaluates to false
>    mm/huge_memory.c:1867:20: sparse: sparse: context imbalance in 'madvise_free_huge_pmd' - unexpected unlock
>    include/linux/page-flags.h:235:46: sparse: sparse: self-comparison always evaluates to false
>    mm/huge_memory.c:1905:28: sparse: sparse: context imbalance in 'zap_huge_pmd' - unexpected unlock
>    mm/huge_memory.c:2016:28: sparse: sparse: context imbalance in 'move_huge_pmd' - unexpected unlock
>    mm/huge_memory.c:2156:20: sparse: sparse: context imbalance in 'change_huge_pmd' - unexpected unlock
>    mm/huge_memory.c:2306:12: sparse: sparse: context imbalance in '__pmd_trans_huge_lock' - wrong count at exit
>    mm/huge_memory.c:2323:12: sparse: sparse: context imbalance in '__pud_trans_huge_lock' - wrong count at exit
>    mm/huge_memory.c:2347:28: sparse: sparse: context imbalance in 'zap_huge_pud' - unexpected unlock
>    mm/huge_memory.c:2426:18: sparse: sparse: context imbalance in '__split_huge_zero_page_pmd' - unexpected unlock
>    mm/huge_memory.c:2640:18: sparse: sparse: context imbalance in '__split_huge_pmd_locked' - unexpected unlock
>    include/linux/page-flags.h:235:46: sparse: sparse: self-comparison always evaluates to false
>    mm/huge_memory.c: note: in included file (through include/linux/smp.h, include/linux/lockdep.h, include/linux/spinlock.h, ...):
>    include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
>    include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
>    mm/huge_memory.c: note: in included file (through include/linux/mmzone.h, include/linux/gfp.h, include/linux/mm.h):
>    include/linux/page-flags.h:235:46: sparse: sparse: self-comparison always evaluates to false
>    mm/huge_memory.c:3031:30: sparse: sparse: context imbalance in '__split_huge_page' - unexpected unlock
>    mm/huge_memory.c:3306:17: sparse: sparse: context imbalance in 'split_huge_page_to_list_to_order' - different lock contexts for basic block
>    mm/huge_memory.c: note: in included file (through include/linux/smp.h, include/linux/lockdep.h, include/linux/spinlock.h, ...):
>    include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
>    mm/huge_memory.c: note: in included file (through include/linux/mmzone.h, include/linux/gfp.h, include/linux/mm.h):
>    include/linux/page-flags.h:235:46: sparse: sparse: self-comparison always evaluates to false
>    mm/huge_memory.c: note: in included file (through include/linux/smp.h, include/linux/lockdep.h, include/linux/spinlock.h, ...):
>    include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
>    mm/huge_memory.c: note: in included file (through include/linux/mmzone.h, include/linux/gfp.h, include/linux/mm.h):
>    include/linux/page-flags.h:235:46: sparse: sparse: self-comparison always evaluates to false
>    include/linux/page-flags.h:235:46: sparse: sparse: self-comparison always evaluates to false
>
> vim +/huge_anon_orders_swapin_always +83 mm/huge_memory.c
>
>     51 
>     52  /*
>     53   * By default, transparent hugepage support is disabled in order to avoid
>     54   * risking an increased memory footprint for applications that are not
>     55   * guaranteed to benefit from it. When transparent hugepage support is
>     56   * enabled, it is for all mappings, and khugepaged scans all mappings.
>     57   * Defrag is invoked by khugepaged hugepage allocations and by page faults
>     58   * for all hugepage allocations.
>     59   */
>     60  unsigned long transparent_hugepage_flags __read_mostly =
>     61  #ifdef CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS
>     62          (1<<TRANSPARENT_HUGEPAGE_FLAG)|
>     63  #endif
>     64  #ifdef CONFIG_TRANSPARENT_HUGEPAGE_MADVISE
>     65          (1<<TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG)|
>     66  #endif
>     67          (1<<TRANSPARENT_HUGEPAGE_DEFRAG_REQ_MADV_FLAG)|
>     68          (1<<TRANSPARENT_HUGEPAGE_DEFRAG_KHUGEPAGED_FLAG)|
>     69          (1<<TRANSPARENT_HUGEPAGE_USE_ZERO_PAGE_FLAG);
>     70 
>     71  static struct shrinker *deferred_split_shrinker;
>     72  static unsigned long deferred_split_count(struct shrinker *shrink,
>     73                                            struct shrink_control *sc);
>     74  static unsigned long deferred_split_scan(struct shrinker *shrink,
>     75                                           struct shrink_control *sc);
>     76 
>     77  static atomic_t huge_zero_refcount;
>     78  struct folio *huge_zero_folio __read_mostly;
>     79  unsigned long huge_zero_pfn __read_mostly = ~0UL;
>     80  unsigned long huge_anon_orders_always __read_mostly;
>     81  unsigned long huge_anon_orders_madvise __read_mostly;
>     82  unsigned long huge_anon_orders_inherit __read_mostly;
>   > 83  unsigned long huge_anon_orders_swapin_always __read_mostly;
>     84 
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

Thanks
Barry


