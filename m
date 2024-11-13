Return-Path: <linux-kernel+bounces-408310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A6369C7D3E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 22:00:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D92BB1F22F4D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 21:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 935412071EA;
	Wed, 13 Nov 2024 20:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Pv2qApiY"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819BE15AAC1
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 20:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731531595; cv=none; b=OwTAMdM5jY8F/HO3cJzK6bmQRBtabiSOtvHYqanQMJVbBwkeSuddLLeQ4laKkjYe0b4NPmN1ATmfqdK6bdZeJZyrmbTIzfD9cvwqdGhE0S9HgWHJJY+/jxna8zTx61fPB2wA9uz7pA7kjrgg9xx8MTvVZexfWkUrR/Yk91W2Sdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731531595; c=relaxed/simple;
	bh=JV9d4OxHq8DF19Ig3LOAHi+UDRd9l+5H0TQegziFWu8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pEr5oJdUQs5ck702KSiq/EP1rrpOnQ3yVIxet35OVFJDoTm9hQlG5CMUpPOpvYfDPIJBi4pnA1s8JZ6OU8XzR/26uRpiBbN2v3gjRxpgjkVFGZG+SGVCSOqWCT7l+n1wXJ23GyMO/HW4sUDtDA2xU+z+onY1vtV8xFmsqOTGkBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Pv2qApiY; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=aHGuDlZRisdoNDSarEu2LBMMNAO3kh9oosx8hsw2E9Q=; b=Pv2qApiYjDXW0e8taPsKhWAOyy
	qihnh7YOuwFqILEkCe3IsSTuw7w9pVuQP2yFIObfEqTDtvIylguslQn6PfyuQ0sSzkEftmCCM6pzL
	bDmNQGYTud88KLTg6dE0l2Xlpw1gMTGufuOnRSgZ8lLTzW/bxJ5JsHZ8K14bu5/dK7VDjPh4Kz+eo
	WxLnaHWIBhz3Wiclmj8B+81wIy5BAjq77DnwW8JpMxR1ZhnCh7bmjAPXLm0VEPjKi9qRElSr0yAaq
	Yvy81aRmfgcKXVALnq/s++Sl9kMWg6piWpzUL3zNWYWfefk55Jkr1bLonuNBkSLpcyJGbefCmyDmn
	epKDGS0w==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tBKSa-0000000GvXK-0xwA;
	Wed, 13 Nov 2024 20:59:32 +0000
Date: Wed, 13 Nov 2024 20:59:31 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Jann Horn <jannh@google.com>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org,
	lorenzo.stoakes@oracle.com, mhocko@suse.com, hannes@cmpxchg.org,
	mjguzik@gmail.com, oliver.sang@intel.com,
	mgorman@techsingularity.net, david@redhat.com, peterx@redhat.com,
	oleg@redhat.com, dave@stgolabs.net, paulmck@kernel.org,
	brauner@kernel.org, dhowells@redhat.com, hdanton@sina.com,
	hughd@google.com, minchan@google.com, shakeel.butt@linux.dev,
	souravpanda@google.com, pasha.tatashin@soleen.com,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	kernel-team@android.com
Subject: Re: [PATCH v2 4/5] mm: make vma cache SLAB_TYPESAFE_BY_RCU
Message-ID: <ZzUTMw-RajUTcOgS@casper.infradead.org>
References: <20241112194635.444146-1-surenb@google.com>
 <20241112194635.444146-5-surenb@google.com>
 <54b8d0b9-a1c7-4c1b-a588-2e5308a977fb@suse.cz>
 <sdfh56itaffzhpk4rft2tsjm7r44auhjomfthzgxzrmj5632eq@noi2uhgp3a3h>
 <ZzSwM5qwStadOZvv@casper.infradead.org>
 <k26pa6fhn2j6bgfwtcdp6u5vk25mkclitzvqqeqvji77k4lqop@yowwrqusmdyp>
 <CAG48ez29OcD=NL0EqW3hO+3VNzkZce5REcYev5-M09-_HOqsDA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez29OcD=NL0EqW3hO+3VNzkZce5REcYev5-M09-_HOqsDA@mail.gmail.com>

On Wed, Nov 13, 2024 at 05:44:00PM +0100, Jann Horn wrote:
> Something like NULL or (void*)1 is fine with me but please don't do
> pointer-to-itself - we shouldn't unnecessarily store a pointer to an
> object of one type in a pointer field of an incompatible type, that
> increases the risk of creating type confusion issues (both in the
> memory corruption sense and in the Spectre sense). I know MM already
> has several places where similar stuff can happen (in particular
> page->mapping), but here it seems like unnecessary risk to me.

Hm?  I don't think page->mapping can ever point at page.  As far as I
know, we have four cases, discriminated by the bottom two bits:

0 - NULL or address_space
1 - anon_vma
2 - movable_ops
3 - ksm_stable_node

In fact, we're almost done eliminating page->mapping.  Just a few
filesystems and device drivers left to go.

Would it be halpful if we did:

-	struct address_space *mapping;
+	union {
+		struct address_space *mapping;
+		unsigned long raw_mapping;
+	};

and had non-filesystems use raw_mapping and do the masking?

