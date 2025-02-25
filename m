Return-Path: <linux-kernel+bounces-530931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59C67A43A4B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 10:52:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF9FD16F675
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 09:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70957266B7F;
	Tue, 25 Feb 2025 09:47:38 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 858C2265617
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 09:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740476858; cv=none; b=Y/f71OmMUhHNvN7zvqR+pw7yh9yjoaGJQr2bpxZe6kkJ9Z+azBVYPRT4A+e3+d2Cs+27N7hLd7Ov6kaaU9x6AoZwqf5QCRl3e2ig2iaHnWJBPrJfoH2Cc7L3iiA3+4pALgVKNneVtheBNFq8NyN7kTIIvU5GDEf08qOKODIAhmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740476858; c=relaxed/simple;
	bh=otozORp1LUAeuRPnVmD/a9N4A7uUDPEVNRGLipcMklQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YJW37mnHh+aD5OIrx5hAZ/vFVdV1VcnJAYoPehlWoDbNMDDpvGSRVUKs8GkYj6sT+dzgmH3OC7MT9tR5ggSfQsB/WYb1ZbRi9TvJLmbe9vxgo6XAJ0cvw4FasBFkU4x6XJpqqm7VgN1+QQz0SkhNU5+CfK1MFh9o8EKgUmDA9nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F18311516;
	Tue, 25 Feb 2025 01:47:49 -0800 (PST)
Received: from [10.57.84.186] (unknown [10.57.84.186])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4972E3F673;
	Tue, 25 Feb 2025 01:47:32 -0800 (PST)
Message-ID: <b39a37c8-c9b5-406d-a97a-24fa67622b49@arm.com>
Date: Tue, 25 Feb 2025 09:47:30 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: kernel BUG at arch/arm64/mm/mmu.c:185!
Content-Language: en-GB
To: Luiz Capitulino <luizcap@redhat.com>, LKML
 <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Cc: ardb@kernel.org,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <will@kernel.org>
References: <a3d9acbe-07c2-43b6-9ba9-a7585f770e83@redhat.com>
 <fe95f4c8-4b09-4d8e-99c9-987ddc2761e3@arm.com>
 <9f5600b3-6525-4045-ad1f-4408dfc9ce0f@redhat.com>
 <cf2b32a4-2217-4a31-b6d7-e60a9f4ef7dd@arm.com>
 <789c17e6-5ebc-4e37-93cd-19d24f148fd8@redhat.com>
 <dee18de8-7938-4df1-badb-c00832d6995f@redhat.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <dee18de8-7938-4df1-badb-c00832d6995f@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

(Adding arm folks for visibility)

See original report here for context:
https://lore.kernel.org/all/a3d9acbe-07c2-43b6-9ba9-a7585f770e83@redhat.com/

TL;DR is that 6.14 doesn't boot on Ampere Altra when kaslr is enabled.


On 20/02/2025 20:08, Luiz Capitulino wrote:
> On 2025-02-19 09:40, Luiz Capitulino wrote:
> 
>>>> Btw, I'll try to bisect again and will also try to update the system's firmware
>>>> just in case.
> 
> I tried to bisect it and again, got nowhere.
> 
> Git bisect says the first bad commit is 8883957b3c9de2087fb6cf9691c1188cccf1ac9c .
> But I'm able to boot that tree...
> 

OK, think I've found the dodgy commit:

Commit 62cffa496aac ("arm64/mm: Override PARange for !LPA2 and use it consistently")

Based on the changes it certainly looks like it could be the issue, but I
haven't spotted exactly what the problem is yet. Ard, could you take a look?

I managed to hack multi ram bank support into kvmtool, so I can now repro the
issue in virtualization. Then was able to bisect to get to the above commit.

I'll keep digging to see if I can get to the root cause, but I suspect Ard is
best placed to hypothesise at this point.

Thanks,
Ryan

