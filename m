Return-Path: <linux-kernel+bounces-186483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D13C18CC4BA
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 18:14:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86BBF2810BC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 16:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7351B3716D;
	Wed, 22 May 2024 16:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Aw3Fgi2O"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E8D56444
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 16:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716394433; cv=none; b=A8wlV49JICSY0MniW+k61s2YVgs9DHePYWqGUxiH004tr7d8Zg9fvXQAY5TCTBoHlqEqsWo0XCQbNuV3CMW7bn2+OreEvrRNdcR5rIsv3zvHXuP2BeCf3gpE+ZVoz9ogarpCW9ML0YfiJZYxAzn2yPNS/guna4pCkvOLKFpYODs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716394433; c=relaxed/simple;
	bh=NjXiPTWnOeImNdoz9BOwvzUqhkai0vzWdsLF5ouFHs8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oNGdIy9qwhnLrEMiSctcAIjoEwIl++dfWW274VflrZZz6q8dg+CcOrSiUUDcTw7GYq7rKUKPGkVX/cTh8oY5urXOml8iSZ21LIPsbFXJlL/qEBvzADXt36a29GCO7J+TtkaOjgnhoKrCpCG5vPn6lCuyEfdz+McqYF0z/OKbPxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Aw3Fgi2O; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716394430;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3nOUOflu7eQzj/terIhor8uH3BfQ+23Qg6GF2/UGitw=;
	b=Aw3Fgi2OPeNobl6V6uXb4qpMv2w+9o3PFqy/WAiGcqvZxxtxcv8Hg3jYhMxFewa1gmxP7v
	xQFNLH7E5WMEA6IcQrY9ikPnqoWZulJaRfe6k3YYzntkrnlKF7F6w4ChZ5JIUhay+o7MRt
	yzRwo0vQD4M/znt8kgqw9OEQkV9zGi4=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-364-lZOu8c7RMR6Alz31AhyiIQ-1; Wed, 22 May 2024 12:13:49 -0400
X-MC-Unique: lZOu8c7RMR6Alz31AhyiIQ-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6a0dc98ce3fso12330046d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 09:13:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716394429; x=1716999229;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3nOUOflu7eQzj/terIhor8uH3BfQ+23Qg6GF2/UGitw=;
        b=ehzutuCuzCpPtYcNscERnjWY69jhc1SHFbix0CiLCv30jrfK3jpAXZhGruEUagx4op
         QdWroWILvfOb50QX9DkuU5jwXKnTp/DbRqzMkPghgyDuiwmqf1P3MIxxy/rU6ljN4jxB
         PunAtJKnU7PQSZsdkqzFrS19UBI0jEh7YM+Qhb+AvzvM/VZeXqCSakrrtAKasr2bbnvq
         y0DSRfiGdPpNl/ROlaphD94jMM+DfKGHWTV//146owQNp+kBge6VDWtqZvB9sjcwn+iK
         htPYjtWj8wg9FYSp35EkZBuBCwAXbg2ghzSxeGKnrwh9uiNjORwnrVXl6C6iyp4Lz0vL
         yUyw==
X-Forwarded-Encrypted: i=1; AJvYcCXyGB75LnExdBf75hAWvjhNLvBUMqMg5AC3IqDUct/DR5mmORgSZaBnmL1k+rpj2fq7Ix/2OR4g7eRZxb1V/KTuY0d1vdtnQBXUZmlq
X-Gm-Message-State: AOJu0Ywx3usx7KoJFg0dsduwjP//H8ntu1x2HhKhzW6Sx57rGQJuN0nf
	upWNsBz8Ah3EfLa1xffwh/aGzfRLK9bPSEsHNpJyMk7h+ZFhIr1N80+q6zVuvbf0FyP+pm9Y4d6
	MQVmRqqySI2oJazPd+PW7y1YpRmNEbgiNUuCZfsaE6g2jxmbTdXa1TBJvbk8cIA==
