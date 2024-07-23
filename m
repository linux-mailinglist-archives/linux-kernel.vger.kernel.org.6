Return-Path: <linux-kernel+bounces-259959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4518393A07D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 14:28:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E48CE1F22D99
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 12:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C117D152503;
	Tue, 23 Jul 2024 12:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IU0dp5V8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF7414AD17
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 12:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721737679; cv=none; b=Eo+Na59Cp6TQAHzBP35M/0wh6uuK8hd2em/5BdRXQkvuPIWNDC7QhhWrraHeuxVrsrtlqBDvek65or9tbn30rcAH0l03fU4FsxBlxigBa+TD4FXhRaodsaOpm+R/2Xrg72xkA79w8pYfFk6H988wfm8GfBI+mmohT2bXMoqFnZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721737679; c=relaxed/simple;
	bh=An6cxk5WgNJRBNSKfy2vcuZjPmw6N26My4hpVbojqqY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OVh0jk5JK8zwjoHGvoNxng8Xt3JI8uKpgQp0WwjRMS8EnMX5erHcY9TsMsjcm4LJehdQOIb93pFwnHvGCQVI/czyQUG8KeD1U+W/+ldEP7/ll+nAiUuvT2ULokv33gPoVqLHogTCBgLFggfaKXzEcdc9MIZGac+jl2Od0eGD8YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IU0dp5V8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721737676;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gRPMaoIkpqAyAKW7v6ZLRiiasNI4QNMp+VEOcz4QSnQ=;
	b=IU0dp5V8+H1td1iUZERKayE7KbrtEaNkr1vv0+hwch+puTEHyNSXEb1Dv9F84ApJW9DM9I
	s3wPbfASA/pMY6tKCrjG72Me2rCNVEv2lcUtRFpEU0cNzG3pL0L0yRGI79IBUNfD+b5LTW
	rNowYxGI3nN113/S6BBxsJOuzmUZ3xw=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-6wQ6rX64OauRxUdiFZei3g-1; Tue, 23 Jul 2024 08:27:52 -0400
X-MC-Unique: 6wQ6rX64OauRxUdiFZei3g-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-449332e01c0so65982201cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 05:27:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721737672; x=1722342472;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gRPMaoIkpqAyAKW7v6ZLRiiasNI4QNMp+VEOcz4QSnQ=;
        b=L/U+d66Gtj2LXTCWQbeThVQeGYr2hwLnTl4Oq/ByaNZGGB2VZXht4dFCEL89OHDsge
         HI0wJTvLl7sSo0+vrtAkoEdEJ3lWc0pecERvND7vsRgUWH/sgkS8piEW4tnRA1oOK3SZ
         4dKjwDcDmEU70udCnpquLWK1zDiC0GYpLwxskxN7Te0ArqYjj5d9WohUi5BaG67dWyYj
         k33H2d16LbY60V4JuyZOqG1yDaUl+QVBWKQEFiZFFSCDD9FDRt20MDYbblL3d63lRNgi
         kPZcov2HpsoCIKcjecJuYZM1TUGEMdauiwksdhS+XSv7asWaF7F9owEonR6FtTyLgoX6
         aFTg==
X-Forwarded-Encrypted: i=1; AJvYcCWvgWDcl3p3+MOCe90Ajx9sgfGWaUtLwIGC9u04LzCAam2WAKmJG4MQfYM2tHnDXrigrtrZ3GhsgBs6KJOQjuV6SbQZ31Lg+1A120Ti
X-Gm-Message-State: AOJu0Yxmcsoj9pwh/rqnfgWWMABTWPmk58JhjsvPvirpT20D+WRvapxC
	QO6eSAP2rupkydCZ8STuXdoWg8u4mUpuDTe+1w0ivUOgjjocQJSHEzZBlzfTLcKHYfrXbuiLjKa
	ENotdLSbwEC9OkYRMxzy9pm3J5gFAEpxEzfqmL/iu4x1JfeNrrvvfqzrog4eKd11X1jn5Hb0qIu
	IpDn6BBhw0jWyfZXYdGiJEG1z3okg4AF99HUw6
