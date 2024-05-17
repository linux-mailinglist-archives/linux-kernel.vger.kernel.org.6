Return-Path: <linux-kernel+bounces-182205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1598A8C8810
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 16:27:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C3C41F27BA5
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 14:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01F955FB94;
	Fri, 17 May 2024 14:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="IQGJUkqk";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="d93YTo6p";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="IQGJUkqk";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="d93YTo6p"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4775E060
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 14:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715956037; cv=none; b=YhF2y0SR3maaBewfoSlY24TVNi95uh2Ns0w/Cg/FYZboHhp3RfsHz0S7xgP7qM8BWteUuINrSxrUOaibCgqMTCZH32q/xg3pEEwbIhCU1a4caoeyYcAy3zV2nd87l1nlnodLLE6ZML19wue+FVCxx+aQRhAzWIrlX3ES64SeP9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715956037; c=relaxed/simple;
	bh=1uPZe6O+U/nIaxtRP7otFXadxDMw6y7Mvt2STUpxVZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qr6zCesNq/sFzvPdOgr+3rU7paO8XS24wEqcvQRWA7o4ATJ/xL0IBnFR9W6Ra7liJXwBjOm51DvbtCTRiZMGYzsHaDrMBtwVR2/w/TLwtNmcMB7SfHPT69VyQj389TGvJW5OFBdL5luRuR1GLglgIdfNTOmz+/IVqWOlK9LVFYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=IQGJUkqk; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=d93YTo6p; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=IQGJUkqk; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=d93YTo6p; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 277C03753E;
	Fri, 17 May 2024 14:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1715956033; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jFIvzqT1E77ELTg/8u02x5Dv1NLQX6WrR+4hhQiT4oM=;
	b=IQGJUkqkkohUkV66RGC0pnNG0TgpepqS59fTIPw+Z7nvfEFzM+llsBAe/AI2704WalsXw3
	8/SXxt6dJmfCR506rd25Vdl9elilP4wDnZoxxZkAFw9Lr4MRML47/DXry/FA0RK86m9ZmA
	ncgCd3+jXDvYY2ZfWKood7VRMUOLjP4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1715956033;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jFIvzqT1E77ELTg/8u02x5Dv1NLQX6WrR+4hhQiT4oM=;
	b=d93YTo6ppEpbIMm6E++0P43k5l8zG+mImUCLwKIVLmOn54pWg4sV5khUUnFpcs5eRFWcYd
	urwDymmLzA+I8ZBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1715956033; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jFIvzqT1E77ELTg/8u02x5Dv1NLQX6WrR+4hhQiT4oM=;
	b=IQGJUkqkkohUkV66RGC0pnNG0TgpepqS59fTIPw+Z7nvfEFzM+llsBAe/AI2704WalsXw3
	8/SXxt6dJmfCR506rd25Vdl9elilP4wDnZoxxZkAFw9Lr4MRML47/DXry/FA0RK86m9ZmA
	ncgCd3+jXDvYY2ZfWKood7VRMUOLjP4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1715956033;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jFIvzqT1E77ELTg/8u02x5Dv1NLQX6WrR+4hhQiT4oM=;
	b=d93YTo6ppEpbIMm6E++0P43k5l8zG+mImUCLwKIVLmOn54pWg4sV5khUUnFpcs5eRFWcYd
	urwDymmLzA+I8ZBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B59AD13942;
	Fri, 17 May 2024 14:27:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id PrieKUBpR2YlegAAD6G6ig
	(envelope-from <osalvador@suse.de>); Fri, 17 May 2024 14:27:12 +0000
Date: Fri, 17 May 2024 16:27:11 +0200
From: Oscar Salvador <osalvador@suse.de>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Jason Gunthorpe <jgg@nvidia.com>, Peter Xu <peterx@redhat.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH 0/8] Reimplement huge pages without hugepd on powerpc
 8xx
