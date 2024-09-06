Return-Path: <linux-kernel+bounces-318485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0886F96EE9C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 10:56:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2C711F254B2
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 08:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4493C4594A;
	Fri,  6 Sep 2024 08:56:02 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 156ED15854A
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 08:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725612961; cv=none; b=a0hRH71SKwzhGkUBzObcDMxrz9G7H9u50WlAnd9NFl0qlw0PPvm4on64BeGYQ2M6E16obuPPV4TF7h860wVMgMtVGP9gHRut6GkpWKYlfK4w3AIoCPUc81KzBxN4V2KjRiZwwP57H+XIinPLIqxeFNPBYJkW2PgxvMk4zog1XKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725612961; c=relaxed/simple;
	bh=s4cioB1fa282tQAZraWB/KTG/03vHRZ+A91xZ9wFedE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BsED77u2GoUaBGu//q/EFKOy8sgAqiL6ygH6T2vo0pNM65GYR2eX4wZXoGG7ArC4INzT9HR9VfUneB/lfEKDJZjcJvix3T436MGExb/IkQN8g9vrUa4biYYZEndCaqmuAshwgQu0A/lewyT3JctfNjuky3jnVhJK42WVvCciLxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 81B8EFEC;
	Fri,  6 Sep 2024 01:56:26 -0700 (PDT)
Received: from [10.57.86.132] (unknown [10.57.86.132])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5DC593F73F;
	Fri,  6 Sep 2024 01:55:58 -0700 (PDT)
Message-ID: <58cf63c1-25e5-4958-96cb-a9d65390ca3e@arm.com>
Date: Fri, 6 Sep 2024 09:55:57 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: shmem: fix khugepaged activation policy for shmem
Content-Language: en-GB
To: Baolin Wang <baolin.wang@linux.alibaba.com>, akpm@linux-foundation.org,
 hughd@google.com
Cc: willy@infradead.org, david@redhat.com, 21cnbao@gmail.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <7c796904528e21152ba5aa639e963e0ae45b7040.1725600217.git.baolin.wang@linux.alibaba.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <7c796904528e21152ba5aa639e963e0ae45b7040.1725600217.git.baolin.wang@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 06/09/2024 06:28, Baolin Wang wrote:
> Shmem has a separate interface (different from anonymous pages) to control
> huge page allocation, that means shmem THP can be enabled while anonymous
> THP is disabled. However, in this case, khugepaged will not start to collapse
> shmem THP, which is unreasonable.
> 
> To fix this issue, we should call start_stop_khugepaged() to activate or
> deactivate the khugepaged thread when setting shmem mTHP interfaces.
> Moreover, add a new helper shmem_hpage_pmd_enabled() to help to check
> whether shmem THP is enabled, which will determine if khugepaged should
> be activated.
> 
> Reported-by: Ryan Roberts <ryan.roberts@arm.com>
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
> Hi Ryan,
> 
> I remember we discussed the shmem khugepaged activation issue before, but
> I haven’t seen any follow-up patches to fix it. Recently, I am trying to
> fix the shmem mTHP collapse issue in the series [1], and I also addressed
> this activation issue. Please correct me if you have a better idea. Thanks.

Thanks for for sorting this - it looks like a good approach to me! Just a couple
of nits. Regardless:

Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>

> 
> [1] https://lore.kernel.org/all/cover.1724140601.git.baolin.wang@linux.alibaba.com/T/#u
> ---
>  include/linux/shmem_fs.h |  6 ++++++
>  mm/khugepaged.c          |  2 ++
>  mm/shmem.c               | 29 +++++++++++++++++++++++++++--
>  3 files changed, 35 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
> index 515a9a6a3c6f..ee6635052383 100644
> --- a/include/linux/shmem_fs.h
> +++ b/include/linux/shmem_fs.h
> @@ -114,6 +114,7 @@ int shmem_unuse(unsigned int type);
>  unsigned long shmem_allowable_huge_orders(struct inode *inode,
>  				struct vm_area_struct *vma, pgoff_t index,
>  				loff_t write_end, bool shmem_huge_force);
> +bool shmem_hpage_pmd_enabled(void);
>  #else
>  static inline unsigned long shmem_allowable_huge_orders(struct inode *inode,
>  				struct vm_area_struct *vma, pgoff_t index,
> @@ -121,6 +122,11 @@ static inline unsigned long shmem_allowable_huge_orders(struct inode *inode,
>  {
>  	return 0;
>  }
> +
> +static inline bool shmem_hpage_pmd_enabled(void)
> +{
> +	return false;
> +}
>  #endif
>  
>  #ifdef CONFIG_SHMEM
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index f9c39898eaff..caf10096d4d1 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -430,6 +430,8 @@ static bool hugepage_pmd_enabled(void)
>  	if (test_bit(PMD_ORDER, &huge_anon_orders_inherit) &&
>  	    hugepage_global_enabled())
>  		return true;
> +	if (shmem_hpage_pmd_enabled())
> +		return true;

nit: There is a comment at the top of this function, perhaps that could be
extended to cover shmem too?

>  	return false;
>  }
>  
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 74f093d88c78..d7c342ae2b37 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -1653,6 +1653,23 @@ static gfp_t limit_gfp_mask(gfp_t huge_gfp, gfp_t limit_gfp)
>  }
>  
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +bool shmem_hpage_pmd_enabled(void)
> +{
> +	if (shmem_huge == SHMEM_HUGE_DENY)
> +		return false;
> +	if (test_bit(HPAGE_PMD_ORDER, &huge_shmem_orders_always))

question: When is it correct to use HPAGE_PMD_ORDER vs PMD_ORDER? I tend to use
PMD_ORDER (in hugepage_pmd_enabled() for example).

> +		return true;
> +	if (test_bit(HPAGE_PMD_ORDER, &huge_shmem_orders_madvise))
> +		return true;
> +	if (test_bit(HPAGE_PMD_ORDER, &huge_shmem_orders_within_size))
> +		return true;
> +	if (test_bit(HPAGE_PMD_ORDER, &huge_shmem_orders_inherit) &&
> +	    shmem_huge != SHMEM_HUGE_NEVER)
> +		return true;
> +
> +	return false;
> +}
> +
>  unsigned long shmem_allowable_huge_orders(struct inode *inode,
>  				struct vm_area_struct *vma, pgoff_t index,
>  				loff_t write_end, bool shmem_huge_force)
> @@ -5036,7 +5053,7 @@ static ssize_t shmem_enabled_store(struct kobject *kobj,
>  		struct kobj_attribute *attr, const char *buf, size_t count)
>  {
>  	char tmp[16];
> -	int huge;
> +	int huge, err;
>  
>  	if (count + 1 > sizeof(tmp))
>  		return -EINVAL;
> @@ -5060,7 +5077,9 @@ static ssize_t shmem_enabled_store(struct kobject *kobj,
>  	shmem_huge = huge;
>  	if (shmem_huge > SHMEM_HUGE_DENY)
>  		SHMEM_SB(shm_mnt->mnt_sb)->huge = shmem_huge;
> -	return count;
> +
> +	err = start_stop_khugepaged();
> +	return err ? err : count;
>  }
>  
>  struct kobj_attribute shmem_enabled_attr = __ATTR_RW(shmem_enabled);
> @@ -5137,6 +5156,12 @@ static ssize_t thpsize_shmem_enabled_store(struct kobject *kobj,
>  		ret = -EINVAL;
>  	}
>  
> +	if (ret > 0) {
> +		int err = start_stop_khugepaged();
> +
> +		if (err)
> +			ret = err;
> +	}
>  	return ret;
>  }
>  


