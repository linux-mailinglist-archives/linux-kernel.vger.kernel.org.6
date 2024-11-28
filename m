Return-Path: <linux-kernel+bounces-424062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C9FB09DB02F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 01:12:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC224B21C1E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 00:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46E72139E;
	Thu, 28 Nov 2024 00:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Pk2Y8Kkt"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF41A322B
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 00:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732752741; cv=none; b=B6xe4CDBTCQ1Rjp35HaD/IJBw1USYmxlnmoCe5v2OisIWnH9cd8tWd5VD0sya71O4FVeUYN3oMFey7ohDicBdEVs94TPnK50BPALCw3NW4+MwODsIYot4XvWD+MJIm3YOwAG1/GmMkPEAhgrATCrVHU+qcyZUiCalxZqS0S25V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732752741; c=relaxed/simple;
	bh=1wBlTdR2M7PQZzwGVnXRiZjvMutu2geYjTbhQm3S5p0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fH4QKeiKKX4nVjE9Embf11T4cCb0x9L5yiTwn6PxN0uHEOei44wabRLdz/vmkdf8nXolmHPTJcLFnSOSMdrNoso5YhRlX/GX/g6X086Gm1qAt4cTlakeZbaF/Bk9NEqHs1z+immGm3CquO5JP6SbIk85D/9TH/q0Pt80ycOBd6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Pk2Y8Kkt; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5cfa90e04c2so302791a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 16:12:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732752738; x=1733357538; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c9ZvzJNeYF8D1+sk6RDoHEwKn57vL3CbCcxJHULX100=;
        b=Pk2Y8Kktt01kn8Ac1Q5v2nS7a4kMUIQrX8w14CCQuwWOc2rY8vi/K5hjQ6RCvx4FvY
         jgWGrAqeeVSLoLs5uXSgQm009bF9WaPecxxmDCE1HVzhaj/JamSVJYLweuDzMRQIwi4b
         AkS2QOrm0xWQ2m2k9ryi7VJBKPC83zaewxjX8sCecxa/Z0LAuMO3Rm4f7xh2p0Gl5/AI
         4Ja72BqsjuzhAq27iJFEPsk/ZGV8greflwaUpGGYr0mohM/00we5evmB5IP50k2A+YV/
         mgotQWsK2XBROnrchsiQ0TKg+mn62xtIaFOjAoKjWZX3FCJZ1un9YHeEfX9y39mzZAou
         PShg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732752738; x=1733357538;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c9ZvzJNeYF8D1+sk6RDoHEwKn57vL3CbCcxJHULX100=;
        b=fYsygIN5QL8d6Un7jDAKaQELEYZKB4pQhClDSRI/s0P1/UHKYdkJDpNqgbwSIvA+9x
         J7d22YpLPof0Jk69RrxOUwXVSDctVPh1mFLktOJVFhEVeJmjbrc9Sfj1FnbHUmyTRKmE
         TwSUAjlytFU2GWZDjt7pFDxRwYhX79AtowRJa3Fguw8RN78TBdC3nFr/SzjDptW5ZDKN
         qzjYdjSuoyIIfTpqT36RuwfHlj7e5N1j4zR2NQWYTmrI5IRc73832YdnzRXvKqlOaczO
         CkoqGePYAFLc3WwMhUdJfB4UMol+NAvLPcAJqWe1Whov4J0FFbdd1ES1Qpojt57hDsxc
         tAgQ==
X-Forwarded-Encrypted: i=1; AJvYcCXE4QubfXtM4OhPyeLdMXVQCuOPxwiezkw0utAy7A8VXbsWac8xKdlfS2hyDs4UAr49l+Ec294zaZZL7ck=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywo9BB4Dzqt596tKi7BqvpAAtHtwOIs9M6cINalKE+ILi0IFRH/
	KtZ27cENghTtk72yI3+k9Vx1J1Iur56J5/1rp5L/uW2El6EuArIevYU5/ioa/hiF3h7dXKfGBiX
	fx3An/thcCr89moD/Ft6udGpgBH7Wn8nJtYw=
X-Gm-Gg: ASbGncujZCo+i3+K4FeJ+6Q3IEy9yqWU6jz3p2037DqjcnnbdxfQF/q0mjCBLRhwQJd
	5ftozhsSwOg8BHSzr7IMFtxSLfNNcU4OsFul3yxQbONdU1cu7peCqa8/X+juK
X-Google-Smtp-Source: AGHT+IFDvXejfnYS4jVUBD7b6/+H5tmvWvBKsZkBFNTLvhj9XZlL7z6XdC4VtMxsDl7Zx6hCMzSMxCHZyAu63mLmSMI=
X-Received: by 2002:a05:6402:5243:b0:5d0:225b:f4e4 with SMTP id
 4fb4d7f45d1cf-5d080c5cdaamr3633749a12.29.1732752738002; Wed, 27 Nov 2024
 16:12:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240820163512.1096301-1-qyousef@layalina.io> <20240820163512.1096301-12-qyousef@layalina.io>
