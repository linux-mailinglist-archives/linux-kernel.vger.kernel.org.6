Return-Path: <linux-kernel+bounces-180791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 184AF8C7321
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 10:49:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49F7A1C2246B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 08:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEFAB142E8B;
	Thu, 16 May 2024 08:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ltx3A+f1"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52892D054
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 08:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715849358; cv=none; b=kiYJkw832QJFTYSuEObo0GZCEn/s1z3YrncmBztDtipHoG6OgGc5WFYgo4gn3e03ld5EhW7IAHLIHkuqDmV0oNGgKC9iE4SEky7k7AZNJZNX5qsmn0v2Gk3WdnF74JQSupSDT/VMZuUR4hbOnXjSvbZ2eNibqGV1A3uX6ClRYS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715849358; c=relaxed/simple;
	bh=f78xiDhvsUkQ0vEOzZLFLmGbZwcxWJdGNpPjrHYsuao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HD7Cjv+25JUEkdn4WfoqUzItRGb6eTewBHe62TqK8G4RSP9R6Zqkce88rLWsJWCNJhqmq823bhRSe5kJ8N5KevNHL+kpqSTP6XiPBV/bWhjx73ksXVdEzeuDqTXIbi4ATuDPrBFoFsW3lcpw2Z49Bv/zVF6PGmNqtL6uRwh7MEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ltx3A+f1; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=RrvR/OuJN0GiPOp743A77k50xCQo42dKCOI/Td+WRes=; b=ltx3A+f1VKx0Q27cjpnamTfQak
	Rzmyu9nlW0hOY2GJC8+AZNRDLCcqgQuSce306lnSD5Yq6jtoIFk2/5QgcDmuqeL73sbrFMID/NDyi
	gEYJqEqP8lt1tluM1qXx1k9lZ4qQg2ZyrBkMc0+I/mQtnc0zI+GYdwrkFopGFh7LvZF5a/FlfkAEY
	uuzv2E1/mIyVzA8OPiv5iTXdrQ5g+i+hs8+6yPCfLlyxYAn3Oktl++PhQaAZOn7mbfcbnyh9lbEFk
	3h2PjAwprtvcHi+c5z2xH5D8FiQbK0YgNWQlzSbJvejbBK8YbHt55058VMLxF97DobwWC2RlS0LSy
	RESRpweA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s7WnX-00000005NtP-475h;
	Thu, 16 May 2024 08:49:12 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 7307730068B; Thu, 16 May 2024 10:49:11 +0200 (CEST)
Date: Thu, 16 May 2024 10:49:11 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Yun Levi <ppbuk5246@gmail.com>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Vineeth Pillai <vineeth@bitbyteword.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	anna-maria@linutronix.de, mingo@kernel.org, tglx@linutronix.de,
	Markus.Elfring@web.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] time/tick-sched: idle load balancing when nohz_full
 cpu becomes idle.
Message-ID: <20240516084911.GF22557@noisy.programming.kicks-ass.net>
References: <20240508172621.30069-1-ppbuk5246@gmail.com>
 <20240509092931.35209-2-ppbuk5246@gmail.com>
 <ZkU8lm2tjm_r9FpZ@pavilion.home>
 <20240516075628.GC22557@noisy.programming.kicks-ass.net>
 <CAM7-yPRHp3tiZjuBTesdRQoU8WJNg1scon_txS_6R-pZq9MXHw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM7-yPRHp3tiZjuBTesdRQoU8WJNg1scon_txS_6R-pZq9MXHw@mail.gmail.com>

On Thu, May 16, 2024 at 09:20:08AM +0100, Yun Levi wrote:
> > None of that HK nonsense is relevant. The NOHZ_FULL nonsense implies
> > single CPU partitions, and *that* should be avoiding any and all
> > load-balancing.
> 
> Do you mean.. tick_nohz_full cpu (non-HK-ticked cpu) shouldn't belong
> to any sched_domain?

AFAIK NOHZ_FULL still hard relies on the isolcpus garbage, so yeah, it
should be all single cpu partitions, which don't have a domain.

(this really should migrate to use cpusets partitions)

> > If there still is, that's a bug, but that's not related to HK goo.
> >
> > As such, I don't think the HK_TYPE_SCHED check in
> > nohz_balance_enter_idle() actually makes sense, the on_null_omain()
> > check a little below that should already take care of things, no?
> 
> IIUC,
> currently, whether cpu belongs on domain or null is determined by
> HK_DOMAIN_FLAGS

No! you can create NULL domains without any of the HK nonsense. Both
isolcpus and cpusets can create single CPU partitions.

> However, when "nohz_full=" is used, it still on HK_DOMAIN, so it
> belongs to sched_domain
> so, it couldn't be filtered out by on_null_domain().
> 
> unless "isolcpus=domain" or "isolcpus={cpu_list}", it's on null domain.
> with "isolcpus=tick", it participates sched_domain.

Frederic ?!? You can use nohz_full without isolcpus? That makes no
sense. If you do that you get to keep the pieces.

