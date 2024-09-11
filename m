Return-Path: <linux-kernel+bounces-325679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DB00975D0E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 00:21:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5828A2847CB
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 22:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60CDB1BB68F;
	Wed, 11 Sep 2024 22:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pMVATVqj"
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4079D1B9B33
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 22:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726093251; cv=none; b=eOcQOABbs/RR+OZjZnFtkCxiXoNG8SAW8WUbqu1Qd7qNuvX4284qRl3w+0/QwvCyR7mmXgn9XzgabzkP7jw6MA4c54t1UDL8c7VT/GzXHR0e5jc1sRsgME3FzkngXmcCmjAWgqJ/+Tdrv2J9xuD5PqE5puiF41f6cEayqMx8QF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726093251; c=relaxed/simple;
	bh=At3KN1vJHe3HfQKgM616/sxJCeR4JS3rf/XzFOCz+Og=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GP0QXWUVbGcfef9lvFiHbdpWHSG5mZdu1BhUZCWNHNwfYN+hYT+PfoZW9LPxenh4+iqs4uprMIfSZQSqOoQ5MkuowJ9URFQ3CTeBfqPgv1NlpJh5jxZUqegJH8lIHus21Hqb33w3PQSsIDSAZFUZQJ9GPAzxQSQps8PoUPFl6fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pMVATVqj; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 11 Sep 2024 15:20:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1726093246;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+MlZ0mawDlEwUZp7Ryvv2HfbC6bAGFXeox7y/af6rjw=;
	b=pMVATVqjn2sWMKvjniszDv5T2Of5AaOmG2EmPyXwBXqWjBIBYTzaorch1TZ51gv/2oBYMh
	VdIiOs6cErsW9q1Z0utKsnhO0fR7HrZQo8hl4F+HRA88OxKe22o6LxP6pi5Bn3OPRsRLIa
	lA5/saYfi/jNkOZZ5liAM1+3bHYLHkU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Matthew Wilcox <willy@infradead.org>, Omar Sandoval <osandov@osandov.com>, Chris Mason <clm@fb.com>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Meta kernel team <kernel-team@meta.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm: optimize truncation of shadow entries
Message-ID: <3xy45w5enrkvnyvxwufxfgzmpmii6au4o6wbepqkl5qfiygizc@2c4b7jcs676y>
References: <20240911173801.4025422-1-shakeel.butt@linux.dev>
 <20240911173801.4025422-2-shakeel.butt@linux.dev>
 <20240911210824.GA117602@cmpxchg.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240911210824.GA117602@cmpxchg.org>
X-Migadu-Flow: FLOW_OUT

On Wed, Sep 11, 2024 at 05:08:24PM GMT, Johannes Weiner wrote:
> On Wed, Sep 11, 2024 at 10:38:00AM -0700, Shakeel Butt wrote:
> > The kernel truncates the page cache in batches of PAGEVEC_SIZE. For each
> > batch, it traverses the page cache tree and collects the entries (folio
> > and shadow entries) in the struct folio_batch. For the shadow entries
> > present in the folio_batch, it has to traverse the page cache tree for
> > each individual entry to remove them. This patch optimize this by
> > removing them in a single tree traversal.
> > 
> > On large machines in our production which run workloads manipulating
> > large amount of data, we have observed that a large amount of CPUs are
> > spent on truncation of very large files (100s of GiBs file sizes). More
> > specifically most of time was spent on shadow entries cleanup, so
> > optimizing the shadow entries cleanup, even a little bit, has good
> > impact.
> > 
> > To evaluate the changes, we created 200GiB file on a fuse fs and in a
> > memcg. We created the shadow entries by triggering reclaim through
> > memory.reclaim in that specific memcg and measure the simple truncation
> > operation.
> > 
> >  # time truncate -s 0 file
> > 
> >               time (sec)
> > Without       5.164 +- 0.059
> > With-patch    4.21  +- 0.066 (18.47% decrease)
> > 
> > Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> 
> Looks good to me. One thing that's a bit subtle is that the tree walk
> assumes indices[] are ordered, such that indices[0] and indices[nr-1]
> reliably denote the range of interest. AFAICS that's the case for the
> current callers but if not that could be a painful bug to hunt down.

The current callers use find_get_entries() and find_lock_entries() to
fill up the indices array which provides this guarantee.

> 
> Assessing lowest and highest index in that first batch iteration seems
> a bit overkill though. Maybe just a comment stating the requirement?

I will add a comment in v2.

> 
> Otherwise,
> 
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Thanks for the review.

