Return-Path: <linux-kernel+bounces-171143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44FF88BE02D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 12:53:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68F2B1C232CF
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 10:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EB7814F9ED;
	Tue,  7 May 2024 10:52:54 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A6F214EC77
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 10:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715079173; cv=none; b=n6De+DAQwiNH0xCW6q8S2jQpLl1rDg9dZLi7Jim7qnHX7j5g/vSUE+flIUdgShypAIT/jLbDjJEY3Z7ne+uNTfyAAgqfjm5fHFORO9u4I5eppa/fbvnPCve010skwt4eN7+Tc4gTm0mZZH7xcwcQ9zBNfvy2MOWbNR4zDzU9kOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715079173; c=relaxed/simple;
	bh=cE5lLCSEiRrbD/Q/KZo8uMyfJ+JSa/+WwFpZA6EH+Ok=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sTD1bpaWt0xOhy43HFGltNdg5MsbGYJMy3DqdFZKn/UHSzM8h+n3heJWnecs2PPkyEpeKoZ+WZdHHUDAsQMrKDJAPcGCx3ijaCtMKRti+Cuu7EZEW5wgV+9h0HP7eKnGr000zt1fkUyCe1nPlhGb484c7moZcp6L5FstRSwYnqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0AE8A1063;
	Tue,  7 May 2024 03:53:17 -0700 (PDT)
Received: from [10.1.34.181] (XHFQ2J9959.cambridge.arm.com [10.1.34.181])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6F8973F587;
	Tue,  7 May 2024 03:52:49 -0700 (PDT)
Message-ID: <30329a82-45b9-4e78-8c48-bd56af113786@arm.com>
Date: Tue, 7 May 2024 11:52:48 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/8] mm: shmem: add multi-size THP sysfs interface for
 anonymous shmem
Content-Language: en-GB
To: Baolin Wang <baolin.wang@linux.alibaba.com>, akpm@linux-foundation.org,
 hughd@google.com
Cc: willy@infradead.org, david@redhat.com, ioworker0@gmail.com,
 wangkefeng.wang@huawei.com, ying.huang@intel.com, 21cnbao@gmail.com,
 shy828301@gmail.com, ziy@nvidia.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <cover.1714978902.git.baolin.wang@linux.alibaba.com>
 <6b4afed1ef26dbd08ae9ec58449b329564dcef3e.1714978902.git.baolin.wang@linux.alibaba.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <6b4afed1ef26dbd08ae9ec58449b329564dcef3e.1714978902.git.baolin.wang@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 06/05/2024 09:46, Baolin Wang wrote:
> To support the use of mTHP with anonymous shmem, add a new sysfs interface
> 'shmem_enabled' in the '/sys/kernel/mm/transparent_hugepage/hugepages-kB/'
> directory for each mTHP to control whether shmem is enabled for that mTHP,
> with a value similar to the top level 'shmem_enabled', which can be set to:
> "always", "inherit (to inherit the top level setting)", "within_size", "advise",
> "never", "deny", "force". These values follow the same semantics as the top
> level, except the 'deny' is equivalent to 'never', and 'force' is equivalent
> to 'always' to keep compatibility.

We decided at [1] to not allow 'force' for non-PMD-sizes.

[1]
https://lore.kernel.org/linux-mm/533f37e9-81bf-4fa2-9b72-12cdcb1edb3f@redhat.com/

However, thinking about this a bit more, I wonder if the decision we made to
allow all hugepages-xxkB/enabled controls to take "inherit" was the wrong one.
Perhaps we should have only allowed the PMD-sized enable=inherit (this is just
for legacy back compat after all, I don't think there is any use case where
changing multiple mTHP size controls atomically is actually useful). Applying
that pattern here, it means the top level can always take "force" without any
weird error checking. And we would allow "force" on the PMD-sized control but
not on the others - again this is easy to error check.

Does this pattern make more sense? If so, is it too late to change
hugepages-xxkB/enabled interface?

