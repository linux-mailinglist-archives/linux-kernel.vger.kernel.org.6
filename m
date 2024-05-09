Return-Path: <linux-kernel+bounces-174077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 845D58C09FD
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 05:09:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A7D01F22616
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 03:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CD71146D42;
	Thu,  9 May 2024 03:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="izWZFXSD"
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85D113C3D3
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 03:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715224136; cv=none; b=PS0kuJipwqFB5XcdUYCY1P0fSUEBd0pIKAaFie6DcTdUT9BK71RoKv7QPONIIxeXfUuAFp2sX4HiVS3wwOyieQYfLF2Irktb7gUd1O7x0g9AVGyIsdojHBhpTVldg4OQ3OzdOIs9/7+wFW+QyGAV2xW/O7t4oGbLFK6cnacapsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715224136; c=relaxed/simple;
	bh=+viQcmRhjEvQ/mJCxM2OIlarFQs1cpr8hD+N0a8ZWkI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nqYWSZwkKod9I+4vXOLaRgtfK5XwPV7z96/Pj4vLSFdDm1FMj09reqyO/5D/HgqXLvucZc809lcCDgJwIhVSc1+WnjFn2l1cQys2qFai0zmURpmFU2Kipon/G30dCfKZCAMhssqHFvkkxWtHxmchz1pH55m64tCd6BwWlUTJ1fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=izWZFXSD; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1715224130; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=5EkEQoIaR256h7mVAdSvV5iKLkBhUyOBOqXGs/IWo7k=;
	b=izWZFXSDdlhLAWhJ6OB03C0TKgQoPhP60Ky5WfQsnHexrWAO2xkOeRjpFtweceYRObJVVCNucAlDO4ITG16Dxk6LBdbZqFNQ5PBbpqP7ToLyFw5zYHWPbPWM9Sq4r1d8aG9OISRdyHCjhuYdpLKEwqRSif9o8dysPHSNNl6fCG0=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033022160150;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0W65KgZQ_1715224127;
Received: from 30.97.56.60(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W65KgZQ_1715224127)
          by smtp.aliyun-inc.com;
          Thu, 09 May 2024 11:08:48 +0800
Message-ID: <15314a86-5d9a-4fb4-a0f6-8b1a56764aad@linux.alibaba.com>
Date: Thu, 9 May 2024 11:08:47 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] add mTHP support for anonymous shmem
To: Daniel Gomez <da.gomez@samsung.com>, David Hildenbrand <david@redhat.com>
Cc: "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "hughd@google.com" <hughd@google.com>,
 "willy@infradead.org" <willy@infradead.org>,
 "ioworker0@gmail.com" <ioworker0@gmail.com>,
 "wangkefeng.wang@huawei.com" <wangkefeng.wang@huawei.com>,
 "ying.huang@intel.com" <ying.huang@intel.com>,
 "21cnbao@gmail.com" <21cnbao@gmail.com>,
 "ryan.roberts@arm.com" <ryan.roberts@arm.com>,
 "shy828301@gmail.com" <shy828301@gmail.com>, "ziy@nvidia.com"
 <ziy@nvidia.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <cover.1714978902.git.baolin.wang@linux.alibaba.com>
 <CGME20240508113934eucas1p13a3972f3f9955365f40155e084a7c7d5@eucas1p1.samsung.com>
 <fqtaxc5pgu3zmvbdad4w6xty5iozye7v5z2b5ckqcjv273nz7b@hhdrjwf6rai3>
 <f44dc19a-e117-4418-9114-b723c5dc1178@redhat.com>
 <qye6lbmybiivdrr2vtlwgzzqelp7zoekezgiwo6mpirrl2576z@voszmqjbnm2q>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <qye6lbmybiivdrr2vtlwgzzqelp7zoekezgiwo6mpirrl2576z@voszmqjbnm2q>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/5/8 22:28, Daniel Gomez wrote:
> On Wed, May 08, 2024 at 01:58:19PM +0200, David Hildenbrand wrote:
>> On 08.05.24 13:39, Daniel Gomez wrote:
>>> On Mon, May 06, 2024 at 04:46:24PM +0800, Baolin Wang wrote:
>>>> Anonymous pages have already been supported for multi-size (mTHP) allocation
>>>> through commit 19eaf44954df, that can allow THP to be configured through the
>>>> sysfs interface located at '/sys/kernel/mm/transparent_hugepage/hugepage-XXkb/enabled'.
>>>>
>>>> However, the anonymous shared pages will ignore the anonymous mTHP rule
>>>> configured through the sysfs interface, and can only use the PMD-mapped
>>>> THP, that is not reasonable. Many implement anonymous page sharing through
>>>> mmap(MAP_SHARED | MAP_ANONYMOUS), especially in database usage scenarios,
>>>> therefore, users expect to apply an unified mTHP strategy for anonymous pages,
>>>> also including the anonymous shared pages, in order to enjoy the benefits of
>>>> mTHP. For example, lower latency than PMD-mapped THP, smaller memory bloat
>>>> than PMD-mapped THP, contiguous PTEs on ARM architecture to reduce TLB miss etc.
>>>>
>>>> The primary strategy is similar to supporting anonymous mTHP. Introduce
>>>> a new interface '/mm/transparent_hugepage/hugepage-XXkb/shmem_enabled',
>>>> which can have all the same values as the top-level
>>>> '/sys/kernel/mm/transparent_hugepage/shmem_enabled', with adding a new
>>>> additional "inherit" option. By default all sizes will be set to "never"
>>>> except PMD size, which is set to "inherit". This ensures backward compatibility
>>>> with the shmem enabled of the top level, meanwhile also allows independent
>>>> control of shmem enabled for each mTHP.
>>>
>>> I'm trying to understand the adoption of mTHP and how it fits into the adoption
>>> of (large) folios that the kernel is moving towards. Can you, or anyone involved
>>> here, explain this? How much do they overlap, and can we benefit from having
>>> both? Is there any argument against the adoption of large folios here that I
>>> might have missed?
>>
>> mTHP are implemented using large folios, just like traditional PMD-sized THP
>> are. (you really should explore the history of mTHP and how it all works
>> internally)
> 
> I'll check more in deep the code. By any chance are any of you going to be at
> LSFMM this year? I have this session [1] scheduled for Wednesday and it would
> be nice to get your feedback on it and if you see this working together with
> mTHP/THP.
> 
> [1] https://lore.kernel.org/all/4ktpayu66noklllpdpspa3vm5gbmb5boxskcj2q6qn7md3pwwt@kvlu64pqwjzl/

Great. I'm also interested in tmpfs support for large folios (or mTHP), 
so please CC me if you plan to send a new version.

As David mentioned, this patchset is mainly about adding mTHP support 
for anonymous shmem, and I think that some of the swap support for large 
folios could work together.

