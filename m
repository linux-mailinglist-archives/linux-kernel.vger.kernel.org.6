Return-Path: <linux-kernel+bounces-380570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 267A89AF2A9
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 21:38:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 426B21C22180
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 19:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFB0B1FE0F6;
	Thu, 24 Oct 2024 19:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uuJVht6W"
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8CD22B67D
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 19:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729798711; cv=none; b=jsfncllq3H4RMyxBkxC6QNvCJwT50ERI7t3W5aYeZQQUvnHpVRyDyCjoVKFBMl/ZFLWksALGz4/z11dcvWf7vpbzqjhuZ7ayGQPsgguCCXKbtC+X6a3rx7DpDILDmg4f4nAb7r6kNQWOaUH0siZ5bVIrr5myI8loFpqn0XJBtOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729798711; c=relaxed/simple;
	bh=nD6EnB7uSGjuXYIk9bDc+dViW5uOP+52Zp4nG1vJySI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ognlcLmH3RfIIL5/b+0mah5PwtVKSke+AbR8drhs8XXaC/j0N6xfKDalQhUiC82w7RuF3wwYT8Ye0opkLP4l27H8lYMd43YMuv4dsy7Fboe3Y8BbzHmwOAOidgykzS1HCuU2yYuU0BxboBzaKXW3Rg154O3W58tFbZVVwAdAvQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uuJVht6W; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 24 Oct 2024 12:38:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729798706;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ygh5XAsyE1TzKPxIn/H04CcE11DeEBKZl9YsXiKRJ8c=;
	b=uuJVht6WUnsXQSm+f/Nq3lHvBqHu1NB1BTppL0W1zeEZF2IeV/n0Ab+H2v0O+uOEDKPY8B
	x3A9QmFME8FT0KbeyTXpXmlIY7+b/q/Q+geenVCVIJ/gt1+A0Ja5Mtf1zkxBDE/rK3LDZi
	LrFOQHFm5FoEM19Jti9PVhi7s0Z+/Zk=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Michal Hocko <mhocko@suse.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Muchun Song <muchun.song@linux.dev>, Hugh Dickins <hughd@google.com>, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-doc@vger.kernel.org, Meta kernel team <kernel-team@meta.com>
Subject: Re: [RFC PATCH 3/3] memcg-v1: remove memcg move locking code
Message-ID: <ocwpveyzmog7kaetvfmihzyrxlw5drz647jcsjcziv2gmejyyj@vksg3ntjea2g>
References: <20241024065712.1274481-1-shakeel.butt@linux.dev>
 <20241024065712.1274481-4-shakeel.butt@linux.dev>
 <ZxoQhEPXmSkM7sH_@tiehlicka>
 <kr6fjny7aqni4habduj2uqfznusozkku3xeq62bjscb5ovwxog@ccgl3kxufmma>
 <ZxqXyQb1nT6DWPN_@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxqXyQb1nT6DWPN_@google.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Oct 24, 2024 at 06:54:01PM GMT, Roman Gushchin wrote:
> On Thu, Oct 24, 2024 at 10:23:49AM -0700, Shakeel Butt wrote:
> > On Thu, Oct 24, 2024 at 11:16:52AM GMT, Michal Hocko wrote:
> > > On Wed 23-10-24 23:57:12, Shakeel Butt wrote:
> > > > The memcg v1's charge move feature has been deprecated. There is no need
> > > > to have any locking or protection against the moving charge. Let's
> > > > proceed to remove all the locking code related to charge moving.
> > > > 
> > > > Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> > > > ---
> > > > -/**
> > > > - * folio_memcg_lock - Bind a folio to its memcg.
> > > > - * @folio: The folio.
> > > > - *
> > > > - * This function prevents unlocked LRU folios from being moved to
> > > > - * another cgroup.
> > > > - *
> > > > - * It ensures lifetime of the bound memcg.  The caller is responsible
> > > > - * for the lifetime of the folio.
> > > > - */
> > > > -void folio_memcg_lock(struct folio *folio)
> > > > -{
> > > > -	struct mem_cgroup *memcg;
> > > > -	unsigned long flags;
> > > > -
> > > > -	/*
> > > > -	 * The RCU lock is held throughout the transaction.  The fast
> > > > -	 * path can get away without acquiring the memcg->move_lock
> > > > -	 * because page moving starts with an RCU grace period.
> > > > -         */
> > > > -	rcu_read_lock();
> > > 
> > > Is it safe to remove the implicit RCU?
> > 
> > Good question. I think it will be safe to keep the RCU in this patch and
> > in the followup examine each place and decide to remove RCU or not.
> 
> I took a really quick look and based on it I believe it is safe.
> Shakeel, can you, please, check too and preferably keep your code intact.
> I think it's better to remove it all together, rather than do it in two steps.
> If we really need rcu somewhere, we can replace folio_memcg_lock()/unlock()
> with an explicit rcu_read_lock()/rcu_read_unlock().
> 

Yup going through that and till now it seems safe. Hopefully I will have
the update by the evening.

