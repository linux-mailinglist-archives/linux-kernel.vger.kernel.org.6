Return-Path: <linux-kernel+bounces-259574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E3EA99398BA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 05:39:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C9C9B21B07
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 03:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD61413B5B4;
	Tue, 23 Jul 2024 03:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gJ54VKtM"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E2B2C9D
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 03:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721705932; cv=none; b=u1UxfAbzi++3MQh4TLdlRTLeSHTPz6XSRerhA+bQfxAadznZ3MClZWLM1Yoap0dWWiBiZ+r5fsEwrKQV3I4fhaxioHDyFKlJQdpwdmaaT42AnA3wfDru2kiA61z1L8OUMc+bVoQRLmwE5civLDdxC5UcSkmw5er2UJfU5a4bnqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721705932; c=relaxed/simple;
	bh=1631P6e/mcs9hwEOVcOrQkreV28dqYK4PniggGBcbso=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nKb/4kCTwfVfMMtCCRCX81NwzR/8IFL3GWR4SH6sI/K+tWP/TkrYZt8g5UJJXNItfjFObCMdqWoo6AY+B2y0OjauQPSogayZQKNGt/7+8vMIigDtVv70raKZl1Pam7CWdnkZaToWvj9if+/z0gRIMLDsVbUdyXhB4ORIb1H/qxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gJ54VKtM; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721705930; x=1753241930;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=1631P6e/mcs9hwEOVcOrQkreV28dqYK4PniggGBcbso=;
  b=gJ54VKtMfCMAjBRPvp6X9/UgoKSlR9BiUbmuj6hOkXz8jVAiQ4whJ5XQ
   nMANMTlt46eSyuQRYyK3Wc2R7a4hnCu6MdEXFPLUdjPAP9bhh2es43UIh
   Wl09kMJ4NYi4XjmaEgn+7VT9s4NIlYrQiB2b+2Pso3UI8/gDVUX4l4kGk
   kxyIpUiMtycirXd2B2zKw3ncgx+vWaFmSzqHIWWvwXeWuohagXz+tBIJb
   04tJFaUVUKBs7Eoq961jo7qgNWh2jePbBp4NES0l7KpgqvmTh5zyM50+T
   Fx0QhJReHln17swAeeA7L+yenhq4BRZUxbSfWBIwiUXcY2E6xkQCGAXm6
   A==;
X-CSE-ConnectionGUID: IB0K2bvlSnWMl+dXvZkSlA==
X-CSE-MsgGUID: xqpLj4yfRsWtMSg+Q9Qosw==
X-IronPort-AV: E=McAfee;i="6700,10204,11141"; a="29895398"
X-IronPort-AV: E=Sophos;i="6.09,229,1716274800"; 
   d="scan'208";a="29895398"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2024 20:38:49 -0700
X-CSE-ConnectionGUID: gDjPZIziQauDyW62ia0RZQ==
X-CSE-MsgGUID: Ybl3aCNrQJKGv0QsZpBNuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,229,1716274800"; 
   d="scan'208";a="89553417"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2024 20:38:47 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Zhongkun He <hezhongkun.hzk@bytedance.com>
Cc: peterz@infradead.org,  mgorman@suse.de,  linux-mm@kvack.org,
  linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH] mm/numa_balancing: Fix the memory thrashing problem in
 the single-threaded process
In-Reply-To: <20240722123320.2382992-1-hezhongkun.hzk@bytedance.com> (Zhongkun
	He's message of "Mon, 22 Jul 2024 20:33:20 +0800")
References: <20240722123320.2382992-1-hezhongkun.hzk@bytedance.com>
Date: Tue, 23 Jul 2024 11:35:14 +0800
Message-ID: <871q3kg4r1.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Zhongkun He <hezhongkun.hzk@bytedance.com> writes:

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

Show the test results (numa stats) of the fixed kernel?

> Signed-off-by: Zhongkun He <hezhongkun.hzk@bytedance.com>
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

The change looks reasonable for me, Thanks!

Acked-by: "Huang, Ying" <ying.huang@intel.com>

--
Best Regards,
Huang, Ying

