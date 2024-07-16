Return-Path: <linux-kernel+bounces-253730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DC159325FF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 13:56:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFBC91C21813
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 11:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEB62199EAF;
	Tue, 16 Jul 2024 11:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lBj3LfsZ"
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859441991B6
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 11:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721130990; cv=none; b=Zki/cQmwkk20k5+ZtK4dOnHa2kyUzaAWVbYDJ217mn52T8bGFAVHA3nUYcd/DOyaGtf3JzJ809jTdHLVLmb96H+AdeuM995t900MCTeMDQZ5qCcVF5FQHNnQsyKsniFNuoifxZLIFzE8ht2F/feCv8ATnaduJkOEcammP3ozSa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721130990; c=relaxed/simple;
	bh=oQpiVufI9+fX3ZkwBnPWIl1e+cKvQctzJ/OWbA9O+Iw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tQBCueE6scnu5xOP35XoACEJpAw9thfv6377nPBcHGtUeG+8n1tIYMYUWAJWpe4hV1v5LPpwY/Zdd4POY4Nzqc+2BmtXVAWlmevhWjcyQTvA3b7jKjaX0sLTCpOsYLURNOkq9+V8HWnqfKDdFFc9pUc+qiEIO9BuJjuvprhsoEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lBj3LfsZ; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3dab3b85623so1719732b6e.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 04:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721130987; x=1721735787; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1nD4QC061U13Kl7W9ZeSg+Ir8jgpSm8fv5/7HD2vQrM=;
        b=lBj3LfsZeWfTmuoI/f7jt5Ct+k8ISfpYpU+0GLjl23IMK98rFbXo/b9m43Tt8XGonp
         +cfdzZRmn7W+frKPbUGgUScEcbm8eXdrtT2jxKhQEjnbmvTUog0tWAhn4d6k6fb9GXM/
         hIfr+2QnUGmIRDRvlg5C4uOA0tEhHQ9R01Z2+xj4p6sQ1rcCfw7SK7/RCgD2OPvEZznC
         fx6Qo8hbAv5OvB5A6cH5xV5Dz4iLINdpFR0h59bErCwMJ54ddyZPuiqvVk63U3JJO+Gy
         tMG5cnYzdCRw03X9hrwbdVV4yTvioZmguittReQ4fa4Vb1RNzdHg3eHHQG7Oo+qJ/Tn3
         xLeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721130987; x=1721735787;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1nD4QC061U13Kl7W9ZeSg+Ir8jgpSm8fv5/7HD2vQrM=;
        b=GjZsRoIEYUUxW8eC1fD6gog/m1a36pFGuTrJErpOfEFyKw+0Lg7jn44hGp82nHAoR9
         0cZ0OXm/5JIZ6w10zbkMWvM91idxvFu7JB9uY8MUdgBsV2FfPsczcYdoILRT6wguFQkG
         OUM5hAf87yHvjYy4Oo7geJAozy4EMGDLD1sBRpmFUMe9iSvn+s9kkn3j/dF61EDKwHPr
         HiUxy9Ko4PRmnK5UMJWht4ENklNh5oqGIdKIfBq1EzlraBQRVQCge3QR1III7vcQYNNd
         csXJyc7PXBXl3WiJb1s/mDwyeBjqucL/uOBoTwG+Ktk+KQL5CyyXOF0oU0ZHjF5yhVVf
         7qTw==
X-Forwarded-Encrypted: i=1; AJvYcCW3pboP3wWZ5BhO6pq2UfbU1YjFCfEcGRjT00ZF8BKpBdEK5cvssN1F0hY/H43P2S5DzJvEnuIM/EZ/lSxqo1DDjVsMQ2RB0px6SYFb
X-Gm-Message-State: AOJu0YxuBkHqlfG4kyle7vKM7h3VKlWCR1OdLMvlRO9fFN99ayZPMnmi
	hn+iU/mWESkW+EJ6j69vo5QgDGhEEls7SudtlUvgy40CokEUO/WEkfDRttAGy0oaKvFBnODzksH
	aJoRaJmlXzIt1t3sGxd6Q7IP8haA=
X-Google-Smtp-Source: AGHT+IHNwzJQUUVRzaD9wlXiBBt2ke98AXlxzccGZTl43Ow5QY/BSv9ZtkN+hCj9MH7khhuXr4W3ttWy9SavnB5yzLE=
X-Received: by 2002:a05:6870:7012:b0:25d:dea:456f with SMTP id
 586e51a60fabf-260bdfa14d9mr1316578fac.42.1721130987451; Tue, 16 Jul 2024
 04:56:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240624082011.4990-1-xuewen.yan@unisoc.com> <20240624082011.4990-3-xuewen.yan@unisoc.com>
 <20240628012832.37swdtxr4ds2kkp7@airbuntu> <CAKfTPtALDtnbPmq4401oLKzcEDurLKuCyqyNKOb1oYLAVJ2P4A@mail.gmail.com>
 <20240703115407.y6tjelkpq5njkzjy@airbuntu> <CAKfTPtCNEa+pAbo1br_1SDSn8=x67YMCi_jytpjUMHv7a9xMKA@mail.gmail.com>
 <20240704235652.n2wtpwck43umh4dq@airbuntu>
