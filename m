Return-Path: <linux-kernel+bounces-259616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF7EF939995
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 08:16:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D2E2B21B0B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 06:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 246A313C813;
	Tue, 23 Jul 2024 06:15:59 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4E3ABE6C
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 06:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721715358; cv=none; b=O16KDSMgG/rv4h/YUNTruvgh1eRx4+cufyohCA7oY7oD+d6jM3DcOEBCkFH55j3kap5UV01VO4XuZpb02z9mfwMOyZXZNT4KEVe+svYprgDHGtDaMEkth03eWxP772qERnH4uN/4AI+RfQiP+98lSLMkjeWzvvBgEvnkVV/gt04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721715358; c=relaxed/simple;
	bh=gAnFwDO9A9GzUbYVLZQgZF63joEkrNCbX7S+PwLJcig=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oXJW78JXD3N9Kj+OMsMFMOXHbDF9yKtjaow3C28Yuq14TvoZatr0HBeozeWYGpbJCjpEc1JQBjrQFxdEb76D7uxdeDv9Vdyum1BBgE0tOOISRwC4j5EFxGfwQmkcYxt92PHIxt5Me95x5ok55yLK9yerQ0QWZfxcwI6eRrzWNzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5B872139F;
	Mon, 22 Jul 2024 23:16:20 -0700 (PDT)
Received: from [10.163.54.37] (unknown [10.163.54.37])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 619103F73F;
	Mon, 22 Jul 2024 23:15:50 -0700 (PDT)
Message-ID: <ea121294-eeaf-42b1-bc1c-186f4ea7be1d@arm.com>
Date: Tue, 23 Jul 2024 11:45:46 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] mm/numa_balancing: Fix the memory thrashing problem in
 the single-threaded process
To: Zhongkun He <hezhongkun.hzk@bytedance.com>, peterz@infradead.org,
 mgorman@suse.de, ying.huang@intel.com
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, wuyun.abel@bytedance.com
References: <20240723053250.3263125-1-hezhongkun.hzk@bytedance.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20240723053250.3263125-1-hezhongkun.hzk@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/23/24 11:02, Zhongkun He wrote:
> I found a problem in my test machine that the memory of a process is
> repeatedly migrated between two nodes and does not stop.
> 
> 1.Test step and the machines.
> ------------
> VM machine: 4 numa nodes and 10GB per node.
> 
> stress --vm 1 --vm-bytes 12g --vm-keep
> 
> The info of numa stat:
> while :;do cat memory.numa_stat | grep -w anon;sleep 5;done
> anon N0=98304 N1=0 N2=10250747904 N3=2634334208
> anon N0=98304 N1=0 N2=10250747904 N3=2634334208
> anon N0=98304 N1=0 N2=9937256448 N3=2947825664
> anon N0=98304 N1=0 N2=8863514624 N3=4021567488
> anon N0=98304 N1=0 N2=7789772800 N3=5095309312
> anon N0=98304 N1=0 N2=6716030976 N3=6169051136
> anon N0=98304 N1=0 N2=5642289152 N3=7242792960
> anon N0=98304 N1=0 N2=5105442816 N3=7779639296
> anon N0=98304 N1=0 N2=5105442816 N3=7779639296
> anon N0=98304 N1=0 N2=4837007360 N3=8048074752
> anon N0=98304 N1=0 N2=3763265536 N3=9121816576
> anon N0=98304 N1=0 N2=2689523712 N3=10195558400
> anon N0=98304 N1=0 N2=2515148800 N3=10369933312
> anon N0=98304 N1=0 N2=2515148800 N3=10369933312
> anon N0=98304 N1=0 N2=2515148800 N3=10369933312
> anon N0=98304 N1=0 N2=3320455168 N3=9564626944
> anon N0=98304 N1=0 N2=4394196992 N3=8490885120
> anon N0=98304 N1=0 N2=5105442816 N3=7779639296
> anon N0=98304 N1=0 N2=6174195712 N3=6710886400
> anon N0=98304 N1=0 N2=7247937536 N3=5637144576
> anon N0=98304 N1=0 N2=8321679360 N3=4563402752
> anon N0=98304 N1=0 N2=9395421184 N3=3489660928
> anon N0=98304 N1=0 N2=10247872512 N3=2637209600
> anon N0=98304 N1=0 N2=10247872512 N3=2637209600
> 
> 2. Root cause:
> Since commit 3e32158767b0 ("mm/mprotect.c: don't touch single threaded
> PTEs which are on the right node")the PTE of local pages will not be
> changed in change_pte_range() for single-threaded process, so no
> page_faults information will be generated in do_numa_page(). If a
> single-threaded process has memory on another node, it will
> unconditionally migrate all of it's local memory to that node,
> even if the remote node has only one page.
> 
> So, let's fix it. The memory of single-threaded process should follow
> the cpu, not the numa faults info in order to avoid memory thrashing.
> 
> After a long time of testing, there is no memory thrashing
> from the beginning.
> 
> while :;do cat memory.numa_stat | grep -w anon;sleep 5;done
> anon N0=2548117504 N1=10336903168 N2=139264 N3=0
> anon N0=2548117504 N1=10336903168 N2=139264 N3=0
> anon N0=2548117504 N1=10336903168 N2=139264 N3=0
> anon N0=2548117504 N1=10336903168 N2=139264 N3=0
> anon N0=2548117504 N1=10336903168 N2=139264 N3=0
> anon N0=2548117504 N1=10336903168 N2=139264 N3=0
> anon N0=2548117504 N1=10336903168 N2=139264 N3=0
> anon N0=2548117504 N1=10336903168 N2=139264 N3=0
> anon N0=2548117504 N1=10336903168 N2=139264 N3=0
> anon N0=2548117504 N1=10336903168 N2=139264 N3=0
> anon N0=2548117504 N1=10336903168 N2=139264 N3=0
> anon N0=2548117504 N1=10336903168 N2=139264 N3=0
> anon N0=2548117504 N1=10336903168 N2=139264 N3=0
> anon N0=2548117504 N1=10336903168 N2=139264 N3=0
> 
> V1:
> -- Add the test results (numa stats) from Ying's feedback
> 
> Signed-off-by: Zhongkun He <hezhongkun.hzk@bytedance.com>
> Acked-by: "Huang, Ying" <ying.huang@intel.com>
> ---
>  kernel/sched/fair.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 24dda708b699..d7cbbda568fb 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -2898,6 +2898,12 @@ static void task_numa_placement(struct task_struct *p)
>  		numa_group_count_active_nodes(ng);
>  		spin_unlock_irq(group_lock);
>  		max_nid = preferred_group_nid(p, max_nid);
> +	} else if (atomic_read(&p->mm->mm_users) == 1) {
> +		/*
> +		 * The memory of a single-threaded process should
> +		 * follow the CPU in order to avoid memory thrashing.
> +		 */
> +		max_nid = numa_node_id();
>  	}
>  
>  	if (max_faults) {

This in fact makes sense for a single threaded process but just
wondering could there be any other unwanted side effects ?

