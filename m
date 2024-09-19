Return-Path: <linux-kernel+bounces-333698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8561B97CC84
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 18:29:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03062B229EF
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 16:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C745D1A01AB;
	Thu, 19 Sep 2024 16:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ub1Z8R3F"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2923319DF81
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 16:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726763337; cv=none; b=e4EU6iEjaPcK7Gtu2clnVXUOCqlPFCe/IkmWbDcAxdr6ezn7UFc6DeXf7qPEW5SPJzWDw5w3N2IvC4lElRwKOSxSr3cMTloHBhMFz9LStAHJnlpJ90OchHSUDQzITwqYLhg57FJp+nZ9xb1iE/arLZxSa3oQ2F3wWn2PNucMq8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726763337; c=relaxed/simple;
	bh=rrPh5rmAtg/uC9b/6nlrkvI9rrZ3+X0WOwU/2uZmhSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d63NZfJaYNKbI1dyduDt9yx/dl2MwxccR4G2I762L+Yr6W3zI97an3UIDgGm1A7fDsuDQQFwwlsRBh+aQQ28z1V3K5VOnx9eXltoGeglP7Vp4P4U7Ydurq0Lo4uew/Qz4Of5nIgYxBkVm/BxHoadnhXSUqajt/6iyvPof0XdTuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ub1Z8R3F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AC8EC4CEC4;
	Thu, 19 Sep 2024 16:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726763336;
	bh=rrPh5rmAtg/uC9b/6nlrkvI9rrZ3+X0WOwU/2uZmhSA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ub1Z8R3FaJofwffBtjB5TZAJXkkTVmUfT5cvAdnpF0Qoq+D/AS6EFcKjLRaNz6jZ1
	 0KFWuyuxwGgZvhonBIWkEWPkQbYOI35MYG7cpIFnCeaKyzVKlJwF1LgZB2MojPtRHk
	 Hqm8R5U4/srfgICD0nQHKMKO770T5L5GIx4gQ9sWHb6WFCivDa5vMboro7V/hwi6oF
	 +HA9haJoVfcrkTq88IpWa+P5bnrzE7EmrOxVquUG1IumxEafcsKVfksMJJ5y6OE6oa
	 Lj0CJ5z4NgspuBWttJ/p63TObn6+yEONjImmlV07wak30cMNQfpMFPI1K2OR2eLhrg
	 TY+1RmCiGL/Ig==
Date: Thu, 19 Sep 2024 18:28:53 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Steven Davis <goldside000@outlook.com>
Cc: akpm@linux-foundation.org, ankur.a.arora@oracle.com,
	linux-kernel@vger.kernel.org, peterz@infradead.org,
	tglx@linutronix.de
Subject: Re: [PATCH] irq_work: Replace wait loop with rcuwait_wait_event
Message-ID: <ZuxRRZh-2NAlj96l@localhost.localdomain>
References: <SJ2P223MB10267BCF19A4A37747A52330F7632@SJ2P223MB1026.NAMP223.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SJ2P223MB10267BCF19A4A37747A52330F7632@SJ2P223MB1026.NAMP223.PROD.OUTLOOK.COM>

Le Thu, Sep 19, 2024 at 11:43:26AM -0400, Steven Davis a écrit :
> The previous implementation of irq_work_sync used a busy-wait
> loop with cpu_relax() to check the status of IRQ work. This
> approach, while functional, could lead to inefficiencies in
> CPU usage.
> 
> This commit replaces the busy-wait loop with the rcuwait_wait_event
> mechanism. This change leverages the RCU wait mechanism to handle
> waiting for IRQ work completion more efficiently, improving CPU
> responsiveness and reducing unnecessary CPU usage.
> 
> Signed-off-by: Steven Davis <goldside000@outlook.com>
> ---
>  kernel/irq_work.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/kernel/irq_work.c b/kernel/irq_work.c
> index 2f4fb336dda1..2b092a1d07a9 100644
> --- a/kernel/irq_work.c
> +++ b/kernel/irq_work.c
> @@ -295,8 +295,7 @@ void irq_work_sync(struct irq_work *work)
>  		return;
>  	}
>  
> -	while (irq_work_is_busy(work))
> -		cpu_relax();
> +	rcuwait_wait_event(&work->irqwait, !irq_work_is_busy(work), TASK_UNINTERRUPTIBLE);

Dan Carpenter brought to my attention this a few weeks ago for another problem.:

perf_remove_from_context() <- disables preempt
__perf_event_exit_context() <- disables preempt
-> __perf_remove_from_context()
   -> perf_group_detach()
      -> perf_put_aux_event()
         -> put_event()
            -> _free_event()
               -> irq_work_sync()

