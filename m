Return-Path: <linux-kernel+bounces-284825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BEBD950589
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 14:50:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31B5A1C22EC1
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 12:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35EF21993BA;
	Tue, 13 Aug 2024 12:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="MbcVogWx"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2AD1607B9
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 12:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723553410; cv=none; b=n4jLA8Oak2i6nlxZ3S+sDkhY4XBE/r0cgZUh9hAicRTPsjzRSMwXEgflZ6E7pbPXbQNRIlrBK7OXfUnnWvplsaxM/2L2S9U78ZgZ9iCcsXCB7g4mryvtUVpKW6rCqufj6ApWFqZo7zTP9T+0KmKhn4RYPYHl2VwP9Yjelukn/l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723553410; c=relaxed/simple;
	bh=/5s+tGGltjBp0kQRQqkrVY5F42gsHnuoDcSCHQXbKbo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SafWWsV1ZnfFNSXqF5TFBqxoBr8VABeYHAYkbUg957lbw/mGcUcifa5lAedn7dbubrqlbv4IGh7WJdv/7qImiVKXVvD76JVrfxChVupewxCmhEF2j3VaDlCOrHd7WH2Y0d8GJwyS9H0LjlmHeh8sM6ezJSM1u+8GRWHz7NOtbl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=MbcVogWx; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1723553406;
	bh=3JTj5OrR4YCVo4xbpaM1+3vNhDyPwwq6JrLH7UwwKog=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=MbcVogWxm8B5kX2RxPVpBX6D+wT9QM6+TJf/xnYyEoTtHe/IusCt0b/jFusolJoDh
	 69bhGuVRAKsCELkguiBlzmEIyZu25DdDEpIGBUKl2LcHP6PvN6luAO1CYP04pxOu6R
	 DYI8rd+STVQGe/6xBr9v8PjCwKW5vwCiVa89qYHjvOCy2OGHx7Qgicx7dP6plDnGZf
	 ToDdNthdsM7avYVQ5oy3Py/CihGgg9iuqSfc9a6Hrc6kffElUkjx1YcC6tp6MLAnqF
	 e4n04wp7/z+y0GD5e1MTOSLc/ShjXhJjB+gk8TbT/H6VM9w9OicIGpOc7pO8VvahIr
	 +h5kFkHW0SgEw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Wjrnm3Rq6z4w2R;
	Tue, 13 Aug 2024 22:50:04 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
Cc: "Kirill A . Shutemov" <kirill@shutemov.name>, Nicholas Piggin
 <npiggin@gmail.com>, David Hildenbrand <david@redhat.com>, Matthew Wilcox
 <willy@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, James
 Houghton <jthoughton@google.com>, Huang Ying <ying.huang@intel.com>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, peterx@redhat.com,
 Vlastimil Babka <vbabka@suse.cz>, Rick P Edgecombe
 <rick.p.edgecombe@intel.com>, Hugh Dickins <hughd@google.com>, Borislav
 Petkov <bp@alien8.de>, Christophe Leroy <christophe.leroy@csgroup.eu>, Rik
 van Riel <riel@surriel.com>, Dan Williams <dan.j.williams@intel.com>, Mel
 Gorman <mgorman@techsingularity.net>, x86@kernel.org, Ingo Molnar
 <mingo@redhat.com>, linuxppc-dev@lists.ozlabs.org, Dave Hansen
 <dave.hansen@linux.intel.com>, Dave Jiang <dave.jiang@intel.com>, Oscar
 Salvador <osalvador@suse.de>, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v5 0/7] mm/mprotect: Fix dax puds
In-Reply-To: <20240812181225.1360970-1-peterx@redhat.com>
References: <20240812181225.1360970-1-peterx@redhat.com>
Date: Tue, 13 Aug 2024 22:50:04 +1000
Message-ID: <87plqc1tab.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Peter Xu <peterx@redhat.com> writes:
> [Based on mm-unstable, commit 98808d08fc0f, Aug 7th. NOTE: it is
>  intentional to not have rebased to latest mm-unstable, as this is to
>  replace the queued v4]
>
> v5 Changelog:
> - Rename patch subject "mm/x86: arch_check_zapped_pud()", add "Implement" [tglx]
> - Mostly rewrote commit messages for the x86 patches, follow -tip rules [tglx]
> - Line wrap fixes (to mostly avoid newlines when unnecessary) [tglx]
> - English fixes [tglx]
> - Fix a build issue only happens with i386 pae + clang
>   https://lore.kernel.org/r/202408111850.Y7rbVXOo-lkp@intel.com
>
> v1: https://lore.kernel.org/r/20240621142504.1940209-1-peterx@redhat.com
> v2: https://lore.kernel.org/r/20240703212918.2417843-1-peterx@redhat.com
> v3: https://lore.kernel.org/r/20240715192142.3241557-1-peterx@redhat.com
> v4: https://lore.kernel.org/r/20240807194812.819412-1-peterx@redhat.com
>
> Dax supports pud pages for a while, but mprotect on puds was missing since
> the start.  This series tries to fix that by providing pud handling in
> mprotect().  The goal is to add more types of pud mappings like hugetlb or
> pfnmaps.  This series paves way for it by fixing known pud entries.
>
> Considering nobody reported this until when I looked at those other types
> of pud mappings, I am thinking maybe it doesn't need to be a fix for stable
> and this may not need to be backported.  I would guess whoever cares about
> mprotect() won't care 1G dax puds yet, vice versa.  I hope fixing that in
> new kernels would be fine, but I'm open to suggestions.
>
> There're a few small things changed to teach mprotect work on PUDs. E.g. it
> will need to start with dropping NUMA_HUGE_PTE_UPDATES which may stop
> making sense when there can be more than one type of huge pte.  OTOH, we'll
> also need to push the mmu notifiers from pmd to pud layers, which might
> need some attention but so far I think it's safe.  For such details, please
> refer to each patch's commit message.
>
> The mprotect() pud process should be straightforward, as I kept it as
> simple as possible.  There's no NUMA handled as dax simply doesn't support
> that.  There's also no userfault involvements as file memory (even if work
> with userfault-wp async mode) will need to split a pud, so pud entry
> doesn't need to yet know userfault's existance (but hugetlb entries will;
> that's also for later).
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
>
> - userfault wp-async: I also wanted to test userfault-wp async be able to
>   split huge puds (here it's simply a clear_pud.. though), but it won't
>   work for devdax anyway due to not allowed to do smaller than 1G faults in
>   this case. So skip too.
>
> - Power, as no hardware on hand.

Does it need some specific configuration, or just any Power machine will do?

cheers

