Return-Path: <linux-kernel+bounces-537928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7F7EA4928D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 08:58:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D1813A7667
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 07:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A5A61CBA02;
	Fri, 28 Feb 2025 07:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bqL8MAA5"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12AD92CCC0;
	Fri, 28 Feb 2025 07:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740729490; cv=none; b=H2BMx8EmQLq3+UsJiFOAGCSz1Ejt44NariKSgz0sBsv6OgCjA9zhv8CYqIhzAac/CdBOy0CfPqwe74K9gtBZJglF1CnkOn1EBpJOBTrCVnunLT7H1vHKzikzY7ZdIln+ICfLagiQ+3vTSYT3uCUDrZqeXe/I1/nFyKdGbTHtm9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740729490; c=relaxed/simple;
	bh=A5UlJk1Lwgcjk63CUpIIkNaWpKKDpjlZEsd5GNdhYNw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cIg6osQAWgK9420gByaDZP/IpbQzIw5B/mlDJMIrgnRdpGrhcnZW84sZ0oKz0X0E6N7CFVjBe4W9ItIRuSKa6Zo2mkvwtoUaUcVHTGO57s/9zALFnSdAWeruUlqUuffvp1ZtXKkcHFAurla2BZpRfkuwNbdkhCQciKFngbIacsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=bqL8MAA5; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=H4uV16DUgChkRShZd7CyTzN+P//AtMu7+LwcdpiOvIQ=; b=bqL8MAA5LcUEJ2THFuxDcc7ILy
	KKUuHqucSIzt7nMETkv1JviFBO4XODR3BlWCfe1iVNKHVuoXN4MiAFv0v5sGRPizEk7m/8G2n1JtA
	YuKUL0i3JEuXP6gZagHIxpyG94/r54ziumor8Er72q/L37mLw0AOj/3+FEBt7phiXwoMJL6cGmEs/
	2ooZ2lNxfGzwJqRx3FDbRiemcLuwhYMnPpCR4AtJsYzMVPIxpwY2zda/JGw6/VIy3lLFSKMaU7skK
	p81F9Kv6b/a06pElh2TVUHkV1uQQvsGrwaP/OHgY6y7ft7bsgGxEYSFNRNRXJujx6/Nridyt7PqgQ
	apkx6zrg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tnvFs-00000003vXl-1BzF;
	Fri, 28 Feb 2025 07:57:56 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 4BDB7300756; Fri, 28 Feb 2025 08:57:55 +0100 (CET)
Date: Fri, 28 Feb 2025 08:57:55 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Lyude Paul <lyude@redhat.com>
Cc: rust-for-linux@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Boqun Feng <boqun.feng@gmail.com>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	"open list:SCHEDULER" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v9 1/9] preempt: Introduce HARDIRQ_DISABLE_BITS
Message-ID: <20250228075755.GC5880@noisy.programming.kicks-ass.net>
References: <20250227221924.265259-1-lyude@redhat.com>
 <20250227221924.265259-2-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227221924.265259-2-lyude@redhat.com>

On Thu, Feb 27, 2025 at 05:10:12PM -0500, Lyude Paul wrote:

> @@ -26,29 +27,34 @@
>   *
>   *         PREEMPT_MASK:	0x000000ff
>   *         SOFTIRQ_MASK:	0x0000ff00
> - *         HARDIRQ_MASK:	0x000f0000
> - *             NMI_MASK:	0x00f00000
> + * HARDIRQ_DISABLE_MASK:	0x00ff0000
> + *         HARDIRQ_MASK:	0x07000000
> + *             NMI_MASK:	0x38000000
>   * PREEMPT_NEED_RESCHED:	0x80000000
>   */
>  #define PREEMPT_BITS	8
>  #define SOFTIRQ_BITS	8
> -#define HARDIRQ_BITS	4
> -#define NMI_BITS	4
> +#define HARDIRQ_DISABLE_BITS	8
> +#define HARDIRQ_BITS	3
> +#define NMI_BITS	3

I'm a bit scared here. This reduces the number of NMI levels from 16 to
8, and we have 5 IST gates that can nest in wonderful ways. This might
just be achievable.

Also, you should probably double check the HARDIRQ bits against all
architectures that have interrupt priority support -- Linux doesn't
really do that, local_irq_disable() is typically disable-all, but things
like PowerPC play funny games -- ideally those games are all played
before entering the common code that has the accounting on.

And I don't think we have overflow detection on the NMI/IRQ bits.

The comment with __nmi_enter() is now wrong.


Anyway, like I said before, I like the general idea, but I hate we're
growing a 3rd form.



