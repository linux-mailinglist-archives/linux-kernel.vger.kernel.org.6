Return-Path: <linux-kernel+bounces-343512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C95DF989BE4
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 09:51:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F31F2829BB
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 07:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3F7715FD13;
	Mon, 30 Sep 2024 07:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bkjvfjJI"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5373F208D0
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 07:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727682667; cv=none; b=BMAOXWNfRtV69Fk4/r3EqwKYY45IxnMEd1IVYOPGUTEbQc25wtEXir3ts7imKm1En9MfhRLdzzXNtxuTDNpcMhrblogz7jlV8CKDRcU8WhZmFthuP3oBog5XxXhFcXTJORsgwn+FOFSxbBBy/3VRkFJIIfbmcOILWqJ4jBaRUHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727682667; c=relaxed/simple;
	bh=CI3z09N8Gto3sEfBX7ll5jCetWINIC+H0RsKA6TJm8w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NVOaBPvq/8Yo9b0wlhbm3l71l5stMp7QUZm4MS5mpTcAcKN/auwvNYcaM/eDKQvXsbBUDGE4CT2SF32e4fFMJZdSToz6fnIdVoswm44DvsdRk+hY/qaTQXc2/ddYe5G/inLaH00fteQT4aML6jgL5tjWWsU66E5W5cE2HiA9V+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=bkjvfjJI; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=8e4oAL8woCj1n4vFjmknY8QIMuhYd5ins6ja5aoTfzo=; b=bkjvfjJICS/iXwSqStqoVPRvXZ
	brnSgYPShUAAg/EInagZr+gTRVJN9yItRvWEI9LRY8HKG6drBjRqUpJ8OgxrOPCXru4d+do/vHTJH
	2/uL26u+VsvwgooE3J+5mjB0hDqXCxRwvcz9n4GIBqu0mqFMVVTMoU5SglZpfCbDm8ZXuBp0lW+ft
	ZwCZnINGE2r4U4lg0STlGzM25avGNIgIGs6L0Nzom1HuWDU7ddI71P1ZuBSX01jReSce0Wew3hNGp
	7x03ynuDoaV+fljZrVrP0oUdH8cJa5Wth7WX0/K9cwNnRcsXeLBH74VEM7jPCPsu/xZ5Va+U68S4Z
	J426r2bg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1svBB7-0000000Gi21-3EKH;
	Mon, 30 Sep 2024 07:50:46 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id EF585300754; Mon, 30 Sep 2024 09:50:45 +0200 (CEST)
Date: Mon, 30 Sep 2024 09:50:45 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Chen Yu <yu.c.chen@intel.com>
Cc: Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Chunxin Zang <zangchunxin@lixiang.com>,
	linux-kernel@vger.kernel.org, Chen Yu <yu.chen.surf@gmail.com>,
	kernel test robot <oliver.sang@intel.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>
Subject: Re: [PATCH v2] sched/eevdf: Fix wakeup-preempt by checking
 cfs_rq->nr_running
Message-ID: <20240930075045.GB5594@noisy.programming.kicks-ass.net>
References: <20240925085440.358138-1-yu.c.chen@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240925085440.358138-1-yu.c.chen@intel.com>

On Wed, Sep 25, 2024 at 04:54:40PM +0800, Chen Yu wrote:
> Commit 85e511df3cec ("sched/eevdf: Allow shorter slices to wakeup-preempt")
> introduced a mechanism that a wakee with shorter slice could preempt
> the current running task. It also lower the bar for the current task
> to be preempted, by checking the rq->nr_running instead of cfs_rq->nr_running
> when the current task has ran out of time slice. But there is a scenario
> that is problematic. Say, if there is 1 cfs task and 1 rt task, before
> 85e511df3cec, update_deadline() will not trigger a reschedule, and after
> 85e511df3cec, since rq->nr_running is 2 and resched is true, a resched_curr()
> would happen.
> 

So I'm applying the patch (that change was not indended), but I'm a
little confused by the above description. If we already have TIF_RESCHED
set, then doing resched_curr() should be a NO-OP.

At the same time, how can we have an RT task and not get TIF_RESCHED
set.

