Return-Path: <linux-kernel+bounces-336322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE17D98392A
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 23:41:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7FFE1C21955
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 21:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 148E284D0E;
	Mon, 23 Sep 2024 21:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MqbruLIU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75FBA17BCC
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 21:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727127692; cv=none; b=nf3yPFMwm6tSyHgwtHetzZIHo+gSuNERY4kZkjCa+iVNP0VHIO1du8bRLCGz6JmCzBtQ1NSc8JdfrarFSC2R0HdkvPIMQxxCgPe//+Ga/Pqd/Wsp5XgNILC2uU+hJRJsCLm+DBea8xbA8YC9GN6RpnP4S9kcdCa8WhB2PTB7yco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727127692; c=relaxed/simple;
	bh=qxyvCNYSHdgx/DVQkQTMhEEiuC5CFh7mYE+UyDoM7v8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BMTmMbzf7YIc7hhmLprBPP9+JFAVJBDa+Au+KP1i3r/F0/m3v5liIy3P+RkMOGnYlg99dWBWXOwbysrIYR7/t9DxO2YhZCH/ARElI6J6lENouhGzEoCitJ5e5TSEl69FLhnsppHeuTiL2CUcLTbzVO00xzCAPgTRMgmD5/v021k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MqbruLIU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95A3AC4CEC4;
	Mon, 23 Sep 2024 21:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727127690;
	bh=qxyvCNYSHdgx/DVQkQTMhEEiuC5CFh7mYE+UyDoM7v8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MqbruLIUBVxPG/hnOB/6fUOzwIA7K0KrsvNU0kqz6+MmWX8EYGocC10wdhbZvaGsd
	 hlxjtyn4NRmkxMe+C7H38HzvCiJ4n1tqImWmX3ittyRQQuPFLIp49vtptkGg4dLA8W
	 II8u6QOk6e2b0lbYsJ1k/F/Jsaq8zbQhuaD5Hx+qNrkPwATEa7AV4KgOb4zAI9pz66
	 FckWlMLH609wx84Y9fmSdA3yPDkFrmB85P/mWdr+TwkJFzPxn/ncsR0X1DuIXQDFwI
	 QhwsMDOH2yeWSwenpeEIH1/y/bQlVM+x3atlP7hhneJQSWj+fqVoFL7Zv62ueBYYUx
	 bOOCSb5kON/AQ==
Date: Mon, 23 Sep 2024 23:41:27 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Steven Davis <goldside000@outlook.com>
Cc: akpm@linux-foundation.org, ankur.a.arora@oracle.com,
	linux-kernel@vger.kernel.org, peterz@infradead.org,
	tglx@linutronix.de
Subject: Re: [PATCH] irq_work: Replace wait loop with rcuwait_wait_event
Message-ID: <ZvHghxL6ce-2y7Wx@pavilion.home>
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

So you can remove the CONFIG_PREEMPT_RT special case in this function, right?

Thanks.

>  }
>  EXPORT_SYMBOL_GPL(irq_work_sync);
>  
> -- 
> 2.39.5
> 

