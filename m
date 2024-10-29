Return-Path: <linux-kernel+bounces-386108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16DED9B3F34
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 01:31:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBB0E2836C6
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 00:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDF97BE49;
	Tue, 29 Oct 2024 00:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Wp2Qm4Rz"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E51DF78;
	Tue, 29 Oct 2024 00:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730161892; cv=none; b=Tk8NcUillWwqQfoSXfDWJunJRZ24YmNFrL6s+dL8pJHT75InKEf6l1x5TVSOD2pD55GIJsd/mPCa3VDxnUMwsawfq72l0kT6gZboFMNXO1QWYCFiRXzEYxhcQjV2Cn6axJ91CNyboHzMMdg9CuYDG6Z6TiKChLQVyCUskbRsaRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730161892; c=relaxed/simple;
	bh=4V6Dpjqdx/lucqnbcSW+8YIOnRKjzCXC8i3EyE+hWAU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I73P8+0j7v3ZFZBoiXJCmEjE+1+MsAbfmVxJL3VO30D5Vc95+siEDLW300Rt70QhDQwPLOxIjJPkPSi8a3k9sDKyL1DZkJEC2BFmhDUFRaCUJBssSUoVyVNRa4br8g/PaBILC3+wilixZixZAhJYtsRwpDOp5Oov+dVwFIjwxrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=Wp2Qm4Rz; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=AARMfSu/7CX+ky7XhzUJm5Khwsm5g7vV8ZMifTOXCPw=; b=Wp2Qm4RzkRSaKidVyWnMNoMX5q
	vyRaBdc/tVdhpRFsVJUqWELXf3vXny3uWc+l60FRx1YJRFVeyuRbDrdz35FV7LL6HH1r7MlhToFR5
	VmGNk4zIlZ1dPQY73mEzFwsR1KM04TiA8mo6ezUJNOcayyG8/TmPg6K4LWzQXvGkMzCcZ5gnsHXFu
	Sc05fnF8SNn5Gkh75KtifPyyjYpSJ6D4AoT23+QrxoED0rxV//O6C6mdHTzF8CUM/ml5d2bpJ9s7L
	5UEp1r8/3cI2VWfKhIdRPcvuZ8L6BAeb0rqeYAI+St7OhJ3xYx6FQH6c4NiLcSSGuYuBJSjNdYxFz
	n4vN3xXg==;
Received: from [187.36.213.55] (helo=[192.168.1.103])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1t5a8k-00GIzd-1R; Tue, 29 Oct 2024 01:31:18 +0100
Message-ID: <654236eb-945c-4540-bc52-9c99898deed8@igalia.com>
Date: Mon, 28 Oct 2024 21:31:11 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] mm: shmem: override mTHP shmem default with a kernel
 parameter
To: Barry Song <21cnbao@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
 Andrew Morton <akpm@linux-foundation.org>, Hugh Dickins <hughd@google.com>,
 David Hildenbrand <david@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Lance Yang
 <ioworker0@gmail.com>, linux-mm@kvack.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-dev@igalia.com
References: <20241027175743.1056710-1-mcanal@igalia.com>
 <20241027175743.1056710-4-mcanal@igalia.com>
 <CAGsJ_4xCw3OvkMo6cVr+U97C3SO+n+5c1j5XRodLDaLXW4ALjg@mail.gmail.com>
 <2505d52c-3454-4892-8c90-e3d9b2f0c84f@igalia.com>
 <CAGsJ_4y13T+KE1hJPb=14LBvGixd4uQTcN5pS=Hok6Ca6RD+7g@mail.gmail.com>
 <f1c35067-9381-424b-b962-526b85d59ea9@igalia.com>
 <CAGsJ_4wJ2xoNRLMNkmLL3x1t2YiqQJ1=saXa+HNxRUbSNivRCw@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
In-Reply-To: <CAGsJ_4wJ2xoNRLMNkmLL3x1t2YiqQJ1=saXa+HNxRUbSNivRCw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Barry,