In-Reply-To: <20240820163512.1096301-12-qyousef@layalina.io>
From: John Stultz <jstultz@google.com>
Date: Wed, 27 Nov 2024 16:12:06 -0800
Message-ID: <CANDhNCpbtzP0FXq4tmia45Bkoem3mgMVoAKHCLfvDL-5_T5sLg@mail.gmail.com>
Subject: Re: [RFC PATCH 11/16] sched/qos: Add rampup multiplier QoS
To: Qais Yousef <qyousef@layalina.io>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Vincent Guittot <vincent.guittot@linaro.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 20, 2024 at 9:36=E2=80=AFAM Qais Yousef <qyousef@layalina.io> w=
rote:
>
> Bursty tasks are hard to predict. To use resources efficiently, the
> system would like to be exact as much as possible. But this poses
> a challenge for these bursty tasks that need to get access to more
> resources quickly.
>
> The new SCHED_QOS_RAMPUP_MULTIPLIER allows userspace to do that. As the
> name implies, it only helps them to transition to a higher performance
> state when they get _busier_. That is perfectly periodic tasks by
> definition are not going through a transition and will run at a constant
> performance level. It is the tasks that need to transition from one
> periodic state to another periodic state that is at a higher level that
> this rampup_multiplier will help with. It also slows down the ewma decay
> of util_est which should help those bursty tasks to keep their faster
> rampup.
>
> This should work complimentary with uclamp. uclamp tells the system
> about min and max perf requirements which can be applied immediately.
>
> rampup_multiplier is about reactiveness of the task to change.
> Specifically to a change for a higher performance level. The task might
> necessary need to have a min perf requirements, but it can have sudden
> burst of changes that require higher perf level and it needs the system
> to provide this faster.
>
> TODO: update the sched_qos docs
>
> Signed-off-by: Qais Yousef <qyousef@layalina.io>
> ---
>  include/linux/sched.h      |  7 ++++
>  include/uapi/linux/sched.h |  2 ++
>  kernel/sched/core.c        | 66 ++++++++++++++++++++++++++++++++++++++
>  kernel/sched/fair.c        |  6 ++--
>  kernel/sched/syscalls.c    | 38 ++++++++++++++++++++--
>  5 files changed, 115 insertions(+), 4 deletions(-)
>
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 2e8c5a9ffa76..a30ee43a25fb 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -404,6 +404,11 @@ struct sched_info {
>  #endif /* CONFIG_SCHED_INFO */
>  };
>
> +struct sched_qos {
> +       DECLARE_BITMAP(user_defined, SCHED_QOS_MAX);
> +       unsigned int rampup_multiplier;
> +};
> +
>  /*
>   * Integer metrics need fixed point arithmetic, e.g., sched/fair
>   * has a few: load, load_avg, util_avg, freq, and capacity.
> @@ -882,6 +887,8 @@ struct task_struct {
>
>         struct sched_info               sched_info;
>
> +       struct sched_qos                sched_qos;
> +
>         struct list_head                tasks;
>  #ifdef CONFIG_SMP
>         struct plist_node               pushable_tasks;
> diff --git a/include/uapi/linux/sched.h b/include/uapi/linux/sched.h
> index 67ef99f64ddc..0baba91ba5b8 100644
> --- a/include/uapi/linux/sched.h
> +++ b/include/uapi/linux/sched.h
> @@ -104,6 +104,8 @@ struct clone_args {
>  };
>
>  enum sched_qos_type {
> +       SCHED_QOS_RAMPUP_MULTIPLIER,
> +       SCHED_QOS_MAX,
>  };
>  #endif
...
> +static void __setscheduler_sched_qos(struct task_struct *p,
> +                                    const struct sched_attr *attr)
> +{
> +       switch (attr->sched_qos_type) {
> +       case SCHED_QOS_RAMPUP_MULTIPLIER:
> +               set_bit(SCHED_QOS_RAMPUP_MULTIPLIER, p->sched_qos.user_de=
fined);
> +               p->sched_qos.rampup_multiplier =3D attr->sched_qos_value;
> +       default:
> +               break;
> +       }
> +}
> +
>  /*
>   * Allow unprivileged RT tasks to decrease priority.
>   * Only issue a capable test if needed and only once to avoid an audit
...
> @@ -799,7 +831,9 @@ int __sched_setscheduler(struct task_struct *p,
>                 __setscheduler_params(p, attr);
>                 __setscheduler_prio(p, newprio);
>         }
> +
>         __setscheduler_uclamp(p, attr);
> +       __setscheduler_sched_qos(p, attr);
>

Hey Qais,
  Started tinkering a bit more with this patch series and found
unexpectedly a number of tasks were getting their rampup_multiplier
value set to zero.

It looks like the issue is that the SCHED_QOS_RAMPUP_MULTIPLIER enum
value is 0, so the switch (attr->sched_qos_type) always catches the
uninitialized/unset value during any sched_setscheduler()call, and
further the call to __setscheduler_sched_qos() isn't protected by a
(attr->sched_flags & SCHED_FLAG_QOS) check as is done for
sched_qos_validate() so we always end up falling into it and setting
the rampup_multiplier.

The easiest fix is probably just to have a SCHED_QOS_NONE base value
in the sched_qos_type enum, but we can also add checks on sched_flags
& SCHED_FLAG_QOS. Or do you have another idea?

thanks
-john

