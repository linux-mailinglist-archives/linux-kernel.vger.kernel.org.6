Return-Path: <linux-kernel+bounces-212792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5B9790666D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 10:20:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FA5B1F2570A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 08:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB6E013D507;
	Thu, 13 Jun 2024 08:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="JuEYxjOF"
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970DF13D2B9
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 08:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718266844; cv=none; b=msrKK+wvgEyvMzV/vaxXPTf+b0HugUnPa2I0r/imILSk9Hw4RmP4YsOxP2MXuEJtNnAjB6fadJuqEVc218sd7CdqBL/hESkg5P/1yosZP62cFQUHEq2O/XXUBL3uUtziGuv/3DaWaPuvW8kA2lbNPQIz2odQJE9cF2ynJe6QnJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718266844; c=relaxed/simple;
	bh=orlF50pUCxxA5Usyh9chuvbjIHC8m2eoiF0E/m3gv0A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=akKrVfHk/NRLB7tZsQdmJCPtuEnDQ7d9NgzpYdFD5/aO7kGg73K2sY+NzU7tt+DHMAxvXz5UhkgVA6FDS2xpOOpTQ3b2dM/5djyhMV3+prx68w4pQdTNVhLdH/CLDwQOy38JKIEYviwY65YxHsgYeQ8+fcKlhd4WwovDC49d6oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=JuEYxjOF; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718266839; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=/lFAuOYmr8Us+EmOEoVPRlzvuNvNZ/fszqFE/s0Rh5g=;
	b=JuEYxjOF1U4tB4h+wwSoa1YAzTLpjswX+k2Ehu0gwlae5vI0XnP2a8k2ljEhQ9RrPcvbQmFG+ioZkpI9YUvYrtCoPBDyh16fGErc0sKZlsTQ35+lSJfbP9o3N3GnRPCOUkh19sLJ90OKEJ61IcRi+amE666UsTrM8oOsqzKshLE=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067112;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0W8NU4Xs_1718266836;
Received: from 30.97.56.57(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W8NU4Xs_1718266836)
          by smtp.aliyun-inc.com;
          Thu, 13 Jun 2024 16:20:37 +0800
Message-ID: <d48bcbcc-0935-4d04-b6a8-f1ceec8190bf@linux.alibaba.com>
Date: Thu, 13 Jun 2024 16:20:36 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 4/4] mm/vmscan: avoid split lazyfree THP during
 shrink_folio_list()
To: Lance Yang <ioworker0@gmail.com>, akpm@linux-foundation.org
Cc: 21cnbao@gmail.com, david@redhat.com, fengwei.yin@intel.com,
 libang.li@antgroup.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 maskray@google.com, mhocko@suse.com, minchan@kernel.org, peterx@redhat.com,
 ryan.roberts@arm.com, shy828301@gmail.com, sj@kernel.org,
 songmuchun@bytedance.com, wangkefeng.wang@huawei.com, willy@infradead.org,
 xiehuan09@gmail.com, ziy@nvidia.com, zokeefe@google.com
References: <20240610120809.66601-1-ioworker0@gmail.com>
 <20240613072858.16512-1-ioworker0@gmail.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20240613072858.16512-1-ioworker0@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/6/13 15:28, Lance Yang wrote:
> Hi Andrew,
> 
> I'd like to fix the bug[1] I mentioned previously. Could you please fold the
> following changes into this patch?
> 
> [1] https://lore.kernel.org/linux-mm/20240613065521.15960-1-ioworker0@gmail.com/
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index f409ea9fcc18..425374ae06ed 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2707,10 +2707,8 @@ static bool __discard_anon_folio_pmd_locked(struct vm_area_struct *vma,
>   	if (unlikely(page_folio(page) != folio))
>   		return false;
>   
> -	if (folio_test_dirty(folio) || pmd_dirty(orig_pmd)) {
> -		folio_set_swapbacked(folio);
> +	if (folio_test_dirty(folio) || pmd_dirty(orig_pmd))
>   		return false;
> -	}
>   
>   	orig_pmd = pmdp_huge_clear_flush(vma, addr, pmdp);
>   
> @@ -2737,10 +2735,8 @@ static bool __discard_anon_folio_pmd_locked(struct vm_area_struct *vma,
>   	 *
>   	 * The only folio refs must be one from isolation plus the rmap(s).
>   	 */
> -	if (folio_test_dirty(folio) || pmd_dirty(orig_pmd))
> -		folio_set_swapbacked(folio);
> -
> -	if (folio_test_swapbacked(folio) || ref_count != map_count + 1) {
> +	if (folio_test_dirty(folio) || pmd_dirty(orig_pmd) ||
> +	    ref_count != map_count + 1) {
>   		set_pmd_at(mm, addr, pmdp, orig_pmd);
>   		return false;
>   	}
> diff --git a/mm/rmap.c b/mm/rmap.c
> index b9e5943c8349..393e2c11c44c 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1824,12 +1824,7 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
>   			 */
>   			if (unlikely(folio_test_swapbacked(folio) !=
>   					folio_test_swapcache(folio))) {
> -				/*
> -				 * unmap_huge_pmd_locked() will unmark a
> -				 * PMD-mapped folio as lazyfree if the folio or
> -				 * its PMD was redirtied.
> -				 */
> -				WARN_ON_ONCE(!pmd_mapped);
> +				WARN_ON_ONCE(1);
>   				goto walk_done_err;
>   			}
>   

You can also drop the unused 'pmd_mapped' variable now.

