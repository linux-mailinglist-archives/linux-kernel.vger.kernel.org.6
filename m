Return-Path: <linux-kernel+bounces-542188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1046A4C6EC
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 17:25:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1AA237AAAEC
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 16:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 151D8241C8C;
	Mon,  3 Mar 2025 16:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sbbXvt1g"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D122417F4
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 16:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741018277; cv=none; b=QZdGZ0fcf1ej3W657qOJlluURbU+b/BRdkkxU0PXMU3cr4ScLtrDjHcd+TjWje2i+O23kbKsLVSco3tfoxhGPZuAy36/VzGc45PFMT8CYF0IcFZJxFyt20JKRw2c/PFjBADXW0iIepWaZfxkCX2bbCqwKLn9zmg1q9gUp4A5vGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741018277; c=relaxed/simple;
	bh=lxp4HbbczOYr+XowDROD0D6bHQotztQNb4oAdPJ4Kn4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H8mhJXADN+8ncELrNKNiyhonp/9B/X7unsoCldmVc3XR5iR0sfRqgLhP50D5Xfw+QcPmkOit5Oeg+Toq5sycKwZN0JMVi9aDhLSN6UE+m/4PgZnWqBuxCJ4KQ/mbTjOIesUNJYHymAeZP6rL+cIjhu7dIydTSPB2lpKX6q8tMpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sbbXvt1g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2B60C4CEE6;
	Mon,  3 Mar 2025 16:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741018276;
	bh=lxp4HbbczOYr+XowDROD0D6bHQotztQNb4oAdPJ4Kn4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sbbXvt1gAr2tMNX3yZUMjoDNQ5P5pZcqvs92K+mvUFTakyUS1QUi/wmhhzBapxKjB
	 oFHeuzo1E5XSpM44jLSHKA3KnhHSNptdrTVdPWFNCCr/4xpCcUJd3YAZx2LOGtYb+j
	 Uw+MOFzLp93VLkm19cw4kmHcd7K6Aa4SsWC3Tq1Z7BeimPpEvQThvkwkNd/uw3po6/
	 0EK0kKOI0QsuiDYl3Z0NxJD5f80UsfQ1egvHJT4p0GS0zMrSmAwlLRAZbOPBsLimoE
	 7v/uYwhRH6tyBmbYT7gnRrVKIp5XfzYireQnu3N498nXBQ+Ooe1AA96mB600fd4EXS
	 kyi+1H1mQNo3A==
Date: Mon, 3 Mar 2025 06:11:15 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched_ext: Validate prev_cpu in scx_bpf_select_cpu_dfl()
Message-ID: <Z8XUozpR547RFxkx@slm.duckdns.org>
References: <20250302220903.54001-1-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250302220903.54001-1-arighi@nvidia.com>

Hello,

On Sun, Mar 02, 2025 at 11:09:03PM +0100, Andrea Righi wrote:
> If a BPF scheduler provides an invalid CPU (outside the nr_cpu_ids
> range) as prev_cpu to scx_bpf_select_cpu_dfl() it can cause a kernel
> crash.
> 
> To prevent this, validate prev_cpu in scx_bpf_select_cpu_dfl() and
> trigger an scx error if an invalid CPU is specified.
> 
> Fixes: f0e1a0643a59b ("sched_ext: Implement BPF extensible scheduler class")
> Cc: stable@vger.kernel.org # v6.12+
> Signed-off-by: Andrea Righi <arighi@nvidia.com>
> ---
>  kernel/sched/ext.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 0f1da199cfc7c..88b2ea58ff942 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -6422,6 +6422,11 @@ static bool check_builtin_idle_enabled(void)
>  __bpf_kfunc s32 scx_bpf_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
>  				       u64 wake_flags, bool *is_idle)
>  {
> +	if (!ops_cpu_valid(prev_cpu, NULL)) {
> +		prev_cpu = cpumask_any(p->cpus_ptr);
> +		goto prev_cpu;

I'd just return the invalid prev_cpu. The scheduler is getting aborted
anyway.

Thanks.

-- 
tejun

