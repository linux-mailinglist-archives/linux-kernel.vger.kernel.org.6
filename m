Return-Path: <linux-kernel+bounces-262628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EF7293C9C2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 22:41:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A5B3284545
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 20:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C419E13CFAD;
	Thu, 25 Jul 2024 20:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="HJazsxFU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112F513C9B8
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 20:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721940092; cv=none; b=sbOrNR8vn+hOgAo0srKFw11R+XgyMzUs+fXAviv8jQg7hCccBTiacEkRAsAhzJhGASWwHYj0nusLyTFaL3iny79RShUrk++BpH4AljXY8ZkLdp+SvU+7kHkP9YnH3INjZBDPy2VWJUcj0qIACgDHa6sR7VzUNJjK1A9glTeELro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721940092; c=relaxed/simple;
	bh=GylSB0ehVQ0HMfG0V+ljKrawupUHp8HdzGA9HwiLfdE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=k6Nvk20/XNqrdXC86lKXgYEprtka0WKZTDb9J8BHRMNtzPCIFQbi6zh3YqbwgYzhNHpNA0+OIb4madfPRRK3mzA7dBdmvCO/YhmzNchTd1UFIFhpGCaPb37Rp8N0tiWpMLhzToCbTnC+d75H34ej/jbKujy58Ps38nNrqTv9qZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=HJazsxFU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23E36C4AF0B;
	Thu, 25 Jul 2024 20:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1721940090;
	bh=GylSB0ehVQ0HMfG0V+ljKrawupUHp8HdzGA9HwiLfdE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HJazsxFUG4W4O32s3nlsSJSVqvdrptb8QHsDJhHF0d3dCy0/KXL/9ysgcpJIhGjHT
	 XSpw5cWg9yTkcp6xcpszxbVsVgwxhC2gw+Eg3dTXhVO3v0JO9ZKDNYcOUlhrfEcXvc
	 ACvEExtrMsCr1qtov9bnEWmN+qbv5845tsqmZw+E=
Date: Thu, 25 Jul 2024 13:41:29 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, Muchun Song
 <muchun.song@linux.dev>, Peter Xu <peterx@redhat.com>, Oscar Salvador
 <osalvador@suse.de>
Subject: Re: [PATCH v1 0/2] mm/hugetlb: fix hugetlb vs. core-mm PT locking
Message-Id: <20240725134129.fc9165ac6413c4f774b786c1@linux-foundation.org>
In-Reply-To: <20240725183955.2268884-1-david@redhat.com>
References: <20240725183955.2268884-1-david@redhat.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 25 Jul 2024 20:39:53 +0200 David Hildenbrand <david@redhat.com> wrote:

> Working on another generic page table walker that tries to avoid
> special-casing hugetlb, I found a page table locking issue with hugetlb
> folios that are not mapped using a single PMD/PUD.
> 
> For some hugetlb folio sizes, GUP will take different page table locks
> when walking the page tables than hugetlb when modifying the page tables.
> 
> I did not actually try reproducing an issue, but looking at
> follow_pmd_mask() where we might be rereading a PMD value multiple times
> it's rather clear that concurrent modifications are rather unpleasant.
> 
> In follow_page_pte() we might be better in that regard -- ptep_get() does
> a READ_ONCE() -- but who knows what else could happen concurrently in
> some weird corner cases (e.g., hugetlb folio getting unmapped and freed).
> 
> Did some basic sanity testing with various hugetlb sizes on x86-64 and
> arm64. Maybe I'll find some time to actually write a simple reproducer in
> the common weeks, so this wouldn't have to be all-theoretical for now.

When can we be confident that this change is merge-worthy?

> Only v6.10 is affected, so the #1 can be simply backported as a prereq
> patch along with the real fix.

I'll add the same Fixes: to [1/2], and cc:stable.


