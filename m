Return-Path: <linux-kernel+bounces-242130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF680928400
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 10:45:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4EA82821CD
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 08:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67DD5145B21;
	Fri,  5 Jul 2024 08:45:13 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC4DE1369B1
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 08:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720169113; cv=none; b=SrwLCf8vDfAOM6NNLbm6/yUh9AZNs0QOXQ2zbx1RmhGg2hSEz+PmKoh9Cnwf1NF8vAzF1MRsKUmpKeXFjiKwi1i3cKj7JduXeIXbiAQWhRLcopd8s309vB67lOO/Byzly774mJcLG/+zexahKIS2fbSyR5J5q2ftTpvZS8P71SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720169113; c=relaxed/simple;
	bh=2w7iHu1KEP5gDudvo5LuWqEuiJkAK+H6JXecn9APbZs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IUd+H9n6wyr0M8qNr59bDme9PVQohguHVG+WWDCDuAuD8yv5xsmVj9c5NV2a47SSngm51/Ee2Efb/sA9u2QQ1E+gTGHYXTjqfR1NSAftxnHTDfOMeNqHbAW4xdZHBVLRvXwK9qWUzKuvtrcPqZ6jbc4Aw8tchOtktki/dmEX088=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1CB3E367;
	Fri,  5 Jul 2024 01:45:34 -0700 (PDT)
Received: from [10.57.74.223] (unknown [10.57.74.223])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0FAC73F762;
	Fri,  5 Jul 2024 01:45:06 -0700 (PDT)
Message-ID: <e826368d-499a-483b-8991-8c25aff88f00@arm.com>
Date: Fri, 5 Jul 2024 09:45:05 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/6] add mTHP support for anonymous shmem
Content-Language: en-GB
To: Baolin Wang <baolin.wang@linux.alibaba.com>,
 Matthew Wilcox <willy@infradead.org>, David Hildenbrand <david@redhat.com>
Cc: akpm@linux-foundation.org, hughd@google.com, wangkefeng.wang@huawei.com,
 ying.huang@intel.com, 21cnbao@gmail.com, shy828301@gmail.com,
 ziy@nvidia.com, ioworker0@gmail.com, da.gomez@samsung.com,
 p.raghav@samsung.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1718090413.git.baolin.wang@linux.alibaba.com>
 <ZobtTmzj0AmNXcav@casper.infradead.org>
 <27beaa0e-697e-4e30-9ac6-5de22228aec1@redhat.com>
 <6d4c0191-18a9-4c8f-8814-d4775557383e@redhat.com>
 <Zob8xI-LWe9H_iJs@casper.infradead.org>
 <e08b8245-bc8c-4a18-a1e0-53a139258826@linux.alibaba.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <e08b8245-bc8c-4a18-a1e0-53a139258826@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 05/07/2024 06:47, Baolin Wang wrote:
> 
> 
> On 2024/7/5 03:49, Matthew Wilcox wrote:
>> On Thu, Jul 04, 2024 at 09:19:10PM +0200, David Hildenbrand wrote:
>>> On 04.07.24 21:03, David Hildenbrand wrote:
>>>>> shmem has two uses:
>>>>>
>>>>>     - MAP_ANONYMOUS | MAP_SHARED (this patch set)
>>>>>     - tmpfs
>>>>>
>>>>> For the second use case we don't want controls *at all*, we want the
>>>>> same heiristics used for all other filesystems to apply to tmpfs.
>>>>
>>>> As discussed in the MM meeting, Hugh had a different opinion on that.
>>>
>>> FWIW, I just recalled that I wrote a quick summary:
>>>
>>> https://lkml.kernel.org/r/f1783ff0-65bd-4b2b-8952-52b6822a0835@redhat.com
>>>
>>> I believe the meetings are recorded as well, but never looked at recordings.
>>
>> That's not what I understood Hugh to mean.  To me, it seemed that Hugh
>> was expressing an opinion on using shmem as shmem, not as using it as
>> tmpfs.
>>
>> If I misunderstood Hugh, well, I still disagree.  We should not have
>> separate controls for this.  tmpfs is just not that special.

I wasn't at the meeting that's being referred to, but I thought we previously
agreed that tmpfs *is* special because in some configurations its not backed by
swap so is locked in ram?

> 
> But now we already have a PMD-mapped THP control for tmpfs, and mTHP simply
> extends this control to per-size.
> 
> IIUC, as David mentioned before, for tmpfs, mTHP should act like a huge order
> filter which should be respected by the expected huge orders in the write() and
> fallocate() paths. This would also solve the issue of allocating huge orders in
> writable mmap() path for tmpfs, as well as unifying the interface.
> 
> Anyway, I will try to provide an RFC to discuss the mTHP for tmpfs approach.


