Return-Path: <linux-kernel+bounces-205593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A62D68FFDF0
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 10:21:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5958E1F23F92
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 08:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A14315ADAC;
	Fri,  7 Jun 2024 08:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VX0RgseQ"
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9DE1154441
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 08:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717748463; cv=none; b=oMftKfXYJu4SZEl8MHCGYQV1ORgwJBFTCcTTAP/2d/STPy9isqsCEzcq2jqDm8WtVfAXwWSC8XqTB5m3ANte57YNPgcubrZ08W1rYJN+cVgBf505CTzTAyaTB1Sh4ZqfBSPNFk4ltqURCkNTvsb+422UIN9sqqIcSvRNu4l3j/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717748463; c=relaxed/simple;
	bh=7YKnOk6Dd9DTUtg8MNU0MccPJPY3Th2j2qHyK0v5T5c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r2xeYhVJTZKI2gtqJFI1DFBsG4pGA3z56H5cJ8VRMPSrDKITyL0W6DBzSByC7lig2LBkYZGakl/pYf62QBjHCDynTi7FAkvgiMdCzPNT+LoOI+8LCcVVoUZZaB0YG3p9uY3vNd6InrTagZ+IsYQ56Md5UMOMmqjMKe/w0h0v5U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VX0RgseQ; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3d2062325fbso1114656b6e.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 01:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717748461; x=1718353261; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dIRi7p8AxnKST2wIWmYIffowe3bT/Gjz3uWH4Z5QtKA=;
        b=VX0RgseQAi1xiUlqFonr+62XGZuYzHb0G5TGbcRWTD8YgOS8POfS8e338u7iPlespw
         IviUfZoyDp9VstniBF47PBDOZcURhn6VlFt/fDwRzJjxYHqw5eVNpRNVH0UFFw5b9Eo+
         zOk8aYIAkxtz5FMx/UHb/kF6Ot6RC6bmMYDWAqhj5sXtImYHfMaaMo+Jy6cNcrY4XHQN
         UknhmF0ukPZRP/HibSRXvFuYjLvoCurtUwSc5m8PeZaQ0D5dIM9Knh1U9kCSGgXk7Qnv
         wkzg5EFUqNTYKdMupkWhuMoSN2/vd+y6lnt2Bx8uCmD9XOEyPLsGt7iBc2ScceesvDA2
         ZFHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717748461; x=1718353261;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dIRi7p8AxnKST2wIWmYIffowe3bT/Gjz3uWH4Z5QtKA=;
        b=VJAoaB7fEPwuRlT5J/hihdoegqixPbETKOJmQdQq6rgnLJIRd8xdTwuUD2ogQNVGMX
         rNf2rl88i7g9MuVDEf694npKQPKtdWABOuIq89fC+81ap8Y/P7LoKM2eF4BEbqY6lW50
         7lyzDnkUAGQ9bhRiMguF2mBLn5H9lzdej6mTxDfftLiFghjqvzyF1DBOJrsP+29V5qnv
         nR94eiiwkEVpxFOhUZgCo1LaupcKbI2dWhkQ3RXECHmuq6KD2P226QEkQlm5FXKE8E/O
         yNyEoHmozH1UxmH1H6kWJhG8qyT8551JJIiOlGjNu1+QbCR1BJlzi51OQ4IoQnkfHQ7u
         +6xA==
X-Forwarded-Encrypted: i=1; AJvYcCVruXuACO96AA9QNcyyh0Z555YcambrTFhVybqAczRm4Sfy8zbSPxZQLnPtTes+PseRwt0YNQirJrRt0tifhSwN96K5rWfvxYKTNFry
X-Gm-Message-State: AOJu0YxeLWyWiT57rOKBjbKUDF3CMSL2gAJTS/hIRDw/M8WwcphrLCwp
	UVi0qPTKaPSR212qbjhaG7ZstiumY2z0/mRBBukD/XHKWGBIPGi4nxIFy14ayvdH+bFgM0mMWXY
	TYPHZlP1ukXDzeoXJ0IDn9zPrEIY=
X-Google-Smtp-Source: AGHT+IF5gwhB1qXYVcJrC0tYeUuMxsp4wRAa8PowppUPXs9wYHraxiaHKK+B1vjvBRy620QwZtcjraXzUsLQzwNJrg4=
X-Received: by 2002:a05:6870:32d0:b0:23d:a1d0:7334 with SMTP id
 586e51a60fabf-254644db892mr1912516fac.17.1717748460840; Fri, 07 Jun 2024
 01:21:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240606070645.3295-1-xuewen.yan@unisoc.com> <0763f870-e30c-46cf-aefa-b879f2ebdba4@arm.com>
In-Reply-To: <0763f870-e30c-46cf-aefa-b879f2ebdba4@arm.com>
From: Xuewen Yan <xuewen.yan94@gmail.com>
Date: Fri, 7 Jun 2024 16:20:49 +0800
Message-ID: <CAB8ipk_TjqoNetBZ7dbjRxuBHAP=nz9=ZNomnjnaCEikLQSK2A@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: Prevent cpu_busy_time from exceeding actual_cpu_capacity
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Xuewen Yan <xuewen.yan@unisoc.com>, vincent.guittot@linaro.org, mingo@redhat.com, 
	peterz@infradead.org, juri.lelli@redhat.com, rostedt@goodmis.org, 
	bsegall@google.com, mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com, 
	vincent.donnefort@arm.com, qyousef@layalina.io, ke.wang@unisoc.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Dietmar

On Fri, Jun 7, 2024 at 3:19=E2=80=AFPM Dietmar Eggemann
<dietmar.eggemann@arm.com> wrote:
>
> On 06/06/2024 09:06, Xuewen Yan wrote:
> > Because the effective_cpu_util() would return a util which
> > maybe bigger than the actual_cpu_capacity, this could cause
> > the pd_busy_time calculation errors.
>
> Doesn't return effective_cpu_util() either scale or min(scale, util)
> with scale =3D arch_scale_cpu_capacity(cpu)? So the util sum over the PD
> cannot exceed eenv->cpu_cap?

In effective_cpu_util, the scale =3D arch_scale_cpu_capacity(cpu);
 Although there is the clamp of eenv->pd_cap, but let us consider the
following simple scenario:
The pd cpus are 4-7, and the arch_scale_capacity is 1024, and because
of cpufreq-limit,
the cpu_actual_cap =3D 512. Then the eenv->cpu_cap =3D 512, the eenv->pd_ca=
p =3D 2048;
effective_cpu_util(4) =3D 1024;
effective_cpu_util(5) =3D 1024;
effective_cpu_util(6) =3D 256;
effective_cpu_util(7) =3D 0;

Without this patch, the eenv->pd_busy_time =3D 2048, because the clamp
of eenv->pd_cap.
However, indeed, the cpu4 and cpu5's util would not exceed the actual_cap(5=
12),
so the cpu_util4/5 =3D 512, instead of 1024.
And with this patch, the eenv->pd_busy_time =3D 512+512+256 =3D 1280.
And the 1280 should be more reasonable.

BR
--
xuewen

> Looks like this was the case with 3e8c6c9aac42 already.
>
> > So clamp the cpu_busy_time with the eenv->cpu_cap, which is
> > the actual_cpu_capacity.
> >
> > Fixes: 3e8c6c9aac42 ("sched/fair: Remove task_util from effective utili=
zation in feec()")
> > Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
> > ---
> >  kernel/sched/fair.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 8a5b1ae0aa55..8939d725023a 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -7870,7 +7870,9 @@ static inline void eenv_pd_busy_time(struct energ=
y_env *eenv,
> >       for_each_cpu(cpu, pd_cpus) {
> >               unsigned long util =3D cpu_util(cpu, p, -1, 0);
> >
> > -             busy_time +=3D effective_cpu_util(cpu, util, NULL, NULL);
> > +             util =3D effective_cpu_util(cpu, util, NULL, NULL);
> > +             util =3D min(eenv->cpu_cap, util);
> > +             busy_time +=3D util;
> >       }
> >
> >       eenv->pd_busy_time =3D min(eenv->pd_cap, busy_time);
>

