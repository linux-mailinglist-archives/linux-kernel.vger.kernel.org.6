Return-Path: <linux-kernel+bounces-444326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEFF69F04D2
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 07:31:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0321284A6D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 06:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8835218B482;
	Fri, 13 Dec 2024 06:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="oF934AGk"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71EFE15383B
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 06:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734071504; cv=none; b=p3VFu12wnIJgwCAXFQyd/FJj1jnuFtWm9VT9NfoZIuLs8hTIrkFLR/M+ZDXEixFSd1qqBkHAM/fgnTMULT1t4eJxDKQhAwPIMZXKJATVpusTjj2jzYvTDLB5m/GGaOeJk2ZJHyQ0tUb8iEqP/RjsxvqzNEvzcd3uIMKMnghfIXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734071504; c=relaxed/simple;
	bh=oHDY46pwDGUR7QLxCV9Z6mRLljPXcgs5OW1k8MYw7Uw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZnHB5gLyUjulBGUVzutiQmrcIg2Oeqc7+ECEFLQhSDJEk7qzk8q1JsW562RXzX3amIzSnsggf4ox6tkFeyeJQTWHc25WxJ11008Zgqo4vhU21QoJDTct2csa7wLBhKjM/XT39uwGDlcVkcEh1qKwAJLyoK8hSzmzwrjXMlWm7NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=oF934AGk; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1127)
	id B3474204BA92; Thu, 12 Dec 2024 22:31:37 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B3474204BA92
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1734071497;
	bh=vTVAiq2+IzxAdRwAJ4qMh6NkgYXSYWGX5o5kBIPu5Oc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oF934AGkOJc0LTeVStIBdfmd3qDDasWzwCzx1rIY0sZzrdFx7lx4dfJ4P/QPoJjW3
	 o5aJ+a7sTcKKgKaFpp7wn3DeHThX8sv0rWRPUdBGfs+HARvWs7jKQiiunOTjjhkniN
	 7khjkyTIyIlbjZifTQ9wsr2RHJf9DN+UvRGahnew=
Date: Thu, 12 Dec 2024 22:31:37 -0800
From: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To: Steve Wahl <steve.wahl@hpe.com>, peterz@infradead.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, linux-kernel@vger.kernel.org,
	kprateek.nayak@amd.com, vishalc@linux.ibm.com, samir@linux.ibm.com
Cc: rja@hpe.com, sivanich@hpe.com, mhklinux@outlook.com
Subject: Re: [PATCH v2] sched/topology: improve topology_span_sane speed
Message-ID: <20241213063137.GA16800@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20241031200431.182443-1-steve.wahl@hpe.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241031200431.182443-1-steve.wahl@hpe.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Thu, Oct 31, 2024 at 03:04:31PM -0500, Steve Wahl wrote:
> Use a different approach to topology_span_sane(), that checks for the
> same constraint of no partial overlaps for any two CPU sets for
> non-NUMA topology levels, but does so in a way that is O(N) rather
> than O(N^2).
> 
> Instead of comparing with all other masks to detect collisions, keep
> one mask that includes all CPUs seen so far and detect collisions with
> a single cpumask_intersects test.
> 
> If the current mask has no collisions with previously seen masks, it
> should be a new mask, which can be uniquely identified ("id") by the
> lowest bit set in this mask.  Mark that we've seen a mask with this
> id, and add the CPUs in this mask to the list of those seen.
> 
> If the current mask does collide with previously seen masks, it should
> be exactly equal to a mask seen before, identified once again by the
> lowest bit the current mask has set.  It's an error if we haven't seen
> a mask with that id, or if the current mask doesn't match the one we
> get by looking up that id.
> 
> Move the topology_span_sane() check out of the existing topology level
> loop, let it do its own looping to match the needs of this algorithm.
> 
> On a system with 1920 processors (16 sockets, 60 cores, 2 threads),
> the average time to take one processor offline is reduced from 2.18
> seconds to 1.01 seconds.  (Off-lining 959 of 1920 processors took
> 34m49.765s without this change, 16m10.038s with this change in place.)
> 
> Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
> Tested-by: Michael Kelley <mhklinux@outlook.com>
> Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
> ---
> Version 2: Adopted suggestion by K Prateek Nayak that removes an array and
> simplifies the code, and eliminates the erroneous use of
> num_possible_cpus() that Peter Zijlstra noted.
> 
> Version 1 discussion:
>     https://lore.kernel.org/all/20241010155111.230674-1-steve.wahl@hpe.com/
> 
>  kernel/sched/topology.c | 73 +++++++++++++++++++++++++++--------------
>  1 file changed, 48 insertions(+), 25 deletions(-)
> 
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index 9748a4c8d668..6a2a3e91d59e 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -2356,35 +2356,58 @@ static struct sched_domain *build_sched_domain(struct sched_domain_topology_leve
>  
>  /*
>   * Ensure topology masks are sane, i.e. there are no conflicts (overlaps) for
> - * any two given CPUs at this (non-NUMA) topology level.
> + * any two given CPUs on non-NUMA topology levels.
>   */
> -static bool topology_span_sane(struct sched_domain_topology_level *tl,

<snip>

Subject: RE: [PATCH v2] sched/topology: improve topology_span_sane speed

Apologies for the delayed response, finding such machines for testing
is challenging.

I finally managed to test this patch on a large VM with 1792 vCPUs and
28 NUMA nodes. The CPUs in the test reported BogoMIPS of 3800. For this
test, I measured the time taken by the build_sched_domains function
during the boot-up.

Here are the results:

Without this patch, the build_sched_domains function took approximately
2.33 seconds on the above system. With this patch applied, the time
reduced to 1.14 seconds, resulting in a savings of around 1.2 seconds.
I understand that systems with less powerful CPUs may see even greater
improvements, but I do not currently have access to such hardware.
Therefore, this testing should be considered in relative terms.

I tested this patch purely for performance evaluation. If suitable,
please feel free to add:
Tested-by: Saurabh Sengar <ssengar@linux.microsoft.com>

Are there any remaining concerns with this patch which we can address ?

- Saurabh

