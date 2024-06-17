Return-Path: <linux-kernel+bounces-216937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7099490A8CB
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 10:52:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DB641C209AA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 08:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78D5019066A;
	Mon, 17 Jun 2024 08:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r9C08OtD"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34620171B0
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 08:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718614334; cv=none; b=uQMM0RMHon34ykNpd4EHmUSKTaQMPVCeFma2RO0Uj/eMOKAFmTxUscrWoxQg/njd9npTrvyHseQSvP085ZvQNXFOjHSHUXwSJfGx5lzXr4IAEbZZJioRm72sqb0d0w7y3madbfrwXc8eLrtConzMSdm2YU3OZcW/SVLhdrWyv1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718614334; c=relaxed/simple;
	bh=FrE0pMO5zOzAVNmLstWP2Lj37py+4lIC+/1IX14+ZjQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ksgWY2EGw0S0L0akHlPMUUFs0av8xXV5At7B5ghoqpmVsgMt8m30csnAJSzKCaxotuUJGiFrXV6Q6KKO3IqjmIk81NnbhVOBhivMmfyQDPq3kx1tJPiwyo2F7UQEXxZujIvIPXgIeiHM6fhamtNQI2cMpuP81sjgau5OOwWRKrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=r9C08OtD; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-705c739b878so3325518b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 01:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718614332; x=1719219132; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OD8I+pqbh08jPvP+8sl9T3dgjSbA5oObfEw3j/UACYU=;
        b=r9C08OtDXADoLN/0U16++u9YMfYRoIEonKwHEYIPlktEhDff48v/an4X6AUPjyu7n0
         Jtv/Uxf47fKiDuqttwxIJa5iZdHn3UoegiXQNXi3Srvt9kNVdvUKFlYt1cJz0/yH1x6F
         FGgZpu/v9nYJLtumytrdzGphazAteGu8AGYlo5klT3ChaVu1WfdqA0SfKc2/2Q2hOnq1
         DaqGjw83kKTb8sXM9tnQ/iD7olGUGhGCNV/GsfTFJU1QCXMlSCibKglfaP3LuhnBIX/A
         SsZQADH2JdY2xKxhYoRPTrOFI6Y3dDGuZip0OzRfj4Urd34KQxZlmg1g229nN4y2Dzpx
         3Kvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718614332; x=1719219132;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OD8I+pqbh08jPvP+8sl9T3dgjSbA5oObfEw3j/UACYU=;
        b=qEjK22lyCQCa+BAhXimE5OZ8t4KmP5Sn+m99ERuDNUu9GS8cSh6iL/k/o7LIOsRK/B
         e4sx1FbQbsAXdc8RGl+dSEqxFG3hTqbSIaiMKDzv61Wspf8QuP/92U91sALfb6m9+TLE
         Y9LEcb+kuHuGTvDk75xOWuEM9lPtDW3NxjT8Lkhj3dlhuBVnkpt1yBdYY4GKIA2Pabs1
         WJnD2paY1m/wtphPfTdv6VLrtxi8Oo8h1Alg0sNbs3ZM0irsqmNDxaIOATNM5pTZfW9e
         wNrHnJwQdfiZfiiZltaproWiqBUkpn+BQ1n2qmVMW1pBUH8i0K0vJ4ygHJYt2oDDnW8E
         GyqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJAKGMoQGPCi++BeWBDMawhsIyzBQrVP1h4X6Dny5epqs0NcjDan84eWnF6rX3Yf71D7/ZGeC2eYACqY7KaOp6XOTRLGbtGAL+8dAN
X-Gm-Message-State: AOJu0YzyW6yckIl/D1eSJYTkVTGjnR5LkN/P+OFysU6Jy00yNtMITbgk
	o08QxTMmp0s3YxcwoQGWxbc0eoC8X2iZeL+o+ANDSJNhTK0zim5SwUXhTlDUdJzEL8exmqpRp6G
	VFLvbSjTZ/FluAV4gEoH+0MN4C1IuUMU1iDIejvdiLGwweQXe
X-Google-Smtp-Source: AGHT+IFpZsJvXA4Le6UsTGH1ECeAiGoJDC+BU1YbChDPuO8xaV6bxhxQjlfx58coHp0UwfES1CQs9fQI+fZF5DZH2sc=
X-Received: by 2002:a17:90b:1c02:b0:2c2:db4e:16eb with SMTP id
 98e67ed59e1d1-2c4da54259amr14844970a91.7.1718614332307; Mon, 17 Jun 2024
 01:52:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230105145159.1089531-1-kajetan.puchalski@arm.com>
 <20230105145159.1089531-3-kajetan.puchalski@arm.com> <20230711175814.zfavcn7xn3ia5va4@airbuntu>
 <ZLZ/btJw5LNVxVy8@e126311.manchester.arm.com> <20230718132432.w5xoxbqm54jmu6n5@airbuntu>
 <20230917010516.54dgcmms44wyfrvx@airbuntu> <CAKfTPtA6ZzRR-zMN7sodOW+N_P+GqwNv4tGR+aMB5VXRT2b5bg@mail.gmail.com>
 <d54d6115-a4d6-466b-a4a2-9c064194f06e@arm.com> <CAKfTPtB21aY9cgi5dSHB0jRp6pE85AfGcHrHjrcpMwi3fJL0FA@mail.gmail.com>
 <286d4cf8-814b-41a2-8d5f-2673dc737f45@arm.com> <CAKfTPtBh6ZDv7=1Tst1kjQjD=UjDG1DAaQOUCXvzP4ZhD94iTg@mail.gmail.com>
 <7ba09d9e-61dc-4d36-a401-0f89915fadfb@arm.com>
