Return-Path: <linux-kernel+bounces-226937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BC5F914610
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 11:19:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCCAC1C22E91
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 09:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCE4F1304B1;
	Mon, 24 Jun 2024 09:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cfFkHVim"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6BF1130492
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 09:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719220753; cv=none; b=K26a08Cf/QhtCD0dfvdBu08bWA9fK6aHL8AR7GPfpckXMbxkRF5ejI1A29gwnyfUWOlW2EQMg4LpvJaKVgrYmHqo279A1qUyJo+jGIp/66QTDHprSAS5SX5He9QhDP/0UmWsgwy3VZtnInKIFYdlL7svQQnnAxJV4FHxvwwL21I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719220753; c=relaxed/simple;
	bh=RT+AW8+PBzwZ+a+aKMlzdwFsNmTcsFuiW6jf5CSOX1Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O8jxCuHcRCg5BsLxueomM1NNmVikXVmfZgrRzwMO9K2RfZ2g6dZTCLZHM+4pTVn5g0ytHI3CiXKVhbwDGgvVGYOVi+0Ke0TYi8/gpODcBG110dQhvOl/7aTCqdreE4bcys/+nSBzSjzHiJkyhoU4SMhhpd/tANYlfu8j69KNSpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cfFkHVim; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2c7a6da20f2so3203686a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 02:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719220751; x=1719825551; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=A9SAQofWuUxGYnDfKTZ/7Ul2x5gYkswxQPvSCxcY1I4=;
        b=cfFkHVimwwDSTIE6upabqWy5cYAN48QcADPMM+mOq6xSTPf4b+0SwDEDzfAWHoVY5z
         6G5KbhetMD3nqWuqTvNnXMAEqvjuvLr1VMFhhrHs9meZwMkioY/bmDcPJHpjW74BcdiM
         v2n/l+hI7kQf8qCmduE1F/S+KM8yQ0KDjP2unT68oaX0X3dR6A555rbhj/uYwO54fNKU
         JrMB4gqsiC6Sac4aAoKVvonc3YNYnfTVjPcgwUY2WUiGKPJ+AsZFDWVCa4mvL1Iyk11+
         lXc+dmbWA2KlwUuA539Rum3g4loWjlgzoakNHopvDOm6Da+qjijbBSwDqrqfFn3QR3dq
         Ov8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719220751; x=1719825551;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A9SAQofWuUxGYnDfKTZ/7Ul2x5gYkswxQPvSCxcY1I4=;
        b=VcVVa0hr+QdWRDnnGTgdUV1aEXRuG2/oIuAMJdJNedCgChrWMSdkYC+POMUPJ6OM8p
         B4LN68rjYkuXkW8llcmgTbMMZ3aH+H1WIR8dcHsqT7LAA+XFiVxFeIOxqxg3DhDefJAd
         68eJWTi/C2XwggQN0WUnq4A0NufO81dIehEy+qDrNmg9fEdd8lal0Mw6WC16B88fZuOp
         uljyOW3Q01A5QSAR7N2A6c88mQuD5hquYwLvTFwmyxXcCspLYKpWv8P6uWkKGLYlKXgX
         kQk1oH5f5i1SYWfj1SzIwNFouFYYz5cERrQFQHyltp/8uDz7PodzlqpcCy29kAD9JuHL
         T2rA==
X-Forwarded-Encrypted: i=1; AJvYcCXWzkbmFHQwrxmxMos88Eml8h2B4Syy3iuZGtsfuoyrdndWj6+zOJpzy/ciGGH/VNmNjFlxp7v+GuYq+SDZdziCXWv5+r/bKNtsnI42
X-Gm-Message-State: AOJu0YxecI4FgBQhtmLnqvqMCQj/cocf6TmHHCyBxChtr7bustoXXBGN
	makztGDGfzp/D0byo539RmV/Y5ab9SR+DO/X82MlbXisK9VN4mUGD82gggyzaSJ+mD2YvakvmJY
	vzxmI6XA1Zal5vLPHkxbEacymC9yuqb6L68cqGA==
X-Google-Smtp-Source: AGHT+IHwY6Epu4+xXObpFiFyK5Aeibk2jkaeeAS3wPiqxAkf1TPx6zG2E6kP02YGVThf8+awPWGAmn3tVvQkxHypbto=
X-Received: by 2002:a17:90a:43c3:b0:2c4:e4a3:b83c with SMTP id
 98e67ed59e1d1-2c8504c81ffmr3511932a91.2.1719220750885; Mon, 24 Jun 2024
 02:19:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240620214450.316280-1-joshdon@google.com>
In-Reply-To: <20240620214450.316280-1-joshdon@google.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Mon, 24 Jun 2024 11:18:59 +0200
Message-ID: <CAKfTPtDDSzLi7PEJkBqepx9cRgmbBKy2ZXJuT0h62e3RkQBoYw@mail.gmail.com>
Subject: Re: [PATCH] Revert "sched/fair: Make sure to try to detach at least
 one movable task"
To: Josh Don <joshdon@google.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Daniel Bristot de Oliveira <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 20 Jun 2024 at 23:45, Josh Don <joshdon@google.com> wrote:
>
> This reverts commit b0defa7ae03ecf91b8bfd10ede430cff12fcbd06.
>
> b0defa7ae03ec changed the load balancing logic to ignore env.max_loop if
> all tasks examined to that point were pinned. The goal of the patch was
> to make it more likely to be able to detach a task buried in a long list
> of pinned tasks. However, this has the unfortunate side effect of
> creating an O(n) iteration in detach_tasks(), as we now must fully
> iterate every task on a cpu if all or most are pinned. Since this load
> balance code is done with rq lock held, and often in softirq context, it
> is very easy to trigger hard lockups. We observed such hard lockups with
> a user who affined O(10k) threads to a single cpu.
>
> When I discussed this with Vincent he initially suggested that we keep
> the limit on the number of tasks to detach, but increase the number of
> tasks we can search. However, after some back and forth on the mailing
> list, he recommended we instead revert the original patch, as it seems
> likely no one was actually getting hit by the original issue.
>

Maybe add a
Fixes: b0defa7ae03e ("sched/fair: Make sure to try to detach at least
one movable task")

> Signed-off-by: Josh Don <joshdon@google.com>

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

> ---
>  kernel/sched/fair.c | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 34fe6e9490c2..a5416798702b 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -9043,12 +9043,8 @@ static int detach_tasks(struct lb_env *env)
>                         break;
>
>                 env->loop++;
> -               /*
> -                * We've more or less seen every task there is, call it quits
> -                * unless we haven't found any movable task yet.
> -                */
> -               if (env->loop > env->loop_max &&
> -                   !(env->flags & LBF_ALL_PINNED))
> +               /* We've more or less seen every task there is, call it quits */
> +               if (env->loop > env->loop_max)
>                         break;
>
>                 /* take a breather every nr_migrate tasks */
> @@ -11328,9 +11324,7 @@ static int load_balance(int this_cpu, struct rq *this_rq,
>
>                 if (env.flags & LBF_NEED_BREAK) {
>                         env.flags &= ~LBF_NEED_BREAK;
> -                       /* Stop if we tried all running tasks */
> -                       if (env.loop < busiest->nr_running)
> -                               goto more_balance;
> +                       goto more_balance;
>                 }
>
>                 /*
> --
> 2.45.2.741.gdbec12cfda-goog
>

