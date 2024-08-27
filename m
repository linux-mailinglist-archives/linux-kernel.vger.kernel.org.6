Return-Path: <linux-kernel+bounces-304094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A4207961A26
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 00:51:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 238841F247F6
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 22:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 628281D417D;
	Tue, 27 Aug 2024 22:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="sJrWBI2F"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ABC01714BC
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 22:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724799087; cv=none; b=deNXebhQySTDcbMHoDr+eR0NQrrOepDfSAakYEsed19wLNQtIpUPYJarPbqFaO5g6Qc0U3/3Vaev4PF8a35Q44T2dPA8xQTkFLp8ZUaRCGg5A9Om+G/WZn9wqylxT4QahXfzvAngNNg0zTF9fV70yX28e1pOeOIh9YCZdO5MPYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724799087; c=relaxed/simple;
	bh=uZEV6Er55Y1nv1xBlG+kUchSJelI/Jfm4FIRafbGjV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JEVxf+w1OncqLWB06TrlZwKWQzuaUeMiYMgM1rU0nJHwevYVnUEda8qvhU8Pigv2GBCaeaGh9jjuDPu4EU5DBL9/rClWijO7OabtUL04LTkS+viYKpMBQVEGIwRbgI/OB1oX3WcVJ/7tYi1Sh7LQIRcU7cEPfkMJkwqaswGyYRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=sJrWBI2F; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20227ba378eso55008935ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 15:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1724799085; x=1725403885; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GJGHZxh5R6ZTtzzS/6NHcFwTfwgCDmdEBZWgyIzoMVk=;
        b=sJrWBI2FJL5ddMRADH+qo3A+SmTzsmuUmxnq6ndGO4pxZQFlS5VB+0sWQJDf1j1YF9
         cnSFDgsnTkdVrQ3UEMKvf2+mZBQ6qwuu2aP6vpS7Ac2qIIRXLDsUIaeWYZdGonuH/lxQ
         OHTeWtS4/Lzp2DFNMWw3dljnviTQ88zIZ5ZcHqzWz90bORq8ewtUD5W5rcOycr2Ar4gv
         4uhBqYAbuIGEi8LAg2DCpsQe9QKyH05+lb/DWQYXLvdwNfo5QSQMhWzPw0jbtG/HbqtL
         9dwFZT89JGwPkXy0/gzhxDmKFoKXnWYScQBclRcBm2nP2j7NCvXjDvptjjEgeoMqYG1F
         NHfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724799085; x=1725403885;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GJGHZxh5R6ZTtzzS/6NHcFwTfwgCDmdEBZWgyIzoMVk=;
        b=NUHnLrJhQGtLZKz9I1q+xFlW4zlUeAMlsKLEi8NP8btmUfUz3uVFky3OpFdsdsLdPE
         wPe3SMLUFCEQXaI4XgFdbc45VPa9e54k9wRNeGlmyKGoqa6T6MQia6ss/bgIUkBs/wV8
         t0YAUbw+Ln6/BNNSvz25Yi90TzJUQmcPwjj7aPKWi18bWnXebCfgZCFvxV5gp3F64UVA
         hEjBU6MXg/32+PgjIiC4rD68HB/x3aZ/UBmvU3x6B/e/D+1GNhQiJcctTqvUHHQCDFOm
         yoOcojDa3rCPwZmcobjlC7wjbRU9xEj0ulQ+bVS35lnEHsVd2lMZWMlKp8J7hviWv9VH
         TTfw==
X-Forwarded-Encrypted: i=1; AJvYcCW9iUUi5ZuJ2sX9uMRJ4eVlL9hbF9+oNFOruVBwhwCTh/Tuix5+YL59ve5GQ5HMpAbN+vi4RHoyJ+oiBbQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAQY/bWmdfWN2bwjjfK/ZxpsOsEoUY0qx4B17ViaIDGtmwrG2x
	BDCGZ+YkKo4DqI0RzMPSxYSyn39O5ZE8Ip9uJECIhZwqm2GH3BGF8OavkQjLnDuOohYJgC+1ffK
	Q
X-Google-Smtp-Source: AGHT+IFtWGzsf+t9jppqitVe4iRyVZpKNl+Rv44cEroZBBCOkbsjRtNxvNObXq1JQJhWQRM7TkpVTg==
X-Received: by 2002:a17:903:244c:b0:203:a156:54af with SMTP id d9443c01a7336-203a15655dcmr223343795ad.17.1724799085373;
        Tue, 27 Aug 2024 15:51:25 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-0-65.pa.nsw.optusnet.com.au. [49.179.0.65])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-203855dbf79sm87443545ad.125.2024.08.27.15.51.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 15:51:24 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1sj522-00F3c9-04;
	Wed, 28 Aug 2024 08:51:22 +1000
