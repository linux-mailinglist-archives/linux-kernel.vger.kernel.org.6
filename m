Return-Path: <linux-kernel+bounces-397273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2B759BD9BF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 00:32:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA36D1C210A2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 23:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33AC8216A1A;
	Tue,  5 Nov 2024 23:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n8CLohlP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D701D1F79
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 23:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730849526; cv=none; b=TcnrtxRUrr2O5/RDXcN16Aolja47rqscS3iTqE7J8LalQLN8zST4PhU/m4OE6zfEwRuGjuDsQFPoskeNOzpciHSpvX+hFbVbekFa+GimiieKTBWtNBRYz3V8cu/t1nsvsyE7TTk6Q9YV/dJ+v5/oPAmXl9rKEjBOnbe65CnHq44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730849526; c=relaxed/simple;
	bh=njo4WD5fdCPN3s0NNta4F0P4LWb8OYuTSabew40Yb4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AHJTT0FfdS421GoE4PNrNU2+yZ2bFFIeuikf8xMyXFCefwxxxKQH8yvwwL7iprJiwWZRcsU79CToaecqU42HAHW7y2aQAZTyFm191ul1I3fPrX6wUvH0Gc8g+HzVxJmyRipsRz3qb2HG1BU+foZyC4y3FB7rNimprK5aunSnRQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n8CLohlP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 075E1C4CECF;
	Tue,  5 Nov 2024 23:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730849526;
	bh=njo4WD5fdCPN3s0NNta4F0P4LWb8OYuTSabew40Yb4s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n8CLohlPGHa3goIygsu0uCCn5cM129iytv4fkMXgWgG4EAKVhzFBv04JoR3svJR/7
	 iEI+j//3UUkHdKeiMSk3lly+euooq9ebBktjQS0jwkq/6SilLzTgcQsLq5LRJYiA+h
	 nzJc7wLmA6hbRRYdk8miJ0hS+CrsKwgoN6GhlGgoQrHqV1LaMUOIOrPiYy0ytkp2BU
	 6WqVNwUfuRYLV/udyBLxdzwGtDhcAixh/AQdXHJNJha6ADj49jAd4QafC5O1nBjKK0
	 s9IrmPe76tzv0ERfw/GNSGg1HVpt1Q1ap1CKGJ0FPlkC2ePF7cIiVXfwLqNCsEpDCi
	 eBLgFQFUUp9XQ==
Date: Tue, 5 Nov 2024 13:32:05 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-6.13] sched_ext: Do not enable LLC/NUMA
 optimizations when domains overlap
Message-ID: <Zyqq9fnsOg56aO7S@slm.duckdns.org>
References: <20241031073401.13034-1-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241031073401.13034-1-arighi@nvidia.com>

Hello, Andrea.

Sorry about the delay.

On Thu, Oct 31, 2024 at 08:34:01AM +0100, Andrea Righi wrote:
> @@ -3154,16 +3154,29 @@ static void update_selcpu_topology(void)
>  	rcu_read_lock();
>  	sd = rcu_dereference(per_cpu(sd_llc, cpu));
>  	if (sd) {
> -		cpus = sched_domain_span(sd);
> -		if (cpumask_weight(cpus) < num_possible_cpus())
> +		llc_cpus = sched_domain_span(sd);
> +		if (cpumask_weight(llc_cpus) < num_possible_cpus())

Not from this patch but should the weight be compared against
num_online_cpus()? Sched domains don't include offline CPUs, right?

...
> +	/*
> +	 * If the NUMA domain perfectly overlaps with the LLC domain, enable
> +	 * LLC optimization only, as checking for an idle CPU in the same
> +	 * domain twice is redundant.
> +	 */
> +	if (enable_numa && enable_llc && cpumask_equal(numa_cpus, llc_cpus))
> +		enable_numa = false;
> +	/*
> +	 * If all the online CPUs are in the same LLC domain, there is no
> +	 * reason to enable LLC optimization.
> +	 */
> +	if (enable_llc && cpumask_equal(llc_cpus, cpu_online_mask))
> +		enable_llc = false;

The second test looks like it should always be correct. I'm not sure the
first one is. It probably is good enough but would at least be worthwhile to
explain why that is?

Thanks.

-- 
tejun

