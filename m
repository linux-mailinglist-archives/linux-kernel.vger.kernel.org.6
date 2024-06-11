Return-Path: <linux-kernel+bounces-209578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 858F39037EE
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 11:35:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 149D3B2602E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 09:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65CB7176AC1;
	Tue, 11 Jun 2024 09:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1h9kfKoU";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Wyti0idM";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1h9kfKoU";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Wyti0idM"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE891BF2A
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 09:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718098468; cv=none; b=VIB2KizszWRfJYHjM4DstMe7AGXvXXbVRBDbUqdxXNJKmnX4Mdp99a3Lv8vaERGVA/GLTBEU8HohfAu3EEElNCWHPgFPUb5NjrnxdvdFlCBjJWqzXkKXskd76ITn90Kj72zk5gXL5k6uek2GyOkQMwdPqzCweDUK5qFisYWn3Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718098468; c=relaxed/simple;
	bh=039KEOjJTO3YVS9SW6PakeGw3N0m3XJPvPkiVlagfm8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z1Tfui3JjGxRTZE/wim9tQiPZRl5FXmF6nk9YdlW4b7MLwHHfXS6ZI4RFWZyQoQDx8NZVY1wYKd2/ZD7b92Npi7wNc3I9ACG9EWlcCCqszB+2tYn2QQnNSg2bTqhjtJaQ7xanHAXhW/OF+P7d5cmh1vv+86cBAGQFsINO3+FuK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1h9kfKoU; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Wyti0idM; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1h9kfKoU; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Wyti0idM; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2FB9133686;
	Tue, 11 Jun 2024 09:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718098465; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bXl9G+kh6CJWJjfSYdY3mI/mE/xXvq102BbFQ15gmgk=;
	b=1h9kfKoUjzUX7Pg0FYO4/Hn86ca25G+Dw0AJG6LeaEH4SJ+Pr27qT5mX6xNgxC6+O6nlft
	br7k3/K0BFcSDett6c63kGZre4r1PJdSH5PsMsFXqyiITD7SPqMSS1uvPAn4oCFafdgeLW
	Px/kUM1cWdNYU4YVxTTrQ2a7A0yPIFM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718098465;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bXl9G+kh6CJWJjfSYdY3mI/mE/xXvq102BbFQ15gmgk=;
	b=Wyti0idMR4rKs3LoThTM+Y8V0nVad7j2jppVkPhnwFxzg/7HdB6YPRlKnU0DR4KISNMvTk
	44kaEKvNEVIr0MBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718098465; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bXl9G+kh6CJWJjfSYdY3mI/mE/xXvq102BbFQ15gmgk=;
	b=1h9kfKoUjzUX7Pg0FYO4/Hn86ca25G+Dw0AJG6LeaEH4SJ+Pr27qT5mX6xNgxC6+O6nlft
	br7k3/K0BFcSDett6c63kGZre4r1PJdSH5PsMsFXqyiITD7SPqMSS1uvPAn4oCFafdgeLW
	Px/kUM1cWdNYU4YVxTTrQ2a7A0yPIFM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718098465;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bXl9G+kh6CJWJjfSYdY3mI/mE/xXvq102BbFQ15gmgk=;
	b=Wyti0idMR4rKs3LoThTM+Y8V0nVad7j2jppVkPhnwFxzg/7HdB6YPRlKnU0DR4KISNMvTk
	44kaEKvNEVIr0MBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A858413A55;
	Tue, 11 Jun 2024 09:34:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Jbt2JiAaaGapdAAAD6G6ig
	(envelope-from <osalvador@suse.de>); Tue, 11 Jun 2024 09:34:24 +0000
Date: Tue, 11 Jun 2024 11:34:23 +0200
From: Oscar Salvador <osalvador@suse.de>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Jason Gunthorpe <jgg@nvidia.com>, Peter Xu <peterx@redhat.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v5 02/18] mm: Define __pte_leaf_size() to also take a PMD
 entry
