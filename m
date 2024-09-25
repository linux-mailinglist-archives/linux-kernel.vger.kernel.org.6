Return-Path: <linux-kernel+bounces-337899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24D289850D1
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 04:03:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D72752853E3
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 02:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74CF913774A;
	Wed, 25 Sep 2024 02:03:32 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1182B3770C
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 02:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727229812; cv=none; b=UDijqSgLwuDy9Oy6cudAwSnAQIXr/hEYviDiJXFoV6hQwPFbRPYz6SGj2WODkY9FQitHnil5WVTPHa6qU1FvcZMSH07ndEUrBSO8aMqZSYEdBoYTF0ZFzvt/m90w8IE0c0iXafG/oAWr+gh0oCUxgHBuMaUCo2dMVAonrmooIzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727229812; c=relaxed/simple;
	bh=1lLMvwBGgiP4ESfuVr28iLkJjikYPchBeABT6GMBPok=;
	h=Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=S9jJDzOhBcVmgoKy9J9jG10z7SMbmW8acIqsaN9zCog7WKfc5Z8yNB990bqV6Sxhy2vIoqRmjK3E6BII0KHpu4tDCGL8stsQhlujwEDU36sLf/FCYDiBrM9+hLIhhrtk0v/GybvjuF5HrLZOMYQ7CZruCoLlufM/YGxYguLxvsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4XD0KN01ZTz1HJxf;
	Wed, 25 Sep 2024 09:59:35 +0800 (CST)
Received: from dggpemf100006.china.huawei.com (unknown [7.185.36.228])
	by mail.maildlp.com (Postfix) with ESMTPS id 1CE18140203;
	Wed, 25 Sep 2024 10:03:26 +0800 (CST)
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemf100006.china.huawei.com (7.185.36.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 25 Sep 2024 10:03:25 +0800
Subject: Re: [PATCH v3 3/3] debugobjects: Reduce contention on pool lock in
 fill_pool()
To: Thomas Gleixner <tglx@linutronix.de>, Andrew Morton
	<akpm@linux-foundation.org>, <linux-kernel@vger.kernel.org>
References: <20240911083521.2257-1-thunder.leizhen@huawei.com>
 <20240911083521.2257-4-thunder.leizhen@huawei.com>
 <90546c16-52e3-b92c-d99b-724278647809@huawei.com> <87ldzq1nh9.ffs@tglx>
From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <ff651fc5-9a5b-0260-6e24-c4e0fa8330c6@huawei.com>
Date: Wed, 25 Sep 2024 10:03:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <87ldzq1nh9.ffs@tglx>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemf100006.china.huawei.com (7.185.36.228)



On 2024/9/17 20:19, Thomas Gleixner wrote:
> On Wed, Sep 11 2024 at 17:04, Leizhen wrote:
>> On 2024/9/11 16:35, Zhen Lei wrote:
>>> Scenarios that use allocated node filling can also be applied lockless
>>> mechanisms, but slightly different. The global list obj_to_free can only
>>> be operated exclusively by one core, while kmem_cache_zalloc() can be
>>> invoked by multiple cores simultaneously. Use atomic counting to mark how
>>> many cores are filling, to reduce atomic write conflicts during check. In
>>> principle, only the first comer is allowed to fill, but there is a very
>>> low probability that multiple comers may fill at the time.
>>>
>>> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
>>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>>
>> Hi, Thomas:
>>   I was going to mark "Signed-off-by" as you. Because except for the
>> following line of changes, you wrote everything. But you're maintainer.
>> It doesn't seem good if I post a patch with your Signed-off-by. Please
>> feel free to change it, but do not forget to add "Reported-by" or
>> "Tested-by" for me.
> 
> Suggested-by is fine. I look at it after back from travel and
> conferencing.

Thank you very much. You're such a gentleman.

> 
> Thanks,
> 
>         tglx
> .
> 

-- 
Regards,
  Zhen Lei

