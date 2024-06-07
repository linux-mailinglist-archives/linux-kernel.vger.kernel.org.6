Return-Path: <linux-kernel+bounces-205840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A05DD900110
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 12:38:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 534741F2598D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 10:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E15DA170830;
	Fri,  7 Jun 2024 10:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mj+UTIgy"
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2FE15DBB7
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 10:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717756690; cv=none; b=gsyPpHV5a+85GATAyrowgvj4Au4LjH9k4YDzl488t6rmki6APRNFgNsuhRC/bGCfInhjs9z/vDGJIgcE2PKcUIB05OSPW1EdDrWr3yI/ul7UmqrTrpX5m/2Y4LSo8DOt5vl9lZPMNQkvr91p9eO+zWUspX1USkeri3dGjlfBdRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717756690; c=relaxed/simple;
	bh=Z/mdWrkVlem1gY+MV04XH00y55hY9Gvc8F47rLQzxak=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=as5/E2TJpOQ+kLiv+SeLOLKQalDzxvaxDYGFkPdH1inHGkrmAfcFO8AXPKZgsNviP4bYgsMhdIPnMeVX6gysKqyxx2q+r27Z0dpqGjp1XxJJ0hn0KonYcvIs28Ug2jaILLDobFF5OWRwA6YRhQlSLUwnYebQqX2GVfcybX6gU+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mj+UTIgy; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3d20c0fe970so818355b6e.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 03:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717756688; x=1718361488; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xaI0Q81ruSBQnGTreVhaznQdvACwrU3yk1vhgUHVUX8=;
        b=mj+UTIgyh82SfEFrWGG6D/ZaDNa4rQoWrRtwUbfUm/mOoqB+eaQRsT/NDZhEdMTKn6
         aTi53nOeSMRjmd6yOq5eZ312CYSpOV9H1SznShH6pDrH5SDBF7nBe6imOp7MOKO2TPqX
         ht3WGFIpu5kc8pQLpJ6W9qW10EapXaXJF3XzkXnQM9dWUnUC3TuBhYc9FPb5Rj8tHIwn
         HVJSjSD6hOA0nB8TS/gXvqfg7DLAhpeU/QOjhRIiL3mMAeM7p9reTj3U5iBiZtpnZrSm
         /oVAxEWBzlh+2o0fNnFUBWr9sXiKYyXR/Ogt9zNcEyMZB5prAdwRGx0SSXRYpUxe2KWA
         RFoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717756688; x=1718361488;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xaI0Q81ruSBQnGTreVhaznQdvACwrU3yk1vhgUHVUX8=;
        b=wL0hInr89iywNYMFOk/HRnG4Gm4WKCvatEajuphMKT8J6lv9ztlFqr5XoBW/vtPVKZ
         d6Idj/yWg22KybaTt3r2MozI9O+9nJebYBQENEI26qxrLWHj/6CqwqEsfCvLDgTfvvAY
         fr1S1o2mUYxlflliGydtm0lF7UUqFSMyXTbAZRDieAH1QIWIMCCGh27elveUnIHdzJLS
         VVMM3KPJcPYu964y6As9OgQMPThtMwdmFCtm46dxNL38c0zsbtx75vB80z0lCBFZqr82
         SyQhA9VIddFNcRwEO3A0bcEuoFeUEM3ZB4Kk2obSARpP93Y7/CyeChfAGSS8TikO0aU8
         D8xQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgCextKk7pvjRve/62hqewKLh3qNdggtOCUi5sVKk94ZtXeicfbyA43FPnIyHrVIb/D0ZHO/Kn6okvtYMPqfIpSnvIol0fhtMCJINh
X-Gm-Message-State: AOJu0YzpNniwpO+T5Bli4jAM7TsRdh6+e0AjT0JQD/9BbtVdhpFU7GhF
	RSJxwICHGHSUovZ3BITSdP6+RXd4LbtrJpgQ9LrHpWpMKz5GsIvQsAFc5de++dNd2CKUhLW5BDy
	oa5ZXwX3yqui7y48FPSIKOMTRohhwRhn1
