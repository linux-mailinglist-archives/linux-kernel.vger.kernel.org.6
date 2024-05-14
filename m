Return-Path: <linux-kernel+bounces-178350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9B778C4C69
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 08:41:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15E611C20B44
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 06:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B4FBE541;
	Tue, 14 May 2024 06:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="JRvbgVHn"
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2A9386
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 06:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715668902; cv=none; b=jgFKbXePa3y25NKlIzngJK3dnUVwPoSwOh0pqavmlkCVrhHnonA0v9FDYtFdz/vnRd3ILWM7jN0RtnqR985AqQJGhiECcfJCNwCrpmsnSwhRqWfAVhZFC869+jN5XffacZryH10wZvNrQPQnmx6Ldb/y3rkXwsq5bZrxtjSfJzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715668902; c=relaxed/simple;
	bh=lnFsYaVZ9mk+akNFRVvwXwFr24R9BjCu6nIkuWkhF6k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hFPazaMMDerrXDN0fMrRwErrAKGXA2ECNFmIBSGvmK4jKwUZQIIDXfpLWLjAPX1TC8DOvZ8YzQNip4aRMIKQiI5EXD/JKnlNgIC6ypl7Pf/4Rk00TMig24sywc5C9gipIy8ahoW1E6E6JauYFDEIHoH5s2T7VKmKwB575qpCoQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=JRvbgVHn; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1715668890; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=qq9BIghgoJ+LZ1XpMSxI2larmjAnvQoJQ/47VqjuHhc=;
	b=JRvbgVHnVOCOxk+LgcNUGZjP8LE9HWYrqeeUvbc63kjUEKPW05as9t+dUypSHwCq1+Si61jgtotiPYW26ESh6dg1yT+CmANLGRXnVMXPIGJk477hEVzplODvGVI1QTexoLjWtk3sTPBCc/19bLMG4PJYmvL6kXZOePvK3X8Yu0E=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045046011;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0W6TyffK_1715668887;
Received: from 30.97.56.67(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W6TyffK_1715668887)
          by smtp.aliyun-inc.com;
          Tue, 14 May 2024 14:41:28 +0800
Message-ID: <f22c9fc8-2356-46c6-ac8e-dc97328d7fcc@linux.alibaba.com>
Date: Tue, 14 May 2024 14:41:27 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v5 3/4] mm/mlock: check for THP missing the mlock
 in try_to_unmap_one()
To: Lance Yang <ioworker0@gmail.com>, akpm@linux-foundation.org
Cc: willy@infradead.org, sj@kernel.org, maskray@google.com, ziy@nvidia.com,
 ryan.roberts@arm.com, david@redhat.com, 21cnbao@gmail.com, mhocko@suse.com,
 fengwei.yin@intel.com, zokeefe@google.com, shy828301@gmail.com,
 xiehuan09@gmail.com, libang.li@antgroup.com, wangkefeng.wang@huawei.com,
 songmuchun@bytedance.com, peterx@redhat.com, minchan@kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240513074712.7608-1-ioworker0@gmail.com>
 <20240513074712.7608-4-ioworker0@gmail.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20240513074712.7608-4-ioworker0@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/5/13 15:47, Lance Yang wrote:
> The TTU_SPLIT_HUGE_PMD will no longer perform immediately, so we might
> encounter a PMD-mapped THP missing the mlock in the VM_LOCKED range
> during the pagewalk. It's likely necessary to mlock this THP to prevent
> it from being picked up during page reclaim.
> 
> Suggested-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Signed-off-by: Lance Yang <ioworker0@gmail.com>

IMO, this patch should be merged into patch 2, otherwise patch 2 is 
buggy. Quote the description in the 'submission patches.rst' document:

"When dividing your change into a series of patches, take special care 
to ensure that the kernel builds and runs properly after each patch in 
the series.  Developers using ``git bisect`` to track down a problem can 
end up splitting your patch series at any point; they will not thank you 
if you introduce bugs in the middle."

> ---
>   mm/rmap.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 4c4d14325f2e..08a93347f283 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1671,7 +1671,8 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
>   		if (!(flags & TTU_IGNORE_MLOCK) &&
>   		    (vma->vm_flags & VM_LOCKED)) {
>   			/* Restore the mlock which got missed */
> -			if (!folio_test_large(folio))
> +			if (!folio_test_large(folio) ||
> +			    (!pvmw.pte && (flags & TTU_SPLIT_HUGE_PMD)))
>   				mlock_vma_folio(folio, vma);
>   			goto walk_done_err;
>   		}

