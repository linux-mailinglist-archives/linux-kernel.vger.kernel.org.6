Return-Path: <linux-kernel+bounces-575065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F021AA6ED1A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 10:55:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F40DA16F153
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 09:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 076A7199FAB;
	Tue, 25 Mar 2025 09:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bpyNpvRm"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED03C253F1F
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 09:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742896513; cv=none; b=cNUqPwgG51jw0VJyEyzzVhwEaVOmBTsmf7M0P9N2Tt2uAyXqiRDMhqTMh4nkqEc9U9gPhHtQJTfloz3m8ISqVSVbqMzGKFaQKTPG5H7oP5ONcWN0YD38KwsKgmflBPK4TFEV4MciUccl9CwA2RK8LbuljDmno1dwlFNQXXEyxQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742896513; c=relaxed/simple;
	bh=s3vRoJO9KCdRiGB7I2a3vCYZT0qYEi3rStspDL15YPs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BML97ccghL2BKdTrpwbK9rPRyYG9Lzggte8q+MpJFDUjmEUckIY91o7MnIzX4VGw94G1A3JE/vSkpfEkIhhw1jIx45VwUdrh7r9umcKDkFhEhcEl/iSIVk0ywJf8P1rKQKUNi3tJIf2dFIiGtWtTR5KNjvfsXBYHMy53S0/0tNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bpyNpvRm; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2ff69365e1dso7373576a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 02:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742896510; x=1743501310; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OikC43tfGVqcaGJaSFtBGBt98zMmOylB8g82DSjPV3k=;
        b=bpyNpvRm3kAzGTxN72OosjQpPSkRqD9aJPlBWsNK6A0mmcP1mnqfAuIkxm6aQYPH+H
         e6705qrpm54ICv606WAG+5HodbzBKJzPaG2WdaxjlWAOIWvez3Q8paKeI2z/D6vsN6/H
         k+v+ouUZa/iDsnhSQf9h6LWENVKJ5GoyQspmK0oDDs3du3V43bKOBLsdbpH4F8FmBeT3
         i9GL8Axu00i5ZctICaqW51pkM3MC2K6Rw254YbNojD+SHtcd1Mwhp2nzzyA31qUPv0Fy
         VTYUhuVFA64EVQvrTCKArtUr4NeIqn+QMe90OvJ8HN2EfLNDoP0JrivJRutdMRz9YbbX
         nfdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742896510; x=1743501310;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OikC43tfGVqcaGJaSFtBGBt98zMmOylB8g82DSjPV3k=;
        b=j5/M21oFqj1Wokv6m0k9L7KOV5j71dzfzqHwH3h7n7EXN80D16QUi5SCUoEUjiXO30
         2ufrx/nvTYg0KPCdbbb3t4NPbWjJwgNKTO//yK/npX4VWTjukqlNTUT9yiM6jS+bLsGJ
         v6OtpQgbqcD9l7swCLm64rrpD056FQzCxs9SEjIGTT51KrvoUN5H83egE1D3ShBoaT9j
         coJ81QTSV7IdJ5yOpS8n014vQV/CLp9P0V15CTYtZvWSquOq7tMeR2MlfIXWkVhsMJ6T
         Y4fUquIoJuh3NWVlkPKzrp5smyxP/hoHrno36Qj7YjLFI3XWsO3z5SW6UslsLQBoU4ot
         Kw3g==
X-Gm-Message-State: AOJu0Yx0DaAlk/2aHInm3+2Duo+Gn+0c3iyV8vGK+u6w0p9Y0KccK3pO
	eqzEinqhamr9av/Iavd4Xypa8JTDLGXv40fY++VizH0pzxEGcyCfWRRbG3q+KNksit1epldwrsk
	bmdkyQqxDALbiAv9u94eq5aAQyrs=
X-Gm-Gg: ASbGncukfyYm5fbzWRtkvaqX0LzceU2ef8TljfUV4aiGr4PivgDcXeEfB6XMQl6TRor
	jIpMMMv+FfEQYxOjoDrFHF/PaAz8aLIBwL4cvPQjMWGnl81jGQavE0dnrOHtY43jHcB3gSbf6CE
	qTGDbSIdBGR36NNFzhHkzc8Rr8tXW2L56yWYXo
X-Google-Smtp-Source: AGHT+IGNIEeEUu6SigCoTSpIj9xYEpEWYK8C0NKYzoyZvgcjwlTLD0/P82xVLjttC0KKK2MAJ8X+XpE4+SSRkHydSjY=
X-Received: by 2002:a17:90b:2647:b0:301:c5cb:7b13 with SMTP id
 98e67ed59e1d1-3030fe552f1mr23024928a91.3.1742896509787; Tue, 25 Mar 2025
 02:55:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJNi4rPaPeVWzBve6Toi8hhrxP6GROAGRug7+c3zg1crDeOt7Q@mail.gmail.com>
 <875xk022wu.ffs@tglx>
