Return-Path: <linux-kernel+bounces-281585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5837B94D871
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 23:37:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DD44280E09
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 21:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86EF316A957;
	Fri,  9 Aug 2024 21:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KjrCaZVG"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0956115534B
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 21:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723239443; cv=none; b=q8yhK4XDpUJ3OP74Mnfb1acVdvhiNPZpHfumiCr8oJGObqvjUQgMEj4XsNxq692wSaNsb4AA59gJm6X/p65akZtYslmoQILgnlV6bt4fvkn6BJxGDcHxzLzlZ6QtzWGB8hRi4wnopP0kvB9y5+8CY8N2PJPiRcJi9s7GPO/PKuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723239443; c=relaxed/simple;
	bh=NiXQJJYuW1Qctir86KmE+BKryC0pQS3beDNfKWDAfCc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SCsO0HTkkddSTg9r05zuwOP4XH1TEMaoZHR6zBKqhv9rw3LxWEN8ke1K1Wz0fVQPlR0tadpQsLNLyZz5SVslpD2VGdA7V397HeRGUNW+pxyRvfslqSDWdnKzl6d8xVP/J3F+nNzUdFk7qGDS48bVeBE50k/y4zYyzNTPHONxHvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KjrCaZVG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723239441;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vLaN61XvMItpso5ET5hnaX5H7GrLf1LjcFKL/77gKXA=;
	b=KjrCaZVGoHENTdpuYKCZVJK3VfbfQoc3TV/wxa0aq7IZOQBWKaVaIAJv3ool4zKDYE7x2W
	8El5HZOKbgRrQhwRum3yIPESY+0uqgue7rB+dRoDo5pAuZfqUFSfJpbDBzZvJpHuP/Szmj
	hOJSRDa26c5vN/WJbGPqlDOwYmb9s50=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-JzJN_lPkPXiV2cCFr91Zyg-1; Fri, 09 Aug 2024 17:37:19 -0400
X-MC-Unique: JzJN_lPkPXiV2cCFr91Zyg-1
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-3dc29db029cso654739b6e.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 14:37:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723239439; x=1723844239;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vLaN61XvMItpso5ET5hnaX5H7GrLf1LjcFKL/77gKXA=;
        b=asHDsyHsSELit4t6Uy74YGoX4FU0Ja7MJdl7uhwdqtE7Q9lR1Ydz7SXcHjieku8Qha
         BzuiTPnoq1V8Im7UF4EUc++LaR7+YfiqbGKg2JQOP/JgzOdcgWg7KPkuAPO3Kx/sYVt0
         qzqgkisYJQPZN3VCcg7/aMx1xwp+V7a8JcfYxhJ91qn3M0Zf2pKpT0hT3G478f+SMbng
         CVHfAopwlySa+YI4BbPCB6Z2jH7JTjLO0Oqi/FGBMOc3JqoBgP8C3GDrXEt2PY3aXlpY
         hPvjzGHl1aS2aUmUki/mgcc1Js5V1XVTjo+rVbQPhaJOVWz/c8ddFBQJ7xmjRg3CFPWR
         nHYg==
X-Forwarded-Encrypted: i=1; AJvYcCWlV3Fh5KzfaG9UKU1xTG3yzB/eiCFwtR2pO0dnxWAq2g6Ml/V3Ix1Z71pK4vmxgyyZn6Z8EOw1s5D6UNfpDlCqxN4lPLGwqkc7ovRA
X-Gm-Message-State: AOJu0YwyPtFHbIfx1RyxUkNGm6Qp2y0XZFNfqfl1JrzbQPCRln3Udo0b
	DW9V5ZlqqiH+TYIC1cUL7IQhJCfnzlRBc5sJj47Tw3vUQEUCDCn95LDkzmBpo3knst6utLGkD0d
	xSL9kdvVnY78qLsWI9eBc/LhwxNHLK67O8tjvTppgULD0xZwYwHQYehZvR/6yYQ==
X-Received: by 2002:a05:6808:2113:b0:3d5:6338:49de with SMTP id 5614622812f47-3dc416e1f18mr1830092b6e.5.1723239438873;
        Fri, 09 Aug 2024 14:37:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHwM82YW2GARYPlTotghl2UYBNZ3FORuZWjx1vF1xR71aVPbyjVU6f+5Zh59bD0enYavl9npw==
X-Received: by 2002:a05:6808:2113:b0:3d5:6338:49de with SMTP id 5614622812f47-3dc416e1f18mr1830084b6e.5.1723239438516;
        Fri, 09 Aug 2024 14:37:18 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4531c1c30b7sm1479831cf.22.2024.08.09.14.37.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 14:37:17 -0700 (PDT)
Date: Fri, 9 Aug 2024 17:37:14 -0400
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Sean Christopherson <seanjc@google.com>,
	Oscar Salvador <osalvador@suse.de>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	linux-arm-kernel@lists.infradead.org, x86@kernel.org,
	Will Deacon <will@kernel.org>, Gavin Shan <gshan@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>, Zi Yan <ziy@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Ingo Molnar <mingo@redhat.com>,
	Alistair Popple <apopple@nvidia.com>,
	Borislav Petkov <bp@alien8.de>,
	Thomas Gleixner <tglx@linutronix.de>, kvm@vger.kernel.org,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Yan Zhao <yan.y.zhao@intel.com>
Subject: Re: [PATCH 06/19] mm/pagewalk: Check pfnmap early for
 folio_walk_start()
