Return-Path: <linux-kernel+bounces-424508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EB349DB524
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 10:56:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9146EB25C0A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 09:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88303157A67;
	Thu, 28 Nov 2024 09:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eXmoYhFI"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B2B156238
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 09:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732787813; cv=none; b=WorH4YoVytfOmXu24oU2pTptIHDVhvYYaWfAQITzWqMJ0LrpJzI0HAquAl0vtTwVYTSSA1t2IMF/w0aVlqaXHDSJ8j7Mc7uxT7tUGGqv23ZKCY0YNtjPFxisWEAbgULpsOIfmOjws18XMPEbTx+l9TbvaworiNTk8Op1vcGL2Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732787813; c=relaxed/simple;
	bh=KHlS6Inh+8TL2i1n1t/uRbLDYXYhVJ0ix3PVDXu7rlI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PK8EnHq7RgD6F0RwvW61jIer/j9E6S/49M05jzSydWltTtj14NIlz3AISSJAVMBOujycWLPJagHUv/EAbOIK3N1nr/Xwdr1XUL9pqIZcbz92gt7ujeb8kE97WESMUhmQ2sKlqc6cgtTS4ey6py3fGkpJAzggFsVlmcWRaCvWIHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=eXmoYhFI; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=tyMBcGhdrpbofxu5fzC92eHHIzVsVHYQbkYn0+5nD+g=; b=eXmoYhFIIMWUJPm+A+ajNAlO/u
	abT9eppglWDOnzB0EPsgnN+ZbMPljIBntf9DxeOT2bt6wFuhn4eMLfcyrCPuLbDaDrT9MxJJbenYk
	HUya7i/Ra8amHbrgYcxNHIcdg0iZSIZcZ2Q+0xLfkd7S/7rHCMr8qe2lG+Zm3wNO7I0OWuKxGQkHx
	HHIWzdLT2ZW/o35mBfO6jGdFkaAvk37NLpWoMGKMUh3iuTAM511/OyXinHLhkkxdo2qpS424+jDnu
	5OyeQknzP/CVo1Nvuyoq+EDZxOmycvLQyWAM3pm6UJ5bxMZ+zo7iWijLNoxIJK0EZLiLtb8KadrzN
	T/IYEcNA==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tGbGO-00000001aBv-24Rk;
	Thu, 28 Nov 2024 09:56:44 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 1581C300271; Thu, 28 Nov 2024 10:56:44 +0100 (CET)
Date: Thu, 28 Nov 2024 10:56:43 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: mingo@redhat.com, juri.lelli@redhat.com, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, linux-kernel@vger.kernel.org,
	kprateek.nayak@amd.com, pauld@redhat.com, efault@gmx.de,
	luis.machado@arm.com
Subject: Re: [PATCH 2/9] sched/fair: Add new cfs_rq.h_nr_enqueued
Message-ID: <20241128095643.GB24400@noisy.programming.kicks-ass.net>
References: <20241128092750.2541735-1-vincent.guittot@linaro.org>
 <20241128092750.2541735-3-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241128092750.2541735-3-vincent.guittot@linaro.org>

On Thu, Nov 28, 2024 at 10:27:43AM +0100, Vincent Guittot wrote:
> With delayed dequeued feature, a sleeping sched_entity remains enqueued
> in the rq until its lag has elapsed. As a result, it stays also visible
> in the statistics that are used to balance the system and in particular
> the field h_nr_running when the sched_entity is associated to a task.
> 
> Create a new h_nr_enqueued that tracks all enqueued tasks and restore the
> behavior of h_nr_running i.e. tracking the number of fair tasks that want
> to run.

Isn't h_nr_enqueued := h_nr_running - h_nr_delayed ? Does it really make
sense to have another variable that is so trivially computable?

Also naming; h_nr_enqueued isn't really adequate I feel, because the
whole problem is that the delayed tasks are still very much enqueued.

