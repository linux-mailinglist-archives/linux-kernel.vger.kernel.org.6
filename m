Return-Path: <linux-kernel+bounces-229114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93CF5916B16
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 16:54:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B07F1F2542F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 14:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A583916F90F;
	Tue, 25 Jun 2024 14:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PrnOnP7n"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0F016F8FC
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 14:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719327241; cv=none; b=P37/OqHreZdM3rZl05FqtmFDAbp+D7gApk5Y4ZryUmbdj73rV/2s+3jmuKDpApSK65iuzXPUz4WQMpZtSUosgSgx5y4CUhn8kzcjx6I2T8yAb6tOAr1z+kmIxzc19j0EU9qAc6SxzwaNNOgC45OlcFFe17W4R2EhsuY96JUEgpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719327241; c=relaxed/simple;
	bh=niAnUsMIiZcwGbHf89s+zBEZQ68m+OKzAV5rf2+7qDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c0qRY5l96Ja35E5Bz5rTGpvXcKtXQV+t8HPLWMjFyG83iFqXj10vWWJ64+yhuw31SrBwVjeu/yKZCHxeONXNrEyH/Pxkx+vJ9Adf/x4r7Bo/ooX60T6wOzuX/MM+kyLNrterrS+SGkrXPf2p1x+tf8cJ8ZZ8MhJ7c4pqUE07v4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PrnOnP7n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58241C32781;
	Tue, 25 Jun 2024 14:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719327240;
	bh=niAnUsMIiZcwGbHf89s+zBEZQ68m+OKzAV5rf2+7qDw=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=PrnOnP7na4jwYqdxzkJua8AERGOhotbmfJK21YvLWAtEWALFGcgln7GU6idNNUDbg
	 YQ4zt8/1jPE4l78AJ92Rp/cOMJ498DB905lunCx/VxBJm5vnp9ss+XVTtxUsVS8Jtw
	 Z5hGa3dtQnW1do3UYV79RpT74djsNcm0V4mabK5h5RR1VGeGs56TGC6ecLSDVb4ZuJ
	 w0nuRxERc4/qOQOV1ZBNOOuJAjjeQSrlb7FWl3o5kAnZa2TqHPYlz0Rugm5m2hRcVW
	 XlNPgkDNGx+3EGr32kD6Zy3KU/ALEc57wLTWBQFZYYOjIfNVUllIEA+ogHNTxm8+Zq
	 PiYiw+bWqB1uA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 3CFAECE0760; Tue, 25 Jun 2024 07:53:59 -0700 (PDT)
Date: Tue, 25 Jun 2024 07:53:59 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] Fix scalability problem in workqueue watchdog touch
 caused by stop_machine
Message-ID: <9d1d4a41-fcdb-448c-9a0f-bc9909193fa9@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240625114249.289014-1-npiggin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240625114249.289014-1-npiggin@gmail.com>

On Tue, Jun 25, 2024 at 09:42:43PM +1000, Nicholas Piggin wrote:
> Here are a few patches to fix a lockup caused by very slow progress due
> to a scalability problem in workqueue watchdog touch being hammered by
> thousands of CPUs in multi_cpu_stop. Patch 2 is the fix.
> 
> I did notice when making a microbenchmark reproducer that the RCU call
> was actually also causing slowdowns. Not nearly so bad as the workqueue
> touch, but workqueue queueing of dummy jobs slowed down by a factor of
> several times when lots of other CPUs were making
> rcu_momentary_dyntick_idle() calls. So I did the stop_machine patches to
> reduce that. So those patches 3,4 are independent of the first two and
> can go in any order.

For the series:

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

> Thanks,
> Nick
> 
> Nicholas Piggin (4):
>   workqueue: wq_watchdog_touch is always called with valid CPU
>   workqueue: Improve scalability of workqueue watchdog touch
>   stop_machine: Rearrange multi_cpu_stop state machine loop
>   stop_machine: Add a delay between multi_cpu_stop touching watchdogs
> 
>  kernel/stop_machine.c | 31 +++++++++++++++++++++++--------
>  kernel/workqueue.c    | 12 ++++++++++--
>  2 files changed, 33 insertions(+), 10 deletions(-)
> 
> -- 
> 2.45.1
> 