In-Reply-To: <20240704235652.n2wtpwck43umh4dq@airbuntu>
From: Xuewen Yan <xuewen.yan94@gmail.com>
Date: Tue, 16 Jul 2024 19:56:15 +0800
Message-ID: <CAB8ipk8ywd9q1zu54NRcz6Efi=qZZXUidtVtfWjcSb_dK_nQzA@mail.gmail.com>
Subject: Re: [PATCH V2 2/2] sched/fair: Use actual_cpu_capacity everywhere in util_fits_cpu()
To: Qais Yousef <qyousef@layalina.io>
Cc: Vincent Guittot <vincent.guittot@linaro.org>, Xuewen Yan <xuewen.yan@unisoc.com>, 
	dietmar.eggemann@arm.com, mingo@redhat.com, peterz@infradead.org, 
	juri.lelli@redhat.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com, 
	christian.loehle@arm.com, vincent.donnefort@arm.com, ke.wang@unisoc.com, 
	di.shen@unisoc.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 5, 2024 at 7:56=E2=80=AFAM Qais Yousef <qyousef@layalina.io> wr=
ote:
>
> On 07/03/24 16:54, Vincent Guittot wrote:
> > On Wed, 3 Jul 2024 at 13:54, Qais Yousef <qyousef@layalina.io> wrote:
> > >
> > > On 07/02/24 15:25, Vincent Guittot wrote:
> > >
> > > > > >        *
> > > > > >        * Only exception is for HW or cpufreq pressure since it =
has a direct impact
> > > > > >        * on available OPP of the system.
> > > > > > @@ -5011,7 +5011,7 @@ static inline int util_fits_cpu(unsigned =
long util,
> > > > > >        * For uclamp_max, we can tolerate a drop in performance =
level as the
> > > > > >        * goal is to cap the task. So it's okay if it's getting =
less.
> > > > > >        */
> > > > > > -     capacity_orig =3D arch_scale_cpu_capacity(cpu);
> > > > > > +     capacity_actual =3D get_actual_cpu_capacity(cpu);
> > > > > >
> > > > > >       /*
> > > > > >        * We want to force a task to fit a cpu as implied by ucl=
amp_max.
> > > > > > @@ -5039,7 +5039,7 @@ static inline int util_fits_cpu(unsigned =
long util,
> > > > > >        *     uclamp_max request.
> > > > > >        *
> > > > > >        *   which is what we're enforcing here. A task always fi=
ts if
> > > > > > -      *   uclamp_max <=3D capacity_orig. But when uclamp_max >=
 capacity_orig,
> > > > > > +      *   uclamp_max <=3D capacity_actual. But when uclamp_max=
 > capacity_actual,
> > > > > >        *   the normal upmigration rules should withhold still.
> > > > > >        *
> > > > > >        *   Only exception is when we are on max capacity, then =
we need to be
> > > > > > @@ -5050,8 +5050,8 @@ static inline int util_fits_cpu(unsigned =
long util,
> > > > > >        *     2. The system is being saturated when we're operat=
ing near
> > > > > >        *        max capacity, it doesn't make sense to block ov=
erutilized.
> > > > > >        */
> > > > > > -     uclamp_max_fits =3D (capacity_orig =3D=3D SCHED_CAPACITY_=
SCALE) && (uclamp_max =3D=3D SCHED_CAPACITY_SCALE);
> > > > > > -     uclamp_max_fits =3D !uclamp_max_fits && (uclamp_max <=3D =
capacity_orig);
> > > > > > +     uclamp_max_fits =3D (capacity_actual =3D=3D SCHED_CAPACIT=
Y_SCALE) && (uclamp_max =3D=3D SCHED_CAPACITY_SCALE);
> > > > >
> > > > > We should use capacity_orig here. We are checking if the CPU is t=
he max
> > > > > capacity CPU.
> > > >
> > > > I was also wondering what would be the best choice there. If we
> > > > consider that we have only one performance domain with all max
> > > > capacity cpus then I agree that we should keep capacity_orig as we
> > > > can't find a better cpu that would fit. But is it always true that =
all
> > > > max cpu are tied to the same perf domain ?
> > >
> > > Hmm I could be not thinking straight today. But the purpose of this c=
heck is to
> > > ensure overutilized can trigger for the common case where a task will=
 always
> > > fit the max capacity cpu (whether it's on a single pd or multiple one=
s). For
> > > that corner case fits_capacity() should be the only fitness check oth=
erwise
> > > overutilized will never trigger by default.
> >
> > Ok, so I messed up several use cases but in fact both are similar ...
> >
> > if capacity_actual !=3D SCHED_CAPACITY_SCALE and uclamp_max =3D=3D
> > SCHED_CAPACITY_SCALE
> > then uclamp_max_fits =3D (capacity_actual =3D=3D SCHED_CAPACITY_SCALE) =
&&
> > (uclamp_max =3D=3D SCHED_CAPACITY_SCALE) is false
> > and uclamp_max_fits =3D !uclamp_max_fits && (uclamp_max <=3D
> > capacity_actual); is also false because (uclamp_max <=3D
> > capacity_actual) is always false
> >
> > if capacity_actual =3D=3D SCHED_CAPACITY_SCALE and uclamp_max =3D=3D
> > SCHED_CAPACITY_SCALE
> > then we are the same as with capacity_orig
>
> Right. The condition is becoming less readable, but you're right it doesn=
't
> change functionality.
>
> Xuewen, could you put something in the commit message please to remind us=
 in
> the future that we thought about this and it is fine?

Sorry for the late reply. I will read all the emails carefully.
I am also studying the definition and usage of this function carefully.
I will send patch v3 as soon as I fully understand it.

Thanks!

>
> Thanks!
>
> --
> Qais Yousef

