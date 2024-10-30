Return-Path: <linux-kernel+bounces-388525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C467E9B60BB
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 12:01:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83BE128207A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 11:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1379A1E285C;
	Wed, 30 Oct 2024 11:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Dgi1j5mU"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA1A374F1
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 11:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730286067; cv=none; b=cXm/UwSehTgnjYf6tg3zNUMlJRqR/LlCGBy0nKQ6xnVdqCa1LWLYnLCSigxqARjmkEe3U9fU9p9HY9dsRuBGRtrkQZTyhWrpMerxGXJ675Ugj8QmmZ8LKcdKF0LoX8Fim6HIA+EBIufNWHDdsvOqWZweV9tpl2kYuI1uVkM2gSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730286067; c=relaxed/simple;
	bh=FdqQgkr6nyj5UIrSkVF1FPhTvx2Ly5K1TjMARDT8dtU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WayolVvKBr2/eX3prvByOSwxp2Bp4W/+K17r6lw63fk/8jcsPIczPAfageGroca+Qm5gQA6e9St02ewLFPKRE5BUcdU3u9NqBExdRVL3q04lzbwoQsxDdzcDs6zKn0yZz5kFxyRU20T42FGuZbvJmnW/7E0B7DcKeZEcbt0lYyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Dgi1j5mU; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=dro8xWc27MCENjI9Eb4iLkZ+EZf2BtDA/T4dTqKV1oQ=; b=Dgi1j5mUIc6SAPmt1FmNEGw0Uj
	JiNl9PkPCPAmN1G/PB3XO/svCGSUkH2oO4iYCH5eMKg+JQXKEvNB2wsJAts9wDI4L5W+IyQHCr8WS
	eWT1Yu3vUlxHKZi77uxCwfTJhyft5RpHHZJa1M7rPkHqS7fysC0ghzGRmU573CK1pAQfEELXLb/Al
	cwAw7YoNrBFkivxvJ/dQYzoOO3tUAdn13uuKAqooWTQoJ0CGOGisSRc2nk/8ky/oc7W2fLQa9tqSj
	Boo2ZLhrD6BryBWYPnMQLTfX/6kyyMX7aucFCSRp26M3PnyLNYEWBQHDOY5uN6+3CV69cQ58JQwCa
	Dtrf40tg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t66Rc-0000000AEOV-357N;
	Wed, 30 Oct 2024 11:00:56 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 62073300ABE; Wed, 30 Oct 2024 12:00:56 +0100 (CET)
Date: Wed, 30 Oct 2024 12:00:56 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Tianchen Ding <dtcccc@linux.alibaba.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>, Tejun Heo <tj@kernel.org>
Subject: Re: [RFC PATCH 2/2] sched/eevdf: Introduce a cgroup interface for
 slice
Message-ID: <20241030110056.GL14555@noisy.programming.kicks-ass.net>
References: <20241028063313.8039-1-dtcccc@linux.alibaba.com>
 <20241028063313.8039-3-dtcccc@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241028063313.8039-3-dtcccc@linux.alibaba.com>

On Mon, Oct 28, 2024 at 02:33:13PM +0800, Tianchen Ding wrote:
> Introduce "cpu.fair_slice" for cgroup v2 and "cpu.fair_slice_us" for v1
> according to their name styles. The unit is always microseconds.
> 
> A cgroup with shorter slice can preempt others more easily. This could be
> useful in container scenarios.
> 
> By default, cpu.fair_slice is 0, which means the slice of se is
> calculated by min_slice from its cfs_rq. If cpu.fair_slice is set, it
> will overwrite se->slice with the customized value.

So I'm not sure I like to expose this, like this.

The thing is, this is really specific to the way we schedule the cgroup
mess, fully hierarchical. If you want to collapse all this, like one of
those bpf schedulers does, then you cannot do this.

