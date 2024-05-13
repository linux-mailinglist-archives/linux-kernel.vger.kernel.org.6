Return-Path: <linux-kernel+bounces-177182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 705A48C3B1F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 08:00:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B42B2815D9
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 06:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 584C414658F;
	Mon, 13 May 2024 06:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BicIse0b"
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2D44C81
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 06:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715580036; cv=none; b=ljeHP2z2oxC+ETkBERXEbEd2zXNVjWGSYDBYjr2PfcgO0nvuzdG9dsIoSCdHwZz9kv6xWvxehTM2HvjWIX+iZj5hsfqM2YcgMWsv7PNh8NbTYQKzZhw6C4zx9j5T0LzR+6HbMigplgWoBx0wGRSaju+iuSqiZvohR9iq7kAEqCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715580036; c=relaxed/simple;
	bh=U6jyMIMYyMvRLZrQ+/DKHJ/d/UnO6SKxH0N3kkgzAGA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ihw7Gp/P3GwdFxnDRyoA3rqc1Wj5DWry6C5CMiZxUYgMO204NV8YcqfsqR7SAc+761oaWBmJYQgaM+EIK+Vr/VNzpT7/ZCCpFgHgNBQ8Bf6FGg8ckR4ocK/jlkDe9lWYJd0dXRyy/vae2sKWXjDfXvj1uWgnfAtyoGqTaiJDHg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BicIse0b; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-6f447260f9dso3095655b3a.0
        for <linux-kernel@vger.kernel.org>; Sun, 12 May 2024 23:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715580034; x=1716184834; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A+UWE13EKJKc2jsx12DqNcqiTCBkf/xDYNgDW2I4NGM=;
        b=BicIse0bv15L/OaAXm0fyxAHUrl8BG+j1uUsoQ5zXzv5lui5wM/WndKgWuT6S8PY6T
         NbRYzXU3Np3BNvPy2pIb1aIxPVxKPzN+vlIVa9E76ikyH6o7IP+W23YxaA0FyRKU6fln
         5sRgQEAJ6gYsC/Zpv7RypZj3DFBTDTdbj2Lk/ywexLe20PNqS7vIWPYRHVJiqsNgV9NK
         THHZZDx/JCw2mbAEYhw+FzExraZP0U2qJaljV5jQiPzvNsIE1wjIUzGyjn+TkFAfzxAw
         s8SWrf/tVDoNLfNHW/U+kYpYlhlQlJ0ujd9gXaeKpV5JBSLOi+bDCJx5Bycw9jyqt6Nw
         Yr0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715580034; x=1716184834;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A+UWE13EKJKc2jsx12DqNcqiTCBkf/xDYNgDW2I4NGM=;
        b=EEksMoEBB4SW6PhrT7szzHEw+1EbcAWanKA9y89su08ZL3n5HJOfGgcT/YsS63qowA
         UYPXmTB3MghI1NdL1RUwZbMjUpfnBEKk+c+JCbx7ReDwhLwbfoqTBNiUELIZlSTv8BIs
         IoDpn+lagKHgSFd6K7zkWDv7tkL59l4Nfr/n1jf47CdvkEkFcvIt7rZR+aiWwrm1cqcB
         mr1EkrV0NcipB8reUsYvu8HYfV5uKziHgMA7Mi0Ygebo9D8NzKoC8p1MX0qHxqNptDmJ
         M3lK6jDojoBp1KQSuLvUWgxZ3TnxiSlbzRGEJm2ttm6Sq4BXZndXm71cc2oHfz3iEtlh
         fFUA==
X-Forwarded-Encrypted: i=1; AJvYcCUCSZXw41F7eAb3OOfWr2jNDIXp2ros3l8W6wBr/KF/GY+KEiIMV+9wPO8UCY4GZdD0DAkIGOa9km+pjEhDqCYs3mbHwy+BsS24pr1g
X-Gm-Message-State: AOJu0Yyn9Y1f/6TcjtMs0wg9e6CBmlah6jKX+MQfUaKCzFDiFRZbp8t/
	PABPAuOie2eB+JpI0h65Tt+H6USANwhFFoGmmeX1sYCG4hv/5rAn
