Return-Path: <linux-kernel+bounces-561272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 24956A60F81
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 12:01:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08B667A4E54
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 11:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D421E1F3B87;
	Fri, 14 Mar 2025 11:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="T7hWzj93"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1C91E5B95
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 11:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741950083; cv=none; b=aVl1zRJUaxBeC/ZNQlSt9PvHRmfRvWS7H0/+k5A0eixG0o8qk9C+Y2BUD6HDZhF4jby0rYMiLJJ9pnIB13Tb/koxCUCtiUTsgyfwmg4/zZsm2c+V8EeeC4ja58HglE+GniwS2nUtZtgE/R50Rg3nWDdFpTOxVMB9xc5P7NFyZaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741950083; c=relaxed/simple;
	bh=wSrdNpvE6BBVdnL5Xg5M3p7VjhKgOqw4REV4qu72WpI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uTStD8TkHOcw3QUKaNWJcq2uHbEuiBK76PMVXuSxUH+47zcLCWdeHPaq0BY3b5vyIX8YRvyYQgCtM67punULfJmQZrNwRLMsGLDgaZIJiuKcpsXzoCi7ELxjjsJtzZaBMRCK0vscXag30H0pz/KeUaj9O3ULLkJ8McHjtqjwyhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=T7hWzj93; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=7isWwY/qpGnRrUm0sVQaVkG3yVbQ9GHkuVrefn9jIQo=; b=T7hWzj93s1A3hy1e+DsR7TqNmj
	am/n3Iur8yqbfHoVaOMGzw0zIEVp9Tpp5FAYetEYWRv36VRN6ANL7Ckt+9/GEWWpHH145L08kc5O2
	DGCTxhkjy8NbibZPvGd48Xh7yc7jLLJGWJuNQ4av0uokEFZEhdxsZa4stuAyWWmCCHEFOUz8Xat4/
	yuX7zekhbhXjENwnkva87kqxD4Xl1WEz0MroeiREHhD5iY4D0+q0db7pWR4Ar+V2Sc29flKLKrX28
	28hCgF45VQxxO8BoGnmrc0ZRnE0QKKbkxS5qE45Ea2eZ1dSv4JWg46a8ariZb7tk/wEggA0lfFT3H
	/1cg7L9A==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tt2kj-0000000HLsm-42sE;
	Fri, 14 Mar 2025 10:59:34 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id D911A300599; Fri, 14 Mar 2025 11:58:56 +0100 (CET)
Date: Fri, 14 Mar 2025 11:58:56 +0100
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
Subject: Re: [PATCH v10 00/21] futex: Add support task local hash maps,
 FUTEX2_NUMA and FUTEX2_MPOL
Message-ID: <20250314105856.GB36322@noisy.programming.kicks-ass.net>
References: <20250312151634.2183278-1-bigeasy@linutronix.de>
 <20250312151848.RlB_XuHA@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250312151848.RlB_XuHA@linutronix.de>

On Wed, Mar 12, 2025 at 04:18:48PM +0100, Sebastian Andrzej Siewior wrote:

> @@ -1591,7 +1597,8 @@ static int futex_hash_allocate(unsigned int hash_slots, bool custom)
>  		struct futex_private_hash *free __free(kvfree) = NULL;
>  		struct futex_private_hash *cur, *new;
>  
> -		cur = mm->futex_phash;
> +		cur = rcu_dereference_protected(mm->futex_phash,
> +						lockdep_is_held(&mm->futex_hash_lock));
>  		new = mm->futex_phash_new;
>  		mm->futex_phash_new = NULL;
>  

Same thing again, this makes no sense.

