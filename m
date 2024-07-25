Return-Path: <linux-kernel+bounces-262694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E598993CAEE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 00:41:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 130A21C21869
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 22:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD624143899;
	Thu, 25 Jul 2024 22:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TYWnhLea"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA7717E9
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 22:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721947286; cv=none; b=mNPSFwDgEcQaw1HD2mrBE7JykUhQjvB/0Ou+3oqIpmOA529y125pVpr4LyrGgxRv9HrFhDYRywlWmBuARlDtJweHGy032e6lAckqMGJ7MEPyWgfzD4ydx9130OM4/smqubEWZbMDoL4yfucSh47tRUM6Ut62a29B1pftyZfE84g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721947286; c=relaxed/simple;
	bh=ouynCymLEGFdQRCCm1k+hMnHMy7ftVf7aydHTsr3oBk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UzU8wX7UsDat/JZqyyxQtAK7bqL21Riu7aIs3q0evxhosY8IpLpw5iPBgqedQtFXB1JqTslZ5Hwicxr+fbG/tmlhLYaGRep9bTP8jJidVFfuDWIXwG35ijEI1dMRcqlhSF/P2PPDcWeO1cxmBamOtO6RmIexphfCyU5oNLe7Q1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TYWnhLea; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721947284;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=u5IjTDKou7RsegoJDQrUdTSsaR0wePSmCha5JTdz6Yk=;
	b=TYWnhLeauTdnLMp6mW/L/tNLNzroBP6rdUDxa2uRYEUSb/uM6whUzLjgZhgRmGxnemtMJ3
	eV5LdY6YtOkghZCgQ0pS9vlavib4IodOraXJPNHAmCwoqf9ZQtUExAJWYrox1IO3U8uXYv
	ABJA2HgjVDGh8zJEKKFlNKra+zI2PTY=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-494-RU4xciqvPV2MqM8YG2S5vw-1; Thu, 25 Jul 2024 18:41:22 -0400
X-MC-Unique: RU4xciqvPV2MqM8YG2S5vw-1
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-7093890e502so78574a34.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 15:41:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721947282; x=1722552082;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u5IjTDKou7RsegoJDQrUdTSsaR0wePSmCha5JTdz6Yk=;
        b=SH0IUB2mEPdF2cQUM2J7Zdk9mwpo2GYxqThuvdWmnO+HPV5pFW2A1gl0KsZxYzz8Zl
         qsyHWKzRf2yxKtse/bO8/lpYTKes9rvhk2s6qFd0BDDFEqyteUG+OfJKoZtn4PW3q04A
         b61q1n+EEoD1BVR5g2bHiv7h44qyBy2lGvxNGy9A+D7G2/AXAgf6gdVvXHatGFzbQDVA
         cMUsD1qBkmfgmKbvb41f7UufxhNzEX+kXzCTG5wFTpld6GSi99c9mAsol0DHolotwHJ1
         9bePPJ566okR3fAvt2i2HUeinR1m+x/B/5wb861e2fZrohTddaDjzQeuVHhetNWwhMcU
         QAcQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1+byX1KHQcNINfE53steKsmkK7bM7SCXo1jbMa/iNrYynircUwdIwxNwVhnz6/LOtnA9LXJ+F521Dk6Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw145Srt9mw7ukLY2Pr6UVheMvKStUDpD5a8lHR82/8YQR2nfua
	gk84+piLV43aSXlvoMTy7ErtXkzp4xUsU7iCBZhy/1OeA4A2N7FWJhCUn5yjq6RAhLrpxVeJlB6
	m4Bl8cl10aGLbokyHoJTVxNSBk95afpo7iH3t5VHOWRvN2Adhgve2tNUaFJ8q7w==
X-Received: by 2002:a05:6830:1651:b0:703:5c54:ddac with SMTP id 46e09a7af769-7092fa57dc7mr2750327a34.2.1721947281941;
        Thu, 25 Jul 2024 15:41:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGxIL6o6NZPBdYvHx1uIaunP84Pm7SW2ixxgCYcEwJ2VgyEqi0/RBTDXtRm2M6ZYXomWlm6fw==
X-Received: by 2002:a05:6830:1651:b0:703:5c54:ddac with SMTP id 46e09a7af769-7092fa57dc7mr2750314a34.2.1721947281608;
        Thu, 25 Jul 2024 15:41:21 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a1d739810bsm123991185a.16.2024.07.25.15.41.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 15:41:21 -0700 (PDT)
Date: Thu, 25 Jul 2024 18:41:17 -0400
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
Message-ID: <ZqLUjQb2BjedihOx@x1n>
References: <20240715192142.3241557-1-peterx@redhat.com>
 <20240715192142.3241557-9-peterx@redhat.com>
 <CADrL8HVH8ff+_Szrmn4ZCyAkm9gDc2oY4VVo3r+6RN_ms6pbhw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CADrL8HVH8ff+_Szrmn4ZCyAkm9gDc2oY4VVo3r+6RN_ms6pbhw@mail.gmail.com>

On Thu, Jul 25, 2024 at 11:29:49AM -0700, James Houghton wrote:
> > -               pages += change_pmd_range(tlb, vma, pud, addr, next, newprot,
> > +
> > +               if (pud_leaf(pud)) {
> > +                       if ((next - addr != PUD_SIZE) ||
> > +                           pgtable_split_needed(vma, cp_flags)) {
> > +                               __split_huge_pud(vma, pudp, addr);
> > +                               goto again;
> 
> IIUC, most of the time, we're just going to end up clearing the PUD in
> this case. __split_huge_pud() will just clear it, then we goto again
> and `continue` to the next pudp. Is that ok?
> 
> (I think it's ok as long as: you never map an anonymous page with a
> PUD,

I think this is true.

> and that uffd-wp is not usable with non-hugetlb PUD mappings of
> user memory (which I think is only DAX?).

Uffd-wp has the async mode that can even work with dax puds.. even though I
don't think anyone should be using it.  Just like I'm more sure that nobody
is using mprotect() too with dax pud, and it further justifies why nobody
cared this much..

What uffd-wp would do in this case is it'll make pgtable_split_needed()
returns true on this PUD, the PUD got wiped out, goto again, then
change_prepare() will populate this pud with a pgtable page.  Then it goes
downwards, install PMD pgtable, then probably start installing pte markers
ultimately if it's a wr-protect operation.

> So it seems ok today...?)

Yes I think it's ok so far, unless you think it's not. :)

> 
> Also, does the comment in pgtable_split_needed() need updating?

/*
 * Return true if we want to split THPs into PTE mappings in change
 * protection procedure, false otherwise.
 */

It looks to me it's ok for now to me? THP can represents PUD in dax, and we
indeed want to break THPs (no matter PUD/PMD) finally into PTE mappings.

> 
> Somewhat related question: change_huge_pmd() is very careful not to
> clear the PMD before writing the new value. Yet change_pmd_range(),
> when it calls into __split_huge_pmd(), will totally clear the PMD and
> then populate the PTEs underneath (in some cases at least), seemingly
> reintroducing the MADV_DONTNEED concern. But your PUD version, because
> it never re-populates the PUD (or PMDs/PTEs underneath) does not have
> this issue. WDYT?

Could you elaborate more on the DONTNEED issue you're mentioning here?

> 
> Thanks for this series!

Thanks for reviewing it, James.

-- 
Peter Xu


