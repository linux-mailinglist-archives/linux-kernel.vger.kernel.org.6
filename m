Return-Path: <linux-kernel+bounces-568813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE3EA69AAF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 22:15:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7655A8A6A88
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 21:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2529A1EC013;
	Wed, 19 Mar 2025 21:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ObhiuStn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8739A801
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 21:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742418876; cv=none; b=OTk8LyvD4B+KpB/L5NhBQ8c66P7EGudavuD76dq/0a0/wHIkMr+lBko0WtORHm/izXkWF8rWRizAbOV3huAPcq1/udtYdrWawlRlz/l7LYs/dFfeQ4avyg+ruUNgR98hQkldIHTMjaOtl1cAMwc7zmxTicJOaliSmu6qtWsUMs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742418876; c=relaxed/simple;
	bh=SzhKJd816KDQDVnISeC1XIzQ11PdNLZf8nIMHNo99Y8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=je5vWs66+qRfYhNrQ7wL/cG4GVJZabwWrMaDFl9uZkY6RKOEjTkfWCTr4IFjWC1FBhUMJ4ssToVlVY6cBsPU2v1XjIp5rUXkDB3d9gGzq6rHgX5ZojZ373XaynCgxTA/jrA9/eSpaR5qJTCumGTxq8tC8C0gs1X2hzdKz+xMcgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ObhiuStn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94B61C4CEE4;
	Wed, 19 Mar 2025 21:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742418876;
	bh=SzhKJd816KDQDVnISeC1XIzQ11PdNLZf8nIMHNo99Y8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ObhiuStnHRBczFNqk0OMx3ZE46s4AXyq3IosKfrQJgB+i4xzTV5yOCYJDRitvwbR7
	 BkPWfguiI8v40c2Vybu/UhKn5bdQ2+kxaYih098AKD8e4b2pN2l+4xHwTF8tU0JhQC
	 3oEfK9KdxV4JKp0zox+dMgUWUvPswSvPCyiqTVyr1GNA8GxmXFSzgXrC+yul5W58mW
	 0LWQbj48+BJSiRPbXQpHtRPLu8Z8mS7oj7dTBOzqiy0Tzw/tG2ZIEcvse98jJTC0aU
	 0qWYUkrmQV2W09gstjbiG0g7juCzngQfLYz3vALyx8i6cZ+s5ytyQR03cyvOYsPLqS
	 jOzcIH46+eoDQ==
Date: Wed, 19 Mar 2025 22:14:31 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>, Mel Gorman <mgorman@suse.de>,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH 0/5] sched: Make CONFIG_SCHED_DEBUG features unconditional
Message-ID: <Z9szt3MpQmQ56TRd@gmail.com>
References: <20250317104257.3496611-1-mingo@kernel.org>
 <83c3bd7f-3ff9-4d3c-ab3e-981b73b95141@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83c3bd7f-3ff9-4d3c-ab3e-981b73b95141@linux.ibm.com>


* Shrikanth Hegde <sshegde@linux.ibm.com> wrote:

> 
> 
> On 3/17/25 16:12, Ingo Molnar wrote:
> > For more than a decade, CONFIG_SCHED_DEBUG=y has been enabled
> > in all the major Linux distributions:
> > 
> >     /boot/config-6.11.0-19-generic:CONFIG_SCHED_DEBUG=y
> > 
> > The reason is that while originally CONFIG_SCHED_DEBUG started
> > out as a debugging feature, over the years (decades ...) it has
> > grown various bits of statistics, instrumentation and
> > control knobs that are useful for sysadmin and general software
> > development purposes as well.
> 
> A tunable like base_slice which is the only tunable available for EEVDF is under the debug.
> So an option is to get rid of CONFIG_SCHED_DEBUG and make it available to all.
> 
> We had seen performance regression when domains folder was built with cpu hotplug.
> Later that was moved iff verbose was enabled. Maybe something like that can be done
> if something is hurting performance.
> 
> > 
> > But within the kernel we still pretend that there's a choice,
> > and sometimes code that is seemingly 'debug only' creates overhead
> > that should be optimized in reality.
> > 
> > So make it all official and make CONFIG_SCHED_DEBUG unconditional.
> > This gets rid of a large amount of #ifdefs, so good riddance ...
> > 
> 
> There are some references in selftest like these, maybe remove them as well?
> 
> tools/testing/selftests/sched_ext/config:CONFIG_SCHED_DEBUG=y
> tools/testing/selftests/sched/config:CONFIG_SCHED_DEBUG=y
> tools/testing/selftests/wireguard/qemu/debug.config:CONFIG_SCHED_DEBUG=y

Indeed - fixed.

I left out all the defconfigs from the patches, because there's a lot 
of them (~79 reference CONFIG_SCHED_DEBUG ...) and they get refreshed 
naturally in any case.

> Also ran unixbench and hackbench on 80 CPU system (1NUMA) with and 
> without CONFIG_SCHED_DEBUG. hackbench numbers are almost the same.
>
> for unixbench, process creation/Context Switching show 1-2% 
> improvement with CONFIG_SCHED_DEBUG=n

Thank you for the testing! I'll add:

  Tested-by: Shrikanth Hegde <sshegde@linux.ibm.com>

to the series if you don't mind.

And irrespectively of this series we should probably look at that 1-2% 
overhead in unixbench context switching overhead, maybe there's a few 
low hanging fruits in the debug code.

	Ingo

