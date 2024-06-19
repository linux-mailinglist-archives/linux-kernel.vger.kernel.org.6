Return-Path: <linux-kernel+bounces-220759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 856F290E6B6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 11:18:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12A19283F60
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 09:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17C50824BB;
	Wed, 19 Jun 2024 09:17:21 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B98AA8172D
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 09:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718788640; cv=none; b=SGyYE2MEBQ3sPkM9dAISfW0BsJLvaM6lWslAzp9K4rSJ7O+n8YJXlEWdqST+BlTF3p5uiuVq91k0jKsG5Hix+KB5EkTPM3f4+aVWWRQZi/5tNM1VXnrFALMR8jHFkS9VeLpZQ/rVT6Vo5MxbT9NDCvGOSC1abxuxpjX85VQHphg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718788640; c=relaxed/simple;
	bh=R7eYwQf/V7rh6DhupXYV5jKWOqKXa9wYTQbdNnyN7AI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PivC6R853CCTxTKXqVfJ/8qbp+HIk7QBKhxHFangKAYhlbQzRyHrHRIUuXuCzsUBfoY4wfzx4HaGSDlOzwmH1v0ph5GdlerNi2o4yuVJez9WaFOedV5OP7E/UEbsfGNZwiaMQewyqvyIpvDHqrOGmtMITz/dZV0M6Je56xlzzQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 049C8DA7;
	Wed, 19 Jun 2024 02:17:37 -0700 (PDT)
Received: from [10.1.36.163] (XHFQ2J9959.cambridge.arm.com [10.1.36.163])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 88B963F64C;
	Wed, 19 Jun 2024 02:17:10 -0700 (PDT)
Message-ID: <f9f105d9-77ba-427c-9958-92710f70716b@arm.com>
Date: Wed, 19 Jun 2024 10:17:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 0/5] Alternative mTHP swap allocator improvements
To: "Huang, Ying" <ying.huang@intel.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>,
 Kalesh Singh <kaleshsingh@google.com>, Barry Song <baohua@kernel.org>,
 Hugh Dickins <hughd@google.com>, David Hildenbrand <david@redhat.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20240618232648.4090299-1-ryan.roberts@arm.com>
 <87tthp4cx9.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Language: en-GB
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <87tthp4cx9.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/06/2024 08:19, Huang, Ying wrote:
> Hi, Ryan,
> 
> Ryan Roberts <ryan.roberts@arm.com> writes:
> 
>> Hi All,
>>
>> Chris has been doing great work at [1] to clean up my mess in the mTHP swap
>> entry allocator.
> 
> I don't think the original behavior is something like mess.  It's just
> the first step in the correct direction.  It's straightforward and
> obviously correctly.  Then, we can optimize it step by step with data to
> justify the increased complexity.

OK, perhaps I was over-egging it by calling it a "mess". What you're describing
was my initial opinion too, but I saw Andrew complaining that we shouldn't be
merging a feature if it doesn't work. This series fixes the problem in a minimal
way - if you ignore the last patch, which is really is just a performance
optimization and could be dropped.

If we can ultimately get Chris's series to 0% fallback like this one, and
everyone is happy with the current state for v6.10, then agreed - let's
concentrate on Chris's series for v6.11.

Thanks,
Ryan

> 
>> But Barry posted a test program and results at [2] showing that
>> even with Chris's changes, there are still some fallbacks (around 5% - 25% in
>> some cases). I was interested in why that might be and ended up putting this PoC
>> patch set together to try to get a better understanding. This series ends up
>> achieving 0% fallback, even with small folios ("-s") enabled. I haven't done
>> much testing beyond that (yet) but thought it was worth posting on the strength
>> of that result alone.
>>
>> At a high level this works in a similar way to Chris's series; it marks a
>> cluster as being for a particular order and if a new cluster cannot be allocated
>> then it scans through the existing non-full clusters. But it does it by scanning
>> through the clusters rather than assembling them into a list. Cluster flags are
>> used to mark clusters that have been scanned and are known not to have enough
>> contiguous space, so the efficiency should be similar in practice.
>>
>> Because its not based around a linked list, there is less churn and I'm
>> wondering if this is perhaps easier to review and potentially even get into
>> v6.10-rcX to fix up what's already there, rather than having to wait until v6.11
>> for Chris's series? I know Chris has a larger roadmap of improvements, so at
>> best I see this as a tactical fix that will ultimately be superseeded by Chris's
>> work.
> 
> I don't think we need any mTHP swap entry allocation optimization to go
> into v6.10-rcX.  There's no functionality or performance regression.
> Per my understanding, we merge optimization when it's ready.
> 
> Hi, Andrew,
> 
> Please correct me if you don't agree.
> 
> [snip]
> 
> --
> Best Regards,
> Huang, Ying


