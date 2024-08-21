Return-Path: <linux-kernel+bounces-296046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 728DB95A4D4
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 20:42:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29B54284904
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 18:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBB171B5308;
	Wed, 21 Aug 2024 18:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KhnrU+u1"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B091B1D4E
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 18:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724265737; cv=none; b=TH9tYYA+zi8yn3wtnbftneIIG4+0cXdyNl9Hh5M2A7TIKTvSaF63vqiAW6IMLYk2FwOgJ8jj3E7Ya1W+vjVMQH4xid9uhyuQXQaR3WNIeqmrS98cmyrKZ5OAr5XJ/Hp/lfoXCzYvBviGVbM4rX8xdPVHPX8KDJilWeMeHCReqQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724265737; c=relaxed/simple;
	bh=bFgyN/kXvo7b/UScYydAHDHbvcJhOi0knnbOTkA5tTU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fB2TJfuIbRxkQODFjmNNhnercS9uVyz0U+2MaFcP7V5noUs1RpUZMXjO7PXTBueP4izaNQHSdsHgao1JqEHoEuAb9x3A1Sd4zF0VmHRWiF6JxJ4DXUWz+Xe/raF3+DeWkHtozZoUIMnxQ6x5mPHkX/+jRMCuAPxDFOKqARr9wSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KhnrU+u1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724265734;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bxtRUWPBJDHjggPAMnTH/KRZh2Re9tIX9Caj2lJIIn8=;
	b=KhnrU+u1SBPArje1RW1IRIyP/5NCy6pkkTejvIRDyTNLrUu5DBpi7dGX2v+PHUQg/HOc1M
	q14dLm+cpuqBVQEZxJCGs1e+1PfZUvH5f8LR0mpYPebtHqeJaaHWK7yK8Fhr9HSo4fnHmW
	ExsHArgxdgf6Qp+/R7+neSQW+hF7uBM=
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-173-YGvHT16kOFyQscpqjz7slg-1; Wed, 21 Aug 2024 14:42:12 -0400
X-MC-Unique: YGvHT16kOFyQscpqjz7slg-1
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-4f52183a0f8so7666e0c.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 11:42:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724265732; x=1724870532;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bxtRUWPBJDHjggPAMnTH/KRZh2Re9tIX9Caj2lJIIn8=;
        b=p8Akruwrf0zuqCPn/jCKBnIbtskX9jQtcwb8Gq8yYPcTog38BXn7duk9kvV24BQdAy
         Fmofp2QZ0u8OiBTeypMNx/Z0RbFDYZKcy6PFL+LafAVy+EUyrhjepyapZON6D7NgNeg0
         d0pAvbSX1hYT2Dz4HGG3r1Bs8CyV56Bfoao2P2tdij6efwCfKJHEKXOajMPyxtLQbxzC
         7TIz0Jx6lhQ35hjTL0ZIH3Hrmdt6k9bhrSu1pbkCGVfQtMXP7+EXipBHDPimm+ugDMW4
         +uRupo4MUE9NBGsffy8DK8/mTe0XVIlDFkftWaG4jw84m84YsJdy2kVjrM1VSx1Nvh/O
         35lQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3fdEKIWDTxG5X2Dr0AIvlM0GalQQguIIQWFdpVj8kF6znvS/b+bd7Z0orhUjsQSENHpr7oUA9kCRQIss=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPJSrA4tMszIAqHKWn0Kf527hHnv9XB109snifgQNvFAoMy9CK
	WZ03OBL44RneirO1AgOMbPQDhNjoac+PbIhIhAbpP2EZ0y5XXuoYtzZ4/4ujWR5JXV22yUYaPtN
	gV/7h3srDyio7XUuYonIW4adesNVGx6jIldqAWIAQCXoZpCEpRvHXh8yDOuENzQ==
X-Received: by 2002:a05:6122:31aa:b0:4f5:2276:1366 with SMTP id 71dfb90a1353d-4fcf359b050mr3850779e0c.3.1724265732172;
        Wed, 21 Aug 2024 11:42:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF2LW4+n8nTAfSzrfkkM6791Kkp4/ULsaTSZO+hvp6iv7hAwAb2/BkSllzEF9UW3wJdZt4VMA==
