Return-Path: <linux-kernel+bounces-265062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 805C193EC08
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 05:52:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 363EF1F221AD
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 03:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFD4181AC7;
	Mon, 29 Jul 2024 03:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fRCewtFc"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA5C81219
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 03:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722225164; cv=none; b=SyhAYt2TIwfaFGdTlaNqOcY8JnxPkt1TQ/zJAvlujoMSWU16AdyoJCa8giyNM3/GliKOjeYMRXkb8UlvQCmgjwbwQKLAS6XBQewxuFzp2cTsr46HK2HJO0VKL+tlN/Z2YiQyQpKzpEvn57zT7HmrxxccLCp3GVBlqCPh5FNKXac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722225164; c=relaxed/simple;
	bh=cU9rLqWI7qINEtYwqZnJQdaKYqaME+oyJWzitLVQotA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UefNbgu7iKJBvJ6FUguKsMNDa7Dv39ZcZ1Op5l9cLH7NAEidoEDs2cCr1r3JHz87OSCeGkNgeCXmKKiSttX5HKVtaItrAlfa8Td/p0QhUNFCQX2Mwi8NOISys7rOmXzN29Ty7aV+YTnoeVcA1QGVTm/U3IQybJXvKpJ6sAIUeOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=fRCewtFc; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=s8FgCUKnjCBNDZ8KtrzbkSupmKxVrM0fUmUeYtnKteQ=; b=fRCewtFc4GnjMM8AJr8h7cyDzq
	pxif6iv75KL3lQ4bmXcTzOOhskPpuNUsB7tHBLwpMtYJvceqwkbeB7HWEpOqqXBKDcB+RHCtDRd9c
	c4KZH3wa3rKt54xSlA01iTzBzZSa8olj7bWpLGnoGSlit9rZaOb8KYzA6qqWePe89AdbiPx/yCb0/
	0qvcv8f8CDVN2eKNUxwFFmgU8FjdkALaePZWcU6QMfhb7PULPoLRksa/eFRwvrzfeT9KN/I7WlKgN
	iJigB9lK55DOPlnWCQdig0CajHBOwVsTKTI/3n6CvjI8uGnK2IeE9kGKaI7Q5rbQBWcJNgL852mJz
	TPASi+PQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sYHR0-0000000D81o-0yTB;
	Mon, 29 Jul 2024 03:52:30 +0000
Date: Mon, 29 Jul 2024 04:52:30 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, ying.huang@intel.com,
	baolin.wang@linux.alibaba.com, chrisl@kernel.org, david@redhat.com,
	hannes@cmpxchg.org, hughd@google.com, kaleshsingh@google.com,
	kasong@tencent.com, linux-kernel@vger.kernel.org, mhocko@suse.com,
	minchan@kernel.org, nphamcs@gmail.com, ryan.roberts@arm.com,
	senozhatsky@chromium.org, shakeel.butt@linux.dev,
	shy828301@gmail.com, surenb@google.com, v-songbaohua@oppo.com,
	xiang@kernel.org, yosryahmed@google.com
Subject: Re: [PATCH v5 4/4] mm: Introduce per-thpsize swapin control policy
Message-ID: <ZqcR_oZmVpi2TrHO@casper.infradead.org>
References: <20240726094618.401593-1-21cnbao@gmail.com>
 <20240726094618.401593-5-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240726094618.401593-5-21cnbao@gmail.com>

On Fri, Jul 26, 2024 at 09:46:18PM +1200, Barry Song wrote:
> A user space interface can be implemented to select different swap-in
> order policies, similar to the mTHP allocation order policy. We need
> a distinct policy because the performance characteristics of memory
> allocation differ significantly from those of swap-in. For example,
> SSD read speeds can be much slower than memory allocation. With
> policy selection, I believe we can implement mTHP swap-in for
> non-SWAP_SYNCHRONOUS scenarios as well. However, users need to understand
> the implications of their choices. I think that it's better to start
> with at least always never. I believe that we will add auto in the
> future to tune automatically, which can be used as default finally.

I strongly disagree.  Use the same sysctl as the other anonymous memory
allocations.

