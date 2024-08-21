Return-Path: <linux-kernel+bounces-295551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 545D0959E30
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 15:09:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D96D1C223DB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 13:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7D86192D9C;
	Wed, 21 Aug 2024 13:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=techsingularity.net header.i=@techsingularity.net header.b="UxEdYdwD"
Received: from mail12.out.titan.email (mail12.out.titan.email [18.198.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9DD91531EB
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 13:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.198.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724245763; cv=none; b=RUGdnHJx5FotPWrl/HFHvTB6nAhIwXgiUU4JUi9w3Sz9c3+RVcp/4uEQouc1J0daHvDy3Re0CsyIB+viBojVFXdZMDtVAlxmvRWqM/R5+QZdKYKqi5rHLrHF6AWdrDMRWmbRyBnphkfGyEdp4oFcYBqAjycfw7wd/OSNrHAcG1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724245763; c=relaxed/simple;
	bh=My7y7J5HNdnS02v5jM3lavqokyVawL/T+ney0aPVpZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TrqZXXIR57SSLzL/phXEEYCBjE65/FAwEBaq3B3IJMynrkc/e2EkM2k15jrj9lxJuLZ8Rig/VgAalxQrVzqtqnCqwfRXPUmIHLx3pdK25tNXWgte7SLYjQkKRjW1lCJ0lFW5UMflMrHm5364u8HOHhl0h53Qwj44G+9C2UJvbN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=techsingularity.net; spf=pass smtp.mailfrom=techsingularity.net; dkim=pass (1024-bit key) header.d=techsingularity.net header.i=@techsingularity.net header.b=UxEdYdwD; arc=none smtp.client-ip=18.198.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=techsingularity.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=techsingularity.net
Received: from smtp-out0101.titan.email (localhost [127.0.0.1])
	by smtp-out0101.titan.email (Postfix) with ESMTP id 13594A0039;
	Wed, 21 Aug 2024 10:04:18 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; bh=3lvVL1/ui3rYgyHVZcQEFCfPPiHCwpxTUiDjUkvuW0E=;
	c=relaxed/relaxed; d=techsingularity.net;
	h=message-id:date:cc:references:from:subject:in-reply-to:to:mime-version:from:to:cc:subject:date:message-id:in-reply-to:references:reply-to;
	q=dns/txt; s=titan1; t=1724234658; v=1;
	b=UxEdYdwDdH+d2Si0oIsO4pUO9SXTK3PLyUCOO7UY3v7U0ldCy828BMlb1sK6Ugd3k+4oA5FU
	IfXmai5+6pewi34hBUVjz//zLzGCZi1KLu57SY46pqIhFbU0q75EpUDbuqAbLGNaWMZTwBZwKkK
	aBClmkNUr5wOftWxKdsZWWL8=
Received: from mail.blacknight.com (ip-84-203-196-95.broadband.digiweb.ie [84.203.196.95])
	by smtp-out0101.titan.email (Postfix) with ESMTPA id 352B4A0074;
	Wed, 21 Aug 2024 10:04:17 +0000 (UTC)
Date: Wed, 21 Aug 2024 11:04:14 +0100
Feedback-ID: :mgorman@techsingularity.net:techsingularity.net:flockmailId
From: Mel Gorman <mgorman@techsingularity.net>
To: Yujie Liu <yujie.liu@intel.com>
Cc: Raghavendra K T <raghavendra.kt@amd.com>, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Chen Yu <yu.chen.surf@gmail.com>, Tim Chen <tim.c.chen@intel.com>, linux-kernel@vger.kernel.org, 
	Xiaoping Zhou <xiaoping.zhou@intel.com>, Chen Yu <yu.c.chen@intel.com>
Subject: Re: [PATCH v2] sched/numa: Fix the vma scan starving issue
Message-ID: <5s55bgrmpomlpefmvt4bz7t2myvjnbw6lnvtsnbkdphwfb7zdo@tnm7flx5jidu>
References: <20240805082228.4082656-1-yujie.liu@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20240805082228.4082656-1-yujie.liu@intel.com>
X-F-Verdict: SPFVALID
X-Titan-Src-Out: 1724234657951595086.19953.5304654029938163147@prod-euc1-smtp-out1002.
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.4 cv=RdqWCUtv c=1 sm=1 tr=0 ts=66c5bba1
	a=yLX2s/SMutoCvBNwHxSr4A==:117 a=yLX2s/SMutoCvBNwHxSr4A==:17
	a=Q9fys5e9bTEA:10 a=CEWIc4RMnpUA:10 a=QyXUC8HyAAAA:8 a=zd2uoN0lAAAA:8
	a=R_Myd5XaAAAA:8 a=x3rUVTaim7rB7NycJ50A:9 a=PUjeQqilurYA:10
	a=L2g4Dz8VuBQ37YGmWQah:22
X-Virus-Scanned: ClamAV using ClamSMTP

On Mon, Aug 05, 2024 at 04:22:28PM +0800, Yujie Liu wrote:
> Problem statement:
> Since commit fc137c0ddab2 ("sched/numa: enhance vma scanning logic"), the
> Numa vma scan overhead has been reduced a lot. Meanwhile, the reducing of
> the vma scan might create less Numa page fault information. The
> insufficient information makes it harder for the Numa balancer to make
> decision. Later, commit b7a5b537c55c08 ("sched/numa: Complete scanning of
> partial VMAs regardless of PID activity") and commit 84db47ca7146d7
> ("sched/numa: Fix mm numa_scan_seq based unconditional scan") are found
> to bring back part of the performance.
> 
> Recently when running SPECcpu omnetpp_r on a 320 CPUs/2 Sockets system,
> a long duration of remote Numa node read was observed by PMU events:
> A few cores having ~500MB/s remote memory access for ~20 seconds.
> It causes high core-to-core variance and performance penalty. After the
> investigation, it is found that many vmas are skipped due to the active
> PID check. According to the trace events, in most cases, vma_is_accessed()
> returns false because the history access info stored in pids_active
> array has been cleared.
> 
> Proposal:
> The main idea is to adjust vma_is_accessed() to let it return true easier.
> Thus compare the diff between mm->numa_scan_seq and
> vma->numab_state->prev_scan_seq. If the diff has exceeded the threshold,
> scan the vma.
> 
> This patch especially helps the cases where there are small number of
> threads, like the process-based SPECcpu. Without this patch, if the
> SPECcpu process access the vma at the beginning, then sleeps for a long
> time, the pid_active array will be cleared. A a result, if this process
> is woken up again, it never has a chance to set prot_none anymore.
> Because only the first 2 times of access is granted for vma scan:
> (current->mm->numa_scan_seq) - vma->numab_state->start_scan_seq) < 2
> to be worse, no other threads within the task can help set the prot_none.
> This causes information lost.
> 
> Raghavendra helped test current patch and got the positive result
> on the AMD platform:
> 
> autonumabench NUMA01
>                             base                  patched
> Amean     syst-NUMA01      194.05 (   0.00%)      165.11 *  14.92%*
> Amean     elsp-NUMA01      324.86 (   0.00%)      315.58 *   2.86%*
> 
> Duration User      380345.36   368252.04
> Duration System      1358.89     1156.23
> Duration Elapsed     2277.45     2213.25
> 
> autonumabench NUMA02
> 
> Amean     syst-NUMA02        1.12 (   0.00%)        1.09 *   2.93%*
> Amean     elsp-NUMA02        3.50 (   0.00%)        3.56 *  -1.84%*
> 
> Duration User        1513.23     1575.48
> Duration System         8.33        8.13
> Duration Elapsed       28.59       29.71
> 
> kernbench
> 
> Amean     user-256    22935.42 (   0.00%)    22535.19 *   1.75%*
> Amean     syst-256     7284.16 (   0.00%)     7608.72 *  -4.46%*
> Amean     elsp-256      159.01 (   0.00%)      158.17 *   0.53%*
> 
> Duration User       68816.41    67615.74
> Duration System     21873.94    22848.08
> Duration Elapsed      506.66      504.55
> 
> Intel 256 CPUs/2 Sockets:
> autonuma benchmark also shows improvements:
> 
>                                                v6.10-rc5              v6.10-rc5
>                                                                          +patch
> Amean     syst-NUMA01                  245.85 (   0.00%)      230.84 *   6.11%*
> Amean     syst-NUMA01_THREADLOCAL      205.27 (   0.00%)      191.86 *   6.53%*
> Amean     syst-NUMA02                   18.57 (   0.00%)       18.09 *   2.58%*
> Amean     syst-NUMA02_SMT                2.63 (   0.00%)        2.54 *   3.47%*
> Amean     elsp-NUMA01                  517.17 (   0.00%)      526.34 *  -1.77%*
> Amean     elsp-NUMA01_THREADLOCAL       99.92 (   0.00%)      100.59 *  -0.67%*
> Amean     elsp-NUMA02                   15.81 (   0.00%)       15.72 *   0.59%*
> Amean     elsp-NUMA02_SMT               13.23 (   0.00%)       12.89 *   2.53%*
> 
>                    v6.10-rc5   v6.10-rc5
>                                   +patch
> Duration User     1064010.16  1075416.23
> Duration System      3307.64     3104.66
> Duration Elapsed     4537.54     4604.73
> 
> The SPECcpu remote node access issue disappears with the patch applied.
> 
> Fixes: fc137c0ddab2 ("sched/numa: enhance vma scanning logic")
> Reported-by: Xiaoping Zhou <xiaoping.zhou@intel.com>
> Reviewed-and-tested-by: Raghavendra K T <raghavendra.kt@amd.com>
> Co-developed-by: Chen Yu <yu.c.chen@intel.com>
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> Signed-off-by: Yujie Liu <yujie.liu@intel.com>

Ok, I didn't exactly replicate the autonuma test results but then again,
I'd be a little surprised it was affected by this issue. The rescan
decision is a bit arbitrary but I see no obviously better alternative
and the patch is fixing an important corner case so

Acked-by: Mel Gorman <mgorman@techsingularity.net>

Sorry for the long delay in reviewing, my backlog for upstream work is
insane :(

-- 
Mel Gorman
SUSE Labs

