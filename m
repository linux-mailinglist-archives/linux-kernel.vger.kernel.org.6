Return-Path: <linux-kernel+bounces-385489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EFAA19B37C8
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 18:37:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D4021C21DD8
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 17:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F28781DF74A;
	Mon, 28 Oct 2024 17:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nnY3w8dB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD9C1DF729
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 17:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730137067; cv=none; b=QjsKWXV0V0qTKcWSAON+U3wWf33nMYnxs4strwe9Q9rBbo6Ah5lGZe5oEh+1snPpjwvTJTfkSJze/Byr9kvwKTdR/xu4JspAHnfWnKJYcDBUY9THmEuTqPyZJX9uZR8btjQ5OM1BrUMkoxmF2LJAYUGfw5kffUtdb4iqy3DkgZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730137067; c=relaxed/simple;
	bh=YKFdwPlvEwTcvdyN5mALjpp8/LZtoQLHqTBipTr9QKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ntCYNFTstUdv9ylvoPaXA1Qf3F15xuT9wKDk+KDK4jmz3ECUH60RPLosRRMkN59IfqRVH+SoMCz9si+0VXABOGJgdsIyMh3Ci4AWIeDJk/31lWWEc3wuHOiQ0ilWA6gWj/yNyaLb623SKyn+RSgnMx2Ay1TJDOhZ6ZBNiwrztR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nnY3w8dB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D66C5C4CEC3;
	Mon, 28 Oct 2024 17:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730137067;
	bh=YKFdwPlvEwTcvdyN5mALjpp8/LZtoQLHqTBipTr9QKg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nnY3w8dBPGQ6MTE/dZvBU/w5+bWe9wLCR5oz8nE0mhN2AoEtb055CX4Nl4KDqZydU
	 Ophfi4k0m4p46O9C9XQ5GhCxJ5Xvusxg7lTqKNV8/pWh02CvO8MXL8nfJu0/4uZQrx
	 /+o+J1qIoc3KotddafypjmB/3uOlVyj68X2uNrtTZm8JAgC4m2xd5d1cwV2WPp6Y9i
	 Af8RJ/WZaOq2JYb8YuwFvC5cVcdx8RdNhvN6cBhX9e4wwe47CW1QIXVe9FfaMfTX8H
	 ndPtFHrHD0M7vhIbLcn6Tm0EwYltB+9pvGkQiQGt3wZMV18rIQzQkS5YCJ1MEmdJpx
	 cXRjfVp6nU0ig==
Date: Mon, 28 Oct 2024 07:37:46 -1000
From: Tejun Heo <tj@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	David Vernet <void@manifault.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Ingo Molnar <mingo@kernel.org>, Rasmus Villemoes <ravi@prevas.dk>
Subject: Re: [patch v1A 2/2] sched/ext: Remove sched_fork() hack
Message-ID: <Zx_L6uCS9vvQTsna@slm.duckdns.org>
References: <20241028103006.008053168@linutronix.de>
 <20241028103142.423153706@linutronix.de>
 <87ldy82wkc.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ldy82wkc.ffs@tglx>

On Mon, Oct 28, 2024 at 02:20:35PM +0100, Thomas Gleixner wrote:
> Instead of solving the underlying problem of the double invocation of
> __sched_fork() for idle tasks, sched-ext decided to hack around the issue
> by partially clearing out the entity struct to preserve the already
> enqueued node. A provided analysis and solution has been ignored for four
> months.
> 
> Now that someone else has taken care of cleaning it up, remove the
> disgusting hack and clear out the full structure. Remove the comment in the
> structure declaration as well, as there is no requirement for @node being
> the last element anymore.
> 
> Fixes: f0e1a0643a59 ("sched_ext: Implement BPF extensible scheduler class")
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: David Vernet <void@manifault.com>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Ben Segall <bsegall@google.com>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Valentin Schneider <vschneid@redhat.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun

