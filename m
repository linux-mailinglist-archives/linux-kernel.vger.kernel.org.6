Return-Path: <linux-kernel+bounces-224928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBDE39128C7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 17:02:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1785D1C260F4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 15:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC315502BD;
	Fri, 21 Jun 2024 15:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fk7gGsY0"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E49A4CDF9
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 15:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718982117; cv=none; b=CLvh7bWPw9E3BA4Bbgjicw+NN8tK8ON2QjEZp1fm7oiIFnH0PB3oj4jDuXhF2fFDh835CRIqcDYhgE0ITnfeZTywAQRmBeyYwWjRlowdycY4M1tvRZkja4ptp1MuLFAE+Knjs80y7hgnU6SaQz35OB5WJ9Y4GEpWwZrqYhStTaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718982117; c=relaxed/simple;
	bh=U5FbGj9341y9I5di5l7P227GVvKlgS0dA3G7vCN+yY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yu5b94nhonwkyEIv8xwV2P56wljmVdSsUJLJqVskfPYCreQ67UQFFP7i0zypq5OfObSLBhebrRldvkydyPg2JHajWxIXWMCMJl5Wq4ir0DrwtEXkrkg7hNB17Ho1X2qZeNZigXIUHqdk3d1gwPVOtdQqyKt+AC2SPhgQjnmwA6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fk7gGsY0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718982115;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=REVMzCf9KPJKxppAPyYl2jD1cpXtxvVGJIDHyR5KKbs=;
	b=fk7gGsY0cgBTPHPqq+7cxogb54B8scrd0CUMHH+O3xfT768A5B7lO37qxu7zv6QJ2KSpbQ
	Mrz+qQkSIVY43r4adAOMQzP98YKtowW2BjnVZlf0Yh37nDhM1Gwxw7Rg33DOdC23pvGnVy
	ll+Z0IXU37jfidnNDd1+JPXfYacG4v4=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-501-2Sw25Eu5Np22FRo7BfC6wQ-1; Fri, 21 Jun 2024 11:01:54 -0400
X-MC-Unique: 2Sw25Eu5Np22FRo7BfC6wQ-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6b4fc5c2ee5so3658236d6.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 08:01:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718982113; x=1719586913;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=REVMzCf9KPJKxppAPyYl2jD1cpXtxvVGJIDHyR5KKbs=;
        b=tV7SBmQ4VsJGsAj5mO4IvXEsaDOjNP5rsFMb8ulE1Sn3RCNhmG+tiRlu281Wx847zd
         RVhaYHVT/T590pnZ8ZwW5wfAPdvPilBo2pmemJeri6Hi+o7aqbFa+drZTp1fs68AoMw0
         OpfmMoGUrPNzCuEguvhkTIfgYx2t2GB4eMolY1l3LupHY48wLEXJuXHZSt2uIj5A0LRb
         3S8+dudZrHUcYA4edFAfSOYOh73ebptQJAmAeCi4ZdIhyhFEQF3PXY26G47Xq2EVuNCo
         cSTt3GmsfmKbQ8BisGFjSdoWAY0zvPnpdNHWbmg6dpL+QKZeVO0NeCQOYOJ1EK7lbEaQ
         QSjw==
X-Gm-Message-State: AOJu0YwZpX1imWIlilcWBoS5vLbGUFuU4l2WOMYre7gVvyjEYieMC2JH
	7P+SWQgnj4mmnZSlG6wVpkSvwXgUgiiaVsmJuzs33zUwqKi988rRpu/WiGCAzPexvLvwVaBuPCW
	M6DsYexJXvSHL9HEiR3m+qx5cx/OVIbwEJkzW4TOjP/dIa2UWuP0meS43BidlNVt5HqU3dX1Yce
	Sfmh5q/ELKzn189IuvNkVSBh+9VEBsUuWhBljq7dgaEVI=
X-Received: by 2002:a05:622a:2cc:b0:441:581b:c111 with SMTP id d75a77b69052e-444a7a153ffmr95993721cf.1.1718982112962;
        Fri, 21 Jun 2024 08:01:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGy/M4tB0NsmwFw2Vc1r8qkgVlJcFixEuuYKG9UASFE/pxP8aIpWiptz9iA6cfjIHrhSLs9OQ==
