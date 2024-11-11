Return-Path: <linux-kernel+bounces-403784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F2D19C3AC7
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 10:23:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB3391F21289
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 09:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A2831684B4;
	Mon, 11 Nov 2024 09:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NZtdh+TE"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8293146A6B
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 09:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731316978; cv=none; b=TreT6d7Imfd9SeLvB6mIM8XYnjl+5+Ul00ToadHVtNL9+6EqzfSsMQ/O5GhcdtTwnP+2HeAe6vP57nP3/sI3yozVSiJb251zwgDHBlCYypAOR2axPA+v0Wn3BNaASNBwn9pu8EsW7eBiY0xZuLed6simoINkKhMQ+4pli9cKUOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731316978; c=relaxed/simple;
	bh=WxeVuH1yeLK0Mvfupynnf9QlW9kVvHqmffj9hqqUh6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MQ0Q7r6qos44SZbAsxd4iOy6PLBt3SXW+VDdA87zrWcmoB4sqYGWuJTSR+MeotiMo6m0AkPGl4y+gp4cyIPF3wts/I1fRj23g4Iv2DG5Kd8LnBNiTyqsY+kRgP68hYHY44RjNpiKqZgrJ35/Bx/gakWw62Pb4h3JiQFPAi+KGMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=NZtdh+TE; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=jQWVeTyEJG0sCQodrkrs+h6zYnNoQYC9P3JaXN9aqSk=; b=NZtdh+TEmSxgQD4fRXwT/wIjRW
	t/beWKRJX69BiHfR5KQpWzA3llmagM7AwurE3ZXFUV7nAQu4HYHOh9gZioBMAIaepdEDbx8BHYIh9
	K0Z28RWuAnlGqujw3aSDsnJ/tYMfjGzXfk33Bvr/0Ypln6qDVfTvmaafpygg9SwDHU+yV6mq2oQjy
	iDtX1mD6aLj0GMeCZKr/LKTsPBHoBWua6ekWgbeNn95sseUCwZmrK41GRxbj1WsBizUW7Jm7kRFiJ
	5fEjpB6CqiaJA26HeaCYxoYcl8jFqY4VROsMjG0TKm6RafEtXIVRZCv360kWsRfFVtGixtjBXbmqx
	qAxnhtRg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tAQdD-0000000CaLj-14Po;
	Mon, 11 Nov 2024 09:22:47 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id E051E300472; Mon, 11 Nov 2024 10:22:46 +0100 (CET)
Date: Mon, 11 Nov 2024 10:22:46 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>, Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/topology: Correctly propagate NUMA flag to
 scheduling domains
Message-ID: <20241111092246.GC22801@noisy.programming.kicks-ass.net>
References: <20241109145628.112617-1-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241109145628.112617-1-arighi@nvidia.com>

On Sat, Nov 09, 2024 at 03:56:28PM +0100, Andrea Righi wrote:

> @@ -1974,6 +1981,7 @@ void sched_init_numa(int offline_node)
>  	 */
>  	tl[i++] = (struct sched_domain_topology_level){
>  		.mask = sd_numa_mask,
> +		.sd_flags = cpu_numa_flags,
>  		.numa_level = 0,
>  		SD_INIT_NAME(NODE)
>  	};

This doesn't seem right. This level is a single node, and IIRC we only
expect SD_NUMA on cross-node domains.