X-Received: by 2002:a05:6214:2626:b0:6a0:87e5:210c with SMTP id 6a1803df08f44-6ab80931c4emr24096656d6.5.1716394428137;
        Wed, 22 May 2024 09:13:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZToKdbUy5jaMTAiNrIxehX58pgqc0VaKB4XF1FynvcepfCcDlxlf35vwQBh40mWPVQggo8g==
X-Received: by 2002:a05:6214:2626:b0:6a0:87e5:210c with SMTP id 6a1803df08f44-6ab80931c4emr24096056d6.5.1716394427346;
        Wed, 22 May 2024 09:13:47 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6a15f1d9dd2sm134417386d6.129.2024.05.22.09.13.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 09:13:47 -0700 (PDT)
Date: Wed, 22 May 2024 12:13:45 -0400
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>,
	"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
	Gavin Shan <gshan@redhat.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
	Pavel Tatashin <pasha.tatashin@soleen.com>,
	axelrasmussen@google.com, nadav.amit@gmail.com,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Subject: Re: 6.10/bisected/regression - commit 8430557fc584 cause warning at
 mm/page_table_check.c:198 __page_table_check_ptes_set+0x306
Message-ID: <Zk4ZuQpql0kBkMMH@x1n>
References: <CABXGCsMB9A8-X+Np_Q+fWLURYL_0t3Y-MdoNabDM-Lzk58-DGA@mail.gmail.com>
 <Zk0HxVODITGKqYCw@x1n>
 <CABXGCsNbcMn0Z0RudFrBW78rZPE+cDY+f9r+yKf_AZwJZUOrQg@mail.gmail.com>
 <Zk0UA6wABOB9X_Dx@x1n>
 <CABXGCsOZnxrSHd0y6QrFhzAiY-uTJiRSmo__C_P8Y2qjFV6bRA@mail.gmail.com>
 <Zk0h0V8kvZRKu6F4@x1n>
 <a3d54407-87aa-4f59-adac-c9b79fe1ecef@redhat.com>
 <Zk4MsGxhP5x5aURG@x1n>
 <03faa624-1685-4a21-81fc-cc9e8b760e97@redhat.com>
 <Zk4Y9tU7pOzU0lw1@x1n>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zk4Y9tU7pOzU0lw1@x1n>