In-Reply-To: <875xk022wu.ffs@tglx>
From: richard clark <richard.xnu.clark@gmail.com>
Date: Tue, 25 Mar 2025 17:54:58 +0800
X-Gm-Features: AQ5f1JqYEwNRR58lzDarOJKfOrvacm-ZDrKE_UsmaKh3gsTaUsm0aGs3qM00oss
Message-ID: <CAJNi4rPtsUohpXgD28Bi7K4Y0G=ShgNuUmf1L3E4ze7txj_z0w@mail.gmail.com>
Subject: Re: hrtimer precision issue/question??
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, richard clark <richard.xnu.clark@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi tglx, Thanks for the explanation! I tried run 'cyclictest -a 0 -t 1
-m -p99 -r' to use the relative timer instead of absolute, now the
output of the same diff as:
[   63.824382] [ 0- 0]t0=3D63816686720,t1=3D63817689248,d=3D1002 us
[   63.825387] [ 0- 0]t0=3D63817691648,t1=3D63818694144,d=3D1002 us
[   63.825691] [ 4- 7]t0=3D63808939136,t1=3D63818998336,d=3D10059 us
[   63.826392] [ 0- 0]t0=3D63818696544,t1=3D63819699456,d=3D1002 us
[   63.827402] [ 0- 0]t0=3D63819704352,t1=3D63820709120,d=3D1004 us
[   63.828407] [ 0- 0]t0=3D63820712448,t1=3D63821714976,d=3D1002 us
[   63.829413] [ 0- 0]t0=3D63821717536,t1=3D63822720032,d=3D1002 us
[   63.830417] [ 0- 0]t0=3D63822722496,t1=3D63823724928,d=3D1002 us
[   63.831423] [ 0- 0]t0=3D63823727264,t1=3D63824730912,d=3D1003 us
[   63.832429] [ 0- 0]t0=3D63824734176,t1=3D63825736768,d=3D1002 us
[   63.833434] [ 0- 0]t0=3D63825739168,t1=3D63826741568,d=3D1002 us
[   63.834439] [ 0- 0]t0=3D63826743904,t1=3D63827746432,d=3D1002 us
[   63.835445] [ 0- 0]t0=3D63827748832,t1=3D63828752576,d=3D1003 us
[   63.836164] [ 7- 4]t0=3D63819412064,t1=3D63829471328,d=3D10059 us
[   63.836452] [ 0- 0]t0=3D63828755936,t1=3D63829760032,d=3D1004 us

Now I am wondering if the cyclictest will have the same result using
the relative timer instead of absolute, suppose all the other
conditions are the same?
Also the '-a 0' set affinity to cpu0 and only one timer thread with
'-t 1', don't know why some cyclictest migrate(?) to the other cpus
than cpu0, any comments about this...
Thanks!

On Sun, Mar 23, 2025 at 5:04=E2=80=AFAM Thomas Gleixner <tglx@linutronix.de=
> wrote:
>
> On Sat, Mar 22 2025 at 11:20, richard clark wrote:
> > With diff below under the 'cyclictest -a 0 -t 1 -m -p99' trigger from
> > the arm64-based linux box, the interval is 1000us and the arch_timer
> > in the system is: arch_timer: cp15 timer(s) running at 31.25MHz
> > (phys).  1tick =3D 32ns for the arch timer, I am not sure if those
> > durations less than 1000us are expected?
>
> With your method of measurement yes. There is a german saying, which
> describes this. It roughly translates to:
>
>    "Who measures a lot, might measure a lot of garbage."
>
> But it accurately describes, what you are measuring here. You do:
>
>     t1 =3D ktime_get();
>     arm_timer(T);
>     schedule();
>     t2 =3D ktime_get();
>
> and then look at t2 - t1. That only tells you how long the task actually
> slept. But that's ignoring the most important information here:
>
>     arm_timer(T);
>
> cyclictest uses:
>
>            clock_nanosleep(clockid, ABSTIME, &T);
>
> and T is maintained in absolute time on a periodic time line.
>
>     T =3D starttime + N * interval;
>
> So the only interesting information here is at which time the task
> returns from schedule(), i.e. you want to look at:
>
>         t2 - T
>
> Why? Because that gives you the latency of the wakeup. That's what
> cyclictest is looking at in user space:
>
>            clock_nanosleep(... &T);
>            clock_gettime(..., &T2);
>            latency =3D T2 - T;
>
> Now what you are looking at is the time at which the cyclictest task
> comes back into the kernel to sleep, which is obviously
>
>            t1 =3D T[N] + latency[N-1] + execution_time;
>
> But the timer is armed for T[N], so your t2 is:
>
>            t2 =3D T[N] + latency[N];
>
> You surely can do the remaining math and map that to the output:
>
> > [  165.555795] [ 0- 0]t0=3D165550399226,t1=3D165551394303,d=3D995 us
> > [  165.556802] [ 0- 0]t0=3D165551398751,t1=3D165552400997,d=3D1002 us
>
> Right?
>
> Thanks,
>
>         tglx

