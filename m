Return-Path: <linux-kernel+bounces-387303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF8A59B4F32
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 17:22:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9391F286755
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 16:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B2F51990D9;
	Tue, 29 Oct 2024 16:22:47 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED6E198E99
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 16:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730218967; cv=none; b=eWumwo31nh9I9HYURbypAKLfqpNTMdu0V2KFRa03qPZVNVy5ZPzLe+wVPMP3s9slwDygSDLid0/RlbSzFI0T0Qq9AUkEtlmjpwkjmNa0rAuSdZbc6TZOTiWTTQG9izmTFUxHmE7vVHxl/MGt4M6lldWrCw4LQgKTrwoDhB92sIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730218967; c=relaxed/simple;
	bh=FoeBvAoeLePVuxJ0KpC2FxGwDSaN5NhHcgbG5Er4P3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CDgbtshc0EUZUiVodq2KsKObLs77xdBQ4B6bn2BhkV5qRckIumphU4r2eQM4vTknD7Lo5YhBYkRsWSwNg0P1dN8SDJkvPfPKDQ5GFXLuOxMYGiz2okCzgMb1KPJRidNSRskKEYgBc5e/LKb431aZmlWATw7t5R2AYSfhBoim384=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82843C4CECD;
	Tue, 29 Oct 2024 16:22:44 +0000 (UTC)
Date: Tue, 29 Oct 2024 16:22:42 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Vlastimil Babka <vbabka@suse.cz>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Mark Brown <broonie@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Peter Xu <peterx@redhat.com>,
	linux-arm-kernel@lists.infradead.org, Will Deacon <will@kernel.org>,
	Aishwarya TCV <Aishwarya.TCV@arm.com>
Subject: Re: [PATCH hotfix 6.12 v2 4/8] mm: resolve faulty mmap_region()
 error path behaviour
Message-ID: <ZyEL0s_qiyAYURR2@arm.com>
References: <57mgmdx7wgfwci3yo3ggkmcnm3ujamgkwcccm77ypvmer5tegn@opiq3ceh2uvy>
 <ykzmur56ms7fm4midi6tbncjvcvf7ue4lp7e4orblrmwnefw3e@oa3enlpdrcrr>
 <bea02efe-a695-49e0-b15c-2270a82cadbf@lucifer.local>
 <CAHk-=whpXVBNvd0NJpw9=FGcuTuThwtfcKeM3Ug=Uk6kpChCPA@mail.gmail.com>
 <0b64edb9-491e-4dcd-8dc1-d3c8a336a49b@suse.cz>
 <CAHk-=wgE8410gu3EabjNEHhOYh1dyYwt23J62S4a9SYcwZUFhw@mail.gmail.com>
 <1608957a-d138-4401-98ef-7fbe5fb7c387@suse.cz>
 <cf1deb9b-c5c4-4e85-891d-62ecf9a04e0f@lucifer.local>
 <ZyD5iXikMzotl9mU@arm.com>
 <da15a72b-c1de-427b-a764-0ebbdd3f6a8e@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da15a72b-c1de-427b-a764-0ebbdd3f6a8e@lucifer.local>

On Tue, Oct 29, 2024 at 03:16:00PM +0000, Lorenzo Stoakes wrote:
> On Tue, Oct 29, 2024 at 03:04:41PM +0000, Catalin Marinas wrote:
> > On Mon, Oct 28, 2024 at 10:14:50PM +0000, Lorenzo Stoakes wrote:
> > > So continue to check VM_MTE_ALLOWED which arch_calc_vm_flag_bits() sets if
> > > MAP_ANON.
> > [...]
> > > diff --git a/mm/shmem.c b/mm/shmem.c
> > > index 4ba1d00fabda..e87f5d6799a7 100644
> > > --- a/mm/shmem.c
> > > +++ b/mm/shmem.c
> > > @@ -2733,9 +2733,6 @@ static int shmem_mmap(struct file *file, struct vm_area_struct *vma)
> > >  	if (ret)
> > >  		return ret;
> > >
> > > -	/* arm64 - allow memory tagging on RAM-based files */
> > > -	vm_flags_set(vma, VM_MTE_ALLOWED);
> >
> > This breaks arm64 KVM if the VMM uses shared mappings for the memory
> > slots (which is possible). We have kvm_vma_mte_allowed() that checks for
> > the VM_MTE_ALLOWED flag as the VMM may not use PROT_MTE/VM_MTE directly.
> 
> Ugh yup missed that thanks.
> 
> > I need to read this thread properly but why not pass the file argument
> > to arch_calc_vm_flag_bits() and set VM_MTE_ALLOWED in there?
> 
> Can't really do that as it is entangled in a bunch of other stuff,
> e.g. calc_vm_prot_bits() would have to pass file and that's used in a bunch
> of places including arch code and... etc. etc.

Not calc_vm_prot_bits() but calc_vm_flag_bits().
arch_calc_vm_flag_bits() is only implemented by two architectures -
arm64 and parisc and calc_vm_flag_bits() is only called from do_mmap().

Basically we want to set VM_MTE_ALLOWED early during the mmap() call
and, at the time, my thinking was to do it in calc_vm_flag_bits(). The
calc_vm_prot_bits() OTOH is also called on the mprotect() path and is
responsible for translating PROT_MTE into a VM_MTE flag without any
checks. arch_validate_flags() would check if VM_MTE comes together with
VM_MTE_ALLOWED. But, as in the KVM case, that's not the only function
checking VM_MTE_ALLOWED.

Since calc_vm_flag_bits() did not take a file argument, the lazy
approach was to add the flag explicitly for shmem (and hugetlbfs in
-next). But I think it would be easier to just add the file argument to
calc_vm_flag_bits() and do the check in the arch code to return
VM_MTE_ALLOWED. AFAICT, this is called before mmap_region() and
arch_validate_flags() (unless I missed something in the recent
reworking).

> I suggest instead we instead don't drop the yucky shmem thing, which will
> set VM_MTE_ALLOWED for shmem, with arch_calc_vm_flag_bits() still setting
> it for MAP_ANON, but the other changes will mean the arch_validate_flags()
> will be fixed too.
> 
> So this just means not dropping the mm/shmem.c bit basically and everything
> should 'just work'?

If we can't get the calc_vm_flag_bits() approach to work, I'm fine with
this as a fix and we'll look to do it properly from 6.13.

-- 
Catalin

