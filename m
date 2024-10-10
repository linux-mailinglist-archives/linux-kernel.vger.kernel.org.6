Return-Path: <linux-kernel+bounces-358502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B4D899802F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 10:38:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19A4BB25907
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 08:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4187D1BE87E;
	Thu, 10 Oct 2024 08:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lHwio+nE"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AEFE1BF311
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 08:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728547909; cv=none; b=HnBX632oTaAvHTmmshaV+5R0e9Yj3UBkuSjakkH1jta0Xj52ZZIQ+IgiTNHjgNQGHklSEO/g2OEZzuZoZJn641h7o8xDGemPmYMlpNMH1DflXRHIcEpP2n4efOfR+hrHsUxS88AX2QHeeKO60tSpIQsAAtphYj4LFj60gM7VDl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728547909; c=relaxed/simple;
	bh=R5+0wiryyjVn0yfcAfpaC/u5jemc97CY4rYW3WMi/y4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RRa19e9RaGdF0NVRda6ih5jPhQRYVwsps3zFVJWTnhgSSad1JfudY3zSmxHGitYLWnJQfKjDGnyvyf6qlqrJHlexhrHognSh2iYMPi9Je4/gtuiqd886/n+20NJdJXqp9v/39JEbpCDyhgcDeA9Zs2UX7NKhMFOmCej3STQ01/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=lHwio+nE; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=6qPxvXn9MZxVow59XRRH0RUNiQjnqXiAqsiiJ4bqLtY=; b=lHwio+nENPugc5nj2th4mDolCF
	6yfvXBR8Puwtmp4JJ+N4nx+E/j6QOb/dyZoGrTCkD/o1apFasAIAYaGY1eFi2O3V1GW4QDps7PzV1
	NaAYjGmK5l7L8nEtQHUrQSIDrqYNH8dLg4E5w+Kpa9Ymo4lY+PtqboYRqSqDnpY661Mk9uz+zbH1D
	uJRfPcGIXi6iR53Ck1HfxbPVg+sOgwUH1QLzHAypMvhOaIvxtOX6L1fJBsStVrZ8LZAal8ZXAuAq9
	+izGVZ9G/aM01CtTewmKraR8eqKeowWWuLHkREAPz0G/W+Pa3D39diVBYykod1ris7MA91hy+gwEm
	Dgjz7Z7g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1syoGg-00000005EX7-1sPv;
	Thu, 10 Oct 2024 08:11:30 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 1F54E30088D; Thu, 10 Oct 2024 10:11:30 +0200 (CEST)
Date: Thu, 10 Oct 2024 10:11:29 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org,
	tglx@linutronix.de, paulmck@kernel.org, mingo@kernel.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, frederic@kernel.org,
	efault@gmx.de
Subject: Re: [PATCH 3/7] rcu: fix header guard for rcu_all_qs()
Message-ID: <20241010081129.GB17263@noisy.programming.kicks-ass.net>
References: <20241009165411.3426937-1-ankur.a.arora@oracle.com>
 <20241009165411.3426937-4-ankur.a.arora@oracle.com>
 <20241010064123.WJjDYegr@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241010064123.WJjDYegr@linutronix.de>

On Thu, Oct 10, 2024 at 08:41:23AM +0200, Sebastian Andrzej Siewior wrote:
> On 2024-10-09 09:54:07 [-0700], Ankur Arora wrote:
> > rcu_all_qs() is defined for !CONFIG_PREEMPT_RCU but the declaration
> > is conditioned on CONFIG_PREEMPTION.
> > 
> > With CONFIG_PREEMPT_LAZY, CONFIG_PREEMPTION=y does not imply
> > CONFIG_PREEMPT_RCU=y.
> 
> From kernel/rcu/Kconfig:
> | config PREEMPT_RCU
> |         bool
> |         default y if PREEMPTION
> 
> this looks like PREEMPT_RCU implies PREEMPTION.

The point was to make PREEMPT_RCU=n possible even when PREEMPTION=y,
which is fine.

