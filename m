Return-Path: <linux-kernel+bounces-362016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DBD499AFFA
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 04:02:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5BFC1F22EE8
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 02:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E284DDC3;
	Sat, 12 Oct 2024 02:02:44 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C11A17579
	for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 02:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728698564; cv=none; b=gfmt6nJldkjNw1AfsvOCU9JoLogVmH5ywRIJV8PApG48/vu4B+fIZeOkR+Fgl5qdkE3DmIGLcBBmOc6+Z1CbONGflBSiJwQg+T+sCuXvHXFBsi+DjwU2v9tR6VUELr38iogQ8dKQbhnJO1KlMuTe2P2VIT8tnbh1sOEfMXfsNgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728698564; c=relaxed/simple;
	bh=0/PZaHWgGOvP3GTAa9+cKQ3HdSCoBrmWnsIB4cRDlOk=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=BllDio/qY61xhcBAkoO1sZU6jyoLUQJqkKty6qEMfT40kCUPfbvlpNIyYi+vRqrjbfr2p0Z0fF8ERxg259gy+fE07ycqUpO2yNhtH6uv1odZPravA1kY3LgY2AyZyP5dJBiZxvRVjHgqJsTp7ewUVinYR0oT3jzDSfhG3GgOZ8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4XQRYV4KYhzyT4F;
	Sat, 12 Oct 2024 10:01:18 +0800 (CST)
Received: from dggpemf100006.china.huawei.com (unknown [7.185.36.228])
	by mail.maildlp.com (Postfix) with ESMTPS id C2CB61800F2;
	Sat, 12 Oct 2024 10:02:37 +0800 (CST)
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemf100006.china.huawei.com (7.185.36.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 12 Oct 2024 10:02:37 +0800
Subject: Re: [patch 20/25] debugobjects: Prepare kmem_cache allocations for
 batching
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
CC: Waiman Long <longman@redhat.com>
References: <20241007163507.647617031@linutronix.de>
 <20241007164914.198647184@linutronix.de>
 <cd9df252-8ec8-cb84-533f-ebc98a788032@huawei.com> <87jzeegyep.ffs@tglx>
From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <a776760d-ece2-74b5-278d-d070450472a8@huawei.com>
Date: Sat, 12 Oct 2024 10:02:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <87jzeegyep.ffs@tglx>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemf100006.china.huawei.com (7.185.36.228)



On 2024/10/12 4:47, Thomas Gleixner wrote:
> On Thu, Oct 10 2024 at 16:40, Leizhen wrote:
>> On 2024/10/8 0:50, Thomas Gleixner wrote:
>>> +static bool kmem_alloc_batch(struct hlist_head *head, struct kmem_cache *cache, gfp_t gfp)
>>> +{
>>> +	struct hlist_node *last = NULL;
>>> +	struct debug_obj *obj;
>>> +
>>> +	for (int cnt = 0; cnt < ODEBUG_BATCH_SIZE; cnt++) {
>>> +		obj = kmem_cache_zalloc(cache, gfp);
>>> +		if (!obj) {
>>> +			free_object_list(head);
>>> +			return false;
>>> +		}
>>> +		debug_objects_allocated++;
>>> +
>>> +		if (!last)
>>> +			last = &obj->node;
>>> +		obj->batch_last = last;
>>> +
>>> +		hlist_add_head(&obj->node, head);
>>
>> There seems to be a need to use hlist_splice_init() outside the loop like patch 2/25.
>> Prepare the local list first, if all ODEBUG_BATCH_SIZE is successfully allocated,
>> attach it to 'head' at a time, including account debug_objects_allocated. Then back
>> to patch 8/25, keep debug_objects_freed still in lock protection and do not move it
>> into free_object_list(). Seems like it should be.
> 
> In case that the allocation of 16 object fails, the accounting
> concurrency problem vs. free_object_list is pretty irrelevant.
> 
> It's debug information and moving it under lock protection for a corner
> case is just making the code more complex.

OK, got it, with 8/25.

> 
> Thanks,
> 
>         tglx
> 
> .
> 

-- 
Regards,
  Zhen Lei

