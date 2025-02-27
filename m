Return-Path: <linux-kernel+bounces-535633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29FA5A47556
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 06:44:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30B8916E98E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 05:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FDEE209F3E;
	Thu, 27 Feb 2025 05:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bfhCq9Jj"
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7711E5210
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 05:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740635080; cv=none; b=BBg37Lqr9nEcIupCsYDcjwQUR4oSjY7sOJqejFdMf7PwUgq47jXywTTH3yFsmpOprCHbhqGZHe0/Lu0ZhGbVk7sHDb59Bjtm+lxSMMZ7L+JOgU+r6tPI06meC8JvxWSXvK8ORt6I3om0CE3NtljeG3FMLgJJQftjAvFcOj1Wnzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740635080; c=relaxed/simple;
	bh=oEo1qjWXwvmV+GAlxNnksywkGBv9YY6iJ2nMcFwsIAk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GFyjTHJT9aw2QmkGmj1M74ZFkmvTI1btd3+AaN12pO01kWsV0fJoAEKNXmyCMAZ11HxQ3J/i63tFQKhYUper1XIYjvAjvhB5KhlvfOP2fhhgz4ImamJhm5yy3a6DXC9VztcbMe67Kge6oBRh8ptKqqqkvZJKqKwh5UjogCn8ovk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bfhCq9Jj; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 27 Feb 2025 05:44:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740635076;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ERFgDI+aEGThEtR4yr1u5l1He+Oh0pNjxy51oH28XYU=;
	b=bfhCq9JjZq9L5aFtZPxk1fa1qWyZuVgIo/bgY4wCBec0FvHVZD4+7CQOHLiM/8JOjP5XE4
	ZqSU7hSJSFYj+4175CeWuu6k7Pwm0mL95991iBSSqqXcTYh+bt42yB13oPbZvGBK6zqCn0
	z01q9dyKNo1dP+EinZcYjqK9dtX6VwQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org,
	chengming.zhou@linux.dev, linux-mm@kvack.org, kernel-team@meta.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] zswap: do not crash the kernel on decompression
 failure
Message-ID: <Z7_7vah_U1JzmpCX@google.com>
References: <20250227001445.1099203-1-nphamcs@gmail.com>
 <Z7-9o81kBfw4tFSz@google.com>
 <20250227043141.GB110982@cmpxchg.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227043141.GB110982@cmpxchg.org>
X-Migadu-Flow: FLOW_OUT

On Wed, Feb 26, 2025 at 11:31:41PM -0500, Johannes Weiner wrote:
> On Thu, Feb 27, 2025 at 01:19:31AM +0000, Yosry Ahmed wrote:
> > On Wed, Feb 26, 2025 at 04:14:45PM -0800, Nhat Pham wrote:
> > >  	if (WARN_ON_ONCE(folio_test_large(folio)))
> > >  		return true;
> > >  
> > > +	entry = xa_load(tree, offset);
> > > +	if (!entry)
> > > +		return false;
> > > +
> > 
> > A small comment here pointing out that we are deliberatly not setting
> > uptodate because of the failure may make things more obvious, or do you
> > think that's not needed?
> >
> > > +	if (!zswap_decompress(entry, folio))
> > > +		return true;
> 
> How about an actual -ev and have this in swap_read_folio():

Good idea, I was going to suggest an enum but this is simpler.

> 
>         ret = zswap_load(folio);
>         if (ret != -ENOENT) {
>                 folio_unlock(folio);
>                 goto finish;
>         }
> 
> 	read from swapfile...
> 
> Then in zswap_load(), move uptodate further up like this (I had
> previously suggested this):
> 
> 	if (!zswap_decompress(entry, folio))
> 		return -EIO;
> 
> 	folio_mark_uptodate(folio);
> 
> and I think it would be clear, even without or just minimal comments.

Another possibility is moving folio_mark_uptodate() back to
swap_read_folio(), which should make things even clearer imo as the
success/failure logic is all in one place:

	ret = zswap_load(folio);
	if (ret != -ENOENT) {
		folio_unlock(folio);
		/* Comment about not marking uptodate */
		if (!ret)
			folio_mark_uptodate();
		goto finish;
	}

or we can make it crystal clear we have 3 distinct cases:

	ret = zswap_load(folio);
	if (!ret) {
		folio_unlock(folio);
		folio_mark_uptodate();
		goto finish;
	} else if (ret != -ENOENT) {
		/* Comment about not marking uptodate */
		folio_unlock(folio);
		goto finish;
	}

WDYT?
		

