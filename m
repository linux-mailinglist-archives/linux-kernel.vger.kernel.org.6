Return-Path: <linux-kernel+bounces-554366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 841FBA596DC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 14:59:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45F573AA0DD
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 13:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A00F22A807;
	Mon, 10 Mar 2025 13:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P4bGru9o"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1BBB1AA7BA
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 13:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741615191; cv=none; b=PXC6FXGjxdvW9WjeHbJJRWAydSHsOix8JDylcpDvXk2RgWLqqPU4Q0hziJWDWtOPrfxcPzVbG/5A8Ku0E4XC/KPipesTLpAjJ7WlmZ1/Gldv0D30inpzsADnub6tn5bATjWEi7Rl4refuIU1wrjdJODoUou4VK6YR+GkJAryIkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741615191; c=relaxed/simple;
	bh=Yh6n9bq/amLuXLGzyyexficZQzX1dJOyGY6+IEDDQsA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hkqAerLjp/LA04WoLa6EQYLsfhdTvKI+3aDSw8Kkv+H5sW2g9WpzSpBbRNFE4K1S2um69h2ZJj7wUKrQrThy0tPZBGE4x/XKyVshrTA1iFr58ahdra7tZkjJeSMlQpjzNDim43Z9lmmO7Umc+bVexhoWq0Pfe6UE4a4LE8mTAKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=P4bGru9o; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5e6ff035e9aso1740445a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 06:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741615188; x=1742219988; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jl+g7SjppZuPPqGMNpi69kOreR0Ej6ApvhdQOqINvfs=;
        b=P4bGru9od4kyAKTNMVICMn2JIvPZjprHcZdNaR804zjAndHgFqbtw50JEfe1DLNKHw
         xakueD3P/c5TfnDfgkdDoHcpDgpECfLMG/cPQ39Pvrrl5Q8lhbUMKOFYHR8H2zBZIGIz
         1eh2Gry3N6FG1t49ix9KxjhyzHuMfL0/UzLCMqsXXrklT8bOlxmcF6X+PeBK9lGJ7+XL
         On/sizXMClFS4RZ6cdzstddEPQHvwrgo3WzHqJnhPcqczvfUma6du/laZRN6vUJP6DmT
         eg29MppqfgTxt0ZZM6ITHnTiFYTmDTp8Bj5rYOPHGcLH7mm1gXRilCE6tk/qNYA+NWvb
         JqwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741615188; x=1742219988;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jl+g7SjppZuPPqGMNpi69kOreR0Ej6ApvhdQOqINvfs=;
        b=EZPpSyzbfMwZbresvCKz5xQXWKz7x2KzSIPnLh1MJx516dhDAur6hYY4kvMPKW2Gkm
         gFZx01YpgyJaWbMydprVqoKN/BpyGQ5RYgMNzQoN72VPwfrh14nWNZSOehS/+/mRBen4
         RRAgyrhDaV1sQq83gZ+ETl0u8zETSmSt34LZ3U9GZ56HeQg1vLGbMFBSYk9wpAiv2Ytz
         nl4gLh0r9e69o4OX64rIHv6Xbq6JfuHDSm9M6uSjRri1lbcv/sMKkQQlrHMjLRm4LAhu
         QhdervjtghDt0DEiDbokiveLdzhTTx+wIL2qbsy7MM4/HMUppUpfa+4FBKrv6QIMst3p
         syqA==
X-Forwarded-Encrypted: i=1; AJvYcCVhJSPld7ikTnRfIdA15klKcbMHyuYs3ilqZ2XtpLbGrbqNfWhWSjpPQuDEiGkDKNjAO5IbXRwPwJLQRNg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2W3y1UhvuCrPj551ngCyZzDhDInZDKwz0ajKmioLD6kQMSXsW
	yVkwRkA6DUHkMJn1kUGzlZYSX5/AwnXEyuhcWIEqE8R55jchMPWeECnEk581guQHy1XM49+4Khh
	XfbeWqVXISmabv3k/Ixp1O+Fdgnas1IdhoqhlEZf7CjI8OrljdYE=
X-Gm-Gg: ASbGncs38nPhxc2ZlAgSCueBdIzbRfO+ya9dTMCqpQp922o9I2GLU7RAMo7iaDdBoUj
	sSCS4je+bCvLX7pCBbBk6shqVFHgBenh9ZaxoGUxl2CeQTlXS9uqWtMUQY2Re/mCB1Zdp2fm4aZ
	IzK0YVRmrFSW4JmU8w+kU4U0iU0APJaqoy1TN2u4AruKtQpkDQ8q0IpY0=
X-Google-Smtp-Source: AGHT+IEtJqb7qfe2DsiNgJhvPScBvm1kIZ1noKr+pKDu1mABwPOfnwjYQ06UJTE6wA0frCo76hdhEImgTegcbjsvblA=
X-Received: by 2002:a17:907:9455:b0:abf:425d:5d3 with SMTP id
 a640c23a62f3a-ac252f4b12dmr1655355266b.40.1741615187926; Mon, 10 Mar 2025
 06:59:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250306162635.2614376-1-dietmar.eggemann@arm.com>
