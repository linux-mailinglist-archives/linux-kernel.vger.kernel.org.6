Return-Path: <linux-kernel+bounces-563724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60C2DA64742
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 10:28:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64D503B4E93
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 09:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75539221F36;
	Mon, 17 Mar 2025 09:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="F2slaZbw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BjS7QKbn"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E732221DAE
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 09:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742203530; cv=none; b=gGr8Qpk35o/g9I/04Cm49XImr7HLJHhJBp/id6WthwHnCGkNAss5hV7So+49VtuM+g3qep3OFCgIjIFOhtjxevPmlDcUJm4v2MI0hwco6xsWEwrDbSumhLlCn18+T9KF58vd53HFvhYBkOca6KmOHxrU33B9aDvvMp/gRdfnRrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742203530; c=relaxed/simple;
	bh=dvztFSyZEErM9HZEwREnIEAgg46fSGRjsHx3ksHlq0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PxB6fsMarCM5NVjsLHl0mGE+2AukfeHPrbFe4+fCSJ12I4yoy7CdSZbt/uxgKiW3ETl3G15eJatDufiITQhekplZ17AapSoN71eQZ7dvlw1QdsM1EGc7fiaLGSxC/sRYjUu+XminopoT9koQ/9lAHFCe/7F4en/zubguSLNx3g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=F2slaZbw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BjS7QKbn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 17 Mar 2025 10:25:26 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742203527;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z/C7OyGVRK60ZqzYGVybQCEnm9DV3fpBqNs0Cp11nQA=;
	b=F2slaZbwSHazunDpZEf0dQDXezXZ3k6MiI+va2edK8SotRBmRKkOOLroNmm6Lf2diozhZr
	ovQmE+NhISVh7P3X7sexa+O+T4ej4Ri4DCjsVnrLAp2TIfQnMImvpN15KkLYpY7DFVznbc
	fica56ms1tMbh8XsppBuZkElnM1k3Yp2+8rBEJ1O4IyySCvn151uz6lEvNUcpt0Ilr39jq
	yJVz2PR74/aktc4GRvOfawBLmwZGdS+6JCaa1MXnSiq0axktLJSRjxe5MVeSjC8BvMrCNU
	bvrqInGGSd6OL0ntQ5aTszCvKLg0sczs6beser8nq71mrkZOoMsfw2YeOmqxwA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742203527;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z/C7OyGVRK60ZqzYGVybQCEnm9DV3fpBqNs0Cp11nQA=;
	b=BjS7QKbnK4pwtkhilxtiiAHXJ4A0lMXGS4BflKeNfSNHEiq+SpT6p6EBIk1iQXnv7MoExP
	PwW9oZ57eavArwBw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Ben Segall <bsegall@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Mel Gorman <mgorman@suse.de>, Peter Zijlstra <peterz@infradead.org>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Will Deacon <will@kernel.org>
Subject: Re: [PATCH v4 1/9] sched: Add a generic function to return the
 preemption string.
Message-ID: <20250317092526.S1MfZldy@linutronix.de>
References: <20250314160810.2373416-1-bigeasy@linutronix.de>
 <20250314160810.2373416-2-bigeasy@linutronix.de>
 <Z9ay49NsoC73dKXe@gmail.com>
 <20250317083155.9g9ksofZ@linutronix.de>
 <Z9fnf9g_zmbNXICh@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z9fnf9g_zmbNXICh@gmail.com>

On 2025-03-17 10:12:31 [+0100], Ingo Molnar wrote:
> 
> * Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> 
> > On 2025-03-16 12:15:47 [+0100], Ingo Molnar wrote:
> > > 
> > > * Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> > > 
> > > > +const char *preempt_modes[] = {
> > > > +	"none", "voluntary", "full", "lazy", NULL,
> > > > +};
> > > 
> > > > +	/* Count entries in NULL terminated preempt_modes */
> > > > +	for (j = 0; preempt_modes[j]; j++)
> > > > +		;
> > > 
> > > I'm pretty sure the build-time ARRAY_SIZE() primitive is superior here. ;-)
> > 
> > It would be but it is not an option.
> > That array is defined in core.c where it is "always" required while
> > debug.c needs it optionally. core.c is its one compile unit while
> > debug.c is included by build_utility.c. So I don't see how this can work
> > unless we shift things:
> 
> Why not have it all in debug.c?

The debug.c include is behind CONFIG_SCHED_DEBUG. This needs to be moved
into debug.c itself so that code can be added regardless of
CONFIG_SCHED_DEBUG. It is not only sched-debug after that.

Then we have `preempt_dynamic_mode' logic which is in core.c but it is
exported and used in debug.c
So if all this is not a concern then I can move it.

> Thanks,
> 
> 	Ingo

Sebastian

