Return-Path: <linux-kernel+bounces-400583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B7DA9C0F96
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 21:19:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D43C21F23D16
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 20:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC409217465;
	Thu,  7 Nov 2024 20:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dbI42bwn"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794B4188CC6
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 20:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731010742; cv=none; b=nMiDQLBFMxD23seck+RG5Avnrrep4VPMkVRil6uKbhin3l+4mqSxfLW8ac7utCFV/3qSjUuqdVo9HxHUApLTnov0cZN0UHdrjPcSYllFAsgpmNPXydHxj6IWCYl74bE/Klbl1Vy4oD0XSijRUxMukPXw+znCpFEPi69O+/gQPng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731010742; c=relaxed/simple;
	bh=9gPzSR0UhgOjG8ntDxRVrI69CdMKbFwW9gJok9kLUNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i6LaJ1/P+RubJmfYSWvAoXU4Q+aI3lD8cpJtF0+OmcnP48WvAqN+qscmJTgTl9zl22k5AnSBE8QkcXBQrRytm1DtvV3dXUxzlsL6HaW1zf+lxccMWdL+n6OFycrrNIePIMLneoRGvAQh0wOIOCRFSm/duSrnLq3km4JEBKAD/0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dbI42bwn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731010738;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DH+MZbGllo2Z/LKXzkjk2+K2q8W6yDeuyVqTLfkdLSU=;
	b=dbI42bwnftSihSUxhnwJeqtNEcXLG6GjZ5x0dPc9AGNb+cSgVJo/rKKvhoWXxMKxLqlPB3
	PDJ6LJlRvv8ZTpB9uZyLWCLuZClvHAR+lybof5NlpTAkPDBkAodItNIV3hPb4GRn2eKd6R
	FcIvx0DhcczEQS+jZsWMes0uRzg36Cs=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-352-Mw-8cVUtM2mw5Oa1fyuuLA-1; Thu, 07 Nov 2024 15:18:56 -0500
X-MC-Unique: Mw-8cVUtM2mw5Oa1fyuuLA-1
X-Mimecast-MFC-AGG-ID: Mw-8cVUtM2mw5Oa1fyuuLA
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-7181ca4eca5so1396605a34.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 12:18:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731010736; x=1731615536;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DH+MZbGllo2Z/LKXzkjk2+K2q8W6yDeuyVqTLfkdLSU=;
        b=xO/D1CIw9XOHQk6ZC/xWQCc8SNjdbF/o0w1F6q/w6I2yqlwY+Nk0DsSq44z10xSMwz
         c8sAL3YTst1+UIpsO5vo+vN5sEngoIYdiDR04Odmolp/bnTpNLcYwx3/eqMswaRqTRx4
         AEZu/nYN91wRyTZaKPz7I8hMh7UcRuCfBBe6kiFKv3Xrqg0xQ8G24MeDJZ6VHlApl4Q+
         5Mmisa04FelCWPVzKghjMB/rhCBPJ7YlhBvxU3xznOPu4CpPx9nMv133BWkB+dWFC+S4
         67uwc3y2wdek7Y7dcNQL9oI8X+zBSGedgKhXFlPcFLtD+HRX1TAEZqYr1frdKzdEz+S5
         uMhg==
X-Gm-Message-State: AOJu0Yz7VTx88jI6g843UOGo5WsnxB/SjB+mPAzNQsRzmBoejiJq+whd
	PrtlMLx7OL5iwkTyUwf8i+2HWMfbuf3I3QAhj2KfjvqFNXfMcQ+GpQBN3qV61jXU7beItxzLPha
	mUOI+rcOiTIf+QQvG+YLS6XREt0kDcpFpZ82niTqGaz14csWR2u/+rw45WClGhg==
X-Received: by 2002:a05:6830:4901:b0:718:1090:3d10 with SMTP id 46e09a7af769-71a1c26b815mr384732a34.26.1731010736032;
        Thu, 07 Nov 2024 12:18:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFwCHKP9eJDHkTkRNdJvbMHj2ouDzJkHvi1omVCRtbP3+U4VtXnQQh8zIvMo/9t0yF/hTfmNw==
X-Received: by 2002:a05:6830:4901:b0:718:1090:3d10 with SMTP id 46e09a7af769-71a1c26b815mr384707a34.26.1731010735689;
        Thu, 07 Nov 2024 12:18:55 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com. [99.254.114.190])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71a108e344asm429889a34.48.2024.11.07.12.18.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 12:18:55 -0800 (PST)
