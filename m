Return-Path: <linux-kernel+bounces-538693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E20A6A49BFE
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 15:27:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A1431895561
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 14:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0924426F441;
	Fri, 28 Feb 2025 14:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sZa9/kdy"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE4926B971
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 14:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740752795; cv=none; b=O9eFTvsTdCgLRy4VtpfCvf5YmFVf6Rc/1kocjBxT7UAgEyuPdv644BQlj+dGow0jFIvdNOjzWrPGmXFhDTg0tomRbnb81gWB9aC8SIsgbemP8fN/lIaJZ1fRb9ytuyF2HX19txnx9jA4lSRYR6L5lD2F/b0ezYBPJ8ZyMjMuMPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740752795; c=relaxed/simple;
	bh=QiVgr12VKMtVHMXo95Y/WWsy9+BtALIite9AAmXbl0U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L3Un2Uvmk953uHDte/55gdRyugX6P014oneFpjIikc1QeNvCBzsXhP0fN4oqtXnt3h6f+psuSZ5jbWvLnHMOIx3Xjz7evoVLHo1SwQxzSNrtagJFc9PDdVogOljrquu91pTCNK3t5Ma4uo/wmuUqUOQ00x02Hvqas+G/IbxVbzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sZa9/kdy; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-abb81285d33so415643766b.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 06:26:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740752792; x=1741357592; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1sj7oeXN6IU9KA60eTFPxHexEba4DjrVreuMdd1h5k0=;
        b=sZa9/kdyH7jcX1ipi37lLfgf+/yorEbvg0NyCyBzXNOjKWMeCeEMwCqT4r8J4w8IiK
         +UtfjCVZa5+pU3IR6JkDBV8w37m2T6KlswKLyQYFG4cTHTKggjibBWOLT1gKtNVOfewj
         KtfR0dAoykq+f8ip7dNGNFgOg48hOShP/Ycr9GYdjTTsejxxq4NgKJ9s0FRYxnOSt0QX
         5Ztyn3UQf8Y4DeRuXVgsGAwe4Jq8wLjmlIMHtbCPthRDB2wsHKBlTasJPdKCS2rOFNJx
         aGPgHmHftasT/uUNS0XJza61u8e2FuCu9dmtXMhz9KWdYAtN34wM7C+KMoJXAGJgDG7f
         G4JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740752792; x=1741357592;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1sj7oeXN6IU9KA60eTFPxHexEba4DjrVreuMdd1h5k0=;
        b=KzBgJn+9z6AroJLctFRJ7CJhwxryJ/U3qUhHQAE9irDAPrT2jZhvMPiASQYr2UpmKY
         Wvk6VkZnekCaJ/D9+p6+W2OuaS89E3w5ZzZseiuPSlW10xs+o/+JIL4MbH2PuxY/VWRy
         DnZTfuCaMKOnjAKPIJSnZJIHGP29zdYodOEbCeb2BTbW+f7vgPQBKYpZVLCcXZxaYOUT
         oXe/CEYKo15iL88rH9Sw3vxjhZCmBe27O5+1Bg43BfOspArEEeW+Zzhg2EkFcoPGczpd
         GDXOyP5rfY1RI8nyPpf5hfFX7rtisvVBkTvDq1n/TlfILgmyqtRkGru9oHwHcNLlBVN9
         mFMw==
X-Forwarded-Encrypted: i=1; AJvYcCXN13LvCAD8T8u68EELrTZkA5tBhvc/lbuwmbugQqPg2xqMJxdJnS2GP3Mif1UrLugkTdZ99oisn8ytmec=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGrftRZAbI/zEfrKnMWSnBhG12as9iGDiO9G5f1GtIyBtQL1y8
	NfOSkIGoWahegRz9EGkxCRaoCbKuIXuutXSxhqEwHiQQt007SWo+m4Y1Fk3yYlM9HQQQNGRqsLs
	MyCR080d2FOt96kEKemh/tyFIoX1+w0yFPsW8zA==
