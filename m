Return-Path: <linux-kernel+bounces-186420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1BA48CC3F6
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 17:18:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75A881F23032
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 15:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D24165FBB3;
	Wed, 22 May 2024 15:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FAZ0h1E7"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295FD1864C
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 15:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716391098; cv=none; b=RTdKso90OMNrHhJ3tuj7fCuIRt/fhUb9BkVXLCMBnhtDE+xK14sKTciwInglJY3FMuxxp14eNbcLKMnr3zhpDTtPmayi0/XkvLxUtWZIrlFSj2HDH4bYmc/MatwBTu4XbqJhZDCOIry/pEHAgekTMiqSmMiFCehahW8OJWuvfEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716391098; c=relaxed/simple;
	bh=50/dZ85ASItHuZNQlApDnkH32ZONR3FwgNdPWbnEd+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y3FctLT2CmULcx3OD02pmShzCU/e4wOFh4vx+zXfGYspNgbkOBmhG/y3duYa49pQs9XBfZxIA8y69Ac6y31el744xOJe2Tbm5tzfC9hUrCGz++1In/R39iozOL2RkSNwkuF9GPM2UudDXv/Y9qf1zDYIwNzeMhwsSMQz9GpDY1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FAZ0h1E7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716391094;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ulyp3dBHYflCzA+CsU6OOs2LSl0OHKOiv4gLt08Co68=;
	b=FAZ0h1E71QKyFnQrzOMZct/o/ndkhRfMBDtN1enh2OtbX1wOBpHKleumcg/2x7kqmfW63f
	CygGbnKAo6p9pLmK/V6+ONM4CSdHOnVXG4pj1FudLa+5LUGRRTZdHMQI8TUuCL8JPSXKyc
	PaXjiYWgpEktp8RzM6Gh4e4qwwXzuAw=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-299-BLiyOxw1PVC1Z0QftF_VTQ-1; Wed, 22 May 2024 11:18:13 -0400
X-MC-Unique: BLiyOxw1PVC1Z0QftF_VTQ-1
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-36db6689f26so576885ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 08:18:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716391093; x=1716995893;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ulyp3dBHYflCzA+CsU6OOs2LSl0OHKOiv4gLt08Co68=;
        b=CSdBuJpcLcSxmQoF1Kd9hWLQl60gRYdVwVtt259PP5NUUPQVsN2pTDPCxluDJgcku6
         XCDPVzoTq5rqfMZ79xom1QO3bJQPHcoEu1GyAIngwmLSbMaih8xDuoyLZHysquNpwRY5
         uu/t2TdjtT7AfXL5eFn+LsfXRyyUR9mkBb+XqTrwvNhBYC1QQNOl6eJYLOpBK2McwLAu
         sA0UVAKHGaEg9j2zm1iWhjozUlIcZ17IcUCwOpswXlaf9RtruxzweXSjk5XrWtpa9yL5
         H575A47ejYdG+CavaTw+k0PolBHYhgpCMt5DEMi9YRtRyv12Eq4anYuIaYInioEtD0fM
         CN/A==
X-Forwarded-Encrypted: i=1; AJvYcCUyy/zZ0IeOdQKAB3D4S7F1ejB/vZWTbSVVsyaz5H9TpO7Ev1aRrl8Folz0YT5oP34U/mA0b1MYu+UP71tIBfpHX+PtLRfEXOB0nTi5
X-Gm-Message-State: AOJu0YwS7CbKr+1P7kNUgxRH0K7FSuCAXWVpsBmZi7VZxkCFVODg4hNP
	22lxQRCOCtS/gMz/D2SkCEEMBubjRNVhwq6/pLspVgHzjbs9pzwaD+n3CZGBm27hzk/yb0QyhBo
	DnoHrkqFHJ8M3Lcq4GnXgwOziCe8dLrfFikOwHhRp/nKHgoKZvG1NE8oY1UKSoA==
X-Received: by 2002:a05:6e02:1c02:b0:36a:38bf:5fb2 with SMTP id e9e14a558f8ab-371fb04c8fdmr24423145ab.2.1716391092245;
        Wed, 22 May 2024 08:18:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHvnnEDsLrIKhn97E1pHNKsOLgdbP5FcPWedFf7z4C9RS6gQMHNy23x7AOb9kd74Li1AccHAA==
X-Received: by 2002:a05:6e02:1c02:b0:36a:38bf:5fb2 with SMTP id e9e14a558f8ab-371fb04c8fdmr24422775ab.2.1716391091527;
        Wed, 22 May 2024 08:18:11 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-37137c67c0esm7890395ab.59.2024.05.22.08.18.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 08:18:11 -0700 (PDT)
Date: Wed, 22 May 2024 11:18:08 -0400
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>,
	Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
	Pavel Tatashin <pasha.tatashin@soleen.com>,
	axelrasmussen@google.com, nadav.amit@gmail.com,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Subject: Re: 6.10/bisected/regression - commit 8430557fc584 cause warning at
 mm/page_table_check.c:198 __page_table_check_ptes_set+0x306
Message-ID: <Zk4MsGxhP5x5aURG@x1n>
References: <CABXGCsMB9A8-X+Np_Q+fWLURYL_0t3Y-MdoNabDM-Lzk58-DGA@mail.gmail.com>
 <Zk0HxVODITGKqYCw@x1n>
 <CABXGCsNbcMn0Z0RudFrBW78rZPE+cDY+f9r+yKf_AZwJZUOrQg@mail.gmail.com>
 <Zk0UA6wABOB9X_Dx@x1n>
 <CABXGCsOZnxrSHd0y6QrFhzAiY-uTJiRSmo__C_P8Y2qjFV6bRA@mail.gmail.com>
 <Zk0h0V8kvZRKu6F4@x1n>
 <a3d54407-87aa-4f59-adac-c9b79fe1ecef@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a3d54407-87aa-4f59-adac-c9b79fe1ecef@redhat.com>

