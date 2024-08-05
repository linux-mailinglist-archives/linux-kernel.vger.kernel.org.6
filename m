Return-Path: <linux-kernel+bounces-274814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9E50947D1A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 16:45:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 962DC285084
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 14:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4329A149000;
	Mon,  5 Aug 2024 14:45:04 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D763A13C67E
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 14:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722869103; cv=none; b=Lzi2FS5pFVYQC/q4i3kNG2Vvut6HyU9G+YJ1bd3v5PhKTsAL8yCJB93TmL6oFU0pOmiUZwLSF2j+QpSEb5NiKzZeXeOQX7zqEJUapCvkfmWoikLvo28diZk4ngU7+CYNDvWmAoryG2BYcuXzPs3l8U6Wb+9nCOiSPq3IyhNIKPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722869103; c=relaxed/simple;
	bh=vC6nX0apxBLoU6EqUiVEoO9ic/umJEX70x5GeL9NS2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jsQdQOCLZXKylEvY7tYUFL55J4EWsf9xz4CpM2/ZOjexp/+fh39YwtcHeNS+kAxcrRt9ZHot1QcxUhrIM0E1Pooj8ctiHT7Ii1/eOyLKq+JjtXpOokGOtGrSbgXoPfEDse6vL29KCV/OAipMD5pUDPobyJ6VclWIT/Z9uJneSpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B58D4106F;
	Mon,  5 Aug 2024 07:45:26 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AABAE3F5A1;
	Mon,  5 Aug 2024 07:44:59 -0700 (PDT)
Date: Mon, 5 Aug 2024 15:44:53 +0100
From: Dave Martin <Dave.Martin@arm.com>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH 01/20] arm/bL_switcher: Use kthread_run_on_cpu()
Message-ID: <ZrDlZYoafHFpW4TS@e133380.arm.com>
References: <20240726215701.19459-1-frederic@kernel.org>
 <20240726215701.19459-2-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240726215701.19459-2-frederic@kernel.org>

Hi,

On Fri, Jul 26, 2024 at 11:56:37PM +0200, Frederic Weisbecker wrote:
> Use the proper API instead of open coding it.
> 
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> ---
>  arch/arm/common/bL_switcher.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/common/bL_switcher.c b/arch/arm/common/bL_switcher.c
> index 9a9aa53547a6..d1e82a318e3b 100644
> --- a/arch/arm/common/bL_switcher.c
> +++ b/arch/arm/common/bL_switcher.c
> @@ -307,13 +307,11 @@ static struct task_struct *bL_switcher_thread_create(int cpu, void *arg)
>  {
>  	struct task_struct *task;
>  
> -	task = kthread_create_on_node(bL_switcher_thread, arg,
> -				      cpu_to_node(cpu), "kswitcher_%d", cpu);
> -	if (!IS_ERR(task)) {
> -		kthread_bind(task, cpu);
> -		wake_up_process(task);
> -	} else
> +	task = kthread_run_on_cpu(bL_switcher_thread, arg,
> +				  cpu, "kswitcher_%d");
> +	if (IS_ERR(task))
>  		pr_err("%s failed for CPU %d\n", __func__, cpu);
> +
>  	return task;
>  }

It's ages since I worked on this, but it looks like this is pure
refactoring.  So far as I can see, it does the right thing, so, FWIW:

Reviewed-by: Dave Martin <Dave.Martin@arm.com>

I don't currently have hardware I can test this on, though.

Nico (Cc added) might just possibly have an opinion on it, though this
looks uncontroversial.

Cheers
---Dave

