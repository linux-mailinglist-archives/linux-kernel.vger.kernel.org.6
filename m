Return-Path: <linux-kernel+bounces-309960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 037C6967275
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 17:46:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 334701C21293
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 15:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B143A3CF7E;
	Sat, 31 Aug 2024 15:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KBl10ThL"
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876DB37143
	for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 15:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725119190; cv=none; b=gkABuaFm9OZb+tkKpQLxboBarHzeIxRe6EsBOONah2xB51aAAkQJOTCVCff+aqU5IuC7fmnq3DNiNl+oP2cjp8sZz0Vkn/J15pGgL+g9bSKglBDNpKcz3IVzwyBPf1yKpG0hUAqZ/Ak6k4EjH6gyufd0NjbtN7Fy9yYTQeCCHeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725119190; c=relaxed/simple;
	bh=sDnjgJhAxHfYmY7V2VSw+91dumqejER0PaCYWnzsgKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ilnYljwGcgIrMjmbcENjRrF24m0/1eYbHqaz5Sy0wu0EHuMv2NlzehOAyhSWcy1x4KAcUxTj0wUsQzF6QG6Ze5POdCEYLyOBJGN7iEzjDF2PGsKXv1t5hc5RpnlKyMt2uomeQC+TaxnGYfxwDrXgxuXEWKDJ1D3ELMtoaL80GFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KBl10ThL; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 31 Aug 2024 11:46:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725119183;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+Ssykqay2fp62kkpmBqa33KeQFdv9PjPfIXcKwkriOA=;
	b=KBl10ThLQ2GKFQK5Kn90cPVgcjPOkabpIBYmNyauDeH8hW1M6e9rGbvyaMZqV/zVLKAcWC
	VohFTDfY9p3UJhRcNjvGrIRsVZzFP4egEW5K85hYJ8iDgdY5H3/22yJ68Hi84/qdPougIm
	4zbqduyRcpZ/osqY3uwnE0FegLfXm54=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Theodore Ts'o <tytso@mit.edu>
Cc: Dave Chinner <david@fromorbit.com>, Michal Hocko <mhocko@suse.com>, 
	Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Dave Chinner <dchinner@redhat.com>
Subject: Re: [PATCH] bcachefs: Switch to memalloc_flags_do() for vmalloc
 allocations
Message-ID: <czqac5lskwgsqoeba54omj5cfjouklnkgti6sl5a5n4kr7r7jv@bts5jicfq2dy>
References: <20240828140638.3204253-1-kent.overstreet@linux.dev>
 <Zs9xC3OJPbkMy25C@casper.infradead.org>
 <gutyvxwembnzaoo43dzvmnpnbmj6pzmypx5kcyor3oeomgzkva@6colowp7crgk>
 <Zs959Pa5H5WeY5_i@tiehlicka>
 <xxs3s22qmlzby3ligct7x5a3fbzzjfdqqt7unmpih64dk3kdyx@vml4m27gpujw>
 <ZtBWxWunhXTh0bhS@tiehlicka>
 <wjfubyrzk4ovtuae5uht7uhhigkrym2anmo5w5vp7xgq3zss76@s2uy3qindie4>
 <ZtCFP5w6yv/aykui@dread.disaster.area>
 <20240830033905.GC9627@mit.edu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240830033905.GC9627@mit.edu>
X-Migadu-Flow: FLOW_OUT

On Thu, Aug 29, 2024 at 11:39:05PM GMT, Theodore Ts'o wrote:
> On Fri, Aug 30, 2024 at 12:27:11AM +1000, Dave Chinner wrote:
> > 
> > We've been using __GFP_NOFAIL semantics in XFS heavily for 30 years
> > now. This was the default Irix kernel allocator behaviour (it had a
> > forwards progress guarantee and would never fail allocation unless
> > told it could do so). We've been using the same "guaranteed not to
> > fail" semantics on Linux since the original port started 25 years
> > ago via open-coded loops.
> 
> Ext3/ext4 doesn't have quite the history as XFS --- it's only been
> around for 23 years --- but we've also used __GFP_NOFAIL or its
> moral equivalent, e.g.:
> 
> > 	do {
> > 		p = kmalloc(size);
> > 	while (!p);
> 
> For the entire existence of ext3.
> 
> > Put simply: __GFP_NOFAIL will be rendered completely useless if it
> > can fail due to external scoped memory allocation contexts.  This
> > will force us to revert all __GFP_NOFAIL allocations back to
> > open-coded will-not-fail loops.
> 
> The same will be true for ext4.  And as Dave has said, the MM
> developers want to have visibility to when file systems have basically
> said, "if you can't allow us to allocate memory, our only alternative
> is to cause user data loss, crash the kernel, or loop forever; we will
> choose the latter".  The MM developers tried to make __GFP_NOFAIL go
> away several years ago, and ext4 put the retry loop back, As a result,
> the compromise was that the MM developers restored __GFP_NOFAIL, and
> the file systems developers have done their best to reduce the use of
> __GFP_NOFAIL as much as possible.
> 
> So if you try to break the GFP_NOFAIL promise, both xfs and ext4 will
> back to the retry loop.  And the MM devs will be sad, and they will
> forcibly revert your change to *ther* code, even if that means
> breaking bcachefs.  Becuase otherwise, you will be breaking ext4 and
> xfs, and so we will go back to using a retry loop, which will be worse
> for Linux users.

GFP_NOFAIL may be better than the retry loop, but it's still not good.

Consider what happens when you have a GFP_NOFAIL in a critical IO path,
when the system is almost exhausted on memory; yes, that allocation will
succeed _eventually_, but without any latency bounds. When you're
thrashing or being fork bombed, that allocation is contending with
everything else.

Much the same way that a lock in a critical path where the work done
under the lock grows when the system is loaded, it's a contention point
subject to catastrophic failure.

Much better to preallocate, e.g. with a mempool, or have some other kind
of fallback.

It might work to do __GFP_NOFAIL|__GFP_HIGH in critical paths, but I've
never seen that investigated or tried.

And this is an area filesystem people really need to be thinking about.
Block layer gets this right, filesystems do not, and I suspect this is a
key contributor to our performance and behaviour sucking when we're
thrashing.

bcachefs puts a lot of effort into making sure we can run in bounded
memory, because I put a lot of emphasiss on consistent performance and
bounded latency, not just winning benchmarks. There's only two
__GFP_NOFAIL allocations in bcachefs, and I'll likely remove both of
them when I get around to it.

