Return-Path: <linux-kernel+bounces-209200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C2F4902E9B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 04:53:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27E672834BF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 02:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DED3916F85D;
	Tue, 11 Jun 2024 02:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="nI8taSAG"
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3FB2A2A
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 02:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718074408; cv=none; b=hpx1z6mlrRJ52bpe9Ta2BwVlr2zx7vpOPfG/i6A5VaAK+ykumLiXcBmCS5nPdRu9JQ4VN3UE8E6bi/Q9RWAy0GhG2FOKu62EwE8MZipJsuR/cj/SJsfIYBXVaK6gYsQOOR+3MESNTSl7S3R93tr3n8cg3AwezMrsc6XsEJh5yeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718074408; c=relaxed/simple;
	bh=ShNxA8sdFwHAawK2Hgl/KWSFDJOd4xSvXw6uCEhExP0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BHk5V3ZArmL36o8iJzLu+i+jJfSJI6aqOZjX1Bpcv43+p+1iLIfJ+JZFYUUrejW4T/HtI4MfnpgSb99sjgUfuwUm4NQq6g/xynaEg6r2saQ97L3cpqonHmKDc9D1gLNwB0ClRExuUJYkCSv8oCk6FhvR58a6A3ku0RYEdKc7gd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=nI8taSAG; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718074402; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Dl8n43VI8mn4utlO/CKQEcJ3bnZnLyAzO5cH3rC0sRo=;
	b=nI8taSAG2UkV+hbuotEMv6natRFHljdrqcaMAu4hK8b6rI/7sYwkvLFxKXMONaXzpeZYfDFmth5nRWnh5STKE89nkOETNrh70N0/MtQ7jpid9ii0zKr5dHFKTBbr5BsDsXbU2BiMnnoBKwE5N5OKOZGjdchQbdhm7ErfIRRC2zw=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032014031;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0W8EobXH_1718074399;
Received: from 30.97.56.68(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W8EobXH_1718074399)
          by smtp.aliyun-inc.com;
          Tue, 11 Jun 2024 10:53:20 +0800
Message-ID: <18b99bf2-a9c9-4abe-8345-e9864502c40e@linux.alibaba.com>
Date: Tue, 11 Jun 2024 10:53:19 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/6] add mTHP support for anonymous shmem
To: Daniel Gomez <da.gomez@samsung.com>
Cc: "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "hughd@google.com" <hughd@google.com>,
 "willy@infradead.org" <willy@infradead.org>,
 "david@redhat.com" <david@redhat.com>,
 "wangkefeng.wang@huawei.com" <wangkefeng.wang@huawei.com>,
 "ying.huang@intel.com" <ying.huang@intel.com>,
 "21cnbao@gmail.com" <21cnbao@gmail.com>,
 "ryan.roberts@arm.com" <ryan.roberts@arm.com>,
 "shy828301@gmail.com" <shy828301@gmail.com>, "ziy@nvidia.com"
 <ziy@nvidia.com>, "ioworker0@gmail.com" <ioworker0@gmail.com>,
 Pankaj Raghav <p.raghav@samsung.com>, "linux-mm@kvack.org"
 <linux-mm@kvack.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <cover.1717495894.git.baolin.wang@linux.alibaba.com>
 <CGME20240610121040eucas1p2ad07a27dec959bf1658ea9e5f0dd4697@eucas1p2.samsung.com>
 <qmbf362n2vtjaaeqvv6ta5xets3wyo5m3lfsocsrhvqjdso3vr@okzpmdbm3ogn>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <qmbf362n2vtjaaeqvv6ta5xets3wyo5m3lfsocsrhvqjdso3vr@okzpmdbm3ogn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/6/10 20:10, Daniel Gomez wrote:
> Hi Baolin,
> 
> On Tue, Jun 04, 2024 at 06:17:44PM +0800, Baolin Wang wrote:
>> Anonymous pages have already been supported for multi-size (mTHP) allocation
>> through commit 19eaf44954df, that can allow THP to be configured through the
>> sysfs interface located at '/sys/kernel/mm/transparent_hugepage/hugepage-XXkb/enabled'.
>>
>> However, the anonymous shmem will ignore the anonymous mTHP rule configured
>> through the sysfs interface, and can only use the PMD-mapped THP, that is not
>> reasonable. Many implement anonymous page sharing through mmap(MAP_SHARED |
>> MAP_ANONYMOUS), especially in database usage scenarios, therefore, users expect
>> to apply an unified mTHP strategy for anonymous pages, also including the
>> anonymous shared pages, in order to enjoy the benefits of mTHP. For example,
>> lower latency than PMD-mapped THP, smaller memory bloat than PMD-mapped THP,
>> contiguous PTEs on ARM architecture to reduce TLB miss etc.
>>
>> As discussed in the bi-weekly MM meeting[1], the mTHP controls should control
>> all of shmem, not only anonymous shmem, but support will be added iteratively.
>> Therefore, this patch set starts with support for anonymous shmem.
>>
>> The primary strategy is similar to supporting anonymous mTHP. Introduce
>> a new interface '/mm/transparent_hugepage/hugepage-XXkb/shmem_enabled',
>> which can have almost the same values as the top-level
>> '/sys/kernel/mm/transparent_hugepage/shmem_enabled', with adding a new
>> additional "inherit" option and dropping the testing options 'force' and
>> 'deny'. By default all sizes will be set to "never" except PMD size, which
>> is set to "inherit". This ensures backward compatibility with the anonymous
>> shmem enabled of the top level, meanwhile also allows independent control of
>> anonymous shmem enabled for each mTHP.
>>
>> Use the page fault latency tool to measure the performance of 1G anonymous shmem
> 
> I'm not familiar with this tool. Could you share which repo/tool you are
> referring to?

Sure. The git repo is: https://github.com/gormanm/pft.git

And I did a little changes to test anon shmem:
diff --git a/pft.c b/pft.c
index 3ab1457..bbcd7e6 100644
--- a/pft.c
+++ b/pft.c
@@ -739,7 +739,7 @@ alloc_test_memory(void)
         int j;

         if (do_shm) {
-               if (p = alloc_shm(bytes)) {
+               if (p = valloc_shared(bytes)) {
                         do_mbind(p, bytes);
                         do_noclear(p, bytes);
                 }

> Also, are you running or are you aware of any other tools/tests available for
> shmem that we can use to make sure we do not introduce any regressions?

I did run the mm selftest cases, as well as some testing cases I wrote 
for anon shmem.

