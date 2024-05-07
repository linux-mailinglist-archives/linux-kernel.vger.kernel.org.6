Return-Path: <linux-kernel+bounces-171197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70CD88BE0FD
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 13:27:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FA661C21574
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 11:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CB9E15219B;
	Tue,  7 May 2024 11:26:56 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAA1E522E
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 11:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715081216; cv=none; b=RQsIEFS9RF3YK3JHvOLGs4aIYPRIzkiEZWFKBZrZ2CxpPxX9Ui0LIPEce1K4XmEnLPabDqi2k2xgGl0FdQ5WzpldX9r6iz481IR27Y6i2G9GdZTBFmwpQRvLSxeV5FHXbQHgznbMDIjtKYaX04hbpnkdWRMGKw17MOOyrGLT/+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715081216; c=relaxed/simple;
	bh=W7S2v33HPqpr6Hg+sdpbHfoD8E2GMIdOEdVd5GGP8/g=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=i6CmnuoHSGRlWFt25MGtTvHHReZzblgyZwlaNaBDhieREolTS6aPeNNfh9dJH/wvndKcaveebjFSn780JX2jsnmypyYvi9wTM+2+1SbXR9eJ5AVcZovlTWr3Q3mgtfMTXvn8LaicdsvmAFKfb/Y0o2Fkq9Wv72fkMCfSfXNbAag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D0F861063;
	Tue,  7 May 2024 04:27:19 -0700 (PDT)
Received: from [10.1.34.181] (XHFQ2J9959.cambridge.arm.com [10.1.34.181])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7AB6E3F587;
	Tue,  7 May 2024 04:26:52 -0700 (PDT)
Message-ID: <9ce8a0f4-d1af-44ea-87b5-57ebdb3d2910@arm.com>
Date: Tue, 7 May 2024 12:26:51 +0100
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
From: Ryan Roberts <ryan.roberts@arm.com>
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
In-Reply-To: <4e7ce57f-cad1-44d5-a1d8-4cd47683a358@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 07/05/2024 12:14, Ryan Roberts wrote:
> On 07/05/2024 12:13, David Hildenbrand wrote:
>>
>>> https://github.com/intel/lmbench/blob/master/src/lat_mem_rd.c#L95
>>>
>>>> suggest. If you want to try something semi-randomly; it might be useful to rule
>>>> out the arm64 contpte feature. I don't see how that would be interacting here if
>>>> mTHP is disabled (is it?). But its new for 6.9 and arm64 only. Disable with
>>>> ARM64_CONTPTE (needs EXPERT) at compile time.
>>> I don't enabled mTHP, so it should be not related about ARM64_CONTPTE,
>>> but will have a try.
>>
>> cont-pte can get active if we're just lucky when allocating pages in the right
>> order, correct Ryan?
> 
> No it shouldn't do; it requires the pages to be in the same folio.
> 

That said, if we got lucky in allocating the "right" pages, then we will end up
doing an extra function call and a bit of maths per every 16 PTEs in order to
figure out that the span is not contained by a single folio, before backing out
of an attempt to fold. That would probably be just about measurable.

But the regression doesn't kick in until 96K, which is the step after 64K. I'd
expect to see the regression on 64K too if that was the issue. The cacheline is
64K so I suspect it could be something related to the cache?