In-Reply-To: <7ba09d9e-61dc-4d36-a401-0f89915fadfb@arm.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Mon, 17 Jun 2024 10:52:01 +0200
Message-ID: <CAKfTPtBZvnk11fXB6QgmE_jtNje5N3a5RyB7cFZMRPGbJJ+7KA@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] cpuidle: teo: Introduce util-awareness
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: Kajetan Puchalski <kajetan.puchalski@arm.com>, rafael@kernel.org, daniel.lezcano@linaro.org, 
	Dietmar.Eggemann@arm.com, dsmythies@telus.net, yu.chen.surf@gmail.com, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Peter Zijlstra <peterz@infradead.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Qais Yousef <qyousef@layalina.io>
Content-Type: text/plain; charset="UTF-8"

On Wed, 12 Jun 2024 at 11:16, Lukasz Luba <lukasz.luba@arm.com> wrote:
>
>
>
> On 6/12/24 10:04, Vincent Guittot wrote:
> > On Wed, 12 Jun 2024 at 09:25, Lukasz Luba <lukasz.luba@arm.com> wrote:
> >>
> >> Hi Vincent,
> >>
> >> My apologies for delay, I was on sick leave.
> >>
> >> On 5/28/24 15:07, Vincent Guittot wrote:
> >>> On Tue, 28 May 2024 at 11:59, Lukasz Luba <lukasz.luba@arm.com> wrote:
> >>>>
> >>>> Hi Vincent,
> >>>>
> >>>> On 5/28/24 10:29, Vincent Guittot wrote:
> >>>>> Hi All,
> >>>>>
> >>>>> I'm quite late on this thread but this patchset creates a major
> >>>>> regression for psci cpuidle driver when using the OSI mode (OS
> >>>>> initiated mode).  In such a case, cpuidle driver takes care only of
> >>>>> CPUs power state and the deeper C-states ,which includes cluster and
> >>>>> other power domains, are handled with power domain framework. In such
> >>>>> configuration ,cpuidle has only 2 c-states : WFI and cpu off states
> >>>>> and others states that include the clusters, are managed by genpd and
> >>>>> its governor.
> >>>>>
> >>>>> This patch selects cpuidle c-state N-1 as soon as the utilization is
> >>>>> above CPU capacity / 64 which means at most a level of 16 on the big
> >>>>> core but can be as low as 4 on little cores. These levels are very low
> >>>>> and the main result is that as soon as there is very little activity
> >>>>> on a CPU, cpuidle always selects WFI states whatever the estimated
> >>>>> sleep duration and which prevents any deeper states. Another effect is
> >>>>> that it also keeps the tick firing every 1ms in my case.
> >>>>
> >>>> Thanks for reporting this.
> >>>> Could you add what regression it's causing, please?
> >>>> Performance or higher power?
> >>>
> >>> It's not a perf but rather a power regression. I don't have a power
> >>> counter so it's difficult to give figures but I found it while running
> >>> a unitary test below on my rb5:
> >>> run 500us every 19457ms on medium core (uclamp_min: 600).
> >>
> >> Mid cores are built differently, they have low static power (leakage).
> >> Therefore, for them the residency in deeper idle state should be
> >> longer than for Big CPU. When you power off the CPU you loose your
> >> cache data/code. The data needs to be stored in the L3 or
> >> further memory. When the cpu is powered on again, it needs code & data.
> >> Thus, it will transfer that data/code from L3 or from DDR. That
> >> information transfer has energy cost (it's not for free). The cost
> >> of data from DDR is very high.
> >> Then we have to justify if the energy lost while sleeping in shallower
> >> idle state can be higher than loading data/code from outside.
> >> For different CPU it would be different.
> >
> > I'm aware of these points and the residency time of an idle state is
> > set to reflect this cost. In my case, the idle time is far above the
> > residency time which means that we should get some energy saving.
> > cpu off 4.488ms
> > cluster off 9.987ms
> > vs
> > sleep duration 18.000ms
> >
> > Also, the policy of selecting a shallower idle state than the final
> > selected one doesn't work with PSCI OSI because cpuidle is only aware
> > of per CPU idle states but it is not aware of the cluster or
> > deeper/wider idle states so cpuidle doesn't know what will be the
> > final selected idle state. This is a major problem, in addition to
> > keep the tick firing
>
> I think we are aligned with this.
> Something has to change in this implementation of idle gov.
>
> I'm a bit more skeptical about your second point with PSCI.
> That standard might be to strong to change.

I'm not expecting to change PSCI but the cpuidle governor must keep in
mind that it doesn't have the full picture of the final selected idle
state of the system. Typically this means that doing a minus 1 on the
index of the selected cpuidle state is not correct and it must take
into account the final idle states selected outside cpuidle.

