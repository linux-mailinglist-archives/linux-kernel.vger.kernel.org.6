Return-Path: <linux-kernel+bounces-386805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D9C29B4813
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 12:14:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C40F01F219FC
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 11:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F7AF204F80;
	Tue, 29 Oct 2024 11:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="icbbYhzs"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E79205145;
	Tue, 29 Oct 2024 11:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730200464; cv=none; b=in3RGcO4340t1WK26uDOsAQmWi+en8WYTxdf0Sd0QqJp8+azMUccBxlZdW6UVJS0nQCL/6Vlsz83vrtbEwlmvfj1p4kpVkhDoksapraWW3AiJxj99gbcQZQY0i3BBHh6xNEhaTk3VP7qLB8xHceZBmWWtACmOpqytmqmfELj96A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730200464; c=relaxed/simple;
	bh=ntcR/5fxYI9veJkD9zPHKCvwGVU+MMkjl7VtMV4YZ1o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gfoNqO2S+/6+dmWbb18IGnmWOJgmSuwPuLdKR5uLcySFzNZj6lBHatZMMS/dazzkFpQ89ILGw+6fDvy+01f+dsGdUJjM85mRW/otUlh1lvmBxSRzjvYSouSv+bBjOUm6kWABG76RGZ4NTpxZaKY0yHUYen+IOmM9hVrSvmmuWwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=icbbYhzs; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=AYysOSKmA73dsvmvXqLdUufvFFewPZvF2sm/O7lEFDE=; b=icbbYhzsA3CPDkrmDlPobvrASF
	TgWFZ+UPrdLjSqKdy4qnTyfO3dPdOBuz3wIoPYsDwA2dtN3u+U99rTYrFd8MTIxEZHSDVj0jN9ktp
	uh1BMem9i7tZfX4kbBB/lhVtVHEPC7sXJnCqYlgmPhHV+/9RCzGWwtevCld+qNMmhfodP2Jf3p/pI
	ZQ8ZNixTBHlnihJ83ah3aOIeGcHBM7EyENVvL6m1GPrsL6MkbUidSffJ+fu9pUVi8+ezVacCwMLXn
	4TKEYYWaNWkyHjUOCfKBijLiq9Fbdmjj8cSd8wp84sBTY6rqFCQRayWCW5QfjbqLucqM/mF2rwCBZ
	lSWMyx3A==;
Received: from [187.36.213.55] (helo=[192.168.1.103])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1t5kAm-00Gb04-T9; Tue, 29 Oct 2024 12:14:05 +0100
Message-ID: <aa6d71d5-979d-41d7-bc5c-0ac0bc6f159a@igalia.com>
Date: Tue, 29 Oct 2024 08:13:59 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] mm: shmem: control THP support through the kernel
 command line
To: Baolin Wang <baolin.wang@linux.alibaba.com>,
 Jonathan Corbet <corbet@lwn.net>, Andrew Morton <akpm@linux-foundation.org>,
 Hugh Dickins <hughd@google.com>, Barry Song <baohua@kernel.org>,
 David Hildenbrand <david@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Lance Yang <ioworker0@gmail.com>
Cc: linux-mm@kvack.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-dev@igalia.com
References: <20241029002324.1062723-1-mcanal@igalia.com>
 <20241029002324.1062723-3-mcanal@igalia.com>
 <6044e56a-7747-45d4-82c9-7a070950ddd2@linux.alibaba.com>
Content-Language: en-US
From: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
In-Reply-To: <6044e56a-7747-45d4-82c9-7a070950ddd2@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Baolin,

On 28/10/24 23:03, Baolin Wang wrote:
> 
> 
> On 2024/10/29 08:13, Maíra Canal wrote:
>> Add a new kernel command line to control the hugepage allocation policy
>> for the internal shmem mount, ``transparent_hugepage_shmem``. The
>> parameter is similar to ``transparent_hugepage`` and has the following
>> format:
>>
>> transparent_hugepage_shmem=<policy>
>>
>> where ``<policy>`` is one of the seven valid policies available for
>> shmem.
>>
>> By configuring the default hugepage allocation policy for the internal
>> shmem mount, applications that use shmem, such as the DRM GEM objects,
>> can take advantage of mTHP before it's been configured through sysfs.
> 
> Just out of curiosity, do you have any performance benefit data when 
> using mTHP for DRM GEM objects?

I haven't yet benchmark mTHP with V3D (Raspberry Pi's GPU) and also I
still need to find the ideal combination of huge pages' sizes. But the
idea is to benefit from the Super Pages support that I recently
implemented in V3D [1]. Currently, I'm using a separate tmpfs mountpoint
to implement Super Pages.

I'll apply your refactor suggestion in the next version. Thanks!

[1] 
https://mairacanal.github.io/unleashing-power-enabling-super-pages-on-RPi/

Best Regards,
- Maíra

