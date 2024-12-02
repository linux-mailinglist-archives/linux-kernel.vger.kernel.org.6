Return-Path: <linux-kernel+bounces-427681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 622C29E049F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 15:17:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B0E5282711
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 14:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B92F1203711;
	Mon,  2 Dec 2024 14:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KXUh0mVc"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF7B2036FC
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 14:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733149052; cv=none; b=C/OXPa2mzPQMd/kkLtphX2sIlik1wkWEgjSrwSYP9GjHXLzTpcY2ceD2ql1CUHQ9DhyGpi91n9IW5Vf86S0KDrWoYACEuNdPopR+Mq2InrDXipfJz31dsquzyubUgcG76TiVAXUUz1G/rDZwofsTau/Z3CAGCouMhWzgtEWPZkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733149052; c=relaxed/simple;
	bh=l53eq6Gqpux6ZIPoGVWN74grMDjkSlFt7LppoiLq+dU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hzof8t8a7ajyXEtQsur81WRtvmpJXcoAdI9Et9PLqgU2+NYdfewihz+zNQhnSNbcRDdbDACZhKqDdIHhh2+Oxxyy4zPetDohwYdo90fvXDUlDE2KG2a1A1GPSa4WNwrqTRE2tLRnFwhKJG4wuQb5bmZR2LQlSFNTKf5hOAv4WRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KXUh0mVc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733149049;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WbP9zKYTPrlEKwNqt/TPMC6qYtfaqL70kVm05VnW98Q=;
	b=KXUh0mVcQNdDL8ROb3gHKCwNnQZ+Roqf3g0l9Qeck91F/WMAEMFjMgm4NOpILGLBCL2KsS
	DNP8tcNiCh4h3bvzRcd5DgFWyNTlRMABIgXgGrizl9seJndnskAhx2lvGEGtSpCB+GdiRz
	Nn0taB6KJxzcZjV1pB3aF6uwmbVrzOY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-651--A63-GJmPJa3r3qvii1ftw-1; Mon,
 02 Dec 2024 09:17:26 -0500
X-MC-Unique: -A63-GJmPJa3r3qvii1ftw-1
X-Mimecast-MFC-AGG-ID: -A63-GJmPJa3r3qvii1ftw
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DFA861955F43;
	Mon,  2 Dec 2024 14:17:24 +0000 (UTC)
Received: from localhost (unknown [10.72.113.10])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B33F5195605A;
	Mon,  2 Dec 2024 14:17:22 +0000 (UTC)
Date: Mon, 2 Dec 2024 22:17:16 +0800
From: Baoquan He <bhe@redhat.com>
To: Yan Zhao <yan.y.zhao@intel.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
	"Kirill A. Shutemov" <kirill@shutemov.name>,
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev, x86@kernel.org,
	rick.p.edgecombe@intel.com, kirill.shutemov@linux.intel.com
Subject: Re: [PATCH] kexec_core: Accept unaccepted kexec destination addresses
Message-ID: <Z03BbH5PgNrE81dz@MiWiFi-R3L-srv>
References: <20241021034553.18824-1-yan.y.zhao@intel.com>
 <87frop8r0y.fsf@email.froward.int.ebiederm.org>
 <tpbcun3d4wrnbtsvx3b3hjpdl47f2zuxvx6zqsjoelazdt3eyv@kgqnedtcejta>
 <87cyjq7rjo.fsf@email.froward.int.ebiederm.org>
 <ZxmRkUNmx863Po2U@yzhao56-desk.sh.intel.com>
 <Z0WzHZ+fNn6WuH/E@MiWiFi-R3L-srv>
 <Z0bt4HXAKqM3C1ZW@yzhao56-desk.sh.intel.com>
 <Z0iJ+DTPA2IkVDx7@MiWiFi-R3L-srv>
 <Z0lWkrsXSpDVfW72@yzhao56-desk.sh.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z0lWkrsXSpDVfW72@yzhao56-desk.sh.intel.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On 11/29/24 at 01:52pm, Yan Zhao wrote:
