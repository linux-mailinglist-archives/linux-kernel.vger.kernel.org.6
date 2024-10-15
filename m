Return-Path: <linux-kernel+bounces-365814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B754B99EA3F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 14:48:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DACAD1C20AA5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 12:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B3201C07EB;
	Tue, 15 Oct 2024 12:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PXOG84ZB"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7775B1C07D4
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 12:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728996483; cv=none; b=dJS1t7Ur2EmZ0/OLjcBb6tFOUtaonMWWnWkuGiUqyMMxiKOMEc9XNQrgPcC6NCjwJ8kwJvVGKleBtUiBge/r3NdwR/ZLVJnCo0ufJC0iK0vusprGym+NtX461v6zeWAcnb3IQFx8ELHLuHi3COcXvnN40XO4Gee9Eix1PXG8GGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728996483; c=relaxed/simple;
	bh=IO77FHLymBPgyQi1QtGwOt9Ng65gqPaA/UBtjbGnv40=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NduWdNUozS325WZYkynf641Vhf7FSdnZ9+GD/hvG3iPzsw1oavJnA7n/tirsFwmewGc+Ec2UUMxu+DI2xtpOo49bfABrZ37++ikDe1ZZwPclFcRubBtuEfaOun2x3fiLwoADsU9SBJW+wRug8cdvQJq4BjGxbxkwJT1HNDKTsEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PXOG84ZB; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-71e5a62031aso1701766b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 05:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728996481; x=1729601281; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+7NhPPrC8VuVTV14xQVxCrkyz6izEiR7QEgNjEcJGCc=;
        b=PXOG84ZBgpkndyDVj0zw3uXxe1gO8SPDT82Fb0p7WQiphqko5kQEVUYtqs3UtsD8SI
         YJxSiTKEkT1cQ4dGEDPBxt9ndX/nR+C9Q/xQPn+6w9Op2E9alDKhOI5akQ/Dj2WrTZXx
         HV+yDi14052Du+6yMflWyjDi6M4v5lHJX3xRFEZfErO7mhm9oHWfng2aD904S6fDXVZw
         0yROZQ9j6rLnb931tqHCOEecwY7SodtSq22Rj2H2QmxOhdAxKe3d4XYx+clZlHOmRefo
         c1Q7ykoODzwCVh4F4OxKmtM98ioe/FZ5uz3g1BsupR4hrrrUsVOJ0oixDxWYMKki93sU
         AbmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728996481; x=1729601281;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+7NhPPrC8VuVTV14xQVxCrkyz6izEiR7QEgNjEcJGCc=;
        b=FiSo4isqNUk2ofQhl1SRH1RjJ/hXJBCWhVLcNAC7fmoaB42IC8HeLIZfr8ntRzPBD1
         1qPNs7TILL4wxC5TXV4Am/oJaVGWeMQaSgm4ja0h6vddoZy/VCIAD0VT4itWgczKrnAR
         q8zl4NJua9dO7Fx/CkcuJ+21uiUVNn7l8tOAeP8L847Nldollr8/Ut23NEiAOBgRqBeZ
         25usgEyYdX9VUJ8V46sv6Io6Ackzn3LlQ/LAaEKxN7xQ0mu0Ed9IF8pbeQ6hYUPwLFh0
         qGNprZnkUQ/y0SuBJ4UdTs4zR1JRtKssNQZYsq1QgEWQe/cR1lePS7/HEZfpSiDEmsRM
         Xp7A==
X-Forwarded-Encrypted: i=1; AJvYcCUa9KIQ2k0NCWTO1qEBKfFoSQQ7VTgVn5gMVbIc20fJnVLNdoRUkrFYV7QxBxvi9S6y6TZpaf1tMmoAv2E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1yH1yngutn7RrKPLOPFR8uAo9ojfxu6NhCRkgjFs1otFF3k/D
	YYN25t6HuI/u2zoWZo4idaPVmmkiQ8eIJb5rlNrK7s+m6EHZa3NX2Y+9FLOsVcOmEEEHzCFqJS2
	O9JkWdQbd6GQ3C5yJ/UkO81GuJwa+Z5m6bcJBbg==
