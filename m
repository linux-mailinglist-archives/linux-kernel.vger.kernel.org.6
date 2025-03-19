Return-Path: <linux-kernel+bounces-567642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C412A6887F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 10:46:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0166119C571F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 09:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AFB4257AF8;
	Wed, 19 Mar 2025 09:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wsiM85jw"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67E825F78E
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 09:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742376905; cv=none; b=AfWa2/MBiPWTHj//qH8eDPhsJxG16OBBN11aBqQkbaroHxy7XWYkLKyx3KMb3wZtBjYP71i8ua2CDmG3AGCTTvIo2iDKOCZQ6s+J0GELDObATrbLVre0sX7s+RaErv8sSCBTZMn1Js7Jn1YGkpq4HPj5Nqdk/0qNK3CKZCbYeMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742376905; c=relaxed/simple;
	bh=JV2OdPz1WiI+QL4VUylyn5FzQGpYETj9MHxeFZ4p4bc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uJ5VS2yzbEvRvqAT8dOCJ4vcEt/ZDCw4Y/AEpecKBRa9GItfDLKWXcgCw3tqqpXn6HXweXPKI+1hjL+PakRWzJA94f4+OEgSDyhdy8M6LdTOIutLBv0FURNp/2BYM1lKVU04uQan8iLaKQ1SsK1068oJedYYxGUvDRsDejGZiwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wsiM85jw; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5e66407963fso2805131a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 02:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742376902; x=1742981702; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Rmn2UOnqffmm0/krQIQoMdbT3AZ3yRTrlx8eCPNqDFs=;
        b=wsiM85jwZUs0zdnXjCV77KHvTLAj6H4kuAUsBVrY8IVVfhu4H9yWNDhC8q2opvOH/f
         XGOeSiIcueCBpRfPWVmBnLIrZ2RgiOf141KpX6np+rTWaPJGCMt/0EckutaF1DqkQvTY
         DTJj0oSYHVLKn2JviQSxRx/vWDX3i20FAhl43pVUPAHqrLV5siC7LfPQmZD33gocfGHN
         Mg+x5tIcCOlJ7haFx/c7OiZqAK7klr9bH++mo6FF9fkwIoXgdkr2hSx8cmb+oNOCWTr5
         TK0Gp99tXPyShNKBlfsAfrjhcDyTLgeLhgtB8SPRDNXNiWyyzCRDEdQPlEyefzSHMVeS
         A8Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742376902; x=1742981702;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rmn2UOnqffmm0/krQIQoMdbT3AZ3yRTrlx8eCPNqDFs=;
        b=fSbrgqXHsbtJmcxW1mFO01ZgkDz2kdCimnDQp3jEdDIZm3dGb4PTSXlQ7qc7UFDV9J
         oP7dyxhTBydM7/vz2sXsyvpyX1aYtTEUFP5hgT7/rfrK7rYOuGug6dR9D0FF3dYu+z7p
         AB3Nre4TccTNw/A3cFjo1pmg7eKX/GdYE6zUB4RQObTE39vnoP6a+IgKlvvNUsuVcEhG
         l5MjcRvDsHVj53Xm6q3tq6Kw7k3ht7rNw9tco9Du8xrB2XMUxIaHkhjqsMDFbLSDV07D
         BWvYHXbbTpM7TAYWFtDp+MVhLkSEVHhZftc06X/3p1Ss3UJr+Lf1fbpZIuUE6kHVuCHC
         nB6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXzz351QIusPILXokJPtcHiKae7kpaVIfHkjq7Tu7J739IE7l1TYDB29qSBYgg6ssywfRNPv04qq1vO6/c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9WyCob8ziZubZ262MfkTvEyx6gLABJn4H5LijEu3xtqK0qDNU
	2SVqhxxMpsqMMASQLlNyihklKHm8MujNZGC8DBy1552UFdwl1IJqkxHm8dbE/FlazOr2NhUow4x
	mnNbmSnl7RobE1WM1k++6XSa1JAp64oxBc+xMZg==
