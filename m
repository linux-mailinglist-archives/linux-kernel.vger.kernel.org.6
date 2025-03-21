Return-Path: <linux-kernel+bounces-571580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 526A1A6BF1C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 17:07:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8725189EF9C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 16:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A035B229B23;
	Fri, 21 Mar 2025 16:06:37 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298D31E22FA
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 16:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742573197; cv=none; b=UG1Xi9bpEQz2KJB79riJCNOhTta6RxvXgm+KEMEcX7pCUa8DyxR01GtTfSkMysDdBSG+Fl/nmlGQvKkXimoytKcpDMdFaO47QdWdLvBOdB1oF78mnSOt8TxqClmTVYux5eLZgizXA1mmUBkBbjglToc7fFyhZK2slLlxeuWipoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742573197; c=relaxed/simple;
	bh=lLBcSr6Rag8IypS0xGuQXJIvIXTE0qwJoViXLFmhHqw=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kjkYb7KEPVRnwrA4HKSraDRzdNt+OBbjVpvLZphxJdNIeBad7ZobI3w5IRZvARd98pOKOW+3w+ZgGH7us/BdAqfA+OEvr/dp4UJM4+2m1m6fRdYULitJ/6VOX9fNkNoLALIECokSUaRRWbb31T2ZNHh8RNhUMQSQu7yC54EjiOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZK6gQ3lzcz6K5p4;
	Sat, 22 Mar 2025 00:03:30 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id A238914038F;
	Sat, 22 Mar 2025 00:06:31 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 21 Mar
 2025 17:06:30 +0100
Date: Fri, 21 Mar 2025 16:06:28 +0000
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
Subject: Re: [RFC PATCH V1 01/13] mm: Add kmmscand kernel daemon
Message-ID: <20250321160628.000033a9@huawei.com>
In-Reply-To: <20250319193028.29514-2-raghavendra.kt@amd.com>
References: <20250319193028.29514-1-raghavendra.kt@amd.com>
	<20250319193028.29514-2-raghavendra.kt@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500010.china.huawei.com (7.191.174.240) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 19 Mar 2025 19:30:16 +0000
Raghavendra K T <raghavendra.kt@amd.com> wrote:

> Add a skeleton to support scanning and migration.
> Also add a config option for the same.
> 
> High level design:
> 
> While (1):
>   scan the slowtier pages belonging to VMAs of a task.
>   Add to migation list
> 
> Separate thread:
>   migrate scanned pages to a toptier node based on heuristics
> 
> The overall code is heavily influenced by khugepaged design.
> 
> Signed-off-by: Raghavendra K T <raghavendra.kt@amd.com>


I'm really bad and reading code and not commenting on the 'small'
stuff.  So feel free to ignore this given the RFC status!
This sort of read through helps me get my head around a series.

> ---
>  mm/Kconfig    |   8 +++
>  mm/Makefile   |   1 +
>  mm/kmmscand.c | 176 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 185 insertions(+)
>  create mode 100644 mm/kmmscand.c
> 
> diff --git a/mm/Kconfig b/mm/Kconfig
> index 1b501db06417..5a4931633e15 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -783,6 +783,14 @@ config KSM
>  	  until a program has madvised that an area is MADV_MERGEABLE, and
>  	  root has set /sys/kernel/mm/ksm/run to 1 (if CONFIG_SYSFS is set).
>  
> +config KMMSCAND
> +	bool "Enable PTE A bit scanning and Migration"
> +	depends on NUMA_BALANCING
> +	help
> +	  Enable PTE A bit scanning of page. CXL pages accessed are migrated to

Trivial but don't mention CXL.  "Other memory tier solutions are available"

> +	  a regular NUMA node. The option creates a separate kthread for
> +	  scanning and migration.
> +

> diff --git a/mm/kmmscand.c b/mm/kmmscand.c
> new file mode 100644
> index 000000000000..6c55250b5cfb
> --- /dev/null
> +++ b/mm/kmmscand.c

