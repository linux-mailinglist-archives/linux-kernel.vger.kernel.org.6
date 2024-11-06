Return-Path: <linux-kernel+bounces-399019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17F089BF984
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 23:56:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C292E1F229C1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 22:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EA8920D4F0;
	Wed,  6 Nov 2024 22:56:33 +0000 (UTC)
Received: from mail115-80.sinamail.sina.com.cn (mail115-80.sinamail.sina.com.cn [218.30.115.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0680C2EAE0
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 22:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730933793; cv=none; b=bBa27qaPoLog7JOcG1xTx7isnNaB1AqzjuKSXCvQdMbqPhPT1Cm76Eu7k6E0ehMnljgTlYcUXp5I0CHeits1iUl2v1KMjsRmU4yJ33nAGbvNXcSVR+rA3obZpEAE0bCV+JrYhvPAjM876lRfrCyIRr73mVFvMJwqhtCqjAky15M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730933793; c=relaxed/simple;
	bh=exLIv4/IYoR/wgWYSzmBKxxs96NMcM0mJG4FkWFl1qs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dSFxTcaV2lM9WDNzpWL0R9b23ruowwwa5IHZFhjLufvGuS3UhodASRmwLtHIw9l1k0N7tORTxh1dgfMJh3nKrdJijoRPmVoyGtSY7ShEWwWCHNpC4sDvne8KjDaKXn4FciLmEwoqCJjkp/jHwb5iadeC3ly4xBqc/dhipjAhrLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.67.144])
	by sina.com (10.185.250.23) with ESMTP
	id 672BF3EE00007FA6; Wed, 7 Nov 2024 06:55:47 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 3774038913343
X-SMAIL-UIID: E4B312D3770147929370392E8E322C56-20241107-065547-1
From: Hillf Danton <hdanton@sina.com>
To: Carlos Llamas <cmllamas@google.com>
Cc: linux-kernel@vger.kernel.org,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH 8/8] binder: use per-vma lock in page installation
Date: Thu,  7 Nov 2024 06:55:34 +0800
Message-Id: <20241106225534.3388-1-hdanton@sina.com>
In-Reply-To: <20241105200258.2380168-9-cmllamas@google.com>
References: <20241105200258.2380168-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue,  5 Nov 2024 20:02:50 +0000 Carlos Llamas <cmllamas@google.com>
> Use per-vma locking for concurrent page installations, this minimizes
> contention with unrelated vmas improving performance. The mmap_lock is
> still acquired when needed though, e.g. before folio_walk_start().
> 
Is the locking order correct in this patch?

	lock vma
	lock vma->vm_mm

> Many thanks to Barry Song who posted a similar approach [1].
> 
> Link: https://lore.kernel.org/all/20240902225009.34576-1-21cnbao@gmail.com/ [1]
> Cc: Nhat Pham <nphamcs@gmail.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Barry Song <v-songbaohua@oppo.com>
> Cc: Suren Baghdasaryan <surenb@google.com>
> Signed-off-by: Carlos Llamas <cmllamas@google.com>
> ---
>  drivers/android/binder_alloc.c | 70 +++++++++++++++++++++++++++++-----
>  1 file changed, 60 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
> index d505ffddb6db..47cf1c354e6f 100644
> --- a/drivers/android/binder_alloc.c
> +++ b/drivers/android/binder_alloc.c
> @@ -234,13 +234,63 @@ static inline bool binder_alloc_is_mapped(struct binder_alloc *alloc)
>  	return smp_load_acquire(&alloc->mapped);
>  }
>  
> +static struct vm_area_struct *binder_find_lock_vma(struct binder_alloc *alloc,
> +						   unsigned long addr,
> +						   bool *mm_locked)
> +{
> +	struct mm_struct *mm = alloc->mm;
> +	struct vm_area_struct *vma;
> +
> +	/* attempt per-vma lock first */
> +	vma = lock_vma_under_rcu(mm, addr);
> +	if (vma) {
> +		*mm_locked = false;
> +		return vma;
> +	}
> +
> +	/* fallback to mmap_lock */
> +	mmap_read_lock(mm);
> +	vma = vma_lookup(mm, addr);
> +	if (!vma || !binder_alloc_is_mapped(alloc)) {
> +		mmap_read_unlock(mm);
> +		return NULL;
> +	}
> +	*mm_locked = true;
> +
> +	return vma;
> +}
> +
> +static struct page *binder_page_lookup(struct mm_struct *mm,
> +				       struct vm_area_struct *vma,
> +				       unsigned long addr,
> +				       bool mm_locked)
> +{
> +	struct folio_walk fw;
> +	struct page *page;
> +
> +	/* folio_walk_start() requires the mmap_lock */
> +	if (!mm_locked)
> +		mmap_read_lock(mm);
> +
> +	if (!folio_walk_start(&fw, vma, addr, 0))
> +		return NULL;
> +
> +	page = fw.page;
> +	folio_walk_end(&fw, vma);
> +
> +	if (!mm_locked)
> +		mmap_read_unlock(mm);
> +
> +	return page;
> +}
> +
>  static int binder_install_single_page(struct binder_alloc *alloc,
>  				      unsigned long index,
>  				      unsigned long addr)
>  {
>  	struct vm_area_struct *vma;
> -	struct folio_walk fw;
>  	struct page *page;
> +	bool mm_locked;
>  	int ret = 0;
>  
>  	if (!mmget_not_zero(alloc->mm))
> @@ -257,12 +307,11 @@ static int binder_install_single_page(struct binder_alloc *alloc,
>  	INIT_LIST_HEAD(&page->lru);
>  	page->index = index;
>  
> -	mmap_read_lock(alloc->mm);
> -	vma = vma_lookup(alloc->mm, addr);
> -	if (!vma || !binder_alloc_is_mapped(alloc)) {
> +	vma = binder_find_lock_vma(alloc, addr, &mm_locked);
> +	if (!vma) {
>  		pr_err("%d: %s failed, no vma\n", alloc->pid, __func__);
>  		ret = -ESRCH;
> -		goto unlock;
> +		goto out;
>  	}
>  
>  	ret = vm_insert_page(vma, addr, page);
> @@ -275,14 +324,13 @@ static int binder_install_single_page(struct binder_alloc *alloc,
>  		 */
>  		ret = 0;
>  		__free_page(page);
> -		if (!folio_walk_start(&fw, vma, addr, 0)) {
> +		page = binder_page_lookup(alloc->mm, vma, addr, mm_locked);
> +		if (!page) {
>  			pr_err("%d: failed to find page at offset %lx\n",
>  			       alloc->pid, addr - alloc->vm_start);
>  			ret = -ESRCH;
>  			break;
>  		}
> -		page = fw.page;
> -		folio_walk_end(&fw, vma);
>  		fallthrough;
>  	case 0:
>  		/* Mark page installation complete and safe to use */
> @@ -296,8 +344,10 @@ static int binder_install_single_page(struct binder_alloc *alloc,
>  		break;
>  	}
>  
> -unlock:
> -	mmap_read_unlock(alloc->mm);
> +	if (mm_locked)
> +		mmap_read_unlock(alloc->mm);
> +	else
> +		vma_end_read(vma);
>  	if (page)
>  		__free_page(page);
>  out:
> -- 
> 2.47.0.199.ga7371fff76-goog

