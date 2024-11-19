Return-Path: <linux-kernel+bounces-414058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EDA379D2280
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 10:28:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BA0BB214C1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 09:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 070C71BD9D2;
	Tue, 19 Nov 2024 09:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FkfVkhdB"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB5819ABAB
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 09:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732008515; cv=none; b=d8RymI0g00hCqzEzY5zU5PVDVNY4OFh6hzWYZykU5ss2yI+dc45cLd+j94NIowdOfI2YIJX9iU42TlIFgEo+fbvExLZDVFnrfI+aBnri63vrK9Z6cTYzTWkMckzWOXKahO4RnHHB05sdGLyLeaLg/61jYNLmdlxbjsJdYjQt6PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732008515; c=relaxed/simple;
	bh=W/MteMkxnRJM1ZM2dbHiUsRpi88LONOpZYcXXtk6S74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eS0vUF1jAblL8IZzJe3ZTkyMd1EYoe5dd9cluFiyMRQ1rdJ3PXx0h/rsY3adRKlG5nd9anQtM1Bd19C1XAzEaxEg8VQx4Kit5cLmm8PfrtWbWUH3MhprEQRMg0eSWNIXNfI7ckBLmSCWwSad5hTB0OzXRJiB1cF7LCNwCyZh1po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=FkfVkhdB; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=xmhQGNQwoFjshvMHLQfCQtF5vQCpHpOZX2p5j81zU9g=; b=FkfVkhdBMHOP6b5bmGz4KPRwEO
	SMeO2mc/2Lhl/hymGpB5Zaf/WadgIc3MS3NWRHK62ap8XK+cGpFtOkxX/0CsEPQnLxKXqhT0DN4d2
	CbJajLTG/CoB1GPa57DqcgjmSO/jz1JPsL09/SzGSl4QLgm3rWgideyEgqaQY6jPqZ+4meBrh9YzY
	6KdT4yD8akuTg7V7l/7m8FpIhc7ShdEheQ9REDRLbSbXUv5zaHQI94Sfr12BdwetuCgq4tMtihqvb
	V/JetUv3vHiE8+icRnSRYSlnHqQZrZ2MdOzfBmg9OoitFFw1g1wodtW6MERT4Ut/qicy1TeDyoUEr
	koWUv8+Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tDKX7-00000003v02-2P7E;
	Tue, 19 Nov 2024 09:28:31 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id B1C1D3006AB; Tue, 19 Nov 2024 10:28:29 +0100 (CET)
Date: Tue, 19 Nov 2024 10:28:29 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Saravana Kannan <saravanak@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, kernel-team@android.com,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1] cpu/suspend: Do a partial hotplug during suspend
Message-ID: <20241119092829.GF11903@noisy.programming.kicks-ass.net>
References: <20241119020519.832013-1-saravanak@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241119020519.832013-1-saravanak@google.com>

On Mon, Nov 18, 2024 at 06:05:15PM -0800, Saravana Kannan wrote:
> The hotplug state machine goes through 100+ states when transitioning
> from online to offline. And on the way back, it goes through these
> states in reverse.
> 
> When a CPU goes offline, some of the states that occur after a CPU is
> powered off are about freeing up various per-CPU resources like
> kmalloc caches, pages, network buffers, etc. All of these states make
> sense when a CPU is permanently hotplugged off.
> 
> However, when offlining a CPU during suspend, we just want to power
> down the CPUs to that the system can enter suspend. In this scenario,
> we could simply stop the hotplug state machine right after the CPU has
> been power off. During resume, we can simply resume the CPU to an
> online state from the state where we paused the offline.
> 
> This save both time both during suspend and resume and it is
> proportional to the number of CPUs in the system. So, if systems with
> a large number of CPUs, we can expect this to have a huge amount of
> time saved.
> 
> On a Pixel 6, averaging across 100+ suspend/resumes cycles, the total
> time to power off 7 of the 8 CPUs goes from 51 ms down to 24 ms.
> Similarly, the average time to power off each individual CPU (they are
> different) also goes down by 50%.
> 
> The average time spent powering up CPUs goes down from 34 ms to 32 ms.
> Keep in mind that the time saved during resume is not easily
> quantified by looking at CPU onlining times. This is because the
> actual time savings comes later when per-CPU resources do not need to
> be reallocated and would speed up actions like allocations, etc that
> can pick up memory from per-CPU kmalloc caches, etc.
> 
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
> 
> Hi Thomas/Peter,
> 
> The hotplug state machine rewrite is great! Enables all kinds of
> optimizations for suspend/resume.
> 
> About this patch, I'm not sure if the exact state the hotplug state is
> paused at (CPUHP_WORKQUEUE_PREP) will work for all arch/boards, but
> this is the general idea.
> 
> If it works as is, great! At a glance, it looks like it should work
> though. None of the other stages between this and CPUHP_OFFLINE seem
> to be touching hardware.
> 
> If CPUHP_WORKQUEUE_PREP doesn't work, then we can make it a config
> option to select the state or an arch call or something along those
> lines.
> 
> What are your thoughts on this? How would you like me to proceed?

Well, if we push this one step further, why do we need hotplug at all?
Can't we just keep them up and idle?

That is, if we look at suspend_enter(), you'll note that
PM_SUSPEND_TO_IDLE happens before the whole disable_secondary_cpus()
thing.

So million-dollar question, can this pixel thing do suspend to idle?


Traditionally hybernate is the whole save-to-disk and power machine off
thing, and then there was suspend (to RAM) which was some dodgy as heck
BIOS thing (on x86) which required all non-boot CPUs to be 'dead'.

But does your (aaargh64) platform actually require us to take out the
non-boot CPUs, or is this just histerical raisins?

