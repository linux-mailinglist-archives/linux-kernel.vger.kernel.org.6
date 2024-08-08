Return-Path: <linux-kernel+bounces-280160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E233094C675
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 23:48:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52BCDB2507C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 21:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 622E315CD42;
	Thu,  8 Aug 2024 21:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i2VqWua6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1614150994
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 21:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723153675; cv=none; b=Hvb3oTj3VZexQcCP23t2y0hq1IyahbjLBMQth/3a6CyR7+sbEF9es3PnNcRuBamiJ52pL3joFdoG8mjwMBJgN/w5gzhjdDXFOZVWfJCU2VJVn3+5lCG29ifyPdIJR44NlC9149e36qMMkjCZRBo4eXHeQ2Jl520m+4j634FYKEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723153675; c=relaxed/simple;
	bh=s4XkxCp6B8NmYy2SASddwVP3Gr+y7OJEdxvm73dk1+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=feR60sL9BbdNQb+FoyZG0Je+x1M87ZCmVs7O3XdMy/rFVDT+YtuAhsZpGjcROSnndezuuw0xPdyb5ClUui4rJg5wFNrHXPVEV846VdBAoIsQku8ARp3+Nk+jSMnhsF/QqDARDHtNN3uAN/a6UFl5eoVH69h5wKYFbJa0SJhjhSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i2VqWua6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723153672;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y4cQ3dGvl+e98q+IJj301khv7EGPDrAUXWE89nsHh7w=;
	b=i2VqWua6hFWfgzE4+thdjUKiitHHs9rfDpw0biuZmOZ74cSR8gdZsRIdopcMBaB5sRTsWJ
	CiSIeQCGAihw0VXxiO4I3RwWWlK+uYzbxjGTEVrvP9uyTlWk73BnB6aQ87AlprVqINE4Va
	1k9F4bPVvsG9WQX5vPFcmEMToILF3/0=
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-6MYeLgGZMY2wPodmRWa5Jg-1; Thu, 08 Aug 2024 17:47:49 -0400
X-MC-Unique: 6MYeLgGZMY2wPodmRWa5Jg-1
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-81fb65857e0so62738241.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 14:47:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723153669; x=1723758469;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y4cQ3dGvl+e98q+IJj301khv7EGPDrAUXWE89nsHh7w=;
        b=V7B+XDed76CuOEeCI1SVvCB4bw3517hgirWW7RWrSAkDahjI4mKjyHZt0xPeoWSwbL
         Xg1h1O23xiiTXCm+QKPj+v96+4tSu8AkfVg3WUHK1kCOQQboqwy8KRmtX69EYceX/33Z
         Ug1xtiZoHucbQ8ogVTsmJTn4czdu2zlrAF2lheQhkk4db1OdfBoA9NrusOznpflzJCLt
         GNWynJTIh+xjUpZLVqkW/xzljQMttkRCg3vVCX6IftrSCqs1VVHxXf+kSpcHM4nEa+KG
         zjNcgv8Bdw0+SCrdWNe3XWAskd0xnUUUzwId4Yp60bRMtLCzh1Poy1J7vB56x6lAa5Do
         wMhw==
X-Gm-Message-State: AOJu0YxnT0gUgqQu0BHQkuj6T+g59TLtTkQ66vTLVgYxEakzCfDHWQdW
	YJNQu2fDa8LDFzY+VWjgJN0i86ZMMnVGAYcz3taou9tMS5fQ49LYvzAcoeepVzUT8/yyBGYP/7/
	wnMVJvGzajptlbTSHiYwDQai9+sfF0m7rTNi+h0xGnbitDOkwmZ5g1ZECjBHCiQ==
X-Received: by 2002:a05:6122:1696:b0:4f4:959b:8342 with SMTP id 71dfb90a1353d-4f9028ededfmr2281574e0c.2.1723153669032;
        Thu, 08 Aug 2024 14:47:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGBUCPV/3BJaIuZdMerz+8wpoNJAPGodVbwYONTfq25mwe5QVB/HX82z8YwrBUiUNO7Dj9CXg==
X-Received: by 2002:a05:6122:1696:b0:4f4:959b:8342 with SMTP id 71dfb90a1353d-4f9028ededfmr2281559e0c.2.1723153668575;
        Thu, 08 Aug 2024 14:47:48 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a3785e13fdsm198784985a.34.2024.08.08.14.47.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 14:47:48 -0700 (PDT)
Date: Thu, 8 Aug 2024 17:47:44 -0400
From: Peter Xu <peterx@redhat.com>
To: Sean Christopherson <seanjc@google.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	"Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Oscar Salvador <osalvador@suse.de>,
	Dan Williams <dan.j.williams@intel.com>,
	James Houghton <jthoughton@google.com>,
	Matthew Wilcox <willy@infradead.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	Rik van Riel <riel@surriel.com>, Dave Jiang <dave.jiang@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Rick P Edgecombe <rick.p.edgecombe@intel.com>,
	"Kirill A . Shutemov" <kirill@shutemov.name>,
	linuxppc-dev@lists.ozlabs.org,
	Mel Gorman <mgorman@techsingularity.net>,
	Hugh Dickins <hughd@google.com>, Borislav Petkov <bp@alien8.de>,
	David Hildenbrand <david@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vlastimil Babka <vbabka@suse.cz>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Huang Ying <ying.huang@intel.com>, kvm@vger.kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	David Rientjes <rientjes@google.com>
