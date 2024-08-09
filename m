Return-Path: <linux-kernel+bounces-280761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7812D94CECC
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 12:37:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9895B21716
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 10:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 687541922DB;
	Fri,  9 Aug 2024 10:37:33 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3147616D337
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 10:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723199852; cv=none; b=HCUAONEWqqs8qHxZpfXpfE2t7OUzS7Uvw0IMD8jatvP8Z6LVL0NvfU0kj3OK5P0XWVyYbHXHy9F52r+OXQ6OSKlW+ZaPxgRsQ0YbGqUnZpq8ecNbp+v8gwyog2NbJmMw63S/2e0974gaRSpZRG+eNDfu0GhrCo5a6BNRDV4CgRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723199852; c=relaxed/simple;
	bh=KzVgi6QcSdcVZ98VzDFwX0fLZna3gnufW8QHsxVdnDU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g7cEyT/qw1GcP4d5umgMV+NTOlLs4L5i/XrBX94XlvA7IQJIGa8nz6sQqueEeKS7UsSkyE7av1WSlsMeDp8xRETQdiYXfIQiH5wiNC+leO/Lv1nSdT1OPMnHUuOy6rI7A5R/5e4w7hflNWvLQ2uwhF5m/0jLbFmfph8kqBATciY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A2D9613D5;
	Fri,  9 Aug 2024 03:37:56 -0700 (PDT)
Received: from [10.57.95.64] (unknown [10.57.95.64])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BBFA83F766;
	Fri,  9 Aug 2024 03:37:29 -0700 (PDT)
Message-ID: <3c8f00ea-af28-46c7-9a5d-83c4b9462be3@arm.com>
Date: Fri, 9 Aug 2024 11:37:28 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm: Override mTHP "enabled" defaults at kernel cmdline
Content-Language: en-GB
To: David Hildenbrand <david@redhat.com>, Barry Song <baohua@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Jonathan Corbet <corbet@lwn.net>, Lance Yang <ioworker0@gmail.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
References: <20240808101700.571701-1-ryan.roberts@arm.com>
 <99b78488-c524-4269-b1fb-a13eaa4f274c@redhat.com>
 <CAGsJ_4z2D2yWWZhUM_yDSdn9=zpkYkHhzAKO8CQ1Xu3gDaECRA@mail.gmail.com>
 <75eb6e75-8a6d-460a-8e96-7496ed1396b7@redhat.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <75eb6e75-8a6d-460a-8e96-7496ed1396b7@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 09/08/2024 10:32, David Hildenbrand wrote:
