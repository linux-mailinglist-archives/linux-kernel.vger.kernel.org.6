Return-Path: <linux-kernel+bounces-571737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 548ECA6C181
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 18:29:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DF381B60D2C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 17:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9D4D22DF96;
	Fri, 21 Mar 2025 17:29:49 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3401DEFFC
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 17:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742578189; cv=none; b=fvIM/ivG99UukyoakyENLXDTVgW7xEh1hsHeJjnqnIJ/QvT/rN1R/EGv2SEA9+EAXvHm7d00RpbRU02cJSiKSaOKO78XkhgGn3W+VRHxQpf4pmRP+QLyaks/XcOEMEKFC+xwTsj4aQG6RjT+39e9qAJn483CZecBs96aw9HmJmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742578189; c=relaxed/simple;
	bh=FO1Xtlh9NM66i9m6W+H8XvfXMiscDmxhQBEF1prHM38=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZogTn+wd96aVDX0s4weeuT9mJ2x75FU/qSxbUS4X1l3esuQxQ0UYRHyslJ3qee74u4jW995bkPZP5sNNe4JUMiAGBLHF9z0693Oi43qQR7Q8b5M6R6J07iNYedHTtL5143yP1jNaWQwFO8lycGCzdg95RAP4Qu14tR8/CiePF+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZK8WQ3MCsz6K9BM;
	Sat, 22 Mar 2025 01:26:42 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id BD980140142;
	Sat, 22 Mar 2025 01:29:43 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 21 Mar
 2025 18:29:42 +0100
Date: Fri, 21 Mar 2025 17:29:40 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Raghavendra K T <raghavendra.kt@amd.com>
CC: <AneeshKumar.KizhakeVeetil@arm.com>, <Hasan.Maruf@amd.com>,
	<Michael.Day@amd.com>, <akpm@linux-foundation.org>, <bharata@amd.com>,
	<dave.hansen@intel.com>, <david@redhat.com>, <dongjoo.linux.dev@gmail.com>,
	<feng.tang@intel.com>, <gourry@gourry.net>, <hannes@cmpxchg.org>,
	<honggyu.kim@sk.com>, <hughd@google.com>, <jhubbard@nvidia.com>,
	<jon.grimm@amd.com>, <k.shutemov@gmail.com>, <kbusch@meta.com>,
	<kmanaouil.dev@gmail.com>, <leesuyeon0506@gmail.com>, <leillc@google.com>,
	<liam.howlett@oracle.com>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, <mgorman@techsingularity.net>, <mingo@redhat.com>,
	<nadav.amit@gmail.com>, <nphamcs@gmail.com>, <peterz@infradead.org>,
	<riel@surriel.com>, <rientjes@google.com>, <rppt@kernel.org>,
	<santosh.shukla@amd.com>, <shivankg@amd.com>, <shy828301@gmail.com>,
	<sj@kernel.org>, <vbabka@suse.cz>, <weixugc@google.com>,
	<willy@infradead.org>, <ying.huang@linux.alibaba.com>, <ziy@nvidia.com>,
	<dave@stgolabs.net>
Subject: Re: [RFC PATCH V1 04/13] mm: Create a separate kernel thread for
 migration
Message-ID: <20250321172940.00007646@huawei.com>
In-Reply-To: <20250319193028.29514-5-raghavendra.kt@amd.com>
References: <20250319193028.29514-1-raghavendra.kt@amd.com>
	<20250319193028.29514-5-raghavendra.kt@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100010.china.huawei.com (7.191.174.197) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 19 Mar 2025 19:30:19 +0000
Raghavendra K T <raghavendra.kt@amd.com> wrote:

> Having independent thread helps in:
>  - Alleviating the need for multiple scanning threads
>  - Aids to control batch migration (TBD)
>  - Migration throttling (TBD)
> 
A few comments on things noticed whilst reading through.

Jonathan

> Signed-off-by: Raghavendra K T <raghavendra.kt@amd.com>
> ---
>  mm/kmmscand.c | 157 +++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 154 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/kmmscand.c b/mm/kmmscand.c
> index a76a58bf37b2..6e96cfab5b85 100644
> --- a/mm/kmmscand.c
> +++ b/mm/kmmscand.c

>  /* Per folio information used for migration */
>  struct kmmscand_migrate_info {
>  	struct list_head migrate_node;
> @@ -101,6 +126,13 @@ static int kmmscand_has_work(void)
>  	return !list_empty(&kmmscand_scan.mm_head);
>  }
>  
> +static int kmmmigrated_has_work(void)
> +{
> +	if (!list_empty(&kmmscand_migrate_list.migrate_head))
> +		return true;
> +	return false;
If it isn't getting more complex later, can just
	return !list_empty().
or indeed, just put that condition directly at caller.

> +}


>  static inline bool is_valid_folio(struct folio *folio)
>  {
> @@ -238,7 +293,6 @@ static int hot_vma_idle_pte_entry(pte_t *pte,
>  			folio_put(folio);
>  			return 0;
>  		}
> -		/* XXX: Leaking memory. TBD: consume info */
>  		info = kzalloc(sizeof(struct kmmscand_migrate_info), GFP_NOWAIT);
>  		if (info && scanctrl) {
>  
> @@ -282,6 +336,28 @@ static inline int kmmscand_test_exit(struct mm_struct *mm)
>  	return atomic_read(&mm->mm_users) == 0;
>  }
>  
> +static void kmmscand_cleanup_migration_list(struct mm_struct *mm)
> +{
> +	struct kmmscand_migrate_info *info, *tmp;
> +
> +	spin_lock(&kmmscand_migrate_lock);

Could scatter some guard() magic in here.

> +	if (!list_empty(&kmmscand_migrate_list.migrate_head)) {

Maybe flip logic of this unless it is going to get more complex in future
patches.  That way, with guard() handling the spin lock, you can just
return when nothing to do.

> +		if (mm == READ_ONCE(kmmscand_cur_migrate_mm)) {
> +			/* A folio in this mm is being migrated. wait */
> +			WRITE_ONCE(kmmscand_migration_list_dirty, true);
> +		}
> +
> +		list_for_each_entry_safe(info, tmp, &kmmscand_migrate_list.migrate_head,
> +			migrate_node) {
> +			if (info && (info->mm == mm)) {
> +				info->mm = NULL;
> +				WRITE_ONCE(kmmscand_migration_list_dirty, true);
> +			}
> +		}
> +	}
> +	spin_unlock(&kmmscand_migrate_lock);
> +}

>  static unsigned long kmmscand_scan_mm_slot(void)
>  {
>  	bool next_mm = false;
> @@ -347,9 +429,17 @@ static unsigned long kmmscand_scan_mm_slot(void)
>  
>  		if (vma_scanned_size >= kmmscand_scan_size) {
>  			next_mm = true;
> -			/* TBD: Add scanned folios to migration list */
> +			/* Add scanned folios to migration list */
> +			spin_lock(&kmmscand_migrate_lock);
> +			list_splice_tail_init(&kmmscand_scanctrl.scan_list,
> +						&kmmscand_migrate_list.migrate_head);
> +			spin_unlock(&kmmscand_migrate_lock);
>  			break;
>  		}
> +		spin_lock(&kmmscand_migrate_lock);
> +		list_splice_tail_init(&kmmscand_scanctrl.scan_list,
> +					&kmmscand_migrate_list.migrate_head);
> +		spin_unlock(&kmmscand_migrate_lock);

I've stared at this a while, but if we have entered the conditional block
above, do we splice the now empty list? 

>  	}
>  
>  	if (!vma)

