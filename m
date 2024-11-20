Return-Path: <linux-kernel+bounces-415162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 807849D3229
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 03:28:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11690B23BE7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 02:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 828C53A1B6;
	Wed, 20 Nov 2024 02:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dRzeKgNm"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1308B27447
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 02:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732069720; cv=none; b=h/NvWZPIEN05qAu8SWDd4W5hJQ9os2MMm+ejcqaA2BBk8QvUNU9r/B8MOmb27sZV8sTATdoLoJxi1KvhsAJIcWSSt3p9ZHY4+UvSHG3Oe2H1f1UhB5eb9cUtHuIeyGNxpcoN6+tNHRBVMlB4s9dc8Db1W2D9a5eXPSk9qtza5So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732069720; c=relaxed/simple;
	bh=4ZNckUHAo7o6Avi7GR/OAA6XTq6pZs4bLw0W2JufT9Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uuJn7vJEXnkq4/zl0X6GU3C38XYBZ8dtSKZ93ToB0EhHVKlJUkdGd+j0vv2bbhmTtl4srQk1CZ9gVqkSO4q0ps71173lEqGEbtPOE1Gvq+9N+GuoRZP+bBHUtUc+2a97u7ib0TT99RrMcfL6hQ/4ZaRYXBeJNjIKEIMcveAKggU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dRzeKgNm; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-53da2140769so4210011e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 18:28:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732069717; x=1732674517; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ZNckUHAo7o6Avi7GR/OAA6XTq6pZs4bLw0W2JufT9Q=;
        b=dRzeKgNmq1wAOkc7v2C9aKpHBnDm0NkQ2K231+gQZXu/XQxCyEjcDtkzkgbN6TtXtl
         RTBOaKCGSU8oCaTnAa//dkdyLABqlEFJEJWTfyD6if1mEVHxC//Hu/rIFuZjAaJDhNrl
         7yWGWkeXuEOREERuAlZ5b/T0dyTpLeZRX5jEH4J49FljyHX6Xa5i05WS+rdC46VCZUj6
         WjUL3bcCi4XkL8SdcdXXmY/WKGK1VCs0sItTo4Y/VW/uSrdms+sSDzAURLTh5g3C6ErY
         h73hNVstRatvz0p0FtC+d8QJreyU/XthLm+Q5qgBUjvW2T7qfLai3eWzD+bcWj862i5s
         QZnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732069717; x=1732674517;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4ZNckUHAo7o6Avi7GR/OAA6XTq6pZs4bLw0W2JufT9Q=;
        b=xORA8KFqIViObpi5YHPxYLJKDxpZJOJ+tkyA1Cg0J5Qgwi1va55F8jkVl+GHa5wg1u
         y9IzA0ikKJ8AhGknfeOSCLiJFfjrJ3yQw0Qm6OoHXZC2/Vk4lJQvivB757TmqTiXjC3+
         0wAgzZvOIemZEEjoBdZ/SGzbiQTEeZU6ec/pt9oumqoiKy9azdARDAKmfReC8Cv4fVEv
         C/UxmK0M9R5qOwWbEua+CENX8L00VPvSJ9PrnNazi3PUk3dAKyGbhZj4/ltV9KPUDzLG
         75v+pjef3A43gyl1jOJBaQUAtSo33y/ZaHOqJuQxrAvLEAHloLFia4EMz7VwHd4J7N/T
         HaYA==
X-Forwarded-Encrypted: i=1; AJvYcCWTlydnq5SOO0q8TXJpexGZcqfJDKYMObh1Fde4I0XDf5x/nmsqvgKQu3h2pLqrp9h7DVZJ1o1TUXM6jmM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyX6yF/3N4T7TY40lvvmOhrCJk7wReRCY6b85jkElfx94TDaV/9
	ZwbayD6dyL7Qh2rLd7/+nskJZ3NwyHJ2DuUQudCylf/Jvkpe+bsGiseEZTWjKpDn23PeQWOAiSY
	qwSsT9veDhbJhvHzvnUx0znQ8d9o1jKlI14ph
X-Google-Smtp-Source: AGHT+IFzpceM6BtUXlk+pmAQjmsYV209zQ7ovr7SvODU1pQQKWx7+yjYr2FsI9kCV2r0dyFDXSqRWV+jq85fFsE7W2U=
X-Received: by 2002:a05:6512:3b92:b0:53d:a6d1:b72a with SMTP id
 2adb3069b0e04-53dc133391fmr277385e87.15.1732069716951; Tue, 19 Nov 2024
 18:28:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241119020519.832013-1-saravanak@google.com> <20241119092829.GF11903@noisy.programming.kicks-ass.net>
