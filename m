Return-Path: <linux-kernel+bounces-525696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70BBDA3F345
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 12:49:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 553C5189E8FC
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 11:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 706FB2080F5;
	Fri, 21 Feb 2025 11:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QL7g4p2u"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CEDD1E9B01
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 11:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740138557; cv=none; b=XiARt0Nr0nctTWObnFooHS7t7h+gFvEdR6r1urofKgfYjGIPsObh0HrGV6baPJY0Vu1XVqcpqWpYc5TvNeCyTiRBQmxeypwD1JWc2/v1AC67DPCUtEkUsEH2spBgRSOoztmhf+NBYgZCuQg08cfVur0PLbFEBfK2a89vl0ikWhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740138557; c=relaxed/simple;
	bh=jNBio+kesG4CeOba152o0mqGcDEOsNgDASlGieo71cE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fcUpbFpBC6vbfc8D3Ag1ilPPEvDDhh6O7J6VOT1uDSFEsYgrCYv6SudajXbSsYiTLA0MhO9ZyxFBCvrEC6DzAH0OfC9gk8NAUBf7Tw3b6lpsx0vVnpk2a0k6JxxM2oEvOyAMfM8uaaDWelPwA+6NiUCNGY6bZiQ4eKDqZvaHGQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QL7g4p2u; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-abbda4349e9so295035066b.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 03:49:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740138554; x=1740743354; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wbukk/Pm24QQteCSVgGhTCAMcpPz29Bwr41h3vS7nfo=;
        b=QL7g4p2uvP/e9Me6LYkQxgByVgJLgj+Joy+IMOJEthOxXES6qayrpEo4hFO4N04ZvB
         RfVsKa/q6qpVkIzm3Lkldofpfj1Tk2mJdFpHcHhKC+/JSLbMZ8u06NJCgh72hUXjgqQt
         AlN5UG59MrpLGRtQE9Wp1mOBKFajqUvhPNJABHki8T+T6m4GfOKanLKZG8mM7a0Pvfcj
         KAVrCcG8vL5XkfWyrKArDIj45o1EE2GJ2OVJJrqD0Ug8pf8bZ0dyWgzvv4koqaOnMLAC
         /sQGmh3zUPhqPlIZRmSa2r8rOY2hhfB/GQOpyeR1Ej9ZFaBT7mHvKTfh0nYvhK/Lgy3p
         7V3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740138554; x=1740743354;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wbukk/Pm24QQteCSVgGhTCAMcpPz29Bwr41h3vS7nfo=;
        b=NeL86gf4vj/bB5alUyyVFGItlVrTx28IU9cr0azAw7UFeOWZXPs2K+vM3Lw90d/osI
         0ifBZQdr6r/2VNJnykX+LhA9mvEyEnCQa/lV6Mm67aaTap9y4l/52a3v70HmaNH+brQn
         1VqaJTphIL/Vf63ytv0S6JUdJvjDsWIJ5wEt1v5GCqyKK5g/A/JUuCBeekINlsuuZww5
         btwUcCEP3MWsfQ0XevnfyMpJE2NCbEIBm+GpqlvUTgr58PFv1RvQLL158Kjsfm80qZG5
         tTqipw36F89g2DBcC2TXJ0Kn15ZBDWjvkkUSkTRXqKPcHKy1gxSUobS/XMOLrbBAajmz
         g9cQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3ZSUlB5tDwCzKRv6HmWov1BITnHserasvuND5At/+JyYgGIAJovfRo4CkGitycDy37uLX2HXABi2Ools=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6mTF9M/CmZejWGApV03ykP/itO6GgCsSNWC6PqY8WXtxYS/9p
	YkGz0tQKOKpcrPn/NqHpQDhgNqoi/iUATd/eOgh5Sn58rX6PmravYp2UMY7lzJ3h9SBRRCL22EB
	HJfWwAquTo+72+TMwkl5prQnYks5D8EkSqlxUAQ==
X-Gm-Gg: ASbGncuKoyaCoLg/2aWawNfe8XNN1AS4Bll5y1jcHDssabqaSPW6+G5Rda5J+LiyRkq
	x7lt+taALfjjFkoVq39XYMZ6P1uLkXCGdQYUTEqJbtn1sMZZJOb3zeEx6ivP0benSprj6lwfxRY
	iNWTs0nd5aUe4lzZLGvzTRxdbn7dyoXZUXvhDV
X-Google-Smtp-Source: AGHT+IH7Ua9WP/nyp7I6m7893TC+gYsnO4OnmMQ58MJvTtn2GrBKJWu1mq2wF8cPMOjRdmzDw3KDMziEvmaBkjodJ4c=
X-Received: by 2002:a17:907:7818:b0:abb:1c99:5e18 with SMTP id
 a640c23a62f3a-abc0da212f6mr183663866b.25.1740138554223; Fri, 21 Feb 2025
 03:49:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250221111226.64455-1-wuyun.abel@bytedance.com> <20250221111226.64455-3-wuyun.abel@bytedance.com>
In-Reply-To: <20250221111226.64455-3-wuyun.abel@bytedance.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Fri, 21 Feb 2025 12:49:02 +0100
X-Gm-Features: AWEUYZlcorIU1M5XXOPeT-itz2NUsYqh3XsZO0hdnLg7xLlRwet3tvUAIo1M9X4
Message-ID: <CAKfTPtBzsX6GKZP_NGTONrkp96qx9uOHr0+XG7tC6ELy4tbHBg@mail.gmail.com>
Subject: Re: [PATCH 2/2] sched/fair: Fix premature check of WAKEUP_PREEMPTION
To: Abel Wu <wuyun.abel@bytedance.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Josh Don <joshdon@google.com>, 
	Tianchen Ding <dtcccc@linux.alibaba.com>, 
	"open list:SCHEDULER" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 21 Feb 2025 at 12:12, Abel Wu <wuyun.abel@bytedance.com> wrote:
>
> Idle tasks are by definition preempted by non-idle tasks whether feat
> WAKEUP_PREEMPTION is enabled or not. This isn't true any longer since

I don't think it's true, only "sched_idle never preempts others" is
always true but sched_feat(WAKEUP_PREEMPTION) is mainly there for
debug purpose so if WAKEUP_PREEMPTION is false then nobody preempts
others at wakeup, idle, batch or normal


> commit faa42d29419d ("sched/fair: Make SCHED_IDLE entity be preempted in strict hierarchy")
> which gives priority to WAKEUP_PREEMPTION, so when !FAIR_GROUP_SCHED,
> SCHED_IDLE tasks do not preempt by non-idle tasks.
>
> Fixes: faa42d29419d ("sched/fair: Make SCHED_IDLE entity be preempted in strict hierarchy")
> Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
> ---
>  kernel/sched/fair.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 4340178f29b7..de9a2689de9c 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -8768,9 +8768,6 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
>         if (test_tsk_need_resched(rq->curr))
>                 return;
>
> -       if (!sched_feat(WAKEUP_PREEMPTION))
> -               return;
> -
>         find_matching_se(&se, &pse);
>         WARN_ON_ONCE(!pse);
>
> @@ -8783,6 +8780,9 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
>         if (cse_is_idle && !pse_is_idle)
>                 goto preempt;
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

