Return-Path: <linux-kernel+bounces-280385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA6F094C9DD
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 07:50:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65FFB281A10
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 05:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E2BD16C847;
	Fri,  9 Aug 2024 05:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="LnQXcxUW"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C3E334CDD
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 05:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723182598; cv=none; b=KeXj7IyuMbITAhqQlPtmOIcQD7VL4mSWnUCdgqJEesDOyI1q8cf5QN13oElYq4hawhS+AZ/IP1Imr3DURs6FsdoTxxHPlXWUSvBEqeVHJB6unUNWwzCmt0XCHr6zA3nkWO8pW5tc9KgA6Lqy9Z/V3rCFqUMDQQ41+X5CONTWLp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723182598; c=relaxed/simple;
	bh=vGVQw6HM7s6ctRJSm0vJ/Kdj8GFEiVIqCoeUbIh8NeE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NG8XtGvJdU5EvpH3WYktDcS3D1n19UV3A/TTYR3CXIfFVoJp8scyghKh4+M/OoN3NlrH9lEhSShcdJaUGeJHuOknpfwBlAF+vz8bgo1PRZSIV/8NeobMwgCeln+deRcnZBMVarA4TDyd+eltlpp4dNONiUzFoR9K/WsFKGOZHCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=LnQXcxUW; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1127)
	id 233F020B7165; Thu,  8 Aug 2024 22:49:56 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 233F020B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1723182596;
	bh=UhQ1H6gi9SswMxmgtyTkcFeAEphqY31W/5bcdJDEhYc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LnQXcxUWVinPlqMhZwA94DjJIumNgXIxKrq05fH/f1aA2oD98BRffuzBW7SQ8J3Dd
	 F4rsp5Q8uN3OXBr/nsU8RJ2JfgXrVNwA+BPxmQAMj8zRthUKzPzvg+CHfhNT5rK+0z
	 +Il0hnN6bT5ieUvMurRXTsk3frsspRuZl1Ihwjxg=
Date: Thu, 8 Aug 2024 22:49:56 -0700
From: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, ssengar@microsoft.com,
	wei.liu@kernel.org
Subject: Re: [PATCH] mm/vmstat: Defer the refresh_zone_stat_thresholds after
 all CPUs bringup
Message-ID: <20240809054956.GA12044@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1720169301-21002-1-git-send-email-ssengar@linux.microsoft.com>
 <20240808222006.72071b7b945b290e5270eb30@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240808222006.72071b7b945b290e5270eb30@linux-foundation.org>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Thu, Aug 08, 2024 at 10:20:06PM -0700, Andrew Morton wrote:
> On Fri,  5 Jul 2024 01:48:21 -0700 Saurabh Sengar <ssengar@linux.microsoft.com> wrote:
> 
> > refresh_zone_stat_thresholds function has two loops which is expensive for
> > higher number of CPUs and NUMA nodes.
> > 
> > Below is the rough estimation of total iterations done by these loops
> > based on number of NUMA and CPUs.
> > 
> > Total number of iterations: nCPU * 2 * Numa * mCPU
> > Where:
> >  nCPU = total number of CPUs
> >  Numa = total number of NUMA nodes
> >  mCPU = mean value of total CPUs (e.g., 512 for 1024 total CPUs)
> > 
> > For the system under test with 16 NUMA nodes and 1024 CPUs, this
> > results in a substantial increase in the number of loop iterations
> > during boot-up when NUMA is enabled:
> > 
> > No NUMA = 1024*2*1*512  =   1,048,576 : Here refresh_zone_stat_thresholds
> > takes around 224 ms total for all the CPUs in the system under test.
> > 16 NUMA = 1024*2*16*512 =  16,777,216 : Here refresh_zone_stat_thresholds
> > takes around 4.5 seconds total for all the CPUs in the system under test.
> > 
> > Calling this for each CPU is expensive when there are large number
> > of CPUs along with multiple NUMAs. Fix this by deferring
> > refresh_zone_stat_thresholds to be called later at once when all the
> > secondary CPUs are up. Also, register the DYN hooks to keep the
> > existing hotplug functionality intact.
> >
> > ...
> >
> > --- a/mm/vmstat.c
> > +++ b/mm/vmstat.c
> > @@ -31,6 +31,7 @@
> >  
> >  #include "internal.h"
> >  
> > +static int vmstat_late_init_done;
> >  #ifdef CONFIG_NUMA
> >  int sysctl_vm_numa_stat = ENABLE_NUMA_STAT;
> >  
> > @@ -2107,7 +2108,8 @@ static void __init init_cpu_node_state(void)
> >  
> >  static int vmstat_cpu_online(unsigned int cpu)
> >  {
> > -	refresh_zone_stat_thresholds();
> > +	if (vmstat_late_init_done)
> > +		refresh_zone_stat_thresholds();
> >  
> >  	if (!node_state(cpu_to_node(cpu), N_CPU)) {
> >  		node_set_state(cpu_to_node(cpu), N_CPU);
> > @@ -2139,6 +2141,14 @@ static int vmstat_cpu_dead(unsigned int cpu)
> >  	return 0;
> >  }
> >  
> > +static int __init vmstat_late_init(void)
> > +{
> > +	refresh_zone_stat_thresholds();
> > +	vmstat_late_init_done = 1;
> > +
> > +	return 0;
> > +}
> > +late_initcall(vmstat_late_init);
> 
> OK, so what's happening here.  Once all CPUs are online and running
> around doing heaven knows what, one of the CPUs sets up everyone's
> thresholds.  So for a period, all the other CPUs are running with
> inappropriate threshold values.
> 
> So what are all the other CPUs doing at this point in time, and why is
> it safe to leave their thresholds in an inappropriate state while they
> are doing it?

From what I undersatnd these threshold values are primarily used by
userspace tools, and this data will be useful post late_initcall only.

If there’s a more effective approach to handle this, please let me know,
and I can investigate further.

- Saurabh

