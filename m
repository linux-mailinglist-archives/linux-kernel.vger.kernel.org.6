Return-Path: <linux-kernel+bounces-412391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 710189D0862
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 05:22:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25123281A5D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 04:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27799823C3;
	Mon, 18 Nov 2024 04:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TtHZ2x/Y"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2348325760
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 04:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731903725; cv=none; b=skLnsPb8/e0G7sR6X934U9j9RkceY+kwmhWwPCftHNyOXl37u6KxC0/C4zuddD92he/fNFiiWeRyW5SdvLykIrIPYQ7aWTn9tg+EGe+DbBBo6wC8CpiqqY5sRUfRPVdUUgjDF4RpViayl6LsvgHrWGJnO42rvm3jscNoOPBnnP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731903725; c=relaxed/simple;
	bh=S6ZATa9Cwpa8kiNzunPK402yxZ00hmovMy5Fey6u0vo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E0eZvZtMM5QvdG9ps9LOArsLieYC73QboLrnhDWb0Fra7tcwHqGdGPSGg9RLNPLtfom6IXIFGPrcK1EY7SxAVBLqkQUnrxSB2YeZ09PTSGTUysWW1a7Jdo7B1maHQPa+l61S/c/9kp++WJKxSxCgmBVxevjN8us0iQNubMyyUXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=TtHZ2x/Y; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=aYkkJ/xn2nCKMiiN7tsl34G8O8kOQEIySBtfq+iOWXs=; b=TtHZ2x/YJ0TkFRSHg5PYv3oeUd
	TfEcQOG8Wzov63HCuTIuLhyEZZ9iJS9uuckMF5GUy3HD5O4nFBZL/y/vWFSt5nLInhBiMFkokT18H
	5mMlDsCscA2asfm7Deo6gBLyr6lFqVyr5Kpk52Bhe29yRehhDHfmtoM6y/0SrmEQ98xPRAxyR5eg/
	L/PFGXf1TvX+/f4NnJkc69HodS7OBn3HNdN9qkkvQ1s06C/ftmN8UEGkbydTqEHj8UXovIx+xq0qZ
	wjMMApP8ZzmZ6WHc8PLjySSaLmX3jzLrR82nU5o5ZBiA+eLICR9bSBZHyPJrr9oCZQhaWG1PM4ByV
	kWQZPdMQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tCtGw-00000002YtG-2u92;
	Mon, 18 Nov 2024 04:21:58 +0000
Date: Mon, 18 Nov 2024 04:21:58 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Barry Song <21cnbao@gmail.com>
Cc: Chen Ridong <chenridong@huaweicloud.com>, akpm@linux-foundation.org,
	mhocko@suse.com, hannes@cmpxchg.org, yosryahmed@google.com,
	yuzhao@google.com, david@redhat.com, ryan.roberts@arm.com,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	chenridong@huawei.com, wangweiyang2@huawei.com,
	xieym_ict@hotmail.com, Chris Li <chrisl@kernel.org>
Subject: Re: [RFC PATCH v2 1/1] mm/vmscan: move the written-back folios to
 the tail of LRU after shrinking
Message-ID: <ZzrA5nXldoE2PWx4@casper.infradead.org>
References: <20241116091658.1983491-1-chenridong@huaweicloud.com>
 <20241116091658.1983491-2-chenridong@huaweicloud.com>
 <Zzq8jsAQNYgDKSGN@casper.infradead.org>
 <CAGsJ_4x0OrdhorQdz8PyLD84GOYVZJ7kLfGV_5yupLG_ZQ_B3w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGsJ_4x0OrdhorQdz8PyLD84GOYVZJ7kLfGV_5yupLG_ZQ_B3w@mail.gmail.com>

On Mon, Nov 18, 2024 at 05:14:14PM +1300, Barry Song wrote:
> On Mon, Nov 18, 2024 at 5:03 PM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Sat, Nov 16, 2024 at 09:16:58AM +0000, Chen Ridong wrote:
> > > 2. In shrink_page_list function, if folioN is THP(2M), it may be splited
> > >    and added to swap cache folio by folio. After adding to swap cache,
> > >    it will submit io to writeback folio to swap, which is asynchronous.
> > >    When shrink_page_list is finished, the isolated folios list will be
> > >    moved back to the head of inactive lru. The inactive lru may just look
> > >    like this, with 512 filioes have been move to the head of inactive lru.
> >
> > I was hoping that we'd be able to stop splitting the folio when adding
> > to the swap cache.  Ideally. we'd add the whole 2MB and write it back
> > as a single unit.
> 
> This is already the case: adding to the swapcache doesn’t require splitting
> THPs, but failing to allocate 2MB of contiguous swap slots will.

Agreed we need to understand why this is happening.  As I've said a few
times now, we need to stop requiring contiguity.  Real filesystems don't
need the contiguity (they become less efficient, but they can scatter a
single 2MB folio to multiple places).

Maybe Chris has a solution to this in the works?

