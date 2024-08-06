Return-Path: <linux-kernel+bounces-275854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E63AA948AFF
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 10:13:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22B451C22A92
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 08:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 347FC1BC9F4;
	Tue,  6 Aug 2024 08:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="st9UVMC/"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB511BBBE0
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 08:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722932028; cv=none; b=oZtgCUjB9jb1dmbfPSchMn3Tx23tDBoAziISH9fn0m1uy8ee6EP3IOqwzxp5PZSbxRirfgD2HfewPF8QrYB/aeN9MW1yjf5y8r8zNChI4UN2vFHCnw4/gRuz+XkP5vgtP2NtCsi4et6GYhamcrVAWqHO/Pu7tc/YaAaqBNcytWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722932028; c=relaxed/simple;
	bh=ObYpYrq1VI6WI25qh+gsblu9I2m9rPwb8E5yirq0qsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gYfbOiQepv7dGSutFE97t+7W9CTyLCFOI1MJIarCsNXAdAA97pb6cNKacGI5J9gxccUziwrlKWFNe2evcyGJItOv6myv0HPcFbWWimP1G13hQc82RONGJOz5eYMKiEwf4Isfm+xeslYacCjeycsezvTE8RT75OaclV5AUtadMGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=st9UVMC/; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=F7/dbo8KkUzj7hjXzbEgGbdxcPMK/9QH+lMkCQK1eXk=; b=st9UVMC/8Z64Y+b+U10299RAmG
	xwFkhoGgWsXUSNU5+vE5515eblghqKr+XIncFn7GEruV+fljeryeXJsJDMKkguQp2R725fQXaUUYB
	ycgONcGIPL7u8shTTfqb3qSOriEN7RHHHAVEEhpy2GWbvpvyJWoQPwXlzaH9b//tx4jaNVPaMbLBl
	kwRMvzMIhrm+49T/9e98YtbVvWMtGBn3pKyanRSmHbhTuRP8EwHGFh72Mq/ylWwavNL02SReCSCel
	M0/blVzIw8x3JXg6SjTLkCY3B/T81WuDMkVMr6iZKH4kP8mDsY23X7BInaUu6GG+BL3vfdwPOjMnX
	zD8yOpbQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sbFKA-00000005R2X-2GN0;
	Tue, 06 Aug 2024 08:13:42 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 2D62330049D; Tue,  6 Aug 2024 10:13:42 +0200 (CEST)
Date: Tue, 6 Aug 2024 10:13:42 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Tejun Heo <tj@kernel.org>
Cc: void@manifault.com, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	mingo@redhat.com
Subject: Re: [PATCHSET sched_ext/for-6.12] sched_ext: Misc updates
Message-ID: <20240806081342.GO37996@noisy.programming.kicks-ass.net>
References: <20240804024047.100355-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240804024047.100355-1-tj@kernel.org>

On Sat, Aug 03, 2024 at 04:40:07PM -1000, Tejun Heo wrote:
> Misc updates mostly implementing Peter's feedbacks from the following
> thread:
> 
>  http://lkml.kernel.org/r/20240723163358.GM26750@noisy.programming.kicks-ass.net
> 
> This patchset contains the following patches:
> 
>  0001-sched_ext-Simplify-scx_can_stop_tick-invocation-in-s.patch
>  0002-sched_ext-Add-scx_enabled-test-to-start_class-promot.patch
>  0003-sched_ext-Use-update_curr_common-in-update_curr_scx.patch
>  0004-sched_ext-Simplify-UP-support-by-enabling-sched_clas.patch
>  0005-sched_ext-Improve-comment-on-idle_sched_class-except.patch
>  0006-sched_ext-Make-task_can_run_on_remote_rq-use-common-.patch

Aside of that one nice in the last patch these look good. Thanks!

