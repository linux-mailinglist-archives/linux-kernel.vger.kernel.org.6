Return-Path: <linux-kernel+bounces-280619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EDE994CCE4
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 11:06:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 157231F21728
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 09:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1854B18FDD0;
	Fri,  9 Aug 2024 09:05:57 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 174C0BA41
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 09:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723194356; cv=none; b=qvr7a51ScoAEApmqxFyDm4qP04xtsDCibtNGkpSm8Jym0OzuDtivqlBrNoLnVGCRXtcQDG1Hio7pwrYSnWBGqsNA+SMTaNEMhEb4hO9MPHk5LVykp/02O32DF3CCTS/6tlXP/d37VdwYhWDlLcsvJ0Eo2+U8Ok35uoAXiBVz1AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723194356; c=relaxed/simple;
	bh=XSmLzU5UdFAB1VFUrX7MA56hBPiTogs2+/NMh6rIIvk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h1mdoVaxwgGjO/Eea6rxEV8ufraZhBzvPo26D/uCpwTWrmLshFsr0wCWlNFXuENwES+Tq/4/zWb/9SinXtbiHMvY4248PebGWtFIPDrxnahMRWkhpExU1cArlJ27N5zgVASDYQl/bfteCEvJ20A7KZirtyhhFQYeYlkv1i/LeyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 24DD2FEC;
	Fri,  9 Aug 2024 02:06:20 -0700 (PDT)
Received: from [10.57.95.64] (unknown [10.57.95.64])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A18EF3F6A8;
	Fri,  9 Aug 2024 02:05:52 -0700 (PDT)
Message-ID: <9f8ba5c8-5bc3-4af2-96d2-2f52ee923ef5@arm.com>
Date: Fri, 9 Aug 2024 10:05:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 1/2] mm: collect the number of anon large folios
Content-Language: en-GB
To: David Hildenbrand <david@redhat.com>, Barry Song <21cnbao@gmail.com>,
 akpm@linux-foundation.org, linux-mm@kvack.org
Cc: chrisl@kernel.org, kaleshsingh@google.com, kasong@tencent.com,
 linux-kernel@vger.kernel.org, ioworker0@gmail.com,
 baolin.wang@linux.alibaba.com, ziy@nvidia.com, hanchuanhua@oppo.com,
 Barry Song <v-songbaohua@oppo.com>
References: <20240808010457.228753-1-21cnbao@gmail.com>
 <20240808010457.228753-2-21cnbao@gmail.com>
 <e9f82fd8-e1da-49ea-a735-b174575c02bc@arm.com>
 <1222cd76-e732-4238-9413-61843249c1e8@arm.com>
 <4465afdc-23e9-4844-a0a0-519f49b1229c@redhat.com>
 <616401ea-289d-4ae2-acde-6704b0fa9c46@redhat.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <616401ea-289d-4ae2-acde-6704b0fa9c46@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09/08/2024 09:58, David Hildenbrand wrote:
> On 09.08.24 10:42, David Hildenbrand wrote:
>>>> Not sure I fully understand why David prefers to do the unaccounting at
>>>> free-time though? It feels unbalanced to me to increment when first mapped but
>>>> decrement when freed. Surely its safer to either use alloc/free or use first
>>>> map/last map?
>>>>
>>>> If using alloc/free isn't there a THP constructor/destructor that prepares the
>>>> deferred list? (My memory may be failing me). Could we use that?
>>>
>>> Additionally, if we wanted to extend (eventually) to track the number of shmem
>>> and file mthps in additional counters, could we also account using similar folio
>>> free-time hooks? If not, it might be an argument to account in rmap_unmap to be
>>> consistent for all?
>>
>> Again, see NR_FILE_THPS handling. No rmap over-complication please.
> 
> ... not to mention that it is non-sensical to only count pageache folios that
> are mapped to user space ;)

Yes, good point. I'll get back in my box. :)


