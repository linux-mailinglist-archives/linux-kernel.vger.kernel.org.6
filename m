Return-Path: <linux-kernel+bounces-286974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 016D6952106
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 19:25:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9E271F2412F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 17:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 246121BBBEA;
	Wed, 14 Aug 2024 17:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VsiYCBqf"
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0061B9B2B
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 17:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723656326; cv=none; b=m6hxDayGkYUSjPegqpY3a+FFP47lLAZLwnyDiVyJz+zEefTcodlGVMtylhTjjmwTnyR79TMRXR975RVqREoaLruvWZJtBjJgHNX4ouh41TMvWGtCDdM5euX+1XnjcZLSYJkecZ1xcW+vUFMXIKBH7V0hJx7gldKTA3PBPpfb7do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723656326; c=relaxed/simple;
	bh=pAJ5YUxTT+Iwim1Yg5afwz+MZOShUsNFhllc3NfzqwI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R8rGfkkgb5sqTTJw3/a+bouUxN7p29R0tyoI3TWqleIrugYlvjpZQ35GJZOoBUi128MJOKUZdyS9Wvtp34TDJ1GMyqhXxxbhh2/dPLl4tQZi7ClRcUxUOk+AR/suMPTQjSCN6KclAlPpx8mOsBIFrQZ+NwD6wKPl3KdNV79I29o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VsiYCBqf; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7a1d067d5bbso3006385a.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 10:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723656324; x=1724261124; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=48MqnTmoLNla70Qt0w+hF2CCbTExY23nQT0Cc6bIV9A=;
        b=VsiYCBqf86kINDVde2cWLgqIDII/VkHoavstlVx5k/AKkrwZ8MUrEoDoDW/UhLmgfs
         BUrVwRVIMGgmQ7LabstjheE76O9Qxcs63+wnVbn6CsmcOYcxOobqe7WutUCLtVe3uD9k
         p5eiSA1qtPOsEa6/jh3sEXU9lLFarwl6q+AWtes6MYd1xVTGjlBmN7PDPpQ+KyOtW0V4
         nL9zu8SHubhsQr1uiEZzaYX+bK/Pjoibfo5eZLWhJ33zDGbfCWvYGjiGXku3xrcHGa3E
         bPOKi8ua528ThdnnR83KUhGJzF8h25xRW7u50j3UFyQmpXRaBULjBQBuDsTssSg4N+k8
         vqhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723656324; x=1724261124;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=48MqnTmoLNla70Qt0w+hF2CCbTExY23nQT0Cc6bIV9A=;
        b=cTk9VnSMzQOQs8C9xndA0ynyBIizcy3Rk84EaFrSzbz55fISje1zPvfoR2BTe035I4
         2JUiVB56bA4r/kObc/TDB21j38FTb7dInaeptGnaUwdw8AJ//aoA08A1RbQzM+Iti7wk
         lzA1h+HvQqWIWpmQycR3P3HeT3xDQxTg4BuzXxpGStoMkKCBKvh+IZK7ih/hfdPpmrYK
         HU9r7Cs/xot6xV07NgdJoDdfAqrEIau23f32Fikq+su+WxKG5vXuoOW36LnIQ6IVZ4EY
         f7HZoCGre3ODuabMavV5+692Ng4VFKL9XhHVWVYDjmNKGkba3/MzU9coedi4PwuhE98s
         1FGA==
X-Forwarded-Encrypted: i=1; AJvYcCWvY1vTemv9KQIma/43LHh4VYTJfLRxjeMOc0kmIev8/JgiLnAPFpNDK53Q/NaQ1KGytwogTg91n+FRAoO52O6TBOKtijxFmRe7m21n
X-Gm-Message-State: AOJu0YzDQDw/I5iOtsHaI5R9tn5Il93jyhyqbbK91qXBTnOTstgRpHup
	7ILkzPIjpsC+0lAnBoK3nT04GFCsTttxAIJRY2tKTQCwhv0n87Osa054ucVX6rlQKgKnOcDPtTC
	wSwSz6vNDvAHhdVINd5xuNUtzje6DEmFKaVqZXQ==
X-Google-Smtp-Source: AGHT+IEEb+UT904t7qw6Sw+IZKhO9dpP+ZUuW4ox2PynJUXy9DtcPymBmhEVP2TIRcLGcfiZcaU6kOauIRMC8Hz36Ko=
X-Received: by 2002:a05:620a:17a5:b0:79f:aa2:5023 with SMTP id
 af79cd13be357-7a4ee3e86b0mr445253685a.46.1723656323596; Wed, 14 Aug 2024
 10:25:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240727102732.960974693@infradead.org> <CAKfTPtALe942tjoyq1RqSYyM40PG+tfEY8skRDxRM1daWLSKUg@mail.gmail.com>
 <1572d0f2646312767a3ef8b72f740c9033163bf3.camel@gmx.de> <CAKfTPtAjXejbsGS+Wd0maiiUyCgSb2xPVZGUXUPCSw_kNLJRDA@mail.gmail.com>
 <9cc41a877aa2d263b47de698d3ebe724961f9e55.camel@gmx.de>
In-Reply-To: <9cc41a877aa2d263b47de698d3ebe724961f9e55.camel@gmx.de>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Wed, 14 Aug 2024 19:25:11 +0200
Message-ID: <CAKfTPtA671h00MdA+CYW5tckxfk+9SVoH6RowR1Ut3_LJY1rjQ@mail.gmail.com>
Subject: Re: [PATCH 00/24] Complete EEVDF
To: Mike Galbraith <efault@gmx.de>
Cc: Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com, juri.lelli@redhat.com, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, vschneid@redhat.com, linux-kernel@vger.kernel.org, 
	kprateek.nayak@amd.com, wuyun.abel@bytedance.com, youssefesmat@chromium.org, 
	tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"

On Wed, 14 Aug 2024 at 19:18, Mike Galbraith <efault@gmx.de> wrote:
>
> On Wed, 2024-08-14 at 18:59 +0200, Vincent Guittot wrote:
> > On Wed, 14 Aug 2024 at 18:46, Mike Galbraith <efault@gmx.de> wrote:
> > >
> > > On Wed, 2024-08-14 at 16:34 +0200, Vincent Guittot wrote:
> > > >
> > > > While trying to test what would be the impact of delayed dequeue on
> > > > load_avg, I noticed something strange with the running slice. I have a
> > > > simple test with 2 always running threads on 1 CPU and the each thread
> > > > runs around 100ms continuously before switching to the other one
> > > > whereas I was expecting 3ms (the sysctl_sched_base_slice on my system)
> > > > between 2 context swicthes
> > > >
> > > > I'm using your sched/core branch. Is it the correct one ?
> > >
> > > Hm, building that branch, I see the expected tick granularity (4ms).
> >
> > On my side tip/sched/core switches every 4ms but Peter's sched/core,
> > which is delayed queued on top of tip/sched/core if I don't get it
> > wrong, switches every 100ms.
>
> FWIW, I checked my local master-rt tree as well, which has Peter's
> latest eevdf series wedged in (plus 4cc290c20a98 now).. it also worked
> as expected.

After looking at deadline and slice, the issue is on my tool was
trying to change the slice (an old trial for previous version) which
got clamp to 100ms.
we can forgot this, sorry for the noise

>
>         -Mike
>

