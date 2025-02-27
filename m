Return-Path: <linux-kernel+bounces-535396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18ADAA471FB
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 03:12:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7B911882C4B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 02:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9F031487F6;
	Thu, 27 Feb 2025 02:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jCTeBojF"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7B31F94A
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 02:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740622359; cv=none; b=LvHbmxzyWTDpaXtKU7yS9VI0luL7MbL//GYNt1U8Jmatk0f7s1pTcwCNIZtjzGJ00Gc7mZ8G654KqluHHp0G4/pDYNyCLth+8a0Uq+ETY1LeYc1lMHJfb7lrJWsVJtciJWYZTe/yMuM4uSrvE1bn2vlsx0slw5PhI92B6w6yw5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740622359; c=relaxed/simple;
	bh=HH12gKKrFaZm7wzH3pCpMF8j418F10mNd/vReR3oceA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AUqqWZAgPNsh2FrphxKo4oyRITx8vDMBuh0OZTGZbtR7T7bFQnEZi/HJwd+PfvfqnTTzISDvTj0oJsIB8eWdU4kGMxZU1YbjBgh93H8etP7NptpWI6Q7xe6ckhgx0mP8yS1L6BvrLPucCs/oiMoowPAnnP9PmD+PsPqlSgwgx/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jCTeBojF; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-abec925a135so62409166b.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 18:12:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740622352; x=1741227152; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1lYamqTJH3BifzDRaKsEz7OpShDOh2zvdQFoGbniJMw=;
        b=jCTeBojFN9+cGWTabOAq3imZW2IRhC/OyJ3dPu2C16B3ggoyrjOwN0/THkHToKTX5i
         HjpBoUp3cjxLHsK3z2v5JJtqGN7gOeCUd5lmY7iS6vke1T4Ul83Nrc4r2kkWPv5o1TY5
         lyP2rwMU5Ik/zVNr1V+G8e0s0MxSE3szj6rTNwOgFUMtzqePNWEAEoVc+tpaVRtB8go4
         WMjfm8EZn+Vd2Oczgqp3d33MhZPw/7QeT+TTWTSKJm7ImKeOvnf3Wa4JBBUqgfanr9xe
         QiJWmFyf9lBLujYJuRZCIvDev4iPTVsC78T0A3A13RFh3824tQt9gk4929oMnt8TKyJ4
         ZG3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740622352; x=1741227152;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1lYamqTJH3BifzDRaKsEz7OpShDOh2zvdQFoGbniJMw=;
        b=Dvz6Nj/opW3UzHdPYGekZa0pivO9+04RDq+lnAqNZnliRSY57HvAdJ/6RMX8xySMTo
         xiv2THBw+BtudHhXIJaEFF917ZOgk2mIutqSnjdR24Q84PUQYxk234ZZxKWVB7Cuq92e
         A26eeidM/xkoMssOH0AoYps3P9bQK2tNboMZdqAHpIhiisY/IOG/D+DN6SsRXyhCRIaF
         fB5tGU1WN8aOcNyrQwpPJ8KRG/wOi+shgDPLj9aC6qQMHCjPedQZu4HaLzgwOZQodoad
         H6hlDIQiOleIZBW7H+x96LaWrIIDDE6vKTYg1EWDM61lzV/s0/UnH+jeibOKjM8srRkj
         i7hw==
X-Forwarded-Encrypted: i=1; AJvYcCWsvjUaZ2avSOOMSROAaSQ4A7KSST2QspQYfTwTpGltGuuV6ghNg1CvUjnpCbxv8arXkpnV0gdJZD3NO+I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbukWehUMp0GxJaS2aha0DhLCkJ7hFiDYTKzNwVep/QJZEfGdG
	2BZ2Ur5bq1+uZi3l3gzkEVYphNjnG8fjLZszgWBkj4BiyYJHHHkdguyZ1hAlUt03cWizhy1pB2Y
	2UfJ8MDJgIeNZUw1//fG9JZLVkRI=
X-Gm-Gg: ASbGncvJAUO3RQ8npWvvwZx6F62vvOMIrFRxX6lAQTuPTx5hKRuuIZfYVpxKETza+cL
	cUDrfLbBHfK8JJB+F9A6zUgMBDxs/pVVrLnk6KNk21ocWo4JMc3khXglU8IYx0MTNMlAH48hM86
	ydylCKROtx