Date: Wed, 28 Aug 2024 08:51:21 +1000
From: Dave Chinner <david@fromorbit.com>
To: Christoph Hellwig <hch@lst.de>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Chandan Babu R <chandan.babu@oracle.com>,
	Matthew Wilcox <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 4/5] xfs: convert perag lookup to xarray
Message-ID: <Zs5Yac5V0pbz1PMF@dread.disaster.area>
References: <20240821063901.650776-1-hch@lst.de>
 <20240821063901.650776-5-hch@lst.de>
 <20240821162810.GF865349@frogsfrogsfrogs>
 <20240822034548.GD32681@lst.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240822034548.GD32681@lst.de>

On Thu, Aug 22, 2024 at 05:45:48AM +0200, Christoph Hellwig wrote:
> On Wed, Aug 21, 2024 at 09:28:10AM -0700, Darrick J. Wong wrote:
> > On Wed, Aug 21, 2024 at 08:38:31AM +0200, Christoph Hellwig wrote:
> > > Convert the perag lookup from the legacy radix tree to the xarray,
> > > which allows for much nicer iteration and bulk lookup semantics.
> > 
> > Looks like a pretty straightforward covnersion.  Is there a good
> > justification for converting the ici radix tree too?  Or is it too
> > sparse to be worth doing?
> 
> radix trees and xarrays have pretty similar behavior related to
> sparseness or waste of interior nodes due to it. 

And the node size is still 64 entries, which matches up with inode
chunk size. Hence a fully populated and cached inode chunk fills
xarray nodes completely, just like the radix tree. Hence if our
inode allocation locality decisions work, we end up with good
population characteristics in the in-memory cache index, too.

> So unless we find a
> better data structure for it, it would be worthwhile.

I have prototype patches to convert the ici radix tree to an xarray.
When I wrote it a few months ago I never got the time to actually
test it because other stuff happened....

> But the ici radix tree does pretty funny things in terms of also
> protecting other fields with the lock synchronizing it, so the conversion
> is fairly complicated

The locking isn't a big deal - I just used xa_lock() and xa_unlock()
to use the internal xarray lock to replace the perag->pag_ici_lock.
This gives the same semantics of making external state and tree
state updates atomic.

e.g. this code in xfs_reclaim_inode():

	spin_lock(&pag->pag_ici_lock);
	if (!radix_tree_delete(&pag->pag_ici_root,
			       XFS_INO_TO_AGINO(ip->i_mount, ino)))
		ASSERT(0);
	xfs_perag_clear_inode_tag(pag, NULLAGINO, XFS_ICI_RECLAIM_TAG);
	spin_unlock(&pag->pag_ici_lock);

becomes:

	xa_lock(&pag->pag_icache);
	if (__xa_erase(&pag->pag_icache,
			XFS_INO_TO_AGINO(ip->i_mount, ino)) != ip)
		ASSERT(0);
	xfs_perag_clear_inode_tag(pag, NULLAGINO, XFS_ICI_RECLAIM_TAG);
	xa_unlock(&pag->pag_icache);

so the clearing of the XFS_ICI_RECLAIM_TAG in the mp->m_perag tree
is still atomic w.r.t. the removal of the inode from the icache
xarray.

> and I don't feel like doing it right now, at least
> no without evaluating if for example a rthashtable might actually be
> the better data structure here.  The downside of the rthashtable is
> that it doens't support tags/masks and isn't great for iteration, so it
> might very much not be very suitable.

The rhashtable is not suited to the inode cache at all. A very
common access pattern is iterating all the inodes in an inode
cluster (e.g. in xfs_iflush_cluster() or during an icwalk) and with
a radix tree or xarray, these lookups all hit the same node and
cachelines. We've optimised this into gang lookups, which means
all the inodes in a cluster are fetched at the same time via
sequential memory access.

Move to a rhashtable makes this iteration mechanism impossible
because the rhashtable is unordered. Every inode we look up now
takes at least one cacheline miss because it's in some other
completely random index in the rhashtable and not adjacent to
the last inode we lookuped up. Worse, we have to dereference each
object we find on the chain to do key matching, so it's at least two
cacheline accesses per inode lookup.

So instead of a cluster lookup of 32 inodes only requiring a few
cacheline accesses to walk down the tree and then 4 sequential
cacheline accesses to retreive all the inode pointers, we have at
least 64 individual random cacheline accesses to get the pointers to
the same number of inodes.

IOWs, a hashtable of any kind is way more inefficient than using the
radix tree or xarray when it comes to the sorts of lockless
sequential access patterns we use internally with the XFS inode
cache.

Keep in mind that I went through all this "scalable structure
analysis" back in 2007 before I replaced the hash table based inode
cache implementation with radix trees. Radix trees were a far better
choice than a hash table way back then, and nothing in our inode
cache access patterns and algorithms has really changed since
then....

-Dave.
-- 
Dave Chinner
david@fromorbit.com