On Wed, May 22, 2024 at 12:10:30PM -0400, Peter Xu wrote:
> On Wed, May 22, 2024 at 05:34:21PM +0200, David Hildenbrand wrote:
> > On 22.05.24 17:18, Peter Xu wrote:
> > > On Wed, May 22, 2024 at 09:48:51AM +0200, David Hildenbrand wrote:
> > > > On 22.05.24 00:36, Peter Xu wrote:
> > > > > On Wed, May 22, 2024 at 03:21:04AM +0500, Mikhail Gavrilov wrote:
> > > > > > On Wed, May 22, 2024 at 2:37 AM Peter Xu <peterx@redhat.com> wrote:
> > > > > > > Hmm I still cannot reproduce.  Weird.
> > > > > > > 
> > > > > > > Would it be possible for you to identify which line in debug_vm_pgtable.c
> > > > > > > triggered that issue?
> > > > > > > 
> > > > > > > I think it should be some set_pte_at() but I'm not sure, as there aren't a
> > > > > > > lot and all of them look benign so far.  It could be that I missed
> > > > > > > something important.
> > > > > > 
> > > > > > I hope it's helps:
> > > > > 
> > > > > Thanks for offering this, it's just that it doesn't look coherent with what
> > > > > was reported for some reason.
> > > > > 
> > > > > > 
> > > > > > > sh /usr/src/kernels/(uname -r)/scripts/faddr2line /lib/debug/lib/modules/(uname -r)/vmlinux debug_vm_pgtable+0x1c04
> > > > > > debug_vm_pgtable+0x1c04/0x3360:
> > > > > > native_ptep_get_and_clear at arch/x86/include/asm/pgtable_64.h:94
> > > > > > (inlined by) ptep_get_and_clear at arch/x86/include/asm/pgtable.h:1262
> > > > > > (inlined by) ptep_clear at include/linux/pgtable.h:509
> > > > > 
> > > > > This is a pte_clear(), and pte_clear() shouldn't even do the set() checks,
> > > > > and shouldn't stumble over what I added.
> > > > > 
> > > > > IOW, it doesn't match with the real stack dump previously:
> > > > > 
> > > > > [    5.581003]  ? __page_table_check_ptes_set+0x306/0x3c0
> > > > > [    5.581274]  ? __pfx___page_table_check_ptes_set+0x10/0x10
> > > > > [    5.581544]  ? __pfx_check_pgprot+0x10/0x10
> > > > > [    5.581806]  set_ptes.constprop.0+0x66/0xd0
> > > > > [    5.582072]  ? __pfx_set_ptes.constprop.0+0x10/0x10
> > > > > [    5.582333]  ? __pfx_pte_val+0x10/0x10
> > > > > [    5.582595]  debug_vm_pgtable+0x1c04/0x3360
> > > > > 
> > > > 
> > > > Staring at pte_clear_tests():
> > > > 
> > > > #ifndef CONFIG_RISCV
> > > > 	pte = __pte(pte_val(pte) | RANDOM_ORVALUE);
> > > > #endif
> > > > 	set_pte_at(args->mm, args->vaddr, args->ptep, pte);
> > > > 
> > > > So we set random PTE bits, probably setting the present, uffd and write bit
> > > > at the same time. That doesn't make too much sense when we want to perform
> > > > that such combinations cannot exist.
> > > 
> > > Here the issue is I don't think it should set W bit anyway, as we init
> > > page_prot to be RWX but !shared:
> > > 
> > > 	args->page_prot          = vm_get_page_prot(VM_ACCESS_FLAGS);
> > > 
> > > On x86_64 (Mikhail's system) it should have W bit cleared afaict, meanwhile
> > > the RANDOM_ORVALUE won't touch bit W due to S390_SKIP_MASK (which contains
> > > bit W / bit 1, which is another "accident"..).  Then even if with that it
> > > should not trigger..  I think that's also why I cannot reproduce this
> > > problem locally.
> > 
> > Why oh why are skip mask applied independently of the architecture.
> > 
> > While _PAGE_RW should indeed be masked out by RANDOM_ORVALUE.
> > 
> > But with shadow stacks we consider a PTE writable (see
> > pte_write()->pte_shstk()) if
> > (1) X86_FEATURE_SHSTK is enabled
> > (2) _PAGE_RW is clear
> > (3) _PAGE_DIRTY is set
> > 
> > _PAGE_DIRTY is bit 6.
> > 
> > Likely your CPU does not support shadow stacks.
> 
> Good point.  My host has it, but I tested in the VM which doesn't.  I
> suppose we can wait and double check whether Mikhail should see the issue
> went away with that patch provided.
> 
> In this case, instead of keep fiddling with random bits to apply and
> further work on top of per-arch random bits, I'd hope we can simply drop
> that random mechanism as I don't think it'll be pxx_none() now.  I attached
> a patch I plan to post. Does it look reasonable?
> 
> I also copied Anshuman, Gavin and Aneesh.

No I didn't.. this one will..

