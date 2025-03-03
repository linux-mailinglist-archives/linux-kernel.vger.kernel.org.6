Return-Path: <linux-kernel+bounces-540913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 209E2A4B65C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 03:56:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 221D616E172
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 02:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6853919CCFA;
	Mon,  3 Mar 2025 02:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b+5ew8c9"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07261AA786
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 02:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740970608; cv=none; b=eO6m7BMIcAWknG8eUnX5IhV9eSJoSLtoYSjtZyc5yu+cdB4BjggHij5LREsUr3yR1ZYBLJ/k0R8BWaLqyHfUN1zUhX/X+sL/df8jDiQG/s7Qel8Pa4QqT1jQRzfz/zw3OAbolSGPy5GOLERKPoY/cTICgS1v+mX2eDB6R4CiWsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740970608; c=relaxed/simple;
	bh=4ltmz4+OE+nj2aWFuE8DlZINOhhINdS207+6JNfls9E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TiVIUP5Edka1A27IW2Hjh8m2m2SFKhv1SqmCaMyqYSIYrUML43zcwT+SzUPOexTdc78x28tKOWV2bfxQJY58ept0dvlvSc63A17n8b2xM/m0fvoSuoJuwmkCXJ8WZ6YbWHAkgWwM9ecfWoneCL1k1umIf/7LV/n4wlHn7iPFMZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b+5ew8c9; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-abf64aa2a80so193120266b.0
        for <linux-kernel@vger.kernel.org>; Sun, 02 Mar 2025 18:56:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740970605; x=1741575405; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5bHsnvW08Pbpw48CQ/CPWTbYb2V5PC23OQ+MNGQ+naA=;
        b=b+5ew8c9Xc/7dHqMNI9P+yWLFitE1HTOHno2aE9euwba7trKPg0aXiMDmD2lJvo6Hq
         /OXFL1iRtQ0X55W/0/KRIUQF8BAlpXiGvy8le3MoPpylrN2tBNw+u2AoZ22ooMJ9T6rR
         5UafZb8VIt/salrJvYaSy/4uNF7kyJcwvFgiaH3j//gTjuZyGAvi4XmG7hPk0+zk8GPB
         257LaPmngU0gPGg28QBqUaWpKo5nEjJIMZysYZzl9abHFKhFimWEMQyfYqGDHVxEkYh+
         Px9ttsPt4Ta+eV/Q39ZTx/H9N3whnSIJ+iZCMzxPfCQneM+qQCXHe0j4HgV5GOPAENKA
         nqFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740970605; x=1741575405;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5bHsnvW08Pbpw48CQ/CPWTbYb2V5PC23OQ+MNGQ+naA=;
        b=Xbajw0EqD/HRxhZFQCUeL4PcbhQUm7uWPhw2f9ydhTo8VLJ4v5PjtO8D3aRpXuJhQU
         shCdJ8/Skiaf76d8mYLhlUlifpmTwhyZC/An3l2+fkZJ+57Z1snHiXaXQER/d2oBoD0E
         Sfr8L0sm9QC/kb3lUlRKf9cQwBLDJHeyZhuMVgth68rMKW8geZFz5Cr19bVQKh6KOU+L
         VLSv5pXCi8wOXp6zyAAHtZZ04mi1eKKDg3iYoIZ2qWEmA08JjyouXvbnQfaaOWDxTG9V
         3e7xM3MmOQXOkGqW+c9wTte1KvhSE8jhVpkkVcIQAzf2bA4HFlJpsnvrSgBjhOe75NwM
         Q4YQ==
X-Forwarded-Encrypted: i=1; AJvYcCVzaHmb0HgDRJt5hl9BQGkRRVdXrJ9zKUKepm+PdL+GwC1PO7K6jYtkczjev/8X+5NTAA78EUWa4unemtM=@vger.kernel.org
X-Gm-Message-State: AOJu0YySk1jf7aYND6u2QAdaQY3fvjF9XulEx4Eq6GS3mK5pHX9AZiXw
	BoSmJi4vPjZ3dStaPe72xNNjyzA7+NwKNJPX5j6qdTkOIDGYNlbXn4UrF7QePx9yv+jZEBrv/59
	2NcapWxVO9cszS9iMth0+pWKoCSY=
