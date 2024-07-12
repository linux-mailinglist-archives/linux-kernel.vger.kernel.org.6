Return-Path: <linux-kernel+bounces-250130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BBAD92F48C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 06:01:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF8C81F243A0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 04:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4D6C10A1F;
	Fri, 12 Jul 2024 04:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ybF11d2z"
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C5C624
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 04:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720756886; cv=none; b=AY7wnduv6G+ZhFiTQ3O358gVb5wj34I4ieusKWyLKG34/c2BSNrnuYB0baH2zhuhABxcl6v5lskFHFWB9iP3HVzMBPEMrxja8Wslu7I+M9fu3jjx03veVXI1zBxH5jOLviYKTQNEwQlMZ5Dyun5g/sz0W1jhD6cK9Smg5OoFr3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720756886; c=relaxed/simple;
	bh=KH5KHtRJDyJtKgLZ6xrQSvRQ/J+p9oJZervF4lsyX+g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nb9RmpTpA+ZgowEwDjeMdol+Zem5ETZmsl3W7TCgMFqohepmOEyhWNXDmEUUkf6ZnnNRsZHYvc4s+cruWSNDcnP15njUn/8g0DPFhIMwxmz3s1AMabi4POs7ka8TQgbAXLaY7TkhxtoRAg3oRhGGoS0PSgiCENBU1XrMxWv0waA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ybF11d2z; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1720756881; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=/VZJgwIDEY1bFqqyo1Sj8OxXpbkhbY9mmx+7bOp9cv4=;
	b=ybF11d2zPNWAmGxj1Jw3kuuJIOJ7f+ZFmryNVQnstbUq9UGQfQcKT3F+1Qa+ZWJBOoS6XASQm0l5ZZKYgkk0m2Xzs+hyhZQNoMqqv2RgHaH2KDDbzAVb/mlODsZFlWesFOVoHWRjbJzd9ObZOdIkKxG7kb8R0+N2DryCF29P4js=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033023225041;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0WAMhfpp_1720756880;
Received: from 30.97.56.66(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WAMhfpp_1720756880)
          by smtp.aliyun-inc.com;
          Fri, 12 Jul 2024 12:01:21 +0800
Message-ID: <bd6459a5-5bfd-4986-b110-6b8af1e0eda8@linux.alibaba.com>
Date: Fri, 12 Jul 2024 12:01:20 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/3] memory tiering: read last_cpupid correctly in
 do_huge_pmd_numa_page()
To: Zi Yan <ziy@nvidia.com>, David Hildenbrand <david@redhat.com>,
 "Huang, Ying" <ying.huang@intel.com>, linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
References: <20240712024455.163543-1-zi.yan@sent.com>
 <20240712024455.163543-2-zi.yan@sent.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20240712024455.163543-2-zi.yan@sent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/7/12 10:44, Zi Yan wrote:
> From: Zi Yan <ziy@nvidia.com>
> 
> last_cpupid is only available when memory tiering is off or the folio
> is in toptier node. Complete the check to read last_cpupid when it is
> available.
> 
> Before the fix, the default last_cpupid will be used even if memory
> tiering mode is turned off at runtime instead of the actual value. This
> can prevent task_numa_fault() from getting right numa fault stats, but
> should not cause any crash. User might see performance changes after the
> fix.
> 
> Fixes: 33024536bafd ("memory tiering: hot page selection with hint page fault latency")
> Signed-off-by: Zi Yan <ziy@nvidia.com>

LGTM.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

> ---
>   mm/huge_memory.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index d7c84480f1a4..07d9dde4ca33 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -1705,7 +1705,8 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
>   	 * For memory tiering mode, cpupid of slow memory page is used
>   	 * to record page access time.  So use default value.
>   	 */
> -	if (node_is_toptier(nid))
> +	if (!(sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING) ||
> +	    node_is_toptier(nid))
>   		last_cpupid = folio_last_cpupid(folio);
>   	target_nid = numa_migrate_prep(folio, vmf, haddr, nid, &flags);
>   	if (target_nid == NUMA_NO_NODE)

