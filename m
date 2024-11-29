Return-Path: <linux-kernel+bounces-425365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C5869DC10F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 10:07:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0BBB281FCA
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 09:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D23016B75C;
	Fri, 29 Nov 2024 09:07:24 +0000 (UTC)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2A4143C40
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 09:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732871243; cv=none; b=a4Ptas+UukKExDLPiq3hLxxsZILbLftkMa2XJprAJw5mnRfpLkoW85JzQTyWMHG+wnzAhL1Azh9SNPwbOvK5HXUZiHY6jHvaC1gy/jon/LYeaeidaxmmlP+RkuslGHKu2k5sP27Mj6/PdBPkmfrrvAaq8ywZJnneK505a8371CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732871243; c=relaxed/simple;
	bh=XYQfHvqX9F3V3jPH4pKQJlRoOPMlLf9YqrS9mD82um0=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=iQS8DKaahQm3/f2etuqYEbKHa56KPDMMwQTuH4BwTjGuc10bkomx06fybQUroiqtdW8WJI+KnMTrchitqkbNLasSVi9hSP4qMpHgAm9aD9tGg6q9ICl+ZZaFX9QFhMfS7bJXyWPIqH7ImlJ5ltMvXrf4+pVPbCX/Rs8Pwu5u6TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Y06hD5Mmqz1T5r2;
	Fri, 29 Nov 2024 17:05:00 +0800 (CST)
Received: from kwepemd200019.china.huawei.com (unknown [7.221.188.193])
	by mail.maildlp.com (Postfix) with ESMTPS id B399B1A016C;
	Fri, 29 Nov 2024 17:07:11 +0800 (CST)
