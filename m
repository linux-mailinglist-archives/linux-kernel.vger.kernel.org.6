Return-Path: <linux-kernel+bounces-334015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E2697D166
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 08:58:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98F461C22D3C
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 06:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3936142ABD;
	Fri, 20 Sep 2024 06:58:52 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56B25433D6
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 06:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726815531; cv=none; b=blEgV90gGakAsxkJcNma0A2C9HzqiDBLaFlg4425x9YiOr0sW3m0NPit0QQhvYYUDhFlsZmr17F1fq0WyStFRIU0VGsUtndeRp544mMmiep+H8c6steOjaHIS/Afsd/WZNkw4Lf+uaoVJsD9iuvvGxDOn9x6HzbG24CoQnlgscI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726815531; c=relaxed/simple;
	bh=mnslPytw/GT5iBSuOmGhwFzMETeBcTXbPtH4/UY+3BM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YZiJiG6tFeEYoIm8jOsbTeev3p8qGgvoC1mYSwK8nlwdYHza9UZ/Dd4y3KgptAGQeuPCKniCAdFcy/Nex889ikkgf7LccCoX4yUQhHTkJvnmcIvuD84Wn7z4EPyEhO8JHYVnEJmIJN0Urv08NV+3/sHzd5QVlg/R9/ag5Mm5aBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D78D7FEC;
	Thu, 19 Sep 2024 23:59:18 -0700 (PDT)
Received: from [10.163.35.184] (unknown [10.163.35.184])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3F4693F64C;
	Thu, 19 Sep 2024 23:58:46 -0700 (PDT)
Message-ID: <b1dc2aa1-cd38-4f1f-89e9-6d009a619541@arm.com>
Date: Fri, 20 Sep 2024 12:28:44 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm/vmstat: Defer the refresh_zone_stat_thresholds
 after all CPUs bringup
To: Saurabh Sengar <ssengar@linux.microsoft.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: ssengar@microsoft.com, wei.liu@kernel.org, srivatsa@csail.mit.edu
References: <1723443220-20623-1-git-send-email-ssengar@linux.microsoft.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <1723443220-20623-1-git-send-email-ssengar@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/12/24 11:43, Saurabh Sengar wrote:
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
> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> ---
> [V2]
> 	- Move vmstat_late_init_done under CONFIG_SMP to fix
>           variable 'defined but not used' warning.
> 
>  mm/vmstat.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/vmstat.c b/mm/vmstat.c
> index 4e2dc067a654..fa235c65c756 100644
> --- a/mm/vmstat.c
> +++ b/mm/vmstat.c
> @@ -1908,6 +1908,7 @@ static const struct seq_operations vmstat_op = {
>  #ifdef CONFIG_SMP
>  static DEFINE_PER_CPU(struct delayed_work, vmstat_work);
>  int sysctl_stat_interval __read_mostly = HZ;
> +static int vmstat_late_init_done;
>  
>  #ifdef CONFIG_PROC_FS
>  static void refresh_vm_stats(struct work_struct *work)
> @@ -2110,7 +2111,8 @@ static void __init init_cpu_node_state(void)
>  
>  static int vmstat_cpu_online(unsigned int cpu)
>  {
> -	refresh_zone_stat_thresholds();
> +	if (vmstat_late_init_done)
> +		refresh_zone_stat_thresholds();
>  
>  	if (!node_state(cpu_to_node(cpu), N_CPU)) {
>  		node_set_state(cpu_to_node(cpu), N_CPU);
> @@ -2142,6 +2144,14 @@ static int vmstat_cpu_dead(unsigned int cpu)
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
> +late_initcall(vmstat_late_init);>  #endif
>  
>  struct workqueue_struct *mm_percpu_wq;

late_initcall() triggered vmstat_late_init() guaranteed to be called
before the last call into vmstat_cpu_online() during a normal boot ?
Otherwise refresh_zone_stat_thresholds() will never be called unless
there is a CPU online event later.