> On Thu, Nov 28, 2024 at 11:19:20PM +0800, Baoquan He wrote:
> > On 11/27/24 at 06:01pm, Yan Zhao wrote:
> > > On Tue, Nov 26, 2024 at 07:38:05PM +0800, Baoquan He wrote:
> > > > On 10/24/24 at 08:15am, Yan Zhao wrote:
> > > > > On Wed, Oct 23, 2024 at 10:44:11AM -0500, Eric W. Biederman wrote:
> > > > > > "Kirill A. Shutemov" <kirill@shutemov.name> writes:
> > > > > > 
> > > > > > > Waiting minutes to get VM booted to shell is not feasible for most
> > > > > > > deployments. Lazy is sane default to me.
> > > > > > 
> > > > > > Huh?
> > > > > > 
> > > > > > Unless my guesses about what is happening are wrong lazy is hiding
> > > > > > a serious implementation deficiency.  From all hardware I have seen
> > > > > > taking minutes is absolutely ridiculous.
> > > > > > 
> > > > > > Does writing to all of memory at full speed take minutes?  How can such
> > > > > > a system be functional?
> > > > > > 
> > > > > > If you don't actually have to write to the pages and it is just some
> > > > > > accounting function it is even more ridiculous.
> > > > > > 
> > > > > > 
> > > > > > I had previously thought that accept_memory was the firmware call.
> > > > > > Now that I see that it is just a wrapper for some hardware specific
> > > > > > calls I am even more perplexed.
> > > > > > 
> > > > > > 
> > > > > > Quite honestly what this looks like to me is that someone failed to
> > > > > > enable write-combining or write-back caching when writing to memory
> > > > > > when initializing the protected memory.  With the result that everything
> > > > > > is moving dog slow, and people are introducing complexity left and write
> > > > > > to avoid that bad implementation.
> > > > > > 
> > > > > > 
> > > > > > Can someone please explain to me why this accept_memory stuff has to be
> > > > > > slow, why it has to take minutes to do it's job.
> > > > > This kexec patch is a fix to a guest(TD)'s kexce failure.
> > > > > 
> > > > > For a linux guest, the accept_memory() happens before the guest accesses a page.
> > > > > It will (if the guest is a TD)
> > > > > (1) trigger the host to allocate the physical page on host to map the accessed
> > > > >     guest page, which might be slow with wait and sleep involved, depending on
> > > > >     the memory pressure on host.
> > > > > (2) initializing the protected page.
> > > > > 
> > > > > Actually most of guest memory are not accessed by guest during the guest life
> > > > > cycle. accept_memory() may cause the host to commit a never-to-be-used page,
> > > > > with the host physical page not even being able to get swapped out.
> > > > 
> > > > So this sounds to me more like a business requirement on cloud platform,
> > > > e.g if one customer books a guest instance with 60G memory, while the
> > > > customer actually always only cost 20G memory at most. Then the 40G memory
> > > > can be saved to reduce pressure for host.
> > > Yes.
> > 
> > That's very interesting, thanks for confirming.
> > 
> > > 
> > > > I could be shallow, just a wild guess.
> > > > If my guess is right, at least those cloud service providers must like this
> > > > accept_memory feature very much.
> > > > 
> > > > > 
> > > > > That's why we need a lazy accept, which does not accept_memory() until after a
> > > > > page is allocated by the kernel (in alloc_page(s)).
> > > > 
> > > > By the way, I have two questions, maybe very shallow.
> > > > 
> > > > 1) why can't we only find those already accepted memory to put kexec
> > > > kernel/initrd/bootparam/purgatory?
> > > 
> > > Currently, the first kernel only accepts memory during the memory allocation in
> > > a lazy accept mode. Besides reducing boot time, it's also good for memory
> > > over-commitment as you mentioned above.
> > > 
> > > My understanding of why the memory for the kernel/initrd/bootparam/purgatory is
> > > not allocated from the first kernel is that this memory usually needs to be
> > > physically contiguous. Since this memory will not be used by the first kernel,
> > > looking up from free RAM has a lower chance of failure compared to allocating it
> > 
> > Well, there could be misunderstanding here.The final loaded position of
> > kernel/initrd/bootparam/purgatory is not searched from free RAM, it's
> Oh, by free RAM, I mean system RAM that is marked as
> IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY, but not marked as
> IORESOURCE_SYSRAM_DRIVER_MANAGED.
> 
> 
> > just from RAM on x86. Means it possibly have been allocated and being
> > used by other component of 1st kernel. Not like kdump, the 2nd kernel of
> Yes, it's entirely possible that the destination address being searched out has
> already been allocated and is in use by the 1st kernel. e.g. for
> KEXEC_TYPE_DEFAULT, the source page for each segment is allocated from the 1st
> kernel, and it is allowed to have the same address as its corresponding
> destination address.
> 
> However, it's not guaranteed that the destination address must have been
> allocated by the 1st kernel.
> 
> > kexec reboot doesn't care about 1st kernel's memory usage. We will copy
> > them from intermediat position to the designated location when jumping.
> Right. If it's not guaranteed that the destination address has been accepted
> before this copying, the copying could trigger an error due to accessing an
> unaccepted page, which could be fatal for a linux TDX guest.

