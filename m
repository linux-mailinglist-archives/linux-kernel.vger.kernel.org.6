Return-Path: <linux-kernel+bounces-341112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A1F6987B70
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 01:00:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDC95282435
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 23:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32BF6183CAF;
	Thu, 26 Sep 2024 23:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IyYyOD4s"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901F1282FA
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 23:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727391640; cv=none; b=JkzwMpgHHaEVs5h9pYTUXKSSlO03Z5EcGufz4MHsq9TVJ1/6idPHJ2c1s5hMR9KVUSxPJoSEjuyDJ9Fv9zfy7DHCP8xQbp8SRyg3y46cD+zxUkXWnjUIkttyHEe7TRvBmasvIF8hI6ePoKNKjTzHE6WyjGWiC4M97Ya3zdEbj4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727391640; c=relaxed/simple;
	bh=pmf7ub6g8CXr0rQj/+rBhki9ttfduvcBTuEyy6tQBEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KbhSry/wDLDFN8l7LCzPazRl1FpIj9L14zeP8UtfirE534T8CthNx+/T8dFfUuJxZbQL5FswWH2mhTF69Cpekcql75zWicvAars7GXtx0TYcGiiPfW28QPdFIBC10LUaOXh5shCk3jPxtiM7p1KIRKC8ywF5BymRtZGNWw7SzTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IyYyOD4s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC5E0C4CEC5;
	Thu, 26 Sep 2024 23:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727391640;
	bh=pmf7ub6g8CXr0rQj/+rBhki9ttfduvcBTuEyy6tQBEQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IyYyOD4siTJAgGVBlxj0m52774zKuH2na/mpDEWZFTdOZftrUo0y2zP9vjI3OG98k
	 +D+227A+XvDGiOwjwPIER0qkKkh4znOSgHtkqygs/Co8Ts7UfIIqQPJvRU8UGmQQwN
	 stHgSF4xoMildSOLrVuy8kqgxYwMDvITP+X8mXh1JKXRnjfHbQv88IY2/rmM6WNqsL
	 MBUyxIx2Cle2vJNm2MLEynM518kB9eSQ/noZa3m4ajBcwJ6AUnESawVVne1Y4ooHY2
	 FP0c5lXCq5HWeEQmm31jR/43Mq2958+rZcAWRje4JsrsB6myYzFVqOnYDwdwarGOTI
	 YJO/gynNoFPig==
Date: Thu, 26 Sep 2024 13:00:39 -1000
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com
Cc: kernel-team@meta.com, linux-kernel@vger.kernel.org, sched-ext@meta.com
Subject: Re: [PATCHSET sched_ext/for-6.12-fixes] sched_ext: Split
 %SCX_DSQ_GLOBAL per-node
Message-ID: <ZvXnl29kN4zPtGxU@slm.duckdns.org>
References: <20240925000622.1972325-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240925000622.1972325-1-tj@kernel.org>

On Tue, Sep 24, 2024 at 02:06:02PM -1000, Tejun Heo wrote:
> In the bypass mode, the global DSQ is used to schedule all tasks in simple
> FIFO order. All tasks are queued into the global DSQ and all CPUs try to
> execute tasks from it. This creates a lot of cross-node cacheline accesses
> and scheduling across the node boundaries, and can lead to live-lock
> conditions where the system takes tens of minutes to disable the BPF
> scheduler while executing in the bypass mode.
> 
> This patchset splits the global DSQ per NUMA node. Each node has its own
> global DSQ. When a task is dispatched to SCX_DSQ_GLOBAL, it's put into the
> global DSQ local to the task's CPU and all CPUs in a node only consume its
> node-local global DSQ.
> 
> This resolves a livelock condition which could be reliably triggered on an
> 2x EPYC 7642 system by running `stress-ng --race-sched 1024` together with
> `stress-ng --workload 80 --workload-threads 10` while repeatedly enabling
> and disabling a SCX scheduler.
> 
> This patchset contains the following patches:
> 
>  0001-scx_flatcg-Use-a-user-DSQ-for-fallback-instead-of-SC.patch
>  0002-sched_ext-Allow-only-user-DSQs-for-scx_bpf_consume-s.patch
>  0003-sched_ext-Relocate-find_user_dsq.patch
>  0004-sched_ext-Split-the-global-DSQ-per-NUMA-node.patch
>  0005-sched_ext-Use-shorter-slice-while-bypassing.patch

Applied to sched_ext/for-6.12-fixes.

Thanks.

-- 
tejun

