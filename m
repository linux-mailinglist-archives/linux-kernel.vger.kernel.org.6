Return-Path: <linux-kernel+bounces-561681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B072CA614D9
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 16:29:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A600B3A95EB
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 15:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC1B8202964;
	Fri, 14 Mar 2025 15:29:00 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C34B201261
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 15:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741966140; cv=none; b=piEqB4lq+kpJf/j+V5CFWNWuqg0Feyt5luwncii/2GxpGyb7JLUUUWA9gownxbv7NxMnENNNgEookbYHFTJjAS7mg6uyoMIbC4jbA2Gp0MZDSJeH7AI9FKpurp/EWFZ1xXW85PdGgLGTDTBJcts4ftPA94RWP1H2u/brYAWm4b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741966140; c=relaxed/simple;
	bh=Gu8311cXDMi9254TckjdgcgP6Gl04MqisFPbym68FBg=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vm/X837Jo2pyKxOWtPe5YmYo/kwDWznpFag+YoPXLhaS7ZdUyzd8Tvim0cJF/+CA+nvC0pwpxQtU6U1FkO4SOd5Gxn3GgTGLM+XGP8XjO/Irj5icuak7MgO9pmEJzdS3XKqgbpy7CBtuqCLjH5ASEB+U4WuyD2aU8sau0JvEorE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZDp7Q3bdWz6H6s3;
	Fri, 14 Mar 2025 23:24:18 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id C41EB14039F;
	Fri, 14 Mar 2025 23:28:53 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 14 Mar
 2025 16:28:52 +0100
Date: Fri, 14 Mar 2025 15:28:50 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Bharata B Rao <bharata@amd.com>
CC: <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<AneeshKumar.KizhakeVeetil@arm.com>, <Hasan.Maruf@amd.com>,
	<Michael.Day@amd.com>, <akpm@linux-foundation.org>, <dave.hansen@intel.com>,
	<david@redhat.com>, <feng.tang@intel.com>, <gourry@gourry.net>,
	<hannes@cmpxchg.org>, <honggyu.kim@sk.com>, <hughd@google.com>,
	<jhubbard@nvidia.com>, <k.shutemov@gmail.com>, <kbusch@meta.com>,
	<kmanaouil.dev@gmail.com>, <leesuyeon0506@gmail.com>, <leillc@google.com>,
	<liam.howlett@oracle.com>, <mgorman@techsingularity.net>, <mingo@redhat.com>,
	<nadav.amit@gmail.com>, <nphamcs@gmail.com>, <peterz@infradead.org>,
	<raghavendra.kt@amd.com>, <riel@surriel.com>, <rientjes@google.com>,
	<rppt@kernel.org>, <shivankg@amd.com>, <shy828301@gmail.com>,
	<sj@kernel.org>, <vbabka@suse.cz>, <weixugc@google.com>,
	<willy@infradead.org>, <ying.huang@linux.alibaba.com>, <ziy@nvidia.com>,
	<dave@stgolabs.net>, <yuanchu@google.com>, <hyeonggon.yoo@sk.com>
Subject: Re: [RFC PATCH 2/4] mm: kpromoted: Hot page info collection and
 promotion daemon
Message-ID: <20250314152850.00003112@huawei.com>
In-Reply-To: <20250306054532.221138-3-bharata@amd.com>
References: <20250306054532.221138-1-bharata@amd.com>
	<20250306054532.221138-3-bharata@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 6 Mar 2025 11:15:30 +0530
Bharata B Rao <bharata@amd.com> wrote:

> kpromoted is a kernel daemon that accumulates hot page info
> from different sources and tries to promote pages from slow
> tiers to top tiers. One instance of this thread runs on each
> node that has CPUs.
>=20

Firstly, nice work. Much easier to discuss things with an
implementation to look at.

I'm looking at this with my hardware hotness unit "hammer" in hand :)

> Subsystems that generate hot page access info can report that
> to kpromoted via this API:
>=20
> int kpromoted_record_access(u64 pfn, int nid, int src,
> 			    unsigned long time)

This perhaps works as an interface for aggregating methods
that produce per access events.  Any hardware counter solution
is going to give you data that is closer to what you used for
the promotion decision.

