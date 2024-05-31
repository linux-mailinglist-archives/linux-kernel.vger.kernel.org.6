Return-Path: <linux-kernel+bounces-196178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E9E18D587F
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 04:05:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5567A283B33
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 02:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 177C274E3D;
	Fri, 31 May 2024 02:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y9qNrTdK"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487506BFCA
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 02:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717121138; cv=none; b=t83r1EwbepXgDJm6xb/i3UpleopKUMc5FLZz3gbYXZXP7oWwnMnjoxhnOmY1ARs4mylIszPjAzoi3OhR3LUQSh0tTZaky3CpLj8WnsCcNTcmtFA8+CCUlBYs4QNYkB80Eh2C3a5a7+cVkdc2HYzW91EK5PPMNpGNewNK++j6vzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717121138; c=relaxed/simple;
	bh=Oi19lPR1rM1bSW2hafHJqcwmeahdBfGSLTlvj54GMeQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bcjUBcFQ6BoZHVX7M+xpgCq6BwZbQz2lIQSD58DBSJlqRv9cohhQhi94ivbpThNMZcjhqJgrI6H+kO/oWha0uOjnBHi4oMCQ2qOvNdfvK8la8Ii/WCUSLCVpo6oMQMsFcTlZ88W6B2Fgds4CzSY4Pw7AtM1iTgnURyW4+W961QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y9qNrTdK; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717121136; x=1748657136;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=Oi19lPR1rM1bSW2hafHJqcwmeahdBfGSLTlvj54GMeQ=;
  b=Y9qNrTdKEkqAyyHEcchE73Qh/JpMCB3536RDB5okAhKzS4Bd4tmOSUXm
   39B1apY2WRzUgRMLzoPIRsTQDWcZoSNoN3rrWRuQI3qQP7ywVoGHAiOQj
   IB6ifL9Taa7U5+rB8MFhGIEF1xMwWYdAhRMDCo0p8hO6gVe3YZCYzapT2
   kvKILWv/vAJ4mukOxFSg/zhHdMuV0n7Bf6ufixg2ndwyRQYGFamjDisVS
   O4FJylBMXkauN0tfZHKuw1eK52QI5gGxmLdb2RXbNxAGCrU1n23BeGlqL
   JGwBv4fKWmMYhHbrwGpDQXuo3/8Q6Is/oNcpzPCgho+UorBNvzNPYSt48
   Q==;
X-CSE-ConnectionGUID: Lg+Ln1ygTf2AK/pmUonKiQ==
X-CSE-MsgGUID: zgS4dZRTTlmPwhPqS8o8Eg==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="13847006"
X-IronPort-AV: E=Sophos;i="6.08,202,1712646000"; 
   d="scan'208";a="13847006"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 19:05:35 -0700
X-CSE-ConnectionGUID: iwLVEAa2S7mWd/QB/SX5JQ==
X-CSE-MsgGUID: AkRNlyHoQrGcJFi+UE6ttQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,202,1712646000"; 
   d="scan'208";a="35948040"
