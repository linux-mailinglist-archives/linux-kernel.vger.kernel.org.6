Return-Path: <linux-kernel+bounces-227851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E7A9915742
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 21:37:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B055E1F2168F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 19:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B499E1A01C6;
	Mon, 24 Jun 2024 19:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="w2bdg+pG"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D001E4A9
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 19:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719257848; cv=none; b=CVuvqtqGzZUyLTUzzJ1HSrW4knftHtYByucgnTtlU0f+K1e9ako5h0UekLLk1Ru9DnDi5r6qAxsgVbr/NsJJnJI7ym0o1IMkkvYwzbwrVX4sMsyNZgPVSvV3vuHUwfukBdsJyftnyeks3Yz+NHENAZoKJSa4qwth+EQefLZdmys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719257848; c=relaxed/simple;
	bh=ZdZPJy6218rNrvUBGo4Gd5B8gj5aiNVFAGuC7pf3gGU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e+osmiV+Gf+VvX1ski55LZ8BHEMgLgcvm/9vyw4EkRvEEnQ1M/1Apomb1pe8JmvuOuzrs83pr15PHECZ5LEXRc2Xrok6cr9LBsamKrL0K9MqjHW+q7pg66D9slp+0OQfb/86GoguauUuT6v7qgSseClB9dQlqk0Oz9wATcSFVzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=w2bdg+pG; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-57a16f4b8bfso76a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 12:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719257845; x=1719862645; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=C5omOsOb9VQoiAfUqh6SLtIWT4eydxDoSc5vvX1m5GA=;
        b=w2bdg+pGavcn//bZcunTU5+0I8wUlixPPtpB7+hBMGt1jgq1PlqBLMgqg2cWIn2/l+
         GFcb/OC5x6UTeCbnxRHVNj/zqDl8PEhgAowzUSuUT/hhqgVIPyyxEdioCJ4QrGS90hgx
         cPJhnZzzvX1h2r012xRDTUwrgOl4l/xuO/Apsqk/sKkyiDjKvpGKML/7xnkDjjy/mXED
         /EHiaCZijQjUSim1MrOrtLf0zi+0Plh96OaY8VeCQjALmDXVK6veohtev3U/vL+Nqp2o
         fempD+K5jcO8uQq+7CkrRjh5Etpq1ygv/ynNxCiQ4lLjvjwPBnmoO2ofaoqYBab1Dxye
         q9JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719257845; x=1719862645;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C5omOsOb9VQoiAfUqh6SLtIWT4eydxDoSc5vvX1m5GA=;
        b=se4Fv4eIHV02WABLH78nioRrJKn41VV3IH/lsMpb0Duwp47/PiEUpGDOwESKOf29NX
         GUY4pmGgIbZAE6tE60nthkpmHS/7LseFofYw2NptwislRLzKtZ0UDajNV+vEOFH/mzdH
         sJw8GO+mNnmk545G/p5ZM8qbcvgPrOE5FKj/H77NufMlNEBvFdsnpEBWKaOlCQ8GC+wg
         4oZBWZRxGHCfebwP08JsALOP2DmiTnWpCP/5lYFhEuhyJTsLlW6OvdGNiZb3PGA9qDT+
         XMiwjkrs1h7gj6WoTCwkc8WN+yPozR3XfJiCTQ0ZTB8gq/BfkocNrrJ6Ru8/cQkByCJE
         GGBg==
X-Gm-Message-State: AOJu0YwgssQ5YHykdC/72Iy0eBK0zT1rOQ2mQBZHvq8G2XPAurDY/wuS
	PYV92qHqIxzwcL4QEXwKoK0WpFvQLmTGJd+uho4Uk/EOrmZ4yaAuQQN3iOPap8Bb20aPAnwL6HS
	tegYdRlouWF2U+32PenHs3snvPR4cxdeUJlZd
X-Google-Smtp-Source: AGHT+IFQapbzbuQ9S4pDsYFv0LCzO8ZNY3pkwLHuFCWs4PiDlJwfIM7BRGmA4+/u2XWcbKg9gvoyFJOZCItP4eLhpkY=
X-Received: by 2002:a05:6402:50d1:b0:57c:b712:47b5 with SMTP id
 4fb4d7f45d1cf-57dcde35e68mr32794a12.4.1719257844465; Mon, 24 Jun 2024
 12:37:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240624073900.10343-1-dtcccc@linux.alibaba.com>
In-Reply-To: <20240624073900.10343-1-dtcccc@linux.alibaba.com>
From: Josh Don <joshdon@google.com>
Date: Mon, 24 Jun 2024 12:37:11 -0700
Message-ID: <CABk29Nuro7TDTimsvAHPev+7xYNKAQ=tZgfFk3An3YTa2WEazQ@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: Make SCHED_IDLE se be preempted in strict hierarchy
To: Tianchen Ding <dtcccc@linux.alibaba.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Daniel Bristot de Oliveira <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>
Content-Type: text/plain; charset="UTF-8"

Hi Tianchen,

Thanks for these fixes.

>  #endif /* CONFIG_FAIR_GROUP_SCHED */
> @@ -8382,16 +8382,7 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
>         if (test_tsk_need_resched(curr))
>                 return;
>
> -       /* Idle tasks are by definition preempted by non-idle tasks. */
> -       if (unlikely(task_has_idle_policy(curr)) &&
> -           likely(!task_has_idle_policy(p)))
> -               goto preempt;
> -
> -       /*
> -        * Batch and idle tasks do not preempt non-idle tasks (their preemption
> -        * is driven by the tick):
> -        */
> -       if (unlikely(p->policy != SCHED_NORMAL) || !sched_feat(WAKEUP_PREEMPTION))
> +       if (!sched_feat(WAKEUP_PREEMPTION))
>                 return;
>
>         find_matching_se(&se, &pse);
> @@ -8408,6 +8399,12 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
>                 goto preempt;
>         if (cse_is_idle != pse_is_idle)
>                 return;

nit: add newline

> +       /*
> +        * Batch tasks do not preempt non-idle tasks (their preemption
> +        * is driven by the tick):
> +        */
> +       if (unlikely(pse == &p->se && p->policy == SCHED_BATCH))
> +               return;

I think it is worth extending that comment to explain why we don't
also check policy for SCHED_IDLE here (since the cse_is_idle checks
above boil down to checking for task idle policy in this special case
where pse is a task entity). The comment above the pse_is_idle checks
only talks about idle group preemption, when here we're relying on it
for idle task preemption.

>
>         cfs_rq = cfs_rq_of(se);
>         update_curr(cfs_rq);
> --
> 2.39.3
>

Reviewed-by: Josh Don <joshdon@google.com>

