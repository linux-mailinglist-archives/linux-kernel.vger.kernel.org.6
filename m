Return-Path: <linux-kernel+bounces-225148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D65E912C9A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 19:47:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FB641C2213E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 17:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE3F216ABC6;
	Fri, 21 Jun 2024 17:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XzVsdzul"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0551C14
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 17:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718992059; cv=none; b=oo3F76r97P7v8MiMtvVqw87xCxSXxddL32LMEkppaJwlSVQvHh5U7p7J99TJhoVLgi5olAvsNFJ7/v0xg1ZuypUs1Pw0iXyQmQk7I3v6xh5GtXwfvHxY3yUjq/n2szpn8XMqmme3lxk7WXF7J2yk2FknzVZReJC3UJ2tNOtudLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718992059; c=relaxed/simple;
	bh=shMHWu3nAdGSas5JyTJbcaFLKAUodBr38dOltNDM0m4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V6dLyn28G5VbqWCsN4LqL/FMKBh146iSPTJqI4UUQ6IKmcO1TaWwVUypT0AOm8+b/05Tctm2hFZKhXqlGWpvhqVFyYQ4vVxDgxRO2HFus+ypSreHDtnHoaGPTc9vOrh7I/iKCm0Kmz8KVDArMwDlmyRQDRIz40umcHPWEupma8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XzVsdzul; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45LHU9P4001221;
	Fri, 21 Jun 2024 17:47:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=B
	s87PPJQVTQ2eZp3vLh6LBPKnNfGxQBD9n+kptHrFbY=; b=XzVsdzulq5svMWxTV
	vcW4zVui0SlaDLH1QLAcoj0oS4cCJ9DWSg6YeJ96vLbMA16I+V4ONnNzdWvqPt1X
	Nh7rgFxlA1fghS5FkYLBS+t8Ohq1L3TSXcFvEfDD691L7k0yMubLegsQ4rX2/m4+
	MfQJzjdOK1R6ICUye8stHyRr8O+vk4HnVkUGogjmmBd6PRNpmmwv6doaHoqRu3TM
	XPyW792Pg46qP4EUbfTx6BUzjXW/gq51XdUlYm4/fCgzGU22AR5LxR+4l6DiYiSo
	CFIhzCyynYfVpx0eLHut/MgKwzJmLVqPNHb6zKkdTtWey0zgFzMhOaAX13qyb4lH
	jVMkA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ywdyar1pc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Jun 2024 17:47:30 +0000 (GMT)
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45LHlTWr003582;
	Fri, 21 Jun 2024 17:47:29 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ywdyar1pa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Jun 2024 17:47:29 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45LFTn7l031351;
	Fri, 21 Jun 2024 17:47:29 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3yvrrq8f7s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Jun 2024 17:47:29 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45LHlQjU22151926
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Jun 2024 17:47:28 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C092858054;
	Fri, 21 Jun 2024 17:47:26 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1256D58056;
	Fri, 21 Jun 2024 17:47:25 +0000 (GMT)
Received: from [9.171.63.80] (unknown [9.171.63.80])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 21 Jun 2024 17:47:24 +0000 (GMT)
Message-ID: <4474a212-7fc0-46b8-9f5b-bae878970b6b@linux.ibm.com>
Date: Fri, 21 Jun 2024 23:17:23 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] mm/migrate: move NUMA hinting fault folio
 isolation + checks under PTL
To: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
References: <20240620212935.656243-1-david@redhat.com>
 <20240620212935.656243-3-david@redhat.com>
Content-Language: en-US
From: Donet Tom <donettom@linux.ibm.com>
In-Reply-To: <20240620212935.656243-3-david@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: JllXY4P0dRnbr1_TgDGf1UqTJE2xr3NU
X-Proofpoint-GUID: y1LQfnrD6B2QqpEwxfX9cCcEZZLxKGB5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-21_08,2024-06-21_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 clxscore=1011 malwarescore=0 priorityscore=1501
 phishscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999 adultscore=0
 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406210126