X-Gm-Gg: ASbGncsFXFsS2SEbAKyErWrHqSdVUOtKySxKXr083cykKt7SYnwP6yKrySjcclmd+mn
	ClsO60Wgrgqk7w9Qc42BP3uyxqi83/1DzRoaFxIvldHkOcWO0h8C96GRhuq4KQ+1NMd9S8+FT75
	57JMRDU5LtXb/iRCDx1jhYwY4M
X-Google-Smtp-Source: AGHT+IEJB9yuQUTqwi4isGrxD5QyjQIW1ss1czUgdn55fd/AENDuhHLVVJIo8pq1i0qLz31Bl1W7vj1byd1jiefeGNg=
X-Received: by 2002:a05:6402:354a:b0:5de:39fd:b2f5 with SMTP id
 4fb4d7f45d1cf-5eb80d05ea6mr2082776a12.1.1742376901674; Wed, 19 Mar 2025
 02:35:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250303105241.17251-1-xuewen.yan@unisoc.com> <20250303105241.17251-2-xuewen.yan@unisoc.com>
In-Reply-To: <20250303105241.17251-2-xuewen.yan@unisoc.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Wed, 19 Mar 2025 10:34:49 +0100
X-Gm-Features: AQ5f1Jr6RHA5TwlCEclQP4eh8ML-EvaEIJ8LDshhlG_AP2lcQROcu8uebNCWdTg
Message-ID: <CAKfTPtC=QYe4uZuK87G3GG6zi+f3r214hUnK9=K1mNv59FsYFA@mail.gmail.com>
Subject: Re: [RFC PATCH V2 1/3] sched/fair: Fixup-wake_up_sync-vs-DELAYED_DEQUEUE
To: Xuewen Yan <xuewen.yan@unisoc.com>
Cc: peterz@infradead.org, mingo@redhat.com, juri.lelli@redhat.com, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, vschneid@redhat.com, linux-kernel@vger.kernel.org, 
	ke.wang@unisoc.com, di.shen@unisoc.com, xuewen.yan94@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 3 Mar 2025 at 11:56, Xuewen Yan <xuewen.yan@unisoc.com> wrote:
>
> Delayed dequeued feature keeps a sleeping task enqueued until its
> lag has elapsed. As a result, it stays also visible in rq->nr_running.
> So when in wake_affine_idle(), we should use the real running-tasks
> in rq to check whether we should place the wake-up task to
> current cpu.
> On the other hand, add a helper function to return the nr-delayed.
>
> Fixes: 152e11f6df29 ("sched/fair: Implement delayed dequeue")
> Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

> ---
> V2:
> - add helper function (Vincent)
> ---
>  kernel/sched/fair.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 1c0ef435a7aa..a354f29c4f6f 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -7181,6 +7181,11 @@ static bool dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>         return true;
>  }
>
> +static inline unsigned int cfs_h_nr_delayed(struct rq *rq)
> +{
> +       return (rq->cfs.h_nr_queued - rq->cfs.h_nr_runnable);
> +}
> +
>  #ifdef CONFIG_SMP
>
>  /* Working cpumask for: sched_balance_rq(), sched_balance_newidle(). */
> @@ -7342,8 +7347,12 @@ wake_affine_idle(int this_cpu, int prev_cpu, int sync)
>         if (available_idle_cpu(this_cpu) && cpus_share_cache(this_cpu, prev_cpu))
>                 return available_idle_cpu(prev_cpu) ? prev_cpu : this_cpu;
>
> -       if (sync && cpu_rq(this_cpu)->nr_running == 1)
> -               return this_cpu;
> +       if (sync) {
> +               struct rq *rq = cpu_rq(this_cpu);
> +
> +               if ((rq->nr_running - cfs_h_nr_delayed(rq)) == 1)
> +                       return this_cpu;
> +       }
>
>         if (available_idle_cpu(prev_cpu))
>                 return prev_cpu;
> --
> 2.25.1
>

