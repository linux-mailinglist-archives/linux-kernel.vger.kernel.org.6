Return-Path: <linux-kernel+bounces-520983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F36B4A3B20E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 08:15:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CB2C7A5A79
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 07:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A16A1C1F05;
	Wed, 19 Feb 2025 07:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ILZ7SdKI"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A64179BC
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 07:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739949312; cv=none; b=nduOdDmQFFsWt/QyhMfAzizS1DufyEQyv+PCYLATMosZrtus9/BDP6vZy2SO8iuiwDjEVD7xx2zhLB62RXzqf2CUi7e/0PwDNAQR6Jn7iHqDWrb29ehqgRSj69HoVmFKqIkw3h6W3lMHPL3pHnn7USUYtExbHb4LWOBPtG6/n1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739949312; c=relaxed/simple;
	bh=/F44B/3WqM8zLwlWnCZl/7gaKck/B0NZphdRo5/7EfQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W7mGQuVyr2hrA8vVFvYU5t8ost2Ifrd73kRm3B75UB2TJeO7j8WYvg70vIQ5JQo6ONbire72S2bRhtlVCAIdpYv+ZrrsN/EOFGEpnjXf29sV2Rok56ufWgOvuvEKYj7Sst6QtDOAibrtx9Wi8iq+rwsw/+mwneB+KKY8zZKTdo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ILZ7SdKI; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-abbda4349e9so34019666b.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 23:15:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739949308; x=1740554108; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LkpVnDMzNwoaUzhfMlZMPhoYdEPrLxFNYoWqVVmm/iA=;
        b=ILZ7SdKI5zISkIDNSLw8jPtuCOVdbYDuO7fOb/6yZJE9kL0KwBPA0q1tibJjFdrSXf
         eGHm77QEtHKYSUYAvoohw/D8rxi6VvRr/bGZbf19D4eE5PG47PeALbO7PvHBQal8ZByN
         FNlff/TBAAvYkyJLzz/q6HGf5q494cTspYBKRm7niV7o3gRsbzsPh9ywe8UQ07y5beDM
         IVvX5rCYuBD7ApO/zyG+S+T1L2uer6xSO3Fd1E0Ij065/i2FQfp6Xqnk6CrLt8zBE8lQ
         9vWpYZ1CTiystOCcQ7Hn0lOq1C4r2RpUs/ixBDhzgv4LW0qmIReyysTRLSrnbMeNFRtW
         xA9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739949308; x=1740554108;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LkpVnDMzNwoaUzhfMlZMPhoYdEPrLxFNYoWqVVmm/iA=;
        b=ghUmtHeTZCExqGHB6b+UFonZpa4ThM/TVHwPy/4aAWRKRgAlRrCOg3AVvGvyQpVNOu
         U/Y/SpGlWnZcaFSZ+M2UVha9bJuSOYwZPD846r7t3X1vgGBZP8KeOi4xBfk8XqgNauOf
         P5c/YjvoCUk2zjz3WqkCGmyt3PZysjhwXjGxoacerMSCoFKmiy4P21vVM/Wn3Lq5Udn7
         p0HmydHK35JEX3o6CcBfM8FOfzBetUVVxUWAi0PhMaZ8jS393i4wDeCAexCX9cqhLx03
         fK7Fz04olYe9FkL8ZjQ/Tt+nDV6n1lQGETwtpp1eZVmlX4Sob1Vb8vWclAJ8MYZDbmy7
         KH3w==
X-Forwarded-Encrypted: i=1; AJvYcCWfXPJByoAFMPT6pc8EfnBYMqIKVCAX+UkSJwZl/aVlcLJHpD8r6KPfV34QF900PPL/xgOJil52is7bn84=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHXbfdKRQmxFXuoU8ehp0i8A7y+gw+zCsH5uRyXZU8XH7lQO7B
	Frby/G2VafYDRHnfVlMmmAmdoaduUmTBOOtbHim5LV4BoWH0YfCLba2NJQ/jnCZFs5K93yhJFDI
	9t5kdUYSSwtASeNZ2FzHP8sZf4nvPJar1
