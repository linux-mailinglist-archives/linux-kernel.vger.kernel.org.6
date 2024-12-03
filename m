Return-Path: <linux-kernel+bounces-429235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 701109E1948
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 11:30:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 364F9160910
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 10:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E98501E1C2E;
	Tue,  3 Dec 2024 10:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KJKQCNP2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD8A1DFE1C
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 10:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733221852; cv=none; b=NTEVsZhvL2tBe+6RsKGEVWN2TaYEAwXvmwE/LNX5ujGhmwtKS8Pjje0LXej5kHqjQlogkJwuycuWX7K2sl+zXwQ47VXjnwftu28t+6Oy7WWZ3sZCQazVihB1FCs/O7xWmEYR9e33kx1EMU8+ISw3XATP7zF8+x2YAML1V/yfHao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733221852; c=relaxed/simple;
	bh=agBdfohU6uGT3pRcO1ECFkSQ2EcQqT8N7wKtnv6dwXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S1JK2ddfBqkr5k7hO4ynqOl6Gm2Ul6I9lx0J+Hnz9rMH6pbIjTe3HG30Dnfk4wzzaAFqM6CB0FarDOmtvWdOLxMM2EpSIGzMa4QIqy7u3gsu2fFgW3+mLWgNngeBw8dmjJZidQYx0Rbtp6omNJ8wc4H5KAVVJbesIi6Ea8jeFXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KJKQCNP2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733221849;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xnrtD1CQI4UR1z9IWtbJHJhqD1dW84dYt1dsSz0U8Bw=;
	b=KJKQCNP2OA8kz6o8IXE8xHqbRy/8zvqmlukWyLJISybobu6Vz5DxtOvn2NO3Nhtx9N5FAn
	YY6BLgrBc5RMhc8RunKlx2XTc1Wr+eHIMTTRF/9lq2dD3DpOzp8LcJims1FYlHLwk4qObO
	7pgTpQzDrBwPGCzwj57DAGvb55uee08=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-619-D3Q6V3QqOVefF15VLWutmQ-1; Tue,
 03 Dec 2024 05:30:44 -0500
X-MC-Unique: D3Q6V3QqOVefF15VLWutmQ-1
X-Mimecast-MFC-AGG-ID: D3Q6V3QqOVefF15VLWutmQ
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C83861955D83;
	Tue,  3 Dec 2024 10:30:42 +0000 (UTC)
Received: from localhost (unknown [10.72.113.10])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 208F01956054;
	Tue,  3 Dec 2024 10:30:40 +0000 (UTC)
Date: Tue, 3 Dec 2024 18:30:36 +0800
From: Baoquan He <bhe@redhat.com>
To: Yan Zhao <yan.y.zhao@intel.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
	"Kirill A. Shutemov" <kirill@shutemov.name>,
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev, x86@kernel.org,
	rick.p.edgecombe@intel.com, kirill.shutemov@linux.intel.com
Subject: Re: [PATCH] kexec_core: Accept unaccepted kexec destination addresses
Message-ID: <Z07dzP6ZdW3sNahj@MiWiFi-R3L-srv>
References: <87frop8r0y.fsf@email.froward.int.ebiederm.org>
 <tpbcun3d4wrnbtsvx3b3hjpdl47f2zuxvx6zqsjoelazdt3eyv@kgqnedtcejta>
 <87cyjq7rjo.fsf@email.froward.int.ebiederm.org>
 <ZxmRkUNmx863Po2U@yzhao56-desk.sh.intel.com>
 <Z0WzHZ+fNn6WuH/E@MiWiFi-R3L-srv>
 <Z0bt4HXAKqM3C1ZW@yzhao56-desk.sh.intel.com>
 <Z0iJ+DTPA2IkVDx7@MiWiFi-R3L-srv>
 <Z0lWkrsXSpDVfW72@yzhao56-desk.sh.intel.com>
 <Z03BbH5PgNrE81dz@MiWiFi-R3L-srv>
 <Z07YJlxK9/piXLhK@yzhao56-desk.sh.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z07YJlxK9/piXLhK@yzhao56-desk.sh.intel.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On 12/03/24 at 06:06pm, Yan Zhao wrote:
