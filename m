Return-Path: <linux-kernel+bounces-270598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB519441EB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 05:36:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CFB92834D8
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 03:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 514E113CF9F;
	Thu,  1 Aug 2024 03:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kFkXLDs+"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700FA171CD
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 03:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722483357; cv=none; b=goKVcsbafbd4De4tFwMQzue8imQx+SIvhd4PHk29KQuGRxVqoYndLg9qsXFcDaHaOBBkxDZMDqCUFV/5Jv8lTT7tEg2llv8I+jDR7cH7L3Lvp4vZRC7Ik5W0xagSCG+QN0XGF7UH8OMHQxKDt8iBfApaGJ+iJI3soZqrovQa2TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722483357; c=relaxed/simple;
	bh=0DMtud3iIOeHhxIy+H8Ew/dicSpWWLquGMYvw8ArYlc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HgsZZoEyOYo/6f/O/yhUlfTJnRTM/cWCVpYveRYW4EsIYkRI0yisy4+ORizNi9YnMz/TnlO/fAbJZx1U7QlCkSC55Iy9vwVGw13w+KWbaF6b5Gocrc1qDGkgh1UhyNTMTmK+WZYLNkqgY1X3YPVnzAxGhFBakmjwOS+FZbcF8YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=kFkXLDs+; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=HlwpK9U6TuXGOvkD7uqz2mtvB263qVdMN2nixeBYcks=; b=kFkXLDs+s2g5TRWrcWJXtGgXex
	xIumqTI9O18RcKHMj1wMlXhpdDh1DHUu9OHstHWvv1CBGfds+qNPk103wk1O77A0dWDK4ubzF//jL
	P2sSZr0LxaOX3H24flSTfjVagtztXapHeVi3ql5sv93xNW3u72VkLMPYY/lSK3fdgMWN30dVY6ja5
	Dw+7gDMLcxgc77MM3wuymbmQ1fCU/+GaZQKnil8KC9yC4DnJxogCeXDgmqwi3JUB/zWqRQnkfedFW
	18kWw5LjqpBtwTqHtJ/0IQNlJWbJ+AgUG0fpbJfAaWIxX5KDSUkACsFmCwR6ZgKe1+MzRHFDuOWJH
	MLfgMm7g==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sZMbV-0000000Gvqc-1AdQ;
	Thu, 01 Aug 2024 03:35:49 +0000
Date: Thu, 1 Aug 2024 04:35:49 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Alex Shi <seakeel@gmail.com>, alexs@kernel.org,
	Vitaly Wool <vitaly.wool@konsulko.com>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	minchan@kernel.org, david@redhat.com, 42.hyeyoo@gmail.com,
	Yosry Ahmed <yosryahmed@google.com>, nphamcs@gmail.com
Subject: Re: [PATCH v4 22/22] mm/zsmalloc: update comments for page->zpdesc
 changes
Message-ID: <ZqsClTYNqR5wYlJ6@casper.infradead.org>
References: <20240729112534.3416707-1-alexs@kernel.org>
 <20240729112534.3416707-23-alexs@kernel.org>
 <20240730093726.GB16599@google.com>
 <8fc7939b-416a-4328-9df2-488f17783543@gmail.com>
 <20240731021619.GD16599@google.com>
 <c614ec0c-ff5c-4ef6-8542-53ee5308f62a@gmail.com>
 <20240801031304.GF16599@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240801031304.GF16599@google.com>

On Thu, Aug 01, 2024 at 12:13:04PM +0900, Sergey Senozhatsky wrote:
> On (24/07/31 12:14), Alex Shi wrote:
> > > A bit of a different thing, still documentation related tho: do
> > > we want to do something about comments that mention page_lock in
> > > zsmalloc.c?
> > 
> > Good question!
> > 
> > There are some comments mentioned about the page_lock in the file, but missed
> > in the header of file, so how about the following adding:
> 
> And e.g. things like
> 
> `The page locks trylock_zspage got will be released by __free_zspage.`
> 
> Should this (and the rest) spell "zpdesc locks" or something? Or do
> we still want to refer to it as "page lock"?

pages do not have locks.  folios have locks.  zpdesc sounds like it has
a lock too.

