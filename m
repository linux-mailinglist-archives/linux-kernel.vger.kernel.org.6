Return-Path: <linux-kernel+bounces-314710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F15C996B75B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 11:51:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3018D1C21F31
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 09:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C7AC1CCECB;
	Wed,  4 Sep 2024 09:50:55 +0000 (UTC)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB83145B35
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 09:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725443455; cv=none; b=ZH/DAsd4H9lYm1vs27u5+DFocOquRjCOjYbUsRI2c0MeRyofJPhOJzqGvfwYrJ4nTUxc+Y7Y4r2ekNUdVKjbSL5lSVmehrav/N3RBqR85KEB16O5SquC+qBgVOGPVGUekXUA3blC53Y5tdlc5KyRQ8uvklfzOTr2NYW8rVZz/BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725443455; c=relaxed/simple;
	bh=JGnFHr77G379PpB6Dr0hWdy2WMMB6oV9BeQxLhM5amU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Q+KMvBUdImr4E5qz851ZyXtyX2ZCXhz3I9yH/WX5IZd6OpKdCOPSUtEWfWiBV+sqeQiRYwNvdXq2uHh0b1ySdinImCVxdaxtRQGCgowO2N3eVN8/62fvVzobZ0NHUA9rV6eI2D2EdMMp1ftisDsfzPNpihfM5G0Mkl3CH5U5uvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4WzHkT09fkz1xwns;
	Wed,  4 Sep 2024 17:48:49 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id BEE5F1A0188;
	Wed,  4 Sep 2024 17:50:49 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemh500013.china.huawei.com (7.202.181.146) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 4 Sep 2024 17:50:49 +0800
Message-ID: <ffc4e9b0-3e67-9215-9168-91b2b3c68d5f@huawei.com>
Date: Wed, 4 Sep 2024 17:50:48 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH] static_call: Handle module init failure correctly in
 static_call_del_module()
Content-Language: en-US
To: Thomas Gleixner <tglx@linutronix.de>, <linux-kernel@vger.kernel.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, Christophe Leroy
	<christophe.leroy@csgroup.eu>, Josh Poimboeuf <jpoimboe@kernel.org>
References: <87cylj7v6x.ffs@tglx>
 <3e158999-c93a-a4e3-85a9-2d6bfc1ccee7@huawei.com> <877cbr7qed.ffs@tglx>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <877cbr7qed.ffs@tglx>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemh500013.china.huawei.com (7.202.181.146)



On 2024/9/4 16:51, Thomas Gleixner wrote:
> On Wed, Sep 04 2024 at 16:03, Jinjie Ruan wrote:
>> On 2024/9/4 15:08, Thomas Gleixner wrote:
>>> So the check must be:
>>>
>>> 	if (!static_call_key_has_mods(key))
>>>         	break;
>>
>> Hi, Thomas,
>>
>> with this patch, the issue not occurs again，
>>
>> but there are some memory leak here same to the following problem:
> 
> That has absolutely nothing to do with static calls and the memory
> allocation failure case there.
> 
> The module passed all preparatory steps, otherwise it would not be able
> to create a kmem_cache from the module init() function:
> 
>      kmem_cache_create+0x11/0x20
>      do_one_initcall+0xdc/0x550
>      do_init_module+0x241/0x630
> 
> amdgpu_init()
> 
> 	r = amdgpu_sync_init();
> 	if (r)
> 		goto error_sync;
> 
> 	r = amdgpu_fence_slab_init();
> 	if (r)
> 		goto error_fence;
> 
>         <SNIP>
>         
> 	return pci_register_driver(&amdgpu_kms_pci_driver);
> 
> error_fence:
> 	amdgpu_sync_fini();
> error_sync:
>         return r;
> 
> Can you spot the problem?

I see, let me test it.

> 
> Thanks,
> 
>         tglx