X-Google-Smtp-Source: AGHT+IH3ZG8BZiYUkU7Wq6xCqYhnRUGAwB86xQfmuDQZzoCnRqbRpoQ8xy+lXAfxXzp/AdSn0uKqbEyx7gijlkHCYJw=
X-Received: by 2002:a05:6808:14c2:b0:3d2:178b:3332 with SMTP id
 5614622812f47-3d2178b3407mr382541b6e.49.1717756686333; Fri, 07 Jun 2024
 03:38:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240606070645.3295-1-xuewen.yan@unisoc.com> <0763f870-e30c-46cf-aefa-b879f2ebdba4@arm.com>
 <CAB8ipk_TjqoNetBZ7dbjRxuBHAP=nz9=ZNomnjnaCEikLQSK2A@mail.gmail.com> <64115627-c6c7-416b-99f9-0df22cbdca6b@arm.com>
In-Reply-To: <64115627-c6c7-416b-99f9-0df22cbdca6b@arm.com>
From: Xuewen Yan <xuewen.yan94@gmail.com>
Date: Fri, 7 Jun 2024 18:37:54 +0800
Message-ID: <CAB8ipk-86-oJJ2XhJ2y5=ek3QwmMe0OJ+ry9FddmXrrChqu6+A@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: Prevent cpu_busy_time from exceeding actual_cpu_capacity
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Xuewen Yan <xuewen.yan@unisoc.com>, vincent.guittot@linaro.org, mingo@redhat.com, 
	peterz@infradead.org, juri.lelli@redhat.com, rostedt@goodmis.org, 
	bsegall@google.com, mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com, 
	vincent.donnefort@arm.com, qyousef@layalina.io, ke.wang@unisoc.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 7, 2024 at 6:30=E2=80=AFPM Dietmar Eggemann
<dietmar.eggemann@arm.com> wrote:
>
> On 07/06/2024 10:20, Xuewen Yan wrote:
> > Hi Dietmar
> >
> > On Fri, Jun 7, 2024 at 3:19=E2=80=AFPM Dietmar Eggemann
> > <dietmar.eggemann@arm.com> wrote:
> >>
> >> On 06/06/2024 09:06, Xuewen Yan wrote:
> >>> Because the effective_cpu_util() would return a util which
> >>> maybe bigger than the actual_cpu_capacity, this could cause
> >>> the pd_busy_time calculation errors.
> >>
> >> Doesn't return effective_cpu_util() either scale or min(scale, util)
> >> with scale =3D arch_scale_cpu_capacity(cpu)? So the util sum over the =
PD
> >> cannot exceed eenv->cpu_cap?
> >
> > In effective_cpu_util, the scale =3D arch_scale_cpu_capacity(cpu);
> >  Although there is the clamp of eenv->pd_cap, but let us consider the
> > following simple scenario:
> > The pd cpus are 4-7, and the arch_scale_capacity is 1024, and because
> > of cpufreq-limit,
>
> Ah, this is due to:
>
> find_energy_efficient_cpu()
>
>    ...
>    for (; pd; pd =3D pd->next)
>        ...
>        cpu_actual_cap =3D get_actual_cpu_capacity(cpu)
>
>        for_each_cpu(cpu, cpus)
>            ...
>            eenv.pd_cap +=3D cpu_actual_cap
>
> and:
>
> get_actual_cpu_capacity()
>
>    ...
>    capacity =3D arch_scale_cpu_capacity(cpu)
>
>    capacity -=3D max(hw_load_avg(cpu_rq(cpu)), cpufreq_get_pressure(cpu))
>
> which got introduced by f1f8d0a22422 ("sched/cpufreq: Take cpufreq
> feedback into account").

I don't think it was introduced by f1f8d0a22422, because f1f8d0a22422
just replaced the cpu_thermal_cap with get_actual_cpu_capacity(cpu).
The eenv.cpu_cap was  introduced by 3e8c6c9aac42 ("sched/fair: Remove
task_util from effective utilization in feec()").

BR
---
xuewen

>
> [...]

