Return-Path: <linux-kernel+bounces-279794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0807294C1F5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 17:51:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DB501F231F0
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 15:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A647D190470;
	Thu,  8 Aug 2024 15:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vae04t7d"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070C619006D
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 15:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723132184; cv=none; b=Fb2FvixMeKxAts/0HZNGxGcd+XT5rebFkZLmNNYucwk3gLEqfJ1NplCHKzE1zHfCdnLPf7bYv/tfjVyY/vWbTSSbEkCOz45CGziRrVoHYXpNoEWdA/NVExJ+L+AztmbS0uEItBaSgJEBvniQMZHl7hdc6ANybzShWBffVwagf/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723132184; c=relaxed/simple;
	bh=NChNezK7M1Rqd5zq6A3/MXQOAcQsuiYNlJbxN7iA4rI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uhdNtk2+nBZh6mJjOtn1d6+zlEiWPZ73q+4BCBnvwhcUDBbJMGPaWyBWakH0t79qDQgrdneN4o/GSILCMC0mTXoGt530DV7Mx3H1TMTPri6yDSeJDnQFeFYVqEZ4hp11GVdovyq++tF4O8s+cK04f+NcogH0uyOT7TAmKTOCTYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vae04t7d; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723132182;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c69S7nSyvekSR7azb7NgbUlVdfdg4AICMxtsy48mxj8=;
	b=Vae04t7d78qvb9KHjvMvuypinrIqb0ofTEZVvurErtEpd7I1s2E/curEL4pREdpTDE1Y64
	NwepxXFeJC4yZRtePdYvYTR4//lz+fzB0fP7SSszgApt8Gl3VDbXTwwOZX5K1+kXtRQvRS
	Me8Q6MN8DYqn4mYNamTnjSdLaYGJI6c=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-183-WkBMs5r0M4SXWgGZZMo8-A-1; Thu, 08 Aug 2024 11:49:40 -0400
X-MC-Unique: WkBMs5r0M4SXWgGZZMo8-A-1
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-70939f4bb1aso63367a34.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 08:49:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723132180; x=1723736980;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c69S7nSyvekSR7azb7NgbUlVdfdg4AICMxtsy48mxj8=;
        b=u8Sn9FdMEl9yT2ctS9LahwlYhwUAbXjYNELUgvwc5eOnjNbxDz3bmkNo671XTVi4fY
         fmBdzOkShIPpIveNSRt9a7hXuJtTUDVHu4zyLkEB1aLu//Ylu6SObdhe1iYIkFBzsRAK
         fCUoOvWBjkptm2iU3Yapj+ipcuBovI/hT+vy1pMmYi+T68ARAqs5pN3e6wiQEs+U7ewj
         J42Cs+/YRlU9d7TLfDjPQOs6QyGBuZokB2gddlJfNRgkN5kWhTu6A49CiNKcVHvp4Cbj
         16HN91zh5dv98u4JwboSuV+/zzY2ByMAsGez1b+wMFbNd2yFv1YOJEEVMgnwtvlITVvN
         LPpA==
X-Gm-Message-State: AOJu0YyFLbblWkKqGNEdquohJ0c0TIohqWFPvyjA4iWXh7xbNjBoNyPX
	LMwGtrfhERanQrEF+/DQaNNI5I+kS3egSu5m4bfTntN6inkMhk/fbqgeyYuK2hFzpp/GRjtLZGL
	0hMJ8S0MK1RRB3z+boG3ehEPWLhm/UmnJ0P01/zMx0WkbFAZon6EC34/p0WuD7w==
X-Received: by 2002:a05:6870:51c7:b0:260:ccfd:b270 with SMTP id 586e51a60fabf-26c58abb4bbmr2307fac.7.1723132180123;
        Thu, 08 Aug 2024 08:49:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG2v/RUodTRobMhQbY3FEHNXh4Gs9MwrhEqdXluF8KQ8hMZ3OnAtry4aRQGnOXF4AoW7eM3Og==
