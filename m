Return-Path: <linux-kernel+bounces-174308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 440FA8C0CE3
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 10:52:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7321F1C20F7D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 08:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 025AA14A0A3;
	Thu,  9 May 2024 08:52:24 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4CAB13D289
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 08:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715244743; cv=none; b=kjVD6cPN2a46i0LNccuJZ3OGXcBnUcR/TN64XjksLCCNmpAzhXF/yjmGGWCkhtrM6lN6n179QiqIrVHGTe6nxbg6sS85xAvjPuVpydbnBVrkZWoWjPHGVTFm9yiukHYD/Ri4IInNl0XAX66E3t+R115vKiFgj7w5zzO0waa/Jws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715244743; c=relaxed/simple;
	bh=aS+jJPZZRPiKHCX180z4+IsZWClUBunHD4Mtlw9ESBg=;
	h=Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=fvoS4sGDWGwcTXciVRu9LLa7WT5tBKYOphtY8XxoP4Kx39Szx9xRKd6QZ2cnzL8ljNUWhmCtgiB/J+gFj7NaMtPKmTDOQtxulKuOdhX29X86/1w/WdGAyuTwrmm1vi/k1VIpRNXGswkN6GJ3TTBfsJxkwVFN02psGCQYxpwBo+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VZlzs1QQJzvXbS;
	Thu,  9 May 2024 16:48:57 +0800 (CST)
Received: from canpemm500002.china.huawei.com (unknown [7.192.104.244])
	by mail.maildlp.com (Postfix) with ESMTPS id 6099C18007E;
	Thu,  9 May 2024 16:52:18 +0800 (CST)
Received: from [10.173.135.154] (10.173.135.154) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 9 May 2024 16:52:17 +0800
Subject: Re: [PATCH 3/3] mm/memory-failure: send SIGBUS in the event of thp
 split fail
To: Jane Chu <jane.chu@oracle.com>, <nao.horiguchi@gmail.com>,
	<akpm@linux-foundation.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
References: <20240501232458.3919593-1-jane.chu@oracle.com>
 <20240501232458.3919593-4-jane.chu@oracle.com>
 <2e51deff-24ca-32d5-dbd2-9077f860723c@huawei.com>
 <56448498-96e4-4350-a915-15b97294bc62@oracle.com>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <9092ae5b-4910-95c6-14b6-a884f6fa9361@huawei.com>
Date: Thu, 9 May 2024 16:52:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <56448498-96e4-4350-a915-15b97294bc62@oracle.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500002.china.huawei.com (7.192.104.244)

On 2024/5/9 0:56, Jane Chu wrote:
> On 5/8/2024 2:03 AM, Miaohe Lin wrote:
> 
>> On 2024/5/2 7:24, Jane Chu wrote:
>>> When handle hwpoison in a GUP longterm pin'ed thp page,
>>> try_to_split_thp_page() will fail. And at this point, there is little else
>>> the kernel could do except sending a SIGBUS to the user process, thus
>>> give it a chance to recover.
>> It seems the user process will still receive SIGBUS via kill_accessing_process()
>> when (re-)access thp later. So they should have a chance to recover already.
>> Or am I miss something?
> 
> The concern is about real UE consumption in which case, it's desirable to kill the process ASAP without having to relying on subsequent access.  Also to honor processes' MCE-early-kill request. kill_accessing_process() is very conservative in that, it doesn't check other processes that have the poisoned page mapped.

I see. Thanks for your explanation.
Thanks.
.

> 
> thanks,
> 
> -jane
> 
>>
>> Thanks.
>> .
>>
>>
> .


