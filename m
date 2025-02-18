Return-Path: <linux-kernel+bounces-519973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A054CA3A431
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 18:26:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DA2A3B541E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 17:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DD4126FA75;
	Tue, 18 Feb 2025 17:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="epyh0LjK"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19EA22B5B1
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 17:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739899469; cv=none; b=rPnlSxt6kZCQJNgT7mxMuEs/I5c59Cuvboc6xgAgWO9a53UfvPqmqoiLBQV0D8gk8uBoFdnT28y6eeXpuSjehDieuu1yUS0dEs5QI47J3ie37Ly+qLsnDFeLbQ5+/3q/1pJPHuwQWqlY5jW7km1lejW56Xz12ls95bbt9/OkLXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739899469; c=relaxed/simple;
	bh=UYvQ8cvzgrlMWxSCtJWwAGwYeCBMOSkjcsDeBAxaR/E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=adEyyckNMg0XymJPk0IuaiPv6FLaqPrF3ZLlT54gtBXbysRew7Ey4HsSBxiua3j2ryAhG1gzoXTYOBBy7UfZSDhpaOLaTni+oPItR9sLDJ9kad2NWgNRo2FqPEHanH1i9QAb01zJk/fiPzBh58GWCx9Hj9DlICzw0uHzHtMz33s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=epyh0LjK; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5e0813bd105so1154562a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 09:24:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739899466; x=1740504266; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VghWuWywqAWhAz04LgNs+5Ws2lIBBuFmKC9pV4TuUwI=;
        b=epyh0LjKpikjGkNVCx8FSkHuykWm9lYR7xP67DJLrpe863edKc9oyp++c5XAc5ggoH
         TOITvrL+rQkexqo8SZY7Y30eD2gmXtOrA2M0KyGCDlhTiLZpHC+bi23nPHMvRGIRaVTO
         Y6C5zpP4c4qc/B7paVOrMdwbDksS2BAa+3wb5yIZadu7fdVoS9tXlkbWQWgeYcAtYcsH
         z+Hsbg/SFDmps+bsK9QqGu7Si80wN5JJxuDEyeykkTZZoIkAB/GaObHuR2LQn4G/50U0
         Kw9tSeWKAAkri/SaPuwnT81lgoxLxGgBCOhV2+TxSPVqGJ4iedr/War0rkXFVCpLyn1s
         CpZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739899466; x=1740504266;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VghWuWywqAWhAz04LgNs+5Ws2lIBBuFmKC9pV4TuUwI=;
        b=PNOENhvjh+2PALXg4oRtM8jT2TrtadTPsw4hWfT4DyMSB2LqTxQEEmelWspygxnLNQ
         d8rWpv0kzlupJkXeF+Np/FMo793wIZjcjR4rHBU2RHKHgshgIql/QQBos5+P4i3PR70G
         /7enhQoHPOgnd9bMicD+6S33mvOztfNyI9OPWvgj8ReUqexA5QMFUr5rq06Sn8XAP/KK
         BTvEjcom00Vx/DSrZVKuzi1cbH6CL2DQfWIawR753WDG51hZhkIQAhDDWSJucpcXKeXC
         A/PtAh7XXFSIphY6/tGVR69hWcqFwcy1W9gKyGDHj4E1DdEOuKVEU+2Kz+4S3+SJExPt
         XZhg==
X-Forwarded-Encrypted: i=1; AJvYcCViYteHAKgyx9aiatIYlYPC/vF5lTNaUVJqzXDzAEHPFXbOGIOcUZUQv283qHiz2wVnwcGanIxuHbjSMoI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKmP7sXepbUw/RFM8Xl1DTlPr5Mzm+tzxVErdcVwkxhPkYXtzL
	aAa+Y54J1fmmxV0FCqrOIUOyY7PzI6sk+8m8L8VR6V1A1QHhay1N1CPdcn/vmdRyFTMSpw1nmp0
	706In6MlUtN2zWLoUDMnMu8lw4Dy9pVmDAlhHVQ==
X-Gm-Gg: ASbGncvw6126etH55RVgUqy3KSg3A18Gqqe6Ohz9u9K5zJfO5vJ7nFpF1ct4Aic+JcC
	84UwwkOZVEhlttTKkpmGgVyt+QTkkZSxQZDpVoixqNBlcuPHw4samMB3p3BqcNrHZlyFPierbCH
	wdEPjz8EKUQwDDf8IsC1O5inJIMw==
X-Google-Smtp-Source: AGHT+IG98JAowTNmMZuNx99TAV3DImdVKvxGbGe4eFPRPRPAiOuc5I8JKeXz+Z29HXt4EvfYqeLWR3gP1HYFtSbgLfo=
X-Received: by 2002:a05:6402:3548:b0:5d0:b51c:8479 with SMTP id
 4fb4d7f45d1cf-5e0360816b9mr12380826a12.10.1739899466239; Tue, 18 Feb 2025
 09:24:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250213091554.2593-1-xuewen.yan@unisoc.com> <20250213091554.2593-2-xuewen.yan@unisoc.com>
In-Reply-To: <20250213091554.2593-2-xuewen.yan@unisoc.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Tue, 18 Feb 2025 18:24:14 +0100
X-Gm-Features: AWEUYZk6nb8mmS0CDI1NkQh-hvpOdV9fwGtoHB-66szy4c-x5QxhAJf-AOlpeVc
Message-ID: <CAKfTPtAgsn0=_LjD1HovuN__fXanOOrOawatx5EhUmMn3KDYig@mail.gmail.com>
Subject: Re: [PATCH 2/2] sched/uclamp: Add uclamp_is_used() check before
 enable it
To: Xuewen Yan <xuewen.yan@unisoc.com>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, vschneid@redhat.com, qyousef@layalina.io, ke.wang@unisoc.com, 
	di.shen@unisoc.com, xuewen.yan94@gmail.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 13 Feb 2025 at 10:18, Xuewen Yan <xuewen.yan@unisoc.com> wrote:
>
> Because the static_branch_enable() would get the cpus_read_lock(),
> and sometimes users may frequently set the uclamp value of tasks,
> and the uclamp_validate() would call the static_branch_enable()
> frequently, so add the uclamp_is_used() check to prevent calling
> the cpus_read_lock() frequently.

You should extended this to all calls to
static_branch_enable(&sched_uclamp_used) which are cgroups and system
wide uclamp
Android likes to play with task's uclamp but the same could happen with others

>
> Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
> ---
>  kernel/sched/syscalls.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
> index 456d339be98f..d718fddadb03 100644
> --- a/kernel/sched/syscalls.c
> +++ b/kernel/sched/syscalls.c
> @@ -368,7 +368,8 @@ static int uclamp_validate(struct task_struct *p,
>          * blocking operation which obviously cannot be done while holding
>          * scheduler locks.
>          */
> -       static_branch_enable(&sched_uclamp_used);
> +       if (!uclamp_is_used())
> +               static_branch_enable(&sched_uclamp_used);

may be use a helper function to encapsulate this and use it everywhere
we enable sched_uclamp_used

>
>         return 0;
>  }
> --
> 2.25.1
>

