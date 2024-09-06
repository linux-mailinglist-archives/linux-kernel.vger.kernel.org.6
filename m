Return-Path: <linux-kernel+bounces-318109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B4E96E870
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 05:52:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 933F91C22A76
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 03:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FD3B3CF74;
	Fri,  6 Sep 2024 03:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EWsDUIk1"
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597B9A41
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 03:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725594773; cv=none; b=W4WNHXkk5Cgly+zEdsvR6cjw3lmKQWN7I/R2r4ES5vURMA5QQCeH9l41RNJafaoKvB3P9Yw1dP5pHWewKfhnPIE8NPh/zYcx4gKyHWXg5B5LvfFQwPZPjidQgJr+1Lioy5PDmMvIasfTKTV6PXMJpYYZZ0KxEt26K8kC44+nKP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725594773; c=relaxed/simple;
	bh=k+EFDrv0Cg1+Kr7vOF+1aKyyGEYd+++vpec491VItdo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cLR1prIEKliX7VXz09DAWNhpjvKbK8FjHKX/zDjhf9Tqm+tXh/KXCeGvzo3lSHqypb3mPZfWaVm0Zcjho/QvhUonw5jzPWqOyQGoeOhxQtqHg8UwiFNtyKiakPrqWDiP4j7eVvUxh+Vs5yr+V2j8aDbPxsSbeOuk2cbQNmy1jbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EWsDUIk1; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 5 Sep 2024 23:52:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725594767;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ViqQws4Jf5ziYGnPbgxaT1dl8++vDEC9G09+6DnUaY0=;
	b=EWsDUIk1GSB2ZARLyN51oWu0S91Lx4Y9sI1v80o+i9Fd55EtgN8xmnlTMgaoKd4CYqKHmj
	YazBWM44WRcybdK+tis1Xwp5TX5av0Q9xrWBMukgKgJXSdeOuKpPxg3uKMFhJs/tziEdR0
	+7rzaHpVjj5/KQ7Cqm0PMZHtoEgY9s4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org
Subject: Re: [PATCH] mm/show_mem.c: report alloc tags in human readable units
Message-ID: <cu62ykkqsnuef45qn44wucsqqmpexx2isadwwuu26rny6femip@ptdf3u6zgcqp>
References: <20240906005337.1220091-1-kent.overstreet@linux.dev>
 <CAJuCfpGPAWO5M9SgTYapvtfxnK19EFbNhGZGunGK2OCxdVYNjQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpGPAWO5M9SgTYapvtfxnK19EFbNhGZGunGK2OCxdVYNjQ@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Sep 05, 2024 at 08:32:24PM GMT, Suren Baghdasaryan wrote:
> On Thu, Sep 5, 2024 at 5:53 PM Kent Overstreet
> <kent.overstreet@linux.dev> wrote:
> >
> > We already do this when reporting slab info - more consistent and more
> > readable.
> 
> Hi Kent,
> I remember we discussed this before and agreed upon Pasha's suggestion
> that if needed one could do:
> 
> # sort -g /proc/allocinfo|tail|numfmt --to=iec
>         2.8M    22648 fs/kernfs/dir.c:615 func:__kernfs_new_node
>         3.8M      953 mm/memory.c:4214 func:alloc_anon_folio
>         4.0M     1010 drivers/staging/ctagmod/ctagmod.c:20 [ctagmod]
> func:ctagmod_start
>         4.1M        4 net/netfilter/nf_conntrack_core.c:2567
> func:nf_ct_alloc_hashtable
>         6.0M     1532 mm/filemap.c:1919 func:__filemap_get_folio
>         8.8M     2785 kernel/fork.c:307 func:alloc_thread_stack_node
>          13M      234 block/blk-mq.c:3421 func:blk_mq_alloc_rqs
>          14M     3520 mm/mm_init.c:2530 func:alloc_large_system_hash
>          15M     3656 mm/readahead.c:247 func:page_cache_ra_unbounded
>          55M     4887 mm/slub.c:2259 func:alloc_slab_page
>         122M    31168 mm/page_ext.c:270 func:alloc_page_ext
> 
> That's even documented here:
> https://elixir.bootlin.com/linux/v6.10.8/source/Documentation/mm/allocation-profiling.rst#L36
> Did something change?

That's for /proc/allocinfo, which this patch doesn't change - this is
the oom report.