On 28/10/24 19:35, Barry Song wrote:
> On Mon, Oct 28, 2024 at 7:34 PM Maíra Canal <mcanal@igalia.com> wrote:
>>
>> Hi Barry,
>>
>> On 28/10/24 08:09, Barry Song wrote:
>>> On Mon, Oct 28, 2024 at 6:10 PM Maíra Canal <mcanal@igalia.com> wrote:
>>>>
>>>> Hi Barry,
>>>>
>>>> On 27/10/24 18:54, Barry Song wrote:
>>>>> On Mon, Oct 28, 2024 at 6:58 AM Maíra Canal <mcanal@igalia.com> wrote:
>>>>>>
>>>>>> Add the ``thp_shmem=`` kernel command line to allow specifying the
>>>>>> default policy of each supported shmem hugepage size. The kernel parameter
>>>>>> accepts the following format:
>>>>>>
>>>>>> thp_shmem=<size>[KMG],<size>[KMG]:<policy>;<size>[KMG]-<size>[KMG]:<policy>
>>>>>>
>>>>>> For example,
>>>>>>
>>>>>> thp_shmem=16K-64K:always;128K,512K:inherit;256K:advise;1M-2M:never;4M-8M:within_size
>>>>>>
>>>>>> By configuring the default policy of several shmem huge pages, the user
>>>>>> can take advantage of mTHP before it's been configured through sysfs.
>>>>>>
>>>>>> Signed-off-by: Maíra Canal <mcanal@igalia.com>
>>>>>> ---
>>>>>>     .../admin-guide/kernel-parameters.txt         |  10 ++
>>>>>>     Documentation/admin-guide/mm/transhuge.rst    |  17 +++
>>>>>>     mm/shmem.c                                    | 109 +++++++++++++++++-
>>>>>>     3 files changed, 135 insertions(+), 1 deletion(-)
>>>>>>
>>>>>
>>>>> Hi Maíra,
>>>>>
>>>>>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>>>>>> index acabb04d0dd4..595fa096e28b 100644
>>>>>> --- a/Documentation/admin-guide/kernel-parameters.txt
>>>>>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>>>>>> @@ -6700,6 +6700,16 @@
>>>>>>                            Force threading of all interrupt handlers except those
>>>>>>                            marked explicitly IRQF_NO_THREAD.
>>>>>>
>>>>>> +       shmem_anon=     [KNL]
>>>>>> +                       Format: <size>[KMG],<size>[KMG]:<policy>;<size>[KMG]-<size>[KMG]:<policy>
>>>>>> +                       Control the default policy of each hugepage size for the
>>>>>> +                       internal shmem mount. <policy> is one of policies available
>>>>>> +                       for the shmem mount ("always", "inherit", "never", "within_size",
>>>>>> +                       and "advise").
>>>>>> +                       It can be used multiple times for multiple shmem THP sizes.
>>>>>> +                       See Documentation/admin-guide/mm/transhuge.rst for more
>>>>>> +                       details.
>>>>>
>>>>> I'm not sure this is the right name. How about "thp_shmem"?
>>>>
>>>> Oops, sorry about that.
>>>>
>>>>>
>>>>>> +
>>>>>>            topology=       [S390,EARLY]
>>>>>>                            Format: {off | on}
>>>>>>                            Specify if the kernel should make use of the cpu
>>>>>> diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
>>>>>> index 9b5b02c4d1ab..47e7fc30e22d 100644
>>>>>> --- a/Documentation/admin-guide/mm/transhuge.rst
>>>>>> +++ b/Documentation/admin-guide/mm/transhuge.rst
>>>>>> @@ -332,6 +332,23 @@ allocation policy for the internal shmem mount by using the kernel parameter
>>>>>>     seven valid policies for shmem (``always``, ``within_size``, ``advise``,
>>>>>>     ``never``, ``deny``, and ``force``).
>>>>>>
>>>>>> +In the same manner as ``thp_anon`` controls each supported anonymous THP
>>>>>> +size, ``thp_shmem`` controls each supported shmem THP size. ``thp_shmem``
>>>>>> +has the same format as ``thp_anon``, but also supports the policy
>>>>>> +``within_size``.
>>>>>> +
>>>>>> +``thp_shmem=`` may be specified multiple times to configure all THP sizes
>>>>>> +as required. If ``thp_shmem=`` is specified at least once, any shmem THP
>>>>>> +sizes not explicitly configured on the command line are implicitly set to
>>>>>> +``never``.
>>>>>> +
>>>>>> +``transparent_hugepage_shmem`` setting only affects the global toggle. If
>>>>>> +``thp_shmem`` is not specified, PMD_ORDER hugepage will default to
>>>>>> +``inherit``. However, if a valid ``thp_shmem`` setting is provided by the
>>>>>> +user, the PMD_ORDER hugepage policy will be overridden. If the policy for
>>>>>> +PMD_ORDER is not defined within a valid ``thp_shmem``, its policy will
>>>>>> +default to ``never``.
>>>>>> +
>>>>>>     Hugepages in tmpfs/shmem
>>>>>>     ========================
>>>>>>
>>>>>> diff --git a/mm/shmem.c b/mm/shmem.c
>>>>>> index 24cdeafd8260..0a7a7d04f725 100644
>>>>>> --- a/mm/shmem.c
>>>>>> +++ b/mm/shmem.c
>>
>> [...]
>>
>>>>>>     static int __init setup_transparent_hugepage_shmem(char *str)
>>>>>>     {
>>>>>>            int huge, ret = 0;
>>>>>> @@ -5206,6 +5228,91 @@ static int __init setup_transparent_hugepage_shmem(char *str)
>>>>>>     }
>>>>>>     __setup("transparent_hugepage_shmem=", setup_transparent_hugepage_shmem);
>>>>>>
>>>>>> +static char str_dup[PAGE_SIZE] __initdata;
>>>>>> +static int __init setup_thp_shmem(char *str)
>>>>>> +{
>>>>>> +       char *token, *range, *policy, *subtoken;
>>>>>> +       unsigned long always, inherit, madvise, within_size;
>>>>>> +       char *start_size, *end_size;
>>>>>> +       int start, end, nr;
>>>>>> +       char *p;
>>>>>> +
>>>>>> +       if (!str || strlen(str) + 1 > PAGE_SIZE)
>>>>>> +               goto err;
>>>>>> +       strcpy(str_dup, str);
>>>>>> +
>>>>>> +       always = huge_shmem_orders_always;
>>>>>> +       inherit = huge_shmem_orders_inherit;
>>>>>> +       madvise = huge_shmem_orders_madvise;
>>>>>> +       within_size = huge_shmem_orders_within_size;
>>>>>> +       p = str_dup;
>>>>>> +       while ((token = strsep(&p, ";")) != NULL) {
>>>>>> +               range = strsep(&token, ":");
>>>>>> +               policy = token;
>>>>>> +
>>>>>> +               if (!policy)
>>>>>> +                       goto err;
>>>>>> +
>>>>>> +               while ((subtoken = strsep(&range, ",")) != NULL) {
>>>>>> +                       if (strchr(subtoken, '-')) {
>>>>>> +                               start_size = strsep(&subtoken, "-");
>>>>>> +                               end_size = subtoken;
>>>>>> +
>>>>>> +                               start = get_order_from_str(start_size);
>>>>>> +                               end = get_order_from_str(end_size);
>>>>>> +                       } else {
>>>>>> +                               start = end = get_order_from_str(subtoken);
>>>>>> +                       }
>>>>>> +
>>>>>> +                       if (start < 0 || end < 0 || start > end)
>>>>>> +                               goto err;
>>>>>> +
>>>>>> +                       nr = end - start + 1;
>>>>>> +                       if (!strcmp(policy, "always")) {
>>>>>> +                               bitmap_set(&always, start, nr);
>>>>>> +                               bitmap_clear(&inherit, start, nr);
>>>>>> +                               bitmap_clear(&madvise, start, nr);
>>>>>> +                               bitmap_clear(&within_size, start, nr);
>>>>>> +                       } else if (!strcmp(policy, "advise")) {
>>>>>> +                               bitmap_set(&madvise, start, nr);
>>>>>> +                               bitmap_clear(&inherit, start, nr);
>>>>>> +                               bitmap_clear(&always, start, nr);
>>>>>> +                               bitmap_clear(&within_size, start, nr);
>>>>>> +                       } else if (!strcmp(policy, "inherit")) {
>>>>>> +                               bitmap_set(&inherit, start, nr);
>>>>>> +                               bitmap_clear(&madvise, start, nr);
>>>>>> +                               bitmap_clear(&always, start, nr);
>>>>>> +                               bitmap_clear(&within_size, start, nr);
>>>>>> +                       } else if (!strcmp(policy, "within_size")) {
>>>>>> +                               bitmap_set(&within_size, start, nr);
>>>>>> +                               bitmap_clear(&inherit, start, nr);
>>>>>> +                               bitmap_clear(&madvise, start, nr);
>>>>>> +                               bitmap_clear(&always, start, nr);
>>>>>> +                       } else if (!strcmp(policy, "never")) {
>>>>>> +                               bitmap_clear(&inherit, start, nr);
>>>>>> +                               bitmap_clear(&madvise, start, nr);
>>>>>> +                               bitmap_clear(&always, start, nr);
>>>>>> +                               bitmap_clear(&within_size, start, nr);
>>>>>> +                       } else {
>>>>>> +                               pr_err("invalid policy %s in thp_shmem boot parameter\n", policy);
>>>>>> +                               goto err;
>>>>>> +                       }
>>>>>> +               }
>>>>>> +       }
>>>>>> +
>>>>>> +       huge_shmem_orders_always = always;
>>>>>> +       huge_shmem_orders_madvise = madvise;
>>>>>> +       huge_shmem_orders_inherit = inherit;
>>>>>> +       huge_shmem_orders_within_size = within_size;
>>>>>> +       shmem_orders_configured = true;
>>>>>> +       return 1;
>>>>>> +
>>>>>> +err:
>>>>>> +       pr_warn("thp_shmem=%s: error parsing string, ignoring setting\n", str);
>>>>>> +       return 0;
>>>>>> +}
>>>>>
>>>>> Can we share source code with thp_anon since there's a lot of duplication?
>>>>
>>>> I'm not a regular mm contributor and I'm most usually around drivers, so
>>>> I don't know exactly here I could add shared code. Should I add the
>>>> headers to "internal.h"?
>>>
>>> My comment isn't related to drivers or memory management. It's solely about
>>> avoiding code duplication. For example, we could create a shared function to
>>> handle both controls, reducing redundant code :-)
>>
>> Let me rephrase it.
>>
>> I completely agree that we should avoid code duplication. I'm asking
>> where is the best place to add the headers of the shared functions.
>> "linux/shmem_fs.h" doesn't look appropriate to me, so I believe the
>> remaining options would be "linux/huge_mm.h" or "internal.h".
> 
> Both locations seem quite odd. I have a feeling that these boot command
> elements are purely internal, yet internal.h contains something that is
> actually 'external' to mm. The shared code isn't 'external' enough to belong
> in internal.h.
> 
> I didn't realize that shmem has placed these controls in its own file;
> I thought they
> were also located in mm/huge_memory.c. Given the current situation, I would
> prefer to keep the code as it is and tolerate the code duplication.
> 
> Unless we are going to place controls for shmem and other thp controls in
> one place, I feel your code is better than having a shared function either in
> internal.h or linux/huge_mm.h.

Sorry, I only catch your e-mail after sending v2. If possible, please,
take a look on v2 [1] and let me know if you still prefer to duplicate
the code.

[1] 
https://lore.kernel.org/linux-mm/20241029002324.1062723-1-mcanal@igalia.com/T/

Best Regards,
- Maíra

> 
>>
>> I would like to know your opinion about those two options.
>>
>> Best Regards,
>> - Maíra
>>
>>>
>>>>
>>>> Best Regards,
>>>> - Maíra
>>>>
>>>>>
>>>>>> +__setup("thp_shmem=", setup_thp_shmem);
>>>>>> +
>>>>>>     #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
>>>>>>
>>>>>>     #else /* !CONFIG_SHMEM */
>>>>>> --
>>>>>> 2.46.2
>>>>>>
>>>>>
> 
> Thanks
> barry