X-Gm-Gg: ASbGncttNDo+U0wHLYnRrGjmIMUGQCQgN2j7AKcmLb8SR9QelCG71dDGczD0b7X+G37
	fTZCZKINfCv7fU5gG5q/zEWuM9sV1XA4sTFNGmd0BHP1M8QQmugkugcLP3EN2usd5FduG0EkbqQ
	==
X-Google-Smtp-Source: AGHT+IHM+2MVemGOiWt7SOCvVN5Fzkh3+CcRvP+8nY1R9MLiCP6Vk/AydyFjQX8UNdUu0ySqW1GgEAFwSeApi3VSgf0=
X-Received: by 2002:a17:906:c10f:b0:abb:6f30:32c3 with SMTP id
 a640c23a62f3a-abb70b29567mr1712076066b.24.1739949307924; Tue, 18 Feb 2025
 23:15:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250213091554.2593-1-xuewen.yan@unisoc.com> <20250213091554.2593-2-xuewen.yan@unisoc.com>
 <CAKfTPtAgsn0=_LjD1HovuN__fXanOOrOawatx5EhUmMn3KDYig@mail.gmail.com>
In-Reply-To: <CAKfTPtAgsn0=_LjD1HovuN__fXanOOrOawatx5EhUmMn3KDYig@mail.gmail.com>
From: Xuewen Yan <xuewen.yan94@gmail.com>
Date: Wed, 19 Feb 2025 15:14:56 +0800
X-Gm-Features: AWEUYZm03mUIgPjU-OBLK_-zBbhwpTvpD487p9f1jPBufw7ACWYfSTplahfBB_E
Message-ID: <CAB8ipk9UqS8h+nAUUaORr0K-VQaMWZEcoHLbKQDmeNZPMORiPA@mail.gmail.com>
Subject: Re: [PATCH 2/2] sched/uclamp: Add uclamp_is_used() check before
 enable it
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Xuewen Yan <xuewen.yan@unisoc.com>, mingo@redhat.com, peterz@infradead.org, 
	juri.lelli@redhat.com, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, qyousef@layalina.io, 
	ke.wang@unisoc.com, di.shen@unisoc.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 19, 2025 at 1:24=E2=80=AFAM Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> On Thu, 13 Feb 2025 at 10:18, Xuewen Yan <xuewen.yan@unisoc.com> wrote:
> >
> > Because the static_branch_enable() would get the cpus_read_lock(),
> > and sometimes users may frequently set the uclamp value of tasks,
> > and the uclamp_validate() would call the static_branch_enable()
> > frequently, so add the uclamp_is_used() check to prevent calling
> > the cpus_read_lock() frequently.
>
> You should extended this to all calls to
> static_branch_enable(&sched_uclamp_used) which are cgroups and system
> wide uclamp
> Android likes to play with task's uclamp but the same could happen with o=
thers
>
> >
> > Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
> > ---
> >  kernel/sched/syscalls.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
> > index 456d339be98f..d718fddadb03 100644
> > --- a/kernel/sched/syscalls.c
> > +++ b/kernel/sched/syscalls.c
> > @@ -368,7 +368,8 @@ static int uclamp_validate(struct task_struct *p,
> >          * blocking operation which obviously cannot be done while hold=
ing
> >          * scheduler locks.
> >          */
> > -       static_branch_enable(&sched_uclamp_used);
> > +       if (!uclamp_is_used())
> > +               static_branch_enable(&sched_uclamp_used);
>
> may be use a helper function to encapsulate this and use it everywhere
> we enable sched_uclamp_used
>

Okay, thank you very much for your suggestion, I would modify it in patch-v=
2.

BR

> >
> >         return 0;
> >  }
> > --
> > 2.25.1
> >

