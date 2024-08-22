Return-Path: <linux-kernel+bounces-297589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BA0395BB34
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 18:00:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0019B26E88
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 15:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 230821CEAB4;
	Thu, 22 Aug 2024 15:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="I3O0vdCZ"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0E41CE71B
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 15:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724342121; cv=none; b=PagTOixaC+78mtyWyiuNZy7tUABV90wZE8SXP4Z/E3jLpDQA2gy+8jkBECmMN18MxgroCPjWlcvu3zt8A4YDbV3tDKFE8b9624nSZa/Q0mnVoMtZ4GeFZ1DI85NO+AMvwxoz3j5jFiWL629SnM16bT2xaEufIG3m9l9bMVAX9hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724342121; c=relaxed/simple;
	bh=jdwuLAb4tfrdQ0WNu15vvEX060UAwSVPW6HKAaf2qyw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NMreHKGu5wLuDde13bG1SDoOmOZw/nCC4NcnsX1gx4G/FYDdxz2aVae4/dr/hBAybZajDgwIm8T9UkHaBDAJKu/qNCIynKnYcQn33e2mNZo/V58KyA/0Iw4/tq95I9cWYnBO1k4B4ES9Q9AGoHBk7poigBYpa+/Rzbe9kkWyAQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=I3O0vdCZ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=zDYD8mwxX6eQtQZYTIeuMaOPon4Wwg8QX/pqSpudFzE=; b=I3O0vdCZyUOzzAjF5VVolfkg70
	jJJ85HbyzHF7slSTbm8VM/w/vuaL/IDydFRo4QsiPXUdCrlAsiKZqW/7AubgvM5x7UbfJVCUv0P6y
	OcFHVZu3enA5oCKgHSzR6Oz8tljkCpv4VJg4icoxEc2pr2j7IpdgOZIHcapANlRvimplrFyvcZ9Sh
	uvhthsMVN1W9R+n6RgkXYMbB5a+lm6K8WCEMYKG5w1sK+cSxKdA+/RKH11kQ2z/Nw3X1+iy3G0nCP
	8tARGdH+DZatAebmUkWpdLE695TJl4xOFFGS4acKlkyZ3i4kuXHTAdPsCvb3MlQHQRAr20I0cqxk1
	5bGtR6BQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shA9Q-0000000AgSE-1KXQ;
	Thu, 22 Aug 2024 15:55:04 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id E4900300642; Thu, 22 Aug 2024 17:55:03 +0200 (CEST)
Date: Thu, 22 Aug 2024 17:55:03 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Hongyan Xia <hongyan.xia2@arm.com>
Cc: mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, linux-kernel@vger.kernel.org,
	kprateek.nayak@amd.com, wuyun.abel@bytedance.com,
	youssefesmat@chromium.org, tglx@linutronix.de, efault@gmx.de
Subject: Re: [PATCH 00/24] Complete EEVDF
Message-ID: <20240822155503.GC17097@noisy.programming.kicks-ass.net>
References: <20240727102732.960974693@infradead.org>
 <c6a673d4-ee16-4458-bf68-8f75d5062984@arm.com>
 <717e6294-5c62-415c-bc8b-5da1d8ac3642@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <717e6294-5c62-415c-bc8b-5da1d8ac3642@arm.com>

On Wed, Aug 21, 2024 at 10:46:07AM +0100, Hongyan Xia wrote:
> Okay, in case the trace I provided isn't clear enough, I traced the crash to
> a call chain like this:
> 
> dl_server_start()
> 	enqueue_dl_entity()
> 		update_stats_enqueue_dl()
> 			update_stats_enqueue_sleeper_dl()
> 				__schedstats_from_dl_se()
> 					dl_task_of() <---------- crash
> 
> If I undefine CONFIG_SCHEDSTATS, then it boots fine, and I wonder if this is
> the reason why other people are not seeing this. This is probably not EEVDF
> but DL refactoring related.

Thanks for the report -- I'll see if I can spot something. Since you
initially fingered these eevdf patches, could you confirm or deny that
changing:

  kernel/sched/features.h:SCHED_FEAT(DELAY_DEQUEUE, true)

to false, makes any difference in the previously failing case?