> 
> Thanks,
> 
> ===8<===
> From c10cde00b14d2d305390dd418a8a8855d3e6437f Mon Sep 17 00:00:00 2001
> From: Peter Xu <peterx@redhat.com>
> Date: Wed, 22 May 2024 12:04:33 -0400
> Subject: [PATCH] drop RANDOM_ORVALUE bits
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  mm/debug_vm_pgtable.c | 30 ++++--------------------------
>  1 file changed, 4 insertions(+), 26 deletions(-)
> 
> diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
> index f1c9a2c5abc0..b5d7be05063a 100644
> --- a/mm/debug_vm_pgtable.c
> +++ b/mm/debug_vm_pgtable.c
> @@ -40,22 +40,7 @@
>   * Please refer Documentation/mm/arch_pgtable_helpers.rst for the semantics
>   * expectations that are being validated here. All future changes in here
>   * or the documentation need to be in sync.
> - *
> - * On s390 platform, the lower 4 bits are used to identify given page table
> - * entry type. But these bits might affect the ability to clear entries with
> - * pxx_clear() because of how dynamic page table folding works on s390. So
> - * while loading up the entries do not change the lower 4 bits. It does not
> - * have affect any other platform. Also avoid the 62nd bit on ppc64 that is
> - * used to mark a pte entry.
>   */
> -#define S390_SKIP_MASK		GENMASK(3, 0)
> -#if __BITS_PER_LONG == 64
> -#define PPC64_SKIP_MASK		GENMASK(62, 62)
> -#else
> -#define PPC64_SKIP_MASK		0x0
> -#endif
> -#define ARCH_SKIP_MASK (S390_SKIP_MASK | PPC64_SKIP_MASK)
> -#define RANDOM_ORVALUE (GENMASK(BITS_PER_LONG - 1, 0) & ~ARCH_SKIP_MASK)
>  #define RANDOM_NZVALUE	GENMASK(7, 0)
>  
>  struct pgtable_debug_args {
> @@ -511,8 +496,7 @@ static void __init pud_clear_tests(struct pgtable_debug_args *args)
>  		return;
>  
>  	pr_debug("Validating PUD clear\n");
> -	pud = __pud(pud_val(pud) | RANDOM_ORVALUE);
> -	WRITE_ONCE(*args->pudp, pud);
> +	WARN_ON(pud_none(pud));
>  	pud_clear(args->pudp);
>  	pud = READ_ONCE(*args->pudp);
>  	WARN_ON(!pud_none(pud));
> @@ -548,8 +532,7 @@ static void __init p4d_clear_tests(struct pgtable_debug_args *args)
>  		return;
>  
>  	pr_debug("Validating P4D clear\n");
> -	p4d = __p4d(p4d_val(p4d) | RANDOM_ORVALUE);
> -	WRITE_ONCE(*args->p4dp, p4d);
> +	WARN_ON(p4d_none(p4d));
>  	p4d_clear(args->p4dp);
>  	p4d = READ_ONCE(*args->p4dp);
>  	WARN_ON(!p4d_none(p4d));
> @@ -582,8 +565,7 @@ static void __init pgd_clear_tests(struct pgtable_debug_args *args)
>  		return;
>  
>  	pr_debug("Validating PGD clear\n");
> -	pgd = __pgd(pgd_val(pgd) | RANDOM_ORVALUE);
> -	WRITE_ONCE(*args->pgdp, pgd);
> +	WARN_ON(pgd_none(pgd));
>  	pgd_clear(args->pgdp);
>  	pgd = READ_ONCE(*args->pgdp);
>  	WARN_ON(!pgd_none(pgd));
> @@ -634,9 +616,6 @@ static void __init pte_clear_tests(struct pgtable_debug_args *args)
>  	if (WARN_ON(!args->ptep))
>  		return;
>  
> -#ifndef CONFIG_RISCV
> -	pte = __pte(pte_val(pte) | RANDOM_ORVALUE);
> -#endif
>  	set_pte_at(args->mm, args->vaddr, args->ptep, pte);
>  	flush_dcache_page(page);
>  	barrier();
> @@ -650,8 +629,7 @@ static void __init pmd_clear_tests(struct pgtable_debug_args *args)
>  	pmd_t pmd = READ_ONCE(*args->pmdp);
>  
>  	pr_debug("Validating PMD clear\n");
> -	pmd = __pmd(pmd_val(pmd) | RANDOM_ORVALUE);
> -	WRITE_ONCE(*args->pmdp, pmd);
> +	WARN_ON(pmd_none(pmd));
>  	pmd_clear(args->pmdp);
>  	pmd = READ_ONCE(*args->pmdp);
>  	WARN_ON(!pmd_none(pmd));
> -- 
> 2.45.0
> 
> -- 
> Peter Xu

-- 
Peter Xu


