Return-Path: <linux-kernel+bounces-230667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E41F918036
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 13:51:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EED8B285AE1
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 11:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFEAA1802A3;
	Wed, 26 Jun 2024 11:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="CeHbkMGt"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3683117FAAE
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 11:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719402689; cv=none; b=gVyL3lCFf6ckKoZww+5rIGzFpNmYnRp91jN8zrlYr4m66LEyEAL861bwrjyhQsbDAFw+pdC4zb9XN9MJFW6oN3+LXCLZC7OMGFVSaYyNApTSHqCIqgHEjnvWi5noJ+kPCAztWbpCE+Xq770xE1oSL/uJI4y+WkRrebfdeldFv8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719402689; c=relaxed/simple;
	bh=Rsn10QpYlx4zwOki5/X3Iqu7AvvhAvls+kfQZVHyDiw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C7CJr7jOBg0fhw7BtcVXO5kMtU6YsDGziApMJeQp0Uj3tUjbAb6KDpq7zLdcpmKGNRChCAOQ6Hdx1pnveAFepmQSAKWcag7m4FZbLP2RtwXEykuFe+gve78v6ibrbX2enDNrLXtAXNRA0sETBitr20a14+KKrhmxxOK5LN4o76k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=CeHbkMGt; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=iamY6AWMHg1NOm0ChQZW+78oF/bE5eWOuQYihbOeRCY=; b=CeHbkMGtyB+sj7tlpBsY3v9dpK
	X5ecP043F4rtH+O8CQGJlfKNtLidtzF7JxrakJ6Fn2Umdl2wGyKwceESxRWAYz6xR50b3nP5K9Zqv
	Jyzn7SkA7vio3gRk0NHQMqbwh4tP3xJjYxSX7AIST/0MEEMXczpO0hN53YWJByZLH5l4Khhr3Yfg5
	nl927b0ZRknmQa1BAVsY3dIEE3Vwan7VosbfsPFclcnaMmdoMVTUPPq8n+Xmh8p8nMidX7YuTgmmC
	O9L0avUFq4M7V529NUbRexemR76AYYy0cMEJji+29sAbQFgl77/ruUc8rgllIdfUmi6N/9wefZmz6
	7SdrtzoQ==;
Received: from [84.69.19.168] (helo=[192.168.0.101])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1sMRB7-007gpS-Tw; Wed, 26 Jun 2024 13:51:09 +0200
Message-ID: <9355e4b3-9892-4e5c-9288-103c93bd3bca@igalia.com>
Date: Wed, 26 Jun 2024 12:51:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/numa_balancing: Teach mpol_to_str about the balancing
 mode
To: "Huang, Ying" <ying.huang@intel.com>, Tvrtko Ursulin <tursulin@igalia.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-dev@igalia.com,
 Mel Gorman <mgorman@suse.de>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Rik van Riel <riel@surriel.com>,
 Johannes Weiner <hannes@cmpxchg.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Dave Hansen <dave.hansen@intel.com>, Andi Kleen <ak@linux.intel.com>,
 Michal Hocko <mhocko@suse.com>, David Rientjes <rientjes@google.com>
References: <20240625132605.38428-1-tursulin@igalia.com>
 <87r0ckozs4.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <87r0ckozs4.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 26/06/2024 09:48, Huang, Ying wrote:
> Tvrtko Ursulin <tursulin@igalia.com> writes:
> 
>> From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>>
>> If a task has had MPOL_F_NUMA_BALANCING set it is useful to show that in
> 
> IIUC, MPOL_F_NUMA_BALANCING works for VMA area via mbind() too.

Ah okay.. I think I forgot to actually check and went by what commit 
text of bda420b98505 said, which is probably outdated.

>> procfs. Teach the mpol_to_str helper about its existance and while at it
>> update the comment to account for "weighted interleave" when suggesting
>> a recommended buffer size.
> 
> Otherwise LGTM, Thanks!
> 
> Reviewed-by: "Huang, Ying" <ying.huang@intel.com>

Thank you! Would you have an idea of which tree this should go to aka 
which maintainer to ask to merge it?

Second question - I also have a patch which enables choosing balancing 
for tmpfs (mpol_parse_str) but I am unsure of its value. It would make 
things symmetrical, but is there some other benefit I don't know. Any 
thoughts on this?

Regards,

Tvrtko

>> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>> References: bda420b98505 ("numa balancing: migrate on fault among multiple bound nodes")
>> Cc: Huang Ying <ying.huang@intel.com>
>> Cc: Mel Gorman <mgorman@suse.de>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: Rik van Riel <riel@surriel.com>
>> Cc: Johannes Weiner <hannes@cmpxchg.org>
>> Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
>> Cc: Dave Hansen <dave.hansen@intel.com>
>> Cc: Andi Kleen <ak@linux.intel.com>
>> Cc: Michal Hocko <mhocko@suse.com>
>> Cc: David Rientjes <rientjes@google.com>
>> ---
>>   mm/mempolicy.c | 10 +++++++---
>>   1 file changed, 7 insertions(+), 3 deletions(-)
>>
>> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
>> index aec756ae5637..d147287c4505 100644
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

