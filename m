Return-Path: <linux-kernel+bounces-209168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56803902E2F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 04:04:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDE12284DA7
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 02:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52319B662;
	Tue, 11 Jun 2024 02:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="t/b2HW8t"
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC94A94B
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 02:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718071486; cv=none; b=ZhaNW9VOIawJxewXZgAUC2ijxewXzeNDh+oBFhBgkDQUwiWf9Q8fW33YrqCaOw/p7oDYfnzG+2t6kZmpWHnJu/JyOdKYKt/pR+voQo4OB7oaAepww7F8uWfNitTO6oY0VPeGKSY4CHvIwcqI0l0MzHtFfKyLbikTIdoHFQXIsHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718071486; c=relaxed/simple;
	bh=KHMWCLwiS57Nz16itqOWI3JbubOZ0uAVAJGTbNUd2Iw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fBd6bONdAX0alAM4fkgF2i8MsFCkQj0crZC8au3ft0pBqqXUdLaPXAfpE0Ya7UMRll6If64dDNofdsyYOjuSG/Pm6JONvPQXj/hQ8NFy6W7T1Lp01YtK8TzoxfQ3y69SzUjPF1dA4utoHrP5GsRpu17/kcnTf2iLqXUR8E9lKbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=t/b2HW8t; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718071474; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=7j4g4SdK/dgS0J/c8Twl0jOBteQXn2uqyypbDOrvpVM=;
	b=t/b2HW8t/Wflliv86LLSBqZpwduSb1VCrfnnUln9w/tmvS/8L7nNGOcrxa+S2U7nLfeGcMaXnX/hKST3LiskawF83M16TVkLQ5tQ5n39WYM6XYyTRIp6oWqwdtVSi13Tuc33P+whfzZy8+heTLAZfE1giXdpaRVN7/FzF3Y+3ZM=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R461e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032014031;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0W8EY.xP_1718071471;
Received: from 30.97.56.68(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W8EY.xP_1718071471)
          by smtp.aliyun-inc.com;
          Tue, 11 Jun 2024 10:04:32 +0800
Message-ID: <6c7a8602-5b88-424c-a8c4-8a9502865d94@linux.alibaba.com>
Date: Tue, 11 Jun 2024 10:04:31 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/6] mm: shmem: add multi-size THP sysfs interface for
 anonymous shmem
To: Daniel Gomez <da.gomez@samsung.com>
Cc: "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "hughd@google.com" <hughd@google.com>,
 "willy@infradead.org" <willy@infradead.org>,
 "david@redhat.com" <david@redhat.com>,
 "wangkefeng.wang@huawei.com" <wangkefeng.wang@huawei.com>,
 "ying.huang@intel.com" <ying.huang@intel.com>,
 "21cnbao@gmail.com" <21cnbao@gmail.com>,
 "ryan.roberts@arm.com" <ryan.roberts@arm.com>,
 "shy828301@gmail.com" <shy828301@gmail.com>, "ziy@nvidia.com"
 <ziy@nvidia.com>, "ioworker0@gmail.com" <ioworker0@gmail.com>,
 Pankaj Raghav <p.raghav@samsung.com>, "linux-mm@kvack.org"
 <linux-mm@kvack.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <cover.1717495894.git.baolin.wang@linux.alibaba.com>
 <119966ae28bf2e2d362ae3d369ac1a1cd27ba866.1717495894.git.baolin.wang@linux.alibaba.com>
 <CGME20240610122305eucas1p21bfd8a8c999b3fc8bfce04e5feea7bf7@eucas1p2.samsung.com>
 <denilwdvfb772l432ezexwmy46rzv7disxhryf2ktqmtfk5khe@ghq3sohl5z3w>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <denilwdvfb772l432ezexwmy46rzv7disxhryf2ktqmtfk5khe@ghq3sohl5z3w>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/6/10 20:23, Daniel Gomez wrote:
