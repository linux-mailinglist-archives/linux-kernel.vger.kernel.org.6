Return-Path: <linux-kernel+bounces-358477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE792997FD1
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 10:31:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF41E1C2120A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 08:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D14281FF7C9;
	Thu, 10 Oct 2024 07:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lHSSwgHT"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38571C9EB3
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 07:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728546648; cv=none; b=X5YrLyfuDWBv5F0Ffy8rJGWRKjZgjWEsLuNCFRMocigu07/61JIy+HpURfZaYoeo6+DNyEuWM9lGftD5CFOrAOfP3bsbdP78EPAKy2sWf1rAKI0Fv3AVCrHuaq7fxGJbHpuuqIsQC4qgl2OdZDTE+LjUSeds60sRyED/tNLJ0fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728546648; c=relaxed/simple;
	bh=N6of/suUMYod6OV/wY/Wl8R5O3YAAiagzxYyyF3dWA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QrdoMYWpyQvjhL4b/lrm+zShY7TMOEcoXMNu7NDrKDwPahdnu9vCQFhWeIwDAexdnD1SOBKvFb8zCFq07bnxC8jpjCpOWWSny5NunWxxQYhLUwybm4ZTu1S4esngT6LFmq0NIQSRfIVnjGwlcFaocqM6iBbiiiMButvDla4ya2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=lHSSwgHT; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=xa+OI90OGbpzsM7ExACJJXhgr3sapIrB3JJbXovs1w0=; b=lHSSwgHTt8Oeh5Qepndmui+yOa
	BZbRxsF9x+NyrNv8mrkgiWT7DxI6tdepXD73inG9AEGC7g31kWFwRtlTWSFBvBQAB7eMgAEkFoULZ
	Twj8VfxvZkoUBdgsQZL9pfUCtWI9NIIkh4Kx9cReM7z7OsC4wQGCT5zugHifyuUcmcx/i3tFeelDZ
	1lPmvUv0q2KJQj8747R/hkAUvnORV8x3Q2YC/Bs4UP7YrbJot1oSsnm9qjbMklg4eLllBU54fmOxV
	ec9tEfsiYADliXfN3MW2VABQocEGSVSKvgnzZSO2gcy2B/88ZEqTkp9PwRFICrm8lFwH5o1X6S3jI
	B0yT7myA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1synwR-000000074nE-0c7i;
	Thu, 10 Oct 2024 07:50:35 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 2937930088D; Thu, 10 Oct 2024 09:50:35 +0200 (CEST)
Date: Thu, 10 Oct 2024 09:50:35 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: bigeasy@linutronix.de, tglx@linutronix.de, mingo@kernel.org,
	linux-kernel@vger.kernel.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, ankur.a.arora@oracle.com, efault@gmx.de
Subject: Re: [PATCH 3/5] sched: Enable PREEMPT_DYNAMIC for PREEMPT_RT
Message-ID: <20241010075035.GX17263@noisy.programming.kicks-ass.net>
References: <20241007074609.447006177@infradead.org>
 <20241007075055.441622332@infradead.org>
 <Zwd5tKFBj62Lwdxv@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zwd5tKFBj62Lwdxv@infradead.org>

On Wed, Oct 09, 2024 at 11:52:36PM -0700, Christoph Hellwig wrote:
> On Mon, Oct 07, 2024 at 09:46:12AM +0200, Peter Zijlstra wrote:
> > In order to enable PREEMPT_DYNAMIC for PREEMPT_RT, remove PREEMPT_RT
> > from the 'Preemption Model' choice. Strictly speaking PREEMPT_RT is
> > not a change in how preemption works, but rather it makes a ton more
> > code preemptible.
> > 
> > Notably, take away NONE and VOLATILE options for PREEMPT_RT, they make
> > no sense (but are techincally possible).
> 
> Should we take away NONE entirely because it is kinda silly?
> 
> Just a bystander here, but the explosion of different preemption models
> is a bit silly and not really helpful to users.

The end goal is to get rid of Voluntary and None, but getting there will
require more work. A lot of careful work to be sure. In the end we
should be rid of those two preemption models and the cond_resched() and
much of the random need_resched() hackery they brought.

But we can't do it all at once, so yeah, we need to grow extra crap
before we can take out the old stuff. Nothing new there, but I get your
frustration.