X-Received: by 2002:a05:622a:2cc:b0:441:581b:c111 with SMTP id d75a77b69052e-444a7a153ffmr95992901cf.1.1718982112163;
        Fri, 21 Jun 2024 08:01:52 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-444c2c3d946sm11823491cf.74.2024.06.21.08.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 08:01:51 -0700 (PDT)
Date: Fri, 21 Jun 2024 11:01:47 -0400
From: Peter Xu <peterx@redhat.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc: x86@kernel.org, Borislav Petkov <bp@alien8.de>,
	Dave Jiang <dave.jiang@intel.com>,
	"Kirill A . Shutemov" <kirill@shutemov.name>,
	Ingo Molnar <mingo@redhat.com>, Oscar Salvador <osalvador@suse.de>,
	Matthew Wilcox <willy@infradead.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Dan Williams <dan.j.williams@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Hugh Dickins <hughd@google.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Rik van Riel <riel@surriel.com>,
	Mel Gorman <mgorman@techsingularity.net>,
	"Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Huang Ying <ying.huang@intel.com>
Subject: Re: [PATCH 4/7] mm/powerpc: Add missing pud helpers
Message-ID: <ZnWV2-YBFKXjLA9v@x1n>
References: <20240621142504.1940209-1-peterx@redhat.com>
 <20240621142504.1940209-5-peterx@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240621142504.1940209-5-peterx@redhat.com>

On Fri, Jun 21, 2024 at 10:25:01AM -0400, Peter Xu wrote:
> +pmd_t pudp_invalidate(struct vm_area_struct *vma, unsigned long address,
> +		      pud_t *pudp)
> +{
> +	unsigned long old_pud;
> +
> +	VM_WARN_ON_ONCE(!pmd_present(*pmdp));
> +	old_pmd = pmd_hugepage_update(vma->vm_mm, address, pmdp, _PAGE_PRESENT, _PAGE_INVALID);
> +	flush_pmd_tlb_range(vma, address, address + HPAGE_PMD_SIZE);
> +	return __pmd(old_pmd);
> +}

I'll need an amend at least here, and my test harness won't catch it even
if it's a mistake as silly as it could be..  My apologies for such noise.
Below is what I plan to squash into this patch when I repost v2.

===8<===
diff --git a/arch/powerpc/mm/book3s64/pgtable.c b/arch/powerpc/mm/book3s64/pgtable.c
index c6ae969020e0..ea2c83634434 100644
--- a/arch/powerpc/mm/book3s64/pgtable.c
+++ b/arch/powerpc/mm/book3s64/pgtable.c
@@ -176,15 +176,15 @@ pmd_t pmdp_invalidate(struct vm_area_struct *vma, unsigned long address,
        return __pmd(old_pmd);
 }
 
-pmd_t pudp_invalidate(struct vm_area_struct *vma, unsigned long address,
+pud_t pudp_invalidate(struct vm_area_struct *vma, unsigned long address,
                      pud_t *pudp)
 {
        unsigned long old_pud;
 
-       VM_WARN_ON_ONCE(!pmd_present(*pmdp));
-       old_pmd = pmd_hugepage_update(vma->vm_mm, address, pmdp, _PAGE_PRESENT, _PAGE_INVALID);
-       flush_pmd_tlb_range(vma, address, address + HPAGE_PMD_SIZE);
-       return __pmd(old_pmd);
+       VM_WARN_ON_ONCE(!pud_present(*pudp));
+       old_pud = pud_hugepage_update(vma->vm_mm, address, pudp, _PAGE_PRESENT, _PAGE_INVALID);
+       flush_pud_tlb_range(vma, address, address + HPAGE_PUD_SIZE);
+       return __pud(old_pud);
 }
 
 pmd_t pmdp_huge_get_and_clear_full(struct vm_area_struct *vma,
===8<===

-- 
Peter Xu


