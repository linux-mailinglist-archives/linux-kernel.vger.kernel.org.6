Return-Path: <linux-kernel+bounces-278577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81F0194B20F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 23:23:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A53B283B95
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 21:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68035153838;
	Wed,  7 Aug 2024 21:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="kTH2K96F"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC89149DFF
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 21:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723065798; cv=none; b=a6OIpJUX4UIdvXVwXs7wOKEFTGdeKOQK5yoyaC+tUE98/oMSK7I+/tIbIvnKy3/p+xHzJJySc+bn0/wuCX5R7YlCfYh7LXweeff56TZ4ni0hmLOPDzZAoJo/DBlE1A2nkaQU+kVDgFf7K3fAfEuXrrBomQZ0OYO++IZ4lHaeuu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723065798; c=relaxed/simple;
	bh=5TeacULXpvoFK35sDeqFFGloS/Xk45IocGQ+pCFA1LU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=m3baElOnH8ySoLWIkaF8gSg6TRMwJgoaSODmeVSGkpQsGsEzEslZpOy42bO9jOtek5b1aa6YrM5epDfO0ILS2P5B+GUWdoKsFi0+o53OKjyKkxZXf2GkZNzUU8kF1WSG6Jzd9GdI/5G7EiApRc4NWjZdJ6InXpih214s4Nl/MuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=kTH2K96F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5492CC32781;
	Wed,  7 Aug 2024 21:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1723065798;
	bh=5TeacULXpvoFK35sDeqFFGloS/Xk45IocGQ+pCFA1LU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kTH2K96FIchSUF8CqRAEuvGsFOqDp0pEqwfQtA61rNeoMT6EQichhOCDdgAB/PZ4q
	 5OGZjb/Czsefmbiep4IM10TTePzuqLaeQH1qeIDHQWCTUWYGAksRZP7OT8WUgRUhM9
	 8VPDuwGGVeA5N9V4HmPIvreZjN6ixFaOm5vUOUW8=
Date: Wed, 7 Aug 2024 14:23:16 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Peter Xu <peterx@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, "Aneesh Kumar K . V"
 <aneesh.kumar@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Oscar
 Salvador <osalvador@suse.de>, Dan Williams <dan.j.williams@intel.com>,
 James Houghton <jthoughton@google.com>, Matthew Wilcox
 <willy@infradead.org>, Nicholas Piggin <npiggin@gmail.com>, Rik van Riel
 <riel@surriel.com>, Dave Jiang <dave.jiang@intel.com>, x86@kernel.org, Ingo
 Molnar <mingo@redhat.com>, Rick P Edgecombe <rick.p.edgecombe@intel.com>,
 "Kirill A . Shutemov" <kirill@shutemov.name>,
 linuxppc-dev@lists.ozlabs.org, Mel Gorman <mgorman@techsingularity.net>,
 Hugh Dickins <hughd@google.com>, Borislav Petkov <bp@alien8.de>, David
 Hildenbrand <david@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
 Vlastimil Babka <vbabka@suse.cz>, Dave Hansen
 <dave.hansen@linux.intel.com>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Huang Ying <ying.huang@intel.com>
Subject: Re: [PATCH v4 0/7] mm/mprotect: Fix dax puds
Message-Id: <20240807142316.bbad141a106093b6f36249e2@linux-foundation.org>
In-Reply-To: <20240807194812.819412-1-peterx@redhat.com>
References: <20240807194812.819412-1-peterx@redhat.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  7 Aug 2024 15:48:04 -0400 Peter Xu <peterx@redhat.com> wrote:

> 
> Tests
> =====
> 
> What I did test:
> 
> - cross-build tests that I normally cover [1]
> 
> - smoke tested on x86_64 the simplest program [2] on dev_dax 1G PUD
>   mprotect() using QEMU's nvdimm emulations [3] and ndctl to create
>   namespaces with proper alignments, which used to throw "bad pud" but now
>   it'll run through all fine.  I checked sigbus happens if with illegal
>   access on protected puds.
> 
> - vmtests.
> 
> What I didn't test:
> 
> - fsdax: I wanted to also give it a shot, but only until then I noticed it
>   doesn't seem to be supported (according to dax_iomap_fault(), which will
>   always fallback on PUD_ORDER).  I did remember it was supported before, I
>   could miss something important there.. please shoot if so.

OK.  Who are you addressing this question to?

> - userfault wp-async: I also wanted to test userfault-wp async be able to
>   split huge puds (here it's simply a clear_pud.. though), but it won't
>   work for devdax anyway due to not allowed to do smaller than 1G faults in
>   this case. So skip too.

Sounds OK.  So that's an additional project if anyone cares enough?

> - Power, as no hardware on hand.

Hopefully the powerpc people can help with that.  What tests do you ask
that they run?


