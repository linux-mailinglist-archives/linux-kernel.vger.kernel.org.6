Return-Path: <linux-kernel+bounces-278846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6565394B599
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 05:45:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D16FC283E55
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 03:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9D72433C8;
	Thu,  8 Aug 2024 03:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AWyLPZQw"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F4365C
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 03:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723088714; cv=none; b=Yvxcy6EMxhWviobAlCx3iE0gNP1sQK3Ub1zVHlFdXrwW2pN/wqc2pQpyN0HTtvwSaZTZkjg7oqCp29W9Te2voVis9YmfWttOzVCLuuaWz25SXK/uVHGXoQWUichUfbAxSYJ8lEKrmNElDlsB/oKltMZuMc4xWvHjMGOsjac1Ysg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723088714; c=relaxed/simple;
	bh=LVqElMX3NXgtDhCXI0mZchmJ/FaATc8wFNS/I8I3Gxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bsm9dsCecQ/7jXNe5hC59SAwFkZAW+i/tOGvM0YDcVmnshFSdgtq/svGt7oqNMpkR0lkmEC+k0VBPCbDOh8wTydt1K6j8MZ6BaQtxgJgRdUq2riR9Tz+e8DBGDcg/vJ9gwzecuuqYHzj9WyEtN4ZdZKjjbP+xf2yTJvFSuDhk44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=AWyLPZQw; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Za+TJqbhL/rjJBg2IA082iNPQ+VXM8kbHaYz8Mr1drI=; b=AWyLPZQwiqAcekTM7yqoitp8pu
	f+EBnrV/e3Eg8435NM+0fKiqU6x1EmpTJoU/8CJppiy0TmYtD3+fI7honOwivzn+AmylIfFKERDsa
	tvYPd1u8vERN7Y7Vpd2/e6akctvVd8N1/l2CcGz5sYaf++oN8djJu0bFhr6FRpLaEMsNwOBDBWZUo
	zsP3CvT+5kdjSPKCFtnK4U0PR+MpCw+2mp5svbNKCy02N/pafgwgxAVIl3FeqxOKFWjrvFwXi8LbL
	kq0vGI8d83saKrOZDc6pPUFi5z+l18t5d/vMFrZFfdh7R5T5Ig8nfXhRm+tOdkkpXGzu8zaVUkYAF
	PiECzbQA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sbu5L-00000008Jvm-2fO4;
	Thu, 08 Aug 2024 03:45:07 +0000
Date: Thu, 8 Aug 2024 04:45:07 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Alex Shi <seakeel@gmail.com>
Cc: Yosry Ahmed <yosryahmed@google.com>,
	Andrew Morton <akpm@linux-foundation.org>, alexs@kernel.org,
	Vitaly Wool <vitaly.wool@konsulko.com>,
	Miaohe Lin <linmiaohe@huawei.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, minchan@kernel.org, senozhatsky@chromium.org,
	david@redhat.com, 42.hyeyoo@gmail.com, nphamcs@gmail.com
Subject: Re: [PATCH v5 00/21] mm/zsmalloc: add zpdesc memory descriptor for
 zswap.zpool
Message-ID: <ZrQ_Q-s7dO4aWNlG@casper.infradead.org>
References: <20240806022143.3924396-1-alexs@kernel.org>
 <20240806022311.3924442-1-alexs@kernel.org>
 <20240806123213.2a747a8321bdf452b3307fa9@linux-foundation.org>
 <CAJD7tkakcaLVWi0viUqaW0K81VoCuGmkCHN4KQXp5+SSJLMB9g@mail.gmail.com>
 <ZrJ8hzC9z4NMYffr@casper.infradead.org>
 <c1793a38-b8d3-46f2-8f21-85e691af3275@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c1793a38-b8d3-46f2-8f21-85e691af3275@gmail.com>

On Wed, Aug 07, 2024 at 10:04:11AM +0800, Alex Shi wrote:
> 
> 
> On 8/7/24 3:41 AM, Matthew Wilcox wrote:
> > On Tue, Aug 06, 2024 at 12:34:25PM -0700, Yosry Ahmed wrote:
> >> Matthew asked an important question here that needs to be answered by
> >> zsmalloc experts:
> >> https://lore.kernel.org/lkml/Zq0zucMFsOwATsAC@casper.infradead.org/
> > 
> > Yes, and I said it needed to be answered before we had a v5.  So I'm
> > very disappointed that not 24 hours later we're seeing a v5.
> 
> Hi Willy,
> 
> Sorry, I don't know the reply time meaning a lot here.

How could I have been more clear?

> I tried to reply you:
> https://lore.kernel.org/lkml/86e97328-a784-4320-b634-c582d5a10aff@gmail.com/
> And hope for more discussion on v5.

You wrote:
> I believe you has much more idea of the ways to memdesc. 
> Is there some references or detailed info which I could learn from you?

I've pointed you at everything I've written.  If you ask a specific
question about something that's not clear, I can answer that question.
This vague "please teach me" isn't going to lead anywhere fruitful.

