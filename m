Return-Path: <linux-kernel+bounces-407073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7949C9C683C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 05:51:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 070C1B229C8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 04:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D66316D9AA;
	Wed, 13 Nov 2024 04:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PGfu7bkX"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196F9433CE
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 04:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731473490; cv=none; b=KqemweuSPLzfid4k/ANUbV68oNd/2R2QRQH8gHmDl+qrw1O5bmxkbNo6UAlhzOL+UE0KLj8pycyQKUu1b+WhjF94ZORI7uehWk5pugBJiLk+SxA6Jp7taTzpqgYCEN+2ijHDzndvu5gwkdaowID+pPKm3aRv3nrisyPG264PIjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731473490; c=relaxed/simple;
	bh=l0c4oi/lRVU0xacNIBmUnJ8MqVpO06c6BsKZLfNXWao=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AliUnOfdnw8pS7dVqo/R9XVq385HyHSeu6emeCnxjzAZBAA3RoRYBZJG1n0kDJYC+wkGZQiuHSDVo7UFruX6RKBhURGt7ZuY98JToRFQKSy0ORuf3qR4ZNY0H2GpPkNrU8/w/C/Rd/zdbac5YIXI39wUJaaJyFArpMssSGczXko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PGfu7bkX; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a9a0ef5179dso1088783466b.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 20:51:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731473486; x=1732078286; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UpLXALlzKEchFhHx055mxHWuvzO7Fxzz+fkVfPWjj3A=;
        b=PGfu7bkXeWaIMV60tbxMOvwEAUB2V78xNw9kRILVc5yDJ24G4Ojtykvk1B3R1c5e5R
         JBvj8KOn3nJ0C7QKggGHkoAJbqfUVHORkM3CZ0iXYhZEX0AIhExU80EjCLH0J0xn+beC
         mAG/NJCsQJzychAonFf3hq2fluTWQ5PO0fr2TS3rO5yMXz5SVY9GPPoJiD4rAiPsQ96N
         Fa1U3DBEyXqo9Za96VOyWPzYiEtHb75q8MDHq8ynmlB54NNLCND8hNYyMq3NfIEQEvUX
         ejfasMLCr4ZFsy7T5ia2q3g3h35ULUueYPfwuG21h7pQLRAHOPMpTTnK0LzmU3phrfb9
         MUjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731473486; x=1732078286;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UpLXALlzKEchFhHx055mxHWuvzO7Fxzz+fkVfPWjj3A=;
        b=t/HJRXh9RWmhaNfi3xFSMkgL+X1NyatJZMBFZbZdS77xJBdZgAePM18iAx+U5jxns1
         bHa8IVX3MFlFjHdbCCfvxnqfpCFsaKBZZ5WDVP0UvcaTsCQMW7wuKfRTIHIOXnXMAIxH
         WBIuX48HZkpKp5kbuTBebHCwwSk8Nld3euveUmq8/EafNsBmAoSHEGWe94AfpaL7ztwX
         Mxi3HVZcat8/kVRRp+KkYknj7uNw366MpWb9aMCCSAU+1HBj5H66/sbMuhwda2soUbpI
         iBkAtblJQ4zCOjflihd+C6RhCQdAtQyDK1ABLU2NtsiLMQhVpuEtCLxPM43LMYUtLlKD
         Nscw==
X-Forwarded-Encrypted: i=1; AJvYcCWGYbPSp7jQNuC9C2IASSEBnSY0LlWBJhhbB+dBxfzxxWDMZpgSUqfgJ4IqeALWWtUw19qvJDXeH8VSQb8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxnlSQIXJiqMp4KBs6U8I6VNEOZdX/Vg/3zReBw6VjadBkwvM/
	fV55CxfRIEwGjQ1qHxdEg3QAj+LpijybZ22svV/nBfhYnyasfrLdx7F06FHG6qAyRz5YWRO6ydh
	eM+UZxA9RklTdNZhIaZ7UgzSg7TUNV7nvUPs=
X-Google-Smtp-Source: AGHT+IEuMJK/b6RMPc2Z5S8NSxqpfpKwrEjaoecAxmYJnqCdahkftPa9sU7FbYEMc13TpQneZMMHWPiTo/Zlopl5vkM=
X-Received: by 2002:a17:906:6a20:b0:a99:529d:81ae with SMTP id
 a640c23a62f3a-a9ef00239c8mr1839737466b.55.1731473486274; Tue, 12 Nov 2024
 20:51:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240820163512.1096301-1-qyousef@layalina.io> <20240820163512.1096301-6-qyousef@layalina.io>
In-Reply-To: <20240820163512.1096301-6-qyousef@layalina.io>
From: John Stultz <jstultz@google.com>
Date: Tue, 12 Nov 2024 20:51:15 -0800
Message-ID: <CANDhNCrU3uuA137Udvh+RfC9ELhc7scjR=Oacosbyw+b68AR3Q@mail.gmail.com>
Subject: Re: [RFC PATCH 05/16] sched: cpufreq: Remove magic 1.25 headroom from sugov_apply_dvfs_headroom()
To: Qais Yousef <qyousef@layalina.io>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Vincent Guittot <vincent.guittot@linaro.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 20, 2024 at 9:35=E2=80=AFAM Qais Yousef <qyousef@layalina.io> w=
rote:
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_sche=
dutil.c
> index 575df3599813..303b0ab227e7 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -187,13 +187,28 @@ static unsigned int get_next_freq(struct sugov_poli=
cy *sg_policy,
>   * to run at adequate performance point.
>   *
>   * This function provides enough headroom to provide adequate performanc=
e
> - * assuming the CPU continues to be busy.
> + * assuming the CPU continues to be busy. This headroom is based on the
> + * dvfs_update_delay of the cpufreq governor or min(curr.se.slice, TICK_=
US),
> + * whichever is higher.
>   *
> - * At the moment it is a constant multiplication with 1.25.
> + * XXX: Should we provide headroom when the util is decaying?
>   */
> -static inline unsigned long sugov_apply_dvfs_headroom(unsigned long util=
)
> +static inline unsigned long sugov_apply_dvfs_headroom(unsigned long util=
,  int cpu)
>  {
> -       return util + (util >> 2);
> +       struct rq *rq =3D cpu_rq(cpu);
> +       u64 delay;
> +
> +       /*
> +        * What is the possible worst case scenario for updating util_avg=
, ctx
> +        * switch or TICK?
> +        */
> +       if (rq->cfs.h_nr_running > 1)
> +               delay =3D min(rq->curr->se.slice/1000, TICK_USEC);

Nit: this fails to build on 32bit due to the u64 division.

Need something like:
       if (rq->cfs.h_nr_running > 1) {
               u64 slice =3D rq->curr->se.slice;

               do_div(slice, 1000);
               delay =3D min(slice, TICK_USEC);
       } else
...

thanks
-john

