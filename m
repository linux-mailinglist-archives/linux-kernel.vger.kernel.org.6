Return-Path: <linux-kernel+bounces-259309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B4149393E3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 20:55:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97E9BB21178
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 18:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67FF0170854;
	Mon, 22 Jul 2024 18:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="u9Id17Bg";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bB+tbcFP"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E26D16FF3B
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 18:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721674513; cv=none; b=ik0xshmGIL72vccSAxiFIdSQD8S8zUF5QxBml8aWhuEtqNswdDaHjMlcVBqqa3z5tj2/qa1eMnLu21ww2eToyEQx5TO2owNzV4f8nFIU5xlkYJxaNGQc9lKCV3VhpB7bG03qN4y0vi41kI8WFug+KvNwuaoBEjZwDw2VQLdoKhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721674513; c=relaxed/simple;
	bh=kC2Rk+2JFv2QPCXZuDB945Wqqs6EUGa1hSbekfQVPq8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LDRk7obACCwZltxNHXusI7CdGKCholXx/AKcdUqfl65qvdp527yU2pDitwYYimb429dBdOAzFiIlvcQYLdZ3mUjLX0RrZlxUFPg57ARAuH0qZTezI8C6ml/7S/tIae3rSzqpVet3/KkvzOSJzTq0kfD1M7rfAsJZvkLFiYff+P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=u9Id17Bg; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bB+tbcFP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1721674510;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ou/vyOWK0b0T0DNfFVAqlYWvoRiI5kaaynDGb33LnZY=;
	b=u9Id17Bg2ZZZofa4fhaV7E6fOmtd2tSXsmZFxnDjFoBAH+M3ASV2u33/MkIkkF5rpArxnF
	QEp91/gZcIk0svcRNukwlU2/4MxmY1hiMb5NaAz1SGYfXlcEFrrg605E13sSaBh0Bdx1s5
	lbJdPDhtMPjq5/NDrRpfuedfPbHUgtFvidG+OYgm4QU4iC+9L+fwEgos2Gr3YO37Q6c0Xg
	+XNEzDZcCwUljm2Q2kqqoXAtCNPvmVb8Yyy/ENwB5flYKMhnXQvYk81rY2n9JVkp4Gw3NS
	Wk81NzFfzm8UY0+R23IK8K42OykDMDCbQ2mqjoFF/aI4O+RNn27P/CPCpu07DA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1721674510;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ou/vyOWK0b0T0DNfFVAqlYWvoRiI5kaaynDGb33LnZY=;
	b=bB+tbcFP9KbokYPGQTTKw2gpKDfNQgKTJst7oUVhw+rkyiNTIFBzi8lg1OmgZm7QDYpd3+
	grH9nCmYu0LWTzDg==
To: Naresh Kamboju <naresh.kamboju@linaro.org>, open list
 <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org, Linux
 Regressions <regressions@lists.linux.dev>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker
 <frederic@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Anders Roxell
 <anders.roxell@linaro.org>, Peter Zijlstra <peterz@infradead.org>, Dan
 Carpenter <dan.carpenter@linaro.org>
Subject: Re: WARNING: at kernel/time/timer_migration.c:1714 tmigr_cpu_prepare
In-Reply-To: <CA+G9fYsdQ58YL96Kv7dY1nb5Ok3=o7L68JdpOH4yZJ_3nAdExw@mail.gmail.com>
References: <CA+G9fYsdQ58YL96Kv7dY1nb5Ok3=o7L68JdpOH4yZJ_3nAdExw@mail.gmail.com>
Date: Mon, 22 Jul 2024 20:55:09 +0200
Message-ID: <87ikwxw92q.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Jul 22 2024 at 19:59, Naresh Kamboju wrote:
> The following boot warnings noticed on all the devices running today's
> Linux next-20240722 tag. The system is stable and booted to console.
>
> First seen on next-20240722.
>
>   GOOD: next-20240719
>   BAD: next-20240722
>
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

https://lore.kernel.org/all/Zp5bpLJHlYsZinGj@localhost.localdomain/

