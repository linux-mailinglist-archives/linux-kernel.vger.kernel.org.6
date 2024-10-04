Return-Path: <linux-kernel+bounces-350302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35414990322
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 14:38:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64FB21C2175A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 12:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F4631D45FF;
	Fri,  4 Oct 2024 12:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nSWJlxH/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0EA1D45E2
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 12:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728045463; cv=none; b=XFbWgJxMRqlEIINrJ5sh57kuPyg5gflimpEX4zudNQJkWm+l4t7wGShnO2/inCu2gAZ31cJx/aLvSXD5obcZ1XyR8buAh8qPVVBF/VQ81XxTQ4STAis9+nnqqLYUFLj5kSKv0dkZaAZ9aP7dz6/LNxUfdo9KydBxdW3CbGfRjWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728045463; c=relaxed/simple;
	bh=/eCfyRvQjlc+/+MzJM+Lozt+n38vDldK/kYvieVCF8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=frOZ7kbhmycJMrm8qLh0jMRqo+49w9KQqNwhxu0sWcvkFs0Fq2B5HoLRJN7fm8QTwh3xnc2cXhvxVYmzsI5ikE1H5GkuU4S39CgKUQlacGTef5OY5/iUbki4keiaOptvpMCrTSBF+pxcxvFJJexTj+efAq+3cFlXzqo12tPR0jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nSWJlxH/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EE7AC4CEC7;
	Fri,  4 Oct 2024 12:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728045462;
	bh=/eCfyRvQjlc+/+MzJM+Lozt+n38vDldK/kYvieVCF8c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nSWJlxH/Ur3gatsrgfINvQPI7YdkdkvoHYhMwXN0U3A3JA1zDzLUhCm6i2tx8rDBf
	 Vq+0RI19U+AwDzYZxlorZX0WJ/GOQN+oPrW6V4GproTRGHMdkNCtSVLqEe/Quc0Ll5
	 udx6b/zpFlD7fB5AtxSt3noydFbt9adKhY/bL8ift9AbjyLu1DpRmtAwo61t2uTdi/
	 nY85onSLKUB10V5r3hPF0r4A32rWHDsLHPVYxpqWDsWDhVR9G1ecRGhmaxajKs6lO2
	 b2WuO/Mlse4a9xelq6xktYEeILn1hUpncCvDyhc4OUZDLQcOs88ZRTQ5CymOkE2vxZ
	 +BBsmk8DWdaFA==
Date: Fri, 4 Oct 2024 14:37:39 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Leonardo Bras <leobras@redhat.com>
Cc: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
	linux-kernel@vger.kernel.org, Junyao Zhao <junzhao@redhat.com>
Subject: Re: [PATCH v2 1/1] wq: Avoid using isolated cpus' timers on
 queue_delayed_work
Message-ID: <Zv_hk59xfNvzlw3B@localhost.localdomain>
References: <20240130010046.2730139-2-leobras@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240130010046.2730139-2-leobras@redhat.com>

Hi,

Le Mon, Jan 29, 2024 at 10:00:46PM -0300, Leonardo Bras a écrit :
> When __queue_delayed_work() is called, it chooses a cpu for handling the
> timer interrupt. As of today, it will pick either the cpu passed as
> parameter or the last cpu used for this.
> 
> This is not good if a system does use CPU isolation, because it can take
> away some valuable cpu time to:
> 1 - deal with the timer interrupt,
> 2 - schedule-out the desired task,
> 3 - queue work on a random workqueue, and
> 4 - schedule the desired task back to the cpu.
> 
> So to fix this, during __queue_delayed_work(), if cpu isolation is in
> place, pick a random non-isolated cpu to handle the timer interrupt.
> 
> As an optimization, if the current cpu is not isolated, use it instead
> of looking for another candidate.
> 
> Signed-off-by: Leonardo Bras <leobras@redhat.com>
> ---
> Changes since v1:
> - Make sure the CPU is isolated for any value of "cpu"
> 
> Changes since RFC:
> - Do not use the same cpu from the timer for queueing the work.
> - If the current cpu is not isolated, use it's timer instead of
>   looking for another candidate.
> 
>  kernel/workqueue.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> index 76e60faed8923..8dd7c01b326a4 100644
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
> @@ -1958,10 +1958,18 @@ static void __queue_delayed_work(int cpu, struct workqueue_struct *wq,
>  	dwork->cpu = cpu;
>  	timer->expires = jiffies + delay;
>  
> -	if (unlikely(cpu != WORK_CPU_UNBOUND))
> +	if (housekeeping_enabled(HK_TYPE_TIMER)) {
> +		/* If the current cpu is a housekeeping cpu, use it. */
> +		cpu = smp_processor_id();
> +		if (!housekeeping_test_cpu(cpu, HK_TYPE_TIMER))
> +			cpu = housekeeping_any_cpu(HK_TYPE_TIMER);

add_timer() already picks up a housekeeping CPU. So why is it needed?

Thanks.

>  		add_timer_on(timer, cpu);
> -	else
> -		add_timer(timer);
> +	} else {
> +		if (likely(cpu == WORK_CPU_UNBOUND))
> +			add_timer(timer);
> +		else
> +			add_timer_on(timer, cpu);
> +	}

>  }
>  
>  /**
> -- 
> 2.43.0
> 
> 