In-Reply-To: <20241119092829.GF11903@noisy.programming.kicks-ass.net>
From: Saravana Kannan <saravanak@google.com>
Date: Tue, 19 Nov 2024 18:28:00 -0800
Message-ID: <CAGETcx_vABsh8HgMi1rYRWmB5RhYwqGT6kKJ+9LX0HrcP8i7yA@mail.gmail.com>
Subject: Re: [RFC PATCH v1] cpu/suspend: Do a partial hotplug during suspend
To: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 19, 2024 at 1:28=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Mon, Nov 18, 2024 at 06:05:15PM -0800, Saravana Kannan wrote:
> > The hotplug state machine goes through 100+ states when transitioning
> > from online to offline. And on the way back, it goes through these
> > states in reverse.
> >
> > When a CPU goes offline, some of the states that occur after a CPU is
> > powered off are about freeing up various per-CPU resources like
> > kmalloc caches, pages, network buffers, etc. All of these states make
> > sense when a CPU is permanently hotplugged off.
> >
> > However, when offlining a CPU during suspend, we just want to power
> > down the CPUs to that the system can enter suspend. In this scenario,
> > we could simply stop the hotplug state machine right after the CPU has
> > been power off. During resume, we can simply resume the CPU to an
> > online state from the state where we paused the offline.
> >
> > This save both time both during suspend and resume and it is
> > proportional to the number of CPUs in the system. So, if systems with
> > a large number of CPUs, we can expect this to have a huge amount of
> > time saved.
> >
> > On a Pixel 6, averaging across 100+ suspend/resumes cycles, the total
> > time to power off 7 of the 8 CPUs goes from 51 ms down to 24 ms.
> > Similarly, the average time to power off each individual CPU (they are
> > different) also goes down by 50%.
> >
> > The average time spent powering up CPUs goes down from 34 ms to 32 ms.
> > Keep in mind that the time saved during resume is not easily
> > quantified by looking at CPU onlining times. This is because the
> > actual time savings comes later when per-CPU resources do not need to
> > be reallocated and would speed up actions like allocations, etc that
> > can pick up memory from per-CPU kmalloc caches, etc.
> >
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > ---
> >
> > Hi Thomas/Peter,
> >
> > The hotplug state machine rewrite is great! Enables all kinds of
> > optimizations for suspend/resume.
> >
> > About this patch, I'm not sure if the exact state the hotplug state is
> > paused at (CPUHP_WORKQUEUE_PREP) will work for all arch/boards, but
> > this is the general idea.
> >
> > If it works as is, great! At a glance, it looks like it should work
> > though. None of the other stages between this and CPUHP_OFFLINE seem
> > to be touching hardware.
> >
> > If CPUHP_WORKQUEUE_PREP doesn't work, then we can make it a config
> > option to select the state or an arch call or something along those
> > lines.
> >
> > What are your thoughts on this? How would you like me to proceed?
>
> Well, if we push this one step further, why do we need hotplug at all?
> Can't we just keep them up and idle?
>
> That is, if we look at suspend_enter(), you'll note that
> PM_SUSPEND_TO_IDLE happens before the whole disable_secondary_cpus()
> thing.
>
> So million-dollar question, can this pixel thing do suspend to idle?

Unfortunately not. You saw my rant about firmware and s2idle bugs at
LPC. But yes, I'm going my part towards pushing for s2idle over s2ram.

And even if this Pixel could do it, there are a lot of devices in use
today that will never get a firmware update to enable s2idle. So, why
have all of them waste time and energy doing useless steps during
suspend?

> Traditionally hybernate is the whole save-to-disk and power machine off
> thing, and then there was suspend (to RAM) which was some dodgy as heck
> BIOS thing (on x86) which required all non-boot CPUs to be 'dead'.

My change would also help with the time it takes to power off the CPUs
during hibernate :) If it'll work (otherwise, we can make sure this
applies only to suspend).

> But does your (aaargh64) platform actually require us to take out the
> non-boot CPUs, or is this just histerical raisins?

Lol, I had to google histerical raisins to understand what it meant. I
might start using this :)
I'm pretty sure we need to call into the firmware to power off the CPU
so it can do all the housekeeping before powering down the caches.

Thanks,
Saravana

