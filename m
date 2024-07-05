Return-Path: <linux-kernel+bounces-241778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2435E927F87
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 03:04:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDE801F24E78
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 01:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB4736FDC;
	Fri,  5 Jul 2024 01:04:35 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96CCB1DA30D
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 01:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720141475; cv=none; b=NGYINXOzlUQSx4m1Yaq/udrkPUO4R/Cvc4sbwU0DVOoiS/EEVDKWur3nP9sGfcJoydkURza0B7v66MZkWVtsQoCpOC+PWaHa5QZP3xMau77Wb79jjveABUZnWXrsmfM5UWnX1rBSIjp/YOCJaFCSHWDdWdyWqDxC8NggFB23OdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720141475; c=relaxed/simple;
	bh=a81ikMlkn88aoMKPwfTb1P7o7pudJaCjl0oXjRsXDek=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=ZeCmrR5VCYvY2TW4jRgBVWSutklTP4BOCL4pSnusq1/197ybkloauQar3ObgzXTJ2sgGir+mYc2R4iaNogoTl5X82cwvOsdOelf7J2ZQh0r9K+3h83nOLTj6sWO3Z/dfiU/cuJf17mWXWtMAcrxOnHzZRdWsuu3HbZntI2uEf1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WFZxl6yLYzdgLk;
	Fri,  5 Jul 2024 09:02:51 +0800 (CST)
Received: from kwepemd200019.china.huawei.com (unknown [7.221.188.193])
	by mail.maildlp.com (Postfix) with ESMTPS id D525D18009B;
	Fri,  5 Jul 2024 09:04:29 +0800 (CST)
Received: from [10.173.127.72] (10.173.127.72) by
 kwepemd200019.china.huawei.com (7.221.188.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 5 Jul 2024 09:04:29 +0800
Subject: Re: [PATCH] mm/memory-failure: allow memory allocation from emergency
 reserves
To: Andrew Morton <akpm@linux-foundation.org>
CC: Rui Qi <qirui.001@bytedance.com>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <nao.horiguchi@gmail.com>
References: <20240625022342.6158-1-qirui.001@bytedance.com>
 <d7fb45a9-2d16-a2d5-59f4-f1e7a4362e33@huawei.com>
 <20240702001940.43a9447a76b51a871d8dec97@linux-foundation.org>
 <070697f1-83f5-ff8e-dfc0-2f99c98c448c@huawei.com>
 <20240704162629.cf750dd1ee58c70d358466f3@linux-foundation.org>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <27737d6b-514b-13d7-7830-9d80e192a48e@huawei.com>
Date: Fri, 5 Jul 2024 09:04:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240704162629.cf750dd1ee58c70d358466f3@linux-foundation.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemd200019.china.huawei.com (7.221.188.193)

On 2024/7/5 7:26, Andrew Morton wrote:
> On Tue, 2 Jul 2024 16:04:02 +0800 Miaohe Lin <linmiaohe@huawei.com> wrote:
> 
>>>> Tasks might not be killed even to_kill struct is allocated.
>>>>
>>>> ...
>>>>
>>>>> -	raw_hwp = kmalloc(sizeof(struct raw_hwp_page), GFP_ATOMIC);
>>>>> +	raw_hwp = kmalloc(sizeof(struct raw_hwp_page), GFP_ATOMIC | __GFP_MEMALLOC);
>>>>
>>>> In already hardware poisoned code path, raw_hwp can be allocated to store raw page info
>>>> without killing anything. So __GFP_MEMALLOC might not be suitable to use.
>>>> Or am I miss something?
>>>
>>> Yes, I'm doubtful about this patch.  I think that rather than poking at a
>>> particular implementation, it would be helpful for us to see a complete
>>> description of the issues which were observed, please.  Let's see the
>>> bug report and we can discuss fixes later.
>>
>> I agree with you, Andrew. Thanks. :)
> 
> I dropped the patch.  Please let's proceed as discussed above.
> .

Sure. Thanks.
.

