Return-Path: <linux-kernel+bounces-546278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98F81A4F8AF
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 09:23:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBC9D3A7D85
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 08:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AC8F1F584A;
	Wed,  5 Mar 2025 08:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gZitgGbq"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB8D1F5826
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 08:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741162933; cv=none; b=WdgNMNmdnOYjFpYnNWGpt/y/b4irreWRIJ7OjI41CMkWUoBHrl2EJcNbb6v5oIUuu1gb8/Tyo7YKGr4TSD2Jf2hY+QkrhEDKESi8gyP2OXS0n2QHab+6ppoLZ2bmlByvzapkAv+Sw9slz1SK6Bm0lAO6Et+02ytd0XfWkt2P6Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741162933; c=relaxed/simple;
	bh=7dbxBIp1KdSmrxY2YrczBEJIi2mdKiVw3dJRiuom3S4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y/OYgWfxSqk3290p8/nE/lNKwz0YMD/5IlRCL9CJ6gMwcZY6FabFVrdZNbps04JqbDRgHmZqzFi4/Y4kLbllDGRR6S0w33l+ltbsPhA8+yDcONHLDHL9/WX263NGOQ3Q8LKzc4mHNpdjO229pgU90zVSl7baU3ORYlMH+LQJyWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gZitgGbq; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-390ec449556so5299166f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 00:22:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741162928; x=1741767728; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7RMNh6sUr+MEi0nX1lz7f3n/Y4qaP5HXPTyxG0vSMbo=;
        b=gZitgGbqCD+a0EhD7Vdvxvq0JOtfBL7JfSL1RiYeivBdsJyUiQuB9DyaCZFRdRyLSg
         PMfp5xbZOqq3QSBowEpp0bRUusD0vGMFVqSlL32aijlMmlBJjfOYgNiSKGphLlHwb/tU
         4StCE0vvwJC9Ho1ty2UVJCrVo2CsgUle+MyiXfOh4OUhFJrbLUZA9jnopI0bluXqv2A/
         /LzyjcCvmdsC4zkNxjUBienoE/eJ68bGbbAUiDyFjoaEfDakejDP2aCmuJ51j+fXXLHT
         Rz5pzi2v5y3aQ/bXTWcPPw4BMN7IG9qVMfjBwpKqJrYOQC3Zn1y3BgGRu95aBxTWEmXt
         1R9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741162928; x=1741767728;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7RMNh6sUr+MEi0nX1lz7f3n/Y4qaP5HXPTyxG0vSMbo=;
        b=VkgY0D1I/HE7cQWPWOu3aTR3cZ2x3pTtK34x7XLN5o5b4F/z4HI/iicHJ462UfiZBg
         7c/U1FobmjlsGxTO4xyHOJseTwEZHrg/pBLFjYb3z/upzE6ecLNPAUY8bQn//VURTGpT
         3MYU/gsv+0ufwxRp0Ztw3sSwHiwhtWyncgqu2TYiVxjSVBgEzJrQUjOViFoSY75JE/GX
         fYu+UnhC3cHIBLi5B7sSWBTbgg8qdet/CRkSNqevw76BA1/6mQOwgyVDqSQ75lMkLXVp
         2QJKc+VbzodqNZ5twsALlpNhfm9eIe5GEeKzu3ySGfYlCDjo0D/sLub6UB23TbtAb34s
         rvvQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhWZk11dCjMb9hxYzYHmCf0gztZbr6WLHx5OGvEsX17eddHNH4xzukVeUci2o/+NOdSKsOqAMX32IYHuk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7lyf0MqNqyDbTHotuJEEqkvBJAj5AkNdIYMSBv7NQoAfr0+Su
	xpw9ck8bb4nhRIuo16iufIhvRil1gXLsCxU+sKuh4P3Uetrm/f77OV7/SXF8ncNnFd1JeWEU514
	r3r6dOS8dmFee2JQ/5XEZ1eHjRr4MWVQUHcqVXQ==
X-Gm-Gg: ASbGncujXads5IbPeBCt1moDVBgcdnf7Tlvul5NBFEYIgTKUSjxFiTzWcI9N7+46868
	VWhKY+JXITZVwbyBko9hCRKHeISVBFnBGXvf/UIKjqAkDj8lyvDUthYtdzkNolmoxssFr8B7txa
	ONdl1Fr7oPAdCvVwKdweKhjn4jwaAa0T91gNSpktOEzk3txuC1JYMRixg=
