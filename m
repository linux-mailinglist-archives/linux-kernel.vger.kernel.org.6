Return-Path: <linux-kernel+bounces-576922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60AD3A71603
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 12:46:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E27D6171032
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 11:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8D091A5BB2;
	Wed, 26 Mar 2025 11:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IIhC/AOG"
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CECC611E
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 11:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742989600; cv=none; b=eyN4ao9tzfA5jKS7R8yqUhaF08nqo447RY0ANGVHlIH7NN5HgMe51kGwWoL7UGZdi58sxTILwiF+hZsBgaUT4982AwzGEs33ZG0lASTs3qNC9Pp9J6ZdsywO1tXXiC9sr03ugUj/y4sV+OBd+M6Qt68onLNFk10e3VK5AjhOagQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742989600; c=relaxed/simple;
	bh=ePqU6o72X0FlzzlkjBqVQea3QqwX+1DEwm1qds8PXdI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DZZdBjzk8oy8ymwojr7QFYBuhGRNbwuJU/OCTXEX9DW5dPgkzwAGdOuXvP4/tJYWUrdQBLQ9G1aOkqH1/NRjfr+wkZA6RVfs1y/ZOCg7z4pqVenPMlDfk/7jZoa6u9h3HDZH7mdfkJlQIBJM/axUpoPbToLxvkHexf8Mv1npMA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IIhC/AOG; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-476f4e9cf92so46624791cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 04:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742989597; x=1743594397; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2pUk9hjLsSbot2vAUpjC4Ulxq6UuFRzREWWpBJPYYAI=;
        b=IIhC/AOGeEe9V63twl/h//4Xgs9bfkpOxLA72jh/NA3D2A24wKGmvU6cCgvQ4OPZkm
         WoDBg7qjOy3D+qd9PbXUfzPgPgaphBYFVqCn2JdRTL/O6wziwqPX7Nth1fflowZ3+lNn
         w12AEUYVhf1v/ofXfUvSYfnIu50Ip9sNcDJW07i2M49bXzw1D/GbymOWGp7DguwC08ry
         HYIFKPYMyJ20ylrz3z5NlMA3eVWN3asHwzPRm2ZQbuOtI9SB8X7Q7NHwUZHUXBXL2ikz
         u+cgG87YKViADvyTNNKRQ4ddUcUcLcv3p4l8Fpgs+w+HJSGDf0ZFONrjhs+Pst9t05X5
         b6Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742989597; x=1743594397;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2pUk9hjLsSbot2vAUpjC4Ulxq6UuFRzREWWpBJPYYAI=;
        b=irAJCChHadBZdaf1IwOf1UcFCyuSJ9U5ryEnzACteWEkjAp6+b+I25qVD5Nq1/biq2
         nZXFyo71UrG5/3fGnY/22TWCCKk+BvROhAugHGU8fwcYMEmfI+VNGyCz9ciZizSzxMrf
         9LMx5TGWqn8US+0QjNZ9qLsYcVrQ6YvIixFvvThvBJRgAb7rzZorgkzW17O+3Iyguqey
         d9Ox4etwyTFSYUO1/9Sf6yKJt0W+SbGe31dxsg1YkH8a9sGbJkGMIDhqpJEBmt2kuAHb
         WblImOq8uN3pQ51C9Sg5KP7ddqO0H994LrD8SuWf6Xs3XsJtb1sYVnvgyju2N9zO8x29
         lZaw==
X-Forwarded-Encrypted: i=1; AJvYcCVT4uShyMtqDdoNiNRA1arYLHkaHIzl35Hz3nklWthi9U0wma5oau2wOEZzmdciM5n499WVya46spStWBY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/sbbqtdnnkXhn8opIPq1OyKqFnlXhNx2pUlJt7Lk1iLxWxIDs
	I8YdVDRSk2FCNea8rk+DMLeDhEVjVFfCHXxhPDSnmWUSjgKje4gJxJY0ea9P8Vbw7AjCkW4UNel
	eEtS3K2DmMw3tYPwH1kPoRQlpwe0=
X-Gm-Gg: ASbGnctaHSOR+ntZCM/ra0suwQi5agPBwT+w8Ut1t3h2LU5kQUtFqBpZiFXX8S0T9O2
	8KaEORFGlfvtBRpDc6f1vdMfoG9YglttwpOZyyGNsKuHTtBoemIoz/fq9p2SRE7cdc7jATAbtjP
	nLpaIpG4NMK8OzrGDRmBUmcmO3t+U=
X-Google-Smtp-Source: AGHT+IEzvK709Gs+N70vdulm5+1cU9KNcyq8cvPtH7QvY1TilIJWhRwJxXE9e5U/G/zeXR63t7ovCDW1uusvUA8plPk=
X-Received: by 2002:a05:622a:1f08:b0:476:c650:9839 with SMTP id
 d75a77b69052e-4771de800d1mr249482921cf.51.1742989597017; Wed, 26 Mar 2025
 04:46:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250325014733.18405-1-xuewen.yan@unisoc.com> <03344e80-4ed2-41f1-9d2b-f7ed2e201eba@amd.com>
 <CAB8ipk_1=U_HgVQrfQ4VRUDrcHJBQd2LJ9aXh8PG6E-Z4_xS+g@mail.gmail.com> <d19cc24f-32a4-4d10-a51c-466476616e7d@amd.com>
