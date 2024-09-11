Return-Path: <linux-kernel+bounces-324481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE5E2974D00
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 10:46:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BC731F22492
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 08:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3685917E008;
	Wed, 11 Sep 2024 08:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lDK/V/om"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19A117D354
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 08:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726044343; cv=none; b=uu9SRx2YS7IC0tqbF3Llx9u35jpM5XnkUV4C8VDpV0OMUKJexMNokxba2pGbLWhZ8OT/4qYL3BXtKiFM+cwpYMp249Z2M2rIVikrFksOcqFWZpmOlivunqvLwZ/uk9ILOwAZIPCHg2NivmuyhZFyj5ba3vPa5YEhKsshp2V/ixs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726044343; c=relaxed/simple;
	bh=exMe7vnoGxsC/QgFY+o5eIBq81ki6LC3HOsDeysXuCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YZskhOmzYpvJwPg0JrUCS3KQZYSO+qfhsP4vnBoEMCb0JtdV2lVFkJayP9AWGNWw/kO6+z/S1X+1KrVWbsVQYK9muMa79oG8exOfEhaIKhonffYkSEaBf7nrCBjHCzlQEWVVMaaOCehqSWm5eIsH20n/3C7Yk+YCvNaKyVg4Kl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=lDK/V/om; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=2jXpKzBtDSlZdjAIzt1Wc1eMaJQ8JPZuhmIV6AZBSPI=; b=lDK/V/om+TiUmUQaa2r7zR6O/V
	saW3vulryAfKwjyFzwZSd2aSTgCHmdCF5IxJzHq/0aT+F8h9GX4jLoU8NDi9IKC2iVUE5ZfsLivbS
	kmSxSMqqADVsQnDBSSK+jyb6k4GxnPwLEKdpRbJ1/3clPX7k/3Qr9cPI76m1J/PvLctiI7zbBP/ff
	FPwORxD+/rNl5jcmFDFQiwJ3DU347Eg9qyecjq5nSeYdUxZBnePnIEheGX25JXAfMt/0dkEunIDGC
	z2k0QjMe7kjC7FQx8bNAWcpwJCS0SDx26ZNd8tLC6fdQvwGP1SpgcSZWh2MphlAqva5RmTfiYDgbE
	184NCc3Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1soIye-00000007K9w-39HR;
	Wed, 11 Sep 2024 08:45:28 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 1D503300642; Wed, 11 Sep 2024 10:45:28 +0200 (CEST)
Date: Wed, 11 Sep 2024 10:45:28 +0200
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
Message-ID: <20240911084528.GJ4723@noisy.programming.kicks-ass.net>
References: <CAKfTPtDO3n-4mcr2Sk-uu0ZS5xQnagdicQmaBh-CyrndPLM8eQ@mail.gmail.com>
 <aa81d37e-ad9c-42c6-a104-fe8496c5d907@arm.com>
 <c49ef5fe-a909-43f1-b02f-a765ab9cedbf@arm.com>
 <CAKfTPtCNUvWE_GX5LyvTF-WdxUT=ZgvZZv-4t=eWntg5uOFqiQ@mail.gmail.com>
 <a9a45193-d0c6-4ba2-a822-464ad30b550e@arm.com>
 <20240905145354.GP4723@noisy.programming.kicks-ass.net>
 <20240906104525.GG4928@noisy.programming.kicks-ass.net>
 <8d0d01b9-a430-49cc-93a5-67b4d68aa35c@arm.com>
 <20240910140524.GH4723@noisy.programming.kicks-ass.net>
 <52ca4cea-8f65-434e-af17-e4bf664d9488@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52ca4cea-8f65-434e-af17-e4bf664d9488@arm.com>

On Wed, Sep 11, 2024 at 09:35:16AM +0100, Luis Machado wrote:
> On 9/10/24 15:05, Peter Zijlstra wrote:
> > On Tue, Sep 10, 2024 at 12:04:11PM +0100, Luis Machado wrote:
> >> I gave the above patch a try on our Android workload running on the Pixel 6 with a 6.8-based kernel.
> >>
> >> First I'd like to confirm that Dietmar's fix that was pushed to tip:sched/core (Fix util_est
> >> accounting for DELAY_DEQUEUE) helps bring the frequencies and power use down to more sensible levels.
> >>
> >> As for the above changes, unfortunately I'm seeing high frequencies and high power usage again. The
> >> pattern looks similar to what we observed with the uclamp inc/dec imbalance.
> > 
> > :-(
> > 
> >> I haven't investigated this in depth yet, but I'll go stare at some traces and the code, and hopefully
> >> something will ring bells.
> > 
> > So first thing to do is trace h_nr_delayed I suppose, in my own
> > (limited) testing that was mostly [0,1] correctly correlating to there
> > being a delayed task on the runqueue.
> > 
> > I'm assuming that removing the usage sites restores function?
> 
> It does restore function if we remove the usage.
> 
> From an initial look:
> 
> cat /sys/kernel/debug/sched/debug | grep -i delay                                                                                                                                                                                                                             
>   .h_nr_delayed                  : -4
>   .h_nr_delayed                  : -6
>   .h_nr_delayed                  : -1
>   .h_nr_delayed                  : -6
>   .h_nr_delayed                  : -1
>   .h_nr_delayed                  : -1
>   .h_nr_delayed                  : -5
>   .h_nr_delayed                  : -6
> 
> So probably an unexpected decrement or lack of an increment somewhere.

Yeah, that's buggered. Ok, I'll go rebase sched/core and take this patch
out. I'll see if I can reproduce that.