On Wed, May 22, 2024 at 09:48:51AM +0200, David Hildenbrand wrote:
> On 22.05.24 00:36, Peter Xu wrote:
> > On Wed, May 22, 2024 at 03:21:04AM +0500, Mikhail Gavrilov wrote:
> > > On Wed, May 22, 2024 at 2:37 AM Peter Xu <peterx@redhat.com> wrote:
> > > > Hmm I still cannot reproduce.  Weird.
> > > > 
> > > > Would it be possible for you to identify which line in debug_vm_pgtable.c
> > > > triggered that issue?
> > > > 
> > > > I think it should be some set_pte_at() but I'm not sure, as there aren't a
> > > > lot and all of them look benign so far.  It could be that I missed
> > > > something important.
> > > 
> > > I hope it's helps:
> > 
> > Thanks for offering this, it's just that it doesn't look coherent with what
> > was reported for some reason.
> > 
> > > 
> > > > sh /usr/src/kernels/(uname -r)/scripts/faddr2line /lib/debug/lib/modules/(uname -r)/vmlinux debug_vm_pgtable+0x1c04
> > > debug_vm_pgtable+0x1c04/0x3360:
> > > native_ptep_get_and_clear at arch/x86/include/asm/pgtable_64.h:94
> > > (inlined by) ptep_get_and_clear at arch/x86/include/asm/pgtable.h:1262
> > > (inlined by) ptep_clear at include/linux/pgtable.h:509
> > 
> > This is a pte_clear(), and pte_clear() shouldn't even do the set() checks,
> > and shouldn't stumble over what I added.
> > 
> > IOW, it doesn't match with the real stack dump previously:
> > 
> > [    5.581003]  ? __page_table_check_ptes_set+0x306/0x3c0
> > [    5.581274]  ? __pfx___page_table_check_ptes_set+0x10/0x10
> > [    5.581544]  ? __pfx_check_pgprot+0x10/0x10
> > [    5.581806]  set_ptes.constprop.0+0x66/0xd0
> > [    5.582072]  ? __pfx_set_ptes.constprop.0+0x10/0x10
> > [    5.582333]  ? __pfx_pte_val+0x10/0x10
> > [    5.582595]  debug_vm_pgtable+0x1c04/0x3360
> > 
> 
> Staring at pte_clear_tests():
> 
> #ifndef CONFIG_RISCV
> 	pte = __pte(pte_val(pte) | RANDOM_ORVALUE);
> #endif
> 	set_pte_at(args->mm, args->vaddr, args->ptep, pte);
> 
> So we set random PTE bits, probably setting the present, uffd and write bit
> at the same time. That doesn't make too much sense when we want to perform
> that such combinations cannot exist.

Here the issue is I don't think it should set W bit anyway, as we init
page_prot to be RWX but !shared:

	args->page_prot          = vm_get_page_prot(VM_ACCESS_FLAGS);

On x86_64 (Mikhail's system) it should have W bit cleared afaict, meanwhile
the RANDOM_ORVALUE won't touch bit W due to S390_SKIP_MASK (which contains
bit W / bit 1, which is another "accident"..).  Then even if with that it
should not trigger..  I think that's also why I cannot reproduce this
problem locally.

But I think applying random bits are indeed tricky, and I don't really know
why we did that.  I can get that we want to set some non-empty pte, but
AFAIU this should be far enough:

	pte_t pte = pfn_pte(args->pte_pfn, args->page_prot);

As that should already be pte_none()==false, then we clear and recheck
making sure pte_none(), looks good enough already.  Obviously that trick
already broke PPC64 and S390 before due to existance of PPC64_SKIP_MASK
etc..

I guess it won't hurt in this case to double check, though. Mikhail, would
you mind mark this line to see whether it's the line that triggered your
WARNING?  Perhaps also dump something more than that, something like:

===8<===
diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
index f1c9a2c5abc0..610b1996b2e9 100644
--- a/mm/debug_vm_pgtable.c
+++ b/mm/debug_vm_pgtable.c
@@ -635,7 +635,8 @@ static void __init pte_clear_tests(struct pgtable_debug_args *args)
                return;

 #ifndef CONFIG_RISCV
-       pte = __pte(pte_val(pte) | RANDOM_ORVALUE);
+       pr_info("page_prot=0x%lx\n", pgprot_val(args->page_prot));
+       pr_info("pteval|RANDOM_ORVALUE=0x%lx\n", pte_val(pte) | RANDOM_ORVALUE);
 #endif
        set_pte_at(args->mm, args->vaddr, args->ptep, pte);
        flush_dcache_page(page);
===8<===

For me it dumps:

[    2.249478] debug_vm_pgtable: [pte_clear_tests          ]: page_prot=0x25
[    2.250049] debug_vm_pgtable: [pte_clear_tests          ]: pteval|RANDOM_ORVALUE=0xbffffffffffffff5

Logically you should see the same, but since faddr2line doesn't seem to
work properly for some reason, maybe we can try.

> 
> In pmd_clear_tests() and friends we use WRITE_ONCE() instead, so there we
> don't run into trouble.

Right, and I think they should probably use set_pmd_at() rather than
WRITE_ONCE() if we want to cover the helpers.. but that's another story.

Thanks,

-- 
Peter Xu


