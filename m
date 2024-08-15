Return-Path: <linux-kernel+bounces-288220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86AB4953779
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 17:42:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA76E1C25335
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 15:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C1381B012B;
	Thu, 15 Aug 2024 15:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qj7jU/tc"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F4F1AED41
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 15:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723736511; cv=none; b=TQIQyXSLvxHuN2EWC1uuMSthun8omT1h69qFItwNGaZeSxSFg3/hs5d5sTiBbmNjcsBZ+RXERFFcHtETyNo/aWgaqJ21Uqgm7/amjZHtNtXk5XfQC9BHsL4gJrjjJiFTfHyio8wJE6CXEbz5vhMKxUN+U0rDmRv0jkWhmmW0Taw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723736511; c=relaxed/simple;
	bh=iKftnuoXv++1YtyaUGQI++5wooIkfj0lQ2g4x1O0WsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WtLGXhQnfeTgEdjy6vBPIwVG6RuPJIaAgFkr3XMbfgWHaix3DDm2JGbu7gOijqhXAKH9vbIgaQ0pfSzp1MJPq+WNdq7UiCnvVjMBMSAlNJ0np7sfm5weVZg2+ronPzWUN2IDO0S0gC9daqNUmTbwmUq9cTWyntK46e1OapJXz4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qj7jU/tc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723736508;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JsmHuSZ/h+8byKlDVdTBZriKwwSluzVcisJkUaNyJWc=;
	b=Qj7jU/tcYE6RXLAUYqYIdONE6R7PcArQ5d3HGUVlwud0dvYJI1cn6yz+kADJuw8gOUoK8D
	kvklxOPLac76Lv7pxxdgfewdM1GURyNCicoNmR6nsYrwKbGirErgjJ/7TUCDfuMyYh2rdr
	HGgBUPtWFvZgzQIYsQ2D5wW3EPH6nEk=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-N9wULLT4MdOnfvw5usjhOQ-1; Thu, 15 Aug 2024 11:41:44 -0400
X-MC-Unique: N9wULLT4MdOnfvw5usjhOQ-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6b95c005dbcso1949196d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 08:41:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723736504; x=1724341304;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JsmHuSZ/h+8byKlDVdTBZriKwwSluzVcisJkUaNyJWc=;
        b=oAdpRBkMHkNasvsSg4Ph7tp8tUQ+xvgbGKrXYnNhnZ7/sAlsDzLId1hgAeCEPMOIv4
         +y8wp73pehQzhJb7R88WO+TDXAFpRwxR8EXAeh/DkjwDdMaOU1wHmOO0RAGzuNDhKxUc
         GMLFnacyDUo15HGfpUVloyX6quN2Icp89Jn0KdbB7pv7eRRay5z8EmgUy0+0nOeuXMzO
         DxukG4t7VGf7KpFilSZcbNRk8JrW0vmXPZbnl2n83IPua7P9FvWzYPrhOVDbcOiDJeZw
         TAqz+Z+2hcHEmQ7R6G8GeSB3tNzDcXOoSSkZu0kL2lZbKNNFr0ntJ3Rz6s4dwHsSHeyk
         jz9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVNEMJig6tcesShrMR1YL/iszm96KD+dMg7W88TNQc8wlxFHbSK7K8tUVIP9wqwnCgcU8YjCoH+ERGUsW4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9Ue4i10MLDoBcIrD2yn2e4yp2OXuUfWClwshg6hpyXJaubxj1
	KjIXFW8Z2bzdTQads9efu4A+Pu2q8hLgyi1MIfVznh3bEbKsqL/mcOg3HiD4v7LKfjtq/1l/5Uz
	EFb2h42PzpeAv+bHdceLFuwBMsSn7BIsp+SCgnWCW3DqK/q5fQyFNglBjB50lhw==
X-Received: by 2002:a05:6214:c2a:b0:6b9:9417:c103 with SMTP id 6a1803df08f44-6bf5d15e1c2mr43262716d6.1.1723736503617;
        Thu, 15 Aug 2024 08:41:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFzOO1MXixhWkJJiUpcPb8vsKcxQhlblFzoLUtxY92DYm0+isa557XEa9BsKNxw5lcKbfHR8g==
X-Received: by 2002:a05:6214:c2a:b0:6b9:9417:c103 with SMTP id 6a1803df08f44-6bf5d15e1c2mr43262466d6.1.1723736503043;
        Thu, 15 Aug 2024 08:41:43 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bf6ff0c354sm7266716d6.135.2024.08.15.08.41.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 08:41:42 -0700 (PDT)
Date: Thu, 15 Aug 2024 11:41:39 -0400
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
Message-ID: <Zr4hs8AGbPRlieY4@x1n>
References: <20240809160909.1023470-1-peterx@redhat.com>
 <20240809160909.1023470-10-peterx@redhat.com>
 <20240814131954.GK2032816@nvidia.com>
 <Zrz2b82-Z31h4Suy@x1n>
 <20240814221441.GB2032816@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240814221441.GB2032816@nvidia.com>