> Hi Baolin,
> On Tue, Jun 04, 2024 at 06:17:47PM +0800, Baolin Wang wrote:
>> To support the use of mTHP with anonymous shmem, add a new sysfs interface
>> 'shmem_enabled' in the '/sys/kernel/mm/transparent_hugepage/hugepages-kB/'
>> directory for each mTHP to control whether shmem is enabled for that mTHP,
>> with a value similar to the top level 'shmem_enabled', which can be set to:
>> "always", "inherit (to inherit the top level setting)", "within_size", "advise",
>> "never". An 'inherit' option is added to ensure compatibility with these
>> global settings, and the options 'force' and 'deny' are dropped, which are
>> rather testing artifacts from the old ages.
>>
>> By default, PMD-sized hugepages have enabled="inherit" and all other hugepage
>> sizes have enabled="never" for '/sys/kernel/mm/transparent_hugepage/hugepages-xxkB/shmem_enabled'.
>>
>> In addition, if top level value is 'force', then only PMD-sized hugepages
>> have enabled="inherit", otherwise configuration will be failed and vice versa.
>> That means now we will avoid using non-PMD sized THP to override the global
>> huge allocation.
>>
>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>> ---
>>   Documentation/admin-guide/mm/transhuge.rst | 23 ++++++
>>   include/linux/huge_mm.h                    | 10 +++
>>   mm/huge_memory.c                           | 11 +--
>>   mm/shmem.c                                 | 96 ++++++++++++++++++++++
>>   4 files changed, 132 insertions(+), 8 deletions(-)
>>
>> diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
>> index d414d3f5592a..b76d15e408b3 100644
>> --- a/Documentation/admin-guide/mm/transhuge.rst
>> +++ b/Documentation/admin-guide/mm/transhuge.rst
>> @@ -332,6 +332,29 @@ deny
>>   force
>>       Force the huge option on for all - very useful for testing;
>>   
>> +Shmem can also use "multi-size THP" (mTHP) by adding a new sysfs knob to control
>> +mTHP allocation: '/sys/kernel/mm/transparent_hugepage/hugepages-<size>kB/shmem_enabled',
>> +and its value for each mTHP is essentially consistent with the global setting.
>> +An 'inherit' option is added to ensure compatibility with these global settings.
>> +Conversely, the options 'force' and 'deny' are dropped, which are rather testing
>> +artifacts from the old ages.
>> +always
>> +    Attempt to allocate <size> huge pages every time we need a new page;
>> +
>> +inherit
>> +    Inherit the top-level "shmem_enabled" value. By default, PMD-sized hugepages
>> +    have enabled="inherit" and all other hugepage sizes have enabled="never";
>> +
>> +never
>> +    Do not allocate <size> huge pages;
>> +
>> +within_size
>> +    Only allocate <size> huge page if it will be fully within i_size.
>> +    Also respect fadvise()/madvise() hints;
>> +
>> +advise
>> +    Only allocate <size> huge pages if requested with fadvise()/madvise();
>> +
>>   Need of application restart
>>   ===========================
>>   
>> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
>> index 020e2344eb86..fac21548c5de 100644
>> --- a/include/linux/huge_mm.h
>> +++ b/include/linux/huge_mm.h
>> @@ -6,6 +6,7 @@
>>   #include <linux/mm_types.h>
>>   
>>   #include <linux/fs.h> /* only for vma_is_dax() */
>> +#include <linux/kobject.h>
>>   
>>   vm_fault_t do_huge_pmd_anonymous_page(struct vm_fault *vmf);
>>   int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
>> @@ -63,6 +64,7 @@ ssize_t single_hugepage_flag_show(struct kobject *kobj,
>>   				  struct kobj_attribute *attr, char *buf,
>>   				  enum transparent_hugepage_flag flag);
>>   extern struct kobj_attribute shmem_enabled_attr;
>> +extern struct kobj_attribute thpsize_shmem_enabled_attr;
>>   
>>   /*
>>    * Mask of all large folio orders supported for anonymous THP; all orders up to
>> @@ -265,6 +267,14 @@ unsigned long thp_vma_allowable_orders(struct vm_area_struct *vma,
>>   	return __thp_vma_allowable_orders(vma, vm_flags, tva_flags, orders);
>>   }
>>   
>> +struct thpsize {
>> +	struct kobject kobj;
>> +	struct list_head node;
>> +	int order;
>> +};
>> +
>> +#define to_thpsize(kobj) container_of(kobj, struct thpsize, kobj)
>> +
>>   enum mthp_stat_item {
>>   	MTHP_STAT_ANON_FAULT_ALLOC,
>>   	MTHP_STAT_ANON_FAULT_FALLBACK,
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index 8e49f402d7c7..1360a1903b66 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -449,14 +449,6 @@ static void thpsize_release(struct kobject *kobj);
>>   static DEFINE_SPINLOCK(huge_anon_orders_lock);
>>   static LIST_HEAD(thpsize_list);
>>   
>> -struct thpsize {
>> -	struct kobject kobj;
>> -	struct list_head node;
>> -	int order;
>> -};
>> -
>> -#define to_thpsize(kobj) container_of(kobj, struct thpsize, kobj)
>> -
>>   static ssize_t thpsize_enabled_show(struct kobject *kobj,
>>   				    struct kobj_attribute *attr, char *buf)
>>   {
>> @@ -517,6 +509,9 @@ static struct kobj_attribute thpsize_enabled_attr =
>>   
>>   static struct attribute *thpsize_attrs[] = {
>>   	&thpsize_enabled_attr.attr,
>> +#ifdef CONFIG_SHMEM
>> +	&thpsize_shmem_enabled_attr.attr,
>> +#endif
>>   	NULL,
>>   };
>>   
>> diff --git a/mm/shmem.c b/mm/shmem.c
>> index ae358efc397a..643ff7516b4d 100644
>> --- a/mm/shmem.c
>> +++ b/mm/shmem.c
>> @@ -131,6 +131,14 @@ struct shmem_options {
>>   #define SHMEM_SEEN_QUOTA 32
>>   };
>>   
>> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
>> +static unsigned long huge_anon_shmem_orders_always __read_mostly;
>> +static unsigned long huge_anon_shmem_orders_madvise __read_mostly;
>> +static unsigned long huge_anon_shmem_orders_inherit __read_mostly;
>> +static unsigned long huge_anon_shmem_orders_within_size __read_mostly;
>> +static DEFINE_SPINLOCK(huge_anon_shmem_orders_lock);
>> +#endif
> 
> Since we are also applying the new sysfs knob controls to tmpfs and anon mm,
> should we rename this to get rid of the anon prefix?

Sure. I want to do this in the patch set of mTHP support tmpfs 
originally, but yes, I can just drop the 'anon' prefix as a preparation.

