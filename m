Return-Path: <linux-kernel+bounces-535171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36872A46FC3
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 01:00:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F9EB3AFEF4
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 00:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D69D679CF;
	Thu, 27 Feb 2025 00:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bEIOLwsm"
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41AB1FC8
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 00:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740614437; cv=none; b=MYldOIEe9BU97CQwe6sR+G/F+16blHqwVEuZr9u7lOGeHoVJGBUBuGIc6OaWCBKsWnTHOfa62uXCuBsu+sn9aHRfkrzLi/cuWM6hnsOghO5ayQFtIN6nhSXZbT7aYcYKCXJm+/IMAIHcMjCYe3SqfhCAtmV0Zow43oJHenTLaBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740614437; c=relaxed/simple;
	bh=nfHEX4wecSpOYGYuoY+3dKBNs1jUcg8WeLZ83fxlWT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IZzJmzjFYrW5sqku759DeY3Hxdp11OGwFJYwy7/s8Pvn1B/GGKlDK2i9xjluANa+FXHKkYfBIoUcYm3Ua2Kqxl2NgRgsdhhZO+bGLEUdlKjj/XM9iSBFljhT6Dq7Cb9TH9ycaOavWAe5sou7AvGhCI684UIrYrInOQCmbBuBWak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bEIOLwsm; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 27 Feb 2025 00:00:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740614432;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lZF8l/6nKdJOw4wJVKCersbjISsxoghQ1nANtX1CqBI=;
	b=bEIOLwsm3ncqczp/Vdewq3DRMAeuJM57tPvyoFbWb8dSKpn+c5XrKn5D5RO7ftTn/K2nTI
	JdVSGtPOFX4iEBUFZBrZn99vHjobZGDh1xOWebsjao2oLpsPLT4PfO6ERhJ78HhQFJ8v95
	7bkKrpxsDU6QlK8pYG+Wh+zu/DQc0v4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Nhat Pham <nphamcs@gmail.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, akpm@linux-foundation.org,
	chengming.zhou@linux.dev, linux-mm@kvack.org, kernel-team@meta.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] zswap: do not crash the kernel on decompression failure
Message-ID: <Z7-rG7Y3DK33MyCl@google.com>
References: <20250225213200.729056-1-nphamcs@gmail.com>
 <Z76Go1VGw272joly@google.com>
 <20250226045727.GB1775487@cmpxchg.org>
 <Z780VzBOE3LKY0yi@google.com>
 <CAKEwX=PR3tJM4X00hSua-w-FNR_ZwQ1oRqdT2Cgj_FV9cCUing@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKEwX=PR3tJM4X00hSua-w-FNR_ZwQ1oRqdT2Cgj_FV9cCUing@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Feb 26, 2025 at 03:20:13PM -0800, Nhat Pham wrote:
> On Wed, Feb 26, 2025 at 7:33 AM Yosry Ahmed <yosry.ahmed@linux.dev> wrote:
> >
> > On Tue, Feb 25, 2025 at 11:57:27PM -0500, Johannes Weiner wrote:
> > > On Wed, Feb 26, 2025 at 03:12:35AM +0000, Yosry Ahmed wrote:
> > > > On Tue, Feb 25, 2025 at 01:32:00PM -0800, Nhat Pham wrote:
> > > > > Currently, we crash the kernel when a decompression failure occurs in
> > > > > zswap (either because of memory corruption, or a bug in the compression
> > > > > algorithm). This is overkill. We should only SIGBUS the unfortunate
> > > > > process asking for the zswap entry on zswap load, and skip the corrupted
> > > > > entry in zswap writeback.
> > > >
> > > > Some relevant observations/questions, but not really actionable for this
> > > > patch, perhaps some future work, or more likely some incoherent
> > > > illogical thoughts :
> > > >
> > > > (1) It seems like not making the folio uptodate will cause shmem faults
> > > > to mark the swap entry as hwpoisoned, but I don't see similar handling
> > > > for do_swap_page(). So it seems like even if we SIGBUS the process,
> > > > other processes mapping the same page could follow in the same
> > > > footsteps.
> > >
> > > It's analogous to what __end_swap_bio_read() does for block backends,
> > > so it's hitchhiking on the standard swap protocol for read failures.
> >
> > Right, that's also how I got the idea when I did the same for large
> > folios handling.
> 
> And your handling of the large folio (along with the comment in the
> other thread) was how I got the idea for this patch :)
> 
> >
> > >
> > > The page sticks around if there are other users. It can get reclaimed,
> > > but since it's not marked dirty, it won't get overwritten. Another
> > > access will either find it in the swapcache and die on !uptodate; if
> > > it was reclaimed, it will attempt another decompression. If all
> > > references have been killed, zswap_invalidate() will finally drop it.
> > >
> > > Swapoff actually poisons the page table as well (unuse_pte).
> >
> > Right. My question was basically why don't we also poison the page table
> > in do_swap_page() in this case. It's like that we never swapoff.
> 
> That would require a rmap walk right? To also poison the other PTEs
> that point to the faulty (z)swap entry?
> 
> Or am I misunderstanding your point :)

Oh I meant why not just mark the entry where the fault happened as
poisoned at least. Finding other PTEs that point to the swap entry is a
different story. I don't think we can even use the rmap here.