Message-ID: <ZmgaHyS0izhtKbx6@localhost.localdomain>
References: <cover.1717955558.git.christophe.leroy@csgroup.eu>
 <172b11c93e0de7a84937af2da9f80bd17c56b8c9.1717955558.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <172b11c93e0de7a84937af2da9f80bd17c56b8c9.1717955558.git.christophe.leroy@csgroup.eu>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_TLS_ALL(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,nvidia.com,redhat.com,ellerman.id.au,gmail.com,vger.kernel.org,kvack.org,lists.ozlabs.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On Mon, Jun 10, 2024 at 07:54:47AM +0200, Christophe Leroy wrote:
> On powerpc 8xx, when a page is 8M size, the information is in the PMD
> entry. So allow architectures to provide __pte_leaf_size() instead of
> pte_leaf_size() and provide the PMD entry to that function.
> 
> When __pte_leaf_size() is not defined, define it as a pte_leaf_size()
> so that architectures not interested in the PMD arguments are not
> impacted.
> 
> Only define a default pte_leaf_size() when __pte_leaf_size() is not
> defined to make sure nobody adds new calls to pte_leaf_size() in the
> core.

Hi Christophe,

Now I am going to give you a hard time, so sorry in advance.
I should have raised this before, but I was not fully aware of it.

There is an ongoing effort of unifying pagewalkers [1], so hugetlb does not have
to be special-cased anymore, and the operations we do for THP on page-table basis
work for hugetlb as well.

The most special bit about this is huge_ptep_get.
huge_ptep_get() gets special handled on arm/arm64/riscv and s390.

arm64 and riscv is about cont-pmd/pte and propagate the dirty/young bits bits, so that
is fine as walkers can already understand that.
s390 is a funny one because it converts pud/pmd to pte and viceversa, because hugetlb
*works* with ptes, so before returning the pte it has to transfer all
bits from PUD/PMD level into a something that PTE level can understand.
As you can imagine, this can be gone as we already have all the
information in PUD/PMD and that is all pagewalkers need.

But we are left with the one you will introduce in patch#8.

8MB pages get mapped as cont-pte, but all the information is stored in
the PMD entries (size, dirtiness, present etc).
huge_ptep_get() will return the PMD for 8MB, and so all operations hugetlb
code performs with what huge_ptep_get returns will be performed on those PMDs.

Which brings me to this point:

I do not think __pte_leaf_size is needed. AFAICS, it should be enough to define
pmd_leaf on 8xx, and return 8MB if it is a 8MB hugepage.

   #define pmd_leaf pmd_leaf
   static inline bool pmd_leaf(pmd_t pmd)
   {
          return pmd_val(pmd) & _PMD_PAGE_8M);
   }

   and then pmd_leaf_size to return _PMD_PAGE_8M.
   
This will help because on the ongoing effort of unifying hugetlb and
getting rid of huge_ptep_get() [1], pagewalkers will stumble upon the
8mb-PMD as they do for regular PMDs.

Which means that they would be caught in the following code:

        ptl = pmd_huge_lock(pmd, vma);
        if (ptl) {
	        - 8MB hugepages will be handled here
                smaps_pmd_entry(pmd, addr, walk);
                spin_unlock(ptl);
        }
	/* pte stuff */
	...

where pmd_huge_lock is:

 static inline spinlock_t *pmd_huge_lock(pmd_t *pmd, struct vm_area_struct *vma)
 {
        spinlock_t *ptl = pmd_lock(vma->vm_mm, pmd);

        if (pmd_leaf(*pmd) || pmd_devmap(*pmd))
                return ptl;
        spin_unlock(ptl);
        return NULL;
 }

So, since pmd_leaf() will return true for 8MB hugepages, we are fine,
because anyway we want to perform pagetable operations on *that* PMD and
not the ptes that are cont-mapped, which is different for e.g: 512K
hugepages, where we perform it on pte level.

So I would suggest that instead of this patch, we have one implementing pmd_leaf
and pmd_leaf_size for 8Mb hugepages on power8xx, as that takes us closer to our goal of
unifying hugetlb.

[1] https://github.com/leberus/linux/tree/hugetlb-pagewalk-v2


-- 
Oscar Salvador
SUSE Labs

