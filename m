Return-Path: <linux-kernel+bounces-370304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A7D1A9A2AF4
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 19:30:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 688F8B252FD
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 17:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 996E41DFD82;
	Thu, 17 Oct 2024 17:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="GgNV52UO"
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9C51DF967
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 17:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729185764; cv=none; b=IDGZRL3Xqkc3BFNqJyIJ5FqNWXpyRXnfIMf59deIdJ2DN51LocYiCkWVt/oh4s963nGi324byoYpntvZc9ba7Qfgp4PLCxNryBe15QkaByjWM3+ZkmfC24l4nsT9VB8P9sntzPR+NFixgzk20SWZp8V2BtEJksGv4VTSVb277/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729185764; c=relaxed/simple;
	bh=f13C2ND8m+p2ohBEFDFbMettJBrpxKuRIBoaGQO0+j4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oZRSLTV8PtbgNEHEFghTpG5CoSRu2NfTepyL04tLMwg0YkPII+z5RTfuax7rXYIOQN/mN7wbCo/nrm0rE+r9i80ItMed61IHmjScAWwelIyJ8fO3TgXFIlcIZKmI+NO56xqtmY15q9cgKBx4X2NhSKY5IBmgqI5Yb2DF563NgMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=GgNV52UO; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6cbe8119e21so8562636d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 10:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1729185760; x=1729790560; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bc94PXKTprK1Ibjok2UffvvJfluU5XAoP6z0IjVe7TQ=;
        b=GgNV52UO9oJ82AHiYBjVL4OdhPOrbXwYRwFGtLFvIgf9d3kKyFFqrKFLPosAVZAt9N
         e5FblsmZZ0I5r5er2isP7Xbi1ndze4hnKkx0xJWMA1D/xWH6OidgD4LUzE5KkrWR7Hx4
         nCJj0O+6ThCseppsy5wSKFQ7Z910BbmWoPpNuRjcuEYRvUsSP+PHW3kY3O2PPmk7j823
         TfIy5LOCMj4yv8lOE/qNQAOzKDphJgzXYZKR3DHRX20eNOuq3PXzyxHpVxsLqrMIwhX2
         l6XHqkhgNIO1y7NBnbWL6L9aszEp55tvYEmMB2uz1gxVTqrXg6tI6yT1pslQxs3/Tt0P
         4rVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729185760; x=1729790560;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bc94PXKTprK1Ibjok2UffvvJfluU5XAoP6z0IjVe7TQ=;
        b=RpGPRejWY6G18QVqAf7kLcfqjBLl/STjd+BcQxTZl7uTmP+5w8lBVrrscktXjpNWt/
         xJh6+yRhld3hMH+frcxDvMDtF+k5XIka6NZcyLeKgCYmvmE05gCYi3RqkQoNdfDTaPgz
         q+XK8sfRu8lFNIO+0eAJRfRqnIcO4LBThrs+i17LS/6C7V7kyFgEiBumdSyNMX6mSSfT
         bIsbWPHATdTCU6iNgjqKNHOFmitoau883cwhCmC2asKC5AABY4cgduo/d37QJOUIkhX3
         BUcg88krMy82cfV4+5+pz85yKOk3qzYB5mN6AKTOOU+qbsME9dH1Nd2g7vAtE36Hlh67
         hLEA==
X-Forwarded-Encrypted: i=1; AJvYcCVREN6zr9xNCM0ZCFBe2z5THUjZWt1q562Vj2x2qS0of8xbfG5+WXRBjsMYgWI/bpgv51GrF/RVKLssagI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHkIFsmwIYbpSsvbQrzDdLdDnmfPos+HbKJ4tDQneiLUGg36Ef
	LH7t79nYbuJlR+MgVfNiskv/8ArGvpihu0xlHJFpaUf+VL79qOVZR7Xq0oojZss=
