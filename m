Return-Path: <linux-kernel+bounces-195850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CCCF8D52CA
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 22:04:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0780E285D10
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 20:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F6415588B;
	Thu, 30 May 2024 20:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="e2f1bkq9"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB98F74040
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 20:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717099464; cv=none; b=KRNOz58zroGKzsDyycNQq0ALypMyIUcT1UcJWTwQGtI8tVoSgEuA/VzDl0JA+8LqXNt/8Q6BLXaK2LE3/X3J0NOb1SSCfeY/VR9ZCg7dJ7qTMUd31nZNYCoGzoDCkL1ovTctb+KpbUzJcAwLI7LLPSGNTg6d3a5RsO+85twSDFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717099464; c=relaxed/simple;
	bh=Z3eZx9NDsXnWgYkipyZqSi7f5PAiQBZLb7hkodlWvDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hqgbZvNXaC6uptTAY9PbrTjsD8IoHiGP7cJHibRCINf46XszvQxuelY5yaV3p4Bg3LVho/cY7JsBE/RiUIzTjebc/e7vPZ7qo5QsbN8RdHMtzjpOE5lxdsqOtj0X6J5mGfGZXw9YvseKjjgU+3pbtn6/BG4w9JWqTdMgFru3a+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=e2f1bkq9; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=/bBYT7UwHhY6mRNtfgkO0poVUMVNoTkDOtlF1Z4cO0U=; b=e2f1bkq9uLx1zHBflnppPaiMxj
	tR+yCUYGJP/XdDgupBQXMJjQMTmumVo1XdwR9sW5Uxt4Vj1fxw7llefMQYoc5MLxkh8o9JHsCk9xr
	6bm8mBedCA5W7GA9K69t2NckzSxWpT5qRcyZCfzHEigaeaAMwWdkrHMvSFriTeNacuUkvI9tUFi6F
	rm+EBY3E7mr5xUVqw2AUXnxVPfUocX47U7dsczxJIHllBmfSiJ+CsHUcxQMsZPryLMrkbc7Kn5qNp
	elo7tVXEZ+uKSN8i6UiwOKpv/eSZbz1Lpj+QI14rMMEagjSInP673raxVagl8UqtlQmBSiAEBQ7Lk
	5UyClcwA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCm0W-0000000B7ep-1RqI;
	Thu, 30 May 2024 20:04:16 +0000
Date: Thu, 30 May 2024 21:04:16 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Usama Arif <usamaarif642@gmail.com>, akpm@linux-foundation.org,
	nphamcs@gmail.com, chengming.zhou@linux.dev, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	Hugh Dickins <hughd@google.com>, Huang Ying <ying.huang@intel.com>
Subject: Re: [PATCH 1/2] mm: store zero pages to be swapped out in a bitmap
Message-ID: <ZljbwMj-FNw9TqDV@casper.infradead.org>
References: <20240530102126.357438-1-usamaarif642@gmail.com>
 <20240530102126.357438-2-usamaarif642@gmail.com>
 <20240530122715.GB1222079@cmpxchg.org>
 <CAJD7tkYcTV_GOZV3qR6uxgFEvYXw1rP-h7WQjDnsdwM=g9cpAw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJD7tkYcTV_GOZV3qR6uxgFEvYXw1rP-h7WQjDnsdwM=g9cpAw@mail.gmail.com>

On Thu, May 30, 2024 at 09:24:20AM -0700, Yosry Ahmed wrote:
> I am wondering if it's even possible to take this one step further and
> avoid reclaiming zero-filled pages in the first place. Can we just
> unmap them and let the first read fault allocate a zero'd page like
> uninitialized memory, or point them at the zero page and make them
> read-only, or something? Then we could free them directly without
> going into the swap code to begin with.

I was having similar thoughts.  You can see in do_anonymous_page() that
we simply map the shared zero page when we take a read fault on
unallocated anon memory.

So my question is where are all these zero pages coming from in the Meta
fleet?  Obviously we never try to swap out the shared zero page (it's
not on any LRU list).  So I see three possibilities:

 - Userspace wrote to it, but it wrote zeroes.  Then we did a memcmp(),
   discovered it was zeroes and fall into this path.  It would be safe
   to just discard this page.
 - We allocated it as part of a THP.  We never wrote to this particular
   page of the THP, so it's zero-filled.  While it's safe to just
   discard this page, we might want to write it for better swap-in
   performance.
 - Userspace wrote non-zeroes to it, then wrote zeroes to it before
   abandoning use of this page, and so it eventually got swapped out.
   Perhaps we could teach userspace to MADV_DONTNEED the page instead?

Has any data been gathered on this?  Maybe there are other sources of
zeroed pages that I'm missing.  I do remember a presentation at LSFMM
in 2022 from Google about very sparsely used THPs.