X-Received: by 2002:a05:6122:31aa:b0:4f5:2276:1366 with SMTP id 71dfb90a1353d-4fcf359b050mr3850745e0c.3.1724265731697;
        Wed, 21 Aug 2024 11:42:11 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bf6ff0fbb8sm63382556d6.144.2024.08.21.11.42.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 11:42:11 -0700 (PDT)
Date: Wed, 21 Aug 2024 14:42:08 -0400
From: Peter Xu <peterx@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Sean Christopherson <seanjc@google.com>,
	Oscar Salvador <osalvador@suse.de>,
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
Message-ID: <ZsY1ABO25MelPQDF@x1n>
References: <20240809160909.1023470-1-peterx@redhat.com>
 <20240809160909.1023470-7-peterx@redhat.com>
 <b103edb7-c41b-4a5b-9d9f-9690c5b25eb7@redhat.com>
 <ZrZJqd8FBLU_GqFH@x1n>
 <d9d1b682-cf3c-4808-ba50-56c75a406dae@redhat.com>
 <20240814130525.GH2032816@nvidia.com>
 <81080764-7c94-463f-80d3-e3b2968ddf5f@redhat.com>
 <Zr9gXek8ScalQs33@x1n>
 <20240816173836.GD2032816@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240816173836.GD2032816@nvidia.com>

On Fri, Aug 16, 2024 at 02:38:36PM -0300, Jason Gunthorpe wrote:
> On Fri, Aug 16, 2024 at 10:21:17AM -0400, Peter Xu wrote:
> > On Fri, Aug 16, 2024 at 11:30:31AM +0200, David Hildenbrand wrote:
> > > On 14.08.24 15:05, Jason Gunthorpe wrote:
> > > > On Fri, Aug 09, 2024 at 07:25:36PM +0200, David Hildenbrand wrote:
> > > > 
> > > > > > > That is in general not what we want, and we still have some places that
> > > > > > > wrongly hard-code that behavior.
> > > > > > > 
> > > > > > > In a MAP_PRIVATE mapping you might have anon pages that we can happily walk.
> > > > > > > 
> > > > > > > vm_normal_page() / vm_normal_page_pmd() [and as commented as a TODO,
> > > > > > > vm_normal_page_pud()] should be able to identify PFN maps and reject them,
> > > > > > > no?
> > > > > > 
> > > > > > Yep, I think we can also rely on special bit.
> > > > 
> > > > It is more than just relying on the special bit..
> > > > 
> > > > VM_PFNMAP/VM_MIXEDMAP should really only be used inside
> > > > vm_normal_page() because thay are, effectively, support for a limited
> > > > emulation of the special bit on arches that don't have them. There are
> > > > a bunch of weird rules that are used to try and make that work
> > > > properly that have to be followed.
> > > > 
> > > > On arches with the sepcial bit they should possibly never be checked
> > > > since the special bit does everything you need.
> > > > 
> > > > Arguably any place reading those flags out side of vm_normal_page/etc
> > > > is suspect.
> > > 
> > > IIUC, your opinion matches mine: VM_PFNMAP/VM_MIXEDMAP and pte_special()/...
> > > usage should be limited to vm_normal_page/vm_normal_page_pmd/ ... of course,
> > > GUP-fast is special (one of the reason for "pte_special()" and friends after
> > > all).
> > 
> > The issue is at least GUP currently doesn't work with pfnmaps, while
> > there're potentially users who wants to be able to work on both page +
> > !page use cases.  Besides access_process_vm(), KVM also uses similar thing,
> > and maybe more; these all seem to be valid use case of reference the vma
> > flags for PFNMAP and such, so they can identify "it's pfnmap" or more
> > generic issues like "permission check error on pgtable".
> 
> Why are those valid compared with calling vm_normal_page() per-page
> instead?
> 
> What reason is there to not do something based only on the PFNMAP
> flag?

My comment was for answering "why VM_PFNMAP flags is needed outside
vm_normal_page()", because GUP lacks supports of it.

Are you suggesting we should support VM_PFNMAP in GUP, perhaps?

Thanks,

-- 
Peter Xu


