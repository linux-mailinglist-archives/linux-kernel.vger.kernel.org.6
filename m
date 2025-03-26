Return-Path: <linux-kernel+bounces-577443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 991CEA71D17
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 18:26:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B9B57A8BEE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 17:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8902F215791;
	Wed, 26 Mar 2025 17:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V6R0Iakg"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B7621579F
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 17:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743009946; cv=none; b=Q8soKJyt7OYGDbQzxs2DyuIcjnqDWuAUPzWl+uODpuRDk1pAUUdzn/GUYc/fYrR6iqk3o1wFlreB/AdpqkcItqYwsfAgej9eNlSVsbyvVu2qKrIEtCnq7Y+iTJfLcsb/d6q4JktqA5yJuHpTFBuN+nb0ng2jEf7O/EOiEZLCJGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743009946; c=relaxed/simple;
	bh=LyI82Ys2O9la28KCLjgrOfoLbD3OT0wDAR5iRRxrxIU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uhz1XtEEqUFsuw/vj7NbPYzkQcBdd9a9bhr49PPik8FwbxhMRtztHVFMCmUVvTRrC9ZvwWEbTW5k2pFJo6HIb6SeYRzu2WlR5aIBp5oqsJ1P/6jRdire6Dt4ZkbFtOlx9sBaRIwJtAt1crMY6tW6NOvsbUbajv6nlDMUCl+ROjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=V6R0Iakg; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ac298c8fa50so11086366b.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 10:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1743009943; x=1743614743; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hYZRfbu7gQUa+RW47dljr54AuBiOf4/iSQG+JvcYJ7s=;
        b=V6R0IakghImbAizOFhr18XbYY31NyJAu2E8c0TacRLfnvPq9NB8YHj15eJBOs0ai6k
         XkyF5ndUDvpfJ2sXtjTCRDbvHxLReF5HmJgBnclLI8oZG1Y0UmTm/CScRTAMlOZOClKm
         tFL7+7IiJ4DC5GcVQnfTr5+bcqQAP7dNMiOs9PCw0WvZCp2iqy+LltzM6gp+7/+6ZAg1
         3vYSSlw9Kuz3CFkQOMiXDhqF4/BfZEUUwbOc7RTurH4q6BN8VPGoZTTnlxtDcQIE1vWT
         LODTEZEHFPSX4ca8uknCwsIVuXGWhJnPkVyq/p7Oa5e1D5tQZiKn1aJ559j4bFYgeYnd
         APOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743009943; x=1743614743;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hYZRfbu7gQUa+RW47dljr54AuBiOf4/iSQG+JvcYJ7s=;
        b=AOizM2KUss1xJMrf2voEvBR8EF7hEYlhMorXUNfcLNyoEb5uOk3re9mT6TjB+MYLLd
         KgiBiqn9ycRX+3uB9CFC1gvmAdi9zwuqXy2N1j5LF43np8s7rlZpJs9ao1T8lWJOX/TS
         +V2BUWobeRFOHOeBKB/eHkBpE669M0PXoXVR6EcZ1048fL4Ilb/NxoPRFD5ON+G8LELh
         Ed+CFMtrHjloOFrhIz2bpW6/mdNFKA2Ja8cvvbkoJvDn1n+qvAqYBJHplx6fdEaqctWG
         BVDOx4rSRuIPs6gJyiTjy+KiqqucdoY3y3D7HFW/OsIPNVr2qBzT9hEKajwvWqGyIzd/
         a1rQ==
X-Gm-Message-State: AOJu0Yx3hLikvirmO6hiLeQ8UMfLJfMK8HkjXzj4qWmLpulMvxUp6NdY
	QcHoQbo+7zm95zAPvkbrNq3V42uSfe/1tf7i6xFce7uCZ0mVF2nd97EzsXsCyKG/Poali9dJyAG
	MSNgzsKTZ3nUQ3mD7rcjMLS6EYgNF3h9xQDjA3w==
X-Gm-Gg: ASbGncumBKVIVsne1/V+HRYqUlMCYfA8bLqhptXONucO1aBZQZOmC/UQJ61jDwRCLSW
	ME7TwMGPpTJqdiV/IPscp+k4xkn8j8CeG3V6U4qOuLZr81we0BlsKbmNwjBEm7jSqudAv/u++QB
	B70OESIN6bRYFAxmyB1ZDJmVGUtIMWqO567A2RYLB+2LeYDqKpMmS9y3s=