> +
> +struct kmmscand_scan kmmscand_scan = {
> +	.mm_head = LIST_HEAD_INIT(kmmscand_scan.mm_head),
> +};
> +
> +static int kmmscand_has_work(void)
> +{

Unless this is going to get more complex, I'd just put
the implementation inline.  Kind of obvious what is doing
so the wrapper doesn't add much.

> +	return !list_empty(&kmmscand_scan.mm_head);
> +}
> +
> +static bool kmmscand_should_wakeup(void)
> +{
> +	bool wakeup =  kthread_should_stop() || need_wakeup ||

bonus space after =

> +	       time_after_eq(jiffies, kmmscand_sleep_expire);
> +	if (need_wakeup)
> +		need_wakeup = false;

Why not set it unconditionally?  If it is false already, no
harm done and removes need to check.

> +
> +	return wakeup;
> +}
> +
> +static void kmmscand_wait_work(void)
> +{
> +	const unsigned long scan_sleep_jiffies =
> +		msecs_to_jiffies(kmmscand_scan_sleep_ms);
> +
> +	if (!scan_sleep_jiffies)
> +		return;
> +
> +	kmmscand_sleep_expire = jiffies + scan_sleep_jiffies;
> +	wait_event_timeout(kmmscand_wait,
> +			kmmscand_should_wakeup(),
> +			scan_sleep_jiffies);

strange wrap.  Maybe add a comment on why we don't care if
this timed out or not.

> +	return;
> +}
> +
> +static unsigned long kmmscand_scan_mm_slot(void)
> +{
> +	/* placeholder for scanning */

I guess this will make sense later in series!

> +	msleep(100);
> +	return 0;
> +}
> +
> +static void kmmscand_do_scan(void)
> +{
> +	unsigned long iter = 0, mms_to_scan;
> +

	unsigned long mms_to_scan = READ_ONCE(kmmscand_mms_to_scan);

> +	mms_to_scan = READ_ONCE(kmmscand_mms_to_scan);
> +
> +	while (true) {
> +		cond_resched();

Odd to do this at start. Maybe at end of loop?

> +
> +		if (unlikely(kthread_should_stop()) ||
> +			!READ_ONCE(kmmscand_scan_enabled))
> +			break;
return;  Then we don't need to read on to see if anything else happens.
> +
> +		if (kmmscand_has_work())
> +			kmmscand_scan_mm_slot();
> +
> +		iter++;
> +		if (iter >= mms_to_scan)
> +			break;
			return;
Same argument as above.

> +	}
> +}
> +
> +static int kmmscand(void *none)
> +{
> +	for (;;) {

while (true) maybe.  Feels more natural to me for a loop
with no terminating condition.   Obviously same thing in practice.

> +		if (unlikely(kthread_should_stop()))
			return;
> +			break;
> +
> +		kmmscand_do_scan();
> +
> +		while (!READ_ONCE(kmmscand_scan_enabled)) {
> +			cpu_relax();
> +			kmmscand_wait_work();
> +		}
> +
> +		kmmscand_wait_work();
> +	}
> +	return 0;
> +}
> +
> +static int start_kmmscand(void)
> +{
> +	int err = 0;
> +
> +	guard(mutex)(&kmmscand_mutex);
> +
> +	/* Some one already succeeded in starting daemon */
> +	if (kmmscand_thread)
return 0;
> +		goto end;
> +
> +	kmmscand_thread = kthread_run(kmmscand, NULL, "kmmscand");
> +	if (IS_ERR(kmmscand_thread)) {
> +		pr_err("kmmscand: kthread_run(kmmscand) failed\n");
> +		err = PTR_ERR(kmmscand_thread);
> +		kmmscand_thread = NULL;

Use a local variable instead and only assign on success. That
way you don't need to null it out in this path.

> +		goto end;

return PTR_ERR(kmmscand_thread_local);

> +	} else {
> +		pr_info("kmmscand: Successfully started kmmscand");
No need for else give the other path exits.

> +	}
> +
> +	if (!list_empty(&kmmscand_scan.mm_head))
> +		wake_up_interruptible(&kmmscand_wait);
> +
> +end:
> +	return err;
> +}
> +
> +static int stop_kmmscand(void)
> +{
> +	int err = 0;

No point in err if always 0.

> +
> +	guard(mutex)(&kmmscand_mutex);
> +
> +	if (kmmscand_thread) {
> +		kthread_stop(kmmscand_thread);
> +		kmmscand_thread = NULL;
> +	}
> +
> +	return err;
> +}
> +
> +static int __init kmmscand_init(void)
> +{
> +	int err;
> +
> +	err = start_kmmscand();
> +	if (err)
> +		goto err_kmmscand;

start_kmmscand() should be side effect free if it is returning an
error.  Not doing that makes for hard to read code.

Superficially looks like it is already side effect free so you
can probably just return here.


> +
> +	return 0;
> +
> +err_kmmscand:
> +	stop_kmmscand();
> +
> +	return err;
> +}
> +subsys_initcall(kmmscand_init);