X-Gm-Gg: ASbGncv/XtfJlxONWXahTSHQD8C9eWCO37jMjNRTWOLHxO/66piQ6bUeqX4/7n/qUeO
	8EODZmqwSXpUrQT7oY7GBiqy4rQchbLycZJxnwYaZ1pjtlNAcwpYGDmwVJDkWOhxd3dHjY3sF/e
	9+t0hr1J5HiJ6lOU6iNpXMJsM3UyE=
X-Google-Smtp-Source: AGHT+IGRgTcLKGBcpk25Pl/iRqBpGIPwcROFqgSpt4jfJ+/5CgfAR3Jzl9H7SArY1mCItL7/BYkvqw8OM2s7yqzgass=
X-Received: by 2002:a17:906:794e:b0:abf:742e:1fca with SMTP id
 a640c23a62f3a-abf742e23d7mr296522166b.18.1740970604779; Sun, 02 Mar 2025
 18:56:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250226024741.2274-1-xuewen.yan@unisoc.com> <CAKfTPtBB6FH+5G5eRxC-0UA3H_M6Qt=CvKfCNvHy2=Dg0EEMxw@mail.gmail.com>
In-Reply-To: <CAKfTPtBB6FH+5G5eRxC-0UA3H_M6Qt=CvKfCNvHy2=Dg0EEMxw@mail.gmail.com>
From: Xuewen Yan <xuewen.yan94@gmail.com>
Date: Mon, 3 Mar 2025 10:56:33 +0800
X-Gm-Features: AQ5f1JoPpRiVtwHs5D7MFxGBmUcYasGZQXAuXu17CGS2mSkmmsBBz_MXs62FaKg
Message-ID: <CAB8ipk8kZ0MLSqqohRQ=xb=W6Yx+rVsFL_v=Xh=fN4mkP14tew@mail.gmail.com>
Subject: Re: [RFC PATCH] sched/fair: Fixup wake_up_sync vs DELAYED_DEQUEUE
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Xuewen Yan <xuewen.yan@unisoc.com>, peterz@infradead.org, mingo@redhat.com, 
	juri.lelli@redhat.com, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, ke.wang@unisoc.com, 
	di.shen@unisoc.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 1, 2025 at 12:39=E2=80=AFAM Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> On Wed, 26 Feb 2025 at 03:51, Xuewen Yan <xuewen.yan@unisoc.com> wrote:
> >
> > Delayed dequeued feature keeps a sleeping task enqueued until its
> > lag has elapsed. As a result, it stays also visible in rq->nr_running.
> > So when in ake_affine_idle(), we should use the real running-tasks
>
> typo: wake_affine_idle
>
> > in rq to check whether we should place the wake-up task to
> > current cpu.
>
> fair enough
>
> >
> > Fixes: 152e11f6df29 ("sched/fair: Implement delayed dequeue")
> > Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
> > ---
> >  kernel/sched/fair.c | 11 +++++++++--
> >  1 file changed, 9 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 1c0ef435a7aa..2d6d5582c3e9 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -7342,8 +7342,15 @@ wake_affine_idle(int this_cpu, int prev_cpu, int=
 sync)
> >         if (available_idle_cpu(this_cpu) && cpus_share_cache(this_cpu, =
prev_cpu))
> >                 return available_idle_cpu(prev_cpu) ? prev_cpu : this_c=
pu;
> >
> > -       if (sync && cpu_rq(this_cpu)->nr_running =3D=3D 1)
> > -               return this_cpu;
> > +       if (sync) {
> > +               struct rq *rq =3D cpu_rq(this_cpu);
> > +               int nr_delayed;
> > +
> > +               nr_delayed =3D rq->cfs.h_nr_queued - rq->cfs.h_nr_runna=
ble;
>
> Could you encapsulate this in a helper function ? something like below
>
> static inline unsigned int cfs_h_nr_delayed(struct rq *rq)
> {
>         struct rq *rq =3D cpu_rq(this_cpu);
>
>         return (rq->cfs.h_nr_queued - rq->cfs.h_nr_runnable);
> }
>

Okay=EF=BC=8Cor we could  add cfs_h_nr_delayed(struct cfs_rq *cfs_rq)?
Others can call it with cfs_h_nr_delayed(cfs_rq) or cfs_h_nr_delayed(rq->cf=
s_q).
This way, the helper function will be more versatile.

On the other hand, I found that it's not just the nr-running here that
needs to be fixed; other instances of nr-running also need correction,
such as in yield_task_fair and sched_fair_update_stop_tick. Perhaps we
need to modify a series of patches to address these issues.

BR

