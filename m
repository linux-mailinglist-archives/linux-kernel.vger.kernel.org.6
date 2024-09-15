Return-Path: <linux-kernel+bounces-329858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A17F9796C1
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 15:14:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2070328183F
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 13:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B28C1C57AC;
	Sun, 15 Sep 2024 13:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gmQyedi/"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFFA5125DB
	for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 13:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726406069; cv=none; b=moNonv/oLCwajvtHObiBpd7bPDmTmuv4NDUU9ycw3R1rhqArD9ZJai/JHZtzsmdJpsxSekTMdf7jWVt24Tw1sY08ljjO/Fim5XfdKjnnFBRejDLWam9MNEJucKWH4GbSB+mV1a5QZI7FVcQBsAx8SmVzMgkuVqWGdImtqLXmstU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726406069; c=relaxed/simple;
	bh=vGAWYDwtmHEp0feNY96nZ5iZ5K0RUZuhddHMGLSRve0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JFcFuJWWcVd9lnZajwbDL3UxhskmuEKH0C69OcnnwZsKyDHQIVnGvPcYrAc2yOyT56OG77hG9/evlTF28cs178mRO/ydTvtip/2V3pBMnDNLyCNWrEiqGnYPPDtYp5QVVQGdnBvOLQ1q20LUN+RtAJirLmrLGk8HDBVPToIE8Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gmQyedi/; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-374b25263a3so1535885f8f.0
        for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 06:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726406066; x=1727010866; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EKD0tpWk/TDA0am1PYoTZE4iDckLnw1hxZdm5GR5XZM=;
        b=gmQyedi/TvT9Wpq5A0q239iUJMwJpDQC1sUwMmrbM9o31n4WdPX2ihPGh+1qOU1j7G
         bVDjXBQKYRkYI0dbp9fuZpSoQTneLQayn4yZSHRYwd0+AuddumMMZqhtoibYmwJEH/sH
         dk2tiX+qGKKmedW76E9Aot5LeGaM1mhHoPqiFIXmFSOEGCiERP0BtE8ykoehPWmIkuTx
         yoz2ugeVZ3yqkCyAw5o4pQCrPkHE4PNfJGW7XkAVzt0bxxPZwWlVh3BFTEeUOSGGPcIQ
         C+fMovw05C3GljlOtpiD4QOAmQ43QuBlzrGWDYH9PBBCa85hAJ33TCfA/jH4ybVryr+h
         tpXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726406066; x=1727010866;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EKD0tpWk/TDA0am1PYoTZE4iDckLnw1hxZdm5GR5XZM=;
        b=Zj1hag7ZZHOGjphZXL9GpKBdwVAE6PB+JiO5r51m1lT1UIo70z8Od8/Ll3eVhTI8vi
         7r8w0Kj34rf2Scvmqo7vOKdqC4WydRzWcLDGJzzTsxBcihVE+bfDcafkOOD33sMlgc4y
         4WVjuGXi0ULX1al4mivPtMkZFn1zy1aPdRhC57fv1sL8tBoyT3V1LxhUI85gjuUFaXKc
         Lfg/RcHmDrqBCao2Jd3TtSan0RLVPwABzTfg2nA06FEQuB4Jc8+0SFvOplKTOc58qcH9
         LogQEyNG+IiqAIHnA4o8hgVRXYNk3MRhb5faG2qvroFJq7LeBHOmiUVXAlbujT/hw+RL
         OkPg==
X-Forwarded-Encrypted: i=1; AJvYcCVsJ0Q/qzFY6XQDhaC3e7NpDtGig5cN9PnRZERjBrPX/W4v/W8ACpIxrjXNCY2zKHy+WjJXslpv9OkDv5A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2f+pyLxP3WpZdHru26nLWPy7k2turCuirhgjjiS4cnAd9nB//
	XJzfZsnuqgd3Pc9cVzuVUfqH88bPjL56sQ/uxdXXcTt/tD+0mtr/G0A3i5S1Oc4=
X-Google-Smtp-Source: AGHT+IFtIuzO5eYvGi3Zx+kKoxVxq6/zqJvEOCLFr12A5pI5BsIr6lY6Cy/lE6tjqXv3EVut986fzw==
X-Received: by 2002:adf:b219:0:b0:374:ca4f:bd70 with SMTP id ffacd0b85a97d-378d62537c7mr3858969f8f.53.1726406065923;
        Sun, 15 Sep 2024 06:14:25 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e73f9999sm4645289f8f.58.2024.09.15.06.14.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Sep 2024 06:14:25 -0700 (PDT)
