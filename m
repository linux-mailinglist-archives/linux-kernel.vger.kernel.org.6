Return-Path: <linux-kernel+bounces-527661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78571A40DF2
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 11:00:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3BA43B4067
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 10:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F04722036F0;
	Sun, 23 Feb 2025 10:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N+MF4zLJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2BE1FC7F8
	for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 10:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740304837; cv=none; b=Wtu5caxrvCJmZyBgx3IorPueRSpiO4wU+tujCypL9T/rTZ3akEnStqHZEfM6H8B1Yq//xzYaUcsZ41VTCxmOc8Il/0hMTxS0h71aRuxTP8g46S2wXJfMkIRSJxd9hfKpgKqMI86yTe2aBJo/ViivX60X2IF7vZVtrH17DXmvalM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740304837; c=relaxed/simple;
	bh=pmcHYHCiNgsF3nHoAFCcHPhsEZjhrg+MxkpBr1R1+NY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=isAB3cjVXl9Zu3rM0UJDxdOfw1d5XfCwrkRYYcnbowV5H+GVUwaUz0VPmC5Jz8b+63Q5RzW2Bdyqem7/y7HB5eyXgjj9d+EU0CHUmUvmVvpyZo7ApfdQgVihbSdxIEt/WOtTSQicwlACMch1Vq5UedbHzYy/PJAPrms8RbnyO3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N+MF4zLJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79A1AC4CEDD;
	Sun, 23 Feb 2025 10:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740304836;
	bh=pmcHYHCiNgsF3nHoAFCcHPhsEZjhrg+MxkpBr1R1+NY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N+MF4zLJ24fBk4xLtjB7/tA6boqFKtcLqL/am6lrHygi3nHeBTwU5SWMkJSTj6Vd0
	 UTsWnUpe1nDES2SKqIeDmfjn3E1E6FueOIL1Yd2wcdrQzw0N6V/+SBpOLCKz6M3N9R
	 rkme7Q41U7t2jdJ8nKehvnAMG3vGb4YK0zy4YL8QhpWYL6a8drxWeYpwFUcmWvEAIY
	 EWsTIQjTY34fiDALkKSZBjawlfI1IHWliw3VbQCnLroCWPVg9pXg4Nv9VBs+P6srXO
	 Jy2Pk1NJNn5ZHrCbCxjDwrrdnfsBRQsKr+gpipH9iRyeYjrwvruJts7YZTzD9ESbX3
	 sIaEwx/tUrHNw==
Date: Sun, 23 Feb 2025 11:00:26 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: Joel Fernandes <joelagnelf@nvidia.com>,
	Qais Yousef <qyousef@layalina.io>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Stultz <jstultz@google.com>,
	Saravana Kannan <saravanak@google.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] Kconfig.hz: Change default HZ to 1000
Message-ID: <Z7rxuqIB38Wv557A@gmail.com>
References: <20250210001915.123424-1-qyousef@layalina.io>
 <20250212145054.GA1965539@joelnvbox>
 <Z7rTNxHcXWizV3lq@gpd3>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7rTNxHcXWizV3lq@gpd3>


* Andrea Righi <arighi@nvidia.com> wrote:

> On Wed, Feb 12, 2025 at 09:50:54AM -0500, Joel Fernandes wrote:
> > On Mon, Feb 10, 2025 at 12:19:15AM +0000, Qais Yousef wrote:
> ...
> > > I believe HZ_250 was the default as a trade-off for battery power
> > > devices that might not be happy with frequent TICKS potentially draining
> > > the battery unnecessarily. But to my understanding the current state of
> > 
> > Actually, on x86, me and Steve did some debug on Chromebooks and we found
> > that HZ_250 actually increased power versus higher HZ. This was because
> > cpuidle governor changes C states on the tick, and by making it less
> > frequent, the CPU could be in a shallow C state for longer.
> 
> FWIW, I found the same about power consumption when we decided to switch to
> CONFIG_HZ=1000 in the Ubuntu kernel:
> https://discourse.ubuntu.com/t/enable-low-latency-features-in-the-generic-ubuntu-kernel-for-24-04/42255

The "HZ=1000 reduces power consumption or keeps it the same" is 
actually a pretty good argument to change the default to HZ=1000.

These experiments and numbers (if any) should be incorporated in the 
changelog prominently - as actual data and the Kconfig decisions made 
by major distros will, most of the time, be superior to meta analysis 
that seems to be the changelog right now.

Thanks,

	Ingo