X-Google-Smtp-Source: AGHT+IGMVUKNTw/eVfMH2L0U2HxiBnw2mwGkdXdC/d5Lw7VXU0JVPNTdWAdeI5aec29xd5fcXJSBGeJpjTvaYYDKZPU=
X-Received: by 2002:a05:6a00:2e97:b0:71e:cc7:c507 with SMTP id
 d2e1a72fcca58-71e4c1cf183mr20943846b3a.23.1728996480484; Tue, 15 Oct 2024
 05:48:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240830130309.2141697-1-vincent.guittot@linaro.org>
 <20240830130309.2141697-5-vincent.guittot@linaro.org> <64ed0fb8-12ea-4452-9ec2-7ad127b65529@arm.com>
 <66583e86-e2a7-4e4f-bd45-40ea2d4a21df@arm.com> <CAKfTPtAooR2Qqko6Cfe=hQiTqJEzHX0j5uydza-SxdGDTsoGYA@mail.gmail.com>
 <ae1d8de4-dbd2-44fd-b4a4-ce1c63286c1d@arm.com> <CAKfTPtB5LfT7Rr1RRhqnQcLxhHN_w9APn4E9rf4-uBC2oofG8Q@mail.gmail.com>
 <59b31e93-9784-493d-8c85-10e07aabd86b@arm.com>
In-Reply-To: <59b31e93-9784-493d-8c85-10e07aabd86b@arm.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Tue, 15 Oct 2024 14:47:49 +0200
Message-ID: <CAKfTPtD6fck1=jQS3d4oDYCWsOX4f1oAkd6FA7v9oe6Zuj6C0A@mail.gmail.com>
Subject: Re: [RFC PATCH 4/5] sched/fair: Use EAS also when overutilized
To: Pierre Gondois <pierre.gondois@arm.com>
Cc: Christian Loehle <christian.loehle@arm.com>, qyousef@layalina.io, hongyan.xia2@arm.com, 
	mingo@redhat.com, peterz@infradead.org, linux-kernel@vger.kernel.org, 
	rafael.j.wysocki@intel.com, lukasz.luba@arm.com, vschneid@redhat.com, 
	mgorman@suse.de, bsegall@google.com, rostedt@goodmis.org, 
	dietmar.eggemann@arm.com, juri.lelli@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 11 Oct 2024 at 14:52, Pierre Gondois <pierre.gondois@arm.com> wrote=
:
>
> Hello Vincent,
>
> On 10/9/24 10:53, Vincent Guittot wrote:
> > Hi Pierre,
> >
> > On Mon, 7 Oct 2024 at 09:03, Pierre Gondois <pierre.gondois@arm.com> wr=
ote:
> >>
> >> Hello Vincent,
> >>
> >> Sorry for the delay:
> >>
> >> On 9/25/24 15:28, Vincent Guittot wrote:
> >>> On Thu, 19 Sept 2024 at 10:26, Pierre Gondois <pierre.gondois@arm.com=
> wrote:
> >>>>
> >>>> Hello Vincent,
> >>>> I tried this patch on a Pixel 6 (8 CPUs, 4 little, 2 mid, 2 big)
> >>>> with patches 1-4/5 using these workloads:
> >>>> ---
> >>>> A.
> >>>> a. 8 tasks at 2%/5%/10% during 1s
> >>>> b. 1 task:
> >>>>       - sleeping during 0.3s
> >>>>       - at 100% during 0.3s
> >>>>       - sleeping during 0.3s
> >>>>
> >>>> b. is used to reach the overutilized state during a limited amount o=
f time.
> >>>> EAS is then operating, then the load balancer does the task placemen=
t, then EAS
> >>>> is operating again.
> >>>>
> >>>> B.
> >>>> a. 8 tasks at 2%/5%/10% during 1s
> >>>> b. 1 task:
> >>>>       - at 100% during 1s
> >>>>
> >>>> ---
> >>>> I'm seeing the energy consumption increase in some cases. This seems=
 to be
> >>>> due to feec() migrating tasks more often than what the load balancer=
 does
> >>>> for this workload. This leads to utilization 'spikes' and then frequ=
ency
> >>>> 'spikes', increasing the overall energy consumption.
> >>>> This is not entirely related to this patch though,, as the task plac=
ement seems
> >>>> correct. I.e. feec() effectively does an optimal placement given the=
 EM and
> >>>> task utilization. The task placement is just a bit less stable than =
with
> >>>> the load balancer.
> >>>
> >>> Would patch 5 help to keep things better placed ? in particular if
> >>> task b is misplaced at some point because of load balance ?
> >>
> >> I assume so, it would require more testing on my side
> >>
> >>>
> >>> I agree that load balance might still contribute to migrate task in a
> >>> not energy efficient way
> >>>
> >>>>
> >>>> ---
> >>>> Regarding hackbench, I've reproduced the test you've run on the same=
 Pixel6.