In-Reply-To: <20250306162635.2614376-1-dietmar.eggemann@arm.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Mon, 10 Mar 2025 14:59:36 +0100
X-Gm-Features: AQ5f1JqXfUiTPrsgOLbGCRIyNlvJx35yv-k1-8QkWqgOfehpJs9nYQjirGu9CPA
Message-ID: <CAKfTPtCfd_=gm7rsT_qBL8pw5uybEvYH4N2tvxpKndxxi4L7oA@mail.gmail.com>
Subject: Re: [PATCH] /sched/core: Fix Unixbench spawn test regression
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Hagar Hemdan <hagarhem@amazon.com>, linux-kernel@vger.kernel.org, 
	wuchi.zero@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 6 Mar 2025 at 17:26, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>
> Hagar reported a 30% drop in UnixBench spawn test with commit
> eff6c8ce8d4d ("sched/core: Reduce cost of sched_move_task when config
> autogroup") on a m6g.xlarge AWS EC2 instance with 4 vCPUs and 16 GiB RAM
> (aarch64) (single level MC sched domain) [1].
>
> There is an early bail from sched_move_task() if p->sched_task_group is
> equal to p's 'cpu cgroup' (sched_get_task_group()). E.g. both are
> pointing to taskgroup '/user.slice/user-1000.slice/session-1.scope'
> (Ubuntu '22.04.5 LTS').

Isn't this same use case that has been used by commit eff6c8ce8d4d to
show the benefit of adding the test if ((group ==
tsk->sched_task_group) ?
Adding Wuchi who added the condition

>
> So in:
>
>   do_exit()
>
>     sched_autogroup_exit_task()
>
>       sched_move_task()
>
>         if sched_get_task_group(p) == p->sched_task_group
>           return
>
>         /* p is enqueued */
>         dequeue_task()              \
>         sched_change_group()        |
>           task_change_group_fair()  |
>             detach_task_cfs_rq()    |                              (1)
>             set_task_rq()           |
>             attach_task_cfs_rq()    |
>         enqueue_task()              /
>
> (1) isn't called for p anymore.
>
> Turns out that the regression is related to sgs->group_util in
> group_is_overloaded() and group_has_capacity(). If (1) isn't called for
> all the 'spawn' tasks then sgs->group_util is ~900 and
> sgs->group_capacity = 1024 (single CPU sched domain) and this leads to
> group_is_overloaded() returning true (2) and group_has_capacity() false
> (3) much more often compared to the case when (1) is called.
>
> I.e. there are much more cases of 'group_is_overloaded' and
> 'group_fully_busy' in WF_FORK wakeup sched_balance_find_dst_cpu() which
> then returns much more often a CPU != smp_processor_id() (5).
>
> This isn't good for these extremely short running tasks (FORK + EXIT)
> and also involves calling sched_balance_find_dst_group_cpu() unnecessary
> (single CPU sched domain).
>
> Instead if (1) is called for 'p->flags & PF_EXITING' then the path
> (4),(6) is taken much more often.
>
>   select_task_rq_fair(..., wake_flags = WF_FORK)
>
>     cpu = smp_processor_id()
>
>     new_cpu = sched_balance_find_dst_cpu(..., cpu, ...)
>
>       group = sched_balance_find_dst_group(..., cpu)
>
>         do {
>
>           update_sg_wakeup_stats()
>
>             sgs->group_type = group_classify()
>
>               if group_is_overloaded()                             (2)
>                 return group_overloaded
>
>               if !group_has_capacity()                             (3)
>                 return group_fully_busy
>
>               return group_has_spare                               (4)
>
>         } while group
>
>         if local_sgs.group_type > idlest_sgs.group_type
>           return idlest                                            (5)
>
>         case group_has_spare:
>
>           if local_sgs.idle_cpus >= idlest_sgs.idle_cpus
>             return NULL                                            (6)
>
> Unixbench Tests './Run -c 4 spawn' on:
>
> (a) VM AWS instance (m7gd.16xlarge) with v6.13 ('maxcpus=4 nr_cpus=4')
>     and Ubuntu 22.04.5 LTS (aarch64).
>
>     Shell & test run in '/user.slice/user-1000.slice/session-1.scope'.
>
>     w/o patch   w/ patch
>     21005       27120
>
> (b) i7-13700K with tip/sched/core ('nosmt maxcpus=8 nr_cpus=8') and
>     Ubuntu 22.04.5 LTS (x86_64).
>
>     Shell & test run in '/A'.
>
>     w/o patch   w/ patch
>     67675       88806
>
> CONFIG_SCHED_AUTOGROUP=y & /sys/proc/kernel/sched_autogroup_enabled equal
> 0 or 1.
>
> [1] https://lkml.kernel.org/r/20250205151026.13061-1-hagarhem@amazon.com
>
> Reported-by: Hagar Hemdan <hagarhem@amazon.com>
> Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> ---
>  kernel/sched/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index b00f884701a6..ca0e3c2eb94a 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -9064,7 +9064,7 @@ void sched_move_task(struct task_struct *tsk)
>          * group changes.
>          */
>         group = sched_get_task_group(tsk);
> -       if (group == tsk->sched_task_group)
> +       if ((group == tsk->sched_task_group) && !(tsk->flags & PF_EXITING))
>                 return;
>
>         update_rq_clock(rq);
> --
> 2.34.1
>

