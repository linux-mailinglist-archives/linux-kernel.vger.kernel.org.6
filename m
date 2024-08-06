Return-Path: <linux-kernel+bounces-276602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB2099495EB
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 18:52:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1893F1C222A5
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 16:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBDBC45C18;
	Tue,  6 Aug 2024 16:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QJeb4wwN"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6600418EB0
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 16:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722963112; cv=none; b=gB3/pid+PXjgCiNmijUiGVaR1WYYLQxk2aveU1d8sgkoHSjokiJA122dJNASOhdxC4Pfa1PviwhelE3ew+6tihYVgT2c8BMxIDuAA7UHD1ZozM22BzP4oiCPaaXfekVi5GLQT1mZDhMn43OCzh2GWNsVDuadl+ahAXLX8TaFi90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722963112; c=relaxed/simple;
	bh=AHc0BZPonfl1l7/cpOnljbv+DPHVJ/KoWRXEEPaZyAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KEpj/msC9YvddIoDEKuSYZN2DZ13IPjABnqtfCu+TU0Qr2fyqlN50BTIbBZbyzNPHeAyOrom5gEeBgeTFJT1MGE6F+xz4/tNOhDv7PC5T62yUWzYRZiU3SJCCrIyzhyqzShOh+A/vqLsxr5syH9J1IFZyMbvarhVUAnIk6XJha8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QJeb4wwN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722963109;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/mCJXCJjs2Oa+lqZWj1oOLjxdvcWGqBpryPUVus180I=;
	b=QJeb4wwNrGJbUFf7trdNi8T+d/9fD15nrFfKvwGFOUMkyIUMZgporbMJu8y++rqf+2CAND
	RSt6LngCb+cxT4Zl74VoeDpFX0RKdHYEAi9hxbuuQcuUY6snNnyeIyH5pdjOlMuKnYxG9W
	PEvjBafDmJq6vFLnJmlR4eF+ZdCkBlc=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-gB1bfeMoOjaS9bBj7ZdT0g-1; Tue, 06 Aug 2024 12:51:48 -0400
X-MC-Unique: gB1bfeMoOjaS9bBj7ZdT0g-1
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-5d5af231915so61914eaf.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 09:51:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722963107; x=1723567907;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/mCJXCJjs2Oa+lqZWj1oOLjxdvcWGqBpryPUVus180I=;
        b=nRtfFNdN+yvSXkX5Zq2MqM1+OA+fe9nRJGSWJzqQ+nqPN5jtcdU0HvLgIOiT6rTkYk
         +ELvvWGviifgtLV1GNUqkwFVFz6T/sVANk1sY776ylW/1PT2em+TBSmBpVO0XfGAFxQV
         /jBFKP5vjMwbEVKtO7Z/IWIqtcqmkV07hUZUwaThnMJBm70qW9wtg6XSpQGV1HSwIsho
         L4dQzRippeWJ/uiZ7oAKE4l979XO/hEueqY0yrp1ucbI30Nbp+vclTwBAiNQRWubV4b2
         +19m7tu/WCHKVfVnvyoafeIieSrKMkg9MPE8wXKqJiM5aTMvi9/X6EnwH4FFfglDfJ7L
         i4Zg==
X-Forwarded-Encrypted: i=1; AJvYcCWsB6Ud+uNDFhCoORfKLn+2lZfIj/g3Q5pgRmB4toUZGz1RfldvF+f1/TH92YIo8vEhGLksMaVt/7INk3o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWkXrwo2E6I17Jps0wzR2y5Lyrs4PnTwL+diA2FUGKcM8c4v+R
	8OsS3+xb8fMZQ2x1W+aLDMEPqV94ETArUFeeBUG/VkIwP8xwAU15bBkAeZBiMxrgzWK5rnYUsIk
	RajDc5yNUyPsFnqvDnT9rDzAl5bEQYS7yV0fmm1BaEHhCZT6PBeHHrc8oozx08g==
