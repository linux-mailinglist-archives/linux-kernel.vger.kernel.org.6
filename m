Return-Path: <linux-kernel+bounces-303155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15DD8960833
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 13:10:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A7F81C22985
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 11:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C51719E83C;
	Tue, 27 Aug 2024 11:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="CNuTXrtY"
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com [209.85.208.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486EA19DF97
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 11:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724757010; cv=none; b=TtNX6b2CRWncWo6EgEiyJpuU7PiXVE6syXhld6rLlE6qKwdyMGsJyZr+NZ7A512ImVrs1ijbMvul+YeAIYIsk99mSFT7awkFGfBvd5vlxuuLSms1qadxBKHDLN47cWmMMEbOO0p6HVTPsivjpl714BGHZ5YBfMFxG95l7oASuOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724757010; c=relaxed/simple;
	bh=lUKoTmu1bay1N5WAaZq+PqCeYVuwG/OQ96yMLxGgCA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tYyvLnb6KizCpFfffF5LuakpQk/hNOXeuZ7jeftptkoj/6Hts1/+DI10qHT043FPkJ0RluWvr/ebw+wL5oZl6jYWlC8OKIwW+N7YPSOSMKkIFfVrX1ukIO+FBliFSUCrc5Yoi9enJAeqWaSdgcCbLsFNhQOPgH1EbUsiH6WD19A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=CNuTXrtY; arc=none smtp.client-ip=209.85.208.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-ed1-f68.google.com with SMTP id 4fb4d7f45d1cf-5bef295a429so6314698a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 04:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1724757005; x=1725361805; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=b2GVADUu+50FR86WFWjEQDx1sWPsEjQk62VuMrGxa3s=;
        b=CNuTXrtYCjPkt7f+aZDGVfhrJ9/sxFSoIAVMp/WpRQJ5Gl1RFRbpNCoUWzLZX7LzS+
         6TudhMyhoi2D8bI/I0TOHpLsXMvdv8j/iLZ3DG9wrMraZi1ZiSW9X4qzIcstU3ZY2HP2
         pal7vxazLk9aGvBV9gPFTYhvyL1PVsBIImYMZGQH7YXpUCELQVE03GADq9u6HwQWY7Dc
         QoMrKV+tnw1iK0qZ7Uq42vBI6iV+okjxgoMJYRstpzCCfZVHVnXryd/aiBIa+AQewS6t
         D7BFblj+k7QXmvxJTVA3TQEc3yXbtAdqT+gauf8WS41PHYyOAMZ/Z3Eafc/gJFc8mAmU
         xacQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724757005; x=1725361805;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b2GVADUu+50FR86WFWjEQDx1sWPsEjQk62VuMrGxa3s=;
        b=aFsTwjZSX65pU91YbzMKkxjGi04uLY7TR9KCQugrB90bEXBGezJ7QQ29P0aasIWQIR
         fDND5kaF0O5BuAJn+qrwKDEOuWLBm0a71MiPQHJfpyqNHx05VaLF+fcFaLuccEheouPC
         JUsTFheMfwE1/7+vAzdE2oUHF9LPV8RBtNa67ydqqdapT4GRbBulIvcGD+uds93RN74P
         SfZxXAQ21Kr6PNRhxs02vXRNW7NIXSU8T3QoRI2N+izmzVmuuNxYbd4IY+fDbU69pBDa
         QoX6CdTWDNyviUlK8+TpnxQnNoGaSvsyRt/Rjvd9VcqO0r4s4Xf8NYzhRlY5KR2d5BxB
         zPGw==
X-Forwarded-Encrypted: i=1; AJvYcCXDhT2b36VrxGKOTIn7iYahjCHvsxbImdWusDDHSLA8Bl4KXuHzSf3ykCCT+C5bL8zagzZid+BHXpq+2Uc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzufbPclyh3HrXfDbON5rtyt5zUoJs+jQF8RsI38I2Wv0jFMVQl
	c42I3WymPl5HVmGirAuk0tBBm7dBha4oKbETjo7/EoArpoFwfO+b0oAzQdUlmro=
X-Google-Smtp-Source: AGHT+IFXILVvadY6JDPZpwFQLW1mMv0in4yMBTZeFRwWdlT0hkieZp9RXze6ioVo5e5lBWEyGlV/5A==
X-Received: by 2002:a17:907:86a9:b0:a86:7bdf:efcd with SMTP id a640c23a62f3a-a86a52b8ae9mr731168566b.20.1724757005143;
        Tue, 27 Aug 2024 04:10:05 -0700 (PDT)
Received: from localhost (ip-046-005-139-073.um12.pools.vodafone-ip.de. [46.5.139.73])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a86e549c1ffsm97141966b.50.2024.08.27.04.10.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 04:10:04 -0700 (PDT)
Date: Tue, 27 Aug 2024 13:09:59 +0200
From: Johannes Weiner <hannes@cmpxchg.org>
To: Usama Arif <usamaarif642@gmail.com>
Cc: Nico Pache <npache@redhat.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Barry Song <baohua@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Lance Yang <ioworker0@gmail.com>, Peter Xu <peterx@redhat.com>,
	Rafael Aquini <aquini@redhat.com>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Zi Yan <ziy@nvidia.com>
Subject: Re: [RFC 0/2] mm: introduce THP deferred setting
Message-ID: <20240827110959.GA438928@cmpxchg.org>
References: <20240729222727.64319-1-npache@redhat.com>
 <72320F9D-9B6A-4ABA-9B18-E59B8382A262@nvidia.com>
 <CAA1CXcCD798gkLoZuz3Cd5-Wf2MRfnAG_EB0U3nbScZeFv09dw@mail.gmail.com>
 <CAA1CXcCCOS8-aqcm+w8Aoqe2P5q005wMrgmtx=xjzJgjKFb7mg@mail.gmail.com>
 <61411216-d196-42de-aa64-12bd28aef44f@gmail.com>
 <CAA1CXcCe8QDir2KiWg=GmN4BErfXSDs_9kmnYfyK=X8H8U8QwA@mail.gmail.com>
 <698ea52e-db99-4d21-9984-ad07038d4068@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <698ea52e-db99-4d21-9984-ad07038d4068@gmail.com>

On Tue, Aug 27, 2024 at 11:37:14AM +0100, Usama Arif wrote:
> 
> 
> On 26/08/2024 17:14, Nico Pache wrote:
> > On Mon, Aug 26, 2024 at 10:47 AM Usama Arif <usamaarif642@gmail.com> wrote:
> >>
> >>
> >>
> >> On 26/08/2024 11:40, Nico Pache wrote:
> >>> On Tue, Jul 30, 2024 at 4:37 PM Nico Pache <npache@redhat.com> wrote:
> >>>>
> >>>> Hi Zi Yan,
> >>>> On Mon, Jul 29, 2024 at 7:26 PM Zi Yan <ziy@nvidia.com> wrote:
> >>>>>
> >>>>> +Kirill
> >>>>>
> >>>>> On 29 Jul 2024, at 18:27, Nico Pache wrote:
> >>>>>
> >>>>>> We've seen cases were customers switching from RHEL7 to RHEL8 see a
> >>>>>> significant increase in the memory footprint for the same workloads.
> >>>>>>
> >>>>>> Through our investigations we found that a large contributing factor to
> >>>>>> the increase in RSS was an increase in THP usage.
> >>>>>
> >>>>> Any knob is changed from RHEL7 to RHEL8 to cause more THP usage?
> >>>> IIRC, most of the systems tuning is the same. We attributed the
> >>>> increase in THP usage to a combination of improvements in the kernel,
> >>>> and improvements in the libraries (better alignments). That allowed
> >>>> THP allocations to succeed at a higher rate. I can go back and confirm
> >>>> this tomorrow though.
> >>>>>
> >>>>>>
> >>>>>> For workloads like MySQL, or when using allocators like jemalloc, it is
> >>>>>> often recommended to set /transparent_hugepages/enabled=never. This is
> >>>>>> in part due to performance degradations and increased memory waste.
> >>>>>>
> >>>>>> This series introduces enabled=defer, this setting acts as a middle
> >>>>>> ground between always and madvise. If the mapping is MADV_HUGEPAGE, the
> >>>>>> page fault handler will act normally, making a hugepage if possible. If
> >>>>>> the allocation is not MADV_HUGEPAGE, then the page fault handler will
> >>>>>> default to the base size allocation. The caveat is that khugepaged can
> >>>>>> still operate on pages thats not MADV_HUGEPAGE.
> >>>>>
> >>>>> Why? If user does not explicitly want huge page, why bother providing huge
> >>>>> pages? Wouldn't it increase memory footprint?
> >>>>
> >>>> So we have "always", which will always try to allocate a THP when it
> >>>> can. This setting gives good performance in a lot of conditions, but
> >>>> tends to waste memory. Additionally applications DON'T need to be
> >>>> modified to take advantage of THPs.
> >>>>
> >>>> We have "madvise" which will only satisfy allocations that are
> >>>> MADV_HUGEPAGE, this gives you granular control, and a lot of times
> >>>> these madvises come from libraries. Unlike "always" you DO need to
> >>>> modify your application if you want to use THPs.
> >>>>
> >>>> Then we have "never", which of course, never allocates THPs.
> >>>>
> >>>> Ok. back to your question, like "madvise", "defer" gives you the
> >>>> benefits of THPs when you specifically know you want them
> >>>> (madv_hugepage), but also benefits applications that dont specifically
> >>>> ask for them (or cant be modified to ask for them), like "always"
> >>>> does. The applications that dont ask for THPs must wait for khugepaged
> >>>> to get them (avoid insertions at PF time)-- this curbs a lot of memory
> >>>> waste, and gives an increased tunability over "always". Another added
> >>>> benefit is that khugepaged will most likely not operate on short lived
> >>>> allocations, meaning that only longstanding memory will be collapsed
> >>>> to THPs.
> >>>>
> >>>> The memory waste can be tuned with max_ptes_none... lets say you want
> >>>> ~90% of your PMD to be full before collapsing into a huge page. simply
> >>>> set max_ptes_none=64. or no waste, set max_ptes_none=0, requiring the
> >>>> 512 pages to be present before being collapsed.
> >>>>
> >>>>>
> >>>>>>
> >>>>>> This allows for two things... one, applications specifically designed to
> >>>>>> use hugepages will get them, and two, applications that don't use
> >>>>>> hugepages can still benefit from them without aggressively inserting
> >>>>>> THPs at every possible chance. This curbs the memory waste, and defers
> >>>>>> the use of hugepages to khugepaged. Khugepaged can then scan the memory
> >>>>>> for eligible collapsing.
> >>>>>
> >>>>> khugepaged would replace application memory with huge pages without specific
> >>>>> goal. Why not use a user space agent with process_madvise() to collapse
> >>>>> huge pages? Admin might have more knobs to tweak than khugepaged.
> >>>>
> >>>> The benefits of "always" are that no userspace agent is needed, and
> >>>> applications dont have to be modified to use madvise(MADV_HUGEPAGE) to
> >>>> benefit from THPs. This setting hopes to gain some of the same
> >>>> benefits without the significant waste of memory and an increased
> >>>> tunability.
> >>>>
> >>>> future changes I have in the works are to make khugepaged more
> >>>> "smart". Moving it away from the round robin fashion it currently
> >>>> operates in, to instead make smart and informed decisions of what
> >>>> memory to collapse (and potentially split).
> >>>>
> >>>> Hopefully that helped explain the motivation for this new setting!
> >>>
> >>> Any last comments before I resend this?
> >>>
> >>> Ive been made aware of
> >>> https://lore.kernel.org/all/20240730125346.1580150-1-usamaarif642@gmail.com/T/#u
> >>> which introduces THP splitting. These are both trying to achieve the
> >>> same thing through different means. Our approach leverages khugepaged
> >>> to promote pages, while Usama's uses the reclaim path to demote
> >>> hugepages and shrink the underlying memory.
> >>>
> >>> I will leave it up to reviewers to determine which is better; However,
> >>> we can't have both, as we'd be introducing trashing conditions.
> >>>
> >>
> >> Hi,
> >>
> >> Just inserting this here from my cover letter:
> >>
> >> Waiting for khugepaged to scan memory and
> >> collapse pages into THP can be slow and unpredictable in terms of performance
> > Obviously not part of my patchset here, but I have been testing some
> > changes to khugepaged to make it more aware of what processes are hot.
> > Ideally then it can make better choices of what to operate on.
> >> (i.e. you dont know when the collapse will happen), while production
> >> environments require predictable performance. If there is enough memory
> >> available, its better for both performance and predictability to have
> >> a THP from fault time, i.e. THP=always rather than wait for khugepaged
> >> to collapse it, and deal with sparsely populated THPs when the system is
> >> running out of memory.
> >>
> >> I just went through your patches, and am not sure why we can't have both?
> > Fair point, we can. I've been playing around with splitting hugepages
> > and via khugepaged and was thinking of the trashing conditions there--
> > but your implementation takes a different approach.
> > I've been working on performance testing my "defer" changes, once I
> > find the appropriate workloads I'll try adding your changes to the
> > mix. I have a feeling my approach is better for latency sensitive
> > workloads, while yours is better for throughput, but let me find a way
> > to confirm that.
> > 
> > 
> Hmm, I am not sure if its latency vs throughput.
> 
> There are 2 things we probably want to consider, short lived and long lived mappings, and
> in each of these situations, having enough memory and running out of memory.
> 
> For short lived mappings, I believe reducing page faults is a bigger factor in
> improving performance. In that case, khugepaged won't have enough time to work,
> so THP=always will perform better than THP=defer. THP=defer in this case will perform
> the same as THP=madvise?
> If there is enough memory, then the changes I introduced in the shrinker won't cost anything
> as the shrinker won't run, and the system performance will be the same as THP=always.
> If there is low memory and the shrinker runs, it will only split THPs that have zero-filled
> pages more than max_ptes_none, and map the zero-filled pages to shared zero-pages saving memory.
> There is ofcourse a cost to splitting and running the shrinker, but hopefully it only splits
> underused THPs.
> 
> For long lived mappings, reduced TLB misses would be the bigger factor in improving performance.
> For the initial run of the application THP=always will perform better wrt TLB misses as
> page fault handler will give THPs from start.
> Later on in the run, the memory might look similar between THP=always with shrinker and
> max_ptes_none < HPAGE_PMD_NR vs THP=defer and max_ptes_none < HPAGE_PMD_NR?
> This is because khugepaged will have collapsed pages that might have initially been faulted in.
> And collapsing has a cost, which would not have been incurred if the THPs were present from fault.
> If there is low memory, then shrinker would split memory (which has a cost as well) and the system
> memory would look similar or better than THP=defer, as the shrinker would split THPs that initially
> might not have been underused, but are underused at time of memory pressure.
> 
> With THP=always + underused shrinker, the cost (splitting) is incurred only if needed and when its needed.
> While with THP=defer the cost (higher page faults, higher TLB misses + khugepaged collapse) is incurred all the time,
> even if the system might have plenty of memory available and there is no need to take a performance hit.

I agree with this. The defer mode is an improvement over the upstream
status quo, no doubt. However, both defer mode and the shrinker solve
the issue of memory waste under pressure, while the shrinker permits
more desirable behavior when memory is abundant.

So my take is that the shrinker is the way to go, and I don't see a
bonafide usecase for defer mode that the shrinker couldn't cover.

