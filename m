Return-Path: <linux-kernel+bounces-328546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B5D97858B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 18:14:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 080441C222C3
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 16:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6435161FC4;
	Fri, 13 Sep 2024 16:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jc1DQIL5"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA1ED502
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 16:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726244079; cv=none; b=n9FS2QPHloxOTe3OxLU+t6z99xLX1iO++Fo5EaaRTf5dtaPMizKQFSvJWhcYLaFsRa51UgBIy7fl4A5ROYF3wY+ci+9RQA8D0KdDlznlzRsVuRpeUlv2gIhegxy5pa5opGZLh2+9dnD+pXOvb+igacXFycnark+7icvISLk0ywc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726244079; c=relaxed/simple;
	bh=58i9GhiFFTmfKWxU3edBq68pTLPjGtrRGCYmR0XEWYw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ma7v33EshW307BYWch91PsISHj9HPheoiwP/HzCFrmC+3Zjchag/KVQ7PhUMSIa5Sz9W/qhRCHmwXld/UXIRHAgIJ20TAzvLFMvmm6eZ9Nv7t+s+tIdm+h8k7X/8889mMkh6GZZ2hAgKIH+pJ5e9fD1AtlK2PIqWoCuZ3E829Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jc1DQIL5; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7b0c9bbddb4so1631811a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 09:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726244077; x=1726848877; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=k3sfmhPCsJ8N0kfGHvGp1JD0fhbJFa0kOkkkY4RvNYg=;
        b=jc1DQIL5RHmoR80Tmtf5VlWXQwD+OVZ0UdgXgMnzjTv+8QdtXvNctxz+YHq3IG9E0Q
         lrQ8Jf/5Zs15KfnW1AtOLSUOnzE7+1wExYNKax1X6sQ6N8pvkImxvJqdmgn3Jihnie1Z
         XTeJjXCurSMaIiIDq1jJP+a2Y6Vqb+PyF0H4CIVQ7nSQsl6RsiExSn0oDaboHd3JegE5
         FP5Mb0ZRjiNqq5DWnTuVolLziJ1s0EneIMUE7XVyvMAJsxEI3Beqttkuetq0gBNyprQl
         DfKRKc0m1O28KQp3pHBzfQLVATtp7hzjSFkVt3Yu7OawuCGMk5u/Vu9asb7Gtwp/PbOs
         db3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726244077; x=1726848877;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k3sfmhPCsJ8N0kfGHvGp1JD0fhbJFa0kOkkkY4RvNYg=;
        b=H+goHu8VpPz+fcNW2IMEha/PbpBLrUYe78/m9E8yFPKIFPvEiAMhIkb2XiQnJQQpP8
         +CNfGIminu7PgN6LxP8ETYdHZhJjPL0azYxR32Zc3Q9ZI/5iyly+R4S7sWbERjV0lpNR
         zblCdXr46UIvCLlqAfFSVdBoMnx4fJYbsrNRXj/ykc4HKw+2HaQeWhsQ+aO6Y3VouYe7
         xxD8SWXAQ1nZDuhXd8a8YbY/8t4VmgJiHcluu9CQpzDsLXivKunP0/FBeXU4oJM5Bui3
         hQS4YT7MeYf2UXxygRnNTLfZC8FWRCoA2p6cnPUU27L+2OcHfZ8W1Uzu6JavbHLA7k4J
         r0aw==
X-Gm-Message-State: AOJu0YwdDcUIMYEdZwz1YgvbbCHwXgN0B38zuYGFQZ/qIE4Udo+D9MEM
	tH9JGVmBRJKcu2TMbsd/n7lzMvpM8QEKjvG166vqA5KVIyPDoVpIrnZlk9hHursOhwm6K0c6Ocj
	ES7VXGtcrAIawkMeHLmbDB3gVFXgZrLB3AbH+WA==
X-Google-Smtp-Source: AGHT+IE1JePHlH3d/E87lzzKaJZwUvbA+kPupkgy6Tswjrp87EvmuEgorBN7aRkFJMMq4kK0pCYLnLU6PhV97Yv5DHY=
X-Received: by 2002:a17:90a:c10:b0:2d8:f7e2:eff with SMTP id
 98e67ed59e1d1-2dba006821cmr7133948a91.36.1726244077324; Fri, 13 Sep 2024
 09:14:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240913085824.404709-1-pierre.gondois@arm.com>
In-Reply-To: <20240913085824.404709-1-pierre.gondois@arm.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Fri, 13 Sep 2024 18:14:26 +0200
Message-ID: <CAKfTPtB2=_O=dJbTH=e_Hg80_rcSvBgwUP+ZMehfyG4sG5W6iQ@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: Fix integer underflow
To: Pierre Gondois <pierre.gondois@arm.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>
Content-Type: text/plain; charset="UTF-8"

Hi Pierre

On Fri, 13 Sept 2024 at 10:58, Pierre Gondois <pierre.gondois@arm.com> wrote:
>
> (struct sg_lb_stats).idle_cpus is of type 'unsigned int'.
> (local->idle_cpus - busiest->idle_cpus) can underflow to UINT_MAX
> for instance, and max_t(long, 0, UINT_MAX) will output UINT_MAX.
>
> Use lsub_positive() instead of max_t().

Have you faced the problem or this patch is based on code review ?

we have the below in sched_balance_find_src_group() that should ensure
that we have local->idle_cpus > busiest->idle_cpus

if (busiest->group_weight > 1 &&
    local->idle_cpus <= (busiest->idle_cpus + 1)) {
    /*
    * If the busiest group is not overloaded
    * and there is no imbalance between this and busiest
    * group wrt idle CPUs, it is balanced. The imbalance
    * becomes significant if the diff is greater than 1
    * otherwise we might end up to just move the imbalance
    * on another group. Of course this applies only if
    * there is more than 1 CPU per group.
    */
    goto out_balanced;
}

>
> Fixes: 0b0695f2b34a ("sched/fair: Rework load_balance()")
> cc: stable@vger.kernel.org
> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
> ---
>  kernel/sched/fair.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 9057584ec06d..6d9124499f52 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -10775,8 +10775,8 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
>                          * idle CPUs.
>                          */
>                         env->migration_type = migrate_task;
> -                       env->imbalance = max_t(long, 0,
> -                                              (local->idle_cpus - busiest->idle_cpus));
> +                       env->imbalance = local->idle_cpus;
> +                       lsub_positive(&env->imbalance, busiest->idle_cpus);
>                 }
>
>  #ifdef CONFIG_NUMA
> --
> 2.25.1
>

