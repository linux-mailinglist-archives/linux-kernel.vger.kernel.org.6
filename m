Return-Path: <linux-kernel+bounces-281283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 582B794D516
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 18:54:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FFE51C22AEB
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 16:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F722941B;
	Fri,  9 Aug 2024 16:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yd00n64u"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD9922087
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 16:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723222450; cv=none; b=pNsdLI/xdfuGfnWP46cZ3aX75SPXE2Y/ciTinM+rXychSVAt/CdKFd4472JoF+GnGurZUuIcyhVN1eucbrRTqPK6yUeoyHGZDAQs+kdl/Z7UKJlaFjmuFS+V5VGSkfxTT6uxWt+Ct+UtNGhsk85OCsC54MkTvFVhtK0VR9upEPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723222450; c=relaxed/simple;
	bh=DUGaX4dOaBc1SKm+QpUZxIx4yUNvGBVKHqKpcVtH7b0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FN+HryWNCu241h0IVnY3P2P6hFdvLUW2nkcWs9teWc6Rg5G6NaCdQmK7HJ5+C/XYZOLafznYsSbQWjPjDBhbJu3V0Db1fowFRpQB8wR7rmddmHc2jgmmCO8v+MhMHjF49Dcv+Yc1PvZR3XIx1qB0go9yayzCJiHkQt0t2qTtWY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Yd00n64u; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723222448;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=86nPCx79W6PGHL+fSL/w3sszGXq3z8SJRXsfiXl5Py8=;
	b=Yd00n64uRebULzb//ETznVQTiLn5Z8Q6elTJSV2V9WnbH5tjLVLTPms+CeqqtxGQrjBbG8
	mxv7c9PV56UwQiXgZMbz4mvxLLYgapoyCC6pvFGMJ2k0DMXb9yVqHat/PFVgMoCPVVMtIs
	vK+couAIINM7bDaMerWmakfnVHwalxA=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-493-7tAaW00OPEmPmn-8xoruJg-1; Fri, 09 Aug 2024 12:54:06 -0400
X-MC-Unique: 7tAaW00OPEmPmn-8xoruJg-1
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-7093890e502so485133a34.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 09:54:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723222446; x=1723827246;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=86nPCx79W6PGHL+fSL/w3sszGXq3z8SJRXsfiXl5Py8=;
        b=l6LJmkrxRw4z5ldxzC/1t5fsViszPftSsYGolWJ6GHWyl+TkM91QB9EkH3H6f03VSO
         hAOa5SW77iTZ5hkdPmRe0vW/adYveB2pUS735M/Fde89Qu7V1jWuZLPoOAbzulQnaz+i
         1TqPk9MH+ChiW4OHTI2Ot8/YDmmWkan11JynUZum9fH4+4000jLpjrw0oGR2zpMPafco
         jB9bZKEUosf/7AbCF5nCGPSIXoMu/0G7R44DiZrEKKaMvt/t7ri2mPlVnPBPkntbh1nB
         UBtFjEOZ4qh5djS0IfjSE2sJBWA0VmrdMjLsvCpCYIpq+maG0MCtaHPTrj3py2Pw27eP
         giXw==
X-Forwarded-Encrypted: i=1; AJvYcCW8vchlMdvdhQkSFxRyLwIwVw8nUOvX5GBlT7YHktgDn+uZcMT5lvetZCwIbiWOhDsWkcGAt5K2P5M4szM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+xf1rpE95JSWdakz8HuR/ZdO9NqwcES/BdKElcwgD1jecuTHr
	gVI1JpGlQ0FXcZeYXHFu29tNeCLFJYw+Dk0rGGorzRyX4/6DsI0wNe/nOpe1q4Rdp0M+M1FguVW
	7F46BuyI66FxXdkffXO3FGzoxWqbl1uEuZhICgn43jWFf4Mw/c2ozwfoWeipd9A==
X-Received: by 2002:a05:6830:2b25:b0:703:5c54:ddac with SMTP id 46e09a7af769-70b7470a670mr1628360a34.2.1723222445784;
        Fri, 09 Aug 2024 09:54:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGpuMCJfrpcp3WHIjMj9LLfZZ/K5MFK4Lv5p2xqcXiI3Eo7cosoDQu8/NAx31jVVYmRJIlX7w==
X-Received: by 2002:a05:6830:2b25:b0:703:5c54:ddac with SMTP id 46e09a7af769-70b7470a670mr1628345a34.2.1723222445418;
        Fri, 09 Aug 2024 09:54:05 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a3786cce67sm279215085a.116.2024.08.09.09.54.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 09:54:04 -0700 (PDT)
Date: Fri, 9 Aug 2024 12:54:01 -0400
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
Message-ID: <ZrZJqd8FBLU_GqFH@x1n>
References: <20240809160909.1023470-1-peterx@redhat.com>
 <20240809160909.1023470-7-peterx@redhat.com>
 <b103edb7-c41b-4a5b-9d9f-9690c5b25eb7@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b103edb7-c41b-4a5b-9d9f-9690c5b25eb7@redhat.com>

On Fri, Aug 09, 2024 at 06:20:06PM +0200, David Hildenbrand wrote:
> On 09.08.24 18:08, Peter Xu wrote:
> > Pfnmaps can always be identified with special bits in the ptes/pmds/puds.
> > However that's unnecessary if the vma is stable, and when it's mapped under
> > VM_PFNMAP | VM_IO.
> > 
> > Instead of adding similar checks in all the levels for huge pfnmaps, let
> > folio_walk_start() fail even earlier for these mappings.  It's also
> > something gup-slow already does, so make them match.
> > 
> > Cc: David Hildenbrand <david@redhat.com>
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >   mm/pagewalk.c | 5 +++++
> >   1 file changed, 5 insertions(+)
> > 
> > diff --git a/mm/pagewalk.c b/mm/pagewalk.c
> > index cd79fb3b89e5..fd3965efe773 100644
> > --- a/mm/pagewalk.c
> > +++ b/mm/pagewalk.c
> > @@ -727,6 +727,11 @@ struct folio *folio_walk_start(struct folio_walk *fw,
> >   	p4d_t *p4dp;
> >   	mmap_assert_locked(vma->vm_mm);
> > +
> > +	/* It has no folio backing the mappings at all.. */
> > +	if (vma->vm_flags & (VM_IO | VM_PFNMAP))
> > +		return NULL;
> > +
> 
> That is in general not what we want, and we still have some places that
> wrongly hard-code that behavior.
> 
> In a MAP_PRIVATE mapping you might have anon pages that we can happily walk.
> 
> vm_normal_page() / vm_normal_page_pmd() [and as commented as a TODO,
> vm_normal_page_pud()] should be able to identify PFN maps and reject them,
> no?

Yep, I think we can also rely on special bit.

When I was working on this whole series I must confess I am already
confused on the real users of MAP_PRIVATE pfnmaps.  E.g. we probably don't
need either PFNMAP for either mprotect/fork/... at least for our use case,
then VM_PRIVATE is even one step further.

Here I chose to follow gup-slow, and I suppose you meant that's also wrong?
If so, would it make sense we keep them aligned as of now, and change them
altogether?  Or do you think we should just rely on the special bits?

And, just curious: is there any use case you're aware of that can benefit
from caring PRIVATE pfnmaps yet so far, especially in this path?

As far as I read, none of folio_walk_start() users so far should even
stumble on top of a pfnmap, share or private.  But that's a fairly quick
glimps only.  IOW, I was wondering whether I'm just over cautious here.

Thanks,

-- 
Peter Xu


