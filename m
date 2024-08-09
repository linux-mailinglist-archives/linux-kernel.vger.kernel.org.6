Return-Path: <linux-kernel+bounces-280986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EF6194D1A1
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 15:53:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A25E81F24A6E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 13:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C02E195B14;
	Fri,  9 Aug 2024 13:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hqSktPeD"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F8E1E49B
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 13:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723211617; cv=none; b=n3ignlPohVLv1PuF2d45DBwv6nWBU6/349OtuAXTERpIr+eK9BCX4zIINCJ0lTzvdYe8Cya8jmdXdSodTUC8khknbkqcAMlYPdLUcCsWw4uu+9lX4MKWQpwbOP4TDPUzw1TLSO2K1zdo6p9x8klXBBgpO0uJxAsavH7fTtv3AJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723211617; c=relaxed/simple;
	bh=5abXkopCeNFzF1FwOFBExUN4HrZ5nx8S4qtwAUb6CZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uuQi9DmKygzewd/55qvqA4HatPLs5QCYEkh1wC5bZp56XjjPl42rvriEQ99WMdy6HSFdB8lZzVr/UAC8bh7OrFvyvS+cCR5WG4dOVOvzF6vFRmohcnlsZPcUZyzlLZzJwLYxLMTbOBWCbFUGPAaQ/oq3xIvTaDX0DkRnPeqfWs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hqSktPeD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723211614;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WDbHYgHEck43iqNj8mlC9mwPoKgwtzUQVA3kNM0mHs4=;
	b=hqSktPeDdyoWftUYy396CXzGk3lENp8rcsLcYr64y06/LrjVg+kyBxA3yxRLZzg3eX9HFH
	Y5ya50Y02vPga13ZnJvFJBKR9vYFjrF9E2uugtkmUIYrB1NaofWQ4krAh+NdpiI87DOOW3
	4PCp8ZFP2YfrJVEq1eD9BPuGVqjFm7E=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-FEvdoCBwMRugDC0CXIp_hQ-1; Fri, 09 Aug 2024 09:53:33 -0400
X-MC-Unique: FEvdoCBwMRugDC0CXIp_hQ-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6bba0f9d3efso4039976d6.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 06:53:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723211612; x=1723816412;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WDbHYgHEck43iqNj8mlC9mwPoKgwtzUQVA3kNM0mHs4=;
        b=NNm2l9Aub1V7lNasefLXdnXeF4TyqMPiEXCTAzb1L9E5u0GLAcnf13RTtjLofenBPE
         rLdVZh6+vFQS/JhIqvn8HjveAa3d3dyGsbHakC/M4+lPZ4UEMCiD07rfy70Q3T95Rqq7
         98LcItmwN5zqxy74Zu5QjkDbUiiIideHm13gZBT858L3For3xbmlSqxdCZcN/sdTchOG
         HaWE2qAbE1VgE/d9aTRBfRvxPcM4SsDLNzgRCvHuiXmiHthcRPBG1Vygzom42S9fcuoa
         D/zoKmHov0sCtEllCuIcfzGGeq28FrJuOEbxZoezn6ZVsyZQLxqjPjf0epSddXnaiF8L
         MYSA==
X-Gm-Message-State: AOJu0Yyw64LMhIrQxW72I4WMNqRTWkcqu6eY+lz8Jj72p8V0NeCJygBZ
	nWMlzLQL4yB4DFa5mH6XDXlr7WV3E1225twaYJTZ36CerE1SKUX+7xdvv01h/58GVlNNF0v+Yjo
	P7eCHL5XUmAgoXYCcZTSHCf9De4CCU4tByIdt2ojCS+ye9QbBqNi+RlfKQJsQbA==
X-Received: by 2002:a05:620a:319d:b0:7a1:5683:4aae with SMTP id af79cd13be357-7a4c18681efmr93159385a.10.1723211612529;
        Fri, 09 Aug 2024 06:53:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHMiWgDgRbpmEJ2yt83G9IfveiqoJa1zDyWB54xiHqbp4o5xzDhd8cR/4kQNOyjKUHOvFbE/Q==
X-Received: by 2002:a05:620a:319d:b0:7a1:5683:4aae with SMTP id af79cd13be357-7a4c18681efmr93156985a.10.1723211612040;
        Fri, 09 Aug 2024 06:53:32 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a3786d43f2sm263955685a.125.2024.08.09.06.53.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 06:53:31 -0700 (PDT)
