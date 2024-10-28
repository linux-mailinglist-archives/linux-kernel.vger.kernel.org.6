Return-Path: <linux-kernel+bounces-385575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B1449B38D3
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 19:12:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CE2C1C214F0
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 18:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EB4B1DF972;
	Mon, 28 Oct 2024 18:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SKt+qkt7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD1F1DF75E
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 18:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730139116; cv=none; b=b2Q6sHiKkHYfbrtDXv9QdFdf5pmzZOwadn1VYwZ7hk4FM8ZO7z09OVCSP+YWFrb+N5a7eYdN4ML2G7g2/5TtoZC1RiSJ+5G5eut/ylFn7OZE4pZ1f7dxBtvB9OFHM/1Zd/pq1/0wVwqQv7OSoh97xLqaFa6G55sFzzgbQJQjSLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730139116; c=relaxed/simple;
	bh=l3yPF/VzQY+B6DWFJh6rUz7tigzR6YEJO++nwTRYdgI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SpzJnjY90DGCqI+UI6stCsDfZzjdIEb8uoA3G7qcNfi+7gPY1HfWCeqggrU4u8icQKlqf+wvZCby0O63X/AWi2iTgSG1r3KbfBciiz/HogiI0NO2xwkTgxJJJ7Lr59hRbd3nRc1fTEXuztTZOGcTYkBfWron6XH0+26tFR1255g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SKt+qkt7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A0E8C4CEC3;
	Mon, 28 Oct 2024 18:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730139116;
	bh=l3yPF/VzQY+B6DWFJh6rUz7tigzR6YEJO++nwTRYdgI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SKt+qkt7WTwvUu+aJeBSQ3QYqcz4YYrOnJzV2q9UkjFv9BrIPRrvkdcoV8wTEFAHr
	 eMmoMMUeU0rkhjYR2anzmfzxDb5sPJwYj4Xd0aAKSI4juXYas7qCNIr1nBbYwIXTZ8
	 MBnvr/uDgqoKm3ZT/cyfTPAip0Mctd16SGjaHAL/dlwnH06lwIh855L/znXyUCz091
	 cT+JjqpouyUJXRCWPu6AEdp6GJRwt4M6+yRarNZVzsjvProYAfsMTTmEeZeIxjyxtn
	 vxQQLdMCi4UabIcsP2bRizsXfhT6MS3u5NbIeFOuyhRCh7T1eh+0HnB+hLFBB75v2B
	 8sL51OPfrrO8Q==
Date: Mon, 28 Oct 2024 08:11:55 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] sched_ext: Introduce NUMA awareness to the default
 idle selection policy
Message-ID: <Zx_T6-9Ash0YEH0Z@slm.duckdns.org>
References: <20241028113338.85525-1-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241028113338.85525-1-arighi@nvidia.com>

Hello,

On Mon, Oct 28, 2024 at 12:33:38PM +0100, Andrea Righi wrote:
...
> +static void update_selcpu_topology(void)
>  {
> +	bool enable_llc = false, enable_numa = false;
> +	struct sched_domain *sd;
> +	const struct cpumask *cpus;
> +	s32 cpu = cpumask_first(cpu_possible_mask);

On x86, the first CPU is guaranteed to be online but there are archs that
allow the first CPU to go down in which case the topo information might not
be available. Use cpumask_first(cpu_online_mask) instead?

...
> @@ -3383,6 +3479,10 @@ static void handle_hotplug(struct rq *rq, bool online)
>  
>  	atomic_long_inc(&scx_hotplug_seq);
>  
> +	if ((SCX_HAS_OP(cpu_online) || SCX_HAS_OP(cpu_offline)) &&
> +	    static_branch_likely(&scx_builtin_idle_enabled))
> +		update_selcpu_topology();

Hmm... this feels a bit too complicated. Just gate it with scx_enabled()?

>  	if (online && SCX_HAS_OP(cpu_online))
>  		SCX_CALL_OP(SCX_KF_UNLOCKED, cpu_online, cpu);
>  	else if (!online && SCX_HAS_OP(cpu_offline))
> @@ -5202,6 +5302,10 @@ static int scx_ops_enable(struct sched_ext_ops *ops, struct bpf_link *link)
>  			static_branch_enable_cpuslocked(&scx_has_op[i]);
>  
>  	check_hotplug_seq(ops);
> +#ifdef CONFIG_SMP
> +	if (!ops->update_idle || (ops->flags & SCX_OPS_KEEP_BUILTIN_IDLE))
> +		update_selcpu_topology();
> +#endif

And always update here?

Thanks.

-- 
tejun