X-Google-Smtp-Source: AGHT+IFgXfG6zZft0seFQcj/0hGAntlM5b4QIRh98rM7ciwNpamlMxzfQnNQCIrlaVzeReaaX3tY9A==
X-Received: by 2002:a05:6a20:12d4:b0:1a5:6a85:8ce9 with SMTP id adf61e73a8af0-1afde0a8da9mr9520068637.12.1715580034317;
        Sun, 12 May 2024 23:00:34 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2b67105649fsm7106812a91.6.2024.05.12.23.00.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 May 2024 23:00:33 -0700 (PDT)
From: xu xin <xu.xin.sc@gmail.com>
X-Google-Original-From: xu xin <xu.xin16@zte.com.cn>
To: chengming.zhou@linux.dev
Cc: aarcange@redhat.com,
	akpm@linux-foundation.org,
	david@redhat.com,
	hughd@google.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	shr@devkernel.io,
	xu.xin16@zte.com.cn,
	zhouchengming@bytedance.com,
	si.hao@zte.com.cn
Subject: Re: [PATCH v2 2/2] mm/ksm: fix ksm_zero_pages accounting
Date: Mon, 13 May 2024 06:00:29 +0000
Message-Id: <20240513060029.651050-1-xu.xin16@zte.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240513-b4-ksm-counters-v2-2-f2520183a8ca@linux.dev>
References: <20240513-b4-ksm-counters-v2-2-f2520183a8ca@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> We normally ksm_zero_pages++ in ksmd when page is merged with zero page,
> but ksm_zero_pages-- is done from page tables side, which can't protected
> by the ksmd mutex.

  "cant protected" -> "can't be protected".

  But It's better to say  "where there is no any accessing protection of
  ksm_zero_pages" because ksmd mutex is to protect the flag of ksm_run, not to
  protect the counters of KSM.


  Anyway, The following code looks OK to me.