On 6/21/24 02:59, David Hildenbrand wrote:
> Currently we always take a folio reference even if migration will not
> even be tried or isolation failed, requiring us to grab+drop an additional
> reference.
>
> Further, we end up calling folio_likely_mapped_shared() while the folio
> might have already been unmapped, because after we dropped the PTL, that
> can easily happen. We want to stop touching mapcounts and friends from
> such context, and only call folio_likely_mapped_shared() while the folio
> is still mapped: mapcount information is pretty much stale and unreliable
> otherwise.
>
> So let's move checks into numamigrate_isolate_folio(), rename that
> function to migrate_misplaced_folio_prepare(), and call that function
> from callsites where we call migrate_misplaced_folio(), but still with
> the PTL held.
>
> We can now stop taking temporary folio references, and really only take
> a reference if folio isolation succeeded. Doing the
> folio_likely_mapped_shared() + golio isolation under PT lock is now similar
> to how we handle MADV_PAGEOUT.
>
> While at it, combine the folio_is_file_lru() checks.
>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>   include/linux/migrate.h |  7 ++++
>   mm/huge_memory.c        |  8 ++--
>   mm/memory.c             |  9 +++--
>   mm/migrate.c            | 81 +++++++++++++++++++----------------------
>   4 files changed, 55 insertions(+), 50 deletions(-)
>
> diff --git a/include/linux/migrate.h b/include/linux/migrate.h
> index f9d92482d117..644be30b69c8 100644
> --- a/include/linux/migrate.h
> +++ b/include/linux/migrate.h
> @@ -139,9 +139,16 @@ const struct movable_operations *page_movable_ops(struct page *page)
>   }
>   
>   #ifdef CONFIG_NUMA_BALANCING
> +int migrate_misplaced_folio_prepare(struct folio *folio,
> +		struct vm_area_struct *vma, int node);
>   int migrate_misplaced_folio(struct folio *folio, struct vm_area_struct *vma,
>   			   int node);
>   #else
> +static inline int migrate_misplaced_folio_prepare(struct folio *folio,
> +		struct vm_area_struct *vma, int node)
> +{
> +	return -EAGAIN; /* can't migrate now */
> +}
>   static inline int migrate_misplaced_folio(struct folio *folio,
>   					 struct vm_area_struct *vma, int node)
>   {
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index fc27dabcd8e3..4b2817bb2c7d 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -1688,11 +1688,13 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
>   	if (node_is_toptier(nid))
>   		last_cpupid = folio_last_cpupid(folio);
>   	target_nid = numa_migrate_prep(folio, vmf, haddr, nid, &flags);
> -	if (target_nid == NUMA_NO_NODE) {
> -		folio_put(folio);
> +	if (target_nid == NUMA_NO_NODE)
> +		goto out_map;
> +	if (migrate_misplaced_folio_prepare(folio, vma, target_nid)) {
> +		flags |= TNF_MIGRATE_FAIL;
>   		goto out_map;
>   	}
> -
> +	/* The folio is isolated and isolation code holds a folio reference. */
>   	spin_unlock(vmf->ptl);
>   	writable = false;
>   
> diff --git a/mm/memory.c b/mm/memory.c
> index 118660de5bcc..4fd1ecfced4d 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -5207,8 +5207,6 @@ int numa_migrate_prep(struct folio *folio, struct vm_fault *vmf,
>   {
>   	struct vm_area_struct *vma = vmf->vma;
>   
> -	folio_get(folio);
> -
>   	/* Record the current PID acceesing VMA */
>   	vma_set_access_pid_bit(vma);
>   
> @@ -5345,10 +5343,13 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
>   	else
>   		last_cpupid = folio_last_cpupid(folio);
>   	target_nid = numa_migrate_prep(folio, vmf, vmf->address, nid, &flags);
> -	if (target_nid == NUMA_NO_NODE) {
> -		folio_put(folio);
> +	if (target_nid == NUMA_NO_NODE)
> +		goto out_map;
> +	if (migrate_misplaced_folio_prepare(folio, vma, target_nid)) {
> +		flags |= TNF_MIGRATE_FAIL;
>   		goto out_map;
>   	}
> +	/* The folio is isolated and isolation code holds a folio reference. */
>   	pte_unmap_unlock(vmf->pte, vmf->ptl);
>   	writable = false;
>   	ignore_writable = true;
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 0307b54879a0..27f070f64f27 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -2530,9 +2530,37 @@ static struct folio *alloc_misplaced_dst_folio(struct folio *src,
>   	return __folio_alloc_node(gfp, order, nid);
>   }
>   
> -static int numamigrate_isolate_folio(pg_data_t *pgdat, struct folio *folio)
> +/*
> + * Prepare for calling migrate_misplaced_folio() by isolating the folio if
> + * permitted. Must be called with the PTL still held.
> + */
> +int migrate_misplaced_folio_prepare(struct folio *folio,
> +		struct vm_area_struct *vma, int node)
>   {
>   	int nr_pages = folio_nr_pages(folio);
> +	pg_data_t *pgdat = NODE_DATA(node);
> +
> +	if (folio_is_file_lru(folio)) {
> +		/*
> +		 * Do not migrate file folios that are mapped in multiple
> +		 * processes with execute permissions as they are probably
> +		 * shared libraries.
> +		 *
> +		 * See folio_likely_mapped_shared() on possible imprecision
> +		 * when we cannot easily detect if a folio is shared.
> +		 */
> +		if ((vma->vm_flags & VM_EXEC) &&
> +		    folio_likely_mapped_shared(folio))
> +			return -EACCES;
> +
> +		/*
> +		 * Do not migrate dirty folios as not all filesystems can move
> +		 * dirty folios in MIGRATE_ASYNC mode which is a waste of
> +		 * cycles.
> +		 */
> +		if (folio_test_dirty(folio))
> +			return -EAGAIN;
> +	}
>   
>   	/* Avoid migrating to a node that is nearly full */
>   	if (!migrate_balanced_pgdat(pgdat, nr_pages)) {
> @@ -2550,65 +2578,37 @@ static int numamigrate_isolate_folio(pg_data_t *pgdat, struct folio *folio)
>   		 * further.
>   		 */
>   		if (z < 0)
> -			return 0;
> +			return -EAGAIN;
>   
>   		wakeup_kswapd(pgdat->node_zones + z, 0,
>   			      folio_order(folio), ZONE_MOVABLE);
> -		return 0;
> +		return -EAGAIN;
>   	}
>   
>   	if (!folio_isolate_lru(folio))
> -		return 0;
> +		return -EAGAIN;
>   
>   	node_stat_mod_folio(folio, NR_ISOLATED_ANON + folio_is_file_lru(folio),
>   			    nr_pages);
> -
> -	/*
> -	 * Isolating the folio has taken another reference, so the
> -	 * caller's reference can be safely dropped without the folio
> -	 * disappearing underneath us during migration.
> -	 */
> -	folio_put(folio);
> -	return 1;
> +	return 0;
>   }
>   
>   /*
>    * Attempt to migrate a misplaced folio to the specified destination
> - * node. Caller is expected to have an elevated reference count on
> - * the folio that will be dropped by this function before returning.
> + * node. Caller is expected to have isolated the folio by calling
> + * migrate_misplaced_folio_prepare(), which will result in an
> + * elevated reference count on the folio. This function will un-isolate the
> + * folio, dereferencing the folio before returning.
>    */
>   int migrate_misplaced_folio(struct folio *folio, struct vm_area_struct *vma,
>   			    int node)
>   {
>   	pg_data_t *pgdat = NODE_DATA(node);
> -	int isolated;
>   	int nr_remaining;
>   	unsigned int nr_succeeded;
>   	LIST_HEAD(migratepages);
>   	int nr_pages = folio_nr_pages(folio);
>   
> -	/*
> -	 * Don't migrate file folios that are mapped in multiple processes
> -	 * with execute permissions as they are probably shared libraries.
> -	 *
> -	 * See folio_likely_mapped_shared() on possible imprecision when we
> -	 * cannot easily detect if a folio is shared.
> -	 */
> -	if (folio_likely_mapped_shared(folio) && folio_is_file_lru(folio) &&
> -	    (vma->vm_flags & VM_EXEC))
> -		goto out;
> -
> -	/*
> -	 * Also do not migrate dirty folios as not all filesystems can move
> -	 * dirty folios in MIGRATE_ASYNC mode which is a waste of cycles.
> -	 */
> -	if (folio_is_file_lru(folio) && folio_test_dirty(folio))
> -		goto out;
> -
> -	isolated = numamigrate_isolate_folio(pgdat, folio);
> -	if (!isolated)
> -		goto out;
> -
>   	list_add(&folio->lru, &migratepages);
>   	nr_remaining = migrate_pages(&migratepages, alloc_misplaced_dst_folio,
>   				     NULL, node, MIGRATE_ASYNC,
> @@ -2620,7 +2620,6 @@ int migrate_misplaced_folio(struct folio *folio, struct vm_area_struct *vma,
>   					folio_is_file_lru(folio), -nr_pages);
>   			folio_putback_lru(folio);
>   		}
> -		isolated = 0;
>   	}
>   	if (nr_succeeded) {
>   		count_vm_numa_events(NUMA_PAGE_MIGRATE, nr_succeeded);
> @@ -2629,11 +2628,7 @@ int migrate_misplaced_folio(struct folio *folio, struct vm_area_struct *vma,
>   					    nr_succeeded);
>   	}
>   	BUG_ON(!list_empty(&migratepages));
> -	return isolated ? 0 : -EAGAIN;
> -
> -out:
> -	folio_put(folio);
> -	return -EAGAIN;
> +	return nr_remaining ? -EAGAIN : 0;
>   }
>   #endif /* CONFIG_NUMA_BALANCING */
>   #endif /* CONFIG_NUMA */

Hi David,

I have tested these patches on my system. My system has 2 DRAM nodes and 
1 PMEM node.
I tested page migration between DRAM nodes and page promotion from PMEM 
to DRAM.
Both are working fine.

below are the results.

Migration results
=============
numa_pte_updates 18977
numa_huge_pte_updates 0
numa_hint_faults 18504
numa_hint_faults_local 2116
numa_pages_migrated 16388



Promotion Results
===============
nr_sec_page_table_pages 0
nr_iommu_pages 0
nr_swapcached 0
pgpromote_success 16386
pgpromote_candidate 0


Tested-by: Donet Tom <donettom@linux.ibm.com>


Thanks
Donet

