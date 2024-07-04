Return-Path: <linux-kernel+bounces-240381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D47926D17
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 03:25:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 388C91C216BE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 01:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4C0CDF59;
	Thu,  4 Jul 2024 01:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DUbT8hka"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1700C2581
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 01:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720056348; cv=none; b=jwzZoH64M0C+buDA4Nl2gcIQ17bz/3qS9oKzzSbgeKdgE066yR4F7wFzGjL85ahCNaiMHoRQNzYOa+edRs91LJAz7Q2AD/z09BMafNISpcs9mkw8ZbKQtqQuk8CN82+pqVnDnFDjKj21mnyw8X9Oli6MIm7fdFZKXtgC15DBv8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720056348; c=relaxed/simple;
	bh=KmHwntjfoh548MYxF2gaKvlgIfLxehlCWOkxGkzuKZ4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qRoPN3qgWZkUFB6WN3ifOo1rPdl+X3ghIibhRf+aTCpewkAzfqVwix5h5sO3/eWO2a5S91SJo3NAltCv6CYpd0vLDfTlNXP8/b8UKN7727UfUZSgRzUcAAhNokYGjroy73KJHPZW/wgQvHKgCUw8aJlF9CW5MMjQS5ljyFglYCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DUbT8hka; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720056345; x=1751592345;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=KmHwntjfoh548MYxF2gaKvlgIfLxehlCWOkxGkzuKZ4=;
  b=DUbT8hkacFuJS3sox6B7+C0nva/bMPBtcgqvxj0F3t8LPZd/SHgi5IdQ
   G8WADwhbb5rLejgDI4xyP7GUK+ce6qmx7AJGTfQlDBoWcXwBA6CzZLir+
   JuH6vo2kas9fuHfSgYron0oW0KB7Lspp+Vw55pw2SPAH8WYMemyohyTdZ
   WOeVvhZlzKRwLuCPsEHCmUv2jU5wdR5s9mEpeWuzgAc7CaUA/BpOV/Wjg
   4FMA6NvfvuVSKeRRSnE7xTW7Uic+PG5kQF75BlDiW/VVuULC9yqXBfggV
   U2foxNduf/kReNXMvBQZI+v2jpJ5gHkKAavR5GVavwSRwPenWXP9O1PQc
   g==;
