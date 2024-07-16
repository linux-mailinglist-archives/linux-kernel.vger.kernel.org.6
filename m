Return-Path: <linux-kernel+bounces-253586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FC88932369
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 11:54:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C1BB2828D2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 09:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 770DD19755B;
	Tue, 16 Jul 2024 09:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jwbB1YGt"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E13E2E832
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 09:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721123682; cv=none; b=HwBkK58OJYRnfPqSrR5/WiaeaFtUIhPsUn518ugeaf2Yxc4lNUI/c6IpuQ+67r9nVtNvo3LGpdEdHr0ybmc+I+ajuQwH+W2MhX175+s8cPKaK05+GocsgxzifyFRZmapVIvGCZaI3SRNhXbg3jFZkkYtVYwQLuq7+3QVNAO2soQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721123682; c=relaxed/simple;
	bh=6QH8R/1HWB0XuEym5YNV/rUkes423H8SZXKnb8Hi1uI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PESbi3mFqndg35WroHyF0Ff5TMfjN/a+nlGlyyOOquuPA/cBQ6iTdD5sTQ6xK2X431Oc2afgIMGAgb6G08Mnfvx6E3bIqSVXVFsnrr7AEdh+NE7GdK80eThuefdpkAs6TT+WwoUqfONN72wDRLb2v0hG6zCY/K1G7ra0R6B+zaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=jwbB1YGt; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=bMU282zY45MrRosFfHO7c1Cn23kVioUJD3+wNn5yMCo=; b=jwbB1YGtqBwVWIidX25VPofAPC
	2pNtQ5t2ZL+vkhCZNBEvxDI7q/aDxNa35qRTeOHVF26pbNFFhms3zHk//eyzc3ITGF1QNvZ1fulR8
	SNf4AfAqTMt9XGShSXCo8oF8ugT4qvn2M7a3YAFO03rx438D9RNZKUmsoSYjNjuPiAKfKMmHUCS92
	LlXUwaa7OoQIbRPuM6DNkTHpKqwo765+ur30mT3k5Z1xl29SAz+1+8T2jpJLbB1BHHm6mrv+YO5ui
	DEdEbyG2goUFGhH6KNytrG28CP2FeiayHBFeMjiWk0bazeFA8DNFS2Ner4D9QAK7HpdsI1t9AThn3
	vk2U6Wuw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sTet2-00000002114-0Tfz;
	Tue, 16 Jul 2024 09:54:20 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 0F3F03003FF; Tue, 16 Jul 2024 11:54:19 +0200 (CEST)
Date: Tue, 16 Jul 2024 11:54:18 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Yang Yingliang <yangyingliang@huaweicloud.com>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	bristot@redhat.com, vschneid@redhat.com, tglx@linutronix.de,
	yu.c.chen@intel.com, tim.c.chen@linux.intel.com,
	yangyingliang@huawei.com, liwei391@huawei.com
Subject: Re: [PATCH 0/4] sched/smt: Fix error handling in
 sched_cpu_deactivate()
Message-ID: <20240716095418.GD26750@noisy.programming.kicks-ass.net>
References: <20240703031610.587047-1-yangyingliang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240703031610.587047-1-yangyingliang@huaweicloud.com>

On Wed, Jul 03, 2024 at 11:16:06AM +0800, Yang Yingliang wrote:
> From: Yang Yingliang <yangyingliang@huawei.com>
> 
> sched_smt_present decrement and set_rq_offline() is called before
> cpuset_cpu_inactive(), if cpuset_cpu_inactive() fails, these two
> things need be rollback.
> 
> Yang Yingliang (4):
>   sched/smt: Introduce sched_smt_present_inc/dec() helper
>   sched/smt: fix unbalance sched_smt_present dec/inc
>   sched/core: Introduce sched_set_rq_on/offline() helper
>   sched/core: fix unbalance set_rq_online/offline() in
>     sched_cpu_deactivate()
> 
>  kernel/sched/core.c | 68 +++++++++++++++++++++++++++++++--------------
>  1 file changed, 47 insertions(+), 21 deletions(-)

Thanks!

