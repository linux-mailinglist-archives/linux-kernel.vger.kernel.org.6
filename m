Return-Path: <linux-kernel+bounces-214862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1C56908B3B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 14:06:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FEC81F2409B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 12:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C013195F0D;
	Fri, 14 Jun 2024 12:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CmgIodLM"
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14E1811FE
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 12:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718366801; cv=none; b=Y2h9JIDd2YiXY1xnkJtvOjGU+M7XBIU8DrTmTTNv7YZ5XbQOj0ZOuoorGnnh5WkBJv9iLmlxgdMl7MYdOdrF3KF8v1M1Mr/usgafuR7y//e6MVJHEUmMYJUiZSWMQ7E0atrdaGtmD+QMY6xfPZ97Qj45MdX0VwXZdhY+eG9CShU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718366801; c=relaxed/simple;
	bh=4wCXZuEusw5nZqkrkb+6LVoPrYEB+QjclkBKWNxbQ10=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oGCBX0Bcafdn20I/GTjDmri/YfZNvvGfrdohAOwJC0jRl+i0vELp0BhzW6qBIwNU5WEZIySNTAUoO9iJSo0dePTV0Pz3Qd7ON0cW+Kjk3Z/NsTqeoJIdzVQ0ff03lUp0lGmaroGL3PDB0wxY1pmLXKdq6hBwmwai+SnDUNhhaGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CmgIodLM; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: usamaarif642@gmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1718366796;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KHG/yGyCiGvKudRrmafp28uTXE2vDuh3tAitczZGb/k=;
	b=CmgIodLMnVHV55Tk4LUvWAhewejUmuErW/ZxAwKOLzaqoVqUg3MHmyCQV1CORFrWVF7fMB
	X6PUvmq2hcEXKCEfppE92NJinO95mWrhmKEi6+3q1SqU772wMV0DxfT1YHvY26BuhmFToC
	PMy+wBgFRxTRjIeyYBtTwvDFeKkwNoI=
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: hannes@cmpxchg.org
X-Envelope-To: shakeel.butt@linux.dev
X-Envelope-To: david@redhat.com
X-Envelope-To: ying.huang@intel.com
X-Envelope-To: hughd@google.com
X-Envelope-To: willy@infradead.org
X-Envelope-To: yosryahmed@google.com
X-Envelope-To: nphamcs@gmail.com
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: kernel-team@meta.com
Message-ID: <b5952ee4-3b86-40ff-a3de-8a08f09557bd@linux.dev>
Date: Fri, 14 Jun 2024 20:05:48 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v5 1/2] mm: store zero pages to be swapped out in a bitmap
Content-Language: en-US
To: Usama Arif <usamaarif642@gmail.com>, akpm@linux-foundation.org
Cc: hannes@cmpxchg.org, shakeel.butt@linux.dev, david@redhat.com,
 ying.huang@intel.com, hughd@google.com, willy@infradead.org,
 yosryahmed@google.com, nphamcs@gmail.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, kernel-team@meta.com
References: <20240614100902.3469724-1-usamaarif642@gmail.com>
 <20240614100902.3469724-2-usamaarif642@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <20240614100902.3469724-2-usamaarif642@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2024/6/14 18:07, Usama Arif wrote:
> Approximately 10-20% of pages to be swapped out are zero pages [1].
> Rather than reading/writing these pages to flash resulting
> in increased I/O and flash wear, a bitmap can be used to mark these
> pages as zero at write time, and the pages can be filled at
> read time if the bit corresponding to the page is set.
> With this patch, NVMe writes in Meta server fleet decreased
> by almost 10% with conventional swap setup (zswap disabled).
> 
> [1] https://lore.kernel.org/all/20171018104832epcms5p1b2232e2236258de3d03d1344dde9fce0@epcms5p1/
> 
> Signed-off-by: Usama Arif <usamaarif642@gmail.com>

Looks good to me, only some small nits below.

Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>

> ---
>  include/linux/swap.h |   1 +
>  mm/page_io.c         | 113 ++++++++++++++++++++++++++++++++++++++++++-
>  mm/swapfile.c        |  15 ++++++
>  3 files changed, 128 insertions(+), 1 deletion(-)
> 
[...]
> +
> +static void swap_zeromap_folio_set(struct folio *folio)
> +{
> +	struct swap_info_struct *sis = swp_swap_info(folio->swap);
> +	swp_entry_t entry;
> +	unsigned int i;
> +
> +	for (i = 0; i < folio_nr_pages(folio); i++) {
> +		entry = page_swap_entry(folio_page(folio, i));

It seems simpler to use:

swp_entry_t entry = folio->swap;

for (i = 0; i < folio_nr_pages(folio); i++, entry.val++)

The current code is good too, no objection.

> +		set_bit(swp_offset(entry), sis->zeromap);
> +	}
> +}
> +
[...]
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 9c6d8e557c0f..0b8270359bcf 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -747,6 +747,14 @@ static void swap_range_free(struct swap_info_struct *si, unsigned long offset,
>  	unsigned long begin = offset;
>  	unsigned long end = offset + nr_entries - 1;
>  	void (*swap_slot_free_notify)(struct block_device *, unsigned long);
> +	unsigned int i;
> +
> +	/*
> +	 * Use atomic clear_bit operations only on zeromap instead of non-atomic
> +	 * bitmap_clear to prevent adjacent bits corruption due to simultaneous writes.
> +	 */
> +	for (i = 0; i < nr_entries; i++)
> +		clear_bit(offset + i, si->zeromap);

I'm wondering if we need to clear bits at all? Since the current locked folio is
the owner of these bits, we always update correctly when swap_writepage(). So
if these swap entries freed and reused by another folio, we won't load from backend
until that another folio has gone swap_writepage(), which update these bits correctly.

Maybe I missed something? Anyway, it should be no harm to clear here too.

Thanks.

>  
>  	if (offset < si->lowest_bit)
>  		si->lowest_bit = offset;
> @@ -2635,6 +2643,7 @@ SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
>  	free_percpu(p->cluster_next_cpu);
>  	p->cluster_next_cpu = NULL;
>  	vfree(swap_map);
> +	bitmap_free(p->zeromap);
>  	kvfree(cluster_info);
>  	/* Destroy swap account information */
>  	swap_cgroup_swapoff(p->type);
> @@ -3161,6 +3170,12 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
>  		goto bad_swap_unlock_inode;
>  	}
>  
> +	p->zeromap = bitmap_zalloc(maxpages, GFP_KERNEL);
> +	if (!p->zeromap) {
> +		error = -ENOMEM;
> +		goto bad_swap_unlock_inode;
> +	}
> +
>  	if (p->bdev && bdev_stable_writes(p->bdev))
>  		p->flags |= SWP_STABLE_WRITES;
>  

