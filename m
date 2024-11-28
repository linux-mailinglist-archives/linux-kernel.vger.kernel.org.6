Return-Path: <linux-kernel+bounces-424860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74DB89DBA5F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 16:19:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3529D2815E6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 15:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 683AB1B2198;
	Thu, 28 Nov 2024 15:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EIyJSqyk"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE7E19CD13
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 15:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732807178; cv=none; b=UKcd1rNG5R00Q4HT+FsCfwyMQHsvvHL5VQ37VOUfwC6Ofw1GHSLMzXp2c3uAVB39nWZFkA56Cw+gtjYyipljMRDcbiNpVvqttXiQntq0YVX42LqdAClZYxciv6OPpoAn+ava+LXphcmUe6BRwK9qNpWYjW6RS0lgX4gfUwMrWm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732807178; c=relaxed/simple;
	bh=YyZedDy3okp0nALDPsjnZBP0zJTRMrEGnyJvxVpfScI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K0vh0+AQbIGHsTn29uoU+aGUDUp2hZTEoi8ClRQIblH3pB4/vHte27kyDj53AtwiOJMDBO+8prUgvhpONc0FVSvhwyCW6U1snrLdKnt+oqS9jBlHw3ptF53E/8iktQ4tRJqVvSo+T7MY2yS1jil7RXNwz41HbkBmuxtX6SnMmLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EIyJSqyk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732807175;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Id6THo/fI6vVef/8Eixc+rBcXSt5nmBVRnKcFs3SFmM=;
	b=EIyJSqykR956lAqGSnGBvdacaqUxa+rGJe5xbAOwiq4j/RxFy5iCh0fp6NDBbcPTRCM+Hz
	scodyMB0DLcU47ubVhFfoNssKqWPLE7iv0cuRUgSoZXsEjNWnhgcRnksrYKmVV2cZIdSwH
	seyyCIiYZBYT5pXu0khby8oH9Zn1Q6Q=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-564-dqbCfCTmNz2cQMULusPfFw-1; Thu,
 28 Nov 2024 10:19:31 -0500
X-MC-Unique: dqbCfCTmNz2cQMULusPfFw-1
X-Mimecast-MFC-AGG-ID: dqbCfCTmNz2cQMULusPfFw
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 91E1C19560AB;
	Thu, 28 Nov 2024 15:19:27 +0000 (UTC)
Received: from localhost (unknown [10.72.113.10])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 99DF1195605A;
	Thu, 28 Nov 2024 15:19:25 +0000 (UTC)
Date: Thu, 28 Nov 2024 23:19:20 +0800
From: Baoquan He <bhe@redhat.com>
To: Yan Zhao <yan.y.zhao@intel.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
	"Kirill A. Shutemov" <kirill@shutemov.name>,
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev, x86@kernel.org,
	rick.p.edgecombe@intel.com, kirill.shutemov@linux.intel.com
Subject: Re: [PATCH] kexec_core: Accept unaccepted kexec destination addresses
Message-ID: <Z0iJ+DTPA2IkVDx7@MiWiFi-R3L-srv>
References: <20241021034553.18824-1-yan.y.zhao@intel.com>
 <87frop8r0y.fsf@email.froward.int.ebiederm.org>
 <tpbcun3d4wrnbtsvx3b3hjpdl47f2zuxvx6zqsjoelazdt3eyv@kgqnedtcejta>
 <87cyjq7rjo.fsf@email.froward.int.ebiederm.org>
 <ZxmRkUNmx863Po2U@yzhao56-desk.sh.intel.com>
 <Z0WzHZ+fNn6WuH/E@MiWiFi-R3L-srv>
 <Z0bt4HXAKqM3C1ZW@yzhao56-desk.sh.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z0bt4HXAKqM3C1ZW@yzhao56-desk.sh.intel.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On 11/27/24 at 06:01pm, Yan Zhao wrote:
