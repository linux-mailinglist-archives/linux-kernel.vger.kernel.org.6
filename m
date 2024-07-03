Return-Path: <linux-kernel+bounces-239579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D97A4926299
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 15:57:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 972102810A2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 13:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D6D217A92E;
	Wed,  3 Jul 2024 13:57:33 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E3285624
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 13:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720015053; cv=none; b=O1N+HxK6EGbAjmbgod2iQYJK2PIuMWoqtYoPF5AJP10Wu5vULkSijH+quaptgNFG7mM8RGVJHQeE/NsyPPUpMaRZoZBl/qDxoPTCEcHrrrkF1NR6vQbLeNmfWy7N2cbwQfu+DOPzk68Ug2khb/UnVf7kb+ClYwlEIelOcEQ+zFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720015053; c=relaxed/simple;
	bh=TeFCHldqFGf6WsPSKBG/GxNa0TmXyXz38Y7BcFhGyqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lx+LR/Vt9VBh5IKhlUG5UYc30HANLZ2J563mKUJDq7ZL4qY6UyI1OLBIGkYcX/dLeKpZQTl7P8vh9nuk2HCqH+UGpgkAE/5TjZYF4Z7w0lvPJCpuJnBCbZsPFyAYpcd+DXzJfxairA8IrlwDxq358ZzZts/SoKHFGZAjpMUzdLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FEC0C3277B;
	Wed,  3 Jul 2024 13:57:31 +0000 (UTC)
Date: Wed, 3 Jul 2024 14:57:29 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: David Hildenbrand <david@redhat.com>
Cc: Yang Shi <yang@os.amperecomputing.com>, muchun.song@linux.dev,
	will@kernel.org, akpm@linux-foundation.org, linux-mm@kvack.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hugetlbfs: add MTE support
Message-ID: <ZoVYyYx7-1R_lvW5@arm.com>
References: <20240625233717.2769975-1-yang@os.amperecomputing.com>
 <ZoPz14fYSqVyvRTw@arm.com>
 <fcf036e1-d65c-4a4b-9280-19024bb4da1b@redhat.com>
 <9dd065aa-f377-4b4c-893a-df69c9f67360@os.amperecomputing.com>
 <cdc28193-5748-41a0-9308-6ef1f0be3690@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cdc28193-5748-41a0-9308-6ef1f0be3690@redhat.com>

On Wed, Jul 03, 2024 at 12:24:40PM +0200, David Hildenbrand wrote:
> On 03.07.24 02:20, Yang Shi wrote:
> > On 7/2/24 6:09 AM, David Hildenbrand wrote:
> > > On 02.07.24 14:34, Catalin Marinas wrote:
> > > > On Tue, Jun 25, 2024 at 04:37:17PM -0700, Yang Shi wrote:
> > > > > MTE can be supported on ram based filesystem. It is supported on tmpfs.
> > > > > There is use case to use MTE on hugetlbfs as well, adding MTE support.
> > > > > 
> > > > > Signed-off-by: Yang Shi <yang@os.amperecomputing.com>
> > > > > ---
> > > > >    fs/hugetlbfs/inode.c | 2 +-
> > > > >    1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > 
> > > > > diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> > > > > index ecad73a4f713..c34faef62daf 100644
> > > > > --- a/fs/hugetlbfs/inode.c
> > > > > +++ b/fs/hugetlbfs/inode.c
> > > > > @@ -110,7 +110,7 @@ static int hugetlbfs_file_mmap(struct file
> > > > > *file, struct vm_area_struct *vma)
> > > > >         * way when do_mmap unwinds (may be important on powerpc
> > > > >         * and ia64).
> > > > >         */
> > > > > -    vm_flags_set(vma, VM_HUGETLB | VM_DONTEXPAND);
> > > > > +    vm_flags_set(vma, VM_HUGETLB | VM_DONTEXPAND | VM_MTE_ALLOWED);
> > > > >        vma->vm_ops = &hugetlb_vm_ops;
> > > > 
> > > > Last time I checked, about a year ago, this was not sufficient. One
> > > > issue is that there's no arch_clear_hugetlb_flags() implemented by your
> > > > patch, leaving PG_arch_{2,3} set on a page. The other issue was that I
> > > > initially tried to do this only on the head page but this did not go
> > > > well with the folio_copy() -> copy_highpage() which expects the
> > > > PG_arch_* flags on each individual page. The alternative was for
> > > > arch_clear_hugetlb_flags() to iterate over all the pages in a folio.
> > > 
> > > This would likely also add a blocker for
> > > ARCH_WANT_OPTIMIZE_HUGETLB_VMEMMAP on arm64 (no idea if there are now
> > > ways to move forward with that now, or if we are still not sure if we
> > > can actually add support), correct?
> > 
> > IIUC, it is not. We just need to guarantee each subpage has
> > PG_mte_tagged flag and allocated tags. The HVO just maps the 7 vmemmap
> > pages for sub pages to the first page, they still see the flag and the
> > space for tag is not impacted, right? Did I miss something?
> 
> In the R/O vmemmap optimization we won't be able to modify the flags of the
> double-mapped vmemmap pages via the double mappings.
> 
> Of course, we could find HVO-specific ways to only modify the flags of the
> first vmemmap page, but it does sound wrong ...
> 
> Really, the question is if we can have a per-folio flag for hugetlb instead
> and avoid all that?

I think it is possible and I have some half-baked changes but got
distracted and never completed. The only issue I came across was
folio_copy() calling copy_highpage() on individual pages that did not
have the original PG_mte_tagged (PG_arch_2) flag. To avoid some races,
we also use PG_mte_lock (PG_arch_3) as some form of locking but for
optimisation we don't clear this flag after copying the tags and setting
PG_mte_tagged. So doing the checks on the head page only confuses the
tail page copying.

Even if we use PG_arch_3 as a proper lock bit and clear it after
tag copying, I'll need to check whether this can race with any
mprotect(PROT_MTE) that could cause losing tags or leaking tags (not
initialising the pages). set_pte_at() relies on the PG_mte_tagged flag
to decide whether to initialise the tags. The arm64 hugetlbfs supports
contiguous ptes, so we'd get multiple set_pte_at() calls.

Anyway, I think with some care it is doable, I just did not have the
time, nor did I see anyone asking for such feature until now.

-- 
Catalin

