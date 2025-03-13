Return-Path: <linux-kernel+bounces-560161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C093A5FEE4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 19:11:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81E4516C6CA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 18:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A8DD1EBFE2;
	Thu, 13 Mar 2025 18:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Jg5MYpWb"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B391C8631
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 18:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741889503; cv=none; b=WrrFYxL7+u01vMnFuP0PdMYoN4SstjdAi7StqbBhJotcbzzTIE/YuOQZiM+zrPcTI357HxnD+hG+SMsifyCeOr/Iq5hiflXfTuvUWwZkVe7BAVv/zHlKu8v3A2QXcP2WcKLdozJ/6QVtxYl6wI0otlln4L/F5UpNGJyrP+wuf+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741889503; c=relaxed/simple;
	bh=ofKUbUs2X58qm+AJW1ciZdf0AOUurV42sokYQDEDN18=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ZjRgoJXFaV12ufPAKD9XBs8mW79YxtE7OT8+YQgnxRtYbM9CWmtnX7X1S16UvxrpIlBvrufWWKasfahIWdSghalgSyM+cpz0LossZy4rGK2myVjkKiJWGEuBHNaiCw1/N3PsCXa/KVZDx69ktfxtJcIbbYdBn3z0ZES9rZht+7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Jg5MYpWb; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4394c747c72so6571925e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 11:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741889500; x=1742494300; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8p30DA53bI6PuiFh/iHxzo25VltyUumdd721+bLC4Pk=;
        b=Jg5MYpWb4WSLTmKhomDKs3kCu+mXOa6Q1yezElLwk9ROKXvlo8EHy+gNmYfKYyOYe1
         EEY1+WrtGc3rMlbUOXJdtXsYw0NRUioDm8zjTQItB5IrSpRPWk9yMLdhDP/Ms0EyHgX7
         ucpYsSnfKQGuGeQNCtnh1bdWFMRmx11AFK8qtSTlFwCSKu1XTh576sU5q8MG7jf9AsBz
         6uwRiITZObKwbT3ryfZJTyztuWRxM0Ylx1gFBSufKUuqH+wizIquuhmcs5aJVCRLibcO
         g8cYRHiGFvpkXqHdPH2b0cEji1Zvvrl/0Ucn8cQLqi0WKi+Ry8mXQx/qKC3TPMPBW7v1
         7rmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741889500; x=1742494300;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8p30DA53bI6PuiFh/iHxzo25VltyUumdd721+bLC4Pk=;
        b=G1JANTaBQ3xxPM2ZW5gVhtTzD3eRESTsMGSzT3QSFg1cnw2GWT3m6OlzpUI8AsFxY7
         tYHiWrz8ljORLO/LTGOzFDyjb625c0T1IDB29+tVBEkeJqWYNOow1fYXW1B4aZOlxyPp
         R9KNuc3t61G0sqMPlw2oKVUMPljoJm5umV19V9p9eX7DyZpgWVJotHcCHMBbshLlAB6o
         9kkzcecNrxxCcndDQjKD14ukus8EEVFWSgEuKUbEk1PKl90H4zNWGXIfTNHlo8DIWkIE
         C8+1jdsEp/HF37MkhIqnQQ2JEcdQzYn1kdVUf1UsvdbewV5bcyeuShlRccRSpZoQGjOB
         ScQw==
X-Gm-Message-State: AOJu0Yw+RWEasKEIfHnEcpYNW0Wa1b+Oxsq2uH+HEWP2FPy45E4O/R+8
	vEtDQwDk0a1QhaXcqC1/ZGsrnjTU4TXLkChd6ulxE8m3gZqi8WFvop0mqu3le0l36EH61yGn1OH
	rqNhG4i+1Eg==
X-Google-Smtp-Source: AGHT+IE4wDnoPc9EOKAgyJOM9+Bkac5viowYsO8CgIONHzVZLkFEl13poXtNAOIIrPh4W5A6xNrV2GgLwMNQJw==
X-Received: from wmgg26.prod.google.com ([2002:a05:600d:1a:b0:43c:fa87:4fa0])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:524f:b0:43c:fbba:41ba with SMTP id 5b1f17b1804b1-43d01c25c31mr108057025e9.28.1741889500197;
 Thu, 13 Mar 2025 11:11:40 -0700 (PDT)