X-Google-Smtp-Source: AGHT+IFuIXbmhLu1A6V2C/og0vYQWo77sEyep3TN1K0LxyXzovDiav8k2aiku7uTfPX/HcYgYJyzaudNlt0YAeRhA14=
X-Received: by 2002:a05:6000:2cc:b0:391:13ef:1b35 with SMTP id
 ffacd0b85a97d-3911f757771mr1293184f8f.29.1741162927747; Wed, 05 Mar 2025
 00:22:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250304170007.245261-1-aboorvad@linux.ibm.com>
In-Reply-To: <20250304170007.245261-1-aboorvad@linux.ibm.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Wed, 5 Mar 2025 09:21:56 +0100
X-Gm-Features: AQ5f1Jon-wuJX4mx4VpRDNI6TfgENDmRlr7mSh0fUITpglImFdohiT9i1_nLJG0
Message-ID: <CAKfTPtCJKkwFeMKUrD3o224Nz4N+1qjtq0LvL945k9tJ8t8h-g@mail.gmail.com>
Subject: Re: [PATCH 1/1] sched/fair: Fix invalid pointer dereference in child_cfs_rq_on_list()
To: Aboorva Devarajan <aboorvad@linux.ibm.com>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	riel@surriel.com, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, odin@uged.al, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 4 Mar 2025 at 18:00, Aboorva Devarajan <aboorvad@linux.ibm.com> wrote:
>
> In child_cfs_rq_on_list(), leaf_cfs_rq_list.prev is expected to point to
> a valid cfs_rq->leaf_cfs_rq_list in the hierarchy. However, when accessed
> from the first node in a list, leaf_cfs_rq_list.prev can incorrectly point
> back to the list head (rq->leaf_cfs_rq_list) instead of another
> cfs_rq->leaf_cfs_rq_list.
>
> The function does not handle this case, leading to incorrect pointer
> calculations and unintended memory accesses, which can result in a kernel
> crash.
>
> A recent attempt to reorder fields in struct rq exposed this issue by
> modifying memory offsets and affecting how pointer computations are
> resolved. While the problem existed before, it was previously masked by
> specific field arrangement. The reordering caused erroneous pointer
> accesses, leading to a NULL dereference and a crash, as seen in the
> following trace:
>
> [    2.152852] Call Trace:
> [    2.152855] __update_blocked_fair+0x45c/0x6a0 (unreliable)
> [    2.152862] sched_balance_update_blocked_averages+0x11c/0x24c
> [    2.152869] sched_balance_softirq+0x60/0x9c
> [    2.152876] handle_softirqs+0x148/0x3b4
> [    2.152884] do_softirq_own_stack+0x40/0x54
> [    2.152891] __irq_exit_rcu+0x18c/0x1b4
> [    2.152897] irq_exit+0x20/0x38
> [    2.152903] timer_interrupt+0x174/0x30c
> [    2.152910] decrementer_common_virt+0x28c/0x290
> [    2.059873] systemd[1]: Hostname set to ...
> [    2.152682] BUG: Unable to handle kernel data access on read at 0x100000125
> [    2.152717] Faulting instruction address: 0xc0000000001c0270
> [    2.152724] Oops: Kernel access of bad area, sig: 7 [#1]
> ..
>
> To fix this, introduce a check to detect when prev points to the list head
> (&rq->leaf_cfs_rq_list). If this condition is met, return early to prevent
> the use of an invalid prev_cfs_rq.
>
> Fixes: fdaba61ef8a2 ("sched/fair: Ensure that the CFS parent is added after unthrottling")
> Signed-off-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
> ---
>  kernel/sched/fair.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 1c0ef435a7aa..a4daa7a9af0b 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4045,12 +4045,15 @@ static inline bool child_cfs_rq_on_list(struct cfs_rq *cfs_rq)
>  {
>         struct cfs_rq *prev_cfs_rq;
>         struct list_head *prev;
> +       struct rq *rq;
> +
> +       rq = rq_of(cfs_rq);
>
>         if (cfs_rq->on_list) {
>                 prev = cfs_rq->leaf_cfs_rq_list.prev;
> +               if (prev == &rq->leaf_cfs_rq_list)
> +                       return false;

what about the else case below , prev can also point to rq->leaf_cfs_rq_list

>         } else {
> -               struct rq *rq = rq_of(cfs_rq);
> -
>                 prev = rq->tmp_alone_branch;
>         }
>
> --
> 2.43.5
>

