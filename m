Return-Path: <linux-kernel+bounces-420382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D9959D79BD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 02:19:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12A99282764
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 01:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2A194A28;
	Mon, 25 Nov 2024 01:19:24 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167712F43
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 01:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732497564; cv=none; b=i4CHpT6qQreXTvYfh78U6lLgZYjxdzNm8mHzWpeRAAa4hath/Jt0iobfb5A5KBA9coDDEQpeiBTJ5BJJnUvGY6nORhp3nlza1LRBFgEgrEkTZzeX8tnZi5yJfDDMcLNduP3CwtFnCQ6JW7oXi/kDOrbB2lC3cnF0SPj132R6N+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732497564; c=relaxed/simple;
	bh=O274OeBx5RTQ87pRBvU4x3+hppklt0m3pg8+DaHG3tA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=tEQWyCHJ5+b4zJTbFLCDlnS9eABjjBUxCOgk+35Br18Y+pMLofSbQR5qkeNrs6b1eUIV8WfUbc7npfvVg3mVKGY80UxbGZQGsHg84gaH50t9s60EaT0DT2Tcvik2ciaYV78sNwc6xhSEDf8tpTK0TQ2Fc8uRHaYt6ZGZ+tD49q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4XxSVD6yfdz1k0Mf;
	Mon, 25 Nov 2024 09:17:08 +0800 (CST)
Received: from kwepemd100013.china.huawei.com (unknown [7.221.188.163])
	by mail.maildlp.com (Postfix) with ESMTPS id A31CD1A0171;
	Mon, 25 Nov 2024 09:19:13 +0800 (CST)
Received: from [10.67.109.79] (10.67.109.79) by kwepemd100013.china.huawei.com
 (7.221.188.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Mon, 25 Nov
 2024 09:19:12 +0800
Message-ID: <7e617fe7-388f-43a1-b0fa-e2998194b90c@huawei.com>
Date: Mon, 25 Nov 2024 09:19:11 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 1/1] mm/vmscan: move the written-back folios to the
 tail of LRU after shrinking
To: Matthew Wilcox <willy@infradead.org>, Barry Song <21cnbao@gmail.com>,
	Chris Li <chrisl@kernel.org>
CC: Chen Ridong <chenridong@huaweicloud.com>, <akpm@linux-foundation.org>,
	<mhocko@suse.com>, <hannes@cmpxchg.org>, <yosryahmed@google.com>,
	<yuzhao@google.com>, <david@redhat.com>, <ryan.roberts@arm.com>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<wangweiyang2@huawei.com>, <xieym_ict@hotmail.com>, Chris Li
	<chrisl@kernel.org>
References: <20241116091658.1983491-1-chenridong@huaweicloud.com>
 <20241116091658.1983491-2-chenridong@huaweicloud.com>
 <Zzq8jsAQNYgDKSGN@casper.infradead.org>
 <CAGsJ_4x0OrdhorQdz8PyLD84GOYVZJ7kLfGV_5yupLG_ZQ_B3w@mail.gmail.com>
 <ZzrA5nXldoE2PWx4@casper.infradead.org>
Content-Language: en-US
From: chenridong <chenridong@huawei.com>
In-Reply-To: <ZzrA5nXldoE2PWx4@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemd100013.china.huawei.com (7.221.188.163)



On 2024/11/18 12:21, Matthew Wilcox wrote:
> On Mon, Nov 18, 2024 at 05:14:14PM +1300, Barry Song wrote:
>> On Mon, Nov 18, 2024 at 5:03 PM Matthew Wilcox <willy@infradead.org> wrote:
>>>
>>> On Sat, Nov 16, 2024 at 09:16:58AM +0000, Chen Ridong wrote:
>>>> 2. In shrink_page_list function, if folioN is THP(2M), it may be splited
>>>>    and added to swap cache folio by folio. After adding to swap cache,
>>>>    it will submit io to writeback folio to swap, which is asynchronous.
>>>>    When shrink_page_list is finished, the isolated folios list will be
>>>>    moved back to the head of inactive lru. The inactive lru may just look
>>>>    like this, with 512 filioes have been move to the head of inactive lru.
>>>
>>> I was hoping that we'd be able to stop splitting the folio when adding
>>> to the swap cache.  Ideally. we'd add the whole 2MB and write it back
>>> as a single unit.
>>
>> This is already the case: adding to the swapcache doesn’t require splitting
>> THPs, but failing to allocate 2MB of contiguous swap slots will.
> 
> Agreed we need to understand why this is happening.  As I've said a few
> times now, we need to stop requiring contiguity.  Real filesystems don't
> need the contiguity (they become less efficient, but they can scatter a
> single 2MB folio to multiple places).
> 
> Maybe Chris has a solution to this in the works?
> 

Hi, Chris, do you have a better idea to solve this issue?

Best regards,
Ridong