In-Reply-To: <d19cc24f-32a4-4d10-a51c-466476616e7d@amd.com>
From: Xuewen Yan <xuewen.yan94@gmail.com>
Date: Wed, 26 Mar 2025 19:46:26 +0800
X-Gm-Features: AQ5f1JohI7-7-cAqxigagCWF4Mxyh-ro-_hk0Aq6ncXZpSuYolG1Ldyswd957ns
Message-ID: <CAB8ipk8WGLqbBfamqLcXtaHO-CEbZTXt51nCwHixOn6JVaRnyw@mail.gmail.com>
Subject: Re: [PATCH v2] sched/uclamp: Align uclamp and util_est and call
 before freq update
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Xuewen Yan <xuewen.yan@unisoc.com>, dietmar.eggemann@arm.com, mingo@redhat.com, 
	peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org, 
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, 
	hongyan.xia2@arm.com, qyousef@layalina.io, ke.wang@unisoc.com, 
	di.shen@unisoc.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Prateek,

On Wed, Mar 26, 2025 at 12:37=E2=80=AFPM K Prateek Nayak <kprateek.nayak@am=
d.com> wrote:
>
> Hello Xuewen,
>
> On 3/26/2025 8:27 AM, Xuewen Yan wrote:
> > Hi Prateek,
> >
> > On Wed, Mar 26, 2025 at 12:54=E2=80=AFAM K Prateek Nayak <kprateek.naya=
k@amd.com> wrote:
> >>
> >> Hello Xuewen,
> >>
> >> On 3/25/2025 7:17 AM, Xuewen Yan wrote:
> >>> When task's uclamp is set, we hope that the CPU frequency
> >>> can increase as quickly as possible when the task is enqueued.
> >>> Because the cpu frequency updating happens during the enqueue_task(),
> >>> so the rq's uclamp needs to be updated before the task is enqueued,
> >>> just like util_est.
>
> I thought the frequency ramp up / ramp down was a problem with
> delayed tasks being requeued.
>

Yes, you are right.
IMHO, perhaps this issue should be fixed separately, as uclamp not
only affects delayed tasks, but should also be placed before
enqueue-task for other tasks.

On the other hand, I previously also sent a message regarding the
frequency issue with delayed tasks in iowait.
https://lore.kernel.org/all/20250226114301.4900-1-xuewen.yan@unisoc.com/

...

> >> On a larger note ...
> >>
> >> An enqueue of a delayed task will call requeue_delayed_entity() which
> >> will only enqueue p->se on its cfs_rq and do an update_load_avg() for
> >> that cfs_rq alone.
> >>
> >> With cgroups enabled, this cfs_rq might not be the root cfs_rq and
> >> cfs_rq_util_change() will not call cpufreq_update_util() leaving the
> >> CPU running at the older frequency despite the updated uclamp
> >> constraints.
> >>
> >> If think cfs_rq_util_change() should be called for the root cfs_rq
> >> when a task is delayed or when it is re-enqueued to re-evaluate
> >> the uclamp constraints.
> >
> > I think you're referring to a different issue with the delayed-task's
> > util_ets/uclamp.
> > This issue is unrelated to util-est and uclamp, because even without
> > these two features, the problem you're mentioning still exists.
> > Specifically, if the delayed-task is not the root CFS task, the CPU
> > frequency might not be updated in time when the delayed-task is
> > enqueued.
> > Maybe we could add the update_load_avg() in clear_delayed to solve the =
issue?
>
> I thought something like:
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index a0c4cd26ee07..007b0bb91529 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5473,6 +5473,9 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_=
entity *se, int flags)
>                 if (sched_feat(DELAY_DEQUEUE) && delay &&
>                     !entity_eligible(cfs_rq, se)) {
>                         update_load_avg(cfs_rq, se, 0);
> +                       /* Reevaluate frequency since uclamp may have cha=
nged */
> +                       if (cfs_rq !=3D rq->cfs)
> +                               cfs_rq_util_change(rq->cfs, 0);
>                         set_delayed(se);
>                         return false;
>                 }
> @@ -6916,6 +6919,9 @@ requeue_delayed_entity(struct sched_entity *se)
>         }
>
>         update_load_avg(cfs_rq, se, 0);
> +       /* Reevaluate frequency since uclamp may have changed */
> +       if (cfs_rq !=3D rq->cfs)
> +               cfs_rq_util_change(rq->cfs, 0);
>         clear_delayed(se);
>   }
>
> ---
>
> to ensure that schedutil knows about any changes in the uclamp
> constraints at the first dequeue, at reenqueue.

Because of the decay of update_load_avg(), for a normal task with
uclamp, it doesn't necessarily trigger frequency update when enqueued.
If we want to enforce frequency scaling for requeued delayed-tasks,
would it be possible to extend this change to trigger frequency update
for all enqueued tasks?


>
> >
> > -->8--
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index a0c4cd26ee07..c75d50dab86b 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -5435,6 +5435,7 @@ static void clear_delayed(struct sched_entity *se=
)
> >          for_each_sched_entity(se) {
> >                  struct cfs_rq *cfs_rq =3D cfs_rq_of(se);
> >
> > +               update_load_avg(cfs_rq, se, UPDATE_TG);
>
> For finish_delayed_dequeue_entity() calling into clear_delayed(),
> UPDATE_TG would be done already in dequeue_entity().
>
> For requeue, I believe the motivation to skip UPDATE_TG was for
> the entity to compete with its original weight to be picked off
> later.

Okay.

>
---
BR
xuewen

