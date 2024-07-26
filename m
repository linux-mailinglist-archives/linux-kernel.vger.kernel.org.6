Return-Path: <linux-kernel+bounces-263202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 569BA93D299
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 13:57:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ABA8AB209BF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 11:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1447417A5AF;
	Fri, 26 Jul 2024 11:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g+66Flo7"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D3436D
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 11:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721995015; cv=none; b=tyW926ttQWyVu6pKTDjQ6TV4st194yPZ9JunLkJKVsFA5Ne7HNWBFDf9qe5P53gFAFY64RySyZgwohBltlzGI0FZ7AVBORSb8zYxmkhjKeIUcFfh7EqXJGdX9WbjSH/IMXG6K/R3PQnFt2NdPwMhfQybyWYh4pGZxVIC4E/TOJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721995015; c=relaxed/simple;
	bh=+gflEwjn2lHmvpNQUTpiaPOlEqdAMFvLHX8pUs6rmzo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OMAcKCNbgN3+Gzm439BV8GIjzuTrRy+/HY7lEGc+ltduPA8cVxmHjwaV5W7fJFAY2c9a2ZYhZVYsgjAmJukDCwlW3onwSh9zeqTQAqdV+S6qMPHo9QcojICWgaoDC+6CWEiLL9CH7mBA4DoNA6vhINgwBmz1V6mjJ1DLr4wZG6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g+66Flo7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721995012;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4Z86IH/NwuVbs4wh6Itna1eI4RVlRsUnJ2R+cQ/ZJjM=;
	b=g+66Flo7xtMc8KGlUM19YvKEDkNAKyL4CIWItT/kpVWaHI58/YbxgBQcva14y0mpzpImNz
	6uh9xhiB4M+7VNnjOBeBn2eBWE6XxlLnAxlnJudu16qR17wfznFxW0+hNslHqw/my5UQDq
	+TlgOZDPbi5Hd6WSLrzcV6fWMOR2ke4=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-550-PyzfBCYvPZO8k-MQKhGNpw-1; Fri, 26 Jul 2024 07:56:50 -0400
X-MC-Unique: PyzfBCYvPZO8k-MQKhGNpw-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6b7973ab9cbso1878806d6.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 04:56:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721995010; x=1722599810;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4Z86IH/NwuVbs4wh6Itna1eI4RVlRsUnJ2R+cQ/ZJjM=;
        b=AIKbIhum9EPkAYk4yQWmk66crzQPdprwVI7QIcOHAr7WgW9nowoqBuAXoRv1R3yQqi
         oS/h4tNKMPoAur2kmoul6CkmVVqm6uhpcgX+sdxor/0XfZeFZfihtOZEiIN4Vbu0QZ/V
         HgUbBK/BiS7a7NrJBgerycPhfj9pyovLlmfN7p7BgM4TXClAS8oQ5SiEbJKZSayWAv3j
         QkWD3dMytw1kD+ztMQZDGFCKDVUd0ibET2yhYgR7Ng1ff13tXv1nXM8JRZksece7IQlX
         WVxKiNh+ovZGYbMu8UXwWgmVtRJpoH5BZmSYqjBoZi8BRZtrIuK9RZFhKu8qgDY05b2Q
         rFoA==
X-Forwarded-Encrypted: i=1; AJvYcCUchxldpLUON8yMB5QY7n97EZLt0BqWkU5/xIXa09vcVlysK6/XMQnfgr8+VBkF1j1HmTmeo/icrJbsD9tMc5r9Dk6gU7VWa7beZD2b
X-Gm-Message-State: AOJu0YwMwNEtNZEPx/gLdHlJPaswTxRqhJmrSzZXg10mg8XTudOdFh1r
	GvvuA3ZPlnyRs1RMgzTVAvKI/GJpe0n5IOCwKEIXulWoi4YaVFr6JnX2WArKe3Pu/IJqQ4ZSHhu
	JTf309biBbEPWyew0EUnOH7ZNJBVpBir4cIZA2YL4eZqMs51WSj1bCBTKNA9zxw==
X-Received: by 2002:a05:6214:519a:b0:6b0:6370:28d4 with SMTP id 6a1803df08f44-6bb3e36d07bmr37225526d6.6.1721995010429;
        Fri, 26 Jul 2024 04:56:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEEGvC2s1YpmC7Xh0oPNbR2PTMgHDtIWIWACRSqNjlE8cYjZEpmS07NBeANfwhQ2eLo+N025Q==
X-Received: by 2002:a05:6214:519a:b0:6b0:6370:28d4 with SMTP id 6a1803df08f44-6bb3e36d07bmr37225126d6.6.1721995009990;
        Fri, 26 Jul 2024 04:56:49 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb3fb17327sm15684346d6.145.2024.07.26.04.56.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 04:56:49 -0700 (PDT)
Date: Fri, 26 Jul 2024 07:56:46 -0400
From: Peter Xu <peterx@redhat.com>
To: James Houghton <jthoughton@google.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Dave Jiang <dave.jiang@intel.com>, Rik van Riel <riel@surriel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	linuxppc-dev@lists.ozlabs.org, Matthew Wilcox <willy@infradead.org>,
	Rick P Edgecombe <rick.p.edgecombe@intel.com>,
	Oscar Salvador <osalvador@suse.de>,
	Mel Gorman <mgorman@techsingularity.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Borislav Petkov <bp@alien8.de>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Huang Ying <ying.huang@intel.com>,
	"Kirill A . Shutemov" <kirill@shutemov.name>,
	"Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Hugh Dickins <hughd@google.com>, x86@kernel.org,
	Nicholas Piggin <npiggin@gmail.com>,
	Vlastimil Babka <vbabka@suse.cz>, Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH v3 8/8] mm/mprotect: fix dax pud handlings
