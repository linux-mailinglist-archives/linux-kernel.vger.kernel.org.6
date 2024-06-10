Return-Path: <linux-kernel+bounces-208774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D1A57902902
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 21:08:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D7B61F22B99
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 19:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B365814B975;
	Mon, 10 Jun 2024 19:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jxFSriHx"
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A59085626
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 19:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718046496; cv=none; b=BZqA+WJjmucXZRm7HLD7WtylFLkMvCx/0kK3pdi9Yv+HM4RPPReia83pnXnn/cBqgJiA/4/h94r44iHmWjpGB72stvpZbJ+kXNoDynytw33srvrWcnmeAfhjmbtvzTb69U/GsLVl36s/pfxIZSLa6pK3kouGFOUigiuSk9jGxF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718046496; c=relaxed/simple;
	bh=2LH7Mq758jip3fRWKYW+Igh/ol6AMypsLYGrskJqvb0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TzzVy+4yGqlIdUX/JWazBl3LxfSjYUfc05z4yMdJZKWyQB0Ux+zrKCqLiDKY419NfWk/BJPPhrYdvhe+2jjyHKJAYycp874xGkkBBVZHfBjFkdELaVOq6zUgKgerZx3JV12VHPj0I5uV9OaxIM9RaFk1Q/h33mayyZWZzt5WYZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jxFSriHx; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: yosryahmed@google.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1718046492;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oNWYfatfBVCfLA1P/LzD5i97uvPMeL95cxbaUUFmbJA=;
	b=jxFSriHxLjs7DgVr9cvwy8RV5Qd7kD4SVcugWvrbN4HRE3LBXUSIqI7uhtJK0mgKN9BKoQ
	AzdNpipPC58OOS7AAeLn9Q0zH835Qnl0rsKj2YmEk/MoAi+7bmgMseV1DfnGRdQb1IHTeA
	fjBqSP7xyhgLGdkxkn7T/ZPbyNlOMvo=
X-Envelope-To: usamaarif642@gmail.com
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: willy@infradead.org
X-Envelope-To: hannes@cmpxchg.org
X-Envelope-To: nphamcs@gmail.com
X-Envelope-To: chengming.zhou@linux.dev
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: kernel-team@meta.com
Date: Mon, 10 Jun 2024 12:08:04 -0700
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Usama Arif <usamaarif642@gmail.com>, akpm@linux-foundation.org, 
	willy@infradead.org, hannes@cmpxchg.org, nphamcs@gmail.com, chengming.zhou@linux.dev, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH] mm: Do not start/end writeback for pages stored in zswap
Message-ID: <y7ourydoftwyfxza3a2vlenh6bzdrhtc25h4msqgq2uyg75ocf@wrfov7zflr3w>
References: <20240610143037.812955-1-usamaarif642@gmail.com>
 <CAJD7tkYdTvfO8P+aZNmr7bF7vEetxiqQQ4ML8BcLdmKohT-+Cg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJD7tkYdTvfO8P+aZNmr7bF7vEetxiqQQ4ML8BcLdmKohT-+Cg@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Jun 10, 2024 at 10:31:36AM GMT, Yosry Ahmed wrote:
> On Mon, Jun 10, 2024 at 7:31 AM Usama Arif <usamaarif642@gmail.com> wrote:
> >
> > start/end writeback combination incorrectly increments NR_WRITTEN
> > counter, eventhough the pages aren't written to disk. Pages successfully
> > stored in zswap should just unlock folio and return from writepage.
> >
> > Signed-off-by: Usama Arif <usamaarif642@gmail.com>
> > ---
> >  mm/page_io.c | 2 --
> >  1 file changed, 2 deletions(-)
> >
> > diff --git a/mm/page_io.c b/mm/page_io.c
> > index a360857cf75d..501784d79977 100644
> > --- a/mm/page_io.c
> > +++ b/mm/page_io.c
> > @@ -196,9 +196,7 @@ int swap_writepage(struct page *page, struct writeback_control *wbc)
> >                 return ret;
> >         }
> >         if (zswap_store(folio)) {
> > -               folio_start_writeback(folio);
> >                 folio_unlock(folio);
> > -               folio_end_writeback(folio);
> 
> Removing these calls will have several effects, I am not really sure it's safe.
> 
> 1. As you note in the commit log, NR_WRITTEN stats (and apparently
> others) will no longer be updated. While this may make sense, it's a
> user-visible change. I am not sure if anyone relies on this.
> 

I couldn't imagine how this stat can be useful for the zswap case and I
don't see much risk in changing this stat behavior for such cases.

> 2. folio_end_writeback() calls folio_rotate_reclaimable() after
> writeback completes to put a folio that has been marked with
> PG_reclaim at the tail of the LRU, to be reclaimed first next time. Do
> we get this call through other paths now?
> 

The folio_rotate_reclaimable() only makes sense for async writeback
pages i.e. not for zswap where we synchronously reclaim the page.

> 3. If I remember correctly, there was some sort of state machine where
> folios go from dirty to writeback to clean. I am not sure what happens
> if we take the writeback phase out of the equation.
> 

Is there really such a state machine? We only trigger writeback if the
page is dirty and we have cleared it. The only thing I can think of is
the behavior of the waiters on PG_locked bit but the window of
PG_writeback is so small that it seems like it does not matter.


