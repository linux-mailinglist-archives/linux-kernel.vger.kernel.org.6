Return-Path: <linux-kernel+bounces-220767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E359B90E6C7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 11:20:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C7DB1F21B47
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 09:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC68981219;
	Wed, 19 Jun 2024 09:18:03 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 686BE7FBA2
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 09:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718788683; cv=none; b=f4QpeLeCjulYR3CJY9hDwPqWg8zjFtAyV06ccWbanFdDaXlDPFF4nlVqYMeMoxisohwV+z+CuD8LW6GiM9CHM7oM1k/WaFJAsrpUfELIXK6YxCIH82WH+EaTSF+uyqQpEXrq5ZOvyYV77a5xB0Lj9z6e0j4pqXig2mQDqKz/5xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718788683; c=relaxed/simple;
	bh=ubHO/e4RQHzqMr1rBGsnG3SMu6ypec3VVa+saJ5rmv4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hiF6MtAhTYiH6XNN7RfvBl3frrTM/xUG2bEK79AwZfMvLW74aj9OjBvruwRe1SGpyb3sDhdxLEBsgiOgCLY+o9amUimUW1SuUkyJ57b+rBw7nHPOo+bJUYJ2h9c3k7XEawaIVz49yg77xCltkauAPEn5+9QhnkkrGwj7jIBuTp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 828A1DA7;
	Wed, 19 Jun 2024 02:18:24 -0700 (PDT)
Received: from [10.1.36.163] (XHFQ2J9959.cambridge.arm.com [10.1.36.163])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3F1CE3F7B4;
	Wed, 19 Jun 2024 02:17:58 -0700 (PDT)
Message-ID: <48859779-45ba-445d-8ce0-486575a3fd7b@arm.com>
Date: Wed, 19 Jun 2024 10:17:56 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 0/5] Alternative mTHP swap allocator improvements
Content-Language: en-GB
To: Barry Song <baohua@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>,
 Kairui Song <kasong@tencent.com>, "Huang, Ying" <ying.huang@intel.com>,
 Kalesh Singh <kaleshsingh@google.com>, Hugh Dickins <hughd@google.com>,
 David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, Shuai Yuan <yuanshuai@oppo.com>
References: <20240618232648.4090299-1-ryan.roberts@arm.com>
 <CAGsJ_4wx2WD+Msjhqqy7CK1gNGAQ2LGjuM5x_bNdXUOeGsz3xw@mail.gmail.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <CAGsJ_4wx2WD+Msjhqqy7CK1gNGAQ2LGjuM5x_bNdXUOeGsz3xw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 19/06/2024 10:11, Barry Song wrote:
> On Wed, Jun 19, 2024 at 11:27 AM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>
>> Hi All,
>>
>> Chris has been doing great work at [1] to clean up my mess in the mTHP swap
>> entry allocator. But Barry posted a test program and results at [2] showing that
>> even with Chris's changes, there are still some fallbacks (around 5% - 25% in
>> some cases). I was interested in why that might be and ended up putting this PoC
>> patch set together to try to get a better understanding. This series ends up
>> achieving 0% fallback, even with small folios ("-s") enabled. I haven't done
>> much testing beyond that (yet) but thought it was worth posting on the strength
>> of that result alone.
>>
>> At a high level this works in a similar way to Chris's series; it marks a
>> cluster as being for a particular order and if a new cluster cannot be allocated
>> then it scans through the existing non-full clusters. But it does it by scanning
>> through the clusters rather than assembling them into a list. Cluster flags are
>> used to mark clusters that have been scanned and are known not to have enough
>> contiguous space, so the efficiency should be similar in practice.
>>
>> Because its not based around a linked list, there is less churn and I'm
>> wondering if this is perhaps easier to review and potentially even get into
>> v6.10-rcX to fix up what's already there, rather than having to wait until v6.11
>> for Chris's series? I know Chris has a larger roadmap of improvements, so at
>> best I see this as a tactical fix that will ultimately be superseeded by Chris's
>> work.
>>
>> There are a few differences to note vs Chris's series:
>>
>> - order-0 fallback scanning is still allowed in any cluster; the argument in the
>>   past was that swap should always use all the swap space, so I've left this
>>   mechanism in. It is only a fallback though; first the the new per-order
>>   scanner is invoked, even for order-0, so if there are free slots in clusters
>>   already assigned for order-0, then the allocation will go there.
>>
>> - CPUs can steal slots from other CPU's current clusters; those clusters remain
>>   scannable while they are current for a CPU and are only made unscannable when
>>   no more CPUs are scanning that particular cluster.
>>
>> - I'm preferring to allocate a free cluster ahead of per-order scanning, since,
>>   as I understand it, the original intent of a per-cpu current cluster was to
>>   get pages for an application adjacent in the swap to speed up IO.
>>
>> I'd be keen to hear if you think we could get something like this into v6.10 to
>> fix the mess - I'm willing to work quickly to address comments and do more
>> testing. If not, then this is probably just a distraction and we should
>> concentrate on Chris's series.
> 
> Ryan, thank you very much for accomplishing this.
> 
> I am getting Shuai Yuan's (CC'd) help to collect the latency histogram of
> add_to_swap() for both your approach and Chris's. I will update you with
> the results ASAP.

Ahh great - look forward to the results!

> 
> I am also anticipating Chris's V3, as V1 seems quite stable, but V2 has
> caused a couple of crashes.
> 
>>
>> This applies on top of v6.10-rc4.
>>
>> [1] https://lore.kernel.org/linux-mm/20240614-swap-allocator-v2-0-2a513b4a7f2f@kernel.org/
>> [2] https://lore.kernel.org/linux-mm/20240615084714.37499-1-21cnbao@gmail.com/
>>
>> Thanks,
>> Ryan
>>
>> Ryan Roberts (5):
>>   mm: swap: Simplify end-of-cluster calculation
>>   mm: swap: Change SWAP_NEXT_INVALID to highest value
>>   mm: swap: Track allocation order for clusters
>>   mm: swap: Scan for free swap entries in allocated clusters
>>   mm: swap: Optimize per-order cluster scanning
>>
>>  include/linux/swap.h |  18 +++--
>>  mm/swapfile.c        | 164 ++++++++++++++++++++++++++++++++++++++-----
>>  2 files changed, 157 insertions(+), 25 deletions(-)
>>
>> --
>> 2.43.0
>>
> 
> Thanks
> Barry


