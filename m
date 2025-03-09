Return-Path: <linux-kernel+bounces-553212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C96F2A585B6
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 17:07:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61438188DB36
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 16:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D2711B4153;
	Sun,  9 Mar 2025 16:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="l4DdD6AD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aMlxGz3j"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2403E632
	for <linux-kernel@vger.kernel.org>; Sun,  9 Mar 2025 16:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741536467; cv=none; b=SYEGNaKH+KEARpgTSsvuG2wx2Kr7fS0AbgDPxHL8gj3m71KyzqM1JwjirHr47aTLOciB1t8hiGLhcWP3B7ejoCEGXZmSxjvYoTisd7f7jashpgs5i17Z5K9ElS0KtffHFXszV27+GKPANigehj30U3/UZ06qI82M/gFrj3yJbMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741536467; c=relaxed/simple;
	bh=0JhmLuxA7dimGOmm3hQkS0PRP/Ry6So1nSmkxSb0sGw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KgqcdzDBPcczHuTW1TtpdD3mlZ5GECdFP0Iya73dgmXMGIQt+/i/ve8exDQduTY8ZmIZC1QWRIH6P/i7Uf0+Y+4WtvPEiNTsg7RuEmN3sYKE8IYwNU9H38hfU6XO7FOAaxC+Jm7N8WXv/qKD+oOWUvrrl9ZQqvtC2pNnYMx6y/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=l4DdD6AD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aMlxGz3j; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741536464;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wEBBcBVo9fDoA/+ljA4qKZ0QIC/RnAFkDzOZx+0i7qw=;
	b=l4DdD6ADv+nYRbanjULLvzRi30ProwOC4Zc0CLg2aEeA7uyYObvpe+LsUhymatx09wBIHl
	NR9KVH+HOWRWKoRGXZ5pb+MJJkDxdm/DW2muo7UCzl+1gQbvfkHWAEC8dIpUO7GshOoQfo
	ygRyL3pB1Jmzw8+sRc+8gJOStr8rOoSteYtgbTpi/tuBIM71wgUy3X2O2v5aXs9S2s+PnU
	ZqQi+QQo2FZ42wXhQb8bb1p3uwWnMqONnPOahVmWTiSjJrlboVVsd4bsPdo2rp+FpzWLYO
	QY0LoBYU7ElHjyFf8Q5ZLNUWtp1EZy1OGf+irQRoYARnbmXq+2fNyoUdYixFdA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741536464;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wEBBcBVo9fDoA/+ljA4qKZ0QIC/RnAFkDzOZx+0i7qw=;
	b=aMlxGz3jqxQmdh4N8Nq25567ZoIDpEA160vdP4YBK9VxEqhCpYTbu0khnw6cHUrD9Y3jAo
	Zy813PosWl3LumCw==
To: Yafang Shao <laoar.shao@gmail.com>
Cc: paulmck@kernel.org, linux-kernel@vger.kernel.org, jstultz@google.com,
 sboyd@kernel.org, christian@heusel.eu, kernel-team@meta.com, Peter
 Zijlstra <peterz@infradead.org>, Michal =?utf-8?Q?Koutn=C3=BD?=
 <mkoutny@suse.com>, Vincent
 Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH v2] clocksource: Defer marking clocksources unstable to
 kthread
In-Reply-To: <CALOAHbDhKzaj93PcQReEGk-omw7s5xXVj_X=+by1r6c0G4aV3A@mail.gmail.com>
References: <11d36fdd-55c2-4f3b-96b1-dd442f759ba0@paulmck-laptop>
 <87plir32as.ffs@tglx>
 <CALOAHbDhKzaj93PcQReEGk-omw7s5xXVj_X=+by1r6c0G4aV3A@mail.gmail.com>
Date: Sun, 09 Mar 2025 17:07:43 +0100
Message-ID: <87ecz62nn4.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 09 2025 at 19:36, Yafang Shao wrote:
> On Sun, Mar 9, 2025 at 12:38=E2=80=AFAM Thomas Gleixner <tglx@linutronix.=
de> wrote:
>> So as this got introduced in the 6.14 merge window, the proper fix is to
>> revert commit 8722903cbb8f and send it back to the drawing board. It was
>> clearly never tested with the various possibilities which invoke
>> mark_tsc*_unstable().
>
> Hello Thomas,
>
> It has been reverted by the following commit
> b9f2b29b9494 ("sched: Don't define sched_clock_irqtime as static key")

That does not help much because the commit is in the sched/core branch,
which is scheduled for the next merge window. But this wants to be fixed
in Linus tree before 6.14 final. Peter?

Thanks,

        tglx

