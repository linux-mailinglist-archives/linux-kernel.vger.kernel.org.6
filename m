Return-Path: <linux-kernel+bounces-548859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7D09A54A36
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 13:02:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2621A188C648
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 12:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D76F2010E2;
	Thu,  6 Mar 2025 12:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fBU+zxXs"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1192A2E3397
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 12:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741262517; cv=none; b=q2U3jstrq5KAgssXlTmpkO+4ijWzaIc8yO8gRDQxQ84lJjZQ+bdIxkYxWKw+8NWLMyuESfVm2lkriQnzRQIuuC0CTgwUoDvnMPfT6AEAFqEer37tcHITWVc80aPkVsxE+qJ+73pLr6cFOhLA/VK5ZOaqyF6D4hePr2RCfAc3kqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741262517; c=relaxed/simple;
	bh=/mD583GSW/oYPKZI8Rgdge97MwvG6TiuCEXRzglihy0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ENTZooSVJJIrxmbF2QlAxUFmr861Jpcw6yooaYNEbIyi63iBdfgLKTRfzgYYvsG8ErRT7bZMN8hqai+5igOND2UDsfQ+Otbt4idbln+ZdcRu9Q1C263yLzneMrtHYOemlvRjn1T6/5NM+c+ARpE5tHGiZ6kalJ05KAU2XLXuZjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fBU+zxXs; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5e535e6739bso870550a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 04:01:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741262513; x=1741867313; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qsshg1nGGTkPQI+oxnMmUb57TnnJoQxp2iYlWY/FcQ8=;
        b=fBU+zxXsKqZKlHO9L+sbcxcEgtebLLdyUhfJUcWMKubDD170UyaqbJX/YhyhdBZisT
         rqMYn6uV2Sw9CKCTE2Jybkzw8PUqsGag+JmlKBXN4c4m9JZdxmgZT2wg8sMJ+Q7G/ZGa
         MgncMeBQ5mirS2JslX/8m4YMUGhamDchX45yW6y15sJ+dr/frnuKySmBZjtItA4q3m++
         WmO5NS+MIYP2P/FvzTbfGbbJX+k83Fs1ISgM+DvT3DsIkCRcE3G0zk7PoH1QNsI9dweB
         1xupZynT06SFA5IGMrSVol+rmZmkfTI+z3TysPpBCjesS915OoDjJBOe2b6eQyFNL/5o
         UOYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741262513; x=1741867313;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qsshg1nGGTkPQI+oxnMmUb57TnnJoQxp2iYlWY/FcQ8=;
        b=n4E9OREVVMN8a9/O81zB7fJTYwYNW/j1Rrw2lknPkCNHDtE0beLbK2us7rLJ4wuNI/
         DdnUkceiJZfkBmmIsI9dgrukItYYiz/XcatXYr5HZXOX+bxwc/J14CBH3wRtePsm0hnX
         GH9wNpFV9KoyTIckGLiGInfDtWGFgIFDRpQiBl7mS8x7ZY+SMb8B+sWKfiRYiNFmT4Ee
         QaOnWUYXmSHOtqtUd4C0EvdI6MZwmb+3Z3oXTpdGb4vcqJL0LRvWFrzA6MBlRuiBJePU
         yumzP2Qc6UV5YZr9hChre0IRrUFWuKjlcrVXJhO1EJICI/HyHjTkNd9k8Lerw+zMg1qE
         YKRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUiup0HRUcsKetXjKI2krJQIYJinbwH0XhcbZKd+pMsr0qfGfgcMuvl9BxLviV5ALndpe2+FBKYZY04at8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyela1Edqw3ysyRBIrlb0JhDXhXQya6GU1xLu3MWypDdYrY5Bhi
	ZPjcfWrLG8y64HMUXPw0fbdTALtbmTBfAcL6x5x8FeRSSdLwZ9lcPR0XuSlv1zaEtAQnvj7moT0
	JokuxgJ20Pn6eQUCxB7FVTNidaNI=
