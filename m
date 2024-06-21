Return-Path: <linux-kernel+bounces-224040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EFF6911C65
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 09:07:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00A111F242A8
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 07:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1153168C1D;
	Fri, 21 Jun 2024 07:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X6dzxbMe"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE497155300
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 07:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718953652; cv=none; b=QLyBSBKOk6J/8p5UeoSNMpso7THTnElNqFrWtt1KZ+54kHuvnpVTvxe/a6W5IwTjEVFK7IBwcBDrYlr17BnXY3ViAO3wGi4bJoCIEJDHZEwB01WBWai7P6Owl/t4cl0Ss2T/MX8urZ9B2eRmJrvbOsYVb7WUOzDit/V3k0UfCLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718953652; c=relaxed/simple;
	bh=U7O/f4ugiEkC98DWZvtW3F9cYFCOjQxaBn1Mwd+XbA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fiul5hLKaYINUeJrf3glHbfr6rkmx747uWbsn6aRzJq9lPJm705b5dyqkWUXJlxdaK0ws6wNfRJVoJaOQ+IzBzU5HdKveTb45fGLPqpcAfXFLT5pwjv0l6g0Tfcc2RWETsyLEZhN0H8CUVceqJBGCxCD02gjnBkQ2T4lQFyuFbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X6dzxbMe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718953649;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pVNRr002L+NyIVSk486BNVmsI1O8j0gJ9CCkEeh4Wcg=;
	b=X6dzxbMemdhJJu6M2eA/eYUKCWfaLs9FXIIr5jAA/dqnK5qYVazOzoJ+sRMQ3zAxUNvFdk
	ySbdlbCchdJTIGWNEgf9o+Jnw/wUSruZidE3gFpef36gTomcK2g7Svt1msrXJWULoFrW0z
	ffzcgArXW3bfbOl0NlBN1av6KP4nQbc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-526-FE3XjoE-MH2DRKwjKcM-DQ-1; Fri,
 21 Jun 2024 03:07:24 -0400
X-MC-Unique: FE3XjoE-MH2DRKwjKcM-DQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E01451956096;
	Fri, 21 Jun 2024 07:07:22 +0000 (UTC)
Received: from localhost (unknown [10.72.112.17])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4738F19560AF;
	Fri, 21 Jun 2024 07:07:20 +0000 (UTC)
Date: Fri, 21 Jun 2024 15:07:16 +0800
From: Baoquan He <bhe@redhat.com>
To: Hailong Liu <hailong.liu@oppo.com>, Nick Bowler <nbowler@draconx.ca>
Cc: linux-kernel@vger.kernel.org,
	Linux regressions mailing list <regressions@lists.linux.dev>,
	linux-mm@kvack.org, sparclinux@vger.kernel.org,
	"Uladzislau Rezki (Sony)" <urezki@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: PROBLEM: kernel crashes when running xfsdump since ~6.4
Message-ID: <ZnUmpMbCBFWnvaEz@MiWiFi-R3L-srv>
References: <75e17b57-1178-4288-b792-4ae68b19915e@draconx.ca>
 <00d74f24-c49c-460e-871c-d5af64701306@draconx.ca>
 <20240621033005.6mccm7waduelb4m5@oppo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240621033005.6mccm7waduelb4m5@oppo.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On 06/21/24 at 11:30am, Hailong Liu wrote:
> On Thu, 20. Jun 14:02, Nick Bowler wrote:
> > On 2024-06-20 02:19, Nick Bowler wrote:
> > > After upgrading my sparc to 6.9.5 I noticed that attempting to run
> > > xfsdump instantly (within a couple seconds) and reliably crashes the
> > > kernel.  The same problem is also observed on 6.10-rc4.
> > [...]
> > >   062eacf57ad91b5c272f89dc964fd6dd9715ea7d is the first bad commit
> > >   commit 062eacf57ad91b5c272f89dc964fd6dd9715ea7d
> > >   Author: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > >   Date:   Thu Mar 30 21:06:38 2023 +0200
> > >
> > >       mm: vmalloc: remove a global vmap_blocks xarray
> >
> > I think I might see what is happening here.
> >
> > On this machine, there are two CPUs numbered 0 and 2 (there is no CPU1).
> >
> +Baoquan

Thanks for adding me, Hailong.

> 
> Ahh, I thought you are right. addr_to_vb_xa assume that the CPU numbers are
> contiguous. I don't have knowledge about CPU at all.
> Technically change the implement addr_to_vb_xa() to
> return &per_cpu(vmap_block_queue, raw_smp_processor_id()).vmap_blocks;
> would also work, but it violate the load balance. Wating for
> experts reply.

Yeah, I think so as you explained.

> 
> > The per-cpu variables in mm/vmalloc.c are initialized like this, in
> > vmalloc_init
> >
> >   for_each_possible_cpu(i) {
> >     /* ... */
> >     vbq = &per_cpu(vmap_block_queue, i);
> >     /* initialize stuff in vbq */
> >   }
> >
> > This loops over the set bits of cpu_possible_mask, bits 0 and 2 are set,
> > so it initializes stuff with i=0 and i=2, skipping i=1 (I added prints to
> > confirm this).
> >
> > Then, in vm_map_ram, with the problematic change it calls the new
> > function addr_to_vb_xa, which does this:
> >
> >   int index = (addr / VMAP_BLOCK_SIZE) % num_possible_cpus();
> >   return &per_cpu(vmap_block_queue, index).vmap_blocks;
> >
> > The num_possible_cpus() function counts the number of set bits in
> > cpu_possible_mask, so it returns 2.  Thus, index is either 0 or 1, which
> > does not correspond to what was initialized (0 or 2).  The crash occurs
> > when the computed index is 1 in this function.  In this case, the
> > returned value appears to be garbage (I added prints to confirm this).

This is a great catch. 

> >
> > If I change addr_to_vb_xa function to this:
> >
> >   int index = ((addr / VMAP_BLOCK_SIZE) & 1) << 1; /* 0 or 2 */
> >   return &per_cpu(vmap_block_queue, index).vmap_blocks;

Yeah, while above change is not generic, e.g if it's CPU0 and CPU3.
I think we should take the max possible CPU number as the hush bucket
size. The vb->va is also got from global free_vmap_area, so no need to
worry about the waste.

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index be2dd281ea76..18e87cafbaf2 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2542,7 +2542,7 @@ static DEFINE_PER_CPU(struct vmap_block_queue, vmap_block_queue);
 static struct xarray *
 addr_to_vb_xa(unsigned long addr)
 {
-	int index = (addr / VMAP_BLOCK_SIZE) % num_possible_cpus();
+	int index = (addr / VMAP_BLOCK_SIZE) % nr_cpu_ids;
 
 	return &per_cpu(vmap_block_queue, index).vmap_blocks;
 }


