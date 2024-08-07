Return-Path: <linux-kernel+bounces-278644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 545F094B305
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 00:28:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B4831F22F25
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 22:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40FB6153808;
	Wed,  7 Aug 2024 22:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3ZxdDYBh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VmoamQMO"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42597250EC
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 22:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723069730; cv=none; b=lmdPLSYuuzpq4ZFFB93hSuLvyKAz68fYjcfjKvdllsAxSrHv+PC3SmsazNrUGtvLs58Z2PAnW0KcYVmh8AZRAx/w1QUcMRh0wlVzyJcImfBquwAdMF0OOaZvzSzYqpYenwIjHn7fqQWZ8JIPvshARhbdMEvkeop0tCyTvKTkalo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723069730; c=relaxed/simple;
	bh=ap8/4l66WfD6kWFUFQ3DMvm3L4NlYEyaierJKDHIPL8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NbzLy0TF+5AV3wrs6h08bLwCcx/OObIiGQZ97mFmKxvU9ivMbv2mgwqU0eF6Xjkgxc0Z69WKntZzLxYYsFosaDTBwe4OkLsTm1OzbyLopGYdN6nsFNq2DKqW8hEfbldXOkrDZvKwwr4qMOEY66Zqgf+Th/RXUYalv4eN5uRTVJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3ZxdDYBh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VmoamQMO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723069727;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l6W13aUL7iArB1u1SHKLVFvFvnvLUQ1pwZnVA+aBUsE=;
	b=3ZxdDYBh9dkkHBe2taR3ntGjkle6rDPMBLXo4UhxX0U5hvgCD7ElxlpVVKzebM7m55YoYg
	6IKzzdSsW1TDc9pIvZYbtMq17EoFTuLcw1atQsU7Bsl9Yw+lnCggeHfiMfyuVHDLhinNCV
	GkL4xmuAy8lmfTKAidBHshnaxOnMmkK7vcvn/I5wTIvG/bMAOekzFsjwDQtCOo5gjYb9Mh
	3KjeJhRTZmnhVGLmBNpWTdiMxBXZNjdkdyW9PbyWAh2qSub1H21tOY/VlFOBZky3I79b+M
	kKAWkAEexeyKsLLvMcde8oZ+cKCdvPGfvph2jGxkNDnZ9tv62FmQT5a2EO1IWw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723069727;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l6W13aUL7iArB1u1SHKLVFvFvnvLUQ1pwZnVA+aBUsE=;
	b=VmoamQMOr4JMUHfQGwGo1xKYxHHMAQiHW/JDSB/7JHvkAeXPux0Xok96bTkMYXb7wubsH8
	cukq0GYxhuQaqOAQ==
To: Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
Cc: "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Michael Ellerman
 <mpe@ellerman.id.au>, Oscar Salvador <osalvador@suse.de>, Dan Williams
 <dan.j.williams@intel.com>, James Houghton <jthoughton@google.com>,
 Matthew Wilcox <willy@infradead.org>, Nicholas Piggin <npiggin@gmail.com>,
 Rik van Riel <riel@surriel.com>, Dave Jiang <dave.jiang@intel.com>, Andrew
 Morton <akpm@linux-foundation.org>, x86@kernel.org, Ingo Molnar
 <mingo@redhat.com>, Rick P Edgecombe <rick.p.edgecombe@intel.com>, "Kirill
 A . Shutemov" <kirill@shutemov.name>, peterx@redhat.com,
 linuxppc-dev@lists.ozlabs.org, Mel Gorman <mgorman@techsingularity.net>,
 Hugh Dickins <hughd@google.com>, Borislav Petkov <bp@alien8.de>, David
 Hildenbrand <david@redhat.com>, Vlastimil Babka <vbabka@suse.cz>, Dave
 Hansen <dave.hansen@linux.intel.com>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Huang Ying <ying.huang@intel.com>
Subject: Re: [PATCH v4 5/7] mm/x86: arch_check_zapped_pud()
In-Reply-To: <20240807194812.819412-6-peterx@redhat.com>
References: <20240807194812.819412-1-peterx@redhat.com>
 <20240807194812.819412-6-peterx@redhat.com>
Date: Thu, 08 Aug 2024 00:28:47 +0200
Message-ID: <878qx80xy8.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Aug 07 2024 at 15:48, Peter Xu wrote:

> Subject: mm/x86: arch_check_zapped_pud()

Is not a proper subject line. It clearly lacks a verb.

  Subject: mm/x86: Implement arch_check_zapped_pud()


> Introduce arch_check_zapped_pud() to sanity check shadow stack on PUD zaps.
> It has the same logic of the PMD helper.

s/of/as/

> +
> +void arch_check_zapped_pud(struct vm_area_struct *vma, pud_t pud)
> +{
> +	/* See note in arch_check_zapped_pte() */
> +	VM_WARN_ON_ONCE(!(vma->vm_flags & VM_SHADOW_STACK) &&
> +			pud_shstk(pud));

Please get rid of the line break. You have 100 characters.

> +}
> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> index 2a6a3cccfc36..2289e9f7aa1b 100644
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h
> @@ -447,6 +447,13 @@ static inline void arch_check_zapped_pmd(struct vm_area_struct *vma,
>  }
>  #endif
>  
> +#ifndef arch_check_zapped_pud
> +static inline void arch_check_zapped_pud(struct vm_area_struct *vma,
> +					 pud_t pud)
> +{

Ditto..

> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 0024266dea0a..81c5da0708ed 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c

Why is a mm change burried in a patch which is named mm/x86?

It's clearly documented that core changes with the generic fallback come
in one patch and the architecture override in a separate one afterwards.

Do we write documentation just for the sake of writing it?

Thanks,

        tglx