Subject: Re: [PATCH v4 2/7] mm/mprotect: Push mmu notifier to PUDs
Message-ID: <ZrU9AJi7-pHT_UWS@x1n>
References: <20240807194812.819412-1-peterx@redhat.com>
 <20240807194812.819412-3-peterx@redhat.com>
 <ZrTlZ4vZ74sK8Ydd@google.com>
 <ZrU20AqADICwwmCy@x1n>
 <ZrU5JyjIa1CwZ_KD@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZrU5JyjIa1CwZ_KD@google.com>

On Thu, Aug 08, 2024 at 02:31:19PM -0700, Sean Christopherson wrote:
> On Thu, Aug 08, 2024, Peter Xu wrote:
> > Hi, Sean,
> > 
> > On Thu, Aug 08, 2024 at 08:33:59AM -0700, Sean Christopherson wrote:
> > > On Wed, Aug 07, 2024, Peter Xu wrote:
> > > > mprotect() does mmu notifiers in PMD levels.  It's there since 2014 of
> > > > commit a5338093bfb4 ("mm: move mmu notifier call from change_protection to
> > > > change_pmd_range").
> > > > 
> > > > At that time, the issue was that NUMA balancing can be applied on a huge
> > > > range of VM memory, even if nothing was populated.  The notification can be
> > > > avoided in this case if no valid pmd detected, which includes either THP or
> > > > a PTE pgtable page.
> > > > 
> > > > Now to pave way for PUD handling, this isn't enough.  We need to generate
> > > > mmu notifications even on PUD entries properly.  mprotect() is currently
> > > > broken on PUD (e.g., one can easily trigger kernel error with dax 1G
> > > > mappings already), this is the start to fix it.
> > > > 
> > > > To fix that, this patch proposes to push such notifications to the PUD
> > > > layers.
> > > > 
> > > > There is risk on regressing the problem Rik wanted to resolve before, but I
> > > > think it shouldn't really happen, and I still chose this solution because
> > > > of a few reasons:
> > > > 
> > > >   1) Consider a large VM that should definitely contain more than GBs of
> > > >   memory, it's highly likely that PUDs are also none.  In this case there
> > > 
> > > I don't follow this.  Did you mean to say it's highly likely that PUDs are *NOT*
> > > none?
> > 
> > I did mean the original wordings.
> > 
> > Note that in the previous case Rik worked on, it's about a mostly empty VM
> > got NUMA hint applied.  So I did mean "PUDs are also none" here, with the
> > hope that when the numa hint applies on any part of the unpopulated guest
> > memory, it'll find nothing in PUDs. Here it's mostly not about a huge PUD
> > mapping as long as the guest memory is not backed by DAX (since only DAX
> > supports 1G huge pud so far, while hugetlb has its own path here in
> > mprotect, so it must be things like anon or shmem), but a PUD entry that
> > contains pmd pgtables.  For that part, I was trying to justify "no pmd
> > pgtable installed" with the fact that "a large VM that should definitely
> > contain more than GBs of memory", it means the PUD range should hopefully
> > never been accessed, so even the pmd pgtable entry should be missing.
> 
> Ah, now I get what you were saying.
> 
> Problem is, walking the rmaps for the shadow MMU doesn't benefit (much) from
> empty PUDs, because KVM needs to blindly walk the rmaps for every gfn covered by
> the PUD to see if there are any SPTEs in any shadow MMUs mapping that gfn.  And
> that walk is done without ever yielding, which I suspect is the source of the
> soft lockups of yore.
> 
> And there's no way around that conundrum (walking rmaps), at least not without a
> major rewrite in KVM.  In a nested TDP scenario, KVM's stage-2 page tables (for
> L2) key off of L2 gfns, not L1 gfns, and so the only way to find mappings is
> through the rmaps.

I think the hope here is when the whole PUDs being hinted are empty without
pgtable installed, there'll be no mmu notifier to be kicked off at all.

To be explicit, I meant after this patch applied, the pud loop for numa
hints look like this:

        FOR_EACH_PUD() {
                ...
                if (pud_none(pud))
                        continue;

                if (!range.start) {
                        mmu_notifier_range_init(&range,
                                                MMU_NOTIFY_PROTECTION_VMA, 0,
                                                vma->vm_mm, addr, end);
                        mmu_notifier_invalidate_range_start(&range);
                }
                ...
        }

So the hope is that pud_none() is always true for the hinted area (just
like it used to be when pmd_none() can be hopefully true always), then we
skip the mmu notifier as a whole (including KVM's)!

Thanks,

-- 
Peter Xu


