Return-Path: <linux-kernel+bounces-265579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC2093F314
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 12:47:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 997431F228AD
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 10:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE0BF14372D;
	Mon, 29 Jul 2024 10:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DrN6V29a"
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE51B13D281
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 10:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722250053; cv=none; b=s8K/7ZMitMp4rndMq9LrB3VtccyotlmzyRCgSsr4wiE8zPrlbK+lV2L5kMVmJThS3a8CNwB4X8X+TrWiL4AizmyPxB21P+nyMVkXt+rj/f2DinCdEYB/o1E+OEr6XXPXZxK/iIJvAJcsWEcJoV4wFeTkp0udLyL0mH/mzixUEYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722250053; c=relaxed/simple;
	bh=1A9s1tSbmgkwPr+21mNtSsIaonsXbvUU//hWrE2epnU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rZKc+Ga9zDO+tx3ZXXYDCFMdb4twMAT0Zu3Otn4KKf1We9mQ5xMYpiommOwLgkCB2DXce9TMLGWyWBNlPysNv5Xnu/9nmPkx6k5+kTjl3qNIvd1JuDENsRDu2cY60x+GCiNuYjZjV/PqNAsABE7Mq8WxhTgaDnj3W1sLXNpwuUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DrN6V29a; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-70943713472so551885a34.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 03:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722250050; x=1722854850; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tOt+y8/Gt/rabaByfeyl/jxGLEMzEbqTr7urP1FN1Vk=;
        b=DrN6V29aYpFcIK4H9ZoeXtmPMBRkAu8P/H43jsF9DAT1p1lc/3Iar4wyGvY4Fj/QBP
         IT4K2zHM9M/9rQkIVo3QiLA9RuiGnlZXb1opLiZaLejJj4xWRM7XPOwyV8t9ZUbSd29w
         6eHOLhQ2Zi56ubsLe0AT938f1l/44h3IAWNZDmJA0hCyEcObr9FHvCjCmeOSVSELDuQN
         LdKity808ucAljtlCnX9aqe4VP0S8/bsf9K8Nf64duNaWjENLhJJoA69HlV6WxfSdORB
         houQ4S+LKAPO4VZRAsNSAMh7s5S1s1N7IYmeDV9OZ/NDYLRDLf9ZdKqh5Y0PwZ/rEX9x
         fAJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722250050; x=1722854850;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tOt+y8/Gt/rabaByfeyl/jxGLEMzEbqTr7urP1FN1Vk=;
        b=AKHsd2s3xjanZ+183ncfX04k4rEpaSINhlHkD+lb37xh3xfgGcA5YEnXMzS0q7+FsV
         deZzVIsVcWp66QvQYxukU60obLgGMpYjP+mVVujA80L/CBF1ooEjH68+Qi/+nfQd5xLb
         tquGqvPlppB/CCrNTr7tYDIsWNcnpdZoXLjpNzL6XXioRijpDHAX4DNBYQCD9rLjZyUq
         6FtWBa5wvxSsE2S2ccCqH+y9aap+fDVVq03sUECWO/C/GHdV9zx7TpW2eMpquJsxj938
         ntmEJ7WYNzNKlo+5ymoY3+KMCov+MRMATq3MC6D8tlz5u3yQjjORELfQqVg9BGh/C9ti
         nimw==
X-Forwarded-Encrypted: i=1; AJvYcCWOw0MWXEadwv6OrurFsvX4Ju5TI5UwqJ5SrvZ+Zp0s9F00mpbHc5wfrbKDzGe8jFZHTlNzhw9tawep7mA/Z/3RIynJIjkmb2yB14eT
X-Gm-Message-State: AOJu0Yzo18j7ntPQ0HFRuOfAMhNIYnoYUNZm3pR+S3ReSTtKv605+Ctc
	ScceVCJ7xnzEjc9BqQ5z7fgWN7HhooVmNke5X2/uC3d5yWrPPJyCYyHraIpk8sddRtO7O74kwCv
	9D90OBw+SGP+0pATublcWlGnHhZE=