We might need to aggregate at different levels.  So access
counting promotes to a hot list and we can inject other events
at that level.  The data I have from the CXL HMU is typically
after an epoch (period of time) these N pages were accessed more
than M times.  I can sort of map that to the internal storage
you have.

Would be good to evaluate approximate trackers on top of access
counts. I've no idea if sketches or similar would be efficient
enough (they have a bit of a write amplification problem) but
they may give good answers with much lower storage cost at the
risk of occasionally saying something is hot when it's not.

>=20
> @pfn: The PFN of the memory accessed
> @nid: The accessing NUMA node ID
> @src: The temperature source (subsystem) that generated the
>       access info
> @time: The access time in jiffies
>=20
> Some temperature sources may not provide the nid from which
> the page was accessed. This is true for sources that use
> page table scanning for PTE Accessed bit. Currently the toptier
> node to which such pages should be promoted to is hard coded.

For those cases (CXL HMU included) maybe we need to
consider how to fill in missing node info with at least a vague chance
of getting a reasonable target for migration.  We can always fall
back to random top tier node, or nearest one to where we are coming
from (on basis we maybe landed in this node based on a fallback
list when the top tier was under memory pressure).

=46rom an interface point of view is that a problem for this layer,
or for the underlying tracking mechanism? (maybe with some helpers)
Also, see later discussion of consistency of hotness tracking and
that the best solution for that differs from that to get
potential targets.  The answer to Is this page consistently hot?" can be
approximated with "Was this page once hot and is it not now cold?"

Access time is something some measurement techniques will only
give you wrt to a measurement was in a window (potentially a long
one if you are looking for consistent hotness over minutes).

>=20
> Also, the access time provided some sources may at best be
> considered approximate. This is especially true for hot pages
> detected by PTE A bit scanning.
>=20
> kpromoted currently maintains the hot PFN records in hash lists
> hashed by PFN value. Each record stores the following info:
>=20
> struct page_hotness_info {
> 	unsigned long pfn;
>=20
> 	/* Time when this record was updated last */
> 	unsigned long last_update;
>=20
> 	/*
> 	 * Number of times this page was accessed in the
> 	 * current window
I'd express here how that window was defined (I read on
to answer the question I had here at first!)

> 	 */
> 	int frequency;
>=20
> 	/* Most recent access time */
> 	unsigned long recency;

Put next to the last_update so all the times are together

>=20
> 	/* Most recent access from this node */
> 	int hot_node;

Probably want to relax the most recent part.  I'd guess
the ideal here would be if this is the node accessing it the most
'recently'.

>=20
> 	struct hlist_node hnode;
> };
>=20
> The way in which a page is categorized as hot enough to be
> promoted is pretty primitive now.

That bit is very hard even if we solve everything else and heavily dependent
on workload access pattern stability and migration impact.  Maybe for
'very hot' pages a fairly short consistency of hotness period is
good enough, but it gets much messier if we care about warm pages.
I guess we solve the 'very hot' first though and maybe avoid the phase
transition from an application starting to when it is at steady state
by considering a wait time for any new userspace process before we
consider moving anything?

Also worth noting that the mechanism that makes sense to check if a
detected hot page is 'stable hot' might use entirely different tracking
approach to that used to find it as a candidate.

Whether that requires passing data between hotness trackers is an
interesting question, or whether there is a natural ordering to trackers.



> diff --git a/mm/kpromoted.c b/mm/kpromoted.c
> new file mode 100644
> index 000000000000..2a8b8495b6b3
> --- /dev/null
> +++ b/mm/kpromoted.c

