Return-Path: <linux-kernel+bounces-279671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E83994C04A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 16:54:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E17EAB273DD
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 14:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5060A18EFC1;
	Thu,  8 Aug 2024 14:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NU2iJXKX"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF2DB674
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 14:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723128868; cv=none; b=oMMhPVFRTFBGmZU4R+QinFvq3l8Wpigodgzcj+eOR/Vrt+gT7+F0Pr0/GAIaOYJnFp9tT7/oVXNTeE0yRh2ZIFMQ6tt4o/4TDMidbnomq1vJCpTICuUz9G9JiRYV/P/hOuR383liAGbMzQGOyBTi/zicVxArTKR1QM1ZAQyt2no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723128868; c=relaxed/simple;
	bh=7HP1ZPDuNorieLY22iz6Wcsd7Rrc4hxlfbjq8NcudzU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GuRVkYC1Eyy0IQaWesUu52hkbsZlHb8C8UWComWxg5WcWcbVDxIAb/fWXN3lw6t2u8Ckvuz1QtUXA/cPzoETc8YQ8SiEQdJh9DybPqGJvWUDG3vcdmse7sZ5QpBLC/QfMYgpJoc9MLr4QfVX1jGdQQN8Zsi/jiM62CjeOdKyvFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NU2iJXKX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723128865;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0YfHjxzOoIJLo5MdFMHzLs+Cgg2yZMeP3Ex80OFBemw=;
	b=NU2iJXKXYV2drVStquDANv8BsIjM4cR/b+TvIDp42io7u/XIVTen8lUaQJKPY5pKVOihgY
	OaLwrowbzC2tQqUI0DogUD5j7iZ4RBn9a3GZur42LPSlbuz4sBddpWHVjSU9x/QmuEqEN9
	PXV79rMdsDkBjS3qdRdLehvwbQl0QFQ=
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-511-W5Ncu5UKOhO6nLtOsjarqA-1; Thu, 08 Aug 2024 10:54:24 -0400
X-MC-Unique: W5Ncu5UKOhO6nLtOsjarqA-1
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-25e65d02dd4so100818fac.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 07:54:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723128863; x=1723733663;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0YfHjxzOoIJLo5MdFMHzLs+Cgg2yZMeP3Ex80OFBemw=;
        b=BsAi3b+dQHf1+81I0tirjA9Nwy2JL2jYE1G2Qta1c9Tl7FosghVqG/PlklJJeIuCK/
         nXWdUmza8qA1vBsTrUWWjiYMdx2Wko+h0aCigkmAFROpLEWaQL8y4B175WSN86YaEAEL
         W/327L96jsjhQL3eKxbLzfTKUD39VlBZOQc9ZsukDF1DDq1y+2xWjCW5W1M/4IWtlNFn
         t2kWLruYfwYfn4wJg+tUnLlb+tSXPLJYnDo6pl5nereI6fF3WI9X+tu076aqoJxSWIAn
         ozUb25vGGT/Rg+vK7TsuP3ylytXj+kekt2DLv2GnBR6YNcYrIAUw7Yej/SD5MQU2GF2E
         O5WA==
X-Gm-Message-State: AOJu0Yw2zSuEh0UJIfJJzXjMmhIGtbY4MqXw6/UwjdmR8ZLPTCW/BZIE
	WuzxpwJg8sGzLcd3KRFdxeTA2d1hk4+hxSWKGAj2KvlhWmtsOrEqFs/p0FupErjDCuUE/0wYR0q
	RNNamleff+yZR/FzWEmkbPGn9Th8oNy7LgLeUv6zPQ8u+pRVhZ5GV9BDw2ngROkr8aPI5rQ==
X-Received: by 2002:a05:6808:1490:b0:3da:ac08:b74a with SMTP id 5614622812f47-3dc3b4623aamr1357582b6e.7.1723128863365;
        Thu, 08 Aug 2024 07:54:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHiqsl7u491+dk16BCdQXSlY2KYF+kMbWvb93MQDcyt8BmOo92tc6HC335u2mF8sk01BC1ZNg==
X-Received: by 2002:a05:6808:1490:b0:3da:ac08:b74a with SMTP id 5614622812f47-3dc3b4623aamr1357566b6e.7.1723128862987;
        Thu, 08 Aug 2024 07:54:22 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a3785d0d1asm167486185a.25.2024.08.08.07.54.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 07:54:22 -0700 (PDT)
Date: Thu, 8 Aug 2024 10:54:19 -0400
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
Subject: Re: [PATCH v4 4/7] mm/x86: Make pud_leaf() only care about PSE bit
Message-ID: <ZrTcGxANpcvwp1qt@x1n>
References: <20240807194812.819412-1-peterx@redhat.com>
 <20240807194812.819412-5-peterx@redhat.com>
 <87bk240y8h.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87bk240y8h.ffs@tglx>

On Thu, Aug 08, 2024 at 12:22:38AM +0200, Thomas Gleixner wrote:
> On Wed, Aug 07 2024 at 15:48, Peter Xu wrote:
> > An entry should be reported as PUD leaf even if it's PROT_NONE, in which
> > case PRESENT bit isn't there. I hit bad pud without this when testing dax
> > 1G on zapping a PROT_NONE PUD.
> 
> That does not qualify as a change log. What you hit is irrelevant unless
> you explain the actual underlying problem. See Documentation/process/
> including the TIP documentation.

Firstly, thanks a lot for the reviews.

I thought the commit message explained exactly what is the underlying
problem, no?

The problem is even if PROT_NONE, as long as the PSE bit is set on the PUD
it should be treated as a PUD leaf.  Currently, the code will return
pud_leaf()==false for those PROT_NONE PUD entries, and IMHO that is wrong.
This patch wants to make it right.  I still think that's mostly what I put
there in the commit message..

Would you please suggest something so I can try to make it better,
otherwise?  Or it'll be helpful too if you could point out which part of
the two documentations I should reference.

> 
> > diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
> > index e39311a89bf4..a2a3bd4c1bda 100644
> > --- a/arch/x86/include/asm/pgtable.h
> > +++ b/arch/x86/include/asm/pgtable.h
> > @@ -1078,8 +1078,7 @@ static inline pmd_t *pud_pgtable(pud_t pud)
> >  #define pud_leaf pud_leaf
> >  static inline bool pud_leaf(pud_t pud)
> >  {
> > -	return (pud_val(pud) & (_PAGE_PSE | _PAGE_PRESENT)) ==
> > -		(_PAGE_PSE | _PAGE_PRESENT);
> > +	return pud_val(pud) & _PAGE_PSE;
> >  }
> 
> And the changelog does not explain why this change is not affecting any
> existing user of pud_leaf().

That's what I want to do: I want to affect them..

And IMHO it's mostly fine before because mprotect() is broken with 1g
anyway, and I guess nobody managed to populate any pud entry with PROT_NONE
on dax 1g before, and that's what this whole series is trying to fix.

Thanks,

-- 
Peter Xu