X-Received: by 2002:a05:6870:51c7:b0:260:ccfd:b270 with SMTP id 586e51a60fabf-26c58abb4bbmr2291fac.7.1723132179728;
        Thu, 08 Aug 2024 08:49:39 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a3785d0b3fsm171313085a.19.2024.08.08.08.49.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 08:49:39 -0700 (PDT)
Date: Thu, 8 Aug 2024 11:49:35 -0400
From: Peter Xu <peterx@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>
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
	Vlastimil Babka <vbabka@suse.cz>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Huang Ying <ying.huang@intel.com>
Subject: Re: [PATCH v4 5/7] mm/x86: arch_check_zapped_pud()
Message-ID: <ZrTpD0XOUsNMM9tP@x1n>
References: <20240807194812.819412-1-peterx@redhat.com>
 <20240807194812.819412-6-peterx@redhat.com>
 <878qx80xy8.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <878qx80xy8.ffs@tglx>

On Thu, Aug 08, 2024 at 12:28:47AM +0200, Thomas Gleixner wrote:
> On Wed, Aug 07 2024 at 15:48, Peter Xu wrote:
> 
> > Subject: mm/x86: arch_check_zapped_pud()
> 
> Is not a proper subject line. It clearly lacks a verb.
> 
>   Subject: mm/x86: Implement arch_check_zapped_pud()
> 
> 
> > Introduce arch_check_zapped_pud() to sanity check shadow stack on PUD zaps.
> > It has the same logic of the PMD helper.
> 
> s/of/as/

Will fix above two.

> 
> > +
> > +void arch_check_zapped_pud(struct vm_area_struct *vma, pud_t pud)
> > +{
> > +	/* See note in arch_check_zapped_pte() */
> > +	VM_WARN_ON_ONCE(!(vma->vm_flags & VM_SHADOW_STACK) &&
> > +			pud_shstk(pud));
> 
> Please get rid of the line break. You have 100 characters.

Coding-style.rst still tells me 80 here:

        The preferred limit on the length of a single line is 80 columns.

        Statements longer than 80 columns should be broken into sensible chunks,
        unless exceeding 80 columns significantly increases readability and does
        not hide information.

Maybe this just changed very recently so even not in mm-unstable?

I'll fix the two line-wrap in this patch anyway, as I figured these two
cases even didn't hit 80..  probably because I used fill-column=75 locally..

But still I'll probably need to figure it out for other spots.  Please help
me to justify.

> 
> > +}
> > diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> > index 2a6a3cccfc36..2289e9f7aa1b 100644
> > --- a/include/linux/pgtable.h
> > +++ b/include/linux/pgtable.h
> > @@ -447,6 +447,13 @@ static inline void arch_check_zapped_pmd(struct vm_area_struct *vma,
> >  }
> >  #endif
> >  
> > +#ifndef arch_check_zapped_pud
> > +static inline void arch_check_zapped_pud(struct vm_area_struct *vma,
> > +					 pud_t pud)
> > +{
> 
> Ditto..
> 
> > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > index 0024266dea0a..81c5da0708ed 100644
> > --- a/mm/huge_memory.c
> > +++ b/mm/huge_memory.c
> 
> Why is a mm change burried in a patch which is named mm/x86?
> 
> It's clearly documented that core changes with the generic fallback come
> in one patch and the architecture override in a separate one afterwards.
> 
> Do we write documentation just for the sake of writing it?

Hmm if that's the rule, in practise I bet many patches are violating that
rule that we merged and whatever patches I used to read.. but I see now,
I'll break this patch into two.

Personally I'd really still prefer it to be one patch especially when it's
only implemented in x86, then I copy x86+mm maintainers all here and it
explains why it's there.  So please let me know if you think it may still
make sense to keep this patch as-is, or I'll split by default.

Thanks,

-- 
Peter Xu


