Return-Path: <linux-kernel+bounces-342468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 439CC988F61
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 15:22:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F13C2823B9
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 13:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 460681885A5;
	Sat, 28 Sep 2024 13:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WylIPDAM"
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7844918756A
	for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 13:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727529723; cv=none; b=pxYBp/1MMJZawHRj8qmQ++slVYerEjedoJTxFTXSl5g27vAbZBnM26jrZHZeSTT6yZmhDnag3VWZKOmwILfrJCxQVf0lChny0Y9HCkjRqZ+BM+JEpdtnRD3YC0jJ5VgjYEs9luysk0x27NMv1xATpG9AluWgAo2Dzf9ccsi79CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727529723; c=relaxed/simple;
	bh=HabCXyTUwhvzyVp+xwl0P9X/QhhFgT791v6Np7Twpwo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VaumfVyFSkNGcyi5lAGZtTfnmAqk25+Im8UC2FRnv/9S3C5SsDAfG+8bR8hS3EVTFmI3LOaTjSyYJarF8pJYy4YfVaD4hzu2Fw2vd6GNtKSTu6RAAWxKCaWfahDa9Zjp9w+6H0YOtk7VqP3Dv7t7mirex3MIXAsw3xXZc+kire8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WylIPDAM; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 28 Sep 2024 15:21:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1727529717;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=G2mkZZAJJpioFFA5wSjGEtZMdtpGiBUzUAF4n4uCg5w=;
	b=WylIPDAMx5fgMlIJ+MX0WEGCallGzhIX3FAxcx1xPa3EVzH9guOzAryZE+vAE0gfOnSe64
	5lhTlMl3N3P/6A2CFa5h7LOoj1SA7gah5zEYT0LrOqiLUaWfSiE9y/buzfWGmc6C1/DsTr
	Owl6JAjl1lYTD6nb35+SpQX6PVCuTTk=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Andrea Righi <andrea.righi@linux.dev>
To: Tejun Heo <tj@kernel.org>
Cc: void@manifault.com, peterz@infradead.org, mingo@redhat.com,
	kernel-team@meta.com, linux-kernel@vger.kernel.org,
	sched-ext@meta.com, Daniel Hodges <hodges.daniel.scott@gmail.com>,
	Changwoo Min <multics69@gmail.com>,
	Dan Schatzberg <schatzberg.dan@gmail.com>
Subject: Re: [PATCH 3/3] sched_ext, scx_qmap: Add and use SCX_ENQ_CPU_SELECTED
Message-ID: <ZvgC6rhPCxXYTrh6@gpd3>
References: <20240927234838.152112-1-tj@kernel.org>
 <20240927234838.152112-4-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240927234838.152112-4-tj@kernel.org>
X-Migadu-Flow: FLOW_OUT

On Fri, Sep 27, 2024 at 01:46:13PM -1000, Tejun Heo wrote:
> scx_qmap and other schedulers in the SCX repo are using SCX_ENQ_WAKEUP to
> tell whether ops.select_cpu() was called. This is incorrect as
> ops.select_cpu() can be skipped in the wakeup path and leads to e.g.
> incorrectly skipping direct dispatch for tasks that are bound to a single
> CPU.
> 
> sched core has been udpated to specify ENQUEUE_RQ_SELECTED if
> ->select_task_rq() was called. Map it to SCX_ENQ_CPU_SELECTED and update
> scx_qmap to test it instead of SCX_ENQ_WAKEUP.

Even if it's quite convenient to have the SCX_ENQ_CPU_SELECTED flag
provided by kernel, I was wondering if we could just delegate this whole
logic to BPF and avoid introducing this extra flag in the kernel.

In theory we could track when ops.select_cpu() is called by setting a
flag in the BPF task context (BPF_MAP_TYPE_TASK_STORAGE). Specifically,
the flag could be set in ops.select_cpu() and cleared in ops.stopping().
Then, when ops.enqueue() is called, we can check the flag to determine
whether ops.select_cpu() was skipped or not.

Since most of the scx schedulers already implement their own task
context, this shouldn't add too much complexity/overhead to the BPF
code, it'd be fully backward-compatible and it doesn't depend on the
particular kernel logic that calls ->select_task_rq(). WDYT?

Thanks,
-Andrea

> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Cc: David Vernet <void@manifault.com>
> Cc: Daniel Hodges <hodges.daniel.scott@gmail.com>
> Cc: Changwoo Min <multics69@gmail.com>
> Cc: Andrea Righi <andrea.righi@linux.dev>
> Cc: Dan Schatzberg <schatzberg.dan@gmail.com>
> ---
>  kernel/sched/ext.c             | 1 +
>  tools/sched_ext/scx_qmap.bpf.c | 4 ++--
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index c09e3dc38c34..9f00c8b629f1 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -691,6 +691,7 @@ enum scx_enq_flags {
>  	/* expose select ENQUEUE_* flags as enums */
>  	SCX_ENQ_WAKEUP		= ENQUEUE_WAKEUP,
>  	SCX_ENQ_HEAD		= ENQUEUE_HEAD,
> +	SCX_ENQ_CPU_SELECTED	= ENQUEUE_RQ_SELECTED,
>  
>  	/* high 32bits are SCX specific */
>  
> diff --git a/tools/sched_ext/scx_qmap.bpf.c b/tools/sched_ext/scx_qmap.bpf.c
> index 83c8f54c1e31..588b7dce44fa 100644
> --- a/tools/sched_ext/scx_qmap.bpf.c
> +++ b/tools/sched_ext/scx_qmap.bpf.c
> @@ -230,8 +230,8 @@ void BPF_STRUCT_OPS(qmap_enqueue, struct task_struct *p, u64 enq_flags)
>  		return;
>  	}
>  
> -	/* if !WAKEUP, select_cpu() wasn't called, try direct dispatch */
> -	if (!(enq_flags & SCX_ENQ_WAKEUP) &&
> +	/* if select_cpu() wasn't called, try direct dispatch */
> +	if (!(enq_flags & SCX_ENQ_CPU_SELECTED) &&
>  	    (cpu = pick_direct_dispatch_cpu(p, scx_bpf_task_cpu(p))) >= 0) {
>  		__sync_fetch_and_add(&nr_ddsp_from_enq, 1);
>  		scx_bpf_dispatch(p, SCX_DSQ_LOCAL_ON | cpu, slice_ns, enq_flags);
> -- 
> 2.46.2
> 

