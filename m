Return-Path: <linux-kernel+bounces-267052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF540940BC7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 10:37:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E16591C23B68
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 08:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99F941922E5;
	Tue, 30 Jul 2024 08:36:47 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 897A2193078
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 08:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722328607; cv=none; b=rjcqnd9zMH9NBA207t8hlhIrHf1twcohcXxW5g4RFnIWSGUT726h/g4qSAWLgwMhTGymiyufKgcJS3H75UqlRF4RKtoBjkew0wCC/Pvu5+O8LBnjylHsDgegnRUQnWeAMJXgpwUObvdQ792FfoaPdyn+FesfNW9CG2H4djuGvXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722328607; c=relaxed/simple;
	bh=wFR5OkArG5cogDqZr9dJ/pJdxh5F4WNEWQOZLjQbOug=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E7XScxaFJHcKbJKO34bfrfYBYG6YgyK2s68jHwdIHTd5i7t85Eun+LqeU1Bi057M1sd12eTMvj1hthhj5v1uyvx3UyWSWNZVRAiCa2i1VnmwJjkdyuKHqKbiuLzmqn2FDTLc57taI7+f5aEhB4UqRx3e5qSCLIuCiJos8nmdroY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2D4481007;
	Tue, 30 Jul 2024 01:37:10 -0700 (PDT)
Received: from [10.57.78.186] (unknown [10.57.78.186])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1F5BD3F766;
	Tue, 30 Jul 2024 01:36:40 -0700 (PDT)
Message-ID: <f0c7f061-6284-4fe5-8cbf-93281070895b@arm.com>
Date: Tue, 30 Jul 2024 09:36:39 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/4] mm: Introduce per-thpsize swapin control policy
Content-Language: en-GB
To: Matthew Wilcox <willy@infradead.org>, Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, ying.huang@intel.com,
 baolin.wang@linux.alibaba.com, chrisl@kernel.org, david@redhat.com,
 hannes@cmpxchg.org, hughd@google.com, kaleshsingh@google.com,
 kasong@tencent.com, linux-kernel@vger.kernel.org, mhocko@suse.com,
 minchan@kernel.org, nphamcs@gmail.com, senozhatsky@chromium.org,
 shakeel.butt@linux.dev, shy828301@gmail.com, surenb@google.com,
 v-songbaohua@oppo.com, xiang@kernel.org, yosryahmed@google.com
References: <20240726094618.401593-1-21cnbao@gmail.com>
 <20240726094618.401593-5-21cnbao@gmail.com>
 <ZqcR_oZmVpi2TrHO@casper.infradead.org>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <ZqcR_oZmVpi2TrHO@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29/07/2024 04:52, Matthew Wilcox wrote:
> On Fri, Jul 26, 2024 at 09:46:18PM +1200, Barry Song wrote:
>> A user space interface can be implemented to select different swap-in
>> order policies, similar to the mTHP allocation order policy. We need
>> a distinct policy because the performance characteristics of memory
>> allocation differ significantly from those of swap-in. For example,
>> SSD read speeds can be much slower than memory allocation. With
>> policy selection, I believe we can implement mTHP swap-in for
>> non-SWAP_SYNCHRONOUS scenarios as well. However, users need to understand
>> the implications of their choices. I think that it's better to start
>> with at least always never. I believe that we will add auto in the
>> future to tune automatically, which can be used as default finally.
> 
> I strongly disagree.  Use the same sysctl as the other anonymous memory
> allocations.

I vaguely recall arguing in the past that just because the user has requested 2M
THP that doesn't mean its the right thing to do for performance to swap-in the
whole 2M in one go. That's potentially a pretty huge latency, depending on where
the backend is, and it could be a waste of IO if the application never touches
most of the 2M. Although the fact that the application hinted for a 2M THP in
the first place hopefully means that they are storing objects that need to be
accessed at similar times. Today it will be swapped in page-by-page then
eventually collapsed by khugepaged.

But I think those arguments become weaker as the THP size gets smaller. 16K/64K
swap-in will likely yield significant performance improvements, and I think
Barry has numbers for this?

So I guess we have a few options:

 - Just use the same sysfs interface as for anon allocation, And see if anyone
reports performance regressions. Investigate one of the options below if an
issue is raised. That's the simplest and cleanest approach, I think.

 - New sysfs interface as Barry has implemented; nobody really wants more
controls if it can be helped.

 - Hardcode a size limit (e.g. 64K); I've tried this in a few different contexts
and never got any traction.

 - Secret option 4: Can we allocate a full-size folio but only choose to swap-in
to it bit-by-bit? You would need a way to mark which pages of the folio are
valid (e.g. per-page flag) but guess that's a non-starter given the strategy to
remove per-page flags?

Thanks,
Ryan