X-Received: by 2002:a4a:b80c:0:b0:5c6:6029:1568 with SMTP id 006d021491bc7-5d6455f39d2mr8735143eaf.0.1722963107397;
        Tue, 06 Aug 2024 09:51:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFbwac9k+Zg/Ro5fMGPCeM4WfaEKkODNlqWaBpva+fIizYSSXt9HO+Y9Im0OPLjbfFmriUNWQ==
X-Received: by 2002:a4a:b80c:0:b0:5c6:6029:1568 with SMTP id 006d021491bc7-5d6455f39d2mr8735112eaf.0.1722963106982;
        Tue, 06 Aug 2024 09:51:46 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb9c83a236sm47898606d6.92.2024.08.06.09.51.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 09:51:46 -0700 (PDT)
Date: Tue, 6 Aug 2024 12:51:43 -0400
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
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
	Vlastimil Babka <vbabka@suse.cz>, Ingo Molnar <mingo@redhat.com>,
	Alex Thorlton <athorlton@sgi.com>
Subject: Re: [PATCH v3 2/8] mm/mprotect: Remove NUMA_HUGE_PTE_UPDATES
Message-ID: <ZrJUn3IhYDsHSADT@x1n>
References: <20240715192142.3241557-1-peterx@redhat.com>
 <20240715192142.3241557-3-peterx@redhat.com>
 <added2d0-b8be-4108-82ca-1367a388d0b1@redhat.com>
 <Zq-Y3qs5_PZW04bt@x1n>
 <054324a3-bc77-426f-a751-06700aad394e@redhat.com>
 <ZrJO0aLVaeRoo8eo@x1n>
 <a149ee8e-e53a-4978-b5af-dbf43c99cf7b@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a149ee8e-e53a-4978-b5af-dbf43c99cf7b@redhat.com>

On Tue, Aug 06, 2024 at 06:32:10PM +0200, David Hildenbrand wrote:
> On 06.08.24 18:26, Peter Xu wrote:
> > On Tue, Aug 06, 2024 at 03:02:00PM +0200, David Hildenbrand wrote:
> > > > Right.
> > > > 
> > > > I don't have a reason to change numa_pte_updates semantics yet so far, but
> > > > here there's the problem where numa_huge_pte_updates can be ambiguous when
> > > > there is even PUD involved.
> > > > 
> > > > In general, I don't know how I should treat this counter in PUD path even
> > > > if NUMA isn't involved in dax yet; it can be soon involved if we move on
> > > > with using this same path for hugetlb, or when 1G thp can be possible (with
> > > > Yu Zhao's TAO?).
> > > 
> > > We shouldn't bother about it in the PUD path at all I think. Especially as
> > > long as NUMA hinting doesn't apply to any of what we would handle on the PUD
> > > path :)
> > 
> > Hmm, I just noticed that hugetlb was never involved.. but then how about a
> > potential 1G THP?  Do you mean 1G THP will not be accounted in numa
> > balancing too even in the future?
> 
> My best guess is that you would want a separate counter for that. The old
> one was just badly named ...
> 
> 72403b4a0fbd even spells out "NUMA huge PMD updates".
> 
> 
> "NUMA huge PMD updates were the number of THP  updates which in combination
> can be used to calculate how many ptes were updated from userspace."
> 
> ... which doesn't make sense if you don't know how "huge" the huge actually
> was. :)
> 
> > 
> > The motivation I had this patch in this series is I want to be clear on how
> > I should treat this counter in pud path if it won't go.  And when people
> > compare the two paths we'll need to be clear why there's such difference if
> > I ignore it in pud path.
> > 
> > Per my current read on this counter, it might be an overkill to do that at
> > all, and it might be simpler we drop it now.
> 
> Fine with me. But I would send that out separately, not buried in this
> series. The we might actually get Mel to review (was he CCed?).

Yes he is.

Fair point, let's do this separately. It's just that when split I don't
feel strongly to push that patch alone..  no reason for me to push dropping
a counter that maybe some people can still use even if I don't.  More
important to me is how I should move on with PUD, then at least this is
fully discussed and ignoring is the option I'm ok.

I'll respin with this patch dropped as of now, then I'll add a comment in
the PUD patch mention this counter is ignored.

Thanks,

-- 
Peter Xu


