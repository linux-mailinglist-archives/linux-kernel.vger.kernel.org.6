Return-Path: <linux-kernel+bounces-280365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD44694C997
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 07:20:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 848B31F24B17
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 05:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E69A516BE27;
	Fri,  9 Aug 2024 05:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="WM5m8X0Q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C14918E25
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 05:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723180808; cv=none; b=nouDlBAnLrUJnNG1JUFggoK5KNu6RGSdWQqtz5ZI0ADbNRJRrfgN5DLx7vCBlHEHu53O7s/tIxW0+6bHDhoCP6uIKnrDGWn8MJU0Rvk9LzN/BKoBrGdNQ8v70HNqxOXkjHanC+r4oBzEmBBqntGNkMjZtvmmPy413VF3ZBXNw0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723180808; c=relaxed/simple;
	bh=yzMqCYpZGTsjXi1DWGC9h3DsWjJ6QDDyqPUffbMvsps=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Sdt6ZRrdsiEMGcPwejI+SswZeTRWBnDWKlub+XffSBj4AhKgO6lha9tV8aqX5/TudYe5j9jLTaGL6bJf7P6qESEPyiApMkZUcVZDjqr8y+/79SpQJD5HqiMI263YojWzbBF/eqnvsiJLWLCmGtYa0F7m6sT5tUiOPk9y+hbH7Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=WM5m8X0Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4497BC4AF0D;
	Fri,  9 Aug 2024 05:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1723180807;
	bh=yzMqCYpZGTsjXi1DWGC9h3DsWjJ6QDDyqPUffbMvsps=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WM5m8X0QfF+/Z9lGQnSSvGLNbHm/e+vMSp7yLviYzINni3vjA/zhXsHBTstBIL139
	 78A5U0TUEZpQYFgrUVghlf1hutT/EjtHuDRIjApIn5rJpaft1C0McOoC3a3P8+wpDd
	 2EIS/PcrA3MS2C2CKaeBGF2oW9icmSRokJFrjEw8=
Date: Thu, 8 Aug 2024 22:20:06 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Saurabh Sengar <ssengar@linux.microsoft.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, ssengar@microsoft.com,
 wei.liu@kernel.org
Subject: Re: [PATCH] mm/vmstat: Defer the refresh_zone_stat_thresholds after
 all CPUs bringup
Message-Id: <20240808222006.72071b7b945b290e5270eb30@linux-foundation.org>
In-Reply-To: <1720169301-21002-1-git-send-email-ssengar@linux.microsoft.com>
References: <1720169301-21002-1-git-send-email-ssengar@linux.microsoft.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  5 Jul 2024 01:48:21 -0700 Saurabh Sengar <ssengar@linux.microsoft.com> wrote:

> refresh_zone_stat_thresholds function has two loops which is expensive for
> higher number of CPUs and NUMA nodes.
> 
> Below is the rough estimation of total iterations done by these loops
> based on number of NUMA and CPUs.
> 
> Total number of iterations: nCPU * 2 * Numa * mCPU
> Where:
>  nCPU = total number of CPUs
>  Numa = total number of NUMA nodes
>  mCPU = mean value of total CPUs (e.g., 512 for 1024 total CPUs)
> 
> For the system under test with 16 NUMA nodes and 1024 CPUs, this
> results in a substantial increase in the number of loop iterations
> during boot-up when NUMA is enabled:
> 
> No NUMA = 1024*2*1*512  =   1,048,576 : Here refresh_zone_stat_thresholds
> takes around 224 ms total for all the CPUs in the system under test.
> 16 NUMA = 1024*2*16*512 =  16,777,216 : Here refresh_zone_stat_thresholds
> takes around 4.5 seconds total for all the CPUs in the system under test.
> 
> Calling this for each CPU is expensive when there are large number
> of CPUs along with multiple NUMAs. Fix this by deferring
> refresh_zone_stat_thresholds to be called later at once when all the
> secondary CPUs are up. Also, register the DYN hooks to keep the
> existing hotplug functionality intact.
>
> ...
>
> --- a/mm/vmstat.c
> +++ b/mm/vmstat.c
> @@ -31,6 +31,7 @@
>  
>  #include "internal.h"
>  
> +static int vmstat_late_init_done;
>  #ifdef CONFIG_NUMA
>  int sysctl_vm_numa_stat = ENABLE_NUMA_STAT;
>  
> @@ -2107,7 +2108,8 @@ static void __init init_cpu_node_state(void)
>  
>  static int vmstat_cpu_online(unsigned int cpu)
>  {
> -	refresh_zone_stat_thresholds();
> +	if (vmstat_late_init_done)
> +		refresh_zone_stat_thresholds();
>  
>  	if (!node_state(cpu_to_node(cpu), N_CPU)) {
>  		node_set_state(cpu_to_node(cpu), N_CPU);
> @@ -2139,6 +2141,14 @@ static int vmstat_cpu_dead(unsigned int cpu)
>  	return 0;
>  }
>  
> +static int __init vmstat_late_init(void)
> +{
> +	refresh_zone_stat_thresholds();
> +	vmstat_late_init_done = 1;
> +
> +	return 0;
> +}
> +late_initcall(vmstat_late_init);

OK, so what's happening here.  Once all CPUs are online and running
around doing heaven knows what, one of the CPUs sets up everyone's
thresholds.  So for a period, all the other CPUs are running with
inappropriate threshold values.

So what are all the other CPUs doing at this point in time, and why is
it safe to leave their thresholds in an inappropriate state while they
are doing it?


