Return-Path: <linux-kernel+bounces-288330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 739739538E6
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 19:21:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95C181C255CF
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 17:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 049511B4C4B;
	Thu, 15 Aug 2024 17:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZbL0X0qY"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D7729A1
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 17:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723742471; cv=none; b=pRE25Nv0ymg10QNrh0gkeybna1jCssvN0mVLA1474Qnh4hootXVGFyKao6swx5jbtqczcVLmQwxYAc3FuptVbb6Q6k2sHYsAwo8egPok+VdlJ/GWTsDX2Qi5JgnL7W0bpjR9C/NgHwjNeZCc3vNBhC3/4fwJAq9N+nuVIlVfG4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723742471; c=relaxed/simple;
	bh=jhM/cFHfhhJ6Ms9XzJ7pkPXXjW31JAoz5O0SjjIgqRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YKSOf/6/lFOb6hpM8evmOsQjR3zzwBYaSu/0PO7Zawq9/FJrP3Xx5A0UcT5orTm1F41F8V8RyiPfLp1HGBD0BAQ5/k0QdRyfwoBNWbKgQ9qoYXzXPKKjNDej0S/5BNkdQMG+NNnZPRh8GUVraXxBZQir3sbWHxiLx2rCVRgyhKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZbL0X0qY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723742468;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0UdGNGM4n0EJXKPbA0XiOUzOnUQaUwtu8wg6uziglrg=;
	b=ZbL0X0qY6uWKDL24yuBld8/isRRQ/lVWWc+jqMvXYcCZpYtD5L2+HnfwIEi4NJOfR2eTkw
	pumuSdQplQm756kuqSgzQo/4mMXLeRn0CoJSjGEisO4LIKex/w13v2pjiHW9QNhQs0wX1j
	r2H/qU5NpVRk2ivjIRCE5KysDf+4o8Q=
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-93-S1MZJItzOQ2pAoPglvU5Dw-1; Thu, 15 Aug 2024 13:21:06 -0400
X-MC-Unique: S1MZJItzOQ2pAoPglvU5Dw-1
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-4929a748c20so73108137.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 10:21:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723742466; x=1724347266;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0UdGNGM4n0EJXKPbA0XiOUzOnUQaUwtu8wg6uziglrg=;
        b=V0J5yRHv3lcQTSbFIog//K3fhsuuuRgms7DXxqKd6pEH+jYKiLNzq8T3hQuL9RWZya
         IVIwAdS42eqc4U24y0kJJkVV+XACnvEh9Mtj1gsBa/QKEzSmODjg42VVQcsg899SI1aj
         brFc8QppR81lMgCJzfToldFoTX2hr68D/vLjvr3A6PN1SOkm6RpBqQqzowe+shkDoILN
         7AMJ5o0lsNBtsMcqM3uWG2n/7I+Ng6dKt3uAXyuch85bpsRvTkrY1Nw8WfzlMYWt6lmv
         +zhrQqxXSQajnBoMUGmXTLnONEXc2QvtunZI0D/PYKUSTbnW80tXOanbh4inMjllgD7K
         0VdQ==
X-Forwarded-Encrypted: i=1; AJvYcCWcAmPhq0qZ2B9i7EVKkJW0kVvHck6Z1I3qnNcA/yz0BseWU07rC9uyy8TeJT2A+t2QvrsSnrl/y727OGdVtCGo+FHyscVs9A3eNRD/
X-Gm-Message-State: AOJu0YzGThPZjGXL/IdITyT4ex+CYjTQovsTEOrj/hCBaMYfAcn0mcE+
	is9pecFzVXtYRnnUfERTqc/esfM4XalM+vzANDaJVRD5fZ9tAWxEM0wD/7Y9X4/EYZklQKQK6LG
	eb2THMDJFQr4hZIJ560y3RE/fSNnmm8UHVyJQo74jh5Tn8kkXsR0JbtfddkVgZQ==
X-Received: by 2002:a05:6102:1614:b0:491:1e5b:8a0a with SMTP id ada2fe7eead31-497799c449bmr338936137.4.1723742465926;
        Thu, 15 Aug 2024 10:21:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFwrVDaObp41gdMHIuT2tGq6ulUs7glamf+9vgeunYMavhW1nsyHH5jRDCChiVsv3XfQ+9REQ==
