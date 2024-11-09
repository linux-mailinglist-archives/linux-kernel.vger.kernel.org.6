Return-Path: <linux-kernel+bounces-402591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87D609C296F
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 03:05:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30FF1282801
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 02:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 713D2282FE;
	Sat,  9 Nov 2024 02:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RPDcb0P+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D235C1C27
	for <linux-kernel@vger.kernel.org>; Sat,  9 Nov 2024 02:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731117915; cv=none; b=oXHxqXWh+hZXC1FDCL0i2xot1e94cXRP0BhXM1vp6ooWtXRL1shF3t0n483kk9ZzYRtKZ3gqY5SmcuSsLfw0lvuDDaQgLX9qt0IIyXhQwXYUcxyTPu+D/a0EDZGzwPOhEuf8S+4+BBfK9dhp94tpfDAqzftsRqsHyLBqNhhM1xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731117915; c=relaxed/simple;
	bh=oHDnLhe79l2GGcoFm13Qr6MszLy/IqdJy1F39Si0m0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WymJaPzfoDfdeoLXYGX+bjDspbtREQVZNNPcmKuXBiUtEx8l0oBCmDpUiROt9XVIX0q4Og+Dx2IbSJO+maUyla48ueWsRrRZe3jmQiUjPLJbwRJtpLsCGnzYW0k6oLAt68WaSwuFhgSnpHyaXTQpj7X7etAihyUD1BKog8VHQcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RPDcb0P+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48F80C4CECF;
	Sat,  9 Nov 2024 02:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731117915;
	bh=oHDnLhe79l2GGcoFm13Qr6MszLy/IqdJy1F39Si0m0g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RPDcb0P+HICuQdMVfIz9NpkU9SdL2m+8KYvyqDXqf+SonFhPbjMjH9CO/KS2hKFvp
	 k2MFn7LBRcA4IGyahZ/XEg1i0CRnvzMnAkCYz3s2nnrDxu13xFImTCurbNZs39LF7Y
	 2XLuX82FyvtsY1EcmoOCYKBUgE0+VHWnE7mOC/X6OJUG74ewAePKNWVfmvOKIpbNj2
	 mtdaEJmiIP50OW9feY5Mq37OaDyHBuz7k6RFGgUavcreWUIo2n8DiiPNDPO7ff5l7r
	 hdZEAtQ56ZcIYrmuJF77vN1mkjXLDqfBKWc0K5IxG0dElHd2ZDcWZVWGMp4kklobCA
	 +WGYREON3aUaQ==
Date: Fri, 8 Nov 2024 16:05:14 -1000
From: Tejun Heo <tj@kernel.org>
To: Changwoo Min <multics69@gmail.com>
Cc: arighi@nvidia.com, void@manifault.com, changwoo@igalia.com,
	kernel-dev@igalia.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched_ext: add a missing rcu_read_lock/unlock pair at
 scx_select_cpu_dfl()
Message-ID: <Zy7DWssEuFN6Zehi@slm.duckdns.org>
References: <20241109015420.170729-1-changwoo@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241109015420.170729-1-changwoo@igalia.com>

Hello,

On Sat, Nov 09, 2024 at 10:54:20AM +0900, Changwoo Min wrote:
...
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 6ff501a18b88..830a21d666e9 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -3320,9 +3320,11 @@ static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
>  		if (static_branch_maybe(CONFIG_SCHED_MC, &scx_selcpu_topo_llc)) {
>  			struct sched_domain *sd;
>  
> +			rcu_read_lock();
>  			sd = rcu_dereference(per_cpu(sd_llc, prev_cpu));
>  			if (sd)
>  				llc_cpus = sched_domain_span(sd);
> +			rcu_read_unlock();

Shouldn't RCU critical section cover the places where llc_cpus is deref'd?

Thanks.

-- 
tejun

