Return-Path: <linux-kernel+bounces-564400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1EF0A65418
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 15:45:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A76E3A8290
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 14:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16135245020;
	Mon, 17 Mar 2025 14:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TJo62byc"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C509B24500E
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 14:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742222667; cv=none; b=EkUBpa0x6aH0MpkEr9MlQ1C7Nd/DA+K+QQS9uzCK+O0c28vfkv5dxiQ+IBZcRcaZZAEJYFjy/I4+vLdyfgHk4Rvpf78VMroD+XhKwjo1KpsfJrulSY6HSx55pF8+As06cdEmldX4AlNjMTQWoSEWP/bwfl7ZhC1iA/njNkKeEOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742222667; c=relaxed/simple;
	bh=D67MiZM1OlWyGEYaDHpsix7GTNizwJ+ySW6CALHaVmU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RfenQLmEg/L54dt17+F70j9glloR1sAqcjzzCZz+hVikA/Ino2ifXIbAv/EJarVoFMMIZmh39FtGuUzrW78xFDWnja4taV6UchxRnT4jFFndEIPIWuMYjTHPmaOtHPewjtm6PMRXl/quZs/d5SbVzPyai6o7+SK9R+XqNicRIzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TJo62byc; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5498c742661so4977555e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 07:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742222663; x=1742827463; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dzjKCnFEpJfO2LYKHlFZEmxFc8nJD2d/7SZvtFuh6b4=;
        b=TJo62byczl9/TbAouXdb5S+oAzJrccfzioHZkX+dDgDBcyBLewjHJqwQbpKk6PAVzI
         SSuD1nk5Duzz8sswqj0BHziQOd8QrksVdxRrvpl2MctrF+6dQQb02a1zmQYS45xybAki
         NhH06pbLf+bwq1CLovtmvLoxTVYgdaEDXdu1Pyaoq22ozHgvhhffddcHl7zwSCkrbVGM
         tLxh4aseO6SXJiOhH0odBQADu4y/jwIekMYyDjVr+JpInK9/BePHDCEvZo1JG7QvycYr
         MBX/MoA2KDxvLJlnKmLkFa7uSAtcd1sye+TJbVJyle3zEDe93Vfw+Dt8ox9ZmNQrgmXW
         6Kfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742222663; x=1742827463;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dzjKCnFEpJfO2LYKHlFZEmxFc8nJD2d/7SZvtFuh6b4=;
        b=wksgdZOvX4ODFYCGrEH+tOp7IYXbJuZgPJLznjeC65/D/vHwWXPDB5jsEBTuqSEGfu
         GbX0J/7Xo02WvNrUccbWEIyUoPyjOht3bpozZgHtFVnxLrArS6llprNcdOqCotmgcyCS
         DzXD0WxouXShSoEVHUfQf0qLqCJgTUnAeleVOra01gCuUfzISlCcYmJHQK6nI9q8xYEF
         IuIpPf9zxcpBJmK3dEpLID7bdJw4Pt8VUAnVKVajkc/Z8F9QdrD9ryWuMV8k8hu+APed
         GtLqU2ko9tRPlbICVi/Chz+FbK1DXYnnFXVZ/0y6Z5w0caxcd8pAJoiYUJrRQbZIVpdG
         D8aw==
X-Gm-Message-State: AOJu0Yy5O/y4Ic1FwtTrhAwsd+/RdbEJYZyvLkQ3FmqHEXBwWA4U8sa7
	q4sS3axA/a0pU7OCjRO4zFQSHy6MluVyprOuchIgwB5CxD76rjkB37ATFGFY3GQc3R1tobCIWru
	Ou16un5N1b5yoVZJugp4vUV+sYVwJdFpg1lg=
X-Gm-Gg: ASbGncsqX/uoGDElmSSvOKIPi9HAhYuctbCqYgD8lrIrDqRP223MKRJv0ivAh7UE/5G
	SUuyXSPvCYqW266u7UaRREpPN+XV1e2v/x9NnAX/N7nP2hP85fPi7jGOehlf1tXgkd2eQqR73dy
	c+praprakZ23cpzW8cF8yq7IY=
X-Google-Smtp-Source: AGHT+IGXmPBxAfzK1vAQqYi5qJGkOzahtFskXNaem/FfxmVKi4cIAUI9hXEGgzm20bHHp6Ho2fBvhrk4YQdGeHndWRE=
X-Received: by 2002:a05:6512:b01:b0:545:2b24:c711 with SMTP id
 2adb3069b0e04-54a03b91a85mr20493e87.21.1742222663323; Mon, 17 Mar 2025
 07:44:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250312221147.1865364-1-jstultz@google.com> <20250312221147.1865364-2-jstultz@google.com>
 <20250317143347.GE36386@noisy.programming.kicks-ass.net>
In-Reply-To: <20250317143347.GE36386@noisy.programming.kicks-ass.net>
From: John Stultz <jstultz@google.com>
Date: Mon, 17 Mar 2025 15:44:11 +0100
X-Gm-Features: AQ5f1JqqLS47AYHEy7gOQ44yJBo-KqU3S46iXeAXICju9pqhBo32qh7aCOYGSJ8
Message-ID: <CANDhNCrCmNVQjAy2pHY_K3VYR=f_44fqPRnAP-mr16yUhk8rPw@mail.gmail.com>
Subject: Re: [RFC PATCH v15 1/7] sched: Add CONFIG_SCHED_PROXY_EXEC & boot
 argument to enable/disable
To: Peter Zijlstra <peterz@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@redhat.com>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Valentin Schneider <vschneid@redhat.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
	Zimuzo Ezeozue <zezeozue@google.com>, Mel Gorman <mgorman@suse.de>, Will Deacon <will@kernel.org>, 
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Metin Kaya <Metin.Kaya@arm.com>, 
	Xuewen Yan <xuewen.yan94@gmail.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Suleiman Souhlal <suleiman@google.com>, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 17, 2025 at 3:33=E2=80=AFPM Peter Zijlstra <peterz@infradead.or=
g> wrote:
> On Wed, Mar 12, 2025 at 03:11:31PM -0700, John Stultz wrote:
>
> > diff --git a/init/Kconfig b/init/Kconfig
> > index d0d021b3fa3b3..b989ddc27444e 100644
> > --- a/init/Kconfig
> > +++ b/init/Kconfig
> > @@ -875,6 +875,16 @@ config UCLAMP_BUCKETS_COUNT
> >
> >         If in doubt, use the default value.
> >
> > +config SCHED_PROXY_EXEC
> > +     bool "Proxy Execution"
> > +     default n
> > +     # Avoid some build failures w/ PREEMPT_RT until it can be fixed
> > +     depends on !PREEMPT_RT
>         depends on !SPM && !SCHED_CLASS_EXT
>
> for now, right?

Did you mean SMP there?  SMP is supported. Even with same rq proxying,
it just blocks the task and lets it sleep if the owner is on another
rq.

!SCHED_CLASS_EXT might be something to add, but mostly because the
SCHED_CLASS_EXT code probably doesn't have a way to understand the
split contexts yet.

I'll dig a bit more there.

Thanks so much for the feedback! Really appreciate it!
-john

