Return-Path: <linux-kernel+bounces-402721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39C139C2AF5
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 08:12:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06D5E282ADA
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 07:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36F4613D518;
	Sat,  9 Nov 2024 07:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="VbpfmhGH"
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698CB3B192
	for <linux-kernel@vger.kernel.org>; Sat,  9 Nov 2024 07:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731136355; cv=none; b=kmIi2uDDv2/NK+OF7wb62LHhrXOZhX26bqCbPUR9q4b3k8Z3lTRYebjPc79zEdr9sGoo93VQGAgfjEq6jp7cCIFoWYGd16IhOgCk8YZY115WRHON/VmKFQKDoyVCj81Ruig3FRfHzAESuJSwUbxy9r3Inef7Ap/fnOMGrK7FpGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731136355; c=relaxed/simple;
	bh=Vox/FHuQsiAnvbmzX5WEbHKtviQOqFrkUmXLLSWLFZk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H8F2WS84Hpvtcer2KI+rL2p6FLYG2J2yr16upvSUrZjAxDVLnnB4xsbqymBNOhYXbgoKo+duIRftNwKTeiHid5Iy431qk3+Mjnv/gaFBzYD1v21cWwKTJ3J58/UDbz49GdyGbMTtpnU1am3Wtp96OPlgAIBLAIektmRenL6E6U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=VbpfmhGH; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1731136344; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=A6UqBYVCS/TOTFjQt3Tzhr5BGkUP2D8w/Z3WsnhNXlI=;
	b=VbpfmhGH/b/LoahYw/of4FTD7LfDHwVB6j73EFwjcxgVUmUMirrH3SHomYjtHrReiQ52DqZSGvO1W4IWpDAneDQrU3h/yFg6MKASLRVitDsPnkmotdnIm9z4Eq3bXraiZ4K92UTADs290N4BFzXOCQEP8kRFXugL96v8O6a9BJo=
Received: from 30.15.226.209(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WJ.rpS._1731136341 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 09 Nov 2024 15:12:23 +0800
Message-ID: <fabfc6d6-6693-40ca-b2c6-769882b19178@linux.alibaba.com>
Date: Sat, 9 Nov 2024 15:12:21 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] Support large folios for tmpfs
To: David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
 hughd@google.com
Cc: willy@infradead.org, wangkefeng.wang@huawei.com, 21cnbao@gmail.com,
 ryan.roberts@arm.com, ioworker0@gmail.com, da.gomez@samsung.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1731038280.git.baolin.wang@linux.alibaba.com>
 <3d49fbf8-866f-485b-b7fa-a89bbfb3cd7c@redhat.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <3d49fbf8-866f-485b-b7fa-a89bbfb3cd7c@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/11/8 23:30, David Hildenbrand wrote:
> On 08.11.24 05:12, Baolin Wang wrote:
>> Traditionally, tmpfs only supported PMD-sized huge folios. However 
>> nowadays
>> with other file systems supporting any sized large folios, and extending
>> anonymous to support mTHP, we should not restrict tmpfs to allocating 
>> only
>> PMD-sized huge folios, making it more special. Instead, we should allow
>> tmpfs can allocate any sized large folios.
>>
>> Considering that tmpfs already has the 'huge=' option to control the huge
>> folios allocation, we can extend the 'huge=' option to allow any sized 
>> huge
>> folios. The semantics of the 'huge=' mount option are:
>>
>> huge=never: no any sized huge folios
>> huge=always: any sized huge folios
>> huge=within_size: like 'always' but respect the i_size
>> huge=advise: like 'always' if requested with fadvise()/madvise()
>>
>> Note: for tmpfs mmap() faults, due to the lack of a write size hint, 
>> still
>> allocate the PMD-sized huge folios if huge=always/within_size/advise 
>> is set.
> 
> So, no fallback to smaller sizes for now in case we fail to allocate a 
> PMD one? Of course, this can be added later fairly easily.

Right. I have no strong preference on this. If no one objects, I can add 
a fallback to smaller large folios if the PMD sized allocation fails in 
the next version.

>> Moreover, the 'deny' and 'force' testing options controlled by
>> '/sys/kernel/mm/transparent_hugepage/shmem_enabled', still retain the 
>> same
>> semantics. The 'deny' can disable any sized large folios for tmpfs, while
>> the 'force' can enable PMD sized large folios for tmpfs.
>>
>> Any comments and suggestions are appreciated. Thanks.
>>
>> Hi David,
>> I did not add a new Kconfig option to control the default behavior of 
>> 'huge='
>> in the current version. I have not changed the default behavior at this
>> time, and let's see if there is a need for this.
> 
> Likely we want to change the default at some point so people might get a 
> benefit in more scenarios automatically. But I did not investigate how 
> /tmp is mapped as default by Fedora, for example.

Personally, adding a cmdline to change the default value might be more 
useful than the Kconfig. Anyway, I still want to investigate if there is 
a real need.