Date: Fri, 9 Aug 2024 09:53:28 -0400
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
Message-ID: <ZrYfWLkey3v7cDi0@x1n>
References: <20240807194812.819412-1-peterx@redhat.com>
 <20240807194812.819412-5-peterx@redhat.com>
 <87bk240y8h.ffs@tglx>
 <ZrTcGxANpcvwp1qt@x1n>
 <87mslluceb.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87mslluceb.ffs@tglx>

On Fri, Aug 09, 2024 at 02:08:28PM +0200, Thomas Gleixner wrote:
> https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#changelog
> 
>   A good structure is to explain the context, the problem and the
>   solution in separate paragraphs and this order

I'll try to follow, thanks.

[...]

> > And IMHO it's mostly fine before because mprotect() is broken with 1g
> > anyway, and I guess nobody managed to populate any pud entry with PROT_NONE
> > on dax 1g before, and that's what this whole series is trying to fix.
> 
> Again your humble opinion matters, but technical facts and analysis
> matter way more.

All the rest comments in the reply were about "why it's a PUD leaf".  So
let me reply in one shot.

Referring to pXd_leaf() documentation in linux/pgtable.h:

/*
 * pXd_leaf() is the API to check whether a pgtable entry is a huge page
 * mapping.  It should work globally across all archs, without any
 * dependency on CONFIG_* options.  For architectures that do not support
 * huge mappings on specific levels, below fallbacks will be used.
 *
 * A leaf pgtable entry should always imply the following:
 *
 * - It is a "present" entry.  IOW, before using this API, please check it
 *   with pXd_present() first. NOTE: it may not always mean the "present
 *   bit" is set.  For example, PROT_NONE entries are always "present".
 *
 * - It should _never_ be a swap entry of any type.  Above "present" check
 *   should have guarded this, but let's be crystal clear on this.
 *
 * - It should contain a huge PFN, which points to a huge page larger than
 *   PAGE_SIZE of the platform.  The PFN format isn't important here.
 *
 * - It should cover all kinds of huge mappings (e.g., pXd_trans_huge(),
 *   pXd_devmap(), or hugetlb mappings).
 */

It explicitly stated that PROT_NONE should be treated as a present entry,
and also a leaf. The document is for pXd_leaf(), so it should cover puds
too.  In this specific case of the zapping path, it's only possible it's a
DAX 1G thp.  But pud_leaf() should work for hugetlb too, for example, when
PROT_NONE applied on top of a 1G hugetlb with PSE set.

Unfortunately, I wrote this document in 64078b3d57.. so that's also another
way of saying "my humble opinion".. it's just nobody disagreed so far, and
please shoot if you see any issue out of it.

IOW, I don't think we must define pXd_leaf() like this - we used to define
pXd_leaf() to cover migration entries at least on x86, for example. But per
my own past mm experience, the current way is the right thing to do to make
everything much easier and less error prone.  Sorry, I can't get rid of
"IMHO" here.

Another example of "we can define pXd_leaf() in other ways" is I believe
for PPC 8XX series it's possible to make special use of pmd_leaf() by
allowing pmd_leaf() to return true even for two continuous pte pgtable
covering 8MB memory.  But that will be an extremely special use of
pmd_leaf() even if it comes, maybe worth an update above when it happens,
and it'll only be used by powerpc not any other arch.  It won't happen if
we want to drop 8MB support, though.

So in short, I don't think there's a 100% correct "technical" answer of
saying "how to define pxx_leaf()"; things just keep evolving, and "humble
opinions" keeps coming with some good reasons.  Hope that answers the
question to some extent.

Taking all things into account, I wonder whether below enriched commit
message would get me closer to your ACK on this, trying to follow the rule
you referenced on the order of how context/problem/solution should be
ordered and addressed:

    When working on mprotect() on 1G dax entries, I hit an zap bad pud
    error when zapping a huge pud that is with PROT_NONE permission.

    Here the problem is x86's pud_leaf() requires both PRESENT and PSE bits
    set to report a pud entry as a leaf, but that doesn't look right, as
    it's not following the pXd_leaf() definition that we stick with so far,
    where PROT_NONE entries should be reported as leaves.

    To fix it, change x86's pud_leaf() implementation to only check against
    PSE bit to report a leaf, irrelevant of whether PRESENT bit is set.

Thanks,

-- 
Peter Xu


