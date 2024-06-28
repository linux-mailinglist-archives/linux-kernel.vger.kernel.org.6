Return-Path: <linux-kernel+bounces-234486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F94D91C73F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 22:20:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C925D1F26982
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 20:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DBA274BF8;
	Fri, 28 Jun 2024 20:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="may2slvj"
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC205381A
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 20:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719606038; cv=none; b=k1BTts+yKApJF/hULFXCXuv8rgb75EyHSWus+XmDh5io9FPuICW2m3LR83VTZqiRjM3ME4jmraOIeL9wxyh3CMGWfz0aqQFttWx9A5P/X2O/y+d5UdYhPtqZOTxPi7drb7f8rTanbIIiRvtVHIxiRAvPZME/Vdq38h/MVgx1wmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719606038; c=relaxed/simple;
	bh=Jh0CHP6s/GzWBSCVekYbVMjdWFQ7i6Cpxw/d+O1HOEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IwV6YpkbzwR9HJAptH7gAZO39Nj4HWlM6udSzxjr7Lhm9LUnEH6SOBKMRuyww/YoKisnnUtBE0M+LZY9vaiM8ZnM/iyoienLRjw97iHWTBA3KOZYkQtwo2G0li+bAf77KOOOSzTrG7/2IC8iva3GiETDYcafdtsZXBFbL0oJgmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=may2slvj; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: bigeasy@linutronix.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1719606032;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jaczfZ+aSfSn432mxZtQUrbIhMuA0lo6ajpxb6Awmrw=;
	b=may2slvjLfAi0sIg/+ebEklWZQceXX1v7yb8lhY50u3jefQQmK1XXbdcZzR9JrC6mylaKU
	34c22n5vdi4bVONYaeU9fpi4gDCzd/pNaaxqOe+kIOQ1vMVHdYncOFA+RKS3fgbr/yWFxG
	/EY4KIA+LAU6nzCeCLsd9m06VHxNIhU=
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: bsegall@google.com
X-Envelope-To: bristot@redhat.com
X-Envelope-To: dietmar.eggemann@arm.com
X-Envelope-To: mingo@redhat.com
X-Envelope-To: juri.lelli@redhat.com
X-Envelope-To: klarasmodin@gmail.com
X-Envelope-To: mgorman@suse.de
X-Envelope-To: peterz@infradead.org
X-Envelope-To: rostedt@goodmis.org
X-Envelope-To: surenb@google.com
X-Envelope-To: tglx@linutronix.de
X-Envelope-To: vschneid@redhat.com
X-Envelope-To: vincent.guittot@linaro.org
Date: Fri, 28 Jun 2024 16:20:27 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Ben Segall <bsegall@google.com>, 
	Daniel Bristot de Oliveira <bristot@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, 
	Klara Modin <klarasmodin@gmail.com>, Mel Gorman <mgorman@suse.de>, 
	Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Suren Baghdasaryan <surenb@google.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Valentin Schneider <vschneid@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH] sched/task_struct: Move alloc_tag to the end of the
 struct.
Message-ID: <w2qopormdwuh54vropw6sgvadnivjnrgvmpurud2cu6nannfj3@xxrs2r6qt7zi>
References: <20240621102750.oH9p1FQq@linutronix.de>
 <20240628094944.QwcHkf8J@linutronix.de>
 <ynstsvvvjonzkltu4iwedbmntwnnth7dmcvng3ccrtqv45bq3y@5p6amff7cjmw>
 <20240628195553.G48MpeQ6@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240628195553.G48MpeQ6@linutronix.de>
X-Migadu-Flow: FLOW_OUT

On Fri, Jun 28, 2024 at 09:55:53PM +0200, Sebastian Andrzej Siewior wrote:
> On 2024-06-28 15:35:38 [-0400], Kent Overstreet wrote:
> > On Fri, Jun 28, 2024 at 11:49:44AM +0200, Sebastian Andrzej Siewior wrote:
> > > On 2024-06-21 12:27:52 [+0200], To linux-mm@kvack.org wrote:
> > > > The alloc_tag member has been added to task_struct at the very
> > > > beginning. This is a pointer and on 64bit architectures it forces 4 byte
> > > > padding after `ptrace' and then forcing another another 4 byte padding
> > > > after `on_cpu'. A few members later, `se' requires a cacheline aligned
> > > > due to struct sched_avg resulting in 52 hole before `se'.
> > > > 
> > > > This is the case on 64bit-SMP architectures.
> > > > The 52 byte hole can be avoided by moving alloc_tag away where it
> > > > currently resides.
> > > > 
> > > > Move alloc_tag to the end of task_struct. There is likely a hole before
> > > > `thread' due to its alignment requirement and the previous members are
> > > > likely to be already pointer-aligned.
> > > > 
> > > > Fixes: 22d407b164ff7 ("lib: add allocation tagging support for memory allocation profiling")
> > > > Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > > 
> > > Could we please get this merged and worry about possible performance
> > > regression later? Or once there is a test case or an idea where this
> > > pointer might fit better but clearly the current situation is worse.
> > 
> > Sebastian, I gave you review feedback on your patch; if you can
> > incorporate it into a new version your patch will sail right in.
> 
> Kent, you said you didn't want it where it currently is. Fine. You said
> you want it at the front next to `flags'. This isn't going to work since
> there is no space left. You didn't make another suggestion or say how to
> make room.

It doesn't need to be on the exact same cacheline, just as near as you
can get it.