> >>>> I have CONFIG_SCHED_CLUSTER enabled, which allows having a sched dom=
ain for
> >>>> each little/mid/big CPUs (without the config, these group would no e=
xist).
> >>>
> >>> Why did you do this ? All cpus are expected to be in same sched domai=
n
> >>> as they share their LLC
> >>
> >> I did this to observe the loa balancer a bit more carefully while revi=
ewing
> >> the first patch:
> >>     sched/fair: Filter false overloaded_group case for EAS
> >> I've let this configuration, but effectively this should not bring any=
thing more.
> >>
> >>
> >>>
> >>>>
> >>>> I see an important regression in the result.
> >>>> I replaced the condition to run feec() through select_task_rq_fair()=
 by:
> >>>>      if (get_rd_overloaded(cpu_rq(cpu)->rd) =3D=3D 0)) {
> >>>
> >>> overloaded is enable when more than 1 task runs on a cpu whatever the
> >>> utilization
> >>
> >> Yes right, this idea has little sense.
> >>
> >>>
> >>>>        new_cpu =3D find_energy_efficient_cpu(p, prev_cpu);
> >>>>        ...
> >>>>      }
> >>>> and obtained better results.
> >>>>
> >>>> Indeed, for such intensive workload:
> >>>> - EAS would not have any energy benefit, so better prioritize perfor=
mance
> >>>>      (as Christian mentioned)
> >>>> - EAS would not be able to find a fitting CPU, so running feec() sho=
uld be
> >>>>      avoided
> >>>> - as you mention in the commit message, shuffling tasks when one CPU=
 becomes
> >>>>      momentarily overutilized is inefficient energy-wise (even thoug=
h I don't have
> >>>>      the numbers, it should make sense).
> >>>> So detecting when the system is overloaded should be a better compro=
mise I
> >>>> assume. The condition in sched_balance_find_src_group() to let the l=
oad balancer
> >>>> operate might also need to be updated.
> >>>>
> >>>> Note:
> >>>> - base: with patches 1-4/5
> >>>> - _ou: run feec() when not overutilized
> >>>> - _ol: run feec() when not overloaded
> >>>> - mean: hackbench execution time in s.
> >>>> - delta: negative is better. Value is in percentage.
> >>>
> >>> Could you share your command line ? As explained in the cover letter =
I
> >>> have seen some perf regressions but not in the range that you have
> >>> below
> >>>
> >>> What is your base ? tip/sched/core ?
> >>
> >> I am working on a Pixel6, with a branch based on v6.8 with some schedu=
ler patches
> >> to be able to apply your patches cleanly.
> >
> > TBH, I'm always cautious with those kind of frankenstein kernel
> > especially with all changes that have happened on the scheduler since
> > v6.8 compared to tip/sched/core
>
> Yes I understand, I'll re-test it on a Juno with a newer kernel.
>
> >
> >>
> >> The mapping id -> command line is as:
> >
> > Thanks for the commands details, I'm going to have a look
> >
> >> (1) hackbench -l 5120 -g 1
> >> (2) hackbench -l 1280 -g 4
> >> (3) hackbench -l 640  -g 8
> >> (4) hackbench -l 320  -g 16
> >>
> >> (5) hackbench -p -l 5120 -g 1
> >> (6) hackbench -p -l 1280 -g 4
> >> (7) hackbench -p -l 640  -g 8
> >> (8) hackbench -p -l 320  -g 16
> >>
> >> (9) hackbench -T -l 5120 -g 1
> >> (10) hackbench -T -l 1280 -g 4
> >> (11) hackbench -T -l 640  -g 8
> >> (12) hackbench -T -l 320  -g 16
> >>
> >> (13) hackbench -T -p -l 5120 -g 1
> >> (14) hackbench -T -p -l 1280 -g 4
> >> (15) hackbench -T -p -l 640  -g 8
> >> (16) hackbench -T -p -l 320  -g 16
> >>
> >>
> >>>
> >>>> =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=AC=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=AC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=AC=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=AC=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=AC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=AC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=AC=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=AC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=90
> >>>> =E2=94=82 id  =E2=94=86 mean_base =E2=94=86 std_base =E2=94=86 mean_=
ou =E2=94=86 std_ou   =E2=94=86 mean_ol =E2=94=86 std_ol   =E2=94=86 delta_=
ou =E2=94=86 delta_ol =E2=94=82
> >>>> =E2=95=9E=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=AA=E2=
=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=
=90=E2=95=90=E2=95=90=E2=95=AA=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=
=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=AA=E2=95=90=E2=95=90=E2=
=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=AA=E2=95=
=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=
=E2=95=90=E2=95=AA=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=
=95=90=E2=95=90=E2=95=90=E2=95=AA=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=
=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=AA=E2=95=90=E2=95=90=
=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=
=95=AA=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=
=90=E2=95=90=E2=95=90=E2=95=A1
> >>>> =E2=94=82 1   =E2=94=86 1.9786    =E2=94=86 0.04719  =E2=94=86 3.085=
6  =E2=94=86 0.122209 =E2=94=86 2.1734  =E2=94=86 0.045203 =E2=94=86 55.95 =
   =E2=94=86 9.85     =E2=94=82
