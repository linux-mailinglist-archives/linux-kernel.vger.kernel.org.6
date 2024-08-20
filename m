Return-Path: <linux-kernel+bounces-293144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF315957B3F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 03:58:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B5321C237CA
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 01:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C29C1BC58;
	Tue, 20 Aug 2024 01:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="OgEgrAhB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6F517BD5
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 01:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724119088; cv=none; b=sq0iWuXue2RCQAqlK1F1WuUiHMyFKUVubZmpW2Gu14VxeoSpcGEbfPzpNkOwnOvX22oQe0QuezjAsFzBZcAsyulA46SDmgXHmOxG3sGanlSNuPaJY+Tk7MbSHnTgt+/MFr5hIRMSeLU3lR7S/kVcH7Ifw1C1GQz4zpPV7O41b4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724119088; c=relaxed/simple;
	bh=cejtC/PyS6RvsWMyHm2qJil3IcRdGZA3/YAr3q5QXbk=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ZElcl3SpGPwMAZqfwOVSVHZN88aioKpoC/XV1egiOWueaiJSoB3FpTorlJmmjGHzy3hysSskI/dzVurWIijX43V1EL36HMlpRZtufMrWjxj2OenowqsCpNUNFKYZauQEzf9La2BAdDvZ3Xz9hBDNCQBRCJ0oRa37ycJRUxGPssk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=OgEgrAhB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3E3FC32782;
	Tue, 20 Aug 2024 01:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1724119088;
	bh=cejtC/PyS6RvsWMyHm2qJil3IcRdGZA3/YAr3q5QXbk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OgEgrAhBZuyATxrXhqbor+r49lEfhGh9L5J2NdeZApFXpE3HrWlaYMG45iNfdVpPt
	 Wpdc4mxN254YvU4kNO+ae2Yn1OtdV4ITGykk/VBTBkMFXRp3weiKPqFkEAiRsB9fqF
	 AioKcOnBnueDgzUg5skGCWpeGf6wEU4b4YovtiiA=
Date: Mon, 19 Aug 2024 18:58:07 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Chen Yu <yu.c.chen@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Andreas Gruenbacher
 <agruenba@redhat.com>, Tejun Heo <tj@kernel.org>, Shuah Khan
 <skhan@linuxfoundation.org>, "Mickael Salaun" <mic@digikod.net>,
 linux-kernel@vger.kernel.org, Chen Yu <yu.chen.surf@gmail.com>, kernel test
 robot <oliver.sang@intel.com>
Subject: Re: [PATCH] kthread: fix task state in kthread worker if being
 frozen
Message-Id: <20240819185807.ff5004ade2661c46740fc459@linux-foundation.org>
In-Reply-To: <20240819141551.111610-1-yu.c.chen@intel.com>
References: <20240819141551.111610-1-yu.c.chen@intel.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 19 Aug 2024 22:15:51 +0800 Chen Yu <yu.c.chen@intel.com> wrote:

> It was reported that during cpu hotplug test, the following
> error was triggered:
> 
>  do not call blocking ops when !TASK_RUNNING; state=1 set at kthread_worker_fn (kernel/kthread.c:?)
>  WARNING: CPU: 1 PID: 674 at kernel/sched/core.c:8469 __might_sleep
> 
>  handle_bug
>  exc_invalid_op
>  asm_exc_invalid_op
>  __might_sleep
>  __might_sleep
>  kthread_worker_fn
>  kthread_worker_fn
>  kthread
>  __cfi_kthread_worker_fn
>  ret_from_fork
>  __cfi_kthread
>  ret_from_fork_asm
> 
> Peter pointed out that there is a race condition when the kworker is being
> frozen and falls into try_to_freeze() with TASK_INTERRUPTIBLE, which
> triggeres the warning.

OK.  A full description of this race would be better than simply
asserting that it exists, please.

> Fix this by explicitly set the TASK_RUNNING before entering try_to_freeze().

OK.

> --- a/kernel/kthread.c
> +++ b/kernel/kthread.c
> @@ -848,6 +848,12 @@ int kthread_worker_fn(void *worker_ptr)
>  	} else if (!freezing(current))
>  		schedule();
>  
> +	/*
> +	 * Explicitly set the running state in case we are being
> +	 * frozen and skip the schedule() above. try_to_freeze()
> +	 * expects the current task to be in the running state.
> +	 */
> +	__set_current_state(TASK_RUNNING);
>  	try_to_freeze();
>  	cond_resched();
>  	goto repeat;

Comment is helpful, but why express in a comment that which can be
expressed in code?

--- a/kernel/kthread.c~kthread-fix-task-state-in-kthread-worker-if-being-frozen
+++ a/kernel/kthread.c
@@ -847,6 +847,12 @@ repeat:
 		trace_sched_kthread_work_execute_end(work, func);
 	} else if (!freezing(current))
 		schedule();
+	} else {
+		/*
+		 * Handle the case where X happens
+		 */
+		__set_current_state(TASK_RUNNING);
+	}
 
 	try_to_freeze();
 	cond_resched();
_