Message-ID: <ZraMCkGXKzobx5N3@x1n>
References: <20240809160909.1023470-1-peterx@redhat.com>
 <20240809160909.1023470-7-peterx@redhat.com>
 <b103edb7-c41b-4a5b-9d9f-9690c5b25eb7@redhat.com>
 <ZrZJqd8FBLU_GqFH@x1n>
 <d9d1b682-cf3c-4808-ba50-56c75a406dae@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d9d1b682-cf3c-4808-ba50-56c75a406dae@redhat.com>

On Fri, Aug 09, 2024 at 07:25:36PM +0200, David Hildenbrand wrote:
> On 09.08.24 18:54, Peter Xu wrote:
> > On Fri, Aug 09, 2024 at 06:20:06PM +0200, David Hildenbrand wrote:
> > > On 09.08.24 18:08, Peter Xu wrote:
> > > > Pfnmaps can always be identified with special bits in the ptes/pmds/puds.
> > > > However that's unnecessary if the vma is stable, and when it's mapped under
> > > > VM_PFNMAP | VM_IO.
> > > > 
> > > > Instead of adding similar checks in all the levels for huge pfnmaps, let
> > > > folio_walk_start() fail even earlier for these mappings.  It's also
> > > > something gup-slow already does, so make them match.
> > > > 
> > > > Cc: David Hildenbrand <david@redhat.com>
> > > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > > > ---
> > > >    mm/pagewalk.c | 5 +++++
> > > >    1 file changed, 5 insertions(+)
> > > > 
> > > > diff --git a/mm/pagewalk.c b/mm/pagewalk.c
> > > > index cd79fb3b89e5..fd3965efe773 100644
> > > > --- a/mm/pagewalk.c
> > > > +++ b/mm/pagewalk.c
> > > > @@ -727,6 +727,11 @@ struct folio *folio_walk_start(struct folio_walk *fw,
> > > >    	p4d_t *p4dp;
> > > >    	mmap_assert_locked(vma->vm_mm);
> > > > +
> > > > +	/* It has no folio backing the mappings at all.. */
> > > > +	if (vma->vm_flags & (VM_IO | VM_PFNMAP))
> > > > +		return NULL;
> > > > +
> > > 
> > > That is in general not what we want, and we still have some places that
> > > wrongly hard-code that behavior.
> > > 
> > > In a MAP_PRIVATE mapping you might have anon pages that we can happily walk.
> > > 
> > > vm_normal_page() / vm_normal_page_pmd() [and as commented as a TODO,
> > > vm_normal_page_pud()] should be able to identify PFN maps and reject them,
> > > no?
> > 
> > Yep, I think we can also rely on special bit.
> > 
> > When I was working on this whole series I must confess I am already
> > confused on the real users of MAP_PRIVATE pfnmaps.  E.g. we probably don't
> > need either PFNMAP for either mprotect/fork/... at least for our use case,
> > then VM_PRIVATE is even one step further.
> 
> Yes, it's rather a corner case indeed.
> > 
> > Here I chose to follow gup-slow, and I suppose you meant that's also wrong?
> 
> I assume just nobody really noticed, just like nobody noticed that
> walk_page_test() skips VM_PFNMAP (but not VM_IO :) ).

I noticed it, and that's one of the reasons why this series can be small,
as walk page callers are intact.

> 
> Your process memory stats will likely miss anon folios on COW PFNMAP
> mappings ... in the rare cases where they exist (e.g., mmap() of /dev/mem).

Do you mean /proc/$PID/status?  I thought that (aka, mm counters) should be
fine with anon pages CoWed on top of private pfnmaps, but possibly I
misunderstood what you meant.

> 
> > If so, would it make sense we keep them aligned as of now, and change them
> > altogether?  Or do you think we should just rely on the special bits?
> 
> GUP already refuses to work on a lot of other stuff, so likely not a good
> use of time unless somebody complains.
> 
> But yes, long-term we should make all code either respect that it could
> happen (and bury less awkward checks in page table walkers) or rip support
> for MAP_PRIVATE PFNMAP out completely.
> 
> > 
> > And, just curious: is there any use case you're aware of that can benefit
> > from caring PRIVATE pfnmaps yet so far, especially in this path?
> 
> In general MAP_PRIVATE pfnmaps is not really useful on things like MMIO.
> 
> There was a discussion (in VM_PAT) some time ago whether we could remove
> MAP_PRIVATE PFNMAPs completely [1]. At least some users still use COW
> mappings on /dev/mem, although not many (and they might not actually write
> to these areas).

Ah, looks like the private map on /dev/mem is the only thing we know.

> 
> I'm happy if someone wants to try ripping that out, I'm not brave enough :)
> 
> [1]
> https://lkml.kernel.org/r/1f2a8ed4-aaff-4be7-b3b6-63d2841a2908@redhat.com
> 
> > 
> > As far as I read, none of folio_walk_start() users so far should even
> > stumble on top of a pfnmap, share or private.  But that's a fairly quick
> > glimps only.
> 
> do_pages_stat()->do_pages_stat_array() should be able to trigger it, if you
> pass "nodes=NULL" to move_pages().

.. so assume this is also about private mapping over /dev/mem, then:
someone tries to write some pages there to some MMIO regions, then tries to
use move_pages() to fetch which node those pages locate?  Hmm.. OK :)

> 
> Maybe s390x could be tricked into it, but likely as you say, most code
> shouldn't trigger it. The function itself should be handling it correctly as
> of today, though.

So indeed I cannot justify it won't be used, and it's not a huge deal
indeed if we stick with special bits.  Let me go with that in the next
version for folio_walk_start().

Thanks,

-- 
Peter Xu