X-Received: by 2002:a05:6102:1614:b0:491:1e5b:8a0a with SMTP id ada2fe7eead31-497799c449bmr338922137.4.1723742465544;
        Thu, 15 Aug 2024 10:21:05 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bf6ff0dcdasm7929396d6.140.2024.08.15.10.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 10:21:04 -0700 (PDT)
Date: Thu, 15 Aug 2024 13:21:01 -0400
From: Peter Xu <peterx@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
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
	David Hildenbrand <david@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>, kvm@vger.kernel.org,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Yan Zhao <yan.y.zhao@intel.com>
Subject: Re: [PATCH 09/19] mm: New follow_pfnmap API
Message-ID: <Zr44_VE_Z0qbH0yT@x1n>
References: <20240809160909.1023470-1-peterx@redhat.com>
 <20240809160909.1023470-10-peterx@redhat.com>
 <20240814131954.GK2032816@nvidia.com>
 <Zrz2b82-Z31h4Suy@x1n>
 <20240814221441.GB2032816@nvidia.com>
 <Zr4hs8AGbPRlieY4@x1n>
 <20240815161603.GH2032816@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240815161603.GH2032816@nvidia.com>

On Thu, Aug 15, 2024 at 01:16:03PM -0300, Jason Gunthorpe wrote:
> On Thu, Aug 15, 2024 at 11:41:39AM -0400, Peter Xu wrote:
> > On Wed, Aug 14, 2024 at 07:14:41PM -0300, Jason Gunthorpe wrote:
> > > On Wed, Aug 14, 2024 at 02:24:47PM -0400, Peter Xu wrote:
> > > > On Wed, Aug 14, 2024 at 10:19:54AM -0300, Jason Gunthorpe wrote:
> > > > > On Fri, Aug 09, 2024 at 12:08:59PM -0400, Peter Xu wrote:
> > > > > 
> > > > > > +/**
> > > > > > + * follow_pfnmap_start() - Look up a pfn mapping at a user virtual address
> > > > > > + * @args: Pointer to struct @follow_pfnmap_args
> > > > > > + *
> > > > > > + * The caller needs to setup args->vma and args->address to point to the
> > > > > > + * virtual address as the target of such lookup.  On a successful return,
> > > > > > + * the results will be put into other output fields.
> > > > > > + *
> > > > > > + * After the caller finished using the fields, the caller must invoke
> > > > > > + * another follow_pfnmap_end() to proper releases the locks and resources
> > > > > > + * of such look up request.
> > > > > > + *
> > > > > > + * During the start() and end() calls, the results in @args will be valid
> > > > > > + * as proper locks will be held.  After the end() is called, all the fields
> > > > > > + * in @follow_pfnmap_args will be invalid to be further accessed.
> > > > > > + *
> > > > > > + * If the PTE maps a refcounted page, callers are responsible to protect
> > > > > > + * against invalidation with MMU notifiers; otherwise access to the PFN at
> > > > > > + * a later point in time can trigger use-after-free.
> > > > > > + *
> > > > > > + * Only IO mappings and raw PFN mappings are allowed.  
> > > > > 
> > > > > What does this mean? The paragraph before said this can return a
> > > > > refcounted page?
> > > > 
> > > > This came from the old follow_pte(), I kept that as I suppose we should
> > > > allow VM_IO | VM_PFNMAP just like before, even if in this case I suppose
> > > > only the pfnmap matters where huge mappings can start to appear.
> > > 
> > > If that is the intention it should actively block returning anything
> > > that is vm_normal_page() not check the VM flags, see the other
> > > discussion..
> > 
> > The restriction should only be applied to the vma attributes, not a
> > specific pte mapping, IMHO.
> > 
> > I mean, the comment was describing "which VMA is allowed to use this
> > function", reflecting that we'll fail at anything !PFNMAP && !IO.
> > 
> > It seems legal to have private mappings of them, where vm_normal_page() can
> > return true here for some of the mappings under PFNMAP|IO. IIUC either the
> > old follow_pte() or follow_pfnmap*() API cared much on this part yet so
> > far.
> 
> Why? Either the function only returns PFN map no-struct page things or
> it returns struct page stuff too, in which case why bother to check
> the VMA flags if the caller already has to be correct for struct page
> backed results?
> 
> This function is only safe to use under the proper locking, and under
> those rules it doesn't matter at all what the result is..

Do you mean we should drop the PFNMAP|IO check?  I didn't see all the
callers to say that they won't rely on proper failing of !PFNMAP&&!IO vmas
to work alright.  So I assume we should definitely keep them around.

Or I could have totally missed what you're suggesting here..

> > > > > > + * The mmap semaphore
> > > > > > + * should be taken for read, and the mmap semaphore cannot be released
> > > > > > + * before the end() is invoked.
> > > > > 
> > > > > This function is not safe for IO mappings and PFNs either, VFIO has a
> > > > > known security issue to call it. That should be emphasised in the
> > > > > comment.
> > > > 
> > > > Any elaboration on this?  I could have missed that..
> > > 
> > > Just because the memory is a PFN or IO doesn't mean it is safe to
> > > access it without a refcount. There are many driver scenarios where
> > > revoking a PFN from mmap needs to be a hard fence that nothing else
> > > has access to that PFN. Otherwise it is a security problem for that
> > > driver.
> > 
> > Oh ok, I suppose you meant the VFIO whole thing on "zapping mapping when
> > MMIO disabled"?  If so I get it.  More below.
> 
> And more..
> 
> > > > The user needs to do proper mapping if they need an usable address,
> > > > e.g. generic_access_phys() does ioremap_prot() and recheck the pfn didn't
> > > > change.
> > > 
> > > No, you can't take the phys_addr_t outside the start/end region that
> > > explicitly holds the lock protecting it. This is what the comment must
> > > warn against doing.
> > 
> > I think the comment has that part covered more or less:
> > 
> >  * During the start() and end() calls, the results in @args will be valid
> >  * as proper locks will be held.  After the end() is called, all the fields
> >  * in @follow_pfnmap_args will be invalid to be further accessed.
> > 
> > Feel free to suggest anything that will make it better.
> 
> Be much more specific and scary:
> 
>   Any physical address obtained through this API is only valid while
>   the @follow_pfnmap_args. Continuing to use the address after end(),
>   without some other means to synchronize with page table updates
>   will create a security bug.

Some misuse on wordings here (e.g. we don't return PA but PFN), and some
sentence doesn't seem to be complete.. but I think I get the "scary" part
of it.  How about this, appending the scary part to the end?

 * During the start() and end() calls, the results in @args will be valid
 * as proper locks will be held.  After the end() is called, all the fields
 * in @follow_pfnmap_args will be invalid to be further accessed.  Further
 * use of such information after end() may require proper synchronizations
 * by the caller with page table updates, otherwise it can create a
 * security bug.

>  
> > For generic_access_phys() as a specific example: I think it is safe to map
> > the pfn even after end(). 
> 
> The map could be safe, but also the memory could be hot unplugged as a
> race. I don't know either way if all arch code is safe for that.

I hope it's ok, or we have similar problem with follow_pte() for all
theseyears.. in all cases, this sounds like another thing to be checked
outside of scope of this patch..

> 
> > After the map, it rewalks the pgtable, making sure PFN is still there and
> > valid, and it'll only access it this time before end():
> > 
> > 	if (write)
> > 		memcpy_toio(maddr + offset, buf, len);
> > 	else
> > 		memcpy_fromio(buf, maddr + offset, len);
> > 	ret = len;
> > 	follow_pfnmap_end(&args);
> 
> Yes
>  
> > If PFN changed, it properly releases the mapping:
> > 
> > 	if ((prot != pgprot_val(args.pgprot)) ||
> > 	    (phys_addr != (args.pfn << PAGE_SHIFT)) ||
> > 	    (writable != args.writable)) {
> > 		follow_pfnmap_end(&args);
> > 		iounmap(maddr);
> > 		goto retry;
> > 	}
> > 
> > Then taking the example of VFIO: there's no risk of racing with a
> > concurrent zapping as far as I can see, because otherwise it'll see pfn
> > changed.
> 
> VFIO dumps the physical address into the IOMMU and ignores
> zap. Concurrent zap results in a UAF through the IOMMU mapping.

Ohhh, so this is what I'm missing..

It worked for generic mem only because VFIO pins them upfront so any form
of zapping won't throw things away, but we can't pin pfnmaps yet so far.

It sounds like we need some mmu notifiers when mapping the IOMMU pgtables,
as long as there's MMIO-region / P2P involved.  It'll make sure when
tearing down the BAR mappings, the devices will at least see the same view
as the processors.

Thanks,

-- 
Peter Xu