> 
> By default, PMD-sized hugepages have enabled="inherit" and all other hugepage
> sizes have enabled="never" for '/sys/kernel/mm/transparent_hugepage/hugepages-xxkB/shmem_enabled'.
> 
> In addition, if top level value is 'force', then only PMD-sized hugepages
> have enabled="inherit", otherwise configuration will be failed and vice versa.
> That means now we will avoid using non-PMD sized THP to override the global
> huge allocation.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
>  Documentation/admin-guide/mm/transhuge.rst | 29 +++++++
>  include/linux/huge_mm.h                    | 10 +++
>  mm/huge_memory.c                           | 11 +--
>  mm/shmem.c                                 | 96 ++++++++++++++++++++++
>  4 files changed, 138 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
> index 076443cc10a6..a28496e15bdb 100644
> --- a/Documentation/admin-guide/mm/transhuge.rst
> +++ b/Documentation/admin-guide/mm/transhuge.rst
> @@ -332,6 +332,35 @@ deny
>  force
>      Force the huge option on for all - very useful for testing;
>  
> +Anonymous shmem can also use "multi-size THP" (mTHP) by adding a new sysfs knob
> +to control mTHP allocation: /sys/kernel/mm/transparent_hugepage/hugepages-<size>kB/shmem_enabled.
> +Its value for each mTHP is essentially consistent with the global setting, except
> +for the addition of 'inherit' to ensure compatibility with the global settings.
> +always
> +    Attempt to allocate <size> huge pages every time we need a new page;
> +
> +inherit
> +    Inherit the top-level "shmem_enabled" value. By default, PMD-sized hugepages
> +    have enabled="inherit" and all other hugepage sizes have enabled="never";
> +
> +never
> +    Do not allocate <size> huge pages;
> +
> +within_size
> +    Only allocate <size> huge page if it will be fully within i_size.
> +    Also respect fadvise()/madvise() hints;
> +
> +advise
> +    Only allocate <size> huge pages if requested with fadvise()/madvise();
> +
> +deny
> +    Has the same semantics as 'never', now mTHP allocation policy is only
> +    used for anonymous shmem and no not override tmpfs.
> +
> +force
> +    Has the same semantics as 'always', now mTHP allocation policy is only
> +    used for anonymous shmem and no not override tmpfs.
> +
>  Need of application restart
>  ===========================
>  
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index e49b56c40a11..dbd6b3f56210 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -6,6 +6,7 @@
>  #include <linux/mm_types.h>
>  
>  #include <linux/fs.h> /* only for vma_is_dax() */
> +#include <linux/kobject.h>
>  
>  vm_fault_t do_huge_pmd_anonymous_page(struct vm_fault *vmf);
>  int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
> @@ -63,6 +64,7 @@ ssize_t single_hugepage_flag_show(struct kobject *kobj,
>  				  struct kobj_attribute *attr, char *buf,
>  				  enum transparent_hugepage_flag flag);
>  extern struct kobj_attribute shmem_enabled_attr;
> +extern struct kobj_attribute thpsize_shmem_enabled_attr;
>  
>  /*
>   * Mask of all large folio orders supported for anonymous THP; all orders up to
> @@ -265,6 +267,14 @@ unsigned long thp_vma_allowable_orders(struct vm_area_struct *vma,
>  	return __thp_vma_allowable_orders(vma, vm_flags, tva_flags, orders);
>  }
>  
> +struct thpsize {
> +	struct kobject kobj;
> +	struct list_head node;
> +	int order;
> +};
> +
> +#define to_thpsize(kobj) container_of(kobj, struct thpsize, kobj)
> +
>  enum mthp_stat_item {
>  	MTHP_STAT_ANON_FAULT_ALLOC,
>  	MTHP_STAT_ANON_FAULT_FALLBACK,
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 9efb6fefc391..d3080a8843f2 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -449,14 +449,6 @@ static void thpsize_release(struct kobject *kobj);
>  static DEFINE_SPINLOCK(huge_anon_orders_lock);
>  static LIST_HEAD(thpsize_list);
>  
> -struct thpsize {
> -	struct kobject kobj;
> -	struct list_head node;
> -	int order;
> -};
> -
> -#define to_thpsize(kobj) container_of(kobj, struct thpsize, kobj)
> -
>  static ssize_t thpsize_enabled_show(struct kobject *kobj,
>  				    struct kobj_attribute *attr, char *buf)
>  {
> @@ -517,6 +509,9 @@ static struct kobj_attribute thpsize_enabled_attr =
>  
>  static struct attribute *thpsize_attrs[] = {
>  	&thpsize_enabled_attr.attr,
> +#ifdef CONFIG_SHMEM
> +	&thpsize_shmem_enabled_attr.attr,
> +#endif
>  	NULL,
>  };
>  
> diff --git a/mm/shmem.c b/mm/shmem.c
> index a383ea9a89a5..59cc26d44344 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -131,6 +131,14 @@ struct shmem_options {
>  #define SHMEM_SEEN_QUOTA 32
>  };
>  
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +static unsigned long huge_anon_shmem_orders_always __read_mostly;
> +static unsigned long huge_anon_shmem_orders_madvise __read_mostly;
> +static unsigned long huge_anon_shmem_orders_inherit __read_mostly;
> +static unsigned long huge_anon_shmem_orders_within_size __read_mostly;
> +static DEFINE_SPINLOCK(huge_anon_shmem_orders_lock);
> +#endif
> +
>  #ifdef CONFIG_TMPFS
>  static unsigned long shmem_default_max_blocks(void)
>  {
> @@ -4687,6 +4695,12 @@ void __init shmem_init(void)
>  		SHMEM_SB(shm_mnt->mnt_sb)->huge = shmem_huge;
>  	else
>  		shmem_huge = SHMEM_HUGE_NEVER; /* just in case it was patched */
> +
> +	/*
> +	 * Default to setting PMD-sized THP to inherit the global setting and
> +	 * disable all other multi-size THPs, when anonymous shmem uses mTHP.
> +	 */
> +	huge_anon_shmem_orders_inherit = BIT(HPAGE_PMD_ORDER);
>  #endif
>  	return;
>  
> @@ -4746,6 +4760,11 @@ static ssize_t shmem_enabled_store(struct kobject *kobj,
>  			huge != SHMEM_HUGE_NEVER && huge != SHMEM_HUGE_DENY)
>  		return -EINVAL;
>  
> +	/* Do not override huge allocation policy with non-PMD sized mTHP */
> +	if (huge == SHMEM_HUGE_FORCE &&
> +	    huge_anon_shmem_orders_inherit != BIT(HPAGE_PMD_ORDER))
> +		return -EINVAL;
> +
>  	shmem_huge = huge;
>  	if (shmem_huge > SHMEM_HUGE_DENY)
>  		SHMEM_SB(shm_mnt->mnt_sb)->huge = shmem_huge;
> @@ -4753,6 +4772,83 @@ static ssize_t shmem_enabled_store(struct kobject *kobj,
>  }
>  
>  struct kobj_attribute shmem_enabled_attr = __ATTR_RW(shmem_enabled);
> +
> +static ssize_t thpsize_shmem_enabled_show(struct kobject *kobj,
> +					  struct kobj_attribute *attr, char *buf)
> +{
> +	int order = to_thpsize(kobj)->order;
> +	const char *output;
> +
> +	if (test_bit(order, &huge_anon_shmem_orders_always))
> +		output = "[always] inherit within_size advise never deny [force]";
> +	else if (test_bit(order, &huge_anon_shmem_orders_inherit))
> +		output = "always [inherit] within_size advise never deny force";
> +	else if (test_bit(order, &huge_anon_shmem_orders_within_size))
> +		output = "always inherit [within_size] advise never deny force";
> +	else if (test_bit(order, &huge_anon_shmem_orders_madvise))
> +		output = "always inherit within_size [advise] never deny force";
> +	else
> +		output = "always inherit within_size advise [never] [deny] force";
> +
> +	return sysfs_emit(buf, "%s\n", output);
> +}
> +
> +static ssize_t thpsize_shmem_enabled_store(struct kobject *kobj,
> +					   struct kobj_attribute *attr,
> +					   const char *buf, size_t count)
> +{
> +	int order = to_thpsize(kobj)->order;
> +	ssize_t ret = count;
> +
> +	if (sysfs_streq(buf, "always") || sysfs_streq(buf, "force")) {
> +		spin_lock(&huge_anon_shmem_orders_lock);
> +		clear_bit(order, &huge_anon_shmem_orders_inherit);
> +		clear_bit(order, &huge_anon_shmem_orders_madvise);
> +		clear_bit(order, &huge_anon_shmem_orders_within_size);
> +		set_bit(order, &huge_anon_shmem_orders_always);
> +		spin_unlock(&huge_anon_shmem_orders_lock);
> +	} else if (sysfs_streq(buf, "inherit")) {
> +		/* Do not override huge allocation policy with non-PMD sized mTHP */
> +		if (shmem_huge == SHMEM_HUGE_FORCE &&
> +		    order != HPAGE_PMD_ORDER)
> +			return -EINVAL;
> +
> +		spin_lock(&huge_anon_shmem_orders_lock);
> +		clear_bit(order, &huge_anon_shmem_orders_always);
> +		clear_bit(order, &huge_anon_shmem_orders_madvise);
> +		clear_bit(order, &huge_anon_shmem_orders_within_size);
> +		set_bit(order, &huge_anon_shmem_orders_inherit);
> +		spin_unlock(&huge_anon_shmem_orders_lock);
> +	} else if (sysfs_streq(buf, "within_size")) {
> +		spin_lock(&huge_anon_shmem_orders_lock);
> +		clear_bit(order, &huge_anon_shmem_orders_always);
> +		clear_bit(order, &huge_anon_shmem_orders_inherit);
> +		clear_bit(order, &huge_anon_shmem_orders_madvise);
> +		set_bit(order, &huge_anon_shmem_orders_within_size);
> +		spin_unlock(&huge_anon_shmem_orders_lock);
> +	} else if (sysfs_streq(buf, "madvise")) {
> +		spin_lock(&huge_anon_shmem_orders_lock);
> +		clear_bit(order, &huge_anon_shmem_orders_always);
> +		clear_bit(order, &huge_anon_shmem_orders_inherit);
> +		clear_bit(order, &huge_anon_shmem_orders_within_size);
> +		set_bit(order, &huge_anon_shmem_orders_madvise);
> +		spin_unlock(&huge_anon_shmem_orders_lock);
> +	} else if (sysfs_streq(buf, "never") || sysfs_streq(buf, "deny")) {
> +		spin_lock(&huge_anon_shmem_orders_lock);
> +		clear_bit(order, &huge_anon_shmem_orders_always);
> +		clear_bit(order, &huge_anon_shmem_orders_inherit);
> +		clear_bit(order, &huge_anon_shmem_orders_within_size);
> +		clear_bit(order, &huge_anon_shmem_orders_madvise);
> +		spin_unlock(&huge_anon_shmem_orders_lock);
> +	} else {
> +		ret = -EINVAL;
> +	}
> +
> +	return ret;
> +}
> +
> +struct kobj_attribute thpsize_shmem_enabled_attr =
> +	__ATTR(shmem_enabled, 0644, thpsize_shmem_enabled_show, thpsize_shmem_enabled_store);
>  #endif /* CONFIG_TRANSPARENT_HUGEPAGE && CONFIG_SYSFS */
>  
>  #else /* !CONFIG_SHMEM */


