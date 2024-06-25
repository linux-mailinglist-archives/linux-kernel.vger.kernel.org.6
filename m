Return-Path: <linux-kernel+bounces-228912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76DFA916893
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 15:05:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C026DB21EFA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 13:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0490114D45E;
	Tue, 25 Jun 2024 13:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="plGyAsNB"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73CF1E861
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 13:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719320709; cv=none; b=pWOdptsp8qkPgVxMKu1l2ef7RDDOQCauSzt4MsJHlDRo8/Ys8KnBVLKHPedkOR5oa32lytgMYDLq0mXaUBmHgguuq13yh4dhpNuS2sjs8b8bT1AUZr4+nq8WMIm5ghGJiyaOs3AckzVC8YwrIq1xAQGAuMIOa2wE6HQyo+hgzN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719320709; c=relaxed/simple;
	bh=/HsF/xKFUdO30WqC0OYPmbQqSGZqCDKGGiXFykxakAc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TWTf+9KZ+5VdX8OQn2qhFwaC88mbkkGLYXzls6qMtsaxN74OVzA4yK/QJPreqvx8M9jWB+Ij8lmUcVw03FCiUGxRT87+ZaqdegwuxmNCD5eJrtcFQVelzO7/Y/UyBbB/eabBT8+ltm55/ug+Nn9azOaKi4Eygj/Y932dOYOElEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=plGyAsNB; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-6c5bcb8e8edso3893433a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 06:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719320707; x=1719925507; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=X2Q2Gc0/a/GptHFmAre/qf9ITPsCyFPIjbIlaZ07oI4=;
        b=plGyAsNBqv15pUn8CV9sKzmzlnkX9OEGSYmDgblFP2cdeptmANgP+6BXEy5HtTUExs
         CsF4UT03j9lWvjbnIuksGS83RjM0yQNU1jK/ujJNybOiMzWKslDulifDHWrYDcKt3Fpj
         LEq+D7YrvrA2rAjBYt/34Ry0MDKxVF/9pv4/PEN/bhbkA7AJun1S9UeLV+WgJ83Unyqz
         KQhSyQBn4SZtnugN3iNGEawzKbZYyLeGl0h4FqX7vERSqrxJbCKrR0JGrDFCbo6hvDKQ
         hs1GgDq/5SguXRcTyRiqLNeRRaBSTfs6pIRMqwSLdZKdlseiOJ9GwKI5C54ZAVOdXOgO
         YqPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719320707; x=1719925507;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X2Q2Gc0/a/GptHFmAre/qf9ITPsCyFPIjbIlaZ07oI4=;
        b=v2YOY0zp8ToETDceTeFjg5brtduie16qiCDqHcmdm+dvATxy7czaqR0nv2CoMbkNfq
         u7bUZpKgviplEaYdnuXAKKUIOShin7ct6wdl/VXUdIhq+6FdqjLLpn5kh4UBX/+uVD83
         hoPbDzVyv7fIWvtmYMiH+w/SHk2B4mDeigmTv83sxH3yhkB64FiOqqWPohewyH6A2WZT
         0hatTW7HPNLPeaNNR5GRigmvFmN/ID00zlbhBE8PZ6ytOLFKnKj9XxmqgrD2T9KEBCUl
         tq1RSeOUjIA9TswPKD+9YNFnMHpv6L1tFSfIMxJ5mrR6hH6BIJ84tZmzl1WhFh80393V
         4jeQ==
X-Forwarded-Encrypted: i=1; AJvYcCUABXSgllj6n0infu4cSdS+AIBMK5ze0jNciumcDZVZF/AAkW9ydAP4MKb8NRy0tho9SqNYdh1dTfGCLNlsTCLBFJWQZRkNgXG/oOzd
X-Gm-Message-State: AOJu0YzOXEIkbtFLbDkh7WBCPayUj6lEsV0MDfQHjFKtvf9Uagf2zK/r
	vGAi3m0+DWlAwXL2IWlnNZj3DyCsufdOtf2G1Eysv3NP8OiTIuAmsURPmZ0VlXhitMxFB/Fmadr
	uOgoMa1JFgmvTcNUGAqnlqhf1fJTrob5oY5A5Qw==
