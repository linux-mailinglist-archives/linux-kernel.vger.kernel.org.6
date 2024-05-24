Return-Path: <linux-kernel+bounces-188271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D79D98CDFE8
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 05:41:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 068671C222FB
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 03:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 565E9376E4;
	Fri, 24 May 2024 03:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="RaYF9tzj"
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E61A2F50A
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 03:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716522061; cv=none; b=bt+ycRxffHimc/PA52/AZd592nYSgx/VmAVrqBB//3kEJdGSE+hPfVpnrLpPE9ABFGqgtNT/ELvO4M+cXqlGu/s4ajEJiN1b3uA+kC3eKzDIZW6pz/jWnkpvPIEo3+WK8ANT5FKQFGMEoJC5C18k7mB/S1jKuuv1GF+fsRYLLqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716522061; c=relaxed/simple;
	bh=vgXOu/zmlMUS9NL8gsOaAG3ZZfawnlaAzNA/vrKoLMY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hlkOPHC8mMSNtsU3Nlet56l+8FRH1pp4mBJpadid00K4VAL9ypknbFdnYwQpYPCe+JRwDHlTbVAJd0lwNhId3Yj9zC33VYPxBeu1rrEhnJDh3dJdVDN6INI4iI6vv5Fi5Be8mvROH2iYTPgS7IkpAlGYCmXFxSPksvAr95kLAF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=RaYF9tzj; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1716522056; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=6/UZ2+cAO5LwgqyUyoJz3cM9YsqKmDTGWP10HkryRFU=;
	b=RaYF9tzjO4JLDOkYJ4Ba2PPkv7sng9z4VIxMH0e/FjfDEJFK19/7jKLoXpTFHF13vK+5duNCsDra+odUVNo1TWvneR9GJWKXJXM9gtCXWUwrWh4faL5eD2n0mrmccPQxuE2IByV32y6IbNDJ0DadQxDtdPRLrjlKJ7u8VEm70pI=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R411e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045075189;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0W74cpp8_1716522053;
Received: from 30.97.56.65(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W74cpp8_1716522053)
          by smtp.aliyun-inc.com;
          Fri, 24 May 2024 11:40:55 +0800
Message-ID: <0ae77b66-c919-4dfe-9b3c-741b52643257@linux.alibaba.com>
Date: Fri, 24 May 2024 11:40:53 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: arm64: Fix the out-of-bounds issue in
 contpte_clear_young_dirty_ptes
To: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Barry Song <v-songbaohua@oppo.com>, Lance Yang <ioworker0@gmail.com>,
 Ryan Roberts <ryan.roberts@arm.com>, David Hildenbrand <david@redhat.com>,
 Jeff Xie <xiehuan09@gmail.com>, Kefeng Wang <wangkefeng.wang@huawei.com>,
 Michal Hocko <mhocko@suse.com>, Minchan Kim <minchan@kernel.org>,
 Muchun Song <songmuchun@bytedance.com>, Peter Xu <peterx@redhat.com>,
 Yang Shi <shy828301@gmail.com>, Yin Fengwei <fengwei.yin@intel.com>,
 Zach O'Keefe <zokeefe@google.com>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
References: <20240524005444.135417-1-21cnbao@gmail.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20240524005444.135417-1-21cnbao@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/5/24 08:54, Barry Song wrote:
> From: Barry Song <v-songbaohua@oppo.com>
> 
> We are passing a huge nr to __clear_young_dirty_ptes() right
> now. While we should pass the number of pages, we are actually
> passing CONT_PTE_SIZE. This is causing lots of crashes of
> MADV_FREE, panic oops could vary everytime.
> 
> Fixes: 89e86854fb0a ("mm/arm64: override clear_young_dirty_ptes() batch helper")
> Cc: Lance Yang <ioworker0@gmail.com>
> Cc: Barry Song <21cnbao@gmail.com>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Jeff Xie <xiehuan09@gmail.com>
> Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: Muchun Song <songmuchun@bytedance.com>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Yang Shi <shy828301@gmail.com>
> Cc: Yin Fengwei <fengwei.yin@intel.com>
> Cc: Zach O'Keefe <zokeefe@google.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>

Good catch. Feel free to add:
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

> ---
>   arch/arm64/mm/contpte.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/mm/contpte.c b/arch/arm64/mm/contpte.c
> index 9f9486de0004..a3edced29ac1 100644
> --- a/arch/arm64/mm/contpte.c
> +++ b/arch/arm64/mm/contpte.c
> @@ -376,7 +376,7 @@ void contpte_clear_young_dirty_ptes(struct vm_area_struct *vma,
>   	 * clearing access/dirty for the whole block.
>   	 */
>   	unsigned long start = addr;
> -	unsigned long end = start + nr;
> +	unsigned long end = start + nr * PAGE_SIZE;
>   
>   	if (pte_cont(__ptep_get(ptep + nr - 1)))
>   		end = ALIGN(end, CONT_PTE_SIZE);
> @@ -386,7 +386,7 @@ void contpte_clear_young_dirty_ptes(struct vm_area_struct *vma,
>   		ptep = contpte_align_down(ptep);
>   	}
>   
> -	__clear_young_dirty_ptes(vma, start, ptep, end - start, flags);
> +	__clear_young_dirty_ptes(vma, start, ptep, (end - start) / PAGE_SIZE, flags);
>   }
>   EXPORT_SYMBOL_GPL(contpte_clear_young_dirty_ptes);
>   

