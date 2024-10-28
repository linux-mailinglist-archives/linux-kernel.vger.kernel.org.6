Return-Path: <linux-kernel+bounces-384402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67CD69B29A6
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 09:04:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCC81B2149A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A72561D6DAA;
	Mon, 28 Oct 2024 07:52:37 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B59C1D61AC
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 07:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730101957; cv=none; b=MPDE3g19wwXQo2Eia4rVNNX8idnwp9QvjLbBHoZOx8I5UUMQHwHj/N9RJ+EMO2Ld8VDktaMp/f9tVlyBoVBdiud1sLdjL1ov81T8jg5bSus6eza+fF4r0IiOjGmMP6ALNP5NRK9XZFtHpAC0sfrMsDz02ktNyBH96ikGeCzL95w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730101957; c=relaxed/simple;
	bh=05z+lhnRMfX7W99XMQIVuZC8ff5F/873Aco3qvM+mz4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zff8bE86r/2mMD6YI2Igg1JThXmQYtIwd3HEnW4OsSBF9o+CgiPglo//FQd+apaMr1CJthCAJ7GvKO8m6iWEFW2Ykc87IfZ/4rA+t/aC4vyfP1qR246k1TEfX326JcyFxnNGfKAehEHIlMagBk958pvuu8TvV0tvIaAacLQVS88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B36B8C4CEC3;
	Mon, 28 Oct 2024 07:52:35 +0000 (UTC)
Date: Mon, 28 Oct 2024 03:52:32 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Nam Cao <namcao@linutronix.de>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker
 <frederic@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Andreas
 Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Miguel
 Ojeda <ojeda@kernel.org>, Kees Cook <kees@kernel.org>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 24/31] tracing/osnoise: Switch to use hrtimer_setup()
Message-ID: <20241028035232.0981c3ed@rorschach.local.home>
In-Reply-To: <491c6ad7c82f8fc446d0727757e6b4267ac64417.1729864823.git.namcao@linutronix.de>
References: <cover.1729864823.git.namcao@linutronix.de>
	<491c6ad7c82f8fc446d0727757e6b4267ac64417.1729864823.git.namcao@linutronix.de>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 28 Oct 2024 08:31:57 +0100
Nam Cao <namcao@linutronix.de> wrote:

> There is a newly introduced hrtimer_setup() which will replace
> hrtimer_init(). This new function is similar to the old one, except that it
> also sanity-checks and initializes the timer's callback function.
> 
> Switch to use this new function.
> 
> Patch was created by using Coccinelle.
> 

Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve

> Signed-off-by: Nam Cao <namcao@linutronix.de>
> ---
> Cc: Steven Rostedt <rostedt@goodmis.org>
> ---
>  kernel/trace/trace_osnoise.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
> index 1439064f65d6..e50f7a1aae6d 100644
> --- a/kernel/trace/trace_osnoise.c
> +++ b/kernel/trace/trace_osnoise.c
> @@ -1896,8 +1896,7 @@ static int timerlat_main(void *data)
>  	tlat->count = 0;
>  	tlat->tracing_thread = false;
>  
> -	hrtimer_init(&tlat->timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_PINNED_HARD);
> -	tlat->timer.function = timerlat_irq;
> +	hrtimer_setup(&tlat->timer, timerlat_irq, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_PINNED_HARD);
>  	tlat->kthread = current;
>  	osn_var->pid = current->pid;
>  	/*
> @@ -2461,8 +2460,7 @@ static int timerlat_fd_open(struct inode *inode, struct file *file)
>  	tlat = this_cpu_tmr_var();
>  	tlat->count = 0;
>  
> -	hrtimer_init(&tlat->timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_PINNED_HARD);
> -	tlat->timer.function = timerlat_irq;
> +	hrtimer_setup(&tlat->timer, timerlat_irq, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_PINNED_HARD);
>  
>  	migrate_enable();
>  	return 0;


