Return-Path: <linux-kernel+bounces-390544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 175839B7B1B
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 13:51:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA9DC286EC4
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 12:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDBF419D087;
	Thu, 31 Oct 2024 12:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="OJJ+ekAp"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD3A19CC2E;
	Thu, 31 Oct 2024 12:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730379094; cv=none; b=YTzc/AkOP8nHPj12LQ7KjguVymcAgbBRFw5pIcMdFUP/iu9ITDLe4loBjoWH/lRDQGZXSeDwJooPhyZ0E3XMfspfyUQ9MshV79C2Fif7XvkZ/kAZGv499wtnE1rhUA8V8VtJtGxT0jrecL0WGYaN42eJJjjr8Kjom8lua1JQ+TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730379094; c=relaxed/simple;
	bh=8WukueJglfIZ7V/2lN2zJBVmiF1G+XXvk8Aa2j1mF4I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dDQ+HorGXxr/wNuQxVf4+bukP2k4OY86ufaBbl88wub+gUpqhWv6JU7x/oyabK6C97RkOED+1VaFjDbC7Asjl9uJfg/OJ7o4R8Itx9WzagxozXxSJLjwRN1c/Vb6tZx5P8i0prJak1Hba8d2qNY9ureWv0xU5IcNIGBm0jGBjWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=OJJ+ekAp; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=pHltMX9LLDodjoFNq4oyjQF0WKzjMpxw/dGQ9QZLO3U=; b=OJJ+ekApQQKAPl3CnRjns8iW2S
	S/n/Va8F8V1WXrcXiImAuA+vEQshA/m+Cv7dqmFeIm9awtFnlw+hU5AHLfyV/LU2f6YUh/+nShGJo
	OCgMWXkLbSlmKcjRpB64Flah7LH8M+iIORw9lYdUY+2xNN2VOhUKT+tYFroXnzsWg5tmrTQI6jBtr
	1zPpm1by9rx+HJcpbmCVAE+XI2BescWnMbVMZYEIZuvQphyawBchAy2Kcsd4fPCdvqVbR5kLBojW6
	Bm3bArrJ080zvH81YsQlxSXd0jHsyVVnzQLasmKnWqEeBXeXPCxcDRjyDVEMYNsqVvzlQfR/CHtYF
	ZDK2pD3A==;
Received: from [187.36.213.55] (helo=[192.168.1.103])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1t6Udt-00014M-Qd; Thu, 31 Oct 2024 13:51:14 +0100
Message-ID: <899284fa-953f-48a1-af29-222d0d55881c@igalia.com>
Date: Thu, 31 Oct 2024 09:51:05 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] mm: shmem: override mTHP shmem default with a
 kernel parameter
To: David Hildenbrand <david@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
 Andrew Morton <akpm@linux-foundation.org>, Hugh Dickins <hughd@google.com>,
 Barry Song <baohua@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Lance Yang <ioworker0@gmail.com>
Cc: linux-mm@kvack.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-dev@igalia.com
References: <20241030130308.1066299-1-mcanal@igalia.com>
 <20241030130308.1066299-4-mcanal@igalia.com>
 <2c507326-3267-431e-936a-23e2ab6a3baf@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
In-Reply-To: <2c507326-3267-431e-936a-23e2ab6a3baf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi David,

On 31/10/24 09:37, David Hildenbrand wrote:
> On 30.10.24 13:58, Maíra Canal wrote:
>> Add the ``thp_shmem=`` kernel command line to allow specifying the
>> default policy of each supported shmem hugepage size. The kernel 
>> parameter
>> accepts the following format:
>>
>> thp_shmem=<size>[KMG],<size>[KMG]:<policy>;<size>[KMG]- 
>> <size>[KMG]:<policy>
>>
>> For example,
>>
>> thp_shmem=16K-64K:always;128K,512K:inherit;256K:advise;1M-2M:never;4M-8M:within_size
>>
>> By configuring the default policy of several shmem hugepages, the user
>> can take advantage of mTHP before it's been configured through sysfs.
>>
>> Signed-off-by: Maíra Canal <mcanal@igalia.com>
>> ---
>>   .../admin-guide/kernel-parameters.txt         |  10 ++
>>   Documentation/admin-guide/mm/transhuge.rst    |  17 +++
>>   mm/shmem.c                                    | 109 +++++++++++++++++-
>>   3 files changed, 135 insertions(+), 1 deletion(-)
>>

[...]

