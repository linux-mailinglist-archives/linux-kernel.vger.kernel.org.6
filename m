Return-Path: <linux-kernel+bounces-388697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC4D29B6333
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 13:39:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71DE72825F7
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 12:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1013E1E882F;
	Wed, 30 Oct 2024 12:39:38 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC3A1E4AE
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 12:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730291977; cv=none; b=Ht4/6kecFk0Sm85pGh0a5Sy669MH3YbSx6Tol0son969Qi272R/6fmo8cr0j8hr9CbBbzmf27o/gVQe5pQ4gsPCiPnjjAPacdWvkiMDfKDeRTDhF7kKyon5CSuhGLBoOtKCVL3FTLOMKS208RH05rnz9o50XrcwYXaQ3sfxCDQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730291977; c=relaxed/simple;
	bh=WlN1LOdiW+8HFQ7KCVA8tPTdNBNrAX0xNXccrvtrSCw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ePoZ/qAhkZJnsTKu6mmnRl/TqIx8kI2v+AcM6ivg63j1iEh2/RMHiuXuT+ufVoy/UvwL7VR2oE7jM91Q1bbtg45NB5QCikTyJIwCNvVlyFBU1zlGp6egKfZW9VvyWJV//ueKkZOybMY3X3O/gyLr6pxKyNkpHK1B7+MkguDSnUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37EE5C4CEE3;
	Wed, 30 Oct 2024 12:39:34 +0000 (UTC)
Date: Wed, 30 Oct 2024 12:39:31 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Xu <peterx@redhat.com>, Will Deacon <will@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	"James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
	Helge Deller <deller@gmx.de>,
	Yang Shi <yang@os.amperecomputing.com>
Subject: Re: [PATCH hotfix 6.12 v4 4/5] mm: refactor arch_calc_vm_flag_bits()
 and arm64 MTE handling
Message-ID: <ZyIpAwt0MSAhgs2t@arm.com>
References: <cover.1730224667.git.lorenzo.stoakes@oracle.com>
 <ec251b20ba1964fb64cf1607d2ad80c47f3873df.1730224667.git.lorenzo.stoakes@oracle.com>
 <f5495714-19ba-40b8-a3ac-fe395c075a36@suse.cz>
 <ZyIRbbA-_8duD2hH@arm.com>
 <c8760d0e-acbd-4fd6-b077-58b5c374cad3@suse.cz>
 <3f184fad-e0da-470a-888e-70a17419e206@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f184fad-e0da-470a-888e-70a17419e206@lucifer.local>

On Wed, Oct 30, 2024 at 11:53:06AM +0000, Lorenzo Stoakes wrote:
> On Wed, Oct 30, 2024 at 12:09:43PM +0100, Vlastimil Babka wrote:
> > On 10/30/24 11:58, Catalin Marinas wrote:
> > > On Wed, Oct 30, 2024 at 10:18:27AM +0100, Vlastimil Babka wrote:
> > >> On 10/29/24 19:11, Lorenzo Stoakes wrote:
> > >> > --- a/arch/arm64/include/asm/mman.h
> > >> > +++ b/arch/arm64/include/asm/mman.h
> > >> > @@ -6,6 +6,8 @@
> > >> >
> > >> >  #ifndef BUILD_VDSO
> > >> >  #include <linux/compiler.h>
> > >> > +#include <linux/fs.h>
> > >> > +#include <linux/shmem_fs.h>
> > >> >  #include <linux/types.h>
> > >> >
> > >> >  static inline unsigned long arch_calc_vm_prot_bits(unsigned long prot,
> > >> > @@ -31,19 +33,21 @@ static inline unsigned long arch_calc_vm_prot_bits(unsigned long prot,
> > >> >  }
> > >> >  #define arch_calc_vm_prot_bits(prot, pkey) arch_calc_vm_prot_bits(prot, pkey)
> > >> >
> > >> > -static inline unsigned long arch_calc_vm_flag_bits(unsigned long flags)
> > >> > +static inline unsigned long arch_calc_vm_flag_bits(struct file *file,
> > >> > +						   unsigned long flags)
> > >> >  {
> > >> >  	/*
> > >> >  	 * Only allow MTE on anonymous mappings as these are guaranteed to be
> > >> >  	 * backed by tags-capable memory. The vm_flags may be overridden by a
> > >> >  	 * filesystem supporting MTE (RAM-based).
> > >>
> > >> We should also eventually remove the last sentence or even replace it with
> > >> its negation, or somebody might try reintroducing the pattern that won't
> > >> work anymore (wasn't there such a hugetlbfs thing in -next?).
> > >
> > > I agree, we should update this comment as well though as a fix this
> > > patch is fine for now.
> > >
> > > There is indeed a hugetlbfs change in -next adding VM_MTE_ALLOWED. It
> > > should still work after the above change but we'd need to move it over
> >
> > I guess it will work after the above change, but not after 5/5?
> >
> > > here (and fix the comment at the same time). We'll probably do it around
> > > -rc1 or maybe earlier once this fix hits mainline.
> >
> > I assume this will hopefully go to rc7.
> 
> To be clear - this is a CRITICAL fix that MUST land for 6.12. I'd be inclined to
> try to get it to an earlier rc-.

Ah, good point. So after this series is merged at rc6/rc7, the new
MTE+hugetlbfs in -next won't work. Not an issue, it can be sorted out
later.

> > > I don't think we have
> > > an equivalent of shmem_file() for hugetlbfs, we'll need to figure
> > > something out.
> >
> > I've found is_file_hugepages(), could work? And while adding the hugetlbfs
> > change here, the comment could be adjusted too, right?
> 
> Right but the MAP_HUGETLB should work to? Can we save such changes that
> alter any kind of existing behaviour to later series?
> 
> As this is going to be backported (by me...!) and I don't want to risk
> inadvertant changes.

MAP_HUGETLB and is_file_hugepages() fixes can go in after 6.13-rc1. This
series is fine as is, we wouldn't backport any MAP_HUGETLB changes
anyway since the flag check wasn't the only issue that needed addressing
for hugetlb MTE mappings.

-- 
Catalin

