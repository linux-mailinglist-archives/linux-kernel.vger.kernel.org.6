Return-Path: <linux-kernel+bounces-367979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B1419A090B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 14:10:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0134A1F24A90
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 12:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 201DD207A26;
	Wed, 16 Oct 2024 12:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="S5DFeUER"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BED9206E71
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 12:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729080622; cv=none; b=PqzXNocl2G0uA5R1i8wDXCqqoWzpRwk6i7U7+gLKpkl1rCUq6zlGN+bgeTcLk+U6g6f5LxW5ifDMEvTx8ftuYf0JNEJdg9LSKpwQyoQov8yTAlEBtE1kAOU0QWa6tETvZDCR8qHkNPaqVHm/hCQn480Z3wbHY8CcDwO4WiYIdsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729080622; c=relaxed/simple;
	bh=pJPwxwox4Uc6jHqFn9IB/05FJM7LR5bmM+2gC3Stu+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GYVj/e6S7UFDeGPqNymNfdWxuPBCqmEAd75N7URPiJC9RB6Y7LWp4MJj3jZ5+tq9DG2JKwmnLfpPFyHZQQA6B6oPf8mU7dWb2dXAdw4CtLd9jVEQLeJc2ghOKJFvj7ba/Gm9dFG5W82uEV69oGfoT7oRZp8eN1YWXsvF2NTf4NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=S5DFeUER; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Wbct+3rFhIfACUcxTULDM1G6g7itqtXhTaevGD/k18w=; b=S5DFeUERiCRLpkKsR2oZM/tloK
	aN6pky/TOfDdyDHCqvVyIWvERo7OyCnMcN44X+VWWxGkqOQFaawdLFhGE+52jhSTE9TdnUnzXnFEX
	fIxINE2DScTMCQ1LxUEyErpGk5rMvf89O8O1Wl0taRv4Cr7B8i2Pj0GNd6eptsATsdZmz2xXUgaqq
	+7VkdFpBrtQK3JY1m9xu+l3nqtud177oWbCWRQvuydHIe8VldhCGAlls7tsMua+3lBeaV+mt0JAsi
	qZhqdXdMzkZZc6OgM+Hb8rHm7ZxjH1i3O9c3x0KGndiAt6ufxL01qFOmv2kaN95FzIc2xQ78m+HqW
	y6zrobCw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t12qz-00000007rRW-1YJX;
	Wed, 16 Oct 2024 12:10:14 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 9A9E5300777; Wed, 16 Oct 2024 14:10:13 +0200 (CEST)
Date: Wed, 16 Oct 2024 14:10:13 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: lizhe.67@bytedance.com
Cc: akpm@linux-foundation.org, boqun.feng@gmail.com,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	longman@redhat.com, mingo@redhat.com, will@kernel.org
Subject: Re: [RFC 0/2] rwsem: introduce upgrade_read interface
Message-ID: <20241016121013.GS16066@noisy.programming.kicks-ass.net>
References: <20241016080955.GR16066@noisy.programming.kicks-ass.net>
 <20241016085345.46956-1-lizhe.67@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016085345.46956-1-lizhe.67@bytedance.com>

On Wed, Oct 16, 2024 at 04:53:45PM +0800, lizhe.67@bytedance.com wrote:
> On Wed, 16 Oct 2024 10:09:55 +0200, peterz@infradead.org wrote:
> 
> > On Wed, Oct 16, 2024 at 12:35:58PM +0800, lizhe.67@bytedance.com wrote:
> > > From: Li Zhe <lizhe.67@bytedance.com>
> > > 
> > > In the current kernel rwsem implementation, there is an interface to
> > > downgrade write lock to read lock, but there is no interface to upgrade
> > > a read lock to write lock. This means that in order to acquire write
> > > lock while holding read lock, we have to release the read lock first and
> > > then acquire the write lock, which will introduce some troubles in
> > > concurrent programming. This patch set provides the 'upgrade_read' interface
> > > to solve this problem. This interface can change a read lock to a write
> > > lock.
> > 
> > upgrade-read is fundamentally prone to deadlocks. Imagine two concurrent
> > invocations, each waiting for all readers to go away before proceeding
> > to upgrade to a writer.
> >
> > Any solution to fixing that will end up being semantically similar to
> > dropping the read lock and acquiring a write lock -- there will not be a
> > single continuous critical section.
> 
> According to the implementation of this patch, one of the invocation will

Since the premise as described here is utter nonsense, I didn't get to
actually reading the implementation -- why continue to waste time etc.

> get '-EBUSY' in this case. If -EBUSY is obtained and the invocation thread
> continues to retry instead of dropping the read lock and acquiring a write lock,
> it may cause problems.

Failure should drop the read lock, otherwise it is too easy to mess
things up.

> Of course, this patchset only try it's best to achieve a
> single continuous critical section as much as possible, and there is no guarantee.

As already stated, nothing like that was mentioned.

> > As such, this interface makes no sense.
> 
> This interface is just trying to reduce the overhead caused by the
> additional checks, which is caused by non-continuous critical
> sections, as much as possible.  Rather than eliminating it in all
> scenarios. So would it be better to change the error code to something
> else? So that the caller will not retry this interface?

You fail to quantify the gains. How am I supposed to know if the
(significant?) increase in complexity is worth it?

Why should I accept this increase in complexity for the sake of
khugepaged, something which I care very little about?