Date: Thu, 13 Mar 2025 18:11:19 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAMcf02cC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDY0MD3cTiTN2CRKB4Yk5OfrKuhUFqomGahbGBeYqBElBTQVFqWmYF2MB opSA3Z6XY2loAh7L+lWUAAAA=
X-Change-Id: 20250310-asi-page-alloc-80ea1f8307d0
X-Mailer: b4 0.14.2
Message-ID: <20250313-asi-page-alloc-v1-0-04972e046cea@google.com>
Subject: [PATCH RFC 00/11] mm: ASI integration for the page allocator
From: Brendan Jackman <jackmanb@google.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, David Rientjes <rientjes@google.com>, 
	Vlastimil Babka <vbabka@suse.cz>, David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Mike Rapoport <rppt@kernel.org>, Junaid Shahid <junaids@google.com>, Reiji Watanabe <reijiw@google.com>, 
	Patrick Bellasi <derkling@google.com>, Brendan Jackman <jackmanb@google.com>, 
	Yosry Ahmed <yosry.ahmed@linux.dev>
Content-Type: text/plain; charset="utf-8"

.:: Intro

This code illustrates the idea I'm proposing at LSF/MM/BPF [0].
Sorry it's so close to the conference, I was initially quite ambitious
in what I wanted to show here and tried to implement a more complete
patch series. Now I've run out of time and I've had to reduce the scope
and just hack some minimal stuff together. Now, this series is _only_
supposed to be about page_alloc.c, everything else is just there as
scaffolding so that allocator code can be discussed.

I've marked the most incomplete patches with [HACKS] in the title to
illustrate what aspects are less worthy of attention.

See [0] and also [1] for broader context on the ASI/page_alloc topic.
See [2] for context about ASI itself. For this RFC the most important
fact is: ASI requires creating another kernel address space (the
"restricted address space") that is a subset of that normal one (i.e.
the "unrestricted address space"). That is, an address space just like
the normal one, but with holes in it. Pages that are unmapped from the
restricted address space are called "sensitive".

.:: The Idea

What is sensitive (i.e.  where the holes are) is decided at allocation
time. This illustrates an initial implementation of that capability for
the direct map. The basic idea of this implementation is to operate at
pageblock-granularity, and use migratetypes to track sensitivity.  The
key advantages of this approach are:

- Migratetypes exist to avoid fragmentation. Using them to index pages
  by sensitivity takes advantage of this, so that the physmap doesn't
  get fragmented with respect to sensitivity. This means we can use
  large TLB entries for the restricted physmap.

- Since pageblocks are never smaller than a PMD mapping, if the
  restricted physmap is always made of PMDs, we never have to break down
  mappings while changing sensitivity. This means we don't have
  difficulties with needing to allocate pagetables in the middle of the
  allocator.

- Migratetypes already offer indexing capability - that is, there are
  separate freelists for each migratetype. This means when the user
  allocates a page with a given sensitivity, all the infrastructure is
  already in place to look up a page that is already mapped/unmapped as
  needed (if it exists). This minimizes unnecessary TLB flushes.

This differs from Mike Rapoport's work on __GFP_UNMAPPED [3] in that,
instead of having a totally separate free area for the pages that are
unmapped, it aims to pervade the allocator. If it turns out that for all
nonsensitive (or all sensitive, which seems highly unlikely) pages, a
access to the full feature set of the page allocator is not needed for a
performant system, we could certainly do something like Mike's patchset.
But we don't have any reason to expect a correlation between
sensitivity and performance needs.

.:: Patchset overview

- Patch 1 adds a minimal subset of the base ASI framework that was
  introduced by the RFCv2 [2].

- Patches 2-5 add the necessary framework for creating and manipulating
  the ASI physmap. This is the area where I have had to reduce the scope
  of this series, I had hoped to present a proper integration here. But
  instead I've had to just hack something together that kinda works.
  You can probably skip over this section.

- Patches 6-8 are preparatory hacks and changes to the generic mm code.

- Patches 9-11 are the important bit. The new migratetypes are created.
  Then logic is added to create nonsensitive pageblocks when needed.
  Then logic is added to change them back to sensitive pageblocks when
  needed.