Message-ID: <ZqOO_hlZtsUIUXUU@x1n>
References: <20240715192142.3241557-1-peterx@redhat.com>
 <20240715192142.3241557-9-peterx@redhat.com>
 <CADrL8HVH8ff+_Szrmn4ZCyAkm9gDc2oY4VVo3r+6RN_ms6pbhw@mail.gmail.com>
 <ZqLUjQb2BjedihOx@x1n>
 <CADrL8HWGf9BD5WX_zu7TW9NQXVXUwmaeHU6EGRJkSXyk2zesmg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADrL8HWGf9BD5WX_zu7TW9NQXVXUwmaeHU6EGRJkSXyk2zesmg@mail.gmail.com>

On Thu, Jul 25, 2024 at 05:23:48PM -0700, James Houghton wrote:
> On Thu, Jul 25, 2024 at 3:41 PM Peter Xu <peterx@redhat.com> wrote:
> >
> > On Thu, Jul 25, 2024 at 11:29:49AM -0700, James Houghton wrote:
> > > > -               pages += change_pmd_range(tlb, vma, pud, addr, next, newprot,
> > > > +
> > > > +               if (pud_leaf(pud)) {
> > > > +                       if ((next - addr != PUD_SIZE) ||
> > > > +                           pgtable_split_needed(vma, cp_flags)) {
> > > > +                               __split_huge_pud(vma, pudp, addr);
> > > > +                               goto again;
> > >
> > > IIUC, most of the time, we're just going to end up clearing the PUD in
> > > this case. __split_huge_pud() will just clear it, then we goto again
> > > and `continue` to the next pudp. Is that ok?
> > >
> > > (I think it's ok as long as: you never map an anonymous page with a
> > > PUD,
> >
> > I think this is true.
> >
> > > and that uffd-wp is not usable with non-hugetlb PUD mappings of
> > > user memory (which I think is only DAX?).
> >
> > Uffd-wp has the async mode that can even work with dax puds.. even though I
> > don't think anyone should be using it.  Just like I'm more sure that nobody
> > is using mprotect() too with dax pud, and it further justifies why nobody
> > cared this much..
> >
> > What uffd-wp would do in this case is it'll make pgtable_split_needed()
> > returns true on this PUD, the PUD got wiped out, goto again, then
> > change_prepare() will populate this pud with a pgtable page.  Then it goes
> > downwards, install PMD pgtable, then probably start installing pte markers
> > ultimately if it's a wr-protect operation.
> 
> Ah, I didn't understand this patch correctly. You're right, you'll
> install PMDs underneath -- I thought we'd just find pud_none() and
> bail out. So this all makes sense, thanks!
> 
> >
> > > So it seems ok today...?)
> >
> > Yes I think it's ok so far, unless you think it's not. :)
> >
> > >
> > > Also, does the comment in pgtable_split_needed() need updating?
> >
> > /*
> >  * Return true if we want to split THPs into PTE mappings in change
> >  * protection procedure, false otherwise.
> >  */
> >
> > It looks to me it's ok for now to me? THP can represents PUD in dax, and we
> > indeed want to break THPs (no matter PUD/PMD) finally into PTE mappings.
> 
> Oh, heh I was thinking of the other comment:
> 
> /*
> * pte markers only resides in pte level, if we need pte markers,
> * we need to split.  We cannot wr-protect shmem thp because file
> * thp is handled differently when split by erasing the pmd so far.
> */
> 
> I guess this is fine too, it just kind of reads as if this function is
> only called for PMDs. *shrug*

Ah ok, yeah it looks mostly fine here too.  Let's make this easy by keeping
it as-is, but if there'll be a new version I can touch it up if it helps
the readings.

> 
> >
> > >
> > > Somewhat related question: change_huge_pmd() is very careful not to
> > > clear the PMD before writing the new value. Yet change_pmd_range(),
> > > when it calls into __split_huge_pmd(), will totally clear the PMD and
> > > then populate the PTEs underneath (in some cases at least), seemingly
> > > reintroducing the MADV_DONTNEED concern. But your PUD version, because
> > > it never re-populates the PUD (or PMDs/PTEs underneath) does not have
> > > this issue. WDYT?
> 
> I guess I'm wrong about this -- your PUD version is the same as the
> PMD version in this respect: both clear the PUD/PMD and then install
> lower page table entries.
> 
> >
> > Could you elaborate more on the DONTNEED issue you're mentioning here?
> 
> In change_huge_pmd(), there is a comment about not clearing the pmd
> before setting the new value. I guess the issue is: if a user is
> MADV_DONTNEEDing some memory and happens to see a cleared PMD, it will
> just move on. But in this case, if change_huge_pmd() temporarily
> cleared a PMD, then MADV_DONTNEED saw it and moved on, and then
> change_huge_pmd() installed a new PMD, the MADV_DONTNEED has basically
> skipped over the PMD, probably not what the user wanted. It seems like
> we have the same issue when a PMD is cleared when we're splitting it.
> 
> But yeah, given that your PUD version is apparently no different from
> the PMD version in this respect, maybe this question isn't very
> interesting. :)

Ah that one, so yeah that's why I introduced pudp_invalidate() in this
series to make sure that issue isn't there.  Then I assume we're good.

Thanks,

-- 
Peter Xu


