Return-Path: <linux-kernel+bounces-405181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D52B9C4DFD
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 05:58:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D11EC1F24D9A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 04:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04A72208217;
	Tue, 12 Nov 2024 04:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="C7KO0ZfC"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5AE4C91
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 04:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731387518; cv=none; b=f7ydEfhV0sOOVpjj4sjAPATtwI07tRR19s6/U/etFfBoESDzqAwiRLIm1Gco12FpLnnLE8GMAXCx3z4DK4bRAyChqrnSe4jI7aSvdodtqlEKD2sJ0tfSmKUUq81r4dB+grHE+AJu9huUBhwNu2bS77ZRoT4wUb0BFh6QMx+uY4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731387518; c=relaxed/simple;
	bh=KUJ9RZoVyyhR24B1mFeElVHLDCrBa1k4L+FmU8LgQps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ek7KztPNBXjs5O//NeCwOe91TiW0pKeVnIuEez0ytWP2S/Ap42h8Mpfhp24Q/L3drhUjsT74Y+7g5N9I78xOiGoSRCevryIGGH4ZQ6gCOHtP1EPDk/+JC657UIHjrLYrXCI1BzetRrogqdptLwaJlz3hBltvnOIgFquZMHOvSxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=C7KO0ZfC; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=kXv1wKhPRyR2M0MWYjkijB14RxzA9Z0quwJXGJzEUa0=; b=C7KO0ZfChbwhN+d0USEvOx+vSV
	fTG0TgXml+ZpjSkyIXpLGLnpfir7j+3QfvCzaul5kXHRDLv3NBubh4JrEKJV5ZRF6vKK3VVotmBww
	qHfqWGKeEQZLDvpHarOMXbGxVUl1yT7aMbf3WKTOymBlL4sIw++3L8bRriUKZOc0gaOo/1OY3qPm4
	GgA2QCsT0kn0znpY8f9MBRNA2v3TKAg59xbHkaz+3dUdtgCG4iwnIpkdZiyzj66LpT+AGy+Tse247
	tqpgQniABaQbNeARe+EEB22J1/HEizNSEsMYavL877imTLc1yL711oihmH7Nj8ypkLPbJpzm6LWPw
	mvMms76Q==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tAiyj-0000000Dr6c-1tTt;
	Tue, 12 Nov 2024 04:58:13 +0000
Date: Tue, 12 Nov 2024 04:58:13 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, liam.howlett@oracle.com,
	lorenzo.stoakes@oracle.com, mhocko@suse.com, vbabka@suse.cz,
	hannes@cmpxchg.org, mjguzik@gmail.com, oliver.sang@intel.com,
	mgorman@techsingularity.net, david@redhat.com, peterx@redhat.com,
	oleg@redhat.com, dave@stgolabs.net, paulmck@kernel.org,
	brauner@kernel.org, dhowells@redhat.com, hdanton@sina.com,
	hughd@google.com, minchan@google.com, jannh@google.com,
	shakeel.butt@linux.dev, souravpanda@google.com,
	pasha.tatashin@soleen.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH 3/4] mm: replace rw_semaphore with atomic_t in vma_lock
Message-ID: <ZzLgZTH9v5io1Elx@casper.infradead.org>
References: <20241111205506.3404479-1-surenb@google.com>
 <20241111205506.3404479-4-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241111205506.3404479-4-surenb@google.com>

On Mon, Nov 11, 2024 at 12:55:05PM -0800, Suren Baghdasaryan wrote:
> When a reader takes read lock, it increments the atomic, unless the
> top two bits are set indicating a writer is present.
> When writer takes write lock, it sets VMA_LOCK_WR_LOCKED bit if there
> are no readers or VMA_LOCK_WR_WAIT bit if readers are holding the lock
> and puts itself onto newly introduced mm.vma_writer_wait. Since all
> writers take mmap_lock in write mode first, there can be only one writer
> at a time. The last reader to release the lock will signal the writer
> to wake up.

I don't think you need two bits.  You can do it this way:

0x8000'0000 - No readers, no writers
0x1-7fff'ffff - Some number of readers
0x0 - Writer held
0x8000'0001-0xffff'ffff - Reader held, writer waiting

A prospective writer subtracts 0x8000'0000.  If the result is 0, it got
the lock, otherwise it sleeps until it is 0.

A writer unlocks by adding 0x8000'0000 (not by setting the value to
0x8000'0000).

A reader unlocks by adding 1.  If the result is 0, it wakes the writer.

A prospective reader subtracts 1.  If the result is positive, it got the
lock, otherwise it does the unlock above (this might be the one which
wakes the writer).

And ... that's it.  See how we use the CPU arithmetic flags to tell us
everything we need to know without doing arithmetic separately?


