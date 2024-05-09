Return-Path: <linux-kernel+bounces-174233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C25118C0BF4
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 09:26:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A1511F22707
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 07:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB6961494D2;
	Thu,  9 May 2024 07:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MZsAud3t"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD4513D270;
	Thu,  9 May 2024 07:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715239592; cv=none; b=rl7vppMn5FkvV0sX96NV4guY05kSh6QaNsbE9wwJVmHlR2d9vHFDje8IEpUU1FXHauNQhexjDezIus3y6pqDCoOXpRbNW0UyR/sKpglpSIs9e4pIZPN6F9ChHTemS6S06vfMYzzPWK5luvBa35yLP2x1tqDYt7IZIms1f6mHnv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715239592; c=relaxed/simple;
	bh=mSbNo9wFHWoeq8V0swf9aBjuFrGvwAyLh7olQz08M8U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PBEONpus4SOhrYOpxJuBoPxH0kvheb/vrAjlC8zvVQI6vuHf/QiMPYYkPhAJJDCv2C+n/AWYV5fwdpGDLUAzDmVDJRIVE/jzCQMkwd3AQakiB++PB3hDud6+RQDromJLqoX47kEjJ3m0QpR/nYRRpelGfWzZ4R55iMlYHMlLay0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MZsAud3t; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-43df3b00becso1373471cf.2;
        Thu, 09 May 2024 00:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715239590; x=1715844390; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R9y2y2IHmFNbKKYaQSA05sZKLTZb4i48PMVBUG60zwM=;
        b=MZsAud3tS4hA2lEt/DuDWV+2VzvliXY7aItgfWowAyLTq36UsgXy1HoWVsQwIPTDR0
         B6n59zE7YF39EgdXCIY5ljE2cwDyeDJJVUS1PRK9cqt2uuoJBW/t5M8uowZDDZ4cokh3
         9fOu12uGXtcIQL7DApVd4o6aAUZeT2N7LggDRzrAo7Okv04xzDf/6aRXds8TLagTqRJF
         AXW4Scy0mukvmvr7ketGkGqkVRHlYatoP2Su3Dsa3LtgA3hIFQwF4NzLhWxadez3hM5S
         /506r3Vf5IW3XtsHHr/943x0+eLlMhEPBbqcW7jKSRkWxHsWUh3ceqQCFbqs7/4Okr7C
         RfUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715239590; x=1715844390;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R9y2y2IHmFNbKKYaQSA05sZKLTZb4i48PMVBUG60zwM=;
        b=arjGHSdjKTMTyxdUzGuxLRP3ypZFzhMwt4R/EB7CP3T+cWuMDZa+quBDhYgKm16YwK
         s9iz728T04iiZBlUc1g2aOmHLB09af8r2Gc4FJqOXtmYmDAUJpTpegO0Ol02S005W27m
         TqkXE1WSjKuUai/TvU+XLrvB5pWNwNOg/BqNGVc5szwaGAssGeBaTeoHaAIVeD9PdvR+
         4QmD/vH1ma0Z9Dt/zaoiBmOQJIQaaCvzS1FC0K3enhrRARrrOsJG2heIIsky3JN4ME6l
         DTvxfzu7ulL21yDlq/hQZynpAMrJdCRz51rs7Skdd6rNfc2P6xcq5eP8J1taa4pWj111
         JV7w==
X-Forwarded-Encrypted: i=1; AJvYcCXV3YhzNWfr/ylpKUtOIaE1A45yaOwGFjnNTx5SFXe8sfz35ns8FwpmYYA6Wr+EVLWUEmcylBw+8fMM8Kj5bkG5yu7n+qH8amwNng7/
X-Gm-Message-State: AOJu0YxoEAC9VH/lJflFJ/reONqWqmX7BiSryw5vwM7+UPJPqsPJLrEB
	f1glfsqrhyn0nQ9SC25kZM/nPyPHpGaid3JY/mUrvjEhvyf5EgxSEOLt+OzwSZwbVbLHAEKlBcm
	yvVOXl2ZZIEPTAMkTmRwG08KAmxU=
X-Google-Smtp-Source: AGHT+IHZUWb+ZeLYyGH7omMVRhmmW6OAFOMgBEPLsq4PMidPUfZP0K1/ru2MJg5PuFbGt8u6o0RJlvW0G9CiTfdNr8Y=
X-Received: by 2002:ac8:7f8d:0:b0:43a:be54:ea0b with SMTP id
 d75a77b69052e-43dbf861d81mr50578151cf.64.1715239589766; Thu, 09 May 2024
 00:26:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240508172621.30069-1-ppbuk5246@gmail.com> <20240508192213.31050-1-ppbuk5246@gmail.com>
 <a407d12f-6845-4f51-a112-6bdc17641ff1@web.de>
In-Reply-To: <a407d12f-6845-4f51-a112-6bdc17641ff1@web.de>
From: Yun Levi <ppbuk5246@gmail.com>
Date: Thu, 9 May 2024 08:26:18 +0100
Message-ID: <CAM7-yPS6ecODhv-FQpYE5OE_LufmtKRg4htp9JH6MBUF03N4rA@mail.gmail.com>
Subject: Re: [PATCH v3] time/tick-sched: idle load balancing when nohz_full
 cpu becomes idle.
To: Markus Elfring <Markus.Elfring@web.de>
Cc: kernel-janitors@vger.kernel.org, 
	Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, 
	Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> Would you eventually like to add the tag =E2=80=9CFixes=E2=80=9D once mor=
e?

Sorry. I forgot :(

> > +++ b/kernel/time/tick-sched.c
> > @@ -1228,8 +1228,10 @@ void tick_nohz_idle_stop_tick(void)
> >               ts->idle_sleeps++;
> >               ts->idle_expires =3D expires;
> >
> > -             if (!was_stopped && tick_sched_flag_test(ts, TS_FLAG_STOP=
PED)) {
> > -                     ts->idle_jiffies =3D ts->last_jiffies;
> > +             if (tick_sched_flag_test(ts, TS_FLAG_STOPPED)) {
> > +                     if (!was_stopped)
> > +                             ts->idle_jiffies =3D ts->last_jiffies;
> > +
> >                       nohz_balance_enter_idle(cpu);
> >               }
> =E2=80=A6
>
> I interpret these diff data in the way that you propose to reorder
> two condition checks.
>
> But I wonder still how =E2=80=9Cgood=E2=80=9D the presented change descri=
ption fits to
> the suggested source code adjustment.

FWIW it doesn't need to check !was_stopped to
call nohz_balance_enter_idle() in tick_nohz_idle_stop_tick().
Formerly, __tick_nohz_idle_enter() is called in both
tick_nohz_irq_exit() and in do_idle().
That's why it's required for nohz full cpu which already stop the
tick, but not idle
to prevent enter idle balance.
(but it makes nohz full cpu enter nohz idle balance as side effect i think?=
)

 but after some reorganizing code tick_nohz_idle_stop_tick() becomes
the code called in
only when enter idle.

What I point is that it doesn't need to check !was_stopped to call
nohz_balance_enter_idle()
in tick_nohz_idle_stop_tick().

So, I think it's enough in commit message?

Am I wrong?

Thanks.