X-CSE-ConnectionGUID: LMndM1nJRc6xr1mo2xQfkg==
X-CSE-MsgGUID: Qo49wTrhQJWwdsrBBa7Fjw==
X-IronPort-AV: E=McAfee;i="6700,10204,11122"; a="17427686"
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="17427686"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 18:25:44 -0700
X-CSE-ConnectionGUID: rs6IqsqkSwOyj5hZtI3gZg==
X-CSE-MsgGUID: u9RiaY7yRsaozAseJu0eig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="46863250"
Received: from unknown (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 18:25:41 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: Tvrtko Ursulin <tursulin@igalia.com>,  linux-mm@kvack.org,
  linux-kernel@vger.kernel.org,  kernel-dev@igalia.com,  Mel Gorman
 <mgorman@suse.de>,  Peter Zijlstra <peterz@infradead.org>,  Ingo Molnar
 <mingo@redhat.com>,  Rik van Riel <riel@surriel.com>,  Johannes Weiner
 <hannes@cmpxchg.org>,  "Matthew Wilcox (Oracle)" <willy@infradead.org>,
  Dave Hansen <dave.hansen@intel.com>,  Andi Kleen <ak@linux.intel.com>,
  Michal Hocko <mhocko@suse.com>,  David Rientjes <rientjes@google.com>
Subject: Re: [PATCH v2] mm/numa_balancing: Teach mpol_to_str about the
 balancing mode
In-Reply-To: <a95b70c0-b386-4189-a06a-008d58a8c2ae@igalia.com> (Tvrtko
	Ursulin's message of "Wed, 3 Jul 2024 09:34:01 +0100")
References: <20240702150006.35206-1-tursulin@igalia.com>
	<87o77fkprp.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<2fe66068-4419-4bfc-a92b-2ece3cfcb2ad@igalia.com>
	<87ed8akivq.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<a95b70c0-b386-4189-a06a-008d58a8c2ae@igalia.com>
Date: Thu, 04 Jul 2024 09:23:49 +0800
Message-ID: <874j96j6fu.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Tvrtko Ursulin <tvrtko.ursulin@igalia.com> writes:

> On 03/07/2024 08:57, Huang, Ying wrote:
>> Tvrtko Ursulin <tvrtko.ursulin@igalia.com> writes:
>> 
>>> On 03/07/2024 06:28, Huang, Ying wrote:
>>>> Tvrtko Ursulin <tursulin@igalia.com> writes:
>>>>
>>>>> From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>>>>>
>>>>> Since balancing mode was added in
>>>>> bda420b98505 ("numa balancing: migrate on fault among multiple bound nodes"),
>>>>> it was possible to set this mode but it wouldn't be shown in
>>>>> /proc/<pid>/numa_maps since there was no support for it in the
>>>>> mpol_to_str() helper.
>>>>>
>>>>> Furthermore, because the balancing mode sets the MPOL_F_MORON flag, it
>>>>> would be displayed as 'default' due a workaround introduced a few years
>>>>> earlier in
>>>>> 8790c71a18e5 ("mm/mempolicy.c: fix mempolicy printing in numa_maps").
>>>>>
>>>>> To tidy this up we implement two changes:
>>>>>
>>>>> First we introduce a new internal flag MPOL_F_KERNEL and with it mark the
>>>>> kernel's internal default and fallback policies (for tasks and/or VMAs
>>>>> with no explicit policy set). By doing this we generalise the current
>>>>> special casing and replace the incorrect 'default' with the correct
>>>>> 'bind'.
>>>>>
>>>>> Secondly, we add a string representation and corresponding handling for
>>>>> MPOL_F_NUMA_BALANCING. We do this by adding a sparse mapping array of
>>>>> flags to names. With the sparseness being the downside, but with the
>>>>> advantage of generalising and removing the "policy" from flags display.
>>>> Please split these 2 changes into 2 patches.  Because we will need
>>>> to
>>>> back port the first one to -stable kernel.
>>>
>>> Why two? AFAICT there wasn't a issue until bda420b98505, and to fix it
>>> all changes from this patch are needed.
>> After bda420b98505, MPOL_BIND with MPOL_F_NUMA_BALANCING will be
>> shown
>> as "default", which is a bug.  While it's a new feature to show
>> "balancing".  The first fix should be back-ported to -stable kernel
>> after bda420b98505.  While we don't need to do that for the second one.
>
> You lost me but it could be I am not at my best today so if you could
> please explain more precisely what you mean?
>
> When bda420b98505 got in, it added MPOL_F_NUMA_BALANCING. But there
> was no "balancing" in mpol_to_str(). That's one fix for bda420b98505.

IMO, it's not a big issue to miss "balancing" in mpol_to_str().  It's
not absolutely necessary to backport this part.

> But also it did not change the pre-existing check for MPOL_F_MORON
> added in 8790c71a18e5, many years before it, which was the thing
> causing bind+balancing to be printed as default. So that's the second
> part of the fix. But also AFAICS to tag as fixes bda420b98505.
>
> Making 8790c71a18e5 target of Fixes: does not IMO make sense though
> because *at the time* of that patch it wasn't broken. What am I
> missing?

Yes, we should use "Fixes: bda420b98505 ..." for this part.  This is a
big issue, because "default" will be shown for MPOL_BIND, which is
totally wrong.  We need to backport this fix.  It's good for backporting
to keep it small and focused.

>>>>> End result:
>>>>>
>>>>> $ numactl -b -m 0-1,3 cat /proc/self/numa_maps
>>>>> 555559580000 bind=balancing:0-1,3 file=/usr/bin/cat mapped=3 active=0 N0=3 kernelpagesize_kB=16
>>>>> ...
>>>>>
>>>>> v2:
>>>>>    * Fully fix by introducing MPOL_F_KERNEL.
>>>>>
>>>>> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>>>>> Fixes: bda420b98505 ("numa balancing: migrate on fault among multiple bound nodes")
>>>>> References: 8790c71a18e5 ("mm/mempolicy.c: fix mempolicy printing in numa_maps")
>>>>> Cc: Huang Ying <ying.huang@intel.com>
>>>>> Cc: Mel Gorman <mgorman@suse.de>
>>>>> Cc: Peter Zijlstra <peterz@infradead.org>
>>>>> Cc: Ingo Molnar <mingo@redhat.com>
>>>>> Cc: Rik van Riel <riel@surriel.com>
>>>>> Cc: Johannes Weiner <hannes@cmpxchg.org>
>>>>> Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
>>>>> Cc: Dave Hansen <dave.hansen@intel.com>
>>>>> Cc: Andi Kleen <ak@linux.intel.com>
>>>>> Cc: Michal Hocko <mhocko@suse.com>
>>>>> Cc: David Rientjes <rientjes@google.com>
>>>>> ---
>>>>>    include/uapi/linux/mempolicy.h |  1 +
>>>>>    mm/mempolicy.c                 | 44 ++++++++++++++++++++++++----------
>>>>>    2 files changed, 32 insertions(+), 13 deletions(-)
>>>>>
>>>>> diff --git a/include/uapi/linux/mempolicy.h b/include/uapi/linux/mempolicy.h
>>>>> index 1f9bb10d1a47..bcf56ce9603b 100644
>>>>> --- a/include/uapi/linux/mempolicy.h
>>>>> +++ b/include/uapi/linux/mempolicy.h
>>>>> @@ -64,6 +64,7 @@ enum {
>>>>>    #define MPOL_F_SHARED  (1 << 0)	/* identify shared policies */
>>>>>    #define MPOL_F_MOF	(1 << 3) /* this policy wants migrate on fault */
>>>>>    #define MPOL_F_MORON	(1 << 4) /* Migrate On protnone Reference On Node */
>>>>> +#define MPOL_F_KERNEL   (1 << 5) /* Kernel's internal policy */
>>>>>      /*
>>>>>     * These bit locations are exposed in the vm.zone_reclaim_mode sysctl
>>>>> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
>>>>> index aec756ae5637..8ecc6d9f100a 100644
>>>>> --- a/mm/mempolicy.c
>>>>> +++ b/mm/mempolicy.c
>>>>> @@ -134,6 +134,7 @@ enum zone_type policy_zone = 0;
>>>>>    static struct mempolicy default_policy = {
>>>>>    	.refcnt = ATOMIC_INIT(1), /* never free it */
>>>>>    	.mode = MPOL_LOCAL,
>>>>> +	.flags = MPOL_F_KERNEL,
>>>>>    };
>>>>>      static struct mempolicy preferred_node_policy[MAX_NUMNODES];
>>>>> @@ -3095,7 +3096,7 @@ void __init numa_policy_init(void)
>>>>>    		preferred_node_policy[nid] = (struct mempolicy) {
>>>>>    			.refcnt = ATOMIC_INIT(1),
>>>>>    			.mode = MPOL_PREFERRED,
>>>>> -			.flags = MPOL_F_MOF | MPOL_F_MORON,
>>>>> +			.flags = MPOL_F_MOF | MPOL_F_MORON | MPOL_F_KERNEL,
>>>>>    			.nodes = nodemask_of_node(nid),
>>>>>    		};
>>>>>    	}
>>>>> @@ -3150,6 +3151,12 @@ static const char * const policy_modes[] =
>>>>>    	[MPOL_PREFERRED_MANY]  = "prefer (many)",
>>>>>    };
>>>>>    +static const char * const policy_flags[] = {
>>>>> +	[ilog2(MPOL_F_STATIC_NODES)] = "static",
>>>>> +	[ilog2(MPOL_F_RELATIVE_NODES)] = "relative",
>>>>> +	[ilog2(MPOL_F_NUMA_BALANCING)] = "balancing",
>>>>> +};
>>>>> +
>>>>>    #ifdef CONFIG_TMPFS
>>>>>    /**
>>>>>     * mpol_parse_str - parse string to mempolicy, for tmpfs mpol mount option.
>>>>> @@ -3293,17 +3300,18 @@ int mpol_parse_str(char *str, struct mempolicy **mpol)
>>>>>     * @pol:  pointer to mempolicy to be formatted
>>>>>     *
>>>>>     * Convert @pol into a string.  If @buffer is too short, truncate the string.
>>>>> - * Recommend a @maxlen of at least 32 for the longest mode, "interleave", the
>>>>> - * longest flag, "relative", and to display at least a few node ids.
>>>>> + * Recommend a @maxlen of at least 42 for the longest mode, "weighted
>>>>> + * interleave", the longest flag, "balancing", and to display at least a few
>>>>> + * node ids.
>>>>>     */
>>>>>    void mpol_to_str(char *buffer, int maxlen, struct mempolicy *pol)
>>>>>    {
>>>>>    	char *p = buffer;
>>>>>    	nodemask_t nodes = NODE_MASK_NONE;
>>>>>    	unsigned short mode = MPOL_DEFAULT;
>>>>> -	unsigned short flags = 0;
>>>>> +	unsigned long flags = 0;
>>>>>    -	if (pol && pol != &default_policy && !(pol->flags &
>>>>> MPOL_F_MORON)) {
>>>>> +	if (!(pol->flags & MPOL_F_KERNEL)) {
>>>> Can we avoid to introduce a new flag?  Whether the following code
>>>> work?
>>>>           if (pol && pol != &default_policy && !(pol->mode !=
>>>>               MPOL_PREFERRED) && !(pol->flags & MPOL_F_MORON))
>>>> But I think that this is kind of fragile.  A flag is better.  But
>>>> personally, I don't think MPOL_F_KERNEL is a good name, maybe
>>>> MPOL_F_DEFAULT?
>>>
>>> I thought along the same lines, but as you have also shown we need to
>>> exclude both default and preferred fallbacks so naming the flag
>>> default did not feel best. MPOL_F_INTERNAL? MPOL_F_FALLBACK?
>>> MPOL_F_SHOW_AS_DEFAULT? :))
>>>
>>> What I dislike about the flag more is the fact internal flags are for
>>> some reason in the uapi headers. And presumably we cannot zap them.
>>>
>>> But I don't think we can check for MPOL_PREFERRED since it can be a
>>> legitimate user set policy.
>> It's not legitimate (yet) to use MPOL_PREFERRED +
>> MPOL_F_NUMA_BALANCING.
>> 
>>>
>>> We could check for the address of preferred_node_policy[] members with
>>> a loop covering all possible nids? If that will be the consensus I am
>>> happy to change it. But flag feels more elegant and robust.
>> Yes.  I think that this is doable.
>>          (unsigned long)addr >= (unsigned
>> long)(preferred_node_policy) && \
>>                  (unsigned long)addr < (unsigned long)(preferred_node_policy) + \
>>                  sizeof(preferred_node_policy)
>
> Not the prettiest but at least in the spirit of the existing
> &default_policy check. I can do that, no problem. If someone has a
> different opinion please shout soon.
>
>>>>>    		mode = pol->mode;
>>>>>    		flags = pol->flags;
>>>>>    	}
>>>>> @@ -3328,15 +3336,25 @@ void mpol_to_str(char *buffer, int maxlen, struct mempolicy *pol)
>>>>>    	p += snprintf(p, maxlen, "%s", policy_modes[mode]);
>>>>>      	if (flags & MPOL_MODE_FLAGS) {
>>>>> -		p += snprintf(p, buffer + maxlen - p, "=");
>>>>> +		unsigned int bit, cnt = 0;
>>>>>    -		/*
>>>>> -		 * Currently, the only defined flags are mutually exclusive
>>>>> -		 */
>>>>> -		if (flags & MPOL_F_STATIC_NODES)
>>>>> -			p += snprintf(p, buffer + maxlen - p, "static");
>>>>> -		else if (flags & MPOL_F_RELATIVE_NODES)
>>>>> -			p += snprintf(p, buffer + maxlen - p, "relative");
>>>>> +		for_each_set_bit(bit, &flags, ARRAY_SIZE(policy_flags)) {
>>>>> +			if (bit <= ilog2(MPOL_F_KERNEL))
>>>>> +				continue;
>>>>> +
>>>>> +			if (cnt == 0)
>>>>> +				p += snprintf(p, buffer + maxlen - p, "=");
>>>>> +			else
>>>>> +				p += snprintf(p, buffer + maxlen - p, ",");
>>>>> +
>>>>> +			if (WARN_ON_ONCE(!policy_flags[bit]))
>>>>> +				p += snprintf(p, buffer + maxlen - p, "bit%u",
>>>>> +					      bit);
>>>>> +			else
>>>>> +				p += snprintf(p, buffer + maxlen - p,
>>>>> +					      policy_flags[bit]);
>>>>> +			cnt++;
>>>>> +		}
>>>> Please refer to commit 2291990ab36b ("mempolicy: clean-up
>>>> mpol-to-str()
>>>> mempolicy formatting") for the original format.
>>>
>>> That was in 2008 so long time ago and in the meantime there were no
>>> bars. The format in this patch tries to align with the input format
>>> and I think it manages, apart from deciding to print unknown flags as
>>> bit numbers (which is most probably an irrelevant difference). Why do
>>> you think the pre-2008 format is better?
>> If you think that your format is better, please explain why you not
>> use
>> the original format in the patch description.  You can also show
>> examples to compare.
>
> Because there is no "old" format? If you refer to the one which ended
> in 2008. Or if you refer to the one this patch replaces, then it is
> effectively the same format for a single flag. And for multiple flags
> before this patch that wasn't a possibility. So I am not sure what I
> would include as a comparison. Broken "default" vs
> "bind=balancing:0-1"? Am I missing something?

In the old format (not in the old code), it is,

bind=relative|balancing:0-1

while in your format,

bind=relative,balancing:0-1

Please explain why you make the change.

[snip]

--
Best Regards,
Huang, Ying

