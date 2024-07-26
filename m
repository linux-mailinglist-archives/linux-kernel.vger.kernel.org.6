Return-Path: <linux-kernel+bounces-263286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A14E393D3B9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 15:08:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50A062838A1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 13:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ACCC17B514;
	Fri, 26 Jul 2024 13:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="R1ckrdP6"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F8942070
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 13:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721999321; cv=none; b=sX+bJbQi0FtDhbl0G/+0YaSXhOtmINAmhUI8bVu2Ikkp8KLJDC10QjsdQpslipLFDDT8qEjAmJ9I7zoHIL81kT6U6ixMV90k3djPQj/yCV7FJxHaCUix2puzME9AGYD1VZVAt297dnL33RvJXS0ryfYOrZ322TlE1bJuPGqQ6DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721999321; c=relaxed/simple;
	bh=aXvevRCZHpPfmsZwO8nh4sg50c6J5KdgmfHtW/OpZ+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UfFJt1gXrBhG+EgCZSrFsQjlJZQm23M7L+xgwpfj9Ertd1RB+pX2jh2ulzYd8FNWBZdt6B6z+5rmImlyP4qd+o7t7P+0/71HNT9I2i44+k6tfFzIU2wns55CraZV36XRMG/i3cJzNTTEGPJ8SgWxfJVnSZ/FAw2CclGu3h/8vKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=R1ckrdP6; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=GpdtUHRk4rArOx4gNacSV7DVCVe6gxiVt/YL9vxhalg=; b=R1ckrdP6XWFVW0lgOZbGWhDMW/
	0N2PtO5VeFYbqGpS83WDe6aULz6EikLIsIaMk1TxKiCPnT9fZartsVyKOTInTFaJCSUX9QSpYDXo0
	B7/+Tg7ZDAVUtcxpjKl/XVXJPWthQmsaC9jUfhdJ2rEGcYQB+eXbLuY95yQJpKyeRKIv6yrxFZGC+
	IwT5TkuBjnaO4TiHJOIXbPPXgTxd0xhNpLUDRsx0sfUPlIanswbJ2vxI/MrWzfC3cFcmGpzDuhY9y
	JGuPpMBUGbA+YUcFxbuLHXjzD+enDO4IEMMn7+1E0jLxWzE6ytZ29XSlGms4XLLqvPCG7jDVdhZlf
	nM/CvETQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sXKgQ-0000000AEnw-2lr9;
	Fri, 26 Jul 2024 13:08:30 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 9D28430068B; Fri, 26 Jul 2024 15:08:29 +0200 (CEST)
Date: Fri, 26 Jul 2024 15:08:29 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Zheng Zucheng <zhengzucheng@huawei.com>, mingo@redhat.com,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 -next] sched/cputime: Fix mul_u64_u64_div_u64()
 precision for cputime
Message-ID: <20240726130829.GN13387@noisy.programming.kicks-ass.net>
References: <20240725120315.212428-1-zhengzucheng@huawei.com>
 <20240726023235.217771-1-zhengzucheng@huawei.com>
 <20240726104429.GA21542@redhat.com>
 <20240726130401.GB21542@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240726130401.GB21542@redhat.com>

On Fri, Jul 26, 2024 at 03:04:01PM +0200, Oleg Nesterov wrote:
> On 07/26, Oleg Nesterov wrote:
> >
> > On 07/26, Zheng Zucheng wrote:
> > >
> > > before call mul_u64_u64_div_u64(),
> > > stime = 175136586720000, rtime = 135989749728000, utime = 1416780000.
> >
> > So stime + utime == 175138003500000
> >
> > > after call mul_u64_u64_div_u64(),
> > > stime = 135989949653530
> >
> > Hmm. On x86 mul_u64_u64_div_u64(175136586720000, 135989749728000, 175138003500000)
> > returns 135989749728000 == rtime, see below.
> 
> Seriously, can you re-check your numbers? it would be nice to understand why
> x86_64 differs...

x86_64 has a custom mul_u64_u64_div_u64() implementation.

> > But perhaps it makes sense to improve the accuracy of mul_u64_u64_div_u64() ?
> > See the new() function in the code below.
> 
> Just in case, the usage of ilog2 can be improved, but this is minor.

I meant to go look at this, it seems to loop less than your improved
version, but I'm chasing crashes atm. Perhaps it provides inspiration.

https://codebrowser.dev/llvm/compiler-rt/lib/builtins/udivmodti4.c.html#__udivmodti4