Date: Thu, 7 Nov 2024 15:18:51 -0500
From: Peter Xu <peterx@redhat.com>
To: riel@surriel.com
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, linux-mm@kvack.org,
	akpm@linux-foundation.org, muchun.song@linux.dev,
	mike.kravetz@oracle.com, leit@meta.com, willy@infradead.org,
	stable@kernel.org, Ackerley Tng <ackerleytng@google.com>,
	Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH 2/4] hugetlbfs: extend hugetlb_vma_lock to private VMAs
Message-ID: <Zy0gqwIw5Y3IuNTD@x1n>
References: <20231006040020.3677377-1-riel@surriel.com>
 <20231006040020.3677377-3-riel@surriel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231006040020.3677377-3-riel@surriel.com>

On Thu, Oct 05, 2023 at 11:59:07PM -0400, riel@surriel.com wrote:
> From: Rik van Riel <riel@surriel.com>
> 
> Extend the locking scheme used to protect shared hugetlb mappings
> from truncate vs page fault races, in order to protect private
> hugetlb mappings (with resv_map) against MADV_DONTNEED.
> 
> Add a read-write semaphore to the resv_map data structure, and
> use that from the hugetlb_vma_(un)lock_* functions, in preparation
> for closing the race between MADV_DONTNEED and page faults.
> 
> Signed-off-by: Rik van Riel <riel@surriel.com>
> Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
> Cc: stable@kernel.org
> Fixes: 04ada095dcfc ("hugetlb: don't delete vma_lock in hugetlb MADV_DONTNEED processing")
> ---
>  include/linux/hugetlb.h |  6 ++++++
>  mm/hugetlb.c            | 41 +++++++++++++++++++++++++++++++++++++----
>  2 files changed, 43 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index 5b2626063f4f..694928fa06a3 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -60,6 +60,7 @@ struct resv_map {
>  	long adds_in_progress;
>  	struct list_head region_cache;
>  	long region_cache_count;
> +	struct rw_semaphore rw_sema;
>  #ifdef CONFIG_CGROUP_HUGETLB
>  	/*
>  	 * On private mappings, the counter to uncharge reservations is stored
> @@ -1231,6 +1232,11 @@ static inline bool __vma_shareable_lock(struct vm_area_struct *vma)
>  	return (vma->vm_flags & VM_MAYSHARE) && vma->vm_private_data;
>  }
>  
> +static inline bool __vma_private_lock(struct vm_area_struct *vma)
> +{
> +	return (!(vma->vm_flags & VM_MAYSHARE)) && vma->vm_private_data;
> +}
> +
>  /*
>   * Safe version of huge_pte_offset() to check the locks.  See comments
>   * above huge_pte_offset().
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index a86e070d735b..dd3de6ec8f1a 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -97,6 +97,7 @@ static void hugetlb_vma_lock_alloc(struct vm_area_struct *vma);
>  static void __hugetlb_vma_unlock_write_free(struct vm_area_struct *vma);
>  static void hugetlb_unshare_pmds(struct vm_area_struct *vma,
>  		unsigned long start, unsigned long end);
> +static struct resv_map *vma_resv_map(struct vm_area_struct *vma);
>  
>  static inline bool subpool_is_free(struct hugepage_subpool *spool)
>  {
> @@ -267,6 +268,10 @@ void hugetlb_vma_lock_read(struct vm_area_struct *vma)
>  		struct hugetlb_vma_lock *vma_lock = vma->vm_private_data;
>  
>  		down_read(&vma_lock->rw_sema);
> +	} else if (__vma_private_lock(vma)) {
> +		struct resv_map *resv_map = vma_resv_map(vma);
> +
> +		down_read(&resv_map->rw_sema);
>  	}
>  }

+Ackerley +Oscar

I'm reading the resv code recently and just stumbled upon this. So want to
raise this question.

IIUC __vma_private_lock() will return false for MAP_PRIVATE hugetlb vma if
the vma is dup()ed from a fork(), with/without commit 187da0f8250a
("hugetlb: fix null-ptr-deref in hugetlb_vma_lock_write") which fixed a
slightly different issue.

The problem is the current vma lock for private mmap() is based on the resv
map, and the resv map only belongs to the process that mmap()ed this
private vma.  E.g. dup_mmap() has:

                if (is_vm_hugetlb_page(tmp))
                        hugetlb_dup_vma_private(tmp);

Which does:

	if (vma->vm_flags & VM_MAYSHARE) {
                ...
	} else
		vma->vm_private_data = NULL; <---------------------

So even if I don't know how many of us are even using hugetlb PRIVATE +
fork(), assuming that's the most controversial use case that I'm aware of
on hugetlb that people complains about.. with some tricky changes like
04f2cbe35699.. Just still want to raise this pure question, that after a
fork() on private vma, and if I read it alright, lock/unlock operations may
become noop..

Thanks,

>  
> @@ -276,6 +281,10 @@ void hugetlb_vma_unlock_read(struct vm_area_struct *vma)
>  		struct hugetlb_vma_lock *vma_lock = vma->vm_private_data;
>  
>  		up_read(&vma_lock->rw_sema);
> +	} else if (__vma_private_lock(vma)) {
> +		struct resv_map *resv_map = vma_resv_map(vma);
> +
> +		up_read(&resv_map->rw_sema);
>  	}
>  }
>  
> @@ -285,6 +294,10 @@ void hugetlb_vma_lock_write(struct vm_area_struct *vma)
>  		struct hugetlb_vma_lock *vma_lock = vma->vm_private_data;
>  
>  		down_write(&vma_lock->rw_sema);
> +	} else if (__vma_private_lock(vma)) {
> +		struct resv_map *resv_map = vma_resv_map(vma);
> +
> +		down_write(&resv_map->rw_sema);
>  	}
>  }
>  
> @@ -294,17 +307,27 @@ void hugetlb_vma_unlock_write(struct vm_area_struct *vma)
>  		struct hugetlb_vma_lock *vma_lock = vma->vm_private_data;
>  
>  		up_write(&vma_lock->rw_sema);
> +	} else if (__vma_private_lock(vma)) {
> +		struct resv_map *resv_map = vma_resv_map(vma);
> +
> +		up_write(&resv_map->rw_sema);
>  	}
>  }
>  
>  int hugetlb_vma_trylock_write(struct vm_area_struct *vma)
>  {
> -	struct hugetlb_vma_lock *vma_lock = vma->vm_private_data;
>  
> -	if (!__vma_shareable_lock(vma))
> -		return 1;
> +	if (__vma_shareable_lock(vma)) {
> +		struct hugetlb_vma_lock *vma_lock = vma->vm_private_data;
>  
> -	return down_write_trylock(&vma_lock->rw_sema);
> +		return down_write_trylock(&vma_lock->rw_sema);
> +	} else if (__vma_private_lock(vma)) {
> +		struct resv_map *resv_map = vma_resv_map(vma);
> +
> +		return down_write_trylock(&resv_map->rw_sema);
> +	}
> +
> +	return 1;
>  }
>  
>  void hugetlb_vma_assert_locked(struct vm_area_struct *vma)
> @@ -313,6 +336,10 @@ void hugetlb_vma_assert_locked(struct vm_area_struct *vma)
>  		struct hugetlb_vma_lock *vma_lock = vma->vm_private_data;
>  
>  		lockdep_assert_held(&vma_lock->rw_sema);
> +	} else if (__vma_private_lock(vma)) {
> +		struct resv_map *resv_map = vma_resv_map(vma);
> +
> +		lockdep_assert_held(&resv_map->rw_sema);
>  	}
>  }
>  
> @@ -345,6 +372,11 @@ static void __hugetlb_vma_unlock_write_free(struct vm_area_struct *vma)
>  		struct hugetlb_vma_lock *vma_lock = vma->vm_private_data;
>  
>  		__hugetlb_vma_unlock_write_put(vma_lock);
> +	} else if (__vma_private_lock(vma)) {
> +		struct resv_map *resv_map = vma_resv_map(vma);
> +
> +		/* no free for anon vmas, but still need to unlock */
> +		up_write(&resv_map->rw_sema);
>  	}
>  }
>  
> @@ -1068,6 +1100,7 @@ struct resv_map *resv_map_alloc(void)
>  	kref_init(&resv_map->refs);
>  	spin_lock_init(&resv_map->lock);
>  	INIT_LIST_HEAD(&resv_map->regions);
> +	init_rwsem(&resv_map->rw_sema);
>  
>  	resv_map->adds_in_progress = 0;
>  	/*
> -- 
> 2.41.0
> 
> 

-- 
Peter Xu