X-Gm-Gg: ASbGncvXH6ie5PKGaKAU88IoMpAIluwVz+jySIiLoeglM2xWSSNBaSz56SiB3FCqaMu
	nVwTZGE6EFKolmFhGSye+9iA1ZBY7+PaRltOo/9CVMbDp3b9whbgOlDqCz3WGGNmvecxlKdYDYW
	M8cd1RzLTaRnNV/hMOUn7oBlqYg+bwdxhV9WE=
X-Google-Smtp-Source: AGHT+IEfCNROkmE2B1E3KH+AR0WDxYZpuQcVfKtBmduYwkaqDo6zFudBPcYolKp6egeiETEl/QPq7G6DMTePfbqlOlk=
X-Received: by 2002:a17:907:8689:b0:abf:491:31d2 with SMTP id
 a640c23a62f3a-abf25fcfc59mr341762266b.22.1740752791933; Fri, 28 Feb 2025
 06:26:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250227085815.18131-1-wuyun.abel@bytedance.com> <20250227085815.18131-3-wuyun.abel@bytedance.com>
In-Reply-To: <20250227085815.18131-3-wuyun.abel@bytedance.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Fri, 28 Feb 2025 15:26:20 +0100
X-Gm-Features: AQ5f1JoCM1I5_52lUKHHWvEK74NmvJf9w4A8WLgypoEaZWpvbBwIeqzzV6rzmI4
Message-ID: <CAKfTPtBj2xhVg1BA5q6cC57TFGVBtgz6bbKrWGkjStSUKdxpgg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] sched/fair: Fix premature check of WAKEUP_PREEMPTION
To: Abel Wu <wuyun.abel@bytedance.com>
Cc: Madadi Vineeth Reddy <vineethr@linux.ibm.com>, Phil Auld <pauld@redhat.com>, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Josh Don <joshdon@google.com>, 
	Tianchen Ding <dtcccc@linux.alibaba.com>, 
	"open list:SCHEDULER" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 27 Feb 2025 at 09:58, Abel Wu <wuyun.abel@bytedance.com> wrote:
>
> The commit 6bc912b71b6f ("sched: SCHED_OTHER vs SCHED_IDLE isolation")
> defines the behavior of SCHED_IDLE as following:
>
>  - no SCHED_IDLE buddies
>  - never let SCHED_IDLE preempt on wakeup
>  - always preempt SCHED_IDLE on wakeup
>  - limit SLEEPER fairness for SCHED_IDLE
>
> and the 3rd rule is broken if !WAKEUP_PREEMPTION due to recently merged
> commit faa42d29419d ("sched/fair: Make SCHED_IDLE entity be preempted in strict hierarchy")
>
> Although WAKEUP_PREEMPTION is mainly there for debug purpose to provide
> a way to check whether a performance degrade of certain workload is due
> to overscheduling or not, it is still kind of weird that we treat sched-
> idle cpus as idle but don't let the non-idle tasks preempt the sched-idle
> cpus in debug mode (!WAKEUP_PREEMPTION).
>
> Fix it by strictly following the aforementioned rules.
>
> Fixes: faa42d29419d ("sched/fair: Make SCHED_IDLE entity be preempted in strict hierarchy")
> Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>

WAKEUP_PREEMPTION seems to be still used so

Acked-by: Vincent Guittot <vincent.guittot@linaro.org>

> ---
>  kernel/sched/fair.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index aaa9822e9562..a7eeb72d57aa 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -8785,9 +8785,6 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
>         if (test_tsk_need_resched(rq->curr))
>                 return;
>
> -       if (!sched_feat(WAKEUP_PREEMPTION))
> -               return;
> -
>         find_matching_se(&se, &pse);
>         WARN_ON_ONCE(!pse);
>
> @@ -8806,6 +8803,9 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
>                 goto preempt;
>         }
>
> +       if (!sched_feat(WAKEUP_PREEMPTION))
> +               return;
> +
>         /*
>          * IDLE entities do not preempt others.
>          */
> --
> 2.37.3
>

