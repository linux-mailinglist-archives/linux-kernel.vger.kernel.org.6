Return-Path: <linux-kernel+bounces-441848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E77CD9ED4D5
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 19:45:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFBD2283F3D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 18:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8291E200BA9;
	Wed, 11 Dec 2024 18:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="j8qxzUGE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DPpm3HIw"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC92A1DE4CE
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 18:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733942715; cv=none; b=e1WJXKBSbqn8oBvDs07Xo2v24kvVpvN7xIhcF541i5aXS+OUMapehUVl9BRcGV64ggPnGtf9foUQmz2Lp1PxOb+XiINSukaL1/G5yYC3Cn75VwkffEO7APbrNE5xOxH6+Po2BpVagP6eipxNwkoGvTTtBIU3L/YrcFS28h/E3/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733942715; c=relaxed/simple;
	bh=eU/4DpxYd+wyY6Bvp4R3AQ92VftffXdSunAYKonF6e8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tSLgsRnA5qEjkeYyK9qhPM8gW/0JJPcN99pfBz56MmVT7qYXuM0PDRd3Y+0dPGYDJUnH+AtxrIXXWjiHWkipZRPvMzfja+Oy7oj4MyebYsndZ2vQWzcUUJa6WSj/nKUfbwKv71/W8CRw6g9zU7/7YZAhe1RdMYooKA5/46N3/5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=j8qxzUGE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DPpm3HIw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733942710;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k/tmyaOywwMu5T6fg6dqSCNBPfMkmlhPfbF0uH10OYQ=;
	b=j8qxzUGEwcFw2DYmDW6F5F50nxZ51r93QvUUl8YLHULIpHSg2YR064xImtFs5k2PLYhVDA
	s2UnRpTaygkHoR31d3VuG1EqIiGmY3YHqQekPz2ZV1xojulVubc1evJkZiChZSTUwqFieY
	i9HDoE0ueD1VsvMHtBfnoYxgtVYILUSuyMT/jW+tI2xofvlDgX7F6PLp3wXoRBReOuG3R3
	agrxLdHrMIzPdH4/VU3EgkEFGQY7+mjanZphnHiWdfsihnSJnDxefrjIXvQqjat5hQqy2u
	kIRKFIDhCPR+yTbZhMwZiyxrocplcJRbm78eVzH2dXcqV4pBbj5ccDs3vVbgdQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733942710;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k/tmyaOywwMu5T6fg6dqSCNBPfMkmlhPfbF0uH10OYQ=;
	b=DPpm3HIwUD6dN/5F/I/4TOhdhEB/8w0mAM43FdxmROtk1/UvqnjKCI9VSGGc7iLQo7Ajdl
	7KqPPax7pzUwKkAw==
To: Saravana Kannan <saravanak@google.com>, Peter Zijlstra
 <peterz@infradead.org>
Cc: kernel-team@android.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1] cpu/suspend: Do a partial hotplug during suspend
In-Reply-To: <CAGETcx_wv_sC+FhChr8OaV6wjkHxTf9W66AoBQihV=m70G=_iQ@mail.gmail.com>
References: <20241119020519.832013-1-saravanak@google.com>
 <20241119092829.GF11903@noisy.programming.kicks-ass.net>
 <CAGETcx_vABsh8HgMi1rYRWmB5RhYwqGT6kKJ+9LX0HrcP8i7yA@mail.gmail.com>
 <20241120084240.GA19989@noisy.programming.kicks-ass.net>
 <CAGETcx_wv_sC+FhChr8OaV6wjkHxTf9W66AoBQihV=m70G=_iQ@mail.gmail.com>
Date: Wed, 11 Dec 2024 19:45:10 +0100
Message-ID: <87bjxiawjt.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 20 2024 at 13:02, Saravana Kannan wrote:
> On Wed, Nov 20, 2024 at 12:42=E2=80=AFAM Peter Zijlstra <peterz@infradead=
.org> wrote:
> I was thinking before CPUHP_BP_PREPARE_DYN because I saw some drivers
> doing whatever the heck they do in CPUHP_BP_PREPARE_DYN. It'll be much
> easier to do audits of non-dynamic stuff and keep it within
> requirements.
>
>> WORKQUEUE_PREP seems awefully random, and the
>> typical purpose of the _PREPARE stages is to allocate memory/resources
>> such that STARTING can do its thing, similarly _DEAD is about freeing
>> resources that got unused during _DYING.
>
> Yeah, I understood all this. I wanted to pick CPUHP_TMIGR_PREPARE
> (mentioned in my first email) because it was right before
> CPUHP_BP_PREPARE_DYN (and if you skip over CPUHP_MIPS_SOC_PREPARE
> which sounds like a hardware step). But hrtimers seem to have a bug --
> if the sequence fails anywhere in between CPUHP_AP_HRTIMERS_DYING and
> CPUHP_HRTIMERS_PREPARE things fail badly.

Yes, that's known and someone is working on it. Here is the thread:

  https://lore.kernel.org/all/87wmg9oyzk.ffs@tglx

> So, for now I'd say we get in something like CPUHP_SUSPEND wherever it
> works right now (after WORKQUEUE_PREP) and slowly move it up till we
> get it right before CPUHP_BP_PREPARE_DYN.
>
>> So the most logical setup would be to skip the entire _DEAD/_PREPARE
>> cycle.
>
> Makes sense to me.
>
> On a separate note, I'm kinda confused by state machine stages where
> only one of the startup/teardown callbacks are set up. For example,
> I'd think the workqueue_prepare_cpu() would be combined with
> workqueue_online_cpu()/workqueue_offline_cpu(). Why is online() not
> sufficient to undo whatever offline() did?

Some of this is purely historical and was more or less blindly converted
from the original notifier chains.

Other things are one-off initializations to allocate and initialize
memory, which is never freed again under the assumption that the CPUs
will come back online.

But yes, this needs to be looked at on a state by state basis.

Thanks,

        tglx