.:: TODOs

 - This doesn't let you allocate from MIGRATE_HIGHATOMIC pageblocks
   unless you have __GFP_SENSITIVE. We probably need to make the
   pageblock type and per-freelist logic more advanced to be able to
   account for this.

 - When pages transition from sensitive to nonsensitive, they need to be
   zeroed to prevent any leftover data being leaked. This series doesn't
   address that requirement at all.

 - Although I think the abstract design is OK, the actual implementation
   of calling asi_map()/asi_unmap() from page_alloc.c is pretty
   confusing: asi_map() is implicit when calling
   set_pageblock_migratetype() but asi_unmap() is up to the caller. This
   requires some refactoring.

 - Changes to the unrestricted physmap (page protection changes, memory
   hotplug) are not properly mirrored into the restricted physmap.

 - There's no integration with CMA. The branch at [4] has some minimal
   integration into alloc_contig_range().

.:: References

[0] https://lore.kernel.org/linux-mm/CA+i-1C169s8pyqZDx+iSnFmftmGfssdQA29+pYm-gqySAYWgpg@mail.gmail.com/
[1] Some slides I presented in an earlier discussion of this topic:
    https://docs.google.com/presentation/d/1Ozuan7E4z2YWm4V6uE_fe7YoF2BdS3m5jXjDKO7DVy0/edit#slide=id.g32d28ea451a_0_43
[2] https://lore.kernel.org/linux-mm/20250110-asi-rfc-v2-v2-0-8419288bc805@google.com/
[3] https://lore.kernel.org/all/20230308094106.227365-1-rppt@kernel.org/
[5] https://lore.kernel.org/linux-mm/20250129144320.2675822-1-jackmanb@google.com/

This series is available as a branch with some additional testing here:

[4] https://github.com/bjackman/linux/tree/asi/page-alloc-lsfmmbpf25

This applies to mm-unstable.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
Brendan Jackman (11):
      x86/mm: Bare minimum ASI API for page_alloc integration
      x86/mm: Factor out phys_pgd_init()
      x86/mm: Add lookup_pgtable_in_pgd()
      x86/mm/asi: Sync physmap into ASI_GLOBAL_NONSENSITIVE
      [RFC HACKS] Add asi_map() and asi_unmap()
      mm/page_alloc: Add __GFP_SENSITIVE and always set it
      [RFC HACKS] mm/slub: Set __GFP_SENSITIVE for reclaimable slabs
      [RFC HACKS] mm/page_alloc: Simplify gfp_migratetype()
      mm/page_alloc: Split MIGRATE_UNMOVABLE by sensitivity
      mm/page_alloc: Add support for nonsensitive allocations
      mm/page_alloc: Add support for ASI-unmapping pages

 arch/Kconfig                         |  14 ++++
 arch/x86/Kconfig                     |   1 +
 arch/x86/include/asm/asi.h           |  36 ++++++++
 arch/x86/include/asm/pgtable_types.h |   2 +
 arch/x86/mm/Makefile                 |   1 +
 arch/x86/mm/asi.c                    |  85 +++++++++++++++++++
 arch/x86/mm/init.c                   |   3 +-
 arch/x86/mm/init_64.c                |  53 ++++++++++--
 arch/x86/mm/pat/set_memory.c         |  34 ++++++++
 include/linux/asi.h                  |  20 +++++
 include/linux/gfp.h                  |  30 ++++---
 include/linux/gfp_types.h            |  15 +++-
 include/linux/mmzone.h               |  19 ++++-
 include/linux/vmalloc.h              |   4 +
 mm/internal.h                        |   5 ++
 mm/memory_hotplug.c                  |   2 +-
 mm/page_alloc.c                      | 158 +++++++++++++++++++++++++++++++----
 mm/show_mem.c                        |  13 +--
 mm/slub.c                            |   6 +-
 mm/vmalloc.c                         |  32 ++++---
 20 files changed, 475 insertions(+), 58 deletions(-)
---
base-commit: 5ee93e1a769230377c3d44edd4917e8df77be566
change-id: 20250310-asi-page-alloc-80ea1f8307d0

Best regards,
-- 
Brendan Jackman <jackmanb@google.com>


