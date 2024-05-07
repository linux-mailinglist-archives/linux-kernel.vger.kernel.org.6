Return-Path: <linux-kernel+bounces-171163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 871B98BE092
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 12:59:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 422D2289401
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 10:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0D761509B9;
	Tue,  7 May 2024 10:59:38 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5486D14EC7E
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 10:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715079578; cv=none; b=e3/w+4HQvB6QC6ccVYCgPtr81k/kQEXx7q05v71M7CniLcL0pwYe3+cCiidaxpNZcX+qEe1VC65ChC70Cp7b8tBvNX89SZ/fjwIoPjYrHLDOGNE+ZfCdlU1g9fmE/a3OQm9WM4BqDTIa7GLhmq/sEYL2iIza2zmSV4LteNml/9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715079578; c=relaxed/simple;
	bh=1gQ3990aStUAEShBuB2nhG7rzQRUTi8W6QkChNRB26k=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=hjsha87duy6GFrMUllT+X6QtgfZMEozIz6vrNLqRAT3sX1TKqONPcW/Utr4CHkKGITLUuOS5PZtS9jJiKxde2X39WJvyNpl0NfOP6eg0RkhjQzzbfUo9K7WfnTBPYB8GKIy8XB7gXHTk53vdGrHj+X5x2xdDalvp0yfhOlBlNMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4VYZvf0cbsz1R9np;
	Tue,  7 May 2024 18:56:14 +0800 (CST)
Received: from dggpemm100001.china.huawei.com (unknown [7.185.36.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 8E9FD180080;
	Tue,  7 May 2024 18:59:32 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 7 May 2024 18:59:32 +0800
Message-ID: <6016c0e9-b567-4205-8368-1f1c76184a28@huawei.com>
Date: Tue, 7 May 2024 18:59:31 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH] mm: align larger anonymous mappings on THP
 boundaries
Content-Language: en-US
To: Ryan Roberts <ryan.roberts@arm.com>, Yang Shi <shy828301@gmail.com>
CC: Matthew Wilcox <willy@infradead.org>, Yang Shi
	<yang@os.amperecomputing.com>, <riel@surriel.com>, <cl@linux.com>,
	<akpm@linux-foundation.org>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, Ze Zuo <zuoze1@huawei.com>
References: <20231214223423.1133074-1-yang@os.amperecomputing.com>
 <1e8f5ac7-54ce-433a-ae53-81522b2320e1@arm.com>
 <Zav3UK7ESNxCMjyP@casper.infradead.org>
 <b75cb59a-734f-43d5-b565-fc9bb8c5ed05@arm.com>
 <CAHbLzkpT6padaDo8GimCcQReSGybQn_ntzj+wsZbTXe3urtK-g@mail.gmail.com>
 <bad7ec4a-1507-4ec4-996a-ea29d07d47a0@arm.com>
 <CAHbLzkrtcsU=pW13AyAMvF72A03fUV5iFcM0HwQoEemeajtqxg@mail.gmail.com>
 <b84e2799-2b6c-4670-b017-3a04ec18c0f2@arm.com>
 <dea802da-2e5e-4c91-b817-43afdde68958@huawei.com>
 <1dc9a561-55f7-4d65-8b86-8a40fa0e84f9@arm.com>
From: Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <1dc9a561-55f7-4d65-8b86-8a40fa0e84f9@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm100001.china.huawei.com (7.185.36.93)



On 2024/5/7 18:08, Ryan Roberts wrote:
> On 07/05/2024 09:25, Kefeng Wang wrote:
>> Hi Ryan, Yang and all,
>>
>> We see another regression on arm64(no issue on x86) when test memory
>> latency from lmbench,
>>
>> ./lat_mem_rd -P 1 512M 128
> 
> Do you know exectly what this test is doing?

lat_mem_rd measures memory read latency for varying memory sizes and
strides, see https://lmbench.sourceforge.net/man/lat_mem_rd.8.html
> 
>>
>> memory latency(smaller is better)
>>
>> MiB     6.9-rc7    6.9-rc7+revert
> 
> And what exactly have you reverted? I'm guessing just commit efa7df3e3bb5 ("mm:
> align larger anonymous mappings on THP boundaries")?

Yes, just revert efa7df3e3bb5.
> 
>> 0.00049    1.539     1.539
>> 0.00098    1.539     1.539
>> 0.00195    1.539     1.539
>> 0.00293    1.539     1.539
>> 0.00391    1.539     1.539
>> 0.00586    1.539     1.539
>> 0.00781    1.539     1.539
>> 0.01172    1.539     1.539
>> 0.01562    1.539     1.539
>> 0.02344    1.539     1.539
>> 0.03125    1.539     1.539
>> 0.04688    1.539     1.539
>> 0.0625    1.540     1.540
>> 0.09375    3.634     3.086
> 
> So the first regression is for 96K - I'm guessing that's the mmap size? That
> size shouldn't even be affected by this patch, apart from a few adds and a
> compare which determines the size is too small to do PMD alignment for.

Yes, no anon thp.
> 
>> 0.125   3.874     3.175
>> 0.1875  3.544     3.288
>> 0.25    3.556     3.461
>> 0.375   3.641     3.644
>> 0.5     4.125     3.851
>> 0.75    4.968     4.323
>> 1       5.143     4.686
>> 1.5     5.309     4.957
>> 2       5.370     5.116
>> 3       5.430     5.471
>> 4       5.457     5.671
>> 6       6.100     6.170
>> 8       6.496     6.468
>>
>> -----------------------s
>> * L1 cache = 8M, it is no big changes below 8M *
>> * but the latency reduce a lot when revert this patch from L2 *
>>
>> 12      6.917     6.840
>> 16      7.268     7.077
>> 24      7.536     7.345
>> 32      10.723     9.421
>> 48      14.220     11.350
>> 64      16.253     12.189
>> 96      14.494     12.507
>> 128     14.630     12.560
>> 192     15.402     12.967
>> 256     16.178     12.957
>> 384     15.177     13.346
>> 512     15.235     13.233
>>
>> After quickly check the smaps, but don't find any clues, any suggestion?
> 
> Without knowing exactly what the test does, it's difficult to know what to


The major operation(memory read) shows below,

#define    ONE      p = (char **)*p;
#define    FIVE     ONE ONE ONE ONE ONE
#define    TEN      FIVE FIVE
#define    FIFTY    TEN TEN TEN TEN TEN
#define    HUNDRED  FIFTY FIFTY

     while (iterations-- > 0) {
         for (i = 0; i < count; ++i) {
             HUNDRED;
         }
     }

https://github.com/intel/lmbench/blob/master/src/lat_mem_rd.c#L95

> suggest. If you want to try something semi-randomly; it might be useful to rule
> out the arm64 contpte feature. I don't see how that would be interacting here if
> mTHP is disabled (is it?). But its new for 6.9 and arm64 only. Disable with
> ARM64_CONTPTE (needs EXPERT) at compile time.
I don't enabled mTHP, so it should be not related about ARM64_CONTPTE, 
but will have a try.