X-Google-Smtp-Source: AGHT+IGUjcNYXZ2CwwZJnzS49Koq4hi2VhOuLor26wGWWOEHNRfs+sCErQPZ3ETtsAriHZcN7UnN75EpoSIWZ8LlW0k=
X-Received: by 2002:a05:6870:200b:b0:260:eae3:5ec2 with SMTP id
 586e51a60fabf-267d4ddc7dfmr11377624fac.26.1722250049693; Mon, 29 Jul 2024
 03:47:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231209011759.398021-1-qyousef@layalina.io> <20231209011759.398021-3-qyousef@layalina.io>
 <CAB8ipk9+4p29iE8HSiRrcc8DanCcO2U3+HRVY5LXLJRWXFMpOw@mail.gmail.com> <20240724213530.akr2ghuzabz3mfxw@airbuntu>
In-Reply-To: <20240724213530.akr2ghuzabz3mfxw@airbuntu>
From: Xuewen Yan <xuewen.yan94@gmail.com>
Date: Mon, 29 Jul 2024 18:47:18 +0800
Message-ID: <CAB8ipk-PwCvaAaRQSnCsybBTz_9xGw6aqsn+4p3PM8Amz3OedQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] sched/fair: Generalize misfit lb by adding a misfit reason
To: Qais Yousef <qyousef@layalina.io>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	linux-kernel@vger.kernel.org, Lukasz Luba <lukasz.luba@arm.com>, 
	Wei Wang <wvw@google.com>, Rick Yiu <rickyiu@google.com>, Chung-Kai Mei <chungkai@google.com>, 
	Xuewen Yan <xuewen.yan@unisoc.com>, John Stultz <jstultz@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Qais

On Thu, Jul 25, 2024 at 5:35=E2=80=AFAM Qais Yousef <qyousef@layalina.io> w=
rote:
>
> Hi Xuewen
>
> On 07/17/24 16:26, Xuewen Yan wrote:
> > Hi Qais
> >
> > On Sat, Dec 9, 2023 at 9:19=E2=80=AFAM Qais Yousef <qyousef@layalina.io=
> wrote:
>
> > > @@ -11008,6 +11025,7 @@ static struct rq *find_busiest_queue(struct l=
b_env *env,
> > >                  * average load.
> > >                  */
> > >                 if (env->sd->flags & SD_ASYM_CPUCAPACITY &&
> > > +                   rq->misfit_reason =3D=3D MISFIT_PERF &&
> >
> > In Android, I found this would cause a task loop to change the CPUs.
> > Maybe this should be removed. Because for the same capacity cpus, we
> > should skip this cpu when nr_running=3D1.
>
> Could you explain a bit more? Are you saying this is changing the behavio=
r for
> some use case? The check will ensure this path is only triggered for misf=
it
> upmigration. Which AFAICT the only reason why this path was added.
>
> The problem is that to implement another misfit reason, the check for
> capacity_greater() is not true except for MISFIT_PERF. For MISFIT_POWER, =
we
> want the CPU to be smaller.

Sorry, it was my mistake.
After debugging, I found that there was a problem with my handling of
MISFIT_PERF.
But it is true that due to the influence of rt and irq load,
capacity_greater() sometimes does cause some confusion.
Sometimes we find that due to the different capacities between small
cores, a misfit task will migrate several times between small cores,
for example:
If capacity_cpu3 > capacity_cpu2 > capacity_cpu1 >capacity_cpu0,
the misfit task may migrate as follows: cpu0->cpu1->cpu2->cpu3.
I don't know if this migration is really necessary, but it does cause
me some confusion.

Thanks!

>
> I think Vincent is working on a better way to handle all of this now.
>
> >
> > >                     !capacity_greater(capacity_of(env->dst_cpu), capa=
city) &&
> > >                     nr_running =3D=3D 1)
> > >                         continue;