> 
> So we can read very exceptional value of ksm_zero_pages in rare cases,
> such as -1, which is very confusing to users.
> 
> Fix it by changing to use atomic_long_t, and the same case with the
> mm->ksm_zero_pages.
> 
> Fixes: e2942062e01d ("ksm: count all zero pages placed by KSM")
> Fixes: 6080d19f0704 ("ksm: add ksm zero pages for each process")
> Acked-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Chengming Zhou <chengming.zhou@linux.dev>
> ---
>  fs/proc/base.c           |  2 +-
>  include/linux/ksm.h      | 17 ++++++++++++++---
>  include/linux/mm_types.h |  2 +-
>  mm/ksm.c                 | 11 +++++------
>  4 files changed, 21 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index 18550c071d71..72a1acd03675 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -3214,7 +3214,7 @@ static int proc_pid_ksm_stat(struct seq_file *m, struct pid_namespace *ns,
>  	mm = get_task_mm(task);
>  	if (mm) {
>  		seq_printf(m, "ksm_rmap_items %lu\n", mm->ksm_rmap_items);
> -		seq_printf(m, "ksm_zero_pages %lu\n", mm->ksm_zero_pages);
> +		seq_printf(m, "ksm_zero_pages %ld\n", mm_ksm_zero_pages(mm));
>  		seq_printf(m, "ksm_merging_pages %lu\n", mm->ksm_merging_pages);
>  		seq_printf(m, "ksm_process_profit %ld\n", ksm_process_profit(mm));
>  		mmput(mm);
> diff --git a/include/linux/ksm.h b/include/linux/ksm.h
> index 52c63a9c5a9c..11690dacd986 100644
> --- a/include/linux/ksm.h
> +++ b/include/linux/ksm.h
> @@ -33,16 +33,27 @@ void __ksm_exit(struct mm_struct *mm);
>   */
>  #define is_ksm_zero_pte(pte)	(is_zero_pfn(pte_pfn(pte)) && pte_dirty(pte))
>  
> -extern unsigned long ksm_zero_pages;
> +extern atomic_long_t ksm_zero_pages;
> +
> +static inline void ksm_map_zero_page(struct mm_struct *mm)
> +{
> +	atomic_long_inc(&ksm_zero_pages);
> +	atomic_long_inc(&mm->ksm_zero_pages);
> +}
>  
>  static inline void ksm_might_unmap_zero_page(struct mm_struct *mm, pte_t pte)
>  {
>  	if (is_ksm_zero_pte(pte)) {
> -		ksm_zero_pages--;
> -		mm->ksm_zero_pages--;
> +		atomic_long_dec(&ksm_zero_pages);
> +		atomic_long_dec(&mm->ksm_zero_pages);
>  	}
>  }
>  
> +static inline long mm_ksm_zero_pages(struct mm_struct *mm)
> +{
> +	return atomic_long_read(&mm->ksm_zero_pages);
> +}
> +
>  static inline int ksm_fork(struct mm_struct *mm, struct mm_struct *oldmm)
>  {
>  	if (test_bit(MMF_VM_MERGEABLE, &oldmm->flags))
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 24323c7d0bd4..af3a0256fa93 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -985,7 +985,7 @@ struct mm_struct {
>  		 * Represent how many empty pages are merged with kernel zero
>  		 * pages when enabling KSM use_zero_pages.
>  		 */
> -		unsigned long ksm_zero_pages;
> +		atomic_long_t ksm_zero_pages;
>  #endif /* CONFIG_KSM */
>  #ifdef CONFIG_LRU_GEN_WALKS_MMU
>  		struct {
> diff --git a/mm/ksm.c b/mm/ksm.c
> index 0f9c491552ff..6f461411d070 100644
> --- a/mm/ksm.c
> +++ b/mm/ksm.c
> @@ -296,7 +296,7 @@ static bool ksm_use_zero_pages __read_mostly;
>  static bool ksm_smart_scan = true;
>  
>  /* The number of zero pages which is placed by KSM */
> -unsigned long ksm_zero_pages;
> +atomic_long_t ksm_zero_pages = ATOMIC_LONG_INIT(0);
>  
>  /* The number of pages that have been skipped due to "smart scanning" */
>  static unsigned long ksm_pages_skipped;
> @@ -1429,8 +1429,7 @@ static int replace_page(struct vm_area_struct *vma, struct page *page,
>  		 * the dirty bit in zero page's PTE is set.
>  		 */
>  		newpte = pte_mkdirty(pte_mkspecial(pfn_pte(page_to_pfn(kpage), vma->vm_page_prot)));
> -		ksm_zero_pages++;
> -		mm->ksm_zero_pages++;
> +		ksm_map_zero_page(mm);
>  		/*
>  		 * We're replacing an anonymous page with a zero page, which is
>  		 * not anonymous. We need to do proper accounting otherwise we
> @@ -3373,7 +3372,7 @@ static void wait_while_offlining(void)
>  #ifdef CONFIG_PROC_FS
>  long ksm_process_profit(struct mm_struct *mm)
>  {
> -	return (long)(mm->ksm_merging_pages + mm->ksm_zero_pages) * PAGE_SIZE -
> +	return (long)(mm->ksm_merging_pages + mm_ksm_zero_pages(mm)) * PAGE_SIZE -
>  		mm->ksm_rmap_items * sizeof(struct ksm_rmap_item);
>  }
>  #endif /* CONFIG_PROC_FS */
> @@ -3662,7 +3661,7 @@ KSM_ATTR_RO(pages_skipped);
>  static ssize_t ksm_zero_pages_show(struct kobject *kobj,
>  				struct kobj_attribute *attr, char *buf)
>  {
> -	return sysfs_emit(buf, "%ld\n", ksm_zero_pages);
> +	return sysfs_emit(buf, "%ld\n", atomic_long_read(&ksm_zero_pages));
>  }
>  KSM_ATTR_RO(ksm_zero_pages);
>  
> @@ -3671,7 +3670,7 @@ static ssize_t general_profit_show(struct kobject *kobj,
>  {
>  	long general_profit;
>  
> -	general_profit = (ksm_pages_sharing + ksm_zero_pages) * PAGE_SIZE -
> +	general_profit = (ksm_pages_sharing + atomic_long_read(&ksm_zero_pages)) * PAGE_SIZE -
>  				ksm_rmap_items * sizeof(struct ksm_rmap_item);
>  
>  	return sysfs_emit(buf, "%ld\n", general_profit);
> 
> -- 
> 2.45.0
> 

