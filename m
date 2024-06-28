Return-Path: <linux-kernel+bounces-234460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6663791C6F1
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 21:56:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20B112849FF
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 19:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C79877F11;
	Fri, 28 Jun 2024 19:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JcaZ80QF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AX8tboIW"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F307711F
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 19:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719604558; cv=none; b=FYnS0xn11+DXkj/7g9HuLVZ8pM/QU8FN0h0hYbh/GA8534Pt+FKY09hsHYHve2+qKtExz4bphh6h606myi+kh56yPI5VJLjdJPNK3c7Z2K31IQbzelgFPyyGW9e7LLFXfos9hwJExBobCw4yqCBEgMhNTcwJw9x/oCby2EVu+NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719604558; c=relaxed/simple;
	bh=dhPssMacR741Zo4AOMfUDoK7QYpnFpj5GBoLMQ6eWxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JQAga2uguHpYe1KLraYoFHQZL0TcLg/F+dS+/ZgowElQZ+3AUDLTC7lzp1gyKL2mULBYfx9laMUYNXXXKv8ZRGi4z6LeejraLaOlPQMh5r0Nn/BdCvjczsKtHLS+YDsr0DTc1l/jdJwDf/NrJBu+PZY5hf2VagUx/3ixo3ChEOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JcaZ80QF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AX8tboIW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 28 Jun 2024 21:55:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719604554;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ll2YTkjlScvxObzwefF6DLr6xPtB2LxtsUrrnImI+nk=;
	b=JcaZ80QFY6YJysjoGYpIDTxPTaiO+GJKG2JLEh1e1dBNF7O0RXmLKXMlL7seY/bkCbVVAK
	UZCzTM0j42g8DfYneWGyk8W6c9RuW/Ird6vbnk7PxvOJk/mTre3IJ5wqTVc5dD4bTTQw8Q
	7EkLLuSu3jtYGmQxqQ3yau+OErE/hgH4cqwYqiLCYR+yTbbXUizuhygX358aRR1eC1jWxm
	q8v3QCzIhuXrcc1pVHFaqMBV7D/vkPoDLAImgL24Qn0Bz6THrpXu6iT+TY3/8gtfgioDzT
	gVn1Y80M/pLcWROmgXOcKeP578DNzykhr6UJuldf/MmRWdXz5mEdZlTEgg0QqQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719604554;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ll2YTkjlScvxObzwefF6DLr6xPtB2LxtsUrrnImI+nk=;
	b=AX8tboIWjl5kz7t1hkokF7tJMDKllmegbojNJHcqjQTZaONaA07DEYQv3x71xKHVm3eBIa
	Srys+alwwMJjQLCg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Ben Segall <bsegall@google.com>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Klara Modin <klarasmodin@gmail.com>, Mel Gorman <mgorman@suse.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH] sched/task_struct: Move alloc_tag to the end of the
 struct.
Message-ID: <20240628195553.G48MpeQ6@linutronix.de>
References: <20240621102750.oH9p1FQq@linutronix.de>
 <20240628094944.QwcHkf8J@linutronix.de>
 <ynstsvvvjonzkltu4iwedbmntwnnth7dmcvng3ccrtqv45bq3y@5p6amff7cjmw>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ynstsvvvjonzkltu4iwedbmntwnnth7dmcvng3ccrtqv45bq3y@5p6amff7cjmw>

On 2024-06-28 15:35:38 [-0400], Kent Overstreet wrote:
> On Fri, Jun 28, 2024 at 11:49:44AM +0200, Sebastian Andrzej Siewior wrote:
> > On 2024-06-21 12:27:52 [+0200], To linux-mm@kvack.org wrote:
> > > The alloc_tag member has been added to task_struct at the very
> > > beginning. This is a pointer and on 64bit architectures it forces 4 byte
> > > padding after `ptrace' and then forcing another another 4 byte padding
> > > after `on_cpu'. A few members later, `se' requires a cacheline aligned
> > > due to struct sched_avg resulting in 52 hole before `se'.
> > > 
> > > This is the case on 64bit-SMP architectures.
> > > The 52 byte hole can be avoided by moving alloc_tag away where it
> > > currently resides.
> > > 
> > > Move alloc_tag to the end of task_struct. There is likely a hole before
> > > `thread' due to its alignment requirement and the previous members are
> > > likely to be already pointer-aligned.
> > > 
> > > Fixes: 22d407b164ff7 ("lib: add allocation tagging support for memory allocation profiling")
> > > Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > 
> > Could we please get this merged and worry about possible performance
> > regression later? Or once there is a test case or an idea where this
> > pointer might fit better but clearly the current situation is worse.
> 
> Sebastian, I gave you review feedback on your patch; if you can
> incorporate it into a new version your patch will sail right in.

Kent, you said you didn't want it where it currently is. Fine. You said
you want it at the front next to `flags'. This isn't going to work since
there is no space left. You didn't make another suggestion or say how to
make room.

I don't impose this version, I just don't see a better way right now.

Sebastian