X-Google-Smtp-Source: AGHT+IFC3/sRe+K2+xE3egh9WNqXv9h3HcoTjz7ltk3fQfPR6cTWYb5AKB3LAXvpah5wr9yVGhRQXlQI35aVkCXEo14=
X-Received: by 2002:a17:90b:154b:b0:2c3:48a2:6121 with SMTP id
 98e67ed59e1d1-2c8614ab762mr5500167a91.45.1719320706732; Tue, 25 Jun 2024
 06:05:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240624082011.4990-1-xuewen.yan@unisoc.com> <20240624082011.4990-2-xuewen.yan@unisoc.com>
In-Reply-To: <20240624082011.4990-2-xuewen.yan@unisoc.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Tue, 25 Jun 2024 15:04:55 +0200
Message-ID: <CAKfTPtB=Yk8Bp4sSanr4fCdyWA9PVROM+uiWsQSh+QjFpKb+Aw@mail.gmail.com>
Subject: Re: [PATCH V2 1/2] sched/fair: Prevent cpu_busy_time from exceeding actual_cpu_capacity
To: Xuewen Yan <xuewen.yan@unisoc.com>
Cc: dietmar.eggemann@arm.com, mingo@redhat.com, peterz@infradead.org, 
	juri.lelli@redhat.com, qyousef@layalina.io, rostedt@goodmis.org, 
	bsegall@google.com, mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com, 
	christian.loehle@arm.com, vincent.donnefort@arm.com, ke.wang@unisoc.com, 
	di.shen@unisoc.com, xuewen.yan94@gmail.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 24 Jun 2024 at 10:22, Xuewen Yan <xuewen.yan@unisoc.com> wrote:
>
> Commit 3e8c6c9aac42 ("sched/fair: Remove task_util from effective utilization in feec()")
> changed the PD's util from per-CPU to per-PD capping. But because
> the effective_cpu_util() would return a util which maybe bigger
> than the actual_cpu_capacity, this could cause the pd_busy_time
> calculation errors.

I'm still not convinced that this is an error. Your example used for v1 is :

The pd cpus are 4-7, and the arch_scale_capacity is 1024, and because
of cpufreq-limit, the cpu_actual_cap = 512.

Then the eenv->cpu_cap = 512, the eenv->pd_cap = 2048;
effective_cpu_util(4) = 1024;
effective_cpu_util(5) = 1024;
effective_cpu_util(6) = 256;
effective_cpu_util(7) = 0;

so env->pd_busy_time = 2304

Even if effective_cpu_util(4) = 1024; is above the current max compute
capacity of 512, this also means that activity of cpu4 will run twice
longer . If you cap effective_cpu_util(4) to 512 you miss the
information that it will run twice longer at the selected OPP. The
extreme case being:
effective_cpu_util(4) = 1024;
effective_cpu_util(5) = 1024;
effective_cpu_util(6) = 1024;
effective_cpu_util(7) = 1024;

in this case env->pd_busy_time = 4096

If we cap, we can't make any difference between the 2 cases

Do you have more details about the problem you are facing ?



> So clamp the cpu_busy_time with the eenv->cpu_cap, which is
> the actual_cpu_capacity.
>
> Fixes: 3e8c6c9aac42 ("sched/fair: Remove task_util from effective utilization in feec()")
> Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
> Tested-by: Christian Loehle <christian.loehle@arm.com>
> ---
> V2:
> - change commit message.
> - remove the eenv->pd_cap capping in eenv_pd_busy_time(). (Dietmar)
> - add Tested-by.
> ---
>  kernel/sched/fair.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 8a5b1ae0aa55..5ca6396ef0b7 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -7864,16 +7864,17 @@ static inline void eenv_pd_busy_time(struct energy_env *eenv,
>                                      struct cpumask *pd_cpus,
>                                      struct task_struct *p)
>  {
> -       unsigned long busy_time = 0;
>         int cpu;
>
> +       eenv->pd_busy_time = 0;
> +
>         for_each_cpu(cpu, pd_cpus) {
>                 unsigned long util = cpu_util(cpu, p, -1, 0);
>
> -               busy_time += effective_cpu_util(cpu, util, NULL, NULL);
> +               util = effective_cpu_util(cpu, util, NULL, NULL);
> +               util = min(eenv->cpu_cap, util);
> +               eenv->pd_busy_time += util;
>         }
> -
> -       eenv->pd_busy_time = min(eenv->pd_cap, busy_time);
>  }
>
>  /*
> --
> 2.25.1
>
>