>> diff --git a/mm/shmem.c b/mm/shmem.c
>> index dfcc88ec6e34..c2299fa0b345 100644
>> --- a/mm/shmem.c
>> +++ b/mm/shmem.c
>> @@ -136,6 +136,7 @@ static unsigned long huge_shmem_orders_always 
>> __read_mostly;
>>   static unsigned long huge_shmem_orders_madvise __read_mostly;
>>   static unsigned long huge_shmem_orders_inherit __read_mostly;
>>   static unsigned long huge_shmem_orders_within_size __read_mostly;
>> +static bool shmem_orders_configured __initdata;
>>   #endif
>>   #ifdef CONFIG_TMPFS
>> @@ -5027,7 +5028,8 @@ void __init shmem_init(void)
>>        * Default to setting PMD-sized THP to inherit the global 
>> setting and
>>        * disable all other multi-size THPs.
>>        */
>> -    huge_shmem_orders_inherit = BIT(HPAGE_PMD_ORDER);
>> +    if (!shmem_orders_configured)
>> +        huge_shmem_orders_inherit = BIT(HPAGE_PMD_ORDER);
>>   #endif
>>       return;
>> @@ -5180,6 +5182,26 @@ struct kobj_attribute thpsize_shmem_enabled_attr =
>>   #if defined(CONFIG_TRANSPARENT_HUGEPAGE)
>> +static inline int get_order_from_str(const char *size_str)
>> +{
>> +    unsigned long size;
>> +    char *endptr;
>> +    int order;
>> +
>> +    size = memparse(size_str, &endptr);
>> +
>> +    if (!is_power_of_2(size))
>> +        goto err;
>> +    order = get_order(size);
>> +    if (BIT(order) & ~THP_ORDERS_ALL_FILE_DEFAULT)
>> +        goto err;
>> +
>> +    return order;
>> +err:
>> +    pr_err("invalid size %s in thp_shmem boot parameter\n", size_str);
>> +    return -EINVAL;
>> +}
> 
> Hm, mostly copy and paste. You could reuse existing get_order_from_str() 
> simply by passing in the supported orders and moving error reporting to 
> the caller.
> 

Can I use functions from mm/huge_memory.c here?

> static inline int get_order_from_str(const char *size_str,
>          int valid_orders)
> {
>      ...
>      if (!is_power_of_2(size))
>          return -EINVAL;
>      order = get_order(size);
>      if (BIT(order) & ~valid_orders)
>          return -EINVAL;
>      return order;
> }
> 
>> +
>>   static int __init setup_transparent_hugepage_shmem(char *str)
>>   {
>>       int huge;
>> @@ -5195,6 +5217,91 @@ static int __init 
>> setup_transparent_hugepage_shmem(char *str)
>>   }
>>   __setup("transparent_hugepage_shmem=", 
>> setup_transparent_hugepage_shmem);
>> +static char str_dup[PAGE_SIZE] __initdata;
>> +static int __init setup_thp_shmem(char *str)
>> +{
>> +    char *token, *range, *policy, *subtoken;
>> +    unsigned long always, inherit, madvise, within_size;
>> +    char *start_size, *end_size;
>> +    int start, end, nr;
>> +    char *p;
>> +
>> +    if (!str || strlen(str) + 1 > PAGE_SIZE)
>> +        goto err;
>> +    strscpy(str_dup, str);
>> +
>> +    always = huge_shmem_orders_always;
>> +    inherit = huge_shmem_orders_inherit;
>> +    madvise = huge_shmem_orders_madvise;
>> +    within_size = huge_shmem_orders_within_size;
>> +    p = str_dup;
>> +    while ((token = strsep(&p, ";")) != NULL) {
>> +        range = strsep(&token, ":");
>> +        policy = token;
>> +
>> +        if (!policy)
>> +            goto err;
>> +
>> +        while ((subtoken = strsep(&range, ",")) != NULL) {
>> +            if (strchr(subtoken, '-')) {
>> +                start_size = strsep(&subtoken, "-");
>> +                end_size = subtoken;
>> +
>> +                start = get_order_from_str(start_size);
>> +                end = get_order_from_str(end_size);
>> +            } else {
>> +                start = end = get_order_from_str(subtoken);
>> +            }
>> +
>> +            if (start < 0 || end < 0 || start > end)
>> +                goto err;
>> +
>> +            nr = end - start + 1;
>> +            if (!strcmp(policy, "always")) {
>> +                bitmap_set(&always, start, nr);
>> +                bitmap_clear(&inherit, start, nr);
>> +                bitmap_clear(&madvise, start, nr);
>> +                bitmap_clear(&within_size, start, nr);
>> +            } else if (!strcmp(policy, "advise")) {
>> +                bitmap_set(&madvise, start, nr);
>> +                bitmap_clear(&inherit, start, nr);
>> +                bitmap_clear(&always, start, nr);
>> +                bitmap_clear(&within_size, start, nr);
>> +            } else if (!strcmp(policy, "inherit")) {
>> +                bitmap_set(&inherit, start, nr);
>> +                bitmap_clear(&madvise, start, nr);
>> +                bitmap_clear(&always, start, nr);
>> +                bitmap_clear(&within_size, start, nr);
>> +            } else if (!strcmp(policy, "within_size")) {
>> +                bitmap_set(&within_size, start, nr);
>> +                bitmap_clear(&inherit, start, nr);
>> +                bitmap_clear(&madvise, start, nr);
>> +                bitmap_clear(&always, start, nr);
>> +            } else if (!strcmp(policy, "never")) {
>> +                bitmap_clear(&inherit, start, nr);
>> +                bitmap_clear(&madvise, start, nr);
>> +                bitmap_clear(&always, start, nr);
>> +                bitmap_clear(&within_size, start, nr);
>> +            } else {
>> +                pr_err("invalid policy %s in thp_shmem boot 
>> parameter\n", policy);
>> +                goto err;
>> +            }
>> +        }
>> +    }
> 
> 
> Similarly, copy-paste. But not that easy to abstract :) So maybe we'll 
> have to keep that as is for now.

On v2 [1], I abstracted to reduce copy and paste, but me and Barry
agreed that adding this sort of header to linux/huge_mm.h was weird.

[1] 
https://lore.kernel.org/linux-mm/20241029002324.1062723-4-mcanal@igalia.com/

Best Regards,
- Maíra

> 
> 


