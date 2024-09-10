Return-Path: <linux-kernel+bounces-322471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1CEF972953
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 08:13:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3F521C20F46
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 06:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EFED172773;
	Tue, 10 Sep 2024 06:13:47 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9730170A15
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 06:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725948827; cv=none; b=PGSVP2+ACKbAkBgz3Q/MQIYi1XgNfhIkxkqFq5Rzg7iSks6cBAJ2Gi2ZMw0oL8x8q89gGx9FJUK7SPx9/DWdi8XhPbc9Cu/QuPPY89mNN/EqFloymsLA6Driwh8AenewdEk1BcGFhkCXdXHVQuPc9rAzy2KyqyzkZNk3Nub0Z2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725948827; c=relaxed/simple;
	bh=YfAHwumSZldbqrMyckqoVZpv4fbP7RwrMiUlejXY+hU=;
	h=Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=LCMuunv1veXlS1csCkPPm1mBLAxU/vvNpExwRij4QC18O0Jd0Keok2Z5MWcNwTvMomvS7G4tzpyAkrJRVJzycrEpm7iLyt+T4L7lSvsC03xMeUPuRHamcFXNTRGJwPRRsbqFL+tgaiwnrLelXKsrQPnr0wEHlRzxlktykhZ/6fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4X2tf66GWYz1P9M9;
	Tue, 10 Sep 2024 14:12:30 +0800 (CST)
Received: from dggpemf100006.china.huawei.com (unknown [7.185.36.228])
	by mail.maildlp.com (Postfix) with ESMTPS id E366B180AE7;
	Tue, 10 Sep 2024 14:13:35 +0800 (CST)
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemf100006.china.huawei.com (7.185.36.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 10 Sep 2024 14:13:35 +0800
Subject: Re: [PATCH v2 4/6] debugobjects: Don't start fill if there are
 remaining nodes locally
To: Thomas Gleixner <tglx@linutronix.de>, Andrew Morton
	<akpm@linux-foundation.org>, <linux-kernel@vger.kernel.org>
References: <20240904133944.2124-1-thunder.leizhen@huawei.com>
 <20240904133944.2124-5-thunder.leizhen@huawei.com>
 <336109d9-2eea-4d67-ee22-ed218b9504c3@huawei.com>
 <7613ce35-0c65-341f-c6ed-412de79890e6@huawei.com> <87ed5tchc6.ffs@tglx>
 <87bk0xc9iy.ffs@tglx> <32bd93ec-747f-b5a1-917f-f885b87600a5@huawei.com>
 <87wmjkc2te.ffs@tglx>
From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <8ab2df64-9d78-f60d-e4f1-a13b4065b01a@huawei.com>
Date: Tue, 10 Sep 2024 14:13:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <87wmjkc2te.ffs@tglx>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemf100006.china.huawei.com (7.185.36.228)



On 2024/9/9 22:35, Thomas Gleixner wrote:
> On Mon, Sep 09 2024 at 21:51, Leizhen wrote:
>> On 2024/9/9 20:10, Thomas Gleixner wrote:
>>> So something like the uncompiled below should reduce lock contention
>>> significantly with a reasonable safety net.
>>
>> It looks very good. Especially flexible use of 'state' and 'cpus_allocating'.
>> In this way, there is almost no conflict of lock 'pool_lock', and the more
>> cores, the less possible conflict.
>>
>> Hi Thomas Gleixner:
>>   Do you plan to post this patch? But this patch will conflict with my patch 5/6.
>> If you're going to merge my patch 5/6, hopefully yours will be applied
>> after mine.
> 
> I'm short of cycles, so the best way is when you pick it up and
> integrate it instead of 4/6 and post a v3.

OK

> 
>>   By the way, Do you have time to review the patches in the link below?
>>   https://lkml.org/lkml/2024/9/4/1094
> 
> Please use lore.kernel.org links. I've seen it but did not come around

OK

> to it yet because I was staring at this one. I'm single threaded :)

Mostly you big shot are too busy.

> 
> Thanks,
> 
>         tglx
> 
> 
> 
> .
> 

-- 
Regards,
  Zhen Lei

