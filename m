Return-Path: <linux-kernel+bounces-572982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03551A6D115
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 21:40:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 432C73A5881
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 20:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E4A01A0BED;
	Sun, 23 Mar 2025 20:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k2NYWdZO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7D1136E
	for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 20:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742762445; cv=none; b=Zhx75BIK83+nvIE8zBfMvjuCIaP+dVm/1eJhn1lVUzrouiQ7AYtqSKE9Xc0Xh3EtZW1RQfbpIZBhzzN7jKJCcptM1zDHxy/9yHhQDMOqCejPT/Gcy1AWiVG0s6WetFGHWVS1RyxosmdWXd3ECUAb1nuaWHQMKkNI6zGui3mBwI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742762445; c=relaxed/simple;
	bh=l95R0/vSIsnjtwpPdXh9vS/vM9kelyNNuucFGwU3nFg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W+r3+ir6JFW8img4ZmNBOCAzYc3hpS4Vl8LF8D9C/LEcPkuJzPW8rC+VHUjT1QC9TXwoJrcIqhwV71tkXDFBVf7SRIXyfbvKbJtszwXeUQqJMDF02sjHFjzZaq/FvpjDjHOE2pnEZZtisDAafvh/oc7IuBKbLViS/szf2plLQKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k2NYWdZO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ADFAC4CEE2;
	Sun, 23 Mar 2025 20:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742762443;
	bh=l95R0/vSIsnjtwpPdXh9vS/vM9kelyNNuucFGwU3nFg=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=k2NYWdZOGauAkRuiZj6gQ2ps2b6bX6ct7L03Ja5KUIBTzR0i3uZwgAypcV9iMhcTx
	 Yj46lYkC9y8LDCgtm1CHOTsFxE1rs9McrvvGMv2BjpI1AGvmZQ67/UdTAcPaD6aLYP
	 XJB8B5/Ia7lYNgQcOBRrvKQgt+64tlZv/dYGlJ/lnxIgAvKWR1Z1b6yHZAnDTO+paX
	 D+/f2BxZnTqDzXH+1ks+WSxbl4xMZgieiqE2eM+9i3NBKisd+pPOW/eXM359PtltGr
	 VwztUzAwZTEuKrBxoYKnqeJQT+t476+W5iybV6d2D5fQz3H/5OLwWMoQ5PLK4t2C92
	 5ooJnhZiSvdjg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 142AFCE079A; Sun, 23 Mar 2025 13:40:43 -0700 (PDT)
Date: Sun, 23 Mar 2025 13:40:43 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: linux-kernel@vger.kernel.org, jstultz@google.com, tglx@linutronix.de,
	sboyd@kernel.org, feng.tang@intel.com, kernel@gpiccoli.net,
	kernel-dev@igalia.com,
	Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Subject: Re: [PATCH] clocksource: Fix the CPUs' choice in the watchdog percpu
 verification
Message-ID: <5d68cd3a-8be6-4979-815b-5b09a9a46165@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250323173857.372390-1-gpiccoli@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250323173857.372390-1-gpiccoli@igalia.com>

On Sun, Mar 23, 2025 at 02:36:24PM -0300, Guilherme G. Piccoli wrote:
> Right now, if the clocksource watchdog detects a clocksource skew, it
> might perform a percpu checking, for example in the TSC case on x86.
> In other words: supposing TSC is detected as unstable by the
> clocksource watchdog running at CPU1, as part of marking TSC as
> unstable the kernel will also run a check of TSC readings in some CPUs
> other than CPU1 to be sure it is synced between them all.
> 
> But that check might happen only in some CPUs, not all of them; this
> choice is based on the parameter "verify_n_cpus" and in some random
> cpumask calculation. So, the watchdog runs such percpu check in
> up to "verify_n_cpus" random CPUs among all online CPUs, with the risk
> of repeating CPUs (that aren't double checked) in the cpumask random
> calculation.
> 
> But if "verify_n_cpus" > num_online_cpus(), we could skip the random
> calculation and just go ahead and check the clocksource sync between
> all online CPUs, without the risk of skipping some CPUs due to
> duplicity in the random cpumask calculation. That approach is exactly
> what is proposed here.
> 
> Tests in a 4 CPU laptop with TSC skew detected led to some cases of
> the percpu verification skipping some CPU even with verify_n_cpus=8,
> due to the duplicity on random cpumask generation. With this patch,
> the issue is fixed.
> 
> Suggested-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

> ---
> 
> 
> Hey folks, thanks in advance for reviews / suggestions!
> 
> Special thanks to Cascardo for the suggestion of checking
> verify_n_cpus against the number of online CPUs - definitely
> improved the idea!
> 
> I think this could be backported to stable if makes sense;
> I can do it, please let me know your opinion.
> Cheers,
> 
> Guilherme
> 
> 
>  kernel/time/clocksource.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
> index 2a7802ec480c..a32732dab27e 100644
> --- a/kernel/time/clocksource.c
> +++ b/kernel/time/clocksource.c
> @@ -310,7 +310,7 @@ static void clocksource_verify_choose_cpus(void)
>  {
>  	int cpu, i, n = verify_n_cpus;
>  
> -	if (n < 0) {
> +	if ((n < 0) || (n >= num_online_cpus())) {
>  		/* Check all of the CPUs. */
>  		cpumask_copy(&cpus_chosen, cpu_online_mask);
>  		cpumask_clear_cpu(smp_processor_id(), &cpus_chosen);
> -- 
> 2.48.1
> 

