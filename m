Return-Path: <linux-kernel+bounces-171483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3B7B8BE4E7
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 15:56:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D54771C2375B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 13:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA32C15EFDF;
	Tue,  7 May 2024 13:53:56 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C577615EFAE
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 13:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715090036; cv=none; b=D5k10VNqM3T4Hoqfj5aPopUaLJXKdkwOksNFGxKVHy8RIavC7uMctkKf44KqBZltLKMBDx4CMElU+X3LaTtHhJwdMAHfy1229BkjG99nWuZcNmIEAAi+56qUmrRpXlXID+ScdEqfUG4uZqF92UYqewMWY2QuiBuOB8VzPlQKGW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715090036; c=relaxed/simple;
	bh=alx+N3tB3mWJOHYdmXWrKl8FRBhlljKhCrlkTIOaJBA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ufGMUhcz060bKd2y+XVAKkOiLyToKAkCpQZFTCg9HhOpr73wSJ5OYnhCtbLdqD1vn1mHpfheighGF1ulKk7uCpvcSeK3EoC3w3QjW0Y9/NXNepFTr6KTbMfqcFF8aYgotaNgj6Jpj+OAWfsmz9+RgNjbYjMNxOtzlXQtRn2gGKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4VYfnQ5tdwzNw3W;
	Tue,  7 May 2024 21:51:06 +0800 (CST)
Received: from dggpemm100001.china.huawei.com (unknown [7.185.36.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 943C318007D;
	Tue,  7 May 2024 21:53:52 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 7 May 2024 21:53:51 +0800
Message-ID: <da24d8bb-3723-48fa-86f4-8b24457d3556@huawei.com>
Date: Tue, 7 May 2024 21:53:51 +0800
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
To: David Hildenbrand <david@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Yang Shi <shy828301@gmail.com>
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
 <6016c0e9-b567-4205-8368-1f1c76184a28@huawei.com>
 <2c14d9ad-c5a3-4f29-a6eb-633cdf3a5e9e@redhat.com>
From: Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <2c14d9ad-c5a3-4f29-a6eb-633cdf3a5e9e@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm100001.china.huawei.com (7.185.36.93)



On 2024/5/7 19:13, David Hildenbrand wrote:
> 
>> https://github.com/intel/lmbench/blob/master/src/lat_mem_rd.c#L95
>>
>>> suggest. If you want to try something semi-randomly; it might be 
>>> useful to rule
>>> out the arm64 contpte feature. I don't see how that would be 
>>> interacting here if
>>> mTHP is disabled (is it?). But its new for 6.9 and arm64 only. 
>>> Disable with
>>> ARM64_CONTPTE (needs EXPERT) at compile time.
>> I don't enabled mTHP, so it should be not related about ARM64_CONTPTE,
>> but will have a try.

After ARM64_CONTPTE disabled, memory read latency is similar with 
ARM64_CONTPTE enabled(default 6.9-rc7), still larger than align anon 
reverted.

> 
> cont-pte can get active if we're just lucky when allocating pages in the 
> right order, correct Ryan?
> 

