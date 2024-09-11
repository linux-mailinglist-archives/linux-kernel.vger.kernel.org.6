Return-Path: <linux-kernel+bounces-324079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A79A9747B6
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 03:21:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AF0E1F271B3
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 01:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84D7118EB0;
	Wed, 11 Sep 2024 01:21:30 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD56210F1
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 01:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726017690; cv=none; b=WiSJFMCXL4u5f+jMYimI86a84c83yF4hHDWBoUmJNKAnuDVrh+O0QdoLv0LC0nIFhYfm40UbaBVKsfqQgXiUWjfpOmIwxKl8bnGEDWLh3dsTxvQseoQ/t9GCXUsD+6YYLibYb9YIYxps8aB2NwtrZNWxfLxfJb9yv7JO25uCSDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726017690; c=relaxed/simple;
	bh=2ptKXj98s3AyyUEKQQAGiup8IlooiiTOEZfb8MOfFmg=;
	h=Subject:From:To:References:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=dSZ4zJYdDDH7ogEbhrl8InID57t07b3TALF/2UqUFfKD9OSM8p9QTAFA3aa9fateWbaUQTaUXgVJchTR3L8G8rWm5YpPOjlMaGO6tQdQzSB1039XkYA8ugGF6BLopVPA6nrXGsh8EhNjcU25XGNAq9M/5lYRZ84VxweuDkzesF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4X3N6w0QdrzyRfj;
	Wed, 11 Sep 2024 09:20:40 +0800 (CST)
Received: from dggpemf100006.china.huawei.com (unknown [7.185.36.228])
	by mail.maildlp.com (Postfix) with ESMTPS id 5DA421400E3;
	Wed, 11 Sep 2024 09:21:25 +0800 (CST)
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemf100006.china.huawei.com (7.185.36.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 11 Sep 2024 09:21:24 +0800
Subject: Re: [PATCH v2 4/6] debugobjects: Don't start fill if there are
 remaining nodes locally
From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
To: Thomas Gleixner <tglx@linutronix.de>, Andrew Morton
	<akpm@linux-foundation.org>, <linux-kernel@vger.kernel.org>
References: <20240904133944.2124-1-thunder.leizhen@huawei.com>
 <20240904133944.2124-5-thunder.leizhen@huawei.com>
 <336109d9-2eea-4d67-ee22-ed218b9504c3@huawei.com>
 <7613ce35-0c65-341f-c6ed-412de79890e6@huawei.com> <87ed5tchc6.ffs@tglx>
 <87bk0xc9iy.ffs@tglx> <32bd93ec-747f-b5a1-917f-f885b87600a5@huawei.com>
 <8bc3ebed-f092-6842-bd8b-a8b4b1b30cf1@huawei.com>
Message-ID: <263b875c-7485-1331-fec5-ff492a295d62@huawei.com>
Date: Wed, 11 Sep 2024 09:21:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <8bc3ebed-f092-6842-bd8b-a8b4b1b30cf1@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemf100006.china.huawei.com (7.185.36.228)



On 2024/9/10 23:29, Leizhen (ThunderTown) wrote:
> 
> 
> On 2024/9/9 21:51, Leizhen (ThunderTown) wrote:
>> +static void fill_pool(void)
>> +{
>> +	gfp_t gfp = __GFP_HIGH | __GFP_NOWARN;
>> +	static atomic_t cpus_allocating;
>>  
>>  	if (unlikely(!obj_cache))
>>  		return;
>>  
>> +	/*
>> +	 * Avoid allocation and lock contention when
>> +	 *
>> +	 *   - the CPU local pool has at least 2 objects left
>> +	 *   - another CPU is already in the allocation path
>> +	 *   - the global pool has not reached the critical level yet
>> +	 */
>> +	if (this_cpu_read(percpu_obj_pool.obj_free) > 1 && atomic_read(&cpus_allocating) &&
> 
> I rethink that 'cpus_allocating' and 'percpu_obj_pool.obj_free > 1' should be
> contradictory. We can only choose one of them. If 'cpus_allocating' can work,
> there's no need for another. Since I had no way to prove that 'cpus_allocating'

Sorry, I mistyped in a hurry yesterday, and it's 'percpu_obj_pool.obj_free > 1'
that should be deleted.


> would work, I removed it in V3.
> 
>> +	    READ_ONCE(obj_pool_free) > (debug_objects_pool_min_level / 2))
>> +		return;
>> +
>> +	atomic_inc(&cpus_allocating);
>>  	while (READ_ONCE(obj_pool_free) < debug_objects_pool_min_level) {
>>  		struct debug_obj *new[ODEBUG_BATCH_SIZE];
>>  		int cnt;
> 

-- 
Regards,
  Zhen Lei

