Return-Path: <linux-kernel+bounces-199254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B06F38D8469
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 15:52:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E23341C21DC3
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 13:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7693512DD8A;
	Mon,  3 Jun 2024 13:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kOjAT6NL"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26EE1E4A2
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 13:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717422757; cv=none; b=HBxtXOcfspmZ1lskUyscaDHWmbh0Es+dpWohygp/Lbx3cPy2Wbti493uXwOagaokuy798ANe5Ea9FgpCIiAvgQtNnjaPiuJKJM+p+eiumS2oDnCAC+PVGv4LR0OJ7mzpDOqYizr7PFhG6sd9WC7QH1sxxctoWg2zdkVX7zSNiD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717422757; c=relaxed/simple;
	bh=66W8PqO/08bEDz3lkl5bCSdcI1i/DXfmzD75BacEB78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O60yqvODGWp95uzem4RtofhMk6rlupJbu5D4OISIx/e3FP+EqlaMFhVSp1E/NLcksbeq7rJACjeB8B5lwKT9ifiRvhyH9/SnykWt3TmEzXhXehMrBqKVv91UcDC10Z162K9YJUfbM8+E6c3JTvJLiw3nyedjMk4lvbs6278F8O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=kOjAT6NL; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=2WoGTDTDlIhk96e2gtrr9oRMnWxD0GTiKrPTYhXDtqA=; b=kOjAT6NLs8wlRmEz9XbT+ulX+3
	jFhcvpiFSf2R85R9ES/zwCmqSfM6zji4AJdy/qI3IVpPP2krL/ywYPsl9gVQIaSgVuQ7bIWoR7myc
	ct1OR5B30DArtpgGP7i3XhpagUIybx6fUbvTtjx06mGHKG6NUXIzT5ck1P/K0X1TF7eGiMSWMQPSa
	sXjsolo6ubITZlu8fhugmF4q41+pZkMBt9Da/f1fXQsKAd2qmFPjKhC3LuOqIX/PDqVPFr/y1QT+G
	RQDkYcz/fk7FN79xRHN/2b/I3Fo/Av1tFIXRk8yek7NYp6P0mWYuXiORv+hNyKC6B+To3YpOScQ0F
	OqAIdCGw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sE86y-0000000E8t1-26jG;
	Mon, 03 Jun 2024 13:52:32 +0000
Date: Mon, 3 Jun 2024 14:52:32 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Yajun Deng <yajun.deng@linux.dev>
Cc: akpm@linux-foundation.org, rppt@kernel.org, hannes@cmpxchg.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: pass the pfn to set_pageblock_migratetype
Message-ID: <Zl3KoETSfL6-RTU1@casper.infradead.org>
References: <20240603124100.2834-1-yajun.deng@linux.dev>
 <Zl2_N9wHOh9ACQpt@casper.infradead.org>
 <1bb60f7db3a11e86e6f48c1eefe7f27d7d23019c@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1bb60f7db3a11e86e6f48c1eefe7f27d7d23019c@linux.dev>

On Mon, Jun 03, 2024 at 01:48:50PM +0000, Yajun Deng wrote:
> June 3, 2024 at 9:03 PM, "Matthew Wilcox" <willy@infradead.org> wrote:
> > On Mon, Jun 03, 2024 at 08:41:00PM +0800, Yajun Deng wrote:
> > > It is necessary to calculate the pfn in the set_pageblock_migratetype(),
> > >  but most of the callers already have the pfn.
> > 
> > It's not exactly a hard computation though. Have you done any
> > 
> > measurements that show this patch is an improvement?
> 
> No, just view the code. But some callers are in a for loop.

All the more reason to MEASURE.  There is a cost to marshalling
function arguments which must be weighed against the cost of
recalculating the PFN.  Since you haven't done that, NAK.

