Return-Path: <linux-kernel+bounces-312088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A03989691CD
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 05:23:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 564CA1F237B9
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 03:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFEAD1CDFA4;
	Tue,  3 Sep 2024 03:22:57 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167C41A4E6B
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 03:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725333777; cv=none; b=BxS5Or5CXwVpNIDZNnYKTAXCuGbZBq3I3Zl2yRSMBFTq3Dr4SPgQC6HbFYYmiXqITg/z50DSVzh9kvliKZFVwyFgcf8S3/e90mf27oYDYfqD+4lBDEx5MR8bM+usK0iHLvT3CeLfxfFK01SUwoZR1mabtGDFGyrkhiPTcC2Z5RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725333777; c=relaxed/simple;
	bh=UNFiPx1a8ps39k17drwmAYk8T7SbMM8+ejVqOvUINYk=;
	h=Subject:From:To:References:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=pzXZhWLFyoWQRqr7njm1ctarPL1wQaX5gG7ru+KCQSCy9bF+IG7sRE+XdTDs+pnmJMQHFS5A+qJFt2k8Ctp9c4+42bkzoIZoKN7L/qgRx+2NZrI4WRZIWgiHuxpWjPMGwHQ5f2ToN3WFosOCeo5GsUK53rAR1sy1BcOo0bKXc2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WyWBw0Qx0zyRQ5;
	Tue,  3 Sep 2024 11:22:16 +0800 (CST)
Received: from dggpemf100006.china.huawei.com (unknown [7.185.36.228])
	by mail.maildlp.com (Postfix) with ESMTPS id AB08C140258;
	Tue,  3 Sep 2024 11:22:52 +0800 (CST)
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemf100006.china.huawei.com (7.185.36.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 3 Sep 2024 11:22:52 +0800
Subject: Re: [PATCH 1/5] debugobjects: Fix the misuse of global variables in
 fill_pool()
From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
To: Thomas Gleixner <tglx@linutronix.de>, Andrew Morton
	<akpm@linux-foundation.org>, <linux-kernel@vger.kernel.org>
References: <20240902140532.2028-1-thunder.leizhen@huawei.com>
 <20240902140532.2028-2-thunder.leizhen@huawei.com> <87mskq58l5.ffs@tglx>
 <13d2be50-4a52-7cf0-8325-65435ad47a62@huawei.com>
Message-ID: <3bb35c94-dd54-33d4-b7ac-64f0d2b77c07@huawei.com>
Date: Tue, 3 Sep 2024 11:22:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <13d2be50-4a52-7cf0-8325-65435ad47a62@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemf100006.china.huawei.com (7.185.36.228)



On 2024/9/3 10:16, Leizhen (ThunderTown) wrote:
> 
> 
> On 2024/9/3 0:22, Thomas Gleixner wrote:
>> On Mon, Sep 02 2024 at 22:05, Zhen Lei wrote:
>>
>>> The global variable 'obj_pool_min_free' records the lowest historical
>>> value of the number of nodes in the global list 'obj_pool', instead of
>>> being used as the lowest threshold value. This may be a mistake and
>>
>> Maybe? It's either a bug or not.
> 
> Yes, it's a bug, but I'm just learning this module, so I'm not confident.
> 
>>
>>> should be replaced with variable 'debug_objects_pool_min_level'.
>>
>> And if it's a bug then it has to be replaced.
> 
> OK, I will update the commit message in V2.
> 
>>
>> This misses another minor issue:
>>
>> static int			obj_pool_min_free = ODEBUG_POOL_SIZE;
>>
>> static int  __data_racy		debug_objects_pool_min_level __read_mostly
>> 				= ODEBUG_POOL_MIN_LEVEL;
>>
>> As debug_objects_pool_min_level is the minimum level to keep around and
>> obj_pool_min_free is a statistics mechanism, __data_racy is misplaced
>> too. The variables should swap their position, because
>> debug_objects_pool_min_level is functional, but obj_pool_min_free is
>> pure stats.

This principle covers a large number of variables. It should be sorted
by the variable name before. It's better not to change the position this time.

>>
>> Also debug_objects_pool_min_level and debug_objects_pool_size should
>> be __ro_after_init.
> 
> OK, How about modifying it like this? I further removed the __data_racy from
> debug_objects_pool_min_level and debug_objects_pool_size, because __ro_after_init.
> 
> 
> diff --git a/lib/debugobjects.c b/lib/debugobjects.c
> index d3845705db955fa..816d3d968cd9f14 100644
> --- a/lib/debugobjects.c
> +++ b/lib/debugobjects.c
> @@ -70,7 +70,8 @@ static HLIST_HEAD(obj_to_free);
>   * made at debug_stats_show(). Both obj_pool_min_free and obj_pool_max_used
>   * can be off.
>   */
> -static int                     obj_pool_min_free = ODEBUG_POOL_SIZE;
> +static int __ro_after_init     debug_objects_pool_size = ODEBUG_POOL_SIZE;
> +static int __ro_after_init     debug_objects_pool_min_level = ODEBUG_POOL_MIN_LEVEL;
>  static int                     obj_pool_free = ODEBUG_POOL_SIZE;
>  static int                     obj_pool_used;
>  static int                     obj_pool_max_used;
> @@ -84,10 +85,7 @@ static int __data_racy                       debug_objects_fixups __read_mostly;
>  static int __data_racy                 debug_objects_warnings __read_mostly;
>  static int __data_racy                 debug_objects_enabled __read_mostly
>                                         = CONFIG_DEBUG_OBJECTS_ENABLE_DEFAULT;
> -static int __data_racy                 debug_objects_pool_size __read_mostly
> -                                       = ODEBUG_POOL_SIZE;
> -static int __data_racy                 debug_objects_pool_min_level __read_mostly
> -                                       = ODEBUG_POOL_MIN_LEVEL;
> +static int __data_racy                 obj_pool_min_free = ODEBUG_POOL_SIZE;
> 
>  static const struct debug_obj_descr *descr_test  __read_mostly;
>  static struct kmem_cache       *obj_cache __ro_after_init;
> 
> 
>>
>>> Fixes: d26bf5056fc0 ("debugobjects: Reduce number of pool_lock acquisitions in fill_pool()")
>>> Fixes: 36c4ead6f6df ("debugobjects: Add global free list and the counter")
>>
>> Nice detective work!
>>
>> Thanks,
>>
>>         tglx
>> .
>>
> 

-- 
Regards,
  Zhen Lei

