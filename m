Return-Path: <linux-kernel+bounces-539323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 623FDA4A337
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 20:57:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DA2D189D285
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 19:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D6AA230BFB;
	Fri, 28 Feb 2025 19:56:23 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7209C230BDC
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 19:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740772583; cv=none; b=NkOwgTbOefgAQviCCIKafnxIuGVxIeAmarn3lKqSa3oMLcqBB7jFrVGaufLkR4iA2eRI2dAqBcuVoqMAhOto1HP5n1P5jpx6JCkPCykYO4N2Ai/eGlDu+EosYapAiEA1Wkv5CGV9+0XE7jC0AzmSWhVmbIEQ1w2ORy6zY72+GtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740772583; c=relaxed/simple;
	bh=OikHt1HScGRX/qBgvDQ8rnXizxDRfX7NLYBL0aF3vW8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DiS62FNd4hcOYLUPcCZFbvdwzh8xsaS98KMVGbWJev2pfaWqc7IlXErnA8nnu3y/xxy1TSYi+OfkCya97D8seNQ6vg098CZ5+/m57L2g8FVvi8CemPPUVsfb9nMNfC5yUulynNpq48CGQ9I1w/MP46aDQegVq176MLGKc9eCqRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C7FB21515;
	Fri, 28 Feb 2025 11:56:35 -0800 (PST)
Received: from [10.1.197.49] (eglon.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 497573F5A1;
	Fri, 28 Feb 2025 11:56:10 -0800 (PST)
Message-ID: <0206076d-9ffa-4a7f-871e-94c4a8d517b5@arm.com>
Date: Fri, 28 Feb 2025 19:56:10 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 12/42] x86/resctrl: Move rdt_find_domain() to be
 visible to arch and fs code
To: Reinette Chatre <reinette.chatre@intel.com>,
 Catalin Marinas <catalin.marinas@arm.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>,
 Babu Moger <Babu.Moger@amd.com>, shameerali.kolothum.thodi@huawei.com,
 D Scott Phillips OS <scott@os.amperecomputing.com>,
 carl@os.amperecomputing.com, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, amitsinght@marvell.com,
 David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>,
 Dave Martin <dave.martin@arm.com>, Koba Ko <kobak@nvidia.com>,
 Shanker Donthineni <sdonthineni@nvidia.com>
References: <20250207181823.6378-1-james.morse@arm.com>
 <20250207181823.6378-13-james.morse@arm.com>
 <acdfa4ee-e293-49f3-8e53-900b9db63ddb@intel.com> <Z7cK1FpQCgBVSGHq@arm.com>
 <0672ad74-782e-48b9-8591-7e0bdec84845@intel.com>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <0672ad74-782e-48b9-8591-7e0bdec84845@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Reinette,

On 20/02/2025 16:01, Reinette Chatre wrote:
> On 2/20/25 2:58 AM, Catalin Marinas wrote:
>> On Wed, Feb 19, 2025 at 03:24:06PM -0800, Reinette Chatre wrote:
>>> On 2/7/25 10:17 AM, James Morse wrote:
>>>> rdt_find_domain() finds a domain given a resource and a cache-id.
>>>> This is used by both the architecture code and the filesystem code.
>>>>
>>>> After the filesystem code moves to live in /fs/, this helper will no
>>>> longer be visible.
>>>>
>>>> Move it to the global header file. As its now globally visible, and
>>>> has only a handful of callers, swap the 'rdt' for 'resctrl'.

>>>> --- a/include/linux/resctrl.h
>>>> +++ b/include/linux/resctrl.h
>>>> @@ -372,6 +372,40 @@ static inline void resctrl_arch_rmid_read_context_check(void)
>>>>  		might_sleep();
>>>>  }
>>>>  
>>>> +/**
>>>> + * resctrl_find_domain() - Search for a domain id in a resource domain list.
>>>> + * @h:		The domain list to search.
>>>> + * @id:		The domain id to search for.
>>>> + * @pos:	A pointer to position in the list id should be inserted.
>>>> + *
>>>> + * Search the domain list to find the domain id. If the domain id is
>>>> + * found, return the domain. NULL otherwise.  If the domain id is not
>>>> + * found (and NULL returned) then the first domain with id bigger than
>>>> + * the input id can be returned to the caller via @pos.
>>>> + */
>>>> +static inline struct rdt_domain_hdr *resctrl_find_domain(struct list_head *h,
>>>> +							 int id,
>>>> +							 struct list_head **pos)
>>>
>>> Could you please provide a motivation for why this needs to be inline now?
>>
>> It's in a header now, to avoid the compiler complaining about unused
>> static functions wherever this file is included. The alternative is a
>> prototype declaration and the actual implementation in a .c file.

(it was this)


> resctrl_find_domain() is currently in a .c file (arch/x86/kernel/cpu/resctrl/core.c)
> with a prototype declaration (in arch/x86/kernel/cpu/resctrl/internal.h). This patch
> switches resctrl_find_domain() to be inline without a motivation.

Its not clear what side should own this function, both the architecture and filesystem
code need to make use of it. The majority of callers are in the arch code - but putting it
here means its duplicated between architectures.
Putting it in the filesystem code means calling out to it, and means the compiler can't
remove that extra NULL argument thing if its unused. Its also a hindrance to having the
arch code standalone - so we can in the future consider making the filesystem parts a
module. (Tony has picked at this and pointed out that kernfs not being exported is a
bigger problem). Its not needed now (and I haven't tried), but it seems a reasonable
direction of travel.


> After a fresh reading of "The inline disease" in Documentation/process/coding-style.rst 
> I do see a few red flags related to making this function inline. The function is certainly
> larger than the rule of thumb of "3 lines"

The thing about rules of thumb ...
The first example I looked at is __task_state_index(), which is equally longer than this
rule of thumb.


> and considering the number of call sites I do not see how bloating the kernel is justified.

I think this is several orders of magnitude below the point that this is something to care
about. If this were inlined in put_user() or something lots of drivers call, I'd agree.

I'll move it to live in the filesystem code - that saves 36 bytes.
(I'm honestly surprised its measurable!)


James

