Return-Path: <linux-kernel+bounces-211151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB581904DB9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 10:11:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 944D81F21AE7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 08:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A254716D306;
	Wed, 12 Jun 2024 08:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Crx0GyBK"
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54B916C878
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 08:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718179895; cv=none; b=JhBkXVmzd1SUNvetuuBO2vZ3Oc7ZQialdqicAUBmqH79FDAJ9Sd78JwIdDjOaTfdwS/evGougrTGT/24HzX6bmBWHyFjsHF8mveqkYX0HhKHUJ4F8MEWlOTDnK/gNPJaFHog78hANd8SW2m37hE7vLy6lWHpTQkrBGe6obrPRG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718179895; c=relaxed/simple;
	bh=o/83bP/Kgt021W/Xs4v4B6cZ9tybAWx60f4FgAlbeuo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JubfLTS06sA5b7pcomuMRaE6dfpqo7OEqdNohGNMn8r0PDLCIwIPs2Jfk4KzOsaCGKjPBU6W+YLIFLqjDbjel9k0kZAIXwxo+7JzKm81t/H+1qMtNJ0O9peRHzVCuTFRjY/3dnG5/hOJTCO07p6T1OkNpV7q6rkpMAepj2qKYRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Crx0GyBK; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5bafe063f35so299917eaf.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 01:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718179893; x=1718784693; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jtUCsNEN1OLn5CWnbEq8DyQzZdykGreH7aUIN+pkvSo=;
        b=Crx0GyBKN1SDVLT7nYH8zBXsmCCKraGc8DaS2ZC5oS2ePWjcqnLPrYnCeGmkqJPh/q
         PDFKQLMRTGTOYGGkSI33Ftsgpym/l4btS4ErbFMec9ZBDQr//B6PWuvmVudpxcKfoPCp
         sLZxfolRLEcrAKpwZmsKXOx+FJxWx+Y7vW7dZQSjKYt5yaU2hS6HvXwBjh/SoyJRxjo8
         EDW/IA5aTDjxmVMfXsrUW0gftt5gRZxShG5utFzzcWcJc+NKR8APQ28E0ylhh4KpeLHm
         RHw+HO7nRCCLrqdsmaXP2cwx44Z6QEOQqfE1jj1bxVsTPS8URh0eqEeqN53bUchMR6Ge
         U8rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718179893; x=1718784693;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jtUCsNEN1OLn5CWnbEq8DyQzZdykGreH7aUIN+pkvSo=;
        b=VMEOPPDAMra+xxGZ5Tm7Jcf/lMvWf0ne0WtlnA1DViwDACoftJRF7aUFIWq9kg/bzK
         PNpysVxXsIOgzCR3e6F0Jzv4JOB1GO78G6ib5msSRIYo9YN+PiPdmVWI5u5efRJjdIhY
         wyM1vIFEN3MV8mDfnnOn4YvWTAFXw6TeLwuxSPOiedPwxFsvvNE+bfKI55uV0hqYCb7g
         Ld14eiyISj6ZMx+9aEBzj9Q7WGcdBAkWb3Ikm/NlszGVs9XjkUMvWruHL39XFFkDPl5V
         q9HbcPbrxnV1FS+9h3zRmRAkLsWZvsMdCCK+ayFMyl6Jf4/bxK+00y/kvQsxQt+eKBwW
         W+Aw==
X-Forwarded-Encrypted: i=1; AJvYcCVTigQ0lkCWSTD1ri51qVPrdoeRBrJ6gbdYs3XrhjflKMizYtWd/WoyIsfjLTly90p17t07u4KKecO5Ho4ln6zezzwoCNcIBogffORX
X-Gm-Message-State: AOJu0Ywhp79we8/mWOGCRsA8tz2OX8cTcf8+nWnXpLY0w8OuJdnAMU87
	jgIeIILwgbbNn0FMkPiWXFTbtHVT+XR6JAKbZeQaDmb86dNDUA/bboQKFykR2T5zH9u2K/H7a1D
	u7Vrpw7Osj27eFVjyXZtMOWRdzro=
X-Google-Smtp-Source: AGHT+IECgC2oHqDsxlvyzV/cACnerXz2243qmwjQzGItweUJ08q0MLhe29CXS0lfrpbzaZ22X3IRtwWP206QmA+KE2Q=
X-Received: by 2002:a05:6870:2194:b0:254:a157:651a with SMTP id
 586e51a60fabf-25513554843mr634783fac.9.1718179892726; Wed, 12 Jun 2024
 01:11:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240606070645.3295-1-xuewen.yan@unisoc.com> <20240609225520.6gnmx2wjhxghcxfo@airbuntu>
In-Reply-To: <20240609225520.6gnmx2wjhxghcxfo@airbuntu>
From: Xuewen Yan <xuewen.yan94@gmail.com>
Date: Wed, 12 Jun 2024 16:11:21 +0800
Message-ID: <CAB8ipk-9EVgyii3SGH9GOA3Mb5oMQdn1_vLVrCsSn1FmSQieOw@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: Prevent cpu_busy_time from exceeding actual_cpu_capacity
To: Qais Yousef <qyousef@layalina.io>
Cc: Xuewen Yan <xuewen.yan@unisoc.com>, vincent.guittot@linaro.org, mingo@redhat.com, 
	peterz@infradead.org, juri.lelli@redhat.com, dietmar.eggemann@arm.com, 
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, bristot@redhat.com, 
	vschneid@redhat.com, vincent.donnefort@arm.com, ke.wang@unisoc.com, 
	linux-kernel@vger.kernel.org, christian.loehle@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Qais

On Mon, Jun 10, 2024 at 6:55=E2=80=AFAM Qais Yousef <qyousef@layalina.io> w=
rote:
>
> On 06/06/24 15:06, Xuewen Yan wrote:
> > Because the effective_cpu_util() would return a util which
> > maybe bigger than the actual_cpu_capacity, this could cause
> > the pd_busy_time calculation errors.
> > So clamp the cpu_busy_time with the eenv->cpu_cap, which is
> > the actual_cpu_capacity.
>
> I actually think capping by pd_cap is something we should remove. Saturat=
ed
> systems aren't calculated properly especially when uclamp_max is used.
>
> But this might a bigger change and out of scope of what you're proposing.=
.

I agree, there are other things to consider before doing this.

>
> Did this 'wrong' calculation cause an actual problem for task placement?
> I assume the pd looked 'busier' because some CPUs were too busy.

This will not only affect calculations in scenarios with high temperatures.
Sometimes, users will set scalimg_max_freq to actively limit the CPU freque=
ncy,
so that even if the CPU load is large, the CPU frequency will not be very h=
igh.
At this time, even if tasks are placed on other CPUs in the same PD,
the energy increment may not be too large, thus affecting core selection.

>
> Was the system in overutilzied state? Usually if one CPU is that busy
> overutilized should be set and we'd skip EAS - unless uclamp_max was used=
.

As Christian said, This case occurs not only in the overutil scenario,
this scenario holds true as long as the actual-cpu-capacity caused by
the reduction in max cpu frequency is smaller than the cpu util.

Thanks!
---
xuewen
>
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
> > --
> > 2.25.1
> >