Date: Sun, 15 Sep 2024 16:14:21 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org,
	Dimitri Sivanich <dimitri.sivanich@hpe.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [bug report] mm: avoid leaving partial pfn mappings around in
 error case
Message-ID: <e62f5784-f4e2-4f46-b8e8-8ea80b400927@stanley.mountain>
References: <8e3ffaf2-358f-479c-8de6-46e1b0bb0c5f@stanley.mountain>
 <68590155-fd3c-4ce4-9a1f-d314efada198@lucifer.local>
 <5a2f4219-e863-413a-96b9-ad2002f5b35d@stanley.mountain>
 <998b7c12-19a5-4213-8df6-154f50cd5dee@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <998b7c12-19a5-4213-8df6-154f50cd5dee@lucifer.local>

On Sun, Sep 15, 2024 at 01:38:40PM +0100, Lorenzo Stoakes wrote:
> + get_maintainers.pl people for drivers/misc/sgi-gru/grumain.c
> 
> On Sun, Sep 15, 2024 at 03:09:35PM GMT, Dan Carpenter wrote:
> > On Sun, Sep 15, 2024 at 01:01:43PM +0100, Lorenzo Stoakes wrote:
> > > On Sun, Sep 15, 2024 at 01:08:27PM GMT, Dan Carpenter wrote:
> > > > Hi Linus,
> > > >
> > > > Commit 79a61cc3fc04 ("mm: avoid leaving partial pfn mappings around in
> > > > error case") from Sep 11, 2024 (linux-next), leads to the following
> > > > Smatch static checker warning:
> > > >
> > > > 	mm/memory.c:2709 remap_pfn_range_notrack()
> > > > 	warn: sleeping in atomic context
> > > >
> > > > mm/memory.c
> > > >     2696 int remap_pfn_range_notrack(struct vm_area_struct *vma, unsigned long addr,
> > > >     2697                 unsigned long pfn, unsigned long size, pgprot_t prot)
> > > >     2698 {
> > > >     2699         int error = remap_pfn_range_internal(vma, addr, pfn, size, prot);
> > > >     2700
> > > >     2701         if (!error)
> > > >     2702                 return 0;
> > > >     2703
> > > >     2704         /*
> > > >     2705          * A partial pfn range mapping is dangerous: it does not
> > > >     2706          * maintain page reference counts, and callers may free
> > > >     2707          * pages due to the error. So zap it early.
> > > >     2708          */
> > > > --> 2709         zap_page_range_single(vma, addr, size, NULL);
> > > >
> > > > The lru_add_drain() function at the start of zap_page_range_single() takes a
> > > > mutext.
> > >
> > > Hm does it? I see a local lock, and some folio batch locking which are
> > > local locks too?
> >
> > Ah...  No it doesn't.  It's the mmu_notifier_invalidate_range_start() which is
> > a might_sleep() function.  Sorry for the confusion.
> 
> OK so in conclusion it seems to be that Linus's commit introducing
> zap_page_range_single() accidentally had smatch hit a might_sleep() via
> mmu_notifier_invalidate_range_start(), but it should, in theory, have fired
> due to page table allocations invoking the page allocator that might sleep,
> but didn't, because smatch misses the below might_alloc() path...
> 
> -> prepare_alloc_pages()
>    -> might_alloc()
>       -> might_sleep_if(gfpflags_allow_blocking(gfp_mask))
> 
> ...as a result of get_zeroed_page() tripping it up *breathes*. :)
> 
> (please correct me if I am wrong here).

That's an accurate summary...

> 
> The preempt_disable() is introduced in commit fe5bb6b00c3a9 ("sgi-gru: misc
> GRU cleanup") from... 2009, but it fixed it from the far far more broken
> 'disable preemption before taking a mutex' situation that existed before.
> 
> So fix seems to me to not invoke remap_pfn_range() with preemption disabled
> and a mutex held? gru_fault() maintainers added for input...

Every time I get a response to this bug report I feel dumber.  How did I not
see that this was a bug in drivers/misc/sgi-gru/?  Here is another one from the
same driver:

drivers/misc/sgi-gru/grukservices.c:262 gru_get_cpu_resources() warn: sleeping in atomic context

regards,
dan carpenter

