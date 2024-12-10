Return-Path: <linux-kernel+bounces-438970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1A5B9EA8E4
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 07:42:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 789A2284110
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 06:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CC0F22CBDC;
	Tue, 10 Dec 2024 06:42:20 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A6F22B8D9
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 06:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733812940; cv=none; b=TLWCLHb9+7mUatbdxwrIvUQWawrfp9IAQuyaFIQsQK9FUCcDXTDjtJMiM6of6BgkETymEctMZEZG5BMgv7GFcYP+/ys7DZ3OeyDNuRI6rjaUXXvyDBgWwQa5UemBCsR4EkcnP0A4YTdnMI6k1S0Uw8UOvVkArPbrzcy/K2ztBMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733812940; c=relaxed/simple;
	bh=ifT+gZaGmg32IdvzBNBi/br5Iziyj6oCH/zGPkhZXp4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=g28hwc3+9Lf3V6jgPIalx6FRoV1I09L/NyMb0D3f6FmMT8JDF/oLPm7cli1v4rL8ltZnSNi1jVLKhK7AI3aPzzr2TxqKkJiLGpCIMUMcFYF1AR38UswIEzMnNLH0MyOCY32L6fsuUeMlhGJrgXYoMt3qEeG2kTCurviMAtPz3vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Y6pwn1tNlz1V627;
	Tue, 10 Dec 2024 14:39:05 +0800 (CST)
Received: from kwepemd100013.china.huawei.com (unknown [7.221.188.163])
	by mail.maildlp.com (Postfix) with ESMTPS id 582421800FE;
	Tue, 10 Dec 2024 14:42:09 +0800 (CST)
Received: from [10.67.109.79] (10.67.109.79) by kwepemd100013.china.huawei.com
 (7.221.188.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Tue, 10 Dec
 2024 14:42:08 +0800
Message-ID: <f6872957-07ea-4d3a-b10c-a302cd291fda@huawei.com>
Date: Tue, 10 Dec 2024 14:42:07 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/1] mm: vmascan: retry folios written back while
 isolated for traditional LRU
To: Andrew Morton <akpm@linux-foundation.org>, Chen Ridong
	<chenridong@huaweicloud.com>
CC: <mhocko@suse.com>, <hannes@cmpxchg.org>, <yosryahmed@google.com>,
	<yuzhao@google.com>, <david@redhat.com>, <willy@infradead.org>,
	<ryan.roberts@arm.com>, <baohua@kernel.org>, <21cnbao@gmail.com>,
	<wangkefeng.wang@huawei.com>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <wangweiyang2@huawei.com>,
	<xieym_ict@hotmail.com>
References: <20241209083618.2889145-1-chenridong@huaweicloud.com>
 <20241209181341.fb579d7c0f9d76ae7854c4fa@linux-foundation.org>
Content-Language: en-US
From: chenridong <chenridong@huawei.com>
In-Reply-To: <20241209181341.fb579d7c0f9d76ae7854c4fa@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemd100013.china.huawei.com (7.221.188.163)



On 2024/12/10 10:13, Andrew Morton wrote:
> On Mon,  9 Dec 2024 08:36:17 +0000 Chen Ridong <chenridong@huaweicloud.com> wrote:
> 
>> The commit 359a5e1416ca ("mm: multi-gen LRU: retry folios written back
>> while isolated") only fixed the issue for mglru. However, this issue
>> also exists in the traditional active/inactive LRU. Fix this issue
>> in the same way for active/inactive lru.
>>
>> What is fixed:
>> The page reclaim isolates a batch of folios from the tail of one of the
>> LRU lists and works on those folios one by one.  For a suitable
>> swap-backed folio, if the swap device is async, it queues that folio for
>> writeback.  After the page reclaim finishes an entire batch, it puts back
>> the folios it queued for writeback to the head of the original LRU list.
>>
>> In the meantime, the page writeback flushes the queued folios also by
>> batches.  Its batching logic is independent from that of the page reclaim.
>> For each of the folios it writes back, the page writeback calls
>> folio_rotate_reclaimable() which tries to rotate a folio to the tail.
>>
>> folio_rotate_reclaimable() only works for a folio after the page reclaim
>> has put it back.  If an async swap device is fast enough, the page
>> writeback can finish with that folio while the page reclaim is still
>> working on the rest of the batch containing it.  In this case, that folio
>> will remain at the head and the page reclaim will not retry it before
>> reaching there.
> 
> For a single patch series I think it's best to just make it a single
> patch!  No need for a [0/n]: just put all the info into the patch's
> changelog.
> 
> The patch doesn't apply to current development kernels.  Please check
> the mm-unstable branch of
> https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/, or
> linux-next.
> 
> Please replace vmascan with vmscan in the title.

Thanks, Will update.

Best regards,
Ridong