> On Tue, Nov 26, 2024 at 07:38:05PM +0800, Baoquan He wrote:
> > On 10/24/24 at 08:15am, Yan Zhao wrote:
> > > On Wed, Oct 23, 2024 at 10:44:11AM -0500, Eric W. Biederman wrote:
> > > > "Kirill A. Shutemov" <kirill@shutemov.name> writes:
> > > > 
> > > > > Waiting minutes to get VM booted to shell is not feasible for most
> > > > > deployments. Lazy is sane default to me.
> > > > 
> > > > Huh?
> > > > 
> > > > Unless my guesses about what is happening are wrong lazy is hiding
> > > > a serious implementation deficiency.  From all hardware I have seen
> > > > taking minutes is absolutely ridiculous.
> > > > 
> > > > Does writing to all of memory at full speed take minutes?  How can such
> > > > a system be functional?
> > > > 
> > > > If you don't actually have to write to the pages and it is just some
> > > > accounting function it is even more ridiculous.
> > > > 
> > > > 
> > > > I had previously thought that accept_memory was the firmware call.
> > > > Now that I see that it is just a wrapper for some hardware specific
> > > > calls I am even more perplexed.
> > > > 
> > > > 
> > > > Quite honestly what this looks like to me is that someone failed to
> > > > enable write-combining or write-back caching when writing to memory
> > > > when initializing the protected memory.  With the result that everything
> > > > is moving dog slow, and people are introducing complexity left and write
> > > > to avoid that bad implementation.
> > > > 
> > > > 
> > > > Can someone please explain to me why this accept_memory stuff has to be
> > > > slow, why it has to take minutes to do it's job.
> > > This kexec patch is a fix to a guest(TD)'s kexce failure.
> > > 
> > > For a linux guest, the accept_memory() happens before the guest accesses a page.
> > > It will (if the guest is a TD)
> > > (1) trigger the host to allocate the physical page on host to map the accessed
> > >     guest page, which might be slow with wait and sleep involved, depending on
> > >     the memory pressure on host.
> > > (2) initializing the protected page.
> > > 
> > > Actually most of guest memory are not accessed by guest during the guest life
> > > cycle. accept_memory() may cause the host to commit a never-to-be-used page,
> > > with the host physical page not even being able to get swapped out.
> > 
> > So this sounds to me more like a business requirement on cloud platform,
> > e.g if one customer books a guest instance with 60G memory, while the
> > customer actually always only cost 20G memory at most. Then the 40G memory
> > can be saved to reduce pressure for host.
> Yes.

That's very interesting, thanks for confirming.

> 
> > I could be shallow, just a wild guess.
> > If my guess is right, at least those cloud service providers must like this
> > accept_memory feature very much.
> > 
> > > 
> > > That's why we need a lazy accept, which does not accept_memory() until after a
> > > page is allocated by the kernel (in alloc_page(s)).
> > 
> > By the way, I have two questions, maybe very shallow.
> > 
> > 1) why can't we only find those already accepted memory to put kexec
> > kernel/initrd/bootparam/purgatory?
> 
> Currently, the first kernel only accepts memory during the memory allocation in
> a lazy accept mode. Besides reducing boot time, it's also good for memory
> over-commitment as you mentioned above.
> 
> My understanding of why the memory for the kernel/initrd/bootparam/purgatory is
> not allocated from the first kernel is that this memory usually needs to be
> physically contiguous. Since this memory will not be used by the first kernel,
> looking up from free RAM has a lower chance of failure compared to allocating it

Well, there could be misunderstanding here.The final loaded position of
kernel/initrd/bootparam/purgatory is not searched from free RAM, it's
just from RAM on x86. Means it possibly have been allocated and being
used by other component of 1st kernel. Not like kdump, the 2nd kernel of
kexec reboot doesn't care about 1st kernel's memory usage. We will copy
them from intermediat position to the designated location when jumping.

If we take this way, we need search unaccepted->bitmap top down or
bottom up, according to setting. Then another suit of functions need
be provided. That looks a little complicated.

kexec_add_buffer()
-->arch_kexec_locate_mem_hole()
   -->kexec_locate_mem_hole()
      -->kexec_walk_memblock(kbuf, locate_mem_hole_callback) -- on arm64
      -->kexec_walk_resources(kbuf, locate_mem_hole_callback) -- on x86
         -->walk_system_ram_res_rev()

Besides, the change in your patch has one issue. Usually we do kexec load to
read in the kernel/initrd/bootparam/purgatory, while they are loaded to
the destinations till kexec jumping. We could do kexec loading while 
never trigger the jumping, your change have done the accept_memory().
But this doesn't impact much because it always searched and found the
same location on one system.

> from the first kernel, especially when memory pressure is high in the first
> kernel.
> 
>  
> > 2) why can't we accept memory for (kernel, boot params/cmdline/initrd)
> > in 2nd kernel? Surely this purgatory still need be accepted in 1st kernel.
> > Sorry, I just read accept_memory() code, haven't gone through x86 boot
> > code flow.
> If a page is not already accepted, invoking accept_memory() will trigger a
> memory accept to zero-out the page content. So, for the pages passed to the
> second kernel, they must have been accepted before page content is copied in.
> 
> For boot params/cmdline/initrd, perhaps we could make those pages in shared
> memory initially and have the second kernel to accept private memory for copy.
> However, that would be very complex and IMHO not ideal.

I asked this because I saw your reply to Eric in another thread, quote
your saying at below. I am wondering why kernel can accept itself, why
other parts can't do it similarly.
=====
Yes, the kernel actually will accept initial memory used by itself in
extract_kernel(), as in arch/x86/boot/compressed/misc.c.

But the target kernel may not be able to accept memory for purgatory.
And it's currently does not accept memory for boot params/cmdline,
and initrd .
====


