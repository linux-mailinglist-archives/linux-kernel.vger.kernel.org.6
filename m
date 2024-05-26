Return-Path: <linux-kernel+bounces-189715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E60ED8CF3FA
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2024 13:05:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 717F3281A72
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2024 11:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EECD2BA2E;
	Sun, 26 May 2024 11:05:01 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45A53D72
	for <linux-kernel@vger.kernel.org>; Sun, 26 May 2024 11:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716721501; cv=none; b=THCX9v8Dv+AjgI2W5EJaLvVB6avTZ51FOq2PKsUhlOnD0l7pF9EqEiJUvhlrB8TPAlyd8w6pYw3bZBsQC54lXkY0FH/IzrLgWRtElK9EnMlRfYqctBIzWHIWcwWpWpA4HBCbTRopy2ccUz+Ccmbn/mlh7aYAbzWUvf7hK4KW6FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716721501; c=relaxed/simple;
	bh=yGmmIuLTcFqjskdyA7AomRU8Ndv6IVRbK4wBd0fRrCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K+KVvS/cXWnzmn5FuwgCXzg0h12hsMFncJgCCZdkO75d7/OVQMkIM6+SvRXdkJxo1+qLc6IgX8j3nx4EOtxxP0NGGQRopJBgRbcTk68C47BKDDDL20o9arbHZWVPBoaFraIIjNvzabyE+wCwntWcwu97VhH9X3/MOmW/HM94YDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D4B6B5C908;
	Sun, 26 May 2024 11:04:57 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4C7C913A51;
	Sun, 26 May 2024 11:04:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id pqKBD1kXU2ZiZgAAD6G6ig
	(envelope-from <osalvador@suse.de>); Sun, 26 May 2024 11:04:57 +0000
Date: Sun, 26 May 2024 13:04:51 +0200
From: Oscar Salvador <osalvador@suse.de>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Jason Gunthorpe <jgg@nvidia.com>, Peter Xu <peterx@redhat.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH v3 00/16] Reimplement huge pages without hugepd on
 powerpc (8xx, e500, book3s/64)
Message-ID: <ZlMXU_4sbm02jEwe@localhost.localdomain>
References: <cover.1716714720.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1716714720.git.christophe.leroy@csgroup.eu>
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: D4B6B5C908
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action

On Sun, May 26, 2024 at 11:22:20AM +0200, Christophe Leroy wrote:
> This is the continuation of the RFC v1 series "Reimplement huge pages
> without hugepd on powerpc 8xx". It now get rid of hugepd completely
> after handling also e500 and book3s/64
> 
> Also see https://github.com/linuxppc/issues/issues/483
> 
> Unlike most architectures, powerpc 8xx HW requires a two-level
> pagetable topology for all page sizes. So a leaf PMD-contig approach
> is not feasible as such.
> 
> Possible sizes on 8xx are 4k, 16k, 512k and 8M.
> 
> First level (PGD/PMD) covers 4M per entry. For 8M pages, two PMD entries
> must point to a single entry level-2 page table. Until now that was
> done using hugepd. This series changes it to use standard page tables
> where the entry is replicated 1024 times on each of the two pagetables
> refered by the two associated PMD entries for that 8M page.
> 
> For e500 and book3s/64 there are less constraints because it is not
> tied to the HW assisted tablewalk like on 8xx, so it is easier to use
> leaf PMDs (and PUDs).
> 
> On e500 the supported page sizes are 4M, 16M, 64M, 256M and 1G. All at
> PMD level on e500/32 (mpc85xx) and mix of PMD and PUD for e500/64. We
> encode page size with 4 available bits in PTE entries. On e300/32 PGD
> entries size is increases to 64 bits in order to allow leaf-PMD entries
> because PTE are 64 bits on e500.
> 
> On book3s/64 only the hash-4k mode is concerned. It supports 16M pages
> as cont-PMD and 16G pages as cont-PUD. In other modes (radix-4k, radix-6k
> and hash-64k) the sizes match with PMD and PUD sizes so that's just leaf
> entries. The hash processing make things a bit more complex. To ease
> things, __hash_page_huge() is modified to bail out when DIRTY or ACCESSED
> bits are missing, leaving it to mm core to fix it.
> 
> Global changes in v3:
> - Removed patches 1 and 2
> - Squashed patch 11 into patch 5
> - Replaced patches 12 and 13 with a series from Michael
> - Reordered patches a bit to have more general patches up front
> 
> For more details on changes, see in each patch.
> 
> Christophe Leroy (15):
>   mm: Define __pte_leaf_size() to also take a PMD entry
>   mm: Provide mm_struct and address to huge_ptep_get()
>   powerpc/mm: Remove _PAGE_PSIZE
>   powerpc/mm: Fix __find_linux_pte() on 32 bits with PMD leaf entries
>   powerpc/mm: Allow hugepages without hugepd
>   powerpc/8xx: Fix size given to set_huge_pte_at()
>   powerpc/8xx: Rework support for 8M pages using contiguous PTE entries
>   powerpc/8xx: Simplify struct mmu_psize_def
>   powerpc/e500: Remove enc and ind fields from struct mmu_psize_def
>   powerpc/e500: Switch to 64 bits PGD on 85xx (32 bits)
>   powerpc/e500: Encode hugepage size in PTE bits
>   powerpc/e500: Use contiguous PMD instead of hugepd
>   powerpc/64s: Use contiguous PMD/PUD instead of HUGEPD
>   powerpc/mm: Remove hugepd leftovers
>   mm: Remove CONFIG_ARCH_HAS_HUGEPD

I glanced over it and it looks much better, not having to fiddle with other arch
code and generic declarations is a big plus.
I plan to do a proper review tomorrow.

Thanks for working on this Christophe!


-- 
Oscar Salvador
SUSE Labs

