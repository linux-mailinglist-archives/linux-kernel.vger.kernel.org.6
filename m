Return-Path: <linux-kernel+bounces-564033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F0D3A64C73
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 12:26:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24E047A5527
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 11:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3680023644D;
	Mon, 17 Mar 2025 11:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lY0cU5eY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940E7230BC7;
	Mon, 17 Mar 2025 11:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742210744; cv=none; b=k+/dWg0C9cTWjQFHd4jLPjqsuCSoSnzSfEEJHEviBQF3FHwuy08zER/H9FlQI1949VCFdPz8mIKRVxB4dfi3tWf5Nw3Y2rMwGl9/42RsYYRSI8Zv4uoYlMwY87qu8mV9RteZLuuUyRcFzPOfGR6pw1XRKi6i4lCWlD69ZOCqbWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742210744; c=relaxed/simple;
	bh=XB9sbl+1FvcWj8gGUutvWpHNoTdUAQnDbXpna5IoCOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e6jGRykA4uNkW2pGmMCRLfXjX6RrsRDDTPu2qw0L4xZqWcHPMZ3Kh9kf3PXvCf0CfE2hhS8zjZ4kyx6bOfIFIyHUAvPUGfFk/H3UV2d9LtRE87fecfQpJRB7FlQzi8mBb56iH8Kg1h5q5swcDOwO2mBceiRxFOf4T1W6jW9JWwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lY0cU5eY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 718C5C4CEE3;
	Mon, 17 Mar 2025 11:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742210744;
	bh=XB9sbl+1FvcWj8gGUutvWpHNoTdUAQnDbXpna5IoCOc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lY0cU5eYGefSGzGxXT9oQp5bclz6egr1U5bbhAeWyvoyQFgt/IoMnsVRggtIY68xb
	 XV1uUEpUGMuiyWSpEYIRMRfAUPGavG+ptZhhHnk7N/yMau1uHIE5TAsG5VLR2JCJl/
	 QGGhVTLKpeHjqLfFglI+hLgeCeOicoNsiLAQObgNOFswrWUvcrF5DVsJr8xIn4dqK+
	 omVATlJuiPFqNEhBLDxIuIx4tgjc71KB6VtG9U7wVeWFDCDAQKGD2D/SdbolPyjZBa
	 /+AxGK2CVqhka1AjDHVP2g62lKGq9S23w83DXyZDhCIKQgzwSgtMxH+AZ8juANo7FV
	 dW/dG1rD1+vlA==
Date: Mon, 17 Mar 2025 12:25:37 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
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
Message-ID: <Z9gGsVt872Gdodh2@gmail.com>
References: <20250314160810.2373416-1-bigeasy@linutronix.de>
 <20250314160810.2373416-2-bigeasy@linutronix.de>
 <Z9ay49NsoC73dKXe@gmail.com>
 <20250317083155.9g9ksofZ@linutronix.de>
 <Z9fnf9g_zmbNXICh@gmail.com>
 <20250317092526.S1MfZldy@linutronix.de>
 <Z9f2_exjFEpTpuRr@gmail.com>
 <20250317103357.O6YuNbpr@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250317103357.O6YuNbpr@linutronix.de>


* Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> On 2025-03-17 11:18:37 [+0100], Ingo Molnar wrote:
> > Yeah, that's a valid concern.
> > 
> > The thing is, CONFIG_SCHED_DEBUG is mostly meaningless these days - all 
> > major distributions enable it because of the statistics are useful for 
> > system administration, tooling and general software development.
> > 
> > So we should enable it permanently and remove the #ifdeffery. I'll send 
> > out a series to do so soon.
> 
> If that is the way to go, the please Cc me and I rebase on top of it.

Let's do it the other way around - your series is mature enough I 
think, and the merge window is close.

Thanks,

	Ingo