Received: from unknown (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 19:05:34 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Chris Li <chrisl@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,  Kairui Song
 <kasong@tencent.com>,  Ryan Roberts <ryan.roberts@arm.com>,
  linux-kernel@vger.kernel.org,  linux-mm@kvack.org,  Barry Song
 <baohua@kernel.org>
Subject: Re: [PATCH 1/2] mm: swap: swap cluster switch to double link list
In-Reply-To: <CAF8kJuPYvUP+JZQo6dS-iTf0EePb8FWh67Ac8ARUZ87YZwhoZQ@mail.gmail.com>
	(Chris Li's message of "Thu, 30 May 2024 14:49:00 -0700")
References: <20240524-swap-allocator-v1-0-47861b423b26@kernel.org>
	<20240524-swap-allocator-v1-1-47861b423b26@kernel.org>
	<87h6eh57kg.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<CAF8kJuPYvUP+JZQo6dS-iTf0EePb8FWh67Ac8ARUZ87YZwhoZQ@mail.gmail.com>
Date: Fri, 31 May 2024 10:03:42 +0800
Message-ID: <87sexyzqip.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Chris Li <chrisl@kernel.org> writes:

> On Wed, May 29, 2024 at 1:48=E2=80=AFAM Huang, Ying <ying.huang@intel.com=
> wrote:
>>
>> Chris Li <chrisl@kernel.org> writes:
>>
>> > Previously, the swap cluster used a cluster index as a pointer
>> > to construct a custom single link list type "swap_cluster_list".
>> > The next cluster pointer is shared with the cluster->count.
>> > The assumption is that only the free cluster needs to be put
>> > on the list.
>> >
>> > That assumption is not true for mTHP allocators any more.
>>
>> I think that the words aren't correct here.  mTHP swap entry allocators
>> can work with current cluster definition.
>
> The current behavior is very problematic though:
>
> If we only allocate and free order 4 swap entries, nothing else. After
> a while, the free cluster will be used up, the swap entry allocation
> will fail even though there is a lot of swap space left.

The original behavior doesn't work well for order-0 allocation too.
percpu_cluster and quick (cluster) scan path cannot be used for
fragmented swap devices.

>> > Need to track the non full cluster on the list as well.  Move the
>> > current cluster single link list into standard double link list.
>>
>> It's an optimization to track non-full cluster with a list.
>>
>> I understand that you want to change cluster list definition.  I just
>
> In my mind, I was changing the list implementation so it can be
> tracked non free cluster as well.
>
>> feel the wording isn't accurate.
>
> Help me improve it. I am happy to adjust the wording in V2, you can
> provide more feedback then.

I suggest you to focus on improvement.  The original implementation
hasn't the assumption that it's the best or perfect.  It improves from
its base and you can continue to improve it for more situations.
Describe the situation where current implementation doesn't performance
well and how do you improve it.  Better with the cost.

>>
>> > Remove the cluster getter/setter for accessing the cluster
>> > struct member.  Move the cluster locking in the caller function
>> > rather than the getter/setter function. That way the locking can
>> > protect more than one member, e.g. cluster->flag.
>>
>> Sorry, I don't understand the locking in above words.  I don't find that
>> we lock/unlock in the original getter/setter functions.  I found that
>> the cluster locking rule for cluster list is changed.  Better to make
>> this explicit.
>
> The original cluster single link list add/remove will require si->lock
> protection as well, because the list head and tail pointer are outside
> of the cluster pointer.
> In this regard, the cluster double link list locking rule is very
> similar. Yes, I move the list_del() outside of the cluster lock, is
> that what you are referring to as the locking change?

In the original implementation, ci->lock is held when changing ci->data
(in fact next here).  Now, you don't need the ci->lock.  This is a
locking rule change, I suggest you to make it explicit in change log and
comments.

>> > Change cluster code to use "struct swap_cluster_info *" to
>> > reference the cluster rather than by using index. That is more
>> > consistent with the list manipulation. It avoids the repeat
>> > adding index to the cluser_info. The code is easier to understand.
>> >
>> > Remove the cluster next pointer is NULL flag, the double link
>> > list can handle the empty list pretty well.
>> >
>> > The "swap_cluster_info" struct is two pointer bigger, because
>> > 512 swap entries share one swap struct, it has very little impact
>> > on the average memory usage per swap entry.  Other than the list
>> > conversion, there is no real function change in this patch.
>>
>> On 64bit platform, the size of swap_cluster_info increases from 8 bytes
>> to 24 bytes.  For a 1TB swap device, the memory usage will increase from
>> 4MB to 12MB.  This looks OK for me.
>
> Will add the size change calculation in V2 and have you review it again.
>
>>
>> Another choice is to use a customized double linked list using "unsigned
>> int" as pointer to cluster.  That will reduce the size of cluster to 16
>> bytes.  But it may be not necessary to do that.
>
> We can always do that as a follow up step to optimize the 24 byte to
> 16 byte, at the price of more code complicity.
> The trick part is the link list head, it is not part of the cluster
> array, it does not have an index, and will need a special handle for
> that.

In theory, you can define a "struct list_u32_head" and a set of
list_u32_* functions.  But I don't find that it's necessary to do that.

>>
>> Anyway, I think that it's better to add more calculation in changelog
>> for memory usage increment.
>
> Sure, I will adjust the commit message in V2.
>
> Chris
>
>>
>> > ---
>> >  include/linux/swap.h |  14 ++--
>> >  mm/swapfile.c        | 231 ++++++++++++++----------------------------=
---------
>> >  2 files changed, 68 insertions(+), 177 deletions(-)
>> >
>> > diff --git a/include/linux/swap.h b/include/linux/swap.h
>> > index 11c53692f65f..0d3906eff3c9 100644
>> > --- a/include/linux/swap.h
>> > +++ b/include/linux/swap.h
>> > @@ -254,11 +254,12 @@ struct swap_cluster_info {
>> >                                * elements correspond to the swap
>> >                                * cluster
>> >                                */
>> > -     unsigned int data:24;
>> > +     unsigned int count:16;
>> >       unsigned int flags:8;
>>
>> If we use 16bits and 8 bits in bit fields, why not just use u8 and u16
>> instead?
> Not sure about the

?

        u16 count;
        u8 flags;

>>
>> > +     struct list_head next;
>>
>> "next" isn't a good naming because prev pointer is in list_head too.
>> The common naming is "list".
>
> Sure, I can change it to "list".
>
>>
>> Need to revise comments for swap_cluster_info.lock and add the locking
>> rule comments for swap_cluster_info.next.
>
> Will do.
>
>>
>> >  };
>> >  #define CLUSTER_FLAG_FREE 1 /* This cluster is free */
>> > -#define CLUSTER_FLAG_NEXT_NULL 2 /* This cluster has no next cluster =
*/
>> > +
>> >

[snip]

--
Best Regards,
Huang, Ying

