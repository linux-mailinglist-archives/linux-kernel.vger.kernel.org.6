Return-Path: <linux-kernel+bounces-171293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E91D8BE24C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 14:37:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C923E1F230AA
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 12:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0A23158A2D;
	Tue,  7 May 2024 12:36:51 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5216E7E1
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 12:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715085411; cv=none; b=KBvFcjFKd7EwXOaLp553KQlbQ/iH2g0GP79aFNHB0xq6vbgkzFBqDOd67zzGOdsWudkuDPrP5bxr9wmVY0I15qaDKRcjNN9QdNehsLY2QOBJsl9wOFhwUlrbAKCceHZ8hUlZD8qo98P3RSN3xOUgxLW5gxV3DlPVnZkAh/D8S9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715085411; c=relaxed/simple;
	bh=NUFfVBcD6D0ZGUtr0OgcfTxuwVwuy013FrR3Yaj6sN0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rbxzBEwLLGmvW8sw13iSt+rDufug/Agf8sQ3/92fo5ZSYzSbEKeKlV/e58bOs/JfzQfJESLwKzyNr0IS7CgsYP2r4D2NcjiZuoIYpGw000EIycogLMRTVJusjWxfI3d7GNPfe4hFnyTKH1pjVWr1ZA8BuLQMC/IMafJJacIFiq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 895B01063;
	Tue,  7 May 2024 05:37:14 -0700 (PDT)
Received: from [10.1.34.181] (XHFQ2J9959.cambridge.arm.com [10.1.34.181])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 37A2E3F793;
	Tue,  7 May 2024 05:36:47 -0700 (PDT)
Message-ID: <08de71f6-f049-4c3b-977e-f658f85cd734@arm.com>
Date: Tue, 7 May 2024 13:36:45 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH] mm: align larger anonymous mappings on THP
 boundaries
Content-Language: en-GB
To: David Hildenbrand <david@redhat.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, Yang Shi <shy828301@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>,
 Yang Shi <yang@os.amperecomputing.com>, riel@surriel.com, cl@linux.com,
 akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Ze Zuo <zuoze1@huawei.com>
References: <20231214223423.1133074-1-yang@os.amperecomputing.com>
 <1e8f5ac7-54ce-433a-ae53-81522b2320e1@arm.com>
 <Zav3UK7ESNxCMjyP@casper.infradead.org>
 <b75cb59a-734f-43d5-b565-fc9bb8c5ed05@arm.com>
 <CAHbLzkpT6padaDo8GimCcQReSGybQn_ntzj+wsZbTXe3urtK-g@mail.gmail.com>
 <bad7ec4a-1507-4ec4-996a-ea29d07d47a0@arm.com>
 <CAHbLzkrtcsU=pW13AyAMvF72A03fUV5iFcM0HwQoEemeajtqxg@mail.gmail.com>
 <b84e2799-2b6c-4670-b017-3a04ec18c0f2@arm.com>
 <dea802da-2e5e-4c91-b817-43afdde68958@huawei.com>
 <1dc9a561-55f7-4d65-8b86-8a40fa0e84f9@arm.com>
 <6016c0e9-b567-4205-8368-1f1c76184a28@huawei.com>
 <2c14d9ad-c5a3-4f29-a6eb-633cdf3a5e9e@redhat.com>
 <4e7ce57f-cad1-44d5-a1d8-4cd47683a358@arm.com>
 <9ce8a0f4-d1af-44ea-87b5-57ebdb3d2910@arm.com>
 <dbeda3dd-900a-4362-886e-d9aaa58ca525@redhat.com>
 <adc6ac88-8fb8-44ad-abe6-9e9f9e4017e3@redhat.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <adc6ac88-8fb8-44ad-abe6-9e9f9e4017e3@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 07/05/2024 12:42, David Hildenbrand wrote:
> On 07.05.24 13:34, David Hildenbrand wrote:
>> On 07.05.24 13:26, Ryan Roberts wrote:
>>> On 07/05/2024 12:14, Ryan Roberts wrote:
>>>> On 07/05/2024 12:13, David Hildenbrand wrote:
>>>>>
>>>>>> https://github.com/intel/lmbench/blob/master/src/lat_mem_rd.c#L95
>>>>>>
>>>>>>> suggest. If you want to try something semi-randomly; it might be useful
>>>>>>> to rule
>>>>>>> out the arm64 contpte feature. I don't see how that would be interacting
>>>>>>> here if
>>>>>>> mTHP is disabled (is it?). But its new for 6.9 and arm64 only. Disable with
>>>>>>> ARM64_CONTPTE (needs EXPERT) at compile time.
>>>>>> I don't enabled mTHP, so it should be not related about ARM64_CONTPTE,
>>>>>> but will have a try.
>>>>>
>>>>> cont-pte can get active if we're just lucky when allocating pages in the right
>>>>> order, correct Ryan?
>>>>
>>>> No it shouldn't do; it requires the pages to be in the same folio.
>>
>> Ah, my memory comes back. That's also important for folio_pte_batch() to
>> currently work as expected I think. We could change that, though, and
>> let cont-pte batch across folios.
> 
> Thinking about it (and trying to refresh my memories), access/dirty bits might
> be why we don't want to do that.

Yes correct; we only get a single access/dirty bit for the whole contpte block.
So can't honour the core kernel's tracking requirements when the pages are not
part of a single folio.


