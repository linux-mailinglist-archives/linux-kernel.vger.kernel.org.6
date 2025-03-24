Return-Path: <linux-kernel+bounces-573654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 33AE4A6DA40
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 13:48:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 927457A41D3
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 12:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA44D25E445;
	Mon, 24 Mar 2025 12:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="LS/MXNuw"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0EEB199FA8
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 12:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742820517; cv=none; b=tvqFLoy3We/gFqH+4HhSDZePh3WqKo7IPzReafk+354bBou3XUoo+e8X56vIzVCGNaFbg6g40WN0maRA6t+BLJmdkXxOFdwCguSsULr80TfGSXYnFkoeTIoAJ3amWxRjUlD0fINOMUpoyk7FmW3WURhloC8DjkT51LS2EPvxLM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742820517; c=relaxed/simple;
	bh=ArE4ydroaGImbLU6zoYStMozDoA0kRvUW/UhXRHzMP8=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=gtxHOmVaF3vngC+7jBYV7/MDPeSfqnhQIYw340nTUQbFuzc4JrsCFGYkV20Cgav/tI5u9KCFmVdHi87AOVmKI7+i3oI/HRZ/rlg6aKJZtrQu3aNPhWCtMHUWk22kO7H4aROp83Op/dMgZcOjlwi2AlxSfUB5vodU00g3kSb8FzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=LS/MXNuw; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:Message-ID:References:
	In-Reply-To:Subject:Cc:To:From:Date:MIME-Version:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=pHTmMEnxZUEDyBf0DAQd7RJHOP3VZiu1Lw6Ul3RUnz8=; b=LS/MXNuwATSLm0xaiTMAJCd8a5
	vr1EN5jMT44XIsvsCD0DAo4X4wXvoLzYZj81xhIVffyV4yfDdyCB9uzkjZOos0Icqjk9i97lUS+4v
	P7r1lTsmrewHN4qfRAlv4+qdlhDVijQReqc+FxrrS0I5oKTZkDdvBGgdzB42ZlLLaQFsmYR9CQwwk
	CGQ/qok6C8f62QrRmjFjhzBTxiYNi7MUHdA48eUyp1e01/buYBN05uiO7nRSddnFyrd0zq6BnA+km
	rUbcn+XNBtbVpeJCrOZ8GE9euZrSwOVa85trdDmhuq6f43crusDZgUmamdf1fdYW/M8UfLCSEbC+A
	7Gy+Htiw==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
	by fanzine2.igalia.com with esmtps 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1twhE9-005i0c-UI; Mon, 24 Mar 2025 13:48:25 +0100
Received: from webmail.service.igalia.com ([192.168.21.45])
	by mail.igalia.com with esmtp (Exim)
	id 1twhE8-007ydN-3T; Mon, 24 Mar 2025 13:48:25 +0100
Received: from localhost ([127.0.0.1] helo=webmail.igalia.com)
	by webmail with esmtp (Exim 4.96)
	(envelope-from <changwoo@igalia.com>)
	id 1twhDw-00ArZU-1P;
	Mon, 24 Mar 2025 13:48:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 24 Mar 2025 21:48:23 +0900
From: Changwoo Min <changwoo@igalia.com>
To: Andrea Righi <arighi@nvidia.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, Joel
 Fernandes <joelagnelf@nvidia.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-6.15] sched_ext: initialize built-in idle
 state before ops.init()
In-Reply-To: <20250324085753.27112-1-arighi@nvidia.com>
References: <20250324085753.27112-1-arighi@nvidia.com>
Message-ID: <1fcbaeee8b49b1c5f81cd01ba59a00a2@igalia.com>
X-Sender: changwoo@igalia.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Report: NO, Score=-2.2, Tests=ALL_TRUSTED=-3,AWL=0.000,BAYES_50=0.8
X-Spam-Score: -21
X-Spam-Bar: --

Hi Andrea,

This is a nice catch! Looks good to me.

Regards,
Changwoo Min

On 2025-03-24 17:57, Andrea Righi wrote:
> A BPF scheduler may want to use the built-in idle cpumasks in ops.init()
> before the scheduler is fully initialized, either directly or through a
> BPF timer for example.
> 
> However, this would result in an error, since the idle state has not
> been properly initialized yet.
> 
> This can be easily verified by modifying scx_simple to call
> scx_bpf_get_idle_cpumask() in ops.init():
> 
> $ sudo scx_simple
> 
> DEBUG DUMP
> ===========================================================================
> 
> scx_simple[121] triggered exit kind 1024:
>   runtime error (built-in idle tracking is disabled)
> ...
> 
> Fix this by properly initializing the idle state before ops.init() is
> called. With this change applied:
> 
> $ sudo scx_simple
> local=2 global=0
> local=19 global=11
> local=23 global=11
> ...
> 
> Fixes: d73249f88743d ("sched_ext: idle: Make idle static keys private")
> Signed-off-by: Andrea Righi <arighi@nvidia.com>
> ---
>  kernel/sched/ext.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 06561d6717c9a..1ba02755ae8ad 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -5361,6 +5361,8 @@ static int scx_ops_enable(struct sched_ext_ops *ops, struct bpf_link *link)
>  	 */
>  	cpus_read_lock();
>  
> +	scx_idle_enable(ops);
> +
>  	if (scx_ops.init) {
>  		ret = SCX_CALL_OP_RET(SCX_KF_UNLOCKED, init);
>  		if (ret) {
> @@ -5427,8 +5429,6 @@ static int scx_ops_enable(struct sched_ext_ops *ops, struct bpf_link *link)
>  	if (scx_ops.cpu_acquire || scx_ops.cpu_release)
>  		static_branch_enable(&scx_ops_cpu_preempt);
>  
> -	scx_idle_enable(ops);
> -
>  	/*
>  	 * Lock out forks, cgroup on/offlining and moves before opening the
>  	 * floodgate so that they don't wander into the operations prematurely.

