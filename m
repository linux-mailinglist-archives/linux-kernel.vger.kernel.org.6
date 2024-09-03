Return-Path: <linux-kernel+bounces-312900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EE5A969D66
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 14:22:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B9E6284F8E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 12:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 318D81C9856;
	Tue,  3 Sep 2024 12:22:24 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833651A0BD6
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 12:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725366143; cv=none; b=q5I7Kgye2uR6nofUrw8u+M5XYtTuBQ/EPAkAdohhGhFSiRp4MBcGpjyzOhLrAZALbj05HMoVYrL33Ac/02GBUXJd851szGqEKIKi2gFAI6ZliM9lSNSEcSmJMAViJc78CKe+YPL34RyPAhD17tuXdRLDI39kOWbU9mRIRF0l9l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725366143; c=relaxed/simple;
	bh=D1QZLqf/ULyBTYN540ylQlZwL9I4r/S1/yvyea/Kpxs=;
	h=Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=MvDIufhA/ET1NJaCsCPOngHrwzs+wBA1ELtsQd2TNnDsnHZsOks6qdwpZdNvZflrBfsuPNsOqQ272vpaziT5TLM+GeKLctZ39qKb4NftCN8rH+/ilhgUm6tnIpBxiOVImsYt/DUlf5G6FSO10nGjRcWzou+QYmOKPHMcWTyXDY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Wyl4K648Bz20nMZ;
	Tue,  3 Sep 2024 20:17:21 +0800 (CST)
Received: from dggpemf100006.china.huawei.com (unknown [7.185.36.228])
	by mail.maildlp.com (Postfix) with ESMTPS id E14971400D7;
	Tue,  3 Sep 2024 20:22:17 +0800 (CST)
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemf100006.china.huawei.com (7.185.36.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 3 Sep 2024 20:22:17 +0800
Subject: Re: [PATCH 1/5] debugobjects: Fix the misuse of global variables in
 fill_pool()
To: Thomas Gleixner <tglx@linutronix.de>, Andrew Morton
	<akpm@linux-foundation.org>, <linux-kernel@vger.kernel.org>
References: <20240902140532.2028-1-thunder.leizhen@huawei.com>
 <20240902140532.2028-2-thunder.leizhen@huawei.com> <87mskq58l5.ffs@tglx>
 <13d2be50-4a52-7cf0-8325-65435ad47a62@huawei.com>
 <3bb35c94-dd54-33d4-b7ac-64f0d2b77c07@huawei.com>
 <659f0321-e567-ad48-4545-4a47a158d6c2@huawei.com> <87seuh84cx.ffs@tglx>
 <5cf23898-892c-c0a6-2525-206e21732665@huawei.com> <87a5gp7ykb.ffs@tglx>
From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <3ae3de70-0999-bf76-3da5-b1ef9d6a015a@huawei.com>
Date: Tue, 3 Sep 2024 20:22:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <87a5gp7ykb.ffs@tglx>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemf100006.china.huawei.com (7.185.36.228)



On 2024/9/3 19:43, Thomas Gleixner wrote:
> On Tue, Sep 03 2024 at 19:14, Leizhen wrote:
>> On 2024/9/3 17:37, Thomas Gleixner wrote:
>>> On Tue, Sep 03 2024 at 15:00, Leizhen wrote:
>>>>>> @@ -84,10 +85,7 @@ static int __data_racy                       debug_objects_fixups __read_mostly;
>>>>>>  static int __data_racy                 debug_objects_warnings __read_mostly;
>>>>>>  static int __data_racy                 debug_objects_enabled __read_mostly
>>>>>>                                         = CONFIG_DEBUG_OBJECTS_ENABLE_DEFAULT;
>>>>>> -static int __data_racy                 debug_objects_pool_size __read_mostly
>>>>>> -                                       = ODEBUG_POOL_SIZE;
>>>>>> -static int __data_racy                 debug_objects_pool_min_level __read_mostly
>>>>>> -                                       = ODEBUG_POOL_MIN_LEVEL;
>>>>>> +static int __data_racy                 obj_pool_min_free = ODEBUG_POOL_SIZE;
>>>>
>>>> Sorry, I rechecked it again. After this patch, obj_pool_min_free is referenced in the
>>>> same way as obj_pool_max_used. The only race point is located in debug_stats_show().
>>>> However, this reference point does not need to be included in the race analysis. So
>>>> there is no need to add __data_racy for obj_pool_min_free.
>>>
>>> The read races against the write, so KCSAN can detect it and complain, no?
>>
>> Oh, I just saw that there were a lot of other global variables in that function
>> that didn't mask KCSAN's detection. So I'll recheck each global variable.
>> However, for obj_pool_min_free, it seems that it would be better to just add
>> READ_ONCE() in debug_stats_show(). This does not prevent the compiler from
>> optimizing variable references in the lock.
>>
>> # define __data_racy volatile
> 
> This is only when KCSAN is enabled. Otherwise it's empty.
> 
> And if you do a READ_ONCE() then you need a corresponding WRITE_ONCE()
> to make sense. __data_racy is much simpler for that.

OK, I will use __data_racy, thanks

> 
> Thanks,
> 
>         tglx
> .
> 

-- 
Regards,
  Zhen Lei

