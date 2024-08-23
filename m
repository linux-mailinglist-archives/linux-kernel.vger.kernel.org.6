Return-Path: <linux-kernel+bounces-298867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 32CF795CC5E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 14:29:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0865B23348
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 12:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29E36185944;
	Fri, 23 Aug 2024 12:29:20 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B774914B95F
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 12:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724416159; cv=none; b=iJNijV/+G+QAaIjts91uf9CpYeRUQpQHkedVlY+cWxVyPx74mgIRejj3hcS1d84zdGXsGsMsqvcKUsCgvybNvcQ3R/S2cpD8c+wzkYbvkGTS1QiqqYZGYspiNkqe/YTQ3xmAsTl/IL+fHOAzgNat7eqOm1IujsObvg+hxg5d5+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724416159; c=relaxed/simple;
	bh=5li+Z+Hjgfi4rJ+R1PImgeHC1lnF97g/mHtisZRsiW8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KGc5G18CsjVpVE2uP3Qxq+sKh6z/bmM5GOXiMtJBfb09L/Si+NHjLZYzv0886HxyGX0OPdwMKpwRQdJPjVbb+noBl/a/dFSZW91H9bLmqyH3aD8aRQgnN3ewCt6r93pY+qzM5IctAtY9tbWwMw+b5hGOSV797RD3nsFqfdO6Q4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFB23C32786;
	Fri, 23 Aug 2024 12:29:18 +0000 (UTC)
Date: Fri, 23 Aug 2024 08:29:51 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Hongbo Li <lihongbo22@huawei.com>
Cc: <mhiramat@kernel.org>, <mathieu.desnoyers@efficios.com>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next] kernel/trace: Replace printk and WARN_ON by WARN
Message-ID: <20240823082951.37d6ea70@gandalf.local.home>
In-Reply-To: <20240823091803.2953933-1-lihongbo22@huawei.com>
References: <20240823091803.2953933-1-lihongbo22@huawei.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 23 Aug 2024 17:18:03 +0800
Hongbo Li <lihongbo22@huawei.com> wrote:

> Use WARN instead of printk + WARN_ON as reported from coccinelle:
>   SUGGESTION: printk + WARN_ON can be just WARN
> Let's fix it and simplify the code.

Following the advice of robots causes the brain to stop functioning.

> 
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
> ---
>  kernel/trace/trace.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 833e7d654325..5f385c55499f 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -2138,9 +2138,7 @@ static int run_tracer_selftest(struct tracer *type)
>  	/* the test is responsible for resetting too */
>  	tr->current_trace = saved_tracer;
>  	if (ret) {
> -		printk(KERN_CONT "FAILED!\n");
> -		/* Add the warning after printing 'FAILED' */
> -		WARN_ON(1);
> +		WARN(1, "FAILED!\n");

You completely IGNORED and then REMOVED the comment!!!!

Notice that it's not even a KERN_WARN, it's a KERN_CONT.

BIG NACK!

-- Steve

>  		return -1;
>  	}
>  	/* Only reset on passing, to avoid touching corrupted buffers */


