Return-Path: <linux-kernel+bounces-570792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4976AA6B48C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 07:44:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 700C37A5F60
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 06:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73F0F1EA7E7;
	Fri, 21 Mar 2025 06:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QGH0oVEV"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DEF5184F
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 06:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742539467; cv=none; b=IO9BQVIGCbhGdQxBc9I7VIG4eIRXKTnqV5rt45osbwG4NOrY/PyVJwsUFlgqIswp8lwcxAxKUd5VI9SttJ/omK8c6bko29X6uC6tKS7WUy8PDFqy2SbnDXrUF4vlD9FsirsPYI6OT6Ypt/dwxOqRF7Hfv8qoD6owLddNqmANACA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742539467; c=relaxed/simple;
	bh=DF8PnlG7Hr1ATuCJcOG2OjB6fbV40cCabHnk0emD19c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cDX2aiIcR9TObdLP53f3mOd/Io7DbOT3EcPtHZ4U87Yf1Z/UvpPjbfMbQ5gLXiYL8Tzu7ol6nK+R8rUwXIbKtaO+FxbBdrZ9/Dr6nURgrkZ4xv92sBq+Rh/rBcFsvAEvB/Gx5dhzV7dKG5g5hHEn92Ueew9vZMJDIGIi9PxH9yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QGH0oVEV; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ac2c663a3daso331419966b.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 23:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742539464; x=1743144264; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kGQF18ckYSLxZApXLwPAKI0YhIHltP0kb74o7YZV0/8=;
        b=QGH0oVEVrUXxiXdZd3YX0bNg4VkDSIetGdxORRLXAv/+PVziqK52cgqC32uGGkwmgL
         B7p+ubgjxnqisJA/VOd34fZup9B5abDNPYQ30jsRkT6qfoAcDXljbVU9L3TUVkGRI0kN
         82LxL9Z2x7kzUENLE+2uXgmgqC+MwWFVrdWXIVM4j4Z7oiH76VPy/FYjHwFdnXD27zeQ
         6W1l/yIfq6SaqRn1Mot2tAgZYlUh4iTOiNG/7M9X4dSAcyU3I1bCujbYRifiGj7GFbBx
         1JCLpRsLRYWwQMkLhkGxF7s+tPiMzpULrH7ChK9X2V4ZV5VDNC5EP/cG+YbsYb8aIxh3
         0S8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742539464; x=1743144264;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kGQF18ckYSLxZApXLwPAKI0YhIHltP0kb74o7YZV0/8=;
        b=CqwnhBB6Lb55h947NkFLIWUHW1/sNqrc0OSpOVOaXqGY0Q8F35oUOw5/9rXaMr92aO
         U6vaepJQeqyskoGmT51mui6egtREaTS2gK1hO5muFYGfmkrOFwx2DjE/QCypApTmjK22
         5MTDIo3FyUpTI64nYUrSqR19srItUnP+28T594Ihp4nAP5AD9RPgBlRqir6YD0zQkhDo
         AxtYdwFTW/QfV4EFp3jvM2tyUoWH1Py9691t6odDG2UbrKJQ3fBKzh+bDdv5mUE7tsuZ
         tdT8wblQCuKXAuhkXWEMYv+SFQHaYJQ+Z43GOsuJ7azAEdZkllnqQfwLcfpTUCxNv6HE
         vAEA==
X-Forwarded-Encrypted: i=1; AJvYcCXpqcz6WcCqeqEwLwXi1OhUxXX1HCvwCg0PRM9gevPe7a77wv0CIuFe+hpkCSyXvVzkghNWMZLIXFTkXKM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMceJTr1MG7RRWrDD5z2od7ZIg/fyZPOT15nwcGn80qErEtCVY
	32llbN/iX5HGTz/skQ6kT76suWezgVH2gtVTZJipmyD538cUrk1muIHSkbGBW24HriULyswcQ5X
	ogliuOfxzB/Mbjyfs+laOxfTs89E=
X-Gm-Gg: ASbGncu4PwnNN9Cd3bF5uND9An1BxUfeox+lxf54LXKYkljtgdLFOlkkio2QW7aCex0
	cyFDxewpKoR1h0Z0/0/1iA3AgERWmaB22/Iwyh0YLUtFh1mFbXvwag302EYkU6asFBwG/r35V1F
	QU70rTfVAV6+K2AWRFz9g+bO3v8b+fTZlvrqj2Ew==
