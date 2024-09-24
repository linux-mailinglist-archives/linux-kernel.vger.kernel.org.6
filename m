Return-Path: <linux-kernel+bounces-336450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD4F3983B03
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 03:55:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C5891F2302B
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 01:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 895EB8F49;
	Tue, 24 Sep 2024 01:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aO0tSfN4"
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D77938C
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 01:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727142920; cv=none; b=NEJU1m8g6sJoa7/6MZAKcq8Sgeu/WIflR4GYHGuVdg9+hBkvl/Ig/HolSpI4ATrL+Dm2KtUdvgCZwSxwHwUvJnUkGKKZdj+bbtduQdWj2NhwCqxWuxCS+8Hwpju8nXm2YQUdR5PBb9G0QZBa0V7rMVAG90faxXS5P943p8o3fvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727142920; c=relaxed/simple;
	bh=Sc71BkRLfCBqVpCP+o2wncwSaYE3lC0Q0jV8ULOXTjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OmdQ43Ug8Fv7gwHFYL1qR6RNcX5MjrYi+DAMsTMtSPmX08MOD6JrhRoi9sKapKQ2vKHKauTa1vKGBAhhZa45Cp+FVDPqsInwnA5shw1pI8W5o7ft/f/8Tv5cxWYTgPUlf94gpWJSxwPWLESsY+NeQ8d0FgjyetEd1ENWt+CmiBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aO0tSfN4; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 23 Sep 2024 21:55:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1727142916;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pR5RK0YvQc1KSwqY8lWXGQUTZLyx4J/IMgSUde5kNws=;
	b=aO0tSfN4RdKAlRni+fHjYeZ/nLLcK3LNYmNjQYygCD3DNnBjUA/MM8z9Du21ZJWNNWTBpC
	7OEg+l6c+YqcqqbDHqS/lA1rgTsOi/O+kfeh5o03k66ZjdyWhE7NKy2eCZIo9ZLuvG1e3e
	8CNSrffYvsC+qP45Y+1XFSJZukksZ58=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Dave Chinner <david@fromorbit.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Dave Chinner <dchinner@redhat.com>
Subject: Re: [GIT PULL] bcachefs changes for 6.12-rc1
Message-ID: <xxxxcj5ijhcvluoqybzdrwfthigbq5t7r6q4nypbubr2rlcvst@hrhg5gxqmgyn>
References: <dtolpfivc4fvdfbqgmljygycyqfqoranpsjty4sle7ouydycez@aw7v34oibdhm>
 <CAHk-=whQTx4xmWp9nGiFofSC-T0U_zfZ9L8yt9mG5Qvx8w=_RQ@mail.gmail.com>
 <6vizzdoktqzzkyyvxqupr6jgzqcd4cclc24pujgx53irxtsy4h@lzevj646ccmg>
 <ZvIHUL+3iO3ZXtw7@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZvIHUL+3iO3ZXtw7@dread.disaster.area>
X-Migadu-Flow: FLOW_OUT

On Tue, Sep 24, 2024 at 10:26:56AM GMT, Dave Chinner wrote:
> On Mon, Sep 23, 2024 at 03:56:50PM -0400, Kent Overstreet wrote:
> > On Mon, Sep 23, 2024 at 10:18:57AM GMT, Linus Torvalds wrote:
> > > On Sat, 21 Sept 2024 at 12:28, Kent Overstreet
> > > <kent.overstreet@linux.dev> wrote:
> > > >
> > > > We're now using an rhashtable instead of the system inode hash table;
> > > > this is another significant performance improvement on multithreaded
> > > > metadata workloads, eliminating more lock contention.
> > > 
> > > So I've pulled this, but I reacted to this issue - what is the load
> > > where the inode hash table is actually causing issues?
> > > 
> > > Because honestly, the reason we're using that "one single lock" for
> > > the inode hash table is that nobody has ever bothered.
> > > 
> > > In particular, it *should* be reasonably straightforward (lots of
> > > small details, but not fundamentally hard) to just make the inode hash
> > > table be a "bl" hash - with the locking done per-bucket, not using one
> > > global lock.
> > 
> > Dave was working on that - he posted patches and it seemed like they
> > were mostly done, not sure what happened with those.
> 
> I lost interest in that patchset a long while ago. The last posting
> I did was largely as a community service to get the completed,
> lockdep and RTPREEMPT compatible version of the hashbl
> infrastructure it needed out there for other people to be able to
> easily push this forward if they needed it. That was here:
> 
> https://lore.kernel.org/linux-fsdevel/20231206060629.2827226-1-david@fromorbit.com/
> 
> and I posted it because Kent was asking about it because his
> attempts to convert the inode hash to use rhashtables wasn't
> working.
> 
> I've suggested multiple times since then when people have asked me
> about that patch set that they are free to pick it up and finish it
> off themselves. Unfortunately, that usually results in silence, a
> comment of "I don't have time for that", and/or they go off and hack
> around the issue in some other way....

Looking over that thread I'm not clear on what was missing - you
mentioned RTPREEMPT/lockdep but you had a patch for that, which looked
servicable enough?

