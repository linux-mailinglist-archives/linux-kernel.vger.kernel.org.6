Return-Path: <linux-kernel+bounces-419275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB719D6BA9
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 22:35:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 967692819E3
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 21:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79A2C19AA58;
	Sat, 23 Nov 2024 21:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EDJg8xsV"
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B54CEADC
	for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2024 21:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732397733; cv=none; b=irUnZiBtpnFovpnnr4wX+bW8pWHzBIAoz1eBGt1UKCavMwFSzBfkZfbJXTKqjT5qCJCZzBi2kdaO+LMn26Cyz4yw/NCNnJv5hnQSAPvLA8HH9GM5DA6Cmn/TdhZvJpcxxa1ygwjgc1CzbtHqlzCylplumnigU92prBMBVryF/z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732397733; c=relaxed/simple;
	bh=Z+uNhX53sVaYCcTI9owtqEs6w1MaEFmKys3h/NSoXpI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yq/Lcw8p57TvajT2WCKA0bXBku2836P1tTcXuWRc6tg7XHvJum/5hM48oI8eDOyXA+X6YCL/mZhz0HTMJZ3zBhG5XbRxY/9KxozziBY8gLTJYFUbFGw0LIdHsjPkcfCVLsWN6wJuDkZCp/4/fkrsW0wdOgzbSt/GKYmw57hqWjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EDJg8xsV; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 23 Nov 2024 13:35:24 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1732397729;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zKxGTUmS4dcKGQY0jjq321pdX2jaD19pGhWKPewS3bE=;
	b=EDJg8xsVJwYmr/wh/pu9cmlYQKYBUvtoJ+fitNPChNy4h0aMfZKTY+yQ4/nVDbBXOIDzDo
	G6gYk7Wvx+2PMYBhw9DtwJZCfoyeenad0lOg7pOg7zxyuisVFs9L5v8lCaThj1kj1A9QZm
	IAAz0wm/rUhTZU94ONkm9efwQLH8pzI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Vlastimil Babka <vbabka@suse.cz>, Axel Rasmussen <axelrasmussen@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH] mm: mmap_lock: optimize mmap_lock tracepoints
Message-ID: <i3joc4vme76imq2etk7gjfntsy2z5l5niyqobeun5e7m6jh4yi@adwzrxbvuc6l>
References: <20241123060939.169978-1-shakeel.butt@linux.dev>
 <Z0IKhWfOr4ppnQem@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z0IKhWfOr4ppnQem@casper.infradead.org>
X-Migadu-Flow: FLOW_OUT

On Sat, Nov 23, 2024 at 05:01:57PM +0000, Matthew Wilcox wrote:
> On Fri, Nov 22, 2024 at 10:09:39PM -0800, Shakeel Butt wrote:
> >  	TP_printk(
> > -		"mm=%p memcg_path=%s write=%s",
> > -		__entry->mm,
> > -		__get_str(memcg_path),
> > +		"mm=%p memcg_id=%llu write=%s",
> > +		__entry->mm, __entry->memcg_id,
> >  		__entry->write ? "true" : "false"
> 
> Is it actually useful to print out the (hashed) pointer of the mm?
> Wouldn't the PID be more useful so you could actually associate it with
> a task?
> 

For our usecase i.e. bpftrace, we don't really care about these prints
as we can directly access the arguments like mm in bpftrace. I wonder if
others are using this hased pointer in some other way. I don't mind
chaning it but I think that would be a separate patch.

