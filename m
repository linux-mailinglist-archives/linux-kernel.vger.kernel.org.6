Return-Path: <linux-kernel+bounces-544232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C70FA4DF20
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 14:24:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A180C1887D1C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 13:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4038204581;
	Tue,  4 Mar 2025 13:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VMLERQIx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511B0202C2D
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 13:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741094662; cv=none; b=DVrFGE7FmaBsKATILD7Iu/q3zzjyc5CN3GNpY/FcvB4mJVevADlYgAKSIhdMQ/mLidGyRddItAQZOUC5S/CBdLJ2loem3+G36XrUaBgShXgdgYg5+ZJjzfPoz7wI0Mhmzc+Hrbb+mX8J3P4LeBbSXTsTgRVo111a9tOnULYTPPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741094662; c=relaxed/simple;
	bh=VWJ2JqFcp8Axpz+IPJNcbUoYnVh59FXLktDoI76xwVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TmS993RDJemG9Uk1IBYuvRz510hjvcy8d9LznCVVrV6nm7alfYSYcJ9Vm0zMSR4/Vyv5zetl8RS8hKMOf+w4mue6vmQfSLsamhR2t0OqXN6JtxPnYcK9irQ/Tti4lNuxxB/GVSz4BL5QTYgM7yc8dMz8sWtYp5rLMMgTSaHkKnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VMLERQIx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4560C4CEE7;
	Tue,  4 Mar 2025 13:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741094662;
	bh=VWJ2JqFcp8Axpz+IPJNcbUoYnVh59FXLktDoI76xwVg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VMLERQIxNMhU3OGu18p2IGnv/CM3zZB5bg7fqAAoNLupRSEvU3zIyVsZ79Fte9l0b
	 zE3WLkMlNNvblhS260rFQ+uDkjmFgCDgFoSlocSDLVy3xTmUrYtIbG4kKY4dy3gZEI
	 HV4EYw4xLMW2bQJLKdG6lCmtXhvUbSgR4NTZU9AAf3AowOXsj3wGOG+Lip4tJA50ox
	 4B3KvfyXKr1CI2yyrgW1mgCikY4oz2RQ/5Ukhjl+f6sxiHuGLxlrsuEOSqsyug8YfY
	 KPMKKvlr6G0rkdwyXtOFYhg9Ftg2FS9/E3kW0SkzaC9ZoWbB1OmaOXK5p3QpTmc5SG
	 Mkwk5c5yTBqZA==
Date: Tue, 4 Mar 2025 14:24:19 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Phil Auld <pauld@redhat.com>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Waiman Long <longman@redhat.com>,
	Vishal Chourasia <vishalc@linux.ibm.com>,
	Vineeth Reddy <vineethr@linux.ibm.com>
Subject: Re: [PATCH v2] sched/isolation: Make use of more than one
 housekeeping cpu
Message-ID: <Z8b_A4YnOcNzGcaU@localhost.localdomain>
References: <20250218184618.1331715-1-pauld@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250218184618.1331715-1-pauld@redhat.com>

Le Tue, Feb 18, 2025 at 06:46:18PM +0000, Phil Auld a écrit :
> The exising code uses housekeeping_any_cpu() to select a cpu for
> a given housekeeping task. However, this often ends up calling
> cpumask_any_and() which is defined as cpumask_first_and() which has
> the effect of alyways using the first cpu among those available.
> 
> The same applies when multiple NUMA nodes are involved. In that
> case the first cpu in the local node is chosen which does provide
> a bit of spreading but with multiple HK cpus per node the same
> issues arise.
> 
> We have numerous cases where a single HK cpu just cannot keep up
> and the remote_tick warning fires. It also can lead to the other
> things (orchastration sw, HA keepalives etc) on the HK cpus getting
> starved which leads to other issues.  In these cases we recommend
> increasing the number of HK cpus.  But... that only helps the
> userspace tasks somewhat. It does not help the actual housekeeping
> part.
> 
> Spread the HK work out by having housekeeping_any_cpu() and
> sched_numa_find_closest() use cpumask_any_and_distribute()
> instead of cpumask_any_and().
> 
> Signed-off-by: Phil Auld <pauld@redhat.com>
> Reviewed-by: Waiman Long <longman@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Frederic Weisbecker <frederic@kernel.org>
> Cc: Waiman Long <longman@redhat.com>
> Cc: linux-kernel@vger.kernel.org
> Link: https://lore.kernel.org/lkml/20250211141437.GA349314@pauld.westford.csb/

Acked-by: Frederic Weisbecker <frederic@kernel.org>