X-Google-Smtp-Source: AGHT+IFsk5iRNjPCE/WMT8wZfByEs5RcZYFnjCGbQAfcreEexDdRQgoS8t0ouw8Qcytwod/CedVKRg==
X-Received: by 2002:a0c:e84f:0:b0:6cc:2c76:d2e4 with SMTP id 6a1803df08f44-6cc2c76d316mr76715556d6.53.1729185760126;
        Thu, 17 Oct 2024 10:22:40 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cc229714d0sm29815186d6.131.2024.10.17.10.22.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 10:22:39 -0700 (PDT)
Date: Thu, 17 Oct 2024 13:22:34 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: nphamcs@gmail.com, mhocko@kernel.org, roman.gushchin@linux.dev,
	shakeel.butt@linux.dev, muchun.song@linux.dev,
	akpm@linux-foundation.org, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, lnyng@meta.com
Subject: Re: [PATCH 1/1] memcg/hugetlb: Adding hugeTLB counters to memory
 controller
Message-ID: <20241017172234.GA71939@cmpxchg.org>
References: <20241017160438.3893293-1-joshua.hahnjy@gmail.com>
 <20241017160438.3893293-2-joshua.hahnjy@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017160438.3893293-2-joshua.hahnjy@gmail.com>

On Thu, Oct 17, 2024 at 09:04:38AM -0700, Joshua Hahn wrote:
> HugeTLB is added as a metric in memcg_stat_item, and is updated in the
> alloc and free methods for hugeTLB, after (un)charging has already been
> committed. Changes are batched and updated / flushed like the rest of
> the memcg stats, which makes additional overhead by the infrequent
> hugetlb allocs / frees minimal.
> 
> Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
> ---
>  include/linux/memcontrol.h | 3 +++
>  mm/hugetlb.c               | 5 +++++
>  mm/memcontrol.c            | 6 ++++++
>  3 files changed, 14 insertions(+)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 34d2da05f2f1..66e925ae499a 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -39,6 +39,9 @@ enum memcg_stat_item {
>  	MEMCG_KMEM,
>  	MEMCG_ZSWAP_B,
>  	MEMCG_ZSWAPPED,
> +#ifdef CONFIG_HUGETLB_PAGE
> +	MEMCG_HUGETLB,
> +#endif
>  	MEMCG_NR_STAT,
>  };

It would be better to add a native vmstat counter for this, as there
is no strong reason to make this memcg specific. This would also make
it NUMA-node-aware.

IOW, add a new item to enum node_stat_item (plus the string in
vmstat.c and memcontrol.c).

> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 190fa05635f4..ca7151096712 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1887,6 +1887,7 @@ void free_huge_folio(struct folio *folio)
>  	struct hstate *h = folio_hstate(folio);
>  	int nid = folio_nid(folio);
>  	struct hugepage_subpool *spool = hugetlb_folio_subpool(folio);
> +	struct mem_cgroup *memcg = get_mem_cgroup_from_current();
>  	bool restore_reserve;
>  	unsigned long flags;
>  
> @@ -1926,6 +1927,8 @@ void free_huge_folio(struct folio *folio)
>  	hugetlb_cgroup_uncharge_folio_rsvd(hstate_index(h),
>  					  pages_per_huge_page(h), folio);
>  	mem_cgroup_uncharge(folio);
> +	mod_memcg_state(memcg, MEMCG_HUGETLB, -pages_per_huge_page(h));
> +	mem_cgroup_put(memcg);
>  	if (restore_reserve)
>  		h->resv_huge_pages++;

This goes wrong if the folio is freed by somebody other than the
owning cgroup. For example if the task moved between cgroups after the
memory was charged.

It's better to use the folio->memcg linkage that was established by
the allocation path.

Use lruvec_stat_mod_folio(), it will handle all of this.

> @@ -3093,6 +3096,8 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
>  
>  	if (!memcg_charge_ret)
>  		mem_cgroup_commit_charge(folio, memcg);
> +
> +	mod_memcg_state(memcg, MEMCG_HUGETLB, nr_pages);

And here as well.

