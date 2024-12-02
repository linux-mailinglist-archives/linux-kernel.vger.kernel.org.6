Return-Path: <linux-kernel+bounces-427118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 637F59DFCE8
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 10:19:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A91A281D32
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 09:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCEF41FA15C;
	Mon,  2 Dec 2024 09:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cuJESCSe"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89BB1FA15D
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 09:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733131192; cv=none; b=WANVr0XTPULbEjsKkEkxtz7X6W0Viji5KZx6nF/cr/10dXUkKhtk72tCK2ZeUxxIniouroqUGNW50rKtRGklIzz+jjBJFUMOsf8D3kcaKYrwvIt6tsS1P1i35rFgzBtJ3m5Lz8x5CTAdbMFKTO8oCrTWK9nAJOujGDUlPKapyEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733131192; c=relaxed/simple;
	bh=LAI201etXczxUYj/ymY5QLCuCow+OZ4zyYGLfqeYH78=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oIWXLnYuVy2JqyVG3bfgLub8rgBC7BsCF+HQxG3eMPIxBID9GxfXwu3Fa/RuzIjP+mDFm4Pav+kORvMMZd0DR4PRuMT9LPChqKVLjYlmy32glAl6Z3kBveZY1mRJJW2XPjOF01E7xSNCDa6ayqyOT40pS3vaweTiJcebuGsivD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cuJESCSe; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-724d23df764so3327355b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 01:19:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733131190; x=1733735990; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=I97ci8gfBo1WSs82yFcU7Nf/YQ1nSlUC/sgrBd9LgCw=;
        b=cuJESCSe4gtFkpN0z1QKvrMPOhlxqjizPzZfNgPaHnp1+rP5hSA3WpIWSPhj5RHXG+
         moGvd4E6M+E5AD8LRSctN63hEtLhE6ti2Or1qsSPi2u7GX0/G3Bm0Yw/EmwUQ/FJDp6S
         xCV2crG/0td0MkCHft74bstTa6XQ1BSIMindKFbWY4dl7cKnLfPM7G7gM5MZf2DcJuXi
         e0Ksdg4VYvD+gXAgdDiGPLn6a+r5QNvSGoKm6icwLV/42KPoHk/L/RclikS5d76hqCxt
         Ll7HGB1shhWe3W1+4xynnUNja6OWi0GW3oTathPa5ZZiNQeF0zmYACoYSqg2decKIA/c
         ojvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733131190; x=1733735990;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I97ci8gfBo1WSs82yFcU7Nf/YQ1nSlUC/sgrBd9LgCw=;
        b=ELYhUGBQv/Tt9zx7FEefmpHIRoyry35Im0QlRAsO/cmKYlBC36rq5PB4P26zIQMhJ/
         XplZ56e1qe8HgXNOOTiImVFD8NWfmuTz3WzfgOj34rLCdsayjpCo2d12U7WkDGhYJXiR
         b9HjhABJ7CHTrpXvhrQMNKEuozRn3+WW3rJt/Nf+AjwZhJZLbVmeq3fPInEIFOlWkoCP
         a8fZztPeKDKnfmL5B9WwFVRIujzIifdGQnUpEM1olSqjt2uR5inuU+YyKYYHkb4AC3dV
         H26tHAXEsCu7KDVBDtcYnDCivozLysoij0ggo/Pr4VkGalp+Ca+kLDWQqziJqAHG/RgQ
         KnyQ==
X-Forwarded-Encrypted: i=1; AJvYcCVWEer//897tv6o/t8cVnYxmV3qT4go5aGKilV/Qx7mRdVA5qWvOrXC6PaS0/7ICptqcU2jaZhSpT0sN9o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+n36zlg9tuiqXo0/CRSqw6SZpcLVk+uIrLF36BU6BZ3pEkyaI
	Th4OMrIkCqp0b7nByl1q5M+kwkAMoAA4o5J+pOSILKWDDrLBvTJa9YDtT+MwnsWtSxoqub0UGcH
	5QUU3M00AMzel3RQlDOb8RmM0Ub1FkIc14q+AOw==
X-Gm-Gg: ASbGncs6JiMLN64BwGFdzt/5BGdrZGP7gvMG6l5LdhvUHAQgLHPmXF499BXSaSBDW6e
	HVwJYtd58vp7lPjX+fjt795R3+A1GRX3YU73OJ27L6VY3E7M9PycDlrVhuM8n
X-Google-Smtp-Source: AGHT+IEoJkQyjo3Ar3EJ4UpVVt/jtsfNxtjUYrY7d5c7BaG0lnT0VKhpLyPT+xBLHUclAEJSvTsH2ZkTOO/tBnKz7E4=
X-Received: by 2002:a17:90b:1646:b0:2ee:bc1d:f98b with SMTP id
 98e67ed59e1d1-2eebc1dfb17mr4817762a91.31.1733131189957; Mon, 02 Dec 2024
 01:19:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241129161756.3081386-1-vincent.guittot@linaro.org>
 <20241129161756.3081386-11-vincent.guittot@linaro.org> <38a2431d-4c5a-4273-8f1e-7e2f65748501@amd.com>
In-Reply-To: <38a2431d-4c5a-4273-8f1e-7e2f65748501@amd.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Mon, 2 Dec 2024 10:19:39 +0100
Message-ID: <CAKfTPtA6=OjK=fzKhp7DKmQgho+wSE9OKa-rvVBpkMt-E+R6HQ@mail.gmail.com>
Subject: Re: [PATCH 10/10 v2] sched/fair: Fix variable declaration position
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, vschneid@redhat.com, linux-kernel@vger.kernel.org, 
	pauld@redhat.com, efault@gmx.de, luis.machado@arm.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 29 Nov 2024 at 19:30, K Prateek Nayak <kprateek.nayak@amd.com> wrote:
>
> Hello Vincent,
>
> On 11/29/2024 9:47 PM, Vincent Guittot wrote:
> > Move variable declaration at the beginning of the function
> >
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > ---
> >   kernel/sched/fair.c | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index c34874203da2..87552870958c 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -5632,6 +5632,7 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags);
> >   static struct sched_entity *
> >   pick_next_entity(struct rq *rq, struct cfs_rq *cfs_rq)
> >   {
> > +     struct sched_entity *se;
> >       /*
> >        * Enabling NEXT_BUDDY will affect latency but not fairness.
> >        */
> > @@ -5642,7 +5643,7 @@ pick_next_entity(struct rq *rq, struct cfs_rq *cfs_rq)
> >               return cfs_rq->next;
> >       }
> >
> > -     struct sched_entity *se = pick_eevdf(cfs_rq);
> > +     se = pick_eevdf(cfs_rq);
> >       if (se->sched_delayed) {
> >               dequeue_entities(rq, se, DEQUEUE_SLEEP | DEQUEUE_DELAYED);
> >               SCHED_WARN_ON(se->sched_delayed);
>
> Perhaps also squash in:

Yes, I add it in v3

Thanks

>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 3356315d7e64..321e3f9e2ac4 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5476,6 +5476,7 @@ static bool
>   dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
>   {
>         bool sleep = flags & DEQUEUE_SLEEP;
> +       int action = UPDATE_TG;
>
>         update_curr(cfs_rq);
>
> @@ -5502,7 +5503,6 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
>                 }
>         }
>
> -       int action = UPDATE_TG;
>         if (entity_is_task(se) && task_on_rq_migrating(task_of(se)))
>                 action |= DO_DETACH;
>
> --
>
> while at it :)
>
> --
> Thanks and Regards,
> Prateek
>