Oh, I just said the opposite. I meant we could search according to the
current unaccepted->bitmap to make sure the destination area definitely
have been accepted. This is the best if doable, while I know it's not
easy.

> 
> > If we take this way, we need search unaccepted->bitmap top down or
> > bottom up, according to setting. Then another suit of functions need
> > be provided. That looks a little complicated.
> Do you mean searching only accepted pages as destination addresses?
> That might increase the chance of failure compared to accepting the addressed
> being searched out.
> 
> > kexec_add_buffer()
> > -->arch_kexec_locate_mem_hole()
> >    -->kexec_locate_mem_hole()
> >       -->kexec_walk_memblock(kbuf, locate_mem_hole_callback) -- on arm64
> >       -->kexec_walk_resources(kbuf, locate_mem_hole_callback) -- on x86
> >          -->walk_system_ram_res_rev()
> 
> Yes.
> 
> 
> > Besides, the change in your patch has one issue. Usually we do kexec load to
> > read in the kernel/initrd/bootparam/purgatory, while they are loaded to
> > the destinations till kexec jumping. We could do kexec loading while 
> > never trigger the jumping, your change have done the accept_memory().
> > But this doesn't impact much because it always searched and found the
> > same location on one system.
> Right.
> Do you think it's good to move the accept to machine_kexec()?
> The machine_kexec() is platform specific though.

I am not sure if it's appropriate to accept in machine_kexec(). 

> 
> > > from the first kernel, especially when memory pressure is high in the first
> > > kernel.
> > > 
> > >  
> > > > 2) why can't we accept memory for (kernel, boot params/cmdline/initrd)
> > > > in 2nd kernel? Surely this purgatory still need be accepted in 1st kernel.
> > > > Sorry, I just read accept_memory() code, haven't gone through x86 boot
> > > > code flow.
> > > If a page is not already accepted, invoking accept_memory() will trigger a
> > > memory accept to zero-out the page content. So, for the pages passed to the
> > > second kernel, they must have been accepted before page content is copied in.
> > > 
> > > For boot params/cmdline/initrd, perhaps we could make those pages in shared
> > > memory initially and have the second kernel to accept private memory for copy.
> > > However, that would be very complex and IMHO not ideal.
> > 
> > I asked this because I saw your reply to Eric in another thread, quote
> > your saying at below. I am wondering why kernel can accept itself, why
> > other parts can't do it similarly.
> > =====
> > Yes, the kernel actually will accept initial memory used by itself in
> > extract_kernel(), as in arch/x86/boot/compressed/misc.c.
> > 
> > But the target kernel may not be able to accept memory for purgatory.
> > And it's currently does not accept memory for boot params/cmdline,
> > and initrd .
> > ====
> Thanks for pointing this out.
> I also found that my previous reply was confusing and misleading.
> 
> The 2nd kernel will accept the addresses before it decompresses itself there.
> Since these addresses are somewhere "random", the 2nd kernel (and for the 1st
> kernel for itself) needs to call accept_memory() in case that they might not
> have been accepted.
> 
> So, previously, I thought a workable approach might be for kexec to map the
> destination addresses in shared memory, perform the copy/jump, and then have the
> 2nd kernel accept the addresses for decompressing and other parts.
> However, aside from the complications and security concerns, this approach is
> problematic because the 2nd kernel may clear the pages by accepting them if the
> addresses for decompressing overlap with the ones before decompressing.
> 
> That said, would it be acceptable if I update the patch log and maybe also move
> the accept call to machine_kexec()?

Hmm, I think a repost seems necessary, even though this patch looks good
to me. If I do, I would add a cover letter to present with several sections:

1) background information: to explain what scenario the accept memory is
used for. And why accept all memory in kexec reboot case is not
expected.
2) the current problem: a brief description of the problem and itsroot cause;
3) How to fix it: here we can list all possible solutions we can thin of
and what drawbacks they have so that they are not chosen. Then we can
come to the final sotution that your current patch has to resort to
take.

As kexec maintainer, Eric's concerns are very important and need be resolved 
with as much information as possible to let him be happy with the
change, at least let him not hate it. This is my personal suggestion as a
reviewer. You can put them into cover letter if you think it's not good to add
them all in a standalone patch.

> 
> New patch log:
> The kexec segments's destination addresses are searched from the memblock
> or RAM resources. They are not allocated by the first kernel, though they
> may overlap with the memory in used by the first kernel. So, it is not
> guaranteed that they are accepted before kexec relocates to the second
> kernel.
> 
> Accept the destination addresses before kexec relocates to the second
> kernel, since kexec would access them by swapping content of source and
> destination pages.
> 


