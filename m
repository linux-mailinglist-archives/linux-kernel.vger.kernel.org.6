Return-Path: <linux-kernel+bounces-336498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B7D983B82
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 05:25:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE329B226B9
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 03:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 140E71805A;
	Tue, 24 Sep 2024 03:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="RB3NW0sl"
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7608A1A270
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 03:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727148316; cv=none; b=KMvAWUhs3kW0WMdzhVlW9XLvUtVHaxM5MzG3cY0SVOrXqMnjcP63TlySYjsXEuCojVGC0KtbNDPGztDkiNaIwAyVhbNneWHlPKaqzaRmTyt1My5r8hsFKDn9MF2npFD46aDWVQ+gkez6tVEBN6R5oldKxONWcfVXxoiZKpTtK0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727148316; c=relaxed/simple;
	bh=3n76I9EKpWg3hUf7TGZctF9Wa2N1dL4NmZc4zKhmtwo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QgNpCSHehpRBVfgNakRkh72PNq97P+ZL/pj5S2vjaqsrLmD3LDsfzfA5rgayy9NFdQsxerGQ2lc0IyjWpo7+deXQSSVrQSil+453RHN7lMxBVw9LWOWatYeS8cNt253uW+yPzIz9SLKVZFQhxiT0epWw+7JyI3HpEH0qcSE41rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=RB3NW0sl; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1727148311; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=gy4Xw5HcATj18wlOUR8GQnhv7MlnSmGkVGDSvlC2JMo=;
	b=RB3NW0slL+bK1ntpEz0ZOKy0ROslnY9grjxht8YJkIfwcFWZLoLarHgY5RhujD5NkzloV2hSvWwRq6Gd4elh61Kw5oMoNGPXofKcp6KqumoZy9/IhM+9HbVBZhy+DF22MIimotL2Ng8u9eXkGBhjpnhISY+6roEulkvwpMedvNo=
Received: from 30.74.144.117(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WFeKxuu_1727148308)
          by smtp.aliyun-inc.com;
          Tue, 24 Sep 2024 11:25:09 +0800
Message-ID: <9a110f20-42ad-468b-96c6-683e162452a9@linux.alibaba.com>
Date: Tue, 24 Sep 2024 11:25:08 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/2] remove SWAP_MAP_SHMEM
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org,
 hannes@cmpxchg.org, hughd@google.com, shakeel.butt@linux.dev,
 ryan.roberts@arm.com, ying.huang@intel.com, chrisl@kernel.org,
 david@redhat.com, kasong@tencent.com, willy@infradead.org,
 viro@zeniv.linux.org.uk, baohua@kernel.org, chengming.zhou@linux.dev,
 linux-mm@kvack.org, kernel-team@meta.com, linux-kernel@vger.kernel.org
References: <20240923231142.4155415-1-nphamcs@gmail.com>
 <4d38c65d-760c-43a5-bb47-8e0235c13a51@linux.alibaba.com>
 <CAJD7tkamKcaqHR5V+4+9ixmFc3dC2NnGcu7YzdXqxqNEe8FqqA@mail.gmail.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <CAJD7tkamKcaqHR5V+4+9ixmFc3dC2NnGcu7YzdXqxqNEe8FqqA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/9/24 10:15, Yosry Ahmed wrote:
> On Mon, Sep 23, 2024 at 6:55 PM Baolin Wang
> <baolin.wang@linux.alibaba.com> wrote:
>>
>>
>>
>> On 2024/9/24 07:11, Nhat Pham wrote:
>>> The SWAP_MAP_SHMEM state was originally introduced in the commit
>>> aaa468653b4a ("swap_info: note SWAP_MAP_SHMEM"), to quickly determine if a
>>> swap entry belongs to shmem during swapoff.
>>>
>>> However, swapoff has since been rewritten drastically in the commit
>>> b56a2d8af914 ("mm: rid swapoff of quadratic complexity"). Now
>>> having swap count == SWAP_MAP_SHMEM value is basically the same as having
>>> swap count == 1, and swap_shmem_alloc() behaves analogously to
>>> swap_duplicate()
>>>
>>> This RFC proposes the removal of this state and the associated helper to
>>> simplify the state machine (both mentally and code-wise). We will also
>>> have an extra state/special value that can be repurposed (for swap entries
>>> that never gets re-duplicated).
>>>
>>> Another motivation (albeit a bit premature at the moment) is the new swap
>>> abstraction I am currently working on, that would allow for swap/zswap
>>> decoupling, swapoff optimization, etc. The fewer states and swap API
>>> functions there are, the simpler the conversion will be.
>>>
>>> I am sending this series first as an RFC, just in case I missed something
>>> or misunderstood this state, or if someone has a swap optimization in mind
>>> for shmem that would require this special state.
>>
>> The idea makes sense to me. I did a quick test with shmem mTHP, and
>> encountered the following warning which is triggered by
>> 'VM_WARN_ON(usage == 1 && nr > 1)' in __swap_duplicate().
> 
> Apparently __swap_duplicate() does not currently handle increasing the
> swap count for multiple swap entries by 1 (i.e. usage == 1) because it
> does not handle rolling back count increases when
> swap_count_continued() fails.
> 
> I guess this voids my Reviewed-by until we sort this out. Technically
> swap_count_continued() won't ever be called for shmem because we only
> ever increment the count by 1, but there is no way to know this in
> __swap_duplicate() without SWAP_HAS_SHMEM.

Agreed. An easy solution might be to add a new boolean parameter to 
indicate whether the SHMEM swap entry count is increasing?

diff --git a/mm/swapfile.c b/mm/swapfile.c
index cebc244ee60f..21f1eec2c30a 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -3607,7 +3607,7 @@ void si_swapinfo(struct sysinfo *val)
   * - swap-cache reference is requested but the entry is not used. -> 
ENOENT
   * - swap-mapped reference requested but needs continued swap count. 
-> ENOMEM
   */
-static int __swap_duplicate(swp_entry_t entry, unsigned char usage, int nr)
+static int __swap_duplicate(swp_entry_t entry, unsigned char usage, int 
nr, bool shmem)
  {
         struct swap_info_struct *si;
         struct swap_cluster_info *ci;
@@ -3620,7 +3620,7 @@ static int __swap_duplicate(swp_entry_t entry, 
unsigned char usage, int nr)

         offset = swp_offset(entry);
         VM_WARN_ON(nr > SWAPFILE_CLUSTER - offset % SWAPFILE_CLUSTER);
-       VM_WARN_ON(usage == 1 && nr > 1);
+       VM_WARN_ON(usage == 1 && nr > 1 && !shmem);
         ci = lock_cluster_or_swap_info(si, offset);

         err = 0;
@@ -3661,7 +3661,7 @@ static int __swap_duplicate(swp_entry_t entry, 
unsigned char usage, int nr)
                         has_cache = SWAP_HAS_CACHE;
                 else if ((count & ~COUNT_CONTINUED) < SWAP_MAP_MAX)
                         count += usage;
-               else if (swap_count_continued(si, offset + i, count))
+               else if (!shmem && swap_count_continued(si, offset + i, 
count))
                         count = COUNT_CONTINUED;
                 else {
                         /*