X-Google-Smtp-Source: AGHT+IFiqtfLGcmnfHpM1daCPLkdk+Zjj2vcxw29bsJlYk8tY+5JeLYhHSgZF+MXNlcMpYBy4X5JyIRXSzPaUwwobjo=
X-Received: by 2002:a17:906:c10b:b0:abf:7636:3cab with SMTP id
 a640c23a62f3a-ac6faefef6fmr25273466b.29.1743009942974; Wed, 26 Mar 2025
 10:25:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250325150542.1077344-1-pierre.gondois@arm.com>
In-Reply-To: <20250325150542.1077344-1-pierre.gondois@arm.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Wed, 26 Mar 2025 18:25:30 +0100
X-Gm-Features: AQ5f1Jq0RVdOAfjgGQWciTmYmToxBncRZeHG1o7A9n59ADSeEVtrCfZukyO6vf0
Message-ID: <CAKfTPtCfaH6SvBesbKBHRNfjZHJXXC1h4NF8GoFUczE5NiRunQ@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: Allow decaying util_est when util_avg > CPU capa
To: Pierre Gondois <pierre.gondois@arm.com>
Cc: linux-kernel@vger.kernel.org, Chritian Loehle <christian.loehle@arm.com>, 
	Hongyan Xia <hongyan.xia2@arm.com>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 25 Mar 2025 at 16:06, Pierre Gondois <pierre.gondois@arm.com> wrote:
>
> commit 10a35e6812aa ("sched/pelt: Skip updating util_est when
> utilization is higher than CPU's capacity")
> prevents util_est from being updated if util_avg is higher than the
> underlying CPU capacity to avoid overestimating the task when the CPU
> is capped (due to thermal issue for instance). In this scenario, the
> task will miss its deadlines and start overlapping its wake-up events
> for instance. The task will appear as always running when the CPU is
> just not powerful enough to allow having a good estimation of the
> task.
>
> commit b8c96361402a ("sched/fair/util_est: Implement faster ramp-up
> EWMA on utilization increases")
> sets ewma to util_avg when ewma > util_avg, allowing ewma to quickly
> grow instead of slowly converge to the new util_avg value when a task
> profile changes from small to big.
>
> However, the 2 conditions:
> - Check util_avg against max CPU capacity
> - Check whether util_est > util_avg
> are placed in an order such as it is possible to set util_est to a
> value higher than the CPU capacity if util_est > util_avg, but
> util_est is prevented to decay as long as:
> CPU capacity < util_avg < util_est.
>
> Just remove the check as either:
> 1.
> There is idle time on the CPU. In that case the util_avg value of the
> task is actually correct. It is possible that the task missed a
> deadline and appears bigger, but this is also the case when the
> util_avg of the task is lower than the maximum CPU capacity.
> 2.
> There is no idle time. In that case, the util_avg value might aswell
> be an under estimation of the size of the task.
> It is possible that undesired frequency spikes will appear when the
> task is later enqueued with an inflated util_est value, but the
> frequency spike might aswell be deserved. The absence of idle time
> prevents from drawing any conclusion.
>
> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>

This change looks reasonable to me. Did you face problems related to
this in a particular use case ?

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.rog>


> ---
>  kernel/sched/fair.c | 7 -------
>  1 file changed, 7 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index c798d2795243..de7687e579c2 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4918,13 +4918,6 @@ static inline void util_est_update(struct cfs_rq *cfs_rq,
>         if (last_ewma_diff < UTIL_EST_MARGIN)
>                 goto done;
>
> -       /*
> -        * To avoid overestimation of actual task utilization, skip updates if
> -        * we cannot grant there is idle time in this CPU.
> -        */
> -       if (dequeued > arch_scale_cpu_capacity(cpu_of(rq_of(cfs_rq))))
> -               return;
> -
>         /*
>          * To avoid underestimate of task utilization, skip updates of EWMA if
>          * we cannot grant that thread got all CPU time it wanted.
> --
> 2.25.1
>