> On 09.08.24 11:24, Barry Song wrote:
>> On Fri, Aug 9, 2024 at 5:19 PM David Hildenbrand <david@redhat.com> wrote:
>>>
>>> On 08.08.24 12:16, Ryan Roberts wrote:
>>>> Add thp_anon= cmdline parameter to allow specifying the default
>>>> enablement of each supported anon THP size. The parameter accepts the
>>>> following format and can be provided multiple times to configure each
>>>> size:
>>>>
>>>> thp_anon=<size>[KMG]:<value>
>>>>
>>>> See Documentation/admin-guide/mm/transhuge.rst for more details.
>>>>
>>>> Configuring the defaults at boot time is useful to allow early user
>>>> space to take advantage of mTHP before its been configured through
>>>> sysfs.
>>>
>>> I suspect a khugeapged enhancement and/or kernel-config-dependant
>>> defaults and/or early system settings will also be able to mitigate that
>>> without getting kernel cmdlines involved in the future.
>>>
>>>>
>>>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>>>> ---
>>>>
>>>> Hi All,
>>>>
>>>> I've split this off from my RFC at [1] because Barry highlighted that he would
>>>> benefit from it immediately [2]. There are no changes vs the version in that
>>>> series.
>>>>
>>>> It applies against today's mm-unstable (275d686abcb59). (although I had to
>>>> fix a
>>>> minor build bug in stackdepot.c due to MIN() not being defined in this tree).
>>>>
>>>> Thanks,
>>>> Ryan
>>>>
>>>>
>>>>    .../admin-guide/kernel-parameters.txt         |  8 +++
>>>>    Documentation/admin-guide/mm/transhuge.rst    | 26 +++++++--
>>>>    mm/huge_memory.c                              | 55 ++++++++++++++++++-
>>>>    3 files changed, 82 insertions(+), 7 deletions(-)
>>>>
>>>> diff --git a/Documentation/admin-guide/kernel-parameters.txt
>>>> b/Documentation/admin-guide/kernel-parameters.txt
>>>> index bcdee8984e1f0..5c79b58c108ec 100644
>>>> --- a/Documentation/admin-guide/kernel-parameters.txt
>>>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>>>> @@ -6631,6 +6631,14 @@
>>>>                        <deci-seconds>: poll all this frequency
>>>>                        0: no polling (default)
>>>>
>>>> +     thp_anon=       [KNL]
>>>> +                     Format: <size>[KMG]:always|madvise|never|inherit
>>>> +                     Can be used to control the default behavior of the
>>>> +                     system with respect to anonymous transparent hugepages.
>>>> +                     Can be used multiple times for multiple anon THP sizes.
>>>> +                     See Documentation/admin-guide/mm/transhuge.rst for more
>>>> +                     details.
>>>> +
>>>>        threadirqs      [KNL,EARLY]
>>>>                        Force threading of all interrupt handlers except those
>>>>                        marked explicitly IRQF_NO_THREAD.
>>>> diff --git a/Documentation/admin-guide/mm/transhuge.rst
>>>> b/Documentation/admin-guide/mm/transhuge.rst
>>>> index 24eec1c03ad88..f63b0717366c6 100644
>>>> --- a/Documentation/admin-guide/mm/transhuge.rst
>>>> +++ b/Documentation/admin-guide/mm/transhuge.rst
>>>> @@ -284,13 +284,27 @@ that THP is shared. Exceeding the number would block
>>>> the collapse::
>>>>
>>>>    A higher value may increase memory footprint for some workloads.
>>>>
>>>> -Boot parameter
>>>> -==============
>>>> +Boot parameters
>>>> +===============
>>>>
>>>> -You can change the sysfs boot time defaults of Transparent Hugepage
>>>> -Support by passing the parameter ``transparent_hugepage=always`` or
>>>> -``transparent_hugepage=madvise`` or ``transparent_hugepage=never``
>>>> -to the kernel command line.
>>>> +You can change the sysfs boot time default for the top-level "enabled"
>>>> +control by passing the parameter ``transparent_hugepage=always`` or
>>>> +``transparent_hugepage=madvise`` or ``transparent_hugepage=never`` to the
>>>> +kernel command line.
>>>> +
>>>> +Alternatively, each supported anonymous THP size can be controlled by
>>>> +passing ``thp_anon=<size>[KMG]:<state>``, where ``<size>`` is the THP size
>>>> +and ``<state>`` is one of ``always``, ``madvise``, ``never`` or
>>>> +``inherit``.
>>>> +
>>>> +For example, the following will set 64K THP to ``always``::
>>>> +
>>>> +     thp_anon=64K:always
>>>> +
>>>> +``thp_anon=`` may be specified multiple times to configure all THP sizes as
>>>> +required. If ``thp_anon=`` is specified at least once, any anon THP sizes
>>>> +not explicitly configured on the command line are implicitly set to
>>>> +``never``.
>>>
>>> I suggest documenting that "thp_anon=" will not effect the value of
>>> "transparent_hugepage=", or any configured default.

Did you see the previous conversation with Barry about whether or not to honour
configured defaults when any thp_anon= is provided [1]? Sounds like you also
think we should honour the PMD "inherit" default if not explicitly provided on
the command line? (see link for justification for the approach I'm currently
taking).

[1]
https://lore.kernel.org/linux-mm/CAGsJ_4x8ruPspuk_FQVggJMWcXLbRuZFq44gg-Dt7Ewt3ExqTw@mail.gmail.com/

>>>
>>> Wondering if a syntax like
>>>
>>> thp_anon=16K,32K,64K:always;1048K,2048K:madvise

Are there examples of that syntax already or have you just made it up? I found
examples with the colon (:) but nothing this fancy. I guess that's not a reason
not to do it though (other than the risk of screwing up the parser in a subtle way).

>>>
>>> (one could also support ranges, like "16K-64K")
>>>
>>> Would be even better. Then, maybe only allow a single instance.
>>>
>>> Maybe consider it if it's not too crazy to parse ;)
I'll take a look. I'm going to be out for 3 weeks from end of Monday though, so
probably won't get around to that until I'm back. I know Barry is keen to get
this merged, so Barry, if you'd like to take it over that's fine by me (I'm sure
you have enough on your plate though).

>>
>> I prefer the current approach because it effectively filters cases like this.
>>
>> [    0.000000] huge_memory: thp_anon=8K:inherit: cannot parse, ignored
>> [    0.000000] Unknown kernel command line parameters
>> "thp_anon=8K:inherit", will be passed to user space.
>>
>> if we put multiple sizes together, 8K,32K,64K:always
>>
>> We can't determine whether this command line is legal or illegal as it
>> is partially legal and partially illegal.
> 
> Besides: I wouldn't bother about this "user does something stupid" scenario that
> much.
> 
> But yes, once we support more sizes a cmdline might turn invalid on an older
> kernel.
> 
> However, I don't see the problem here. User passed a non-existant size. Ignore
> that one but handle the others, like you would with multiple commands?

Yep, the parser could emit a warning for the size and move on.

> 
> It can be well defined and documented. The command line is legal, just one size
> does not exist.
> 
> The world will continue turning :)
> 


