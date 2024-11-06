Return-Path: <linux-kernel+bounces-397354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A221A9BDAE9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 02:08:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BBD92826F8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 01:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FDBB16F8F5;
	Wed,  6 Nov 2024 01:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j0N6ILT5"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648AA383BF
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 01:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730855306; cv=none; b=JVwa8wV2+f7hC/DaBFLXOCEftHPHMzq5FM2rbjRd1kPbriuhDd9DCgzOdSJZGDbU9et4/nrC0A2I/8RiDBM6i9+xZerRYyUMt+3zciasVlMohTD99BiCyBj32A1jED/mhUsMZCYPoSbb4N3pGnF/XZqUTZ8SRFn2r/+FzLpH9fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730855306; c=relaxed/simple;
	bh=XNGjwvz4iRx6/Z/Gmi4NWM5HSOa5sIAc5abXsNLCWKw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qYDCc9K00msN4VTOSlt+h/Y9Toe3xAhqc+zQMmHaH5k5B8IbWlMGSLzN4/DtKv+p7qXCkSnOmlC3CESwzAX8Gbkz40wVS1/+OesVuphW9qZ+cRqzacpT3o8v6MmTdNtDuSh/x6KRdRmfKGCDaGENj8h0kpTR/XwIBb8ZOCrsy2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j0N6ILT5; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7ee4c57b037so3882093a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 17:08:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730855305; x=1731460105; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ryi/pi3lUq1wNHyZErKlGkkga91D15R+NN0ELpaycaY=;
        b=j0N6ILT5fDtLSp+WQy66lgSCJAI38Lj61eJLN0v2zswzX51kqglOdB+SoeEXMIqIsU
         uL0N0M3o1YfbbSpe6o7piS+mmmyiZNQEzD+RZJY2BRuIe3Z6QPjDRJ0tY5upcK1Xa0KO
         H8jeYS4JdQuTLjlCZJp92xPltpwffwkkJGxTlOBbW/S14lJxCKTe+klLzH0lg27xqNMs
         HdYFWmYMamuqiGFD17yULI4HzIfCaLuOaY8+0rz9IPeO7vvJVjoglfpwEtcFSZhDfYUk
         fWMltU2pI/OB92ITBq3+eUt5BCBXmK2A+7LNrVO1eIhJbxuJV76Fh14PbmyCrOJaD4Vd
         z1wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730855305; x=1731460105;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ryi/pi3lUq1wNHyZErKlGkkga91D15R+NN0ELpaycaY=;
        b=SiB28Rf13ceHKsy7kWy2rUuGM64AIoh564FSzJ77Rn35wNejsUmWVuQpEwLStOGeUB
         xK+IpEUkzAVWk3dop9YlmLku5hbVaFbbhsYqDZOsaU8O7T6j8XVbW/sZedsox2zJwF4B
         PDKWPr3bH4q1kQtlSd13zYo6O2Y30PIT5iW4azaUuxPG5seBZVrUq9P9C3bB4aZQt3tU
         w6fRhdpGgi9uGO0F2gWVj6ZKfhfFkM6nilRxhQhiFZHq5VIDJHht+qU+L5AJsj3xxdTK
         Gd1zey7DgLQ9zUgVp6qLDqkIdAc55QBiE2UmfjfJe1i/c5bYQ2n3WwgwPNba6AW3ouC+
         A9eQ==
X-Forwarded-Encrypted: i=1; AJvYcCV79S0rolP02Q1xNi3ixyJ5xMNo3FgYjp4wgF1/GMPhwWQ5OO5K789Lq01t71N7DMgA2eJN8d3JGIOHvpE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdvY577WwISdXXYBKHS0J2IDY/KWALQyczV+loxvA/e3J0n601
	fxFwsL69uS60FCFPpE/uWkaUlQ9vj8WlgNgXdFt66RmoiNqV8mrLgG0ye4bMKjnoRJrN2WsxXek
	m0+j3Ae/eC/hUUhnY3IgqnQhhah0Rmh/YoM4G
X-Google-Smtp-Source: AGHT+IFTFkB5caX4Ryi1BlTE9iZaLx5VWXEMd+aTVz+dwoFMS23Q5XBJOIY29E4J5TolZNx+t4zU2xFzdt9axsDFoZU=
X-Received: by 2002:a05:6a20:7f8b:b0:1db:e3f6:55f with SMTP id
 adf61e73a8af0-1dbe3f6065fmr10242669637.18.1730855304373; Tue, 05 Nov 2024
 17:08:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240727102732.960974693@infradead.org>
In-Reply-To: <20240727102732.960974693@infradead.org>
From: Saravana Kannan <saravanak@google.com>
Date: Tue, 5 Nov 2024 17:07:44 -0800
Message-ID: <CAGETcx97SEHP5MspzBHsMkmSExnY870DQ-F5L077vzOGnPx0UA@mail.gmail.com>
Subject: Re: [PATCH 00/24] Complete EEVDF
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, vschneid@redhat.com, linux-kernel@vger.kernel.org, 
	kprateek.nayak@amd.com, wuyun.abel@bytedance.com, youssefesmat@chromium.org, 
	tglx@linutronix.de, efault@gmx.de, 
	Android Kernel Team <kernel-team@android.com>, Qais Yousef <qyousef@google.com>, 
	Vincent Palomares <paillon@google.com>, Samuel Wu <wusamuel@google.com>, David Dai <davidai@google.com>, 
	John Stultz <jstultz@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 27, 2024 at 3:27=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> Hi all,
