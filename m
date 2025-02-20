Return-Path: <linux-kernel+bounces-524014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3C55A3DDFF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 16:14:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24D8319C0FA2
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 15:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D06431D63E1;
	Thu, 20 Feb 2025 15:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="H+OlvPOw"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F51C1CA84
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 15:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740064334; cv=none; b=AUeH1yK08EO0JslPbgxpJhq1VL9iaPmV6spq4Y9Gjs1wpxOE+blY7QSM4OjCmb04RCOzmlZiz20kcBHldityI4+JeYL74vnkxYyHL9Kwye+eczfhX7OAEwxa+3PUYh1eD33rzppbHKVoDXeI44Gj0Ti7BMYUERihgpUjGnyBMuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740064334; c=relaxed/simple;
	bh=Ebn7RpTMvyptT3Px2d+O4nd9lnVoFeev+qxv0VXN4jc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SknQsCUebx2EcrdY5bTUHYgk3WrCXl4avoIDsfoQ8wgBGpd3zrgpwad2aDOZrfamVW8uR/6Np6RmqJNtgvWkBcDuggaMRnNvV784er0WDGKbAaSZJ8NNtl8Tw5PW9cBFKzF8xkBbzReSQczBVh0SMjxlv6WZLgSwKFRjFxu4cxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=H+OlvPOw; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=vHiAYzdgINSx5M9Kkp+1FXk1GtPzLmW9/ky2OmD9PmU=; b=H+OlvPOwAnRo04aLFcY7koJ197
	RLJab9vUhVtaQU7LkppJAeMXQsIVXfyaNpodXozUyq4n7AWAnlfLWzCiAxrHDAjrdFHpVL7fz2IRb
	n8oQqq6Vm36Kz0BPKRywoABS9V8yucOIM6jupbWmlKilE6f45/ZaWlX+KjquR6WN5DgvycAYN7XgU
	5xpYxHFZQhWT0m3QW8XtrVXNGxXC3y0lbkndaxs0UN2OBvni/SbaQAIRWVcIIW+tG43WWrb3Da9jd
	xL48exffGlSSATkBktc/BoZ+YiRvd0MBjMwb53rIplNou1WHSaTYUMoFHlSuunaPQRUy4krjMRJtS
	Yc9Ou7Fw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tl8Df-00000009zTg-1SFq;
	Thu, 20 Feb 2025 15:12:07 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 1FCCE30066A; Thu, 20 Feb 2025 16:12:06 +0100 (CET)
Date: Thu, 20 Feb 2025 16:12:06 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org,
	=?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v8 00/15] futex: Add support task local hash maps.
Message-ID: <20250220151206.GB11590@noisy.programming.kicks-ass.net>
References: <20250203135935.440018-1-bigeasy@linutronix.de>
 <20250204151405.GW7145@noisy.programming.kicks-ass.net>
 <20250205122026.l6AQ2lf7@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250205122026.l6AQ2lf7@linutronix.de>

On Wed, Feb 05, 2025 at 01:20:26PM +0100, Sebastian Andrzej Siewior wrote:

> So the beauty of it is that you enforce a ref drop on hb once it gets
> out of scope. So you can't use it by chance once the ref is dropped.
> 
> But this does not help in futex_lock_pi() where you have the drop the
> reference before __rt_mutex_start_proxy_lock() (or at least before
> rt_mutex_wait_proxy_lock()) but still have it you go for the no_block
> shortcut. At which point even the lock is still owned.
> 
> While it makes the other cases nicer, the futex_lock_pi() function was
> the only one where I was thinking about setting hb to NULL to avoid
> accidental usage later on.

Sorry for the delay.. got distracted :/

I think we can simply put:

	futex_hash_put(no_free_ptr(hb));

right where we drop hb->lock in futex_lock_pi().

I've split up the patch a little and stuck them here:

  https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/log/?h=futex/scope 

