Return-Path: <linux-kernel+bounces-233646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E5991BAA9
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 11:04:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FCC8B21E41
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 09:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C4F814B06C;
	Fri, 28 Jun 2024 09:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="hVMd3Y0K"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9719374C2
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 09:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719565431; cv=none; b=dvlR95KlBW39exhSsdorpOGWWV8S1TPbM1UX+j9S5aiWz4Jbr86GWWD1HuwZtq8YRoWZEY4U2snP7apmmmPKH70CTI6fAcXb26eN6pOYjOjWAq2AvsPKlb4Vfpx4DE3J/Lxa34rP6MAfJg8oErzXA+2ochPkThckcrr0AyNUvWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719565431; c=relaxed/simple;
	bh=BzcVBRopUld1iJkhskHLMC5exb5LsdXrAwqNFZmyMDY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mqrzCVAiMLGPozLeM6iisju3IJEw/lN/+Gt8f4sz4FH2vnveDyyxhDm4N4uvxDLEdr5FQtdegG2B8y14vQrfyEIYEN0uVewkaWdlAksJhuRRVzCveJv73oIY2S8YikRO4WmbjD/vaQ8K7dFel5LNW6o8p9vQE3GSyh2tZN16BSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=hVMd3Y0K; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=H53RlDBEUShmO+hCaBglwMyqvXnVZau+Rudn8CfcNQs=; b=hVMd3Y0KcS9550waREbySIGkEK
	C19Flw9baZPFxAYpeerLHwGcXCv+bWxk5A1VcnY4PU0WegIgbpzxo1dBSeLvdZ3+f63XltSjgD6KP
	ifYlhhJe6+M0gLX7PYAZcnPkqd9BENMOtBnVHPbpId7/wPzuKmr+GBVkcOijBAW/K2IVc0QFWLq/A
	2KpIbokwrGdCYKe9Gy/6+QBkGIpTZPCeBMQ8LLqxFEkptgenb749DB3c85PZ7nJJhqR8U+lIkbXbD
	5Ol/oXEOApPg7OY7IDGYpIkU7RVDUqV+X+ipfLGAv2X3c3UBRx51YqcOAcFX/IuhtLJOVOjMtMSw4
	Wt28gbXA==;
Received: from [84.69.19.168] (helo=[192.168.0.101])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1sN7W7-008Xbz-1E; Fri, 28 Jun 2024 11:03:39 +0200
Message-ID: <03641edd-3975-433e-a8d7-d79cb422dc57@igalia.com>
Date: Fri, 28 Jun 2024 10:03:37 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/numa_balancing: Teach mpol_to_str about the balancing
 mode
To: Andrew Morton <akpm@linux-foundation.org>,
 Tvrtko Ursulin <tursulin@igalia.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-dev@igalia.com,
 Huang Ying <ying.huang@intel.com>, Mel Gorman <mgorman@suse.de>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Rik van Riel <riel@surriel.com>, Johannes Weiner <hannes@cmpxchg.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Dave Hansen <dave.hansen@intel.com>, Andi Kleen <ak@linux.intel.com>,
 Michal Hocko <mhocko@suse.com>, David Rientjes <rientjes@google.com>
References: <20240625132605.38428-1-tursulin@igalia.com>
 <20240627143719.86a92240516e689c2f2d1c09@linux-foundation.org>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <20240627143719.86a92240516e689c2f2d1c09@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 27/06/2024 22:37, Andrew Morton wrote:
> On Tue, 25 Jun 2024 14:26:05 +0100 Tvrtko Ursulin <tursulin@igalia.com> wrote:
> 
>> From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>>
>> If a task has had MPOL_F_NUMA_BALANCING set it is useful to show that in
>> procfs. Teach the mpol_to_str helper about its existance and while at it
>> update the comment to account for "weighted interleave" when suggesting
>> a recommended buffer size.
>>
>> ...
>>
>> --- a/mm/mempolicy.c
>> +++ b/mm/mempolicy.c
>> @@ -3293,8 +3293,9 @@ int mpol_parse_str(char *str, struct mempolicy **mpol)
>>    * @pol:  pointer to mempolicy to be formatted
>>    *
>>    * Convert @pol into a string.  If @buffer is too short, truncate the string.
>> - * Recommend a @maxlen of at least 32 for the longest mode, "interleave", the
>> - * longest flag, "relative", and to display at least a few node ids.
>> + * Recommend a @maxlen of at least 42 for the longest mode, "weighted
>> + * interleave", the longest flag, "balancing", and to display at least a few
>> + * node ids.
>>    */
>>   void mpol_to_str(char *buffer, int maxlen, struct mempolicy *pol)
>>   {
>> @@ -3331,12 +3332,15 @@ void mpol_to_str(char *buffer, int maxlen, struct mempolicy *pol)
>>   		p += snprintf(p, buffer + maxlen - p, "=");
>>   
>>   		/*
>> -		 * Currently, the only defined flags are mutually exclusive
>> +		 * The below two flags are mutually exclusive:
>>   		 */
>>   		if (flags & MPOL_F_STATIC_NODES)
>>   			p += snprintf(p, buffer + maxlen - p, "static");
>>   		else if (flags & MPOL_F_RELATIVE_NODES)
>>   			p += snprintf(p, buffer + maxlen - p, "relative");
>> +
>> +		if (flags & MPOL_F_NUMA_BALANCING)
>> +			p += snprintf(p, buffer + maxlen - p, "balancing");
>>   	}
>>   
>>   	if (!nodes_empty(nodes))
> 
> Is it strange to report this via mount options?  `static' and
> `relative' can be set via mount options but afaict `balancing' cannot?
> I guess not...
> 
> Documentation/filesystems/tmpfs.rst appears to be a suitable place to
> document this new userspace API please.

That was the part I was unsure of - whether it makes sense to allow 
passing in 'balancing' via tmpfs.

I just noticed these few oddities while playing with some new NUMA 
policies and attempted (badly) to at least fix the fact 'balancing' is 
not shown in /proc/<pid>/numa_maps if selected via set_mempolicy/mbind.

So I also have a patch to allow 'balancing' to be parsed as tmpfs mount 
option but did not post it yet. Now that Ying has uncovered problems in 
this code go deeper we will see how this all develops.

Regards,

Tvrtko

