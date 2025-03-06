Return-Path: <linux-kernel+bounces-548182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E9CDA54146
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 04:38:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26EAE3AB18A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 03:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F3DE195980;
	Thu,  6 Mar 2025 03:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pRRKwj/E"
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3194A1D
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 03:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741232258; cv=none; b=WB/+FbcnIJ3qa8T6nXMxregOT1uf/Lfw+EZYBPlTKWNAn3nL54c2fQHl+kX0CX2UNWEpglK0xguHXhkuDwFNNzObV+EfiZIECGmhyNRo61MWgLm31mMtOgBQCUsl00vS2fP8KIKqev2tiZ+QZMPQf3941w7rqRkAQlRM0dEFN+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741232258; c=relaxed/simple;
	bh=UQjfSdWJFmbkTskFCMzGmNUTYR2SWotLa6Rym2BzZdw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YJ8jf6/RowLo7yLAlzzQD436ILHsV9H58qtECBmQGRG11eAasExqhmxLjT4eVNWEog7AzSmu3LDS3qTgUlLLxGykbJvCKa4wy7NjnypiDJwSMvHFJOdA43NVq5uidJ71igDVN9Y3Y92bO/tvS50IS2TzGnoOhrYvXFJS+zrqL9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pRRKwj/E; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 5 Mar 2025 19:37:28 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741232253;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GNLoFOWU5jJQo91E4c4IafI+3MUS/RR+ykWtiwhiEyQ=;
	b=pRRKwj/Ezs38ddcadgvSq9Rt+fjo4Xa2sZqVlY80b5oY9cDtdK0f8WNuPsyG3MaxenqaU1
	jcTu1SckckQCzWqcqptvWdyGRuwKtgsbNLgsiJ7DadkdCU9uP/77nmzu4e0jIfEN5Zpfco
	HDF6+lCQfP8mfdWeYqUIzAhrs9tKKFQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: SeongJae Park <sj@kernel.org>
Cc: "Liam R. Howlett" <howlett@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, kernel-team@meta.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH 05/16] mm/madvise: define and use madvise_behavior
 struct for madvise_do_behavior()
Message-ID: <y2trzz53wb43da2dsdlz44mlyla527zqqslxqgmbgqy753tl62@f7awfhhnfuk2>
References: <wdre2a4y6xmkvn4pgoptaqc67b6t646hgypbyjbin23u32zd3h@qrrdupkncnea>
 <20250305235632.137169-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250305235632.137169-1-sj@kernel.org>
X-Migadu-Flow: FLOW_OUT

On Wed, Mar 05, 2025 at 03:56:32PM -0800, SeongJae Park wrote:
> On Wed, 5 Mar 2025 13:40:17 -0800 Shakeel Butt <shakeel.butt@linux.dev> wrote:
> 
> >  
> > +struct madvise_walk_param {
> > +	int behavior;
> > +	struct anon_vma_name *anon_name;
> > +};
> 
> Only madvise_vma_behavior() will use 'behavior' field.  And only
> madvise_vma_anon_name() will use 'anon_name' field.  But I will have to assume
> both function _might_ use both fields when reading the madvise_walk_vmas()
> function code.  That doesn't make my humble code reading that simple and
> straightforward.
> 
> Also populating and passing a data structure that has data that would not
> really be used seems not very efficient to me.
> 

This is not a new pattern. You can find a lot of examples in kernel
where a struct encapsulates multiple fields and its pointer is passed
around rather than those fields (or subset of them). You can check out
zap_details, vm_fault, fs_parameter. If some fields are mutually
exclusive you can have union in the struct. Also I am not sure what do
you mean by "not efficient" here. Inefficient in what sense? Unused
memory or something else?

> [...]
> > @@ -1666,8 +1674,10 @@ static bool is_memory_populate(int behavior)
> >  }
> >  
> >  static int madvise_do_behavior(struct mm_struct *mm,
> > -		unsigned long start, size_t len_in, int behavior)
> > +		unsigned long start, size_t len_in,
> > +		struct madvise_walk_param *arg)
> >  {
> > +	int behavior = arg->behavior;
> >  	struct blk_plug plug;
> >  	unsigned long end;
> >  	int error;
> > @@ -1681,7 +1691,7 @@ static int madvise_do_behavior(struct mm_struct *mm,
> >  	if (is_memory_populate(behavior))
> >  		error = madvise_populate(mm, start, end, behavior);
> 
> 'arg' is for madvise_walk_vmas() visit function, but we're using it as a
> capsule for passing an information that will be used for madvise_do_behavior().
> This also seems not very straightforward to my humble perspective.

Here we can keep behavior as parameter to madvise_walk_vmas() and define
struct madvise_walk_param inside it with the passed behavior. Anyways
this is a very common pattern in kernel.

> 
> I have no strong opinion and maybe my humble taste is too peculiar.  But, if
> this is not a blocker for tlb flushes batcing, I'd like to suggest keep this
> part as is for now, and revisit for more code cleanup later.  What do you
> think, Shakeel?
> 

Squashing patches 5 to 8 into one is the main request from me. My other
suggestion you can ignore but let's see what other says.

