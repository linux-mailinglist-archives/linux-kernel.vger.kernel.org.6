Return-Path: <linux-kernel+bounces-301679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C59C95F3F1
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 16:34:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5FC71F21437
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 14:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C74D18BC01;
	Mon, 26 Aug 2024 14:34:44 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D499F17C9B9;
	Mon, 26 Aug 2024 14:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724682883; cv=none; b=p8HkEGCurL2tAoFRD28/Ya9lHsIwf7LKybWcQHc9RotlRQX7u74OrKV2taFII86TtrxKJq2Uj45CIAY+brSdhrnSHvCrIUqD0TfhClDanDS63hFktRMjfnxjsSrbcbf4Hzi4X2lcN/21ZeIgYkhMSOFMM0c1B96fqkXxnpcuLFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724682883; c=relaxed/simple;
	bh=U5LDB0DqKnVqpxM8vC5MqT2aN5xIplfxjFDGDBwe9YY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QhHAIdNpUu2Ald6M0D/GQ3DLTR4mn7/NjBfWgyvM52cf0TOg/uV9PgYs7Ml/IMcLHMbEcSu0B8X4KB5WewOsnq4lLlkMLkiMafA6vm+bY0VCEqma9k1QieMHMDa0pgYa8HLxGhoRBFj6D1RbJVPyZsYmyAD6kvYNUcGI+WfEHdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C16E2C4FDE5;
	Mon, 26 Aug 2024 14:34:42 +0000 (UTC)
Date: Mon, 26 Aug 2024 10:35:22 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Zheng Yejian <zhengyejian@huaweicloud.com>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: Mitigate possible softlockup in
 __tracing_open()
Message-ID: <20240826103522.390faa85@gandalf.local.home>
In-Reply-To: <20240824030343.3218618-1-zhengyejian@huaweicloud.com>
References: <20240824030343.3218618-1-zhengyejian@huaweicloud.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 24 Aug 2024 11:03:43 +0800
Zheng Yejian <zhengyejian@huaweicloud.com> wrote:

> In __tracing_open(), when max latency tracers took place on the cpu,
> the time start of its buffer would be updated, then event entries with
> timestamps being earlier than start of the buffer would be skipped
> (see tracing_iter_reset()).
> 
> Softlockup will occur if the kernel is non-preemptible and too many
> entries were skipped in the loop that reset every cpu buffer, so add
> cond_resched() to avoid it.
> 
> Signed-off-by: Zheng Yejian <zhengyejian@huaweicloud.com>
> ---
>  kernel/trace/trace.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index ebe7ce2f5f4a..88faa95b457b 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -4706,6 +4706,15 @@ __tracing_open(struct inode *inode, struct file *file, bool snapshot)
>  		for_each_tracing_cpu(cpu) {
>  			ring_buffer_read_start(iter->buffer_iter[cpu]);
>  			tracing_iter_reset(iter, cpu);
> +			/*
> +			 * When max latency tracers took place on the cpu, the time start
> +			 * of its buffer would be updated, then event entries with timestamps
> +			 * being earlier than start of the buffer would be skipped
> +			 * (see tracing_iter_reset()). Softlockup will occur if the kernel
> +			 * is non-preemptible and too many entries were skipped in the loop,
> +			 * so add cond_resched() to mitigate it.
> +			 */
> +			cond_resched();

This is the wrong place to put this. If the problem is with
tracing_iter_reset(), then add it there.

	while (ring_buffer_iter_peek(buf_iter, &ts)) {
		if (ts >= iter->array_buffer->time_start)
			break;
		entries++;
		ring_buffer_iter_advance(buf_iter);
		/* This could be a big loop */
		cond_resched();
	}

-- Steve



>  		}
>  	} else {
>  		cpu = iter->cpu_file;