X-Gm-Gg: ASbGnctBgLgBsvxD5r2meyObehqum4G+RUmAkhx5Yu3zDyP4ORehGJB93yt16s/bI3f
	LVAEtr70KwiV4bv0OJ4ze88JKjpH3efZpeVKHwzgge2ssxa6OYRbWHy4TCvbx/SwLrdtrOa4kmG
	hioAJbRU0FpftGtIWLA9TUd3qOLd0=
X-Google-Smtp-Source: AGHT+IEJBCUTSZabNFHoPqklcjIPLjnNsjuUCWLcDMjN0YhV0iTavveCCl06RaWtAy/XXERP0OpLczSlZOi82s3OrKw=
X-Received: by 2002:a17:907:7288:b0:ac1:e332:b1ef with SMTP id
 a640c23a62f3a-ac20db68a0dmr685000266b.48.1741262512962; Thu, 06 Mar 2025
 04:01:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <84441660bef0a5e67fd09dc3787178d0276dad31.1740664400.git.hongyan.xia2@arm.com>
 <4394f2a7-b4e8-419a-a299-f1afa560c944@arm.com>
In-Reply-To: <4394f2a7-b4e8-419a-a299-f1afa560c944@arm.com>
From: Xuewen Yan <xuewen.yan94@gmail.com>
Date: Thu, 6 Mar 2025 20:01:41 +0800
X-Gm-Features: AQ5f1JqHC4iYpUssP0g-Fru36ecoI_UEpCYDXrIwvH-vnjybx2MR0-CKXDeLI_A
Message-ID: <CAB8ipk_627GF+TV5u=6DK_3aRUHW8qGYwmN+KXMq_Cg-+Say1Q@mail.gmail.com>
Subject: Re: [PATCH] sched/uclamp: Let each sched_class handle uclamp
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Hongyan Xia <hongyan.xia2@arm.com>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, 
	Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 6, 2025 at 2:24=E2=80=AFAM Dietmar Eggemann
<dietmar.eggemann@arm.com> wrote:
>
> On 27/02/2025 14:54, Hongyan Xia wrote:
>
> [...]
>
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 857808da23d8..7e5a653811ad 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -6941,8 +6941,10 @@ enqueue_task_fair(struct rq *rq, struct task_str=
uct *p, int flags)
> >        * Let's add the task's estimated utilization to the cfs_rq's
> >        * estimated utilization, before we update schedutil.
> >        */
> > -     if (!(p->se.sched_delayed && (task_on_rq_migrating(p) || (flags &=
 ENQUEUE_RESTORE))))
> > +     if (!(p->se.sched_delayed && (task_on_rq_migrating(p) || (flags &=
 ENQUEUE_RESTORE)))) {
> > +             uclamp_rq_inc(rq, p);
> >               util_est_enqueue(&rq->cfs, p);
> > +     }
>
> So you want to have p uclamp-enqueued so that its uclamp_min value
> counts for the cpufreq_update_util()/cfs_rq_util_change() calls later in
> enqueue_task_fair?
>
>   if (p->in_iowait)
>     cpufreq_update_util(rq, SCHED_CPUFREQ_IOWAIT);
>
>   enqueue_entity() -> update_load_avg() -> cfs_rq_util_change() ->
>   cpufreq_update_util()
>
> But if you do this before requeue_delayed_entity() (1) you will not
> uclamp-enqueue p which got his ->sched_delayed just cleared in (1)?
>

Could we change to the following:

when enqueue:

-     if (!(p->se.sched_delayed && (task_on_rq_migrating(p) || (flags
& ENQUEUE_RESTORE))))
+     if (!(p->se.sched_delayed && !(flags & ENQUEUE_DELAYED)))
+             uclamp_rq_inc(rq, p);
               util_est_enqueue(&rq->cfs, p);
 +     }


when dequeue:

-       if (!(p->se.sched_delayed && (task_on_rq_migrating(p) ||
(flags & DEQUEUE_SAVE))))
+       if (!p->se.sched_delayed) {
+               uclamp_rq_dec(rq, p);
                util_est_dequeue(&rq->cfs, p);
+       }


> [...]
>

