Return-Path: <linux-kernel+bounces-312788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC40B969B51
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 13:14:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 673292848CB
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 11:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 649C01A42AA;
	Tue,  3 Sep 2024 11:14:49 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E1019CC18
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 11:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725362089; cv=none; b=jeHFyGacfUYSVLhqsC7zTK3/GwyPDnk4aIFyv5E3XddHKDfXGSKXVARMSoCfnyCwSHxMvwVrToE4UqdK2ZBqr4igBtTIpitbu2eTTqghtJpO9kS1z3QqZXQY/5XgeLUuujjzireOuV5BDOqvGPdoTb30SBccSLExZorbNAKl4FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725362089; c=relaxed/simple;
	bh=z86ppRzEkuj++hIAcKacgb5TF5cmI03Zq5c/obmeJGI=;
	h=Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=IdA8UKQraN1RiV7WGwiK1sFJWC3SzSXk03W4qxXDeMzOLxxCFZNq3S/3LbD7BFMT1W21XZnEpZXkSAE1s/H9ivfQ1DcWUNdxmOmyAc5Cj/djvcT+FaeUwE4ubKTovaPkSDP6jo3ZUcTYVkoVhy282UZOZrldr2jD1rPzGdKo+4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Wyjdw3RDMzpVNl;
	Tue,  3 Sep 2024 19:12:52 +0800 (CST)
Received: from dggpemf100006.china.huawei.com (unknown [7.185.36.228])
	by mail.maildlp.com (Postfix) with ESMTPS id A1A431400CA;
	Tue,  3 Sep 2024 19:14:43 +0800 (CST)
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemf100006.china.huawei.com (7.185.36.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 3 Sep 2024 19:14:43 +0800
Subject: Re: [PATCH 1/5] debugobjects: Fix the misuse of global variables in
 fill_pool()
To: Thomas Gleixner <tglx@linutronix.de>, Andrew Morton
	<akpm@linux-foundation.org>, <linux-kernel@vger.kernel.org>
References: <20240902140532.2028-1-thunder.leizhen@huawei.com>
 <20240902140532.2028-2-thunder.leizhen@huawei.com> <87mskq58l5.ffs@tglx>
 <13d2be50-4a52-7cf0-8325-65435ad47a62@huawei.com>
 <3bb35c94-dd54-33d4-b7ac-64f0d2b77c07@huawei.com>
 <659f0321-e567-ad48-4545-4a47a158d6c2@huawei.com> <87seuh84cx.ffs@tglx>
From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <5cf23898-892c-c0a6-2525-206e21732665@huawei.com>
Date: Tue, 3 Sep 2024 19:14:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <87seuh84cx.ffs@tglx>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemf100006.china.huawei.com (7.185.36.228)



On 2024/9/3 17:37, Thomas Gleixner wrote:
> On Tue, Sep 03 2024 at 15:00, Leizhen wrote:
>>>> @@ -84,10 +85,7 @@ static int __data_racy                       debug_objects_fixups __read_mostly;
>>>>  static int __data_racy                 debug_objects_warnings __read_mostly;
>>>>  static int __data_racy                 debug_objects_enabled __read_mostly
>>>>                                         = CONFIG_DEBUG_OBJECTS_ENABLE_DEFAULT;
>>>> -static int __data_racy                 debug_objects_pool_size __read_mostly
>>>> -                                       = ODEBUG_POOL_SIZE;
>>>> -static int __data_racy                 debug_objects_pool_min_level __read_mostly
>>>> -                                       = ODEBUG_POOL_MIN_LEVEL;
>>>> +static int __data_racy                 obj_pool_min_free = ODEBUG_POOL_SIZE;
>>
>> Sorry, I rechecked it again. After this patch, obj_pool_min_free is referenced in the
>> same way as obj_pool_max_used. The only race point is located in debug_stats_show().
>> However, this reference point does not need to be included in the race analysis. So
>> there is no need to add __data_racy for obj_pool_min_free.
> 
> The read races against the write, so KCSAN can detect it and complain, no?

Oh, I just saw that there were a lot of other global variables in that function
that didn't mask KCSAN's detection. So I'll recheck each global variable.
However, for obj_pool_min_free, it seems that it would be better to just add
READ_ONCE() in debug_stats_show(). This does not prevent the compiler from
optimizing variable references in the lock.

# define __data_racy volatile

> 
> Thanks,
> 
>         tglx
> .
> 

-- 
Regards,
  Zhen Lei