Received: from [10.173.127.72] (10.173.127.72) by
 kwepemd200019.china.huawei.com (7.221.188.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 29 Nov 2024 17:07:10 +0800
Subject: Re: [RFC PATCH] mm: memory-failure: add soft-offline stat in mf_stats
To: "Tomohiro Misono (Fujitsu)" <misono.tomohiro@fujitsu.com>, 'Jiaqi Yan'
	<jiaqiyan@google.com>
CC: "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>
References: <20241121045504.2233544-1-misono.tomohiro@fujitsu.com>
 <c25e8ca8-5858-987e-6b1e-2e139d901dc5@huawei.com>
 <TYCPR01MB961779970E6BFA06BD4BF46EE5282@TYCPR01MB9617.jpnprd01.prod.outlook.com>
 <CACw3F51TiRZJMkze-u3a3E_3w65=PMhEUBaBQLUgNwRNuY6+3w@mail.gmail.com>
 <TYCPR01MB961770DF6F58C0D8A16185F7E5292@TYCPR01MB9617.jpnprd01.prod.outlook.com>
 <098640ac-f1c1-95b6-e367-a2673c3ceaae@huawei.com>
 <TYCPR01MB9617A2CC29E34D10B6B85ACFE52A2@TYCPR01MB9617.jpnprd01.prod.outlook.com>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <cc401793-5ef6-55db-0028-728b865e33e0@huawei.com>
Date: Fri, 29 Nov 2024 17:07:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <TYCPR01MB9617A2CC29E34D10B6B85ACFE52A2@TYCPR01MB9617.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemd200019.china.huawei.com (7.221.188.193)

On 2024/11/29 16:26, Tomohiro Misono (Fujitsu) wrote:
>> On 2024/11/28 13:46, Tomohiro Misono (Fujitsu) wrote:
>>>>>> On 2024/11/21 12:55, Tomohiro Misono wrote:
>>>>>>> commit 44b8f8bf2438 ("mm: memory-failure: add memory failure stats
>>>>>>
>>>>>> Sorry for late, I've been swamped recently.
>>>>>
>>>>> Hi,
>>>>> Thanks for your comments.
>>>>>
>>>>>>
>>>>>>> to sysfs") introduces per NUMA memory error stats which show
>>>>>>> breakdown of HardwareCorrupted of /proc/meminfo in
>>>>>>> /sys/devices/system/node/nodeX/memory_failure.
>>>>>>
>>>>>> Thanks for your patch.
>>>>>>
>>>>>>>
>>>>>>> However, HardwareCorrupted also counts soft-offline pages. So, add
>>>>>>> soft-offline stats in mf_stats too to represent more accurate status.
>>>>>>
>>>>>> Adding soft-offline stats makes sense to me.
>>>>>
>>>>> Thanks for confirming.
>>>>
>>>> Agreed with Miaohe.
>>>>
>>>>>
>>>>>>
>>>>>>>
>>>>>>> This updates total count as:
>>>>>>>   total = recovered + ignored + failed + delayed + soft_offline>
>>>>>>> Test example:
>>>>>>> 1) # grep HardwareCorrupted /proc/meminfo
>>>>>>>      HardwareCorrupted:     0 kB
>>>>>>> 2) soft-offline 1 page by madvise(MADV_SOFT_OFFLINE)
>>>>>>> 3) # grep HardwareCorrupted /proc/meminfo
>>>>>>>      HardwareCorrupted:     4 kB
>>>>>>>    # grep -r "" /sys/devices/system/node/node0/memory_failure
>>>>>>>    /sys/devices/system/node/node0/memory_failure/total:1
>>>>>>>    /sys/devices/system/node/node0/memory_failure/soft_offline:1
>>>>>>>    /sys/devices/system/node/node0/memory_failure/recovered:0
>>>>>>>    /sys/devices/system/node/node0/memory_failure/ignored:0
>>>>>>>    /sys/devices/system/node/node0/memory_failure/failed:0
>>>>>>>    /sys/devices/system/node/node0/memory_failure/delayed:0
>>>>>>>
>>>>>>> Signed-off-by: Tomohiro Misono <misono.tomohiro@fujitsu.com>
>>>>>>> ---
>>>>>>> Hello
>>>>>>>
>>>>>>> This is RFC because I'm not sure adding SOFT_OFFLINE in enum
>>>>>>> mf_result is a right approach. Also, maybe is it better to move
>>>>>>> update_per_node_mf_stats() into num_poisoned_pages_inc()?
>>>>>>>
>>>>>>> I omitted some cleanups and sysfs doc update in this version to
>>>>>>> highlight changes. I'd appreciate any suggestions.
>>>>>>>
>>>>>>> Regards,
>>>>>>> Tomohiro Misono
>>>>>>>
>>>>>>>  include/linux/mm.h     | 2 ++
>>>>>>>  include/linux/mmzone.h | 4 +++-
>>>>>>>  mm/memory-failure.c    | 9 +++++++++
>>>>>>>  3 files changed, 14 insertions(+), 1 deletion(-)
>>>>>>>
>>>>>>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>>>>>>> index 5d6cd523c7c0..7f93f6883760 100644
>>>>>>> --- a/include/linux/mm.h
>>>>>>> +++ b/include/linux/mm.h
>>>>>>> @@ -3991,6 +3991,8 @@ enum mf_result {
>>>>>>>     MF_FAILED,      /* Error: handling failed */
>>>>>>>     MF_DELAYED,     /* Will be handled later */
>>>>>>>     MF_RECOVERED,   /* Successfully recovered */
>>>>>>> +
>>>>>>> +   MF_RES_SOFT_OFFLINE, /* Soft-offline */
>>>>>>
>>>>>> It might not be a good idea to add MF_RES_SOFT_OFFLINE here. 'mf_result' is used to record
>>>>>> the result of memory failure handler. So it might be inappropriate to add MF_RES_SOFT_OFFLINE
>> here.
>>>>>
>>>>> Understood. As I don't see other suitable place to put ENUM value, how about changing like below?
>>>>> Or, do you prefer adding another ENUM type instead of this?
>>>>
>>>> I think SOFT_OFFLINE-ed is one of the results of successfully
>>>> recovered, and the other one is HARD_OFFLINE-ed. So how about make a
>>>> separate sub-ENUM for MF_RECOVERED? Something like:
>>>
>>> Thanks for the suggestion.
>>>
>>>>
>>>> enum mf_recovered_result {
>>>>   MF_RECOVERED_SOFT_OFFLINE,
>>>>   MF_RECOVERED_HARD_OFFLINE,
>>>> };
>>>
>>> Ok.
>>>
>>>>
>>>> And
>>>> 1. total = recovered + ignored + failed + delayed
>>>> 2. recovered = soft_offline + hard_offline
>>>
>>> Do you mean mf_stats now have 7 entries in sysfs?
>>> (total, ignored, failed, delayed, recovered, hard_offline, soft_offline, then recovered = hard_offline +
>> soft_offline)
>>> Or 6 entries ? (in that case, hard_offline = recovered - soft_offline)
>>> It might be simpler to understand for user if total is just the sum of other entries like this RFC,
>>> but I'd like to know other opinions.
>>
>> Will it be better to have below items?
>> "
>> total
>> ignored
>> failed
>> dalayed
>> hard_offline
>> soft_offline
>> "
>>
>> though this will break the previous interface.
>> Any thoughts?
> 
> That would be great, but these files are under stable ABI and 
> I don't think we can change them, right?
> 
> https://docs.kernel.org/admin-guide/abi-stable.html
> Userspace programs are free to use these interfaces with no restrictions, and backward
> compatibility for them will be guaranteed for at least 2 years.
> Most interfaces (like syscalls) are expected to never change and always be available.

Thanks for your information. So we need to propose a better solution. Looking forward to hearing more suggestions.

Thanks.
.

> 
> Regards,
> Tomohiro Misono
> 


