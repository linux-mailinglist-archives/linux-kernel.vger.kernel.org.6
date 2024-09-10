Return-Path: <linux-kernel+bounces-323203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E0C0973959
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 16:05:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30FC21C24532
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 14:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4910119412D;
	Tue, 10 Sep 2024 14:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="byx+dfwj"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41BF41865E1
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 14:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725977140; cv=none; b=AmlnOoqPw4ardRsCPklbuLrKKy4EaoDOwQUZYg295buRMZ3ccTMcsONbcp2zMeny012pULTGmJCj9n+T6+2AtGJMjpuZGeLdwHq+NF0Dptdn+aMTiKoK00fVO0PfaWPfH4DpY1k+dJf1OKKhdP00IL6104FciiXp859/HuRCGK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725977140; c=relaxed/simple;
	bh=kjgwN37QUAPEYdziOS2rBHs2dM5mpDEnXHgisRKX7Ik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kr9TS41C8aVLA5oxBc5WzQkTlSrgCM+3UCy/Xmxhgi+S4CvIN3LvbUd59UB6vnG9ymSvYwtQi1YJXQAENJLKPJCOJV1ERP4QEwcJn+w+j1Upu+GnlPVMdPPcaoT4SQabSPOLaZc/tIIUXfw3RtLIJkvolQ6COojdu/Dk5+84N2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=byx+dfwj; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=fuGVzqIX3HZvIIWmMtriLqJTh23uO3Nh6ByytJ1h6/8=; b=byx+dfwjh05lTPBJh6fUWhGaRY
	lR0T4hnu1KmTyRTWKMnqfLFdfoScKW084B90SzSTEO2nqHPQyaWVK/4IC9a7R1IRE+FEo3Jk/MYku
	xpk/I1uZnWoBbE3ax0nu3xi9RxXxT30vm0oxtHXJkf0nJgx4+S8AD6frlpfweMLuoXcWJeq82Z+0F
	wg5FpN1mblFVt4FWgq9TvOzTU6CoHEwQ7gS4pzeOLV0fx4ZPrLQ5MUyuuM/P+zMDufBx8m5Bmj0Xq
	1wtXa4HJfSyA8JPMhKkXhK2DVGCeMUHn6KZx8Cl4uRUNBi+XqbefLJDvR02w51hnV+2NASP+lpsAo
	GBiWoOug==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1so1Uj-0000000BbsX-1WNn;
	Tue, 10 Sep 2024 14:05:25 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 0022F30047C; Tue, 10 Sep 2024 16:05:24 +0200 (CEST)
Date: Tue, 10 Sep 2024 16:05:24 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Luis Machado <luis.machado@arm.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Hongyan Xia <hongyan.xia2@arm.com>, mingo@redhat.com,
	juri.lelli@redhat.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, linux-kernel@vger.kernel.org,
	kprateek.nayak@amd.com, wuyun.abel@bytedance.com,
	youssefesmat@chromium.org, tglx@linutronix.de, efault@gmx.de
Subject: Re: [PATCH 10/24] sched/uclamg: Handle delayed dequeue
Message-ID: <20240910140524.GH4723@noisy.programming.kicks-ass.net>
References: <629937b1-6f97-41d1-aa4f-7349c2ffa29d@arm.com>
 <CAKfTPtBPK8ovttHDQjfuwve63PK_pNH4WMznEHWoXQ=2vGhKQQ@mail.gmail.com>
 <CAKfTPtDO3n-4mcr2Sk-uu0ZS5xQnagdicQmaBh-CyrndPLM8eQ@mail.gmail.com>
 <aa81d37e-ad9c-42c6-a104-fe8496c5d907@arm.com>
 <c49ef5fe-a909-43f1-b02f-a765ab9cedbf@arm.com>
 <CAKfTPtCNUvWE_GX5LyvTF-WdxUT=ZgvZZv-4t=eWntg5uOFqiQ@mail.gmail.com>
 <a9a45193-d0c6-4ba2-a822-464ad30b550e@arm.com>
 <20240905145354.GP4723@noisy.programming.kicks-ass.net>
 <20240906104525.GG4928@noisy.programming.kicks-ass.net>
 <8d0d01b9-a430-49cc-93a5-67b4d68aa35c@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d0d01b9-a430-49cc-93a5-67b4d68aa35c@arm.com>

On Tue, Sep 10, 2024 at 12:04:11PM +0100, Luis Machado wrote:
> I gave the above patch a try on our Android workload running on the Pixel 6 with a 6.8-based kernel.
> 
> First I'd like to confirm that Dietmar's fix that was pushed to tip:sched/core (Fix util_est
> accounting for DELAY_DEQUEUE) helps bring the frequencies and power use down to more sensible levels.
> 
> As for the above changes, unfortunately I'm seeing high frequencies and high power usage again. The
> pattern looks similar to what we observed with the uclamp inc/dec imbalance.

:-(

> I haven't investigated this in depth yet, but I'll go stare at some traces and the code, and hopefully
> something will ring bells.

So first thing to do is trace h_nr_delayed I suppose, in my own
(limited) testing that was mostly [0,1] correctly correlating to there
being a delayed task on the runqueue.

I'm assuming that removing the usage sites restores function?