> >
> > I might have misunderstood your results above last time.
> > mean_base results include patches 1 to 4 and  mean_ou revert patch 4.
> > Does it mean that it is 55% better with patch 4 ? I originally thought
> > there was a regression with patch 4 but I'm not sure that I understood
> > correctly after re reading the table.
>
> The columns are:
> - the _base configuration disables EAS/feec() when in the overutilized st=
ate,
>    i.e. patches 1-3 are applied.

your original description
"
 - base: with patches 1-4/5
 - _ou: run feec() when not overutilized
 - _ol: run feec() when not overloaded
"
was quite confusing :-)

Thanks for the clarification

> - the _ou configuration keeps running EAS/feec() when in the overutilized=
 state
>    i.e. patches 1-4 are applied
> - the _ol configuration should be ignored as previously established
>
>
> >
> >>>> =E2=94=82 2   =E2=94=86 1.8991    =E2=94=86 0.019768 =E2=94=86 2.667=
2  =E2=94=86 0.135266 =E2=94=86 1.98875 =E2=94=86 0.055132 =E2=94=86 40.45 =
   =E2=94=86 4.72     =E2=94=82
> >>>> =E2=94=82 3   =E2=94=86 1.9053    =E2=94=86 0.014795 =E2=94=86 2.576=
1  =E2=94=86 0.141693 =E2=94=86 2.06425 =E2=94=86 0.045901 =E2=94=86 35.21 =
   =E2=94=86 8.34     =E2=94=82
> >>>> =E2=94=82 4   =E2=94=86 1.9586    =E2=94=86 0.023439 =E2=94=86 2.582=
3  =E2=94=86 0.110399 =E2=94=86 2.0955  =E2=94=86 0.053818 =E2=94=86 31.84 =
   =E2=94=86 6.99     =E2=94=82
> >>>> =E2=94=82 5   =E2=94=86 1.746     =E2=94=86 0.055676 =E2=94=86 3.343=
7  =E2=94=86 0.279107 =E2=94=86 1.88    =E2=94=86 0.038184 =E2=94=86 91.51 =
   =E2=94=86 7.67     =E2=94=82
> >>>> =E2=94=82 6   =E2=94=86 1.5476    =E2=94=86 0.050131 =E2=94=86 2.683=
5  =E2=94=86 0.140497 =E2=94=86 1.5645  =E2=94=86 0.081644 =E2=94=86 73.4  =
   =E2=94=86 1.09     =E2=94=82
> >>>> =E2=94=82 7   =E2=94=86 1.4562    =E2=94=86 0.062457 =E2=94=86 2.356=
8  =E2=94=86 0.119213 =E2=94=86 1.48425 =E2=94=86 0.06212  =E2=94=86 61.85 =
   =E2=94=86 1.93     =E2=94=82
> >>>> =E2=94=82 8   =E2=94=86 1.3554    =E2=94=86 0.031757 =E2=94=86 2.060=
9  =E2=94=86 0.112869 =E2=94=86 1.4085  =E2=94=86 0.036601 =E2=94=86 52.05 =
   =E2=94=86 3.92     =E2=94=82
> >>>> =E2=94=82 9   =E2=94=86 2.0391    =E2=94=86 0.035732 =E2=94=86 3.404=
5  =E2=94=86 0.277307 =E2=94=86 2.2155  =E2=94=86 0.019053 =E2=94=86 66.96 =
   =E2=94=86 8.65     =E2=94=82
> >>>> =E2=94=82 10  =E2=94=86 1.9247    =E2=94=86 0.056472 =E2=94=86 2.660=
5  =E2=94=86 0.119417 =E2=94=86 2.02775 =E2=94=86 0.05795  =E2=94=86 38.23 =
   =E2=94=86 5.35     =E2=94=82
> >>>> =E2=94=82 11  =E2=94=86 1.8923    =E2=94=86 0.038222 =E2=94=86 2.811=
3  =E2=94=86 0.120623 =E2=94=86 2.089   =E2=94=86 0.025259 =E2=94=86 48.57 =
   =E2=94=86 10.39    =E2=94=82
> >>>> =E2=94=82 12  =E2=94=86 1.9444    =E2=94=86 0.034856 =E2=94=86 2.667=
5  =E2=94=86 0.219585 =E2=94=86 2.1035  =E2=94=86 0.076514 =E2=94=86 37.19 =
   =E2=94=86 8.18     =E2=94=82
