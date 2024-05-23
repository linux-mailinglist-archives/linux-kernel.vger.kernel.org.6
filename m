Return-Path: <linux-kernel+bounces-187936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 256848CDAF7
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 21:40:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D6E3B23177
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 19:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3D1484A31;
	Thu, 23 May 2024 19:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ACRUEcZ+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6554C28F5
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 19:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716493230; cv=none; b=TmmHzdy5XA6SL7LhUzE0dyGWSqhXUP1Pn8lQ5jToCEqDY2JZjQ0rRMscd72Nl8P+/2dri1teYXVVwUPMslQR8+LNSa2PrLKU+4nR9EJ199WLFs8aaD8hsiWm7TymG6cDGVtWRXIbW5/NWt/8BpVesLyTlgndRDNMplziJJXN7bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716493230; c=relaxed/simple;
	bh=1EtM8jfm5Z9rCo572I/n7O9VmOc5aJGwT85cZ7fzY00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tYn1LgpOKIqJDUeLznHeaQbPPy/CLgR0cIEdU4fIyL1Xb4xbZNC+ZI215aYxmGZURCYVNq82Btqr/p0n9AMO1ahfIr+l6EP/+yePd2M3LTzsmejhwJenOU6ec8ANEkYmB5ch2Tsoxmyh9OTXyKWzOL590W8/mj2bK2y1lGkCm7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ACRUEcZ+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716493227;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OCvWufVacLGgXuxtEqrctwgkg9qLQ+urbHg5QGQf0Ok=;
	b=ACRUEcZ+WrwZAHUK07Kn73ORZmovWt0pXNMWauij/ncolqRIpjxzqUfL9x31q9gbCP+Rgx
	nP6ZWO3+ZlhOD512ahtdcLsraghQw0g8A2c6eEJhe3ZBo0n1vVi/se6m5NIcNw4/6rjYxk
	m3xxfkvCPtwd5WwBAm8jZ7BffcD/cOU=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-523-fbSIgf1ZM3uxLnozLtp5BA-1; Thu, 23 May 2024 15:40:25 -0400
X-MC-Unique: fbSIgf1ZM3uxLnozLtp5BA-1
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-3c9b5776fccso258874b6e.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 12:40:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716493225; x=1717098025;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OCvWufVacLGgXuxtEqrctwgkg9qLQ+urbHg5QGQf0Ok=;
        b=pkeypRDD1tF3TlT/Sds8zfWtj7Cfu0wSJn73MwLHFEHqaM8UWY+T+K9LOXqwPZ30Oh
         +4GtNbbS4yKdvjImKEPHXC1yErHjJC4KAaxME1MnjGbDFnyiSX8nJkcT7nDUiYd64GC3
         JhUdgfdd3pcJ73A/UQIH2JahP99PmvUxr/g6c12L5pOGnfm7p7Sz1y4oPEOFyyPZIDPz
         K7MHv3OV59lNloGGgCQqd5scFPY1GDH/2g+B8dJEUaG+nrbb9JraWk/YgDW+FxlVWPKh
         qBu3KOZJOd9PM0aGx03BGOiWrj/HZLNH9rDCHT4C9LJoLjmBd+1vkM3CVOaaaYyXjKwT
         mN0g==
X-Forwarded-Encrypted: i=1; AJvYcCXo6E8/qsdxwuq0Aq3d3viEGicbwjTOdBCW1zrC3OXFYGw7hSePy5l55Dc3LSqMsTGN1eG8IV3K8STh4SEt2LPX938SmBBqElYKkvCB
X-Gm-Message-State: AOJu0Yzbi9vTJnAztEhVjC8rleBymIda2cKsT9BV1Z8pshRaIQEvPVlM
	HFN+azQjE8lBDawQhCHusal98SCNfpeNkdR+Tfsh58o6KWUw9xItZrrZS/mj6Lp34itoCApa9KI
	H1PrBN9zB7H6JVoVyXTaN76P8mKI45d8MP5h5TokY2jZC0y4XEw1WJIdmJfqrVQ==
X-Received: by 2002:a05:6808:3087:b0:3c8:4cc6:4f0c with SMTP id 5614622812f47-3d1a966af20mr343309b6e.5.1716493224722;
        Thu, 23 May 2024 12:40:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH5T0Za11sb8Fsxy+MXgLZp568ubN3owF+qKZJ+eJpG1Em8U4RQw4I+vJsVrvCB0c6vSaNEQg==
X-Received: by 2002:a05:6808:3087:b0:3c8:4cc6:4f0c with SMTP id 5614622812f47-3d1a966af20mr343274b6e.5.1716493224004;
        Thu, 23 May 2024 12:40:24 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-792bf2a3e3esm1517490185a.68.2024.05.23.12.40.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 12:40:23 -0700 (PDT)
