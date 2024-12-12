Return-Path: <linux-kernel+bounces-442887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D84E79EE37F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 10:56:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B036283B08
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 09:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DBA420FAB5;
	Thu, 12 Dec 2024 09:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WNQef5as"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D082204C3D
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 09:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733997400; cv=none; b=UK6dxPSQChQHiEVJXUR03ufRp6mGN7/CjbulC9OvEOB/AvwhT7h8INRzM79oIdh9bgmhkKLpPC1XOHltMDFZb/PwHFZkwu/WA7y7EDc6734aJ7jfbFiLXwUE95GPjLhODj9ta/+yXuAbbHFleLABa4MkNDMLpQl55C17kjA2U+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733997400; c=relaxed/simple;
	bh=GKpvAGsMS43/hyHIryMhSg1ry1xLRCtSL4HX806+2IU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B3rxHmMmCXazsxziDBf2/bAVFPRtfDo0uNcJ11xh7pHAgO8MJewDuCYmihJjAAEE5Zq2Kj7RtdD/y9JvTYbjlQuAYi0Rn5qD2PLBFaUHWFwwy61pQYTo/HyWBdfOfX1BPrlSzid35si8SZetm5OFyLKtGdx9umEN2mFFE2ufQco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WNQef5as; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-728e1799d95so461290b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 01:56:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733997398; x=1734602198; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qLxnIzd4GcNME5sPG/fJL7Fz3DLaanT+mToVRVhPGgA=;
        b=WNQef5aslxsi+fTLX6SBSLtjqCBO7Gcl6Mlq/FGJoX0Z/9ccE4wN9Pg3+guhXgXr+G
         WS0vM6M+/zC5hNol7q60L1rhVVQ+3xartvnACP445beYohDqjEhcGBRf7bK8wEkOnPpH
         bc9NAvH8AGsVgo/nkUfFSHGpdEwFAPsF2MX16UtkApIyMGLyf0+vCcjlUf/H00W+nZZQ
         An2zlRVRpL97yE6XE4TLjXFLVJcpv0FFhc/mXjLBMjAJsRqrt2+m7zSKghFK3Qg12B8y
         A2fay7ShfDOLcRkSFfz/Ecz01ms0EIk8cxy0sOo0W/5rCFHk6oB56+t9CiNDHHuMmh8I
         Wi4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733997398; x=1734602198;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qLxnIzd4GcNME5sPG/fJL7Fz3DLaanT+mToVRVhPGgA=;
        b=phST/Au3R/xUWOZ1yHcWLI4VPiakG45iNvtjvgMLghTypDDGI7EahIlZ+jdoKCqxju
         GjEXkCpQjG7pnVBS+X8yn5t2C/eF1r0q2GMlUhfmUrIhANeJkwRaNDf6boBkjS8KMD+C
         ltUroTInPZSYCxiLEQIh0mvjOhMyC+K+SR9jV/YdH05SneaPzOMOGmrUi0zB1vfVgTy0
         uD6/ghXpHMBFmi8H3CF3i3Qkl5uNMWkTi4KdG1jeL2OerBA7Lc1wX0IfydqrqwSQNmL5
         l5X3OaJo/W+4RcpVT43rJpLbfso0YnMp3myZmOizwQgO8nycaHCDEkmNG/F8Nr3ng5h2
         X6Sg==
X-Forwarded-Encrypted: i=1; AJvYcCX1fveQ7EYW+imjedlaLiS7GoXY0SpPuH8uz9+jhRHGrN+E0Er2dlxdORL0Jm61/9b5QJLD/+4gNLfPXqs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSWG6c+b5j/V6hgzS4kGw2h1lyCaJIAezEpVEs0mYvnjmbKn2H
	ltnl/NUaGoVWwKl1WvSXj5GwQlFkmldyc0csYg3/3NGqzH4idZHnRX2SaUuAVkYV0yidvjJ6UNh
	Y1a0z9dHh9+1LX3jHrXxbOYx86R6VHoZ/C/fDeA==
X-Gm-Gg: ASbGncv7jegsMqfzbjmHqnJsrS1sa5dlVvccCOCu7dWHPAB/ALTw67dAa6RUcpJf7k4
	42kYmcRLT/reIrMoOWrR9Uz8OJMtpYv73T8f2w7Sa64g4xcPodhNJeAnOMjy3JenXBpE=
X-Google-Smtp-Source: AGHT+IGpVV7yOgN9mrdK/dpaEbiuCT191rsv8/JqgKKRVwEP7O1nhHdYADcNLCU2hU8Pl5OhGH11PhjfTR72EWDYaFs=
X-Received: by 2002:a05:6a20:918d:b0:1e1:aab8:386a with SMTP id
 adf61e73a8af0-1e1ceae1c51mr4067839637.18.1733997398419; Thu, 12 Dec 2024
 01:56:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241211185552.4553-1-kprateek.nayak@amd.com> <20241211185552.4553-8-kprateek.nayak@amd.com>
In-Reply-To: <20241211185552.4553-8-kprateek.nayak@amd.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Thu, 12 Dec 2024 10:56:27 +0100
Message-ID: <CAKfTPtDQy=VfH3Ta8zLSACX7QV+LWaRvj_ueN=iSu5i4t8oBtQ@mail.gmail.com>
Subject: Re: [PATCH 7/8] sched/fair: Do not compute overloaded status
 unnecessarily during lb
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, x86@kernel.org, linux-kernel@vger.kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>, 
	Tim Chen <tim.c.chen@linux.intel.com>, Mario Limonciello <mario.limonciello@amd.com>, 
	Meng Li <li.meng@amd.com>, Huang Rui <ray.huang@amd.com>, 
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 11 Dec 2024 at 19:58, K Prateek Nayak <kprateek.nayak@amd.com> wrote:
>
> Only set sg_overloaded when computing sg_lb_stats() at the highest sched
> domain since rd->overloaded status is updated only when load balancing
> at the highest domain. While at it, move setting of sg_overloaded below
> idle_cpu() check since an idle CPU can never be overloaded.
>
> Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
> ---
>  kernel/sched/fair.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index ec2a79c8d0e7..3f36805ecdca 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -10358,9 +10358,6 @@ static inline void update_sg_lb_stats(struct lb_env *env,
>                 nr_running = rq->nr_running;
>                 sgs->sum_nr_running += nr_running;
>
> -               if (nr_running > 1)
> -                       *sg_overloaded = 1;
> -
>                 if (cpu_overutilized(i))
>                         *sg_overutilized = 1;
>
> @@ -10373,6 +10370,10 @@ static inline void update_sg_lb_stats(struct lb_env *env,
>                         continue;
>                 }
>
> +               /* Overload indicator is only updated at root domain */
> +               if (!env->sd->parent && nr_running > 1)

nit: may be worth checking local variable 1st which should be cheaper
than env->sd->parent

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>


> +                       *sg_overloaded = 1;
> +
>  #ifdef CONFIG_NUMA_BALANCING
>                 /* Only fbq_classify_group() uses this to classify NUMA groups */
>                 if (sd_flags & SD_NUMA) {
> --
> 2.34.1
>

