Return-Path: <linux-kernel+bounces-239495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5D149260EB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 14:52:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC2F7B237D6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 12:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFEC8178360;
	Wed,  3 Jul 2024 12:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GtODGSCl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12FD21E4A9
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 12:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720011145; cv=none; b=bY1Uv2LxaNfbWeQFvEc55Tr1fTXn7B6b+HMm2Eb8pVZpsgbSx+1WoTd+3R9J5LSQaveGiaAPM/3c0ZPFXQxwsnimF0XygSfjNX0wrFVi/RJjSlx61TOhAwpzkTf++r/D++ZDGpAZa8QgDTvwuXRM0fM+8gxL9pzJ28ouHPjKkz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720011145; c=relaxed/simple;
	bh=K3q9isDJCgc7PzYtHI2xjbHaQnN2noNAiXF7TE18c44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ddytOi5X7it+/bI0ccpjzUUiSMfADIKkhFy2do8oIPg7opP4688mFATQEmERkdLoUFJLI/rbq7sKj7ZCQJnhT5jAogMmq3JuMSRQxw4hwwQ0PSdjB8TxwsUgkwLMk3rRUjGy9TufYx+wvc2US8+bwV1WctDBNm62VqmOi5fBPDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GtODGSCl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A9ACC4AF0C;
	Wed,  3 Jul 2024 12:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720011144;
	bh=K3q9isDJCgc7PzYtHI2xjbHaQnN2noNAiXF7TE18c44=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GtODGSCl6ts7VPIhjJUbBmJbCZbek5MQIQFyZxlXsVvntrNYHdjM8mg5db19H2EMp
	 rZ1MwuMUMKOkpdeLDgO2Ggv9C4s+LSNqXwKFBd3iKHbQ6aI0WQ6V/wGJ3+41HP925V
	 Anj7/b+UJH6OC4UubcyXh2hzpB3TWIwejwdERfj7PfagDoZtjYgnO0GUfZfsBEQTMt
	 Aw7pBoENHCDmP9VD3AydkM1FS/k7bi3f1Goo5TRU6CxPFSyG9w6gM4HqIK6HNM3COA
	 72RKdC2sCNm3MduHokF1qNA2cfShZD1iMmcojh5sUbSFL7+rTk5lFSBurkviznBqsz
	 O5YcCLtpz0TaA==
Date: Wed, 3 Jul 2024 14:52:21 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Michal Hocko <mhocko@suse.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Oleg Nesterov <oleg@redhat.com>
Subject: Re: [RFC PATCH 6/6] mm: Drain LRUs upon resume to userspace on
 nohz_full CPUs
Message-ID: <ZoVJhXcR26paUNhX@localhost.localdomain>
References: <20240625135244.20227-1-frederic@kernel.org>
 <20240625135244.20227-7-frederic@kernel.org>
 <ZnrSEf1xuFxKxj1D@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZnrSEf1xuFxKxj1D@tiehlicka>

Le Tue, Jun 25, 2024 at 04:20:01PM +0200, Michal Hocko a écrit :
> On Tue 25-06-24 15:52:44, Frederic Weisbecker wrote:
> > LRUs can be drained through several ways. One of them may add disturbances
> > to isolated workloads while queuing a work at any time to any target,
> > whether running in nohz_full mode or not.
> > 
> > Prevent from that on isolated tasks with draining LRUs upon resuming to
> > userspace using the isolated task work framework.
> > 
> > It's worth noting that this is inherently racy against
> > lru_add_drain_all() remotely queueing the per CPU drain work and
> > therefore it prevents from the undesired disturbance only
> > *most of the time*.
> 
> Can we simply not schedule flushing on remote CPUs and leave that to the
> "return to the userspace" path?

Do you mean I should add a call on return to the userspace path or can
I expect it to be drained at some point already?

The other limitation with that task work thing is that if the task
queueing the work actually goes to sleep and another task go on the CPU
and does isolated work in userspace, the drain doesn't happen. Now whether
that is a real problem or not, I have no idea.

> 
> I do not think we rely on LRU cache flushing for correctness purposes anywhere.
> 
> Please also CC linux MM ML once the core infrastructure is agreed on.

Ok, thanks.

> -- 
> Michal Hocko
> SUSE Labs

