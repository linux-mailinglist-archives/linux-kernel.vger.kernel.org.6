Return-Path: <linux-kernel+bounces-241933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B9B192817E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 07:47:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAB1D285DD9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 05:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4243F73469;
	Fri,  5 Jul 2024 05:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="VmvVsvFH"
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C714225CB
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 05:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720158465; cv=none; b=KLlSsyd/HoeB7PoLr4edvfXF+ua8n2D/KjnEscxphDNaMqc+62EfAV5iE6K99sXK2IfOm/xm77YrwvSQbY+tRib6OEgF0a0IZ1UXuoYqfNKBA6PtcuhJIuw7pYzF6n6+DVCFXbz3nYBqIoLaP2hjgqtzmGoMgd2sjQwHorkjz2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720158465; c=relaxed/simple;
	bh=+Mq9I+DXkuvzGrQQfmuECJOhm2fF8qxp45ga50csDXk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gI0VsYkyX34zEkHgmkr2Ikoxxoq68i1JF5WXe0w8lE0Q72qr59UdE92NhMAHHaamIa6Ke96dyXYV/cJaYYnysz66nlIz9k630ah7eGhGbqcllvnxxpvZLNxPUH5ltQg20Yr5eJlosl3HpapPacYwWj3wSOjkQtVHpbv8sx9vTgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=VmvVsvFH; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1720158460; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=aTMIFrktR6P6sKfiFco3hO79I2IAEdcVXmBy69Wcmgk=;
	b=VmvVsvFHFK3fz3lFcs3RWcLKgoYFloz+yiRMxTUxDG4VRJEylxhxcH1ArV5btAXzrR6mGfctb2xV+b3oGIM4zEBCGAckWkij2lAOx2xZTaZU80lmaPIx9FzR3Iz9EKOPi7R3/HrK6iGqmm7eoRbqiRBCQJRn1Ej68B8e7N48M84=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067112;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0W9tt65s_1720158457;
Received: from 30.97.56.65(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W9tt65s_1720158457)
          by smtp.aliyun-inc.com;
          Fri, 05 Jul 2024 13:47:38 +0800
Message-ID: <e08b8245-bc8c-4a18-a1e0-53a139258826@linux.alibaba.com>
Date: Fri, 5 Jul 2024 13:47:37 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/6] add mTHP support for anonymous shmem
To: Matthew Wilcox <willy@infradead.org>, David Hildenbrand <david@redhat.com>
Cc: akpm@linux-foundation.org, hughd@google.com, wangkefeng.wang@huawei.com,
 ying.huang@intel.com, 21cnbao@gmail.com, ryan.roberts@arm.com,
 shy828301@gmail.com, ziy@nvidia.com, ioworker0@gmail.com,
 da.gomez@samsung.com, p.raghav@samsung.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <cover.1718090413.git.baolin.wang@linux.alibaba.com>
 <ZobtTmzj0AmNXcav@casper.infradead.org>
 <27beaa0e-697e-4e30-9ac6-5de22228aec1@redhat.com>
 <6d4c0191-18a9-4c8f-8814-d4775557383e@redhat.com>
 <Zob8xI-LWe9H_iJs@casper.infradead.org>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <Zob8xI-LWe9H_iJs@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/7/5 03:49, Matthew Wilcox wrote:
> On Thu, Jul 04, 2024 at 09:19:10PM +0200, David Hildenbrand wrote:
>> On 04.07.24 21:03, David Hildenbrand wrote:
>>>> shmem has two uses:
>>>>
>>>>     - MAP_ANONYMOUS | MAP_SHARED (this patch set)
>>>>     - tmpfs
>>>>
>>>> For the second use case we don't want controls *at all*, we want the
>>>> same heiristics used for all other filesystems to apply to tmpfs.
>>>
>>> As discussed in the MM meeting, Hugh had a different opinion on that.
>>
>> FWIW, I just recalled that I wrote a quick summary:
>>
>> https://lkml.kernel.org/r/f1783ff0-65bd-4b2b-8952-52b6822a0835@redhat.com
>>
>> I believe the meetings are recorded as well, but never looked at recordings.
> 
> That's not what I understood Hugh to mean.  To me, it seemed that Hugh
> was expressing an opinion on using shmem as shmem, not as using it as
> tmpfs.
> 
> If I misunderstood Hugh, well, I still disagree.  We should not have
> separate controls for this.  tmpfs is just not that special.

But now we already have a PMD-mapped THP control for tmpfs, and mTHP 
simply extends this control to per-size.

IIUC, as David mentioned before, for tmpfs, mTHP should act like a huge 
order filter which should be respected by the expected huge orders in 
the write() and fallocate() paths. This would also solve the issue of 
allocating huge orders in writable mmap() path for tmpfs, as well as 
unifying the interface.

Anyway, I will try to provide an RFC to discuss the mTHP for tmpfs approach.