On Wed, Aug 14, 2024 at 07:14:41PM -0300, Jason Gunthorpe wrote:
> On Wed, Aug 14, 2024 at 02:24:47PM -0400, Peter Xu wrote:
> > On Wed, Aug 14, 2024 at 10:19:54AM -0300, Jason Gunthorpe wrote:
> > > On Fri, Aug 09, 2024 at 12:08:59PM -0400, Peter Xu wrote:
> > > 
> > > > +/**
> > > > + * follow_pfnmap_start() - Look up a pfn mapping at a user virtual address
> > > > + * @args: Pointer to struct @follow_pfnmap_args
> > > > + *
> > > > + * The caller needs to setup args->vma and args->address to point to the
> > > > + * virtual address as the target of such lookup.  On a successful return,
> > > > + * the results will be put into other output fields.
> > > > + *
> > > > + * After the caller finished using the fields, the caller must invoke
> > > > + * another follow_pfnmap_end() to proper releases the locks and resources
> > > > + * of such look up request.
> > > > + *
> > > > + * During the start() and end() calls, the results in @args will be valid
> > > > + * as proper locks will be held.  After the end() is called, all the fields
> > > > + * in @follow_pfnmap_args will be invalid to be further accessed.
> > > > + *
> > > > + * If the PTE maps a refcounted page, callers are responsible to protect
> > > > + * against invalidation with MMU notifiers; otherwise access to the PFN at
> > > > + * a later point in time can trigger use-after-free.
> > > > + *
> > > > + * Only IO mappings and raw PFN mappings are allowed.  
> > > 
> > > What does this mean? The paragraph before said this can return a
> > > refcounted page?
> > 
> > This came from the old follow_pte(), I kept that as I suppose we should
> > allow VM_IO | VM_PFNMAP just like before, even if in this case I suppose
> > only the pfnmap matters where huge mappings can start to appear.
> 
> If that is the intention it should actively block returning anything
> that is vm_normal_page() not check the VM flags, see the other
> discussion..

The restriction should only be applied to the vma attributes, not a
specific pte mapping, IMHO.

I mean, the comment was describing "which VMA is allowed to use this
function", reflecting that we'll fail at anything !PFNMAP && !IO.

It seems legal to have private mappings of them, where vm_normal_page() can
return true here for some of the mappings under PFNMAP|IO. IIUC either the
old follow_pte() or follow_pfnmap*() API cared much on this part yet so
far.

> 
> It makes sense as a restriction if you call the API follow pfnmap.

I'm open to any better suggestion to names.  Again, I think here it's more
about the vma attribute, not "every mapping under the memory range".

> 
> > > > + * The mmap semaphore
> > > > + * should be taken for read, and the mmap semaphore cannot be released
> > > > + * before the end() is invoked.
> > > 
> > > This function is not safe for IO mappings and PFNs either, VFIO has a
> > > known security issue to call it. That should be emphasised in the
> > > comment.
> > 
> > Any elaboration on this?  I could have missed that..
> 
> Just because the memory is a PFN or IO doesn't mean it is safe to
> access it without a refcount. There are many driver scenarios where
> revoking a PFN from mmap needs to be a hard fence that nothing else
> has access to that PFN. Otherwise it is a security problem for that
> driver.

Oh ok, I suppose you meant the VFIO whole thing on "zapping mapping when
MMIO disabled"?  If so I get it.  More below.

> 
> > I suppose so?  As the pgtable is stable, I thought it means it's safe, but
> > I'm not sure now when you mentioned there's a VFIO known issue, so I could
> > have overlooked something.  There's no address returned, but pfn, pgprot,
> > write, etc.
> 
> zap/etc will wait on the PTL, I think, so it should be safe for at
> least the issues I am thinking of.
> 
> > The user needs to do proper mapping if they need an usable address,
> > e.g. generic_access_phys() does ioremap_prot() and recheck the pfn didn't
> > change.
> 
> No, you can't take the phys_addr_t outside the start/end region that
> explicitly holds the lock protecting it. This is what the comment must
> warn against doing.

I think the comment has that part covered more or less:

 * During the start() and end() calls, the results in @args will be valid
 * as proper locks will be held.  After the end() is called, all the fields
 * in @follow_pfnmap_args will be invalid to be further accessed.

Feel free to suggest anything that will make it better.

For generic_access_phys() as a specific example: I think it is safe to map
the pfn even after end().  I meant here the "map" operation is benign with
ioremap_prot(), afaiu: it doesn't include an access on top of the mapping
yet.

After the map, it rewalks the pgtable, making sure PFN is still there and
valid, and it'll only access it this time before end():

	if (write)
		memcpy_toio(maddr + offset, buf, len);
	else
		memcpy_fromio(buf, maddr + offset, len);
	ret = len;
	follow_pfnmap_end(&args);

If PFN changed, it properly releases the mapping:

	if ((prot != pgprot_val(args.pgprot)) ||
	    (phys_addr != (args.pfn << PAGE_SHIFT)) ||
	    (writable != args.writable)) {
		follow_pfnmap_end(&args);
		iounmap(maddr);
		goto retry;
	}

Then taking the example of VFIO: there's no risk of racing with a
concurrent zapping as far as I can see, because otherwise it'll see pfn
changed.

Thanks,

-- 
Peter Xu