> >>>> =E2=94=82 13  =E2=94=86 1.7107    =E2=94=86 0.04874  =E2=94=86 3.444=
3  =E2=94=86 0.154481 =E2=94=86 1.8275  =E2=94=86 0.036665 =E2=94=86 101.34=
   =E2=94=86 6.83     =E2=94=82
> >>>> =E2=94=82 14  =E2=94=86 1.5565    =E2=94=86 0.056595 =E2=94=86 2.824=
1  =E2=94=86 0.158643 =E2=94=86 1.5515  =E2=94=86 0.040813 =E2=94=86 81.44 =
   =E2=94=86 -0.32    =E2=94=82
> >>>> =E2=94=82 15  =E2=94=86 1.4932    =E2=94=86 0.085256 =E2=94=86 2.684=
1  =E2=94=86 0.135623 =E2=94=86 1.50475 =E2=94=86 0.028336 =E2=94=86 79.75 =
   =E2=94=86 0.77     =E2=94=82
> >>>> =E2=94=82 16  =E2=94=86 1.4263    =E2=94=86 0.067666 =E2=94=86 2.397=
1  =E2=94=86 0.145928 =E2=94=86 1.414   =E2=94=86 0.061422 =E2=94=86 68.06 =
   =E2=94=86 -0.86    =E2=94=82
> >>>> =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=B4=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=B4=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=B4=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=B4=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=B4=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=B4=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=B4=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=B4=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=98
> >>>>
> >>>> On 9/17/24 22:24, Christian Loehle wrote:
> >>>>> On 8/30/24 14:03, Vincent Guittot wrote:
> >>>>>> Keep looking for an energy efficient CPU even when the system is
> >>>>>> overutilized and use the CPU returned by feec() if it has been abl=
e to find
> >>>>>> one. Otherwise fallback to the default performance and spread mode=
 of the
> >>>>>> scheduler.
> >>>>>> A system can become overutilized for a short time when workers of =
a
> >>>>>> workqueue wake up for a short background work like vmstat update.
> >>>>>> Continuing to look for a energy efficient CPU will prevent to brea=
k the
> >>>>>> power packing of tasks.
> >>>>>>
> >>>>>> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> >>>>>> ---
> >>>>>>     kernel/sched/fair.c | 2 +-
> >>>>>>     1 file changed, 1 insertion(+), 1 deletion(-)
> >>>>>>
> >>>>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> >>>>>> index 2273eecf6086..e46af2416159 100644
> >>>>>> --- a/kernel/sched/fair.c
> >>>>>> +++ b/kernel/sched/fair.c
> >>>>>> @@ -8505,7 +8505,7 @@ select_task_rq_fair(struct task_struct *p, i=
nt prev_cpu, int wake_flags)
> >>>>>>                    cpumask_test_cpu(cpu, p->cpus_ptr))
> >>>>>>                        return cpu;
> >>>>>>
> >>>>>> -            if (!is_rd_overutilized(this_rq()->rd)) {
> >>>>>> +            if (sched_energy_enabled()) {
> >>>>>>                        new_cpu =3D find_energy_efficient_cpu(p, pr=
ev_cpu);
> >>>>>>                        if (new_cpu >=3D 0)
> >>>>>>                                return new_cpu;
> >>>>>
> >>>>> Super quick testing on pixel6:
> >>>>> for i in $(seq 0 6); do /data/local/tmp/hackbench -l 500 -g 100 | g=
rep Time; sleep 60; done
> >>>>> with patch 5/5 only:
> >>>>> Time: 19.433
> >>>>> Time: 19.657
> >>>>> Time: 19.851
> >>>>> Time: 19.789
> >>>>> Time: 19.857
> >>>>> Time: 20.092
> >>>>> Time: 19.973
> >>>>>
> >>>>> mainline:
> >>>>> Time: 18.836
> >>>>> Time: 18.718
> >>>>> Time: 18.781
> >>>>> Time: 19.015
> >>>>> Time: 19.061
> >>>>> Time: 18.950
> >>>>> Time: 19.166
> >>>>>
> >>>>>
> >>>>> The reason we didn't always have this enabled is the belief that
> >>>>> this costs us too much performance in scenarios we most need it
> >>>>> while at best making subpar EAS decisions anyway (in an
> >>>>> overutilized state).
> >>>>> I'd be open for questioning that, but why the change of mind?
> >>>>> And why is this necessary in your series if the EAS selection
> >>>>> isn't 'final' (until the next sleep) anymore (Patch 5/5)?
> >>>>>