> On Mon, Dec 02, 2024 at 10:17:16PM +0800, Baoquan He wrote:
> > On 11/29/24 at 01:52pm, Yan Zhao wrote:
> > > On Thu, Nov 28, 2024 at 11:19:20PM +0800, Baoquan He wrote:
> > > > On 11/27/24 at 06:01pm, Yan Zhao wrote:
> > > > > On Tue, Nov 26, 2024 at 07:38:05PM +0800, Baoquan He wrote:
> > > > > > On 10/24/24 at 08:15am, Yan Zhao wrote:
> > > > > > > On Wed, Oct 23, 2024 at 10:44:11AM -0500, Eric W. Biederman wrote:
> > > > > > > > "Kirill A. Shutemov" <kirill@shutemov.name> writes:
> > > > > > > > 
> > > > > > > > > Waiting minutes to get VM booted to shell is not feasible for most
> > > > > > > > > deployments. Lazy is sane default to me.
> > > > > > > > 
> > > > > > > > Huh?
> > > > > > > > 
> > > > > > > > Unless my guesses about what is happening are wrong lazy is hiding
> > > > > > > > a serious implementation deficiency.  From all hardware I have seen
> > > > > > > > taking minutes is absolutely ridiculous.
> > > > > > > > 
> > > > > > > > Does writing to all of memory at full speed take minutes?  How can such
> > > > > > > > a system be functional?
> > > > > > > > 
> > > > > > > > If you don't actually have to write to the pages and it is just some
> > > > > > > > accounting function it is even more ridiculous.
> > > > > > > > 
> > > > > > > > 
> > > > > > > > I had previously thought that accept_memory was the firmware call.
> > > > > > > > Now that I see that it is just a wrapper for some hardware specific
> > > > > > > > calls I am even more perplexed.
> > > > > > > > 
> > > > > > > > 
> > > > > > > > Quite honestly what this looks like to me is that someone failed to
> > > > > > > > enable write-combining or write-back caching when writing to memory
> > > > > > > > when initializing the protected memory.  With the result that everything
> > > > > > > > is moving dog slow, and people are introducing complexity left and write
> > > > > > > > to avoid that bad implementation.
> > > > > > > > 
> > > > > > > > 
> > > > > > > > Can someone please explain to me why this accept_memory stuff has to be
> > > > > > > > slow, why it has to take minutes to do it's job.
> > > > > > > This kexec patch is a fix to a guest(TD)'s kexce failure.
> > > > > > > 
> > > > > > > For a linux guest, the accept_memory() happens before the guest accesses a page.
> > > > > > > It will (if the guest is a TD)
> > > > > > > (1) trigger the host to allocate the physical page on host to map the accessed
> > > > > > >     guest page, which might be slow with wait and sleep involved, depending on
> > > > > > >     the memory pressure on host.
> > > > > > > (2) initializing the protected page.
> > > > > > > 
> > > > > > > Actually most of guest memory are not accessed by guest during the guest life
> > > > > > > cycle. accept_memory() may cause the host to commit a never-to-be-used page,
> > > > > > > with the host physical page not even being able to get swapped out.
> > > > > > 
> > > > > > So this sounds to me more like a business requirement on cloud platform,
> > > > > > e.g if one customer books a guest instance with 60G memory, while the
> > > > > > customer actually always only cost 20G memory at most. Then the 40G memory
> > > > > > can be saved to reduce pressure for host.
> > > > > Yes.
> > > > 
> > > > That's very interesting, thanks for confirming.
> > > > 
> > > > > 
> > > > > > I could be shallow, just a wild guess.
> > > > > > If my guess is right, at least those cloud service providers must like this
> > > > > > accept_memory feature very much.
> > > > > > 
> > > > > > > 
> > > > > > > That's why we need a lazy accept, which does not accept_memory() until after a
> > > > > > > page is allocated by the kernel (in alloc_page(s)).
> > > > > > 
> > > > > > By the way, I have two questions, maybe very shallow.
> > > > > > 
> > > > > > 1) why can't we only find those already accepted memory to put kexec
> > > > > > kernel/initrd/bootparam/purgatory?
> > > > > 
> > > > > Currently, the first kernel only accepts memory during the memory allocation in
> > > > > a lazy accept mode. Besides reducing boot time, it's also good for memory
> > > > > over-commitment as you mentioned above.
> > > > > 
> > > > > My understanding of why the memory for the kernel/initrd/bootparam/purgatory is
> > > > > not allocated from the first kernel is that this memory usually needs to be
> > > > > physically contiguous. Since this memory will not be used by the first kernel,
> > > > > looking up from free RAM has a lower chance of failure compared to allocating it
> > > > 
> > > > Well, there could be misunderstanding here.The final loaded position of
> > > > kernel/initrd/bootparam/purgatory is not searched from free RAM, it's
> > > Oh, by free RAM, I mean system RAM that is marked as
> > > IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY, but not marked as
> > > IORESOURCE_SYSRAM_DRIVER_MANAGED.
> > > 
> > > 
> > > > just from RAM on x86. Means it possibly have been allocated and being
> > > > used by other component of 1st kernel. Not like kdump, the 2nd kernel of
> > > Yes, it's entirely possible that the destination address being searched out has
> > > already been allocated and is in use by the 1st kernel. e.g. for
> > > KEXEC_TYPE_DEFAULT, the source page for each segment is allocated from the 1st
> > > kernel, and it is allowed to have the same address as its corresponding
> > > destination address.
> > > 
> > > However, it's not guaranteed that the destination address must have been
> > > allocated by the 1st kernel.
> > > 
> > > > kexec reboot doesn't care about 1st kernel's memory usage. We will copy
> > > > them from intermediat position to the designated location when jumping.
> > > Right. If it's not guaranteed that the destination address has been accepted
> > > before this copying, the copying could trigger an error due to accessing an
> > > unaccepted page, which could be fatal for a linux TDX guest.
> > 
> > Oh, I just said the opposite. I meant we could search according to the
> > current unaccepted->bitmap to make sure the destination area definitely
> > have been accepted. This is the best if doable, while I know it's not
> > easy.
> Well, this sounds like introducing a new constraint in addition to the current
> checking of !kimage_is_destination_range() in locate_mem_hole_top_down() or
> locate_mem_hole_bottom_up(). (powerpc also has a different implementation).
> 
> This could make the success unpredictable, depending on how many pages have
> been accepted by the 1st kernel and the layout of the accepted pages(e.g.,
> whether they are physically contiguous). The 1st kernel would also have no
> reliable way to ensure success except by accepting all the guest pages.

Yeah, when I finished reading accept_memory code, this is the first idea
which come up into my mind. If it can be made, it's the most ideal. When
I tried to make a draft change, it does introduce a lot of code change and
add very much complication and I just gave up.

Maybe this can be added to cover-letter too to tell this possible path we
explored.


