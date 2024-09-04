Return-Path: <linux-kernel+bounces-314987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E327A96BBC5
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 14:15:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21ACB1C21BE6
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 12:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 832F31D014F;
	Wed,  4 Sep 2024 12:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sjQhYWvQ"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F177C1917E3
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 12:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725452129; cv=none; b=jh72zxhyScnm/0H4HFL26t+PtF6kyHdgT7OCVX0QpPZmLmOGh3lkiZCy34fgT+2lBF8ESXSxlHwRYomnjoSYeVhxfe7+MPcBVoSQrCWPGaW6zZ9A7Caq6jdGDefosH5Fd0o/lRL4GsvFhuc/soiHivsa57hecHB+FcIlYA4p3Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725452129; c=relaxed/simple;
	bh=64gfv3s+htMpmdun/7Zzr72Fv4YYVzlBsASj1s+JTqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jScWPsUh7//STTstg8i6QXTZ3KSPa3OzejEYD3oot0Wp6M05tmgBshDUcAeDNro6XoqWEwhhLKT113aIKSIksaL6NQpVaejQzMdrXahiGX9sMSAQx31QbXia3wksv9OqS7HYGfvZU/1QtfkoUza98riC+xcwepWtl+9CDnvC4t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=sjQhYWvQ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=7rrD7mnSuxzVizNijNZEIP45VR8f0WolBw+WuajR4Q8=; b=sjQhYWvQMO24sSpItwfGmOTvcG
	7H0ST8u+KStZkQ5P3aCi9iYpQ9Ij72wjS8QiY0/cFO6upn3PVSyrqXU1tk1FrrsSKuguhRprYoMAO
	2O9XusPRLt8GBnjTD9yZRek45uRYw6re/ngLVywrn+j84jYZ/vWQ+ddaHdmoNEahkbwpZYESAip7a
	fCuz75QOiqWwo5VYEws1AchYcafSWKdLu5MM2AFZ8p8bkFXw5IR8nkmSFZ5yx1GvHVFLeEeo+VYJj
	pLvpidida3rX9XW3x9gdzKg2Ub2rPVNCJ5b9bmcMOuNyhWqf0RVVMGqQ6NMY8S9kwC0taxxmwrSz8
	XBJKBIKg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1sloum-00000000pKX-2Yu0;
	Wed, 04 Sep 2024 12:15:13 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 1F468300642; Wed,  4 Sep 2024 14:15:13 +0200 (CEST)
Date: Wed, 4 Sep 2024 14:15:13 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Leonardo Bras <leobras@redhat.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Rik van Riel <riel@surriel.com>,
	Thorsten Blum <thorsten.blum@toblux.com>,
	Zqiang <qiang.zhang1211@gmail.com>, Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	linux-kernel@vger.kernel.org,
	"Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Chen Yu <yu.c.chen@intel.com>, Julia Lawall <Julia.Lawall@inria.fr>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [RFC PATCH v2 4/5] softirq: Unify should_wakeup_ksoftirqd()
Message-ID: <20240904121513.GH4723@noisy.programming.kicks-ass.net>
References: <20240904111223.1035-1-kprateek.nayak@amd.com>
 <20240904111223.1035-5-kprateek.nayak@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904111223.1035-5-kprateek.nayak@amd.com>

On Wed, Sep 04, 2024 at 11:12:22AM +0000, K Prateek Nayak wrote:

> @@ -118,14 +101,40 @@ EXPORT_PER_CPU_SYMBOL_GPL(hardirq_context);
>   * the task which is in a softirq disabled section is preempted or blocks.
>   */
>  struct softirq_ctrl {
> +#ifdef CONFIG_PREEMPT_RT
>  	local_lock_t	lock;
> +#endif
>  	int		cnt;
>  };
>  
> -static DEFINE_PER_CPU(struct softirq_ctrl, softirq_ctrl) = {
> +static DEFINE_PER_CPU_ALIGNED(struct softirq_ctrl, softirq_ctrl) = {
> +#ifdef CONFIG_PREEMPT_RT
>  	.lock	= INIT_LOCAL_LOCK(softirq_ctrl.lock),
> +#endif
>  };

With the exception of CONFIG_DEBUG_LOCK_ALLOC (part of LOCKDEP)
local_lock_t is an empty structure when PREEMPT_RT=n.

That is to say, you can probably get by without those extra #ifdefs.