X-Google-Smtp-Source: AGHT+IFkHZSpYroN6cAmPhG3UCeeGVWNROZZKfh0zdQH3C4WFSL1wcOHs7i4JLX0V3aaI37ZWD02nRP4LcR3MEzabH0=
X-Received: by 2002:a17:907:7d93:b0:ab3:60eb:f8b6 with SMTP id
 a640c23a62f3a-abeeef8c479mr717479066b.56.1740622352432; Wed, 26 Feb 2025
 18:12:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250226114301.4900-1-xuewen.yan@unisoc.com> <7e3b656e-ea65-4441-b08f-062eb0501355@arm.com>
In-Reply-To: <7e3b656e-ea65-4441-b08f-062eb0501355@arm.com>
From: Xuewen Yan <xuewen.yan94@gmail.com>
Date: Thu, 27 Feb 2025 10:12:21 +0800
X-Gm-Features: AQ5f1JrFQOEZkPM7BBl-9S8b4_e-acv_f4WjVFGk1nMmXcWiGyVhL4SUdAOSBr4
Message-ID: <CAB8ipk-CcirMttnxDUj_VGfgd3Z9SgeZf+jmLTEV7YBabvVP3w@mail.gmail.com>
Subject: Re: [RFC PATCH] sched/fair: Prevent from cpufreq not being updated
 when delayed-task is iowait
To: Christian Loehle <christian.loehle@arm.com>
Cc: Xuewen Yan <xuewen.yan@unisoc.com>, peterz@infradead.org, mingo@redhat.com, 
	juri.lelli@redhat.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com, 
	Hongyan Xia <Hongyan.Xia2@arm.com>, Pierre Gondois <pierre.gondois@arm.com>, 
	Luis Machado <luis.machado@arm.com>, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, vschneid@redhat.com, ke.wang@unisoc.com, di.shen@unisoc.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2025 at 8:08=E2=80=AFPM Christian Loehle
<christian.loehle@arm.com> wrote:
>
> On 2/26/25 11:43, Xuewen Yan wrote:
> > Because the sched-delayed task maybe in io-wait state,
> > so we should place the requeue_delayed_entity() after the
> > cpufreq_update_util(), to prevent not boosting iowait cpufreq
> > before return.
> >
> > Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
> > ---
> >  kernel/sched/fair.c | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 2d6d5582c3e9..040674734128 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -6931,11 +6931,6 @@ enqueue_task_fair(struct rq *rq, struct task_str=
uct *p, int flags)
> >       if (!(p->se.sched_delayed && (task_on_rq_migrating(p) || (flags &=
 ENQUEUE_RESTORE))))
> >               util_est_enqueue(&rq->cfs, p);
> >
> > -     if (flags & ENQUEUE_DELAYED) {
> > -             requeue_delayed_entity(se);
> > -             return;
> > -     }
> > -
> >       /*
> >        * If in_iowait is set, the code below may not trigger any cpufre=
q
> >        * utilization updates, so do it here explicitly with the IOWAIT =
flag
> > @@ -6944,6 +6939,11 @@ enqueue_task_fair(struct rq *rq, struct task_str=
uct *p, int flags)
> >       if (p->in_iowait)
> >               cpufreq_update_util(rq, SCHED_CPUFREQ_IOWAIT);
> >
> > +     if (flags & ENQUEUE_DELAYED) {
> > +             requeue_delayed_entity(se);
> > +             return;
> > +     }
> > +
> >       if (task_new && se->sched_delayed)
> >               h_nr_runnable =3D 0;
> >
>
> I understand that iowait cpufreq update isn't happening now (and that's a=
 bug),
> but if we reorder we may call cpufreq_update_util(rq, SCHED_CPUFREQ_IOWAI=
T)
> followed by the cpufreq_update_util() in update_load_avg() of
> requeue_delayed_entity()
>         update_load_avg()
>                 cpufreq_update_util()
>
> and the latter will likely be dropped by the governor, so the update
> won't include util of the (re)-enqueuing task, right?

emmm, util_est has already included the util of requeue-task.
However, the cfs_rq->avg.runnable_avg would indeed be slightly different.
If we want to include both iowait and runnable_avg, perhaps we should
add the iowait check to the update_load_avg() function, but this would
make the code more complex.

>
> I'll give it some more thought.