X-Received: by 2002:ac8:58ca:0:b0:447:e3a5:27a7 with SMTP id d75a77b69052e-44fa534bf78mr134363611cf.49.1721737672165;
        Tue, 23 Jul 2024 05:27:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFjdGV5Tx1NxrPq9ZnapFbWFXV+MWf1AQJovjcxpl21nqvOYGt4hOvmEaKRXSBMrzTjGF6EGG8UhxIGS4jxDo=
X-Received: by 2002:ac8:58ca:0:b0:447:e3a5:27a7 with SMTP id
 d75a77b69052e-44fa534bf78mr134363401cf.49.1721737671767; Tue, 23 Jul 2024
 05:27:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240722132935.14426-1-wander@redhat.com> <20240722132935.14426-3-wander@redhat.com>
 <Zp9v8gJ8nqyLkL1m@jlelli-thinkpadt14gen4.remote.csb>
In-Reply-To: <Zp9v8gJ8nqyLkL1m@jlelli-thinkpadt14gen4.remote.csb>
From: Wander Lairson Costa <wander@redhat.com>
Date: Tue, 23 Jul 2024 09:27:40 -0300
Message-ID: <CAAq0SU=s+UMZWXBfHWG4tPCM5VM35T6B0i+JcimbRXm0Q+ZvJA@mail.gmail.com>
Subject: Re: [PATCH 2/3] sched/deadline: avoid redundant check for boosted task
To: Juri Lelli <juri.lelli@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, "open list:SCHEDULER" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 23, 2024 at 5:55=E2=80=AFAM Juri Lelli <juri.lelli@redhat.com> =
wrote:
>
> Hi Wander,
>
> On 22/07/24 10:29, Wander Lairson Costa wrote:
> > enqueue_dl_entity only calls setup_new_dl_entity if the task is not
> > boosted, so the WARN_ON check is unnecessary.
> >
> > Signed-off-by: Wander Lairson Costa <wander@redhat.com>
> > ---
> >  kernel/sched/deadline.c | 11 ++++++++---
> >  1 file changed, 8 insertions(+), 3 deletions(-)
> >
> > diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> > index 312e8fa7ce94..908d5ce79425 100644
> > --- a/kernel/sched/deadline.c
> > +++ b/kernel/sched/deadline.c
> > @@ -785,12 +785,11 @@ static inline void replenish_dl_new_period(struct=
 sched_dl_entity *dl_se,
> >   * one, and to (try to!) reconcile itself with its own scheduling
> >   * parameters.
> >   */
> > -static inline void setup_new_dl_entity(struct sched_dl_entity *dl_se)
> > +static inline void __setup_new_dl_entity(struct sched_dl_entity *dl_se=
)
> >  {
> >       struct dl_rq *dl_rq =3D dl_rq_of_se(dl_se);
> >       struct rq *rq =3D rq_of_dl_rq(dl_rq);
> >
> > -     WARN_ON(is_dl_boosted(dl_se));
> >       WARN_ON(dl_time_before(rq_clock(rq), dl_se->deadline));
> >
> >       /*
> > @@ -809,6 +808,12 @@ static inline void setup_new_dl_entity(struct sche=
d_dl_entity *dl_se)
> >       replenish_dl_new_period(dl_se, rq);
> >  }
> >
> > +static inline void setup_new_dl_entity(struct sched_dl_entity *dl_se)
> > +{
> > +     WARN_ON(is_dl_boosted(dl_se));
> > +     __setup_new_dl_entity(dl_se);
> > +}
> > +
>
> So, the other call path is from dl_server_start() and for this we know
> the entity is not boosted either. We could probably just remove the
> WARN_ON w/o the additional wrapper function. That said, considering it's
> not fast path, I wonder if we actually want to leave the WARN_ON where
> it is, so that we can catch potential future erroneous usages?
>

Yeah, if you feel the patch is not worth it, I am more in favor of
dropping the patch than removing the WARN_ON.

> Thanks,
> Juri
>