X-Google-Smtp-Source: AGHT+IEuRCs8clnRt9/9XKI8bfSW5ZZ1W0+gJlIQyjBl/iMrlo1+qze4bNwI5oIr5meopg7mreEQR9xCxC0TBdlbCK4=
X-Received: by 2002:a17:907:97d6:b0:ac2:9683:ad2c with SMTP id
 a640c23a62f3a-ac3f25412cdmr212419366b.57.1742539464180; Thu, 20 Mar 2025
 23:44:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250314090909.8404-1-xuewen.yan@unisoc.com> <aa8baf67-a8ec-4ad8-a6a8-afdcd7036771@arm.com>
In-Reply-To: <aa8baf67-a8ec-4ad8-a6a8-afdcd7036771@arm.com>
From: Xuewen Yan <xuewen.yan94@gmail.com>
Date: Fri, 21 Mar 2025 14:44:12 +0800
X-Gm-Features: AQ5f1Jr27hlricxjEHub04yMulJDFPH1yi49EiIf-ha0hZMffAwHxAf1QvhfxTc
Message-ID: <CAB8ipk8FX=zhBo0vHPC8MEHMEJKsa+E9J081mzJMLZU_8-U78w@mail.gmail.com>
Subject: Re: [RFC PATCH] sched/util_est: Do not sub the delayed-task's util-est
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Xuewen Yan <xuewen.yan@unisoc.com>, vincent.guittot@linaro.org, mingo@redhat.com, 
	peterz@infradead.org, juri.lelli@redhat.com, rostedt@goodmis.org, 
	bsegall@google.com, mgorman@suse.de, vschneid@redhat.co, 
	linux-kernel@vger.kernel.org, hongyan.xia2@arm.com, qyousef@layalina.io, 
	ke.wang@unisoc.com, di.shen@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi hongyan

On Wed, Mar 19, 2025 at 9:33=E2=80=AFPM Dietmar Eggemann
<dietmar.eggemann@arm.com> wrote:
>
> On 14/03/2025 10:09, Xuewen Yan wrote:
> > In cpu_util_without, When the task is in rq, we should
> > sub the task's util_est, however, the delayed_task->on_rq
> > is true, however, the delayed_task's util had been sub
> > when sleep, so there is no need to sub the delayed task's
> > util-est. So add the checking of delayed-task.
> >
> > On the other hand, as said in [1], the logic of util_est's
> > enqueue/dequeue could be simplified.
> > So simplify it by aligning with the conditions of uclamp.
>
> This flag simplification looks good to me.
>
> IMHO, you should submit this with the uclamp change so that we can call
> uclamp_rq_inc() before p->sched_class->enqueue_task(). To make sure the
> task which is enqueued with 'flags & ENQUEUE_DELAYED' is considered for
> cpufreq_update_util() in enqueue_task_fair() (Hongyan's finding in
> https://lkml.kernel.org/r/84441660bef0a5e67fd09dc3787178d0276dad31.174066=
4400.git.hongyan.xia2@arm.com)
>
> I would prefer the less invasive fix you presented here:
>
> https://lkml.kernel.org/r/CAB8ipk9LpbiUDnbcV6+59+Sa=3DAi7tFzO=3D=3D=3DmpL=
D3obNdV4=3DJ-A@mail.gmail.com
>
> since uclamp is already a core thing (fair + rt), it works for current
> max aggregation and it's less invasive.
>

Since the uclamp's enqueue is affecting performance, could we fix the
uclamp-enqueue issue first?
Need I to send the patch-v2 base the
https://lore.kernel.org/all/CAB8ipk9LpbiUDnbcV6+59+Sa=3DAi7tFzO=3D=3D=3DmpL=
D3obNdV4=3DJ-A@mail.gmail.com/T/#mb32d7675beda5cadc35a3c04cddebc39580c718b
?
As for whether we need to distinguish sched-class, can we discuss that late=
r?

Thanks!

> [...]
>
> > @@ -8037,7 +8037,8 @@ cpu_util(int cpu, struct task_struct *p, int dst_=
cpu, int boost)
> >                */
> >               if (dst_cpu =3D=3D cpu)
> >                       util_est +=3D _task_util_est(p);
> > -             else if (p && unlikely(task_on_rq_queued(p) || current =
=3D=3D p))
> > +             else if (p && unlikely(current =3D=3D p ||
> > +                      (task_on_rq_queued(p) && !p->se.sched_delayed)))
> >                       lsub_positive(&util_est, _task_util_est(p));
>
> cpu_util(..., p !=3D NULL, ...) is only used for select_task_rq_fair().
> IMHO p->se.sched_delayed is not set there.

Hi Dietmar,
You're right, there's really no need to add extra conditions here at the mo=
ment.

Thanks!