Message-ID: <ZkdpP-6znZS5Fvz2@localhost.localdomain>
References: <cover.1711377230.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1711377230.git.christophe.leroy@csgroup.eu>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On Mon, Mar 25, 2024 at 03:55:53PM +0100, Christophe Leroy wrote:
> This series reimplements hugepages with hugepd on powerpc 8xx.
> 
> Unlike most architectures, powerpc 8xx HW requires a two-level
> pagetable topology for all page sizes. So a leaf PMD-contig approach
> is not feasible as such.
> 
> Possible sizes are 4k, 16k, 512k and 8M.
> 
> First level (PGD/PMD) covers 4M per entry. For 8M pages, two PMD entries
> must point to a single entry level-2 page table. Until now that was
> done using hugepd. This series changes it to use standard page tables
> where the entry is replicated 1024 times on each of the two pagetables
> refered by the two associated PMD entries for that 8M page.
> 
> At the moment it has to look into each helper to know if the
> hugepage ptep is a PTE or a PMD in order to know it is a 8M page or
> a lower size. I hope this can me handled by core-mm in the future.
> 
> There are probably several ways to implement stuff, so feedback is
> very welcome.


Hi Christophe,

I have been looking into this because I am interested in the ongoing work of
the hugetlb unification, but my knowledge of ppc pagetables tends to zero,
So be prepared for some stupid questions.

First, let me have a clear picture of the current situation:

power8xx has 4KB, 16KB, 512KB, and 8MB page sizes, and operate on a 2Level 
pagetables. Wiki [1] mentions PGD + PTE, here you seem to be referring them
as PMD + PTE though.

And we can have 1024 PGDs, each of one covers 4MB, so we can cover a total of
of 4GB.

Looking at the page table diagram for power8xx, it seems power8xx has also some
sort of CONTIG_PTE? (same as arm64 does) So we can have contig_ptes representing
bigger page sizes?
I also guess that although power8xx supports all these different sizes, only one
of them can be active at any time, right?

It also seems that this whole hugepd thing is only used when we are using 8MB
PAGE_SIZE, right?
And when that is active, we do have 2 PGDs(4MB each) pointing to the same 8MB
hugepd.
E.g:
                        ____________
 [PGD#0] ------------> |            |
                       | 8MB hugepd |
 [PGD#1] ------------> |____________|

What you want to do with this work is to get rid of that hugepd abstraction
because it is something power8xx/hugetlb specific and cannot be represented
with our "normal" page table layout (PGD,P4D,PUD,PMD,PTE).
I did not check, but I guess we cannot walk the hugepd thing with a normal
page table walker, or can we? (how special is a hugepd? can you describe its
internal layout?)

So, what you proprose, is something like the following?

 [PGD#X] -----------> [PTE#0]
         -----------> [PTE..#1023]
 [PGD#Y] -----------> [PTE#0]
         -----------> [PTE..#1023]

so a 8MB hugepage will be covered by PGD#X and PGD#Y using contiguos PTEs.

The diagram at [1] for 8xx 16K seems a bit misleading to me (or maybe it is
just me). They say that a Level2 table (aka PTE) covers 4KB chunks regardless
of the pagesize, but either I read that wrong or..else.
Because on 16K page size, they show that each pte covers for 16KB memory chunk.
But that would mean 16KB << 10 = 16M each PGD, which is not really that, so what
is the deal there? Or it is just that we always use 4KB PTEs, and use contiguous
PTEs for bigger sizes?

Now, it seems that power8xx has no-p4d, no-pud and no-pmd, right?

Peter mentioned that we should have something like:

X       X
[PGD] - [P4D] - [PUD] - [PMD] - [PTE]

where the PMD and PTE would be the ones we use for representing the 2Level
ptage table, and PGD,P4D and PUD would just be dummies.

But, is not the convention to at least have PGD-PTE always, and have anything
in between as optional? E.g:

  X       ?       ?       ?       X
[PGD] - [P4D] - [PUD] - [PMD] - [PTE]

I mean, are page table walkers ready to deal with non-PGD? I thought they were
not.

Also, in patch#1, you mentioned:

"At the time being, for 512k pages the flag is kept in the PTE and inserted in
the PMD entry at TLB miss exception".

Can you point out where to look for that in the code?

Also, what exactly is the "sz" parameter that gets passed down to pmd_populate_size()?
Is the size of the current mapping we are establishing?
I see that you only make a distinction when the mapping size is 8MB.
So the PMD will have _PMD_PAGE_8MB, so it works that all 1024 PTEs below are contiguous
representing a 4MB chunk?

I will start looking deeper into this series on Monday, but just wanted to have a better
insight of what is going on.

PD: I think we could make the changelog of the coverletter a bit fatter and cover some
details in there, e.g: layout of page-tables for different page sizes, layout of hugepd,
expected layout after the work, etc.
I think it would help in reviewing this series.

Thanks!

[1] https://github.com/linuxppc/wiki/wiki/Huge-pages


-- 
Oscar Salvador
SUSE Labs