Date: Thu, 23 May 2024 15:40:20 -0400
From: Peter Xu <peterx@redhat.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Oscar Salvador <osalvador@suse.de>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH v2 00/20] Reimplement huge pages without hugepd on
 powerpc (8xx, e500, book3s/64)
Message-ID: <Zk-bpBZ_yjsj_B2z@x1n>
References: <cover.1715971869.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1715971869.git.christophe.leroy@csgroup.eu>

On Fri, May 17, 2024 at 08:59:54PM +0200, Christophe Leroy wrote:
> This is the continuation of the RFC v1 series "Reimplement huge pages
> without hugepd on powerpc 8xx". It now get rid of hugepd completely
> after handling also e500 and book3s/64
> 
> Unlike most architectures, powerpc 8xx HW requires a two-level
> pagetable topology for all page sizes. So a leaf PMD-contig approach
> is not feasible as such.
> 
> Possible sizes are 4k, 16k, 512k and 8M.
> 
> First level (PGD/PMD) covers 4M per entry. For 8M pages, two PMD entries
> must point to a single entry level-2 page table. Until now that was
> done using hugepd. This series changes it to use standard page tables
> where the entry is replicated 1024 times on each of the two pagetables
> refered by the two associated PMD entries for that 8M page.
> 
> At the moment it has to look into each helper to know if the
> hugepage ptep is a PTE or a PMD in order to know it is a 8M page or
> a lower size. I hope this can me handled by core-mm in the future.
> 
> For e500 and book3s/64 there are less constraints because it is not
> tied to the HW assisted tablewalk like on 8xx, so it is easier to use
> leaf PMDs (and PUDs).
> 
> On e500 the supported page sizes are 4M, 16M, 64M, 256M and 1G. All at
> PMD level on e500/32 and mix of PMD and PUD for e500/64. We encode page
> size with 4 available bits in PTE entries. On e300/32 PGD entries size
> is increases to 64 bits in order to allow leaf-PMD entries because PTE
> are 64 bits on e500.
> 
> On book3s/64 only the hash-4k mode is concerned. It supports 16M pages
> as cont-PMD and 16G pages as cont-PUD. In other modes (radix-4k, radix-6k
> and hash-64k) the sizes match with PMD and PUD sizes so that's just leaf
> entries.
> 
> Christophe Leroy (20):
>   mm: Provide pagesize to pmd_populate()
>   mm: Provide page size to pte_alloc_huge()
>   mm: Provide pmd to pte_leaf_size()
>   mm: Provide mm_struct and address to huge_ptep_get()
>   powerpc/mm: Allow hugepages without hugepd
>   powerpc/8xx: Fix size given to set_huge_pte_at()
>   powerpc/8xx: Rework support for 8M pages using contiguous PTE entries
>   powerpc/8xx: Simplify struct mmu_psize_def
>   powerpc/mm: Remove _PAGE_PSIZE
>   powerpc/mm: Fix __find_linux_pte() on 32 bits with PMD leaf entries
>   powerpc/mm: Complement huge_pte_alloc() for all non HUGEPD setups
>   powerpc/64e: Remove unneeded #ifdef CONFIG_PPC_E500
>   powerpc/64e: Clean up impossible setups
>   powerpc/e500: Remove enc field from struct mmu_psize_def
>   powerpc/85xx: Switch to 64 bits PGD
>   powerpc/e500: Encode hugepage size in PTE bits
>   powerpc/e500: Use contiguous PMD instead of hugepd
>   powerpc/64s: Use contiguous PMD/PUD instead of HUGEPD
>   powerpc/mm: Remove hugepd leftovers
>   mm: Remove CONFIG_ARCH_HAS_HUGEPD

Great to see this series, thanks again Christophe.

I requested for help on the lsfmm hugetlb unification session, but
unfortunately I don't think there were Power people around.. I'd like to
request help from Power developers again here on the list: it will be very
appreciated if you can help have a look at this series.

It's a direct dependent work to the hugetlb refactoring that we'll be
working on, while it looks like the hugetlb refactoring is something the
community as a whole would like to see in the near future.

We don't want to add more Power-only CONFIG_ARCH_HAS_HUGEPD checks for
hugetlb in any new code.

Currently Oscar offered help on that hugetlb project, and Oscar will start
to work on page_walk API refactoring.  I guess currently the simple way is
we'll work on top of Christophe's series.  Some proper review on this
series will definitely make it clearer on what we should do next.

Thanks,

-- 
Peter Xu