> +static int page_should_be_promoted(struct page_hotness_info *phi)
> +{
> +	struct page *page =3D pfn_to_online_page(phi->pfn);
> +	unsigned long now =3D jiffies;
> +	struct folio *folio;
> +
> +	if (!page || is_zone_device_page(page))
> +		return false;
> +
> +	folio =3D page_folio(page);
> +	if (!folio_test_lru(folio)) {
> +		count_vm_event(KPROMOTED_MIG_NON_LRU);
> +		return false;
> +	}
> +	if (folio_nid(folio) =3D=3D phi->hot_node) {
> +		count_vm_event(KPROMOTED_MIG_RIGHT_NODE);
> +		return false;
> +	}
> +
> +	/* If the page was hot a while ago, don't promote */

	/* If the known record of hotness is old, don't promote */ ?

Otherwise this says don't move a page just because it was hot a long time
back. Maybe it is still hot and we just don't have an update yet?

> +	if ((now - phi->last_update) > 2 * msecs_to_jiffies(KPROMOTED_FREQ_WIND=
OW)) {
> +		count_vm_event(KPROMOTED_MIG_COLD_OLD);
> +		return false;
> +	}
> +
> +	/* If the page hasn't been accessed enough number of times, don't promo=
te */
> +	if (phi->frequency < KPRMOTED_FREQ_THRESHOLD) {
> +		count_vm_event(KPROMOTED_MIG_COLD_NOT_ACCESSED);
> +		return false;
> +	}
> +	return true;
> +}
> +
> +/*
> + * Go thro' page hotness information and migrate pages if required.
> + *
> + * Promoted pages are not longer tracked in the hot list.
> + * Cold pages are pruned from the list as well.

When we say cold here why did we ever see them?

> + *
> + * TODO: Batching could be done
> + */
> +static void kpromoted_migrate(pg_data_t *pgdat)
> +{
> +	int nid =3D pgdat->node_id;
> +	struct page_hotness_info *phi;
> +	struct hlist_node *tmp;
> +	int nr_bkts =3D HASH_SIZE(page_hotness_hash);
> +	int bkt;
> +
> +	for (bkt =3D 0; bkt < nr_bkts; bkt++) {
> +		mutex_lock(&page_hotness_lock[bkt]);
> +		hlist_for_each_entry_safe(phi, tmp, &page_hotness_hash[bkt], hnode) {
> +			if (phi->hot_node !=3D nid)
> +				continue;
> +
> +			if (page_should_be_promoted(phi)) {
> +				count_vm_event(KPROMOTED_MIG_CANDIDATE);
> +				if (!kpromote_page(phi)) {
> +					count_vm_event(KPROMOTED_MIG_PROMOTED);
> +					hlist_del_init(&phi->hnode);
> +					kfree(phi);
> +				}
> +			} else {
> +				/*
> +				 * Not a suitable page or cold page, stop tracking it.
> +				 * TODO: Identify cold pages and drive demotion?

Coldness tracking is really different from hotness as we need to track what=
 we
didn't see to get the really cold pages. Maybe there is some hint to be had
from the exit of this tracker but I'd definitely not try to tackle both ends
with one approach!

> +				 */
> +				count_vm_event(KPROMOTED_MIG_DROPPED);
> +				hlist_del_init(&phi->hnode);
> +				kfree(phi);
> +			}
> +		}
> +		mutex_unlock(&page_hotness_lock[bkt]);
> +	}
> +}


> +/*
> + * Called by subsystems that generate page hotness/access information.
> + *
> + * Records the memory access info for futher action by kpromoted.
> + */
> +int kpromoted_record_access(u64 pfn, int nid, int src, unsigned long now)
> +{

> +	bkt =3D hash_min(pfn, KPROMOTED_HASH_ORDER);
> +	mutex_lock(&page_hotness_lock[bkt]);
> +	phi =3D kpromoted_lookup(pfn, bkt, now);
> +	if (!phi) {
> +		ret =3D PTR_ERR(phi);
> +		goto out;
> +	}
> +
> +	if ((phi->last_update - now) > msecs_to_jiffies(KPROMOTED_FREQ_WINDOW))=
 {
> +		/* New window */
> +		phi->frequency =3D 1; /* TODO: Factor in the history */
> +		phi->last_update =3D now;
> +	} else {
> +		phi->frequency++;
> +	}
> +	phi->recency =3D now;
> +
> +	/*
> +	 * TODOs:
> +	 * 1. Source nid is hard-coded for some temperature sources

Hard coded rather than unknown? I'm curious, what source has that issue?

> +	 * 2. Take action if hot_node changes - may be a shared page?
> +	 * 3. Maintain node info for every access within the window?

I guess some sort of saturating counter set might not be too bad.

> +	 */
> +	phi->hot_node =3D (nid =3D=3D NUMA_NO_NODE) ? 1 : nid;
> +	mutex_unlock(&page_hotness_lock[bkt]);
> +out:
> +	return 0;

why store ret and not return it?

> +}
> +


