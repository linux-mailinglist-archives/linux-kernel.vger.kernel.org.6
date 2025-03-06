Return-Path: <linux-kernel+bounces-548205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8260A54199
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 05:18:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCA133ADB9F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 04:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCBFA1991CB;
	Thu,  6 Mar 2025 04:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s15WA362"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F6618DB13
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 04:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741234697; cv=none; b=bXJCoifgFvovctyJ7drjzbEtaOS6OGrj8rnjTWYuGMI9YVBEGTV/Lszxu/2NfSyDljBL2hP3gf5qQvhNo/hZURSwW9qrel5f5tEl17MH4fehUIhZ97g1kPgum7IHBkCoYdyEUpVKD6CsjiWAFNZ2QCxLEMSDbz1OPH7wBE8dDpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741234697; c=relaxed/simple;
	bh=VgXJGwKGRvF0z0k8Etl8Xec0K7y3Rvi04P7d0jCoAb4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mYA4tX4FtLP5OPZnCOWWKvdIEO52TxcxDxfSsaa9ZD13l8NiirvJWdymZJUORpQ6W/MSptTHOHane9qidC9DUYNOyH7LpvoTexWWBcLOLKY8QohC3qUmnyVAu3EGCNePfPAxeupySMIJMCqbatBhiN3tCsBtsRRcxMnsP2ahHAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s15WA362; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F1F3C4CEE4;
	Thu,  6 Mar 2025 04:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741234694;
	bh=VgXJGwKGRvF0z0k8Etl8Xec0K7y3Rvi04P7d0jCoAb4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s15WA362Z9PWIBmTNg6hAKO0dU1Zgc4ojZ64aPwmNckMZQbyi/sj15Q3tAGSJ2PZd
	 AwHhX3rdTCUOPJQ8FahaOyyaiwVQbfxItHQ51tBurXZkQBZsv4oToYM6J/i14lxGIT
	 y9iUIgoBbqKsgakAxEnoen5MbYLsRd45M9v3TuDLTDpu4f4uIRYCr1NUAX3R3TF9th
	 fvsf1ePefiiPjuKEyvqmGpYvLJv0lqeZlcO+UWZPc0qlcXKqwOjjHAOFEiWAQwzIsg
	 wkf2Jodshy+BrZRO17UqHJNQi0jScHOX1vvAVDeSEev85J7JTvqwyHedBZEM3x51ku
	 wD/zjguTmyEpg==
From: SeongJae Park <sj@kernel.org>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: SeongJae Park <sj@kernel.org>,
	"Liam R. Howlett" <howlett@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH 05/16] mm/madvise: define and use madvise_behavior struct for madvise_do_behavior()
Date: Wed,  5 Mar 2025 20:18:12 -0800
Message-Id: <20250306041812.59243-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <y2trzz53wb43da2dsdlz44mlyla527zqqslxqgmbgqy753tl62@f7awfhhnfuk2>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 5 Mar 2025 19:37:28 -0800 Shakeel Butt <shakeel.butt@linux.dev> wrote:

> On Wed, Mar 05, 2025 at 03:56:32PM -0800, SeongJae Park wrote:
> > On Wed, 5 Mar 2025 13:40:17 -0800 Shakeel Butt <shakeel.butt@linux.dev> wrote:
> > 
> > >  
> > > +struct madvise_walk_param {
> > > +	int behavior;
> > > +	struct anon_vma_name *anon_name;
> > > +};
> > 
> > Only madvise_vma_behavior() will use 'behavior' field.  And only
> > madvise_vma_anon_name() will use 'anon_name' field.  But I will have to assume
> > both function _might_ use both fields when reading the madvise_walk_vmas()
> > function code.  That doesn't make my humble code reading that simple and
> > straightforward.
> > 
> > Also populating and passing a data structure that has data that would not
> > really be used seems not very efficient to me.
> > 
> 
> This is not a new pattern. You can find a lot of examples in kernel
> where a struct encapsulates multiple fields and its pointer is passed
> around rather than those fields (or subset of them). You can check out
> zap_details, vm_fault, fs_parameter. If some fields are mutually
> exclusive you can have union in the struct.

You're right.  But we do so for readability and/or efficiency, right?  And what
I'm saying is that I'm not very sure if this change is making code much easier
to read and/or efficient.

> Also I am not sure what do
> you mean by "not efficient" here. Inefficient in what sense? Unused
> memory or something else?

I was meaning unused memory in this context.  It is a negligible extent, of
course.  Nevertheless, what I wanted to say is not that the change will degrade
efficiency too much, but I'm not clearly seeing the efficiency benefit that
explains why the change is something that should be made.

> 
> > [...]
> > > @@ -1666,8 +1674,10 @@ static bool is_memory_populate(int behavior)
> > >  }
> > >  
> > >  static int madvise_do_behavior(struct mm_struct *mm,
> > > -		unsigned long start, size_t len_in, int behavior)
> > > +		unsigned long start, size_t len_in,
> > > +		struct madvise_walk_param *arg)
> > >  {
> > > +	int behavior = arg->behavior;
> > >  	struct blk_plug plug;
> > >  	unsigned long end;
> > >  	int error;
> > > @@ -1681,7 +1691,7 @@ static int madvise_do_behavior(struct mm_struct *mm,
> > >  	if (is_memory_populate(behavior))
> > >  		error = madvise_populate(mm, start, end, behavior);
> > 
> > 'arg' is for madvise_walk_vmas() visit function, but we're using it as a
> > capsule for passing an information that will be used for madvise_do_behavior().
> > This also seems not very straightforward to my humble perspective.
> 
> Here we can keep behavior as parameter to madvise_walk_vmas() and define
> struct madvise_walk_param inside it with the passed behavior. Anyways
> this is a very common pattern in kernel.
> 
> > 
> > I have no strong opinion and maybe my humble taste is too peculiar.  But, if
> > this is not a blocker for tlb flushes batcing, I'd like to suggest keep this
> > part as is for now, and revisit for more code cleanup later.  What do you
> > think, Shakeel?
> > 
> 
> Squashing patches 5 to 8 into one is the main request from me. My other
> suggestion you can ignore but let's see what other says.

Makes sense.  Thank you for your inputs :)


Thanks,
SJ

