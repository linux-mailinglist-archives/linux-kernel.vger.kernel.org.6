Return-Path: <linux-kernel+bounces-220736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6311090E66C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 10:59:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0A5F282EBC
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 08:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A8207D3F4;
	Wed, 19 Jun 2024 08:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="l1o2YWLf"
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071E27D07E
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 08:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718787548; cv=none; b=pWysKWm3igdAeEaxpfoDpetewPtaA3Qy5omEVwtBabfqS+wW46OXcsM2zfWxAUvuup3RUMwh0khSAzcNp/hZZ64bJTLjbXGEtLZkDYZx3c/aG7e6VRQf2DOk8Gdmg6NZxTiX8QmoaPyxdx6kAUqx49V4aXAZi4VX8bALitLgUc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718787548; c=relaxed/simple;
	bh=t0boIn5eit1OaiyyR3la17Fctl9PaTxCsQ7Bu/ixINg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q5FhOy9o6iOOfe/uEOeRRDTv65aDOOhMQyVnKeUJl9ZYJyoOtbhFQew2yKl80Qph5MwHN6XDcPeBhBs73KdcUJR5AM0D1G6MVwWNiqSM0OStBTKOIsaTnd5xjH+ETP+rQvAZUEbRzR7VmSWQKNYBLWSyzRpau2K+lajLRbvYtDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=l1o2YWLf; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718787538; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=cMqTDD3Eoy+/cRDy+tO1+Stw3D+Z2rha9T8EUPBjcng=;
	b=l1o2YWLfN4Otpp/KQuD/igmy8nYxgfP6nSMAhFfjruEWN3Y0JrqXoESeekAJ0w/KxC+cqhZtbxalnxvU4kHv2/tkYIpGU7uNP7/wSc1ecpQ7kHaFecxFIR66bwuAaaBpcWojBpY3PsXIG/1rgjrRORI8KJjQseiOdzGXRiMEeUc=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R461e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032014031;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0W8nfcRp_1718787535;
Received: from 30.97.56.56(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W8nfcRp_1718787535)
          by smtp.aliyun-inc.com;
          Wed, 19 Jun 2024 16:58:56 +0800
Message-ID: <6f133631-7895-46ae-b933-68627f53c866@linux.alibaba.com>
Date: Wed, 19 Jun 2024 16:58:55 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/9] support large folio swap-out and swap-in for shmem
To: Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: willy@infradead.org, david@redhat.com, wangkefeng.wang@huawei.com,
 chrisl@kernel.org, ying.huang@intel.com, 21cnbao@gmail.com,
 ryan.roberts@arm.com, shy828301@gmail.com, ziy@nvidia.com,
 ioworker0@gmail.com, da.gomez@samsung.com, p.raghav@samsung.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1718690645.git.baolin.wang@linux.alibaba.com>
 <20240618130538.ffab3ce1b4e66e3ba095d8cf@linux-foundation.org>
 <475f0f2c-afc7-4225-809f-93c93f45c830@linux.alibaba.com>
 <2683b71d-aebd-5527-348c-18c0e021b653@google.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <2683b71d-aebd-5527-348c-18c0e021b653@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/6/19 16:16, Hugh Dickins wrote:
> On Wed, 19 Jun 2024, Baolin Wang wrote:
>> On 2024/6/19 04:05, Andrew Morton wrote:
>>> On Tue, 18 Jun 2024 14:54:12 +0800 Baolin Wang
>>> <baolin.wang@linux.alibaba.com> wrote:
>>>
>>>> Shmem will support large folio allocation [1] [2] to get a better
>>>> performance,
>>>> however, the memory reclaim still splits the precious large folios when
>>>> trying
>>>> to swap-out shmem, which may lead to the memory fragmentation issue and can
>>>> not
>>>> take advantage of the large folio for shmeme.
>>>>
>>>> Moreover, the swap code already supports for swapping out large folio
>>>> without
>>>> split, and large folio swap-in[3] series is queued into mm-unstable branch.
>>>> Hence this patch set also supports the large folio swap-out and swap-in for
>>>> shmem.
>>>
>>> I'll add this to mm-unstable for some exposure, but I wonder how much
>>> testing it will have recieved by the time the next merge window opens?
>>
>> Thanks Andrew. I am fine with this series going to 6.12 if you are concerned
>> about insufficient testing (and let's also wait for Hugh's comments). Since we
>> (Daniel and I) have some follow-up patches that will rely on this swap series,
>> hope this series can be tested as extensively as possible to ensure its
>> stability in the mm branch.
> 
> Thanks for giving it the exposure, Andrew, but please drop it from
> mm-unstable until the next cycle. I'd been about to write to say I
> wouldn't be trying it until next cycle, when your mm-commits came in:
> so I thought I ought at least to give mm-everything-2024-06-18 a try.
> 
> Baolin may have fixed stuff, but he (or the interaction with other mm
> work) has broken stuff too: I couldn't get as far with it as with the
> previous version. Just "cp -a" of a kernel source tree into a tmpfs
> huge=always size=<bigenough> failed with lots of ENOSPCs, and when
> "rm -rf"ed lots of WARN_ON(inode->i_blocks) from shmem_evict_inode();
> and on second attempt, then a VM_BUG_ON_FOLIO(!folio_contains) from
> find_lock_entries().

Thanks Hugh for giving it a try. I also can reproduce the 
WARN_ON(inode->i_blocks) issue with today's mm-unstable branch (sadly, 
this issue didn't occur in the older mm-unstable branch), and now I have 
a fix in my local tree. But I will not send out a V3 so quickly, and I 
agree we can drop this series from mm-unstable branch until next cycle.

> Or maybe that VM_BUG_ON_FOLIO() was unrelated, but a symptom of the bug

I did not encounter the VM_BUG_ON_FOLIO() issue, but let me try your 
testing case...

> I'm trying to chase even when this series is reverted: some kind of page
> double usage, manifesting as miscellaneous "Bad page"s and VM_BUG_ONs,
> mostly from page reclaim or from exit_mmap(). I'm still getting a feel
> for it, maybe it occurs soon enough for a reliable bisection, maybe not.
> 
> (While writing, a run with mm-unstable cut off at 2a9964cc5d27,
> drop KSM_KMEM_CACHE(), instead of reverting just Baolin's latest,
> has not yet hit any problem: too early to tell but promising.)
> 
> And before 2024-06-18, I was working on mm-everything-2024-06-15 minus
> Chris Li's mTHP swap series: which worked fairly well, until it locked
> up with __try_to_reclaim_swap()'s filemap_get_folio() spinning around
> on a page with 0 refcount, while a page table lock is held which one
> by one the other CPUs come to want for reclaim. On two machines.
> 
> None of these problems seen on Stephen's last next-2024-06-13.
> I had wanted to see if mm-everything-2024-06-18 fixed that lockup,
> but with the new problems I cannot tell (or it could all be the same
> problem: but if so, odd that it manifests consistently differently).
> 
> There are way too many mTHP shmem and swap patch series floating
> around at the moment, in mm and in fs, for me to cope with:
> everyone, please slow down and test more.

Sure. I will continue to do more testing. Thanks.