>
> So after much delay this is hopefully the final version of the EEVDF patc=
hes.
> They've been sitting in my git tree for ever it seems, and people have be=
en
> testing it and sending fixes.
>
> I've spend the last two days testing and fixing cfs-bandwidth, and as far
> as I know that was the very last issue holding it back.
>
> These patches apply on top of queue.git sched/dl-server, which I plan on =
merging
> in tip/sched/core once -rc1 drops.
>
> I'm hoping to then merge all this (+- the DVFS clock patch) right before =
-rc2.
>
>
> Aside from a ton of bug fixes -- thanks all! -- new in this version is:
>
>  - split up the huge delay-dequeue patch
>  - tested/fixed cfs-bandwidth
>  - PLACE_REL_DEADLINE -- preserve the relative deadline when migrating
>  - SCHED_BATCH is equivalent to RESPECT_SLICE
>  - propagate min_slice up cgroups
>  - CLOCK_THREAD_DVFS_ID
>

Hi Peter,

TL;DR:
We run some basic sched/cpufreq behavior tests on a Pixel 6 for every
change we accept. Some of these changes are merges from Linus's tree.
We can see a very clear change in behavior with this patch series.
Based on what we are seeing, we'd expect this change in behavior to
cause pretty serious power regression (7-25%) depending on what the
actual bug is and the use case.

Intro:
We run these tests 20 times for every build (a bunch of changes). All
the data below is from the 20+ builds before this series and 20 builds
after this series (inclusive). So, all the "before numbers" are from
(20 x 20) 400+ runs and all the after numbers are from another 400+
runs.

Test:
We create a synthetic "tiny" thread that runs for 3ms and sleeps for
10ms at Fmin. We let it run like this for several seconds to make sure
the util is low and all the "new thread" boost stuff isn't kicking in.
So, at this point, the CPU frequency is at Fmin. Then we let this
thread run continuously without sleeping and measure (using ftrace)
the time it takes for the CPU to get to Fmax.

We do this separately (fresh run) on the Pixel 6 with the cpu affinity
set to each cluster and once without any cpu affinity (thread starts
at little).

Data:
All the values below are in milliseconds.

When the thread is not affined to any CPU: So thread starts on little,
ramps up to fmax, migrates to middle, ramps up to fmax, migrates to
big, ramps up to fmax.
+----------------------------------+
| Data            | Before | After |
|-----------------------+----------|
| 5th percentile  | 169    | 151   |
|-----------------------+----------|
| Median          | 221    | 177   |
|-----------------------+----------|
| Mean            | 221    | 177   |
|-----------------------+----------|
| 95th percentile | 249    | 200   |
+----------------------------------+

When thread is affined to the little cluster:
The average time to reach Fmax is 104 ms without this series and 66 ms
after this series. We didn't collect the individual per run data. We
can if you really need it. We also noticed that the little cluster
wouldn't go to Fmin (300 MHz) after this series even when the CPUs are
mostly idle. It was instead hovering at 738 MHz (the Fmax is ~1800
MHz).

When thread is affined to the middle cluster:
+----------------------------------+
| Data            | Before | After |
|-----------------------+----------|
| 5th percentile  | 99     | 84    |
|-----------------------+----------|
| Median          | 111    | 104   |
|-----------------------+----------|
| Mean            | 111    | 104   |
|-----------------------+----------|
| 95th percentile | 120    | 119   |
+----------------------------------+

When thread is affined to the big cluster:
+----------------------------------+
| Data            | Before | After |
|-----------------------+----------|
| 5th percentile  | 138    | 96    |
|-----------------------+----------|
| Median          | 147    | 144   |
|-----------------------+----------|
| Mean            | 145    | 134   |
|-----------------------+----------|
| 95th percentile | 151    | 150   |
+----------------------------------+

As you can see, the ramp up time has decreased noticeably. Also, as
you can tell from the 5th percentile numbers, the standard deviation
has also increased a lot too, causing a wider spread of the ramp up
time (more noticeable in the middle and big clusters). So in general
this looks like it's going to increase the usage of the middle and big
CPU clusters and also going to shift the CPU frequency residency to
frequencies that are 5 to 25% higher.

We already checked the rate_limit_us value and it is the same for both
the before/after cases and it's set to 7.5 ms (jiffies is 4ms in our
case). Also, based on my limited understanding the DELAYED_DEQUEUE
stuff is only relevant if there are multiple contending threads in a
CPU. In this case it's just 1 continuously running thread with a
kworker that runs sporadically less than 1% of the time.

So, without a deeper understanding of this patch series, it's behaving
as if the PELT signal is accumulating faster than expected. Which is a
bit surprising to me because AFAIK (which is not much) the EEVDF
series isn't supposed to change the PELT behavior.

If you want to get a visual idea of what the system is doing, here are
some perfetto links that visualize the traces. Hopefully you have
access permissions to these. You can use the W, S, A, D keys to pan
and zoom around the timeline.

Big Before:
https://ui.perfetto.dev/#!/?s=3D01aa3ad3a5ddd78f2948c86db4265ce2249da8aa
Big After:
https://ui.perfetto.dev/#!/?s=3D7729ee012f238e96cfa026459eac3f8c3e88d9a9

Thanks,
Saravana, Sam and David