> 
>> Signed-off-by: Maíra Canal <mcanal@igalia.com>
>> ---
>>   .../admin-guide/kernel-parameters.txt         |  7 +++
>>   Documentation/admin-guide/mm/transhuge.rst    |  6 +++
>>   mm/shmem.c                                    | 53 +++++++++++++++----
>>   3 files changed, 57 insertions(+), 9 deletions(-)
>>
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/ 
>> Documentation/admin-guide/kernel-parameters.txt
>> index 1666576acc0e..acabb04d0dd4 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -6926,6 +6926,13 @@
>>               See Documentation/admin-guide/mm/transhuge.rst
>>               for more details.
>> +    transparent_hugepage_shmem= [KNL]
>> +            Format: [always|within_size|advise|never|deny|force]
>> +            Can be used to control the hugepage allocation policy for
>> +            the internal shmem mount.
>> +            See Documentation/admin-guide/mm/transhuge.rst
>> +            for more details.
>> +
>>       trusted.source=    [KEYS]
>>               Format: <string>
>>               This parameter identifies the trust source as a backend
>> diff --git a/Documentation/admin-guide/mm/transhuge.rst b/ 
>> Documentation/admin-guide/mm/transhuge.rst
>> index 745055c3dc09..9b5b02c4d1ab 100644
>> --- a/Documentation/admin-guide/mm/transhuge.rst
>> +++ b/Documentation/admin-guide/mm/transhuge.rst
>> @@ -326,6 +326,12 @@ PMD_ORDER THP policy will be overridden. If the 
>> policy for PMD_ORDER
>>   is not defined within a valid ``thp_anon``, its policy will default to
>>   ``never``.
>> +Similarly to ``transparent_hugepage``, you can control the hugepage
>> +allocation policy for the internal shmem mount by using the kernel 
>> parameter
>> +``transparent_hugepage_shmem=<policy>``, where ``<policy>`` is one of 
>> the
>> +seven valid policies for shmem (``always``, ``within_size``, ``advise``,
>> +``never``, ``deny``, and ``force``).
>> +
>>   Hugepages in tmpfs/shmem
>>   ========================
>> diff --git a/mm/shmem.c b/mm/shmem.c
>> index 44282a296c33..26c1eb1b4b1d 100644
>> --- a/mm/shmem.c
>> +++ b/mm/shmem.c
>> @@ -582,7 +582,6 @@ static bool shmem_huge_global_enabled(struct inode 
>> *inode, pgoff_t index,
>>       }
>>   }
>> -#if defined(CONFIG_SYSFS)
>>   static int shmem_parse_huge(const char *str)
>>   {
>>       if (!strcmp(str, "never"))
>> @@ -599,7 +598,6 @@ static int shmem_parse_huge(const char *str)
>>           return SHMEM_HUGE_FORCE;
>>       return -EINVAL;
>>   }
>> -#endif
>>   #if defined(CONFIG_SYSFS) || defined(CONFIG_TMPFS)
>>   static const char *shmem_format_huge(int huge)
>> @@ -624,6 +622,20 @@ static const char *shmem_format_huge(int huge)
>>   }
>>   #endif
>> +static int shmem_valid_huge(int huge)
>> +{
>> +    if (!has_transparent_hugepage() &&
>> +            huge != SHMEM_HUGE_NEVER && huge != SHMEM_HUGE_DENY)
>> +        return -EINVAL;
>> +
>> +    /* Do not override huge allocation policy with non-PMD sized mTHP */
>> +    if (huge == SHMEM_HUGE_FORCE &&
>> +        huge_shmem_orders_inherit != BIT(HPAGE_PMD_ORDER))
>> +        return -EINVAL;
>> +
>> +    return 0;
>> +}
>> +
>>   static unsigned long shmem_unused_huge_shrink(struct shmem_sb_info 
>> *sbinfo,
>>           struct shrink_control *sc, unsigned long nr_to_free)
>>   {
>> @@ -5070,14 +5082,10 @@ static ssize_t shmem_enabled_store(struct 
>> kobject *kobj,
>>       huge = shmem_parse_huge(tmp);
>>       if (huge == -EINVAL)
>>           return -EINVAL;
>> -    if (!has_transparent_hugepage() &&
>> -            huge != SHMEM_HUGE_NEVER && huge != SHMEM_HUGE_DENY)
>> -        return -EINVAL;
>> -    /* Do not override huge allocation policy with non-PMD sized mTHP */
>> -    if (huge == SHMEM_HUGE_FORCE &&
>> -        huge_shmem_orders_inherit != BIT(HPAGE_PMD_ORDER))
>> -        return -EINVAL;
>> +    err = shmem_valid_huge(huge);
>> +    if (err)
>> +        return err;
>>       shmem_huge = huge;
>>       if (shmem_huge > SHMEM_HUGE_DENY)
>> @@ -5174,6 +5182,33 @@ struct kobj_attribute thpsize_shmem_enabled_attr =
>>       __ATTR(shmem_enabled, 0644, thpsize_shmem_enabled_show, 
>> thpsize_shmem_enabled_store);
>>   #endif /* CONFIG_TRANSPARENT_HUGEPAGE && CONFIG_SYSFS */
>> +#if defined(CONFIG_TRANSPARENT_HUGEPAGE)
>> +
>> +static int __init setup_transparent_hugepage_shmem(char *str)
>> +{
>> +    int huge, ret = 0;
>> +
>> +    if (!str)
>> +        goto out;
>> +
>> +    huge = shmem_parse_huge(str);
>> +    if (huge == -EINVAL)
>> +        goto out;
> 
> Looks better. But shmem_parse_huge() is also a common part, and what I 
> am thinking is below:
> 
> diff --git a/mm/shmem.c b/mm/shmem.c
> index f8b8b1ad2631..646d8943950a 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -629,24 +629,39 @@ static unsigned int 
> shmem_huge_global_enabled(struct inode *inode, pgoff_t index
>          }
>   }
> 
> -#if defined(CONFIG_SYSFS)
>   static int shmem_parse_huge(const char *str)
>   {
> +       int huge;
> +
> +       if (!str)
> +               return -EINVAL;
> +
>          if (!strcmp(str, "never"))
> -               return SHMEM_HUGE_NEVER;
> -       if (!strcmp(str, "always"))
> -               return SHMEM_HUGE_ALWAYS;
> -       if (!strcmp(str, "within_size"))
> -               return SHMEM_HUGE_WITHIN_SIZE;
> -       if (!strcmp(str, "advise"))
> -               return SHMEM_HUGE_ADVISE;
> -       if (!strcmp(str, "deny"))
> -               return SHMEM_HUGE_DENY;
> -       if (!strcmp(str, "force"))
> -               return SHMEM_HUGE_FORCE;
> -       return -EINVAL;
> +               huge = SHMEM_HUGE_NEVER;
> +       else if (!strcmp(str, "always"))
> +               huge = SHMEM_HUGE_ALWAYS;
> +       else if (!strcmp(str, "within_size"))
> +               huge = SHMEM_HUGE_WITHIN_SIZE;
> +       else if (!strcmp(str, "advise"))
> +               huge = SHMEM_HUGE_ADVISE;
> +       else if (!strcmp(str, "deny"))
> +               huge = SHMEM_HUGE_DENY;
> +       else if (!strcmp(str, "force"))
> +               huge = SHMEM_HUGE_FORCE;
> +       else
> +               return -EINVAL;
> +
> +       if (!has_transparent_hugepage() &&
> +           huge != SHMEM_HUGE_NEVER && huge != SHMEM_HUGE_DENY)
> +               return -EINVAL;
> +
> +       /* Do not override huge allocation policy with non-PMD sized 
> mTHP */
> +       if (huge == SHMEM_HUGE_FORCE &&
> +           huge_shmem_orders_inherit != BIT(HPAGE_PMD_ORDER))
> +               return -EINVAL;
> +
> +       return huge;
>   }
> -#endif
> 
>   #if defined(CONFIG_SYSFS) || defined(CONFIG_TMPFS)
>   static const char *shmem_format_huge(int huge)
> @@ -5104,16 +5119,8 @@ static ssize_t shmem_enabled_store(struct kobject 
> *kobj,
>                  tmp[count - 1] = '\0';
> 
>          huge = shmem_parse_huge(tmp);
> -       if (huge == -EINVAL)
> -               return -EINVAL;
> -       if (!has_transparent_hugepage() &&
> -                       huge != SHMEM_HUGE_NEVER && huge != 
> SHMEM_HUGE_DENY)
> -               return -EINVAL;
> -
> -       /* Do not override huge allocation policy with non-PMD sized 
> mTHP */
> -       if (huge == SHMEM_HUGE_FORCE &&
> -           huge_shmem_orders_inherit != BIT(HPAGE_PMD_ORDER))
> -               return -EINVAL;
> +       if (huge < 0)
> +               return huge;
> 
>          shmem_huge = huge;
>          if (shmem_huge > SHMEM_HUGE_DENY)
> @@ -5210,6 +5217,25 @@ struct kobj_attribute thpsize_shmem_enabled_attr =
>          __ATTR(shmem_enabled, 0644, thpsize_shmem_enabled_show, 
> thpsize_shmem_enabled_store);
>   #endif /* CONFIG_TRANSPARENT_HUGEPAGE && CONFIG_SYSFS */
> 
> +#if defined(CONFIG_TRANSPARENT_HUGEPAGE)
> +
> +static int __init setup_transparent_hugepage_shmem(char *str)
> +{
> +       int huge;
> +
> +       huge = shmem_parse_huge(str);
> +       if (huge < 0) {
> +               pr_warn("transparent_hugepage_shmem= cannot parse, 
> ignored\n");
> +               return 0;
> +       }
> +
> +       shmem_huge = huge;
> +       return 1;
> +}
> +__setup("transparent_hugepage_shmem=", setup_transparent_hugepage_shmem);
> +
> +#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
> +
>   #else /* !CONFIG_SHMEM */
> 
>   /*


